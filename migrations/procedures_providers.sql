-- CREATE A PROVIDER
DELIMITER $$
CREATE PROCEDURE CreateProvider(
    IN p_name VARCHAR(50),
    IN p_headquarter VARCHAR(150),
    IN p_warehouse VARCHAR(150),
    IN p_contact_name VARCHAR(40),
    IN p_contact_phone VARCHAR(15),
    IN p_contact_email VARCHAR(50),
    IN p_active BOOLEAN
)
BEGIN
    INSERT INTO providers (
        provider_name,
        provider_headquarter,
        provider_warehouse,
        provider_contact_name,
        provider_contact_phone,
        provider_contact_email,
        provider_active
    )
    VALUES (
        p_name,
        p_headquarter,
        p_warehouse,
        p_contact_name,
        p_contact_phone,
        p_contact_email,
        p_active
    );
END $$
DELIMITER ;

-- GET PROVIDERS
DELIMITER $$
CREATE PROCEDURE GetProviders()
BEGIN
    SELECT * FROM providers;
END $$
DELIMITER ;

-- GET A PROVIDER
DELIMITER $$
CREATE PROCEDURE GetProvider(IN p_provider_id INT)
BEGIN
    SELECT * FROM providers WHERE provider_id = p_provider_id;
END $$
DELIMITER ;

-- UPDATE A PROVIDER
DELIMITER $$
CREATE PROCEDURE UpdateProvider(
    IN p_provider_id INT,
    IN p_name VARCHAR(50),
    IN p_headquarter VARCHAR(150),
    IN p_warehouse VARCHAR(150),
    IN p_contact_name VARCHAR(40),
    IN p_contact_phone VARCHAR(15),
    IN p_contact_email VARCHAR(50),
    IN p_active BOOLEAN
)
BEGIN
    UPDATE providers
    SET
        provider_name = p_name,
        provider_headquarter = p_headquarter,
        provider_warehouse = p_warehouse,
        provider_contact_name = p_contact_name,
        provider_contact_phone = p_contact_phone,
        provider_contact_email = p_contact_email,
        provider_active = p_active
    WHERE
        provider_id = p_provider_id;
END $$
DELIMITER ;

-- DELETE A PROVIDER
DELIMITER $$
CREATE PROCEDURE DeleteProvider(IN p_provider_id INT)
BEGIN
    DELETE FROM providers WHERE provider_id = p_provider_id;
END $$
DELIMITER ;

-- CALL CreateProvider('Example Provider', 'HQ Location', 'Warehouse Location', 'Contact Name', '123456789', 'contact@example.com', true);
-- CALL GetProviders();
-- CALL GetProvider(1);
-- CALL UpdateProvider(1, 'Updated Provider Name', 'Updated HQ Location', 'Updated Warehouse Location', 'Updated Contact Name', '987654321', 'updated.contact@example.com', false);
-- CALL DeleteProvider(2);
