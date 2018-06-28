CREATE TABLE Inv_MovReason (
	IDMovReason int NOT NULL,
	Reason varchar(30) NOT NULL,
	Hidden Boolean NOT NULL CONSTRAINT DF_InvMovReason_Hidden_Zero DEFAULT 0,
	System Boolean NOT NULL CONSTRAINT DF_InvMovReason_System_Zero DEFAULT 0,
	Desativado Boolean NOT NULL CONSTRAINT DF_InvMovReason_Desativado_Zero DEFAULT 0
)
GO

ALTER TABLE Inv_MovReason
       ADD CONSTRAINT XPKInv_MovReason PRIMARY KEY (IDMovReason)
GO

CREATE TABLE Inv_MovComplement (
	IDInventoryMov int NOT NULL,
	IDMovReason int NOT NULL,
	Notes varchar(255) NULL
)
GO

ALTER TABLE Inv_MovComplement
       ADD CONSTRAINT XPKInv_MovComplement PRIMARY KEY (
              IDInventoryMov)
GO

ALTER TABLE Inv_MovComplement
       ADD CONSTRAINT FK_InvMovReason_InvMovComplement_IDInventoryMov
              FOREIGN KEY (IDMovReason)
                             REFERENCES Inv_MovReason
GO

ALTER TABLE Inv_MovComplement
       ADD CONSTRAINT FK_InventoryMov_InvMovComplement_IDInventoryMov
              FOREIGN KEY (IDInventoryMov)
                             REFERENCES InventoryMov
GO

INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo) VALUES ('Inv_MovReason.IDMovReason', 1)
GO

INSERT Inv_MovReason (IDMovReason, Reason, System, Hidden, Desativado) VALUES (1, 'None', 1, 0, 0)
GO

INSERT Inv_MovComplement (IDInventoryMov, IDMovReason, Notes)
SELECT IDInventoryMov, 1, Notes From InventoryMov Where Notes IS NOT NULL
GO

ALTER TABLE InventoryMov DROP COLUMN Notes
GO
