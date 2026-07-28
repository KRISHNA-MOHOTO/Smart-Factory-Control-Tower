/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 01_data_validation.sql

  Purpose:
  Validate the manufacturing dataset before performing
  business analysis and dashboard development.

  Validation Checks:
  1. Record Count
  2. Date Range
  3. Missing Values
  4. Duplicate Records
  5. Referential Integrity
  6. Business Rule Validation
==============================================================*/

USE smart_factory_control_tower;

-- ============================================================
-- 1. Record Count Validation
-- Verify the number of records loaded into each table.
-- ============================================================

SELECT COUNT(*) AS total_records FROM dim_machine;
SELECT COUNT(*) AS total_records FROM dim_material;
SELECT COUNT(*) AS total_records FROM dim_product;

SELECT COUNT(*) AS total_records FROM fact_production;
SELECT COUNT(*) AS total_records FROM fact_maintenance;
SELECT COUNT(*) AS total_records FROM fact_quality;
SELECT COUNT(*) AS total_records FROM fact_inventory;
SELECT COUNT(*) AS total_records FROM fact_orders;


-- ============================================================
-- 2. Date Range Validation
-- Verify the available date range in each fact table.
-- ============================================================

SELECT
    MIN(production_date) AS start_date,
    MAX(production_date) AS end_date
FROM fact_production;

SELECT
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM fact_maintenance;

SELECT
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM fact_quality;

SELECT
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM fact_inventory;

SELECT
    MIN(order_date) AS start_date,
    MAX(order_date) AS end_date
FROM fact_orders;


-- ============================================================
-- 3. Missing Value Validation
-- Check critical business keys for NULL values.
-- ============================================================

SELECT *
FROM fact_production
WHERE machine_id IS NULL
   OR product_id IS NULL;

SELECT *
FROM fact_maintenance
WHERE machine_id IS NULL;

SELECT *
FROM fact_quality
WHERE machine_id IS NULL
   OR product_id IS NULL;

SELECT *
FROM fact_inventory
WHERE material_id IS NULL;

SELECT *
FROM fact_orders
WHERE order_id IS NULL
   OR product_id IS NULL;


-- ============================================================
-- 4. Duplicate Record Validation
-- Detect duplicate production records based on
-- Production Date + Machine + Shift.
-- ============================================================

SELECT
    production_date,
    machine_id,
    shift,
    COUNT(*) AS duplicate_count
FROM fact_production
GROUP BY
    production_date,
    machine_id,
    shift
HAVING COUNT(*) > 1;


-- ============================================================
-- 5. Referential Integrity Validation
-- Ensure all foreign keys exist in their corresponding
-- dimension tables.
-- ============================================================

-- Production → Machine

SELECT DISTINCT fp.machine_id
FROM fact_production fp
LEFT JOIN dim_machine dm
       ON fp.machine_id = dm.machine_id
WHERE dm.machine_id IS NULL;


-- Production → Product

SELECT DISTINCT fp.product_id
FROM fact_production fp
LEFT JOIN dim_product dp
       ON fp.product_id = dp.product_id
WHERE dp.product_id IS NULL;


-- Inventory → Material

SELECT DISTINCT fi.material_id
FROM fact_inventory fi
LEFT JOIN dim_material dm
       ON fi.material_id = dm.material_id
WHERE dm.material_id IS NULL;


-- ============================================================
-- 6. Business Rule Validation
-- Validate logical consistency of operational data.
-- ============================================================

-- Actual production should not exceed planned production.

SELECT *
FROM fact_production
WHERE actual_qty > planned_qty;


-- Inventory quantity should never be negative.

SELECT *
FROM fact_inventory
WHERE stock_qty < 0;


-- Defect quantity should never be negative.

SELECT *
FROM fact_quality
WHERE defect_qty < 0;


-- Due date should always be after the order date.

SELECT *
FROM fact_orders
WHERE due_date < order_date;