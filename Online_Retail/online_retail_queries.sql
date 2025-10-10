create database online_retail;
use online_retail;
CREATE TABLE online_retail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice FLOAT,
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);
-- Disable safe updates
SET SQL_SAFE_UPDATES = 0;

-- Your DELETEs
DELETE FROM online_retail WHERE InvoiceNo LIKE 'C%';
DELETE FROM online_retail WHERE CustomerID IS NULL;
DELETE FROM online_retail WHERE UnitPrice <= 0;

-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;
