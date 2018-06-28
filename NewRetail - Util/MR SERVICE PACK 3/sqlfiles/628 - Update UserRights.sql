UPDATE
	UserRights
SET
	CanAccess = 1, CanInsert = 1, CanDelete = 1, CanUpdate = 1, CanPrint = 1
WHERE
	UserTypeID = 1
GO
