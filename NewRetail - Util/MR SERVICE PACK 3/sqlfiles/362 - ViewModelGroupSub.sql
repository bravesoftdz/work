if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelSubGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelSubGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelGroup]
GO

CREATE VIEW vwModelGroup AS
SELECT
	MG.IDModelGroup,
	(TG.Name + '\'+ MG.ModelGroup) as ModelGroup,
	MG.UserCode,
	MG.Desativado,
	MG.Hidden,
	MG.IDGroup
FROM
	ModelGroup MG (NOLOCK)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)


GO

CREATE VIEW vwModelSubGroup AS
SELECT
	MSG.IDModelGroup,
	MSG.IDModelSubGroup,
	(TG.Name + '\'+ MG.ModelGroup + '\' + MSG.ModelSubGroup) as ModelSubGroup,
	MSG.UserCode,
	MSG.Desativado,
	MSG.Hidden
FROM
	ModelSubGroup MSG (NOLOCK)
	JOIN ModelGroup MG (NOLOCK) ON (MSG.IDModelGroup = MG.IDModelGroup)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup) 


GO
