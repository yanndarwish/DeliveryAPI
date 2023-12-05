USE geostar;

-- CREATE A TOUR MEMBER
DELIMITER $$
CREATE PROCEDURE CreateTourMember(
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
CREATE PROCEDURE GetTourMembers(
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

-- GET A TOUR MEMBER
DELIMITER $$
CREATE PROCEDURE GetTourMember(IN p_tour_member_id INT)
BEGIN
    SELECT * FROM tours_members WHERE tour_member_id = p_tour_member_id;
END $$
DELIMITER ;

-- UPDATE A TOUR MEMBER ACTIVE STATUS
DELIMITER $$
CREATE PROCEDURE UpdateTourMemberStatus(
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
CREATE TRIGGER UpdateToursHistory
AFTER UPDATE ON tours_members
FOR EACH ROW
BEGIN
    -- check if tour_member_active has changed
    IF OLD.tour_member_active != NEW.tour_member_active THEN
        -- if tour_member_active is TRUE, insert a new row in tours_history with operation 'ACTIVATE'
        IF NEW.tour_member_active = TRUE THEN
            CALL CreateToursHistory(
                NOW(),
                'ACTIVATE',
                NEW.tour_id,
                NEW.client_id,
                NEW.company_id
            );
        END IF;

        -- if tour_member_active is FALSE, insert a new row in tours_history with operation 'DEACTIVATE'
        IF NEW.tour_member_active = FALSE THEN
            CALL CreateToursHistory(
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
CREATE PROCEDURE UpdateTourMember(
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
CREATE PROCEDURE DeleteTourMember(IN p_tour_member_id INT)
BEGIN
    DELETE FROM tours_members WHERE tour_member_id = p_tour_member_id;
END $$
DELIMITER ;



