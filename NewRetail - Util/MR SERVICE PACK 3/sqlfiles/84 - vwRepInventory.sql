if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryQtyByModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryQtyByModel]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Rep_InventoryQtyByModel
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte aos relatórios da pasta Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	I.IDModel,
	SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
	SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
	SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
	SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
	SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
FROM			
	vw_Rep_Inventory I
	JOIN vw_Rep_Model M ON (I.IDModel = m.IDModel)
GROUP BY I.IDModel




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO