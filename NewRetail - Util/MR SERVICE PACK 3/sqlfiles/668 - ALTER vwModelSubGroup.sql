IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vwModelSubGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwModelSubGroup]
GO

CREATE VIEW vwModelSubGroup AS
SELECT
	MSG.IDModelGroup,
	MSG.IDModelSubGroup,
	TG.IDGroup,
	(SUBSTRING(TG.Name+'      ',1,6) + '..\'+ SUBSTRING(MG.ModelGroup+'      ',1,6) + '..\' + MSG.ModelSubGroup) as ModelSubGroup,
	(TG.Name + '\'+ MG.ModelGroup + '\' + MSG.ModelSubGroup) as FullModelSubGroup,
	MSG.UserCode,
	MSG.Desativado,
	MSG.Hidden
FROM
	ModelSubGroup MSG (NOLOCK)
	JOIN ModelGroup MG (NOLOCK) ON (MSG.IDModelGroup = MG.IDModelGroup)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)
GO
