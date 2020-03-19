CREATE TABLE room_types(
   id serial PRIMARY KEY,
   name VARCHAR (50) NOT NULL
);

INSERT INTO room_types (name) VALUES ('Office');
INSERT INTO room_types (name) VALUES ('Normal');
INSERT INTO room_types (name) VALUES ('Two Bed');
INSERT INTO room_types (name) VALUES ('Special');

CREATE TABLE rooms(
   id serial PRIMARY KEY,
   name VARCHAR (50) NOT NULL,
   room_type_id integer NOT NULL REFERENCES room_types (id)
);

INSERT INTO rooms (name, room_type_id) VALUES ('U45', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('U32', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('U186', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('U150', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('R2', 2);
INSERT INTO rooms (name, room_type_id) VALUES ('R4', 3);
INSERT INTO rooms (name, room_type_id) VALUES ('R5', 4);
INSERT INTO rooms (name, room_type_id) VALUES ('R6', 4);

CREATE TABLE positions(
   id serial PRIMARY KEY,
   designation VARCHAR (100) NOT NULL,
   charges_per_hour FLOAT NOT NULL
);

INSERT INTO positions (designation, charges_per_hour) VALUES ('Professor', 5000);
INSERT INTO positions (designation, charges_per_hour) VALUES ('Assistant Professor', 3000);


CREATE TABLE departments(
   id serial PRIMARY KEY,
   name VARCHAR (100) NOT NULL
);

INSERT INTO departments (name) VALUES ('Neurology');
INSERT INTO departments (name) VALUES ('Orthopedic');
INSERT INTO departments (name) VALUES ('ENT/Neurology');
INSERT INTO departments (name) VALUES ('Skin/Orthepoedic');

CREATE TABLE employees(
   id serial PRIMARY KEY,
   name VARCHAR(200) NOT NULL,
   phone INTEGER NOT NULL,
   position_id integer NOT NULL REFERENCES positions (id),
   department_id integer NOT NULL REFERENCES departments (id),
   room_id integer NOT NULL REFERENCES rooms (id)
);

INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Peterson', '12341234', 1, 1, 1);
INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Jensen', '23452345', 1, 2, 2);
INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Poetch', '34563456', 2, 3, 3);
INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Neurenheim', '45674567', 2, 4, 4);

CREATE TABLE beds(
   id serial PRIMARY KEY,
   bed_number VARCHAR (50) UNIQUE NOT NULL
);

INSERT INTO beds (bed_number) VALUES ('B1');
INSERT INTO beds (bed_number) VALUES ('B5');
INSERT INTO beds (bed_number) VALUES ('B7');
INSERT INTO beds (bed_number) VALUES ('B8');
INSERT INTO beds (bed_number) VALUES ('B9');

CREATE TABLE patients(
   id serial PRIMARY KEY,
   name VARCHAR (100) NOT NULL,
   phone VARCHAR (50) NOT NULL,
   cpr_number CHAR (11) UNIQUE NOT NULL
);

INSERT INTO patients (name, phone, cpr_number) VALUES ('Jan', '190582-1113', '98769876');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Peter', '300175-2359', '87658765');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Jens', '041298-1257', '76547654');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Ole', '051165-9863', '65436543');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Anna', '260792-1050', '54325432');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Dennis', '150893-1151', '43214321');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Ahmed', '010211-7853', '32103210');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Annika', '051285-8072', '21092109');

CREATE TABLE admissions (
   id serial PRIMARY KEY,
   patient_id integer NOT NULL REFERENCES patients (id),
   room_id integer NOT NULL REFERENCES rooms (id),
   bed_id integer NOT NULL REFERENCES beds (id),
   assigned_employee_id integer NOT NULL REFERENCES employees (id)
);

INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (1, 5, 1, 1); -- jan, room r2, bed b1
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (2, 5, 1, 1); -- peter, room r2, bed b1
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (4, 5, 1, 2); -- ole, room r2, bed b1
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (3, 6, 2, 2); -- jens, room r4, bed b5
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (5, 6, 3, 2); -- anna, room r4, bed b7
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (1, 7, 4, 3); -- jan, room r5, bed b8
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (8, 8, 5, 4); -- annika, room r6, bed b9


