USE {DB_NAME};

-- CREATE A TOUR
DELIMITER $$
CREATE PROCEDURE sp_create_tour(
    IN p_tour_name VARCHAR(30),
    IN p_tour_active BOOLEAN,
    IN p_company_id INT,
    IN p_client_ids JSON
)
BEGIN
    INSERT INTO tours (
        tour_name,
        tour_active,
        company_id
    )
    VALUES (
        p_tour_name,
        p_tour_active,
        p_company_id
    );

    -- Get the last inserted tour_id
    SET @new_tour_id = LAST_INSERT_ID();

    -- loop through client_ids and Insert into tours_members table
    WHILE JSON_LENGTH(p_client_ids) > 0 DO
        -- get the first element of the array
        SET @client_id = JSON_EXTRACT(p_client_ids, '$[0]');

        -- remove the first element of the array
        SET p_client_ids = JSON_REMOVE(p_client_ids, '$[0]');

        -- Insert into tours_members table
        CALL sp_create_tour_member(
            @new_tour_id,
            @client_id,
            p_company_id
        );

        CALL sp_create_tours_history(
            NOW(),
            'CREATE',
            @new_tour_id,
            @client_id,
            p_company_id
        );
    END WHILE;

END $$
DELIMITER ;

-- GET TOURS
DELIMITER $$
CREATE PROCEDURE sp_get_tours(
    IN p_offset INT,
    IN p_limit INT,
    IN p_status VARCHAR(10),
    IN p_name VARCHAR(30),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'ACTIVE' THEN
        SELECT
            tour_id,
            tour_name,
            tour_active
        FROM tours 
        WHERE tour_active = TRUE 
        AND company_id = p_company_id
        AND (tour_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT
            tour_id,
            tour_name,
            tour_active
        FROM tours 
        WHERE tour_active = FALSE 
        AND company_id = p_company_id
        AND (tour_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    ELSE
        SELECT
            tour_id,
            tour_name,
            tour_active
        FROM tours 
        WHERE company_id = p_company_id
        AND (tour_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    END IF;
END $$
DELIMITER ;

-- GET TOURS COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_tours_count(
    IN p_status VARCHAR(10),
    IN p_name VARCHAR(30),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'ACTIVE' THEN
        SELECT COUNT(*) AS total FROM tours 
        WHERE tour_active = TRUE 
        AND company_id = p_company_id
        AND (tour_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL);
    ELSEIF p_status = 'INACTIVE' THEN
        SELECT COUNT(*) AS total FROM tours 
        WHERE tour_active = FALSE 
        AND company_id = p_company_id
        AND (tour_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL);
    ELSE
        SELECT COUNT(*) AS total FROM tours 
        WHERE company_id = p_company_id
        AND (tour_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL);
    END IF;
END $$
DELIMITER ;


-- GET A TOUR
DELIMITER $$
CREATE PROCEDURE sp_get_tour(IN p_tour_id INT, IN p_company_id INT)
BEGIN
    SELECT
        tour_id,
        tour_name,
        tour_active,
        company_id
    FROM tours 
    WHERE tour_id = p_tour_id
    AND company_id = p_company_id;
END $$

-- UPDATE A TOUR
DELIMITER $$
CREATE PROCEDURE sp_update_tour(
    IN p_tour_id INT,
    IN p_tour_name VARCHAR(30),
    IN p_tour_active BOOLEAN,
    IN p_company_id INT,
    IN p_client_ids JSON
)
BEGIN
    DECLARE client_id INT;

    -- Deactivate existing tour member
    CALL sp_deactivate_all_tour_members(p_tour_id);    

    -- Insert new tour members and update tours_history for creations
    WHILE JSON_LENGTH(p_client_ids) > 0 DO
        SET client_id = JSON_UNQUOTE(JSON_EXTRACT(p_client_ids, '$[0]'));
        SET p_client_ids = JSON_REMOVE(p_client_ids, '$[0]');

    -- Check if client already exists in the tour
        IF EXISTS (SELECT * FROM tours_members WHERE tour_id = p_tour_id AND client_id = client_id) THEN
            -- Activate the existing tour member
            CALL sp_update_tour_member_status_by_client_id(p_tour_id, client_id, TRUE);
        ELSE
        -- Insert new tour member
        CALL sp_create_tour_member(
            p_tour_id,
            client_id,
            p_company_id
        );

        -- Insert into tours_history for creations
        CALL sp_create_tours_history(
            NOW(),
            'CREATE',
            p_tour_id,
            client_id,
            p_company_id
        );
        END IF;
    END WHILE;

    -- Update the tour details
    UPDATE tours
    SET 
        tour_name = p_tour_name,
        tour_active = p_tour_active,
        company_id = p_company_id
    WHERE tour_id = p_tour_id;
END $$
DELIMITER ;

-- DELETE A TOUR
DELIMITER $$
CREATE PROCEDURE sp_delete_tour(IN p_tour_id INT)
BEGIN
    DELETE FROM tours WHERE tour_id = p_tour_id;
END $$
DELIMITER ;

