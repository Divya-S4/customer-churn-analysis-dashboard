CREATE DATABASE customer_churn_analysis;
USE customer_churn_analysis;

CREATE TABLE customer_churn (
    customerID VARCHAR(50),
    gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(50),
    Churn VARCHAR(10)
);

SELECT * 
FROM customer_churn
LIMIT 10;

SELECT COUNT(*) AS total_customers
FROM customer_churn;

SHOW TABLES;

DROP TABLE customer_churn;

CREATE TABLE customer_churn (
    customerID VARCHAR(50),
    gender VARCHAR(20),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(50),
    Churn VARCHAR(10)
);

SELECT COUNT(*) AS total_customers
FROM customer_churn;

DESCRIBE customer_churn;

SELECT COUNT(*) AS blank_totalcharges
FROM customer_churn
WHERE TotalCharges = '';


SELECT COUNT(*) AS blank_totalcharges
FROM customer_churn
WHERE TotalCharges = '';

SELECT COUNT(*) 
FROM customer_churn
WHERE TotalCharges IS NULL;

SELECT TotalCharges
FROM customer_churn
LIMIT 10;

ALTER TABLE customer_churn
ADD COLUMN TotalCharges_Decimal DECIMAL(10,2);

CREATE TABLE churn_analysis AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges_Decimal AS TotalCharges,
    Churn
FROM customer_churn;


SELECT TotalCharges, TotalCharges_Decimal
FROM customer_churn
LIMIT 10;

SELECT customerID, COUNT(*) AS duplicate_count
FROM customer_churn
GROUP BY customerID
HAVING COUNT(*) > 1;

UPDATE customer_churn
SET TotalCharges_Decimal = CAST(TotalCharges AS DECIMAL(10,2));

SET SQL_SAFE_UPDATES = 0;


SELECT 
    ROUND(
        (SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0)
        / COUNT(*),
    2) AS Churn_Rate_Percentage
FROM churn_analysis;

SELECT 
    gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM churn_analysis
GROUP BY gender;

SELECT 
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM churn_analysis
GROUP BY Contract
ORDER BY Churned_Customers DESC;

SELECT 
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM churn_analysis
GROUP BY PaymentMethod
ORDER BY Churned_Customers DESC;

SELECT 
    ROUND(SUM(TotalCharges),2) AS Revenue_Lost
FROM churn_analysis
WHERE Churn = 'Yes';

SELECT 
    COUNT(*) AS null_totalcharges
FROM churn_analysis
WHERE TotalCharges IS NULL;

SELECT TotalCharges
FROM customer_churn
LIMIT 20;

SET SQL_SAFE_UPDATES = 0;

UPDATE customer_churn
SET TotalCharges_Decimal = TRIM(TotalCharges) + 0;

SELECT 
    TotalCharges,
    TotalCharges_Decimal
FROM customer_churn
LIMIT 20;

DROP TABLE churn_analysis;

CREATE TABLE churn_analysis AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges_Decimal AS TotalCharges,
    Churn
FROM customer_churn;

SELECT 
    ROUND(SUM(TotalCharges),2) AS Revenue_Lost
FROM churn_analysis
WHERE Churn = 'Yes';

