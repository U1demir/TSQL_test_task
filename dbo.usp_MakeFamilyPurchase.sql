-- Процедура для обновления данных о бюджете семьи после совершения покупок в таблице dbo.Family

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
begin try
	if @FamilySurName not in (select dbo.Family.Surname from dbo.Family)
		raiserror ('Покупатель c такой фамилией отсутствует в базе данных', 16, 1);
	with cte_FamilyValue as (
		select 
			dbo.Family.ID
			,sum(dbo.Basket.Value) as Value 
		from dbo.Family 
			inner join dbo.Basket on dbo.Family.ID = dbo.Basket.ID_Family
		group by 
			dbo.Family.ID 
		)
	update dbo.Family
		set BudgetValue = F.BudgetValue - cte_FamilyValue.Value
		from dbo.Family as F 
			inner join cte_FamilyValue on F.ID = cte_FamilyValue.ID 
		where Surname = @FamilySurName;
end try
begin catch
	throw	
end catch;