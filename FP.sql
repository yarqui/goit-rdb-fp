-- =======
-- 1.
-- =======
-- CREATE SCHEMA pandemic;
-- USE pandemic;

-- =======
-- 2.
-- =======
-- CREATE TABLE entities (
-- entity_id INT PRIMARY KEY AUTO_INCREMENT,
-- entity_name VARCHAR(100),
-- entity_code VARCHAR(100),
-- UNIQUE (entity_name, entity_code));

-- ALTER TABLE infectious_cases
-- RENAME TO init_inf_c;

-- CREATE TABLE infectious_cases (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
--     entity_id INT,
--     year INT,
--     number_yaws FLOAT,
--     number_polio FLOAT,
--     number_guinea_worm FLOAT,
--     number_rabies FLOAT,
--     number_malaria FLOAT,
--     number_hiv FLOAT,
--     number_tuberculosis FLOAT,
--     number_smallpox FLOAT,
--     number_cholera FLOAT,
--     FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
-- );

-- INSERT INTO entities (entity_name, entity_code)
-- SELECT DISTINCT entity, code
-- FROM init_inf_c;

-- INSERT INTO infectious_cases (
-- entity_id, year, number_yaws, number_polio, number_guinea_worm, number_rabies, number_malaria, number_hiv, number_tuberculosis, number_smallpox, number_cholera)
-- SELECT ent.entity_id, 
--        iic.Year, 
--        CAST(iic.Number_yaws AS FLOAT), 
--        CAST(iic.polio_cases AS FLOAT), 
--        CAST(iic.cases_guinea_worm AS FLOAT), 
--        CAST(iic.Number_rabies AS FLOAT), 
--        CAST(iic.Number_malaria AS FLOAT), 
--        CAST(iic.Number_hiv AS FLOAT), 
--        CAST(iic.Number_tuberculosis AS FLOAT), 
--        CAST(iic.Number_smallpox AS FLOAT), 
--        CAST(iic.Number_cholera_cases AS FLOAT)
-- FROM init_inf_c iic
-- JOIN entities ent ON ent.entity_name = iic.entity
-- ORDER BY iic.entity, iic.year 
-- ;

-- =======
-- 3
-- =======
-- SELECT entity_id country, MIN(number_rabies) min, MAX(number_rabies) max, AVG(number_rabies) average, SUM(number_rabies) as sum
-- FROM infectious_cases
-- WHERE number_rabies > 0
-- GROUP BY entity_id
-- ORDER BY average DESC
-- LIMIT 10;

-- =======
-- 4
-- =======
-- CREATE TABLE infectious_cases_copy LIKE infectious_cases;

-- INSERT INTO infectious_cases_copy
-- SELECT * FROM infectious_cases;

-- ALTER TABLE infectious_cases
-- ADD COLUMN full_date DATE,
-- ADD COLUMN curr_date DATE,
-- ADD COLUMN diff_date INT
-- ;

-- UPDATE infectious_cases
-- SET full_date = MAKEDATE(year, 1),
-- curr_date = CURDATE(),
-- diff_date = TIMESTAMPDIFF(YEAR, full_date, curr_date)
-- ;

-- SELECT entity_id, year, full_date, curr_date, diff_date FROM infectious_cases;

-- =======
-- 5
-- =======
-- DROP FUNCTION IF EXISTS getDiffInYears;

-- DELIMITER //
-- CREATE FUNCTION getDiffInYears(input_year INT)
-- RETURNS INT
-- NO SQL
-- BEGIN
-- 	DECLARE diffInYears INT;
--     SET diffInYears = TIMESTAMPDIFF(YEAR, CURDATE(), MAKEDATE(input_year, 1));
--     RETURN diffInYears;
-- END//

-- DELIMITER ;

-- SELECT getDiffInYears(2030);
