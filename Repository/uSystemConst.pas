unit uSystemConst;

interface

uses Messages;

const

  //Update Pack 3
  SQL_REG_PATH = 'Software\Microsoft\MSSQLServer\MSSQLServer\CurrentVersion';
  SQL_GO       = 'GO';

  //Main Retail ID fields
  MR_INVENTORY_MOV_ID = 'InventoryMov.IDInventoryMov';
  MR_GROUP_COST_ID    = 'GroupCost.IDCost';
  MR_TIME_CONTROL_ID  = 'TMC_TimeControl.IDTime';
  MR_MODEL_ID         = 'Model.IDModel';
  MR_PESSOA_ID        = 'Pessoa.IDPessoa';
  MR_SYSTEMUSER_ID    = 'SystemUser.IDUser';
  MR_STORE_ID         = 'Store.IDStore';
  MR_TAX_CATEG_ID     = 'TaxCategory.IDTaxCategory';
  MR_CASH_REG_ID      = 'CashRegister.IDCashRegister';
  MR_CATEGORY_ID      = 'TabGroup.IDGroup';
  MR_REQUEST_ID       = 'Request.IDRequest';
  MR_PRESALE_ID       = 'Invoice.IDPreSale';
  MR_APPHISTORY_ID    = 'Sis_AppHistory.IDHistory';
  MR_PURCHASE_ITEM_ID = 'Pur_PurchaseItem.IDPurchaseItem';

  OM_LANCAMENTO_ID    = 'Fin_Lancamento.IDLancamento';
  OM_REPORT_ID        = 'Rep_Item.ItemId';

  APPLENET_REGISTRY_KEY = 'SOFTWARE\AppleNet';

  COD_GERAL= '_COD_GERAL';

  WM_Start = WM_USER+100;

  INC_VALUE = '*';

  DAY_ADJUST = 1 -(1/86400);

  ORDER_AUTO = -1;
  ORDER_ASC  = 0;
  ORDER_DESC = 1;

  //Type of Payment
  PAYMENT_TYPE_CASH      = 1;
  PAYMENT_TYPE_CARD      = 2;
  PAYMENT_TYPE_OTHER     = 3;
  PAYMENT_TYPE_CHECK     = 4;

  QuitacaoMeioTipo_Especie  = 1;
  QuitacaoMeioTipo_Cartao   = 2;
  QuitacaoMeioTipo_Outros   = 3;
  QuitacaoMeioTipo_Cheque   = 4;

  SIS_IDMOEDA_PADRAO        = 4;
  SIS_IDMOEDACOTACAO_PADRAO = 6;

  ffValor     = '#,##0.00;-#,##.00;0.00';
  ffQtde      = '#,##0.00;-#,##.00;0.00';
  ffDataHora  = 'ddddd hh:mm';
  ffHora      = '#,##0.0;-#,##.0;0.0';
  ffPerc      = '#,##0.00 %';
  fdSQLDate   = 'yyyymmdd';


  MaxModulos = 200;
  
  //Main menu navigator
  WEB_PRIOR  = 0;
  WEB_NEXT   = 1;

  // Constantes do MainRetail Copatibilidade
  USER_TYPE_MANAGER        = 2;
  USER_TYPE_ASSIST_MANAGER = 6; // ** Ivanil
  USER_TYPE_CASHIER        = 3; // ** Ivanil
  USER_TYPE_CASHIER_PO     = 5; // ** Ivanil

  PESSOA_TIPO_CLIENTE      = 1;
  PESSOA_TIPO_FORNECEDOR   = 2;
  PESSOA_TIPO_COMISSIONADO = 3;
  PESSOA_TIPO_VENDEDOR     = 4;
  PESSOA_TIPO_GUIA         = 5;
  PESSOA_TIPO_AGENCIA      = 6;
  PESSOA_TIPO_FABRICANTE   = 7;

  PARAM_TAX              = 1;
  PARAM_SALEONNEGATIVE   = 2;
  PARAM_FASTSALE         = 3;
  PARAM_REFRESHONINSERT  = 4;
  PARAM_REFRESHINTERVAL  = 5;
  PARAM_REFRESHBROWSE    = 6;
  PARAM_MAXROWS          = 7;
  PARAM_MODIFYCOST       = 8;
  PARAM_CASHREGRESTANT   = 9;
  PARAM_LICENSE          = 10;
  PARAM_MAXCASHALLOWED   = 11;
  PARAM_CLOSECASHRANDOM  = 12;
  PARAM_MAXQTYCOMPUTERREQ = 13;
  PARAM_MINSALECOMPUTERREQ = 14;
  PARAM_INCLUDEPREPURCHASE = 15;
  PARAM_USE_FRACTIONARY_QTY = 85;

  SUGG_CLASS = 'CLASS';
  SUGG_NAME  = 'NAME';
  SUGG_VALUE = 'VALUE';

  QUICK_REP_TOTALSALES = 1;
  QUICK_REP_ITEMSHOLD  = 2;
  QUICK_REP_ITEMSPO    = 3;




implementation

end.
