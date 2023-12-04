USE geostar;

-- CREATE A DRIVER
DELIMITER $$ 
CREATE PROCEDURE CreateDriver(
    IN p_last_name VARCHAR(25),
    IN p_first_name VARCHAR(25),
    IN p_active BOOLEAN,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100)
)
BEGIN
    DECLARE new_driver_id INT;

    -- Insert into drivers table
    INSERT INTO drivers (
        driver_last_name,
        driver_first_name,
        driver_active
    )
    VALUES (
        p_last_name,
        p_first_name,
        p_active
    );

    -- Get the last inserted driver_id
    SET new_driver_id = LAST_INSERT_ID();

    -- Insert into emails table
    INSERT INTO emails (
        entity_type,
        entity_id,
        email
    )
    VALUES (
        'DRIVER',
        new_driver_id,
        p_email
    );

    -- Insert into phones table
    INSERT INTO phones (
        entity_type,
        entity_id,
        phone
    )
    VALUES (
        'DRIVER',
        new_driver_id,
        p_phone
    );
END $$
DELIMITER ;

-- GET DRIVERS
DELIMITER $$
CREATE PROCEDURE GetDrivers()
BEGIN
    SELECT 
        di.driver_id,
        di.driver_last_name,
        di.driver_first_name,
        di.driver_active,
        di.email,
        di.phone
    FROM drivers_info di;
END $$
DELIMITER ;

-- GET A DRIVER
DELIMITER $$
CREATE PROCEDURE GetDriver(IN p_driver_id INT)
BEGIN
    SELECT 
        di.driver_id,
        di.driver_last_name,
        di.driver_first_name,
        di.driver_active,
        di.email,
        di.phone
    FROM drivers_info di
    WHERE di.driver_id = p_driver_id;
END $$
DELIMITER ;

-- UPDATE A DRIVER
DELIMITER $$
CREATE PROCEDURE UpdateDriver(
    IN p_driver_id INT,
    IN p_last_name VARCHAR(25),
    IN p_first_name VARCHAR(25),
    IN p_active BOOLEAN,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100)
)
BEGIN
    -- Update the drivers table
    UPDATE drivers
    SET
        driver_last_name = p_last_name,
        driver_first_name = p_first_name,
        driver_active = p_active
    WHERE
        driver_id = p_driver_id;

    -- Update the emails table
    UPDATE emails
    SET
        email = p_email
    WHERE
        entity_type = 'DRIVER' AND entity_id = p_driver_id;

    -- Update the phones table
    UPDATE phones
    SET
        phone = p_phone
    WHERE
        entity_type = 'DRIVER' AND entity_id = p_driver_id;
END $$
DELIMITER ;

-- DELETE A DRIVER
DELIMITER $$
CREATE PROCEDURE DeleteDriver(IN p_driver_id INT)
BEGIN
    -- Delete from drivers table
    DELETE FROM drivers WHERE driver_id = p_driver_id;

    -- Delete from emails table
    DELETE FROM emails WHERE entity_type = 'DRIVER' AND entity_id = p_driver_id;

    -- Delete from phones table
    DELETE FROM phones WHERE entity_type = 'DRIVER' AND entity_id = p_driver_id;
END $$
DELIMITER ;
