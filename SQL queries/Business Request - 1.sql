/* Business Request - 1: City-Level Fare and Trip Summary Report
 Generate a report that displays the total trips, average fare per km, average fare per trip, 
 and the percentage contribution of each city's trips to the overall trips. 
 This report will help in assessing trip volume, pricing efficiency, and each city's contribution to the overall trip count. */
select * from dim_city;
select * from dim_date;
select * from dim_repeat_trip_distribution;
select * from fact_passenger_summary;
select * from fact_trips;
select city_name,														-- select the city_name
count(trip_id) as total_trips, 											-- calculates total_trips for each city
round(avg(fare_amount/distance_travelled_km),2) as average_fare_per_km,	-- calculates avg fare/km and rounds to 2 decimals
round(avg(fare_amount),2) as average_fare_per_trip,						-- calculates avg fare/trip and rounds to 2 decimals
round((count(trip_id)/ (select count(*) from fact_trips))*100,2) as percentage_contribution_of_each_city	-- counts total no.trips for each city/total no.of trips across all cities.
from fact_trips join dim_city on fact_trips.city_id = dim_city.city_id group by city_name order by total_trips desc;  	-- joins fact_trips table with dim_city table