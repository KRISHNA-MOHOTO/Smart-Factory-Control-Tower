# Smart Factory Control Tower – Business Story

## Project Objective

The objective of this project is to demonstrate how manufacturing data from production, maintenance, quality, inventory, and customer delivery can be transformed into actionable business insights using MySQL and Power BI.

The solution enables operational teams to identify risks early, investigate root causes, and support continuous improvement through a centralized Smart Factory Control Tower.

## Technology Stack

- MySQL
- Power BI
- SQL Views
- DAX
- Star Schema Data Modeling

## Business Problem

Modern manufacturing plants generate operational data across production, maintenance, quality, inventory, and customer delivery. When these functions operate in isolation, organizations struggle to identify the root causes of operational issues before they impact production efficiency, costs, and customer satisfaction.

This project demonstrates how a Smart Factory Control Tower can integrate manufacturing data into a centralized decision-support dashboard, enabling managers to monitor key operational risks, identify bottlenecks, and make data-driven decisions in real time.

---

## Operational Risk

The Executive Control Tower provides a high-level view of factory performance by monitoring production achievement, machine reliability, inventory status, quality performance, and customer delivery metrics.

The dashboard immediately highlights critical operational risks requiring management attention. In this case study, Machine **M302**, Material **RM08**, and Product **P104** consistently emerge as the primary operational concerns, allowing decision-makers to focus on the highest business priorities rather than reviewing multiple disconnected reports.

---

## Machine Reliability Risk

The Machine Health & Reliability Center identifies assets that have the greatest impact on production performance.

Analysis revealed that **Machine M302** experienced:

* Highest downtime
* Highest breakdown count
* Highest operating temperature
* Highest vibration level

These indicators suggest deteriorating machine health, increasing the likelihood of unplanned production interruptions and reduced manufacturing capacity.

---

## Quality Risk

The Quality Intelligence Center investigates how machine performance affects manufacturing quality.

The analysis shows that **Machine M302** also generated the highest defect quantity and scrap cost, while **Product P104** recorded the highest number of quality defects.

This demonstrates a direct relationship between equipment reliability and product quality, highlighting opportunities for preventive maintenance and process improvement.

---

## Inventory Risk

The Inventory Risk Center evaluates material availability using **Days of Stock** compared with **Supplier Lead Time**, providing a practical inventory planning perspective.

Material **RM08** was identified as the most critical inventory risk because its available stock coverage is significantly lower than the supplier replenishment lead time.

This creates a high probability of production stoppages unless procurement actions are taken before stock depletion.

---

## Customer Delivery Risk

The Customer Delivery Performance Center measures customer service performance using OTIF (On-Time In-Full), delayed orders, and product-level delivery metrics.

**Product P104** recorded the highest delayed order volume and one of the lowest OTIF performances, demonstrating how upstream operational problems ultimately impact customer satisfaction and delivery performance.

---

## Dashboard Features

- Executive Control Tower
- Machine Health & Reliability Center
- Quality Intelligence Center
- Inventory Risk Center
- Customer Delivery Performance Center
- Drill-through Navigation
- Dynamic KPI Cards
- Interactive Cross-filtering
- Executive Summary Panels

## Overall Business Impact

This project illustrates how operational issues propagate throughout a manufacturing environment:

* Machine failures increase downtime.
* Downtime contributes to higher defect rates and scrap costs.
* Quality losses and inventory shortages disrupt production.
* Production delays reduce OTIF performance and increase delayed customer orders.
* The combined effect impacts operational efficiency, manufacturing costs, and customer satisfaction.

By connecting these business functions into a single analytics platform, the dashboard enables faster identification of root causes and supports proactive decision-making.

---

## Recommended Actions

* Prioritize preventive maintenance for Machine **M302**.
* Perform root cause analysis on recurring quality defects.
* Increase inventory monitoring for critical material **RM08** using Days of Stock versus Lead Time.
* Improve production planning for Product **P104** to reduce delayed orders.
* Monitor operational KPIs through the Control Tower to support continuous improvement and data-driven manufacturing decisions.
---

## Key Learnings

During this project, several important data engineering and business intelligence concepts were applied:

- Designed a Star Schema data model for manufacturing analytics.
- Performed comprehensive data validation before analysis.
- Learned the importance of data granularity and why fact tables should not be joined directly.
- Created SQL views to aggregate data at the appropriate business level for reporting.
- Developed DAX measures to support executive KPIs and operational analysis.
- Built an interactive Power BI solution using drill-through navigation and business-focused dashboards.
- Applied manufacturing concepts such as preventive maintenance, RCA, CAPA, OTIF, and inventory planning to convert raw data into actionable insights.