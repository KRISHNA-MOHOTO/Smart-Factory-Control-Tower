/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 02_factory_overview.sql

  Purpose:
  Analyze overall factory production performance, capacity
  utilization, and production achievement across machines,
  production lines, shifts, and products.

  Business Questions:
  1. Overall Production Output
  2. Production Achievement
  3. Line Performance
  4. Shift Performance
  5. Machine Performance
  6. Monthly Production Trend
==============================================================*/

USE smart_factory_control_tower;

-- ============================================================
-- 1. Overall Factory Production
-- Compare planned production with actual production.
-- ============================================================

SELECT
    SUM(planned_qty) AS total_planned_qty,
    SUM(actual_qty) AS total_actual_qty
FROM fact_production;


-- ============================================================
-- 2. Production Achievement Percentage
-- Measure overall factory production efficiency.
-- ============================================================

SELECT
    ROUND(
        SUM(actual_qty) / SUM(planned_qty) * 100,
        2
    ) AS production_achievement_pct
FROM fact_production;


-- ============================================================
-- 3. Production Achievement by Production Line
-- Identify the best performing production lines.
-- ============================================================

SELECT
    line,
    SUM(actual_qty) AS actual_qty,
    SUM(planned_qty) AS planned_qty,
    ROUND(
        SUM(actual_qty) / SUM(planned_qty) * 100,
        2
    ) AS production_achievement_pct
FROM fact_production
GROUP BY line
ORDER BY production_achievement_pct DESC;


-- ============================================================
-- 4. Production Achievement by Shift
-- Compare production efficiency across shifts.
-- ============================================================

SELECT
    shift,
    SUM(actual_qty) AS actual_qty,
    SUM(planned_qty) AS planned_qty,
    ROUND(
        SUM(actual_qty) / SUM(planned_qty) * 100,
        2
    ) AS production_achievement_pct
FROM fact_production
GROUP BY shift
ORDER BY production_achievement_pct DESC;


-- ============================================================
-- 5. Top 5 Machines by Actual Production
-- Identify machines with the highest production output.
-- ============================================================

SELECT
    machine_id,
    SUM(actual_qty) AS total_actual_qty
FROM fact_production
GROUP BY machine_id
ORDER BY total_actual_qty DESC
LIMIT 5;


-- ============================================================
-- 6. Bottom 5 Machines by Production Achievement
-- Identify machines with the lowest production efficiency.
-- ============================================================

SELECT
    machine_id,
    SUM(planned_qty) AS planned_qty,
    SUM(actual_qty) AS actual_qty,
    ROUND(
        SUM(actual_qty) / SUM(planned_qty) * 100,
        2
    ) AS production_achievement_pct
FROM fact_production
GROUP BY machine_id
ORDER BY production_achievement_pct ASC
LIMIT 5;


-- ============================================================
-- 7. Monthly Production Trend
-- Track planned versus actual production over time.
-- ============================================================

SELECT
    DATE_FORMAT(production_date, '%Y-%m') AS production_month,
    SUM(planned_qty) AS planned_qty,
    SUM(actual_qty) AS actual_qty
FROM fact_production
GROUP BY production_month
ORDER BY production_month;


-- ============================================================
-- 8. Product with the Highest Production Volume
-- Identify the product with the greatest production output.
-- ============================================================

SELECT
    product_id,
    SUM(actual_qty) AS total_actual_qty
FROM fact_production
GROUP BY product_id
ORDER BY total_actual_qty DESC
LIMIT 1;


-- ============================================================
-- 9. Production Line Ranking
-- Rank production lines based on total production output.
-- ============================================================

SELECT
    *,
    DENSE_RANK() OVER (ORDER BY actual_qty DESC) AS production_rank
FROM
(
    SELECT
        line,
        SUM(actual_qty) AS actual_qty
    FROM fact_production
    GROUP BY line
) AS line_summary;


-- ============================================================
-- 10. Production Contribution by Line
-- Calculate each production line's contribution to
-- total factory output.
-- ============================================================

SELECT
    *,
    ROUND(
        actual_qty / SUM(actual_qty) OVER() * 100,
        2
    ) AS contribution_pct
FROM
(
    SELECT
        line,
        SUM(actual_qty) AS actual_qty
    FROM fact_production
    GROUP BY line
) AS line_summary
ORDER BY contribution_pct DESC;