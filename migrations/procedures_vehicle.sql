USE {DB_NAME};

-- CREATE A VEHICLE
DELIMITER $$
CREATE PROCEDURE sp_create_vehicle(
    IN p_brand VARCHAR(20),
    IN p_model VARCHAR(20),
    IN p_immatriculation VARCHAR(20),
    IN p_active BOOLEAN,
    IN p_company_id INT
)
BEGIN
    INSERT INTO vehicles (
        vehicle_brand,
        vehicle_model,
        vehicle_immatriculation,
        vehicle_active,
        company_id
    )
    VALUES (
        p_brand,
        p_model,
        p_immatriculation,
        p_active,
        p_company_id
    );
END $$
DELIMITER ;

-- GET VEHICLES
DELIMITER $$
CREATE PROCEDURE sp_get_vehicles(
    IN p_offset INT,
    IN p_limit INT,
    IN p_status VARCHAR(10),
    IN p_brand VARCHAR(20),
    IN p_model VARCHAR(20),
    IN p_immatriculation VARCHAR(20),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'ACTIVE' THEN
        SELECT 
            vehicle_id,
            vehicle_brand,
            vehicle_model,
            vehicle_immatriculation,
            vehicle_active
        FROM vehicles
        WHERE vehicle_active = true
        AND company_id = p_company_id
        AND (vehicle_brand LIKE CONCAT('%', p_brand, '%') OR p_brand IS NULL)
        AND (vehicle_model LIKE CONCAT('%', p_model, '%') OR p_model IS NULL)
        AND (vehicle_immatriculation LIKE CONCAT('%', p_immatriculation, '%') OR p_immatriculation IS NULL)
        LIMIT p_limit
        OFFSET p_offset;
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT 
            vehicle_id,
            vehicle_brand,
            vehicle_model,
            vehicle_immatriculation,
            vehicle_active
        FROM vehicles
        WHERE vehicle_active = false
        AND company_id = p_company_id
        AND (vehicle_brand LIKE CONCAT('%', p_brand, '%') OR p_brand IS NULL)
        AND (vehicle_model LIKE CONCAT('%', p_model, '%') OR p_model IS NULL)
        AND (vehicle_immatriculation LIKE CONCAT('%', p_immatriculation, '%') OR p_immatriculation IS NULL)
        LIMIT p_limit
        OFFSET p_offset;
    ELSE
        SELECT 
            vehicle_id,
            vehicle_brand,
            vehicle_model,
            vehicle_immatriculation,
            vehicle_active
        FROM vehicles
        WHERE company_id = p_company_id
        AND (vehicle_brand LIKE CONCAT('%', p_brand, '%') OR p_brand IS NULL)
        AND (vehicle_model LIKE CONCAT('%', p_model, '%') OR p_model IS NULL)
        AND (vehicle_immatriculation LIKE CONCAT('%', p_immatriculation, '%') OR p_immatriculation IS NULL)
        LIMIT p_limit
        OFFSET p_offset;
    END IF;
END $$
DELIMITER ;

-- GET VEHICLES COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_vehicles_count(
    IN p_status VARCHAR(10),
    IN p_brand VARCHAR(20),
    IN p_model VARCHAR(20),
    IN p_immatriculation VARCHAR(20),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'ACTIVE' THEN
        SELECT COUNT(*) AS total 
        FROM vehicles 
        WHERE vehicle_active = true
        AND company_id = p_company_id
        AND (vehicle_brand LIKE CONCAT('%', p_brand, '%') OR p_brand IS NULL)
        AND (vehicle_model LIKE CONCAT('%', p_model, '%') OR p_model IS NULL)
        AND (vehicle_immatriculation LIKE CONCAT('%', p_immatriculation, '%') OR p_immatriculation IS NULL);
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT COUNT(*) AS total 
        FROM vehicles 
        WHERE vehicle_active = false
        AND company_id = p_company_id
        AND (vehicle_brand LIKE CONCAT('%', p_brand, '%') OR p_brand IS NULL)
        AND (vehicle_model LIKE CONCAT('%', p_model, '%') OR p_model IS NULL)
        AND (vehicle_immatriculation LIKE CONCAT('%', p_immatriculation, '%') OR p_immatriculation IS NULL);
    ELSE
        SELECT COUNT(*) AS total 
        FROM vehicles 
        WHERE company_id = p_company_id
        AND (vehicle_brand LIKE CONCAT('%', p_brand, '%') OR p_brand IS NULL)
        AND (vehicle_model LIKE CONCAT('%', p_model, '%') OR p_model IS NULL)
        AND (vehicle_immatriculation LIKE CONCAT('%', p_immatriculation, '%') OR p_immatriculation IS NULL);
    END IF;
END $$

-- GET A VEHICLE
DELIMITER $$
CREATE PROCEDURE sp_get_vehicle_by_id(IN p_vehicle_id INT)
BEGIN
    SELECT
        vehicle_id,
        vehicle_brand,
        vehicle_model,
        vehicle_immatriculation,
        vehicle_active
    FROM vehicles WHERE vehicle_id = p_vehicle_id;
END $$
DELIMITER ;

-- UPDATE A VEHICLE
DELIMITER $$
CREATE PROCEDURE sp_update_vehicle(
    IN p_vehicle_id INT,
    IN p_brand VARCHAR(20),
    IN p_model VARCHAR(20),
    IN p_immatriculation VARCHAR(20),
    IN p_active BOOLEAN
)
BEGIN
    UPDATE vehicles
    SET
        vehicle_brand = p_brand,
        vehicle_model = p_model,
        vehicle_immatriculation = p_immatriculation,
        vehicle_active = p_active
    WHERE
        vehicle_id = p_vehicle_id;
END $$
DELIMITER ;

-- DELETE A VEHICLE
DELIMITER $$
CREATE PROCEDURE sp_delete_vehicle(IN p_vehicle_id INT)
BEGIN
    DELETE FROM vehicles WHERE vehicle_id = p_vehicle_id;
END $$
DELIMITER ;

-- CALL sp_create_vehicle('Example Brand', 'Example Model', '123ABC', true);
-- CALL sp_get_vehicles();
-- CALL sp_get_vehicle_by_id(1);
-- CALL sp_update_vehicle(1, 'Updated Brand', 'Updated Model', '987XYZ', false);
-- CALL sp_delete_vehicle(2);
