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
    language_id INT PRIMARY KEY,
    language_name VARCHAR(50)
);

-- 4. Create the Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    gender VARCHAR(50)
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
    book_id INT PRIMARY KEY,
    author_id INT,
    language_id INT,
    stock_quantity INT,
    year_of_publish INT,
    publisher_id INT,
    price DECIMAL,
    FOREIGN KEY (Author_id) REFERENCES authors(author_id),
    FOREIGN KEY (Language_id) REFERENCES book_Languages(language_id),
    FOREIGN KEY (Publisher_id) REFERENCES publishers(publisher_id)
);

-- 7. Create the Book_Author table (if needed for many-to-many)
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- 8. Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_Name VARCHAR(255),
    age INT,
    email VARCHAR(255),
    phone VARCHAR(20)
);

-- 9. Create the Addresses table
CREATE TABLE Addresses (
    address_id INT PRIMARY KEY,
    country_id INT,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
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
CREATE TABLE Customer_orders (
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

-- Managing database access through user groups and roles to ensure security

USE bookstore; 

CREATE ROLE admin;
CREATE ROLE sales;
CREATE ROLE manager;
CREATE ROLE customer_care;

-- Create users
CREATE USER 'sarah'@'%' IDENTIFIED BY 'password123';  -- Sales
CREATE USER 'abigael'@'%' IDENTIFIED BY 'securepass';    -- Manager
CREATE USER 'arwa'@'%' IDENTIFIED BY 'pass456';     -- Customer care

-- Assign roles
GRANT sales TO 'sarah'@'%';
GRANT manager TO 'abigael'@'%';
GRANT customer_care TO 'arwa'@'%';

-- Activate roles by default
SET DEFAULT ROLE sales TO 'sarah'@'%';
SET DEFAULT ROLE manager TO 'abigael'@'%';
SET DEFAULT ROLE customer_care TO 'arwa'@'%';

-- Admin has full access
GRANT ALL PRIVILEGES ON bookstore_db.* TO admin;

-- Sales: Can access customer, cust_order, order_line
GRANT SELECT, INSERT, UPDATE ON bookstore.customers TO sales;
GRANT SELECT, INSERT, UPDATE ON bookstore.cust_order TO sales;
GRANT SELECT, INSERT ON bookstore.order_lines TO sales;

-- Manager: Can manage books and stock
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.book TO manager;
GRANT SELECT ON bookstore.publisher TO manager;
GRANT SELECT ON bookstore.author TO manager;

-- Customer Service: Can only read customer and order info
GRANT SELECT ON bookstore.customers TO customer_care;
GRANT SELECT ON bookstore.order_status TO customer_care;

-- Show all roles
SELECT role, host FROM mysql.role;

-- querying the data to extract meaningful insights

-- 1 Get Total Number of Orders
SELECT COUNT(*) AS total_orders FROM customer_orders;
 
-- 2. Get customers with Most Orders
SELECT c.Customer_Name, COUNT(co.order_id) AS orders_count
FROM Customers c
JOIN customer_orders co ON co.customer_id = c.Customer_id
GROUP BY c.Customer_Name
ORDER BY orders_count DESC
LIMIT 5;

-- 3.Get orders by status
SELECT os.status_name, COUNT(*) AS total_orders
FROM customer_orders co
JOIN Order_Status os ON co.order_status_id = os.order_status_id
GROUP BY os.status_name;
