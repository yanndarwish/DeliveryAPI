USE {DB_NAME};

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

    -- Only create email if p_email is not NULL
    IF p_email IS NOT NULL THEN
        CALL sp_create_email('DRIVER', new_driver_id, p_email);
    END IF;

    -- Only create phone if p_phone is not NULL
    IF p_phone IS NOT NULL THEN
        CALL sp_create_phone('DRIVER', new_driver_id, p_phone);
    END IF;
END $$
DELIMITER ;

-- GET DRIVERS
DELIMITER $$
CREATE PROCEDURE sp_get_drivers(
    IN p_offset INT,
    IN p_limit INT,
    IN p_status VARCHAR(10),
    IN p_first_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'ACTIVE' THEN
        SELECT 
            di.driver_id,
            di.driver_last_name,
            di.driver_first_name,
            di.driver_active,
            di.email,
            di.phone
        FROM view_drivers_info di
        WHERE di.company_id = p_company_id
        AND di.driver_active = TRUE
        AND (di.driver_first_name LIKE CONCAT('%', p_first_name, '%') OR p_first_name IS NULL)
        AND (di.driver_last_name LIKE CONCAT('%', p_last_name, '%') OR p_last_name IS NULL)
        AND (di.email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        AND (di.phone LIKE CONCAT('%', p_phone, '%') OR p_phone IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT 
            di.driver_id,
            di.driver_last_name,
            di.driver_first_name,
            di.driver_active,
            di.email,
            di.phone
        FROM view_drivers_info di
        WHERE di.company_id = p_company_id
        AND di.driver_active = FALSE
        AND (di.driver_first_name LIKE CONCAT('%', p_first_name, '%') OR p_first_name IS NULL)
        AND (di.driver_last_name LIKE CONCAT('%', p_last_name, '%') OR p_last_name IS NULL)
        AND (di.email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        AND (di.phone LIKE CONCAT('%', p_phone, '%') OR p_phone IS NULL)
        LIMIT p_limit
        OFFSET p_offset;
    ELSE
        SELECT 
            di.driver_id,
            di.driver_last_name,
            di.driver_first_name,
            di.driver_active,
            di.email,
            di.phone
        FROM view_drivers_info di
        WHERE di.company_id = p_company_id
        AND (di.driver_first_name LIKE CONCAT('%', p_first_name, '%') OR p_first_name IS NULL)
        AND (di.driver_last_name LIKE CONCAT('%', p_last_name, '%') OR p_last_name IS NULL)
        AND (di.email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        AND (di.phone LIKE CONCAT('%', p_phone, '%') OR p_phone IS NULL)
        LIMIT p_limit
        OFFSET p_offset;
    END IF;
END $$
DELIMITER ;

-- GET DRIVERS COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_drivers_count(
    IN p_status VARCHAR(10),
    IN p_first_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'ACTIVE' THEN
        SELECT COUNT(*) AS total
        FROM view_drivers_info di
        WHERE di.company_id = p_company_id
        AND di.driver_active = TRUE
        AND (di.driver_first_name LIKE CONCAT('%', p_first_name, '%') OR p_first_name IS NULL)
        AND (di.driver_last_name LIKE CONCAT('%', p_last_name, '%') OR p_last_name IS NULL)
        AND (di.email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        AND (di.phone LIKE CONCAT('%', p_phone, '%') OR p_phone IS NULL);
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT COUNT(*) AS total
        FROM view_drivers_info di
        WHERE di.company_id = p_company_id
        AND di.driver_active = FALSE
        AND (di.driver_first_name LIKE CONCAT('%', p_first_name, '%') OR p_first_name IS NULL)
        AND (di.driver_last_name LIKE CONCAT('%', p_last_name, '%') OR p_last_name IS NULL)
        AND (di.email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        AND (di.phone LIKE CONCAT('%', p_phone, '%') OR p_phone IS NULL);
    ELSE
        SELECT COUNT(*) AS total
        FROM view_drivers_info di
        WHERE di.company_id = p_company_id
        AND (di.driver_first_name LIKE CONCAT('%', p_first_name, '%') OR p_first_name IS NULL)
        AND (di.driver_last_name LIKE CONCAT('%', p_last_name, '%') OR p_last_name IS NULL)
        AND (di.email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        AND (di.phone LIKE CONCAT('%', p_phone, '%') OR p_phone IS NULL);
    END IF;
END $$

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
    FROM view_drivers_info di
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
