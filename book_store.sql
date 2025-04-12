-- Create the bookStore database
CREATE DATABASE bookStore1;
USE bookStore1;

-- 1. Create the Countries table
CREATE TABLE Countries (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    countryName VARCHAR(255)
);

-- 2. Create the Address_Status table
CREATE TABLE Address_Status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255)
);

-- 3. Create the Book_Languages table
CREATE TABLE Book_Languages (
    Language_id INT PRIMARY KEY,
    Lang VARCHAR(50)
);

-- 4. Create the Authors table
CREATE TABLE Authors (
    Author_id INT PRIMARY KEY,
    name VARCHAR(255),
    Age INT,
    Gender VARCHAR(50)
);

-- 5. Create the Publishers table
CREATE TABLE Publishers (
    Publisher_id INT PRIMARY KEY,
    Country_id INT,
    name VARCHAR(100),
    FOREIGN KEY (Country_id) REFERENCES Countries(country_id)
);

-- 6. Create the Books table
CREATE TABLE Books (
    Book_id INT PRIMARY KEY,
    Author_id INT,
    Language_id INT,
    Stock_quantity INT,
    Year_of_publish INT,
    Publisher_id INT,
    Price DECIMAL,
    FOREIGN KEY (Author_id) REFERENCES Authors(Author_id),
    FOREIGN KEY (Language_id) REFERENCES Book_Languages(Language_id),
    FOREIGN KEY (Publisher_id) REFERENCES Publishers(Publisher_id)
);

-- 7. Create the Book_Author table (if needed for many-to-many)
CREATE TABLE Book_Author (
    Book_id INT,
    Author_id INT,
    FOREIGN KEY (Book_id) REFERENCES Books(Book_id),
    FOREIGN KEY (Author_id) REFERENCES Authors(Author_id)
);

-- 8. Create the Customers table
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Age INT,
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

-- 9. Create the Addresses table
CREATE TABLE Addresses (
    Address_id INT PRIMARY KEY,
    Country_id INT,
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_code VARCHAR(20),
    FOREIGN KEY (Country_id) REFERENCES Countries(country_id)
);

-- 10. Create the Customer_Address table
CREATE TABLE Customer_Address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (address_id) REFERENCES Addresses(Address_id),
    FOREIGN KEY (address_status_id) REFERENCES Address_Status(address_status_id)
);

-- 11. Create the Shipping_Method table
CREATE TABLE Shipping_Method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(255),
    cost DECIMAL(10,2)
);

-- 12. Create the Order_Status table
CREATE TABLE Order_Status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255)
);

-- 13. Create the customer_orders table
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES Shipping_Method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES Order_Status(order_status_id)
);

-- 14. Create the Order_Lines table
CREATE TABLE Order_Lines (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(Book_id)
);

-- 15. Create the Order_History table
CREATE TABLE Order_History (
    order_history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    order_status_id INT,
    status_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
    FOREIGN KEY (order_status_id) REFERENCES Order_Status(order_status_id)
);
