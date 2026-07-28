# 🏭 Smart Factory Control Tower

An end-to-end Manufacturing Analytics and Business Intelligence solution built using **MySQL**, **SQL**, **Power BI**, and **DAX**.

This project simulates a modern smart manufacturing environment by integrating production, maintenance, quality, inventory, and customer delivery data into a centralized **Smart Factory Control Tower**. The solution enables manufacturing teams to monitor operational performance, identify risks, investigate root causes, and support data-driven decision-making.

---

# 📌 Project Overview

Manufacturing organizations generate operational data across multiple departments. When these datasets remain isolated, identifying the root causes of production issues becomes difficult.

The Smart Factory Control Tower consolidates manufacturing data into a unified analytics platform that helps decision-makers answer questions such as:

- Are production targets being achieved?
- Which machines are at the highest operational risk?
- How is machine reliability affecting product quality?
- Which materials are likely to cause production interruptions?
- Which products are creating customer delivery issues?

---

# 🎯 Project Objectives

- Build an end-to-end Manufacturing Analytics solution.
- Design a Star Schema data model.
- Perform data validation and business analysis using SQL.
- Create SQL Views for business-level reporting.
- Develop interactive Power BI dashboards using DAX.
- Demonstrate how operational risks propagate across a manufacturing plant.

---

# 🛠 Technology Stack

| Category | Technology |
|-----------|------------|
| Database | MySQL |
| Query Language | SQL |
| Visualization | Power BI |
| Analytics | DAX |
| Data Model | Star Schema |
| Domain | Manufacturing Analytics |

---

# 📂 Project Workflow

```text
Synthetic Manufacturing Data
            │
            ▼
      MySQL Database
            │
            ▼
      Data Validation
            │
            ▼
 Business SQL Analysis
            │
            ▼
     SQL Reporting Views
            │
            ▼
 Power BI Data Modeling
            │
            ▼
     DAX Calculations
            │
            ▼
 Smart Factory Control Tower
```

---

# 🏗 Data Model

The solution follows a **Star Schema** architecture.

### Fact Tables

- fact_production
- fact_maintenance
- fact_quality
- fact_inventory
- fact_orders

### Dimension Tables

- dim_machine
- dim_product
- dim_material
- dim_date

### Reporting Views

- vw_factory_overview
- vw_machine_risk
- vw_inventory_risk
- vw_customer_risk

**Modeling Principles**

- Star Schema
- One-to-Many Relationships
- No Fact-to-Fact Relationships
- SQL Aggregation before Power BI
- Business-Level Granularity
- Disconnected Reporting Views

---

# 📊 Dashboard Pages

## 1️⃣ Executive Control Tower

Provides a high-level operational overview of the manufacturing plant.

### KPIs

- Production Achievement %
- Defect Rate %
- OTIF %
- Critical Machines
- Critical Materials

Focus:

Executive decision-making and operational monitoring.

---

## 2️⃣ Machine Health & Reliability Center

Monitors machine condition and maintenance performance.

Analysis includes:

- Downtime
- Temperature
- Vibration
- Breakdown Frequency
- Machine Health Score

---

## 3️⃣ Quality Intelligence Center

Evaluates manufacturing quality performance.

Analysis includes:

- Defect Quantity
- Scrap Cost
- Defect Type Analysis
- Machine Quality Ranking
- Product Quality Analysis

---

## 4️⃣ Inventory Risk Center

Monitors material availability and production continuity.

Analysis includes:

- Days of Stock
- Supplier Lead Time
- Material Consumption
- Inventory Risk Ranking

---

## 5️⃣ Customer Delivery Performance Center

Measures customer service performance.

Analysis includes:

- OTIF %
- Delayed Orders
- Delivery Performance
- Customer Delivery Risk

---

# 🔍 Business Insights

### Operational Risk

Machine **M302** recorded:

- Highest downtime
- Highest vibration
- Highest temperature
- Highest breakdown frequency

---

### Quality Risk

Machine **M302** generated:

- Highest defect quantity
- Highest scrap cost

Product **P104** recorded the highest quality defects.

---

### Inventory Risk

Material **RM08** showed the greatest inventory risk because its **Days of Stock** were significantly lower than its supplier **Lead Time**, increasing the likelihood of production interruptions.

---

### Customer Delivery Risk

Product **P104** experienced the highest delayed order percentage, impacting OTIF performance and customer satisfaction.

---

# 💡 Key Business Story

The project demonstrates how operational problems propagate through a manufacturing plant.

```text
Machine Reliability Issues
            │
            ▼
      Increased Downtime
            │
            ▼
      Higher Defect Rates
            │
            ▼
      Increased Scrap Cost
            │
            ▼
Inventory & Production Disruptions
            │
            ▼
Customer Delivery Delays
```

Rather than analyzing each department independently, the Control Tower connects these operational functions into a single decision-support system.

---

# 📁 Repository Structure

```text
Smart-Factory-Control-Tower
│
├── Data
│   ├── Dimension Tables
│   └── Fact Tables
│
├── SQL
│   ├── Data Validation
│   ├── Factory Overview
│   ├── Maintenance Analytics
│   ├── Quality Analytics
│   ├── Inventory Analytics
│   ├── Order Fulfillment Analytics
│   └── Dashboard Views
│
├── Power BI
│   └── Smart_Factory_Control_Tower.pbix
│
├── Assets
│   ├── Executive Dashboard
│   ├── Machine Health
│   ├── Quality
│   ├── Inventory
│   └── Customer Delivery
│
├── Documentation
│
└── README.md
```

---

# 🎯 Key Learnings

During this project I:

- Designed a Star Schema for manufacturing analytics.
- Performed comprehensive SQL-based data validation.
- Learned the importance of data granularity and why fact tables should not be joined directly.
- Created SQL views to aggregate data at the appropriate business grain.
- Built reusable DAX measures for executive KPIs.
- Developed interactive Power BI dashboards with drill-through navigation.
- Applied manufacturing concepts such as Preventive Maintenance, RCA, CAPA, OTIF, and inventory planning to transform raw data into actionable business insights.

---

# 🚀 Future Enhancements

- Report page tooltips
- Dynamic KPI conditional formatting
- Predictive maintenance using machine sensor trends
- Real-time IoT integration
- Supplier performance dashboard
- OEE (Overall Equipment Effectiveness) module

---

# 👨‍💻 Author

**Krishna**

Industrial Engineer | Manufacturing Analytics | SQL | Power BI | Continuous Improvement

If you found this project helpful or interesting, feel free to ⭐ the repository.
