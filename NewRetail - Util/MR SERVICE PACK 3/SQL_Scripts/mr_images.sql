use MainRetailDB
select sku from mrcatalogdb..products p
join model m on p.sku = m.model
where p.image is not NULL