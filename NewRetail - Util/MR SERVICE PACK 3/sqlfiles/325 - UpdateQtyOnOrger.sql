IF NOT EXISTS
	(
	SELECT 
		SC.name ,
		SO.name
	FROM 
		SysColumns SC INNER JOIN
		SysObjects SO ON (SC.ID = SO.ID)
	WHERE 
		SC.name = 'QtyExceeded'
		AND
		SO.name = 'PreInventoryMov'
	)
	BEGIN
		ALTER TABLE 
			PreInventoryMov ADD 
				QtyExceeded	int NULL CONSTRAINT DF_Zero1482 DEFAULT 0
	END
GO

UPDATE
	PreInventoryMov
SET
	QtyRealMov = Qty,
	QtyExceeded = QtyRealMov - Qty
WHERE
	InventMovTypeID = 2
	AND
	Qty > 0
	AND
	QtyRealMov > Qty
GO

UPDATE
	PreInventoryMov
SET	
	QtyExceeded = 0
WHERE
	QtyExceeded IS NULL
GO
