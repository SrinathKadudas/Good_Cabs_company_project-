
/* Business Request - 2: MonthIy City-Level Trips Target Performance Report
Generate a report that evaluates the target performance for trips at the monthly and city level. For each city and month, 
compare the actual total trips with the target trips and categorise the performance as follows:
•	If actual trips are greater than target trips, mark it as "Above Target".
•	If actual trips are less than or equal to target trips, mark it as "Below Target".
Additionally, calculate the % difference between actual and target trips to quantify the performance gap. */

SELECT dc.city_name, 				-- select city_name from dim_city and alias it as dc
dd.month_name,						-- select month_name from dim_date and alias it as dd
    COUNT(ft.trip_id) AS actual_trips,		-- counts the total trips from fact_trips 
    mt.total_target_trips AS target_trips, 	-- takes target_trips column from database targets_db and table monthly_target_trips
    CASE WHEN COUNT(ft.trip_id) > mt.total_target_trips THEN 'Above Target' -- assigns target value
        ELSE 'Below Target'
    END AS performance_status,
    ROUND(((COUNT(ft.trip_id) - mt.total_target_trips) * 100.0 / mt.total_target_trips), 2) AS percentage_difference
FROM trips_db.fact_trips ft 
JOIN trips_db.dim_city dc 					-- joins fact-trips and dim_city with city_id as common column
    ON ft.city_id = dc.city_id
JOIN trips_db.dim_date dd 					-- joins dim_city and dim_date with date date as common column
    ON ft.date = dd.date
JOIN targets_db.monthly_target_trips mt 
    ON ft.city_id = mt.city_id AND dd.start_of_month = mt.month 		-- joins dim_date and monthly_target_trips from targets_db with city_id as common column
WHERE ft.distance_travelled_km > 0  		-- Avoid division by zero
GROUP BY dc.city_name, dd.month_name, mt.total_target_trips
ORDER BY dc.city_name, dd.month_name;