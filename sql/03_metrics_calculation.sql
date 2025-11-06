-- KPI Summary
INSERT OR REPLACE INTO kpi_summary VALUES 
('Total Sales', (SELECT SUM("Sales") FROM fact_orders), DATE('now')),
('Total Profit', (SELECT SUM("Profit") FROM fact_orders), DATE('now')),
('Average Profit Margin', (SELECT AVG("Profit Margin %") FROM fact_orders), DATE('now')),
('Total Orders', (SELECT COUNT(DISTINCT "Order ID") FROM fact_orders), DATE('now')),
('Total Customers', (SELECT COUNT(DISTINCT "Customer ID") FROM fact_orders), DATE('now')),
('Loss Rate', (SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_orders), 2) FROM fact_orders WHERE "Profitability"='Loss'), DATE('now'));

-- Monthly Sales
INSERT OR REPLACE INTO monthly_sales (month, total_sales, total_profit, order_count, customer_count, avg_profit_margin)
SELECT 
    substr("Order Date",1,7) as month,
    SUM("Sales"),
    SUM("Profit"),
    COUNT("Order ID"),
    COUNT(DISTINCT "Customer ID"),
    AVG("Profit Margin %")
FROM fact_orders
GROUP BY month;

-- Category Analysis
INSERT OR REPLACE INTO category_analysis (category, total_sales, total_profit, order_count, profit_margin_pct, avg_discount)
SELECT
    Category,
    SUM("Sales"),
    SUM("Profit"),
    COUNT("Order ID"),
    AVG("Profit Margin %"),
    AVG("Discount")
FROM fact_orders
GROUP BY Category;

-- Segment Analysis
INSERT OR REPLACE INTO segment_analysis (segment, total_sales, total_profit, order_count, customer_count, avg_profit_margin)
SELECT
    Segment,
    SUM("Sales"),
    SUM("Profit"),
    COUNT("Order ID"),
    COUNT(DISTINCT "Customer ID"),
    AVG("Profit Margin %")
FROM fact_orders
GROUP BY Segment;

-- Sub-Category Analysis
INSERT OR REPLACE INTO sub_category_analysis (sub_category, category, total_sales, total_profit, order_count, profit_margin_pct, avg_discount, status)
SELECT
    "Sub-Category",
    Category,
    SUM("Sales"),
    SUM("Profit"),
    COUNT("Order ID"),
    AVG("Profit Margin %"),
    AVG("Discount"),
    CASE WHEN SUM("Profit") < 0 THEN 'Loss-Making' ELSE 'Profitable' END
FROM fact_orders
GROUP BY "Sub-Category", Category;

-- Shipping Analysis
INSERT OR REPLACE INTO shipping_analysis (ship_mode, region, avg_shipping_days, order_count, total_sales, avg_profit)
SELECT
    "Ship Mode",
    Region,
    AVG("Shipping Days"),
    COUNT("Order ID"),
    SUM("Sales"),
    AVG("Profit")
FROM fact_orders
GROUP BY "Ship Mode", Region;
