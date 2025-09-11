# 🏗️ Sales Data Warehouse Project

## 🎯 Objective
This project showcases the development of a modern data warehouse using MySQL, integrating sales data from two operational systems—ERP and CRM—provided as CSV files. The goal is to consolidate, clean, and model this data into a unified, analytics-ready format that supports business reporting and decision-making.

## 📦 Project Overview
This end-to-end solution highlights key data engineering practices:

### 1. 🧱 Data Architecture
- Implemented the Medallion Architecture with layered data processing:
- Bronze Layer: Raw ingestion of ERP and CRM CSV files
- Silver Layer: Cleaned and standardized data with unified schema 
- Gold Layer: Business-ready tables for reporting and analytics
![Data Architecture](https://github.com/pangwrl/sql-dwh-project/blob/main/docs/Data%20Architecture.pdf)

### 2. 🔄 ETL Pipelines
- Built ETL workflows to:
- Extract: Load CSV files from ERP and CRM sources
- Transform: Resolve schema differences, apply business rules, and enrich data
- Load: Insert structured data into MySQL warehouse tables

### 3. 📊 Data Modeling
- Designed a dimensional model with:
- Fact tables capturing sales transactions
- Dimension tables for customers and products
- Optimized for analytical queries and dashboard integration
