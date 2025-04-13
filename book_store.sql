<<<<<<< HEAD
-- Create and work on the bookStore database
CREATE DATABASE BookStoreDB;
USE BookStoreDB;

-- 1. Create the Countries table
CREATE TABLE Countries (
    Country_ID INT PRIMARY KEY AUTO_INCREMENT,
    Country_Name VARCHAR(255)
=======
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
>>>>>>> f6f04c138d8f9c420b5e1b8d6b9b61f5f07125a7
);

-- 2. Create the Address_Status table
CREATE TABLE Address_Status (
    Address_Status_ID INT PRIMARY KEY AUTO_INCREMENT,
    Status_Name VARCHAR(255)
);

-- 3. Create the Book_Languages table
CREATE TABLE Book_Languages (
    Language_ID INT PRIMARY KEY,
    Language_Name VARCHAR(50)
);

-- 4. Create the Authors table
CREATE TABLE Authors (
    Author_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT,
    Gender VARCHAR(50)
);

-- 5. Create the Publishers table
CREATE TABLE Publishers (
    Publisher_ID INT PRIMARY KEY,
    Country_ID INT,
    Name VARCHAR(100),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);

-- 6. Create the Books table
CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Author_ID INT,
    Language_ID INT,
    Stock_Quantity INT,
    Year_of_Publish INT,
    Publisher_ID INT,
    Price DECIMAL,
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID),
    FOREIGN KEY (Language_ID) REFERENCES Book_Languages(Language_ID),
    FOREIGN KEY (Publisher_ID) REFERENCES Publishers(Publisher_ID)
);

-- 7. Create the Book_Author table (if needed for many-to-many)
CREATE TABLE Book_Authors (
    Book_ID INT,
    Author_ID INT,
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID),
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID)
);

-- 8. Create the Customers table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(255),
    Age INT,
    Email VARCHAR(255),
    Phone VARCHAR(20)
);

-- 9. Create the Addresses table
CREATE TABLE Addresses (
<<<<<<< HEAD
    Address_ID INT PRIMARY KEY,
    Country_ID INT,
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    FOREIGN KEY (Country_ID) REFERENCES Countries(Country_ID)
);

-- 10. Create the Customer_Address table
CREATE TABLE Customer_Addresses (
    Customer_ID INT,
    Address_ID INT,
    Address_Status_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Address_ID) REFERENCES address(Address_ID),
    FOREIGN KEY (Address_status_ID) REFERENCES Address_Status(Address_Status_ID)
);

-- 11. Create the Shipping_Method table
CREATE TABLE Shipping_Method (
    Shipping_Method_ID INT PRIMARY KEY AUTO_INCREMENT,
    Method_Name VARCHAR(255),
    Cost DECIMAL(10,2)
);

-- 12. Create the Order_Status table
CREATE TABLE Order_Status (
    Order_Status_ID INT PRIMARY KEY AUTO_INCREMENT,
    Status_Name VARCHAR(255)
);

-- 13. Create the customer_orders table
CREATE TABLE Customer_Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT,
    Order_Date DATE,
    Shipping_Method_ID INT,
    Order_Status_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Shipping_Method_ID) REFERENCES Shipping_Method(Shipping_Method_ID),
    FOREIGN KEY (Order_Status_ID) REFERENCES Order_Status(Order_Status_ID)
);

