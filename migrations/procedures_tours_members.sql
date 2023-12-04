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
    IN p_company_id INT
)
BEGIN
    -- check if p_status is 'active' or 'inactive' or 'all'
    IF p_status = 'active' THEN
        SELECT * FROM tours_members_info WHERE tour_active = TRUE AND company_id = p_company_id;
    ELSEIF p_status = 'inactive' THEN
        SELECT * FROM tours_members_info WHERE tour_active = FALSE AND company_id = p_company_id;
    ELSE
        SELECT * FROM tours_members_info WHERE company_id = p_company_id;
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
    IN p_tour_member_active BOOLEAN
)
BEGIN
    UPDATE tours_members
    SET
        tour_member_active = p_tour_member_active
    WHERE tour_member_id = p_tour_member_id;
END $$
DELIMITER ;

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



