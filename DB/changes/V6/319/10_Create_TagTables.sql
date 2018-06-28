set xact_abort on;
go
begin tran;
go

---*********************************
if object_id('TagModel') is not null drop table TagModel;
if object_id('TagQtyPriceBreak') is not null drop table TagQtyPriceBreak;
if object_id('Tag') is not null drop table Tag;
go

--******************************
create table Tag (
    IDTag int identity(1, 1) not null,
    TagName varchar(50) not null,
    constraint PK_Tag primary key (IDTag),
    constraint Unique_Tag_TagName unique (TagName)
)
go

--******************************
create table TagModel (
    PKTagModel int identity(1, 1) not null,
    IDTag int not null,
    IDModel int not null,
    constraint PK_TagModel primary key (PKTagModel)
)
alter table TagModel with check add constraint FK_TagModel_IDModel foreign key (IDModel)
    references Model (IDModel) on update cascade on delete cascade
alter table TagModel with check add constraint FK_TagModel_IDTag foreign key (IDTag)
    references Tag (IDTag) on update cascade on delete cascade    
go

--***************************************
create table TagQtyPriceBreak (
    IDTag int not null,
    MinQuantity int not null,
    Discount money not null default 0,
    constraint PK_TagQtyPriceBreak primary key (IDTag, MinQuantity)
)
alter table TagQtyPriceBreak with check add constraint
    FK_TagQtyPriceBreak_IDTag foreign key (IDTag)
    references Tag (IDTag) on update cascade on delete cascade    
go

commit tran;