SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[CC] @String  varchar(30) = null
AS
select Valor, Constante from Sis_Constante where constante like RTrim(LTrim(@String)) + '%'  order by valor
GO
