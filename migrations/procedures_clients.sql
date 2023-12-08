USE geostar;

-- CREATE A CLIENT
DELIMITER $$ 
CREATE PROCEDURE sp_create_client(
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
    DECLARE new_address_id INT;
    DECLARE new_client_id INT;

    CALL sp_create_address(p_street_number, p_street, p_city, p_postal_code, p_country);

    SET new_address_id = LAST_INSERT_ID();

    -- Insert into clients table
    INSERT INTO clients (
        client_name,
        client_address,
        client_active
    )
    VALUES (
        p_client_name,
        new_address_id,
        p_active
    );

    SET new_client_id = LAST_INSERT_ID();

    CALL sp_create_phone('CLIENT', new_client_id, p_phone);
    CALL sp_create_email('CLIENT', new_client_id, p_email);
END $$
DELIMITER ;

-- GET CLIENTS
DELIMITER $$
CREATE PROCEDURE sp_get_clients()
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
    FROM clients_info ci;
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
    FROM clients_info ci
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