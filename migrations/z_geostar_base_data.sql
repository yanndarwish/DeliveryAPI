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

-- Insert sample companies
CALL geostar.CreateCompany('GEOSTAR', TRUE, '12345678901234', 'geostar@mail.com', '0101010101','[{},{}]', 1, 'Main Street', 'Cityville', 12345, 'Countryland', '', 1, 'Main Street', 'Cityville', 12345, 'Countryland','');
CALL geostar.CreateCompany('DMT', TRUE, '12345678901234', 'dmt@mail.com', '0101010101','[{},{}]', 2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop', '', 2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop','');
CALL geostar.CreateCompany('JLR', TRUE, '12345678901234', 'jlr@mail.com', '0101010101','[{},{}]', 3, 'Pine Road', 'Villagetown', 10111, 'Countryville', '', 3, 'Pine Road', 'Villagetown', 10111, 'Countryville','');
CALL geostar.CreateCompany('TEST', TRUE, '12345678901234', 'test@mail.com', '0101010101','[{},{}]', 2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop', '',2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop','');

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

-- Insert sample vehicles
CALL geostar.CreateVehicle('Toyota', 'Camry', 'ABC123', TRUE);
CALL geostar.CreateVehicle('Ford', 'Fusion', 'XYZ789', FALSE);
CALL geostar.CreateVehicle('Honda', 'Accord', 'LMN456', TRUE);

-- Insert sample deliveries
CALL geostar.CreateDelivery(
    1, 1, 1, 4 , 101,
    '[{"client_id": 1, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 2, "pickup_date": "2023-11-25 14:00:00"}]',
    '[{"client_id": 3, "dropoff_date": "2023-11-26 11:00:00"}, {"client_id": 3, "dropoff_date": "2023-11-26 13:00:00"}]',
    NULL
);
CALL geostar.CreateDelivery(
    2, 2, 2, 3, 202,
    '[{"client_id": 2, "pickup_date": "2023-11-25 10:00:00"}]',
    '[{"client_id": 1, "dropoff_date": "2023-11-26 11:00:00"}]',
    1
);
CALL geostar.CreateDelivery(
    3, 3, 3, 3, 303,
    '[{"client_id": 1, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 2, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 3, "pickup_date": "2023-11-25 10:00:00"}]',
    '[{"client_id": 1, "dropoff_date": "2023-11-26 11:00:00"}]',
    NULL
);
