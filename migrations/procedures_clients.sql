-- CREATE A CLIENT
DELIMITER $$ 
CREATE PROCEDURE CreateClient(
    IN p_client_name VARCHAR(30),
    IN p_street_number INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(30),
    IN p_postal_code INT,
    IN p_country VARCHAR(30),
    IN p_active BOOLEAN
)
BEGIN
    INSERT INTO clients (
        client_name,
        client_street_number,
        client_street,
        client_city,
        client_postal_code,
        client_country,
        client_active
    )
    VALUES (
        p_client_name,
        p_street_number,
        p_street,
        p_city,
        p_postal_code,
        p_country,
        p_active
    );
END $$
DELIMITER ;

-- GET CLIENTS
DELIMITER $$
CREATE PROCEDURE GetClients()
BEGIN
    SELECT * FROM clients;
END $$
DELIMITER ;

-- GET A CLIENT
DELIMITER $$
CREATE PROCEDURE GetClient(IN p_client_id INT)
BEGIN
    SELECT * FROM clients WHERE client_id = p_client_id;
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
    IN p_active BOOLEAN
)
BEGIN
    UPDATE clients
    SET
        client_name = p_client_name,
        client_street_number = p_street_number,
        client_street = p_street,
        client_city = p_city,
        client_postal_code = p_postal_code,
        client_country = p_country,
        client_active = p_active
    WHERE
        client_id = p_client_id;
END $$
DELIMITER ;

-- DELETE A CLIENT
DELIMITER $$
CREATE PROCEDURE DeleteClient(IN p_client_id INT)
BEGIN
    DELETE FROM clients WHERE client_id = p_client_id;
END $$
DELIMITER ;


-- CALL CreateClient('John Doe', 123, 'Main St', 'City', 12345, 'Country', true);
-- CALL GetClients();
-- CALL GetClient(1);
-- CALL UpdateClient(1, 'Updated Name', 456, 'Updated St', 'Updated City', 54321, 'Updated Country', false);
-- CALL DeleteClient(2);
