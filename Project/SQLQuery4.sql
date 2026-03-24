create database FinalProject;

use FinalProject;

-- 1. Roles
CREATE TABLE Roles (
    id INT PRIMARY KEY IDENTITY(1,1),
    role VARCHAR(255)
);

-- 2. Users
CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    roleID INT,
    CONSTRAINT fk_Users_roleID_Roles
        FOREIGN KEY (roleID) REFERENCES Roles(id)
);

select * from Users;

-- 3. Customer
CREATE TABLE Customer (
    id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone VARCHAR(255),
    CONSTRAINT fk_Customer_id_Users
        FOREIGN KEY (id) REFERENCES Users(id)
);

ALTER TABLE Customer
ADD profileImage VARCHAR(255) NULL;
select * from Customer
-- 4. Address
CREATE TABLE Address (
    id INT PRIMARY KEY IDENTITY(1,1),
    customerID INT,
    AddressLine VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
    CONSTRAINT fk_Address_customerID_Customer
        FOREIGN KEY (customerID) REFERENCES Customer(id)
);

-- 5. Categories
CREATE TABLE categories (
    id INT PRIMARY KEY IDENTITY(1,1),
    categoryName VARCHAR(255)
);

-- 6. Products
CREATE TABLE Products (
    id INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(255),
    description VARCHAR(255),
    categoryID INT,
    Gender VARCHAR(255),
    Price DECIMAL(18,2),
    Quantity INT,
    CONSTRAINT fk_Products_categoryID_categories
        FOREIGN KEY (categoryID) REFERENCES categories(id)
);

ALTER TABLE Products
ADD image_path VARCHAR(255);

-- 7. Cart
CREATE TABLE Cart (
    id INT PRIMARY KEY IDENTITY(1,1),
    customerID INT,
    CONSTRAINT fk_Cart_customerID_Customer
        FOREIGN KEY (customerID) REFERENCES Customer(id)
);

-- 8. cartItems
CREATE TABLE cartItems (
    id INT PRIMARY KEY IDENTITY(1,1),
    cartID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT fk_cartItems_cartID_Cart
        FOREIGN KEY (cartID) REFERENCES Cart(id),
    CONSTRAINT fk_cartItems_ProductID_Products
        FOREIGN KEY (ProductID) REFERENCES Products(id)
);

-- 9. OrderStatus
CREATE TABLE OrderStatus (
    id INT PRIMARY KEY IDENTITY(1,1),
    orderName VARCHAR(255)
);



-- 10. Orders
CREATE TABLE Orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    AddressID INT,
    StatusID INT,
    Payment VARCHAR(255),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18,2),
    OTP VARCHAR(255),
    OTPVerified BIT,
    CONSTRAINT fk_Orders_CustomerID_Customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(id),
    CONSTRAINT fk_Orders_AddressID_Address
        FOREIGN KEY (AddressID) REFERENCES Address(id),
    CONSTRAINT fk_Orders_StatusID_OrderStatus
        FOREIGN KEY (StatusID) REFERENCES OrderStatus(id)
);

-- 11. OrderItems
CREATE TABLE OrderItems (
    id INT PRIMARY KEY IDENTITY(1,1),
    orderID INT,
    ProductID INT,
    Quantity INT,
    unitPrice DECIMAL(18,2),
    CONSTRAINT fk_OrderItems_orderID_Orders
        FOREIGN KEY (orderID) REFERENCES Orders(id),
    CONSTRAINT fk_OrderItems_ProductID_Products
        FOREIGN KEY (ProductID) REFERENCES Products(id)
);

select * from Orders
update orders
set StatusID = 4;
select * from OrderStatus

update OrderStatus
set orderName = 'Delivered'
where id = 4;

delete from OrderStatus
where id >= 5;

select * from OrderItems;

INSERT INTO Roles (role)
VALUES 
('admin'),
('user');



INSERT INTO Users (name, email, password, roleID) VALUES
-- Admin Accounts
('Admin One', 'admin1@example.com', 'admin123', 1),
('Admin Two', 'admin2@example.com', 'admin123', 1),

-- Customer Accounts
('Rahul Sharma', 'rahul@example.com', 'user123', 2),
('Priya Verma', 'priya@example.com', 'user123', 2),
('Amit Patel', 'amit@example.com', 'user123', 2),
('Sneha Reddy', 'sneha@example.com', 'user123', 2),
('Arjun Mehta', 'arjun@example.com', 'user123', 2),
('Neha Singh', 'neha@example.com', 'user123', 2),
('Vikram Joshi', 'vikram@example.com', 'user123', 2),
('Pooja Nair', 'pooja@example.com', 'user123', 2);


INSERT INTO Customer (id, first_name, last_name, phone) VALUES
(3, 'Rahul', 'Sharma', '9876543210'),
(4, 'Priya', 'Verma', '9876543211'),
(5, 'Amit', 'Patel', '9876543212'),
(6, 'Sneha', 'Reddy', '9876543213'),
(7, 'Arjun', 'Mehta', '9876543214'),
(8, 'Neha', 'Singh', '9876543215'),
(9, 'Vikram', 'Joshi', '9876543216'),
(10, 'Pooja', 'Nair', '9876543217');


INSERT INTO Address (customerID, AddressLine, City, State, PostalCode, Country) VALUES
-- Rahul Sharma (id = 3)
(3, 'Flat 101, Green Residency', 'Bangalore', 'Karnataka', '560001', 'India'),
(3, 'Office 12, Tech Park', 'Bangalore', 'Karnataka', '560048', 'India'),

