ALTER TABLE UserRights ADD
       CanExport bit NULL
GO

UPDATE UserRights
SET CanExport = CanAccess
GO
