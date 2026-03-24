USE StoreDB;

CREATE TABLE categories (
    id INT IDENTITY PRIMARY KEY,
    categoryName VARCHAR(255)
);



CREATE TABLE Products (
    id INT IDENTITY PRIMARY KEY,
    productName VARCHAR(255),
    description VARCHAR(255),
    categoryID INT,
    Gender VARCHAR(255),
    Price DECIMAL(10,2),
    Quantity INT
);
ALTER TABLE Products
ADD image_path VARCHAR(255);

ALTER TABLE Products
ADD isDeleted BIT DEFAULT 0;


select * from Products

update Products
set isDeleted = 0;

CREATE TABLE Cart (
    id INT IDENTITY PRIMARY KEY,
    customerID INT
);

CREATE TABLE cartItems (
    id INT IDENTITY PRIMARY KEY,
    cartID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT fk_cartItems_cartID_Cart
        FOREIGN KEY (cartID) REFERENCES Cart(id),
    CONSTRAINT fk_cartItems_ProductID_Products
        FOREIGN KEY (ProductID) REFERENCES Products(id)
);

CREATE TABLE OrderStatus (
    id INT IDENTITY PRIMARY KEY,
    orderName VARCHAR(255)
);


CREATE TABLE Orders (
    id INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    AddressID INT,
    StatusID INT,
    Payment VARCHAR(255),
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2),
    OTP VARCHAR(255),
    OTPVerified BIT,
    CONSTRAINT fk_Orders_StatusID_OrderStatus
        FOREIGN KEY (StatusID) REFERENCES OrderStatus(id)
);


CREATE TABLE OrderItems (
    id INT IDENTITY PRIMARY KEY,
    orderID INT,
    ProductID INT,
    Quantity INT,
    unitPrice DECIMAL(10,2),
    CONSTRAINT fk_OrderItems_orderID_Orders
        FOREIGN KEY (orderID) REFERENCES Orders(id),
    CONSTRAINT fk_OrderItems_ProductID_Products
        FOREIGN KEY (ProductID) REFERENCES Products(id)
);


CREATE TABLE InventoryLogs (
    id INT IDENTITY PRIMARY KEY,
    productID INT,
    adminID INT,
    actionType VARCHAR(255),
    actionTime DATETIME,
    description VARCHAR(255),
    CONSTRAINT fk_log_product
    FOREIGN KEY (productID) REFERENCES Products(id)
);

SET IDENTITY_INSERT StoreDB.dbo.categories ON;

INSERT INTO StoreDB.dbo.categories (id, categoryName)
SELECT id, categoryName
FROM FinalProject.dbo.categories;

SET IDENTITY_INSERT StoreDB.dbo.categories OFF;


SET IDENTITY_INSERT StoreDB.dbo.Products ON;

INSERT INTO StoreDB.dbo.Products
(id, productName, description, categoryID, Gender, Price, Quantity, image_path)
SELECT
id, productName, description, categoryID, Gender, Price, Quantity, image_path
FROM FinalProject.dbo.Products;

SET IDENTITY_INSERT StoreDB.dbo.Products OFF;



SET IDENTITY_INSERT StoreDB.dbo.OrderStatus ON;

INSERT INTO StoreDB.dbo.OrderStatus (id, orderName)
SELECT id, orderName
FROM FinalProject.dbo.OrderStatus;

SET IDENTITY_INSERT StoreDB.dbo.OrderStatus OFF;



SET IDENTITY_INSERT StoreDB.dbo.Cart ON;

INSERT INTO StoreDB.dbo.Cart (id, customerID)
SELECT id, customerID
FROM FinalProject.dbo.Cart;

SET IDENTITY_INSERT StoreDB.dbo.Cart OFF;



SET IDENTITY_INSERT StoreDB.dbo.Orders ON;

INSERT INTO StoreDB.dbo.Orders
(id, CustomerID, AddressID, StatusID, Payment, OrderDate, TotalAmount, OTP, OTPVerified)
SELECT
id, CustomerID, AddressID, StatusID, Payment, OrderDate, TotalAmount, OTP, OTPVerified
FROM FinalProject.dbo.Orders;

SET IDENTITY_INSERT StoreDB.dbo.Orders OFF;



SET IDENTITY_INSERT StoreDB.dbo.cartItems ON;

INSERT INTO StoreDB.dbo.cartItems
(id, cartID, ProductID, Quantity)
SELECT
id, cartID, ProductID, Quantity
FROM FinalProject.dbo.cartItems;

SET IDENTITY_INSERT StoreDB.dbo.cartItems OFF;




SET IDENTITY_INSERT StoreDB.dbo.OrderItems ON;

INSERT INTO StoreDB.dbo.OrderItems
(id, orderID, ProductID, Quantity, unitPrice)
SELECT
id, orderID, ProductID, Quantity, unitPrice
FROM FinalProject.dbo.OrderItems;

SET IDENTITY_INSERT StoreDB.dbo.OrderItems OFF;



SET IDENTITY_INSERT StoreDB.dbo.InventoryLogs ON;

INSERT INTO StoreDB.dbo.InventoryLogs
(id, productID, adminID, actionType, actionTime, description)
SELECT
id, productID, adminID, actionType, actionTime, description
FROM FinalProject.dbo.InventoryLogs;

SET IDENTITY_INSERT StoreDB.dbo.InventoryLogs OFF;

select * from InventoryLogs

UPDATE InventoryLogs
SET actionTime = GETDATE()
WHERE actionTime IS NULL;


