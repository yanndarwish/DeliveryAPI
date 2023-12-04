USE geostar;

-- CREATE A CLIENT
DELIMITER $$ 
CREATE PROCEDURE CreateClient(
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

    -- Insert into addresses table
    INSERT INTO addresses (
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country
    )
    VALUES (
        p_street_number,
        p_street,
        p_city,
        p_postal_code,
        p_country
    );

    -- Get the last inserted address_id
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

    -- Get the last inserted client_id
    SET new_client_id = LAST_INSERT_ID();

    -- Insert into phones table
    INSERT INTO phones (
        entity_type,
        entity_id,
        phone
    )
    VALUES (
        'CLIENT',
        new_client_id,
        p_phone
    );

    -- Insert into emails table
    INSERT INTO emails (
        entity_type,
        entity_id,
        email
    )
    VALUES (
        'CLIENT',
        new_client_id,
        p_email
    );
END $$
DELIMITER ;

-- GET CLIENTS
DELIMITER $$
CREATE PROCEDURE GetClients()
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
CREATE PROCEDURE GetClient(IN p_client_id INT)
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
CREATE PROCEDURE UpdateClient(
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
    -- Update the addresses table
    UPDATE addresses
    SET
        address_street_number = p_street_number,
        address_street = p_street,
        address_city = p_city,
        address_postal_code = p_postal_code,
        address_country = p_country
    WHERE
        address_id = (SELECT client_address FROM clients WHERE client_id = p_client_id);

    -- Update the clients table
    UPDATE clients
    SET
        client_name = p_client_name,
        client_active = p_active
    WHERE
        client_id = p_client_id;

    -- Update the phones table
    UPDATE phones
    SET
        phone = p_phone
    WHERE
        entity_type = 'CLIENT' AND entity_id = p_client_id;

    -- Update the emails table
    UPDATE emails
    SET
        email = p_email
    WHERE
        entity_type = 'CLIENT' AND entity_id = p_client_id;
END $$
DELIMITER ;

-- DELETE A CLIENT
DELIMITER $$
CREATE PROCEDURE DeleteClient(IN p_client_id INT)
BEGIN
    -- Get the existing address_id
    DECLARE existing_address_id INT;
    SELECT client_address INTO existing_address_id FROM clients WHERE client_id = p_client_id;

    -- Delete from clients table
    DELETE FROM clients WHERE client_id = p_client_id;

    -- Delete from addresses table
    DELETE FROM addresses WHERE address_id = existing_address_id;

    -- Delete from phones table
    DELETE FROM phones WHERE entity_type = 'CLIENT' AND entity_id = p_client_id;

    -- Delete from emails table
    DELETE FROM emails WHERE entity_type = 'CLIENT' AND entity_id = p_client_id;
END $$
DELIMITER ;