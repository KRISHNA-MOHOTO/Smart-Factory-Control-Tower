# Power BI Model Design

## Table of Contents

1. Project Objective
2. Solution Architecture
3. Data Model Architecture
4. Why This Design?
5. Fact Tables
6. Dimension Tables
7. Relationships
8. Modeling Principles
9. Business Reporting Views
10. Dashboard Structure
11. Interactive Features
12. Key Business Findings
13. Recommended Actions
14. Technical Skills Demonstrated
15. Technology Stack
16. Business Value

---

# Project

**Smart Factory Control Tower**

---

# Project Objective

The objective of this project is to design and develop an end-to-end Manufacturing Analytics solution that transforms operational manufacturing data into actionable business insights using **MySQL** and **Power BI**.

The solution consolidates production, maintenance, quality, inventory, and customer delivery data into a centralized **Smart Factory Control Tower**, enabling Plant Managers, Manufacturing Engineers, Operations Teams, and Supply Chain professionals to monitor factory performance, identify operational risks, investigate root causes, and support continuous improvement through data-driven decision-making.

---

# Solution Architecture

```
Manufacturing Data
(CSV Files)
        │
        ▼
   MySQL Database
        │
        ▼
 Data Validation (SQL)
        │
        ▼
  Star Schema Design
        │
        ▼
 Business SQL Views
        │
        ▼
 Power BI Data Model
        │
        ▼
 DAX Measures & KPIs
        │
        ▼
 Smart Factory Control Tower
```

---

# Data Model Architecture

The Power BI solution follows a **Star Schema** architecture to ensure efficient filtering, scalable reporting, and simplified analytical queries.

Dimension tables filter multiple fact tables through **one-to-many relationships**, while business-level SQL views are imported as **disconnected reporting tables** for executive dashboards and operational summaries.

This architecture provides:

* Efficient report performance
* Simplified DAX calculations
* Correct business granularity
* Flexible reporting
* Scalable dashboard development
* Clean separation between transactional and reporting layers

---

# Why This Design?

Manufacturing systems generate data across multiple operational processes. Directly joining multiple fact tables inside Power BI can introduce duplicated records, incorrect aggregations, and poor performance.

To overcome these challenges:

* Transactional data is stored in individual fact tables.
* Business-level aggregation is performed in MySQL using SQL Views.
* Power BI consumes already-aggregated reporting views for executive dashboards.
* Dimension tables provide consistent filtering across transactional datasets.
* Reporting views remain disconnected to prevent incorrect fact-to-fact relationships while supporting operational summaries.

This design improves scalability, reporting accuracy, and overall model performance.

---

# Fact Tables

## fact_production

### Purpose

Stores production execution data generated during manufacturing operations.

### Key Metrics

* Planned Quantity
* Actual Quantity
* Runtime Hours
* Setup Time

### Relationships

* dim_machine
* dim_product
* dim_date

---

## fact_maintenance

### Purpose

Stores machine maintenance history and condition monitoring information.

### Key Metrics

* Downtime Minutes
* Breakdown Count
* Temperature
* Vibration

### Relationships

* dim_machine
* dim_date

---

## fact_quality

### Purpose

Stores manufacturing quality inspection results.

### Key Metrics

* Defect Quantity
* Scrap Cost
* Defect Type

### Relationships

* dim_machine
* dim_product
* dim_date

---

## fact_inventory

### Purpose

Stores inventory availability and material consumption information.

### Key Metrics

* Stock Quantity
* Daily Consumption
* Lead Time
* Reorder Level

### Relationships

* dim_material
* dim_date

---

## fact_orders

### Purpose

Stores customer order fulfillment and delivery information.

### Key Metrics

* Order Quantity
* Order Status
* Dispatch Date

### Relationships

* dim_product
* dim_date

---

# Dimension Tables

## dim_machine

### Attributes

* Machine ID
* Machine Type
* Production Line

### Purpose

Provides machine-level filtering across Production, Maintenance, and Quality datasets.

---

## dim_product

### Attributes

* Product ID
* Product Name

### Purpose

Supports production, quality, and customer delivery analysis.

---

## dim_material

### Attributes

* Material ID
* Material Name

### Purpose

Supports inventory monitoring and material risk analysis.

---

## dim_date

### Attributes

* Date
* Day
* Month
* Quarter
* Year

### Purpose

Provides a common calendar dimension for time-based analysis across all business processes.

---

# Relationships

## One-to-Many Relationships

### Machine

* dim_machine → fact_production
* dim_machine → fact_maintenance
* dim_machine → fact_quality

### Product

* dim_product → fact_production
* dim_product → fact_quality
* dim_product → fact_orders

### Material

* dim_material → fact_inventory

### Date

* dim_date → fact_production
* dim_date → fact_maintenance
* dim_date → fact_quality
* dim_date → fact_inventory
* dim_date → fact_orders

---

# Modeling Principles

The Power BI semantic model follows these design principles:

1. Star Schema architecture is used throughout the solution.
2. No direct fact-to-fact relationships are created.
3. Dimension tables filter fact tables using one-to-many relationships.
4. SQL performs business-level aggregation before Power BI consumes the data.
5. Reporting views maintain the correct business granularity.
6. SQL reporting views remain disconnected from transactional fact tables.
7. DAX measures are used for dynamic KPIs, calculations, and interactive reporting.

---

# Business Reporting Views

Business reporting views are created in MySQL to aggregate operational data before it is imported into Power BI.

---

## vw_factory_overview

### Grain

One Row = Entire Factory

### Purpose

