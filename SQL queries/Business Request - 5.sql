
/* Business Request - 5: Identify Month with Highest Revenue for Each City
Generate a report that identifies the month with the highest revenue for each city.
 For each city, display the month name, the revenue amount for that month, and the percentage 
 contribution of that month's revenue to the city's total revenue. */
 
WITH CityRevenue AS (
    SELECT 
        dc.city_name,
        dd.month_name,
        SUM(ft.fare_amount) AS total_revenue,
        SUM(SUM(ft.fare_amount)) OVER (PARTITION BY dc.city_name) AS city_total_revenue,
        RANK() OVER (PARTITION BY dc.city_name ORDER BY SUM(ft.fare_amount) DESC) AS revenue_rank
    FROM trips_db.fact_trips ft
    JOIN trips_db.dim_city dc ON ft.city_id = dc.city_id
    JOIN trips_db.dim_date dd ON ft.date = dd.date
    GROUP BY dc.city_name, dd.month_name
)
SELECT 
    city_name,
    month_name,
    total_revenue,
    (total_revenue * 100.0 / city_total_revenue) AS revenue_percentage
FROM CityRevenue
WHERE revenue_rank = 1
ORDER BY city_name;

