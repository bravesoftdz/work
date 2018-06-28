if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MenuRights]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[MenuRights]
GO

CREATE VIEW MenuRights (UserTypeID, ParentMenu, ModuleName, CanAccess, CanInsert, CanDelete, CanUpdate, CanPrint, IDMenu, IDSubMenu, CanExport)  AS
       SELECT UR.UserTypeID, MI.ParentMenu, MI.Name, UR.CanAccess, UR.CanInsert, UR.CanDelete, UR.CanUpdate, UR.CanPrint, UR.MenuID, UR.SubMenuID, UR.CanExport
       FROM UserRights UR, MenuItem MI
       WHERE UR.MenuID = MI.IDMenu 
AND 
UR.SubMenuID = MI.IDSubMenu
GO