Provides executive KPIs including:

* Production Achievement %
* Total Defects
* Scrap Cost
* Total Downtime
* Total Orders
* OTIF %

---

## vw_machine_risk

### Grain

One Row = One Machine

### Purpose

Aggregates maintenance and quality information to identify machine reliability risks.

### Metrics

* Downtime
* Breakdown Count
* Average Temperature
* Average Vibration
* Defect Quantity
* Scrap Cost
* Risk Level

---

## vw_inventory_risk

### Grain

One Row = One Material

### Purpose

Supports inventory planning and material risk analysis.

### Metrics

* Average Stock
* Daily Consumption
* Lead Time
* Risk Score
* Risk Rank
* Risk Level

---

## vw_customer_risk

### Grain

One Row = One Product

### Purpose

Provides customer delivery performance metrics.

### Metrics

* Total Orders
* Delayed Orders
* Delay Percentage
* OTIF %
* Risk Ranking
* Risk Level

---

# Dashboard Structure

## Page 1 — Executive Control Tower

### Business Question

Where should management focus today?

### Audience

* Plant Managers
* Operations Heads

### Purpose

Provides a factory-wide operational overview by highlighting the most critical business risks.

### KPIs

* Production Achievement %
* Defect Rate %
* OTIF %
* Critical Machines
* Critical Materials

---

## Page 2 — Machine Health & Reliability Center

### Business Question

Which machines are reducing factory productivity and what maintenance actions should be prioritized?

### Audience

* Maintenance Engineers
* Reliability Engineers
* Plant Managers

### Analysis

* Downtime
* Breakdown Frequency
* Temperature
* Vibration
* Machine Risk Ranking
* Maintenance Recommendations

---

## Page 3 — Quality Intelligence Center

### Business Question

Why are defects occurring and what operational factors are driving quality losses?

### Audience

* Quality Engineers
* Manufacturing Engineers

### Analysis

* Defect Quantity
* Scrap Cost
* Defect Type Analysis
* Machine Quality Ranking
* Product Quality Analysis

---

## Page 4 — Inventory Risk Center

### Business Question

Will production stop before new materials arrive?

### Audience

* Inventory Planners
* Supply Chain Teams

### Analysis

* Days of Stock
* Supplier Lead Time
* Material Consumption
* Inventory Risk Ranking
* Stock Coverage Analysis

---

## Page 5 — Customer Delivery Performance Center

### Business Question

Which products are putting customer satisfaction at risk?

### Audience

* Production Planning
* Customer Service
* Operations Managers

### Analysis

* OTIF %
* Delayed Orders
* Product Delivery Ranking
* Customer Risk Analysis
* Monthly Delivery Performance

---

# Interactive Features

The dashboard includes several interactive capabilities to improve business analysis:

* Drill-through navigation
* Cross-page filtering
* Interactive slicers
* Dynamic KPI cards
* Executive summary panels
* Operational recommendation panels

---

# Key Business Findings

## Executive Overview

The Executive Control Tower identified:

* Machine **M302**
* Material **RM08**
* Product **P104**

as the highest operational priorities requiring immediate management attention.

---

## Machine Reliability

Machine **M302** recorded:

* Highest downtime
* Highest breakdown frequency
* Highest operating temperature
* Highest vibration level

These indicators suggest declining equipment reliability and increased production risk.

---

## Quality

Machine **M302** generated the highest defect quantity and scrap cost, while **Product P104** recorded the highest number of defects.

This demonstrates a clear relationship between equipment reliability and manufacturing quality.

---

## Inventory

Material **RM08** presents the greatest inventory risk due to low stock coverage relative to supplier lead time.

The dashboard extends traditional inventory monitoring by comparing **Days of Stock** against **Lead Time**, providing a practical production planning metric.

---

## Customer Delivery

Product **P104** recorded the highest delayed order volume and the lowest delivery performance, indicating the greatest customer delivery risk.

---

# Recommended Actions

* Perform Root Cause Analysis (RCA) for Machine **M302**.
* Strengthen Preventive Maintenance and CAPA activities.
* Improve inventory planning for **RM08** using Days of Stock versus Lead Time.
* Prioritize production scheduling for **P104**.
* Continuously monitor operational KPIs using the Smart Factory Control Tower.

---

# Technical Skills Demonstrated

* MySQL Database Design
* SQL Query Development
* SQL Views
* Data Validation
* Star Schema Data Modeling
* Power BI
* DAX
* KPI Design
* Interactive Dashboard Development
* Drill-through Navigation
* Cross-filtering
* Manufacturing Analytics
* Root Cause Analysis (RCA)
* Preventive Maintenance Analytics
* Inventory Planning
* OTIF Analysis
* Executive Business Reporting

---

# Technology Stack

| Component           | Technology                                    |
| ------------------- | --------------------------------------------- |
| Database            | MySQL                                         |
| Query Language      | SQL                                           |
| Data Modeling       | Star Schema                                   |
| Visualization       | Power BI                                      |
| Analytical Language | DAX                                           |
| Domain              | Manufacturing Analytics                       |
| Project Type        | Business Intelligence & Operational Analytics |

---

# Business Value

The Smart Factory Control Tower demonstrates the complete analytics lifecycle—from data validation and relational data modeling to SQL-based business transformations, DAX calculations, and interactive Power BI reporting.

By integrating production, maintenance, quality, inventory, and customer delivery into a unified decision-support platform, the solution enables manufacturing organizations to identify operational risks earlier, prioritize corrective actions, improve cross-functional visibility, and support continuous improvement through data-driven decision-making.
