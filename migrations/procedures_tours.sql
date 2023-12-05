USE geostar;

-- CREATE A TOUR
DELIMITER $$
CREATE PROCEDURE CreateTour(
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
        CALL CreateTourMember(
            @new_tour_id,
            @client_id,
            p_company_id
        );

        CALL CreateToursHistory(
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
CREATE PROCEDURE GetTours(
    IN p_status VARCHAR(10),
    IN p_company_id INT
)
BEGIN
    IF p_status = 'active' THEN
        SELECT * FROM tours_info WHERE tour_active = TRUE AND company_id = p_company_id;
    ELSEIF p_status = 'inactive' THEN
        SELECT * FROM tours_info WHERE tour_active = FALSE AND company_id = p_company_id;
    ELSE
        SELECT * FROM tours_info WHERE company_id = p_company_id;
    END IF;
END $$

-- GET A TOUR
DELIMITER $$
CREATE PROCEDURE GetTour(IN p_tour_id INT)
BEGIN
    SELECT * FROM tours WHERE tour_id = p_tour_id;
END $$

-- GET TOUR MEMBERS STATUS AT A GIVEN DATE
DELIMITER $$
CREATE PROCEDURE GetTourMembersStatus(
    IN p_tour_id INT,
    IN p_company_id INT,
    IN p_date DATETIME
)
BEGIN
    -- GET all members of a tour
    SET @tour_members = JSON_ARRAY();

    -- assign tour_members to the result of the stored procedure
    CALL GetTourMembers('all', p_company_id, @tour_members);
    SET @active_tour_members = JSON_ARRAY();    

    SELECT @tour_members;

    -- loop through tour_members
    WHILE JSON_LENGTH(@tour_members) > 0 DO
        -- get the first element of the array
        SET @tour_member = JSON_EXTRACT(@tour_members, '$[0]');
        SET @client_id = JSON_EXTRACT(@tour_member, '$.client_id');

        -- get the last operation of the tour member
        CALL GetMemberLastOperation(p_tour_id, p_company_id, @client_id, p_date, @last_operation);

        -- check if the last operation is 'CREATE', 'ACTIVATE' then add the tour member to the active_tour_members array
        IF @last_operation = 'CREATE' OR @last_operation = 'ACTIVATE' THEN
            SET @active_tour_members = JSON_ARRAY_APPEND(@active_tour_members, '$', @client_id);
        END IF;

        -- remove the first element of the array
        SET @tour_members = JSON_REMOVE(@tour_members, '$[0]');

    END WHILE;

    -- return the active_tour_members array
    SELECT @active_tour_members;

END $$ 
DELIMITER ;

-- UPDATE A TOUR
DELIMITER $$
CREATE PROCEDURE UpdateTour(
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
CREATE PROCEDURE DeleteTour(IN p_tour_id INT)
BEGIN
    DELETE FROM tours WHERE tour_id = p_tour_id;
END $$
DELIMITER ;

