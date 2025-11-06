-- Таблица фактов заказов
CREATE TABLE IF NOT EXISTS fact_orders (
    order_id TEXT PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    region TEXT,
    city TEXT,
    category TEXT,
    sub_category TEXT,
    product_id TEXT,
    product_name TEXT,
    sales REAL,
    quantity INTEGER,
    discount REAL,
    profit REAL,
    shipping_days INTEGER,
    profit_margin_pct REAL,
    aov REAL,
    profitability TEXT,
    order_year INTEGER,
    order_month INTEGER,
    order_month_name TEXT,
    order_quarter INTEGER,
    order_day_of_week TEXT,
    discount_band TEXT
);

-- Витрина: ключевые метрики (KPI)
CREATE TABLE IF NOT EXISTS kpi_summary (
    metric_name TEXT PRIMARY KEY,
    metric_value REAL,
    metric_date DATE
);

-- Витрина: продажи и прибыль по месяцам
CREATE TABLE IF NOT EXISTS monthly_sales (
    month TEXT PRIMARY KEY,
    total_sales REAL,
    total_profit REAL,
    order_count INTEGER,
    customer_count INTEGER,
    avg_profit_margin REAL
);

-- Витрина: анализ по категориям товаров
CREATE TABLE IF NOT EXISTS category_analysis (
    category TEXT PRIMARY KEY,
    total_sales REAL,
    total_profit REAL,
    order_count INTEGER,
    profit_margin_pct REAL,
    avg_discount REAL
);

-- Витрина: анализ по сегментам
CREATE TABLE IF NOT EXISTS segment_analysis (
    segment TEXT PRIMARY KEY,
    total_sales REAL,
    total_profit REAL,
    order_count INTEGER,
    customer_count INTEGER,
    avg_profit_margin REAL
);

-- Витрина: анализ по подкатегориям
CREATE TABLE IF NOT EXISTS sub_category_analysis (
    sub_category TEXT PRIMARY KEY,
    category TEXT,
    total_sales REAL,
    total_profit REAL,
    order_count INTEGER,
    profit_margin_pct REAL,
    avg_discount REAL,
    status TEXT
);

-- Витрина: анализ доставки по регионам и методам
CREATE TABLE IF NOT EXISTS shipping_analysis (
    ship_mode TEXT,
    region TEXT,
    avg_shipping_days REAL,
    order_count INTEGER,
    total_sales REAL,
    avg_profit REAL,
    PRIMARY KEY (ship_mode, region)
);
