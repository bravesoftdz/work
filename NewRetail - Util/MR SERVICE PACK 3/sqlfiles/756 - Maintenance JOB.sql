IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Mnt_Recompile_All_Objects]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Mnt_Recompile_All_Objects]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Mnt_Reindex_All_Tables]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Mnt_Reindex_All_Tables]
GO

CREATE PROCEDURE sp_Mnt_Reindex_All_Tables
AS
/* -----------------------------------------------------------------------------------------------------------
	SUMARIO

		Re-indexação de todos os índices de todas as tabelas do database
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

----------------------------------
--	Check the user sysadmin	--
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
		PRINT @tablename_header
		--SELECT @exec_stmt = 'DBCC DBREINDEX (''' + @user_name +'.' + ( @tablename )+ ''','''',80)'
		SELECT @exec_stmt = 'DBCC DBREINDEX (''' + @user_name +'.' + ( @tablename )+ ''')' 
		EXEC (@exec_stmt)
		--SELECT (@exec_stmt)
	END

	FETCH NEXT FROM tnames_cursor INTO @tablename, @uid
END

SELECT @mensagem = 'REINDEX DE TODAS AS TABELAS DO ' + db_name() + ' FORAM FEITOS' 
PRINT ' '
PRINT ' '
raiserror(@mensagem,-1,-1)
DEALLOCATE tnames_cursor
RETURN(0) -- sp_reindexalltables
GO

CREATE PROCEDURE sp_Mnt_Recompile_All_Objects
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

----------------------------------
--	Criação do JOB		--
----------------------------------

BEGIN TRANSACTION            

DECLARE @JobID BINARY(16)
DECLARE @JobName varchar(115)
DECLARE @ReturnCode INT
DECLARE @DataBaseName varchar(100)

SELECT @DataBaseName = db_name()

SET @JobName = 'MR_Maintenance_' + @DataBaseName

SELECT @ReturnCode = 0

IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'[Uncategorized (Local)]') < 1
	EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

-- Delete the job with the same name (if it exists)
SELECT @JobID = job_id
FROM   msdb.dbo.sysjobs
WHERE (name = @DataBaseName)

IF (@JobID IS NOT NULL)    
BEGIN  
	-- Check if the job is a multi-server job  
	IF (EXISTS (SELECT * FROM msdb.dbo.sysjobservers WHERE (job_id = @JobID) AND (server_id <> 0)))
	BEGIN
		-- There is, so abort the script
		RAISERROR (N'Unable to import job ''MR_Maintenance'' since there is already a multi-server job with this name.', 16, 1)
		GOTO QuitWithRollback
	END
	ELSE
		-- Delete the [local] job
		EXECUTE msdb.dbo.sp_delete_job @job_name = @JobName
	SELECT @JobID = NULL
END

BEGIN 
	-- Add the job
	EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = @JobName, @owner_login_name = N'sa', @description = N'No description available.', @category_name = N'[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0)
		GOTO QuitWithRollback

	-- Add the job steps
	EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'Execute Reindex All Tables', @command = N'exec sp_Mnt_Reindex_All_Tables', @database_name = @DataBaseName, @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 2
	IF (@@ERROR <> 0 OR @ReturnCode <> 0)
		GOTO QuitWithRollback 

	EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'Execute Recompile All Objects', @command = N'exec sp_Mnt_Recompile_All_Objects', @database_name = @DataBaseName, @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
	IF (@@ERROR <> 0 OR @ReturnCode <> 0)
		GOTO QuitWithRollback
	EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0)
		GOTO QuitWithRollback 

	-- Add the job schedules
	EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'Daily Maintenance', @enabled = 1, @freq_type = 4, @active_start_date = 20070904, @active_start_time = 10000, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
	IF (@@ERROR <> 0 OR @ReturnCode <> 0)
		GOTO QuitWithRollback

	-- Add the Target Servers
	EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0)
		GOTO QuitWithRollback
END

COMMIT TRANSACTION          

GOTO EndSave              
QuitWithRollback:
IF (@@TRANCOUNT > 0)
	ROLLBACK TRANSACTION 
EndSave: 
GO