-- 14. Create the Order_Lines table
CREATE TABLE Order_Lines (
    Order_Line_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT,
    Book_ID INT,
    Quantity INT,
    Unit_price DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Customer_Orders(Order_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

-- 15. Create the Order_History table
CREATE TABLE Order_History (
    Order_History_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT,
    Order_Status_ID INT,
    Status_Date DATETIME,
    FOREIGN KEY (Order_ID) REFERENCES Customer_Orders(Order_ID),
    FOREIGN KEY (Order_Status_ID) REFERENCES Order_Status(Order_Status_ID)
);

-- Managing database access through user groups and roles to ensure security

USE BookstoreDB; 

CREATE ROLE Admin;
CREATE ROLE Sales;
CREATE ROLE Manager;
CREATE ROLE Customer_care;

-- Create users
CREATE USER 'sarah'@'%' IDENTIFIED BY 'password123';  -- Sales
CREATE USER 'abigael'@'%' IDENTIFIED BY 'securepass';    -- Manager
CREATE USER 'arwa'@'%' IDENTIFIED BY 'pass456';     -- Customer care

-- Assign roles
GRANT Sales TO 'sarah'@'%';
GRANT Manager TO 'abigael'@'%';
GRANT Customer_Care TO 'arwa'@'%';

-- Activate roles by default
SET DEFAULT ROLE Sales TO 'sarah'@'%';
SET DEFAULT ROLE Manager TO 'abigael'@'%';
SET DEFAULT ROLE Customer_Care TO 'arwa'@'%';

-- Admin has full access
GRANT ALL PRIVILEGES ON BookstoreDB.* TO admin;

-- Sales: Can access customer, Customer_order, order_line
GRANT SELECT, INSERT, UPDATE ON BookstoreDB.cCstomers TO sales;
GRANT SELECT, INSERT, UPDATE ON BookstoreDB.Customer_Orders TO sales;
GRANT SELECT, INSERT ON BookstoreDB.Order_Lines TO Sales;

-- Manager: Can manage books and stock
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.Books TO Manager;
GRANT SELECT ON BookstoreDB.Publishers TO Manager;
GRANT SELECT ON BookstoreDB.Authors TO Manager;

-- Customer Service: Can only read customer and order info
GRANT SELECT ON BookstoreDB.Customers TO Customer_Care;
GRANT SELECT ON BookstoreDB.Order_Status TO Customer_Care;

-- Show all roles
SELECT role, host FROM mysql.role;

-- querying the data to extract meaningful insights

-- 1 Get Total Number of Orders
SELECT COUNT(*) AS Total_Orders FROM Customer_Orders;
 
-- 2. Get Customers with Most Orders
SELECT c.Customer_Name, COUNT(co.Order_ID) AS Orders_Count
FROM Customers c
JOIN Customer_Orders co ON co.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Orders_Count DESC
LIMIT 5;

-- 3.Get orders by status
SELECT os.status_name, COUNT(*) AS Total_Orders
FROM Customer_Orders co
JOIN Order_Status os ON co.Order_Status_ID = os.Order_Status_ID
GROUP BY os.Status_Name;
=======
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



USE bookstore; 
 
CREATE TABLE Customer_Address(
    customer_id INT,
	address_id INT,
	address_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (address_id) REFERENCES Addresses(address_id),
    FOREIGN KEY (address_status_id ) REFERENCES Address_Status(address_status_id )
    );
    
CREATE TABLE Address_Status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(255)
    );
    
CREATE  TABLE Countries(
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    countryName VARCHAR(255)
    );
    
CREATE TABLE customer_orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    order_status_id INT,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (shipping_method_id) REFERENCES Shipping_Method(shipping_method_id),
    FOREIGN KEY (order_status_id ) REFERENCES Order_Status(order_status_id )
    
    );
    
CREATE TABLE Order_Lines(
     order_line_id INT PRIMARY KEY AUTO_INCREMENT,
     order_id INT,
     book_id INT,
     quantity INT,
	 unit_price DECIMAL(10,2),
     FOREIGN KEY ( order_id) REFERENCES customer_orders( order_id),
	 FOREIGN KEY (book_id ) REFERENCES book(book_id )
);
CREATE TABLE Order_History(
     order_history_id INT PRIMARY KEY AUTO_INCREMENT,
     order_id  INT,
     order_status_id INT,
	 status_date DATETIME,
	 FOREIGN KEY ( order_id) REFERENCES customer_orders( order_id),
	 FOREIGN KEY (order_status_id ) REFERENCES OrderStatus(order_status_id )
);
 
 CREATE TABLE Shipping_Method (
      shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
      method_name VARCHAR(255),
	  cost DECIMAL(10,2)
 );
 
 CREATE TABLE Order_Status (
       order_status_id INT PRIMARY KEY AUTO_INCREMENT,
       status_name VARCHAR(255)
 );
        

    


  


>>>>>>> f6f04c138d8f9c420b5e1b8d6b9b61f5f07125a7
