CREATE TABLE Inv_NCM (
       IDNCM                int NOT NULL,
       Codigo               varchar(20) NULL,
       Descricao            varchar(255) NULL,
       MVAInterno           decimal(38,4) NULL,
       MVAInterestadual     decimal(38,4) NULL,
       Incide               bit NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL
)
GO

ALTER TABLE Inv_NCM ADD CONSTRAINT
	DF_SystemNCM DEFAULT (0) FOR System
GO

ALTER TABLE Inv_NCM ADD CONSTRAINT
	DF_DesatNCM DEFAULT (0) FOR Desativado
GO

ALTER TABLE Inv_NCM ADD CONSTRAINT
	DF_HiddenNCM DEFAULT (0) FOR Hidden
GO


ALTER TABLE Inv_NCM
       ADD CONSTRAINT XPKInv_NCM PRIMARY KEY (IDNCM)
GO

ALTER TABLE Model
       ADD IDNCM int NULL

ALTER TABLE Model
       ADD CONSTRAINT FK_Inv_NCM_Model_IDNCM
              FOREIGN KEY (IDNCM)
                             REFERENCES Inv_NCM
GO
