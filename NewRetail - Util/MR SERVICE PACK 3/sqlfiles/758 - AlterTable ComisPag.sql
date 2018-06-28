ALTER TABLE ComisPaga DROP CONSTRAINT PK__ComisPaga__51300E55 
GO

execute sp_rename ComisPaga, ComisPagaRCDG2749000
GO

CREATE TABLE ComisPaga (
       IDDocumento          int NOT NULL,
       IDPessoa             int NOT NULL,
       IDLancPag            int NULL
)
GO

ALTER TABLE ComisPaga
       ADD PRIMARY KEY (IDDocumento, IDPessoa)
GO

INSERT INTO ComisPaga (IDDocumento, IDLancPag, IDPessoa) SELECT IDDocumento, IDLancPag, 0 
    FROM ComisPagaRCDG2749000 
GO

DROP TABLE ComisPagaRCDG2749000
GO

ALTER TABLE ComisPaga
       ADD CONSTRAINT FK_Pessoa_ComisPaga_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
