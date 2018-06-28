-- Create Discount SUD (Select, Upsert, and Delete) procedures

set xact_abort on;
go
begin tran;
go
if object_id('[sp_Discounts_Select]') is not null
    drop procedure [sp_Discounts_Select];
if object_id('[sp_Discounts_Upsert]') is not null
    drop procedure [sp_Discounts_Upsert];
if object_id('[sp_Discounts_Delete]') is not null
    drop procedure [sp_Discounts_Delete];
if object_id('[sp_DiscCoupons_Select]') is not null
    drop procedure [sp_DiscCoupons_Select];
if object_id('[sp_DiscCoupons_Upsert]') is not null
    drop procedure [sp_DiscCoupons_Upsert];
if object_id('[sp_DiscCoupons_Delete]') is not null
    drop procedure [sp_DiscCoupons_Delete];
if object_id('[sp_DiscStores_Select]') is not null
    drop procedure [sp_DiscStores_Select];
if object_id('[sp_DiscStores_Upsert]') is not null
    drop procedure [sp_DiscStores_Upsert];
if object_id('[sp_DiscStores_Delete]') is not null
    drop procedure [sp_DiscStores_Delete];
if object_id('[sp_DiscQualifyingTags_Select]') is not null
    drop procedure [sp_DiscQualifyingTags_Select];
if object_id('[sp_DiscQualifyingTags_Upsert]') is not null
    drop procedure [sp_DiscQualifyingTags_Upsert];
if object_id('[sp_DiscQualifyingTags_Delete]') is not null
    drop procedure [sp_DiscQualifyingTags_Delete];
if object_id('[sp_DiscRewardTags_Select]') is not null
    drop procedure [sp_DiscRewardTags_Select];
if object_id('[sp_DiscRewardTags_Upsert]') is not null
    drop procedure [sp_DiscRewardTags_Upsert];
if object_id('[sp_DiscRewardTags_Delete]') is not null
    drop procedure [sp_DiscRewardTags_Delete];
if object_id('[sp_DiscUses_Select]') is not null
    drop procedure [sp_DiscUses_Select];
if object_id('[sp_DiscUses_Upsert]') is not null
    drop procedure [sp_DiscUses_Upsert];
if object_id('[sp_DiscUses_Delete]') is not null
    drop procedure [sp_DiscUses_Delete];
if object_id('[sp_DiscValidOnDays_Select]') is not null
    drop procedure [sp_DiscValidOnDays_Select];
if object_id('[sp_DiscValidOnDays_Upsert]') is not null
    drop procedure [sp_DiscValidOnDays_Upsert];
if object_id('[sp_DiscValidOnDays_Delete]') is not null
    drop procedure [sp_DiscValidOnDays_Delete];
if object_id('[sp_DiscAllowedCustGroups_Select]') is not null
    drop procedure [sp_DiscAllowedCustGroups_Select];
if object_id('[sp_DiscAllowedCustGroups_Upsert]') is not null
    drop procedure [sp_DiscAllowedCustGroups_Upsert];
if object_id('[sp_DiscAllowedCustGroups_Delete]') is not null
    drop procedure [sp_DiscAllowedCustGroups_Delete];
go

/*****************************************************************************
 * Stored procedures for the "Discounts" table.
 ****************************************************************************/

create proc [sp_Discounts_Select]
    @IDDiscount int
as
set nocount on
select
    [IDDiscount],
    [DiscountName],
    [StartOn],
    [EndOn],
    [BeginTimeOfDay],
    [EndTimeOfDay],
    [DiscType],
    [MinSubtotal],
    [IDStore],
    [MaxUsesPerCustomer],
    [MaxUsesInTotal],
    [FirstTimeCustomerOnly],
    [CustomerCardRequired],
    [IsStackable],
    [RewardAmount],
    [AmountType],
    [RewardQuantity],
    [MinQuantity],
    [MinDollarAmount]
from Discounts
where
    [IDDiscount] = @IDDiscount
set nocount off
go
    
