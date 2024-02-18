USE {DB_NAME};

-- CREATE A COMPANY
DELIMITER $$
CREATE PROCEDURE sp_create_company(
    IN p_name VARCHAR(50),
    IN p_active BOOLEAN,
    IN p_siret VARCHAR(14),
    IN p_email VARCHAR(50),
    IN p_phone_number VARCHAR(15),
    IN p_contacts JSON,
    IN p_headquarter_street_number INT,
    IN p_headquarter_street VARCHAR(100),
    IN p_headquarter_city VARCHAR(30),
    IN p_headquarter_postal_code INT,
    IN p_headquarter_country VARCHAR(30),
    IN p_headquarter_comment VARCHAR(100),
    IN p_warehouse_street_number INT,
    IN p_warehouse_street VARCHAR(100),
    IN p_warehouse_city VARCHAR(30),
    IN p_warehouse_postal_code INT,
    IN p_warehouse_country VARCHAR(30),
    IN p_warehouse_comment VARCHAR(100)
)
BEGIN
    DECLARE new_company_id INT;
    DECLARE new_headquarter_id INT;
    DECLARE new_warehouse_id INT;

    -- Insert into companies table
    INSERT INTO companies (
        company_name,
        company_siret,
        contacts,
        company_active
    )
    VALUES (
        p_name,
        p_siret,
        p_contacts,
        p_active
    );

    -- Get the last inserted company_id
    SET new_company_id = LAST_INSERT_ID();

    IF p_headquarter_street IS NOT NULL THEN
        -- Insert into addresses table
        CALL sp_create_address(
            p_headquarter_street_number,
            p_headquarter_street,
            p_headquarter_city,
            p_headquarter_postal_code,
            p_headquarter_country,
            p_headquarter_comment,
            'COMPANY',
            new_company_id
        );
    END IF;

    IF p_warehouse_street IS NOT NULL THEN
        -- Insert into addresses table
        CALL sp_create_address(
            p_warehouse_street_number,
            p_warehouse_street,
            p_warehouse_city,
            p_warehouse_postal_code,
            p_warehouse_country,
            p_warehouse_comment,
            'COMPANY',
            new_company_id
        );
    END IF;

    IF p_email IS NOT NULL THEN
        -- INSERT INTO emails table
        CALL sp_create_email(
            'COMPANY',
            new_company_id,
            p_email
        );
    END IF;

    IF p_phone_number IS NOT NULL THEN
        -- INSERT INTO phones table
        CALL sp_create_phone(
            'COMPANY',
            new_company_id,
            p_phone_number
        );
    END IF;
END$$
DELIMITER ;

