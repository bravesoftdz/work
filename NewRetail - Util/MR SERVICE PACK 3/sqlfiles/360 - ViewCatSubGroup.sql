if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CategorySubCatGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CategorySubCatGroup]
GO

CREATE VIEW dbo.vw_CategorySubCatGroup AS
SELECT
	TG.IDGroup as IDCategory,
	NULL as IDModelGroup,
	NULL as IDModelSubGroup,
	TG.Name as Category
FROM
      TabGroup TG (NOLOCK)

UNION ALL

SELECT
	TG.IDGroup as IDCategory,
	MG.IDModelGroup as IDModelGroup,
	NULL as IDModelSubGroup,
	TG.Name + '\' + MG.ModelGroup As Category
FROM
      TabGroup TG (NOLOCK)
      JOIN ModelGroup MG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)

UNION ALL

SELECT
	TG.IDGroup as IDCategory,
	MG.IDModelGroup,
	MSG.IDModelSubGroup,
	TG.Name + '\'+ MG.ModelGroup + '\'+ MSG.ModelSubGroup as Category
FROM
      TabGroup TG (NOLOCK)
      JOIN ModelGroup MG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)
      JOIN ModelSubGroup MSG (NOLOCK) ON (MG.IDModelGroup = MSG.IDModelGroup)



GO
