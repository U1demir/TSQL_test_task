--Таблица складского учета SKU
create table dbo.SKU (
  ID int identity (1, 1) not null primary key,
  Code as concat('s', ID) unique,
  Name varchar(255) not null
);

--Таблица покупателей
create table dbo.Family (
  ID int identity (1, 1) not null primary key,
  Surname varchar(255) not null,
  BudgetValue decimal not null, 
  constraint CHK_BudgetValue check(BudgetValue >= 0)
);

--Корзина
create table dbo.Basket (
  ID int identity (1, 1) not null primary key,
  ID_SKU int not null,
  ID_Family int not null,
  Quantity int not null,
  Value decimal not null,
  PurchaseDate date not null default getdate(),
  DiscountValue int not null,
  constraint FK_ID_SKU foreign key(ID_SKU)
    references dbo.SKU(ID)
	-- Условия ON опциональны, применил NO ACTION как условие по умолчанию 
	on delete no action
	on update no action,
  constraint FK_ID_Family foreign key(ID_Family)
    references dbo.Family(ID)
	-- тоже самое 
	on delete no action
	on update no action,
  constraint CHK_Quantity check(Quantity >= 0),
  constraint CHK_Value check(Value >= 0)  
);