-- GET ALL COMPANIES
DELIMITER $$
CREATE PROCEDURE sp_get_companies(IN p_offset INT, IN p_limit INT, IN p_status VARCHAR(10), IN p_name VARCHAR(30), IN p_siret CHAR(14), IN p_email VARCHAR(50))
    BEGIN
    IF p_status = "ACTIVE" THEN
        SELECT
            company_id,
            company_name,
            company_siret,
            headquarter_address_id,
            headquarter_street_number,
            headquarter_street,
            headquarter_city,
            headquarter_postal_code,
            headquarter_country,
            warehouse_address_id,
            warehouse_street_number,
            warehouse_street,
            warehouse_city,
            warehouse_postal_code,
            warehouse_country,
            email,
            phone,
            contacts,
            company_active
        FROM view_companies_info
        WHERE company_active = TRUE
        AND (company_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (company_siret LIKE CONCAT('%', p_siret, '%') OR p_siret IS NULL)
        AND (email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    ELSEIF p_status = "INACTIVE" THEN
        SELECT
            company_id,
            company_name,
            company_siret,
            headquarter_address_id,
            headquarter_street_number,
            headquarter_street,
            headquarter_city,
            headquarter_postal_code,
            headquarter_country,
            warehouse_address_id,
            warehouse_street_number,
            warehouse_street,
            warehouse_city,
            warehouse_postal_code,
            warehouse_country,
            email,
            phone,
            contacts,
            company_active
        FROM view_companies_info
        WHERE company_active = FALSE
        AND (company_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (company_siret LIKE CONCAT('%', p_siret, '%') OR p_siret IS NULL)
        AND (email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    ELSE
        SELECT
            company_id,
            company_name,
            company_siret,
            headquarter_address_id,
            headquarter_street_number,
            headquarter_street,
            headquarter_city,
            headquarter_postal_code,
            headquarter_country,
            warehouse_address_id,
            warehouse_street_number,
            warehouse_street,
            warehouse_city,
            warehouse_postal_code,
            warehouse_country,
            email,
            phone,
            contacts,
            company_active
        FROM view_companies_info
        WHERE (company_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (company_siret LIKE CONCAT('%', p_siret, '%') OR p_siret IS NULL)
        AND (email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL)
        LIMIT p_limit 
        OFFSET p_offset;
    END IF;
END$$
DELIMITER ;

-- GET COMPANIES COUNT
DELIMITER $$
CREATE PROCEDURE sp_get_companies_count(IN p_status VARCHAR(10), IN p_name VARCHAR(30), IN p_siret CHAR(14), IN p_email VARCHAR(50))
    BEGIN
    IF p_status = "ACTIVE" THEN
        SELECT COUNT(*) AS total
        FROM view_companies_info
        WHERE company_active = TRUE
        AND (company_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (company_siret LIKE CONCAT('%', p_siret, '%') OR p_siret IS NULL)
        AND (email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL);
    ELSEIF p_status = "INACTIVE" THEN
        SELECT COUNT(*) AS total
        FROM view_companies_info
        WHERE company_active = FALSE
        AND (company_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (company_siret LIKE CONCAT('%', p_siret, '%') OR p_siret IS NULL)
        AND (email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL);
    ELSE
        SELECT COUNT(*) AS total
        FROM view_companies_info
        WHERE (company_name LIKE CONCAT('%', p_name, '%') OR p_name IS NULL)
        AND (company_siret LIKE CONCAT('%', p_siret, '%') OR p_siret IS NULL)
        AND (email LIKE CONCAT('%', p_email, '%') OR p_email IS NULL);
    END IF;
END$$
DELIMITER ;

-- GET COMPANY BY ID
DELIMITER $$
CREATE PROCEDURE sp_get_company_by_id(
    IN p_company_id INT
)
BEGIN
    SELECT
            company_id,
            company_name,
            company_siret,
            headquarter_address_id,
            headquarter_street_number,
            headquarter_street,
            headquarter_city,
            headquarter_postal_code,
            headquarter_country,
            warehouse_address_id,
            warehouse_street_number,
            warehouse_street,
            warehouse_city,
            warehouse_postal_code,
            warehouse_country,
            email,
            phone,
            contacts,
            company_active
        FROM view_companies_info
        WHERE company_id = p_company_id;
END$$
DELIMITER ;

-- UPDATE COMPANY
DELIMITER $$
CREATE PROCEDURE sp_update_company(
    IN p_company_id INT,
    IN p_name VARCHAR(50),
    IN p_active BOOLEAN,
    IN p_siret VARCHAR(14),
    IN p_headquarter_street_number INT,
    IN p_headquarter_street VARCHAR(100),
    IN p_headquarter_city VARCHAR(30),
    IN p_headquarter_postal_code INT,
    IN p_headquarter_country VARCHAR(30),
    IN p_headquarter_comment TEXT,
    IN p_warehouse_street_number INT,
    IN p_warehouse_street VARCHAR(100),
    IN p_warehouse_city VARCHAR(30),
    IN p_warehouse_postal_code INT,
    IN p_warehouse_country VARCHAR(30),
    IN p_warehouse_comment TEXT
)
BEGIN
    DECLARE headquarter_id INT;
    DECLARE warehouse_id INT;

    -- Get the headquarter_id and warehouse_id of the company
    SELECT company_headquarter, company_warehouse INTO headquarter_id, warehouse_id FROM companies WHERE company_id = p_company_id;

    -- Update the headquarter address headquarter_id is not null
    IF headquarter_id IS NOT NULL THEN
        CALL sp_update_address(
            headquarter_id,
            p_headquarter_street_number,
            p_headquarter_street,
            p_headquarter_city,
            p_headquarter_postal_code,
            p_headquarter_country,
            p_headquarter_comment
        );
    END IF;

    -- Update the warehouse address warehouse_id is not null
    IF warehouse_id IS NOT NULL THEN
        CALL sp_update_address(
            warehouse_id,
            p_warehouse_street_number,
            p_warehouse_street,
            p_warehouse_city,
            p_warehouse_postal_code,
            p_warehouse_country,
            p_warehouse_comment
        );
    END IF;

    -- Update companies table
    UPDATE companies
    SET
        company_name = p_name,
        company_siret = p_siret,
        company_active = p_active
    WHERE company_id = p_company_id;

    -- Select the updated company
    SELECT
        company_id,
        company_name,
        company_siret,
        contacts,
        company_active
    FROM companies WHERE company_id = p_company_id;
END$$
DELIMITER ;

-- DELETE COMPANY
DELIMITER $$
CREATE PROCEDURE sp_delete_company(
    IN p_company_id INT
)
BEGIN
    -- Delete the company
    DELETE FROM companies WHERE company_id = p_company_id;
END$$
DELIMITER ;