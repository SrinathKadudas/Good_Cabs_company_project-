    /*  Business Request - 3: City-Level Repeat Passenger Trip Frequency Report
Generate a report that shows the percentage distribution of repeat passengers by the number of trips they have taken in each city. 
Calculate the percentage of repeat passengers who took 2 trips, 3 trips, and so on, up to 10 trips.
Each column should represent a trip count category, displaying the percentage of repeat passengers who fall 
into that category out of the total repeat passengers for that city.
This report will help identify cities with high repeat trip frequency, which can indicate strong customer loyalty or 
frequent usage patterns.*/

    select dc.city_name,
    SUM(CASE WHEN drtd.trip_count = '2-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "2-Trips",
    SUM(CASE WHEN drtd.trip_count = '3-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "3-Trips",
    SUM(CASE WHEN drtd.trip_count = '4-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "4-Trips",
    SUM(CASE WHEN drtd.trip_count = '5-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "5-Trips",
    SUM(CASE WHEN drtd.trip_count = '6-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "6-Trips",
    SUM(CASE WHEN drtd.trip_count = '7-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "7-Trips",
    SUM(CASE WHEN drtd.trip_count = '8-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "8-Trips",
    SUM(CASE WHEN drtd.trip_count = '9-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "9-Trips",
    SUM(CASE WHEN drtd.trip_count = '10-Trips' THEN drtd.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drtd.repeat_passenger_count) AS "10-Trips"
FROM trips_db.dim_repeat_trip_distribution drtd
JOIN trips_db.dim_city dc 
    ON drtd.city_id = dc.city_id
GROUP BY dc.city_name
ORDER BY dc.city_name;