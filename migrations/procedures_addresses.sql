USE geostar;

-- CREATE AN ADDRESS
DELIMITER $$ 
CREATE PROCEDURE CreateAddress(
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_comment TEXT
)
BEGIN
    INSERT INTO addresses (
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        address_comment
    )
    VALUES (
        p_street_number,
        p_street,
        p_city,
        p_postal_code,
        p_country,
        p_comment
    );
END $$
DELIMITER ;

-- GET ADDRESSES
DELIMITER $$
CREATE PROCEDURE GetAddresses()
BEGIN
    SELECT * FROM addresses;
END $$
DELIMITER ;

-- GET AN ADDRESS
DELIMITER $$
CREATE PROCEDURE GetAddress(IN p_address_id INT)
BEGIN
    SELECT * FROM addresses WHERE address_id = p_address_id;
END $$
DELIMITER ;

-- UPDATE AN ADDRESS
DELIMITER $$
CREATE PROCEDURE UpdateAddress(
    IN p_address_id INT,
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_comment TEXT
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
CREATE PROCEDURE DeleteAddress(IN p_address_id INT)
BEGIN
    DELETE FROM addresses WHERE address_id = p_address_id;
END $$
DELIMITER ;
