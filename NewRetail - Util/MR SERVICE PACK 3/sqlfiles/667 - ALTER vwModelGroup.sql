IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vwModelGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwModelGroup]
GO

CREATE VIEW vwModelGroup AS
SELECT
	MG.IDModelGroup,
	(SUBSTRING(TG.Name+'      ',1,6) + '..\'+ MG.ModelGroup) as ModelGroup,
	(TG.Name + '\'+ MG.ModelGroup) as FullModelGroup,
	MG.UserCode,
	MG.Desativado,
	MG.Hidden,
	MG.IDGroup
FROM
	ModelGroup MG (NOLOCK)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)
GO
