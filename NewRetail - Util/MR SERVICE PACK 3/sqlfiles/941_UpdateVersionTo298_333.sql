ALTER TABLE [dbo].[PreSerialMov]
    ADD [processor] CHAR (1) NULL
GO

ALTER TABLE [dbo].[SerialMov]
ADD [processor] CHAR (1) NULL;

GO    

UPDATE SYS_MODULE
SET MRBUILD = 333

GO