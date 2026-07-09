📊 Retail Sales Performance & Customer Insights Dashboard

An end-to-end data analytics project covering the full pipeline: **Python** for data cleaning, **SQL Server** for transformation and business logic, and **Power BI** for an interactive 4-page dashboard with strategic business insights.

🎯 Problem Statement
A UK-based online gift-ware retailer needed visibility into revenue trends, customer value, product performance, and operational leakages (cancellations) across 1M+ transactions spanning Dec 2009 – Dec 2011. This project builds a full analytics pipeline to answer: *Who are our best customers? What drives revenue? Where are we losing money?*

🛠️ Tech Stack
- **Python** (Pandas, NumPy, SQLAlchemy) — data cleaning & preprocessing
- **SQL Server (SSMS)** — data transformation, RFM segmentation, business logic views
- **Power BI** — interactive dashboard, DAX measures, data storytelling

📁 Dataset
[Online Retail II — UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/502/online+retail+ii)
1,067,371 raw transaction records from a UK-based online retailer (Dec 2009 – Dec 2011).

🧹 Data Cleaning (Python)
- Removed 34,335 duplicate rows and 6,207 rows with invalid (zero/negative) prices
- Flagged 19,494 cancelled orders and separately identified 3,456 non-cancelled returns (negative quantity) for accurate revenue reporting
- Preserved orders with missing Customer IDs by flagging them as guest orders, rather than dropping revenue-generating data
- Removed non-product administrative codes (postage, bank charges, etc.)
- Engineered features: Revenue, OrderMonth, DayOfWeek
- **Result:** 1,021,732 clean rows (95.7% retention) pushed to SQL Server via SQLAlchemy

🗄️ SQL Transformation
Built 5 SQL views to separate business logic from the visualization layer:
- `vw_MonthlyRevenue` — revenue, orders, and AOV trends by month
- `vw_RFM` — Recency, Frequency, Monetary customer segmentation using `NTILE()`, classifying customers into Champions / Loyal / At Risk / Lost
- `vw_TopProducts` — product-level revenue and volume aggregation
- `vw_CountryPerformance` — revenue and customer counts by country
- `vw_CancelledImpact` — quantifies revenue lost to order cancellations

📊 Power BI Dashboard (4 Pages)

**1. Executive Summary** — KPIs (Revenue, Orders, AOV, Customers), revenue trend, top countries
**2. Customer Analytics** — RFM segmentation, customer clustering scatter plot, top customer table
**3. Product Analytics** — top products by revenue vs. units sold, cancellation impact
**4. Key Findings & Recommendations** — strategic insights translating data into business actions

💡 Key Insights
- **Seasonality**: Revenue peaks sharply in Nov-Dec (holiday demand) and collapses in January — informs inventory and staffing planning
- **Customer concentration**: ~30% of customers ("Champions") drive disproportionate revenue; a single wholesale account contributed over ₹5.8L in spend
- **Revenue vs. volume mismatch**: Only 3 of the top 10 revenue-generating products are also top 10 by units sold, revealing distinct premium vs. volume product segments
- **Cancellation impact**: ~5% of gross revenue (£979.97K) is lost to cancellations — a quantified, recoverable leakage

📈 Key Metrics
| Metric | Value |
|---|---|
| Total Customers | 26K |
| Total Orders | 40K |
| Total Revenue | £19.69M |
| Avg Order Value | £497.45 |
| Transactions Processed | 1M+ |

📸 Dashboard Preview
![Executive Summary](screenshots/01_executive_summary.png)
![Customer Analytics](screenshots/02_customer_analytics.png)
![Product Analytics](screenshots/03_product_analytics.png)
![Key Findings](screenshots/04_key_findings.png)

🚀 How to Run
1. Run `data_cleaning.ipynb` on the raw dataset to produce the cleaned CSV
2. Execute `sql_views.sql` in SQL Server Management Studio against the imported cleaned table
3. Open `Retail_Analytics_Dashboard.pbix` in Power BI Desktop, connect to your SQL Server instance, and refresh
