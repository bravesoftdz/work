unit uInvoicePollDisplayConst;

interface

const
  INV_CLEAR = 'CLEAR';
  INV_HEADER = 'Invoice';
  INV_SALE_CODE = 'SaleCode';
  INV_DATE = 'Date';
  INV_SUBTOTAL = 'SubTotal';
  INV_TAXTOTAL = 'Tax';
  INV_DISCOUNTTOTAL = 'Discount';
  INV_ADDEXPENSES = 'AddExpenses';
  INV_GRAND_TOTAL = 'GrandTotal';

  INV_TOTAL_ITEM = 'TotalItems';
  INV_COUNT_PAYMENTS = 'CountPayments';

  ITEM_HEADER = 'Item';
  ITEM_ID = 'ID';
  ITEM_IDMODEL = 'IDModel';
  ITEM_MODEL = 'ModelNum';
  ITEM_DESCRIPTION = 'Description';
  ITEM_QTY = 'Qty';
  ITEM_SALEPRICE = 'SalePrice';
  ITEM_DISCOUNT = 'Discount';
  ITEM_TOTAL = 'ItemSubtotal';

  PAYMENT_HEADER = 'HeaderPayment';
  PAYMENT_ID = 'ID';
  PAYMENT_PAYMENT = 'PaymentName';
  PAYMENT_AMOUNT = 'Amount';

  //SERVER
  SVR_POLE_DISPLAY_CLIENT = 'PoleID';
  SVR_POLE_DISPLAY_CLIENT_IP = 'Pole_IP';
  SVR_POLE_DISPLAY_CLIENT_DESCRIPTION = 'Pole_Desc';
  SVR_POLE_DISPLAY_CLIENT_PORT = 'Pole_Port';

  //CROSS SELL
  CROSS_SELL          = 'CrossSell';
  CROSS_SELL_ITEM     = 'Cross_Model';
  CROSS_SELL_REGISTER = 'Cross_Reg';

  //CROSS_ITEMS
  CROSS_ITEMS  = 'CrossItem';
  CROSS_ITEMS_COUNT = 'Cross_Item_Count';
  CROSS_ITEMS_FILE = 'Cross_Item_File';
  CROSS_ITEMS_TYPE = 'Cross_Item_Type';
  CROSS_ITEMS_TIME = 'Cross_Item_Time';

  //ADVERTISING
  ADVERTISING = 'Advertising';
  ADVERTISING_LIST = 'Adv_List';
  ADVERTISING_ID = 'Adv_ID';
  ADVERTISING_DESCRIPTION = 'Adv_Desc';
  ADVERTISING_FILENAME = 'Adv_FileName';
  ADVERTISING_STARTDATE = 'Adv_Start_Date';
  ADVERTISING_ENDDATE = 'Adv_End_Date';
  ADVERTISING_DAYS_OF_WEEK = 'Adv_Days_Week';
  ADVERTISING_TYPE = 'Adv_Type';
  ADVERTISING_DURATION = 'Adv_Duration';
  ADVERTISING_VIDEO_CONTROL = 'Adv_Video_Control';
  ADVERTISING_DISPLAY_DESC = 'Adv_Display_Desc';
  ADVERTISING_HOUR = 'Adv_Hours';

  STATE_WAITING_HEADER = 0;
  STATE_WAITING_BODY = 1;

implementation

end.
