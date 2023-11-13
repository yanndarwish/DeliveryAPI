-- CREATE A DRIVER
DELIMITER $$
CREATE PROCEDURE CreateDriver(
    IN p_last_name VARCHAR(25),
    IN p_first_name VARCHAR(25),
    IN p_email VARCHAR(30),
    IN p_phone VARCHAR(15),
    IN p_active BOOLEAN
)
BEGIN
    INSERT INTO drivers (
        driver_last_name,
        driver_first_name,
        driver_email,
        driver_phone,
        driver_active
    )
    VALUES (
        p_last_name,
        p_first_name,
        p_email,
        p_phone,
        p_active
    );
END $$
DELIMITER ;

-- GET DRIVERS
DELIMITER $$
CREATE PROCEDURE GetDrivers()
BEGIN
    SELECT * FROM drivers;
END $$
DELIMITER ;

-- GET A DRIVER
DELIMITER $$
CREATE PROCEDURE GetDriver(IN p_driver_id INT)
BEGIN
    SELECT * FROM drivers WHERE driver_id = p_driver_id;
END $$
DELIMITER ;

-- UPDATE A DRIVER
DELIMITER $$
CREATE PROCEDURE UpdateDriver(
    IN p_driver_id INT,
    IN p_last_name VARCHAR(25),
    IN p_first_name VARCHAR(25),
    IN p_email VARCHAR(30),
    IN p_phone VARCHAR(15),
    IN p_active BOOLEAN
)
BEGIN
    UPDATE drivers
    SET
        driver_last_name = p_last_name,
        driver_first_name = p_first_name,
        driver_email = p_email,
        driver_phone = p_phone,
        driver_active = p_active
    WHERE
        driver_id = p_driver_id;
END $$
DELIMITER ;

-- DELETE A DRIVER
DELIMITER $$
CREATE PROCEDURE DeleteDriver(IN p_driver_id INT)
BEGIN
    DELETE FROM drivers WHERE driver_id = p_driver_id;
END $$
DELIMITER ;

-- CALL CreateDriver('Doe', 'John', 'john.doe@example.com', '123456789', true);
-- CALL GetDrivers();
-- CALL GetDriver(1);
-- CALL UpdateDriver(1, 'Updated Last Name', 'Updated First Name', 'updated.email@example.com', '987654321', false);
-- CALL DeleteDriver(2);
