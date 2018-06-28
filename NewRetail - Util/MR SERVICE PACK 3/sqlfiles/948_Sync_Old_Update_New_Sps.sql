USE [MainRetailDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_AllActiveCustomerGroups]    Script Date: 05/12/2016 14:23:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AllActiveCustomerGroups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_AllActiveCustomerGroups]
GO

/****** Object:  StoredProcedure [dbo].[sp_AllActiveCustomerGroups]    Script Date: 05/12/2016 14:23:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_AllActiveCustomerGroups] as
    set nocount on;
    select IDTipoPessoa, TipoPessoa
    from TipoPessoa
    where Desativado = 0 and Hidden = 0 and Path like '.001%'
    order by TipoPessoa;
    set nocount off;

GO

/****** Object:  StoredProcedure [dbo].[sp_AllActiveStores]    Script Date: 05/12/2016 14:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_AllActiveStores]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_AllActiveStores]
GO

/****** Object:  StoredProcedure [dbo].[sp_AllActiveStores]    Script Date: 05/12/2016 14:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_AllActiveStores] as
    set nocount on;
    select IDStore, Name
    from Store
    where System = 0 and Desativado = 0
    order by Name;
    set nocount off;

GO


/****** Object:  StoredProcedure [dbo].[sp_DiscAllowedCustGroups_Delete]    Script Date: 05/12/2016 16:30:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscAllowedCustGroups_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscAllowedCustGroups_Delete]
GO

/****** Object:  StoredProcedure [dbo].[sp_DiscAllowedCustGroups_Delete]    Script Date: 05/12/2016 16:30:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscAllowedCustGroups_Delete]
    @IDDiscount int,
    @IDTipoPessoa int
as
set nocount on

delete from DiscAllowedCustGroups where
    [IDDiscount] = @IDDiscount
    and [IDTipoPessoa] = @IDTipoPessoa

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscAllowedCustGroups_Select]    Script Date: 05/12/2016 16:31:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscAllowedCustGroups_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscAllowedCustGroups_Select]
GO

/****** Object:  StoredProcedure [dbo].[sp_DiscAllowedCustGroups_Select]    Script Date: 05/12/2016 16:31:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscAllowedCustGroups" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscAllowedCustGroups_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscAllowedCustGroups_Upsert]    Script Date: 05/12/2016 16:32:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscAllowedCustGroups_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscAllowedCustGroups_Upsert]
GO

/****** Object:  StoredProcedure [dbo].[sp_DiscAllowedCustGroups_Upsert]    Script Date: 05/12/2016 16:32:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscAllowedCustGroups_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscCoupons_Delete]    Script Date: 05/12/2016 16:33:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscCoupons_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscCoupons_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscCoupons_Delete]    Script Date: 05/12/2016 16:33:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscCoupons_Delete]
    @Code nvarchar(255)
as
set nocount on

delete from DiscCoupons where
    [Code] = @Code

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscCoupons_Select]    Script Date: 05/12/2016 16:35:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscCoupons_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscCoupons_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscCoupons_Select]    Script Date: 05/12/2016 16:35:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscCoupons" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscCoupons_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscCoupons_Upsert]    Script Date: 05/12/2016 16:37:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscCoupons_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscCoupons_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscCoupons_Upsert]    Script Date: 05/12/2016 16:37:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscCoupons_Upsert]
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

GO


/****** Object:  StoredProcedure [dbo].[sp_Discounts_Delete]    Script Date: 04/26/2016 18:21:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/****** Object:  StoredProcedure [dbo].[sp_Discounts_Delete]    Script Date: 05/12/2016 16:38:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Discounts_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Discounts_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_Discounts_Delete]    Script Date: 05/12/2016 16:38:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_Discounts_Delete]
    @IDDiscount int
as
set nocount on

delete from Discounts where
    [IDDiscount] = @IDDiscount

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_Discounts_Select]    Script Date: 04/26/2016 18:23:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*****************************************************************************
 * Stored procedures for the "Discounts" table.
 ****************************************************************************/

/****** Object:  StoredProcedure [dbo].[sp_Discounts_Select]    Script Date: 05/12/2016 16:39:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Discounts_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Discounts_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_Discounts_Select]    Script Date: 05/12/2016 16:39:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*****************************************************************************
 * Stored procedures for the "Discounts" table.
 ****************************************************************************/

create proc [dbo].[sp_Discounts_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_Discounts_Upsert]    Script Date: 05/12/2016 16:46:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Discounts_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Discounts_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_Discounts_Upsert]    Script Date: 05/12/2016 16:46:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_Discounts_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscQualifyingTags_Delete]    Script Date: 05/12/2016 16:48:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscQualifyingTags_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscQualifyingTags_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscQualifyingTags_Delete]    Script Date: 05/12/2016 16:48:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscQualifyingTags_Delete]
    @IDDiscount int,
    @IDTag int
as
set nocount on

delete from DiscQualifyingTags where
    [IDDiscount] = @IDDiscount
    and [IDTag] = @IDTag

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscQualifyingTags_Select]    Script Date: 05/12/2016 16:49:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscQualifyingTags_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscQualifyingTags_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscQualifyingTags_Select]    Script Date: 05/12/2016 16:49:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscQualifyingTags" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscQualifyingTags_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscQualifyingTags_Upsert]    Script Date: 05/12/2016 16:50:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscQualifyingTags_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscQualifyingTags_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscQualifyingTags_Upsert]    Script Date: 05/12/2016 16:50:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscQualifyingTags_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscRewardTags_Delete]    Script Date: 05/19/2016 03:05:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscRewardTags_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscRewardTags_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscRewardTags_Delete]    Script Date: 05/19/2016 03:05:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscRewardTags_Delete]
    @IDDiscount int,
    @IDTag int
as
set nocount on

delete from DiscRewardTags where
    [IDDiscount] = @IDDiscount
    and [IDTag] = @IDTag

set nocount off

GO


/****** Object:  StoredProcedure [dbo].[sp_DiscRewardTags_Select]    Script Date: 05/12/2016 16:52:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscRewardTags_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscRewardTags_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscRewardTags_Select]    Script Date: 05/12/2016 16:52:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscRewardTags" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscRewardTags_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscRewardTags_Upsert]    Script Date: 05/12/2016 16:55:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscRewardTags_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscRewardTags_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscRewardTags_Upsert]    Script Date: 05/12/2016 16:55:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscRewardTags_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscStores_Delete]    Script Date: 05/12/2016 16:56:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscStores_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscStores_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscStores_Delete]    Script Date: 05/12/2016 16:56:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscStores_Delete]
    @IDDiscount int,
    @IDStore int
as
set nocount on

delete from DiscStores where
    [IDDiscount] = @IDDiscount
    and [IDStore] = @IDStore

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscStores_Select]    Script Date: 05/12/2016 16:57:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscStores_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscStores_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscStores_Select]    Script Date: 05/12/2016 16:57:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscStores" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscStores_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscStores_Upsert]    Script Date: 05/12/2016 16:59:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscStores_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscStores_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscStores_Upsert]    Script Date: 05/12/2016 16:59:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscStores_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscUses_Delete]    Script Date: 05/12/2016 17:27:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscUses_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscUses_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscUses_Delete]    Script Date: 05/12/2016 17:27:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscUses_Delete]
    @IDDiscount int,
    @IDInventoryMov int
as
set nocount on

delete from DiscUses where
    [IDDiscount] = @IDDiscount
    and [IDInventoryMov] = @IDInventoryMov

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscUses_Select]    Script Date: 05/12/2016 17:27:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscUses_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscUses_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscUses_Select]    Script Date: 05/12/2016 17:27:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscUses" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscUses_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscUses_Upsert]    Script Date: 05/12/2016 17:28:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscUses_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscUses_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscUses_Upsert]    Script Date: 05/12/2016 17:28:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscUses_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscValidOnDays_Delete]    Script Date: 05/12/2016 17:29:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscValidOnDays_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscValidOnDays_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscValidOnDays_Delete]    Script Date: 05/12/2016 17:29:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscValidOnDays_Delete]
    @IDDiscount int,
    @DayOfWeek int
as
set nocount on

delete from DiscValidOnDays where
    [IDDiscount] = @IDDiscount
    and [DayOfWeek] = @DayOfWeek

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscValidOnDays_Select]    Script Date: 05/12/2016 17:30:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscValidOnDays_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscValidOnDays_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscValidOnDays_Select]    Script Date: 05/12/2016 17:30:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
/*****************************************************************************
 * Stored procedures for the "DiscValidOnDays" table.
 ****************************************************************************/

create proc [dbo].[sp_DiscValidOnDays_Select]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_DiscValidOnDays_Upsert]    Script Date: 05/12/2016 17:30:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DiscValidOnDays_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_DiscValidOnDays_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_DiscValidOnDays_Upsert]    Script Date: 05/12/2016 17:30:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_DiscValidOnDays_Upsert]
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

GO

/****** Object:  StoredProcedure [dbo].[sp_PIMAppliedCoupons_Delete]    Script Date: 05/12/2016 18:00:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PIMAppliedCoupons_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PIMAppliedCoupons_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_PIMAppliedCoupons_Delete]    Script Date: 05/12/2016 18:00:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_PIMAppliedCoupons_Delete]
    @PreInventoryMovID int,
    @CouponCode nvarchar(255)
as
set nocount on

delete from PIMAppliedCoupons where
    [PreInventoryMovID] = @PreInventoryMovID
    and [CouponCode] = @CouponCode

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_PIMAppliedCoupons_Select]    Script Date: 05/12/2016 18:01:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PIMAppliedCoupons_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PIMAppliedCoupons_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_PIMAppliedCoupons_Select]    Script Date: 05/12/2016 18:01:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*****************************************************************************
 * Stored procedures for the "PIMAppliedCoupons" table.
 ****************************************************************************/

create proc [dbo].[sp_PIMAppliedCoupons_Select]
    @PreInventoryMovID int,
    @CouponCode nvarchar(255)
as
set nocount on
select
    [PreInventoryMovID],
    [CouponCode]
from PIMAppliedCoupons
where
    [PreInventoryMovID] = @PreInventoryMovID
    and [CouponCode] = @CouponCode
set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_PIMAppliedCoupons_Upsert]    Script Date: 05/12/2016 18:02:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PIMAppliedCoupons_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PIMAppliedCoupons_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_PIMAppliedCoupons_Upsert]    Script Date: 05/12/2016 18:02:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
create proc [dbo].[sp_PIMAppliedCoupons_Upsert]
    @PreInventoryMovID int,
    @CouponCode nvarchar(255)
as
merge PIMAppliedCoupons as Target
using (
    select
    @PreInventoryMovID,
    @CouponCode
)
as Source (
    [PreInventoryMovID],
    [CouponCode]
)
on (
    Target.PreInventoryMovID = Source.PreInventoryMovID
    and Target.CouponCode = Source.CouponCode
)
when not matched then
    insert (
        [PreInventoryMovID],
        [CouponCode]
    )
    values (
        Source.PreInventoryMovID,
        Source.CouponCode
    );

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_CalcPrice]    Script Date: 05/19/2016 03:07:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_CalcPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_CalcPrice]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_CalcPrice]    Script Date: 05/19/2016 03:07:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_PreSale_CalcPrice]
    @IDModel int,
    @StoreID int,
    @Qty int,
    @IDPreInventoryMov int,
    @SpecialPriceID int = null,
    @ManualPrice money = null
as
begin
    set nocount on;

    if (@ManualPrice is not null)
    begin
        merge ManualPrice as target
        using (select @IDPreInventoryMov, @ManualPrice)
            as source (id_preinventorymov,  manual_price)
        on (target.IDPreInventoryMov = source.id_preinventorymov
            and target.IDPreInventoryMov = source.id_preinventorymov)
        when matched then
            update set ManualPrice = source.manual_price
        when not matched then
            insert (IDPreInventoryMov, ManualPrice)
            values (
                source.id_preinventorymov,
                source.manual_price
            );
    end;

    select dbo.fn_CalcPrice(@IDPreInventoryMov, @SpecialPriceID);

END

GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_CalcSalePrice]    Script Date: 05/12/2016 18:04:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_CalcSalePrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_CalcSalePrice]
GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_CalcSalePrice]    Script Date: 05/12/2016 18:04:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PreSale_CalcSalePrice]

		(
		@ModelID		int,
		@IDStore		int,
		@IDCustomer		int,
		@SpecialPriceID		int,
		@SalePrice		money Output,
		@CostPrice		money Output,
		@Discount		money Output,
		@AvgCostPrice		money Output,
		@ReplacementCost	money Output,
		@StoreSalePrice		money Output,
		@RequestCustomer	bit Output,
		@PuppyTracker		bit Output,
		@StoreCostPrice		money OutPut,
		@StoreAvgCost		money OutPut,
		@AddKitItems		bit OutPut,
		@PromotionPrice		money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo do valor no modelo e seu custo
		- Calculo o valor do grupo e do modelo
		- Calculo o desconto pelo tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select
		-203  Erro ao Executar sp_PreSale_CalcCustomerDiscount

	LOG DE MODIFICAES

	Data			Programador		Modificao
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	16 Mar	2005		RodrigoCosta 		Inclusao do campo ReplacementCost
	28 Jul	2005		Rodrigo Costa		Inclusao do campo StoreSellingPrice
	30 Oct	2005		Rodrigo	Costa		Inclusao dos campos StoreCost and Store Avg
	21 Feb	2006		Maximiliano Muniz	Chamada da sp_PreSale_CalcCustomerDiscount
	16 Abr  2008		Ike Javarine		Inclusao de novo parametro para Preco Promocional
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @Model	money
DECLARE @ModelSP 	money
DECLARE @GroupSP 	money
 

SET @Model = Null
SET @ModelSP = Null
SET @GroupSP = Null
SET @ErrorLevel = 0


---------------------------------------------------------------------------------------------------
-- Calculo do valor no modelo e seu custo

SELECT
	@CostPrice = (IsNull(M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost, 0)),
	@Model = CASE WHEN IsNull(I.SellingPrice, 0) = 0 THEN IsNull(M.SellingPrice, 0) ELSE I.SellingPrice END,
	@AvgCostPrice = IsNull(M.AvgCost,0),
	@ReplacementCost = IsNull(ReplacementCost,0),
	@StoreSalePrice = IsNull(I.SellingPrice,0),
	@StoreCostPrice = IsNull(I.StoreCostPrice,0),
	@StoreAvgCost = IsNull(I.StoreAvgPrice,0),
	@AddKitItems = IsNull(TG.PackModelAddItems,0),
	@PromotionPrice = IsNull(M.PromotionPrice,0)
FROM
	Model M (NOLOCK) 
	JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	LEFT OUTER JOIN Inventory I (NOLOCK) ON (I.ModelID = M.IDModel AND I.StoreID = @IDStore)
WHERE
	M.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

---------------------------------------------------------------------------------------------------
-- Calculo o valor do grupo e do modelo

IF IsNull(@SpecialPriceID,0) > 0
BEGIN
	SELECT
		@GroupSP = (1+(SP.SpecialMarkUp/100) ) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO (NOLOCK) 
		JOIN SpecialPriceByGroup SP (NOLOCK)  ON (MO.GroupID = SP.GroupID)
	WHERE
		MO.IDModel = @ModelID
		AND
		SP.SpecialPriceID = @SpecialPriceID


	SELECT
		@ModelSP = (1+(MTSP.MarkUp/100)) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO (NOLOCK) 
		JOIN ModelToSpecialPrice MTSP (NOLOCK) ON (MO.IDModel = MTSP.IDModel)
	WHERE
		MO.IDModel = @ModelID
		AND
		MTSP.IDSpecialPrice = @SpecialPriceID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

END

SET @SalePrice = IsNull(@ModelSP, IsNull(@GroupSP, @Model))

---------------------------------------------------------------------------------------------------
-- Calculo o desconto pelo tipo de Cliente

EXEC sp_PreSale_CalcCustomerDiscount @IDCustomer, @ModelID, 1, @SalePrice, @Discount OUTPUT


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CalcSalePrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_Coupon_Delete]    Script Date: 05/12/2016 18:06:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_Coupon_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_Coupon_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_Coupon_Delete]    Script Date: 05/12/2016 18:06:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_PreSale_Coupon_Delete]
    @DocumentID int,
    @CouponCode nvarchar(255)
as
set nocount on

delete from Sal_Coupon where
    [DocumentID] = @DocumentID
    and [CouponCode] = @CouponCode

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_Coupon_Select]    Script Date: 05/12/2016 18:07:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_Coupon_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_Coupon_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_Coupon_Select]    Script Date: 05/12/2016 18:07:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*****************************************************************************
 * Stored procedures for the "Sal_Coupon" table.
 ****************************************************************************/

create proc [dbo].[sp_PreSale_Coupon_Select]
    @DocumentID int,
    @CouponCode nvarchar(255)
as
set nocount on
select
    [DocumentID],
    [CouponCode]
from Sal_Coupon
where
    [DocumentID] = @DocumentID
    and [CouponCode] = @CouponCode
set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_Coupon_Upsert]    Script Date: 05/12/2016 18:08:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_Coupon_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_Coupon_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_Coupon_Upsert]    Script Date: 05/12/2016 18:08:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_PreSale_Coupon_Upsert]
    @DocumentID int,
    @CouponCode nvarchar(255)
as
merge Sal_Coupon as Target
using (
    select
    @DocumentID,
    @CouponCode
)
as Source (
    [DocumentID],
    [CouponCode]
)
on (
    Target.DocumentID = Source.DocumentID
    and Target.CouponCode = Source.CouponCode
)
when not matched then
    insert (
        [DocumentID],
        [CouponCode]
    )
    values (
        Source.DocumentID,
        Source.CouponCode
    );

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_DelManualDiscount]    Script Date: 05/12/2016 18:09:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_DelManualDiscount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_DelManualDiscount]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_DelManualDiscount]    Script Date: 05/12/2016 18:09:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_PreSale_DelManualDiscount] (
    @IDPreInventoryMov int
)
as

/* --------------------------------------------------------------------------
SUMMARY
    - Checks to see confirm this is a presale and not invoiced yet
    - If this a presale, delete the manualdiscount value
    
TABLE OF ERRORS WITH RETURN_VALUE
     000  Ok
    -201  Could Not delete the manualprice

MODIFICATION LOG
    Date           Programmer         Modification
    -----------    ---------------    ---------------------------------------
    27 Mar 2014    Daniel Browning    First created. See git log.

    -------------------------------------------------------------------------*/

begin
 set nocount on;

DECLARE @FoundIDPreInventoryMov int
DECLARE @ErrorLevel        int
DECLARE @SysError        int

SET @ErrorLevel = 0


SELECT @FoundIDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
 FROM dbo.PreInventoryMov 
WHERE IDPreInventoryMov = @IDPreInventoryMov

IF (@FoundIDPreInventoryMov IS NOT NULL)
BEGIN
 BEGIN TRANSACTION
     DELETE FROM [dbo].[ManualDiscount] WHERE idpreinventorymov = @FoundIDPreInventoryMov;
OK:
    COMMIT TRAN
    RETURN 0
END
ELSE
BEGIN
    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -201
        GOTO ERRO 
    END
END
ERRO:
    PRINT CAST(@ErrorLevel AS VARCHAR)
    DECLARE @ErrorLevelStr varchar(510)
    DECLARE @Params varchar(500)    
    SET @Params = ' [ (IDPreInventoryMov) = ' + CAST(@FoundIDPreInventoryMov AS VARCHAR) + ') ]'
    SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelManualDiscount', @ErrorLevelStr
    RETURN @ErrorLevel
END

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_DelManualPrice]    Script Date: 05/12/2016 18:10:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_DelManualPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_DelManualPrice]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_DelManualPrice]    Script Date: 05/12/2016 18:10:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_PreSale_DelManualPrice]
( @IDPreInventoryMov int
)
as

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMMARY

		- Checks to see confirm this is a presale and not invoiced yet
		- If this a presale, delete from sal_manualprice
		
	TABLE OF ERRORS WITH RETURN_VALUE
		 000  Ok
		-201  Could Not Delete From [dbo].[ManualPrice]

	MODIFICATION LOG

	Data			Programmer		Modification
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	2014-03-09      John Rogers		Created;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

begin
 set nocount on;

--DECLARE @IDPreInventoryMov int
--SET @IDPreInventoryMov = 30769 

DECLARE @FoundIDPreInventoryMov int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0


SELECT @FoundIDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
 FROM dbo.PreInventoryMov 
WHERE IDPreInventoryMov = @IDPreInventoryMov

IF (@FoundIDPreInventoryMov IS NOT NULL)
BEGIN
 BEGIN TRANSACTION
	 DELETE FROM [dbo].[ManualPrice] WHERE idpreinventorymov = @FoundIDPreInventoryMov;
