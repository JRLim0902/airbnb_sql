-- Data cleaning: separate amenities from Name 
--Current Name format: name · rating · amenities OR name · amenities
SELECT name FROM dbo.singapore_listings

-- Separating name into name & features (aka rating & amenities)
SELECT
name,
SUBSTRING(name, 1, CHARINDEX('·', name) -1 ) as NewName
, SUBSTRING(name, CHARINDEX('·', name) + 1 , LEN(name)) as Features
FROM dbo.singapore_listings

-- Create new Column Features
ALTER TABLE singapore_listings
ADD Features Nvarchar(255);

UPDATE singapore_listings
SET Features = SUBSTRING(name, CHARINDEX('·', name) + 1 , LEN(name))

-- separate ratings from features
SELECT
CASE
	WHEN Features LIKE '%!%' THEN SUBSTRING(Features, CHARINDEX('·', Features) + 1 , LEN(Features))
	ELSE Features
END AS NewF
FROM dbo.singapore_listings

-- Create column Amenities
ALTER TABLE singapore_listings
ADD Amenities Nvarchar(255);

UPDATE singapore_listings
SET Amenities = 
(CASE
	WHEN Features LIKE '%!%' THEN SUBSTRING(Features, CHARINDEX('·', Features) + 1 , LEN(Features))
	ELSE Features
END)

--select name, amenities
--from dbo.singapore_listings

SELECT REPLACE(amenities, '.', 'point')
FROM dbo.singapore_listings

UPDATE singapore_listings
SET Amenities = REPLACE(amenities, '.', 'point')

-- Separate amenities into diff columns
SELECT
amenities
,PARSENAME(REPLACE(amenities, '·', '.') , 3) AS bedroom
,PARSENAME(REPLACE(amenities, '·', '.') , 2) AS bed
,PARSENAME(REPLACE(amenities, '·', '.') , 1) AS bath
FROM dbo.singapore_listings

SELECT DISTINCT PARSENAME(REPLACE(amenities, '·', '.') , 3) AS bedroom
FROM dbo.singapore_listings

SELECT DISTINCT PARSENAME(REPLACE(amenities, '·', '.') , 2) AS bed
FROM dbo.singapore_listings
ORDER BY bed

SELECT DISTINCT PARSENAME(REPLACE(amenities, '·', '.') , 1) AS bath
FROM dbo.singapore_listings

ALTER TABLE singapore_listings
ADD Bedroom Nvarchar(255);

UPDATE singapore_listings
SET bedroom = PARSENAME(REPLACE(amenities, '·', '.') , 3)

ALTER TABLE singapore_listings
ADD Bed Nvarchar(255);

UPDATE singapore_listings
SET bed = PARSENAME(REPLACE(amenities, '·', '.') , 2)

ALTER TABLE singapore_listings
ADD Bath Nvarchar(255);

UPDATE singapore_listings
SET bath = PARSENAME(REPLACE(amenities, '·', '.') , 1)

SELECT name, bedroom, bed, bath
FROM dbo.singapore_listings

SELECT name, bedroom
FROM dbo.singapore_listings
WHERE bedroom NOT IN ('%bedroom%')
