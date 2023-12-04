USE geostar;

-- CREATE A DROPOFF (should be called on Delivery creation)
DELIMITER $$
CREATE PROCEDURE CreateDropoff(
    IN p_delivery_id INT,
    IN p_client_id INT,
    IN p_dropoff_date DATETIME
)
BEGIN
    INSERT INTO dropoffs (
        delivery_id,
        client_id,
        dropoff_date
    )
    VALUES (
        p_delivery_id,
        p_client_id,
        p_dropoff_date
    );
END $$
DELIMITER ;

-- CALL CreateDropoff(1, 2, '2023-03-15 12:00:00');
