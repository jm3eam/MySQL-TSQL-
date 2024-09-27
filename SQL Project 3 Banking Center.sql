-- PROJECT 3

Create database banking_center;

use banking_center;

--In this database we are going to have employees,customers,loan product and loan transaction.
--I am assuming that every employee is a mortgage banker.
--The table loan_closing is my transaction table(fact table). 

create table mortage_banker(emp_id char(12) primary key,--The primary key is employee id
F_name char(25) not null,
L_name char(25) not null,
contact_info char(14) not null);--The only contact info that we gather is the phone number (cell)

create table customers (customer_loan_no char(10) primary key,
customer_fname char(25) not null,
customer_lname char(25) not null,
customer_address char (35) not null,
zip_code int null,
contact_no char(14) not null);

create table loan_product (product_id char(9) primary key,
loan_term int not null,
loan_type int not null,
application_enter_date datetime not null);

drop table loan_product;

create table loan_product (product_id char (9) primary key,
	loan_term int not null,
	loan_type int not null,
	application_date datetime not null);


create table loan_closing (application_id char (6) primary key,
loan_amount money not null,
loan_rate decimal not null
closing_date datetime not null,

emp_id char(12) not null,
constraint 