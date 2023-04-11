-- Триггер dbo.TR_Basket_insert_update

create trigger dbo.TR_Basket_insert_update on dbo.Basket
for insert, update as
begin
	update dbo.Basket
	set DiscountValue = case 
	when @@ROWCOUNT > 0 then dbo.Basket.Value * 0.05 
	else 0.00	
	end
	from dbo.Basket inner join inserted as i1 on dbo.Basket.ID = i1.ID inner join inserted as i2 on i1.ID_SKU = i2.ID_SKU where i1.ID <> i2.ID
end;