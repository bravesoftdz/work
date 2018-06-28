CREATE TABLE Sis_Message (
       IDMessage            int NOT NULL,
       CreationDate         datetime NULL,
       Subject              varchar(100) NULL,
       Body                 varchar(225) NULL,
       IDUserSender         int NULL
)
GO

CREATE INDEX XIF1Sis_Message ON Sis_Message
(
       IDUserSender
)
GO

ALTER TABLE Sis_Message
       ADD CONSTRAINT XPKSis_Message PRIMARY KEY (IDMessage)
GO

CREATE TABLE Sis_MessageUser (
       IDMessage            int NOT NULL,
       IDUserReceiver       int NOT NULL,
       ReadDate             datetime NULL
)
GO

CREATE INDEX XIF1Sis_MessageUser ON Sis_MessageUser
(
       IDMessage
)
GO

CREATE INDEX XIF2Sis_MessageUser ON Sis_MessageUser
(
       IDUserReceiver
)
GO

ALTER TABLE Sis_MessageUser
       ADD CONSTRAINT XPKSis_MessageUser PRIMARY KEY (IDMessage, 
              IDUserReceiver)
GO

ALTER TABLE Sis_Message
       ADD CONSTRAINT FK_SystemUser_SisMessage_IDUser
              FOREIGN KEY (IDUserSender)
                             REFERENCES SystemUser
GO

ALTER TABLE Sis_MessageUser
       ADD CONSTRAINT FK_SystemUser_SisMessageUser_IDUser
              FOREIGN KEY (IDUserReceiver)
                             REFERENCES SystemUser
GO

ALTER TABLE Sis_MessageUser
       ADD CONSTRAINT FK_SisMessage_SisMessageUser_IDMessage
              FOREIGN KEY (IDMessage)
                             REFERENCES Sis_Message
GO
