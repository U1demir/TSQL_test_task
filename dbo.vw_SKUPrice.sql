/* Представление dbo.vw_SKUPrice, которое возвращает все атрибуты продуктов из таблицы dbo.SKU и 
расчетный атрибут со стоимостью одного продукта (используя функцию dbo.udf_GetSKUPrice) */

create view dbo.vw_SKUPrice as
select *, dbo.udf_GetSKUPrice(ID) as SKU_Price from dbo.SKU;