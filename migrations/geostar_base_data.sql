-- -- Insert data into clients table
-- INSERT INTO geostar.clients (client_name, client_street_number, client_street, client_city, client_postal_code, client_country, client_active)
-- VALUES ('Dior', 17, 'rue jean goujon', 'PARIS', 75017, 'FRANCE', true);

-- -- Insert data into drivers table
-- INSERT INTO geostar.drivers (driver_last_name, driver_first_name, driver_email, driver_phone, driver_active)
-- VALUES
--     ('B', 'Kevin', 'test@mail.com', '0808080808', false),
--     ('Deux', 'Test', 'test@mail.com', '0707070707', false),
--     ('Mohammad', 'Hasnaine', 'test@mail.com', '0606060606', true);

-- -- Insert data into providers table
-- INSERT INTO geostar.providers (provider_name, provider_headquarter, provider_warehouse, provider_contact_name, provider_contact_phone, provider_contact_email, provider_active)
-- VALUES ('JLR', 'somewhere', 'el', 'Jean-Louis', '0606060606', 'jlr@mail.com', true);

-- -- Insert data into vehicles table
-- INSERT INTO geostar.vehicles (vehicle_brand, vehicle_model, vehicle_immatriculation, vehicle_active)
-- VALUES
--     ('Test', 'Trois', 'AA111AA', true),
--     ('Mercedes', 'Cla', 'AA888BB', false),
--     ('Ford', 'Transit', 'AC444AT', true),
--     ('Tozz', 'Mala toz', 'AA777BB', true);

-- -- Insert data into deliveries table
-- INSERT INTO geostar.deliveries (delivery_driver, delivery_vehicle, delivery_provider, delivery_hotel)
-- VALUES
--     (1, 2, 1, 0),
--     (3, 3, 1, 0),
--     (2, 4, 1, 0);



-- Insert addresses
INSERT INTO geostar.addresses (address_street_number, address_street, address_city, address_postal_code, address_country, address_comment) VALUES
(123, 'Main Street', 'Cityville', 12345, 'Countryland', 'Office address'),
(456, 'Maple Avenue', 'Townsville', 67890, 'Countryland', 'Home address'),
(789, 'Oak Street', 'Villageton', 54321, 'Countryland', 'Warehouse address');

-- Insert clients
INSERT INTO geostar.clients (client_name, client_address, client_active) VALUES
('Client One', 1, 1),
('Client Two', 2, 1),
('Client Three', 1, 0);

-- Insert drivers
INSERT INTO geostar.drivers (driver_last_name, driver_first_name, driver_active) VALUES
('Smith', 'John', 1),
('Doe', 'Jane', 1),
('Johnson', 'Bob', 0);

-- Insert entities
INSERT INTO geostar.entities (entity_name) VALUES
('client'),
('driver'),
('provider');

-- Insert emails
INSERT INTO geostar.emails (entity_type, entity_id, email) VALUES
(1, 1, 'clientone@example.com'),
(2, 1, 'john.smith@example.com'),
(2, 2, 'jane.doe@example.com'),
(3, 1, 'provider@example.com');

-- Insert phones
INSERT INTO geostar.phones (entity_type, entity_id, phone) VALUES
(1, 1, '123-456-7890'),
(2, 1, '555-555-5555'),
(2, 2, '987-654-3210'),
(3, 1, '987-123-4567');

-- Insert providers
INSERT INTO geostar.providers (provider_name, provider_contact_name, provider_headquarter, provider_warehouse, provider_active) VALUES
('Provider One', 'John Manager', 1, 3, 1),
('Provider Two', 'Jane Manager', 1, 1, 1);

-- Insert vehicles
INSERT INTO geostar.vehicles (vehicle_brand, vehicle_model, vehicle_immatriculation, vehicle_active) VALUES
('Toyota', 'Camry', 'ABC123', 1),
('Ford', 'Fusion', 'XYZ987', 1);

-- Insert deliveries
INSERT INTO geostar.deliveries (delivery_driver, delivery_vehicle, delivery_provider, delivery_hotel) VALUES
(1, 1, 1, 0),
(2, 2, 2, 1),
(1, 1, 1, 0);

-- Insert pickups
INSERT INTO geostar.pickups (delivery_id, client_id, pickup_date) VALUES
(1, 1, '2023-11-10 08:00:00'),
(1, 2, '2023-11-11 10:30:00'),
(3, 3, '2023-11-12 12:00:00');

-- Insert dropoffs
INSERT INTO geostar.dropoffs (delivery_id, client_id, dropoff_date) VALUES
(1, 2, '2023-11-10 12:00:00'),
(2, 1, '2023-11-11 14:30:00'),
(3, 3, '2023-11-12 16:00:00');