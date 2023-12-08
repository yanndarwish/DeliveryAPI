USE geostar;

-- CREATE A EMAIL
DELIMITER $$
CREATE PROCEDURE CreateEmail(
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