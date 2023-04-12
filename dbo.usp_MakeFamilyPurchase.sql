-- Процедура для обновления данных о бюджете семьи после совершения покупок в таблице dbo.Family

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
begin try	
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
		where Surname = @FamilySurName
/* В случае ввода отсутствующей фамилии результат выдаст 0 строк, таким образом будет вызвана ошибка деления на 0, 
UPDATE не произойдет и процедура перейдет к блоку CATCH */ 		
		declare @x as int
		set @x = 1/@@rowcount
end try
begin catch
	print 'Покупатель c такой фамилией отсутствует в базе данных';
end catch;