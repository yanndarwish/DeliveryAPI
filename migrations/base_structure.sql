-- Create geostar database
CREATE DATABASE IF NOT EXISTS geostar;

USE geostar;

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

-- Create emails table
CREATE TABLE IF NOT EXISTS emails (
    email_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type VARCHAR(10),
    entity_id INTEGER,
    email VARCHAR(50)
);

-- Create phone numbers table
CREATE TABLE IF NOT EXISTS phones (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_type VARCHAR(10),
    entity_id INTEGER,
    phone VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(30),
    company_headquarter INTEGER,
    company_warehouse INTEGER,
    company_siret VARCHAR(14),
    contacts JSON,
    company_active BOOLEAN,
    FOREIGN KEY (company_headquarter) REFERENCES addresses(address_id),
    FOREIGN KEY (company_warehouse) REFERENCES addresses(address_id)
) ENGINE=InnoDB;

-- Create clients table
CREATE TABLE IF NOT EXISTS clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(30),
    client_address INTEGER,
    client_active BOOLEAN,
    company_id INTEGER,
    FOREIGN KEY (client_address) REFERENCES addresses(address_id),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tours (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_name VARCHAR(30),
    tour_active BOOLEAN,
    company_id INTEGER,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tours_members (
    tour_member_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_id INTEGER,
    client_id INTEGER,
    tour_member_active BOOLEAN DEFAULT TRUE,
    company_id INTEGER,
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tours_operations (
    tour_operation_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_operation_name VARCHAR(10) UNIQUE -- 'CREATE', 'ACTIVATE', 'DEACTIVATE', 'DELETE'
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tours_history (
    tour_history_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_history_date DATETIME,
    tour_history_operation VARCHAR(10), 
    tour_id INTEGER,
    client_id INTEGER,
    company_id INTEGER,
    FOREIGN KEY (tour_history_operation) REFERENCES tours_operations(tour_operation_name),
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_last_name VARCHAR(25),
    driver_first_name VARCHAR(25),
    driver_active BOOLEAN,
    company_id INTEGER,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS entities (
    entity_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_name VARCHAR(10) UNIQUE -- 'CLIENT', 'DRIVER', 'COMPANY'
);

CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_brand VARCHAR(20),
    vehicle_model VARCHAR(20),
    vehicle_immatriculation VARCHAR(20),
    vehicle_active BOOLEAN,
    company_id INTEGER,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    delivery_driver INTEGER,
    delivery_vehicle INTEGER,
    delivery_provider INTEGER,
    delivery_hotel_price INT,
    delivery_outsourced_to INTEGER DEFAULT NULL,
    company_id INTEGER,
    FOREIGN KEY (delivery_driver) REFERENCES drivers(driver_id),
    FOREIGN KEY (delivery_vehicle) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (delivery_provider) REFERENCES companies(company_id),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pickups (
    pickup_id SERIAL PRIMARY KEY,
    company_id INT,
    delivery_id INT,
    client_id INT,
    pickup_date DATETIME,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE IF NOT EXISTS dropoffs (
    dropoff_id SERIAL PRIMARY KEY,
    company_id INT,
    delivery_id INT,
    client_id INT,
    dropoff_date DATETIME,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE VIEW IF NOT EXISTS view_pickups_info AS
SELECT
    d.delivery_id,
    d.company_id,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'date', p.pickup_date,
            'client_info', JSON_OBJECT(
                'client_id', p.client_id,
                'client_name', c.client_name,
                'client_address', CONCAT(a.address_street_number, ' ', a.address_street, ', ', a.address_city, ' ', a.address_postal_code, ' ', a.address_country),
                'client_active', c.client_active
            )
        )
    ) AS pickups
FROM deliveries d
LEFT JOIN pickups p ON d.delivery_id = p.delivery_id
LEFT JOIN clients c ON p.client_id = c.client_id
LEFT JOIN addresses a ON c.client_address = a.address_id
GROUP BY d.delivery_id;

CREATE VIEW IF NOT EXISTS view_dropoffs_info AS
SELECT
    d.delivery_id,
    d.company_id,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'date', do.dropoff_date,
            'client_info', JSON_OBJECT(
                'client_id', do.client_id,
                'client_name', c.client_name,
                'client_address', CONCAT(a.address_street_number, ' ', a.address_street, ', ', a.address_city, ' ', a.address_postal_code, ' ', a.address_country),
                'client_active', c.client_active
            )
        )
    ) AS dropoffs
FROM deliveries d
LEFT JOIN dropoffs do ON d.delivery_id = do.delivery_id
LEFT JOIN clients c ON do.client_id = c.client_id
LEFT JOIN addresses a ON c.client_address = a.address_id
GROUP BY d.delivery_id;

CREATE VIEW IF NOT EXISTS view_deliveries_info AS
SELECT
    d.delivery_id,
    CONCAT(dr.driver_last_name, ', ', dr.driver_first_name) AS delivery_driver,
    CONCAT(v.vehicle_brand, ' ', v.vehicle_model) AS delivery_vehicle,
    c.company_name AS delivery_provider,
    d.delivery_hotel_price,
    co.company_name AS delivery_outsourced_to,
    pi.pickups,
    di.dropoffs,
    d.company_id
FROM deliveries d
LEFT JOIN drivers dr ON d.delivery_driver = dr.driver_id
LEFT JOIN vehicles v ON d.delivery_vehicle = v.vehicle_id
LEFT JOIN companies c ON d.delivery_provider = c.company_id
LEFT JOIN companies co ON d.delivery_outsourced_to = co.company_id
LEFT JOIN view_pickups_info pi ON d.delivery_id = pi.delivery_id
LEFT JOIN view_dropoffs_info di ON d.delivery_id = di.delivery_id;

CREATE VIEW IF NOT EXISTS view_clients_info AS
SELECT
    c.client_id,
    c.client_name,
    a.address_street_number,
    a.address_street,
    a.address_city,
    a.address_postal_code,
    a.address_country,
    a.address_comment,
    c.client_active,
    p.phone,
    e.email,
    c.company_id
FROM clients c
LEFT JOIN addresses a ON c.client_address = a.address_id
LEFT JOIN phones p ON c.client_id = p.entity_id AND p.entity_type = 'CLIENT'
LEFT JOIN emails e ON c.client_id = e.entity_id AND e.entity_type = 'CLIENT';

CREATE VIEW IF NOT EXISTS view_drivers_info AS
SELECT
    d.driver_id,
    d.driver_last_name,
    d.driver_first_name,
    d.driver_active,
    e.email,
    p.phone,
    d.company_id
FROM drivers d
LEFT JOIN emails e ON d.driver_id = e.entity_id AND e.entity_type = 'DRIVER'
LEFT JOIN phones p ON d.driver_id = p.entity_id AND p.entity_type = 'DRIVER';

CREATE VIEW IF NOT EXISTS view_companies_info AS
SELECT
    c.company_id,
    c.company_name,
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
    a_warehouse.address_country AS warehouse_country,
    c.company_siret,
    e.email,
    p.phone,
    c.contacts,
    c.company_active
FROM companies c
LEFT JOIN addresses a_headquarter ON c.company_headquarter = a_headquarter.address_id
LEFT JOIN addresses a_warehouse ON c.company_warehouse = a_warehouse.address_id
LEFT JOIN emails e ON c.company_id = e.entity_id AND e.entity_type = 'COMPANY'
LEFT JOIN phones p ON c.company_id = p.entity_id AND p.entity_type = 'COMPANY';

CREATE VIEW IF NOT EXISTS view_tour_members_info AS
SELECT
    tm.tour_member_id,
    co.company_id,
    tm.tour_id,
    t.tour_name,
    tm.client_id,
    c.client_name,
    a.address_street_number,
    a.address_street,
    a.address_city,
    a.address_postal_code,
    a.address_country,
    tm.tour_member_active
FROM tours_members tm
LEFT JOIN companies co ON tm.company_id = co.company_id
LEFT JOIN tours t ON tm.tour_id = t.tour_id
LEFT JOIN clients c ON tm.client_id = c.client_id
LEFT JOIN addresses a ON c.client_address = a.address_id;
