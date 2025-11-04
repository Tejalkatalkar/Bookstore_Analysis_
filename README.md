# Bookstore_Analysis_
🧾 Project Overview

The Bookstore Analysis Project focuses on analyzing bookstore sales and performance using a Star Schema data model implemented in SQL.
It integrates four CSV files — representing both fact and dimension tables — to support business reporting and analytical queries.
The project answers key business questions related to revenue, categories, publishers, and customer trends.

🌟 Star Schema Architecture

The star schema is designed around a central Fact Table (Book_Sales) connected to multiple Dimension Tables(Books_Data,Publishers, Date_Table)

<img width="968" height="784" alt="image" src="https://github.com/user-attachments/assets/bdbcab5b-f6ab-4325-9e5f-88dab81607f4" />


📂 Datasets Used
| File Name            | Purpose                                                             | SQL Table Name   |
| -------------------- | ------------------------------------------------------------------- | ---------------- |
| `Books_Data.csv`     | Contains book details such as titles, authors, ISBN, and categories | `Book_data`      |
| `Books_Sale.csv`     | Records sales transactions, prices, ratings, and discounts          | `Books_sale`     |
| `Publisher_Data.csv` | Stores publisher information (name, region, and ID)                 | `publishers`     |
| `Date_Table.csv`     | Provides date hierarchy details for time-based analysis             | `Date_Hierarchy` |


⚙️ Project Workflow

Data Loading

Imported all CSV files into SQL tables.

Established relationships between fact and dimension tables.

Data Cleaning & Transformation

Removed duplicates and standardized category names.

Ensured referential integrity between foreign keys.

Schema Design

Defined Primary and Foreign Keys.

Created JOIN relationships for reporting queries.

SQL Analysis
Executed queries to answer real business problems:

Total and average revenue by category/publisher.

Top-selling books and authors.

Discount vs. sales correlation.

Rating-based performance insights.

🚀 Future Scope

Implement ETL pipeline for automated CSV-to-database loading.

Add Customer dimension for deeper segmentation.

Integrate with Power BI / Tableau for interactive dashboards.

Use SQL views or materialized views for faster reporting.

✅ Conclusion

This Bookstore Analysis Project demonstrates a well-structured SQL data warehouse model using the Star Schema approach.
By organizing data into a clear fact-dimension relationship, it simplifies querying and improves analytical performance — providing meaningful business insights into sales, publisher effectiveness, and category performance.
