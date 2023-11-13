-- CREATE A DELIVERY
DELIMITER $$
CREATE PROCEDURE CreateDelivery(
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    IN p_provider_id INT,
    IN p_hotel INT,
    IN p_pickup_client_ids JSON, -- Assuming p_pickup_client_ids is a JSON array of integers
    IN p_pickup_date DATETIME
)
BEGIN
    DECLARE last_delivery_id INT;
    DECLARE pickup_client_id INT;

    INSERT INTO deliveries (
        delivery_driver,
        delivery_vehicle,
        delivery_provider,
        delivery_hotel
    )
    VALUES (
        p_driver_id,
        p_vehicle_id,
        p_provider_id,
        p_hotel
    );

    SET last_delivery_id = LAST_INSERT_ID();

    -- Loop through the ids array
    SET pickup_client_id = JSON_UNQUOTE(JSON_EXTRACT(p_pickup_client_ids, '$[0]'));

    WHILE NOT pickup_client_id IS NULL DO
        -- Call the CREATEPICKUP procedure
        CALL CreatePickup(last_delivery_id, pickup_client_id, p_pickup_date);

        -- Move to the next element in the array
        SET p_pickup_client_ids = JSON_REMOVE(p_pickup_client_ids, '$[0]');
        SET pickup_client_id = JSON_UNQUOTE(JSON_EXTRACT(p_pickup_client_ids, '$[0]'));
    END WHILE;
END $$
DELIMITER ;

-- GET DELIVERIES
DELIMITER $$
CREATE PROCEDURE GetDeliveries()
BEGIN
    SELECT * FROM deliveries_view;
END $$
DELIMITER ;

-- GET DELIVERY
DELIMITER $$
CREATE PROCEDURE GetDelivery(IN p_delivery_id INT)
BEGIN
    SELECT * FROM deliveries_view WHERE delivery_id = p_delivery_id;
END $$
DELIMITER ;

-- UPDATE A DELIVERY (necessary ?)
DELIMITER $$
CREATE PROCEDURE UpdateDelivery(
    IN p_delivery_id INT,
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    IN p_provider_id INT,
    IN p_hotel INT
)
BEGIN
    UPDATE deliveries
    SET
        delivery_driver = p_driver_id,
        delivery_vehicle = p_vehicle_id,
        delivery_provider = p_provider_id,
        delivery_hotel = p_hotel
    WHERE delivery_id = p_delivery_id;
END $$
DELIMITER ;

-- DELETE A DELIVERY
DELIMITER $$
CREATE PROCEDURE DeleteDelivery(IN p_delivery_id INT)
BEGIN
    DELETE FROM deliveries WHERE delivery_id = p_delivery_id;
END $$
DELIMITER ;

-- CALL CreateDelivery(1, 2, 3, 0, '1, 2, 3', '2023-11-10 12:00:00');
-- CALL GetDeliveries();
-- CALL GetDelivery(1);
-- CALL UpdateDelivery(1, 2, 3, 4, 1);
-- CALL DeleteDelivery(1);