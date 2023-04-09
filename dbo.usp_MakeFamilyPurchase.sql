-- Процедура для обновления данных о бюджете семьи после совершения покупок в таблице dbo.Family

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
-- Для корретной работы процедуры поле Surname в таблице dbo.Family должно быть уникально?

if @FamilySurName in (select Surname from dbo.Family)
	begin
		declare @ID as int, @BasketValue as decimal
		select @ID =  ID from dbo.Family where Surname = @FamilySurName
		select @BasketValue = sum(dbo.Basket.Value) from dbo.Basket where ID_Family = @ID
		update dbo.Family
			set BudgetValue = BudgetValue - @BasketValue
		where Surname = @FamilySurName;
	end
else
	print 'Покупатель c такой фамилией отсутствует в базе данных';
go