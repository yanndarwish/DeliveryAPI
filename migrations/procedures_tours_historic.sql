USE geostar;

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