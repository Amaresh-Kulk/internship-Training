USE CustomerDB;

CREATE TABLE Customer (
    id INT PRIMARY KEY,   -- same as Users.id
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone VARCHAR(255)
);

ALTER TABLE Customer
ADD profileImage VARCHAR(255) NULL;

CREATE TABLE Address (
    id INT IDENTITY PRIMARY KEY,
    customerID INT,
    AddressLine VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
     CONSTRAINT fk_Address_customerID_Customer
        FOREIGN KEY (customerID) REFERENCES Customer(id)
);

select * from Customer;
select * from Address;

INSERT INTO CustomerDB.dbo.Customer (id, first_name, last_name, phone, profileImage)
SELECT id, first_name, last_name, phone, profileImage
FROM FinalProject.dbo.Customer;



SET IDENTITY_INSERT CustomerDB.dbo.Address ON;

INSERT INTO CustomerDB.dbo.Address
(id, customerID, AddressLine, City, State, PostalCode, Country)
SELECT
id, customerID, AddressLine, City, State, PostalCode, Country
FROM FinalProject.dbo.Address;

SET IDENTITY_INSERT CustomerDB.dbo.Address OFF;


select * from Customer