ALTER TABLE Sal_PaymentCondition ADD
       EstimetedDate        datetime NULL
GO

ALTER TABLE Mnt_PessoaAddress
     ADD IDMunicipio int NULL
GO

ALTER TABLE Mnt_PessoaAddress
       ADD CONSTRAINT FK_Sis_Municipio_Mnt_PessoaAddress_IDMunicipio
              FOREIGN KEY (IDMunicipio)
                             REFERENCES Sis_Municipio
GO

ALTER TABLE InvoiceOBS
      ADD IDPessoaAddress      int NULL
GO

ALTER TABLE InvoiceOBS
       ADD CONSTRAINT FK_MntPessoaAddress_InvoiceOBS_IDPessoaAddress
              FOREIGN KEY (IDPessoaAddress)
                             REFERENCES Mnt_PessoaAddress
GO
