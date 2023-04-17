-- Триггер dbo.TR_Basket_insert_update

create trigger dbo.TR_Basket_insert_update on dbo.Basket
for insert, update as
begin
	with cte_counter as (
	select 
		ID_SKU
		,count(*) as row_count
	from inserted
	group by 
		ID_SKU	
	)
	update dbo.Basket
	set DiscountValue = case 
		when row_count >= 2 then dbo.Basket.Value * 0.05
		when row_count = 1 and dbo.Basket.ID = inserted.ID then 0.00 -- Обработка одиночных SKU
		else dbo.Basket.DiscountValue
	end
	from dbo.Basket 
		inner join cte_counter on dbo.Basket.ID_SKU = cte_counter.ID_SKU
		left join inserted on dbo.Basket.ID = inserted.ID;
end;