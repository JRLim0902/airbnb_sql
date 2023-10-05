-- clean bedroom column
select name, bedroom, bed, bath
from dbo.singapore_listings
where bedroom is null 

--populate null Bedroom cells with values from Bed column (bcoz some values in Bed Column rightfully belongs in Bedroom Column)
Update singapore_listings
SET bedroom = bed
where bedroom is null 

Update singapore_listings
SET bedroom = trim(bedroom)

select name, bedroom, bed, bath 
from dbo.singapore_listings
where bedroom like '%bed' OR bedroom like '%beds'

-- rectify outliers where Bedroom column should not have values
Update singapore_listings
SET bedroom = null
where bedroom like '%bed' OR bedroom like '%beds'

-- check bedroom column data validity
select distinct bedroom
from dbo.singapore_listings

-- clean Bed column
select name, bed, bath 
from dbo.singapore_listings
where bed is null

select name, bed, bath 
from dbo.singapore_listings
where bed not like '%bed%'

select name, bed, bath 
from dbo.singapore_listings
where bath like '%bed%'

--populate null Bed cells with values from Bath column (bcoz some values in Bath Column rightfully belongs in Bed Column)
Update singapore_listings
SET bed = bath
where bath like '%bed%'

select name, bedroom, bed, bath 
from dbo.singapore_listings
where bed like '%bedroom%'

Update singapore_listings
SET bed = trim(bed)

-- check data validity (where there is no values for Bed column, use Bedroom value)
select distinct bed
from dbo.singapore_listings

--clean Bath column
select name, bath
from dbo.singapore_listings
where bath is null

select name, bath
from dbo.singapore_listings
where bath not like '%bath%'

Update singapore_listings --all info for Beb column
SET bath = null
where bath not like '%bath%'

select distinct bath
from dbo.singapore_listings

select REPLACE(bath, 'point', '.')
from dbo.singapore_listings

Update singapore_listings
SET bath = trim(REPLACE(bath, 'point', '.'))

-- create column Num_bedroom
select distinct bedroom
from dbo.singapore_listings

select distinct trim(REPLACE((REPLACE(bedroom, ' bedrooms', '')), ' bedroom', ''))
from dbo.singapore_listings

ALTER TABLE singapore_listings
Add Num_bedroom Nvarchar(255);

Update singapore_listings
SET Num_bedroom = TRIM(REPLACE((REPLACE(bedroom, ' bedrooms', '')), ' bedroom', ''))

select Num_bedroom, bedroom
from dbo.singapore_listings

-- create column bed
select distinct bed
from dbo.singapore_listings

select distinct trim(REPLACE((REPLACE(bed, ' beds', '')), ' bed', ''))
from dbo.singapore_listings

ALTER TABLE singapore_listings
Add Num_bed Nvarchar(255);

Update singapore_listings
SET Num_bed = trim(REPLACE((REPLACE(bed, ' beds', '')), ' bed', ''))

select Num_bed, bed
from dbo.singapore_listings


-- create column Num_bath
select distinct bath
from dbo.singapore_listings

select distinct trim(REPLACE((REPLACE(bath, ' baths', '')), ' bath', ''))
from dbo.singapore_listings

ALTER TABLE singapore_listings
Add Num_bath Nvarchar(255);

Update singapore_listings
SET Num_bath = trim(REPLACE((REPLACE(bath, ' baths', '')), ' bath', ''))

select distinct Num_bath
from dbo.singapore_listings

select
CASE
	WHEN Num_bath LIKE 'Private half-bath' THEN '0.5 private'
	WHEN Num_bath LIKE 'Shared half-bath' THEN '0.5 shared'
	WHEN Num_bath LIKE 'Half-bath' THEN '0.5'
	WHEN Num_bath LIKE 'o shared' THEN '0'
	ELSE Num_bath
END AS New_Num_bah
From dbo.singapore_listings

Update singapore_listings
SET Num_bath = 
(CASE
	WHEN Num_bath LIKE 'Private half-bath' THEN '0.5 private'
	WHEN Num_bath LIKE 'Shared half-bath' THEN '0.5 shared'
	WHEN Num_bath LIKE 'Half-bath' THEN '0.5'
	WHEN Num_bath LIKE '0 shared' THEN '0'
	ELSE Num_bath
END)

select distinct Num_bath
From dbo.singapore_listings
order by Num_bath 