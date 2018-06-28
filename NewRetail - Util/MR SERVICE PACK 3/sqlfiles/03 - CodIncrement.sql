IF EXISTS(select * from dbo.sysobjects 
	where id = object_id(N'[dbo].[Sis_CodigoIncremental]'))
	 EXEC('DROP TABLE Sis_CodigoIncremental')
GO

CREATE TABLE Sis_CodigoIncremental
(
	Tabela varchar(100) NOT NULL
	CONSTRAINT Tabela PRIMARY KEY,
	UltimoCodigo int NOT NULL
)
GO


SET NOCOUNT ON
DECLARE @TABLE_NAME	Varchar (100)
DECLARE @COLUMN_NAME	Varchar (100)
DECLARE @SQL	Varchar (1000)
DECLARE @UltimoCodigo	int 
SET @UltimoCodigo = 0

DECLARE UltimoCodigo_Cursor CURSOR FOR 
		SELECT 	
		  C.TABLE_NAME,
		  C.COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS C
		WHERE  COLUMNPROPERTY( OBJECT_ID(C.TABLE_NAME),C.COLUMN_NAME,'IsIdentity')= 1
		   AND C.TABLE_NAME IN (SELECT TABLE_NAME FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE')
		ORDER BY 1
OPEN UltimoCodigo_Cursor

FETCH NEXT FROM UltimoCodigo_Cursor INTO  @TABLE_NAME,@COLUMN_NAME

WHILE @@FETCH_STATUS = 0
BEGIN

SET @SQL ='INSERT INTO Sis_CodigoIncremental (Tabela, UltimoCodigo)'+ char (13)+
          'Select '+char (39) +@TABLE_NAME+'.'+@COLUMN_NAME+char (39)+
	  ' AS Tabela,isnull (Max ('+ @COLUMN_NAME + '),1)AS UltimoCodigo From ' +@TABLE_NAME

EXEC (@SQL)
	FETCH NEXT FROM UltimoCodigo_Cursor INTO  @TABLE_NAME,@COLUMN_NAME
END

CLOSE UltimoCodigo_Cursor
DEALLOCATE UltimoCodigo_Cursor
SET NOCOUNT OFF
GO