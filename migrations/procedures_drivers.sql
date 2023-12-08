USE geostar;

-- CREATE A DRIVER
DELIMITER $$ 
CREATE PROCEDURE sp_create_driver(
    IN p_last_name VARCHAR(25),
    IN p_first_name VARCHAR(25),
    IN p_active BOOLEAN,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100),
    IN p_company_id INT
)
BEGIN
    DECLARE new_driver_id INT;

    -- Insert into drivers table
    INSERT INTO drivers (
        driver_last_name,
        driver_first_name,
        driver_active,
        company_id
    )
    VALUES (
        p_last_name,
        p_first_name,
        p_active,
        p_company_id
    );

    SET new_driver_id = LAST_INSERT_ID();

    CALL sp_create_email('DRIVER', new_driver_id, p_email);
    CALL sp_create_phone('DRIVER', new_driver_id, p_phone);
END $$
DELIMITER ;

-- GET DRIVERS
DELIMITER $$
CREATE PROCEDURE sp_get_drivers()
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
CREATE PROCEDURE sp_get_driver_by_id(IN p_driver_id INT)
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
CREATE PROCEDURE sp_update_driver(
    IN p_driver_id INT,
    IN p_last_name VARCHAR(25),
    IN p_first_name VARCHAR(25),
    IN p_active BOOLEAN,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100)
)
BEGIN
    UPDATE drivers
    SET
        driver_last_name = p_last_name,
        driver_first_name = p_first_name,
        driver_active = p_active
    WHERE
        driver_id = p_driver_id;

    CALL sp_update_email('DRIVER', p_driver_id, p_email);
    CALL sp_update_phone('DRIVER', p_driver_id, p_phone);
END $$
DELIMITER ;

-- DELETE A DRIVER
DELIMITER $$
CREATE PROCEDURE sp_delete_driver(IN p_driver_id INT)
BEGIN
    DELETE FROM drivers WHERE driver_id = p_driver_id;

    CALL sp_delete_email('DRIVER', p_driver_id);
    CALL sp_delete_phone('DRIVER', p_driver_id);
END $$
DELIMITER ;