OK:
	COMMIT TRAN
	RETURN 0
END
ELSE
BEGIN
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO 
	END
END
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)

	DECLARE @Params varchar(500)	

	SET @Params = ' [ (IDPreInventoryMov) = ' + CAST(@FoundIDPreInventoryMov AS VARCHAR) + ') ]'

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelManualPrice', @ErrorLevelStr

	RETURN @ErrorLevel

END

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_SetDiscount]    Script Date: 05/12/2016 18:11:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PreSale_SetDiscount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_PreSale_SetDiscount]
GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_SetDiscount]    Script Date: 05/12/2016 18:11:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc [dbo].[sp_PreSale_SetDiscount]
    @DocumentID int
    with execute as caller
as
    set nocount on
    --print 'sp_PreSale_SetDiscount called for DocumentID: '
    --    + cast(@DocumentID as varchar);

    declare @IDPreInventoryMov int;
    declare @UnitDiscount money;
    --declare @Discount money;
    --declare @InvoiceItemDiscount money;
    declare @discounts cursor;
    -- The fast_forward is a performance optimization since we only need to
    -- read through once and do read only operations.
    set @discounts = cursor fast_forward for
        select IDPreInventoryMov, UnitDiscount
        from vw_SelectFinalDiscounts
        where DocumentID = @DocumentID;
    open @discounts
    fetch next from @discounts into @IDPreInventoryMov, @UnitDiscount;

    while @@fetch_status = 0
    begin
        update PreInventoryMov
        set UnitDiscount = @UnitDiscount
        where IDPreInventoryMov = @IDPreInventoryMov
            -- Avoid duplicate I/O when the new discount is the same as the old.
            -- The coalesce() causes the result to be the same even with nulls.
            --and coalesce(UnitDiscount, 0) <> coalesce(@UnitDiscount, 0);

        fetch next from @discounts into @IDPreInventoryMov, @UnitDiscount;
    end
    close @discounts;
    deallocate @discounts;

    with DiscountUpdates as (
        select PIM.IDPreInventoryMov, PIM.UnitDiscount, PIM.Discount,
            MD.ManualDiscount, MD.ManualDiscount * PIM.Qty as ManualDiscountExt
        from ManualDiscount MD
        join PreInventoryMov PIM
            on (PIM.IDPreInventoryMov = MD.IDPreInventoryMov)
        where PIM.DocumentID = @DocumentID
    )
    update DiscountUpdates
    set UnitDiscount = ManualDiscount, Discount = ManualDiscountExt;

    update PreInventoryMov
    set Discount = UnitDiscount * Qty
    where DocumentID = @DocumentID;

    update Invoice
    set ItemDiscount = (
        select sum(Discount) as ItemDiscount
        from PreInventoryMov
        where DocumentID = @DocumentID
    )
    where IDPreSale = @DocumentID;



    return 0;

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CashRegLogReason]    Script Date: 05/12/2016 18:13:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_CashRegLogReason]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_CashRegLogReason]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CashRegLogReason]    Script Date: 05/12/2016 18:13:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_CashRegLogReason]
(
	@IDCashRegLogReason int,@Reason varchar(30),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CashRegLogReason
      (IDCashRegLogReason,Reason,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDCashRegLogReason,@Reason,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CashRegLogReason SET
    			-- No key fields
    			Reason = @Reason,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCashRegLogReason = @IDCashRegLogReason
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CashRegMovPaymentLog]    Script Date: 05/12/2016 18:14:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_CashRegMovPaymentLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_CashRegMovPaymentLog]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CashRegMovPaymentLog]    Script Date: 05/12/2016 18:14:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_CashRegMovPaymentLog]
(
	@IDPaymentLog int,@IDCashRegMov int,@IDMeioPag int,@IDBanco int,@SaleCode varchar(20),@PreSaleDate datetime,@InvoiceTotal money,@CheckNumber varchar(20),@CustomerDocument varchar(20),@CustomerName varchar(80),@CustomerPhone varchar(20),@ValorNominal money,@DataVencimento datetime,@NumDesdobramento varchar(20),@IDPreSale int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CashRegMovPaymentLog
      (IDPaymentLog,IDCashRegMov,IDMeioPag,IDBanco,SaleCode,PreSaleDate,InvoiceTotal,CheckNumber,CustomerDocument,CustomerName,CustomerPhone,ValorNominal,DataVencimento,NumDesdobramento,IDPreSale,ReplLastChange)
      VALUES
      (@IDPaymentLog,@IDCashRegMov,@IDMeioPag,@IDBanco,@SaleCode,@PreSaleDate,@InvoiceTotal,@CheckNumber,@CustomerDocument,@CustomerName,@CustomerPhone,@ValorNominal,@DataVencimento,@NumDesdobramento,@IDPreSale,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CashRegMovPaymentLog SET
    			-- No key fields
    			IDCashRegMov = @IDCashRegMov,
IDMeioPag = @IDMeioPag,
IDBanco = @IDBanco,
SaleCode = @SaleCode,
PreSaleDate = @PreSaleDate,
InvoiceTotal = @InvoiceTotal,
CheckNumber = @CheckNumber,
CustomerDocument = @CustomerDocument,
CustomerName = @CustomerName,
CustomerPhone = @CustomerPhone,
ValorNominal = @ValorNominal,
DataVencimento = @DataVencimento,
NumDesdobramento = @NumDesdobramento,
IDPreSale = @IDPreSale,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPaymentLog = @IDPaymentLog
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ComisPaga]    Script Date: 05/12/2016 18:16:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_ComisPaga]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_ComisPaga]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ComisPaga]    Script Date: 05/12/2016 18:16:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_ComisPaga]
(
	@IDDocumento int,@IDPessoa int,@IDLancPag int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	ComisPaga
      (IDDocumento,IDPessoa,IDLancPag,ReplLastChange)
      VALUES
      (@IDDocumento,@IDPessoa,@IDLancPag,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE ComisPaga SET
    			-- No key fields
    			IDLancPag = @IDLancPag,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDocumento = @IDDocumento AND
IDPessoa = @IDPessoa
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Cotacao]    Script Date: 05/12/2016 18:17:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Cotacao]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Cotacao]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Cotacao]    Script Date: 05/12/2016 18:17:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Cotacao]
(
	@IDCotacao int,@Cotacao varchar(50),@IDStore int,@UltimaEmissao smalldatetime,@Desativado int,@Hidden bit,@DataCotacao smalldatetime,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Cotacao
      (IDCotacao,Cotacao,IDStore,UltimaEmissao,Desativado,Hidden,DataCotacao,ReplLastChange)
      VALUES
      (@IDCotacao,@Cotacao,@IDStore,@UltimaEmissao,@Desativado,@Hidden,@DataCotacao,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Cotacao SET
    			-- No key fields
    			Cotacao = @Cotacao,
IDStore = @IDStore,
UltimaEmissao = @UltimaEmissao,
Desativado = @Desativado,
Hidden = @Hidden,
DataCotacao = @DataCotacao,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCotacao = @IDCotacao
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CotacaoResult]    Script Date: 05/12/2016 18:17:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_CotacaoResult]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_CotacaoResult]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CotacaoResult]    Script Date: 05/12/2016 18:17:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_CotacaoResult]
(
	@IDModel int,@IDFornecedor int,@IDCotacao int,@Cost money,@PO bit,@Qty decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CotacaoResult
      (IDModel,IDFornecedor,IDCotacao,Cost,PO,Qty,ReplLastChange)
      VALUES
      (@IDModel,@IDFornecedor,@IDCotacao,@Cost,@PO,@Qty,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CotacaoResult SET
    			-- No key fields
    			Cost = @Cost,
PO = @PO,
Qty = @Qty,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModel = @IDModel AND
IDFornecedor = @IDFornecedor AND
IDCotacao = @IDCotacao
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CotacaoToFornec]    Script Date: 05/12/2016 18:18:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_CotacaoToFornec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_CotacaoToFornec]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CotacaoToFornec]    Script Date: 05/12/2016 18:18:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_CotacaoToFornec]
(
	@IDCotacao int,@IDFornecedor int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CotacaoToFornec
      (IDCotacao,IDFornecedor,ReplLastChange)
      VALUES
      (@IDCotacao,@IDFornecedor,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CotacaoToFornec SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCotacao = @IDCotacao AND
IDFornecedor = @IDFornecedor
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CotacaoToModel]    Script Date: 05/12/2016 18:24:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_CotacaoToModel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_CotacaoToModel]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CotacaoToModel]    Script Date: 05/12/2016 18:24:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_CotacaoToModel]
(
	@IDCotacao int,@IDModel int,@IDRequest int,@QtyCotada decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CotacaoToModel
      (IDCotacao,IDModel,IDRequest,QtyCotada,ReplLastChange)
      VALUES
      (@IDCotacao,@IDModel,@IDRequest,@QtyCotada,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CotacaoToModel SET
    			-- No key fields
    			IDRequest = @IDRequest,
QtyCotada = @QtyCotada,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCotacao = @IDCotacao AND
IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CustomerCredit]    Script Date: 05/12/2016 18:27:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_CustomerCredit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_CustomerCredit]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CustomerCredit]    Script Date: 05/12/2016 18:27:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_CustomerCredit]
(
	@IDCustomerCredit int,@IDPessoa int,@IDUser int,@IDStore int,@CreditDate datetime,@ExpirationDate datetime,@IsUsed bit,@Amount money,@IDLancamento int,@IDPreInventoryMov int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CustomerCredit
      (IDCustomerCredit,IDPessoa,IDUser,IDStore,CreditDate,ExpirationDate,IsUsed,Amount,IDLancamento,IDPreInventoryMov,ReplLastChange)
      VALUES
      (@IDCustomerCredit,@IDPessoa,@IDUser,@IDStore,@CreditDate,@ExpirationDate,@IsUsed,@Amount,@IDLancamento,@IDPreInventoryMov,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CustomerCredit SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
IDUser = @IDUser,
IDStore = @IDStore,
CreditDate = @CreditDate,
ExpirationDate = @ExpirationDate,
IsUsed = @IsUsed,
Amount = @Amount,
IDLancamento = @IDLancamento,
IDPreInventoryMov = @IDPreInventoryMov,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCustomerCredit = @IDCustomerCredit
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_DailyMaintenanceReport]    Script Date: 05/12/2016 18:54:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_DailyMaintenanceReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_DailyMaintenanceReport]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_DailyMaintenanceReport]    Script Date: 05/12/2016 18:54:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_DailyMaintenanceReport]
(
	@IDDailyMaintenanceReport int,@Date datetime,@Maintenance varchar(35),@LastMessage varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	DailyMaintenanceReport
      (IDDailyMaintenanceReport,Date,Maintenance,LastMessage,ReplLastChange)
      VALUES
      (@IDDailyMaintenanceReport,@Date,@Maintenance,@LastMessage,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE DailyMaintenanceReport SET
    			-- No key fields
    			Date = @Date,
Maintenance = @Maintenance,
LastMessage = @LastMessage,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDailyMaintenanceReport = @IDDailyMaintenanceReport
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_DiscRange]    Script Date: 08/31/2016 11:53:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_DiscRange]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_DiscRange]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_DiscRange]    Script Date: 08/31/2016 11:53:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_DiscRange]
(
	@IDTipoComissionado int,@TotVendaMin money,@PercDiscMax money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	DiscRange
      (IDTipoComissionado,TotVendaMin,PercDiscMax,ReplLastChange)
      VALUES
      (@IDTipoComissionado,@TotVendaMin,@PercDiscMax,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE DiscRange SET
    			-- No key fields
    			PercDiscMax = @PercDiscMax,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDTipoComissionado = @IDTipoComissionado AND
TotVendaMin = @TotVendaMin
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Estimated]    Script Date: 05/12/2016 18:55:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Estimated]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Estimated]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Estimated]    Script Date: 05/12/2016 18:55:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Estimated]
(
	@IDEstimated int,@IDPessoa int,@IDUser int,@IDStore int,@EstimatedDate datetime,@Total money,@OBS varchar(255),@IDPreSale int,@OBS2 varchar(255),@IDTouristGroup int,@IDDeliverType int,@DeliverDate datetime,@DeliverAddress varchar(100),@DeliverOBS varchar(255),@TotalDiscount money,@Confirmed bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Estimated
      (IDEstimated,IDPessoa,IDUser,IDStore,EstimatedDate,Total,OBS,IDPreSale,OBS2,IDTouristGroup,IDDeliverType,DeliverDate,DeliverAddress,DeliverOBS,TotalDiscount,Confirmed,ReplLastChange)
      VALUES
      (@IDEstimated,@IDPessoa,@IDUser,@IDStore,@EstimatedDate,@Total,@OBS,@IDPreSale,@OBS2,@IDTouristGroup,@IDDeliverType,@DeliverDate,@DeliverAddress,@DeliverOBS,@TotalDiscount,@Confirmed,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Estimated SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
IDUser = @IDUser,
IDStore = @IDStore,
EstimatedDate = @EstimatedDate,
Total = @Total,
OBS = @OBS,
IDPreSale = @IDPreSale,
OBS2 = @OBS2,
IDTouristGroup = @IDTouristGroup,
IDDeliverType = @IDDeliverType,
DeliverDate = @DeliverDate,
DeliverAddress = @DeliverAddress,
DeliverOBS = @DeliverOBS,
TotalDiscount = @TotalDiscount,
Confirmed = @Confirmed,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDEstimated = @IDEstimated
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_EstimatedItem]    Script Date: 05/12/2016 18:56:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_EstimatedItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_EstimatedItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_EstimatedItem]    Script Date: 05/12/2016 18:56:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_EstimatedItem]
(
	@IDEstimatedItem int,@IDEstimated int,@IDModel int,@SalePrice money,@Code int,@Qty decimal,@IDDepartment int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	EstimatedItem
      (IDEstimatedItem,IDEstimated,IDModel,SalePrice,Code,Qty,IDDepartment,ReplLastChange)
      VALUES
      (@IDEstimatedItem,@IDEstimated,@IDModel,@SalePrice,@Code,@Qty,@IDDepartment,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE EstimatedItem SET
    			-- No key fields
    			IDEstimated = @IDEstimated,
IDModel = @IDModel,
SalePrice = @SalePrice,
Code = @Code,
Qty = @Qty,
IDDepartment = @IDDepartment,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDEstimatedItem = @IDEstimatedItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Fin_LancamentoComplement]    Script Date: 05/12/2016 18:57:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Fin_LancamentoComplement]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Fin_LancamentoComplement]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Fin_LancamentoComplement]    Script Date: 05/12/2016 18:57:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Fin_LancamentoComplement]
(
	@IDLancamento int,@COO int,@GNF int,@CDC int,@DataEmissao datetime,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Fin_LancamentoComplement
      (IDLancamento,COO,GNF,CDC,DataEmissao,ReplLastChange)
      VALUES
      (@IDLancamento,@COO,@GNF,@CDC,@DataEmissao,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Fin_LancamentoComplement SET
    			-- No key fields
    			COO = @COO,
GNF = @GNF,
CDC = @CDC,
DataEmissao = @DataEmissao,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDLancamento = @IDLancamento
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Fin_LancamentoTerm]    Script Date: 05/12/2016 18:58:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Fin_LancamentoTerm]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Fin_LancamentoTerm]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Fin_LancamentoTerm]    Script Date: 05/12/2016 18:58:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Fin_LancamentoTerm]
(
	@IDLancamento int,@DueDateShift int,@Discount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Fin_LancamentoTerm
      (IDLancamento,DueDateShift,Discount,ReplLastChange)
      VALUES
      (@IDLancamento,@DueDateShift,@Discount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Fin_LancamentoTerm SET
    			-- No key fields
    			Discount = @Discount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDLancamento = @IDLancamento AND
DueDateShift = @DueDateShift
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Fin_Transferencia]    Script Date: 05/12/2016 18:59:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Fin_Transferencia]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Fin_Transferencia]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Fin_Transferencia]    Script Date: 05/12/2016 18:59:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Fin_Transferencia]
(
	@IDTransferencia int,@IDContaCorrenteCredito int,@IDContaCorrenteDebito int,@IDUsuario int,@Data datetime,@Valor money,@Obs text,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Fin_Transferencia
      (IDTransferencia,IDContaCorrenteCredito,IDContaCorrenteDebito,IDUsuario,Data,Valor,Obs,ReplLastChange)
      VALUES
      (@IDTransferencia,@IDContaCorrenteCredito,@IDContaCorrenteDebito,@IDUsuario,@Data,@Valor,@Obs,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Fin_Transferencia SET
    			-- No key fields
    			IDContaCorrenteCredito = @IDContaCorrenteCredito,
IDContaCorrenteDebito = @IDContaCorrenteDebito,
IDUsuario = @IDUsuario,
Data = @Data,
Valor = @Valor,
Obs = @Obs,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDTransferencia = @IDTransferencia
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_GroupCost]    Script Date: 05/12/2016 19:00:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_GroupCost]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_GroupCost]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_GroupCost]    Script Date: 05/12/2016 19:00:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_GroupCost]
(
	@IDCost int,@IDTouristGroup int,@IDCostType int,@IDInventoryMov int,@CostDate smalldatetime,@UnitCost money,@Quantity float,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	GroupCost
      (IDCost,IDTouristGroup,IDCostType,IDInventoryMov,CostDate,UnitCost,Quantity,ReplLastChange)
      VALUES
      (@IDCost,@IDTouristGroup,@IDCostType,@IDInventoryMov,@CostDate,@UnitCost,@Quantity,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE GroupCost SET
    			-- No key fields
    			IDTouristGroup = @IDTouristGroup,
IDCostType = @IDCostType,
IDInventoryMov = @IDInventoryMov,
CostDate = @CostDate,
UnitCost = @UnitCost,
Quantity = @Quantity,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCost = @IDCost
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_GroupCostGift]    Script Date: 05/12/2016 19:01:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_GroupCostGift]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_GroupCostGift]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_GroupCostGift]    Script Date: 05/12/2016 19:01:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_GroupCostGift]
(
	@IDGroupCostGift int,@IDGroupCost int,@IDModel int,@IDUser int,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	GroupCostGift
      (IDGroupCostGift,IDGroupCost,IDModel,IDUser,Desativado,ReplLastChange)
      VALUES
      (@IDGroupCostGift,@IDGroupCost,@IDModel,@IDUser,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE GroupCostGift SET
    			-- No key fields
    			IDGroupCost = @IDGroupCost,
IDModel = @IDModel,
IDUser = @IDUser,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDGroupCostGift = @IDGroupCostGift
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_History]    Script Date: 05/12/2016 19:01:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_History]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_History]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_History]    Script Date: 05/12/2016 19:01:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_History]
(
	@IDHistory int,@IDUser int,@MovDate datetime,@OBS varchar(255),@IDHistoryType int,@IDPreSale int,@IDServiceOrder int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	History
      (IDHistory,IDUser,MovDate,OBS,IDHistoryType,IDPreSale,IDServiceOrder,ReplLastChange)
      VALUES
      (@IDHistory,@IDUser,@MovDate,@OBS,@IDHistoryType,@IDPreSale,@IDServiceOrder,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE History SET
    			-- No key fields
    			IDUser = @IDUser,
MovDate = @MovDate,
OBS = @OBS,
IDHistoryType = @IDHistoryType,
IDPreSale = @IDPreSale,
IDServiceOrder = @IDServiceOrder,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDHistory = @IDHistory
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Hotel]    Script Date: 08/31/2016 12:29:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Hotel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Hotel]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Hotel]    Script Date: 08/31/2016 12:29:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Hotel]
(
	@IDHotel int,@Hotel varchar(50),@Endereco varchar(80),@Cidade varchar(40),@CEP char(12),@Telefone varchar(40),@Fax varchar(40),@OBS varchar(255),@System bit,@Desativado bit,@Hidden bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Hotel
      (IDHotel,Hotel,Endereco,Cidade,CEP,Telefone,Fax,OBS,System,Desativado,Hidden,ReplLastChange)
      VALUES
      (@IDHotel,@Hotel,@Endereco,@Cidade,@CEP,@Telefone,@Fax,@OBS,@System,@Desativado,@Hidden,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Hotel SET
    			-- No key fields
    			Hotel = @Hotel,
Endereco = @Endereco,
Cidade = @Cidade,
CEP = @CEP,
Telefone = @Telefone,
Fax = @Fax,
OBS = @OBS,
System = @System,
Desativado = @Desativado,
Hidden = @Hidden,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDHotel = @IDHotel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_BarcodePrint]    Script Date: 05/12/2016 19:03:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_BarcodePrint]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_BarcodePrint]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_BarcodePrint]    Script Date: 05/12/2016 19:03:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_BarcodePrint]
(
	@IDBarcode char(20),@Date datetime,@Qtd int,@IDUser int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_BarcodePrint
      (IDBarcode,Date,Qtd,IDUser,ReplLastChange)
      VALUES
      (@IDBarcode,@Date,@Qtd,@IDUser,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_BarcodePrint SET
    			-- No key fields
    			Date = @Date,
Qtd = @Qtd,
IDUser = @IDUser,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDBarcode = @IDBarcode
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_BarcodePrintSearch]    Script Date: 05/12/2016 19:04:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_BarcodePrintSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_BarcodePrintSearch]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_BarcodePrintSearch]    Script Date: 05/12/2016 19:04:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_BarcodePrintSearch]
(
	@sequence int,@IdUser int,@IdModel int,@model varchar(30),@description varchar(50),@IdBarcode char(20),@qtyOnHand decimal,@sellingPrice money,@numCopy int,@report varchar(10),@IdSearchType int,@StraightToPrinter char(1),@PrintQueue char(1),@LabelQtyOnHand char(1),@PrimaryBarcode char(1),@LargeImage varchar(255),@LargeImage2 varchar(255),@Manufacturer varchar(50),@VendorNum varchar(6),@Vendor varchar(50),@SizeName varchar(20),@Color varchar(20),@CodColor varchar(10),@ModelToScan varchar(22),@BarcodeToScan varchar(22),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_BarcodePrintSearch
      (sequence,IdUser,IdModel,model,description,IdBarcode,qtyOnHand,sellingPrice,numCopy,report,IdSearchType,StraightToPrinter,PrintQueue,LabelQtyOnHand,PrimaryBarcode,LargeImage,LargeImage2,Manufacturer,VendorNum,Vendor,SizeName,Color,CodColor,ModelToScan,BarcodeToScan,ReplLastChange)
      VALUES
      (@sequence,@IdUser,@IdModel,@model,@description,@IdBarcode,@qtyOnHand,@sellingPrice,@numCopy,@report,@IdSearchType,@StraightToPrinter,@PrintQueue,@LabelQtyOnHand,@PrimaryBarcode,@LargeImage,@LargeImage2,@Manufacturer,@VendorNum,@Vendor,@SizeName,@Color,@CodColor,@ModelToScan,@BarcodeToScan,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_BarcodePrintSearch SET
    			-- No key fields
    			IdUser = @IdUser,
IdModel = @IdModel,
model = @model,
description = @description,
IdBarcode = @IdBarcode,
qtyOnHand = @qtyOnHand,
sellingPrice = @sellingPrice,
numCopy = @numCopy,
report = @report,
IdSearchType = @IdSearchType,
StraightToPrinter = @StraightToPrinter,
PrintQueue = @PrintQueue,
LabelQtyOnHand = @LabelQtyOnHand,
PrimaryBarcode = @PrimaryBarcode,
LargeImage = @LargeImage,
LargeImage2 = @LargeImage2,
Manufacturer = @Manufacturer,
VendorNum = @VendorNum,
Vendor = @Vendor,
SizeName = @SizeName,
Color = @Color,
CodColor = @CodColor,
ModelToScan = @ModelToScan,
BarcodeToScan = @BarcodeToScan,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			sequence = @sequence
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ColorToGroup]    Script Date: 08/31/2016 12:31:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ColorToGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ColorToGroup]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ColorToGroup]    Script Date: 08/31/2016 12:31:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ColorToGroup]
(
	@IDSizeColorGroup int,@IDColor int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ColorToGroup
      (IDSizeColorGroup,IDColor,ReplLastChange)
      VALUES
      (@IDSizeColorGroup,@IDColor,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ColorToGroup SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSizeColorGroup = @IDSizeColorGroup AND
IDColor = @IDColor
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_Count]    Script Date: 05/12/2016 19:05:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_Count]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_Count]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_Count]    Script Date: 05/12/2016 19:05:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_Count]
(
	@IDCount int,@StartDate datetime,@EndDate datetime,@CountType int,@IDUser int,@IDStore int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_Count
      (IDCount,StartDate,EndDate,CountType,IDUser,IDStore,ReplLastChange)
      VALUES
      (@IDCount,@StartDate,@EndDate,@CountType,@IDUser,@IDStore,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_Count SET
    			-- No key fields
    			StartDate = @StartDate,
EndDate = @EndDate,
CountType = @CountType,
IDUser = @IDUser,
IDStore = @IDStore,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCount = @IDCount
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_CountItem]    Script Date: 05/12/2016 19:06:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_CountItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_CountItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_CountItem]    Script Date: 05/12/2016 19:06:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_CountItem]
(
	@IDCountItem int,@Barcode varchar(20),@Qty float,@SalePrice money,@CountDate datetime,@IDUser int,@IDCount int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_CountItem
      (IDCountItem,Barcode,Qty,SalePrice,CountDate,IDUser,IDCount,ReplLastChange)
      VALUES
      (@IDCountItem,@Barcode,@Qty,@SalePrice,@CountDate,@IDUser,@IDCount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_CountItem SET
    			-- No key fields
    			Barcode = @Barcode,
Qty = @Qty,
SalePrice = @SalePrice,
CountDate = @CountDate,
IDUser = @IDUser,
IDCount = @IDCount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCountItem = @IDCountItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_DescriptionPrice]    Script Date: 05/12/2016 19:07:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_DescriptionPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_DescriptionPrice]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_DescriptionPrice]    Script Date: 05/12/2016 19:07:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_DescriptionPrice]
(
	@IDDescriptionPrice int,@DescriptionPrice varchar(20),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_DescriptionPrice
      (IDDescriptionPrice,DescriptionPrice,ReplLastChange)
      VALUES
      (@IDDescriptionPrice,@DescriptionPrice,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_DescriptionPrice SET
    			-- No key fields
    			DescriptionPrice = @DescriptionPrice,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDescriptionPrice = @IDDescriptionPrice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_FrozeCount]    Script Date: 05/12/2016 19:11:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_FrozeCount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_FrozeCount]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_FrozeCount]    Script Date: 05/12/2016 19:11:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_FrozeCount]
