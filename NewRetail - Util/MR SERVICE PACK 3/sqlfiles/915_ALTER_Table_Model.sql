ALTER TABLE Model ADD
       Portion              varchar(100) NULL,
       IDCFOP               int NULL
GO

ALTER TABLE Model
       ADD CONSTRAINT FK_MntCFOP_Model_IDCFOP
              FOREIGN KEY (IDCFOP)
                             REFERENCES Mnt_CFOP
GO