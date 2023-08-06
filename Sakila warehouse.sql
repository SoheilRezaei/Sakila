--Staging query for customer

--CREATE DATABASE [sakila-warehouse]
--USE [sakila-warehouse]
CREATE TABLE customer_staging(
	[first_name] [varchar](45) NOT NULL,
	[last_name] [varchar](45) NOT NULL,
	[active] [char](1) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[country] [varchar](50) NOT NULL
)

go

--Staging for store

-- Create staging table for store
CREATE TABLE store_staging (
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
go

--Staging for staff

-- Create staging table for staff
CREATE TABLE staff_staging (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

go
--Staging for Film
-- Create Staging table for film

CREATE TABLE film_staging (
    title VARCHAR(255),
    description TEXT,
    release_year INT,
    film_language VARCHAR(50),
    rental_duration INT,
    rental_rate DECIMAL(4,2),
	film_duration INT,
    replacement_cost DECIMAL(5,2),
    rating VARCHAR(10),
    film_category VARCHAR(50)
);

go


--Staging for rental

--create staging table for rental
CREATE TABLE rental_staging (
    customer_firstname VARCHAR(50),
    customer_lastname VARCHAR(50),
    staff_firstname VARCHAR(50),
    staff_lastname VARCHAR(50),
    film_name VARCHAR(255),
    store_address VARCHAR(100),
    rental_date DATETIME,
    return_date DATETIME,
	actor_firstname VARCHAR(50),
    actor_lastname VARCHAR(50)
);

go

--staff dimension

CREATE TABLE staff_dim (
	staff_key INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
	startdate DATETIME,
	enddate DATETIME
);





--creating dimesntion

--create customer dim
CREATE TABLE [dbo].[customer_dim](
	customer_key INT IDENTITY PRIMARY KEY,
	[first_name] [varchar](45) NOT NULL,
	[last_name] [varchar](45) NOT NULL,
	[active] [char](1) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[city] [varchar](50) NOT NULL,
	[country] [varchar](50) NOT NULL,
	startdate DATETIME,
	enddate DATETIME
)
go

-- Create Store dimension
CREATE TABLE store_dim (
	store_key INT IDENTITY PRIMARY KEY,
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);


go

-- Create Actor dimension
CREATE TABLE actor_dim (
	actor_key INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
	fullname VARCHAR(100)
);

go

--Create Date dimension

CREATE TABLE date_dim (
	datekey INT IDENTITY PRIMARY KEY,
	date DATETIME,
	year INT,
	month INT,
	day INT
)

go

-- Create film dimension


CREATE TABLE film_dim (
	film_key INT IDENTITY PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    release_year INT,
    film_language VARCHAR(50),
    rental_duration INT,
    rental_rate DECIMAL(4,2),
	film_duration INT,
    replacement_cost DECIMAL(5,2),
    rating VARCHAR(10),
    film_category VARCHAR(50)
);

go

CREATE TABLE rental_fact (
	customer_key INT NOT NULL,
	staff_key INT NOT NULL,
	film_key INT NOT NULL,
    store_key INT NOT NULL,
    rental_date INT,
    return_date INT,
	actor_key INT NOT NULL,
	total_days_rented INT,
	total_cost INT,
	CONSTRAINT FK_custKey FOREIGN KEY (customer_key) references customer_dim (customer_key),
	CONSTRAINT FK_Stffkey FOREIGN KEY (staff_key) references staff_dim (staff_key),
	CONSTRAINT FK_filmkey FOREIGN KEY (film_key) references film_dim (film_key),
	CONSTRAINT FK_retnkey FOREIGN KEY (return_date) references date_dim (datekey),
	CONSTRAINT FK_rendatetkey FOREIGN KEY (rental_date) references date_dim (datekey),
	CONSTRAINT FK_actrkey FOREIGN KEY (actor_key) references actor_dim (actor_key),
	CONSTRAINT FK_strekey FOREIGN KEY (store_key) references store_dim (store_key)
);

go

