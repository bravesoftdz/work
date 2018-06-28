CREATE TABLE PessoaValidation (
       IDPessoaValidation   int NOT NULL,
       IDTipoPessoa         int NOT NULL,
       PessoaField          varchar(40) NULL
)
GO

ALTER TABLE PessoaValidation
       ADD CONSTRAINT XPKPessoaValidation PRIMARY KEY (
              IDPessoaValidation)
GO

ALTER TABLE PessoaValidation
       ADD CONSTRAINT FK_TipoPessoa_PessoaValidation_IDTipoPessoaFilho
              FOREIGN KEY (IDTipoPessoa)
                             REFERENCES TipoPessoa
GO
