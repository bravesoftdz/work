set xact_abort on;
go
begin tran;

if object_id(N'SyncStore') is not null drop trigger SyncStore;
if object_id(N'SyncPessoa') is not null drop trigger SyncPessoa;
if object_id(N'SyncInvoice') is not null drop trigger SyncInvoice;
if object_id(N'SyncInventoryMov') is not null drop trigger SyncInventoryMov;
if object_id(N'SyncInventory') is not null drop trigger SyncInventory;
if object_id(N'SyncBarcode') is not null drop trigger SyncBarcode;
if object_id(N'SyncModel') is not null drop trigger SyncModel;
if object_id('vw_ECDWithModel') is not null drop view vw_ECDWithModel;
if object_id('vw_PreInventoryMovWithDiscounts') is not null drop view vw_PreInventoryMovWithDiscounts;
if object_id('SyncChanges') is not null drop table SyncChanges;
if object_id('SyncTables') is not null drop table SyncTables;
if object_id('SyncBatches') is not null drop table SyncBatches;

commit tran;