(
	@IDCount int,@IDModel int,@Qty decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_FrozeCount
      (IDCount,IDModel,Qty,ReplLastChange)
      VALUES
      (@IDCount,@IDModel,@Qty,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_FrozeCount SET
    			-- No key fields
    			Qty = @Qty,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCount = @IDCount AND
IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_Lot]    Script Date: 05/12/2016 19:13:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_Lot]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_Lot]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_Lot]    Script Date: 05/12/2016 19:13:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_Lot]
(
	@IDLote int,@IDModel int,@IDUser int,@Lot varchar(50),@ExpirationDate datetime,@LotDate datetime,@Qty decimal,@System bit,@Hidden char(18),@Desativado int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_Lot
      (IDLote,IDModel,IDUser,Lot,ExpirationDate,LotDate,Qty,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDLote,@IDModel,@IDUser,@Lot,@ExpirationDate,@LotDate,@Qty,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_Lot SET
    			-- No key fields
    			IDModel = @IDModel,
IDUser = @IDUser,
Lot = @Lot,
ExpirationDate = @ExpirationDate,
LotDate = @LotDate,
Qty = @Qty,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDLote = @IDLote
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelBalance]    Script Date: 05/12/2016 19:15:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ModelBalance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelBalance]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelBalance]    Script Date: 05/12/2016 19:15:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelBalance]
(
	@IDModel int,@BalanceDate datetime,@Qty float,@AvgCostOut money,@BalanceTotal money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelBalance
      (IDModel,BalanceDate,Qty,AvgCostOut,BalanceTotal,ReplLastChange)
      VALUES
      (@IDModel,@BalanceDate,@Qty,@AvgCostOut,@BalanceTotal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelBalance SET
    			-- No key fields
    			Qty = @Qty,
AvgCostOut = @AvgCostOut,
BalanceTotal = @BalanceTotal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModel = @IDModel AND
BalanceDate = @BalanceDate
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelDepartment]    Script Date: 08/31/2016 12:42:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ModelDepartment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelDepartment]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelDepartment]    Script Date: 08/31/2016 12:42:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelDepartment]
(
	@StoreID int,@ModelID int,@IDDepartment int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelDepartment
      (StoreID,ModelID,IDDepartment,ReplLastChange)
      VALUES
      (@StoreID,@ModelID,@IDDepartment,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelDepartment SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			StoreID = @StoreID AND
ModelID = @ModelID AND
IDDepartment = @IDDepartment
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelNutrition]    Script Date: 05/12/2016 19:16:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ModelNutrition]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelNutrition]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelNutrition]    Script Date: 05/12/2016 19:16:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelNutrition]
(
	@IDModel int,@IDNutritionItem int,@QtyPortion decimal,@VDPortion decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelNutrition
      (IDModel,IDNutritionItem,QtyPortion,VDPortion,ReplLastChange)
      VALUES
      (@IDModel,@IDNutritionItem,@QtyPortion,@VDPortion,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelNutrition SET
    			-- No key fields
    			QtyPortion = @QtyPortion,
VDPortion = @VDPortion,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModel = @IDModel AND
IDNutritionItem = @IDNutritionItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelPrice]    Script Date: 05/12/2016 19:17:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ModelPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelPrice]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelPrice]    Script Date: 05/12/2016 19:17:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelPrice]
(
	@IDModel int,@IDDescriptionPrice int,@CostPrice money,@SuggPrice money,@IDVendor int,@SalePrice money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelPrice
      (IDModel,IDDescriptionPrice,CostPrice,SuggPrice,IDVendor,SalePrice,ReplLastChange)
      VALUES
      (@IDModel,@IDDescriptionPrice,@CostPrice,@SuggPrice,@IDVendor,@SalePrice,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelPrice SET
    			-- No key fields
    			CostPrice = @CostPrice,
SuggPrice = @SuggPrice,
IDVendor = @IDVendor,
SalePrice = @SalePrice,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModel = @IDModel AND
IDDescriptionPrice = @IDDescriptionPrice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelStateTax]    Script Date: 05/12/2016 19:18:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ModelStateTax]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelStateTax]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelStateTax]    Script Date: 05/12/2016 19:18:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelStateTax]
(
	@IDModel int,@IDEstado char(3),@IDTaxCategory int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelStateTax
      (IDModel,IDEstado,IDTaxCategory,ReplLastChange)
      VALUES
      (@IDModel,@IDEstado,@IDTaxCategory,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelStateTax SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModel = @IDModel AND
IDEstado = @IDEstado AND
IDTaxCategory = @IDTaxCategory
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelStoreBalance]    Script Date: 05/12/2016 19:27:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_ModelStoreBalance]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelStoreBalance]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelStoreBalance]    Script Date: 05/12/2016 19:27:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelStoreBalance]
(
	@IDStore int,@IDModel int,@BalanceDate datetime,@Qty float,@AvgCostOut money,@BalanceTotal money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelStoreBalance
      (IDStore,IDModel,BalanceDate,Qty,AvgCostOut,BalanceTotal,ReplLastChange)
      VALUES
      (@IDStore,@IDModel,@BalanceDate,@Qty,@AvgCostOut,@BalanceTotal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelStoreBalance SET
    			-- No key fields
    			Qty = @Qty,
AvgCostOut = @AvgCostOut,
BalanceTotal = @BalanceTotal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDStore = @IDStore AND
IDModel = @IDModel AND
BalanceDate = @BalanceDate
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_MovDocument]    Script Date: 05/12/2016 19:30:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_MovDocument]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_MovDocument]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_MovDocument]    Script Date: 05/12/2016 19:30:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_MovDocument]
(
	@IDMovDocument int,@IDPreInventoryMov int,@IDInventoryMov int,@DocumentNumber varchar(20),@DocumentDate datetime,@DocumentStatus int,@IDDocumentType int,@OBS varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_MovDocument
      (IDMovDocument,IDPreInventoryMov,IDInventoryMov,DocumentNumber,DocumentDate,DocumentStatus,IDDocumentType,OBS,ReplLastChange)
      VALUES
      (@IDMovDocument,@IDPreInventoryMov,@IDInventoryMov,@DocumentNumber,@DocumentDate,@DocumentStatus,@IDDocumentType,@OBS,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_MovDocument SET
    			-- No key fields
    			IDPreInventoryMov = @IDPreInventoryMov,
IDInventoryMov = @IDInventoryMov,
DocumentNumber = @DocumentNumber,
DocumentDate = @DocumentDate,
DocumentStatus = @DocumentStatus,
IDDocumentType = @IDDocumentType,
OBS = @OBS,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMovDocument = @IDMovDocument
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_MovPrice]    Script Date: 05/12/2016 19:31:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_MovPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_MovPrice]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_MovPrice]    Script Date: 05/12/2016 19:31:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_MovPrice]
(
	@IDMovPrice int,@IDPreInventoryMov int,@IDInventoryMov int,@IDDescriptionPrice int,@IDVendor int,@SuggPrice money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_MovPrice
      (IDMovPrice,IDPreInventoryMov,IDInventoryMov,IDDescriptionPrice,IDVendor,SuggPrice,ReplLastChange)
      VALUES
      (@IDMovPrice,@IDPreInventoryMov,@IDInventoryMov,@IDDescriptionPrice,@IDVendor,@SuggPrice,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_MovPrice SET
    			-- No key fields
    			IDPreInventoryMov = @IDPreInventoryMov,
IDInventoryMov = @IDInventoryMov,
IDDescriptionPrice = @IDDescriptionPrice,
IDVendor = @IDVendor,
SuggPrice = @SuggPrice,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMovPrice = @IDMovPrice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_NCM]    Script Date: 05/12/2016 19:32:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_NCM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_NCM]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_NCM]    Script Date: 05/12/2016 19:32:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_NCM]
(
	@IDNCM int,@Codigo varchar(20),@Descricao varchar(255),@MVAInterno decimal,@MVAInterestadual decimal,@Incide bit,@System bit,@Desativado bit,@Hidden bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_NCM
      (IDNCM,Codigo,Descricao,MVAInterno,MVAInterestadual,Incide,System,Desativado,Hidden,ReplLastChange)
      VALUES
      (@IDNCM,@Codigo,@Descricao,@MVAInterno,@MVAInterestadual,@Incide,@System,@Desativado,@Hidden,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_NCM SET
    			-- No key fields
    			Codigo = @Codigo,
Descricao = @Descricao,
MVAInterno = @MVAInterno,
MVAInterestadual = @MVAInterestadual,
Incide = @Incide,
System = @System,
Desativado = @Desativado,
Hidden = @Hidden,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDNCM = @IDNCM
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_Nutrition]    Script Date: 05/12/2016 19:33:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_Nutrition]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_Nutrition]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_Nutrition]    Script Date: 05/12/2016 19:33:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_Nutrition]
(
	@IDNutrition int,@Description varchar(50),@Hidden bit,@Desativado bit,@System bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_Nutrition
      (IDNutrition,Description,Hidden,Desativado,System,ReplLastChange)
      VALUES
      (@IDNutrition,@Description,@Hidden,@Desativado,@System,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_Nutrition SET
    			-- No key fields
    			Description = @Description,
Hidden = @Hidden,
Desativado = @Desativado,
System = @System,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDNutrition = @IDNutrition
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_NutritionItem]    Script Date: 05/12/2016 19:34:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_NutritionItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_NutritionItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_NutritionItem]    Script Date: 05/12/2016 19:34:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_NutritionItem]
(
	@IDNutritionItem int,@IDNutrition int,@Description varchar(100),@FieldLength int,@FieldPos int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_NutritionItem
      (IDNutritionItem,IDNutrition,Description,FieldLength,FieldPos,ReplLastChange)
      VALUES
      (@IDNutritionItem,@IDNutrition,@Description,@FieldLength,@FieldPos,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_NutritionItem SET
    			-- No key fields
    			IDNutrition = @IDNutrition,
Description = @Description,
FieldLength = @FieldLength,
FieldPos = @FieldPos,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDNutritionItem = @IDNutritionItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_SizeColorGroup]    Script Date: 08/31/2016 12:44:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_SizeColorGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_SizeColorGroup]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_SizeColorGroup]    Script Date: 08/31/2016 12:44:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_SizeColorGroup]
(
	@IDSizeColorGroup int,@Description varchar(50),@IsColor bit,@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_SizeColorGroup
      (IDSizeColorGroup,Description,IsColor,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDSizeColorGroup,@Description,@IsColor,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_SizeColorGroup SET
    			-- No key fields
    			Description = @Description,
IsColor = @IsColor,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSizeColorGroup = @IDSizeColorGroup
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_SizeToGroup]    Script Date: 08/31/2016 12:46:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_SizeToGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_SizeToGroup]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_SizeToGroup]    Script Date: 08/31/2016 12:46:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_SizeToGroup]
(
	@IDSizeColorGroup int,@IDSize int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_SizeToGroup
      (IDSizeColorGroup,IDSize,ReplLastChange)
      VALUES
      (@IDSizeColorGroup,@IDSize,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_SizeToGroup SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSizeColorGroup = @IDSizeColorGroup AND
IDSize = @IDSize
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_StoreModelLot]    Script Date: 05/12/2016 19:34:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_StoreModelLot]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_StoreModelLot]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_StoreModelLot]    Script Date: 05/12/2016 19:34:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_StoreModelLot]
(
	@IDLote int,@IDStore int,@IDModel int,@Qty decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_StoreModelLot
      (IDLote,IDStore,IDModel,Qty,ReplLastChange)
      VALUES
      (@IDLote,@IDStore,@IDModel,@Qty,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_StoreModelLot SET
    			-- No key fields
    			Qty = @Qty,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDLote = @IDLote AND
IDStore = @IDStore AND
IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_StorePrice]    Script Date: 05/12/2016 19:35:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Inv_StorePrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Inv_StorePrice]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_StorePrice]    Script Date: 05/12/2016 19:35:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Inv_StorePrice]
(
	@IDStore int,@IDModel int,@IDDescriptionPrice int,@IDVendor int,@CostPrice money,@SuggPrice money,@SalePrice money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_StorePrice
      (IDStore,IDModel,IDDescriptionPrice,IDVendor,CostPrice,SuggPrice,SalePrice,ReplLastChange)
      VALUES
      (@IDStore,@IDModel,@IDDescriptionPrice,@IDVendor,@CostPrice,@SuggPrice,@SalePrice,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_StorePrice SET
    			-- No key fields
    			IDVendor = @IDVendor,
CostPrice = @CostPrice,
SuggPrice = @SuggPrice,
SalePrice = @SalePrice,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDStore = @IDStore AND
IDModel = @IDModel AND
IDDescriptionPrice = @IDDescriptionPrice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvAccessory]    Script Date: 08/31/2016 12:49:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvAccessory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvAccessory]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvAccessory]    Script Date: 08/31/2016 12:49:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvAccessory]
(
	@IDInvAccessory int,@IDModel int,@Description varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvAccessory
      (IDInvAccessory,IDModel,Description,ReplLastChange)
      VALUES
      (@IDInvAccessory,@IDModel,@Description,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvAccessory SET
    			-- No key fields
    			Description = @Description,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvAccessory = @IDInvAccessory AND
IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InventorySerial]    Script Date: 05/12/2016 19:36:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InventorySerial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InventorySerial]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InventorySerial]    Script Date: 05/12/2016 19:36:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InventorySerial]
(
	@StoreID int,@ModelID int,@Serial varchar(30),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InventorySerial
      (StoreID,ModelID,Serial,ReplLastChange)
      VALUES
      (@StoreID,@ModelID,@Serial,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InventorySerial SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			StoreID = @StoreID AND
ModelID = @ModelID AND
Serial = @Serial
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvFeatures]    Script Date: 08/31/2016 12:50:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvFeatures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvFeatures]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvFeatures]    Script Date: 08/31/2016 12:50:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvFeatures]
(
	@IDInvFeatures int,@IDModel int,@Feature varchar(255),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvFeatures
      (IDInvFeatures,IDModel,Feature,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDInvFeatures,@IDModel,@Feature,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvFeatures SET
    			-- No key fields
    			IDModel = @IDModel,
Feature = @Feature,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvFeatures = @IDInvFeatures
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvTechFeatures]    Script Date: 08/31/2016 12:51:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvTechFeatures]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvTechFeatures]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvTechFeatures]    Script Date: 08/31/2016 12:51:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvTechFeatures]
(
	@IDInvTechFeatures int,@IDModel int,@TechFeature varchar(255),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvTechFeatures
      (IDInvTechFeatures,IDModel,TechFeature,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDInvTechFeatures,@IDModel,@TechFeature,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvTechFeatures SET
    			-- No key fields
    			IDModel = @IDModel,
TechFeature = @TechFeature,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvTechFeatures = @IDInvTechFeatures
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceCommission]    Script Date: 05/12/2016 19:37:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvoiceCommission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvoiceCommission]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceCommission]    Script Date: 05/12/2016 19:37:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvoiceCommission]
(
	@IDPessoa int,@IDInvoice int,@Commission money,@Tipo char(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvoiceCommission
      (IDPessoa,IDInvoice,Commission,Tipo,ReplLastChange)
      VALUES
      (@IDPessoa,@IDInvoice,@Commission,@Tipo,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvoiceCommission SET
    			-- No key fields
    			Commission = @Commission,
Tipo = @Tipo,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPessoa = @IDPessoa AND
IDInvoice = @IDInvoice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceGen]    Script Date: 05/12/2016 19:38:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvoiceGen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvoiceGen]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceGen]    Script Date: 05/12/2016 19:38:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvoiceGen]
(
	@IDInvoice int,@BitGen bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvoiceGen
      (IDInvoice,BitGen,ReplLastChange)
      VALUES
      (@IDInvoice,@BitGen,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvoiceGen SET
    			-- No key fields
    			BitGen = @BitGen,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvoice = @IDInvoice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceOBS]    Script Date: 05/12/2016 19:39:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvoiceOBS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvoiceOBS]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceOBS]    Script Date: 05/12/2016 19:39:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvoiceOBS]
