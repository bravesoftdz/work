set xact_abort on;
go
begin tran;
go

if object_id('[dbo].[sp_Tag_Select]') is not null drop procedure [dbo].[sp_Tag_Select];
if object_id('[dbo].[sp_Tag_Upsert]') is not null drop procedure [dbo].[sp_Tag_Upsert];
if object_id('[dbo].[sp_Tag_Delete]') is not null drop procedure [dbo].[sp_Tag_Delete];
if object_id('[dbo].[sp_TagModel_Select]') is not null drop procedure [dbo].[sp_TagModel_Select];
if object_id('[dbo].[sp_TagModel_Upsert]') is not null drop procedure [dbo].[sp_TagModel_Upsert];
if object_id('[dbo].[sp_TagModel_Delete]') is not null drop procedure [dbo].[sp_TagModel_Delete];
if object_id('[dbo].[sp_TagQtyDiscountBreak_Select]') is not null drop procedure [dbo].[sp_TagQtyDiscountBreak_Select];
if object_id('[dbo].[sp_TagQtyDiscountBreak_Upsert]') is not null drop procedure [dbo].[sp_TagQtyDiscountBreak_Upsert];
if object_id('[dbo].[sp_TagQtyDiscountBreak_Delete]') is not null drop procedure [dbo].[sp_TagQtyDiscountBreak_Delete];
if object_id('[dbo].[sp_TagQtyPriceBreak_Select]') is not null drop procedure [dbo].[sp_TagQtyPriceBreak_Select];
if object_id('[dbo].[sp_TagQtyPriceBreak_Upsert]') is not null drop procedure [dbo].[sp_TagQtyPriceBreak_Upsert];
if object_id('[dbo].[sp_TagQtyPriceBreak_Delete]') is not null drop procedure [dbo].[sp_TagQtyPriceBreak_Delete];
go

/*****************************************************************************
 * Stored procedures for the "Tag" table.
 ****************************************************************************/

create proc [dbo].[sp_Tag_Select]
    @IDTag int
as
set nocount on
select
    [IDTag],
    [TagName]
from Tag
where
    [IDTag] = @IDTag
set nocount off
go

create proc [dbo].[sp_Tag_Upsert]
    @IDTag int = null output,
    @TagName varchar(50)
as
merge Tag as Target
using (
    select
    @IDTag,
    @TagName
)
as Source (
    [IDTag],
    [TagName]
)
on (
    Target.IDTag = Source.IDTag
)
when matched then
    update set
        TagName = Source.TagName
when not matched then
    insert (
        [TagName]
    )
    values (
        Source.TagName
    );

SELECT @IDTag=@@IDENTITY;
go

create proc [dbo].[sp_Tag_Delete]
    @IDTag int
as
set nocount on

delete from Tag where
    [IDTag] = @IDTag

set nocount off
go

/*****************************************************************************
 * Stored procedures for the "TagModel" table.
 ****************************************************************************/

create proc [dbo].[sp_TagModel_Select]
    @IdTag int
as
set nocount on
select
    TM.PKTagModel,
    TM.IDTag,
    TM.IDModel,
    M.Model,
    M.Description,
    M.SellingPrice,
    TG.Name as Category,
    MG.ModelGroup as SubCategory,
    MSG.ModelSubGroup as "Group",
    MFG.Pessoa
from TagModel TM
	join Model M on (TM.IDModel = M.IDModel)
	join TabGroup TG on (M.GroupID = TG.IDGroup)
	left join ModelGroup MG on (M.IDModelGroup = MG.IDModelGroup and M.GroupID = MG.IDGroup)
	left join ModelSubGroup MSG on (M.IDModelSubGroup = MSG.IDModelSubGroup and MG.IDModelGroup = MSG.IDModelGroup)
	left join Pessoa MFG on (M.IDFabricante = MFG.IDPessoa)
where
    [IdTag] = @IdTag
set nocount off
go

create proc [dbo].[sp_TagModel_Upsert]
    @PKTagModel int = null output,
    @IDTag int,
    @IDModel int
