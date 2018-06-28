unit uReplicationConsts;

interface

const
  REPCOLUMN                 = 'ReplLastChange';
  REP_DELETION_TABLE        = 'Rpl_RowDeleted';
  REP_DELETION_TABLE_SCRIPT = 'Script';
  REP_DELETION_TABLE_NAME   = 'TableName';

  PK_COLUMN_NAME = 'Coluna';
  CRLF = #13#10;

  { ANSI }
  ANSI_FMT_TABLE_SELECT        = 'SELECT * FROM %S (NOLOCK) WHERE (1 = 0)';
  ANSI_FMT_TABLE_SELECT_FILEDS = 'SELECT %S FROM %S (NOLOCK)';
  ANSI_FMT_SQL_UPDATE          = 'UPDATE %S SET ';
  ANSI_FMT_SQL_SELECT          = 'SELECT %S FROM %S (NOLOCK) ';
  ANSI_FMT_SQL_INSERT          = 'INSERT INTO %S (%S) VALUES (%S)';



  { MSSQL2000 - Microsoft SQL Server 2000 }
  MSSQL2000_SELECT_PK =
    'SELECT' + CRLF +
    '	KCU.COLUMN_NAME AS Coluna,' + CRLF +
    '	KCU.ORDINAL_POSITION AS Ordem' + CRLF +
    'FROM' + CRLF +
    '	INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC' + CRLF +
    '	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU ON (TC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME)' + CRLF +
    'WHERE' + CRLF +
    '	TC.CONSTRAINT_TYPE ='#39'PRIMARY KEY'#39 + CRLF +
    '	AND' + CRLF +
    '	TC.TABLE_NAME = '#39'%S'#39 + CRLF +
    '	AND' + CRLF +
    '	KCU.TABLE_CATALOG = '#39'%S'#39 + CRLF +
    'ORDER BY' + CRLF +
    '	KCU.ORDINAL_POSITION';

  MSSQL2000_SELECT_FIELD_TYPES =
  'SELECT' + CRLF +
  '      COLUMN_NAME,' + CRLF +
  '      CASE WHEN DATA_TYPE = '#39'varchar'#39 + CRLF +
  '              THEN DATA_TYPE + '#39'('#39'+ CAST(CHARACTER_MAXIMUM_LENGTH AS varchar(5)) + '#39')'#39 + CRLF +
  '              ELSE DATA_TYPE' + CRLF +
  '      END AS DDL_EXPRESSION' + CRLF +  'FROM' + CRLF +
  '        INFORMATION_SCHEMA.COLUMNS' + CRLF +
  'WHERE' + CRLF +
  '        TABLE_NAME = '#39'%S'#39 + CRLF +
  '	AND' + CRLF +
  '	TABLE_CATALOG = '#39'%S'#39 + CRLF +
  ' AND COLUMNPROPERTY(OBJECT_ID(TABLE_CATALOG + '#39'..'#39' + TABLE_NAME), COLUMN_NAME, '#39'IsComputed'#39') = 0' + CRLF +
  ' AND DATA_TYPE <> '#39'timestamp'#39 + CRLF +
  'ORDER BY' + CRLF +
    '	ORDINAL_POSITION';

  MSSQL2000_SELECT_FK =
    'SELECT' + CRLF +
    '	FC.TABLE_NAME AS TabelaDerivada,' + CRLF +
    '	FC.COLUMN_NAME AS ChaveEstrangeira,' + CRLF +
    '	DC.COLUMN_NAME AS ChaveOriginal,' + CRLF +
    '	DC.TABLE_NAME AS TabelaOriginal,' + CRLF +
    '	RC.CONSTRAINT_NAME AS ConstraintName' + CRLF +
    'FROM' + CRLF +
    '	INFORMATION_SCHEMA.KEY_COLUMN_USAGE FC' + CRLF +
    '	INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC' + CRLF +
    '		ON (FC.CONSTRAINT_NAME = RC.CONSTRAINT_NAME)' + CRLF +
    '	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE DC' + CRLF +
    '		ON (RC.UNIQUE_CONSTRAINT_NAME = DC.CONSTRAINT_NAME)';

  MSSQL2000_WHERE_REP_SINCE = 'IsNull(ReplLastChange, GETDATE()) >= CONVERT(DATETIME, DATEDIFF(DAY, %D, GETDATE()))';

  MSSQL2000_CMD_DISABLE_ALL_TRIGGERS = 'ALTER TABLE %S DISABLE TRIGGER ALL';

  MSSQL2000_CMD_ENABLE_ALL_TRIGGERS = 'ALTER TABLE %S ENABLE TRIGGER ALL';

  MSSQL2000_CMD_ENABLE_CONSTRAINT =
    'ALTER TABLE %S CHECK CONSTRAINT %S';

  MSSQL2000_CMD_DISABLE_CONSTRAINT =
    'ALTER TABLE %S NOCHECK CONSTRAINT %S';



  MSSQL2000_CMD_REPLICATE_BATCH_BEGIN = 'SET NOCOUNT ON';

  MSSQL2000_CMD_REPLICATE_BATCH_BODY =
    '%S' + CRLF +
    'IF @@ROWCOUNT = 0' + CRLF +
    '	BEGIN' + CRLF +
    '	  %S' + CRLF +
    '	END';

  REPLICATION_STORED_PROCEDURE_NAME_FORMAT = 'sp_rpl_insupd_%S';

  MSSQL2000_CMD_REPLICATE_BATCH_BODY_SP =
    'EXEC ' + REPLICATION_STORED_PROCEDURE_NAME_FORMAT + ' %S';



  MSSQL2000_CMD_REPLICATE_BATCH_END = 'SET NOCOUNT OFF';




  COLUMN_NAME_CONST = 'COLUMN_NAME';

  DDL_EXPRESSION_CONST = 'DDL_EXPRESSION';

  (* Carlos MacLeod - Updated 3/06/2011
   01 - TableName
   02 - TableName
   03 - TableName
   04 - Parameters ( with datatype )
   05 - Table Name
   06 - Insert Field names
   07 - Insert Parameters
   08 - TableName
   09 - SET sequence Fields ( Not Key )
   10 - WHERE sequence of Key Fields

  *)

  MSSQL2000_CMD_CREATE_RPL_INS_UPD_STORED_PROCEDURE =
    'IF OBJECT_ID('#39'dbo.'+REPLICATION_STORED_PROCEDURE_NAME_FORMAT+#39') IS NOT NULL' + CRLF +
    '   DROP PROCEDURE dbo.'+REPLICATION_STORED_PROCEDURE_NAME_FORMAT + CRLF +
    'GO' + CRLF +
    'CREATE PROCEDURE [dbo].[sp_rpl_insupd_%S]' + CRLF +
    '(' + CRLF +
    '	%S' + CRLF +
    ') AS' + CRLF +
    //'	DECLARE @SysError		int' + CRLF +
    'BEGIN TRY' + CRLF +
    '      INSERT INTO	%S' + CRLF +
    '      (%S)' + CRLF +
    '      VALUES' + CRLF +
    '      (%S)' + CRLF +
    'END TRY' + CRLF +
    'BEGIN CATCH'  + CRLF +

    '    DECLARE @_rpl_pk_violation_err_num int,'  + CRLF +
    '            @_rpl_number int,'  + CRLF +
    '            @_rpl_message nvarchar(2048),'  + CRLF +
    '            @_rpl_severity tinyint,'  + CRLF +
    '            @_rpl_state tinyint'  + CRLF +
    '    SELECT @_rpl_pk_violation_err_num = 2627,'  + CRLF +
    '           @_rpl_number = error_number(),'  + CRLF +
    '           @_rpl_message = error_message(),'  + CRLF +
    '           @_rpl_severity = error_severity(),'  + CRLF +
    '           @_rpl_state = error_state()'  + CRLF +
    '    IF @_rpl_number = @_rpl_pk_violation_err_num'  + CRLF +
    //'	SELECT @SysError = @@ERROR' + CRLF +
    //'	IF @SysError = 2627' + CRLF +
    //'	BEGIN' + CRLF +
    '    		UPDATE %S SET' + CRLF +
    '    			-- No key fields' + CRLF +
    '    			%S' + CRLF +
    '		    WHERE' + CRLF +
    '         -- Key Fields' + CRLF +
    '    			%S' + CRLF +
    '    			-- Replication Field' + CRLF +
    '    			AND ReplLastChange < @ReplLastChange' + CRLF +
    '        ELSE' + CRLF +
    '            -- Re-raise error since it isn'#39't one we can handle here.' + CRLF +
    '            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)' + CRLF +
    '    END CATCH' + CRLF;
    // +
    //'GO' + CRLF;

implementation

end.
