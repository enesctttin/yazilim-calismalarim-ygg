create database samplew3

--The SELECT DISTINCT statement is used to return only distinct (unique) values.

--The WHERE clause is used to filter records.

--The WHERE clause is used to extract only those records that fulfill a specific condition.

SELECT * FROM Customers
WHERE Country = 'Mexico';

syntax
SELECT column1, column2, ...
FROM table_name
WHERE condition;

SELECT * FROM Customers
WHERE CustomerID = 1;

SELECT * FROM Customers
WHERE CustomerID > 80;

<> === !=

SELECT * FROM Products
WHERE Price BETWEEN 50 AND 60;

SELECT * FROM Customers
WHERE City LIKE 's%';

SELECT * FROM Customers
WHERE City LIKE 's%';

syntax order by
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;


Sort the products from highest to lowest price:
SELECT * FROM Products
ORDER BY Price DESC;


Select all customers where Country is "Spain" AND CustomerName starts with the letter 'G':
SELECT *
FROM Customers
WHERE Country = 'Spain' AND CustomerName LIKE 'G%';

Syntax
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;

-- and olduğu gibi or da var

SELECT * FROM Customers
WHERE City = 'Berlin' OR CustomerName LIKE 'G%' OR Country = 'Norway';  ,

-- not ekleyince başına olumsuzu alırız


Syntax 1
Specify both the column names and the values to be inserted:

INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);


Syntax 2
If you insert values for ALL the columns of the table, you can omit the column names.

However, the order of the values must be in the same order as the columns in the table:

INSERT INTO table_name
VALUES (value1, value2, value3, ...);



What is a NULL Value?
If a field in a table is optional, it is possible to insert or update a record without adding any value to this field. This way, the field will be saved with a NULL value.

A NULL value represents an unknown, missing, or inapplicable data in a database field. It is not a value itself, but a placeholder to indicate the absence of data.

IS NULL Syntax
SELECT column_names
FROM table_name
WHERE column_name IS NULL;

SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL;

SELECT CustomerName, ContactName, [Address]
FROM Customers
WHERE Address IS NULL;


UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;

UPDATE Customers
SET ContactName='Juan';

DELETE Syntax
DELETE FROM table_name WHERE condition;

DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';

The SELECT TOP clause is used to limit the number of records to return.

SELECT TOP 3 * FROM Customers;

SELECT TOP number|percent column_name(s)
FROM table_name
WHERE condition;


Use the AS keyword to give the column a descriptive name:


The behavior of COUNT() depends on the argument used within the parentheses:
COUNT(*) - Counts the total number of rows in a table (including NULL values).
COUNT(columnname) - Counts all non-null values in the column.
COUNT(DISTINCT columnname) - Counts only the unique, non-null values in the column.

SELECT COUNT(ProductName)
FROM Products;

SELECT COUNT(ProductID)
FROM Products
WHERE Price > 20;

SELECT * FROM Customers
WHERE CustomerName LIKE 'a%';

Return all customers from a City that contains the character sequence 'on':

SELECT * FROM Customers
WHERE city LIKE '%on%';


It can be any character or number, but each _ represents one, and only one, character.

Return all customers from a City that starts with 'l' followed by one wildcard character, then 'nd' and then two wildcard characters:

SELECT * FROM Customers
WHERE city LIKE 'l_nd__';

Return all customers that starts with 'La':

SELECT * FROM Customers
WHERE CustomerName LIKE 'La%';


The IN operator is used in the WHERE clause to check if a specified column value matches any value within a provided list.

The IN operator functions as a shorthand for multiple OR conditions, making queries shorter and more readable.

SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'UK');

SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'France' OR Country = 'UK';

Syntax
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...);

 customers that are NOT from 'Germany', 'France', or 'UK':

SELECT * FROM Customers
WHERE Country NOT IN ('Germany', 'France', 'UK');


Syntax  between
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;

SELECT * FROM Products
WHERE Price BETWEEN 10 AND 20
AND CategoryID IN (1,2,3);

SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;

SELECT * FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

SQL aliases are used to give a column or a table a temporary name.
Aliases are used to make column names more readable.
An alias only exists for the duration of that query.
An alias is created with the AS keyword.


SELECT CustomerID AS ID, CustomerName AS Customer
FROM Customers;


Syntax
Alias for column:

SELECT column_name AS alias_name
FROM table_name;

Alias for table:

SELECT column_name(s)
FROM table_name AS alias_name;
---------------------------

The JOIN clause is used to combine rows from two or more tables, based on a related column between them.

