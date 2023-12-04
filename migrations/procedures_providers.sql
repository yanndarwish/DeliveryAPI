USE geostar;

-- CREATE A PROVIDER
DELIMITER $$ 
CREATE PROCEDURE CreateProvider(
    IN p_name VARCHAR(50),
    IN p_contact_name VARCHAR(40),
    IN p_active BOOLEAN,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100),
    IN p_headquarter_street_number INT,
    IN p_headquarter_street VARCHAR(100),
    IN p_headquarter_city VARCHAR(30),
    IN p_headquarter_postal_code INT,
    IN p_headquarter_country VARCHAR(30),
    IN p_warehouse_street_number INT,
    IN p_warehouse_street VARCHAR(100),
    IN p_warehouse_city VARCHAR(30),
    IN p_warehouse_postal_code INT,
    IN p_warehouse_country VARCHAR(30)
)
BEGIN
    DECLARE new_provider_id INT;
    DECLARE new_headquarter_id INT;
    DECLARE new_warehouse_id INT;

    -- Insert into addresses table for headquarter
    INSERT INTO addresses (
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country
    )
    VALUES (
        p_headquarter_street_number,
        p_headquarter_street,
        p_headquarter_city,
        p_headquarter_postal_code,
        p_headquarter_country
    );

    -- Get the last inserted headquarter_id
    SET new_headquarter_id = LAST_INSERT_ID();

    -- Insert into addresses table for warehouse
    INSERT INTO addresses (
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country
    )
    VALUES (
        p_warehouse_street_number,
        p_warehouse_street,
        p_warehouse_city,
        p_warehouse_postal_code,
        p_warehouse_country
    );

    -- Get the last inserted warehouse_id
    SET new_warehouse_id = LAST_INSERT_ID();

    -- Insert into providers table
    INSERT INTO providers (
        provider_name,
        provider_contact_name,
        provider_headquarter,
        provider_warehouse,
        provider_active
    )
    VALUES (
        p_name,
        p_contact_name,
        new_headquarter_id,
        new_warehouse_id,
        p_active
    );

    -- Get the last inserted provider_id
    SET new_provider_id = LAST_INSERT_ID();

    -- Insert into emails table
    INSERT INTO emails (
        entity_type,
        entity_id,
        email
    )
    VALUES (
        'PROVIDER',
        new_provider_id,
        p_email
    );

    -- Insert into phones table
    INSERT INTO phones (
        entity_type,
        entity_id,
        phone
    )
    VALUES (
        'PROVIDER',
        new_provider_id,
        p_phone
    );
END $$
DELIMITER ;

-- GET PROVIDERS
DELIMITER $$
CREATE PROCEDURE GetProviders()
BEGIN
    SELECT 
        pi.provider_id,
        pi.provider_name,
        pi.provider_contact_name,
        pi.provider_active,
        pi.email,
        pi.phone,
        pi.headquarter_address_id,
        pi.headquarter_street_number,
        pi.headquarter_street,
        pi.headquarter_city,
        pi.headquarter_postal_code,
        pi.headquarter_country,
        pi.warehouse_address_id,
        pi.warehouse_street_number,
        pi.warehouse_street,
        pi.warehouse_city,
        pi.warehouse_postal_code,
        pi.warehouse_country
    FROM provider_info pi;
END $$
DELIMITER ;

-- GET A PROVIDER
DELIMITER $$
CREATE PROCEDURE GetProvider(IN p_provider_id INT)
BEGIN
    SELECT 
        pi.provider_id,
        pi.provider_name,
        pi.provider_contact_name,
        pi.provider_active,
        pi.email,
        pi.phone,
        pi.headquarter_address_id,
        pi.headquarter_street_number,
        pi.headquarter_street,
        pi.headquarter_city,
        pi.headquarter_postal_code,
        pi.headquarter_country,
        pi.warehouse_address_id,
        pi.warehouse_street_number,
        pi.warehouse_street,
        pi.warehouse_city,
        pi.warehouse_postal_code,
        pi.warehouse_country
    FROM provider_info pi
    WHERE pi.provider_id = p_provider_id;
END $$
DELIMITER ;

-- UPDATE A PROVIDER
DELIMITER $$
CREATE PROCEDURE UpdateProvider(
    IN p_provider_id INT,
    IN p_name VARCHAR(50),
    IN p_contact_name VARCHAR(40),
    IN p_active BOOLEAN,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(100),
    IN p_headquarter_street_number INT,
    IN p_headquarter_street VARCHAR(100),
    IN p_headquarter_city VARCHAR(30),
    IN p_headquarter_postal_code INT,
    IN p_headquarter_country VARCHAR(30),
    IN p_warehouse_street_number INT,
    IN p_warehouse_street VARCHAR(100),
    IN p_warehouse_city VARCHAR(30),
    IN p_warehouse_postal_code INT,
    IN p_warehouse_country VARCHAR(30)
)
BEGIN
    -- Update the addresses table for headquarter
    UPDATE addresses
    SET
        address_street_number = p_headquarter_street_number,
        address_street = p_headquarter_street,
        address_city = p_headquarter_city,
        address_postal_code = p_headquarter_postal_code,
        address_country = p_headquarter_country
    WHERE
        address_id = (SELECT provider_headquarter FROM providers WHERE provider_id = p_provider_id);

    -- Update the addresses table for warehouse
    UPDATE addresses
    SET
        address_street_number = p_warehouse_street_number,
        address_street = p_warehouse_street,
        address_city = p_warehouse_city,
        address_postal_code = p_warehouse_postal_code,
        address_country = p_warehouse_country
    WHERE
        address_id = (SELECT provider_warehouse FROM providers WHERE provider_id = p_provider_id);

    -- Update the providers table
    UPDATE providers
    SET
        provider_name = p_name,
        provider_contact_name = p_contact_name,
        provider_active = p_active
    WHERE
        provider_id = p_provider_id;

    -- Update the emails table
    UPDATE emails
    SET
        email = p_email
    WHERE
        entity_type = 'PROVIDER' AND entity_id = p_provider_id;

    -- Update the phones table
    UPDATE phones
    SET
        phone = p_phone
    WHERE
        entity_type = 'PROVIDER' AND entity_id = p_provider_id;
END $$
DELIMITER ;

-- DELETE A PROVIDER
DELIMITER $$
CREATE PROCEDURE DeleteProvider(IN p_provider_id INT)
BEGIN
    -- Get the existing headquarter and warehouse addresses
    DECLARE existing_headquarter_id INT;
    DECLARE existing_warehouse_id INT;
    SELECT provider_headquarter, provider_warehouse INTO existing_headquarter_id, existing_warehouse_id FROM providers WHERE provider_id = p_provider_id;

    -- Delete from providers table
    DELETE FROM providers WHERE provider_id = p_provider_id;

    -- Delete from addresses table for headquarter
    DELETE FROM addresses WHERE address_id = existing_headquarter_id;

    -- Delete from addresses table for warehouse
    DELETE FROM addresses WHERE address_id = existing_warehouse_id;

    -- Delete from emails table
    DELETE FROM emails WHERE entity_type = 'PROVIDER' AND entity_id = p_provider_id;

    -- Delete from phones table
    DELETE FROM phones WHERE entity_type = 'PROVIDER' AND entity_id = p_provider_id;
END $$
DELIMITER ;
