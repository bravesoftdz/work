SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_DropConstraint]
@TabelaDerivada Varchar (180),
@ChaveEstrangeira Varchar (180)
AS
/******************************************************************************
	Dropa a constraint de FK de uma Tabela na coluna passada como parâmetro
******************************************************************************/
DECLARE @Constraint Varchar (100)
DECLARE @prep Varchar (100)

SELECT 
	@Constraint = ConstraintName
FROM vw_Sis_ChaveEstrangeira 
WHERE 
	TabelaDerivada = @TabelaDerivada
AND	ChaveEstrangeira = @ChaveEstrangeira

SET @prep =  'ALTER TABLE ' + @TabelaDerivada + 
' DROP CONSTRAINT '+ @Constraint

EXECUTE (@prep)
GO
