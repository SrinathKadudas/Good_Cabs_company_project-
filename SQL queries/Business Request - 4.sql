/* Business Request - 4: Identify Cities with Highest and Lowest Total New Passengers
Generate a report that calculates the total new passengers for each city and ranks them based on this value. 
Identify the top 3 cities with the highest number of new passengers as well as the bottom 3 cities with the lowest number 
of new passengers, categorising them as "Top 3" or "Bottom 3" accordingly. */


with cte_passengersum as (
select dc.city_name, 
sum(fps.total_passengers) as sum_of_passengers,
rank() over (order by sum(fps.total_passengers)desc) as rn
from dim_city dc join 
fact_passenger_summary fps on dc.city_id = fps.city_id group by dc.city_name)
select city_name, sum_of_passengers,
case when
rn > (select count(*) - 3 from cte_passengersum) then 'top-3'
when rn <=3 then 'bottom-3'
else 'other'
end as category
from cte_passengersum
