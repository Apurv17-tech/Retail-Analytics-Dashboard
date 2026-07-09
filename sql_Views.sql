-- MonthlyRevenue 

CREATE VIEW vw_MonthlyRevenue AS
SELECT 
    OrderMonth,
    SUM(Revenue) AS TotalRevenue,
    COUNT(DISTINCT Invoice) AS TotalOrders,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers,
    SUM(Revenue) / COUNT(DISTINCT Invoice) AS AvgOrderValue
FROM online_retail_cleaned
WHERE IsCancelled = 'False'
GROUP BY OrderMonth;

-- RFM 

CREATE VIEW vw_RFM AS
WITH RFM_Base AS (
    SELECT 
        CustomerID,
        DATEDIFF(DAY, MAX(InvoiceDate), (SELECT MAX(InvoiceDate) FROM online_retail_cleaned)) AS Recency,
        COUNT(DISTINCT Invoice) AS Frequency,
        SUM(Revenue) AS Monetary
    FROM online_retail_cleaned
    WHERE IsCancelled = 'False' AND IsGuestOrder = 'False'
    GROUP BY CustomerID
),
RFM_Scores AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM_Base
)
SELECT *,
    (R_Score + F_Score + M_Score) AS RFM_Total,
    CASE 
        WHEN (R_Score + F_Score + M_Score) >= 10 THEN 'Champions'
        WHEN (R_Score + F_Score + M_Score) >= 7 THEN 'Loyal Customers'
        WHEN (R_Score + F_Score + M_Score) >= 5 THEN 'At Risk'
        ELSE 'Lost'
    END AS CustomerSegment
FROM RFM_Scores;

-- TopProducts

CREATE VIEW vw_TopProducts AS
SELECT 
    StockCode,
    Description,
    SUM(Quantity) AS TotalQuantitySold,
    SUM(Revenue) AS TotalRevenue,
    COUNT(DISTINCT Invoice) AS NumOrders
FROM online_retail_cleaned
WHERE IsCancelled = 'False'
GROUP BY StockCode, Description;

--CountryPerformance

CREATE VIEW vw_CountryPerformance AS
SELECT 
    Country,
    SUM(Revenue) AS TotalRevenue,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers,
    COUNT(DISTINCT Invoice) AS TotalOrders
FROM online_retail_cleaned
WHERE IsCancelled = 0
GROUP BY Country;

-- Cancelled Impact

CREATE VIEW vw_CancelledImpact AS
SELECT 
    SUM(Revenue) AS CancelledRevenue,
    COUNT(DISTINCT Invoice) AS CancelledOrders
FROM online_retail_cleaned
WHERE IsCancelled = 'True';