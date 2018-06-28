unit uTranslateScript;

interface

uses ADODB, uDMGlobal;

const
   //ENGLISH ********************************
   MEIOPAG_ENG =
                  'Update MeioPag Set MeioPag = ''American Express batch'' Where IDMeioPag = 16' + #13#10 +
                  'Update MeioPag Set MeioPag = ''American Express Card'' Where IDMeioPag = 3' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Cash'' Where IDMeioPag = 1' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Cash deposit'' Where IDMeioPag = 14' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Check'' Where IDMeioPag = 5' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Diners'' Where IDMeioPag = 6' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Gift Certificate'' Where IDMeioPag = 11' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Manual Balance Adjustment'' Where IDMeioPag = 12' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Master batch'' Where IDMeioPag = 17' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Master Card'' Where IDMeioPag = 4' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Transfer'' Where IDMeioPag = -1' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Visa batch'' Where IDMeioPag = 15' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Visa Card'' Where IDMeioPag = 2';
   TIPOPESSOA_ENG =
                  'Update TipoPessoa Set TipoPessoa = ''Customers'' Where IDTipoPessoa = 1 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Vendors'' Where IDTipoPessoa = 2 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Commissions'' Where IDTipoPessoa = 3 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Sales Person'' Where IDTipoPessoa = 4 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Agents'' Where IDTipoPessoa = 5 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Agencies'' Where IDTipoPessoa = 6 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Manufacturers'' Where IDTipoPessoa = 7 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Other'' Where IDTipoPessoa = 9 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Returns'' Where IDTipoPessoa = 21 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Local/Freelance'' Where IDTipoPessoa = 24';
   TIPOPESSOAPATH_ENG =
                  'Update TipoPessoa Set PathName = ''\ Commissions'' Where IDTipoPessoa = 3 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Agencies'' Where IDTipoPessoa = 6 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Local/Freelance'' Where IDTipoPessoa = 24 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Other'' Where IDTipoPessoa =  9 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Outside Agents'' Where IDTipoPessoa = 5 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Sales Person'' Where IDTipoPessoa = 4 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Customers'' Where IDTipoPessoa = 1 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Manufacturers'' Where IDTipoPessoa = 7 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Vendors'' Where IDTipoPessoa = 2 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Vendors\ Returns'' Where IDTipoPessoa = 21 ';
   MEDIA_ENG =
                  'Update Media Set Media = ''Brochure'' Where IDMedia = 5 '+ #13#10 +
                  'Update Media Set Media = ''Employee'' Where IDMedia = 10 '+ #13#10 +
                  'Update Media Set Media = ''Express Sale'' Where IDMedia =  20  '+ #13#10 +
                  'Update Media Set Media = ''Internet'' Where IDMedia =  16 '+ #13#10 +
                  'Update Media Set Media = ''Outside Agency'' Where IDMedia = 1 '+ #13#10 +
                  'Update Media Set Media = ''Previous Customer'' Where IDMedia = 9 '+ #13#10 +
                  'Update Media Set Media = ''Resale Customer'' Where IDMedia = 11 '+ #13#10 +
                  'Update Media Set Media = ''Sign'' Where IDMedia = 3 '+ #13#10 +
                  'Update Media Set Media = ''Walk In'' Where IDMedia = 7 '+ #13#10 +
                  'Update Media Set Media = ''Word of mouth'' Where IDMedia = 6 ';
   USERTYPE_ENG =
                  'Update UserType Set Name = ''Administrator'' Where IDUserType = 1 '+ #13#10 +
                  'Update UserType Set Name = ''Assistant Manager'' Where IDUserType = 6 '+ #13#10 +
                  'Update UserType Set Name = ''Buyer'' Where IDUserType = 10 '+ #13#10 +
                  'Update UserType Set Name = ''Cashier'' Where IDUserType = 3 '+ #13#10 +
                  'Update UserType Set Name = ''Cashier/PO'' Where IDUserType = 5 '+ #13#10 +
                  'Update UserType Set Name = ''Manager'' Where IDUserType = 2 '+ #13#10 +
                  'Update UserType Set Name = ''Perfumes'' Where IDUserType = 15'+ #13#10 +
                  'Update UserType Set Name = ''Public Relations'' Where IDUserType = 7 '+ #13#10 +
                  'Update UserType Set Name = ''Sales Person'' Where IDUserType = 4'+ #13#10 +
                  'Update UserType Set Name = ''Sales/Returns'' Where IDUserType = 13 '+ #13#10 +
                  'Update UserType Set Name = ''Salesperson/Cashier '' Where IDUserType = 16 '+ #13#10 +
                  'Update UserType Set Name = ''Trouble Shoooter'' Where IDUserType = 8 ';
   INVMOVTYPE_ENG =
                  'Update InventoryMovType Set Name = ''Automatic delete'' Where IDInventMovType = 20 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Back from Gift'' Where IDInventMovType = 15 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Back From Repair'' Where IDInventMovType = 10 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Bought'' Where IDInventMovType = 2 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Credited by Vendor'' Where IDInventMovType = 17 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Decreased QtyOnHand '' Where IDInventMovType = 3 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Deleted'' Where IDInventMovType = 18 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Gift'' Where IDInventMovType = 13 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Increased QtyOnHand'' Where IDInventMovType = 4 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Out for Repair'' Where IDInventMovType = 9 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Physical Decreased'' Where IDInventMovType = 22 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Physical Increased'' Where IDInventMovType = 21 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Reset down to zero'' Where IDInventMovType = 12 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Reset up to Zero'' Where IDInventMovType = 11 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restore QtyOnHand Down'' Where IDInventMovType = 23 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restore QtyOnHand Up'' Where IDInventMovType = 24 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restored'' Where IDInventMovType = 19 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Saida por Gift'' Where IDInventMovType = 14 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Sold'' Where IDInventMovType = 1 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Stolen'' Where IDInventMovType = 6 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''System Import'' Where IDInventMovType = 5 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Transfered IN'' Where IDInventMovType = 8 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Transfered OUT'' Where IDInventMovType = 7 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Unrepairable'' Where IDInventMovType = 16 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Canceled'' Where IDInventMovType = 25 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Service Order'' Where IDInventMovType = 50 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Store Use'' Where IDInventMovType = 26 ';


   CASHREGSTATUS_ENG =
                  'Update CashRegStatus Set CashRegStatus = ''Open'' Where IDCashRegStatus = 1 '+ #13#10 +
                  'Update CashRegStatus Set CashRegStatus = ''Closed'' Where IDCashRegStatus = 2 '+ #13#10 +
                  'Update CashRegStatus Set CashRegStatus = ''Reconciled'' Where IDCashRegStatus = 3 ';

   REP_FOLDER_ENG =
                  'UPDATE Rep_Folder SET Name = ''Point of Sale'' WHERE FolderId = 1 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Sales Support'' WHERE FolderId = 2 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Advertising'' WHERE FolderId = 3 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Purchasing'' WHERE FolderId = 4 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Inventory'' WHERE FolderId = 5 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Commissions'' WHERE FolderId = 6 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Office Manager'' WHERE FolderId = 7 ';

   REP_ITEMS_ENG1 =
                  'UPDATE Rep_Item SET Name = ''Payables Grouped by Vendors'' WHERE ItemId = 12 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Receivables by Customers'' WHERE ItemId = 14 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Bank Transactions by Bank'' WHERE ItemId = 15 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Payables by Date'' WHERE ItemId = 13 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Income vs. Spending'' WHERE ItemId = 16 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Sales Profit Year-Month-Day by Store'' WHERE ItemId = 23 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Open Layaway & Hold by Date'' WHERE ItemId = 21 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Purchase by Purchase Number'' WHERE ItemId = 11 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Back Order by Vendor & P.O. Number'' WHERE ItemId = 9 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Purchase Details by Vendor & Purchase Number'' WHERE ItemId = 10 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Marketing - Customer Purchase History'' WHERE ItemId = 26 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Cash Register Totals by Date'' WHERE ItemId = 24 ';


   REP_ITEMS_ENG2 =
                  'UPDATE Rep_Item SET Name = ''Customer Mailing Labels'' WHERE ItemId = 3 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Sales Grouping by ZipCode'' WHERE ItemId = 25 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Physical Inventory by Item'' WHERE ItemId = 29 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Barcode Generator by Item'' WHERE ItemId = 8 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Aged Inventory by Date'' WHERE ItemId = 7 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Commission by Salesperson'' WHERE ItemId = 17 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Commission Details by Salesperson & Invoice Number'' WHERE ItemId = 18 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Invoices by Date'' WHERE ItemId = 20 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Sales by Agent'' WHERE ItemId = 4 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Sales by Agency'' WHERE ItemId = 5 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Agent Results Grouping by Agency'' WHERE ItemId = 6 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Agency & Agent Invoices by Date'' WHERE ItemId = 31 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Invoice History by Date'' WHERE ItemId = 19 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Full Inventory by Item'' WHERE ItemId = 30 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Inventory Category by Category & Item'' WHERE ItemId = 28 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Category Totals by Category'' WHERE ItemId = 27 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Invoices - Payment Types by Date'' WHERE ItemId = 22 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Best Seller by Qty Sold'' WHERE ItemId = 1 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Iventory Turn Over'' WHERE ItemId = 2 ';

   CASHREGLOG_REASON_ENG =
                  'UPDATE CashRegLogReason SET Reason = ''Administrative Expenses'' WHERE IDCashRegLogReason = 1 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Janitorial & Clean-up'' WHERE IDCashRegLogReason = 2 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Office Expense'' WHERE IDCashRegLogReason = 3 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Travel Expense'' WHERE IDCashRegLogReason = 4 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Meals & Entertainment'' WHERE IDCashRegLogReason = 5 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Promotional Expense'' WHERE IDCashRegLogReason = 6 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Purchase from Customer'' WHERE IDCashRegLogReason = 7 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Repairs & Maintenance'' WHERE IDCashRegLogReason = 8';

   //PORTUGUESE ********************************
   MEIOPAG_BR =
                  'Update MeioPag Set MeioPag = ''American Express batch'' Where IDMeioPag = 16' + #13#10 +
                  'Update MeioPag Set MeioPag = ''American Express Card'' Where IDMeioPag = 3' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Dinheiro'' Where IDMeioPag = 1' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Cash deposit'' Where IDMeioPag = 14' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Cheque'' Where IDMeioPag = 5' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Diners'' Where IDMeioPag = 6' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Vale Presente'' Where IDMeioPag = 11' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Ajuste Manual'' Where IDMeioPag = 12' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Master batch'' Where IDMeioPag = 17' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Master Card'' Where IDMeioPag = 4' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Transferência'' Where IDMeioPag = -1' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Visa batch'' Where IDMeioPag = 15' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Visa Card'' Where IDMeioPag = 2';
   TIPOPESSOA_BR =
                  'Update TipoPessoa Set TipoPessoa = ''Clientes'' Where IDTipoPessoa = 1 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Fornecedores'' Where IDTipoPessoa = 2 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Comissionados'' Where IDTipoPessoa = 3 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Vendedor'' Where IDTipoPessoa = 4 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Agentes'' Where IDTipoPessoa = 5 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Agências'' Where IDTipoPessoa = 6 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Fabricantes'' Where IDTipoPessoa = 7 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Outros'' Where IDTipoPessoa = 9 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Retorno'' Where IDTipoPessoa = 21 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Local/Freelance'' Where IDTipoPessoa = 24';
   TIPOPESSOAPATH_BR =
                  'Update TipoPessoa Set PathName = ''\ Comissões'' Where IDTipoPessoa = 3 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Comissões\ Agências'' Where IDTipoPessoa = 6 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Comissões\ Local/Freelance'' Where IDTipoPessoa = 24 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Comissões\ outros'' Where IDTipoPessoa =  9 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Comissões\ Agentes'' Where IDTipoPessoa = 5 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Comissões\ Vendedor'' Where IDTipoPessoa = 4 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Clientes'' Where IDTipoPessoa = 1 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Fabricantes'' Where IDTipoPessoa = 7 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Fornecedores'' Where IDTipoPessoa = 2 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Fornecedores\ Retorno'' Where IDTipoPessoa = 21 ';
   MEDIA_BR =
                  'Update Media Set Media = ''Folheto'' Where IDMedia = 5 '+ #13#10 +
                  'Update Media Set Media = ''Funcionário'' Where IDMedia = 10 '+ #13#10 +
                  'Update Media Set Media = ''Venda Expressa'' Where IDMedia =  20  '+ #13#10 +
                  'Update Media Set Media = ''Internet'' Where IDMedia =  16 '+ #13#10 +
                  'Update Media Set Media = ''Agência'' Where IDMedia = 1 '+ #13#10 +
                  'Update Media Set Media = ''Cliente Anterior'' Where IDMedia = 9 '+ #13#10 +
                  'Update Media Set Media = ''Cliente Revenda'' Where IDMedia = 11 '+ #13#10 +
                  'Update Media Set Media = ''Letreiro'' Where IDMedia = 3 '+ #13#10 +
                  'Update Media Set Media = ''Shopping'' Where IDMedia = 7 '+ #13#10 +
                  'Update Media Set Media = ''Boca a Boca'' Where IDMedia = 6 ';
   USERTYPE_BR =
                  'Update UserType Set Name = ''Administrador'' Where IDUserType = 1 '+ #13#10 +
                  'Update UserType Set Name = ''Assistente do Gerente'' Where IDUserType = 6 '+ #13#10 +
                  'Update UserType Set Name = ''Comprador'' Where IDUserType = 10 '+ #13#10 +
                  'Update UserType Set Name = ''Caixa'' Where IDUserType = 3 '+ #13#10 +
                  'Update UserType Set Name = ''Caixa/OC'' Where IDUserType = 5 '+ #13#10 +
                  'Update UserType Set Name = ''Gerente'' Where IDUserType = 2 '+ #13#10 +
                  'Update UserType Set Name = ''Perfumes'' Where IDUserType = 15'+ #13#10 +
                  'Update UserType Set Name = ''Relações Públicas'' Where IDUserType = 7 '+ #13#10 +
                  'Update UserType Set Name = ''Vendedor'' Where IDUserType = 4'+ #13#10 +
                  'Update UserType Set Name = ''Vendas/Retornos'' Where IDUserType = 13 '+ #13#10 +
                  'Update UserType Set Name = ''Vendedor/Caixa'' Where IDUserType = 16 '+ #13#10 +
                  'Update UserType Set Name = ''Suporte'' Where IDUserType = 8 ';
   INVMOVTYPE_BR =
                  'Update InventoryMovType Set Name = ''Deleta Automáticamente'' Where IDInventMovType = 20 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Volta do Presente'' Where IDInventMovType = 15 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Volta do Conserto'' Where IDInventMovType = 10 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Comprado'' Where IDInventMovType = 2 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Creditado pelo Fornecedor'' Where IDInventMovType = 17 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Qtd Diminuída'' Where IDInventMovType = 3 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Removida'' Where IDInventMovType = 18 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Presente'' Where IDInventMovType = 13 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Qtd Aumentada'' Where IDInventMovType = 4 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Enviado para Conserto'' Where IDInventMovType = 9 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Estoque Diminuído'' Where IDInventMovType = 22 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Estoque Aumentado'' Where IDInventMovType = 21 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Diminuído para Zero'' Where IDInventMovType = 12 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Aumentado para Zero'' Where IDInventMovType = 11 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Abaixado o Estoque'' Where IDInventMovType = 23 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Elevado o Estoque'' Where IDInventMovType = 24 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restaurado'' Where IDInventMovType = 19 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Saída como Presente'' Where IDInventMovType = 14 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Vendido'' Where IDInventMovType = 1 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Roubado'' Where IDInventMovType = 6 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Importado do Sistema'' Where IDInventMovType = 5 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Entrada Transf'' Where IDInventMovType = 8 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Saída Transf'' Where IDInventMovType = 7 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Sem Conserto'' Where IDInventMovType = 16 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Cancelado'' Where IDInventMovType = 25 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Ordem de Serviço'' Where IDInventMovType = 50 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Usado'' Where IDInventMovType = 26 ';

   CASHREGSTATUS_BR =
                  'Update CashRegStatus Set CashRegStatus = ''Aberta'' Where IDCashRegStatus = 1 '+ #13#10 +
                  'Update CashRegStatus Set CashRegStatus = ''Fechada'' Where IDCashRegStatus = 2 '+ #13#10 +
                  'Update CashRegStatus Set CashRegStatus = ''Conferida'' Where IDCashRegStatus = 3 ';

   REP_FOLDER_BR =
                  'UPDATE Rep_Folder SET Name = ''Vendas'' WHERE FolderId = 1 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Apoio a Vendas'' WHERE FolderId = 2 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Mídia'' WHERE FolderId = 3 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Compras'' WHERE FolderId = 4 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Inventário'' WHERE FolderId = 5 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Comissões'' WHERE FolderId = 6 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Office Manager'' WHERE FolderId = 7 ';

   REP_ITEMS_BR1 =
                  'UPDATE Rep_Item SET Name = ''Contas a Pagar agrupadas por Fornecedores'' WHERE ItemId = 12 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Contas a Receber agrupadas por Clientes'' WHERE ItemId = 14 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Transações Bancárias agrupadas por Banco'' WHERE ItemId = 15 '+ #13#10 +
                  //'UPDATE Rep_Item SET Name = ''Sumário de Contas a Pagar agrupadas por Mês'' WHERE ItemId = 4 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Contas a Pagar agrupadas por data'' WHERE ItemId = 13 '+ #13#10 +
                  //'UPDATE Rep_Item SET Name = ''Tipos de gastos agrupados por Mês'' WHERE ItemId = 6 '+ #13#10 +
                  //'UPDATE Rep_Item SET Name = ''Fluxo de Caixa agrupados por Mês'' WHERE ItemId = 7 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Entradas vs. Gastos'' WHERE ItemId = 16 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Lucro Ano-Mês-Dia por loja'' WHERE ItemId = 23 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Crediário e Guias em transito por data'' WHERE ItemId = 21 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total de Compras por Nº de Compra'' WHERE ItemId = 11 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Compras em aberto por Nº de Ordem de Compra'' WHERE ItemId = 9 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Detalhes das compras por Fornecedor & Nº de OC'' WHERE ItemId = 10 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Marketing - Histórico de compras do Cliente'' WHERE ItemId = 26 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Totais da Caixa Registradora por data'' WHERE ItemId = 24 ';

   REP_ITEMS_BR2 =
                  'UPDATE Rep_Item SET Name = ''Etiquetas de Correios dos Clientes'' WHERE ItemId = 3 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Totais das Vendas agrupados por CEP'' WHERE ItemId = 25 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Ver Inventário Físico por item'' WHERE ItemId = 29 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Gerar Código de Barras por item'' WHERE ItemId = 8 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Idade do Inventário por data'' WHERE ItemId = 7 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total das comissões por Vendedor'' WHERE ItemId = 17 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Detalhe das comissões por Vendedor & Nº de Nota'' WHERE ItemId = 18 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Notas por data'' WHERE ItemId = 20 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Totais de vendas por Agentes '' WHERE ItemId = 4 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Totais de vendas por Agencia '' WHERE ItemId = 5 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Resultado dos Agentes agrupados por Agencias'' WHERE ItemId = 6 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Notas de Agencias e Agentes por data'' WHERE ItemId = 31 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Histórico das Notas por data'' WHERE ItemId = 19 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Inventário completo por item'' WHERE ItemId = 30 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Inventário por Categorias & itens'' WHERE ItemId = 28 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Totais das Categorias por Categoria'' WHERE ItemId = 27 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Notas - Tipos de pagamentos por data'' WHERE ItemId = 22 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Item de melhor venda por Qtd vendida'' WHERE ItemId = 1 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Giro de Estoque'' WHERE ItemId = 2 ';

   CASHREGLOG_REASON_BR =
                  'UPDATE CashRegLogReason SET Reason = ''Despesas administrativas'' WHERE IDCashRegLogReason = 1 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Material de limpesa'' WHERE IDCashRegLogReason = 2 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Despesa de escritório'' WHERE IDCashRegLogReason = 3 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Despesa de viagem'' WHERE IDCashRegLogReason = 4 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Refeições'' WHERE IDCashRegLogReason = 5 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Despesa Promocionais'' WHERE IDCashRegLogReason = 6 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Compra do cliente'' WHERE IDCashRegLogReason = 7 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Reparos & manutenção'' WHERE IDCashRegLogReason = 8';

   //SPANISH ********************************
   MEIOPAG_SPN =
                  'Update MeioPag Set MeioPag = ''American Express batch'' Where IDMeioPag = 16' + #13#10 +
                  'Update MeioPag Set MeioPag = ''American Express Card'' Where IDMeioPag = 3' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Cash'' Where IDMeioPag = 1' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Cash deposit'' Where IDMeioPag = 14' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Check'' Where IDMeioPag = 5' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Diners'' Where IDMeioPag = 6' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Gift Certificate'' Where IDMeioPag = 11' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Manual Balance Adjustment'' Where IDMeioPag = 12' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Master batch'' Where IDMeioPag = 17' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Master Card'' Where IDMeioPag = 4' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Transfer'' Where IDMeioPag = -1' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Visa batch'' Where IDMeioPag = 15' + #13#10 +
                  'Update MeioPag Set MeioPag = ''Visa Card'' Where IDMeioPag = 2';
   TIPOPESSOA_SPN =
                  'Update TipoPessoa Set TipoPessoa = ''Customers'' Where IDTipoPessoa = 1 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Vendors'' Where IDTipoPessoa = 2 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Commissions'' Where IDTipoPessoa = 3 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Sales Person'' Where IDTipoPessoa = 4 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Agents'' Where IDTipoPessoa = 5 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Agencies'' Where IDTipoPessoa = 6 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Manufacturers'' Where IDTipoPessoa = 7 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Other'' Where IDTipoPessoa = 9 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Returns'' Where IDTipoPessoa = 21 '+ #13#10 +
                  'Update TipoPessoa Set TipoPessoa = ''Local/Freelance'' Where IDTipoPessoa = 24';
   TIPOPESSOAPATH_SPN =
                  'Update TipoPessoa Set PathName = ''\ Commissions'' Where IDTipoPessoa = 3 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Agencies'' Where IDTipoPessoa = 6 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Local/Freelance'' Where IDTipoPessoa = 24 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Other'' Where IDTipoPessoa =  9 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Outside Agents'' Where IDTipoPessoa = 5 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Commissions\ Sales Person'' Where IDTipoPessoa = 4 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Customers'' Where IDTipoPessoa = 1 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Manufacturers'' Where IDTipoPessoa = 7 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Vendors'' Where IDTipoPessoa = 2 '+ #13#10 +
                  'Update TipoPessoa Set PathName = ''\ Vendors\ Returns'' Where IDTipoPessoa = 21 ';
   MEDIA_SPN =
                  'Update Media Set Media = ''Brochure'' Where IDMedia = 5 '+ #13#10 +
                  'Update Media Set Media = ''Employee'' Where IDMedia = 10 '+ #13#10 +
                  'Update Media Set Media = ''Express Sale'' Where IDMedia =  20  '+ #13#10 +
                  'Update Media Set Media = ''Internet'' Where IDMedia =  16 '+ #13#10 +
                  'Update Media Set Media = ''Outside Agency'' Where IDMedia = 1 '+ #13#10 +
                  'Update Media Set Media = ''Previous Customer'' Where IDMedia = 9 '+ #13#10 +
                  'Update Media Set Media = ''Resale Customer'' Where IDMedia = 11 '+ #13#10 +
                  'Update Media Set Media = ''Sign'' Where IDMedia = 3 '+ #13#10 +
                  'Update Media Set Media = ''Walk In'' Where IDMedia = 7 '+ #13#10 +
                  'Update Media Set Media = ''Word of mouth'' Where IDMedia = 6 ';
   USERTYPE_SPN =
                  'Update UserType Set Name = ''Administrator'' Where IDUserType = 1 '+ #13#10 +
                  'Update UserType Set Name = ''Assistant Manager'' Where IDUserType = 6 '+ #13#10 +
                  'Update UserType Set Name = ''Buyer'' Where IDUserType = 10 '+ #13#10 +
                  'Update UserType Set Name = ''Cashier'' Where IDUserType = 3 '+ #13#10 +
                  'Update UserType Set Name = ''Cashier/PO'' Where IDUserType = 5 '+ #13#10 +
                  'Update UserType Set Name = ''Manager'' Where IDUserType = 2 '+ #13#10 +
                  'Update UserType Set Name = ''Perfumes'' Where IDUserType = 15'+ #13#10 +
                  'Update UserType Set Name = ''Public Relations'' Where IDUserType = 7 '+ #13#10 +
                  'Update UserType Set Name = ''Sales Person'' Where IDUserType = 4'+ #13#10 +
                  'Update UserType Set Name = ''Sales/Returns'' Where IDUserType = 13 '+ #13#10 +
                  'Update UserType Set Name = ''Salesperson/Cashier '' Where IDUserType = 16 '+ #13#10 +
                  'Update UserType Set Name = ''Trouble Shoooter'' Where IDUserType = 8 ';
   INVMOVTYPE_SPN =
                  'Update InventoryMovType Set Name = ''Automatic delete'' Where IDInventMovType = 20 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Back from Gift'' Where IDInventMovType = 15 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Back From Repair'' Where IDInventMovType = 10 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Bought'' Where IDInventMovType = 2 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Credited by Vendor'' Where IDInventMovType = 17 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Decreased QtyOnHand '' Where IDInventMovType = 3 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Deleted'' Where IDInventMovType = 18 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Gift'' Where IDInventMovType = 13 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Increased QtyOnHand'' Where IDInventMovType = 4 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Out for Repair'' Where IDInventMovType = 9 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Physical Decreased'' Where IDInventMovType = 22 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Physical Increased'' Where IDInventMovType = 21 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Reset down to zero'' Where IDInventMovType = 12 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Reset up to Zero'' Where IDInventMovType = 11 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restore QtyOnHand Down'' Where IDInventMovType = 23 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restore QtyOnHand Up'' Where IDInventMovType = 24 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Restored'' Where IDInventMovType = 19 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Saida por Gift'' Where IDInventMovType = 14 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Sold'' Where IDInventMovType = 1 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Stolen'' Where IDInventMovType = 6 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''System Import'' Where IDInventMovType = 5 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Transfered IN'' Where IDInventMovType = 8 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Transfered OUT'' Where IDInventMovType = 7 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Unrepairable'' Where IDInventMovType = 16 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Cancelado'' Where IDInventMovType = 25 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Ordem de Servicio'' Where IDInventMovType = 50 '+ #13#10 +
                  'Update InventoryMovType Set Name = ''Usado'' Where IDInventMovType = 26 ';

   CASHREGSTATUS_SPN =
                  'Update CashRegStatus Set CashRegStatus = ''Abierta'' Where IDCashRegStatus = 1 '+ #13#10 +
                  'Update CashRegStatus Set CashRegStatus = ''Cerrada'' Where IDCashRegStatus = 2 '+ #13#10 +
                  'Update CashRegStatus Set CashRegStatus = ''Confirmado'' Where IDCashRegStatus = 3 ';

   REP_FOLDER_SPN =
                  'UPDATE Rep_Folder SET Name = ''Ventas'' WHERE FolderId = 1 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Data Ventas'' WHERE FolderId = 2 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Medios'' WHERE FolderId = 3 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Compras'' WHERE FolderId = 4 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Inventario'' WHERE FolderId = 5 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Comisiones'' WHERE FolderId = 6 '+ #13#10 +
                  'UPDATE Rep_Folder SET Name = ''Office Manager'' WHERE FolderId = 7 ';

   REP_ITEMS_SPN1 =
                  'UPDATE Rep_Item SET Name = ''Payables Grouped by Vendors'' WHERE ItemId = 12 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Receivables by Customers'' WHERE ItemId = 14 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Bank Transactions by Bank'' WHERE ItemId = 15 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Payables Aging Summary by Month'' WHERE ItemId = 4 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Payables by Date'' WHERE ItemId = 13 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Expenses Type by Month'' WHERE ItemId = 6 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Cash Flow by Month'' WHERE ItemId = 7 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Income vs. Spending'' WHERE ItemId = 16 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Sales Profit Year-Month-Day by Store'' WHERE ItemId = 23 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Open Layaway & Hold by Date'' WHERE ItemId = 21 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Purchase by Purchase Number'' WHERE ItemId = 11 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Back Order by Vendor & P.O. Number'' WHERE ItemId = 9 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Purchase Details by Vendor & Purchase Number'' WHERE ItemId = 10 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Marketing - Customer Purchase History'' WHERE ItemId = 26 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Cash Register Totals by Date'' WHERE ItemId = 24 ';


   REP_ITEMS_SPN2 =
                  'UPDATE Rep_Item SET Name = ''Customer Mailing Labels'' WHERE ItemId = 3 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Sales Grouping by ZipCode'' WHERE ItemId = 25 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Physical Inventory by Item'' WHERE ItemId = 29 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Barcode Generator by Item'' WHERE ItemId = 8 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Aged Inventory by Date'' WHERE ItemId = 7 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Commission by Salesperson'' WHERE ItemId = 17 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Commission Details by Salesperson & Invoice Number'' WHERE ItemId = 18 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Invoices by Date'' WHERE ItemId = 20 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Sales by Agent'' WHERE ItemId = 4 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Total Sales by Agency'' WHERE ItemId = 5 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Agent Results Grouping by Agency'' WHERE ItemId = 6 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Agency & Agent Invoices by Date'' WHERE ItemId = 31 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Invoice History by Date'' WHERE ItemId = 19 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Full Inventory by Item'' WHERE ItemId = 30 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Inventory Category by Category & Item'' WHERE ItemId = 28 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Category Totals by Category'' WHERE ItemId = 27 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Payment Types by Date'' WHERE ItemId = 22 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Best Seller by Qty Sold'' WHERE ItemId = 1 '+ #13#10 +
                  'UPDATE Rep_Item SET Name = ''Iventory Turn Over'' WHERE ItemId = 2 ';

   CASHREGLOG_REASON_SPN =
                  'UPDATE CashRegLogReason SET Reason = ''Costos administrativos'' WHERE IDCashRegLogReason = 1 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Porteril y limpieza'' WHERE IDCashRegLogReason = 2 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Costo de oficina'' WHERE IDCashRegLogReason = 3 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Costo de recorrido'' WHERE IDCashRegLogReason = 4 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Comidas y hospitalidad'' WHERE IDCashRegLogReason = 5 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Costo promocional'' WHERE IDCashRegLogReason = 6 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Compra del cliente'' WHERE IDCashRegLogReason = 7 '+ #13#10 +
                  'UPDATE CashRegLogReason SET Reason = ''Reparaciones y mantenimiento'' WHERE IDCashRegLogReason = 8';


