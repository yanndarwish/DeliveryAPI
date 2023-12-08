USE geostar;

-- CREATE AN ADDRESS
DELIMITER $$ 
CREATE PROCEDURE sp_create_address(
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30)
)
BEGIN
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
END $$
DELIMITER ;

-- GET ADDRESSES
DELIMITER $$
CREATE PROCEDURE sp_get_addresses()
BEGIN
    SELECT * FROM addresses;
END $$
DELIMITER ;

-- GET AN ADDRESS
DELIMITER $$
CREATE PROCEDURE sp_get_address(IN p_address_id INT)
BEGIN
    SELECT * FROM addresses WHERE address_id = p_address_id;
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
    IN p_country VARCHAR(30)
)
BEGIN
    UPDATE addresses
    SET
        address_street_number = p_street_number,
        address_street = p_street,
        address_city = p_city,
        address_postal_code = p_postal_code,
        address_country = p_country
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