create proc [sp_Discounts_Upsert]
    @IDDiscount int = null output,
    @DiscountName nvarchar(max),
    @StartOn date,
    @EndOn date,
    @BeginTimeOfDay time,
    @EndTimeOfDay time,
    @DiscType nvarchar(max),
    @MinSubtotal money,
    @IDStore int,
    @MaxUsesPerCustomer int,
    @MaxUsesInTotal int,
    @FirstTimeCustomerOnly bit,
    @CustomerCardRequired bit,
    @IsStackable bit,
    @RewardAmount money,
    @AmountType nvarchar(max),
    @RewardQuantity int,
    @MinQuantity int,
    @MinDollarAmount money
as
merge Discounts as Target
using (
    select
    @IDDiscount,
    @DiscountName,
    @StartOn,
    @EndOn,
    @BeginTimeOfDay,
    @EndTimeOfDay,
    @DiscType,
    @MinSubtotal,
    @IDStore,
    @MaxUsesPerCustomer,
    @MaxUsesInTotal,
    @FirstTimeCustomerOnly,
    @CustomerCardRequired,
    @IsStackable,
    @RewardAmount,
    @AmountType,
    @RewardQuantity,
    @MinQuantity,
    @MinDollarAmount
)
as Source (
    [IDDiscount],
    [DiscountName],
    [StartOn],
    [EndOn],
    [BeginTimeOfDay],
    [EndTimeOfDay],
    [DiscType],
    [MinSubtotal],
    [IDStore],
    [MaxUsesPerCustomer],
    [MaxUsesInTotal],
    [FirstTimeCustomerOnly],
    [CustomerCardRequired],
    [IsStackable],
    [RewardAmount],
    [AmountType],
    [RewardQuantity],
    [MinQuantity],
    [MinDollarAmount]
)
on (
    Target.IDDiscount = Source.IDDiscount
)
when matched then
    update set
        DiscountName = Source.DiscountName,
        StartOn = Source.StartOn,
        EndOn = Source.EndOn,
        BeginTimeOfDay = Source.BeginTimeOfDay,
        EndTimeOfDay = Source.EndTimeOfDay,
        DiscType = Source.DiscType,
        MinSubtotal = Source.MinSubtotal,
        IDStore = Source.IDStore,
        MaxUsesPerCustomer = Source.MaxUsesPerCustomer,
        MaxUsesInTotal = Source.MaxUsesInTotal,
        FirstTimeCustomerOnly = Source.FirstTimeCustomerOnly,
        CustomerCardRequired = Source.CustomerCardRequired,
        IsStackable = Source.IsStackable,
        RewardAmount = Source.RewardAmount,
        AmountType = Source.AmountType,
        RewardQuantity = Source.RewardQuantity,
        MinQuantity = Source.MinQuantity,
        MinDollarAmount = Source.MinDollarAmount

when not matched then
    insert (
        [DiscountName],
        [StartOn],
        [EndOn],
        [BeginTimeOfDay],
        [EndTimeOfDay],
        [DiscType],
        [MinSubtotal],
        [IDStore],
        [MaxUsesPerCustomer],
        [MaxUsesInTotal],
        [FirstTimeCustomerOnly],
        [CustomerCardRequired],
        [IsStackable],
        [RewardAmount],
        [AmountType],
        [RewardQuantity],
        [MinQuantity],
        [MinDollarAmount]
    )
    values (
        Source.DiscountName,
        Source.StartOn,
        Source.EndOn,
        Source.BeginTimeOfDay,
        Source.EndTimeOfDay,
        Source.DiscType,
        Source.MinSubtotal,
        Source.IDStore,
        Source.MaxUsesPerCustomer,
        Source.MaxUsesInTotal,
        Source.FirstTimeCustomerOnly,
        Source.CustomerCardRequired,
        Source.IsStackable,
        Source.RewardAmount,
        Source.AmountType,
        Source.RewardQuantity,
        Source.MinQuantity,
        Source.MinDollarAmount
    );
select @IDDiscount = @@Identity;
go
    
create proc [sp_Discounts_Delete]
    @IDDiscount int
as
set nocount on

delete from Discounts where
    [IDDiscount] = @IDDiscount

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscCoupons" table.
 ****************************************************************************/

create proc [sp_DiscCoupons_Select]
    @Code nvarchar(255)
as
set nocount on
select
    [Code],
    [IDDiscount]
