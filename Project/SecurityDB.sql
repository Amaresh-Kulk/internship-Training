USE SecurityDB;

CREATE TABLE Roles (
    id INT IDENTITY PRIMARY KEY,
    role VARCHAR(255)
);

CREATE TABLE Users (
    id INT IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    roleID INT,
    FOREIGN KEY (roleID) REFERENCES Roles(id)
);

INSERT INTO Roles (role)
VALUES 
('admin'),
('user');

select * from Users
select * from Roles


SET IDENTITY_INSERT SecurityDB.dbo.Roles ON;

INSERT INTO SecurityDB.dbo.Roles (id, role)
SELECT id, role
FROM FinalProject.dbo.Roles;

SET IDENTITY_INSERT SecurityDB.dbo.Roles OFF;



SET IDENTITY_INSERT SecurityDB.dbo.Users ON;

INSERT INTO SecurityDB.dbo.Users (id, name, email, password, roleID)
SELECT id, name, email, password, roleID
FROM FinalProject.dbo.Users;

SET IDENTITY_INSERT SecurityDB.dbo.Users OFF;


