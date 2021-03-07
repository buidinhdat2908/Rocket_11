SELECT p.name
from ProductSubcategory ps
join Product p on ps.ProductSubcategoryID = p.ProductSubcategoryID
where ps.`name` ='Saddles'
 ;
 
 SELECT p.name
from ProductSubcategory ps
join Product p on ps.ProductSubcategoryID = p.ProductSubcategoryID
where ps.`name` like 'Bo%'
 ;
 
SELECT p.name
from ProductSubcategory ps
join Product p on ps.ProductSubcategoryID = p.ProductSubcategoryID
where ps.`name` = ( select  MIN(ListPrice)
					FROM product
                    WHERE ProductSubcategoryID = 3
                    );
                    
-- phan 2
-- bai 1--
SELECT a.name , b.name as province
FROM countryregion b
JOIN stateprovince a ON b.CountryRegionCode =a.CountryRegionCode
;
-- bai 2
SELECT a.name , b.name as province
FROM countryregion b
JOIN stateprovince a ON b.CountryRegionCode =a.CountryRegionCode
OR b.name = 'Germany'
;