(
	@IDInvoiceOBS int,@IDPreSale int,@ObsDate datetime,@Obs varchar(255),@IDCFOP int,@IDPessoaTax int,@IDCarrier int,@FreightType int,@IDUserDeliver int,@IDPessoaAddress int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvoiceOBS
      (IDInvoiceOBS,IDPreSale,ObsDate,Obs,IDCFOP,IDPessoaTax,IDCarrier,FreightType,IDUserDeliver,IDPessoaAddress,ReplLastChange)
      VALUES
      (@IDInvoiceOBS,@IDPreSale,@ObsDate,@Obs,@IDCFOP,@IDPessoaTax,@IDCarrier,@FreightType,@IDUserDeliver,@IDPessoaAddress,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvoiceOBS SET
    			-- No key fields
    			IDPreSale = @IDPreSale,
ObsDate = @ObsDate,
Obs = @Obs,
IDCFOP = @IDCFOP,
IDPessoaTax = @IDPessoaTax,
IDCarrier = @IDCarrier,
FreightType = @FreightType,
IDUserDeliver = @IDUserDeliver,
IDPessoaAddress = @IDPessoaAddress,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvoiceOBS = @IDInvoiceOBS
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceToCostType]    Script Date: 05/12/2016 19:40:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvoiceToCostType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvoiceToCostType]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvoiceToCostType]    Script Date: 05/12/2016 19:40:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvoiceToCostType]
(
	@IDInvoiceCost int,@IDPreSale int,@IDCostType int,@Amount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvoiceToCostType
      (IDInvoiceCost,IDPreSale,IDCostType,Amount,ReplLastChange)
      VALUES
      (@IDInvoiceCost,@IDPreSale,@IDCostType,@Amount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvoiceToCostType SET
    			-- No key fields
    			IDPreSale = @IDPreSale,
IDCostType = @IDCostType,
Amount = @Amount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvoiceCost = @IDInvoiceCost
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO
/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvResetHistory]    Script Date: 05/12/2016 19:41:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_InvResetHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_InvResetHistory]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InvResetHistory]    Script Date: 05/12/2016 19:41:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_InvResetHistory]
(
	@ResetDate datetime,@IDStore int,@IDModel int,@Qty decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InvResetHistory
      (ResetDate,IDStore,IDModel,Qty,ReplLastChange)
      VALUES
      (@ResetDate,@IDStore,@IDModel,@Qty,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InvResetHistory SET
    			-- No key fields
    			Qty = @Qty,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			ResetDate = @ResetDate AND
IDStore = @IDStore AND
IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDInventoryMov]    Script Date: 05/12/2016 19:42:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Key_IDInventoryMov]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Key_IDInventoryMov]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDInventoryMov]    Script Date: 05/12/2016 19:42:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Key_IDInventoryMov]
(
	@SeqID int,@SeqVal varchar(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Key_IDInventoryMov
      (SeqID,SeqVal,ReplLastChange)
      VALUES
      (@SeqID,@SeqVal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Key_IDInventoryMov SET
    			-- No key fields
    			SeqVal = @SeqVal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SeqID = @SeqID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDInvoice]    Script Date: 05/12/2016 19:44:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Key_IDInvoice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Key_IDInvoice]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDInvoice]    Script Date: 05/12/2016 19:44:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Key_IDInvoice]
(
	@SeqID int,@SeqVal varchar(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Key_IDInvoice
      (SeqID,SeqVal,ReplLastChange)
      VALUES
      (@SeqID,@SeqVal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Key_IDInvoice SET
    			-- No key fields
    			SeqVal = @SeqVal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SeqID = @SeqID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDLancamento]    Script Date: 05/12/2016 19:46:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Key_IDLancamento]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Key_IDLancamento]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDLancamento]    Script Date: 05/12/2016 19:46:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Key_IDLancamento]
(
	@SeqID int,@SeqVal varchar(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Key_IDLancamento
      (SeqID,SeqVal,ReplLastChange)
      VALUES
      (@SeqID,@SeqVal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Key_IDLancamento SET
    			-- No key fields
    			SeqVal = @SeqVal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SeqID = @SeqID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDPreInventoryMov]    Script Date: 05/12/2016 19:46:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Key_IDPreInventoryMov]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Key_IDPreInventoryMov]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDPreInventoryMov]    Script Date: 05/12/2016 19:46:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Key_IDPreInventoryMov]
(
	@SeqID int,@SeqVal varchar(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Key_IDPreInventoryMov
      (SeqID,SeqVal,ReplLastChange)
      VALUES
      (@SeqID,@SeqVal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Key_IDPreInventoryMov SET
    			-- No key fields
    			SeqVal = @SeqVal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SeqID = @SeqID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDPreSale]    Script Date: 05/12/2016 19:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Key_IDPreSale]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Key_IDPreSale]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDPreSale]    Script Date: 05/12/2016 19:47:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Key_IDPreSale]
(
	@SeqID int,@SeqVal varchar(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Key_IDPreSale
      (SeqID,SeqVal,ReplLastChange)
      VALUES
      (@SeqID,@SeqVal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Key_IDPreSale SET
    			-- No key fields
    			SeqVal = @SeqVal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SeqID = @SeqID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDSaleItemCommission]    Script Date: 05/12/2016 19:49:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Key_IDSaleItemCommission]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Key_IDSaleItemCommission]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Key_IDSaleItemCommission]    Script Date: 05/12/2016 19:49:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Key_IDSaleItemCommission]
(
	@SeqID int,@SeqVal varchar(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Key_IDSaleItemCommission
      (SeqID,SeqVal,ReplLastChange)
      VALUES
      (@SeqID,@SeqVal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Key_IDSaleItemCommission SET
    			-- No key fields
    			SeqVal = @SeqVal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SeqID = @SeqID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MargemTable]    Script Date: 05/12/2016 19:49:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_MargemTable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_MargemTable]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MargemTable]    Script Date: 05/12/2016 19:49:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_MargemTable]