-- Priya Verma (id = 4)
(4, '12 MG Road', 'Mumbai', 'Maharashtra', '400001', 'India'),

-- Amit Patel (id = 5)
(5, '45 SG Highway', 'Ahmedabad', 'Gujarat', '380015', 'India'),

-- Sneha Reddy (id = 6)
(6, 'Plot 22, Jubilee Hills', 'Hyderabad', 'Telangana', '500033', 'India'),

-- Arjun Mehta (id = 7)
(7, '78 Connaught Place', 'Delhi', 'Delhi', '110001', 'India'),

-- Neha Singh (id = 8)
(8, '221 Park Street', 'Kolkata', 'West Bengal', '700016', 'India'),

-- Vikram Joshi (id = 9)
(9, '14 FC Road', 'Pune', 'Maharashtra', '411004', 'India'),

-- Pooja Nair (id = 10)
(10, '9 Marine Drive', 'Mumbai', 'Maharashtra', '400002', 'India'),
(10, 'Block C, Tech City', 'Chennai', 'Tamil Nadu', '600100', 'India');

select * from Products;

update Products
set image_path = '/uploads/products/c1.jpg'
where id = 1;
INSERT INTO categories (categoryName) VALUES
('Men Clothing'),
('Women Clothing'),
('Electronics'),
('Footwear'),
('Accessories');



INSERT INTO Products (ProductName, description, categoryID, Gender, Price, Quantity) VALUES

-- Men Clothing (categoryID = 1)
('Men T-Shirt', 'Cotton round neck t-shirt', 1, 'Male', 799.00, 100),
('Men Jeans', 'Slim fit blue jeans', 1, 'Male', 1999.00, 60),
('Men Jacket', 'Winter warm jacket', 1, 'Male', 3499.00, 40),

-- Women Clothing (categoryID = 2)
('Women Kurti', 'Floral printed kurti', 2, 'Female', 1299.00, 75),
('Women Saree', 'Silk traditional saree', 2, 'Female', 4999.00, 30),
('Women Top', 'Casual summer top', 2, 'Female', 899.00, 90),

-- Electronics (categoryID = 3)
('Smartphone', '5G Android smartphone', 3, 'Unisex', 18999.00, 50),
('Bluetooth Headphones', 'Wireless over-ear headphones', 3, 'Unisex', 2999.00, 80),
('Laptop', '14-inch i5 laptop', 3, 'Unisex', 55999.00, 25),

-- Footwear (categoryID = 4)
('Running Shoes', 'Lightweight sports shoes', 4, 'Male', 2499.00, 70),
('Heels Sandals', 'Party wear high heels', 4, 'Female', 1999.00, 45),
('Casual Sneakers', 'Daily wear sneakers', 4, 'Unisex', 2199.00, 65),

-- Accessories (categoryID = 5)
('Leather Wallet', 'Genuine leather wallet', 5, 'Male', 999.00, 120),
('Handbag', 'Stylish women handbag', 5, 'Female', 2799.00, 55),
('Smart Watch', 'Fitness tracking smart watch', 5, 'Unisex', 3999.00, 85);


INSERT INTO Cart (customerID) VALUES
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);



INSERT INTO cartItems (cartID, ProductID, Quantity) VALUES

-- Cart for Rahul (cartID = 1)
(1, 1, 2),   -- Men T-Shirt
(1, 7, 1),   -- Smartphone

-- Cart for Priya (cartID = 2)
(2, 4, 1),   -- Women Kurti
(2, 15, 1),  -- Smart Watch

-- Cart for Amit (cartID = 3)
(3, 2, 1),   -- Men Jeans
(3, 8, 1),   -- Bluetooth Headphones

-- Cart for Sneha (cartID = 4)
(4, 5, 1),   -- Women Saree
(4, 11, 1),  -- Heels Sandals

-- Cart for Arjun (cartID = 5)
(5, 3, 1),   -- Men Jacket
(5, 10, 1),  -- Running Shoes

-- Cart for Neha (cartID = 6)
(6, 6, 2),   -- Women Top
(6, 14, 1),  -- Handbag

-- Cart for Vikram (cartID = 7)
(7, 9, 1),   -- Laptop

-- Cart for Pooja (cartID = 8)
(8, 12, 1),  -- Casual Sneakers
(8, 13, 1);  -- Leather Wallet


INSERT INTO OrderStatus (orderName) VALUES
('Pending'),
('Shipped'),
('Out for Delivery'),
('Delivered')


SELECT * from Users

select * from Address;

select * from Users;

update Users
set email = ''

select * from Products;
select * from cartItems;

select * from cart;

select * from categories;

select * from OrderItems;

select * from Orders
update users
set email = 'rabommanausei-3875@yopmail.com'
where id = 14;

CREATE TABLE InventoryLogs (
    id INT PRIMARY KEY IDENTITY(1,1),
    productID INT,
    adminID INT,
    actionType VARCHAR(50),
    actionTime DATETIME DEFAULT GETDATE(),
    description VARCHAR(500),

    CONSTRAINT fk_log_product
    FOREIGN KEY (productID) REFERENCES Products(id),

    CONSTRAINT fk_log_admin
    FOREIGN KEY (adminID) REFERENCES Users(id)
);

select * from InventoryLogs;

delete from Users
where id = 12;

select * from Users