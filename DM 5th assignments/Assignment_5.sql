begin;

create table employee
(
    id                   serial primary key,
    username             varchar(255) not null unique,
    password             varchar(255) not null,
    email                varchar(255) not null unique,
    number_of_colleagues integer
);

create table department
(
    id                  serial primary key,
    name                varchar(50) not null unique,
    number_of_employees integer

);

create table department_members
(
    employee_id   integer references employee (id),
    department_id integer references department (id),
    primary key (employee_id, department_id)
);

commit;

create unique index on employee (email);

begin;

create or replace procedure update_department_size(department_number integer)
as
$$
declare
    number_of_department_members integer := 0;
begin
    select count(*) into number_of_department_members from department_members where department_id = department_number;

    update department set number_of_employees = number_of_department_members where id = department_number;
end;
$$
    language plpgsql;

create or replace procedure update_all_department_sizes()
as
$$
declare
    department cursor for select distinct (id) as id
                          from department;
begin
    for item in department
        loop
            call update_department_size(item.id);
        end loop;
end;

$$
    language plpgsql;

create or replace function update_all_department_sizes_trigger() returns trigger
as
$$
begin
    call update_all_department_sizes();
    return null;
end;
$$
    language plpgsql;

create trigger update_all_department_sizes_trigger
    after insert or delete or update
    on department_members
execute function update_all_department_sizes_trigger();

commit;
begin;

create or replace procedure update_colleagues(employee_number integer)
as
$$
declare
    department_number integer := 0;
    number integer := 0;
begin
    select department_id from department_members where employee_id = employee_number into department_number;
    select number_of_employees from department where id = department_number into number;
    update employee
    set number_of_colleagues = number - 1
    where id = employee_number;
end;
$$
    language plpgsql;

create or replace procedure update_all_employee()
as
$$
declare
    employee cursor for select distinct(employee_id) as id
                        from department_members;
begin
    for item in employee loop
        call update_colleagues(item.id);
        end loop;
end;
$$
    language plpgsql;

commit;

begin;
create or replace function update_all_employee_trigger()
    returns trigger
as
$$
begin
    call update_all_employee();
    return null;
end;
$$
    language plpgsql;

create trigger update_all_employee_trigger
    after insert or delete or update
    on department_members
execute function update_all_employee_trigger();

commit;

begin;

insert into employee(username, password, email)
values ('sikri', 'AnotherPassword', 'sikri@gmail.com');
insert into employee(username, password, email)
values ('teyson', 'AnotherPassword', 'teyson@gmail.com');
insert into employee(username, password, email)
values ('Nicky', 'AnotherPassword', 'Nicky@gmail.com');
insert into employee(username, password, email)
values ('Sapra', 'AnotherPassword', 'Sapra@gmail.com');

insert into department(name)
values ('Sales');
insert into department(name)
values ('SoMo');

insert into department_members(employee_id,department_id) values (9, 5);
insert into department_members(employee_id,department_id) values (10, 5);
insert into department_members(employee_id,department_id) values (11, 6);
insert into department_members(employee_id,department_id) values (12, 5);

begin;
update department_members set department_id = 6 where employee_id = 10;

select * from employee;
select * from department;
select * from department_members;
commit;

