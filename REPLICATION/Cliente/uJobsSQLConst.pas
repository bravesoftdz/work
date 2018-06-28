unit uJobsSQLConst;

interface

const

   DROP_JOB_SP =
        'IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id(''sp_IsJobRunning'') ' +
        'AND OBJECTPROPERTY(id, ''IsProcedure'') = 1) DROP PROC sp_IsJobRunning ';

   CREATE_JOB_SP =
        'CREATE PROC sp_IsJobRunning (@JobName   varchar(64), @IsRunning char(1) OUTPUT ) AS '+
        'BEGIN ' +
        'SET NOCOUNT ON ' +

        'DECLARE	@job_id uniqueidentifier, @is_sysadmin int, @job_owner sysname, @execution_status int '+

       	'SET @IsRunning        = ''N'' '+
	      'SET @job_id           = NULL ' +
    	  'SET @is_sysadmin      = 0 '    +
	      'SET @job_owner        = NULL ' +
	      'SET @execution_status = 0 '    +

        'SET @job_id = (SELECT job_id FROM msdb..sysjobs WHERE name = @JobName) '+
        'IF (@job_id IS NULL) BEGIN RAISERROR(''Unknown job name'', 16, 1) RETURN 1 END ' +

        'CREATE TABLE #xp_results (' +
        'job_id                UNIQUEIDENTIFIER NOT NULL, '+
        'last_run_date         INT              NOT NULL, '+
        'last_run_time         INT              NOT NULL, '+
        'next_run_date         INT              NOT NULL, '+
        'next_run_time         INT              NOT NULL, '+
        'next_run_schedule_id  INT              NOT NULL, '+
        'requested_to_run      INT              NOT	NULL, '+
        'request_source        INT              NOT NULL, '+
        'request_source_id     sysname          NULL,     '+
        'running               INT              NOT	NULL, '+
        'current_step          INT              NOT NULL, '+
        'current_retry_attempt INT              NOT NULL, '+
        'job_state             INT              NOT NULL) '+

        'SELECT @is_sysadmin = ISNULL(IS_SRVROLEMEMBER(N''sysadmin''), 0)' +
        'SELECT @job_owner = SUSER_SNAME() '+
        'INSERT INTO #xp_results EXECUTE master.dbo.xp_sqlagent_enum_jobs @is_sysadmin, @job_owner ' +
        'SET @execution_status = (SELECT job_state FROM #xp_results WHERE job_id = @job_id) ' +
        'IF (@execution_status = 1) BEGIN SET @IsRunning = ''Y'' END ' +
        'IF EXISTS (SELECT 1 WHERE (OBJECT_ID(''tempdb..#xp_results'') IS NOT NULL) ) BEGIN DROP TABLE #xp_results	END '+
        'SET NOCOUNT OFF ' +
        'RETURN 0 ' +
        'END';

implementation

end.
