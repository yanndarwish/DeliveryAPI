USE {DB_NAME};

-- CREATE A RELAY
DELIMITER $$ 
CREATE PROCEDURE sp_create_relay(
    IN p_relay_name VARCHAR(30),
    IN p_street_number VARCHAR(10),
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code VARCHAR(10),
    IN p_country VARCHAR(30),
    IN p_comment VARCHAR(100),
    IN p_active BOOLEAN,
    IN p_company_id INT
)
BEGIN
    DECLARE new_address_id INT;
    DECLARE new_relay_id INT;

    -- Insert into relays table
    INSERT INTO relays (
        relay_name,
        relay_active,
        company_id
    )
    VALUES (
        p_relay_name,
        p_active,
        p_company_id
    );

    SET new_relay_id = LAST_INSERT_ID();

    CALL sp_create_address(p_street_number, p_street, p_city, p_postal_code, p_country, p_comment, 'RELAY', new_relay_id);
END $$
DELIMITER ;

-- GET RELAYS
DELIMITER $$
CREATE PROCEDURE sp_get_relays(
    IN p_offset INT,
    IN p_limit INT,
    IN p_status VARCHAR(10),
    IN p_name VARCHAR(30),
    IN p_city VARCHAR(30),
    IN p_postal_code VARCHAR(10),
    IN p_country VARCHAR(30),
    IN p_company_id INT
)
BEGIN
    -- If status is active
    IF p_status = 'ACTIVE' THEN
        SELECT 
            ri.relay_id,
            ri.relay_name,
            ri.address_street_number,
            ri.address_street,
            ri.address_city,
            ri.address_postal_code,
            ri.address_country,
            ri.address_comment,
            ri.relay_active
        FROM view_relays_info ri
        WHERE ri.relay_active = TRUE
        AND (ri.relay_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ri.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ri.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ri.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ri.company_id = p_company_id
        LIMIT p_limit
        OFFSET p_offset;
    -- If status is inactive
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT 
            ri.relay_id,
            ri.relay_name,
            ri.address_street_number,
            ri.address_street,
            ri.address_city,
            ri.address_postal_code,
            ri.address_country,
            ri.address_comment,
            ri.relay_active
        FROM view_relays_info ri
        WHERE ri.relay_active = FALSE
        AND (ri.relay_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ri.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ri.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ri.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ri.company_id = p_company_id
        LIMIT p_limit
        OFFSET p_offset;
    -- If status is all
    ELSE
        SELECT 
            ri.relay_id,
            ri.relay_name,
            ri.address_street_number,
            ri.address_street,
            ri.address_city,
            ri.address_postal_code,
            ri.address_country,
            ri.address_comment,
            ri.relay_active
        FROM view_relays_info ri
        WHERE (ri.relay_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ri.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ri.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ri.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ri.company_id = p_company_id
        LIMIT p_limit
        OFFSET p_offset;
    END IF;
END $$
DELIMITER ;

-- GET RELAYS COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_relays_count(
    IN p_status VARCHAR(10),
    IN p_name VARCHAR(30),
    IN p_city VARCHAR(30),
    IN p_postal_code VARCHAR(10),
    IN p_country VARCHAR(30),
    IN p_company_id INT
)
BEGIN
    -- If status is active
    IF p_status = 'ACTIVE' THEN
        SELECT COUNT(*) AS total
        FROM view_relays_info ri
        WHERE ri.relay_active = TRUE
        AND (ri.relay_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ri.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ri.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ri.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ri.company_id = p_company_id;
    -- If status is inactive
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT COUNT(*) AS total
        FROM view_relays_info ri
        WHERE ri.relay_active = FALSE
        AND (ri.relay_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ri.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ri.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ri.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ri.company_id = p_company_id;
    -- If status is all
    ELSE
        SELECT COUNT(*) AS total
        FROM view_relays_info ri
        WHERE (ri.relay_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (ri.address_city LIKE CONCAT('%', p_city, '%') OR p_city IS NULL)
        AND (ri.address_postal_code LIKE CONCAT('%', p_postal_code, '%') OR p_postal_code IS NULL)
        AND (ri.address_country LIKE CONCAT('%', p_country, '%') OR p_country IS NULL)
        AND ri.company_id = p_company_id;
    END IF;
END $$
DELIMITER ;

-- GET A RELAY
DELIMITER $$
CREATE PROCEDURE sp_get_relay(IN p_relay_id INT, IN p_company_id INT)
BEGIN
    SELECT 
        ci.relay_id,
        ci.relay_name,
        ci.address_street_number,
        ci.address_street,
        ci.address_city,
        ci.address_postal_code,
        ci.address_country,
        ci.address_comment,
        ci.relay_active
    FROM view_relays_info ci
    WHERE ci.relay_id = p_relay_id
    AND ci.company_id = p_company_id;
END $$
DELIMITER ;

-- UPDATE A RELAY
DELIMITER $$
CREATE PROCEDURE sp_update_relay(
    IN p_relay_id INT,
    IN p_relay_name VARCHAR(30),
    IN p_street_number VARCHAR(10),
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code VARCHAR(10),
    IN p_country VARCHAR(30),
    IN p_comment VARCHAR(100),
    IN p_active BOOLEAN
)
BEGIN
    -- GET THE ADDRESS ID OF THE RELAY
    SET @address_id = (SELECT address_id FROM addresses WHERE entity_id = p_relay_id AND entity_type = 'RELAY');

    CALL sp_update_address(@address_id, p_street_number, p_street, p_city, p_postal_code, p_country, p_comment);

    UPDATE relays
    SET
        relay_name = p_relay_name,
        relay_active = p_active
    WHERE
        relay_id = p_relay_id;
END $$
DELIMITER ;

-- DELETE A RELAY
DELIMITER $$
CREATE PROCEDURE sp_delete_relay(IN p_relay_id INT)
BEGIN
    SET @address_id = (SELECT address_id FROM addresses WHERE entity_id = p_relay_id AND entity_type = 'RELAY');

    DELETE FROM relays WHERE relay_id = p_relay_id;

    CALL sp_delete_address(@address_id);
END $$
DELIMITER ;