Here are the different types of JOINs in SQL:

(INNER) JOIN: Returns only rows that have matching values in both tables
LEFT (OUTER) JOIN: Returns all rows from the left table, and only the matched rows from the right table
RIGHT (OUTER) JOIN: Returns all rows from the right table, and only the matched rows from the left table
FULL (OUTER) JOIN: Returns all rows when there is a match in either the left or right table

CustomerID iki tablodada ortak
Here we see that the "CustomerID" column in the "Orders" table refers to the "CustomerID" in the "Customers" table. 
The relationship between the two tables above is the "CustomerID" column

SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

sadece keşisim
INNER JOIN Syntax
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

ProductID	ProductName	CategoryID	Price
3	Aniseed Syrup	2	10.00


CategoryID	CategoryName	Description
2	Condiments	Sweet and savory sauces, relishes, spreads, and seasonings

bu tablolar yukarıdaki sorgu için

You can join more than two tables by adding multiple INNER JOIN clauses in your query.



The LEFT JOIN returns all rows from the left table (table1), and only the matched rows from the right table (table2).

If there is no match in the right table, the result for the columns from the right table will be NULL.

LEFT JOIN Syntax
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;



The RIGHT JOIN returns all rows from the right table (table2), and only the matched rows from the left table (table1).

If there is no match in the left table, the result for the columns from the left table will be NULL.

RIGHT JOIN Syntax
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;

SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;


The FULL JOIN returns all rows when there is a match in either the left or right table.

If a row in the left table has no match in the right table, the result set includes the left row's data and NULL values for all columns of the right table.

If a row in the right table has no match in the left table, the result set includes the right row's data and NULL values for all columns of the left table.

FULL JOIN Syntax
SELECT column_name(s)
FROM table1
FULL JOIN table2
ON table1.column_name = table2.column_name
WHERE condition;

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


A self join is a regular join, but the table is joined with itself.

Self Join Syntax
SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;

SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;




The UNION operator is used to combine the result-set of two or more SELECT statements.

The UNION operator automatically removes duplicate rows from the result set.

Requirements for UNION:

Every SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order

SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

SELECT Country FROM Customers
UNION
SELECT Country FROM Suppliers
ORDER BY Country;

Note: If some customers or suppliers have the same country, each country will only be listed once, because UNION selects only distinct values. Use UNION ALL to also select duplicate values!


The SQL GROUP BY Statement
The GROUP BY statement is used to group rows that have the same values into summary rows, like "Find the number of customers in each country".

The GROUP BY statement is almost always used in conjunction with aggregate functions, like COUNT(), MAX(), MIN(), SUM(), AVG(), to perform calculations on each group.

GROUP BY Syntax
SELECT column1, aggregate_function(column2), column3, ...
FROM table_name
WHERE condition
GROUP BY column1, column3
ORDER BY column_name;


SELECT Country, COUNT(CustomerID) AS [Number of Customers]
FROM Customers
GROUP BY Country;

SELECT Country, COUNT(CustomerID) AS [Number of Customers]  -- country lerde yaşayan insanlara göre toplama yapacak
FROM Customers  
GROUP BY Country   -- neye göre gruplayacağız      
ORDER BY COUNT(CustomerID) DESC;

The SQL HAVING Clause
The HAVING clause is used to filter the results of a GROUP BY query based on aggregate functions. Unlike the WHERE clause, which filters individual rows before grouping, HAVING filters groups after the aggregation has been performed.

HAVING Syntax
SELECT column1, aggregate_function(column2), column3, ...
FROM table_name
WHERE condition
GROUP BY column1, column3
HAVING condition -- The condition on grouped data
ORDER BY column_name;

SELECT 
    Departman, 
    SUM(SatisMiktari) AS ToplamCiro
FROM tblSatislar
GROUP BY Departman
HAVING SUM(SatisMiktari) > 3000; -- Gruplandıktan SONRA toplamı 3000'den büyük olanları filtrele

The SQL CASE Expression
The CASE expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement). So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.

If there is no ELSE part and no conditions are true, it returns NULL.

CASE Syntax
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;


SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;

What is a Stored Procedure?
A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.

So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.

You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

Stored Procedure Syntax
CREATE PROCEDURE procedure_name
AS
sql_statement
GO;
Execute a Stored Procedure
EXEC procedure_name;

CREATE PROCEDURE SelectAllCustomers
AS
SELECT * FROM Customers
GO;
Execute the stored procedure above as follows:

Example
EXEC SelectAllCustomers;
