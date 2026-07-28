/*==============================================================
  SMART FACTORY CONTROL TOWER
  File: 07_control_tower_views.sql

  Purpose:
  Create business-level SQL views to support Power BI reporting.

  Design Principles:
  • Aggregate fact tables to the required business grain.
  • Prevent fact-to-fact row multiplication.
  • Improve Power BI performance.
  • Provide reusable KPI views for dashboard development.
==============================================================*/

USE smart_factory_control_tower;
-- ============================================================
-- View 1 : vw_factory_overview
--
-- Grain:
-- One Row = Entire Factory
--
-- Purpose:
-- Executive KPI layer used by the Control Tower dashboard.
-- ============================================================
-- ============================================================
-- View 2 : vw_machine_risk
--
-- Grain:
-- One Row = One Machine
--
-- Purpose:
-- Combine maintenance and quality metrics into a
-- machine-level operational risk view.
-- ============================================================
-- ============================================================
-- View 3 : vw_inventory_risk
--
-- Grain:
-- One Row = One Material
--
-- Purpose:
-- Calculate inventory risk using stock,
-- consumption and lead time.
-- ============================================================
-- ============================================================
-- View 4 : vw_customer_risk
--
-- Grain:
-- One Row = One Product
--
-- Purpose:
-- Summarize delivery performance and classify
-- customer delivery risk.
-- ============================================================
/*==============================================================

View Summary

vw_factory_overview
    → Executive KPI Dashboard

vw_machine_risk
    → Machine Health Center

vw_inventory_risk
    → Inventory Risk Center

vw_customer_risk
    → Customer Delivery Center

These views are imported into Power BI to provide
business-level aggregated data while preserving
fact table granularity inside the data model.

==============================================================*