(
	@IDMargemTable int,@MargemTable varchar(30),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	MargemTable
      (IDMargemTable,MargemTable,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDMargemTable,@MargemTable,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE MargemTable SET
    			-- No key fields
    			MargemTable = @MargemTable,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMargemTable = @IDMargemTable
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MargemTableRange]    Script Date: 05/12/2016 19:50:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_MargemTableRange]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_MargemTableRange]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MargemTableRange]    Script Date: 05/12/2016 19:50:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_MargemTableRange]
(
	@IDMargemTableRange int,@IDMargemTable int,@MinValue money,@MaxValue money,@Percentage float,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	MargemTableRange
      (IDMargemTableRange,IDMargemTable,MinValue,MaxValue,Percentage,ReplLastChange)
      VALUES
      (@IDMargemTableRange,@IDMargemTable,@MinValue,@MaxValue,@Percentage,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE MargemTableRange SET
    			-- No key fields
    			IDMargemTable = @IDMargemTable,
MinValue = @MinValue,
MaxValue = @MaxValue,
Percentage = @Percentage,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMargemTableRange = @IDMargemTableRange
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuItem]    Script Date: 05/12/2016 19:51:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_MenuItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_MenuItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuItem]    Script Date: 05/12/2016 19:51:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_MenuItem]
(
	@IDMenu int,@IDSubMenu int,@Name varchar(30),@ParentMenu varchar(30),@Tip varchar(255),@CmdLine varchar(255),@Visible bit,@Enabled bit,@Shortcut int,@ImageIndex int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	MenuItem
      (IDMenu,IDSubMenu,Name,ParentMenu,Tip,CmdLine,Visible,Enabled,Shortcut,ImageIndex,ReplLastChange)
      VALUES
      (@IDMenu,@IDSubMenu,@Name,@ParentMenu,@Tip,@CmdLine,@Visible,@Enabled,@Shortcut,@ImageIndex,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE MenuItem SET
    			-- No key fields
    			Name = @Name,
ParentMenu = @ParentMenu,
Tip = @Tip,
CmdLine = @CmdLine,
Visible = @Visible,
Enabled = @Enabled,
Shortcut = @Shortcut,
ImageIndex = @ImageIndex,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMenu = @IDMenu AND
IDSubMenu = @IDSubMenu
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuItemLanguage]    Script Date: 05/12/2016 19:52:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_MenuItemLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_MenuItemLanguage]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuItemLanguage]    Script Date: 05/12/2016 19:52:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_MenuItemLanguage]
(
	@IDMenu int,@IDSubMenu int,@IDLanguage int,@Name varchar(30),@ParentMenu varchar(30),@Tip varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	MenuItemLanguage
      (IDMenu,IDSubMenu,IDLanguage,Name,ParentMenu,Tip,ReplLastChange)
      VALUES
      (@IDMenu,@IDSubMenu,@IDLanguage,@Name,@ParentMenu,@Tip,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE MenuItemLanguage SET
    			-- No key fields
    			Name = @Name,
ParentMenu = @ParentMenu,
Tip = @Tip,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMenu = @IDMenu AND
IDSubMenu = @IDSubMenu AND
IDLanguage = @IDLanguage
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuMain]    Script Date: 05/12/2016 19:53:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_MenuMain]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_MenuMain]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuMain]    Script Date: 05/12/2016 19:53:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_MenuMain]
(
	@IDMenu int,@MenuName varchar(30),@Visible bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	MenuMain
      (IDMenu,MenuName,Visible,ReplLastChange)
      VALUES
      (@IDMenu,@MenuName,@Visible,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE MenuMain SET
    			-- No key fields
    			MenuName = @MenuName,
Visible = @Visible,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMenu = @IDMenu
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuMainLanguage]    Script Date: 05/12/2016 19:54:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_MenuMainLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_MenuMainLanguage]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_MenuMainLanguage]    Script Date: 05/12/2016 19:54:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_MenuMainLanguage]
(
	@IDMenu int,@IDLanguage int,@MenuName varchar(30),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	MenuMainLanguage
      (IDMenu,IDLanguage,MenuName,ReplLastChange)
      VALUES
      (@IDMenu,@IDLanguage,@MenuName,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE MenuMainLanguage SET
    			-- No key fields
    			MenuName = @MenuName,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMenu = @IDMenu AND
IDLanguage = @IDLanguage
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_CFOP]    Script Date: 05/12/2016 19:55:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_CFOP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_CFOP]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_CFOP]    Script Date: 05/12/2016 19:55:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_CFOP]
(
	@IDCFOP int,@Number varchar(15),@Description varchar(30),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_CFOP
      (IDCFOP,Number,Description,ReplLastChange)
      VALUES
      (@IDCFOP,@Number,@Description,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_CFOP SET
    			-- No key fields
    			Number = @Number,
Description = @Description,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCFOP = @IDCFOP
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_Controler]    Script Date: 05/12/2016 19:56:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_Controler]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_Controler]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_Controler]    Script Date: 05/12/2016 19:56:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_Controler]
(
	@Software varchar(50),@Info text,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_Controler
      (Software,Info,ReplLastChange)
      VALUES
      (@Software,@Info,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_Controler SET
    			-- No key fields
    			Info = @Info,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Software = @Software
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_DefaultInvoiceOBS]    Script Date: 05/12/2016 19:57:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_DefaultInvoiceOBS]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_DefaultInvoiceOBS]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_DefaultInvoiceOBS]    Script Date: 05/12/2016 19:57:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_DefaultInvoiceOBS]
(
	@IDDefaultInvoiceOBS int,@OBSType int,@DefaultInvoiceOBS varchar(80),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_DefaultInvoiceOBS
      (IDDefaultInvoiceOBS,OBSType,DefaultInvoiceOBS,ReplLastChange)
      VALUES
      (@IDDefaultInvoiceOBS,@OBSType,@DefaultInvoiceOBS,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_DefaultInvoiceOBS SET
    			-- No key fields
    			OBSType = @OBSType,
DefaultInvoiceOBS = @DefaultInvoiceOBS,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDefaultInvoiceOBS = @IDDefaultInvoiceOBS
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_DocumentType]    Script Date: 05/12/2016 20:00:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_DocumentType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_DocumentType]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_DocumentType]    Script Date: 05/12/2016 20:00:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_DocumentType]
(
	@IDDocumentType int,@DocumentType varchar(40),@DefaultType bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_DocumentType
      (IDDocumentType,DocumentType,DefaultType,ReplLastChange)
      VALUES
      (@IDDocumentType,@DocumentType,@DefaultType,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_DocumentType SET
    			-- No key fields
    			DocumentType = @DocumentType,
DefaultType = @DefaultType,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDocumentType = @IDDocumentType
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_PessoaAddress]    Script Date: 05/12/2016 20:01:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_PessoaAddress]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_PessoaAddress]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_PessoaAddress]    Script Date: 05/12/2016 20:01:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_PessoaAddress]
(
	@IDPessoaAddress int,@IDPessoa int,@Name varchar(60),@Address varchar(80),@City varchar(30),@ZIP varchar(10),@IDTaxCategory int,@IDPais int,@IDEstado char(3),@IsBillTo bit,@System bit,@Hidden bit,@Desativado bit,@Neighborhood varchar(30),@CompanyReg varchar(30),@IDMunicipio int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_PessoaAddress
      (IDPessoaAddress,IDPessoa,Name,Address,City,ZIP,IDTaxCategory,IDPais,IDEstado,IsBillTo,System,Hidden,Desativado,Neighborhood,CompanyReg,IDMunicipio,ReplLastChange)
      VALUES
      (@IDPessoaAddress,@IDPessoa,@Name,@Address,@City,@ZIP,@IDTaxCategory,@IDPais,@IDEstado,@IsBillTo,@System,@Hidden,@Desativado,@Neighborhood,@CompanyReg,@IDMunicipio,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_PessoaAddress SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
Name = @Name,
Address = @Address,
City = @City,
ZIP = @ZIP,
IDTaxCategory = @IDTaxCategory,
IDPais = @IDPais,
IDEstado = @IDEstado,
IsBillTo = @IsBillTo,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
Neighborhood = @Neighborhood,
CompanyReg = @CompanyReg,
IDMunicipio = @IDMunicipio,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPessoaAddress = @IDPessoaAddress
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_PessoaHistory]    Script Date: 05/12/2016 20:03:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_PessoaHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_PessoaHistory]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_PessoaHistory]    Script Date: 05/12/2016 20:03:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_PessoaHistory]
(
	@IDPessoaHistory int,@IDUser int,@MovDate datetime,@IDPessoa int,@IDPessoaHistoryType int,@IDPessoaHistoryResult int,@Obs varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_PessoaHistory
      (IDPessoaHistory,IDUser,MovDate,IDPessoa,IDPessoaHistoryType,IDPessoaHistoryResult,Obs,ReplLastChange)
      VALUES
      (@IDPessoaHistory,@IDUser,@MovDate,@IDPessoa,@IDPessoaHistoryType,@IDPessoaHistoryResult,@Obs,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_PessoaHistory SET
    			-- No key fields
    			IDUser = @IDUser,
MovDate = @MovDate,
IDPessoa = @IDPessoa,
IDPessoaHistoryType = @IDPessoaHistoryType,
IDPessoaHistoryResult = @IDPessoaHistoryResult,
Obs = @Obs,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPessoaHistory = @IDPessoaHistory
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_StoreVendorAccount]    Script Date: 05/19/2016 03:09:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Mnt_StoreVendorAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Mnt_StoreVendorAccount]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Mnt_StoreVendorAccount]    Script Date: 05/19/2016 03:09:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Mnt_StoreVendorAccount]
(
	@IDStoreVendorAccount int,@IDStore int,@IDPessoa int,@Account varchar(35),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Mnt_StoreVendorAccount
      (IDStoreVendorAccount,IDStore,IDPessoa,Account,ReplLastChange)
      VALUES
      (@IDStoreVendorAccount,@IDStore,@IDPessoa,@Account,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Mnt_StoreVendorAccount SET
    			-- No key fields
    			IDStore = @IDStore,
IDPessoa = @IDPessoa,
Account = @Account,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDStoreVendorAccount = @IDStoreVendorAccount
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ModelPriceLog]    Script Date: 05/12/2016 20:04:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_ModelPriceLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_ModelPriceLog]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ModelPriceLog]    Script Date: 05/12/2016 20:04:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_ModelPriceLog]
(
	@IDModelPriceLog int,@IDModel int,@IDUser int,@IDStore int,@ChangeDate datetime,@OldCostPrice money,@NewCostPrice money,@OldSalePrice money,@NewSalePrice money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	ModelPriceLog
      (IDModelPriceLog,IDModel,IDUser,IDStore,ChangeDate,OldCostPrice,NewCostPrice,OldSalePrice,NewSalePrice,ReplLastChange)
      VALUES
      (@IDModelPriceLog,@IDModel,@IDUser,@IDStore,@ChangeDate,@OldCostPrice,@NewCostPrice,@OldSalePrice,@NewSalePrice,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE ModelPriceLog SET
    			-- No key fields
    			IDModel = @IDModel,
IDUser = @IDUser,
IDStore = @IDStore,
ChangeDate = @ChangeDate,
OldCostPrice = @OldCostPrice,
NewCostPrice = @NewCostPrice,
OldSalePrice = @OldSalePrice,
NewSalePrice = @NewSalePrice,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModelPriceLog = @IDModelPriceLog
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ModelToSpecialPrice]    Script Date: 08/31/2016 13:01:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_ModelToSpecialPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_ModelToSpecialPrice]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ModelToSpecialPrice]    Script Date: 08/31/2016 13:01:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_ModelToSpecialPrice]
(
	@IDModel int,@IDSpecialPrice int,@MarkUp money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	ModelToSpecialPrice
      (IDModel,IDSpecialPrice,MarkUp,ReplLastChange)
      VALUES
      (@IDModel,@IDSpecialPrice,@MarkUp,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE ModelToSpecialPrice SET
    			-- No key fields
    			MarkUp = @MarkUp,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModel = @IDModel AND
IDSpecialPrice = @IDSpecialPrice
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ModelTransfSerial]    Script Date: 05/12/2016 20:05:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_ModelTransfSerial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_ModelTransfSerial]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ModelTransfSerial]    Script Date: 05/12/2016 20:05:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_ModelTransfSerial]
(
	@IDModelTransfSerial int,@IDModelTransfDet int,@SerialNum varchar(30),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	ModelTransfSerial
      (IDModelTransfSerial,IDModelTransfDet,SerialNum,ReplLastChange)
      VALUES
      (@IDModelTransfSerial,@IDModelTransfDet,@SerialNum,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE ModelTransfSerial SET
    			-- No key fields
    			IDModelTransfDet = @IDModelTransfDet,
SerialNum = @SerialNum,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDModelTransfSerial = @IDModelTransfSerial
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Nfe_NotaFiscal]    Script Date: 05/12/2016 20:07:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Nfe_NotaFiscal]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Nfe_NotaFiscal]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Nfe_NotaFiscal]    Script Date: 05/12/2016 20:07:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Nfe_NotaFiscal]
(
	@IDNotaFiscal int,@Origem varchar(20),@Referencia int,@Situacao char(15),@DataSolicitacao datetime,@DataUltimoEnvio datetime,@DataResultado datetime,@DataUltimaImpressao datetime,@DetalhamentoErro varchar(8000),@QtdEnvios int,@QtdImpressao int,@IDUserSolicitacao int,@IDUserUltimoEnvio int,@IDUserResultado int,@IDUserUltimaImpressao int,@IDUserCancelamento int,@XMLEnviado text,@XMLRecebido text,@Chave varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Nfe_NotaFiscal
      (IDNotaFiscal,Origem,Referencia,Situacao,DataSolicitacao,DataUltimoEnvio,DataResultado,DataUltimaImpressao,DetalhamentoErro,QtdEnvios,QtdImpressao,IDUserSolicitacao,IDUserUltimoEnvio,IDUserResultado,IDUserUltimaImpressao,IDUserCancelamento,XMLEnviado,XMLRecebido,Chave,ReplLastChange)
      VALUES
      (@IDNotaFiscal,@Origem,@Referencia,@Situacao,@DataSolicitacao,@DataUltimoEnvio,@DataResultado,@DataUltimaImpressao,@DetalhamentoErro,@QtdEnvios,@QtdImpressao,@IDUserSolicitacao,@IDUserUltimoEnvio,@IDUserResultado,@IDUserUltimaImpressao,@IDUserCancelamento,@XMLEnviado,@XMLRecebido,@Chave,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Nfe_NotaFiscal SET
    			-- No key fields
    			Origem = @Origem,
Referencia = @Referencia,
Situacao = @Situacao,
DataSolicitacao = @DataSolicitacao,
DataUltimoEnvio = @DataUltimoEnvio,
DataResultado = @DataResultado,
DataUltimaImpressao = @DataUltimaImpressao,
DetalhamentoErro = @DetalhamentoErro,
QtdEnvios = @QtdEnvios,
QtdImpressao = @QtdImpressao,
IDUserSolicitacao = @IDUserSolicitacao,
IDUserUltimoEnvio = @IDUserUltimoEnvio,
IDUserResultado = @IDUserResultado,
IDUserUltimaImpressao = @IDUserUltimaImpressao,
IDUserCancelamento = @IDUserCancelamento,
XMLEnviado = @XMLEnviado,
XMLRecebido = @XMLRecebido,
Chave = @Chave,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDNotaFiscal = @IDNotaFiscal
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Param]    Script Date: 05/12/2016 20:08:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Param]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Param]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Param]    Script Date: 05/12/2016 20:08:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Param]
(
	@IDParam int,@SrvParameter varchar(40),@SrvValue varchar(30),@SrvType char(10),@Description varchar(200),@DefaultValue varchar(30),@Desativado bit,@IDMenu int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Param
      (IDParam,SrvParameter,SrvValue,SrvType,Description,DefaultValue,Desativado,IDMenu,ReplLastChange)
      VALUES
      (@IDParam,@SrvParameter,@SrvValue,@SrvType,@Description,@DefaultValue,@Desativado,@IDMenu,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Param SET
    			-- No key fields
    			SrvParameter = @SrvParameter,
SrvValue = @SrvValue,
SrvType = @SrvType,
Description = @Description,
DefaultValue = @DefaultValue,
Desativado = @Desativado,
IDMenu = @IDMenu,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDParam = @IDParam
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ParamLanguage]    Script Date: 05/12/2016 20:08:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_ParamLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_ParamLanguage]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_ParamLanguage]    Script Date: 05/12/2016 20:08:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_ParamLanguage]
(
	@IDParam int,@IDLanguage int,@SrvParameter varchar(40),@Description varchar(200),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	ParamLanguage
      (IDParam,IDLanguage,SrvParameter,Description,ReplLastChange)
      VALUES
      (@IDParam,@IDLanguage,@SrvParameter,@Description,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE ParamLanguage SET
    			-- No key fields
    			SrvParameter = @SrvParameter,
Description = @Description,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDParam = @IDParam AND
IDLanguage = @IDLanguage
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_animals]    Script Date: 05/12/2016 20:09:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_animals]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_animals]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_animals]    Script Date: 05/12/2016 20:09:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_animals]
(
	@id int,@sku varchar(50),@litter varchar(50),@breed varchar(50),@sex varchar(50),@weight varchar(50),@color varchar(50),@pen varchar(50),@whelp varchar(50),@comments varchar(50),@breeder varchar(50),@usda varchar(50),@datePur varchar(50),@microchip varchar(50),@registry varchar(50),@reg varchar(50),@regSuff1 varchar(50),@regSuff2 varchar(50),@name varchar(50),@supplier varchar(50),@sire varchar(50),@dam varchar(50),@ref varchar(50),@collar varchar(50),@deposit money,@VendorCost money,@SuggRetail money,@SellingPrice money,@TotQtyOnHand int,@soldDate varchar(50),@soldPrice money,@customerid varchar(20),@status char(1),@fname varchar(50),@lname varchar(50),@address1 varchar(255),@address2 varchar(255),@address3 varchar(50),@city varchar(50),@state varchar(50),@zip varchar(50),@phone varchar(50),@email varchar(50),@vintage varchar(15),@is_trans int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_animals
      (id,sku,litter,breed,sex,weight,color,pen,whelp,comments,breeder,usda,datePur,microchip,registry,reg,regSuff1,regSuff2,name,supplier,sire,dam,ref,collar,deposit,VendorCost,SuggRetail,SellingPrice,TotQtyOnHand,soldDate,soldPrice,customerid,status,fname,lname,address1,address2,address3,city,state,zip,phone,email,vintage,is_trans,ReplLastChange)
      VALUES
      (@id,@sku,@litter,@breed,@sex,@weight,@color,@pen,@whelp,@comments,@breeder,@usda,@datePur,@microchip,@registry,@reg,@regSuff1,@regSuff2,@name,@supplier,@sire,@dam,@ref,@collar,@deposit,@VendorCost,@SuggRetail,@SellingPrice,@TotQtyOnHand,@soldDate,@soldPrice,@customerid,@status,@fname,@lname,@address1,@address2,@address3,@city,@state,@zip,@phone,@email,@vintage,@is_trans,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_animals SET
    			-- No key fields
    			sku = @sku,
litter = @litter,
breed = @breed,
sex = @sex,
weight = @weight,
color = @color,
pen = @pen,
whelp = @whelp,
comments = @comments,
breeder = @breeder,
usda = @usda,
datePur = @datePur,
microchip = @microchip,
registry = @registry,
reg = @reg,
regSuff1 = @regSuff1,
regSuff2 = @regSuff2,
name = @name,
supplier = @supplier,
sire = @sire,
dam = @dam,
ref = @ref,
collar = @collar,
deposit = @deposit,
VendorCost = @VendorCost,
SuggRetail = @SuggRetail,
SellingPrice = @SellingPrice,
TotQtyOnHand = @TotQtyOnHand,
soldDate = @soldDate,
soldPrice = @soldPrice,
customerid = @customerid,
status = @status,
fname = @fname,
lname = @lname,
address1 = @address1,
address2 = @address2,
address3 = @address3,
city = @city,
state = @state,
zip = @zip,
phone = @phone,
email = @email,
vintage = @vintage,
is_trans = @is_trans,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			id = @id
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_breeders]    Script Date: 05/12/2016 20:10:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_breeders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_breeders]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_breeders]    Script Date: 05/12/2016 20:10:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_breeders]
(
	@breeder varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_breeders
      (breeder,ReplLastChange)
      VALUES
      (@breeder,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_breeders SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			breeder = @breeder
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_breeds]    Script Date: 05/12/2016 20:12:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_breeds]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_breeds]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_breeds]    Script Date: 05/12/2016 20:12:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_breeds]
(
	@breed varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_breeds
      (breed,ReplLastChange)
      VALUES
      (@breed,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_breeds SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			breed = @breed
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_config]    Script Date: 05/12/2016 20:12:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_config]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_config]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_config]    Script Date: 05/12/2016 20:12:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_config]
(
	@name varchar(50),@value varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_config
      (name,value,ReplLastChange)
      VALUES
      (@name,@value,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_config SET
    			-- No key fields
    			value = @value,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			name = @name
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_medical]    Script Date: 05/12/2016 20:13:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_medical]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_medical]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_medical]    Script Date: 05/12/2016 20:13:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_medical]
(
	@condition varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_medical
      (condition,ReplLastChange)
      VALUES
      (@condition,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_medical SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			condition = @condition
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_medical_rec]    Script Date: 05/12/2016 20:14:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_medical_rec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_medical_rec]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_medical_rec]    Script Date: 05/12/2016 20:14:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_medical_rec]
(
	@code int,@condition varchar(50),@animalid varchar(50),@entrydate varchar(25),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_medical_rec
      (code,condition,animalid,entrydate,ReplLastChange)
      VALUES
      (@code,@condition,@animalid,@entrydate,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_medical_rec SET
    			-- No key fields
    			condition = @condition,
animalid = @animalid,
entrydate = @entrydate,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			code = @code
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_others]    Script Date: 05/12/2016 20:16:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_others]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_others]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_others]    Script Date: 05/12/2016 20:16:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_others]
(
	@id int,@storeid varchar(50),@vintage varchar(15),@sku varchar(25),@type varchar(25),@object text,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_others
      (id,storeid,vintage,sku,type,object,ReplLastChange)
      VALUES
      (@id,@storeid,@vintage,@sku,@type,@object,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_others SET
    			-- No key fields
    			storeid = @storeid,
vintage = @vintage,
sku = @sku,
type = @type,
object = @object,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			id = @id
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccine_lots]    Script Date: 05/12/2016 20:18:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_vaccine_lots]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccine_lots]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccine_lots]    Script Date: 05/12/2016 20:18:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccine_lots]
(
	@code int,@lotnum varchar(50),@vaccine varchar(50),@manu varchar(50),@expire varchar(25),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_vaccine_lots
      (code,lotnum,vaccine,manu,expire,ReplLastChange)
      VALUES
      (@code,@lotnum,@vaccine,@manu,@expire,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_vaccine_lots SET
    			-- No key fields
    			lotnum = @lotnum,
vaccine = @vaccine,
manu = @manu,
expire = @expire,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			code = @code
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccine_manu]    Script Date: 05/13/2016 11:25:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_vaccine_manu]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccine_manu]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccine_manu]    Script Date: 05/13/2016 11:25:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccine_manu]
(
	@manu varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_vaccine_manu
      (manu,ReplLastChange)
      VALUES
      (@manu,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_vaccine_manu SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			manu = @manu
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccine_shots]    Script Date: 05/13/2016 11:26:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_vaccine_shots]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccine_shots]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccine_shots]    Script Date: 05/13/2016 11:26:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccine_shots]
(
	@code int,@lotnum varchar(50),@animalid varchar(50),@dosedate varchar(25),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_vaccine_shots
      (code,lotnum,animalid,dosedate,ReplLastChange)
      VALUES
      (@code,@lotnum,@animalid,@dosedate,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_vaccine_shots SET
    			-- No key fields
    			lotnum = @lotnum,
animalid = @animalid,
dosedate = @dosedate,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			code = @code
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccines]    Script Date: 05/13/2016 11:27:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_pcm_vaccines]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccines]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_pcm_vaccines]    Script Date: 05/13/2016 11:27:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_pcm_vaccines]
(
	@vaccine varchar(50),@type char(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	pcm_vaccines
      (vaccine,type,ReplLastChange)
      VALUES
      (@vaccine,@type,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE pcm_vaccines SET
    			-- No key fields
    			type = @type,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			vaccine = @vaccine
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PessoaTerm]    Script Date: 05/13/2016 11:27:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PessoaTerm]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PessoaTerm]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PessoaTerm]    Script Date: 05/13/2016 11:27:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PessoaTerm]
(
	@IDPessoa int,@DueDateShift int,@Discount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PessoaTerm
      (IDPessoa,DueDateShift,Discount,ReplLastChange)
      VALUES
      (@IDPessoa,@DueDateShift,@Discount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PessoaTerm SET
    			-- No key fields
    			Discount = @Discount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPessoa = @IDPessoa AND
DueDateShift = @DueDateShift
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PessoaValidation]    Script Date: 05/13/2016 11:28:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PessoaValidation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PessoaValidation]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PessoaValidation]    Script Date: 05/13/2016 11:28:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PessoaValidation]
(
	@IDPessoaValidation int,@IDTipoPessoa int,@PessoaField varchar(40),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PessoaValidation
      (IDPessoaValidation,IDTipoPessoa,PessoaField,ReplLastChange)
      VALUES
      (@IDPessoaValidation,@IDTipoPessoa,@PessoaField,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PessoaValidation SET
    			-- No key fields
    			IDTipoPessoa = @IDTipoPessoa,
PessoaField = @PessoaField,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPessoaValidation = @IDPessoaValidation
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Breed]    Script Date: 08/31/2016 13:04:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_Breed]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_Breed]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Breed]    Script Date: 08/31/2016 13:04:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_Breed]
(
	@IDBreed int,@Breed varchar(50),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_Breed
      (IDBreed,Breed,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDBreed,@Breed,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_Breed SET
    			-- No key fields
    			Breed = @Breed,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDBreed = @IDBreed
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Color]    Script Date: 08/31/2016 13:11:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_Color]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_Color]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Color]    Script Date: 08/31/2016 13:11:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_Color]
(
	@IDColor int,@Color varchar(50),@System int,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_Color
      (IDColor,Color,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDColor,@Color,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_Color SET
    			-- No key fields
    			Color = @Color,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDColor = @IDColor
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_ColorSpecies]    Script Date: 08/31/2016 13:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_ColorSpecies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_ColorSpecies]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_ColorSpecies]    Script Date: 08/31/2016 13:12:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_ColorSpecies]
(
	@IDSpecies int,@IDColor int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_ColorSpecies
      (IDSpecies,IDColor,ReplLastChange)
      VALUES
      (@IDSpecies,@IDColor,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_ColorSpecies SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSpecies = @IDSpecies AND
IDColor = @IDColor
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_MedicalCondition]    Script Date: 08/31/2016 13:13:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_MedicalCondition]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_MedicalCondition]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_MedicalCondition]    Script Date: 08/31/2016 13:13:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_MedicalCondition]
(
	@IDMedicalCondition int,@MedicalCondition varchar(50),@SubMedicalCondition varchar(255),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_MedicalCondition
      (IDMedicalCondition,MedicalCondition,SubMedicalCondition,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDMedicalCondition,@MedicalCondition,@SubMedicalCondition,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_MedicalCondition SET
    			-- No key fields
    			MedicalCondition = @MedicalCondition,
SubMedicalCondition = @SubMedicalCondition,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMedicalCondition = @IDMedicalCondition
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_MedicalConditionSpecies]    Script Date: 08/31/2016 13:14:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_MedicalConditionSpecies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_MedicalConditionSpecies]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_MedicalConditionSpecies]    Script Date: 08/31/2016 13:14:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_MedicalConditionSpecies]
(
	@IDMedicalCondition int,@IDSpecies int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_MedicalConditionSpecies
      (IDMedicalCondition,IDSpecies,ReplLastChange)
      VALUES
      (@IDMedicalCondition,@IDSpecies,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_MedicalConditionSpecies SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMedicalCondition = @IDMedicalCondition AND
IDSpecies = @IDSpecies
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Microchip]    Script Date: 08/31/2016 13:15:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_Microchip]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_Microchip]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Microchip]    Script Date: 08/31/2016 13:15:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_Microchip]
(
	@IDMicrochip int,@Microchip varchar(50),@Amount money,@System bit,@Hidden bit,@Desativado bit,@IDModel int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_Microchip
      (IDMicrochip,Microchip,Amount,System,Hidden,Desativado,IDModel,ReplLastChange)
      VALUES
      (@IDMicrochip,@Microchip,@Amount,@System,@Hidden,@Desativado,@IDModel,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_Microchip SET
    			-- No key fields
    			Microchip = @Microchip,
Amount = @Amount,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
IDModel = @IDModel,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMicrochip = @IDMicrochip
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_MicrochipSale]    Script Date: 05/13/2016 11:30:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_MicrochipSale]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_MicrochipSale]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_MicrochipSale]    Script Date: 05/13/2016 11:30:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_MicrochipSale]
(
	@IDPreInventoryMov int,@IDMicrochip int,@IDPetSale int,@MicrochipNum varchar(20),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_MicrochipSale
      (IDPreInventoryMov,IDMicrochip,IDPetSale,MicrochipNum,ReplLastChange)
      VALUES
      (@IDPreInventoryMov,@IDMicrochip,@IDPetSale,@MicrochipNum,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_MicrochipSale SET
    			-- No key fields
    			IDPetSale = @IDPetSale,
MicrochipNum = @MicrochipNum,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPreInventoryMov = @IDPreInventoryMov AND
IDMicrochip = @IDMicrochip
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_PetSale]    Script Date: 05/13/2016 11:30:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_PetSale]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_PetSale]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_PetSale]    Script Date: 05/13/2016 11:30:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_PetSale]
(
	@IDPetSale int,@IDPreInventoryMov int,@IDWarrantyReport int,@IDWarrantyCustomer int,@IDPet int,@InvoiceTotal money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_PetSale
      (IDPetSale,IDPreInventoryMov,IDWarrantyReport,IDWarrantyCustomer,IDPet,InvoiceTotal,ReplLastChange)
      VALUES
      (@IDPetSale,@IDPreInventoryMov,@IDWarrantyReport,@IDWarrantyCustomer,@IDPet,@InvoiceTotal,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_PetSale SET
    			-- No key fields
    			IDPreInventoryMov = @IDPreInventoryMov,
IDWarrantyReport = @IDWarrantyReport,
IDWarrantyCustomer = @IDWarrantyCustomer,
IDPet = @IDPet,
InvoiceTotal = @InvoiceTotal,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPetSale = @IDPetSale
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Porte]    Script Date: 08/31/2016 13:18:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_Porte]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_Porte]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Porte]    Script Date: 08/31/2016 13:18:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_Porte]
(
	@IDPorte int,@Porte varchar(50),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_Porte
      (IDPorte,Porte,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDPorte,@Porte,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_Porte SET
    			-- No key fields
    			Porte = @Porte,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPorte = @IDPorte
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Registry]    Script Date: 08/31/2016 13:19:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_Registry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_Registry]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_Registry]    Script Date: 08/31/2016 13:19:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_Registry]
(
	@IDRegistry int,@Registry varchar(50),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_Registry
      (IDRegistry,Registry,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDRegistry,@Registry,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_Registry SET
    			-- No key fields
    			Registry = @Registry,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRegistry = @IDRegistry
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_RegistrySale]    Script Date: 05/13/2016 11:31:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_RegistrySale]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_RegistrySale]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_RegistrySale]    Script Date: 05/13/2016 11:31:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_RegistrySale]
(
	@IDPreInventoryMov int,@IDRegistry int,@IDPetSale int,@RegistrationNum varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_RegistrySale
      (IDPreInventoryMov,IDRegistry,IDPetSale,RegistrationNum,ReplLastChange)
      VALUES
      (@IDPreInventoryMov,@IDRegistry,@IDPetSale,@RegistrationNum,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_RegistrySale SET
    			-- No key fields
    			IDPetSale = @IDPetSale,
RegistrationNum = @RegistrationNum,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPreInventoryMov = @IDPreInventoryMov AND
IDRegistry = @IDRegistry
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_RegistrySpecies]    Script Date: 08/31/2016 13:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_RegistrySpecies]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_RegistrySpecies]
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_RegistrySpecies]    Script Date: 08/31/2016 13:21:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_RegistrySpecies]
(
	@IDRegistry int,@IDSpecies int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_RegistrySpecies
      (IDRegistry,IDSpecies,ReplLastChange)
      VALUES
      (@IDRegistry,@IDSpecies,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_RegistrySpecies SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRegistry = @IDRegistry AND
IDSpecies = @IDSpecies
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_WarrantyReport]    Script Date: 05/13/2016 11:32:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pet_WarrantyReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pet_WarrantyReport]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pet_WarrantyReport]    Script Date: 05/13/2016 11:32:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pet_WarrantyReport]
(
	@IDWarrantyReport int,@IDSpecies int,@ReportName varchar(30),@ReportDate datetime,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pet_WarrantyReport
      (IDWarrantyReport,IDSpecies,ReportName,ReportDate,ReplLastChange)
      VALUES
      (@IDWarrantyReport,@IDSpecies,@ReportName,@ReportDate,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pet_WarrantyReport SET
    			-- No key fields
    			IDSpecies = @IDSpecies,
ReportName = @ReportName,
ReportDate = @ReportDate,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDWarrantyReport = @IDWarrantyReport
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PrePurchaseSerial]    Script Date: 05/13/2016 11:33:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PrePurchaseSerial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PrePurchaseSerial]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PrePurchaseSerial]    Script Date: 05/13/2016 11:33:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PrePurchaseSerial]
(
	@IDPrePurchaseMov int,@SerialNumber char(30),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PrePurchaseSerial
      (IDPrePurchaseMov,SerialNumber,ReplLastChange)
      VALUES
      (@IDPrePurchaseMov,@SerialNumber,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PrePurchaseSerial SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPrePurchaseMov = @IDPrePurchaseMov AND
SerialNumber = @SerialNumber
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PreSerialMov]    Script Date: 05/13/2016 11:34:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PreSerialMov]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PreSerialMov]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PreSerialMov]    Script Date: 05/13/2016 11:34:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PreSerialMov]
(
	@PreInventoryMovID int,@SerialNumber char(30),@IdentificationNumber varchar(30),@processor char(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PreSerialMov
      (PreInventoryMovID,SerialNumber,IdentificationNumber,processor,ReplLastChange)
      VALUES
      (@PreInventoryMovID,@SerialNumber,@IdentificationNumber,@processor,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PreSerialMov SET
    			-- No key fields
    			IdentificationNumber = @IdentificationNumber,
processor = @processor,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			PreInventoryMovID = @PreInventoryMovID AND
SerialNumber = @SerialNumber
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PT_GlobalSetting]    Script Date: 05/13/2016 11:37:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PT_GlobalSetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PT_GlobalSetting]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PT_GlobalSetting]    Script Date: 05/13/2016 11:37:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PT_GlobalSetting]
(
	@Id int,@IdPetCategory int,@IdServiceCategory int,@IdKitCategory int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PT_GlobalSetting
      (Id,IdPetCategory,IdServiceCategory,IdKitCategory,ReplLastChange)
      VALUES
      (@Id,@IdPetCategory,@IdServiceCategory,@IdKitCategory,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PT_GlobalSetting SET
    			-- No key fields
    			IdPetCategory = @IdPetCategory,
IdServiceCategory = @IdServiceCategory,
IdKitCategory = @IdKitCategory,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Id = @Id
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PT_GlobalSettingDetail]    Script Date: 05/13/2016 11:38:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PT_GlobalSettingDetail]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PT_GlobalSettingDetail]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PT_GlobalSettingDetail]    Script Date: 05/13/2016 11:38:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PT_GlobalSettingDetail]
(
	@Id int,@GlobalSettingID int,@ServiceMap varchar(30),@IdModel int,@RequireOnSale bit,@price money,@description varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PT_GlobalSettingDetail
      (Id,GlobalSettingID,ServiceMap,IdModel,RequireOnSale,price,description,ReplLastChange)
      VALUES
      (@Id,@GlobalSettingID,@ServiceMap,@IdModel,@RequireOnSale,@price,@description,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PT_GlobalSettingDetail SET
    			-- No key fields
    			GlobalSettingID = @GlobalSettingID,
ServiceMap = @ServiceMap,
IdModel = @IdModel,
RequireOnSale = @RequireOnSale,
price = @price,
description = @description,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Id = @Id
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PT_LocalSetting]    Script Date: 05/13/2016 11:39:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_PT_LocalSetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_PT_LocalSetting]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PT_LocalSetting]    Script Date: 05/13/2016 11:39:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_PT_LocalSetting]
(
	@Id int,@PathToSaleExec varchar(100),@PuppyInstalled bit,@PathToAvail varchar(100),@FrequencyPetAvail varchar(30),@MacAddress varchar(30),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PT_LocalSetting
      (Id,PathToSaleExec,PuppyInstalled,PathToAvail,FrequencyPetAvail,MacAddress,ReplLastChange)
      VALUES
      (@Id,@PathToSaleExec,@PuppyInstalled,@PathToAvail,@FrequencyPetAvail,@MacAddress,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PT_LocalSetting SET
    			-- No key fields
    			PathToSaleExec = @PathToSaleExec,
PuppyInstalled = @PuppyInstalled,
PathToAvail = @PathToAvail,
FrequencyPetAvail = @FrequencyPetAvail,
MacAddress = @MacAddress,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Id = @Id
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_Purchase_AddPurchaseItemTax]    Script Date: 05/18/2016 15:50:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Purchase_AddPurchaseItemTax]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Purchase_AddPurchaseItemTax]
GO


