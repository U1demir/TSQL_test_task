create function dbo.udf_GetSKUPrice (@ID_SKU as int)
	returns decimal(18, 2)
	begin
		declare @value decimal, @qty decimal
		select @value = sum(Value) from dbo.Basket where ID_SKU = @ID_SKU
		select @qty = sum(Quantity) from dbo.Basket where ID_SKU = @ID_SKU
		return @value / @qty
	end;