-- Project 3.0
Create database mortgage_loans;

use mortgage_loans;

create table mortgage_banker (emp_id int primary key,
employee_fname char(25) not null,
employee_lname char(25) not null,
branch_location char (6) not null,
branch_name char (15) null,
contact_info char(14) not null);
//**constraint of foreign key was established under employee id for the customer table. This case, the constraint key 
FK_LOAN_ORIGINATOR will tag the banker who originated the loan application. 
This is a real case use as we use loan app and loan originator to pay incentives**//

insert into mortgage_banker values (20,'Juan','Ramos','100000','Doral','305-550-0000');
insert into mortgage_banker values (21,'Jose','Pardo','100001','Kendall','305-550-0001');
insert into mortgage_banker values (22,'Eli','Barroso','100002','Key Largo','305-550-0002');
insert into mortgage_banker values (23,'John','Wick','100003','Brickell','305-550-0003');
insert into mortgage_banker values (24,'Jamy','Bangi','100003','Brickell','305-550-0003');
insert into mortgage_banker values (25,'Jake','Snake','100004','Downtown','305-550-0004');
insert into mortgage_banker values (26,'Miguel','Rollins','100000','Doral','305-550-0000');
insert into mortgage_banker values (27,'Sam','Adams','100005','Pinecrest','305-550-0005');
insert into mortgage_banker values (28,'Jimmy','Buffett','100006','C.Gables','305-550-0006');
insert into mortgage_banker values (29,'Gillian','Witt','100006','C.Gables','305-550-0006');


create table customers (customer_id char(10) primary key,
customer_fname char(25) not null,
customer_lname char(25) not null,
customer_phone char(14) not null,
emp_id int not null,
constraint FK_loan_originator foreign key(emp_id) references mortgage_banker(emp_id));

insert into customers values ('AU0000001','Mike','Tyson','786-550-0001',20);
insert into customers values ('AU0000002','Tyson','Fury','786-550-0002',21);
insert into customers values ('AU0000003','Nick','Fury','786-550-0003',22);
insert into customers values ('AU0000004','Bruce','Banner','786-550-0004',23);
insert into customers values ('AU0000005','Steve','Rogers','786-550-0005',24);
insert into customers values ('AU0000006','Tony','Stark','786-550-0006',25);
insert into customers values ('AU0000007','Wanda','Witch','786-550-0007',26);
insert into customers values ('AU0000008','Bruce','Wayne','786-550-0008',27);
insert into customers values ('AU0000009','Natasha','Romanof','786-550-0009',25);
insert into customers values ('AU0000010','Carol','Denvers','786-550-0010',29);


create table loans (application_id char (10) primary key,
loan_amount money not null,
loan_type char (10) not null,
loan_rate decimal (4) not null,
customer_id char (10) not null,
constraint FK_loan_closing foreign key (customer_id) references customers (customer_id));
alter table loans
	alter column loan_rate float not null;
-- comments : i couldnt figure out how to present interest rate column in a decimal format.--

insert into loans values ('10-000-001','120500','fixed',3.250,'AU0000001');
insert into loans values ('10-000-002','125500','fixed',3.250,'AU0000002');
insert into loans values ('10-000-003','140000','fixed',3.250,'AU0000003');
insert into loans values ('10-000-004','145000','fixed',3.250,'AU0000004');
insert into loans values ('10-000-005','145500','fixed',3.250,'AU0000005');
insert into loans values ('10-000-006','150500','variable',2.000,'AU0000006');
insert into loans values ('10-000-007','100500','variable',1.500,'AU0000007');
insert into loans values ('10-000-008','200000','variable',1.250,'AU0000008');
insert into loans values ('10-000-009','300000','fixed',3.250,'AU0000009');
insert into loans values ('10-000-010','350000','fixed',3.250,'AU0000010');


create table loans_booked (loan_number int primary key,
	customer_id char (10) not null,
	emp_id int not null,
	application_id char (10) not null,
	amount_financed money not null,
	loan_date datetime not null,
constraint FK_compensation foreign key (emp_id) references mortgage_banker (emp_id),
constraint FK_financing foreign key (application_id) references loans (application_id),
constraint FK_branch_pipeline foreign key (customer_id) references customers (customer_id));

insert into loans_booked values (100001,'AU000001',20,'10-000-001',100000,'2020.01.02');
insert into loans_booked values (100002,'AU000002',21,'10-000-002',110000,'2020.01.30');
insert into loans_booked values (100003,'AU000003',22,'10-000-003',120000,'2020.02.02');
insert into loans_booked values (100004,'AU000004',23,'10-000-004',100000,'2020.02.15');
insert into loans_booked values (100005,'AU000005',24,'10-000-005',100000,'2020.03.15');
insert into loans_booked values (100006,'AU000006',25,'10-000-006',180000,'2020.05.20');
insert into loans_booked values (100007,'AU000007',26,'10-000-007',110000,'2020.07.01');
insert into loans_booked values (100008,'AU000008',27,'10-000-008',111000,'2020.08.01');
insert into loans_booked values (100009,'AU000009',25,'10-000-009',200000,'2020.10.02');
insert into loans_booked values (100010,'AU0000010',29,'10-000-010',200000,'2020.11.30');

select *from loans_booked where amount_financed =110000;-- this query returns all results for loans
--financed for $110,000
select *from loans_booked where emp_id = 25; -- this query returns all results for loans booked under employee_id (25)
select *from loans where loan_rate = 3.250; -- this query returns all results for loans with a rate of 3.250


-- Now this query will join tables to obtain the loan_number, application_id, amount_financed and loan amount for every mortgage loan over $150K
select loans_booked.loan_number,loans_booked.amount_financed,loans.application_id,loans.loan_amount
from loans_booked join loans
on loans_booked.application_id=loans.application_id
where loan_amount > 150000;

update loans_booked set amount_financed=222999;
select *from loans_booked;

use master;
BACKUP DATABASE mortgage_loans to disk='c:\tmp\mortgage.bak' with init, compression; 
-- I was unable to find the correct temp folder for back up so decided to do it with other method via prompt

	