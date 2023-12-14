USE geostar;

-- CREATE A DROPOFF (should be called on Delivery creation)
DELIMITER $$
CREATE PROCEDURE sp_create_dropoff(
    IN p_company_id INT,
    IN p_delivery_id INT,
    IN p_entity_id INT,
    IN p_entity_type VARCHAR(10),
    IN p_dropoff_date DATETIME
)
BEGIN
    INSERT INTO dropoffs (
        company_id,
        delivery_id,
        entity_id,
        entity_type,
        dropoff_date
    )
    VALUES (
        p_company_id,
        p_delivery_id,
        p_entity_id,
        p_entity_type,
        p_dropoff_date
    );
END $$
DELIMITER ;

-- CALL sp_create_dropoff(1, 2, '2023-03-15 12:00:00');
