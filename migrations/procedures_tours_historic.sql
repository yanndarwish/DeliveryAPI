USE {DB_NAME};

-- CREATE tours history
DELIMITER $$
CREATE PROCEDURE sp_create_tours_history(
    IN p_date DATETIME,
    IN p_operation VARCHAR(10),
    IN p_tour_id INT,
    IN p_client_id INT,
    IN p_company_id INT
)
BEGIN
    INSERT INTO tours_history (
        tour_history_date,
        tour_history_operation,
        tour_id,
        client_id,
        company_id
    )
    VALUES (
        p_date,
        p_operation,
        p_tour_id,
        p_client_id,
        p_company_id
    );
END $$
DELIMITER ;

-- GET TOURS HISTORY
DELIMITER $$
CREATE PROCEDURE sp_get_tours_history(
    IN p_tour_id INT,
    IN p_company_id INT,
    IN p_client_id INT,
    IN p_date DATETIME
)
BEGIN
    SELECT 
        tour_history_id,
        tour_history_date,
        tour_history_operation,
        tour_id,
        client_id,
        company_id
    FROM 
        tours_history
    WHERE tour_id = p_tour_id
    AND client_id = p_client_id
    AND company_id = p_company_id
    AND tour_history_date < p_date
    ORDER BY tour_history_id
    DESC LIMIT 1;
END $$
DELIMITER ;

-- INSERT TOURS HISTORY FOR ALL TOUR MEMBERS
DELIMITER $$
CREATE PROCEDURE sp_update_tours_history(
    IN p_tour_id INT,
    IN p_operation VARCHAR(10),
    IN p_date DATETIME
)
BEGIN
    DECLARE v_client_id INT;
    DECLARE v_company_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR
        SELECT 
            client_id,
            company_id
        FROM 
            tours_members
        WHERE tour_id = p_tour_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_client_id, v_company_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL sp_create_tours_history(
            p_date,
            p_operation,
            p_tour_id,
            v_client_id,
            v_company_id
        );
    END LOOP;
    CLOSE cur;
END $$
DELIMITER ;