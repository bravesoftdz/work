if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Mnt_Reindex_All_Tables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Mnt_Reindex_All_Tables]
GO

CREATE  PROCEDURE sp_Mnt_Reindex_All_Tables
AS
/* -----------------------------------------------------------------------------------------------------------
 SUMARIO
 
  Re-indexação de todos os índices de todas as tabelas do database
  por Maximiliano Muniz em 04 de Setembro de 2007.
 
 TABELA DE ERROS PARA RETURN_VALUE
 
   000  Ok
 
 LOG DE MODIFICAÇÕES
 
 Data   Programador  Modificação
 ----------------------- ----------------------- ------------------------------------------------------
 04 Sep 2007  Maximiliano Muniz Criacao;
 ------------------------------------------------------------------------------------------------------ */

SET ARITHABORT ON 
SET QUOTED_IDENTIFIER ON 

DECLARE @dbsid varbinary(85)
 
SELECT
 @dbsid = sid
FROM
 master.dbo.sysdatabases
WHERE
 name = db_name()
 
----------------------------------
-- Check the user sysadmin --
----------------------------------
IF NOT is_srvrolemember('sysadmin') = 1 AND suser_sid() <> @dbsid
BEGIN
 RAISERROR(15288,-1,-1,'SA or DBO','DBCC DBREINDEX')
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
 type = 'U'
 
OPEN tnames_cursor
 
FETCH NEXT FROM tnames_cursor INTO
 @tablename,
 @uid
 
WHILE (@@fetch_status <> -1)
BEGIN
 IF (@@fetch_status <> -2)
 BEGIN
  SELECT @user_name = user_name(@uid)
  SELECT @tablename_header = 'REINDEX ' + @user_name +'.'+ RTRIM(LOWER(@tablename))
  --PRINT @tablename_header
  SELECT @exec_stmt = 'DBCC DBREINDEX (''' + @user_name +'.' + ( @tablename )+ ''','''',80)'
  --SELECT @exec_stmt = 'DBCC DBREINDEX (''' + @user_name +'.' + ( @tablename )+ ''')' 
  EXEC (@exec_stmt)
  --SELECT (@exec_stmt)
 END
 
 FETCH NEXT FROM tnames_cursor INTO @tablename, @uid
END
 
--SELECT @mensagem = 'REINDEX DE TODAS AS TABELAS DO ' + db_name() + ' FORAM FEITOS' 
--PRINT ' '
--PRINT ' '
--raiserror(@mensagem,-1,-1)
DEALLOCATE tnames_cursor
RETURN(0) -- sp_reindexalltables
GO