from DiscCoupons
where
    [Code] = @Code
set nocount off
go
    
create proc [sp_DiscCoupons_Upsert]
    @Code nvarchar(255),
    @IDDiscount int
as
merge DiscCoupons as Target
using (
    select
    @Code,
    @IDDiscount
)
as Source (
    [Code],
    [IDDiscount]
)
on (
    Target.Code = Source.Code
)
when matched then
    update set
        IDDiscount = Source.IDDiscount

when not matched then
    insert (
        [Code],
        [IDDiscount]
    )
    values (
        Source.Code,
        Source.IDDiscount
    );

go
    
create proc [sp_DiscCoupons_Delete]
    @Code nvarchar(255)
as
set nocount on

delete from DiscCoupons where
    [Code] = @Code

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscStores" table.
 ****************************************************************************/

create proc [sp_DiscStores_Select]
    @IDDiscount int,
    @IDStore int
as
set nocount on
select
    [IDDiscount],
    [IDStore],
    [ISInclude]
from DiscStores
where
    [IDDiscount] = @IDDiscount
    and [IDStore] = @IDStore
set nocount off
go
    
create proc [sp_DiscStores_Upsert]
    @IDDiscount int,
    @IDStore int,
    @ISInclude bit
as
merge DiscStores as Target
using (
    select
    @IDDiscount,
    @IDStore,
    @ISInclude
)
as Source (
    [IDDiscount],
    [IDStore],
    [ISInclude]
)
on (
    Target.IDDiscount = Source.IDDiscount
    and Target.IDStore = Source.IDStore
)
when matched then
    update set
        ISInclude = Source.ISInclude

when not matched then
    insert (
        [IDDiscount],
        [IDStore],
        [ISInclude]
    )
    values (
        Source.IDDiscount,
        Source.IDStore,
        Source.ISInclude
    );

go
    
create proc [sp_DiscStores_Delete]
    @IDDiscount int,
    @IDStore int
as
set nocount on

delete from DiscStores where
    [IDDiscount] = @IDDiscount
    and [IDStore] = @IDStore

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscQualifyingTags" table.
 ****************************************************************************/

create proc [sp_DiscQualifyingTags_Select]
    @IDDiscount int,
    @IDTag int
as
set nocount on
select
    [IDDiscount],
    [IDTag]
from DiscQualifyingTags
where
    [IDDiscount] = @IDDiscount
    and [IDTag] = @IDTag
set nocount off
go
    
create proc [sp_DiscQualifyingTags_Upsert]
    @IDDiscount int,
    @IDTag int
as
merge DiscQualifyingTags as Target
using (
    select
    @IDDiscount,
    @IDTag
)
as Source (
    [IDDiscount],
    [IDTag]
)
on (
    Target.IDDiscount = Source.IDDiscount
    and Target.IDTag = Source.IDTag
)
when not matched then
    insert (
        [IDDiscount],
        [IDTag]
    )
    values (
        Source.IDDiscount,
        Source.IDTag
    );

go
    
create proc [sp_DiscQualifyingTags_Delete]
    @IDDiscount int,
    @IDTag int
as
set nocount on

delete from DiscQualifyingTags where
    [IDDiscount] = @IDDiscount
    and [IDTag] = @IDTag

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscRewardTags" table.
 ****************************************************************************/

create proc [sp_DiscRewardTags_Select]
    @IDDiscount int,
    @IDTag int
as
set nocount on
select
    [IDDiscount],
    [IDTag]
from DiscRewardTags
where
    [IDDiscount] = @IDDiscount
    and [IDTag] = @IDTag
set nocount off
go
    
create proc [sp_DiscRewardTags_Upsert]
    @IDDiscount int,
    @IDTag int
as
merge DiscRewardTags as Target
using (
    select
    @IDDiscount,
    @IDTag
)
as Source (
    [IDDiscount],
    [IDTag]
)
on (
    Target.IDDiscount = Source.IDDiscount
    and Target.IDTag = Source.IDTag
)
when not matched then
    insert (
        [IDDiscount],
        [IDTag]
    )
    values (
        Source.IDDiscount,
        Source.IDTag
    );

go
    
create proc [sp_DiscRewardTags_Delete]
    @IDDiscount int,
    @IDTag int
