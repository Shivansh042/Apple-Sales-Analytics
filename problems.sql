/*Easy to Medium (10 Questions)

1. Find the number of stores in each country.
2. Calculate the total number of units sold by each store.
3. Identify how many sales occurred in December 2023.
4. Determine how many stores have never had a warranty claim filed.
5. Calculate the percentage of warranty claims marked as "Warranty Void".
6. Identify which store had the highest total units sold in the last year
7. Count the number of unique products sold in the last year.
8. Find the average price of products in each category.
9. How many warranty claims were filed in 2020?
10. For each store, identify the best-selling day based on highest quantity sold.

Medium to Hard (5 Questions)
11. Identify the least selling product in each country for each year based on total units sold.
12. Calculate how many warranty claims were filed within 180 days of a product sale.
13. Determine how many warranty claims were filed for products launched in the last three years.
14. List the months in the last three years where sales exceeded 3,000 units in the USA.
15. Identify the product category with the most warranty claims filed in the last three years.

Complex (5 Questions)
16. Determine the percentage chance of receiving warranty claims after each purchase for each country.
17. Analyze the year-by-year growth ratio for each store.
18. Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
19. Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed.
20. Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.

Bonus Question
Analyze product sales trends over time, segmented into key periods: from launch to 6 months, 6-12 months, 12-18 months, and beyond 18 months.*/



-- 1. Find the number of stores in each country.

select country, count(store_id) from stores
group by 1
order by 2 desc;


-- 2. Calculate the total number of units sold by each store.

select s.store_id,st.store_name, sum(s.quantity) as total_units_sold 
from sales as s
join stores as st on st.store_id = s.store_id
group by 1,2
ORDER by 3 desc;


-- 3. Identify how many sales occurred in December 2023.

SELECT COUNT(sale_id) as total_sales FROM sales
WHERE TO_CHAR(sale_date, 'MM-YYYY') = '12-2023';


-- 4. Determine how many stores have never had a warranty claim filed.

select count(*) as total_stores from stores
where store_id not in(
select store_id from sales as s
right join warranty as w 
on s.sale_id = w.sale_id);


-- 5. Calculate the percentage of warranty claims marked as "Warranty Void".

select round(count(claim_id)/(select count(*) from warranty ):: NUMERIC 
* 100,2) as warranty_void_percentage 
from warranty
where repair_status = 'Warranty Void';


-- 6. Identify which store had the highest total units sold in the last year.

select s.store_id, st.store_name, sum(s.quantity) as total_unit_sold from sales as s 
join stores as st on s.store_id = st.store_id
where extract(year from sale_date) = extract(year from current_date) - 1
group by 1,2
order by 2 desc
limit 1


-- 7. Count the number of unique products sold in the last year.

select count(distinct product_id) as unique_product from sales
where extract(year from sale_date) = extract(year from current_date) - 1


-- 8. Find the average price of products in each category.

select p.category_id, category_name, round(avg(p.price)::numeric, 2) 
from products as p
join category as c on p.category_id = c.category_id
group by 1,2


-- 9. How many warranty claims were filed in 2020?

select count(claim_id) as claims_in_2020 from warranty
where extract(year from claim_date) = 2020


-- 10. For each store, identify the best-selling day based on highest quantity sold.

select * from
(select store_id, to_char(sale_date, 'day') as day_name, 
	sum(quantity) as total_unit_sold,
	rank() over(partition by store_id order by sum(quantity) desc) as rank
from sales
group by 1,2) as t1
where rank = 1


-- 11. Identify the least selling product in each country for each year based on total units sold.

select * from 
(
select st.country, p.product_name, sum(s.quantity) as total_qty_sold,
rank() over(partition by st.country order by sum(s.quantity) asc) as rank
from sales as s
join stores as st on s.store_id = st.store_id
join products as p on s.product_id = p.product_id
group by 1,2
order by 1,3
)
where rank = 1


-- 12. Calculate how many warranty claims were filed within 180 days of a product sale.

