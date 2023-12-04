USE geostar;

-- CREATE A VEHICLE
DELIMITER $$
CREATE PROCEDURE CreateVehicle(
    IN p_brand VARCHAR(20),
    IN p_model VARCHAR(20),
    IN p_immatriculation VARCHAR(20),
    IN p_active BOOLEAN
)
BEGIN
    INSERT INTO vehicles (
        vehicle_brand,
        vehicle_model,
        vehicle_immatriculation,
        vehicle_active
    )
    VALUES (
        p_brand,
        p_model,
        p_immatriculation,
        p_active
    );
END $$
DELIMITER ;

-- GET VEHICLES
DELIMITER $$
CREATE PROCEDURE GetVehicles()
BEGIN
    SELECT * FROM vehicles;
END $$
DELIMITER ;

-- GET A VEHICLE
DELIMITER $$
CREATE PROCEDURE GetVehicle(IN p_vehicle_id INT)
BEGIN
    SELECT * FROM vehicles WHERE vehicle_id = p_vehicle_id;
END $$
DELIMITER ;

-- UPDATE A VEHICLE
DELIMITER $$
CREATE PROCEDURE UpdateVehicle(
    IN p_vehicle_id INT,
    IN p_brand VARCHAR(20),
    IN p_model VARCHAR(20),
    IN p_immatriculation VARCHAR(20),
    IN p_active BOOLEAN
)
BEGIN
    UPDATE vehicles
    SET
        vehicle_brand = p_brand,
        vehicle_model = p_model,
        vehicle_immatriculation = p_immatriculation,
        vehicle_active = p_active
    WHERE
        vehicle_id = p_vehicle_id;
END $$
DELIMITER ;

-- DELETE A VEHICLE
DELIMITER $$
CREATE PROCEDURE DeleteVehicle(IN p_vehicle_id INT)
BEGIN
    DELETE FROM vehicles WHERE vehicle_id = p_vehicle_id;
END $$
DELIMITER ;

-- CALL CreateVehicle('Example Brand', 'Example Model', '123ABC', true);
-- CALL GetVehicles();
-- CALL GetVehicle(1);
-- CALL UpdateVehicle(1, 'Updated Brand', 'Updated Model', '987XYZ', false);
-- CALL DeleteVehicle(2);