/****** Object:  StoredProcedure [dbo].[sp_Purchase_AddPurchaseItemTax]    Script Date: 05/18/2016 15:50:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Purchase_AddPurchaseItemTax]
		(
		@IDVendor      		int,
		@IDPurchaseItem	int,
		@IDPurchase		int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Pur_PurchaseItemTax

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Pur_PurchaseItemTax


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	10 Dec  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de PurchaseItem
DECLARE @IDPurchaseItemTax		int 
DECLARE @IDVendorTax  		int
DECLARE @IDTaxCategory  		int

SET @ErrorLevel = 0

BEGIN TRAN


/*****************************************************************************************
	Inclusão dos impostos no item
******************************************************************************************/

--Declaração do Cursor de PurchaseItem

DECLARE PurchaseItem_Cursor CURSOR FOR

	SELECT
		VT.IDVendorTax,
		VT.IDTaxCategory
	FROM
		VendorTax VT (NOLOCK) 
	WHERE
		VT.IDPessoa = @IDVendor


OPEN PurchaseItem_Cursor 

--Inicialização de PurchaseItem_Cursor
FETCH NEXT FROM PurchaseItem_Cursor INTO
	@IDVendorTax,
	@IDTaxCategory

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseItemTax.IDPurchaseItemTax', @IDPurchaseItemTax OUTPUT

	INSERT dbo.Pur_PurchaseItemTax
	(
	IDPurchaseItemTax,
	IDPurchaseItem,
	IDVendorTax,
	TaxValue,
	TaxPercentage,
	IDPurchase
	)
	SELECT
		@IDPurchaseItemTax,
		@IDPurchaseItem,
		@IDVendorTax,
		0,
	 	TG.Tax,
		@IDPurchase
	FROM
		TaxCategory TG (NOLOCK) 
	WHERE
		TG.IDTaxCategory = @IDTaxCategory

	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE PurchaseItem_Cursor
		DEALLOCATE PurchaseItem_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM PurchaseItem_Cursor INTO
		@IDVendorTax,
		@IDTaxCategory

END
--fechamento do cursor
CLOSE PurchaseItem_Cursor

