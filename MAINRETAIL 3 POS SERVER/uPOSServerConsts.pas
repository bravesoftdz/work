unit uPOSServerConsts;

interface

uses Messages;


const

  SCH_SERVER           = 'ServerSchedule';
  SCH_POS              = 'POSSchedule';


  MR_HST_CONT_FAIL     = 'Local Connection fail. ';
  MR_HST_SVR_CONT_FAIL = 'Server Connection fail. ';
  MR_HST_JOB_FAIL      = 'Job fail : ';
  MR_HST_VPN_FAIL      = 'VPN fail to connect.';
  MR_HST_OK            = ' succeed. ';
  MR_HST_ERROR         = 'Error: ';


  HISTORY_FILE         = 'history.txt';
  ERROR_FILE           = 'historyerror.txt';
  IMPORT_FILE          = 'historyimport.txt';
  WM_ICONMESSAGE       = WM_USER + 1;

  REG_PATH             = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

  PDV_PERSISTENCE_FILE = 'MRPDVPersistence.ini';
  PDV_GLOBAL_DIR       = 'PDVFiles\';

  POS_DIR_FILES          = 'LogFiles\';
  POS_DIR_FILES_HISTORY  = 'LogFilesHistory\';
  POS_PDV_KEY            = 'PDVTerminals';
  POS_PDV_KEY_LAST_FILE  = 'LastImportedFileName';
  POS_PDV_KEY_LAST_DATE  = 'LastImportedFileDate';
  POS_LAST_IMPORT_DATE   = 'LastImportDate';


  //Arquivos Globais
  PDV_MEDIA_FILE             = 'Media';
  PDV_SYSTEM_USER_FILE       = 'SystemUser';
  PDV_OTHER_COMMIS_FILE      = 'OtherCommission';
  PDV_CUSTOMER_FILE          = 'Customer';
  PDV_PARAM_FILE             = 'Param';
  PDV_STORE_FILE             = 'Store';
  PDV_USER_TO_SYS_FILE       = 'UserTypeToSysFunction';
  PDV_USER_RIGHTS_FILE       = 'UserRights';
  PDV_MODEL_FILE             = 'Model';
  PDV_BARCODE_FILE           = 'Barcode';
  PDV_ACCESSORY_FILE         = 'ModelAccessory';
  PDV_PAY_TYPR_FILE          = 'MeioPag';
  PDV_QTY_FILE               = 'Quantity';
  PDV_CASHREGISTER_FILE      = 'CashRegister';
  PDV_ACCES_FILE             = 'Access';
  PDV_TAXCATEGORY_FILE       = 'TaxCategory';
  PDV_KITMODEL_FILE          = 'KitModel';
  PDV_BANK_FILE              = 'Fin_Banco';
  PDV_DISCRANGE_FILE         = 'DiscRange';
  PDV_INV_FEATURES_FILE      = 'InvFeatures';
  PDV_INV_TECH_FEATURES_FILE = 'InvTechFeatures';
  PDV_INV_DEPARTMENT         = 'InvDepartment';
  PDV_INV_MODEL_DEPARTMENT   = 'InvModelDepartment';
  PDV_INV_MODEL_SERIAL       = 'InventorySerial';
  PDV_INV_STORE_PRICE        = 'InvStoreTablePrice';
  PDV_INV_MODEL_PRICE        = 'InvModelTablePrice';
  PDV_MNT_DOCUMENT_TYPE      = 'MntDocumentType';  
  PDV_CASH_REG_LOG_REASON    = 'CashRegLogReason';
  PDV_PAY_TYPE_MIN_SALE      = 'MeioPagMinSale';  

  CUPOM_VAZIO                = 'XXXXXX';

  CONFIG_FILE    = 'posserver.ini';
  CONFIG_PDV_FILE= 'pdvhistory.ini';
  MR_SYSTEM_TIP  = 'MainRetail POS Server';


  SV_CONNECTION = '#CNT#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_CLOSE_VPN  = '#CVPN#=';

  SINC_TYPE_SERVER    = 0;
  SINC_TYPE_CASH_LOG  = 1;

  CON_TYPE_SERVER = 0;
  CON_TYPE_FTP    = 1;



implementation

end.
