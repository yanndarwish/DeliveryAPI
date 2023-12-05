-- Insert sample entities
INSERT INTO geostar.entities (entity_name) VALUES
('CLIENT'),
('DRIVER'),
('PROVIDER');

-- Insert sample tours_operations
INSERT INTO geostar.tours_operations (tour_operation_name) VALUES
('CREATE'),
('ACTIVATE'),
('DEACTIVATE'),
('DELETE');

-- Insert sample addresses
CALL geostar.CreateAddress(123, 'Main Street', 'Cityville', 12345, 'Countryland', NULL);
CALL geostar.CreateAddress(456, 'Oak Avenue', 'Townburg', 56789, 'Countrytop', NULL);
CALL geostar.CreateAddress(789, 'Pine Road', 'Villagetown', 10111, 'Countryville', NULL);

-- Insert sample companies
INSERT INTO geostar.companies (company_name, company_address, company_siret, company_active) VALUES
('GEOSTAR', 1, '12345678901234', TRUE),
('DMT', 2, '12345678901234', TRUE),
('Company Three', 3, '12345678901234', TRUE);

-- Insert sample clients
CALL geostar.CreateClient('Client One', 1, 'Main Street', 'Cityville', 12345, 'Countryland', TRUE, 0606060606, 'client1@example.com');
CALL geostar.CreateClient('Client Two', 2, 'Oak Avenue', 'Townsville', 67890, 'Countryland', FALSE, 0606060606, 'client2@example.com');
CALL geostar.CreateClient('Client Three', 3, 'Pine Street', 'Villageton', 54321, 'Countryland', TRUE, 0707070707, 'client3@example.com');

-- Insert sample tours
CALL geostar.CreateTour('Tour One', TRUE, 1, '[1, 2, 3]');

-- Update tour members active status
CALL geostar.UpdateTourMemberStatus(1, 1, FALSE);

-- Insert sample drivers
CALL geostar.CreateDriver('Smith', 'John', TRUE, 'driver1@example.com', 0606060606);
CALL geostar.CreateDriver('Johnson', 'Alice', FALSE, 'driver2@example.com', 0606060606);
CALL geostar.CreateDriver('Brown', 'Bob', TRUE, 'driver3@example.com', 0606060606);

-- Insert sample providers
CALL geostar.CreateProvider(
    'Provider One', 'Contact One', TRUE,
    'provider1@example.com', 0606060606,
    1,'street name', 'Paris', 75008, 'France', NULL, NULL, NULL, NULL, NULL
);
CALL geostar.CreateProvider(
    'Provider Two', 'Contact Two', TRUE,
    'provider2@example.com', 0606060606,
    2,'street name', 'Paris', 75008, 'France', NULL, NULL, NULL, NULL, NULL
);
CALL geostar.CreateProvider(
    'Provider Three', 'Contact Three', TRUE,
    'provider3@example.com', 0606060606,
    3,'street name', 'Paris', 75008, 'France', NULL, NULL, NULL, NULL, NULL
);

-- Insert sample vehicles
CALL geostar.CreateVehicle('Toyota', 'Camry', 'ABC123', TRUE);
CALL geostar.CreateVehicle('Ford', 'Fusion', 'XYZ789', FALSE);
CALL geostar.CreateVehicle('Honda', 'Accord', 'LMN456', TRUE);

-- Insert sample deliveries
CALL geostar.CreateDelivery(
    1, 1, 1, 101,
    '[{"client_id": 1, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 2, "pickup_date": "2023-11-25 14:00:00"}]',
    '[{"client_id": 3, "dropoff_date": "2023-11-26 11:00:00"}, {"client_id": 3, "dropoff_date": "2023-11-26 13:00:00"}]'
);
CALL geostar.CreateDelivery(
    2, 2, 2, 202,
    '[{"client_id": 2, "pickup_date": "2023-11-25 10:00:00"}]',
    '[{"client_id": 1, "dropoff_date": "2023-11-26 11:00:00"}]'
);
CALL geostar.CreateDelivery(
    3, 3, 3, 303,
    '[{"client_id": 1, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 2, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 3, "pickup_date": "2023-11-25 10:00:00"}]',
    '[{"client_id": 1, "dropoff_date": "2023-11-26 11:00:00"}]'
);