select count(*) as claims_within_180days from warranty as w
left join sales as s on s.sale_id = w.sale_id
where w.claim_date - s.sale_date <= 180


-- 13. Determine how many warranty claims were filed for products launched in the last three years.

select p.product_name, count(w.claim_id) as warranty_claims from warranty as w 
join sales as s on s.sale_id = w.sale_id
join products as p on p.product_id = s.product_id
where p.launch_date >= current_date - interval '3 year'
group by 1


-- 14. List the months in the last three years where sales exceeded 3,000 units in the USA.

select to_char(s.sale_date, 'mm-yyyy'), sum(s.quantity) as total_units_sold from sales as s
join stores as st on st.store_id = s.store_id
where country = 'USA'
and s.sale_date >= current_date - interval '3 year'
group by 1
having sum(s.quantity) > 3000


-- 15. Identify the product category with the most warranty claims filed in the last three years.

select c.category_id , c.category_name , count(w.claim_id) as warranty_claims from warranty as w
left join sales as s on s.sale_id = w.sale_id
join products as p on p.product_id = s.product_id
join category as c on c.category_id = p.category_id
where w.claim_date >= current_date - interval '3 year'
group by 1
order by 3 desc
limit 1


-- 16. Determine the percentage chance of receiving warranty claims after each purchase for each country.

select st.country, sum(s.quantity) as total_units_sold, count(w.claim_id) as total_claim,
	round(count(w.claim_id)::numeric/sum(s.quantity)::numeric * 100, 2)  as claim_percentage
from sales as s
join stores as st on st.store_id = s.store_id
left join warranty as w on w.sale_id = s.sale_id
group by 1
order by 3 desc


-- 17. Analyze the year-by-year growth ratio for each store.

with yearly_sales as
(
select s.store_id, st.store_name, extract(year from sale_date) as year, sum(s.quantity * p.price) as total_sales from sales as s
join products as p on p.product_id = s.product_id
join  stores as st on st.store_id = s.store_id
group by 1,2,3
order by 2,3
),
yearly_growth as 
(
select store_name, year,
lag(total_sales,1) over(partition by store_name order by year) as last_year_sale,
total_sales as current_year_sale 
from yearly_sales
)
select store_name, year, last_year_sale, current_year_sale,
round((current_year_sale - last_year_sale)::numeric / last_year_sale::numeric * 100 , 3)  as growth_ratio
from yearly_growth
where last_year_sale is not null


-- 18. Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.

select 
case 
	when p.price < 600 then 'Low Range Products'
	when p.price between 600 and 1200 then 'Medium Range Products'
	when p.price between 1200 and 1800 then 'High Range Products'
	else 'Premium Range Products'
end as price_segment , 
count(w.claim_id) as total_warranty_claims from warranty as w 
left join sales as s on s.sale_id = w.sale_id
join products as p on p.product_id = s.product_id
group by 1
order by 2


-- 19. Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed.

with paid_repair as
(
select s.store_id, count(w.claim_id) as total_paid_repaired from warranty as w
left join sales as s on s.sale_id = w.sale_id
where repair_status = 'Paid Repaired'
group by 1
),
total_repair as
(
select s.store_id, st.store_name, count(w.claim_id) as total_repaired from sales as s
join warranty as w on w.sale_id = s.sale_id
join stores as st on st.store_id = s.store_id
group by 1,2
)
select tr.store_id, tr.store_name, pr.total_paid_repaired, tr.total_repaired,
round(pr.total_paid_repaired::numeric / tr.total_repaired::numeric * 100, 2) as paid_repaired_percentage
from total_repair as tr
join paid_repair as pr on tr.store_id = pr.store_id
order by 5 desc


-- 20. Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.

with monthly_sale as
(
select store_id, extract(year from sale_date) as year, extract(month from sale_date) as month, sum(p.price * s.quantity) as total_sales 
from sales as s 
join products as p on p.product_id = s.product_id
group by 1, 2, 3
order by 1, 3
)
select store_id, year, month, total_sales,
sum(total_sales) over(partition by store_id order by year, month) as total_running_sales
from monthly_sale


















