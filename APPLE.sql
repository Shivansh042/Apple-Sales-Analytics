-- DROP TABLE commands (to reset schema if re-run)
   DROP TABLE IF EXISTS warranty;
   DROP TABLE IF EXISTS sales;
   DROP TABLE IF EXISTS products;
   DROP TABLE IF EXISTS category;
   DROP TABLE IF EXISTS stores;

-- CREATE TABLE: stores
CREATE TABLE stores (
    store_id VARCHAR(5) PRIMARY KEY,
    store_name VARCHAR(30),
    city VARCHAR(25),
    country VARCHAR(25)
);

-- CREATE TABLE: category
CREATE TABLE category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(20)
);

-- CREATE TABLE: products
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(35),
    category_id VARCHAR(10),
    launch_date DATE,
    price FLOAT,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- CREATE TABLE: sales
CREATE TABLE sales (
    sale_id VARCHAR(15) PRIMARY KEY,
    sale_date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(20),
    quantity INT,
    CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES stores (store_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- CREATE TABLE: warranty
CREATE TABLE warranty (
    claim_id VARCHAR(10) PRIMARY KEY,
    claim_date DATE,
    sale_id VARCHAR(15),
    repair_status VARCHAR(15),
    CONSTRAINT fk_sale FOREIGN KEY (sale_id) REFERENCES sales (sale_id)
);

-- Success Message
SELECT 'Schema Created Successful' AS Success_Message;


-- Improving Query Performance

create index sales_product_id on sales(product_id);
create index sales_store_id on sales(store_id);
create index sales_sale_date on sales(sale_date);


--Business Problems
/*Find the number of stores in each country.
Calculate the total number of units sold by each store.
Identify how many sales occurred in December 2023.
Determine how many stores have never had a warranty claim filed.
Calculate the percentage of warranty claims marked as "Warranty Void".
Identify which store had the highest total units sold in the last year.
Count the number of unique products sold in the last year.
Find the average price of products in each category.
How many warranty claims were filed in 2020?
For each store, identify the best-selling day based on highest quantity sold.
Medium to Hard (5 Questions)
Identify the least selling product in each country for each year based on total units sold.
Calculate how many warranty claims were filed within 180 days of a product sale.
Determine how many warranty claims were filed for products launched in the last two years.
List the months in the last three years where sales exceeded 5,000 units in the USA.
Identify the product category with the most warranty claims filed in the last two years.
Complex (5 Questions)
Determine the percentage chance of receiving warranty claims after each purchase for each country.
Analyze the year-by-year growth ratio for each store.
Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed.
Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.
Bonus Question
Analyze product sales trends over time, segmented into key periods: from launch to 6 months, 6-12 months, 12-18 months, and beyond 18 months.*/


-- 1. Find the number of stores in each country.

select country, count(store_id) 
from stores
group by 1
order by 2 desc

SELECT COUNT(*) FROM stores;







