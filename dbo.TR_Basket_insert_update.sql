-- Триггер dbo.TR_Basket_insert_update

create trigger dbo.TR_Basket_insert_update on dbo.Basket
for insert, update as
begin
	with cte_set as (
	select 
		ID_SKU
		,count(*) as row_count
	from inserted
	group by 
		ID_SKU
	having count(*) >= 2
	)
	update dbo.Basket
	set DiscountValue = dbo.Basket.Value * 0.05
	from dbo.Basket inner join cte_set on dbo.Basket.ID_SKU = cte_set.ID_SKU;

	-- Обработка одиночных SKU
	with cte_single as (
	select 
		ID_SKU
		,count(*) as row_count
	from inserted
	group by
		ID_SKU
	having count(*) = 1
	)	
	update dbo.Basket
	set DiscountValue = 0.00	
	from dbo.Basket 
		inner join cte_single on dbo.Basket.ID_SKU = cte_single.ID_SKU 
		inner join inserted on dbo.Basket.ID = inserted.ID
end;