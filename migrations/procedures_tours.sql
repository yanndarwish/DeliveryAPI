USE geostar;

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
    IN p_status VARCHAR(10),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'active' THEN
        SELECT * FROM tours WHERE tour_active = TRUE AND company_id = p_company_id;
    ELSEIF p_status = 'inactive' THEN
        SELECT * FROM tours WHERE tour_active = FALSE AND company_id = p_company_id;
    ELSE
        SELECT * FROM tours WHERE company_id = p_company_id;
    END IF;
END $$

-- GET A TOUR
DELIMITER $$
CREATE PROCEDURE sp_get_tour_by_id(IN p_tour_id INT)
BEGIN
    SELECT * FROM tours WHERE tour_id = p_tour_id;
END $$

-- UPDATE A TOUR
DELIMITER $$
CREATE PROCEDURE sp_update_tour(
    IN p_tour_id INT,
    IN p_tour_name VARCHAR(30),
    IN p_tour_active BOOLEAN,
    IN p_company_id INT
)
BEGIN
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

