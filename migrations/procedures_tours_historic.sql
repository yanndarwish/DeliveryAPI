USE geostar;

-- CREATE tours history
DELIMITER $$
CREATE PROCEDURE CreateToursHistory(
    IN p_tour_id INT,
    IN p_date DATETIME,
    IN p_operation VARCHAR(10),
    IN p_company_id INT,
    IN p_client_id INT
)
BEGIN
    INSERT INTO tours_history (
        tour_history_id,
        tour_history_date,
        tour_history_operation,
        company_id,
        client_id
    )
    VALUES (
        p_tour_id,
        p_date,
        p_operation,
        p_company_id,
        p_client_id
    );
END $$
DELIMITER ;

-- GET TOURS HISTORY
DELIMITER $$
CREATE PROCEDURE GetToursHistory(
    IN p_tour_id INT,
    IN p_company_id INT,
    IN p_client_id INT,
    IN p_date DATETIME
)
BEGIN
    -- get all rows where tour_id = p_tour_id and client_id = p_client_id and company_id = p_company_id and date < p_date
    SELECT * FROM tours_history WHERE tour_id = p_tour_id AND client_id = p_client_id AND company_id = p_company_id AND date < p_date;
END $$
DELIMITER ;
