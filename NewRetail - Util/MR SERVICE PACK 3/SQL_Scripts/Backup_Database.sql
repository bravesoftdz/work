if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_Backup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_Backup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_Backup_Sub]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_Backup_Sub]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_Backup_Zip]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_Backup_Zip]
GO

CREATE PROCEDURE sp_Sis_Backup_Zip
	(
	@DatabaseName	varchar(100),
	@BackupPath		varchar(100)
	)
AS

DECLARE @ERRO	integer
DECLARE @Cmd    	varchar(1000)
DECLARE @BKPFile    	varchar(200)
DECLARE @OldZip	varchar(200)
DECLARE @NewZip	varchar(200)
DECLARE @Days	integer

SET @Days = -7 --Delete history
SET @OldZip = DateName(Day, GetDate()+@Days)+Cast(DateName(Month, GetDate()+@Days) as VarChar(3))+DateName(yy, GetDate()+@Days) 
SET @NewZip = DateName(Day, GetDate())+Cast(DateName(Month, GetDate()) as VarChar(3))+DateName(yy, GetDate()) 

SET @BKPFile = @BackupPath + DateName(WeekDay, GetDate()) + '_' + @DatabaseName + '.BAK'

SET @ERRO = 0

--Exec Zip file
SET @Cmd = @BackupPath + 'MRZip.EXE "' +@BackupPath + @NewZip + '.ZIP" "' + @BKPFile + '"'
EXEC master..xp_CmdShell @Cmd
--Print @Cmd

--Delete .Bak file
SET @Cmd =  'DEL ' +@BKPFile
EXEC master..xp_CmdShell @Cmd

-- Delete Zip previews file
SET @Cmd = 'DEL ' + @BackupPath + @OldZip + '.ZIP'
EXEC master..xp_CmdShell @Cmd

RETURN @ERRO
GO

CREATE PROCEDURE sp_Sis_Backup_Sub
	(
	@DatabaseName	varchar(100),
	@BackupPath		varchar(100)
	)
AS

DECLARE @ERRO		integer
DECLARE @Disk    		varchar(1000)
DECLARE @Cmd		varchar(200)

SET @Disk = @BackupPath + DateName(WeekDay, GetDate()) + '_' + @DatabaseName + '.BAK'

SET @ERRO = 0

-- Dell Log
BACKUP TRANSACTION @DatabaseName  WITH TRUNCATE_ONLY
SET @ERRO = @ERRO + @@ERROR 

-- Backup device
BACKUP DATABASE @DatabaseName TO DISK=@Disk WITH INIT

--------------------------------------------------------------------------------
--Zip backup and delete history
EXEC sp_Sis_Backup_Zip @DatabaseName, @BackupPath


RETURN @ERRO
GO

CREATE PROCEDURE sp_Sis_Backup
AS

DECLARE @ERRO		integer
DECLARE @BackupPath	varchar(100)
DECLARE @DatabaseName	varchar(100)
DECLARE @Disk    	varchar(1000)

--Backup will be done on that dir
SET @BackupPath = 'C:\SQL_BACKUP\' 

SET @Disk = @BackupPath +  DateName(WeekDay, GetDate()) + '_System' + '.BAK'
SET @ERRO = 0

-- Backup master
BACKUP DATABASE Master TO DISK=@Disk WITH INIT
SELECT @ERRO = @ERRO + @@ERROR 

-- Backup Distrivution DB, is Exist
if exists (select * from INFORMATION_SCHEMA.SCHEMATA where CATALOG_NAME = 'Distribution')
BEGIN
	BACKUP DATABASE Distribution TO DISK=@Disk WITH NOINIT
	SET @ERRO = @ERRO + @@ERROR 
END

-- Backup do msdb
BACKUP DATABASE Msdb TO DISK=@Disk WITH NOINIT
SELECT @ERRO = @ERRO + @@ERROR 

--Backup transatcion
-- Delete Log
--BACKUP TRANSACTION ApresentationDB  WITH TRUNCATE_ONLY
--SET @ERRO = @ERRO + @@ERROR 

--------------------------------------------------------------------------------
--Zip backup Master and Delete history
EXEC sp_Sis_Backup_Zip 'System', @BackupPath


---------------------------------------------------------------------------------
-- Call Database to backup
EXEC sp_Sis_Backup_Sub 'MainRetailDB', @BackupPath

RETURN @ERRO
GO