--Destruição do cursor
DEALLOCATE PurchaseItem_Cursor


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AddPurchaseItemTax', @ErrorLevelStr

	RETURN @ErrorLevel
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseItemTax]    Script Date: 05/13/2016 11:40:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pur_PurchaseItemTax]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseItemTax]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseItemTax]    Script Date: 05/13/2016 11:40:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseItemTax]
(
	@IDPurchaseItemTax int,@IDPurchaseItem int,@IDVendorTax int,@TaxValue money,@TaxPercentage money,@IDPurchase int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pur_PurchaseItemTax
      (IDPurchaseItemTax,IDPurchaseItem,IDVendorTax,TaxValue,TaxPercentage,IDPurchase,ReplLastChange)
      VALUES
      (@IDPurchaseItemTax,@IDPurchaseItem,@IDVendorTax,@TaxValue,@TaxPercentage,@IDPurchase,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pur_PurchaseItemTax SET
    			-- No key fields
    			IDPurchaseItem = @IDPurchaseItem,
IDVendorTax = @IDVendorTax,
TaxValue = @TaxValue,
TaxPercentage = @TaxPercentage,
IDPurchase = @IDPurchase,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPurchaseItemTax = @IDPurchaseItemTax
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseItemSerial]    Script Date: 05/13/2016 11:41:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pur_PurchaseItemSerial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseItemSerial]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseItemSerial]    Script Date: 05/13/2016 11:41:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseItemSerial]
(
	@IDPurchaseItemSerial int,@IDPurchaseItem int,@SerialNumber varchar(30),@IDPurchase int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pur_PurchaseItemSerial
      (IDPurchaseItemSerial,IDPurchaseItem,SerialNumber,IDPurchase,ReplLastChange)
      VALUES
      (@IDPurchaseItemSerial,@IDPurchaseItem,@SerialNumber,@IDPurchase,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pur_PurchaseItemSerial SET
    			-- No key fields
    			IDPurchaseItem = @IDPurchaseItem,
SerialNumber = @SerialNumber,
IDPurchase = @IDPurchase,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPurchaseItemSerial = @IDPurchaseItemSerial
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseItemTaxRet]    Script Date: 05/13/2016 11:42:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pur_PurchaseItemTaxRet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseItemTaxRet]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseItemTaxRet]    Script Date: 05/13/2016 11:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseItemTaxRet]
(
	@IDPurchaseItemTaxRet int,@IDPurchaseItem int,@IDVendorTax int,@TaxValue money,@TaxPercentage money,@IDPurchase int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pur_PurchaseItemTaxRet
      (IDPurchaseItemTaxRet,IDPurchaseItem,IDVendorTax,TaxValue,TaxPercentage,IDPurchase,ReplLastChange)
      VALUES
      (@IDPurchaseItemTaxRet,@IDPurchaseItem,@IDVendorTax,@TaxValue,@TaxPercentage,@IDPurchase,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pur_PurchaseItemTaxRet SET
    			-- No key fields
    			IDPurchaseItem = @IDPurchaseItem,
IDVendorTax = @IDVendorTax,
TaxValue = @TaxValue,
TaxPercentage = @TaxPercentage,
IDPurchase = @IDPurchase,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPurchaseItemTaxRet = @IDPurchaseItemTaxRet
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseTerm]    Script Date: 05/19/2016 03:12:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pur_PurchaseTerm]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseTerm]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseTerm]    Script Date: 05/19/2016 03:12:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseTerm]
(
	@IDPurchase int,@DueDateShift int,@Discount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pur_PurchaseTerm
      (IDPurchase,DueDateShift,Discount,ReplLastChange)
      VALUES
      (@IDPurchase,@DueDateShift,@Discount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pur_PurchaseTerm SET
    			-- No key fields
    			Discount = @Discount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPurchase = @IDPurchase AND
DueDateShift = @DueDateShift
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseVerify]    Script Date: 05/13/2016 11:43:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Pur_PurchaseVerify]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseVerify]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Pur_PurchaseVerify]    Script Date: 05/13/2016 11:43:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Pur_PurchaseVerify]
(
	@IDPurchaseVerify int,@IDPurchase int,@IDUser int,@IDModel int,@IDBarcode varchar(20),@QtyReceiving decimal,@QtyCounted decimal,@EnterDate datetime,@ScanDate datetime,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Pur_PurchaseVerify
      (IDPurchaseVerify,IDPurchase,IDUser,IDModel,IDBarcode,QtyReceiving,QtyCounted,EnterDate,ScanDate,ReplLastChange)
      VALUES
      (@IDPurchaseVerify,@IDPurchase,@IDUser,@IDModel,@IDBarcode,@QtyReceiving,@QtyCounted,@EnterDate,@ScanDate,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Pur_PurchaseVerify SET
    			-- No key fields
    			IDPurchase = @IDPurchase,
IDUser = @IDUser,
IDModel = @IDModel,
IDBarcode = @IDBarcode,
QtyReceiving = @QtyReceiving,
QtyCounted = @QtyCounted,
EnterDate = @EnterDate,
ScanDate = @ScanDate,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPurchaseVerify = @IDPurchaseVerify
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Request]    Script Date: 05/18/2016 15:56:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Request]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Request]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Request]    Script Date: 05/18/2016 15:56:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Request]
(
	@IDRequest int,@ModelID int,@UserID int,@StoreID int,@IDPreInventoryMov int,@IDCotacao int,@Type char(1),@DateRequest smalldatetime,@Description varchar(50),@Cotado bit,@DelayDate smalldatetime,@QtyReq decimal,@QtyOrdered decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Request
      (IDRequest,ModelID,UserID,StoreID,IDPreInventoryMov,IDCotacao,Type,DateRequest,Description,Cotado,DelayDate,QtyReq,QtyOrdered,ReplLastChange)
      VALUES
      (@IDRequest,@ModelID,@UserID,@StoreID,@IDPreInventoryMov,@IDCotacao,@Type,@DateRequest,@Description,@Cotado,@DelayDate,@QtyReq,@QtyOrdered,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Request SET
    			-- No key fields
    			ModelID = @ModelID,
UserID = @UserID,
StoreID = @StoreID,
IDPreInventoryMov = @IDPreInventoryMov,
IDCotacao = @IDCotacao,
Type = @Type,
DateRequest = @DateRequest,
Description = @Description,
Cotado = @Cotado,
DelayDate = @DelayDate,
QtyReq = @QtyReq,
QtyOrdered = @QtyOrdered,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRequest = @IDRequest
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_RoundingTable]    Script Date: 05/13/2016 11:44:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_RoundingTable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_RoundingTable]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_RoundingTable]    Script Date: 05/13/2016 11:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_RoundingTable]
(
	@IDRoundingTable int,@RoundingTable varchar(30),@System bit,@Hidden bit,@Desativado int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	RoundingTable
      (IDRoundingTable,RoundingTable,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDRoundingTable,@RoundingTable,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE RoundingTable SET
    			-- No key fields
    			RoundingTable = @RoundingTable,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRoundingTable = @IDRoundingTable
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_RoundingTableRange]    Script Date: 05/13/2016 11:45:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_RoundingTableRange]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_RoundingTableRange]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_RoundingTableRange]    Script Date: 05/13/2016 11:45:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_RoundingTableRange]
(
	@IDRoundingTableRange int,@MinValue money,@IDRoundingTable int,@RoundType int,@MaxValue money,@RoundValues varchar(100),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	RoundingTableRange
      (IDRoundingTableRange,MinValue,IDRoundingTable,RoundType,MaxValue,RoundValues,ReplLastChange)
      VALUES
      (@IDRoundingTableRange,@MinValue,@IDRoundingTable,@RoundType,@MaxValue,@RoundValues,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE RoundingTableRange SET
    			-- No key fields
    			MinValue = @MinValue,
IDRoundingTable = @IDRoundingTable,
RoundType = @RoundType,
MaxValue = @MaxValue,
RoundValues = @RoundValues,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRoundingTableRange = @IDRoundingTableRange
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_Discount]    Script Date: 05/13/2016 11:47:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_Discount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_Discount]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_Discount]    Script Date: 05/13/2016 11:47:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_Discount]
(
	@IDDiscount int,@IDPreSale int,@IDPreInventoryMov int,@Discount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_Discount
      (IDDiscount,IDPreSale,IDPreInventoryMov,Discount,ReplLastChange)
      VALUES
      (@IDDiscount,@IDPreSale,@IDPreInventoryMov,@Discount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_Discount SET
    			-- No key fields
    			IDPreSale = @IDPreSale,
IDPreInventoryMov = @IDPreInventoryMov,
Discount = @Discount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDiscount = @IDDiscount
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_DrawerKickLog]    Script Date: 05/13/2016 11:50:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_DrawerKickLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_DrawerKickLog]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_DrawerKickLog]    Script Date: 05/13/2016 11:50:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_DrawerKickLog]
(
	@IDDrawerKickLog int,@IDUser int,@IDCashRegister int,@MovDate datetime,@Type int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_DrawerKickLog
      (IDDrawerKickLog,IDUser,IDCashRegister,MovDate,Type,ReplLastChange)
      VALUES
      (@IDDrawerKickLog,@IDUser,@IDCashRegister,@MovDate,@Type,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_DrawerKickLog SET
    			-- No key fields
    			IDUser = @IDUser,
IDCashRegister = @IDCashRegister,
MovDate = @MovDate,
Type = @Type,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDDrawerKickLog = @IDDrawerKickLog
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_FrequentPromo]    Script Date: 05/13/2016 11:51:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_FrequentPromo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_FrequentPromo]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_FrequentPromo]    Script Date: 05/13/2016 11:51:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_FrequentPromo]
(
	@IDFrequentPromo int,@IDPessoa int,@IDModel int,@Qty decimal,@IsUsed bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_FrequentPromo
      (IDFrequentPromo,IDPessoa,IDModel,Qty,IsUsed,ReplLastChange)
      VALUES
      (@IDFrequentPromo,@IDPessoa,@IDModel,@Qty,@IsUsed,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_FrequentPromo SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
IDModel = @IDModel,
Qty = @Qty,
IsUsed = @IsUsed,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDFrequentPromo = @IDFrequentPromo
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_InvoiceShipping]    Script Date: 05/13/2016 11:52:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_InvoiceShipping]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_InvoiceShipping]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_InvoiceShipping]    Script Date: 05/13/2016 11:52:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_InvoiceShipping]
(
	@IDInvoiceShipping int,@IDPreSale int,@ShipDate datetime,@Tracking varchar(255),@IDDeliverType int,@AddressName varchar(30),@Address varchar(50),@City varchar(20),@ZIP varchar(10),@IDEstado char(3),@IDPais int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_InvoiceShipping
      (IDInvoiceShipping,IDPreSale,ShipDate,Tracking,IDDeliverType,AddressName,Address,City,ZIP,IDEstado,IDPais,ReplLastChange)
      VALUES
      (@IDInvoiceShipping,@IDPreSale,@ShipDate,@Tracking,@IDDeliverType,@AddressName,@Address,@City,@ZIP,@IDEstado,@IDPais,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_InvoiceShipping SET
    			-- No key fields
    			IDPreSale = @IDPreSale,
ShipDate = @ShipDate,
Tracking = @Tracking,
IDDeliverType = @IDDeliverType,
AddressName = @AddressName,
Address = @Address,
City = @City,
ZIP = @ZIP,
IDEstado = @IDEstado,
IDPais = @IDPais,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInvoiceShipping = @IDInvoiceShipping
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_NotasCanceladas]    Script Date: 05/13/2016 11:53:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_NotasCanceladas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_NotasCanceladas]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_NotasCanceladas]    Script Date: 05/13/2016 11:53:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_NotasCanceladas]
(
	@IDNotasCanceladas int,@IDPessoa int,@IDUser int,@Cliente varchar(40),@CPFCGC varchar(20),@COO int,@CCF int,@DataNota datetime,@SubTotal money,@Desconto money,@Acrescimo int,@TipoAcrescimo char(1),@TipoDesconto char(1),@IDCashRegMov int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_NotasCanceladas
      (IDNotasCanceladas,IDPessoa,IDUser,Cliente,CPFCGC,COO,CCF,DataNota,SubTotal,Desconto,Acrescimo,TipoAcrescimo,TipoDesconto,IDCashRegMov,ReplLastChange)
      VALUES
      (@IDNotasCanceladas,@IDPessoa,@IDUser,@Cliente,@CPFCGC,@COO,@CCF,@DataNota,@SubTotal,@Desconto,@Acrescimo,@TipoAcrescimo,@TipoDesconto,@IDCashRegMov,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_NotasCanceladas SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
IDUser = @IDUser,
Cliente = @Cliente,
CPFCGC = @CPFCGC,
COO = @COO,
CCF = @CCF,
DataNota = @DataNota,
SubTotal = @SubTotal,
Desconto = @Desconto,
Acrescimo = @Acrescimo,
TipoAcrescimo = @TipoAcrescimo,
TipoDesconto = @TipoDesconto,
IDCashRegMov = @IDCashRegMov,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDNotasCanceladas = @IDNotasCanceladas
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PaymentCondition]    Script Date: 05/13/2016 11:55:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_PaymentCondition]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_PaymentCondition]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PaymentCondition]    Script Date: 05/13/2016 11:55:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_PaymentCondition]
(
	@IDPaymentCondition int,@IDEstimated int,@IDPreSale int,@IDMeioPag int,@Amount money,@OBS varchar(100),@EstimetedDate datetime,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_PaymentCondition
      (IDPaymentCondition,IDEstimated,IDPreSale,IDMeioPag,Amount,OBS,EstimetedDate,ReplLastChange)
      VALUES
      (@IDPaymentCondition,@IDEstimated,@IDPreSale,@IDMeioPag,@Amount,@OBS,@EstimetedDate,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_PaymentCondition SET
    			-- No key fields
    			IDEstimated = @IDEstimated,
IDPreSale = @IDPreSale,
IDMeioPag = @IDMeioPag,
Amount = @Amount,
OBS = @OBS,
EstimetedDate = @EstimetedDate,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPaymentCondition = @IDPaymentCondition
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PaymentDiscount]    Script Date: 05/13/2016 11:55:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_PaymentDiscount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_PaymentDiscount]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PaymentDiscount]    Script Date: 05/13/2016 11:55:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_PaymentDiscount]
(
	@IDPaymentDiscount int,@IDMeioPag int,@DiscountPercent money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_PaymentDiscount
      (IDPaymentDiscount,IDMeioPag,DiscountPercent,ReplLastChange)
      VALUES
      (@IDPaymentDiscount,@IDMeioPag,@DiscountPercent,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_PaymentDiscount SET
    			-- No key fields
    			IDMeioPag = @IDMeioPag,
DiscountPercent = @DiscountPercent,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPaymentDiscount = @IDPaymentDiscount
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_Promo]    Script Date: 05/13/2016 12:30:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_Promo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_Promo]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_Promo]    Script Date: 05/13/2016 12:30:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_Promo]
(
	@IDPromo int,@Barcode varchar(20),@Promo varchar(35),@PromoType int,@QtyFrequent float,@StartDate datetime,@EndDate datetime,@DaysOfWeek varchar(14),@DiscountType int,@DiscountValue float,@QtyPromoItem float,@System bit,@Hidden bit,@Desativado bit,@IDStore int,@FlatPromo bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_Promo
      (IDPromo,Barcode,Promo,PromoType,QtyFrequent,StartDate,EndDate,DaysOfWeek,DiscountType,DiscountValue,QtyPromoItem,System,Hidden,Desativado,IDStore,FlatPromo,ReplLastChange)
      VALUES
      (@IDPromo,@Barcode,@Promo,@PromoType,@QtyFrequent,@StartDate,@EndDate,@DaysOfWeek,@DiscountType,@DiscountValue,@QtyPromoItem,@System,@Hidden,@Desativado,@IDStore,@FlatPromo,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_Promo SET
    			-- No key fields
    			Barcode = @Barcode,
Promo = @Promo,
PromoType = @PromoType,
QtyFrequent = @QtyFrequent,
StartDate = @StartDate,
EndDate = @EndDate,
DaysOfWeek = @DaysOfWeek,
DiscountType = @DiscountType,
DiscountValue = @DiscountValue,
QtyPromoItem = @QtyPromoItem,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
IDStore = @IDStore,
FlatPromo = @FlatPromo,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPromo = @IDPromo
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PromoItem]    Script Date: 05/13/2016 12:31:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_PromoItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_PromoItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PromoItem]    Script Date: 05/13/2016 12:31:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_PromoItem]
(
	@IDPromoItem int,@IDModel int,@IDPromo int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_PromoItem
      (IDPromoItem,IDModel,IDPromo,ReplLastChange)
      VALUES
      (@IDPromoItem,@IDModel,@IDPromo,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_PromoItem SET
    			-- No key fields
    			IDModel = @IDModel,
IDPromo = @IDPromo,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPromoItem = @IDPromoItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PromoLoyaltyCustomer]    Script Date: 05/13/2016 12:32:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_PromoLoyaltyCustomer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_PromoLoyaltyCustomer]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PromoLoyaltyCustomer]    Script Date: 05/13/2016 12:32:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_PromoLoyaltyCustomer]
(
	@IDPromo int,@IDTipoPessoa int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_PromoLoyaltyCustomer
      (IDPromo,IDTipoPessoa,ReplLastChange)
      VALUES
      (@IDPromo,@IDTipoPessoa,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_PromoLoyaltyCustomer SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPromo = @IDPromo AND
IDTipoPessoa = @IDTipoPessoa
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PromoPrizeItem]    Script Date: 05/13/2016 12:33:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_PromoPrizeItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_PromoPrizeItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_PromoPrizeItem]    Script Date: 05/13/2016 12:33:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_PromoPrizeItem]
(
	@IDPromoPrizeItem int,@IDModel int,@IDPromoItem int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_PromoPrizeItem
      (IDPromoPrizeItem,IDModel,IDPromoItem,ReplLastChange)
      VALUES
      (@IDPromoPrizeItem,@IDModel,@IDPromoItem,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_PromoPrizeItem SET
    			-- No key fields
    			IDModel = @IDModel,
IDPromoItem = @IDPromoItem,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPromoPrizeItem = @IDPromoPrizeItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateCalendar]    Script Date: 04/27/2016 18:56:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateCalendar]    Script Date: 05/13/2016 12:33:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_RebateCalendar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateCalendar]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateCalendar]    Script Date: 05/13/2016 12:33:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateCalendar]
(
	@IDRebateCalendar int,@IDStore int,@Description varchar(30),@DaysOfWeek varchar(14),@DiscountPerc float,@StartDate datetime,@EndDate datetime,@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_RebateCalendar
      (IDRebateCalendar,IDStore,Description,DaysOfWeek,DiscountPerc,StartDate,EndDate,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDRebateCalendar,@IDStore,@Description,@DaysOfWeek,@DiscountPerc,@StartDate,@EndDate,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_RebateCalendar SET
    			-- No key fields
    			IDStore = @IDStore,
Description = @Description,
DaysOfWeek = @DaysOfWeek,
DiscountPerc = @DiscountPerc,
StartDate = @StartDate,
EndDate = @EndDate,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRebateCalendar = @IDRebateCalendar
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateDiscount]    Script Date: 05/13/2016 12:34:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_RebateDiscount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateDiscount]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateDiscount]    Script Date: 05/13/2016 12:34:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateDiscount]
(
	@IDPreSaleCreated int,@DiscountValue money,@ValidFromDate datetime,@ExpirationDate datetime,@IDPreSaleUsed int,@BonusCode varchar(20),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_RebateDiscount
      (IDPreSaleCreated,DiscountValue,ValidFromDate,ExpirationDate,IDPreSaleUsed,BonusCode,ReplLastChange)
      VALUES
      (@IDPreSaleCreated,@DiscountValue,@ValidFromDate,@ExpirationDate,@IDPreSaleUsed,@BonusCode,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_RebateDiscount SET
    			-- No key fields
    			DiscountValue = @DiscountValue,
ValidFromDate = @ValidFromDate,
ExpirationDate = @ExpirationDate,
IDPreSaleUsed = @IDPreSaleUsed,
BonusCode = @BonusCode,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPreSaleCreated = @IDPreSaleCreated
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateItem]    Script Date: 05/13/2016 12:35:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_RebateItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateItem]    Script Date: 05/13/2016 12:35:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateItem]
(
	@IDRebateItem int,@IDModel int,@IDStore int,@DiscountPerc float,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_RebateItem
      (IDRebateItem,IDModel,IDStore,DiscountPerc,ReplLastChange)
      VALUES
      (@IDRebateItem,@IDModel,@IDStore,@DiscountPerc,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_RebateItem SET
    			-- No key fields
    			IDModel = @IDModel,
IDStore = @IDStore,
DiscountPerc = @DiscountPerc,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRebateItem = @IDRebateItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateItemCalendar]    Script Date: 05/13/2016 12:36:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_RebateItemCalendar]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateItemCalendar]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RebateItemCalendar]    Script Date: 05/13/2016 12:36:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_RebateItemCalendar]
(
	@IDRebateItem int,@IDRebateCalendar int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_RebateItemCalendar
      (IDRebateItem,IDRebateCalendar,ReplLastChange)
      VALUES
      (@IDRebateItem,@IDRebateCalendar,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_RebateItemCalendar SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRebateItem = @IDRebateItem AND
IDRebateCalendar = @IDRebateCalendar
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_ReducaoZ]    Script Date: 05/13/2016 12:37:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_ReducaoZ]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_ReducaoZ]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_ReducaoZ]    Script Date: 05/13/2016 12:37:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_ReducaoZ]
(
	@IDReducaoZ int,@MovDate datetime,@NumeroSerie varchar(20),@NumeroLoja int,@NumeroECF int,@NumReducaoZ int,@COOInicial int,@COOFinal int,@NumCancelamentos int,@ValCancelamentos money,@ValDescontos money,@GTInicial money,@GTFinal money,@SubstituicaoTrib money,@Isencao money,@NaoTributavel money,@MFAdicional char(1),@TipoECF varchar(20),@MarcaECF varchar(20),@ModeloECF varchar(20),@VersaoSBECF varchar(10),@DataInstalacaoSBECF datetime,@ContadorReducaoZ int,@ContadorOrdemOperacao int,@ContadorReinicioOperacao int,@NumeroUsuarioECF int,@IncideISSQN bit,@DataEmissao datetime,@IDCashRegister int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_ReducaoZ
      (IDReducaoZ,MovDate,NumeroSerie,NumeroLoja,NumeroECF,NumReducaoZ,COOInicial,COOFinal,NumCancelamentos,ValCancelamentos,ValDescontos,GTInicial,GTFinal,SubstituicaoTrib,Isencao,NaoTributavel,MFAdicional,TipoECF,MarcaECF,ModeloECF,VersaoSBECF,DataInstalacaoSBECF,ContadorReducaoZ,ContadorOrdemOperacao,ContadorReinicioOperacao,NumeroUsuarioECF,IncideISSQN,DataEmissao,IDCashRegister,ReplLastChange)
      VALUES
      (@IDReducaoZ,@MovDate,@NumeroSerie,@NumeroLoja,@NumeroECF,@NumReducaoZ,@COOInicial,@COOFinal,@NumCancelamentos,@ValCancelamentos,@ValDescontos,@GTInicial,@GTFinal,@SubstituicaoTrib,@Isencao,@NaoTributavel,@MFAdicional,@TipoECF,@MarcaECF,@ModeloECF,@VersaoSBECF,@DataInstalacaoSBECF,@ContadorReducaoZ,@ContadorOrdemOperacao,@ContadorReinicioOperacao,@NumeroUsuarioECF,@IncideISSQN,@DataEmissao,@IDCashRegister,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_ReducaoZ SET
    			-- No key fields
    			MovDate = @MovDate,
NumeroSerie = @NumeroSerie,
NumeroLoja = @NumeroLoja,
NumeroECF = @NumeroECF,
NumReducaoZ = @NumReducaoZ,
COOInicial = @COOInicial,
COOFinal = @COOFinal,
NumCancelamentos = @NumCancelamentos,
ValCancelamentos = @ValCancelamentos,
ValDescontos = @ValDescontos,
GTInicial = @GTInicial,
GTFinal = @GTFinal,
SubstituicaoTrib = @SubstituicaoTrib,
Isencao = @Isencao,
NaoTributavel = @NaoTributavel,
MFAdicional = @MFAdicional,
TipoECF = @TipoECF,
MarcaECF = @MarcaECF,
ModeloECF = @ModeloECF,
VersaoSBECF = @VersaoSBECF,
DataInstalacaoSBECF = @DataInstalacaoSBECF,
ContadorReducaoZ = @ContadorReducaoZ,
ContadorOrdemOperacao = @ContadorOrdemOperacao,
ContadorReinicioOperacao = @ContadorReinicioOperacao,
NumeroUsuarioECF = @NumeroUsuarioECF,
IncideISSQN = @IncideISSQN,
DataEmissao = @DataEmissao,
IDCashRegister = @IDCashRegister,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDReducaoZ = @IDReducaoZ
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RemovedItem]    Script Date: 05/13/2016 12:38:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_RemovedItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_RemovedItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_RemovedItem]    Script Date: 05/13/2016 12:38:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_RemovedItem]
(
	@IDRemovedItem int,@IDCashRegister int,@IDModel int,@IDStore int,@IDDepartment int,@IDUserAuto int,@IDPessoa int,@IDUser int,@MovDate datetime,@Qty money,@SalePrice money,@CostPrice money,@Discount money,@SaleCode varchar(20),@PosicaoItem int,@Acrescimo money,@TotalizadorParcial varchar(10),@IDNotasCanceladas int,@IDPreSale int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_RemovedItem
      (IDRemovedItem,IDCashRegister,IDModel,IDStore,IDDepartment,IDUserAuto,IDPessoa,IDUser,MovDate,Qty,SalePrice,CostPrice,Discount,SaleCode,PosicaoItem,Acrescimo,TotalizadorParcial,IDNotasCanceladas,IDPreSale,ReplLastChange)
      VALUES
      (@IDRemovedItem,@IDCashRegister,@IDModel,@IDStore,@IDDepartment,@IDUserAuto,@IDPessoa,@IDUser,@MovDate,@Qty,@SalePrice,@CostPrice,@Discount,@SaleCode,@PosicaoItem,@Acrescimo,@TotalizadorParcial,@IDNotasCanceladas,@IDPreSale,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_RemovedItem SET
    			-- No key fields
    			IDCashRegister = @IDCashRegister,
IDModel = @IDModel,
IDStore = @IDStore,
IDDepartment = @IDDepartment,
IDUserAuto = @IDUserAuto,
IDPessoa = @IDPessoa,
IDUser = @IDUser,
MovDate = @MovDate,
Qty = @Qty,
SalePrice = @SalePrice,
CostPrice = @CostPrice,
Discount = @Discount,
SaleCode = @SaleCode,
PosicaoItem = @PosicaoItem,
Acrescimo = @Acrescimo,
TotalizadorParcial = @TotalizadorParcial,
IDNotasCanceladas = @IDNotasCanceladas,
IDPreSale = @IDPreSale,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRemovedItem = @IDRemovedItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_StoreAccount]    Script Date: 05/13/2016 12:39:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_StoreAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_StoreAccount]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_StoreAccount]    Script Date: 05/13/2016 12:39:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_StoreAccount]
(
	@IDStoreAccount int,@IDStoreAccountUsed int,@IDPessoa int,@IDUser int,@IDStore int,@IDLancamento int,@TransactionDate datetime,@Amount money,@IsUsed bit,@IsReceiving bit,@Verify bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_StoreAccount
      (IDStoreAccount,IDStoreAccountUsed,IDPessoa,IDUser,IDStore,IDLancamento,TransactionDate,Amount,IsUsed,IsReceiving,Verify,ReplLastChange)
      VALUES
      (@IDStoreAccount,@IDStoreAccountUsed,@IDPessoa,@IDUser,@IDStore,@IDLancamento,@TransactionDate,@Amount,@IsUsed,@IsReceiving,@Verify,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_StoreAccount SET
    			-- No key fields
    			IDStoreAccountUsed = @IDStoreAccountUsed,
IDPessoa = @IDPessoa,
IDUser = @IDUser,
IDStore = @IDStore,
IDLancamento = @IDLancamento,
TransactionDate = @TransactionDate,
Amount = @Amount,
IsUsed = @IsUsed,
IsReceiving = @IsReceiving,
Verify = @Verify,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDStoreAccount = @IDStoreAccount
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_StoreAccountLimetLog]    Script Date: 05/13/2016 12:39:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_StoreAccountLimetLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_StoreAccountLimetLog]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_StoreAccountLimetLog]    Script Date: 05/13/2016 12:39:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_StoreAccountLimetLog]
(
	@IDStoreAccountLimtLog int,@IDPessoa int,@IDUser int,@LogDate datetime,@Amount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_StoreAccountLimetLog
      (IDStoreAccountLimtLog,IDPessoa,IDUser,LogDate,Amount,ReplLastChange)
      VALUES
      (@IDStoreAccountLimtLog,@IDPessoa,@IDUser,@LogDate,@Amount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_StoreAccountLimetLog SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
IDUser = @IDUser,
LogDate = @LogDate,
Amount = @Amount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDStoreAccountLimtLog = @IDStoreAccountLimtLog
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TotalizadorParcial]    Script Date: 05/13/2016 12:40:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_TotalizadorParcial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_TotalizadorParcial]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TotalizadorParcial]    Script Date: 05/13/2016 12:40:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_TotalizadorParcial]
(
	@IDTotalizadorParcial int,@IDReducaoZ int,@Codigo varchar(10),@ValorAcumulado money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_TotalizadorParcial
      (IDTotalizadorParcial,IDReducaoZ,Codigo,ValorAcumulado,ReplLastChange)
      VALUES
      (@IDTotalizadorParcial,@IDReducaoZ,@Codigo,@ValorAcumulado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_TotalizadorParcial SET
    			-- No key fields
    			IDReducaoZ = @IDReducaoZ,
Codigo = @Codigo,
ValorAcumulado = @ValorAcumulado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDTotalizadorParcial = @IDTotalizadorParcial
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TrafficBox]    Script Date: 05/13/2016 12:41:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_TrafficBox]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_TrafficBox]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TrafficBox]    Script Date: 05/13/2016 12:41:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_TrafficBox]
(
	@IDTrafficBox int,@TrafficBox varchar(50),@IDStore int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_TrafficBox
      (IDTrafficBox,TrafficBox,IDStore,ReplLastChange)
      VALUES
      (@IDTrafficBox,@TrafficBox,@IDStore,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_TrafficBox SET
    			-- No key fields
    			TrafficBox = @TrafficBox,
IDStore = @IDStore,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDTrafficBox = @IDTrafficBox
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TrafficMov]    Script Date: 05/13/2016 12:42:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_TrafficMov]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_TrafficMov]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TrafficMov]    Script Date: 05/13/2016 12:42:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_TrafficMov]
(
	@IDTrafficMov int,@IDTrafficBox int,@DateMov datetime,@Qty int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_TrafficMov
      (IDTrafficMov,IDTrafficBox,DateMov,Qty,ReplLastChange)
      VALUES
      (@IDTrafficMov,@IDTrafficBox,@DateMov,@Qty,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_TrafficMov SET
    			-- No key fields
    			IDTrafficBox = @IDTrafficBox,
DateMov = @DateMov,
Qty = @Qty,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDTrafficMov = @IDTrafficMov
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TributacaoECF]    Script Date: 05/13/2016 12:43:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sal_TributacaoECF]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sal_TributacaoECF]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sal_TributacaoECF]    Script Date: 05/13/2016 12:43:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sal_TributacaoECF]
(
	@IDTributacaoECF int,@Aliquota float,@BaseCalculo money,@ValImposto money,@IDReducaoZ int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sal_TributacaoECF
      (IDTributacaoECF,Aliquota,BaseCalculo,ValImposto,IDReducaoZ,ReplLastChange)
      VALUES
      (@IDTributacaoECF,@Aliquota,@BaseCalculo,@ValImposto,@IDReducaoZ,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sal_TributacaoECF SET
    			-- No key fields
    			Aliquota = @Aliquota,
BaseCalculo = @BaseCalculo,
ValImposto = @ValImposto,
IDReducaoZ = @IDReducaoZ,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDTributacaoECF = @IDTributacaoECF
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_ServiceOrder]    Script Date: 05/13/2016 12:44:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Ser_ServiceOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Ser_ServiceOrder]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_ServiceOrder]    Script Date: 05/13/2016 12:44:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Ser_ServiceOrder]
(
	@IDServiceOrder int,@IDCustomer int,@IDUser int,@IDSOStatus int,@IDStore int,@SONumber varchar(20),@SODate datetime,@SOCloseDate datetime,@OBS varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Ser_ServiceOrder
      (IDServiceOrder,IDCustomer,IDUser,IDSOStatus,IDStore,SONumber,SODate,SOCloseDate,OBS,ReplLastChange)
      VALUES
      (@IDServiceOrder,@IDCustomer,@IDUser,@IDSOStatus,@IDStore,@SONumber,@SODate,@SOCloseDate,@OBS,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Ser_ServiceOrder SET
    			-- No key fields
    			IDCustomer = @IDCustomer,
IDUser = @IDUser,
IDSOStatus = @IDSOStatus,
IDStore = @IDStore,
SONumber = @SONumber,
SODate = @SODate,
SOCloseDate = @SOCloseDate,
OBS = @OBS,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDServiceOrder = @IDServiceOrder
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOCustomerProduct]    Script Date: 05/13/2016 12:44:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Ser_SOCustomerProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOCustomerProduct]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOCustomerProduct]    Script Date: 05/13/2016 12:44:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOCustomerProduct]
(
	@IDSOCustomerProduct int,@IDManufacture int,@Model varchar(50),@Description varchar(100),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Ser_SOCustomerProduct
      (IDSOCustomerProduct,IDManufacture,Model,Description,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDSOCustomerProduct,@IDManufacture,@Model,@Description,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Ser_SOCustomerProduct SET
    			-- No key fields
    			IDManufacture = @IDManufacture,
Model = @Model,
Description = @Description,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSOCustomerProduct = @IDSOCustomerProduct
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOItem]    Script Date: 05/13/2016 12:45:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Ser_SOItem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOItem]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOItem]    Script Date: 05/13/2016 12:45:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOItem]
(
	@IDSOItem int,@SerialNumber varchar(50),@IniDate datetime,@EndDate datetime,@OBS varchar(100),@IDSOCustomerProduct int,@IDUser int,@IDServiceOrder int,@UsedTime varchar(20),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Ser_SOItem
      (IDSOItem,SerialNumber,IniDate,EndDate,OBS,IDSOCustomerProduct,IDUser,IDServiceOrder,UsedTime,ReplLastChange)
      VALUES
      (@IDSOItem,@SerialNumber,@IniDate,@EndDate,@OBS,@IDSOCustomerProduct,@IDUser,@IDServiceOrder,@UsedTime,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Ser_SOItem SET
    			-- No key fields
    			SerialNumber = @SerialNumber,
IniDate = @IniDate,
EndDate = @EndDate,
OBS = @OBS,
IDSOCustomerProduct = @IDSOCustomerProduct,
IDUser = @IDUser,
IDServiceOrder = @IDServiceOrder,
UsedTime = @UsedTime,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSOItem = @IDSOItem
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOItemDefect]    Script Date: 05/13/2016 12:47:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Ser_SOItemDefect]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOItemDefect]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOItemDefect]    Script Date: 05/13/2016 12:47:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOItemDefect]
(
	@IDSOItemDefect int,@IDDefectType int,@IDSOItem int,@Type int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Ser_SOItemDefect
      (IDSOItemDefect,IDDefectType,IDSOItem,Type,ReplLastChange)
      VALUES
      (@IDSOItemDefect,@IDDefectType,@IDSOItem,@Type,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Ser_SOItemDefect SET
    			-- No key fields
    			IDDefectType = @IDDefectType,
IDSOItem = @IDSOItem,
Type = @Type,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSOItemDefect = @IDSOItemDefect
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOItemProduct]    Script Date: 05/13/2016 12:47:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Ser_SOItemProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOItemProduct]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOItemProduct]    Script Date: 05/13/2016 12:47:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOItemProduct]
(
	@IDSOItemProduct int,@IDUser int,@IDSOItem int,@IDModel int,@IDStore int,@Qty decimal,@CostPrice money,@SalePrice money,@MovDate datetime,@IDCustomer int,@Discount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Ser_SOItemProduct
      (IDSOItemProduct,IDUser,IDSOItem,IDModel,IDStore,Qty,CostPrice,SalePrice,MovDate,IDCustomer,Discount,ReplLastChange)
      VALUES
      (@IDSOItemProduct,@IDUser,@IDSOItem,@IDModel,@IDStore,@Qty,@CostPrice,@SalePrice,@MovDate,@IDCustomer,@Discount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Ser_SOItemProduct SET
    			-- No key fields
    			IDUser = @IDUser,
IDSOItem = @IDSOItem,
IDModel = @IDModel,
IDStore = @IDStore,
Qty = @Qty,
CostPrice = @CostPrice,
SalePrice = @SalePrice,
MovDate = @MovDate,
IDCustomer = @IDCustomer,
Discount = @Discount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSOItemProduct = @IDSOItemProduct
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOStatus]    Script Date: 05/13/2016 12:48:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Ser_SOStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOStatus]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Ser_SOStatus]    Script Date: 05/13/2016 12:48:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Ser_SOStatus]
(
	@IDSOStatus int,@SOStatus varchar(50),@Color varchar(20),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Ser_SOStatus
      (IDSOStatus,SOStatus,Color,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDSOStatus,@SOStatus,@Color,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Ser_SOStatus SET
    			-- No key fields
    			SOStatus = @SOStatus,
Color = @Color,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSOStatus = @IDSOStatus
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_AppHistory]    Script Date: 05/13/2016 12:52:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_AppHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_AppHistory]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_AppHistory]    Script Date: 05/13/2016 12:52:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_AppHistory]
(
	@IDHistory int,@IDUsuario int,@ErrorLevel int,@FormSource varchar(255),@ErrorMessage text,@HistoryDate datetime,@Software varchar(20),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_AppHistory
      (IDHistory,IDUsuario,ErrorLevel,FormSource,ErrorMessage,HistoryDate,Software,ReplLastChange)
      VALUES
      (@IDHistory,@IDUsuario,@ErrorLevel,@FormSource,@ErrorMessage,@HistoryDate,@Software,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_AppHistory SET
    			-- No key fields
    			IDUsuario = @IDUsuario,
ErrorLevel = @ErrorLevel,
FormSource = @FormSource,
ErrorMessage = @ErrorMessage,
HistoryDate = @HistoryDate,
Software = @Software,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDHistory = @IDHistory
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_CodigoIncremental]    Script Date: 05/13/2016 12:53:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_CodigoIncremental]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_CodigoIncremental]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_CodigoIncremental]    Script Date: 05/13/2016 12:53:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_CodigoIncremental]
(
	@Tabela varchar(100),@UltimoCodigo int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_CodigoIncremental
      (Tabela,UltimoCodigo,ReplLastChange)
      VALUES
      (@Tabela,@UltimoCodigo,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_CodigoIncremental SET
    			-- No key fields
    			UltimoCodigo = @UltimoCodigo,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Tabela = @Tabela
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_ConfigExport]    Script Date: 05/13/2016 12:54:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_ConfigExport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_ConfigExport]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_ConfigExport]    Script Date: 05/13/2016 12:54:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_ConfigExport]
(
	@IDConfigExport int,@DelimiterSeparator char(1),@DecimalSeparator char(1),@HeaderConfig text,@FileFormat text,@HeaderFile bit,@IDPessoa int,@ExportType smallint,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_ConfigExport
      (IDConfigExport,DelimiterSeparator,DecimalSeparator,HeaderConfig,FileFormat,HeaderFile,IDPessoa,ExportType,ReplLastChange)
      VALUES
      (@IDConfigExport,@DelimiterSeparator,@DecimalSeparator,@HeaderConfig,@FileFormat,@HeaderFile,@IDPessoa,@ExportType,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_ConfigExport SET
    			-- No key fields
    			DelimiterSeparator = @DelimiterSeparator,
DecimalSeparator = @DecimalSeparator,
HeaderConfig = @HeaderConfig,
FileFormat = @FileFormat,
HeaderFile = @HeaderFile,
IDPessoa = @IDPessoa,
ExportType = @ExportType,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDConfigExport = @IDConfigExport
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_ConfigImport]    Script Date: 05/13/2016 12:55:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_ConfigImport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_ConfigImport]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_ConfigImport]    Script Date: 05/13/2016 12:55:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_ConfigImport]
(
	@IDConfigImport int,@ImportType smallint,@CrossColumn text,@CaseCost bit,@IDPessoa int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_ConfigImport
      (IDConfigImport,ImportType,CrossColumn,CaseCost,IDPessoa,ReplLastChange)
      VALUES
      (@IDConfigImport,@ImportType,@CrossColumn,@CaseCost,@IDPessoa,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_ConfigImport SET
    			-- No key fields
    			ImportType = @ImportType,
CrossColumn = @CrossColumn,
CaseCost = @CaseCost,
IDPessoa = @IDPessoa,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDConfigImport = @IDConfigImport
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Constante]    Script Date: 05/13/2016 12:56:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_Constante]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_Constante]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Constante]    Script Date: 05/13/2016 12:56:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_Constante]
(
	@Constante varchar(100),@Valor int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_Constante
      (Constante,Valor,ReplLastChange)
      VALUES
      (@Constante,@Valor,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_Constante SET
    			-- No key fields
    			Valor = @Valor,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Constante = @Constante
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_GrupoMainMenuPagina]    Script Date: 05/13/2016 12:57:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_GrupoMainMenuPagina]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_GrupoMainMenuPagina]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_GrupoMainMenuPagina]    Script Date: 05/13/2016 12:57:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_GrupoMainMenuPagina]
(
	@IDMenuItem int,@PaginaNome varchar(35),@IDGrupo int,@PaginaVisivel bit,@PaginaSoLeitura bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_GrupoMainMenuPagina
      (IDMenuItem,PaginaNome,IDGrupo,PaginaVisivel,PaginaSoLeitura,ReplLastChange)
      VALUES
      (@IDMenuItem,@PaginaNome,@IDGrupo,@PaginaVisivel,@PaginaSoLeitura,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_GrupoMainMenuPagina SET
    			-- No key fields
    			PaginaVisivel = @PaginaVisivel,
PaginaSoLeitura = @PaginaSoLeitura,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMenuItem = @IDMenuItem AND
PaginaNome = @PaginaNome AND
IDGrupo = @IDGrupo
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Language]    Script Date: 05/13/2016 12:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_Language]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_Language]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Language]    Script Date: 05/13/2016 12:58:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_Language]
(
	@IDLanguage int,@Language varchar(20),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_Language
      (IDLanguage,Language,ReplLastChange)
      VALUES
      (@IDLanguage,@Language,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_Language SET
    			-- No key fields
    			Language = @Language,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDLanguage = @IDLanguage
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_MainMenuOperacao]    Script Date: 05/13/2016 13:02:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_MainMenuOperacao]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_MainMenuOperacao]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_MainMenuOperacao]    Script Date: 05/13/2016 13:02:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_MainMenuOperacao]
(
	@IDMenuItem int,@IDOperacao int,@Operacao varchar(35),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_MainMenuOperacao
      (IDMenuItem,IDOperacao,Operacao,ReplLastChange)
      VALUES
      (@IDMenuItem,@IDOperacao,@Operacao,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_MainMenuOperacao SET
    			-- No key fields
    			Operacao = @Operacao,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMenuItem = @IDMenuItem AND
IDOperacao = @IDOperacao
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Municipio]    Script Date: 05/13/2016 13:04:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_Municipio]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_Municipio]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Municipio]    Script Date: 05/13/2016 13:04:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_Municipio]
(
	@IDMunicipio int,@Codigo varchar(20),@Descricao varchar(100),@System bit,@Hidden bit,@Desativado bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_Municipio
      (IDMunicipio,Codigo,Descricao,System,Hidden,Desativado,ReplLastChange)
      VALUES
      (@IDMunicipio,@Codigo,@Descricao,@System,@Hidden,@Desativado,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_Municipio SET
    			-- No key fields
    			Codigo = @Codigo,
Descricao = @Descricao,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDMunicipio = @IDMunicipio
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_PropertyDomain]    Script Date: 05/13/2016 13:05:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_PropertyDomain]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_PropertyDomain]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_PropertyDomain]    Script Date: 05/13/2016 13:05:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_PropertyDomain]
(
	@Property varchar(255),@PropertyValue varchar(255),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_PropertyDomain
      (Property,PropertyValue,ReplLastChange)
      VALUES
      (@Property,@PropertyValue,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_PropertyDomain SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Property = @Property AND
PropertyValue = @PropertyValue
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Registro]    Script Date: 05/13/2016 13:41:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_Sis_Registro]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_Sis_Registro]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Sis_Registro]    Script Date: 05/13/2016 13:41:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_Sis_Registro]
(
	@Nome varchar(200),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Sis_Registro
      (Nome,ReplLastChange)
      VALUES
      (@Nome,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Sis_Registro SET
    			-- No key fields
    			ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Nome = @Nome
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SpecialPriceByGroup]    Script Date: 05/13/2016 13:41:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_SpecialPriceByGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_SpecialPriceByGroup]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SpecialPriceByGroup]    Script Date: 05/13/2016 13:41:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_SpecialPriceByGroup]
(
	@SpecialPriceID int,@GroupID int,@SpecialMarkUp money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	SpecialPriceByGroup
      (SpecialPriceID,GroupID,SpecialMarkUp,ReplLastChange)
      VALUES
      (@SpecialPriceID,@GroupID,@SpecialMarkUp,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE SpecialPriceByGroup SET
    			-- No key fields
    			SpecialMarkUp = @SpecialMarkUp,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			SpecialPriceID = @SpecialPriceID AND
GroupID = @GroupID
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SYS_Relatorio]    Script Date: 05/13/2016 13:43:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_SYS_Relatorio]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_SYS_Relatorio]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SYS_Relatorio]    Script Date: 05/13/2016 13:43:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_SYS_Relatorio]
(
	@IDRelatorio int,@IDMenu int,@Relatorio varchar(50),@Descricao varchar(255),@CreateIndex int,@OrderClause varchar(50),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	SYS_Relatorio
      (IDRelatorio,IDMenu,Relatorio,Descricao,CreateIndex,OrderClause,ReplLastChange)
      VALUES
      (@IDRelatorio,@IDMenu,@Relatorio,@Descricao,@CreateIndex,@OrderClause,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE SYS_Relatorio SET
    			-- No key fields
    			IDMenu = @IDMenu,
Relatorio = @Relatorio,
Descricao = @Descricao,
CreateIndex = @CreateIndex,
OrderClause = @OrderClause,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRelatorio = @IDRelatorio
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SYS_RelParametro]    Script Date: 05/13/2016 13:44:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_SYS_RelParametro]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_SYS_RelParametro]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SYS_RelParametro]    Script Date: 05/13/2016 13:44:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_SYS_RelParametro]
(
	@IDRelParametro int,@Panel varchar(30),@Label varchar(30),@ValorDefault varchar(30),@Campo varchar(30),@Operador varchar(30),@IDRelatorio int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	SYS_RelParametro
      (IDRelParametro,Panel,Label,ValorDefault,Campo,Operador,IDRelatorio,ReplLastChange)
      VALUES
      (@IDRelParametro,@Panel,@Label,@ValorDefault,@Campo,@Operador,@IDRelatorio,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE SYS_RelParametro SET
    			-- No key fields
    			Panel = @Panel,
Label = @Label,
ValorDefault = @ValorDefault,
Campo = @Campo,
Operador = @Operador,
IDRelatorio = @IDRelatorio,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDRelParametro = @IDRelParametro
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SysFunction]    Script Date: 05/13/2016 13:50:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_SysFunction]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_SysFunction]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SysFunction]    Script Date: 05/13/2016 13:50:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_SysFunction]
(
	@IDSysFunction int,@IDMenu int,@IDSubMenu int,@SysFunction varchar(100),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	SysFunction
      (IDSysFunction,IDMenu,IDSubMenu,SysFunction,ReplLastChange)
      VALUES
      (@IDSysFunction,@IDMenu,@IDSubMenu,@SysFunction,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE SysFunction SET
    			-- No key fields
    			IDMenu = @IDMenu,
IDSubMenu = @IDSubMenu,
SysFunction = @SysFunction,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSysFunction = @IDSysFunction
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SysFunctionLanguage]    Script Date: 05/13/2016 13:51:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_SysFunctionLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_SysFunctionLanguage]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SysFunctionLanguage]    Script Date: 05/13/2016 13:51:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_SysFunctionLanguage]
(
	@IDSysFunction int,@IDLanguage int,@SysFunction varchar(100),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	SysFunctionLanguage
      (IDSysFunction,IDLanguage,SysFunction,ReplLastChange)
      VALUES
      (@IDSysFunction,@IDLanguage,@SysFunction,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE SysFunctionLanguage SET
    			-- No key fields
    			SysFunction = @SysFunction,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDSysFunction = @IDSysFunction AND
IDLanguage = @IDLanguage
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_UpInvent]    Script Date: 05/13/2016 13:53:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_UpInvent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_UpInvent]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_UpInvent]    Script Date: 05/13/2016 13:53:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_UpInvent]
(
	@Model char(30),@Qty decimal,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	UpInvent
      (Model,Qty,ReplLastChange)
      VALUES
      (@Model,@Qty,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE UpInvent SET
    			-- No key fields
    			Qty = @Qty,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			Model = @Model
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_VendorTax]    Script Date: 05/13/2016 13:54:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_rpl_insupd_VendorTax]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_rpl_insupd_VendorTax]
GO


