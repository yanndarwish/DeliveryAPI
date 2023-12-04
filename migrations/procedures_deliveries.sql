USE geostar;

-- CREATE A DELIVERY
DELIMITER $$
CREATE PROCEDURE CreateDelivery(
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    IN p_provider_id INT,
    IN p_hotel_price INT,
    IN p_pickup_clients JSON,
    IN p_dropoff_clients JSON
)
BEGIN
    DECLARE last_delivery_id INT;
    DECLARE pickup_client_id INT;
    DECLARE pickup_date DATETIME;
    DECLARE dropoff_client_id INT;
    DECLARE dropoff_date DATETIME;

    INSERT INTO deliveries (
        delivery_driver,
        delivery_vehicle,
        delivery_provider,
        delivery_hotel_price
    )
    VALUES (
        p_driver_id,
        p_vehicle_id,
        p_provider_id,
        p_hotel_price
    );

    SET last_delivery_id = LAST_INSERT_ID();
    SET @i = 0;
    SET @n = JSON_LENGTH(JSON_UNQUOTE(p_pickup_clients)); 

    WHILE @i < @n DO
        SET pickup_client_id = JSON_EXTRACT(p_pickup_clients, CONCAT('$[', @i, '].client_id'));
        SET pickup_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_pickup_clients, CONCAT('$[', @i, '].pickup_date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL CreatePickup(last_delivery_id, pickup_client_id, pickup_date);
        SET @i = @i + 1;
    END WHILE;

    SET @i = 0;
    SET @n = JSON_LENGTH(p_dropoff_clients);

    WHILE @i < @n DO
        SET dropoff_client_id = JSON_EXTRACT(p_dropoff_clients, CONCAT('$[', @i, '].client_id'));
        SET dropoff_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_dropoff_clients, CONCAT('$[', @i, '].dropoff_date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL CreateDropoff(last_delivery_id, dropoff_client_id, dropoff_date);
        SET @i = @i + 1;
    END WHILE;
END $$
DELIMITER ;

-- GET DELIVERIES
DELIMITER $$
CREATE PROCEDURE GetDeliveries()
BEGIN
    SELECT * FROM deliveries_info;
END $$
DELIMITER ;

-- GET DELIVERY
DELIMITER $$
CREATE PROCEDURE GetDelivery(IN p_delivery_id INT)
BEGIN
    SELECT * FROM deliveries_info WHERE delivery_id = p_delivery_id;
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