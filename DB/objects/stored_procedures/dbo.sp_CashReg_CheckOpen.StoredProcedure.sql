SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_CashReg_CheckOpen]
			( 			
			@CashRegID  		int,
			@IsOpen 		bit output,
			@IDOpenUser 		int output,
			@IDCashRegMov	int output
			) 
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Setando @IDCashRegMov 		- Setando @IDOpenUser
		- Setando @IsOpen
		- Setando IDs para 0 caso sejam Null

	
	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Rodrigo Costa		Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


-- Setando @IDCashRegMov 
SELECT  @IDCashRegMov = (	 
			SELECT 
				MAX(IDCashRegMov) 
			FROM 
				dbo.CashRegMov (NOLOCK)
			WHERE
				dbo.CashRegMov.IDCashRegister = @CashRegID 
				AND 				dbo.CashRegMov.IDCashRegStatus = 1
			)	

-- Setando @IDOpenUser
SELECT  @IDOpenUser = 	(	
			SELECT 
				IDOpenUser
			FROM 
				dbo.CashRegMov (NOLOCK)
			WHERE
				dbo.CashRegMov.IDCashRegMov = @IDCashRegMov
 			)	

-- Setando @IsOpen
SELECT	@IsOpen = 	(
			CASE
 				WHEN @IDOpenUser IS NOT NULL THEN 1 ELSE 0 END
			)

-- Setando IDs para 0 caso sejam Null
SELECT 	@IDOpenUser   		= IsNull(@IDOpenUser, 0)
SELECT 	@IDCashRegMov 	= IsNull(@IDCashRegMov, 0)
GO
