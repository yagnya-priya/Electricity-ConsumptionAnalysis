
-- What is the trend in electricity consumption over time?

SELECT reading_date, reading_value AS Electricity_Consumption
FROM readings 
ORDER BY reading_date ASC
;

CREATE VIEW Electricity_Consumption_Over_Time AS 
SELECT reading_date, reading_value AS Electricity_Consumption
FROM readings 
ORDER BY reading_date ASC
;

-- What is the average electricity consumption per customer and per address?

SELECT c.Customer_FirstName, c.Customer_LastName, c.Customer_Address, AVG(r.reading_value) AS AVG_Electricity_Consumption
FROM customers c
JOIN  meter m 
ON c.Customer_ID = m.customer_id
JOIN readings r 
ON m.meter_id = r.meter_id 
GROUP BY c.Customer_FirstName, c.Customer_LastName, c.Customer_Address
ORDER BY AVG_Electricity_Consumption DESC
;

CREATE VIEW AVG_Electricity_Consumption AS 
SELECT c.Customer_FirstName, c.Customer_LastName, c.Customer_Address, AVG(r.reading_value) AS AVG_Electricity_Consumption
FROM customers c
JOIN  meter m 
ON c.Customer_ID = m.customer_id
JOIN readings r 
ON m.meter_id = r.meter_id 
GROUP BY c.Customer_FirstName, c.Customer_LastName, c.Customer_Address
ORDER BY AVG_Electricity_Consumption DESC
;

-- How many customers have complaints and what are the most common types of complaints?

SELECT COUNT(DISTINCT complaint_id) AS num_customers, complaint_details
FROM complaints
GROUP BY complaint_details
ORDER BY num_customers DESC
;

CREATE VIEW CustomerComplaints AS 
SELECT COUNT(DISTINCT complaint_id) AS num_customers, complaint_details
FROM complaints
GROUP BY complaint_details
ORDER BY num_customers DESC
;

-- What is the average time it takes to resolve complaints?

SELECT  AVG(Time_Taken) AS AverageTimeTaken
FROM complaints
;

CREATE VIEW AverageTimeTaken AS 
SELECT  AVG(Time_Taken)
FROM complaints
;

-- How many employees are needed to effectively manage the EBMS?

SELECT  COUNT(DISTINCT(Employee_ID)) AS Num_Employees
FROM employee
;

CREATE VIEW Num_Employees AS 
SELECT  COUNT(DISTINCT(Employee_ID)) AS Num_Employees
FROM employee
;

-- What is the average reading per meter and per address?

SELECT cu.Customer_Address, m.meter_type, AVG(reading_value) AS AVG_Reading
FROM readings r
JOIN meter m
ON r.meter_id = m.meter_id
JOIN customers cu 
ON m.customer_id = cu.Customer_ID
GROUP BY cu.Customer_Address, m.meter_type
;

CREATE VIEW AVG_Reading AS 
SELECT cu.Customer_Address, m.meter_type, AVG(reading_value) AS AVG_Reading
FROM readings r
JOIN meter m
ON r.meter_id = m.meter_id
JOIN customers cu 
ON m.customer_id = cu.Customer_ID
GROUP BY cu.Customer_Address, m.meter_type
;

-- What is the average payment amount per customer and per address?

SELECT cu.Customer_FirstName, cu.Customer_LastName, cu.Customer_Address, AVG(r.reading_value*pa.Unit_Price) AS AVG_Payment
FROM orders o
JOIN payments pa 
ON o.Ordered_At = pa.payment_date
JOIN customers cu 
ON o.Customer_ID = cu.Customer_ID
JOIN readings r
ON o.Reading_ID = r.reading_id
GROUP BY cu.Customer_FirstName, cu.Customer_LastName, cu.Customer_Address
;

CREATE VIEW AVG_Payment AS 
SELECT cu.Customer_FirstName, cu.Customer_LastName, cu.Customer_Address, AVG(r.reading_value*pa.Unit_Price) AS AVG_Payment
FROM orders o
JOIN payments pa 
ON o.Ordered_At = pa.payment_date
JOIN customers cu 
ON o.Customer_ID = cu.Customer_ID
JOIN readings r
ON o.Reading_ID = r.reading_id
GROUP BY cu.Customer_FirstName, cu.Customer_LastName, cu.Customer_Address
;

-- What is the trend in payment behavior over time?

SELECT pa.payment_date, (r.reading_value*pa.Unit_Price) AS Payment
FROM orders o
JOIN payments pa 
ON o.Ordered_At = pa.payment_date
JOIN readings r
ON o.Reading_ID = r.reading_id
ORDER BY pa.payment_date ASC
;

CREATE VIEW PaymentOverTime AS 
SELECT pa.payment_date, (r.reading_value*pa.Unit_Price) AS Payment
FROM orders o
JOIN payments pa 
ON o.Ordered_At = pa.payment_date
JOIN readings r
ON o.Reading_ID = r.reading_id
ORDER BY pa.payment_date ASC
;

-- What is the average order processing time?

SELECT AVG(Processing_Time)
FROM orders 
;

CREATE VIEW Average_Order_Processing_Time AS 
SELECT AVG(Processing_Time)
FROM orders 
;

-- What is the total revenue generated from the EBMS?

SELECT SUM(r.reading_value*pa.Unit_Price) AS TotalRevenueGenerated
FROM orders o
JOIN payments pa 
ON o.Ordered_At = pa.payment_date
JOIN readings r
ON o.Reading_ID = r.reading_id
;

CREATE VIEW TotalRevenueGenerated AS 
SELECT SUM(r.reading_value*pa.Unit_Price) AS TotalRevenueGenerated
FROM orders o
JOIN payments pa 
ON o.Ordered_At = pa.payment_date
JOIN readings r
ON o.Reading_ID = r.reading_id
;