USE geostar;

-- CREATE A COMPANY
DELIMITER $$
CREATE PROCEDURE CreateCompany(
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
    IN p_headquarter_comment TEXT,
    IN p_warehouse_street_number INT,
    IN p_warehouse_street VARCHAR(100),
    IN p_warehouse_city VARCHAR(30),
    IN p_warehouse_postal_code INT,
    IN p_warehouse_country VARCHAR(30),
    IN p_warehouse_comment TEXT
)
BEGIN
    DECLARE new_company_id INT;
    DECLARE new_headquarter_id INT;
    DECLARE new_warehouse_id INT;

    -- Insert into addresses table for headquarter
    CALL CreateAddress(
        p_headquarter_street_number,
        p_headquarter_street,
        p_headquarter_city,
        p_headquarter_postal_code,
        p_headquarter_country,
        p_headquarter_comment
    );

    -- Get the last inserted headquarter_id
    SET new_headquarter_id = LAST_INSERT_ID();

    -- Insert into addresses table for warehouse
    CALL CreateAddress(
        p_warehouse_street_number,
        p_warehouse_street,
        p_warehouse_city,
        p_warehouse_postal_code,
        p_warehouse_country,
        p_warehouse_comment
    );

    -- Get the last inserted warehouse_id
    SET new_warehouse_id = LAST_INSERT_ID();

    -- Insert into companies table
    INSERT INTO companies (
        company_name,
        company_headquarter,
        company_warehouse,
        company_siret,
        contacts,
        company_active
    )
    VALUES (
        p_name,
        new_headquarter_id,
        new_warehouse_id,
        p_siret,
        p_contacts,
        p_active
    );

    -- Get the last inserted company_id
    SET new_company_id = LAST_INSERT_ID();

     -- INSERT INTO emails table
    CALL CreateEmail(
        'COMPANY',
        new_company_id,
        p_email
    );

    -- INSERT INTO phones table
    CALL CreatePhone(
        'COMPANY',
        new_company_id,
        p_phone_number
    );
END$$
DELIMITER ;

-- GET ALL COMPANIES
DELIMITER $$
CREATE PROCEDURE GetAllCompanies()
BEGIN
    SELECT * FROM companies;
END$$
DELIMITER ;

-- GET COMPANY BY ID
DELIMITER $$
CREATE PROCEDURE GetCompanyById(
    IN p_company_id INT
)
BEGIN
    SELECT * FROM companies WHERE company_id = p_company_id;
END$$
DELIMITER ;

-- UPDATE COMPANY
DELIMITER $$
CREATE PROCEDURE UpdateCompany(
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
        CALL UpdateAddress(
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
        CALL UpdateAddress(
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
    SELECT * FROM companies WHERE company_id = p_company_id;
END$$
DELIMITER ;

-- DELETE COMPANY
DELIMITER $$
CREATE PROCEDURE DeleteCompany(
    IN p_company_id INT
)
BEGIN
    -- Delete the company
    DELETE FROM companies WHERE company_id = p_company_id;
END$$
DELIMITER ;