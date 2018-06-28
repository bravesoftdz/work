SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Mnt_Recompile_All_Objects]
AS
/* -----------------------------------------------------------------------------------------------------------
	SUMARIO

		Recompilação de todos os objetos do database
		por Maximiliano Muniz em 04 de Setembro de 2007.

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	------------------------------------------------------
	04 Sep	2007		Maximiliano Muniz	Criacao;
	------------------------------------------------------------------------------------------------------ */

DECLARE @dbsid varbinary(85)

SELECT
	@dbsid = sid 
FROM
	master.dbo.sysdatabases
WHERE
	name = db_name()

------------------------------------------
--	Check the user sysadmin		--
------------------------------------------
IF NOT is_srvrolemember('sysadmin') = 1 AND suser_sid() <> @dbsid
BEGIN
	RAISERROR(15288,-1,-1,'SA or DBO','sp_recompile')
	RETURN (1)
END

DECLARE @exec_stmt nvarchar(540)
DECLARE @tablename sysname
DECLARE @uid smallint
DECLARE @user_name sysname
DECLARE @tablename_header varchar(267)
DECLARE @mensagem varchar(100)

DECLARE tnames_cursor CURSOR FOR

SELECT
	name,
	uid
FROM
	sysobjects
WHERE
	type in ('U','P','V')
	and schema_ver <> 0

OPEN tnames_cursor

FETCH NEXT FROM tnames_cursor INTO
	@tablename,
	@uid

WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
		SELECT @user_name = user_name(@uid)
		SELECT @tablename_header = 'RECOMPILE ' + @user_name +'.'+ RTRIM(LOWER(@tablename))
		PRINT @tablename_header
		SELECT @exec_stmt = 'sp_recompile ''' + @user_name +'.' + ( @tablename )+ ''''
		EXEC (@exec_stmt)
	END

	FETCH NEXT FROM tnames_cursor INTO @tablename, @uid
END

SELECT @mensagem = 'RECOMPILE DE TODOS OS OBJETOS DO ' + db_name() + ' FORAM FEITOS' 
PRINT ' '
PRINT ' '
raiserror(@mensagem,-1,-1)
DEALLOCATE tnames_cursor
RETURN(0)
GO
