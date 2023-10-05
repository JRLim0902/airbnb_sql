-- relationship between number_of_reviews and room_type (private room has most reviews)
select room_type, SUM(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by room_type
order by total_reviews desc

-- relationship between number_of_reviews and neighbourhood_group (Central, East, N-E, West, North)
select neighbourhood_group, SUM(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by neighbourhood_group
order by total_reviews desc

--relationship between room_type, neighbourhood_group and number_of_reviews
select room_type, neighbourhood_group, AVG(minimum_nights) as min_nights, ROUND(AVG(price),2) as avg_price, SUM(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by room_type, neighbourhood_group
order by total_reviews desc

-- initial exploration indicates private rooms at central region have the most reviews; with average minimum stay of about 2 months
-- 1st hypothesis: Target customers of most Airbnb in Singapore might be work pass holders instead of tourists; looking for medium to long term stay at private room in the central region (business hub).

-- relationship between prices and reviews for private room (no strong corelation, need visualisation for clearer picture)
select price, sum(number_of_reviews) as total_reviews
from dbo.singapore_listings
where room_type = 'Private room'
group by price
order by total_reviews desc

-- relationship between room_type, neighbourhood_group and price (central region, East, West, N-E, North)
select room_type, neighbourhood_group, ROUND(AVG(price),2) as Avg_price
from dbo.singapore_listings
group by room_type, neighbourhood_group
order by room_type, Avg_price desc

-- Central region Airbnbs are rented at higher price.
-- prices are not the sole reasons for number_of_reviews (no strong corelation), will have to explore further into amenities offered.

/* Observations:
- Private rooms at central regions are more popular
- Rental periods are usually at least 2 months and abv
- Prices for Airbnbs at central region are higher (colerate with demand)
- there is no obvious coleration between price and number of review (aka rental count), lower price might not contribute to more rental of Airbnb
- rental of Airbnb (number of reviews) might be affected by amenities offered. (need a closer look)