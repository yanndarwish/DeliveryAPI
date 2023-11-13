-- -- Insert data into clients table
-- INSERT INTO dmt.clients (client_name, client_street_number, client_street, client_city, client_postal_code, client_country, client_active)
-- VALUES ('Dior', 17, 'rue jean goujon', 'PARIS', 75017, 'FRANCE', true);

-- -- Insert data into drivers table
-- INSERT INTO dmt.drivers (driver_last_name, driver_first_name, driver_email, driver_phone, driver_active)
-- VALUES
--     ('Mila', 'Aleks', 'test@gmail.com', '0606060606', true),
--     ('F', 'Yann', 'test@gmail.com', '0606060606', false);

-- -- Insert data into providers table
-- INSERT INTO dmt.providers (provider_name, provider_headquarter, provider_warehouse, provider_contact_name, provider_contact_phone, provider_contact_email, provider_active)
-- VALUES ('JLR', 'somewhere', 'el', 'Jean-Louis', '0606060606', 'jlr@mail.com', true);

-- -- Insert data into vehicles table
-- INSERT INTO dmt.vehicles (vehicle_brand, vehicle_model, vehicle_immatriculation, vehicle_active)
-- VALUES
--     ('Test', 'Trois', 'AA111AA', true),
--     ('Mercedes', 'Cla', 'AA888BB', false),
--     ('Ford', 'Transit', 'AC444AT', true),
--     ('Tozz', 'Mala toz', 'AA777BB', true);

-- -- Insert data into deliveries table
-- INSERT INTO dmt.deliveries (delivery_driver, delivery_vehicle, delivery_provider, delivery_hotel)
-- VALUES
--     (2, 4, 1, 0),
--     (1, 2, 1, 0);

-- Insert addresses
INSERT INTO dmt.addresses (address_street_number, address_street, address_city, address_postal_code, address_country, address_comment) VALUES
(111, 'Pine Street', 'Villagetown', 54321, 'Countryland', 'Main office address'),
(222, 'Cedar Avenue', 'Hamletville', 98765, 'Countryland', 'Home address'),
(333, 'Birch Lane', 'Cityburgh', 12345, 'Countryland', 'Warehouse address');

-- Insert clients
INSERT INTO dmt.clients (client_name, client_address, client_active) VALUES
('Client A', 1, 1),
('Client B', 2, 1),
('Client C', 1, 0);

-- Insert drivers
INSERT INTO dmt.drivers (driver_last_name, driver_first_name, driver_active) VALUES
('Anderson', 'Mike', 1),
('Brown', 'Emma', 1),
('Taylor', 'Chris', 0);

-- Insert entities
INSERT INTO dmt.entities (entity_name) VALUES
('client'),
('driver'),
('provider');

-- Insert emails
INSERT INTO dmt.emails (entity_type, entity_id, email) VALUES
(1, 1, 'clienta@example.com'),
(2, 1, 'mike.anderson@example.com'),
(2, 2, 'emma.brown@example.com'),
(3, 1, 'provider2@example.com');

-- Insert phones
INSERT INTO dmt.phones (entity_type, entity_id, phone) VALUES
(1, 1, '111-222-3333'),
(2, 1, '777-888-9999'),
(2, 2, '444-555-6666'),
(3, 1, '111-999-8888');

-- Insert providers
INSERT INTO dmt.providers (provider_name, provider_contact_name, provider_headquarter, provider_warehouse, provider_active) VALUES
('Provider X', 'Mike Manager', 1, 3, 1),
('Provider Y', 'Emma Manager', 2, 1, 1);

-- Insert vehicles
INSERT INTO dmt.vehicles (vehicle_brand, vehicle_model, vehicle_immatriculation, vehicle_active) VALUES
('Honda', 'Accord', 'XYZ987', 1),
('Chevrolet', 'Malibu', 'ABC123', 1);

-- Insert deliveries
INSERT INTO dmt.deliveries (delivery_driver, delivery_vehicle, delivery_provider, delivery_hotel) VALUES
(1, 1, 1, 0),
(2, 2, 2, 1),
(1, 1, 1, 0);

-- Insert pickups
INSERT INTO dmt.pickups (delivery_id, client_id, pickup_date) VALUES
(1, 1, '2023-11-15 08:00:00'),
(1, 2, '2023-11-16 10:30:00'),
(3, 3, '2023-11-17 12:00:00');

-- Insert dropoffs
INSERT INTO dmt.dropoffs (delivery_id, client_id, dropoff_date) VALUES
(1, 2, '2023-11-15 12:00:00'),
(2, 1, '2023-11-16 14:30:00'),
(3, 3, '2023-11-17 16:00:00');