procedure TranslateDatabase(Language:Integer; Query: TADOQuery);

implementation

procedure TranslateDatabase(Language:Integer; Query: TADOQuery);
begin
   Case Language of
     LANG_ENGLISH: begin
                   with Query do
                      begin
                      if Active then
                         Close;
                      try
                        Connection.BeginTrans;
                        SQL.Text := MEIOPAG_ENG;
                        ExecSQL;
                        SQL.Text := TIPOPESSOA_ENG;
                        ExecSQL;
                        SQL.Text := TIPOPESSOAPATH_ENG;
                        ExecSQL;
                        SQL.Text := MEDIA_ENG;
                        ExecSQL;
                        SQL.Text := USERTYPE_ENG;
                        ExecSQL;
                        SQL.Text := INVMOVTYPE_ENG;
                        ExecSQL;
                        SQL.Text := CASHREGSTATUS_ENG;
                        ExecSQL;
                        SQL.Text := REP_FOLDER_ENG;
                        ExecSQL;
                        SQL.Text := REP_ITEMS_ENG1;
                        ExecSQL;
                        SQL.Text := REP_ITEMS_ENG2;
                        ExecSQL;
                        SQL.Text := CASHREGLOG_REASON_ENG;
                        ExecSQL;
                        Connection.CommitTrans;
                      except
                        Connection.RollbackTrans;
                        end;
                      end;
                   end; //End Engligh

     LANG_PORTUGUESE: begin
                   with Query do
                      begin
                      if Active then
                         Close;
                      try
                        Connection.BeginTrans;
                        SQL.Text := MEIOPAG_BR;
                        ExecSQL;
                        SQL.Text := TIPOPESSOA_BR;
                        ExecSQL;
                        SQL.Text := TIPOPESSOAPATH_BR;
                        ExecSQL;
                        SQL.Text := MEDIA_BR;
                        ExecSQL;
                        SQL.Text := USERTYPE_BR;
                        ExecSQL;
                        SQL.Text := INVMOVTYPE_BR;
                        ExecSQL;
                        SQL.Text := CASHREGSTATUS_BR;
                        ExecSQL;
                        SQL.Text := REP_FOLDER_BR;
                        ExecSQL;
                        SQL.Text := REP_ITEMS_BR1;
                        ExecSQL;
                        SQL.Text := REP_ITEMS_BR2;
                        ExecSQL;
                        SQL.Text := CASHREGLOG_REASON_BR;
                        ExecSQL;
                        Connection.CommitTrans;
                      except
                        Connection.RollbackTrans;
                        end;
                      end;
                   end; //End Portuguese

     LANG_SPANISH: begin
                   with Query do
                      begin
                      if Active then
                         Close;
                      try
                        Connection.BeginTrans;
                        SQL.Text := MEIOPAG_SPN;
                        ExecSQL;
                        SQL.Text := TIPOPESSOA_SPN;
                        ExecSQL;
                        SQL.Text := TIPOPESSOAPATH_SPN;
                        ExecSQL;
                        SQL.Text := MEDIA_SPN;
                        ExecSQL;
                        SQL.Text := USERTYPE_SPN;
                        ExecSQL;
                        SQL.Text := INVMOVTYPE_SPN;
                        ExecSQL;
                        SQL.Text := CASHREGSTATUS_SPN;
                        ExecSQL;
                        SQL.Text := REP_FOLDER_SPN;
                        ExecSQL;
                        SQL.Text := REP_ITEMS_SPN1;
                        ExecSQL;
                        SQL.Text := REP_ITEMS_SPN2;
                        ExecSQL;
                        SQL.Text := CASHREGLOG_REASON_SPN;
                        ExecSQL;
                        Connection.CommitTrans;
                      except
                        Connection.RollbackTrans;
                        end;
                      end;
                   end; //End Spanish
   end;

end;

end.
