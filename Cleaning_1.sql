-- Data cleaning: separate amenities from Name 
--Current Name format: name · rating · amenities OR name · amenities
select name from dbo.singapore_listings

-- Separating name into name & features (aka rating & amenities)
SELECT
name,
SUBSTRING(name, 1, CHARINDEX('·', name) -1 ) as NewName
, SUBSTRING(name, CHARINDEX('·', name) + 1 , LEN(name)) as Features
From dbo.singapore_listings

-- Create new Column Features
ALTER TABLE singapore_listings
Add Features Nvarchar(255);

Update singapore_listings
SET Features = SUBSTRING(name, CHARINDEX('·', name) + 1 , LEN(name))

-- separate ratings from features
select
CASE
	WHEN Features LIKE '%!%' THEN SUBSTRING(Features, CHARINDEX('·', Features) + 1 , LEN(Features))
	ELSE Features
END AS NewF
From dbo.singapore_listings

-- Create column Amenities
ALTER TABLE singapore_listings
Add Amenities Nvarchar(255);

Update singapore_listings
SET Amenities = 
(CASE
	WHEN Features LIKE '%!%' THEN SUBSTRING(Features, CHARINDEX('·', Features) + 1 , LEN(Features))
	ELSE Features
END)

--select name, amenities
--from dbo.singapore_listings

select REPLACE(amenities, '.', 'point')
from dbo.singapore_listings

Update singapore_listings
SET Amenities = REPLACE(amenities, '.', 'point')

-- Separate amenities into diff columns
Select
amenities
,PARSENAME(REPLACE(amenities, '·', '.') , 3) as bedroom
,PARSENAME(REPLACE(amenities, '·', '.') , 2) as bed
,PARSENAME(REPLACE(amenities, '·', '.') , 1) as bath
From dbo.singapore_listings

select distinct PARSENAME(REPLACE(amenities, '·', '.') , 3) as bedroom
From dbo.singapore_listings

select distinct PARSENAME(REPLACE(amenities, '·', '.') , 2) as bed
From dbo.singapore_listings
order by bed

select distinct PARSENAME(REPLACE(amenities, '·', '.') , 1) as bath
From dbo.singapore_listings

ALTER TABLE singapore_listings
Add Bedroom Nvarchar(255);

Update singapore_listings
SET bedroom = PARSENAME(REPLACE(amenities, '·', '.') , 3)

ALTER TABLE singapore_listings
Add Bed Nvarchar(255);

Update singapore_listings
SET bed = PARSENAME(REPLACE(amenities, '·', '.') , 2)

ALTER TABLE singapore_listings
Add Bath Nvarchar(255);

Update singapore_listings
SET bath = PARSENAME(REPLACE(amenities, '·', '.') , 1)

select name, bedroom, bed, bath
from dbo.singapore_listings

select name, bedroom
from dbo.singapore_listings
where bedroom not in ('%bedroom%')