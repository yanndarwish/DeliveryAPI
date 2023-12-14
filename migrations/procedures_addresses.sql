USE geostar;

-- CREATE AN ADDRESS
DELIMITER $$ 
CREATE PROCEDURE sp_create_address(
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_comment VARCHAR(100),
    IN p_entity_type VARCHAR(10),
    IN p_entity_id INT
)
BEGIN
    INSERT INTO addresses (
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        entity_type,
        entity_id,
        address_comment
    )
    VALUES (
        p_street_number,
        p_street,
        p_city,
        p_postal_code,
        p_country,
        p_entity_type,
        p_entity_id,
        p_comment
    );
END $$
DELIMITER ;

-- GET ADDRESSES
DELIMITER $$
CREATE PROCEDURE sp_get_addresses(
    IN p_offset INT,
    IN p_limit INT
)
BEGIN
    SELECT 
        address_id,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        address_comment,
        entity_type,
        entity_id
    FROM addresses
    LIMIT p_limit
    OFFSET p_offset;
END $$
DELIMITER ;

-- GET AN ADDRESS
DELIMITER $$
CREATE PROCEDURE sp_get_address_by_id(IN p_address_id INT)
BEGIN
    SELECT 
        address_id,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        address_comment,
        entity_type,
        entity_id
    FROM addresses
    WHERE address_id = p_address_id;
END $$
DELIMITER ;

-- GET ADDRESSES BY ENTITY
DELIMITER $$
CREATE PROCEDURE sp_get_addresses_by_entity(
    IN p_entity_type VARCHAR(10),
    IN p_entity_id INT
)
BEGIN
    SELECT 
        address_id,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        address_comment,
        entity_type,
        entity_id
    FROM addresses
    WHERE entity_type = p_entity_type
    AND entity_id = p_entity_id;
END $$
DELIMITER ;

-- UPDATE AN ADDRESS
DELIMITER $$
CREATE PROCEDURE sp_update_address(
    IN p_address_id INT,
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_comment VARCHAR(100)
)
BEGIN
    UPDATE addresses
    SET
        address_street_number = p_street_number,
        address_street = p_street,
        address_city = p_city,
        address_postal_code = p_postal_code,
        address_country = p_country,
        address_comment = p_comment
    WHERE
        address_id = p_address_id;
END $$
DELIMITER ;

-- DELETE AN ADDRESS
DELIMITER $$
CREATE PROCEDURE sp_delete_address(IN p_address_id INT)
BEGIN
    DELETE FROM addresses WHERE address_id = p_address_id;
END $$
DELIMITER ;
