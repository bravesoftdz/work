begin tran;

/*
 * Problem: Many credits were issued (CustomerCredit rows were inserted)
 * for InventoryMov transactions that had ModelID=21814 and InventMovTypeID=1.
 * Solution: Find the credits that haven't been used yet and expire them.
 * Also expire the ones for IDPessoa = 1.
 */
 
-- This query is for reviewing stats (except for anonymous purchases):
with ProblematicInventoryMovs as (
	select IDInventoryMov, DocumentID, IDPessoa, PreInventoryMovID,
		 MovDate, SalePrice
	from InventoryMov
	where ModelID=21814 and InventMovTypeID=1 and IDPessoa <> 1
),
AssociatedCustomerCredits as (
	select ProblematicInventoryMovs.*, IDCustomerCredit, CreditDate, IsUsed, Amount
	from CustomerCredit
	join ProblematicInventoryMovs on
		(CustomerCredit.IDPreInventoryMov = ProblematicInventoryMovs.PreInventoryMovID)
	where ExpirationDate is null
),
CreditStats as (
	select
	(
		select sum(SalePrice) from AssociatedCustomerCredits where IsUsed = 1
	) as SumIsUsed,
	(
		select sum(SalePrice) from AssociatedCustomerCredits where IsUsed = 0
	) as SumNotUsed,
	(
		select sum(SalePrice) from AssociatedCustomerCredits
	) as SumAll
	from (select 1 Placeholder1) Placeholder2
)
select * from CreditStats;
 
-- This actually expires the associated records (including anonymous purchases)
with ProblematicInventoryMovs as (
	select IDInventoryMov, DocumentID, IDPessoa, PreInventoryMovID,
		 MovDate, SalePrice
	from InventoryMov
	where ModelID=21814 and InventMovTypeID=1
),
AssociatedCustomerCredits as (
	select ProblematicInventoryMovs.*, IDCustomerCredit, CreditDate, IsUsed, Amount
	from CustomerCredit
	join ProblematicInventoryMovs on
		(CustomerCredit.IDPreInventoryMov = ProblematicInventoryMovs.PreInventoryMovID)
	where ExpirationDate is null
)
update CustomerCredit
set ExpirationDate = current_timestamp, IsUsed = 1
where IDCustomerCredit in (select IDCustomerCredit from AssociatedCustomerCredits);

rollback tran;