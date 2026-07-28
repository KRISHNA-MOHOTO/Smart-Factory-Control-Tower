/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 03_maintenance_analytics.sql

  Purpose:
  Analyze machine reliability, downtime, breakdown frequency,
  and machine health to identify maintenance priorities.

  Business Questions:
  1. Overall Downtime
  2. Machine Downtime Ranking
  3. Breakdown Analysis
  4. Machine Condition Monitoring
  5. Machine Health Assessment
==============================================================*/

USE smart_factory_control_tower;

-- ============================================================
-- 1. Overall Factory Downtime
-- Calculate total and average downtime across all machines.
-- ============================================================

SELECT
    SUM(downtime_min_machine) AS total_downtime_min,
    ROUND(AVG(downtime_min_machine), 2) AS avg_downtime_min
FROM
(
    SELECT
        machine_id,
        SUM(downtime_min) AS downtime_min_machine
    FROM fact_maintenance
    GROUP BY machine_id
) AS machine_downtime;


-- ============================================================
-- 2. Top 5 Machines by Downtime
-- Identify machines with the highest downtime.
-- ============================================================

SELECT
    machine_id,
    SUM(downtime_min) AS total_downtime_min
FROM fact_maintenance
GROUP BY machine_id
ORDER BY total_downtime_min DESC
LIMIT 5;


-- ============================================================
-- 3. Bottom 5 Machines by Downtime
-- Identify the best performing machines.
-- ============================================================

SELECT
    machine_id,
    SUM(downtime_min) AS total_downtime_min
FROM fact_maintenance
GROUP BY machine_id
ORDER BY total_downtime_min ASC
LIMIT 5;


-- ============================================================
-- 4. Average Operating Temperature
-- Compare average machine operating temperature.
-- ============================================================

SELECT
    machine_id,
    ROUND(AVG(temperature_c),2) AS avg_temperature_c
FROM fact_maintenance
GROUP BY machine_id
ORDER BY avg_temperature_c DESC;


-- ============================================================
-- 5. Average Machine Vibration
-- Compare vibration levels across machines.
-- ============================================================

SELECT
    machine_id,
    ROUND(AVG(vibration_mm_s),2) AS avg_vibration_mm_s
FROM fact_maintenance
GROUP BY machine_id
ORDER BY avg_vibration_mm_s DESC;


-- ============================================================
-- 6. Breakdown Frequency
-- Count machine breakdown events.
-- ============================================================

SELECT
    machine_id,
    SUM(breakdown_flag) AS breakdown_count
FROM fact_maintenance
GROUP BY machine_id
ORDER BY breakdown_count DESC;


-- ============================================================
-- 7. Monthly Downtime Trend
-- Track downtime over time.
-- ============================================================

SELECT
    DATE_FORMAT(date,'%Y-%m') AS maintenance_month,
    SUM(downtime_min) AS total_downtime_min
FROM fact_maintenance
GROUP BY maintenance_month
ORDER BY maintenance_month;


-- ============================================================
-- 8. Downtime Contribution by Machine
-- Calculate each machine's contribution to total downtime.
-- ============================================================

SELECT
    machine_id,
    downtime,
    ROUND(
        downtime / SUM(downtime) OVER() * 100,
        2
    ) AS contribution_pct
FROM
(
    SELECT
        machine_id,
        SUM(downtime_min) AS downtime
    FROM fact_maintenance
    GROUP BY machine_id
) AS machine_summary
ORDER BY contribution_pct DESC;


-- ============================================================
-- 9. Machine Health Score
-- Calculate a simple health score using weighted
-- downtime, temperature, and vibration metrics.
-- ============================================================

SELECT
    machine_id,
    ROUND(
        total_downtime * 0.40 +
        avg_temperature * 0.30 +
        avg_vibration * 0.30,
        2
    ) AS health_score
FROM
(
    SELECT
        machine_id,
        SUM(downtime_min) AS total_downtime,
        AVG(temperature_c) AS avg_temperature,
        AVG(vibration_mm_s) AS avg_vibration
    FROM fact_maintenance
    GROUP BY machine_id
) AS machine_health
ORDER BY health_score DESC;