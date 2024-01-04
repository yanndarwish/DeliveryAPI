USE {DB_NAME};

-- CREATE A DELIVERY
DELIMITER $$
CREATE PROCEDURE sp_create_delivery(
    IN p_company_id INT,
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    IN p_provider_id INT,
    IN p_hotel_price INT,
    IN p_pickups JSON,
    IN p_dropoffs JSON,
    IN p_outsourced_to INT
)
BEGIN
    DECLARE last_delivery_id INT;
    DECLARE pickup_client_id INT;
    DECLARE pickup_date DATETIME;
    DECLARE dropoff_client_id INT;
    DECLARE dropoff_date DATETIME;
    DECLARE outsourced_delivery_id INT;
    DECLARE pickup_type VARCHAR(10);
    DECLARE dropoff_type VARCHAR(10);

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
    SET @n = JSON_LENGTH(JSON_UNQUOTE(p_pickups)); 

    WHILE @i < @n DO
        SET pickup_type = JSON_UNQUOTE(JSON_EXTRACT(p_pickups, CONCAT('$[', @i, '].entity_type')));
        SET pickup_client_id = JSON_EXTRACT(p_pickups, CONCAT('$[', @i, '].entity_id'));
        SET pickup_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_pickups, CONCAT('$[', @i, '].date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL sp_create_pickup(p_company_id, last_delivery_id, pickup_client_id, pickup_type, pickup_date);

        IF outsourced_delivery_id IS NOT NULL THEN
            CALL sp_create_pickup(p_outsourced_to, outsourced_delivery_id, pickup_client_id, pickup_type, pickup_date);
        END IF;

        SET @i = @i + 1;
    END WHILE;

    SET @i = 0;
    SET @n = JSON_LENGTH(p_dropoffs);

    WHILE @i < @n DO
        SET dropoff_type = JSON_UNQUOTE(JSON_EXTRACT(p_dropoffs, CONCAT('$[', @i, '].entity_type')));
        SET dropoff_client_id = JSON_EXTRACT(p_dropoffs, CONCAT('$[', @i, '].entity_id'));
        SET dropoff_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_dropoffs, CONCAT('$[', @i, '].date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL sp_create_dropoff(p_company_id, last_delivery_id, dropoff_client_id, dropoff_type, dropoff_date);

        IF outsourced_delivery_id IS NOT NULL THEN
            CALL sp_create_dropoff(p_outsourced_to, outsourced_delivery_id, dropoff_client_id, dropoff_type, dropoff_date);
        END IF;

        SET @i = @i + 1;
    END WHILE;
END $$
DELIMITER ;

-- GET DELIVERIES
DELIMITER $$
CREATE PROCEDURE sp_get_deliveries(IN p_offset INT, IN p_limit INT, IN p_driver VARCHAR(50), IN p_provider VARCHAR(30), IN p_vehicle VARCHAR(30), IN p_day INT, IN p_month INT, IN p_year INT)
BEGIN
    SELECT
        delivery_id,
        delivery_driver,
        delivery_vehicle,
        delivery_provider,
        first_pickup_date,
        delivery_hotel_price,
        delivery_outsourced_to,
        pickups,
        dropoffs,
        company_id
    FROM view_deliveries_info
    WHERE (delivery_driver = p_driver OR p_driver IS NULL)
        AND (delivery_provider = p_provider OR p_provider IS NULL)
        AND (delivery_vehicle = p_vehicle OR p_vehicle IS NULL)
        AND (p_day IS NULL OR DAY(first_pickup_date) = p_day)
        AND (p_month IS NULL OR MONTH(first_pickup_date) = p_month)
        AND (p_year IS NULL OR YEAR(first_pickup_date) = p_year)
    LIMIT p_limit 
    OFFSET p_offset;
END $$
DELIMITER ;

-- GET DELIVERIES COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_deliveries_count(IN p_driver VARCHAR(50), IN p_provider VARCHAR(30), IN p_vehicle VARCHAR(30), IN p_day INT, IN p_month INT, IN p_year INT)
BEGIN
    SELECT COUNT(*) AS total
    FROM view_deliveries_info
    WHERE (delivery_driver = p_driver OR p_driver IS NULL)
        AND (delivery_provider = p_provider OR p_provider IS NULL)
        AND (delivery_vehicle = p_vehicle OR p_vehicle IS NULL)
        AND (p_day IS NULL OR DAY(first_pickup_date) = p_day)
        AND (p_month IS NULL OR MONTH(first_pickup_date) = p_month)
        AND (p_year IS NULL OR YEAR(first_pickup_date) = p_year);
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

-- UPDATE A DELIVERY 
DELIMITER $$
CREATE PROCEDURE sp_update_delivery(
    IN p_delivery_id INT,
    IN p_company_id INT,
    IN p_driver_id INT,
    IN p_vehicle_id INT,
    IN p_provider_id INT,
    IN p_hotel_price INT,
    IN p_pickups JSON,
    IN p_dropoffs JSON,
    IN p_outsourced_to INT
)

BEGIN
    DECLARE pickup_client_id INT;
    DECLARE pickup_date DATETIME;
    DECLARE dropoff_client_id INT;
    DECLARE dropoff_date DATETIME;
    DECLARE pickup_type VARCHAR(10);
    DECLARE dropoff_type VARCHAR(10);
    DECLARE outsourced_delivery_id INT;

    UPDATE deliveries
    SET
        delivery_driver = p_driver_id,
        delivery_vehicle = p_vehicle_id,
        delivery_provider = p_provider_id,
        delivery_hotel_price = p_hotel_price,
        delivery_outsourced_to = p_outsourced_to
    WHERE delivery_id = p_delivery_id;

    DELETE FROM pickups WHERE delivery_id = p_delivery_id;
    DELETE FROM dropoffs WHERE delivery_id = p_delivery_id;

    SET @i = 0;
    SET @n = JSON_LENGTH(JSON_UNQUOTE(p_pickups)); 

    WHILE @i < @n DO
        SET pickup_type = JSON_UNQUOTE(JSON_EXTRACT(p_pickups, CONCAT('$[', @i, '].entity_type')));
        SET pickup_client_id = JSON_EXTRACT(p_pickups, CONCAT('$[', @i, '].entity_id'));
        SET pickup_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_pickups, CONCAT('$[', @i, '].date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL sp_create_pickup(p_company_id, p_delivery_id, pickup_client_id, pickup_type, pickup_date);

        IF outsourced_delivery_id IS NOT NULL THEN
            CALL sp_create_pickup(p_outsourced_to, outsourced_delivery_id, pickup_client_id, pickup_type, pickup_date);
        END IF;

        SET @i = @i + 1;
    END WHILE;

    SET @i = 0;
    SET @n = JSON_LENGTH(p_dropoffs);

    WHILE @i < @n DO
        SET dropoff_type = JSON_UNQUOTE(JSON_EXTRACT(p_dropoffs, CONCAT('$[', @i, '].entity_type')));
        SET dropoff_client_id = JSON_EXTRACT(p_dropoffs, CONCAT('$[', @i, '].entity_id'));
        SET dropoff_date = STR_TO_DATE(CAST(JSON_UNQUOTE(JSON_EXTRACT(p_dropoffs, CONCAT('$[', @i, '].date'))) AS CHAR), '%Y-%m-%d %H:%i:%s');

        CALL sp_create_dropoff(p_company_id, p_delivery_id, dropoff_client_id, dropoff_type, dropoff_date);

        IF outsourced_delivery_id IS NOT NULL THEN
            CALL sp_create_dropoff(p_outsourced_to, outsourced_delivery_id, dropoff_client_id, dropoff_type, dropoff_date);
        END IF;

        SET @i = @i + 1;
    END WHILE;
END $$
DELIMITER ;

-- DELETE A DELIVERY
DELIMITER $$
CREATE PROCEDURE sp_delete_delivery(IN p_delivery_id INT)
BEGIN
    DELETE FROM deliveries WHERE delivery_id = p_delivery_id;
END $$
DELIMITER ;