-- Request from Nick to sum the UsedAmount and add a where clause like:
-- Sold_Amount - UsedAmount <> Card_Balance
-- Original Query:
/*
select
    SAC.CardNumber, IM.SalePrice as Sold_Amount, FL.ValorNominal as UsedAmount, 
    SAC.Amount as Card_Balance, SAC.CardDate, SAC.Amount as Card_Balance, 
    SAC.Canceled, IM.ModelID, IM.DocumentID, IM.QTY, IM.SalePrice, 
    FL.NumMeioQuitPrevisto, FL.IDLancamento, FL.IDPreSale
    --(IM.SalePrice-sum(valorNominal)) as Balance
from Sal_AccountCard SAC
join InventoryMov IM on (SAC.IDPreInventoryMov = IM.PreInventoryMovID)
left join Fin_Lancamento FL on (SAC.CardNumber = FL.NumMeioQuitPrevisto)
-- group by FL.NumMeioQuitPrevisto, SAC.CardNumber
order by SAC.CardDate desc;
*/

-- New version:
with AccountsWithSums as (
    select SAC.CardNumber, sum(coalesce(FL.ValorNominal, 0)) as TotalUsedAmount
    from Sal_AccountCard SAC
    left join Fin_Lancamento FL on (SAC.CardNumber = FL.NumMeioQuitPrevisto)
    group by SAC.CardNumber
),
AndWithMoreDetails as (
    select AccountsWithSums.*, IM.SalePrice as SoldAmount, SAC.Amount as CardBalance,
        SAC.CardDate, SAC.Canceled, IM.ModelID, IM.DocumentID, IM.Qty
    from AccountsWithSums
    join Sal_AccountCard SAC on (SAC.CardNumber = AccountsWithSums.CardNumber)
    join InventoryMov IM on (SAC.IDPreInventoryMov = IM.PreInventoryMovID)
)
select *
from AndWithMoreDetails
where SoldAmount - TotalUsedAmount <> CardBalance
order by CardDate desc;