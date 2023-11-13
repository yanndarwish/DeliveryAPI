-- Create geostar database
CREATE DATABASE IF NOT EXISTS geostar;
USE geostar;

-- TODO : NORMALIZE TO 3rd FORM

-- TODO : REMOVE SELECT *
-- TODO : Index the deliveries_view based on the joins (dev pdf)
-- TODO : prevent client/driver/provider insert if email already exists (address for clients) (trigger)
-- TODO : prevent vehicle insert if immatriculation already exists (trigger)
-- TODO : add error handlers


SET @@session.sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

-- Create addresses table
CREATE TABLE IF NOT EXISTS addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_street_number INT,
    address_street VARCHAR(100),
    address_city VARCHAR(30),
    address_postal_code INT,
    address_country VARCHAR(30),
    address_comment TEXT
) ENGINE=InnoDB;

-- Create clients table
CREATE TABLE IF NOT EXISTS clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(30),
    client_address INTEGER,
    client_active BOOLEAN,
    FOREIGN KEY (client_address) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

-- Create drivers table
CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_last_name VARCHAR(25),
    driver_first_name VARCHAR(25),
    driver_active BOOLEAN
) ENGINE=InnoDB;

-- Create entities table
CREATE TABLE IF NOT EXISTS entities (
    entity_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_name VARCHAR(10) -- 'client' or 'driver' or 'provider'
);

-- Create emails table
CREATE TABLE IF NOT EXISTS emails (
    email_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type INTEGER,
    entity_id INTEGER,
    email VARCHAR(100),
    FOREIGN KEY (entity_type) REFERENCES entities(entity_id),
    FOREIGN KEY (entity_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (entity_id) REFERENCES drivers(driver_id) ON DELETE CASCADE
);

-- Create phone numbers table
CREATE TABLE IF NOT EXISTS phones (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type INTEGER,
    entity_id INTEGER,
    phone VARCHAR(100),
    FOREIGN KEY (entity_type) REFERENCES entities(entity_id),
    FOREIGN KEY (entity_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (entity_id) REFERENCES drivers(driver_id) ON DELETE CASCADE
);

-- Create providers table
CREATE TABLE IF NOT EXISTS providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY,
    provider_name VARCHAR(50),
    provider_contact_name VARCHAR(40),
    provider_headquarter INTEGER,
    provider_warehouse INTEGER,
    provider_active BOOLEAN,
    FOREIGN KEY (provider_headquarter) REFERENCES addresses(address_id),
    FOREIGN KEY (provider_warehouse) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

-- Create vehicles table
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_brand VARCHAR(20),
    vehicle_model VARCHAR(20),
    vehicle_immatriculation VARCHAR(20),
    vehicle_active BOOLEAN
) ENGINE=InnoDB;

-- Create deliveries table
CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    delivery_driver INTEGER REFERENCES drivers(driver_id),
    delivery_vehicle INTEGER REFERENCES vehicles(vehicle_id),
    delivery_provider INTEGER REFERENCES providers(provider_id),
    delivery_hotel INT
) ENGINE=InnoDB;

-- Create Pickups Table
CREATE TABLE IF NOT EXISTS pickups (
    pickup_id SERIAL PRIMARY KEY,
    delivery_id INTEGER REFERENCES deliveries(delivery_id),
    client_id INTEGER REFERENCES clients(client_id),
    pickup_date DATETIME
);

-- Create Dropoffs Table
CREATE TABLE IF NOT EXISTS dropoffs (
    dropoff_id SERIAL PRIMARY KEY,
    delivery_id INTEGER REFERENCES deliveries(delivery_id),
    client_id INTEGER REFERENCES clients(client_id),
    dropoff_date DATETIME
);

-- Create a view combining clients, deliveries, pickups, and dropoffs
-- Aggregate all the pickups info into a single JSON field
-- TODO : INDEX on the pertinent content of the JSON field
-- Should be an array that contains pickup objects, each containing the client infos + pickup date
-- Same for the dropoffs
CREATE VIEW IF NOT EXISTS deliveries_info AS
SELECT
    d.delivery_id,
    CONCAT(dr.driver_last_name, ', ', dr.driver_first_name) AS delivery_driver,
    CONCAT(v.vehicle_brand, ' ', v.vehicle_model) AS delivery_vehicle,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'pickup_date', p.pickup_date,
            'client_info', JSON_OBJECT(
                'client_id', c.client_id,
                'client_name', c.client_name,
                'client_address', c.client_address,
                'client_active', c.client_active
            )
        )
    ) AS delivery_pickups,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'dropoff_date', do.dropoff_date,
            'client_info', JSON_OBJECT(
                'client_id', c.client_id,
                'client_name', c.client_name,
                'client_address', c.client_address,
                'client_active', c.client_active
            )
        )
    ) AS delivery_dropoffs,
    pr.provider_name AS delivery_provider
