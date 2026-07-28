/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 04_quality_analytics.sql

  Purpose:
  Analyze manufacturing quality performance by evaluating
  defects, scrap cost, product quality, defect distribution,
  and machine quality performance.

  Business Questions:
  1. Overall Quality Performance
  2. Scrap Cost Analysis
  3. Machine Quality Performance
  4. Product Quality Performance
  5. Defect Distribution
  6. Machine Quality Ranking
==============================================================*/

USE smart_factory_control_tower;

-- ============================================================
-- 1. Overall Factory Defects
-- Calculate the total number of defective parts produced.
-- ============================================================

SELECT
    SUM(defect_qty) AS total_defects
FROM fact_quality;


-- ============================================================
-- 2. Total Scrap Cost
-- Calculate the total financial impact of quality losses.
-- ============================================================

SELECT
    SUM(scrap_cost) AS total_scrap_cost
FROM fact_quality;


-- ============================================================
-- 3. Defects by Machine
-- Identify machines contributing the highest number of defects.
-- ============================================================

SELECT
    machine_id,
    SUM(defect_qty) AS total_defects
FROM fact_quality
GROUP BY machine_id
ORDER BY total_defects DESC;


-- ============================================================
-- 4. Scrap Cost by Machine
-- Identify machines generating the highest scrap cost.
-- ============================================================

SELECT
    machine_id,
    SUM(scrap_cost) AS total_scrap_cost
FROM fact_quality
GROUP BY machine_id
ORDER BY total_scrap_cost DESC;


-- ============================================================
-- 5. Defects by Product
-- Compare defect quantity across manufactured products.
-- ============================================================

SELECT
    product_id,
    SUM(defect_qty) AS total_defects
FROM fact_quality
GROUP BY product_id
ORDER BY total_defects DESC;


-- ============================================================
-- 6. Defect Type Analysis
-- Analyze defect distribution by defect category.
-- ============================================================

SELECT
    defect_type,
    SUM(defect_qty) AS total_defects
FROM fact_quality
GROUP BY defect_type
ORDER BY total_defects DESC;


-- ============================================================
-- 7. Defect Contribution Percentage
-- Calculate each defect type's contribution to total defects.
-- ============================================================

SELECT
    defect_type,
    total_defects,
    ROUND(
        total_defects / SUM(total_defects) OVER() * 100,
        2
    ) AS contribution_pct
FROM
(
    SELECT
        defect_type,
        SUM(defect_qty) AS total_defects
    FROM fact_quality
    GROUP BY defect_type
) AS defect_summary
ORDER BY contribution_pct DESC;


-- ============================================================
-- 8. Machine Quality Ranking
-- Rank machines based on total defect quantity.
-- Rank 1 represents the best performing machine.
-- ============================================================

SELECT
    machine_id,
    SUM(defect_qty) AS total_defects,
    DENSE_RANK() OVER(
        ORDER BY SUM(defect_qty)
    ) AS quality_rank
FROM fact_quality
GROUP BY machine_id;


-- ============================================================
-- 9. Maintenance and Quality Correlation
--
-- Business Interpretation:
-- Compare the results of maintenance and quality analysis
-- to determine whether machine reliability issues are
-- contributing to manufacturing defects.
--
-- Refer to:
-- • 03_maintenance_analytics.sql
-- • 04_quality_analytics.sql
-- ============================================================


-- ============================================================
-- 10. Root Cause Investigation
--
-- Objective:
-- Identify the primary machine responsible for quality losses
-- and use the analysis to support Root Cause Analysis (RCA),
-- Corrective and Preventive Actions (CAPA), and continuous
-- improvement initiatives.
--
-- Supporting Queries:
-- • Defects by Machine
-- • Scrap Cost by Machine
-- ============================================================