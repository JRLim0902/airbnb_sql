-- relationship of bedroom vs number_of_reviews (most review: 1 bedroom, studio..., support hypothesis that most rentees are work pass holders)
SELECT bedroom, sum(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by bedroom
order by total_reviews desc

-- relationship of bed vs number_of_reviews (most review: 1 bed, 2 beds..., support hypothesis that most rentees are work pass holders)
SELECT bed, sum(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by bed
order by total_reviews desc

-- relationship of bath vs number_of_reviews (most review: 1 bath..., support hypothesis that most rentees are work pass holders)
SELECT bath, sum(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by bath
order by total_reviews desc

-- relationship of bedroom, bed, bath vs number_of_reviews (most review: 1 bath..., support hypothesis that most rentees are work pass holders)
SELECT bedroom, bed, bath, sum(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by bedroom, bed, bath
order by total_reviews desc

SELECT Num_bedroom, Num_bed, Num_bath, sum(number_of_reviews) as total_reviews
from dbo.singapore_listings
group by Num_bedroom, Num_bed, Num_bath
order by total_reviews desc

-- relationship of neighbourhood_group, room_type, ameneties vs average price 
SELECT neighbourhood_group, room_type, bedroom, bed, bath, ROUND(AVG(price),2) as avg_price
from dbo.singapore_listings
group by neighbourhood_group, room_type, bedroom, bed, bath
order by room_type, avg_price desc

-- relationship of neighbourhood_group, room_type, ameneties vs average price 
SELECT neighbourhood_group, room_type, Num_bedroom, Num_bed, Num_bath, ROUND(AVG(price),2) as avg_price
from dbo.singapore_listings
group by neighbourhood_group, room_type, Num_bedroom, Num_bed, Num_bath
order by room_type, avg_price desc

select name 
from dbo.singapore_listings
where bed = '46 beds'