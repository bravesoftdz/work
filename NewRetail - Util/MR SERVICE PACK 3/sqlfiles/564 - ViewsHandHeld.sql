if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCategoryTree]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCategoryTree]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelSubGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelSubGroup]
GO

CREATE VIEW vwModelSubGroup AS
SELECT
	MSG.IDModelGroup,
	MSG.IDModelSubGroup,
	TG.IDGroup,
	(TG.Name + '\'+ MG.ModelGroup + '\' + MSG.ModelSubGroup) as ModelSubGroup,
	MSG.UserCode,
	MSG.Desativado,
	MSG.Hidden
FROM
	ModelSubGroup MSG (NOLOCK)
	JOIN ModelGroup MG (NOLOCK) ON (MSG.IDModelGroup = MG.IDModelGroup)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)

GO

CREATE VIEW vwCategoryTree AS
SELECT
	IDCategory,
	IDSubCategory,
	IDGroup,
	Name,
	IDType,
	IDFinal,
	Desativado,
	Hidden
FROM
(
	SELECT
		IDGroup AS IDCategory,
		NULL AS IDSubCategory,
		NULL AS IDGroup,
		Name,
		1 AS IDType,
		IDGroup AS IDFinal,
		Desativado,
		Hidden
	FROM
		TabGroup
	
	UNION ALL
	
	SELECT
		IDGroup AS IDCategory,
		IDModelGroup AS IDSubCategory,
		NULL AS IDGroup,
		ModelGroup AS Name,
		2 AS IDType,
		IDModelGroup AS IDFinal,
		Desativado,
		Hidden

	FROM
		vwmodelgroup
	
	UNION ALL
	
	SELECT
		IDGroup AS IDCategory,
		IDModelGroup AS IDSubCategory,
		IDModelSubGroup AS IDGroup,
		ModelSubGroup AS Name,
		3 AS IDType,
		IDModelSubGroup AS IDFinal,
		Desativado,
		Hidden
	FROM
		vwmodelsubgroup
) A

GO
