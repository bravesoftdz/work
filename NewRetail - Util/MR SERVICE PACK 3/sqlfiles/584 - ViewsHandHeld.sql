if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCategoryTree]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCategoryTree]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelSubGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelSubGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelGroup]
GO

CREATE VIEW vwModelGroup AS
SELECT
	MG.IDModelGroup,
	(SUBSTRING(TG.Name,1,4) + '..\'+ MG.ModelGroup) as ModelGroup,
	(TG.Name + '\'+ MG.ModelGroup) as FullModelGroup,
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
	TG.IDGroup,
	(SUBSTRING(TG.Name,1,4) + '..\'+ SUBSTRING(MG.ModelGroup,1,4) + '..\' + MSG.ModelSubGroup) as ModelSubGroup,
	(TG.Name + '\'+ MG.ModelGroup + '\' + MSG.ModelSubGroup) as FullModelSubGroup,
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
	FullName,
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
		Name as FullName,
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
		FullModelGroup AS FullName,
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
		FullModelSubGroup AS FullName,
		3 AS IDType,
		IDModelSubGroup AS IDFinal,
		Desativado,
		Hidden
	FROM
		vwmodelsubgroup
) A


GO
