ALTER TABLE TabGroup ADD Credit bit NULL DEFAULT 0
GO

UPDATE TabGroup SET Credit = 0 WHERE Credit is null
GO

UPDATE TabGroup SET Service = 0 WHERE Service is null
GO

ALTER TABLE ServiceRange ADD UseRange Boolean NOT NULL DEFAULT 1
GO

ALTER TABLE Model ADD LargeImage2 Varchar(255) Null
GO