as
set nocount on

delete from DiscRewardTags where
    [IDDiscount] = @IDDiscount
    and [IDTag] = @IDTag

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscUses" table.
 ****************************************************************************/

create proc [sp_DiscUses_Select]
    @IDDiscount int,
    @IDInventoryMov int
as
set nocount on
select
    [IDDiscount],
    [IDInventoryMov]
from DiscUses
where
    [IDDiscount] = @IDDiscount
    and [IDInventoryMov] = @IDInventoryMov
set nocount off
go
    
create proc [sp_DiscUses_Upsert]
    @IDDiscount int,
    @IDInventoryMov int
as
merge DiscUses as Target
using (
    select
    @IDDiscount,
    @IDInventoryMov
)
as Source (
    [IDDiscount],
    [IDInventoryMov]
)
on (
    Target.IDDiscount = Source.IDDiscount
    and Target.IDInventoryMov = Source.IDInventoryMov
)
when not matched then
    insert (
        [IDDiscount],
        [IDInventoryMov]
    )
    values (
        Source.IDDiscount,
        Source.IDInventoryMov
    );

go
    
create proc [sp_DiscUses_Delete]
    @IDDiscount int,
    @IDInventoryMov int
as
set nocount on

delete from DiscUses where
    [IDDiscount] = @IDDiscount
    and [IDInventoryMov] = @IDInventoryMov

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscValidOnDays" table.
 ****************************************************************************/

create proc [sp_DiscValidOnDays_Select]
    @IDDiscount int,
    @DayOfWeek int
as
set nocount on
select
    [IDDiscount],
    [DayOfWeek]
from DiscValidOnDays
where
    [IDDiscount] = @IDDiscount
    and [DayOfWeek] = @DayOfWeek
set nocount off
go
    
create proc [sp_DiscValidOnDays_Upsert]
    @IDDiscount int,
    @DayOfWeek int
as
merge DiscValidOnDays as Target
using (
    select
    @IDDiscount,
    @DayOfWeek
)
as Source (
    [IDDiscount],
    [DayOfWeek]
)
on (
    Target.IDDiscount = Source.IDDiscount
    and Target.DayOfWeek = Source.DayOfWeek
)
when not matched then
    insert (
        [IDDiscount],
        [DayOfWeek]
    )
    values (
        Source.IDDiscount,
        Source.DayOfWeek
    );

go
    
create proc [sp_DiscValidOnDays_Delete]
    @IDDiscount int,
    @DayOfWeek int
as
set nocount on

delete from DiscValidOnDays where
    [IDDiscount] = @IDDiscount
    and [DayOfWeek] = @DayOfWeek

set nocount off
go
    
/*****************************************************************************
 * Stored procedures for the "DiscAllowedCustGroups" table.
 ****************************************************************************/

create proc [sp_DiscAllowedCustGroups_Select]
    @IDDiscount int,
    @IDTipoPessoa int
as
set nocount on
select
    [IDDiscount],
    [IDTipoPessoa]
from DiscAllowedCustGroups
where
    [IDDiscount] = @IDDiscount
    and [IDTipoPessoa] = @IDTipoPessoa
set nocount off
go
    
create proc [sp_DiscAllowedCustGroups_Upsert]
    @IDDiscount int,
    @IDTipoPessoa int
as
merge DiscAllowedCustGroups as Target
using (
    select
    @IDDiscount,
    @IDTipoPessoa
)
as Source (
    [IDDiscount],
    [IDTipoPessoa]
)
on (
    Target.IDDiscount = Source.IDDiscount
    and Target.IDTipoPessoa = Source.IDTipoPessoa
)
when not matched then
    insert (
        [IDDiscount],
        [IDTipoPessoa]
    )
    values (
        Source.IDDiscount,
        Source.IDTipoPessoa
    );

go
    
create proc [sp_DiscAllowedCustGroups_Delete]
    @IDDiscount int,
    @IDTipoPessoa int
as
set nocount on

delete from DiscAllowedCustGroups where
    [IDDiscount] = @IDDiscount
    and [IDTipoPessoa] = @IDTipoPessoa

set nocount off
go
    
commit tran;
