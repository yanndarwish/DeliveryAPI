USE geostar;

-- CREATE A RELAY
DELIMITER $$ 
CREATE PROCEDURE sp_create_relay(
    IN p_relay_name VARCHAR(30),
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
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

    CALL sp_create_address(p_street_number, p_street, p_city, p_postal_code, p_country, 'some comment', 'RELAY', new_relay_id);
END $$
DELIMITER ;

-- GET RELAYS
DELIMITER $$
CREATE PROCEDURE sp_get_relays(IN p_offset INT, IN p_limit INT)
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
    LIMIT p_limit 
    OFFSET p_offset;
END $$
DELIMITER ;

-- GET A RELAY
DELIMITER $$
CREATE PROCEDURE sp_get_relay(IN p_relay_id INT)
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
    FROM relays_info ci
    WHERE ci.relay_id = p_relay_id;
END $$
DELIMITER ;

-- UPDATE A RELAY
DELIMITER $$
CREATE PROCEDURE sp_update_relay(
    IN p_relay_id INT,
    IN p_relay_name VARCHAR(30),
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_active BOOLEAN
)
BEGIN
    -- GET THE ADDRESS ID OF THE RELAY
    SET @address_id = (SELECT relay_address FROM relays WHERE relay_id = p_relay_id);

    CALL sp_update_address(@address_id, p_street_number, p_street, p_city, p_postal_code, p_country);

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
    DECLARE existing_address_id INT;
    SELECT relay_address INTO existing_address_id FROM relays WHERE relay_id = p_relay_id;

    DELETE FROM relays WHERE relay_id = p_relay_id;

    CALL sp_delete_address(existing_address_id);
END $$
DELIMITER ;