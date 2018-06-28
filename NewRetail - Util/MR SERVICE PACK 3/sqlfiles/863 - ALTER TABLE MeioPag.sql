ALTER TABLE MeioPag ADD
      PrintBankBillet bit NULL CONSTRAINT DF_Zero4130 DEFAULT 0,
       BankBilletInterest   money NULL
GO
