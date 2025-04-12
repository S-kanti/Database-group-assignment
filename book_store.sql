-- create airbnb database
CREATE DATABASE bookStore;


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
        

    


  

