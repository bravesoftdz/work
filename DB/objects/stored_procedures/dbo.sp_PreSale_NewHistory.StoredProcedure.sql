SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_NewHistory]( @IDUser int, @MovDate DateTime, @OBS varchar(255), @IDHistoryType int, @IDPreSale int) AS
DECLARE @IDHistory int
 

EXEC sp_Sis_GetNextCode 'History.IDHistory', @IDHistory OUTPUT

INSERT INTO History
            (
            IDHistory,
            IDUser,
            MovDate,
            OBS,
            IDHistoryType,
            IDPreSale
            )
VALUES
            (
            @IDHistory,
            @IDUser,
            @MovDate,
            @OBS,
            @IDHistoryType,
            @IDPreSale
            )
GO
