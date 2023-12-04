USE geostar;

-- CREATE A PHONE
DELIMITER $$
CREATE PROCEDURE CreatePhone(
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