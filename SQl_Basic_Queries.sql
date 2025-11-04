/* 
© 2025 Tejal Katalkar. All rights reserved. https://github.com/Tejalkatalkar
*/

-- Create Tables for storing book details
CREATE TABLE IF NOT EXISTS Publishers (
    Publisher_ID VARCHAR(10) PRIMARY KEY,
    Publication VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Books_Data (
    Book_ID VARCHAR(10) PRIMARY KEY,
    Publisher_ID VARCHAR(10) REFERENCES Publishers(Publisher_ID),
    Title VARCHAR(150) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Category VARCHAR(100),
    Stock_Status VARCHAR(20),
    Book_Length INT CHECK (Book_Length >= 0),
    Edition INT,
    ISBN VARCHAR(20),
    Wished_Count INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Date_Table (
    Date_ID VARCHAR(10) PRIMARY KEY,
    Sales_Date DATE NOT NULL,
    Day INT CHECK (Day BETWEEN 1 AND 31),
    Month INT CHECK (Month BETWEEN 1 AND 12),
    Quarter VARCHAR(5) CHECK (Quarter IN ('Q1','Q2','Q3','Q4')),
    Year INT CHECK (Year >= 2000),
    Weekday VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS Books_Sale (
    Sales_ID VARCHAR(10) PRIMARY KEY,  
    Book_ID VARCHAR(10) NOT NULL,
    Date_ID VARCHAR(10) NOT NULL, 
    Publisher_ID VARCHAR(10) NOT NULL,
    Price DECIMAL(10,2),
    Copies_Left INT,
    Discount_Offer VARCHAR(10),
    Rating DECIMAL(2,1),
    FOREIGN KEY (Book_ID) REFERENCES Books_Data(Book_ID),
    FOREIGN KEY (Date_ID) REFERENCES Date_Table(Date_ID),
    FOREIGN KEY (Publisher_ID) REFERENCES Publishers(Publisher_ID)
);

-- Import data into Publishers table
COPY Publishers(Publisher_ID, Publication)
FROM 'D:/Bookstore_Analysis/Publisher.csv'
DELIMITER ','
CSV HEADER;

-- Import data into Books_Data
COPY Books_Data(Book_ID, Publisher_ID, Title, Author, Category, Stock_Status, Book_Length, Edition, ISBN, Wished_Count)
FROM 'D:/Bookstore_Analysis/Book_Data.csv'
DELIMITER ','
CSV HEADER;

-- Import data into Date_Table
COPY Date_Table(Date_ID, Sales_Date, Day, Month, Quarter, Year, Weekday)
FROM 'D:/Bookstore_Analysis/Date_Table.csv'
DELIMITER ','
CSV HEADER;

-- Import data into Books_Sale
COPY Books_Sale(Sales_ID, Book_ID, Date_ID, Publisher_ID, Price, Copies_Left, Discount_Offer, Rating)
FROM 'D:/Bookstore_Analysis/Books_Sales.csv'
DELIMITER ','
CSV HEADER;

-- Basic SQL Queries
SELECT * FROM Publishers;
SELECT * FROM Books_Data;
SELECT * FROM Date_Table;
SELECT * FROM Books_Sale;

-- Select specific columns
SELECT Publisher_ID, Title, Author FROM Books_Data;

-- Rename column using alias
SELECT Title AS Book_Titles, stock_status FROM Books_Data;

-- Filters rows using where clause
SELECT * FROM Books_Data
WHERE Category = 'Travel';

-- Filter with multiple conditions
SELECT * FROM Books_Data
WHERE stock_status = 'In Stock' AND category = 'Science';

-- IN, BETWEEN, NOT IN, LIKE Operators
SELECT * FROM Books_Data
WHERE Category IN ('Fantasy', 'Health');

SELECT * FROM Books_Data
WHERE Category NOT IN ('Child')

SELECT * FROM Books_Sale
WHERE Price BETWEEN 200 AND 500;

SELECT * FROM Books_Data
WHERE Title LIKE '%Life%';

-- Sorting results
SELECT Book_ID, Edition FROM Books_Data
ORDER BY Edition DESC;

-- Display a Limited number of records
SELECT * FROM Books_Data
ORDER BY category DESC
LIMIT 5;

-- remove duplicate values in a result
SELECT DISTINCT Category FROM Books_Data;

-- Datewise Product Price
SELECT 
    b.Title AS Book_Name,
    s.Date_ID AS Sale_Date,
    s.Price AS Product_Price
FROM Books_Data b
JOIN Books_Sale s
ON b.Book_ID = s.Book_ID
ORDER BY s.Date_ID, b.Title;

--Total revenue by month
SELECT 
    d.Month, d.Year,
    SUM(s.Price) AS Total_Revenue
FROM Books_Sale s
JOIN Date_Table d 
ON s.Date_ID = d.Date_ID
GROUP BY d.Month, d.Year
ORDER BY d.Year, d.Month;

-- Top 5 categories by revenue
SELECT 
    b.Category, 
    SUM(s.Price) AS Total_Revenue
FROM Books_Data b
JOIN Books_Sale s ON b.Book_ID = s.Book_ID
GROUP BY b.Category
ORDER BY Total_Revenue DESC
LIMIT 5;

--Date & Time Functions
SELECT 
    CURRENT_DATE,
    EXTRACT(YEAR FROM Sales_Date),
    TO_CHAR(Sales_Date, 'Month')
FROM Date_Table;

-- Summarizes total books, avg price, and revenue by category.
SELECT 
    b.Category,
    COUNT(*) AS Total_Books,
    AVG(s.Price) AS Avg_Price,
    SUM(s.Price * s.Copies_Left) AS Total_Revenue
FROM Books_Data b
INNER JOIN Books_Sale s ON b.Book_ID = s.Book_ID
GROUP BY b.Category;

--Subqueries
SELECT Book_ID, Price
FROM Books_Sale
WHERE Price > (SELECT AVG(Price) FROM Books_Sale);

--Indexes make data retrieval faster.
CREATE INDEX idx_category ON Books_Data(Category);

--Categorizes books into Low, Medium, and High price ranges for pricing analysis.
SELECT 
    b.Title,
    CASE 
        WHEN s.Price < 300 THEN 'Low'
        WHEN s.Price BETWEEN 300 AND 800 THEN 'Medium'
        ELSE 'High'
    END AS Price_Category
FROM Books_Data b
JOIN Books_Sale s ON b.Book_ID = s.Book_ID;





