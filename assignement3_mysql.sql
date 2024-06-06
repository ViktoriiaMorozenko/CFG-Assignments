CREATE DATABASE ProteinShop;

USE ProteinShop;

CREATE TABLE Customers
(
    Id INTEGER,
    Age INTEGER DEFAULT 18,
        CONSTRAINT CK_Customer_Age CHECK (Age >0 AND Age < 130),
    FirstName CHAR(10) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PRIMARY KEY(Id)
);

CREATE TABLE ContactInformation
(
    CustomerId INTEGER PRIMARY KEY,
    Email VARCHAR(40) UNIQUE,
    Phone CHAR(10) UNIQUE,
    Adress VARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerId)  REFERENCES customers (Id)
);

CREATE TABLE Orders
(
    OrderId CHAR(10) PRIMARY KEY,
    CustomerId INTEGER,
    CreatedAt DATE NOT NULL,
    FOREIGN KEY (CustomerId)  REFERENCES customers (Id)
);

CREATE TABLE Products
(
    OrderId CHAR(10),
    ProductName VARCHAR(50) NOT NULL,
    Quantity INTEGER DEFAULT 1,
    Price DECIMAL(4,2),
    FOREIGN KEY (OrderId)  REFERENCES Orders (OrderId)
);

INSERT INTO Customers (Id, Age, FirstName, LastName)
VALUES
(01, 22, 'Tom', 'Black'),
(02, 48, 'Rhon', 'White'),
(03, 18, 'Peter', 'Green'),
(04, 38, 'John', 'Yellow'),
(05, 27, 'Alice', 'Grey'),
(06, 52, 'Anna', 'Rose'),
(07, 74, 'Tomas', 'Blue'),
(08, 28, 'Mary', 'Pink');

INSERT INTO ContactInformation (CustomerId, Email, Phone, Adress)
VALUES
((SELECT Id FROM Customers WHERE FirstName='Tom'), 'ficicam187@jahsec.com', 7464754532, '9696 New Street
TWICKENHAM
TW15 7VT'),
((SELECT Id FROM Customers WHERE FirstName='Rhon'), 'x4bw5@mailtub.com', 7464751722, '195 George Street
PERTH
PH80 6UY'),
((SELECT Id FROM Customers WHERE FirstName='Peter'), 'nigl1@mailtub.com', 7501556309, '86 Stanley Road
DERBY
DE96 7MW'),
((SELECT Id FROM Customers WHERE FirstName='John'), 'wennabassebru-3597@yopmail.com', 7769578549, '26 Park Road
DUMFRIES
DG19 3UN'),
((SELECT Id FROM Customers WHERE FirstName='Alice'), 'digratoppoco-8788@yopmail.com', 7769594661, '47 York Road
LEEDS
LS57 4QR'),
((SELECT Id FROM Customers WHERE FirstName='Anna'), 'nounoddidife-1824@yopmail.com', 7753994924, '81 North Street
WIGAN
WN70 5BD'),
((SELECT Id FROM Customers WHERE FirstName='Tomas'), 'traboppeicoheu-5026@yopmail.com', 7797751403, '58 Grange Road
DONCASTER
DN52 7BJ'),
((SELECT Id FROM Customers WHERE FirstName='Mary'), 'pezabreneuku-2579@yopmail.com', 7728855543, '8 Queens Road
ROCHESTER
ME48 6OH');

INSERT INTO Orders (OrderId, CustomerId, CreatedAt)
VALUES
('ORD01', (SELECT Id FROM Customers WHERE FirstName='Tom'), '2020-01-15'),
('ORD02', (SELECT Id FROM Customers WHERE FirstName='Rhon'), '2020-05-16'),
('ORD03', (SELECT Id FROM Customers WHERE FirstName='Peter'), '2020-07-18'),
('ORD04', (SELECT Id FROM Customers WHERE FirstName='John'), '2021-04-13'),
('ORD05', (SELECT Id FROM Customers WHERE FirstName='Alice'), '2021-06-02'),
('ORD06', (SELECT Id FROM Customers WHERE FirstName='Anna'), '2021-07-29'),
('ORD07', (SELECT Id FROM Customers WHERE FirstName='Tomas'), '2022-05-11'),
('ORD08', (SELECT Id FROM Customers WHERE FirstName='Mary'), '2023-06-24');

INSERT INTO Products (OrderId, ProductName, Quantity, Price)
VALUES
((SELECT OrderId FROM Orders WHERE CustomerId=1), 'Vegan Protein Brownie', 1, 12.99),
((SELECT OrderId FROM Orders WHERE CustomerId=2), 'Pea Protein Isolate', 2, 11.99),
((SELECT OrderId FROM Orders WHERE CustomerId=3), 'Soya Protein Isolate', 1, 9.99),
((SELECT OrderId FROM Orders WHERE CustomerId=4), 'Protein Pancake Mix', 1, 13.99),
((SELECT OrderId FROM Orders WHERE CustomerId=5), 'Pea Protein Isolate', 1, 11.99),
((SELECT OrderId FROM Orders WHERE CustomerId=6), 'Soya Protein Isolate', 3, 9.99),
((SELECT OrderId FROM Orders WHERE CustomerId=7), 'Vegan Protein Brownie', 1, 12.99),
((SELECT OrderId FROM Orders WHERE CustomerId=8), 'Pea Protein Isolate', 2, 11.99);

/* ALTER TABLE Customers
ADD customerAddress VARCHAR(90) NULL;

ALTER TABLE Customers
DROP COLUMN CustomerAddress; */

-- SELECT * FROM ContactInformation;

/* SELECT CreatedAt
FROM Orders
ORDER BY CreatedAt DESC; */

/* SELECT CustomerId, CreatedAt
FROM Orders
ORDER BY CustomerId DESC, CreatedAt ASC; */

/* SELECT c.FirstName, c.LastName, p.ProductName, o.CreatedAt 
FROM Orders AS o, Customers AS c, Products AS p
WHERE o.CustomerId = c.Id; */

/* SELECT ProductName AS ProductId, Price
FROM Products; */

/* SELECT Quantity * Price AS Total
FROM Products
ORDER BY Total DESC; */

/* SELECT ProductName 
FROM Products
WHERE Quantity=1; */

/* SELECT * FROM Products
WHERE Price > 12; */

/* SET SQL_SAFE_UPDATES = 0;

UPDATE Customers
SET
Customers.Age=22
WHERE 
Customers.FirstName='Tom';

DELETE FROM Products
WHERE 
Price <10; */

/* SELECT AVG(Price) AS average_Price FROM Products;
SELECT SUM(Price) AS GrandTotal FROM Products;
SELECT MIN(Price) FROM Products;
SELECT MAX(Price) FROM Products; 
SELECT COUNT(Quantity) FROM Products; */

/* SELECT *
FROM Orders
LEFT JOIN Customers
ON Orders.CustomerId=Customers.Id; */

/* SELECT * FROM Orders CROSS JOIN Customers; */

/* SELECT ROUND(Price) FROM Products;
SELECT RAND(Price) FROM Products;
SELECT FLOOR(Price) FROM Products;
SELECT ABS(Price) FROM Products; */

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `addProduct`(
    Products VARCHAR(50),
    Amounts INT,
    Costs DECIMAL(4,2))
BEGIN
INSERT INTO Products(ProductName, Quantity, Price)
VALUES (Products, Amounts, Costs);
END//
DELIMITER ;

-- DROP PROCEDURE addProduct;
-- DROP DATABASE ProteinShop;