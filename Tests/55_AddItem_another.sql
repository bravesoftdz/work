begin tran;

--select DocumentID, IDPreInventoryMov, ModelID, * from PreInventoryMov where DocumentID = 1200000001;
select * from SaleItemCommission where IDPreInventoryMov = 1200001002;

exec sp_PreSale_AddItem
    @PreSaleID           = 1200000001,
    @IDCliente           = 1,
    @ModelID             = 1100000001,
    @StoreID             = 1,
    @UserID              = 1,
    @IDComission         = null,
    @Qty                 = 1,
    @SalePrice           = 1.99,
    @CostPrice           = 1.49,
    @Discount            = null,
    @MovDate             = '2014-01-01 12:00:00',
    @ResetDiscount       = 0,
    @Manager             = 0,
    @Date                = '2014-01-01 12:00:00',
    @IDPreInvMovExchange = null,
    @PreInvMovParentID   = null,
    @IDDepartment        = 0,
    @Promo               = 0,
    @IDDescriptionPrice  = 0,
    @IDVendorPrice       = 0,
    @SuggPrice           = 0,
    @DocumentNumber      = '',
    @IDDocumentType      = null,
    @SequencyNum         = 0,
    @TotParcial          = '',
    @DiscountPromo       = 0,
    @UnitDiscount        = null,
    @PreInventMovID      = 1200001002,
    @ManualDiscount      = null,
    @IDSpecialPrice      = null,
    @ManualPrice         = null;
go

select * from SaleItemCommission where IDPreInventoryMov = 1200001002;


rollback tran;