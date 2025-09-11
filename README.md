# 🏗️ Sales Data Warehouse Project

## 🎯 Objective
This project showcases the development of a modern data warehouse using MySQL, integrating sales data from two operational systems—ERP and CRM—provided as CSV files. The goal is to consolidate, clean, and model this data into a unified, analytics-ready format that supports business reporting and decision-making.

## 📦 Project Overview

### 1. 🧱 Data Architecture
Implemented the Medallion Architecture with layered data processing:
- Bronze Layer: Raw ingestion of ERP and CRM CSV files
- Silver Layer: Cleaned and standardized data with unified schema 
- Gold Layer: Business-ready tables for reporting and analytics

[Data Architecture](https://github.com/pangwrl/sql-dwh-project/blob/main/docs/Data%20Architecture.pdf)

### 2. 🔄 ETL Pipelines
Built ETL workflows to:
- Extract: Load CSV files from ERP and CRM sources
- Transform: Resolve schema differences, apply business rules, and enrich data
- Load: Insert structured data into MySQL warehouse tables

### 3. 📊 Data Modeling
Designed a dimensional model with:
- Fact tables capturing sales transactions
- Dimension tables for customers and products
- Optimized for analytical queries and dashboard integration

## 📂 Repository Structure
```
data-warehouse-project/
│
├── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file shows all different techniquies and methods of ETL
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
```
