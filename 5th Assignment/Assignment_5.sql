BEGIN;

CREATE TABLE employee
(
    id                   SERIAL PRIMARY KEY,
    username             VARCHAR(255) NOT NULL UNIQUE,
    password             VARCHAR(255) NOT NULL,
    email                VARCHAR(255) NOT NULL UNIQUE,
    number_of_colleagues INTEGER
);

CREATE TABLE department
(
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(50) NOT NULL UNIQUE,
    number_of_employees INTEGER

);

CREATE TABLE department_members
(
    employee_id   INTEGER REFERENCES employee (id),
    department_id INTEGER REFERENCES department (id),
    PRIMARY KEY (employee_id, department_id)
);

COMMIT;

CREATE UNIQUE INDEX ON employee (email);

BEGIN;

CREATE OR REPLACE PROCEDURE update_department_size(department_number INTEGER)
AS
$$
DECLARE
    number_of_department_members INTEGER := 0;
BEGIN
    SELECT count(*) INTO number_of_department_members FROM department_members WHERE department_id = department_number;

    UPDATE department SET number_of_employees = number_of_department_members WHERE id = department_number;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE update_all_department_sizes()
AS
$$
DECLARE
    department CURSOR FOR SELECT DISTINCT (id) AS id
                              FROM department;
BEGIN
    FOR item IN department
        LOOP
            CALL update_department_size(item.id);
        END LOOP;
END;

$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_all_department_sizes_trigger() RETURNS TRIGGER
AS
$$
BEGIN
    CALL update_all_department_sizes();
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_all_department_sizes_trigger
    AFTER INSERT OR DELETE OR UPDATE
    ON department_members
EXECUTE FUNCTION update_all_department_sizes_trigger();

COMMIT;
BEGIN;

CREATE OR REPLACE PROCEDURE update_colleagues(employee_number INTEGER)
AS
$$
DECLARE
    department_number INTEGER := 0;
    number            INTEGER := 0;
BEGIN
    SELECT department_id FROM department_members WHERE employee_id = employee_number INTO department_number;
    SELECT number_of_employees FROM department WHERE id = department_number INTO number;
    UPDATE employee SET number_of_colleagues = number - 1 WHERE id = employee_number;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE update_all_employee()
AS
$$
DECLARE
    employee CURSOR FOR SELECT DISTINCT(employee_id) AS id
                            FROM department_members;
BEGIN
    FOR item IN employee
        LOOP
            CALL update_colleagues(item.id);
        END LOOP;
END;
$$ LANGUAGE plpgsql;

COMMIT;

BEGIN;
CREATE OR REPLACE FUNCTION update_all_employee_trigger() RETURNS TRIGGER
AS
$$
BEGIN
    CALL update_all_employee();
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_all_employee_trigger
    AFTER INSERT OR DELETE OR UPDATE
    ON department_members
EXECUTE FUNCTION update_all_employee_trigger();

COMMIT;

BEGIN;

INSERT
    INTO employee(username, password, email)
    VALUES
        ('sikri', 'AnotherPassword', 'sikri@gmail.com'),
        ('teyson', 'AnotherPassword', 'teyson@gmail.com'),
        ('Nicky', 'AnotherPassword', 'Nicky@gmail.com'),
        ('Sapra', 'AnotherPassword', 'Sapra@gmail.com');

INSERT
    INTO department(name)
    VALUES
        ('Sales'),
        ('SoMo');

INSERT
    INTO department_members(employee_id, department_id)
    VALUES
        (9, 5),
        (10, 5),
        (11, 5),
        (12, 5);

BEGIN;
UPDATE department_members
SET
    department_id = 6
    WHERE employee_id = 10;

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM department_members;

ROLLBACK;
COMMIT;

BEGIN;

INSERT
    INTO employee(username, password, email)
    VALUES
        ('lol', 'AnotherPassword', 'lol@gmail.com'),
        ('lolo', 'AnotherPassword', 'lolo@gmail.com'),
        ('lollol', 'AnotherPassword', 'lollol@gmail.com'),
        ('lolpop', 'AnotherPassword', 'lolpop@gmail.com');

