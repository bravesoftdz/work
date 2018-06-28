USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[pcm_animals]    Script Date: 04/16/2014 10:08:45 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[pcm_animals] ADD  DEFAULT (0) FOR [is_trans]
GO
