USE geostar;

-- CREATE A TOUR MEMBER
DELIMITER $$
CREATE PROCEDURE sp_create_tour_member(
    IN p_tour_id INT,
    IN p_client_id INT,
    IN p_company_id INT
)
BEGIN
    INSERT INTO tours_members (
        tour_id,
        client_id,
        company_id
    )
    VALUES (
        p_tour_id,
        p_client_id,
        p_company_id
    );
END $$
DELIMITER ;

-- GET TOUR MEMBERS
DELIMITER $$
CREATE PROCEDURE sp_get_tour_members(
    IN p_status VARCHAR(10),
    IN p_company_id INT,
    OUT tour_members JSON
)
BEGIN
    IF p_status = 'active' THEN
    SET tour_members = (
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'tour_member_id', tour_member_id,
                'tour_id', tour_id,
                'client_id', client_id,
                'company_id', company_id,
                'tour_member_active', tour_member_active
            )
        )
        FROM tours_members
        WHERE tour_member_active = TRUE
        AND company_id = p_company_id
    );
    ELSEIF p_status = 'inactive' THEN
    SET tour_members = (
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'tour_member_id', tour_member_id,
                'tour_id', tour_id,
                'client_id', client_id,
                'company_id', company_id,
                'tour_member_active', tour_member_active
            )
        )
        FROM tours_members
        WHERE tour_member_active = FALSE
        AND company_id = p_company_id
    );
    ELSE
    SET tour_members = (
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'tour_member_id', tour_member_id,
                'tour_id', tour_id,
                'client_id', client_id,
                'company_id', company_id,
                'tour_member_active', tour_member_active
            )
        )
        FROM tours_members
        WHERE company_id = p_company_id
    );
    END IF;
END $$
DELIMITER ;

-- GET TOUR MEMBERS INFO
DELIMITER $$
CREATE PROCEDURE sp_get_tour_members_info(
    IN p_status VARCHAR(10),
    IN p_company_id INT,
    IN p_offset INT,
    IN p_limit INT
)
BEGIN
    IF p_status = 'active' THEN
    SELECT
        tour_member_id,
        company_id,
        tour_id,
        tour_name,
        client_id,
        client_name,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        tour_member_active
    FROM view_tour_members_info
    WHERE tour_member_active = TRUE
    AND company_id = p_company_id
    LIMIT p_limit 
    OFFSET p_offset;
    ELSEIF p_status = 'inactive' THEN
    SELECT
        tour_member_id,
        company_id,
        tour_id,
        tour_name,
        client_id,
        client_name,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        tour_member_active
    FROM view_tour_members_info
    WHERE tour_member_active = FALSE
    AND company_id = p_company_id
    LIMIT p_limit 
    OFFSET p_offset;
    ELSE
    SELECT
        tour_member_id,
        company_id,
        tour_id,
        tour_name,
        client_id,
        client_name,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        tour_member_active
    FROM view_tour_members_info
    WHERE company_id = p_company_id
    LIMIT p_limit 
    OFFSET p_offset;
    END IF;
END $$
DELIMITER ;

-- GET A TOUR MEMBER
DELIMITER $$
CREATE PROCEDURE sp_get_tour_member_by_id(IN p_tour_member_id INT)
BEGIN
    SELECT
        tour_member_id,
        company_id,
        tour_id,
        tour_name,
        client_id,
        client_name,
        address_street_number,
        address_street,
        address_city,
        address_postal_code,
        address_country,
        tour_member_active
    FROM view_tour_members_info;
END $$
DELIMITER ;

-- GET A TOUR MEMBER'S LAST OPERATION
DELIMITER $$
CREATE PROCEDURE sp_get_member_last_operation(
    IN p_tour_id INT,
    IN p_company_id INT,
    IN p_client_id INT,
    IN p_date DATETIME,
    OUT last_operation VARCHAR(12)
)
BEGIN
    SET last_operation = (SELECT 
        tour_history_operation
    FROM
        tours_history
    WHERE
        tour_id = p_tour_id
            AND client_id = p_client_id
            AND company_id = p_company_id
            AND tour_history_date < p_date
    ORDER BY tour_history_id DESC
    LIMIT 1);
END $$
DELIMITER ;

-- GET TOUR MEMBERS STATUS AT A GIVEN DATE
DELIMITER $$
CREATE PROCEDURE sp_get_tour_members_status(
    IN p_tour_id INT,
    IN p_company_id INT,
    IN p_date DATETIME
)
BEGIN
    -- GET all members of a tour
    SET @tour_members = JSON_ARRAY();

    -- assign tour_members to the result of the stored procedure
    CALL sp_get_tour_members('all', p_company_id, @tour_members);
    SET @active_tour_members = JSON_ARRAY();    

    SELECT @tour_members;

    -- loop through tour_members
    WHILE JSON_LENGTH(@tour_members) > 0 DO
        -- get the first element of the array
        SET @tour_member = JSON_EXTRACT(@tour_members, '$[0]');
        SET @client_id = JSON_EXTRACT(@tour_member, '$.client_id');

        -- get the last operation of the tour member
        CALL sp_get_member_last_operation(p_tour_id, p_company_id, @client_id, p_date, @last_operation);

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

-- UPDATE A TOUR MEMBER ACTIVE STATUS
DELIMITER $$
CREATE PROCEDURE sp_update_tour_member_status(
    IN p_tour_member_id INT,
    IN p_tour_id INT,
    IN p_tour_member_active BOOLEAN
)
BEGIN
    UPDATE tours_members
    SET
        tour_member_active = p_tour_member_active
    WHERE tour_member_id = p_tour_member_id
    AND tour_id = p_tour_id;
END $$
DELIMITER ;

-- ADD TRIGGER TO UPDATE TOURS HISTORY
DELIMITER $$
CREATE TRIGGER tr_update_tours_history
AFTER UPDATE ON tours_members
FOR EACH ROW
BEGIN
    -- check if tour_member_active has changed
    IF OLD.tour_member_active != NEW.tour_member_active THEN
        -- if tour_member_active is TRUE, insert a new row in tours_history with operation 'ACTIVATE'
        IF NEW.tour_member_active = TRUE THEN
            CALL sp_create_tours_history(
                NOW(),
                'ACTIVATE',
                NEW.tour_id,
                NEW.client_id,
                NEW.company_id
            );
        END IF;

        -- if tour_member_active is FALSE, insert a new row in tours_history with operation 'DEACTIVATE'
        IF NEW.tour_member_active = FALSE THEN
            CALL sp_create_tours_history(
                NOW(),
                'DEACTIVATE',
                NEW.tour_id,
                NEW.client_id,
                NEW.company_id
            );
        END IF;
    END IF;
END $$

-- UPDATE A TOUR MEMBER
DELIMITER $$
CREATE PROCEDURE sp_update_tour_member(
    IN p_tour_member_id INT,
    IN p_tour_id INT,
    IN p_client_id INT,
    IN p_company_id INT
)
BEGIN
    UPDATE tours_members
    SET
        tour_id = p_tour_id,
        client_id = p_client_id,
        company_id = p_company_id
    WHERE tour_member_id = p_tour_member_id;
END $$
DELIMITER ;

-- DELETE A TOUR MEMBER
DELIMITER $$
CREATE PROCEDURE sp_delete_tour_member(IN p_tour_member_id INT)
BEGIN
    DELETE FROM tours_members WHERE tour_member_id = p_tour_member_id;
END $$
DELIMITER ;



