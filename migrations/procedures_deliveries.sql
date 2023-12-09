USE geostar;

-- CREATE A DELIVERY
DELIMITER $$
CREATE PROCEDURE sp_create_delivery(
    IN p_company_id INT,
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    IN p_provider_id INT,
    IN p_hotel_price INT,
    IN p_pickup_clients JSON,
    IN p_dropoff_clients JSON,
    IN p_outsourced_to INT
)
BEGIN
    DECLARE last_delivery_id INT;
    DECLARE pickup_client_id INT;
    DECLARE pickup_date DATETIME;
    DECLARE dropoff_client_id INT;
    DECLARE dropoff_date DATETIME;
    DECLARE outsourced_delivery_id INT;

    INSERT INTO deliveries (
        company_id,
        delivery_driver,
        delivery_vehicle,
        delivery_provider,
        delivery_hotel_price,
        delivery_outsourced_to
    )
    VALUES (
        p_company_id,
        p_driver_id,
        p_vehicle_id,
        p_provider_id,
        p_hotel_price,
        p_outsourced_to
    );

    SET last_delivery_id = LAST_INSERT_ID();
    SET outsourced_delivery_id = NULL;

    -- if outsourced, insert into deliveries with the company id as the provider
    IF p_outsourced_to IS NOT NULL THEN
        INSERT INTO deliveries (
            company_id,
            delivery_driver,
            delivery_vehicle,
            delivery_provider,
            delivery_hotel_price,
            delivery_outsourced_to
        )
        VALUES (
            p_outsourced_to,
            p_driver_id,
            p_vehicle_id,
            p_company_id,
            p_hotel_price,
            NULL
        );

        SET outsourced_delivery_id = LAST_INSERT_ID();
    END IF;

    SET @i = 0;
    SET @n = JSON_LENGTH(JSON_UNQUOTE(p_pickup_clients)); 

    WHILE @i < @n DO
        SET pickup_client_id = JSON_EXTRACT(p_pickup_clients, CONCAT('$[', @i, '].client_id'));
        SET pickup_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_pickup_clients, CONCAT('$[', @i, '].pickup_date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL sp_create_pickup(last_delivery_id, pickup_client_id, pickup_date);

        IF outsourced_delivery_id IS NOT NULL THEN
            CALL sp_create_pickup(outsourced_delivery_id, pickup_client_id, pickup_date);
        END IF;

        SET @i = @i + 1;
    END WHILE;

    SET @i = 0;
    SET @n = JSON_LENGTH(p_dropoff_clients);

    WHILE @i < @n DO
        SET dropoff_client_id = JSON_EXTRACT(p_dropoff_clients, CONCAT('$[', @i, '].client_id'));
        SET dropoff_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_dropoff_clients, CONCAT('$[', @i, '].dropoff_date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL sp_create_dropoff(last_delivery_id, dropoff_client_id, dropoff_date);

        IF outsourced_delivery_id IS NOT NULL THEN
            CALL sp_create_dropoff(outsourced_delivery_id, dropoff_client_id, dropoff_date);
        END IF;

        SET @i = @i + 1;
    END WHILE;
END $$
DELIMITER ;

-- GET DELIVERIES
DELIMITER $$
CREATE PROCEDURE sp_get_deliveries(IN p_offset INT, IN p_limit INT)
BEGIN
    SELECT
        delivery_id,
        delivery_driver,
        delivery_vehicle,
        delivery_provider,
        delivery_hotel_price,
        delivery_outsourced_to,
        pickups,
        dropoffs,
        company_id
    FROM view_deliveries_info
    LIMIT p_limit 
    OFFSET p_offset;
END $$
DELIMITER ;

-- GET DELIVERY
DELIMITER $$
CREATE PROCEDURE sp_get_delivery_by_id(IN p_delivery_id INT)
BEGIN
    SELECT
        delivery_id,
        delivery_driver,
        delivery_vehicle,
        delivery_provider,
        delivery_hotel_price,
        delivery_outsourced_to,
        pickups,
        dropoffs,
        company_id
    FROM view_deliveries_info WHERE delivery_id = p_delivery_id;
END $$
DELIMITER ;

-- UPDATE A DELIVERY (necessary ?)
DELIMITER $$
CREATE PROCEDURE sp_update_delivery(
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
CREATE PROCEDURE sp_delete_delivery(IN p_delivery_id INT)
BEGIN
    DELETE FROM deliveries WHERE delivery_id = p_delivery_id;
END $$
DELIMITER ;