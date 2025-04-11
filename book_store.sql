-- Create the boook_store database
CREATE DATABASE bookStore;
--1. Create the Books table 
CREATE TABLE Books (
    -- Unique identifier for each book.
    Book_id INT PRIMARY KEY,
    -- Foreign key referencing the Author_id in the Authors table.
    Author_id INT REFERENCES Authors (Author_id),
    -- Foreign key referencing the Language-id in the Languages table.
    Language_id INT,
    -- The number of copies of the book in stock.
    Stock_quantity INT,
    -- The year the book was published.
    Year_of_publish INT,
    -- Foreign key referencing publisher-id table.
    Publisher_id INT REFERENCES Publishers (publisher_id),
    -- The price of the book.
    Price DECIMAL
);
-- 2. Create the Authors table to store information about authors.
CREATE TABLE Authors (
    -- A Unique ID for each author.
    Author_id INT PRIMARY KEY,
    -- Full name of the author.
    name VARCHAR(255),
    -- Age of the author in years.
    Age INT,
    -- Gender of the author
    Gender VARCHAR(50)
);
-- 3. Creating a table for book authors
CREATE TABLE Book_Author (
    -- Foreign key referencing the Book-id in the Books table
    Book_id INT REFERENCES Books (Book_id),
    -- Foreign key referencing the Author-id in the Authors table
    Author_id INT REFERENCES Authors (Author_id),
);
--4. Create the Publishers' table
CREATE TABLE Publishers (
    --Unique identifier for book publisher
    Publisher_id INT PRIMARY KEY,
    --Foreign key referencing the Countries
    Country_id INT REFERENCES Countries (country_id),
    --Name of the publisher
    name VARCHAR(100)
);
--5. Create the Book_Lanugages table.
CREATE TABLE Book_Languages (
    --Unique identifier for the language
    Language_id PRIMARY KEY,
    --language which the book is written
    Lang VARCHAR(50),
);
-- 6. Create the Customers table to store customer information.
CREATE TABLE Customers (
    -- Unique identifier for each customer.
    Customer_id INT PRIMARY KEY,
    -- Name of the customer.
    Customer_Name VARCHAR(255),
    -- Age of the customer.
    Age INT,
    -- Email address of the customer.
    Email VARCHAR(255),
    -- Phone number of the customer.
    Phone VARCHAR(20)
);
-- 7. Table to store address information
CREATE TABLE Addresses (
    -- Unique identifier for each address
    Address_id INT PRIMARY KEY, 
    -- Foreign key referencing the Countries table
    Country_id INT REFERENCES Countries (country_id),             
    -- Street address
    Street VARCHAR(255), 
     -- Name of the city       
    City VARCHAR(100),  
    --Name of the state
    State VARCHAR(100),  
    --Postal code       
    Postal_code VARCHAR(20),
);