-- clean bedroom column
SELECT name, bedroom, bed, bath
FROM dbo.singapore_listings
WHERE bedroom IS NULL 

--populate null Bedroom cells with values from Bed column (bcoz some values in Bed Column rightfully belongs in Bedroom Column)
UPDATE singapore_listings
SET bedroom = bed
WHERE bedroom IS NULL 

UPDATE singapore_listings
SET bedroom = trim(bedroom)

SELECT name, bedroom, bed, bath 
FROM dbo.singapore_listings
WHERE bedroom LIKE '%bed' OR bedroom LIKE '%beds'

-- rectify outliers where Bedroom column should not have values
UPDATE singapore_listings
SET bedroom = NULL
WHERE bedroom LIKE '%bed' OR bedroom LIKE '%beds'

-- check bedroom column data validity
SELECT DISTINCT bedroom
FROM dbo.singapore_listings

-- clean Bed column
SELECT name, bed, bath 
FROM dbo.singapore_listings
WHERE bed IS NULL

SELECT name, bed, bath 
FROM dbo.singapore_listings
WHERE bed NOT LIKE '%bed%'

SELECT name, bed, bath 
FROM dbo.singapore_listings
WHERE bath LIKE '%bed%'

--populate null Bed cells with values from Bath column (bcoz some values in Bath Column rightfully belongs in Bed Column)
UPDATE singapore_listings
SET bed = bath
WHERE bath LIKE '%bed%'

SELECT name, bedroom, bed, bath 
FROM dbo.singapore_listings
WHERE bed LIKE '%bedroom%'

UPDATE singapore_listings
SET bed = trim(bed)

-- check data validity (where there is no values for Bed column, use Bedroom value)
SELECT DISTINCT bed
FROM dbo.singapore_listings

--clean Bath column
SELECT name, bath
FROM dbo.singapore_listings
WHERE bath IS NULL

SELECT name, bath
FROM dbo.singapore_listings
WHERE bath NOT LIKE '%bath%'

UPDATE singapore_listings --all info for Beb column
SET bath = NULL
WHERE bath NOT LIKE '%bath%'

SELECT DISTINCT bath
FROM dbo.singapore_listings

SELECT REPLACE(bath, 'point', '.')
FROM dbo.singapore_listings

UPDATE singapore_listings
SET bath = trim(REPLACE(bath, 'point', '.'))

-- create column Num_bedroom
SELECT DISTINCT bedroom
FROM dbo.singapore_listings

SELECT DISTINCT trim(REPLACE((REPLACE(bedroom, ' bedrooms', '')), ' bedroom', ''))
FROM dbo.singapore_listings

ALTER TABLE singapore_listings
ADD Num_bedroom Nvarchar(255);

UPDATE singapore_listings
SET Num_bedroom = TRIM(REPLACE((REPLACE(bedroom, ' bedrooms', '')), ' bedroom', ''))

SELECT Num_bedroom, bedroom
FROM dbo.singapore_listings

-- create column bed
SELECT DISTINCT bed
FROM dbo.singapore_listings

SELECT DISTINCT trim(REPLACE((REPLACE(bed, ' beds', '')), ' bed', ''))
FROM dbo.singapore_listings

ALTER TABLE singapore_listings
ADD Num_bed Nvarchar(255);

UPDATE singapore_listings
SET Num_bed = trim(REPLACE((REPLACE(bed, ' beds', '')), ' bed', ''))

SELECT Num_bed, bed
FROM dbo.singapore_listings


-- create column Num_bath
SELECT DISTINCT bath
FROM dbo.singapore_listings

SELECT DISTINCT trim(REPLACE((REPLACE(bath, ' baths', '')), ' bath', ''))
FROM dbo.singapore_listings

ALTER TABLE singapore_listings
ADD Num_bath Nvarchar(255);

UPDATE singapore_listings
SET Num_bath = trim(REPLACE((REPLACE(bath, ' baths', '')), ' bath', ''))

SELECT DISTINCT Num_bath
from dbo.singapore_listings

SELECT
CASE
	WHEN Num_bath LIKE 'Private half-bath' THEN '0.5 private'
	WHEN Num_bath LIKE 'Shared half-bath' THEN '0.5 shared'
	WHEN Num_bath LIKE 'Half-bath' THEN '0.5'
	WHEN Num_bath LIKE 'o shared' THEN '0'
	ELSE Num_bath
END AS New_Num_bah
FROM dbo.singapore_listings

UPDATE singapore_listings
SET Num_bath = 
(CASE
	WHEN Num_bath LIKE 'Private half-bath' THEN '0.5 private'
	WHEN Num_bath LIKE 'Shared half-bath' THEN '0.5 shared'
	WHEN Num_bath LIKE 'Half-bath' THEN '0.5'
	WHEN Num_bath LIKE '0 shared' THEN '0'
	ELSE Num_bath
END)

SELECT DISTINCT Num_bath
FROM dbo.singapore_listings
ORDER BY Num_bath 
