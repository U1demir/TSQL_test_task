-- Функция рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле.

create function dbo.udf_GetSKUPrice (@ID_SKU as int)
	returns decimal(18, 2)
	as
	begin
		declare @result decimal(18, 2)
		select @result = sum(dbo.Basket.Value)/sum(dbo.Basket.Quantity) from dbo.Basket where ID_SKU = @ID_SKU		
		return @result
	end;