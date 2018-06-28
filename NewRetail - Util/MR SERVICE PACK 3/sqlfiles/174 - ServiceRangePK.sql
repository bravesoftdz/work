DROP INDEX ServiceRange.XPKServiceRange
GO

ALTER TABLE [dbo].[ServiceRange] WITH NOCHECK ADD
    PRIMARY KEY  CLUSTERED ( [IDServiceRange] )  ON [PRIMARY]
GO