USE {DB_NAME};

-- CREATE A EMAIL
DELIMITER $$
CREATE PROCEDURE sp_create_email(
    IN p_entity_type VARCHAR(30),
    IN p_entity_id INT,
    IN p_email VARCHAR(30)
)
BEGIN
    INSERT INTO emails (
        entity_type,
        entity_id,
        email
    )
    VALUES (
        p_entity_type,
        p_entity_id,
        p_email
    );
END $$
DELIMITER ;

-- UPDATE EMAIL
DELIMITER $$
CREATE PROCEDURE sp_update_email(
    IN p_entity_type VARCHAR(30),
    IN p_entity_id INT,
    IN p_email VARCHAR(30)
)
BEGIN
    UPDATE emails
    SET
        email = p_email
    WHERE
        entity_type = p_entity_type AND entity_id = p_entity_id;
END $$
DELIMITER ;

-- DELETE A EMAIL
DELIMITER $$
CREATE PROCEDURE sp_delete_email(
    IN p_entity_type VARCHAR(30),
    IN p_entity_id INT
)
BEGIN
    DELETE FROM emails WHERE entity_type = p_entity_type AND entity_id = p_entity_id;
END $$
DELIMITER ;