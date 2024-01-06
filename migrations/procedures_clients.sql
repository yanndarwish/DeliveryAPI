USE {DB_NAME};

-- CREATE A CLIENT
DELIMITER $$ 
CREATE PROCEDURE sp_create_client(
    IN p_client_name VARCHAR(30),
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_comment VARCHAR(100),
    IN p_active BOOLEAN,
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_company_id INT
)
BEGIN
    DECLARE new_address_id INT;
    DECLARE new_client_id INT;

    -- Insert into clients table
    INSERT INTO clients (
        client_name,
        client_active,
        company_id
    )
    VALUES (
        p_client_name,
        p_active,
        p_company_id
    );

    SET new_client_id = LAST_INSERT_ID();

    CALL sp_create_address(p_street_number, p_street, p_city, p_postal_code, p_country, p_comment, 'CLIENT', new_client_id);
    -- if phone is not null
    IF p_phone IS NOT NULL THEN
        CALL sp_create_phone('CLIENT', new_client_id, p_phone);
    END IF;

    -- if email is not null
    IF p_email IS NOT NULL THEN
        CALL sp_create_email('CLIENT', new_client_id, p_email);
    END IF;
END $$
DELIMITER ;

-- GET CLIENTS
DELIMITER $$
CREATE PROCEDURE sp_get_clients(
    IN p_offset INT,
    IN p_limit INT,
    IN p_status VARCHAR(10),
    IN p_name VARCHAR(30),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_company_id INT
)
BEGIN
    -- IF status is active
    IF p_status = 'ACTIVE' THEN
        SELECT 
            ci.client_id,
            ci.client_name,
            ci.address_street_number,
            ci.address_street,
            ci.address_city,
            ci.address_postal_code,
            ci.address_country,
            ci.address_comment,
            ci.client_active,
            ci.phone,
            ci.email
        FROM view_clients_info ci
        WHERE ci.client_active = TRUE
        AND (ci.client_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ci.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ci.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ci.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ci.company_id = p_company_id
        LIMIT p_limit
        OFFSET p_offset;
    -- IF status is inactive
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT 
            ci.client_id,
            ci.client_name,
            ci.address_street_number,
            ci.address_street,
            ci.address_city,
            ci.address_postal_code,
            ci.address_country,
            ci.address_comment,
            ci.client_active,
            ci.phone,
            ci.email
        FROM view_clients_info ci
        WHERE ci.client_active = FALSE
        AND (ci.client_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ci.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ci.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ci.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ci.company_id = p_company_id
        LIMIT p_limit
        OFFSET p_offset;
    -- IF status is all
    ELSE
        SELECT 
            ci.client_id,
            ci.client_name,
            ci.address_street_number,
            ci.address_street,
            ci.address_city,
            ci.address_postal_code,
            ci.address_country,
            ci.address_comment,
            ci.client_active,
            ci.phone,
            ci.email
        FROM view_clients_info ci
        WHERE (ci.client_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ci.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ci.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ci.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ci.company_id = p_company_id
        LIMIT p_limit
        OFFSET p_offset;
    END IF;
END $$
DELIMITER ;

-- GET CLIENTS COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_clients_count(
    IN p_status VARCHAR(10),
    IN p_name VARCHAR(30),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_company_id INT
)
BEGIN
    -- IF status is active
    IF p_status = 'ACTIVE' THEN
        SELECT COUNT(*) AS total
        FROM view_clients_info ci
        WHERE ci.client_active = TRUE
        AND (ci.client_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ci.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ci.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ci.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ci.company_id = p_company_id;
    -- IF status is inactive
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT COUNT(*) AS total
        FROM view_clients_info ci
        WHERE ci.client_active = FALSE
        AND (ci.client_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ci.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ci.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ci.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ci.company_id = p_company_id;
    -- IF status is all
    ELSE
        SELECT COUNT(*) AS total
        FROM view_clients_info ci
        WHERE (ci.client_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ci.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ci.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ci.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ci.company_id = p_company_id;
    END IF;
END $$
DELIMITER ;

-- GET A CLIENT
DELIMITER $$
CREATE PROCEDURE sp_get_client(IN p_client_id INT)
BEGIN
    SELECT 
        ci.client_id,
        ci.client_name,
        ci.address_street_number,
        ci.address_street,
        ci.address_city,
        ci.address_postal_code,
        ci.address_country,
        ci.address_comment,
        ci.client_active,
        ci.phone,
        ci.email
    FROM view_clients_info ci
    WHERE ci.client_id = p_client_id;
END $$
DELIMITER ;

-- UPDATE A CLIENT
DELIMITER $$
CREATE PROCEDURE sp_update_client(
    IN p_client_id INT,
    IN p_client_name VARCHAR(30),
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_active BOOLEAN,
    IN p_phone VARCHAR(100),
    IN p_email VARCHAR(100)
)
BEGIN
    -- GET THE ADDRESS ID OF THE CLIENT
    SET @address_id = (SELECT client_address FROM clients WHERE client_id = p_client_id);

    CALL sp_update_address(@address_id, p_street_number, p_street, p_city, p_postal_code, p_country);

    UPDATE clients
    SET
        client_name = p_client_name,
        client_active = p_active
    WHERE
        client_id = p_client_id;

    CALL sp_update_phone('CLIENT', p_client_id, p_phone);
    CALL sp_update_email('CLIENT', p_client_id, p_email);
END $$
DELIMITER ;

-- DELETE A CLIENT
DELIMITER $$
CREATE PROCEDURE sp_delete_client(IN p_client_id INT)
BEGIN
    DECLARE existing_address_id INT;
    SELECT client_address INTO existing_address_id FROM clients WHERE client_id = p_client_id;

    DELETE FROM clients WHERE client_id = p_client_id;

    CALL sp_delete_address(existing_address_id);
    CALL sp_delete_phone('CLIENT', p_client_id);
    CALL sp_delete_email('CLIENT', p_client_id);
END $$
DELIMITER ;