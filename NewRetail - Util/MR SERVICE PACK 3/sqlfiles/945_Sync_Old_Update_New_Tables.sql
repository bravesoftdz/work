USE MainRetailDB
alter database MainRetailDb set COMPATIBILITY_LEVEL = 100

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


/****** Object:  Table [dbo].[Discounts]    Script Date: 05/18/2016 22:41:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Discounts]') AND type in (N'U'))
DROP TABLE [dbo].[Discounts]
GO


/****** Object:  Table [dbo].[Discounts]    Script Date: 05/18/2016 22:41:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Discounts](
	[IDDiscount] [int] IDENTITY(1,1) NOT NULL,
	[DiscountName] [nvarchar](max) NULL,
	[StartOn] [date] NULL,
	[EndOn] [date] NULL,
	[BeginTimeOfDay] [time](7) NULL,
	[EndTimeOfDay] [time](7) NULL,
	[DiscType] [nvarchar](max) NULL,
	[MinSubtotal] [money] NULL,
	[IDStore] [int] NULL,
	[MaxUsesPerCustomer] [int] NULL,
	[MaxUsesInTotal] [int] NULL,
	[FirstTimeCustomerOnly] [dbo].[Boolean] NULL,
	[CustomerCardRequired] [dbo].[Boolean] NULL,
	[IsStackable] [dbo].[Boolean] NULL,
	[RewardAmount] [money] NULL,
	[AmountType] [nvarchar](max) NOT NULL,
	[RewardQuantity] [int] NULL,
	[MinQuantity] [int] NULL,
	[MinDollarAmount] [money] NULL,
 CONSTRAINT [PK_Discounts] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Discounts] ADD  DEFAULT ((1)) FOR [IsStackable]
GO

ALTER TABLE [dbo].[Discounts] ADD  DEFAULT ('Percent Off') FOR [AmountType]
GO

/****** Object:  Table [dbo].[DiscAllowedCustGroups]    Script Date: 05/18/2016 22:45:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscAllowedCustGroups]') AND type in (N'U'))
DROP TABLE [dbo].[DiscAllowedCustGroups]
GO


/****** Object:  Table [dbo].[DiscAllowedCustGroups]    Script Date: 05/18/2016 22:45:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscAllowedCustGroups](
	[IDDiscount] [int] NOT NULL,
	[IDTipoPessoa] [int] NOT NULL,
 CONSTRAINT [PK_DiscAllowedCustGroups] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC,
	[IDTipoPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscAllowedCustGroups]  WITH CHECK ADD  CONSTRAINT [FK_DiscAllowedCustGroups_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscAllowedCustGroups] CHECK CONSTRAINT [FK_DiscAllowedCustGroups_IDDiscount]
GO

ALTER TABLE [dbo].[DiscAllowedCustGroups]  WITH CHECK ADD  CONSTRAINT [FK_DiscAllowedCustGroups_IDTipoPessoa] FOREIGN KEY([IDTipoPessoa])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

/****** Object:  Table [dbo].[Tag]    Script Date: 05/18/2016 23:11:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tag]') AND type in (N'U'))
DROP TABLE [dbo].[Tag]
GO


/****** Object:  Table [dbo].[Tag]    Script Date: 05/18/2016 23:11:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[Tag](
	[IDTag] [int] IDENTITY(1,1) NOT NULL,
	[TagName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[IDTag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_Tag_TagName] UNIQUE NONCLUSTERED 
(
	[TagName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



ALTER TABLE [dbo].[DiscAllowedCustGroups] CHECK CONSTRAINT [FK_DiscAllowedCustGroups_IDTipoPessoa]
GO

/****** Object:  Table [dbo].[DiscCoupons]    Script Date: 05/18/2016 23:16:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscCoupons]') AND type in (N'U'))
DROP TABLE [dbo].[DiscCoupons]
GO


/****** Object:  Table [dbo].[DiscCoupons]    Script Date: 05/18/2016 23:16:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscCoupons](
	[Code] [nvarchar](255) NOT NULL,
	[IDDiscount] [int] NOT NULL,
 CONSTRAINT [PK_DiscCoupons] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscCoupons]  WITH CHECK ADD  CONSTRAINT [FK_DiscCoupons_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscCoupons] CHECK CONSTRAINT [FK_DiscCoupons_IDDiscount]
GO

/****** Object:  Table [dbo].[DiscQualifyingTags]    Script Date: 05/18/2016 23:17:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscQualifyingTags]') AND type in (N'U'))
DROP TABLE [dbo].[DiscQualifyingTags]
GO



/****** Object:  Table [dbo].[DiscQualifyingTags]    Script Date: 05/18/2016 23:17:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscQualifyingTags](
	[IDDiscount] [int] NOT NULL,
	[IDTag] [int] NOT NULL,
 CONSTRAINT [PK_DiscQualifyingTags] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC,
	[IDTag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscQualifyingTags]  WITH CHECK ADD  CONSTRAINT [FK_DiscQualifyingTags_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscQualifyingTags] CHECK CONSTRAINT [FK_DiscQualifyingTags_IDDiscount]
GO

ALTER TABLE [dbo].[DiscQualifyingTags]  WITH CHECK ADD  CONSTRAINT [FK_DiscQualifyingTags_IDTag] FOREIGN KEY([IDTag])
REFERENCES [dbo].[Tag] ([IDTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscQualifyingTags] CHECK CONSTRAINT [FK_DiscQualifyingTags_IDTag]
GO


/****** Object:  Table [dbo].[DiscRewardTags]    Script Date: 05/18/2016 23:17:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscRewardTags]') AND type in (N'U'))
DROP TABLE [dbo].[DiscRewardTags]
GO


/****** Object:  Table [dbo].[DiscRewardTags]    Script Date: 05/18/2016 23:17:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscRewardTags](
	[IDDiscount] [int] NOT NULL,
	[IDTag] [int] NOT NULL,
 CONSTRAINT [PK_DiscRewardTags] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC,
	[IDTag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscRewardTags]  WITH CHECK ADD  CONSTRAINT [FK_DiscRewardTags_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscRewardTags] CHECK CONSTRAINT [FK_DiscRewardTags_IDDiscount]
GO

ALTER TABLE [dbo].[DiscRewardTags]  WITH CHECK ADD  CONSTRAINT [FK_DiscRewardTags_IDTag] FOREIGN KEY([IDTag])
REFERENCES [dbo].[Tag] ([IDTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscRewardTags] CHECK CONSTRAINT [FK_DiscRewardTags_IDTag]
GO


/****** Object:  Table [dbo].[DiscStores]    Script Date: 05/18/2016 23:19:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscStores]') AND type in (N'U'))
DROP TABLE [dbo].[DiscStores]
GO


/****** Object:  Table [dbo].[DiscStores]    Script Date: 05/18/2016 23:19:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscStores](
	[IDDiscount] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[ISInclude] [dbo].[Boolean] NULL,
 CONSTRAINT [PK_DiscStores] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC,
	[IDStore] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscStores]  WITH CHECK ADD  CONSTRAINT [FK_DiscStores_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscStores] CHECK CONSTRAINT [FK_DiscStores_IDDiscount]
GO

ALTER TABLE [dbo].[DiscStores]  WITH CHECK ADD  CONSTRAINT [FK_DiscStores_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscStores] CHECK CONSTRAINT [FK_DiscStores_IDStore]
GO

ALTER TABLE [dbo].[DiscStores] ADD  DEFAULT ((1)) FOR [ISInclude]
GO


/****** Object:  Table [dbo].[DiscUses]    Script Date: 05/18/2016 23:20:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscUses]') AND type in (N'U'))
DROP TABLE [dbo].[DiscUses]
GO


/****** Object:  Table [dbo].[DiscUses]    Script Date: 05/18/2016 23:20:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscUses](
	[IDDiscount] [int] NOT NULL,
	[IDInventoryMov] [int] NOT NULL,
 CONSTRAINT [PK_DiscUses] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC,
	[IDInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscUses]  WITH CHECK ADD  CONSTRAINT [FK_DiscUses_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscUses] CHECK CONSTRAINT [FK_DiscUses_IDDiscount]
GO

ALTER TABLE [dbo].[DiscUses]  WITH CHECK ADD  CONSTRAINT [FK_DiscUses_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscUses] CHECK CONSTRAINT [FK_DiscUses_IDInventoryMov]
GO


/****** Object:  Table [dbo].[DiscValidOnDays]    Script Date: 05/18/2016 23:21:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DiscValidOnDays]') AND type in (N'U'))
DROP TABLE [dbo].[DiscValidOnDays]
GO


/****** Object:  Table [dbo].[DiscValidOnDays]    Script Date: 05/18/2016 23:21:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DiscValidOnDays](
	[IDDiscount] [int] NOT NULL,
	[DayOfWeek] [int] NOT NULL,
 CONSTRAINT [PK_DiscValidOnDays] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC,
	[DayOfWeek] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DiscValidOnDays]  WITH CHECK ADD  CONSTRAINT [FK_DiscValidOnDays_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[DiscValidOnDays] CHECK CONSTRAINT [FK_DiscValidOnDays_IDDiscount]
GO


/****** Object:  Table [dbo].[ManualDiscount]    Script Date: 05/18/2016 23:22:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ManualDiscount]') AND type in (N'U'))
DROP TABLE [dbo].[ManualDiscount]
GO


/****** Object:  Table [dbo].[ManualDiscount]    Script Date: 05/18/2016 23:22:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ManualDiscount](
	[IDPreInventoryMov] [int] NOT NULL,
	[ManualDiscount] [money] NOT NULL,
 CONSTRAINT [PK_ManualDiscount] PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ManualDiscount]  WITH CHECK ADD  CONSTRAINT [FK_ManualDiscount_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ManualDiscount] CHECK CONSTRAINT [FK_ManualDiscount_IDPreInventoryMov]
GO

/****** Object:  Table [dbo].[ManualPrice]    Script Date: 05/18/2016 23:23:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ManualPrice]') AND type in (N'U'))
DROP TABLE [dbo].[ManualPrice]
GO


/****** Object:  Table [dbo].[ManualPrice]    Script Date: 05/18/2016 23:23:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ManualPrice](
	[IDPreInventoryMov] [int] NOT NULL,
	[ManualPrice] [money] NOT NULL,
 CONSTRAINT [PK_ManualPrice] PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ManualPrice]  WITH CHECK ADD  CONSTRAINT [FK_ManualPrice_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[ManualPrice] CHECK CONSTRAINT [FK_ManualPrice_IDPreInventoryMov]
GO

/****** Object:  Table [dbo].[PIMAppliedCoupons]    Script Date: 05/18/2016 23:25:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PIMAppliedCoupons]') AND type in (N'U'))
DROP TABLE [dbo].[PIMAppliedCoupons]
GO


/****** Object:  Table [dbo].[PIMAppliedCoupons]    Script Date: 05/18/2016 23:25:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PIMAppliedCoupons](
	[PreInventoryMovID] [int] NOT NULL,
	[CouponCode] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_PIMAppliedCoupons] PRIMARY KEY CLUSTERED 
(
	[PreInventoryMovID] ASC,
	[CouponCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PIMAppliedCoupons]  WITH CHECK ADD  CONSTRAINT [FK_PIMAppliedCoupons_CouponCode] FOREIGN KEY([CouponCode])
REFERENCES [dbo].[DiscCoupons] ([Code])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[PIMAppliedCoupons] CHECK CONSTRAINT [FK_PIMAppliedCoupons_CouponCode]
GO

ALTER TABLE [dbo].[PIMAppliedCoupons]  WITH CHECK ADD  CONSTRAINT [FK_PIMAppliedCoupons_IDPreInventoryMov] FOREIGN KEY([PreInventoryMovID])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[PIMAppliedCoupons] CHECK CONSTRAINT [FK_PIMAppliedCoupons_IDPreInventoryMov]
GO

/****** Object:  Table [dbo].[PT_GlobalMapping]    Script Date: 05/18/2016 23:27:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PT_GlobalMapping]') AND type in (N'U'))
DROP TABLE [dbo].[PT_GlobalMapping]
GO


/****** Object:  Table [dbo].[PT_GlobalMapping]    Script Date: 05/18/2016 23:27:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PT_GlobalMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDStore] [int] NOT NULL,
	[StoreCode] [varchar](255) NULL,
 CONSTRAINT [PK_PT_GlobalMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[Sal_Coupon]    Script Date: 05/18/2016 23:28:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sal_Coupon]') AND type in (N'U'))
DROP TABLE [dbo].[Sal_Coupon]
GO


/****** Object:  Table [dbo].[Sal_Coupon]    Script Date: 05/18/2016 23:28:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Sal_Coupon](
	[DocumentID] [int] NOT NULL,
	[CouponCode] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Sal_Coupon] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC,
	[CouponCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Sal_Coupon]  WITH CHECK ADD  CONSTRAINT [FK_Sal_Coupon_CouponCode] FOREIGN KEY([CouponCode])
REFERENCES [dbo].[DiscCoupons] ([Code])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Sal_Coupon] CHECK CONSTRAINT [FK_Sal_Coupon_CouponCode]
GO

ALTER TABLE [dbo].[Sal_Coupon]  WITH CHECK ADD  CONSTRAINT [FK_Sal_Coupon_DocumentID] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[Invoice] ([IDPreSale])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Sal_Coupon] CHECK CONSTRAINT [FK_Sal_Coupon_DocumentID]
GO


/****** Object:  Table [dbo].[TagModel]    Script Date: 05/18/2016 23:38:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TagModel]') AND type in (N'U'))
DROP TABLE [dbo].[TagModel]
GO


/****** Object:  Table [dbo].[TagModel]    Script Date: 05/18/2016 23:38:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TagModel](
	[PKTagModel] [int] IDENTITY(1,1) NOT NULL,
	[IDTag] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
 CONSTRAINT [PK_TagModel] PRIMARY KEY CLUSTERED 
(
	[PKTagModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TagModel]  WITH CHECK ADD  CONSTRAINT [FK_TagModel_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TagModel] CHECK CONSTRAINT [FK_TagModel_IDModel]
GO

ALTER TABLE [dbo].[TagModel]  WITH CHECK ADD  CONSTRAINT [FK_TagModel_IDTag] FOREIGN KEY([IDTag])
REFERENCES [dbo].[Tag] ([IDTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TagModel] CHECK CONSTRAINT [FK_TagModel_IDTag]
GO


/****** Object:  Table [dbo].[TagQtyDiscountBreak]    Script Date: 05/18/2016 23:39:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TagQtyDiscountBreak]') AND type in (N'U'))
DROP TABLE [dbo].[TagQtyDiscountBreak]
GO


/****** Object:  Table [dbo].[TagQtyDiscountBreak]    Script Date: 05/18/2016 23:39:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TagQtyDiscountBreak](
	[IDTag] [int] NOT NULL,
	[IDDiscount] [int] NOT NULL,
	[MinQuantity] [int] NOT NULL,
 CONSTRAINT [PK_TagQtyDiscountBreak] PRIMARY KEY CLUSTERED 
(
	[IDTag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TagQtyDiscountBreak]  WITH CHECK ADD  CONSTRAINT [FK_TagQtyDiscountBreak_IDDiscount] FOREIGN KEY([IDDiscount])
REFERENCES [dbo].[Discounts] ([IDDiscount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TagQtyDiscountBreak] CHECK CONSTRAINT [FK_TagQtyDiscountBreak_IDDiscount]
GO

ALTER TABLE [dbo].[TagQtyDiscountBreak]  WITH CHECK ADD  CONSTRAINT [FK_TagQtyDiscountBreak_IDTag] FOREIGN KEY([IDTag])
REFERENCES [dbo].[Tag] ([IDTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TagQtyDiscountBreak] CHECK CONSTRAINT [FK_TagQtyDiscountBreak_IDTag]
GO

/****** Object:  Table [dbo].[TagQtyPriceBreak]    Script Date: 05/18/2016 23:40:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TagQtyPriceBreak]') AND type in (N'U'))
DROP TABLE [dbo].[TagQtyPriceBreak]
GO


/****** Object:  Table [dbo].[TagQtyPriceBreak]    Script Date: 05/18/2016 23:40:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TagQtyPriceBreak](
	[IDTag] [int] NOT NULL,
	[MinQuantity] [int] NOT NULL,
	[Discount] [money] NOT NULL,
 CONSTRAINT [PK_TagQtyPriceBreak] PRIMARY KEY CLUSTERED 
(
	[IDTag] ASC,
	[MinQuantity] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TagQtyPriceBreak]  WITH CHECK ADD  CONSTRAINT [FK_TagQtyPriceBreak_IDTag] FOREIGN KEY([IDTag])
REFERENCES [dbo].[Tag] ([IDTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TagQtyPriceBreak] CHECK CONSTRAINT [FK_TagQtyPriceBreak_IDTag]
GO

ALTER TABLE [dbo].[TagQtyPriceBreak] ADD  DEFAULT ((0)) FOR [Discount]
GO


/****** Object:  Table [dbo].[pcm_animals]    Script Date: 05/18/2016 14:05:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_animals]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_animals]
GO


/****** Object:  Table [dbo].[pcm_animals]    Script Date: 05/18/2016 14:05:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_animals](
	[id] [int] NOT NULL,
	[sku] [varchar](50) NULL,
	[litter] [varchar](50) NULL,
	[breed] [varchar](50) NULL,
	[sex] [varchar](50) NULL,
	[weight] [varchar](50) NULL,
	[color] [varchar](50) NULL,
	[pen] [varchar](50) NULL,
	[whelp] [varchar](50) NULL,
	[comments] [varchar](50) NULL,
	[breeder] [varchar](50) NULL,
	[usda] [varchar](50) NULL,
	[datePur] [varchar](50) NULL,
	[microchip] [varchar](50) NULL,
	[registry] [varchar](50) NULL,
	[reg] [varchar](50) NULL,
	[regSuff1] [varchar](50) NULL,
	[regSuff2] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[supplier] [varchar](50) NULL,
	[sire] [varchar](50) NULL,
	[dam] [varchar](50) NULL,
	[ref] [varchar](50) NULL,
	[collar] [varchar](50) NULL,
	[deposit] [money] NULL,
	[VendorCost] [money] NULL,
	[SuggRetail] [money] NULL,
	[SellingPrice] [money] NULL,
	[TotQtyOnHand] [int] NULL,
	[soldDate] [varchar](50) NULL,
	[soldPrice] [money] NULL,
	[customerid] [varchar](20) NULL,
	[status] [char](1) NULL,
	[fname] [varchar](50) NULL,
	[lname] [varchar](50) NULL,
	[address1] [varchar](255) NULL,
	[address2] [varchar](255) NULL,
	[address3] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](50) NULL,
	[zip] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[vintage] [varchar](15) NULL,
	[is_trans] [int] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pcm_animals] ADD  DEFAULT (0) FOR [is_trans]
GO


/****** Object:  Table [dbo].[pcm_breeders]    Script Date: 05/18/2016 14:06:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_breeders]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_breeders]
GO


/****** Object:  Table [dbo].[pcm_breeders]    Script Date: 05/18/2016 14:06:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_breeders](
	[breeder] [varchar](50) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[breeder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_breeds]    Script Date: 05/18/2016 14:07:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_breeds]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_breeds]
GO


/****** Object:  Table [dbo].[pcm_breeds]    Script Date: 05/18/2016 14:07:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_breeds](
	[breed] [varchar](50) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[breed] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_config]    Script Date: 05/18/2016 14:08:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_config]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_config]
GO


/****** Object:  Table [dbo].[pcm_config]    Script Date: 05/18/2016 14:08:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_config](
	[name] [varchar](50) NOT NULL,
	[value] [varchar](50) NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_medical]    Script Date: 05/18/2016 14:09:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_medical]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_medical]
GO


/****** Object:  Table [dbo].[pcm_medical]    Script Date: 05/18/2016 14:09:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_medical](
	[condition] [varchar](50) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[condition] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_medical_rec]    Script Date: 05/18/2016 14:10:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_medical_rec]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_medical_rec]
GO


/****** Object:  Table [dbo].[pcm_medical_rec]    Script Date: 05/18/2016 14:10:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_medical_rec](
	[code] [int] IDENTITY(1,1) NOT NULL,
	[condition] [varchar](50) NOT NULL,
	[animalid] [varchar](50) NOT NULL,
	[entrydate] [varchar](25) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_others]    Script Date: 05/18/2016 14:10:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_others]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_others]
GO


/****** Object:  Table [dbo].[pcm_others]    Script Date: 05/18/2016 14:10:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_others](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[storeid] [varchar](50) NOT NULL,
	[vintage] [varchar](15) NOT NULL,
	[sku] [varchar](25) NOT NULL,
	[type] [varchar](25) NOT NULL,
	[object] [text] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_vaccine_lots]    Script Date: 05/18/2016 14:38:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_vaccine_lots]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_vaccine_lots]
GO


/****** Object:  Table [dbo].[pcm_vaccine_lots]    Script Date: 05/18/2016 14:38:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_vaccine_lots](
	[code] [int] IDENTITY(1,1) NOT NULL,
	[lotnum] [varchar](50) NULL,
	[vaccine] [varchar](50) NOT NULL,
	[manu] [varchar](50) NULL,
	[expire] [varchar](25) NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[pcm_vaccine_manu]    Script Date: 05/18/2016 14:39:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_vaccine_manu]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_vaccine_manu]
GO


/****** Object:  Table [dbo].[pcm_vaccine_manu]    Script Date: 05/18/2016 14:39:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_vaccine_manu](
	[manu] [varchar](50) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[manu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_vaccine_shots]    Script Date: 05/18/2016 15:02:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_vaccine_shots]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_vaccine_shots]
GO


/****** Object:  Table [dbo].[pcm_vaccine_shots]    Script Date: 05/18/2016 15:02:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_vaccine_shots](
	[code] [int] IDENTITY(1,1) NOT NULL,
	[lotnum] [varchar](50) NOT NULL,
	[animalid] [varchar](50) NOT NULL,
	[dosedate] [varchar](25) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[pcm_vaccines]    Script Date: 05/18/2016 15:07:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pcm_vaccines]') AND type in (N'U'))
DROP TABLE [dbo].[pcm_vaccines]
GO


/****** Object:  Table [dbo].[pcm_vaccines]    Script Date: 05/18/2016 15:07:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pcm_vaccines](
	[vaccine] [varchar](50) NOT NULL,
	[type] [char](1) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[vaccine] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[Results]    Script Date: 05/18/2016 21:36:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Results]') AND type in (N'U'))
DROP TABLE [dbo].[Results]
GO


/****** Object:  Table [dbo].[Results]    Script Date: 05/18/2016 21:36:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Results](
	[IDWarrantyReport] [int] NOT NULL,
	[IDSpecies] [int] NOT NULL,
	[Report] [image] NULL,
	[ReportName] [varchar](30) NULL,
	[ReportDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--GO

SET ANSI_PADDING OFF
GO