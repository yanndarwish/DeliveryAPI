USE geostar;

-- CREATE A PICKUP (should be called on Delivery creation)
DELIMITER $$
CREATE PROCEDURE CreatePickup(
    IN p_delivery_id INT,
    IN p_client_id INT,
    IN p_pickup_date DATETIME
)
BEGIN
    INSERT INTO pickups (
        delivery_id,
        client_id,
        pickup_date
    )
    VALUES (
        p_delivery_id,
        p_client_id,
        p_pickup_date
    );
END $$
DELIMITER ;

-- CALL CreatePickup(1, 2, '2023-03-15 12:00:00');