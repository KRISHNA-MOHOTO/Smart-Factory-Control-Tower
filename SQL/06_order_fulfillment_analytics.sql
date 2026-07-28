/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 06_order_fulfillment_analytics.sql

  Purpose:
  Analyze customer delivery performance, order fulfillment,
  OTIF (On-Time In-Full), delayed deliveries, and product
  delivery risk.

  Business Questions:
  1. Overall Order Performance
  2. OTIF Performance
  3. Delayed Order Analysis
  4. Product Delivery Risk
  5. Customer Service Impact
==============================================================*/

USE smart_factory_control_tower;

-- ============================================================
-- 1. Total Orders
-- Calculate the total number of customer orders.
-- ============================================================

SELECT
    COUNT(*) AS total_orders
FROM fact_orders;


-- ============================================================
-- 2. Order Status Breakdown
-- Analyze order distribution by delivery status.
-- ============================================================

SELECT
    status,
    COUNT(*) AS order_count
FROM fact_orders
GROUP BY status;


-- ============================================================
-- 3. OTIF (On-Time In-Full)
-- Calculate the percentage of orders delivered on time.
-- ============================================================

SELECT
    ROUND(
        on_time_orders / total_orders * 100,
        2
    ) AS otif_pct
FROM
(
    SELECT
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN status = 'On Time' THEN 1
                ELSE 0
            END
        ) AS on_time_orders
    FROM fact_orders
) AS order_summary;


-- ============================================================
-- 4. Delayed Orders by Product
-- Identify products with the highest delivery delays.
-- ============================================================

SELECT
    product_id,
    COUNT(*) AS delayed_orders
FROM fact_orders
WHERE status = 'Delayed'
GROUP BY product_id
ORDER BY delayed_orders DESC;


-- ============================================================
-- 5. Monthly Delay Trend
-- Track delayed deliveries over time.
-- ============================================================

SELECT
    DATE_FORMAT(dispatch_date,'%Y-%m') AS dispatch_month,
    COUNT(*) AS delayed_orders
FROM fact_orders
WHERE status = 'Delayed'
GROUP BY dispatch_month
ORDER BY dispatch_month;


-- ============================================================
-- 6. Product Delivery Performance Ranking
-- Rank products by delivery delay percentage.
-- ============================================================

SELECT
    *,
    ROUND(
        delayed_orders / total_orders * 100,
        2
    ) AS delayed_pct,
    DENSE_RANK() OVER(
        ORDER BY
        ROUND(delayed_orders / total_orders * 100,2) DESC
    ) AS delivery_rank
FROM
(
    SELECT
        product_id,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN status = 'Delayed' THEN 1
                ELSE 0
            END
        ) AS delayed_orders
    FROM fact_orders
    GROUP BY product_id
) AS delivery_summary;


-- ============================================================
-- 7. Product with Highest Delivery Risk
-- Identify the product experiencing the highest delay rate.
-- ============================================================

-- Based on this analysis:
-- P104 has the highest customer delivery risk.


-- ============================================================
-- 8. Customer Risk Classification
-- Categorize products according to delivery performance.
-- ============================================================

SELECT
    *,
    CASE
        WHEN delay_pct < 15 THEN 'Low Risk'
        WHEN delay_pct >= 15
             AND delay_pct < 20 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS risk_level
FROM
(
    SELECT
        product_id,
        SUM(
            CASE
                WHEN status = 'Delayed' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100 AS delay_pct
    FROM fact_orders
    GROUP BY product_id
) AS customer_risk;


-- ============================================================
-- 9. Operational Root Cause Assessment
--
-- Objective:
-- Correlate customer delivery performance with upstream
-- operational analyses.
--
-- Supporting Analysis:
-- • Machine Reliability (Maintenance)
-- • Quality Performance
-- • Inventory Risk
--
-- Purpose:
-- Determine whether production reliability, quality losses,
-- or inventory shortages contribute to delayed deliveries.
-- ============================================================


-- ============================================================
-- 10. Executive Business Summary
--
-- Overall Findings:
-- • Machine reliability issues increase production downtime.
-- • Quality losses increase rework and scrap.
-- • Inventory shortages create replenishment risk.
-- • Delivery delays reduce customer service performance.
--
-- Recommended Actions:
-- • Improve machine reliability through preventive maintenance.
-- • Reduce quality losses using RCA and CAPA.
-- • Strengthen inventory planning for critical materials.
-- • Prioritize high-risk products to improve OTIF performance.
--
-- These analyses provide an integrated operational view of
-- manufacturing performance and support executive decision-
-- making through the Smart Factory Control Tower dashboard.
-- ============================================================