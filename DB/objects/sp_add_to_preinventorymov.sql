ALTER PROCEDURE [dbo].[sp_add_to_preinventorymov]
	(
	@PreSaleID		int,
	@IDCliente		int,
	@ModelID		int,
	@StoreID		int,
	@UserID			int,
	@IDComission		int,
	@Qty			float,
	@SalePrice		money,
	@CostPrice		money = Null,
	@Discount		money,
	@MovDate		smalldatetime,
	@IDPreInvMovExchange	int,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@SequencyNum		int,
	@TotParcial		varchar(10),
	@DiscountPromo		money = 0,
	@UnitDiscount       money =0,
	@PreInventMovID		int Output
	)
AS