FROM deliveries d
LEFT JOIN pickups p ON d.delivery_id = p.delivery_id
LEFT JOIN dropoffs do ON d.delivery_id = do.delivery_id
LEFT JOIN drivers dr ON d.delivery_driver = dr.driver_id
LEFT JOIN vehicles v ON d.delivery_vehicle = v.vehicle_id
LEFT JOIN providers pr ON d.delivery_provider = pr.provider_id
LEFT JOIN clients c ON p.client_id = c.client_id OR do.client_id = c.client_id
GROUP BY d.delivery_id, dr.driver_last_name, dr.driver_first_name, v.vehicle_brand, v.vehicle_model, pr.provider_name;


-- Create a view combining clients and addresses
CREATE VIEW IF NOT EXISTS client_info AS
SELECT
    c.client_id,
    c.client_name,
    a.address_street_number,
    a.address_street,
    a.address_city,
    a.address_postal_code,
    a.address_country,
    a.address_comment,
    c.client_active
FROM clients c
LEFT JOIN addresses a ON c.client_address = a.address_id;

-- Create a view combining drivers with emails and phones
CREATE VIEW IF NOT EXISTS driver_info AS
SELECT
    d.driver_id,
    d.driver_last_name,
    d.driver_first_name,
    d.driver_active,
    e.email,
    p.phone
FROM drivers d
LEFT JOIN emails e ON d.driver_id = e.entity_id AND e.entity_type = 'driver'
LEFT JOIN phones p ON d.driver_id = p.entity_id AND p.entity_type = 'driver';

-- Create a view combining providers with emails and phones
CREATE VIEW IF NOT EXISTS provider_info AS
SELECT
    pr.provider_id,
    pr.provider_name,
    pr.provider_contact_name,
    pr.provider_active,
    e.email,
    p.phone,
    a_headquarter.address_id AS headquarter_address_id,
    a_headquarter.address_street_number AS headquarter_street_number,
    a_headquarter.address_street AS headquarter_street,
    a_headquarter.address_city AS headquarter_city,
    a_headquarter.address_postal_code AS headquarter_postal_code,
    a_headquarter.address_country AS headquarter_country,
    a_warehouse.address_id AS warehouse_address_id,
    a_warehouse.address_street_number AS warehouse_street_number,
    a_warehouse.address_street AS warehouse_street,
    a_warehouse.address_city AS warehouse_city,
    a_warehouse.address_postal_code AS warehouse_postal_code,
    a_warehouse.address_country AS warehouse_country
FROM providers pr
LEFT JOIN emails e ON pr.provider_id = e.entity_id AND e.entity_type = 'provider'
LEFT JOIN phones p ON pr.provider_id = p.entity_id AND p.entity_type = 'provider'
LEFT JOIN addresses a_headquarter ON pr.provider_headquarter = a_headquarter.address_id
LEFT JOIN addresses a_warehouse ON pr.provider_warehouse = a_warehouse.address_id;


-- Create dmt database
CREATE DATABASE IF NOT EXISTS dmt;
USE dmt;

SET @@session.sql_mode = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

-- Create addresses table
CREATE TABLE IF NOT EXISTS addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_street_number INT,
    address_street VARCHAR(100),
    address_city VARCHAR(30),
    address_postal_code INT,
    address_country VARCHAR(30),
    address_comment TEXT
) ENGINE=InnoDB;

-- Create clients table
CREATE TABLE IF NOT EXISTS clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(30),
    client_address INTEGER,
    client_active BOOLEAN,
    FOREIGN KEY (client_address) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

-- Create drivers table
CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_last_name VARCHAR(25),
    driver_first_name VARCHAR(25),
    driver_active BOOLEAN
) ENGINE=InnoDB;

-- Create entities table
CREATE TABLE IF NOT EXISTS entities (
    entity_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_name VARCHAR(10) -- 'client' or 'driver' or 'provider'
);

-- Create emails table
CREATE TABLE IF NOT EXISTS emails (
    email_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type INTEGER,
    entity_id INTEGER,
    email VARCHAR(100),
    FOREIGN KEY (entity_type) REFERENCES entities(entity_id),
    FOREIGN KEY (entity_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (entity_id) REFERENCES drivers(driver_id) ON DELETE CASCADE
);

-- Create phone numbers table
CREATE TABLE IF NOT EXISTS phones (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type INTEGER,
    entity_id INTEGER,
    phone VARCHAR(100),
    FOREIGN KEY (entity_type) REFERENCES entities(entity_id),
    FOREIGN KEY (entity_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (entity_id) REFERENCES drivers(driver_id) ON DELETE CASCADE
);

-- Create providers table
CREATE TABLE IF NOT EXISTS providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY,
    provider_name VARCHAR(50),
    provider_contact_name VARCHAR(40),
    provider_headquarter INTEGER,
    provider_warehouse INTEGER,
    provider_active BOOLEAN,
    FOREIGN KEY (provider_headquarter) REFERENCES addresses(address_id),
    FOREIGN KEY (provider_warehouse) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

-- Create vehicles table
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_brand VARCHAR(20),
    vehicle_model VARCHAR(20),
    vehicle_immatriculation VARCHAR(20),
    vehicle_active BOOLEAN
) ENGINE=InnoDB;

-- Create deliveries table
CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    delivery_driver INTEGER REFERENCES drivers(driver_id),
    delivery_vehicle INTEGER REFERENCES vehicles(vehicle_id),
    delivery_provider INTEGER REFERENCES providers(provider_id),
    delivery_hotel INT
) ENGINE=InnoDB;

