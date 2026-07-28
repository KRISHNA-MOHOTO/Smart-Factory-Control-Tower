/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 05_inventory_risk_analytics.sql

  Purpose:
  Analyze inventory availability, replenishment risk,
  material consumption, and procurement risk to identify
  materials that may disrupt production.

  Business Questions:
  1. Inventory Availability
  2. Reorder Risk
  3. Lead Time Analysis
  4. Inventory Risk Assessment
  5. Critical Material Identification
==============================================================*/

USE smart_factory_control_tower;

-- ============================================================
-- 1. Total Inventory Available
-- Calculate available inventory by material.
-- ============================================================

SELECT
    material_id,
    SUM(stock_qty) AS total_inventory
FROM fact_inventory
GROUP BY material_id;


-- ============================================================
-- 2. Materials Below Reorder Level
-- Identify materials requiring replenishment.
-- ============================================================

SELECT
    material_id,
    SUM(reorder_level) AS total_reorder_level,
    SUM(stock_qty) AS total_inventory
FROM fact_inventory
GROUP BY material_id
HAVING total_inventory < total_reorder_level;


-- ============================================================
-- 3. Top 5 Materials with Highest Lead Time
-- Identify materials with the longest procurement lead time.
-- ============================================================

SELECT
    material_id,
    SUM(lead_time_days) AS total_lead_time
FROM fact_inventory
GROUP BY material_id
ORDER BY total_lead_time DESC
LIMIT 5;


-- ============================================================
-- 4. Average Inventory by Material
-- Calculate average stock quantity for each material.
-- ============================================================

SELECT
    material_id,
    ROUND(AVG(stock_qty),2) AS avg_stock_qty
FROM fact_inventory
GROUP BY material_id;


-- ============================================================
-- 5. Inventory Risk Score
-- Assign a simple inventory risk score based on:
-- • Low Stock
-- • High Lead Time
-- • High Daily Consumption
-- ============================================================

SELECT
    material_id,
    (
        CASE WHEN avg_stock_qty < 1500 THEN 1 ELSE 0 END +
        CASE WHEN avg_lead_time > 20 THEN 1 ELSE 0 END +
        CASE WHEN avg_consumption > 130 THEN 1 ELSE 0 END
    ) AS risk_score
FROM
(
    SELECT
        material_id,
        AVG(stock_qty) AS avg_stock_qty,
        AVG(lead_time_days) AS avg_lead_time,
        AVG(daily_consumption) AS avg_consumption
    FROM fact_inventory
    GROUP BY material_id
) AS inventory_summary;


-- ============================================================
-- 6. Inventory Risk Ranking
-- Rank materials based on calculated inventory risk score.
-- ============================================================

SELECT
    *,
    DENSE_RANK() OVER(
        ORDER BY risk_score DESC
    ) AS risk_rank
FROM
(
    SELECT
        material_id,
        (
            CASE WHEN avg_stock_qty < 1500 THEN 1 ELSE 0 END +
            CASE WHEN avg_lead_time > 20 THEN 1 ELSE 0 END +
            CASE WHEN avg_consumption > 130 THEN 1 ELSE 0 END
        ) AS risk_score
    FROM
    (
        SELECT
            material_id,
            AVG(stock_qty) AS avg_stock_qty,
            AVG(lead_time_days) AS avg_lead_time,
            AVG(daily_consumption) AS avg_consumption
        FROM fact_inventory
        GROUP BY material_id
    ) AS inventory_summary
) AS risk_analysis;


-- ============================================================
-- 7. Critical Material Identification
-- Material with the highest inventory risk score.
-- ============================================================

-- Based on this analysis:
-- RM08 is identified as the highest-risk material.


-- ============================================================
-- 8. Material Requiring Daily Monitoring
-- Identify materials requiring close operational monitoring.
-- ============================================================

-- Based on inventory risk analysis:
-- RM08 should be monitored daily.


-- ============================================================
-- 9. Compare Critical Material with Plant Average
-- Compare RM08 inventory characteristics against
-- overall plant averages.
-- ============================================================

SELECT *
FROM
(
    SELECT
        material_id,
        avg_stock_qty,
        ROUND(AVG(avg_stock_qty) OVER(),2) AS plant_avg_stock,
        avg_lead_time,
        ROUND(AVG(avg_lead_time) OVER(),2) AS plant_avg_lead_time,
        avg_consumption,
        ROUND(AVG(avg_consumption) OVER(),2) AS plant_avg_consumption
    FROM
    (
        SELECT
            material_id,
            ROUND(AVG(stock_qty),2) AS avg_stock_qty,
            ROUND(AVG(lead_time_days),2) AS avg_lead_time,
            ROUND(AVG(daily_consumption),2) AS avg_consumption
        FROM fact_inventory
        GROUP BY material_id
    ) AS inventory_summary
) AS plant_comparison
WHERE material_id = 'RM08';


-- ============================================================
-- 10. Business Interpretation
--
-- Objective:
-- Identify inventory risks that may interrupt production
-- and support procurement planning.
--
-- Operational Recommendation:
-- • Maintain adequate safety stock.
-- • Monitor critical materials regularly.
-- • Improve supplier lead time where possible.
-- • Balance inventory levels with consumption trends.
--
-- Note:
-- The Power BI dashboard extends this analysis by comparing
-- Days of Stock against Lead Time, providing a more practical
-- operational view of inventory availability.
-- ============================================================