-- relationship of bedroom vs number_of_reviews (most review: 1 bedroom, studio..., support hypothesis that most rentees are work pass holders)
SELECT bedroom, sum(number_of_reviews) AS total_reviews
FROM dbo.singapore_listings
GROUP BY bedroom
ORDER BY total_reviews DESC

-- relationship of bed vs number_of_reviews (most review: 1 bed, 2 beds..., support hypothesis that most rentees are work pass holders)
SELECT bed, sum(number_of_reviews) AS total_reviews
FROM dbo.singapore_listings
GROUP BY bed
ORDER BY total_reviews DESC

-- relationship of bath vs number_of_reviews (most review: 1 bath..., support hypothesis that most rentees are work pass holders)
SELECT bath, sum(number_of_reviews) AS total_reviews
from dbo.singapore_listings
GROUP BY bath
ORDER BY total_reviews DESC

-- relationship of bedroom, bed, bath vs number_of_reviews (most review: 1 bath..., support hypothesis that most rentees are work pass holders)
SELECT bedroom, bed, bath, sum(number_of_reviews) as total_reviews
FROM dbo.singapore_listings
GROUP BY bedroom, bed, bath
ORDER BY total_reviews DESC

SELECT Num_bedroom, Num_bed, Num_bath, sum(number_of_reviews) as total_reviews
FROM dbo.singapore_listings
GROUP BY Num_bedroom, Num_bed, Num_bath
ORDER BY total_reviews DESC

-- relationship of neighbourhood_group, room_type, ameneties vs average price 
SELECT neighbourhood_group, room_type, bedroom, bed, bath, ROUND(AVG(price),2) as avg_price
FROM dbo.singapore_listings
GROUP BY neighbourhood_group, room_type, bedroom, bed, bath
ORDER BY room_type, avg_price DESC

-- relationship of neighbourhood_group, room_type, ameneties vs average price 
SELECT neighbourhood_group, room_type, Num_bedroom, Num_bed, Num_bath, ROUND(AVG(price),2) as avg_price
FROM dbo.singapore_listings
GROUP BY neighbourhood_group, room_type, Num_bedroom, Num_bed, Num_bath
ORDER BY room_type, avg_price DESC

SELECT name 
FROM dbo.singapore_listings
WHERE bed = '46 beds'
