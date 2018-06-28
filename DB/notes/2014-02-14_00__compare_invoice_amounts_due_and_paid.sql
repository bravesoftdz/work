/*
 * Calculate the amounts due and paid for invoices.
 * The first two CTE are from Nick. The next step will be to correct amounts
 * that are off.
 *
 * Try re-calculating tax, if that doesn't help, then just adjust the discount
 * to match the payment. InventoryMov.SalesTax is the percentage.
 * join InventoryMov on (IM.DocumentID = Invoice.IDInvoice)
 */
with DueAmounts as (
    select InvoiceDate, IDPreSale, IDStore, round(SubTotal,2) as SubTotal,
     OtherExpences, AditionalExpenses, round(ItemDiscount,2) as ItemDiscount,
     round(InvoiceDiscount,2) as InvoiceDiscount, round(Tax,2) as Tax, Layaway,
     SubTotal - ItemDiscount - InvoiceDiscount + Tax as AmountDue
    from Invoice
    where IDInvoice is not null and Canceled = 0 and IDStore = 1
        and InvoiceDate >= '2000-01-01' and InvoiceDate < '2014-02-14'
),
AmountsPaid as (
    select M.MeioPag, L.IDPreSale, round(L.ValorNominal,2) as ValorNominal,
        SA.Amount as Amount
        --,L.IDPreSale, IDStoreAccount, IDStoreAccountUsed, Pagando
    from Fin_Lancamento L
    full outer join MeioPag M on L.IDQuitacaoMeioPrevisto = M.IDMeioPag
    full outer join Sal_StoreAccount SA on (SA.IDLancamento = L.IDLancamento)
    full outer join Invoice I on (L.IDPreSale = I.IDPreSale) 
    where L.DataLancamento >= '2000-01-01' and L.DataLancamento < '2014-02-14'
        and (I.IDStore = 1 or SA.IDStore = 1)
        and L.IDPreSale is not null
        and Pagando = 0
        and Amount is null
        or L.DataLancamento >= '2000-01-01'
        and L.DataLancamento < '2014-02-14'
        and (I.IDStore = 1 or SA.IDStore = 1)
        and L.IDPreSale is not null
        and Pagando = 0
        and ValorNominal = Amount
        or L.DataLancamento >= '2000-01-01'
        and L.DataLancamento < '2014-02-14'
        and (I.IDStore = 1 or SA.IDStore = 1)
        and SA.IsReceiving = 1
),
TotalsDue as (
    select IDPreSale, sum(AmountDue) as TotalDue
    from DueAmounts
    group by IDPreSale
),
TotalsPaid as (
    select IDPreSale, sum(ValorNominal) as TotalPaid
    from AmountsPaid
    group by IDPreSale
),
NeedsInvestigation as (
    select TD.IDPreSale, TD.TotalDue, TP.TotalPaid,
        TD.TotalDue - TP.TotalPaid as TheDifference
    from TotalsDue TD
    left join TotalsPaid TP on (TP.IDPreSale = TD.IDPresale)
    where TD.TotalDue <> TP.TotalPaid
        or (TP.IDPreSale is null and TD.TotalDue <> 0.00) /* No matching payments */
)
select NI.*, IM.SalesTax
from NeedsInvestigation NI
join Invoice I on (I.IDPreSale = NI.IDPreSale)
join InventoryMov IM on (IM.DocumentID = I.IDInvoice)
order by NI.IDPreSale
