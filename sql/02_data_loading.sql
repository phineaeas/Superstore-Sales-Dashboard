-- ЗАГРУЗКА ДАННЫХ ИЗ CSV

-- Загрузка основной таблицы фактов
.mode csv
.import ../data/processed/fact_orders.csv fact_orders

-- Проверка загрузки
SELECT COUNT(*) as total_orders FROM fact_orders;