-- Create Pickups Table
CREATE TABLE IF NOT EXISTS pickups (
    pickup_id SERIAL PRIMARY KEY,
    delivery_id INTEGER REFERENCES deliveries(delivery_id),
    client_id INTEGER REFERENCES clients(client_id),
    pickup_date DATETIME
);

-- Create Dropoffs Table
CREATE TABLE IF NOT EXISTS dropoffs (
    dropoff_id SERIAL PRIMARY KEY,
    delivery_id INTEGER REFERENCES deliveries(delivery_id),
    client_id INTEGER REFERENCES clients(client_id),
    dropoff_date DATETIME
);

-- Create a view combining clients, deliveries, pickups, and dropoffs
-- Aggregate all the pickups info into a single JSON field
-- TODO : INDEX on the pertinent content of the JSON field
-- Should be an array that contains pickup objects, each containing the client infos + pickup date
-- Same for the dropoffs
CREATE VIEW IF NOT EXISTS deliveries_info AS
SELECT
    d.delivery_id,
    CONCAT(dr.driver_last_name, ', ', dr.driver_first_name) AS delivery_driver,
    CONCAT(v.vehicle_brand, ' ', v.vehicle_model) AS delivery_vehicle,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'pickup_date', p.pickup_date,
            'client_info', JSON_OBJECT(
                'client_id', c.client_id,
                'client_name', c.client_name,
                'client_address', c.client_address,
                'client_active', c.client_active
            )
        )
    ) AS delivery_pickups,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'dropoff_date', do.dropoff_date,
            'client_info', JSON_OBJECT(
                'client_id', c.client_id,
                'client_name', c.client_name,
                'client_address', c.client_address,
                'client_active', c.client_active
            )
        )
    ) AS delivery_dropoffs,
    pr.provider_name AS delivery_provider
FROM deliveries d
LEFT JOIN pickups p ON d.delivery_id = p.delivery_id
LEFT JOIN dropoffs do ON d.delivery_id = do.delivery_id
LEFT JOIN drivers dr ON d.delivery_driver = dr.driver_id
LEFT JOIN vehicles v ON d.delivery_vehicle = v.vehicle_id
LEFT JOIN providers pr ON d.delivery_provider = pr.provider_id
LEFT JOIN clients c ON p.client_id = c.client_id OR do.client_id = c.client_id
GROUP BY d.delivery_id, dr.driver_last_name, dr.driver_first_name, v.vehicle_brand, v.vehicle_model, pr.provider_name;


-- Create a view combining clients and addresses
CREATE VIEW IF NOT EXISTS client_info AS
SELECT
    c.client_id,
    c.client_name,
    a.address_street_number,
    a.address_street,
    a.address_city,
    a.address_postal_code,
    a.address_country,
    a.address_comment,
    c.client_active
FROM clients c
LEFT JOIN addresses a ON c.client_address = a.address_id;

-- Create a view combining drivers with emails and phones
CREATE VIEW driver_info AS
SELECT
    d.driver_id,
    d.driver_last_name,
    d.driver_first_name,
    d.driver_active,
    e.email,
    p.phone
FROM drivers d
LEFT JOIN emails e ON d.driver_id = e.entity_id AND e.entity_type = (SELECT entity_id FROM entities WHERE entity_name = 'driver')
LEFT JOIN phones p ON d.driver_id = p.entity_id AND p.entity_type = (SELECT entity_id FROM entities WHERE entity_name = 'driver');


-- Create a view combining providers with emails and phones
CREATE VIEW IF NOT EXISTS provider_info AS
SELECT
    pr.provider_id,
    pr.provider_name,
    pr.provider_contact_name,
    pr.provider_active,
    e.email,
    p.phone,
    a_headquarter.address_id AS headquarter_address_id,
    a_headquarter.address_street_number AS headquarter_street_number,
    a_headquarter.address_street AS headquarter_street,
    a_headquarter.address_city AS headquarter_city,
    a_headquarter.address_postal_code AS headquarter_postal_code,
    a_headquarter.address_country AS headquarter_country,
    a_warehouse.address_id AS warehouse_address_id,
    a_warehouse.address_street_number AS warehouse_street_number,
    a_warehouse.address_street AS warehouse_street,
    a_warehouse.address_city AS warehouse_city,
    a_warehouse.address_postal_code AS warehouse_postal_code,
    a_warehouse.address_country AS warehouse_country
FROM providers pr
LEFT JOIN emails e ON pr.provider_id = e.entity_id AND e.entity_type = (SELECT entity_id FROM entities WHERE entity_name = 'provider')
LEFT JOIN phones p ON pr.provider_id = p.entity_id AND p.entity_type = (SELECT entity_id FROM entities WHERE entity_name = 'provider')
LEFT JOIN addresses a_headquarter ON pr.provider_headquarter = a_headquarter.address_id
LEFT JOIN addresses a_warehouse ON pr.provider_warehouse = a_warehouse.address_id;