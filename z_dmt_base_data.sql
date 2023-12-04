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


-- ======================================================================================================================
-- ======================================================================================================================

-- Insert addresses
-- INSERT INTO dmt.addresses (address_street_number, address_street, address_city, address_postal_code, address_country, address_comment) VALUES
-- (111, 'Pine Street', 'Villagetown', 54321, 'Countryland', 'Main office address'),
-- (222, 'Cedar Avenue', 'Hamletville', 98765, 'Countryland', 'Home address'),
-- (333, 'Birch Lane', 'Cityburgh', 12345, 'Countryland', 'Warehouse address');

-- -- Insert clients
-- INSERT INTO dmt.clients (client_name, client_address, client_active) VALUES
-- ('Client A', 1, 1),
-- ('Client B', 2, 1),
-- ('Client C', 1, 0);

-- -- Insert drivers
-- INSERT INTO dmt.drivers (driver_last_name, driver_first_name, driver_active) VALUES
-- ('Anderson', 'Mike', 1),
-- ('Brown', 'Emma', 1),
-- ('Taylor', 'Chris', 0);

-- -- Insert entities
-- INSERT INTO dmt.entities (entity_name) VALUES
-- ('client'),
-- ('driver'),
-- ('provider');

-- -- Insert emails
-- INSERT INTO dmt.emails (entity_type, entity_id, email) VALUES
-- (1, 1, 'clienta@example.com'),
-- (2, 1, 'mike.anderson@example.com'),
-- (2, 2, 'emma.brown@example.com'),
-- (3, 1, 'provider2@example.com');

-- -- Insert phones
-- INSERT INTO dmt.phones (entity_type, entity_id, phone) VALUES
-- (1, 1, '111-222-3333'),
-- (2, 1, '777-888-9999'),
-- (2, 2, '444-555-6666'),
-- (3, 1, '111-999-8888');

-- -- Insert providers
-- INSERT INTO dmt.providers (provider_name, provider_contact_name, provider_headquarter, provider_warehouse, provider_active) VALUES
-- ('Provider X', 'Mike Manager', 1, 3, 1),
-- ('Provider Y', 'Emma Manager', 2, 1, 1);

-- -- Insert vehicles
-- INSERT INTO dmt.vehicles (vehicle_brand, vehicle_model, vehicle_immatriculation, vehicle_active) VALUES
-- ('Honda', 'Accord', 'XYZ987', 1),
-- ('Chevrolet', 'Malibu', 'ABC123', 1);

-- -- Insert deliveries
-- INSERT INTO dmt.deliveries (delivery_driver, delivery_vehicle, delivery_provider, delivery_hotel) VALUES
-- (1, 1, 1, 0),
-- (2, 2, 2, 1),
-- (1, 1, 1, 0);

-- -- Insert pickups
-- INSERT INTO dmt.pickups (delivery_id, client_id, pickup_date) VALUES
-- (1, 1, '2023-11-15 08:00:00'),
-- (1, 2, '2023-11-16 10:30:00'),
-- (3, 3, '2023-11-17 12:00:00');

-- -- Insert dropoffs
-- INSERT INTO dmt.dropoffs (delivery_id, client_id, dropoff_date) VALUES
-- (1, 2, '2023-11-15 12:00:00'),
-- (2, 1, '2023-11-16 14:30:00'),
-- (3, 3, '2023-11-17 16:00:00');

-- ======================================================================================================================
-- ======================================================================================================================


INSERT INTO dmt.entities (entity_name) VALUES
('CLIENT'),
('DRIVER'),
('PROVIDER');

-- Insert sample addresses
CALL dmt.CreateAddress(123, 'Main Street', 'Cityville', 12345, 'Countryland', NULL);
CALL dmt.CreateAddress(456, 'Oak Avenue', 'Townburg', 56789, 'Countrytop', NULL);
CALL dmt.CreateAddress(789, 'Pine Road', 'Villagetown', 10111, 'Countryville', NULL);

-- Insert sample clients
CALL dmt.CreateClient('Client One', 1, 'Main Street', 'Cityville', 12345, 'Countryland', TRUE, 0606060606, 'client1@example.com');
CALL dmt.CreateClient('Client Two', 2, 'Oak Avenue', 'Townsville', 67890, 'Countryland', FALSE, 0606060606, 'client2@example.com');
CALL dmt.CreateClient('Client Three', 3, 'Pine Street', 'Villageton', 54321, 'Countryland', TRUE, 0707070707, 'client3@example.com');

-- Insert sample drivers
CALL dmt.CreateDriver('Smith', 'John', TRUE, 'driver1@example.com', 0606060606);
CALL dmt.CreateDriver('Johnson', 'Alice', FALSE, 'driver2@example.com', 0606060606);
CALL dmt.CreateDriver('Brown', 'Bob', TRUE, 'driver3@example.com', 0606060606);

-- Insert sample providers
CALL dmt.CreateProvider(
    'Provider One', 'Contact One', TRUE,
    'provider1@example.com', 0707070707,
    1, TRUE, 2, '123-456-7890', 'client1@example.com'
);
CALL dmt.CreateProvider(
    'Provider Two', 'Contact Two', TRUE,
    'provider2@example.com', 0606060606,
    2, TRUE, 3, '234-567-8901', 'client2@example.com'
);
CALL dmt.CreateProvider(
    'Provider Three', 'Contact Three', FALSE,
    'provider3@example.com', 0808080808,
    3, FALSE, 1, '345-678-9012', 'client3@example.com'
);

-- Insert sample vehicles
CALL dmt.CreateVehicle('Toyota', 'Camry', 'ABC123', TRUE);
CALL dmt.CreateVehicle('Ford', 'Fusion', 'XYZ789', FALSE);
CALL dmt.CreateVehicle('Honda', 'Accord', 'LMN456', TRUE);

-- Insert sample deliveries
CALL dmt.CreateDelivery(
    1, 1, 1, 101,
    '[1, 2]', '2023-11-25 10:00:00',
    '[1]', '2023-11-25 14:00:00'
);
CALL dmt.CreateDelivery(
    2, 2, 2, 202,
    '[3]', '2023-11-26 12:00:00',
    '[2]', '2023-11-26 15:30:00'
);
CALL dmt.CreateDelivery(
    3, 3, 3, 303,
    '[]', '2023-11-27 16:00:00',
    '[3]', '2023-11-27 18:00:00'
);

