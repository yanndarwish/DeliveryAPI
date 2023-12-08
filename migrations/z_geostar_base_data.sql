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
CALL geostar.sp_create_company('GEOSTAR', TRUE, '12345678901234', 'geostar@mail.com', '0101010101','[{},{}]', 1, 'Main Street', 'Cityville', 12345, 'Countryland', 1, 'Main Street', 'Cityville', 12345, 'Countryland');
CALL geostar.sp_create_company('DMT', TRUE, '12345678901234', 'dmt@mail.com', '0101010101','[{},{}]', 2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop', 2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop');
CALL geostar.sp_create_company('JLR', TRUE, '12345678901234', 'jlr@mail.com', '0101010101','[{},{}]', 3, 'Pine Road', 'Villagetown', 10111, 'Countryville', 3, 'Pine Road', 'Villagetown', 10111, 'Countryville');
CALL geostar.sp_create_company('TEST', TRUE, '12345678901234', 'test@mail.com', '0101010101','[{},{}]', 2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop',2, 'Oak Avenue', 'Townburg', 56789, 'Countrytop');

-- Insert sample clients
CALL geostar.sp_create_client('Client One', 1, 'Main Street', 'Cityville', 12345, 'Countryland', TRUE, 0606060606, 'client1@example.com');
CALL geostar.sp_create_client('Client Two', 2, 'Oak Avenue', 'Townsville', 67890, 'Countryland', FALSE, 0606060606, 'client2@example.com');
CALL geostar.sp_create_client('Client Three', 3, 'Pine Street', 'Villageton', 54321, 'Countryland', TRUE, 0707070707, 'client3@example.com');

-- Insert sample tours
CALL geostar.sp_create_tour('Tour One', TRUE, 1, '[1, 2, 3]');

-- Update tour members active status
CALL geostar.sp_update_tour_member_status(1, 1, FALSE);

-- Insert sample drivers
CALL geostar.sp_create_driver('Smith', 'John', TRUE, 'driver1@example.com', 0606060606);
CALL geostar.sp_create_driver('Johnson', 'Alice', FALSE, 'driver2@example.com', 0606060606);
CALL geostar.sp_create_driver('Brown', 'Bob', TRUE, 'driver3@example.com', 0606060606);

-- Insert sample vehicles
CALL geostar.sp_create_vehicle('Toyota', 'Camry', 'ABC123', TRUE);
CALL geostar.sp_create_vehicle('Ford', 'Fusion', 'XYZ789', FALSE);
CALL geostar.sp_create_vehicle('Honda', 'Accord', 'LMN456', TRUE);

-- Insert sample deliveries
CALL geostar.sp_create_delivery(
    1, 1, 1, 4 , 101,
    '[{"client_id": 1, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 2, "pickup_date": "2023-11-25 14:00:00"}]',
    '[{"client_id": 3, "dropoff_date": "2023-11-26 11:00:00"}, {"client_id": 3, "dropoff_date": "2023-11-26 13:00:00"}]',
    NULL
);
CALL geostar.sp_create_delivery(
    2, 2, 2, 3, 202,
    '[{"client_id": 2, "pickup_date": "2023-11-25 10:00:00"}]',
    '[{"client_id": 1, "dropoff_date": "2023-11-26 11:00:00"}]',
    1
);
CALL geostar.sp_create_delivery(
    3, 3, 3, 3, 303,
    '[{"client_id": 1, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 2, "pickup_date": "2023-11-25 10:00:00"}, {"client_id": 3, "pickup_date": "2023-11-25 10:00:00"}]',
    '[{"client_id": 1, "dropoff_date": "2023-11-26 11:00:00"}]',
    NULL
);
