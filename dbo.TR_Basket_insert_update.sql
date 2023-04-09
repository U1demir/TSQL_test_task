-- Триггер dbo.TR_Basket_insert_update

create trigger dbo.TR_Basket_insert_update on dbo.Basket
for insert, update as
if exists (select ID_SKU from inserted group by ID_SKU having count(*) >= 2) 
	begin
		update dbo.Basket
		set DiscountValue = dbo.Basket.Value * 0.05 
		from dbo.Basket inner join (select ID_SKU from inserted group by ID_SKU having count(*) >= 2) as i on dbo.Basket.ID_SKU = i.ID_SKU
	end;