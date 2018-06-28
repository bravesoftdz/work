if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Insert_ModelGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Insert_ModelGroup]
GO

CREATE PROCEDURE sp_Insert_ModelGroup AS

DECLARE	@IDGroup	int
DECLARE @IDSubGroup	int 
DECLARE @SubGroup	varchar(30) 
DECLARE @UserCode	varchar(5) 
DECLARE @IDModelGroup	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int


BEGIN TRAN

SET  @ErrorLevel = 0

DECLARE ModelGroup_Cursor CURSOR FOR

	SELECT DISTINCT	
			M.GroupID,
			M.IDSubGroup,
			SG.SubGroup,
			SG.UserCode
	FROM		
			Model M
			LEFT JOIN SubGroup SG ON (SG.IDSubGroup=M.IDSubGroup)
	WHERE
			M.IDSubGroup IS NOT NULL
	
OPEN ModelGroup_Cursor

FETCH NEXT FROM ModelGroup_Cursor INTO
	@IDGroup,
	@IDSubGroup,
	@SubGroup,
	@UserCode

WHILE
@@FETCH_STATUS = 0
BEGIN

	
	EXEC sp_Sis_GetNextCode 'ModelGroup.IDModelGroup', @IDModelGroup OUTPUT

	INSERT INTO ModelGroup
		(
		IDModelGroup,
		ModelGroup,
		IDGroup,
		UserCode
		)
	VALUES
		(
		@IDModelGroup,
		@SubGroup,
		@IDGroup,
		@UserCode
		)

	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE ModelGroup_Cursor
		DEALLOCATE ModelGroup_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	UPDATE Model
	SET 
		IDModelGroup = @IDModelGroup
	WHERE
		GroupID = @IDGroup
		AND
		IDSubGroup = @IDSubGroup
		
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE ModelGroup_Cursor
		DEALLOCATE ModelGroup_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END


	FETCH NEXT FROM ModelGroup_Cursor INTO
		@IDGroup,
		@IDSubGroup,
		@SubGroup,
		@UserCode
END
CLOSE ModelGroup_Cursor
DEALLOCATE ModelGroup_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

	UPDATE Model
	SET
		IDSubGroup = NULL

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	ALTER TABLE Model
        DROP CONSTRAINT FK_SubGroup_Model_IDSubGroup
        
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	ALTER TABLE Model
	DROP COLUMN
		IDSubGroup

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END

	DROP TABLE SubGroup
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN
  
	RETURN @ErrorLevel
GO

EXEC sp_Insert_ModelGroup
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Insert_ModelGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Insert_ModelGroup]
GO
