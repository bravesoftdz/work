set ansi_nulls on
set quoted_identifier on
go

if object_id('ManualPrice') is not null
	drop table ManualPrice;
go

create table ManualPrice (
	IDPreInventoryMov int not null,
	ManualPrice money not null,
	constraint PK_ManualPrice primary key (IDPreInventoryMov)
);
alter table ManualPrice with check add constraint FK_ManualPrice_IDPreInventoryMov
    foreign key (IDPreInventoryMov) references PreInventoryMov (IDPreInventoryMov)
    on update cascade on delete cascade;

if object_id('ManualDiscount') is not null
	drop table ManualDiscount;
go

-- Possible add ManualDiscountType so if it was a $ off vs % off can be maintained
create table ManualDiscount (
	IDPreInventoryMov int not null,
	ManualDiscount money not null,
	constraint PK_ManualDiscount primary key (IDPreInventoryMov)
);
alter table ManualDiscount with check add constraint FK_ManualDiscount_IDPreInventoryMov
    foreign key (IDPreInventoryMov) references PreInventoryMov (IDPreInventoryMov)
    on update cascade on delete cascade;
