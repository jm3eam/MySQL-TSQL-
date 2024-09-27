-- Project 3.0
Create database mortgage_bank;

use mortgage_bank;

--In this database we are going to have employees,customers,loan product and loan transaction.
--I am assuming that every employee is a mortgage banker.
--The table loan_closing is my transaction table(fact table). 

create table mortgage_banker (emp_id char(12) primary key, --The primary key is employee id
employee_fname char(25) not null,
employee_lname char(25) not null,
branch_location char (15) not null,
contact_info char(14) not null);--The only contact info that we gather is the phone number (cell)

create table customers (application_id char(10) primary key,
customer_fname char(25) not null,
customer_lname char(25) not null,
customer_address char (35) not null,
zip_code int null,
contact_info char(14) not null);


create table loan_product (product_id char (9) primary key,
	loan_term int not null,
	loan_type int not null,
	application_date datetime not null);
	---- ** I had made a mistake in assigning the correct data into table. I had crossed info on loan closing
	-- table and loan product table. I had to go back and alter the table to add a new columnn.--

select *from loan_product;
alter table loan_product add property_type char (10) not null;
	

create table loan_closing (loan_id char (6) primary key,