as
merge TagModel as Target
using (
    select
    @PKTagModel,
    @IDTag,
    @IDModel
)
as Source (
    [PKTagModel],
    [IDTag],
    [IDModel]
)
on (
    Target.PKTagModel = Source.PKTagModel
)
when matched then
    update set
        IDTag = Source.IDTag,
        IDModel = Source.IDModel
when not matched then
    insert (
        [IDTag],
        [IDModel]
    )
    values (
        Source.IDTag,
        Source.IDModel
    );
SELECT @PKTagModel=@@IDENTITY;
go

create proc [dbo].[sp_TagModel_Delete]
    @PKTagModel int
as
set nocount on

delete from TagModel where
    [PKTagModel] = @PKTagModel

set nocount off
go

/*****************************************************************************
 * Stored procedures for the "TagQtyDiscountBreak" table.
 ****************************************************************************/

create proc [dbo].[sp_TagQtyDiscountBreak_Select]
    @IDTag int
as
set nocount on
select
    [IDDiscount],
    [IDTag],
    [MinQuantity]
from TagQtyDiscountBreak
where
    [IDTag] = @IDTag
set nocount off
go

create proc [dbo].[sp_TagQtyDiscountBreak_Upsert]
    @IDDiscount int,
    @IDTag int,
    @MinQuantity int
as
merge TagQtyDiscountBreak as Target
using (
    select
    @IDDiscount,
    @IDTag,
    @MinQuantity
)
as Source (
    [IDDiscount],
    [IDTag],
    [MinQuantity]
)
on (
    Target.IDTag = Source.IDTag
)
when matched then
    update set
        IDDiscount = Source.IDDiscount,
        MinQuantity = Source.MinQuantity
when not matched then
    insert (
        [IDDiscount],
        [IDTag],
        [MinQuantity]
    )
    values (
        Source.IDDiscount,
        Source.IDTag,
        Source.MinQuantity
    );
go

create proc [dbo].[sp_TagQtyDiscountBreak_Delete]
    @IDTag int
as
set nocount on

delete from TagQtyDiscountBreak where
    [IDTag] = @IDTag

set nocount off
go

/*****************************************************************************
 * Stored procedures for the "TagQtyPriceBreak" table.
 ****************************************************************************/

create proc [dbo].[sp_TagQtyPriceBreak_Select]
    @IDTag int
as
set nocount on
select
    [IDTag],
    [MinQuantity],
    [Discount]
from TagQtyPriceBreak
where
    [IDTag] = @IDTag
set nocount off
go

create proc [dbo].[sp_TagQtyPriceBreak_Upsert]
    @IDTag int,
    @MinQuantity int,
    @Discount money
as
merge TagQtyPriceBreak as Target
using (
    select
    @IDTag,
    @MinQuantity,
    @Discount
)
as Source (
    [IDTag],
    [MinQuantity],
    [Discount]
)
on (
    Target.IDTag = Source.IDTag
    and Target.MinQuantity = Source.MinQuantity
)
when matched then
    update set
        Discount = Source.Discount
when not matched then
    insert (
        [IDTag],
        [MinQuantity],
        [Discount]
    )
    values (
        Source.IDTag,
        Source.MinQuantity,
        Source.Discount
    );
go

create proc [dbo].[sp_TagQtyPriceBreak_Delete]
    @IDTag int,
    @MinQuantity int
as
set nocount on

delete from TagQtyPriceBreak where
    [IDTag] = @IDTag
    and [MinQuantity] = @MinQuantity

set nocount off
go

if object_id('sp_TagModelCounts') is not null drop procedure sp_TagModelCounts;
go
create proc sp_TagModelCounts
as
set nocount on
select Tag.IDTag, Tag.TagName,
    (select count(*) from TagModel TM where TM.IDTag = Tag.IDTag) as ModelCount
from Tag
order by Tag.TagName;
set nocount off
go

if object_id('sp_TagsForModel') is not null drop procedure sp_TagsForModel;
go
create proc sp_TagsForModel
    @IDModel int
as
set nocount on

select Tag.*
from Tag
where IDTag in (
    select IDTag
    from TagModel
    where IDModel = @IDModel
)
order by TagName, IDTag;

set nocount off
go

commit tran;
