USE {DB_NAME};

-- CREATE A PHONE
DELIMITER $$
CREATE PROCEDURE sp_create_phone(
    IN p_entity_type VARCHAR(30),
    IN p_entity_id INT,
    IN p_phone VARCHAR(30)
)
BEGIN
    INSERT INTO phones (
        entity_type,
        entity_id,
        phone
    )
    VALUES (
        p_entity_type,
        p_entity_id,
        p_phone
    );
END $$
DELIMITER ;

-- UPDATE PHONE
DELIMITER $$
CREATE PROCEDURE sp_update_phone(
    IN p_entity_type VARCHAR(30),
    IN p_phone_id INT,
    IN p_phone VARCHAR(30)
)
BEGIN
    UPDATE phones
    SET
        phone = p_phone
    WHERE
        entity_type = p_entity_type AND phone_id = p_phone_id;
END $$
DELIMITER ;

-- DELETE A PHONE
DELIMITER $$
CREATE PROCEDURE sp_delete_phone(
    IN p_entity_type VARCHAR(30),
    IN p_phone_id INT
)
BEGIN
    DELETE FROM phones WHERE entity_type = p_entity_type AND phone_id = p_phone_id;
END $$
DELIMITER ;