/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_VendorTax]    Script Date: 05/13/2016 13:54:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_rpl_insupd_VendorTax]
(
	@IDVendorTax int,@IDPessoa int,@IDGroup int,@IDTaxCategory int,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	VendorTax
      (IDVendorTax,IDPessoa,IDGroup,IDTaxCategory,ReplLastChange)
      VALUES
      (@IDVendorTax,@IDPessoa,@IDGroup,@IDTaxCategory,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE VendorTax SET
    			-- No key fields
    			IDPessoa = @IDPessoa,
IDGroup = @IDGroup,
IDTaxCategory = @IDTaxCategory,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDVendorTax = @IDVendorTax
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_SelectModelDiscountSummary]    Script Date: 05/13/2016 13:55:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectModelDiscountSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SelectModelDiscountSummary]
GO


/****** Object:  StoredProcedure [dbo].[sp_SelectModelDiscountSummary]    Script Date: 05/13/2016 13:55:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Usage: exec [sp_SelectModelDiscountSummary] @ModelID = 123
 */
create proc [dbo].[sp_SelectModelDiscountSummary]
    @ModelID int
as
    set nocount on
    select * from vw_ModelDiscountSummaries where IDModel = @ModelID;
    set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_SelectModelTags]    Script Date: 05/13/2016 13:56:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectModelTags]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SelectModelTags]
GO


/****** Object:  StoredProcedure [dbo].[sp_SelectModelTags]    Script Date: 05/13/2016 13:56:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 * Usage: exec [sp_SelectModelTags] @ModelID = 123
 */
create proc [dbo].[sp_SelectModelTags]
    @ModelID int
as
    set nocount on
    select * from TagsWithAttrsAndModels where IDModel = @ModelID;
    set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_SelectPotentialModelTags]    Script Date: 05/13/2016 13:57:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_SelectPotentialModelTags]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_SelectPotentialModelTags]
GO


/****** Object:  StoredProcedure [dbo].[sp_SelectPotentialModelTags]    Script Date: 05/13/2016 13:57:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_SelectPotentialModelTags]
    @ModelID int
as
    set nocount on
    select * from TagsWithAttrsAndModels where IDModel <> @ModelID;
    set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_Tag_Delete]    Script Date: 05/13/2016 13:58:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Tag_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Tag_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_Tag_Delete]    Script Date: 05/13/2016 13:58:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_Tag_Delete]
    @IDTag int
as
set nocount on

delete from Tag where
    [IDTag] = @IDTag

set nocount off

GO


/****** Object:  StoredProcedure [dbo].[sp_Tag_Select]    Script Date: 05/13/2016 13:59:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Tag_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Tag_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_Tag_Select]    Script Date: 05/13/2016 13:59:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_Tag_Upsert]    Script Date: 05/13/2016 14:00:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Tag_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_Tag_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_Tag_Upsert]    Script Date: 05/13/2016 14:00:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagModel_Delete]    Script Date: 05/13/2016 14:01:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagModel_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagModel_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagModel_Delete]    Script Date: 05/13/2016 14:01:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_TagModel_Delete]
    @PKTagModel int
as
set nocount on

delete from TagModel where
    [PKTagModel] = @PKTagModel

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_TagModel_Select]    Script Date: 05/13/2016 14:04:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagModel_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagModel_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagModel_Select]    Script Date: 05/13/2016 14:04:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagModel_Upsert]    Script Date: 05/13/2016 14:05:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagModel_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagModel_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagModel_Upsert]    Script Date: 05/13/2016 14:05:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagModelCounts]    Script Date: 05/13/2016 14:06:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagModelCounts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagModelCounts]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagModelCounts]    Script Date: 05/13/2016 14:06:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_TagModelCounts]
as
set nocount on
select Tag.IDTag, Tag.TagName,
    (select count(*) from TagModel TM where TM.IDTag = Tag.IDTag) as ModelCount
from Tag
order by Tag.TagName;
set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_TagQtyDiscountBreak_Delete]    Script Date: 05/13/2016 14:07:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagQtyDiscountBreak_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagQtyDiscountBreak_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagQtyDiscountBreak_Delete]    Script Date: 05/13/2016 14:07:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_TagQtyDiscountBreak_Delete]
    @IDTag int
as
set nocount on

delete from TagQtyDiscountBreak where
    [IDTag] = @IDTag

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_TagQtyDiscountBreak_Select]    Script Date: 05/13/2016 14:08:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagQtyDiscountBreak_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagQtyDiscountBreak_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagQtyDiscountBreak_Select]    Script Date: 05/13/2016 14:08:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagQtyDiscountBreak_Upsert]    Script Date: 05/13/2016 14:09:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagQtyDiscountBreak_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagQtyDiscountBreak_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagQtyDiscountBreak_Upsert]    Script Date: 05/13/2016 14:09:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagQtyPriceBreak_Delete]    Script Date: 05/13/2016 14:10:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagQtyPriceBreak_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagQtyPriceBreak_Delete]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagQtyPriceBreak_Delete]    Script Date: 05/13/2016 14:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_TagQtyPriceBreak_Delete]
    @IDTag int,
    @MinQuantity int
as
set nocount on

delete from TagQtyPriceBreak where
    [IDTag] = @IDTag
    and [MinQuantity] = @MinQuantity

set nocount off

GO

/****** Object:  StoredProcedure [dbo].[sp_TagQtyPriceBreak_Select]    Script Date: 05/13/2016 14:12:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagQtyPriceBreak_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagQtyPriceBreak_Select]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagQtyPriceBreak_Select]    Script Date: 05/13/2016 14:12:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagQtyPriceBreak_Upsert]    Script Date: 05/13/2016 14:12:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagQtyPriceBreak_Upsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagQtyPriceBreak_Upsert]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagQtyPriceBreak_Upsert]    Script Date: 05/13/2016 14:12:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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

GO

/****** Object:  StoredProcedure [dbo].[sp_TagsForModel]    Script Date: 05/13/2016 14:13:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_TagsForModel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_TagsForModel]
GO


/****** Object:  StoredProcedure [dbo].[sp_TagsForModel]    Script Date: 05/13/2016 14:13:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_TagsForModel]
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

GO





















