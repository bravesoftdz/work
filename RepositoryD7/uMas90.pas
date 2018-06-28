unit uMas90;

interface

uses Sysutils, classes, grids;

type
   TMas90EntityColumns = array[0..98] of String;

   TMas90FileType      = (Mas90_FILE_TYPE_CUSTOMER,
                          Mas90_FILE_TYPE_PAYMENT,
                          Mas90_FILE_TYPE_SALE_INVOICE);


const

 {CHART_OF_ACCOUNT_CASH       = 0;  //Cash
 CHART_OF_ACCOUNT_RECEIVABLE = 1;  //Receivable (Accounts Receivable)
 CHART_OF_ACCOUNT_INVENTORY  = 2;  //Inventory
 CHART_OF_ACCOUNT_INCOME     = 21; //Income
 CHART_OF_ACCOUNT_EXPENSES   = 24; //Expense  }

  {
  0 => Cash
  1 => Receivable (Accounts Receivable)
  2 => Inventory
  3 => Unused1 (Do not select)
  4 =>OthCurAsset (Other Current Assets)
  5 => FixedAsset (Fixed Assets)
  6 => AccumDepr (Accumulated Depreciation)
  7 => Unused2 (Do not select)
  8 => OtherAssets (Other Assets)
  9 => Unused4 (Do not select)
  10 => Payable (Accounts Payable)
  11 => OthCurLiability (Other Current Liabilities)
  12 => Unused6 (Do not select)
  13 => OthLiability (Long Term Liabilities)
  14 => Unused7 (Do not select)
  15 => EquityNoClose (Equity - Doesn't Close)),
  16 => Unused8 (Do not select)
  17 => RetEarn (Equity - Retained Earnings
  18 => EquityClose (Equity - Gets Closed))
  19 => Unused9 (Do not select)
  20 => Income
  21 => Unused10 (Do not select)
  22 => CostSales (Cost of Sales)
  23 => Expense
  }

   AMas90EntityColumns : TMas90EntityColumns = ('Division_No',
                                                'Customer_No',
                                                'Name',
                                                'Address1',
                                                'Address2',
                                                'City',
                                                'State',
                                                'Zip_Code',
                                                'Phone_No',
                                                'Terms_Code',
                                                'Open_Item',
                                                'Country_Code',
                                                'Tax_Schedule',
                                                'Tax_Exempt_No',
                                                'Shipping_Method',
                                                'Fax_Number',
                                                'Email_Address',
                                                'Salesprsn_No',
                                                'Default_SLS_CD',
                                                'Cust_Type',
                                                'Price_Level',

                                                'Bank_Code',
                                                'Deposit_Number',
                                                'Division_No',
                                                'Customer_No',
                                                'Customer_Name',
                                                'Batch_Number',
                                                'Invoice_No',
                                                'Amount_Posted',
                                                'Dep_Post_Date',
                                                'Document_No',
                                                'Deposit_Type',
                                                'Payment_Type',
                                                'Deposit_Balance',
                                                'Cust_Post_Amt',

                                                'Invoice_No',
                                                'Invoice_Date',
                                                'Division_No',
                                                'Customer_No',
                                                'Default_Whse',
                                                'Tax_Schedule',
                                                'Terms_Code',
                                                'Salesprsn',
                                                'Line_Type',
                                                'Item_Number',
                                                'Discount',
                                                'Subj_to_Exempt',
                                                'WareHouse_Code',
                                                'Cost_Type',
                                                'Product_Line',
                                                'Unit_of_Measure',
                                                'Lot_Serno_Dist',
                                                'Cogs_Account',
                                                'Reg_Sales_Acnt',
                                                'Price_Ovrrddn',
                                                'Kit_Item',
                                                'Bkord_Comp_LN',
                                                'Skip_Comp',
                                                'Um_Conv_Factor',
                                                'GL_Sales_Accnt',
                                                'Misc_Item_Flag',
                                                'Misc_Item',
                                                'Stand_Kit_Bill',
                                                'Tax_Class',
                                                'Qty_Ordered',
                                                'Qty_Shipped',
                                                'Qty_Backordered',
                                                'Unit_Price',
                                                'Extension',
                                                'Taxable_Amt',
                                                'Non_Tax_Amt',
                                                'Sales_Tax',
                                                'Line_Disc_Perct',
                                                'Unit_Cost',
                                                'Item_Desc',
                                                'Ship_Date',
                                                'Order_Date',
                                                'Invoice_due_dt',
                                                'Discount_Due_Dt',
                                                'Bill_to_Name',
                                                'Bill_to_Addrs1',
                                                'Bill_to_Addrs2',
                                                'Bill_to_City',
                                                'Bill_to_State',
                                                'Bill_to_Zip_CD',
                                                'Ship_to_Code',
                                                'Ship_to_Name',
                                                'Ship_to_Addrs1',
                                                'Ship_to_Addrs2',
                                                'Ship_to_City',
                                                'Ship_to_State',
                                                'Ship_to_Zip_CD',
                                                'Comm_Desc_Line1',
                                                'Comm_Desc_Line2',
                                                'Charge_AMT',
                                                'Misc_Slash',
                                                'Misc_Code',
                                                'Description',
                                                'Freight');

   Mas90_COL_ENTITY_DIVISION_NO             = 0;
   Mas90_COL_ENTITY_CUSTOMER_NO             = 1;
   Mas90_COL_ENTITY_NAME                    = 2;
   Mas90_COL_ENTITY_ADDRESS_1               = 3;
   Mas90_COL_ENTITY_ADDRESS_2               = 4;
   Mas90_COL_ENTITY_CITY                    = 5;
   Mas90_COL_ENTITY_STATE                   = 6;
   Mas90_COL_ENTITY_ZIP_CODE                = 7;
   Mas90_COL_ENTITY_PHONE_NO                = 8;
   Mas90_COL_ENTITY_TERMS_CODE              = 9;
   Mas90_COL_ENTITY_OPEN_ITEM               = 10;
   Mas90_COL_ENTITY_COUNTRY_CODE            = 11;
   Mas90_COL_ENTITY_TAX_SCHEDULE            = 12;
   Mas90_COL_ENTITY_TAX_EXEMPT_NO           = 13;
   Mas90_COL_ENTITY_SHIPPING_METHOD         = 14;
   Mas90_COL_ENTITY_FAX_NUMBER              = 15;
   Mas90_COL_ENTITY_EMAIL_ADDRESS           = 16;
   Mas90_COL_ENTITY_SALESPRSN_NO            = 17;
   Mas90_COL_ENTITY_DEFAULT_SLS_CD          = 18;
   Mas90_COL_ENTITY_CUST_TYPE               = 19;
   Mas90_COL_ENTITY_PRICE_LEVEL             = 20;

   Mas90_COL_ENTITY_BANK_CODE               = 21;
   Mas90_COL_ENTITY_DEPOSIT_NUMBER          = 22;
   //Mas90_COL_ENTITY_DIVISION_NO             = 23;
   //Mas90_COL_ENTITY_CUSTOMER_NO             = 24;
   Mas90_COL_ENTITY_CUSTOMER_NAME           = 25;
   Mas90_COL_ENTITY_BATCH_NUMBER            = 26;
   Mas90_COL_ENTITY_INVOICE_NO              = 27;
   Mas90_COL_ENTITY_AMOUNT_POSTED           = 28;
   Mas90_COL_ENTITY_DEP_POST_DATE           = 29;
   Mas90_COL_ENTITY_DOCUMENT_NO             = 30;
   Mas90_COL_ENTITY_DEPOSIT_TYPE            = 31;
   Mas90_COL_ENTITY_PAYMENT_TYPE            = 32;
   Mas90_COL_ENTITY_DEPOSIT_BALANCE         = 33;
   Mas90_COL_ENTITY_CUST_POST_AMT           = 34;


   //Mas90_COL_ENTITY_INVOICE_NO              = 35;
   Mas90_COL_ENTITY_INVOICE_DATE            = 36;
   //Mas90_COL_ENTITY_DIVISION_NO             = 37;
   //Mas90_COL_ENTITY_CUSTOMER_NO             = 38;
   Mas90_COL_ENTITY_DEFAULT_WHSE            = 39;
   //Mas90_COL_ENTITY_TAX_SCHEDULE            = 40;
   //Mas90_COL_ENTITY_TERMS_CODE              = 41;
   Mas90_COL_ENTITY_SALESPRSN               = 42;
   Mas90_COL_ENTITY_LINE_TYPE               = 43;
   Mas90_COL_ENTITY_ITEM_NUMBER             = 44;
   Mas90_COL_ENTITY_DISCOUNT                = 45;
   Mas90_COL_ENTITY_SUBJ_TO_EXEMPT          = 46;
   Mas90_COL_ENTITY_WAREHOUSE_CODE          = 47;
   Mas90_COL_ENTITY_COST_TYPE               = 48;
   Mas90_COL_ENTITY_PRODUCT_LINE            = 49;
   Mas90_COL_ENTITY_UNIT_OF_MEASURE         = 50;
   Mas90_COL_ENTITY_LOT_SERNO_DIST          = 51;
   Mas90_COL_ENTITY_COGS_ACCOUNT            = 52;
   Mas90_COL_ENTITY_REG_SALES_ACNT          = 53;
   Mas90_COL_ENTITY_PRICE_OVRRDDN           = 54;
   Mas90_COL_ENTITY_KIT_ITEM                = 55;
   Mas90_COL_ENTITY_BKORD_COMP_LN           = 56;
   Mas90_COL_ENTITY_SKIP_COMP               = 57;
   Mas90_COL_ENTITY_UM_CONV_FACTOR          = 58;
   Mas90_COL_ENTITY_GL_SALES_ACCNT          = 59;
   Mas90_COL_ENTITY_MISC_ITEM_FLAG          = 60;
   Mas90_COL_ENTITY_MISC_ITEM               = 61;
   Mas90_COL_ENTITY_STAND_KIT_BILL          = 62;
   Mas90_COL_ENTITY_TAX_CLASS               = 63;
   Mas90_COL_ENTITY_QTY_ORDERED             = 64;
   Mas90_COL_ENTITY_QTY_SHIPPED             = 65;
   Mas90_COL_ENTITY_QTY_BACKORDERED         = 66;
   Mas90_COL_ENTITY_UNIT_PRICE              = 67;
   Mas90_COL_ENTITY_EXTENSION               = 68;
   Mas90_COL_ENTITY_TAXABLE_AMT             = 69;
   Mas90_COL_ENTITY_NON_TAX_AMT             = 70;
   Mas90_COL_ENTITY_SALES_TAX               = 71;
   Mas90_COL_ENTITY_LINE_DISC_PERCT         = 72;
   Mas90_COL_ENTITY_UNIT_COST               = 73;
   Mas90_COL_ENTITY_ITEM_DESC               = 74;
   Mas90_COL_ENTITY_SHIP_DATE               = 75;
   Mas90_COL_ENTITY_ORDER_DATE              = 76;
   Mas90_COL_ENTITY_INVOICE_DUE_DT          = 77;
   Mas90_COL_ENTITY_DISCOUNT_DUE_DT         = 78;
   Mas90_COL_ENTITY_BILL_TO_NAME            = 79;
   Mas90_COL_ENTITY_BILL_TO_ADDRS1          = 80;
   Mas90_COL_ENTITY_BILL_TO_ADDRS2          = 81;
   Mas90_COL_ENTITY_BILL_TO_CITY            = 82;
   Mas90_COL_ENTITY_BILL_TO_STATE           = 83;
   Mas90_COL_ENTITY_BILL_TO_ZIP_CD          = 84;
   Mas90_COL_ENTITY_SHIP_TO_CODE            = 85;
   Mas90_COL_ENTITY_SHIP_TO_NAME            = 86;
   Mas90_COL_ENTITY_SHIP_TO_ADDRS1          = 87;
   Mas90_COL_ENTITY_SHIP_TO_ADDRS2          = 88;
   Mas90_COL_ENTITY_SHIP_TO_CITY            = 89;
   Mas90_COL_ENTITY_SHIP_TO_STATE           = 90;
   Mas90_COL_ENTITY_SHIP_TO_ZIP_CD          = 91;
   Mas90_COL_ENTITY_COMM_DESC_LINE1         = 92;
   Mas90_COL_ENTITY_COMM_DESC_LINE2         = 93;
   Mas90_COL_ENTITY_CHARGE_AMT              = 94;
   Mas90_COL_ENTITY_MISC_SLASH              = 95;
   Mas90_COL_ENTITY_MISC_CODE               = 96;
   Mas90_COL_ENTITY_DESCRIPTION             = 97;
   Mas90_COL_ENTITY_FREIGHT                 = 98;

   CUSTOMER_NO_DIGIT = 7;
   INVOICE_NO_DIGIT  = 7;

type
   //Delete Row and Col in a StringGrid
   TAdvStringGrid = Class(TStringGrid)
      Public
         Procedure DeleteRow(ARow:LongInt); Override;
         Procedure DeleteColumn(AColumn:LongInt); Override;
   End;

   TDefaultClass = Class
       public
          function Print:String; virtual; abstract;
   end;

   TEntityCustomer = class (TDefaultClass)
   private
       fDivision_No      : String;
       fCustomer_No      : String;
       fName             : String;
       fAddress1         : String;
       fAddress2         : String;
       fCity             : String;
       fState            : String;
       fZip_Code         : String;
       fPhone_No         : String;
       fTerms_Code       : String;
       fOpen_Item        : String;
       fCountry_Code     : String;
       fTax_Schedule     : String;
       fTax_Exempt_No    : String;
       fShipping_Method  : String;
       fFax_Number       : String;
       fEmail_Address    : String;
       fSalesprsn_No     : String;
       fDefault_SLS_CD   : String;
       fCust_Type        : String;
       fPrice_Level      : String;
   public
       property Division_No      : String read fDivision_No      write fDivision_No;
       property Customer_No      : String read fCustomer_No      write fCustomer_No;
       property Name             : String read fName             write fName;
       property Address1         : String read fAddress1         write fAddress1;
       property Address2         : String read fAddress2         write fAddress2;
       property City             : String read fCity             write fCity;
       property State            : String read fState            write fState;
       property Zip_Code         : String read fZip_Code         write fZip_Code;
       property Phone_No         : String read fPhone_No         write fPhone_No;
       property Terms_Code       : String read fTerms_Code       write fTerms_Code;
       property Open_Item        : String read fOpen_Item        write fOpen_Item;
       property Country_Code     : String read fCountry_Code     write fCountry_Code;
       property Tax_Schedule     : String read fTax_Schedule     write fTax_Schedule;
       property Tax_Exempt_No    : String read fTax_Exempt_No    write fTax_Exempt_No;
       property Shipping_Method  : String read fShipping_Method  write fShipping_Method ;
       property Fax_Number       : String read fFax_Number       write fFax_Number;
       property Email_Address    : String read fEmail_Address    write fEmail_Address;
       property Salesprsn_No     : String read fSalesprsn_No     write fSalesprsn_No;
       property Default_SLS_CD   : String read fDefault_SLS_CD   write fDefault_SLS_CD;
       property Cust_Type        : String read fCust_Type        write fCust_Type;
       property Price_Level      : String read fPrice_Level      write fPrice_Level;
       function Print:String; Override;
      end;

    TEntityPayment = class (TDefaultClass)
    private
       fBank_Code       : String;
       fDeposit_Number  : String;
       fDivision_No     : String;
       fCustomer_No     : String;
       fCustomer_Name   : String;
       fBatch_Number    : String;
       fInvoice_No      : String;
       fAmount_Posted   : String;
       fDep_Post_Date   : String;
       fDocument_No     : String;
       fDeposit_Type    : String;
       fPayment_Type    : String;
       fDeposit_Balance : String;
       fCust_Post_Amt   : String;
    public
       property Bank_Code       : String read fBank_Code        write fBank_Code;
       property Deposit_Number  : String read fDeposit_Number   write fDeposit_Number;
       property Division_No     : String read fDivision_No      write fDivision_No;
       property Customer_No     : String read fCustomer_No      write fCustomer_No;
       property Customer_Name   : String read fCustomer_Name    write fCustomer_Name;
       property Batch_Number    : String read fBatch_Number     write fBatch_Number;
       property Invoice_No      : String read fInvoice_No       write fInvoice_No;
       property Amount_Posted   : String read fAmount_Posted    write fAmount_Posted;
       property Dep_Post_Date   : String read fDep_Post_Date    write fDep_Post_Date;
       property Document_No     : String read fDocument_No      write fDocument_No;
       property Deposit_Type    : String read fDeposit_Type     write fDeposit_Type;
       property Payment_Type    : String read fPayment_Type     write fPayment_Type;
       property Deposit_Balance : String read fDeposit_Balance  write fDeposit_Balance;
       property Cust_Post_Amt   : String read fCust_Post_Amt    write fCust_Post_Amt;
       function Print:String; Override;
    end;

    TEntitySaleInvoice = class (TDefaultClass)
    private
       fInvoice_No      : String;
       fInvoice_Date    : String;
       fDivision_No     : String;
       fCustomer_No     : String;
       fDefault_Whse    : String;
       fTax_Schedule    : String;
       fTerms_Code      : String;
       fSalesprsn       : String;
       fLine_Type       : String;
       fItem_Number     : String;
       fDiscount        : String;
       fSubj_to_Exempt  : String;
       fWareHouse_Code  : String;
       fCost_Type       : String;
       fProduct_Line    : String;
       fUnit_of_Measure : String;
       fLot_Serno_Dist  : String;
       fCogs_Account    : String;
       fReg_Sales_Acnt  : String;
       fPrice_Ovrrddn   : String;
       fKit_Item        : String;
       fBkord_Comp_LN   : String;
       fSkip_Comp       : String;
       fUm_Conv_Factor  : String;
       fGL_Sales_Accnt  : String;
       fMisc_Item_Flag  : String;
       fMisc_Item       : String;
       fStand_Kit_Bill  : String;
       fTax_Class       : String;
       fQty_Ordered     : String;
       fQty_Shipped     : String;
       fQty_Backordered : String;
       fUnit_Price      : String;
       fExtension       : String;
       fTaxable_Amt     : String;
       fNon_Tax_Amt     : String;
       fSales_Tax       : String;
       fLine_Disc_Perct : String;
       fUnit_Cost       : String;
       fItem_Desc       : String;
       fShip_Date       : String;
       fOrder_Date      : String;
       fInvoice_due_dt  : String;
       fDiscount_Due_Dt : String;
       fBill_to_Name    : String;
       fBill_to_Addrs1  : String;
       fBill_to_Addrs2  : String;
       fBill_to_City    : String;
       fBill_to_State   : String;
       fBill_to_Zip_CD  : String;
       fShip_to_Code    : String;
       fShip_to_Name    : String;
       fShip_to_Addrs1  : String;
       fShip_to_Addrs2  : String;
       fShip_to_City    : String;
       fShip_to_State   : String;
       fShip_to_Zip_CD  : String;
       fComm_Desc_Line1 : String;
       fComm_Desc_Line2 : String;
       fCharge_AMT      : String;
       fMisc_Slash      : String;
       fMisc_Code       : String;
       fDescription     : String;
       fFreight         : String;
       fEmptyField      : String;
    public
       property Invoice_No      : String read fInvoice_No        write fInvoice_No;
       property Invoice_Date    : String read fInvoice_Date      write fInvoice_Date;
       property Division_No     : String read fDivision_No       write fDivision_No;
       property Customer_No     : String read fCustomer_No       write fCustomer_No;
       property Default_Whse    : String read fDefault_Whse      write fDefault_Whse;
       property Tax_Schedule    : String read fTax_Schedule      write fTax_Schedule;
       property Terms_Code      : String read fTerms_Code        write fTerms_Code;
       property Salesprsn       : String read fSalesprsn         write fSalesprsn;
       property Line_Type       : String read fLine_Type         write fLine_Type;
       property Item_Number     : String read fItem_Number       write fItem_Number;
       property Discount        : String read fDiscount          write fDiscount;
       property Subj_to_Exempt  : String read fSubj_to_Exempt    write fSubj_to_Exempt;
       property WareHouse_Code  : String read fWareHouse_Code    write fWareHouse_Code;
       property Cost_Type       : String read fCost_Type         write fCost_Type  ;
       property Product_Line    : String read fProduct_Line      write fProduct_Line;
       property Unit_of_Measure : String read fUnit_of_Measure   write fUnit_of_Measure;
       property Lot_Serno_Dist  : String read fLot_Serno_Dist    write fLot_Serno_Dist;
       property Cogs_Account    : String read fCogs_Account      write fCogs_Account;
       property Reg_Sales_Acnt  : String read fReg_Sales_Acnt    write fReg_Sales_Acnt;
       property Price_Ovrrddn   : String read fPrice_Ovrrddn     write fPrice_Ovrrddn;
       property Kit_Item        : String read fKit_Item          write fKit_Item;
       property Bkord_Comp_LN   : String read fBkord_Comp_LN     write fBkord_Comp_LN;
       property Skip_Comp       : String read fSkip_Comp         write fSkip_Comp;
       property Um_Conv_Factor  : String read fUm_Conv_Factor    write fUm_Conv_Factor;
       property GL_Sales_Accnt  : String read fGL_Sales_Accnt    write fGL_Sales_Accnt;
       property Misc_Item_Flag  : String read fMisc_Item_Flag    write fMisc_Item_Flag;
       property Misc_Item       : String read fMisc_Item         write fMisc_Item;
       property Stand_Kit_Bill  : String read fStand_Kit_Bill    write fStand_Kit_Bill;
       property Tax_Class       : String read fTax_Class         write fTax_Class ;
       property Qty_Ordered     : String read fQty_Ordered       write fQty_Ordered;
       property Qty_Shipped     : String read fQty_Shipped       write fQty_Shipped;
       property Qty_Backordered : String read fQty_Backordered   write fQty_Backordered;
       property Unit_Price      : String read fUnit_Price        write fUnit_Price;
       property Extension       : String read fExtension         write fExtension;
       property Taxable_Amt     : String read fTaxable_Amt       write fTaxable_Amt;
       property Non_Tax_Amt     : String read fNon_Tax_Amt       write fNon_Tax_Amt;
       property Sales_Tax       : String read fSales_Tax         write fSales_Tax;
       property Line_Disc_Perct : String read fLine_Disc_Perct   write fLine_Disc_Perct;
       property Unit_Cost       : String read fUnit_Cost         write fUnit_Cost;
       property Item_Desc       : String read fItem_Desc         write fItem_Desc;
       property Ship_Date       : String read fShip_Date         write fShip_Date;
       property Order_Date      : String read fOrder_Date        write fOrder_Date;
       property Invoice_due_dt  : String read fInvoice_due_dt    write fInvoice_due_dt;
       property Discount_Due_Dt : String read fDiscount_Due_Dt   write fDiscount_Due_Dt;
       property Bill_to_Name    : String read fBill_to_Name      write fBill_to_Name;
       property Bill_to_Addrs1  : String read fBill_to_Addrs1    write fBill_to_Addrs1;
       property Bill_to_Addrs2  : String read fBill_to_Addrs2    write fBill_to_Addrs2;
       property Bill_to_City    : String read fBill_to_City      write fBill_to_City;
       property Bill_to_State   : String read fBill_to_State     write fBill_to_State;
       property Bill_to_Zip_CD  : String read fBill_to_Zip_CD    write fBill_to_Zip_CD;
       property Ship_to_Code    : String read fShip_to_Code      write fShip_to_Code;
       property Ship_to_Name    : String read fShip_to_Name      write fShip_to_Name;
       property Ship_to_Addrs1  : String read fShip_to_Addrs1    write fShip_to_Addrs1;
       property Ship_to_Addrs2  : String read fShip_to_Addrs2    write fShip_to_Addrs2;
       property Ship_to_City    : String read fShip_to_City      write fShip_to_City;
       property Ship_to_State   : String read fShip_to_State     write fShip_to_State;
       property Ship_to_Zip_CD  : String read fShip_to_Zip_CD    write fShip_to_Zip_CD;
       property Comm_Desc_Line1 : String read fComm_Desc_Line1   write fComm_Desc_Line1;
       property Comm_Desc_Line2 : String read fComm_Desc_Line2   write fComm_Desc_Line2;
       property Charge_AMT      : String read fCharge_AMT        write fCharge_AMT;
       property Misc_Slash      : String read fMisc_Slash        write fMisc_Slash;
       property Misc_Code       : String read fMisc_Code         write fMisc_Code;
       property Description     : String read fDescription       write fDescription;
       property Freight         : String read fFreight           write fFreight;
       property EmptyField      : String read fEmptyField        write fEmptyField;
       function Print:String; Override;
    end;

   TMas90 =  class
   private
       fEntityCustomer    : TEntityCustomer;
       fEntityPayment     : TEntityPayment;
       fEntitySaleInvoice : TEntitySaleInvoice;
       FMas90Columns      : TStringList;             //List of Columns to be imported to the System
       FEntityList        : TStringList;

       procedure FreeAllEntityListObj;
       function PrintEntities:String;
    procedure SetBank(sID, sDesc, sType, sInactive: String);
   public
       procedure ClearEntityList;
       procedure AddColumnToImport(Mas90Column:Integer);
       procedure GetColumnsToImport(ColumnGrid, ListGrid:TStringGrid);
       procedure ClearColumnsToImport;
       procedure OpenMas90File(sPath:String; Grid : TStringGrid);

       function SaveDataToFile(sPath:String):Boolean;
       function PrepareInvoiceNoForMAS90(Invoice_No : String):String;
       function PrepareCustomerNoForMAS90(Customer_No : String):String;

       function AddCustomerEntity(FileType:TMas90FileType; Division_No, Customer_No, Name, Address1, Address2,
                                  City, State, Zip_Code, Phone_No, Terms_Code, Open_Item, Country_Code, Tax_Schedule,
                                  Tax_Exempt_No, Shipping_Method, Fax_Number, Email_Address, Salesprsn_No, Default_SLS_CD,
                                  Cust_Type, Price_Level:String): Integer;

       function AddPaymentEntity(FileType: TMas90FileType; Bank_Code,Deposit_Number, Division_No, Customer_No, Customer_Name, Batch_Number,
                                 Invoice_No, Amount_Posted,Dep_Post_Date,Document_No,Deposit_Type,Payment_Type,
                                 Deposit_Balance,Cust_Post_Amt:String): Integer;

       function AddSaleInvoiceEntity(FileType: TMas90FileType; Invoice_No,Invoice_Date,Division_No,Customer_No,Default_Whse,Tax_Schedule,Terms_Code,Salesprsn,
                                 Line_Type,Item_Number,Discount,Subj_to_Exempt,WareHouse_Code,Cost_Type,Product_Line,
                                 Unit_of_Measure,Lot_Serno_Dist,Cogs_Account,Reg_Sales_Acnt,Price_Ovrrddn,Kit_Item,Bkord_Comp_LN,
                                 Skip_Comp,Um_Conv_Factor,GL_Sales_Accnt,Misc_Item_Flag,Misc_Item,Stand_Kit_Bill,Tax_Class,
                                 Qty_Ordered,Qty_Shipped,Qty_Backordered,Unit_Price,Extension,Taxable_Amt,Non_Tax_Amt,Sales_Tax,
                                 Line_Disc_Perct,Unit_Cost,Item_Desc,Ship_Date,Order_Date,Invoice_due_dt,Discount_Due_Dt,
                                 Bill_to_Name,Bill_to_Addrs1,Bill_to_Addrs2,Bill_to_City,Bill_to_State,Bill_to_Zip_CD,Ship_to_Code,
                                 Ship_to_Name,Ship_to_Addrs1,Ship_to_Addrs2,Ship_to_City,Ship_to_State,Ship_to_Zip_CD,Comm_Desc_Line1,
                                 Comm_Desc_Line2,Charge_AMT,Misc_Slash,Misc_Code,Description,Freight:String): Integer;
       Constructor Create;
       Destructor Destroy; override;
end;

implementation

uses uSaveToFile, uStringFunctions;

const

   FIELD_SEPARATOR                   = ',';         //comma
   BEGIN_NEW_LINE                    = '' + #13#10; //start a new line
   BEGIN_FIELD                       = '"';
   END_FIELD                         = '"';

   CUSTOMER_HEADER                   = 'Division_No'     +FIELD_SEPARATOR+
                                       'Customer_No'     +FIELD_SEPARATOR+
                                       'Name'            +FIELD_SEPARATOR+
                                       'Address1'        +FIELD_SEPARATOR+
                                       'Address2'        +FIELD_SEPARATOR+
                                       'City'            +FIELD_SEPARATOR+
                                       'State'           +FIELD_SEPARATOR+
                                       'Zip_Code'        +FIELD_SEPARATOR+
                                       'Phone_No'        +FIELD_SEPARATOR+
                                       'Terms_Code'      +FIELD_SEPARATOR+
                                       'Open_Item'       +FIELD_SEPARATOR+
                                       'Country_Code'    +FIELD_SEPARATOR+
                                       'Tax_Schedule'    +FIELD_SEPARATOR+
                                       'Tax_Exempt_No'   +FIELD_SEPARATOR+
                                       'Shipping_Method' +FIELD_SEPARATOR+
                                       'Fax_Number'      +FIELD_SEPARATOR+
                                       'Email_Address'   +FIELD_SEPARATOR+
                                       'Salesprsn_No'    +FIELD_SEPARATOR+
                                       'Default_SLS_CD'  +FIELD_SEPARATOR+
                                       'Shipping_Method' +FIELD_SEPARATOR+
                                       'Cust_Type'       +FIELD_SEPARATOR+
                                       'Price_Level';

   PAYMENT_HEADER                   =  'Bank_Code'       +FIELD_SEPARATOR+
                                       'Deposit_Number'  +FIELD_SEPARATOR+
                                       'Division_No'     +FIELD_SEPARATOR+
                                       'Customer_No'     +FIELD_SEPARATOR+
                                       'Customer_Name'   +FIELD_SEPARATOR+
                                       'Batch_Number'    +FIELD_SEPARATOR+
                                       'Invoice_No'      +FIELD_SEPARATOR+
                                       'Amount_Posted'   +FIELD_SEPARATOR+
                                       'Dep_Post_Date'   +FIELD_SEPARATOR+
                                       'Document_No'     +FIELD_SEPARATOR+
                                       'Deposit_Type'    +FIELD_SEPARATOR+
                                       'Payment_Type'    +FIELD_SEPARATOR+
                                       'Deposit_Balance' +FIELD_SEPARATOR+
                                       'Cust_Post_Amt';

   SALE_INVOICE_HEADER              =  'Invoice_No'      +FIELD_SEPARATOR+
                                       'Invoice_Date'    +FIELD_SEPARATOR+
                                       'Division_No'     +FIELD_SEPARATOR+
                                       'Customer_No'     +FIELD_SEPARATOR+
                                       'Default_Whse'    +FIELD_SEPARATOR+
                                       'Tax_Schedule'    +FIELD_SEPARATOR+
                                       'Terms_Code'      +FIELD_SEPARATOR+
                                       'Salesprsn'       +FIELD_SEPARATOR+
                                       'Line_Type'       +FIELD_SEPARATOR+
                                       'Item_Number'     +FIELD_SEPARATOR+
                                       'Discount'        +FIELD_SEPARATOR+
                                       'Subj_to_Exempt'  +FIELD_SEPARATOR+
                                       'WareHouse_Code'  +FIELD_SEPARATOR+
                                       'Cost_Type'       +FIELD_SEPARATOR+
                                       'Product_Line'    +FIELD_SEPARATOR+
                                       'Unit_of_Measure' +FIELD_SEPARATOR+
                                       'Lot_Serno_Dist'  +FIELD_SEPARATOR+
                                       'Cogs_Account'    +FIELD_SEPARATOR+
                                       'Reg_Sales_Acnt'  +FIELD_SEPARATOR+
                                       'Price_Ovrrddn'   +FIELD_SEPARATOR+
                                       'Kit_Item'        +FIELD_SEPARATOR+
                                       'Bkord_Comp_LN'   +FIELD_SEPARATOR+
                                       'Skip_Comp'       +FIELD_SEPARATOR+
                                       'Um_Conv_Factor'  +FIELD_SEPARATOR+
                                       'GL_Sales_Accnt'  +FIELD_SEPARATOR+
                                       'Empty_Field'     +FIELD_SEPARATOR+
                                       'Misc_Item_Flag'  +FIELD_SEPARATOR+
                                       'Misc_Item'       +FIELD_SEPARATOR+
                                       'Stand_Kit_Bill'  +FIELD_SEPARATOR+
                                       'Tax_Class'       +FIELD_SEPARATOR+
                                       'Qty_Ordered'     +FIELD_SEPARATOR+
                                       'Qty_Shipped'     +FIELD_SEPARATOR+
                                       'Qty_Backordered' +FIELD_SEPARATOR+
                                       'Unit_Price'      +FIELD_SEPARATOR+
                                       'Extension'       +FIELD_SEPARATOR+
                                       'Taxable_Amt'     +FIELD_SEPARATOR+
                                       'Non_Tax_Amt'     +FIELD_SEPARATOR+
                                       'Sales_Tax'       +FIELD_SEPARATOR+
                                       'Line_Disc_Perct' +FIELD_SEPARATOR+
                                       'Unit_Cost'       +FIELD_SEPARATOR+
                                       'Item_Desc'       +FIELD_SEPARATOR+
                                       'Ship_Date'       +FIELD_SEPARATOR+
                                       'Order_Date'      +FIELD_SEPARATOR+
                                       'Invoice_due_dt'  +FIELD_SEPARATOR+
                                       'Discount_Due_Dt' +FIELD_SEPARATOR+
                                       'Bill_to_Name'    +FIELD_SEPARATOR+
                                       'Bill_to_Addrs1'  +FIELD_SEPARATOR+
                                       'Bill_to_Addrs2'  +FIELD_SEPARATOR+
                                       'Bill_to_City'    +FIELD_SEPARATOR+
                                       'Bill_to_State'   +FIELD_SEPARATOR+
                                       'Bill_to_Zip_CD'  +FIELD_SEPARATOR+
                                       'Ship_to_Code'    +FIELD_SEPARATOR+
                                       'Ship_to_Name'    +FIELD_SEPARATOR+
                                       'Ship_to_Addrs1'  +FIELD_SEPARATOR+
                                       'Ship_to_Addrs2'  +FIELD_SEPARATOR+
                                       'Ship_to_City'    +FIELD_SEPARATOR+
                                       'Ship_to_State'   +FIELD_SEPARATOR+
                                       'Ship_to_Zip_CD'  +FIELD_SEPARATOR+
                                       'Comm_Desc_Line1' +FIELD_SEPARATOR+
                                       'Comm_Desc_Line2' +FIELD_SEPARATOR+
                                       'Charge_AMT'      +FIELD_SEPARATOR+
                                       'Misc_Slash'      +FIELD_SEPARATOR+
                                       'Misc_Code'       +FIELD_SEPARATOR+
                                       'Description'     +FIELD_SEPARATOR+
                                       'Freight';

{--------- Items on a String Grid -----------}

procedure TAdvStringGrid.DeleteColumn(AColumn: Integer);
begin
  inherited;

end;

procedure TAdvStringGrid.DeleteRow(ARow: Integer);
begin
  inherited;

end;

{ TMas90 }

procedure TMas90.AddColumnToImport(Mas90Column: Integer);
 var
    Column : String;
begin
   if not Assigned(FMas90Columns) then
      FMas90Columns := TStringList.Create;

   Column := AMas90EntityColumns[Mas90Column];

   if ValueLocatedInList(FMas90Columns, Column) = -1 then
      FMas90Columns.Add(Column);
end;

function TMas90.AddCustomerEntity(FileType: TMas90FileType; Division_No, Customer_No, Name, Address1, Address2,
                                  City, State, Zip_Code, Phone_No, Terms_Code, Open_Item, Country_Code, Tax_Schedule,
                                  Tax_Exempt_No, Shipping_Method, Fax_Number, Email_Address, Salesprsn_No, Default_SLS_CD,
                                  Cust_Type, Price_Level:String): Integer;
begin
     fEntityCustomer := TEntityCustomer.Create;
     TEntityCustomer(fEntityCustomer).Division_No       := Division_No;
     TEntityCustomer(fEntityCustomer).Customer_No       := Customer_No;
     TEntityCustomer(fEntityCustomer).Name              := Name;
     TEntityCustomer(fEntityCustomer).Address1          := Address1;
     TEntityCustomer(fEntityCustomer).Address2          := Address2;
     TEntityCustomer(fEntityCustomer).City              := City;
     TEntityCustomer(fEntityCustomer).State             := State;
     TEntityCustomer(fEntityCustomer).Zip_Code          := Zip_Code;
     TEntityCustomer(fEntityCustomer).Phone_No          := Phone_No;
     TEntityCustomer(fEntityCustomer).Terms_Code        := Terms_Code;
     TEntityCustomer(fEntityCustomer).Open_Item         := Open_Item;
     TEntityCustomer(fEntityCustomer).Country_Code      := Country_Code;
     TEntityCustomer(fEntityCustomer).Tax_Schedule      := Tax_Schedule;
     TEntityCustomer(fEntityCustomer).Tax_Exempt_No     := Tax_Exempt_No;
     TEntityCustomer(fEntityCustomer).Shipping_Method   := Shipping_Method;
     TEntityCustomer(fEntityCustomer).Fax_Number        := Fax_Number;
     TEntityCustomer(fEntityCustomer).Email_Address     := Email_Address;
     TEntityCustomer(fEntityCustomer).Salesprsn_No      := Salesprsn_No;
     TEntityCustomer(fEntityCustomer).Default_SLS_CD    := Default_SLS_CD;
     TEntityCustomer(fEntityCustomer).Cust_Type         := Cust_Type;
     TEntityCustomer(fEntityCustomer).Price_Level       := Price_Level;

  Result := FEntityList.AddObject('', fEntityCustomer);
end;

function TMas90.AddPaymentEntity(FileType: TMas90FileType; Bank_Code,Deposit_Number, Division_No, Customer_No, Customer_Name, Batch_Number,
                                 Invoice_No, Amount_Posted,Dep_Post_Date,Document_No,Deposit_Type,Payment_Type,
                                 Deposit_Balance,Cust_Post_Amt:String): Integer;
begin
 fEntityPayment := TEntityPayment.Create;
 TEntityPayment(fEntityPayment).Bank_Code         := Bank_Code;
 TEntityPayment(fEntityPayment).Deposit_Number    := Deposit_Number;
 TEntityPayment(fEntityPayment).Division_No       := Division_No;
 TEntityPayment(fEntityPayment).Customer_No       := Customer_No;
 TEntityPayment(fEntityPayment).Customer_Name     := Customer_Name;
 TEntityPayment(fEntityPayment).Batch_Number      := Batch_Number;
 TEntityPayment(fEntityPayment).Invoice_No        := Invoice_No;
 TEntityPayment(fEntityPayment).Amount_Posted     := Amount_Posted;
 TEntityPayment(fEntityPayment).Dep_Post_Date     := Dep_Post_Date;
 TEntityPayment(fEntityPayment).Document_No       := Document_No;
 TEntityPayment(fEntityPayment).Deposit_Type      := Deposit_Type;
 TEntityPayment(fEntityPayment).Payment_Type      := Payment_Type;
 TEntityPayment(fEntityPayment).Deposit_Balance   := Deposit_Balance;
 TEntityPayment(fEntityPayment).Cust_Post_Amt     := Cust_Post_Amt;

Result := FEntityList.AddObject('', fEntityPayment);
end;

function TMas90.AddSaleInvoiceEntity(FileType: TMas90FileType; Invoice_No,Invoice_Date,Division_No,Customer_No,Default_Whse,Tax_Schedule,Terms_Code,Salesprsn,
                                 Line_Type,Item_Number,Discount,Subj_to_Exempt,WareHouse_Code,Cost_Type,Product_Line,
                                 Unit_of_Measure,Lot_Serno_Dist,Cogs_Account,Reg_Sales_Acnt,Price_Ovrrddn,Kit_Item,Bkord_Comp_LN,
                                 Skip_Comp,Um_Conv_Factor,GL_Sales_Accnt,Misc_Item_Flag,Misc_Item,Stand_Kit_Bill,Tax_Class,
                                 Qty_Ordered,Qty_Shipped,Qty_Backordered,Unit_Price,Extension,Taxable_Amt,Non_Tax_Amt,Sales_Tax,
                                 Line_Disc_Perct,Unit_Cost,Item_Desc,Ship_Date,Order_Date,Invoice_due_dt,Discount_Due_Dt,
                                 Bill_to_Name,Bill_to_Addrs1,Bill_to_Addrs2,Bill_to_City,Bill_to_State,Bill_to_Zip_CD,Ship_to_Code,
                                 Ship_to_Name,Ship_to_Addrs1,Ship_to_Addrs2,Ship_to_City,Ship_to_State,Ship_to_Zip_CD,Comm_Desc_Line1,
                                 Comm_Desc_Line2,Charge_AMT,Misc_Slash,Misc_Code,Description,Freight:String): Integer;
begin

 fEntitySaleInvoice := TEntitySaleInvoice.Create;
 TEntitySaleInvoice(fEntitySaleInvoice).Invoice_No           := Invoice_No;
 TEntitySaleInvoice(fEntitySaleInvoice).Invoice_Date         := Invoice_Date;
 TEntitySaleInvoice(fEntitySaleInvoice).Division_No          := Division_No;
 TEntitySaleInvoice(fEntitySaleInvoice).Customer_No          := Customer_No;
 TEntitySaleInvoice(fEntitySaleInvoice).Default_Whse         := Default_Whse;
 TEntitySaleInvoice(fEntitySaleInvoice).Tax_Schedule         := Tax_Schedule;
 TEntitySaleInvoice(fEntitySaleInvoice).Terms_Code           := Terms_Code;
 TEntitySaleInvoice(fEntitySaleInvoice).Salesprsn            := Salesprsn;
 TEntitySaleInvoice(fEntitySaleInvoice).Line_Type            := Line_Type;
 TEntitySaleInvoice(fEntitySaleInvoice).Item_Number          := Item_Number;
 TEntitySaleInvoice(fEntitySaleInvoice).Discount             := Discount;
 TEntitySaleInvoice(fEntitySaleInvoice).Subj_to_Exempt       := Subj_to_Exempt;
 TEntitySaleInvoice(fEntitySaleInvoice).WareHouse_Code       := WareHouse_Code;
 TEntitySaleInvoice(fEntitySaleInvoice).Cost_Type            := Cost_Type;
 TEntitySaleInvoice(fEntitySaleInvoice).Product_Line         := Product_Line;
 TEntitySaleInvoice(fEntitySaleInvoice).Unit_of_Measure      := Unit_of_Measure;
 TEntitySaleInvoice(fEntitySaleInvoice).Lot_Serno_Dist       := Lot_Serno_Dist;
 TEntitySaleInvoice(fEntitySaleInvoice).Cogs_Account         := Cogs_Account;
 TEntitySaleInvoice(fEntitySaleInvoice).Reg_Sales_Acnt       := Reg_Sales_Acnt;
 TEntitySaleInvoice(fEntitySaleInvoice).Price_Ovrrddn        := Price_Ovrrddn;
 TEntitySaleInvoice(fEntitySaleInvoice).Kit_Item             := Kit_Item;
 TEntitySaleInvoice(fEntitySaleInvoice).Bkord_Comp_LN        := Bkord_Comp_LN;
 TEntitySaleInvoice(fEntitySaleInvoice).Skip_Comp            := Skip_Comp;
 TEntitySaleInvoice(fEntitySaleInvoice).Um_Conv_Factor       := Um_Conv_Factor;
 TEntitySaleInvoice(fEntitySaleInvoice).GL_Sales_Accnt       := GL_Sales_Accnt;
 TEntitySaleInvoice(fEntitySaleInvoice).EmptyField           := '';
 TEntitySaleInvoice(fEntitySaleInvoice).Misc_Item_Flag       := Misc_Item_Flag;
 TEntitySaleInvoice(fEntitySaleInvoice).Misc_Item            := Misc_Item;
 TEntitySaleInvoice(fEntitySaleInvoice).Stand_Kit_Bill       := Stand_Kit_Bill;
 TEntitySaleInvoice(fEntitySaleInvoice).Tax_Class            := Tax_Class;
 TEntitySaleInvoice(fEntitySaleInvoice).Qty_Ordered          := Qty_Ordered;
 TEntitySaleInvoice(fEntitySaleInvoice).Qty_Shipped          := Qty_Shipped;
 TEntitySaleInvoice(fEntitySaleInvoice).Qty_Backordered      := Qty_Backordered;
 TEntitySaleInvoice(fEntitySaleInvoice).Unit_Price           := Unit_Price;
 TEntitySaleInvoice(fEntitySaleInvoice).Extension            := Extension;
 TEntitySaleInvoice(fEntitySaleInvoice).Taxable_Amt          := Taxable_Amt;
 TEntitySaleInvoice(fEntitySaleInvoice).Non_Tax_Amt          := Non_Tax_Amt;
 TEntitySaleInvoice(fEntitySaleInvoice).Sales_Tax            := Sales_Tax;
 TEntitySaleInvoice(fEntitySaleInvoice).Line_Disc_Perct      := Line_Disc_Perct;
 TEntitySaleInvoice(fEntitySaleInvoice).Unit_Cost            := Unit_Cost;
 TEntitySaleInvoice(fEntitySaleInvoice).Item_Desc            := Item_Desc;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_Date            := Ship_Date;
 TEntitySaleInvoice(fEntitySaleInvoice).Order_Date           := Order_Date;
 TEntitySaleInvoice(fEntitySaleInvoice).Invoice_due_dt       := Invoice_due_dt;
 TEntitySaleInvoice(fEntitySaleInvoice).Discount_Due_Dt      := Discount_Due_Dt;
 TEntitySaleInvoice(fEntitySaleInvoice).Bill_to_Name         := Bill_to_Name;
 TEntitySaleInvoice(fEntitySaleInvoice).Bill_to_Addrs1       := Bill_to_Addrs1;
 TEntitySaleInvoice(fEntitySaleInvoice).Bill_to_Addrs2       := Bill_to_Addrs2;
 TEntitySaleInvoice(fEntitySaleInvoice).Bill_to_City         := Bill_to_City;
 TEntitySaleInvoice(fEntitySaleInvoice).Bill_to_State        := Bill_to_State;
 TEntitySaleInvoice(fEntitySaleInvoice).Bill_to_Zip_CD       := Bill_to_Zip_CD;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_Code         := Ship_to_Code;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_Name         := Ship_to_Name;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_Addrs1       := Ship_to_Addrs1;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_Addrs2       := Ship_to_Addrs2;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_City         := Ship_to_City;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_State        := Ship_to_State;
 TEntitySaleInvoice(fEntitySaleInvoice).Ship_to_Zip_CD       := Ship_to_Zip_CD;
 TEntitySaleInvoice(fEntitySaleInvoice).Comm_Desc_Line1      := Comm_Desc_Line1;
 TEntitySaleInvoice(fEntitySaleInvoice).Comm_Desc_Line2      := Comm_Desc_Line2;
 TEntitySaleInvoice(fEntitySaleInvoice).Charge_AMT           := Charge_AMT;
 TEntitySaleInvoice(fEntitySaleInvoice).Misc_Slash           := Misc_Slash;
 TEntitySaleInvoice(fEntitySaleInvoice).Misc_Code            := Misc_Code;
 TEntitySaleInvoice(fEntitySaleInvoice).Description          := Description;
 TEntitySaleInvoice(fEntitySaleInvoice).Freight              := Freight;

 Result := FEntityList.AddObject('', fEntitySaleInvoice);
end;


procedure TMas90.ClearColumnsToImport;
begin
  if Assigned(FMas90Columns) then
     FMas90Columns.Clear;
end;

procedure TMas90.ClearEntityList;
begin
 FEntityList.Clear;
end;

constructor TMas90.Create;
begin
 inherited Create;
   FEntityList       := TStringList.Create;
end;

destructor TMas90.Destroy;
begin
  //FreeAllEntityListObj;
  FreeAndNil(FEntityList);

  if Assigned(FMas90Columns) then
     begin
     FMas90Columns := Nil;
     FMas90Columns.Free;
     end;
end;

procedure TMas90.FreeAllEntityListObj;
var
  i : integer;
begin
    //release all objects in the List
    with FEntityList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;
end;

procedure TMas90.GetColumnsToImport(ColumnGrid, ListGrid: TStringGrid);
var
  i : integer;

  function SearchColumn(sColumn:String):String;
  var
  j : integer;
  begin
  Result  := '';
  sColumn := Trim(sColumn);
     for j:=0 to ListGrid.ColCount-1 do
        if Trim(ListGrid.Cells[j,0]) = sColumn then
           begin
           Result := IntToStr(j);
           Break;
           end;
  end;

begin

   if not Assigned(FMas90Columns) then
      Exit;

   ColumnGrid.RowCount := FMas90Columns.Count+1;
   ColumnGrid.ColCount := 3;

   for i:=0 to FMas90Columns.Count-1 do
      begin
      if ListGrid <> nil then
         ColumnGrid.Cells[0,i+1] := SearchColumn(FMas90Columns.Strings[i]);

      ColumnGrid.Cells[1,i+1] := FMas90Columns.Strings[i];
      end;
end;

procedure TMas90.OpenMas90File(sPath: String; Grid: TStringGrid);
  procedure ClearList;
   var j : integer;
   begin
   with Grid do
       begin
       for j:= 0 to RowCount-1 do
           TAdvStringGrid(Grid).DeleteRow(j);
       end;
   end;

var
  i : integer;

begin

    //Clear garbage
    FEntityList.Clear;
    ClearList;

    //Open the file
    FEntityList.LoadFromFile(sPath);

    //How many valid rows
    Grid.RowCount := FEntityList.Count;
    //How many valid cols
    if FEntityList.Count > 0 then
       Grid.ColCount := CountChar(FIELD_SEPARATOR, FEntityList.Strings[0]);
    //Row fixed Header
    Grid.FixedRows := 1;

    for i := 0 to FEntityList.Count-1 do
        Grid.Rows[i].Text :=  StringReplace(FEntityList.Strings[i], FIELD_SEPARATOR, #13, [rfReplaceAll]);
end;

function TMas90.PrepareCustomerNoForMAS90(Customer_No: String): String;
var Cut : Integer;
begin

  if length(Customer_No) > CUSTOMER_NO_DIGIT then
  begin
    Cut := length(Customer_No) - CUSTOMER_NO_DIGIT;
    Result := copy(Customer_No,1,1) + copy(Customer_No,Cut + 2,length(Customer_No) - Cut + 2);
  end
  else
    Result :=  Customer_No;

end;

function TMas90.PrepareInvoiceNoForMAS90(Invoice_No: String): String;
var Cut : Integer;
begin

  if length(Invoice_No) > INVOICE_NO_DIGIT then
  begin
    Cut := length(Invoice_No) - INVOICE_NO_DIGIT;
    Result := copy(Invoice_No,1,1) + copy(Invoice_No,Cut + 2,length(Invoice_No) - Cut + 2);
  end
  else
    Result := Invoice_No;

end;

function TMas90.PrintEntities: String;
var
  i : Integer;
begin
  Result := '';

  for i:=0 to FEntityList.Count-1 do
      if Assigned(FEntityList.Objects[i]) then
         Result := Result + TDefaultClass(FEntityList.Objects[i]).Print;

  if Result = '' then
     Exit;

  if Assigned(FEntityList.Objects[0]) then
    if (FEntityList.Objects[0] is TEntityCustomer) then
        Result := CUSTOMER_HEADER + Result
    else if (FEntityList.Objects[0] is TEntityPayment) then
        Result := PAYMENT_HEADER  + Result
    else if (FEntityList.Objects[0] is TEntitySaleInvoice) then
        Result := SALE_INVOICE_HEADER  + Result;
end;

function TMas90.SaveDataToFile(sPath: String): Boolean;
var
   aFile : TSaveFile;
begin

   Result := False;

   try
     aFile := TSaveFile.Create;
     aFile.FilePath := sPath;
     aFile.AddText(PrintEntities);
     Result := (aFile.CreateFile = -1);
   finally
     aFile.Free;
   end;
end;

procedure TMas90.SetBank(sID, sDesc, sType, sInactive: String);
begin

end;

{ TEntityCustomer }

function TEntityCustomer.Print: String;
begin
   Result :=                                           BEGIN_NEW_LINE +
            BEGIN_FIELD + Division_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Customer_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Name            + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Address1        + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Address2        + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + City            + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + State           + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Zip_Code        + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Phone_No        + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Terms_Code      + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Open_Item       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Country_Code    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Tax_Schedule    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Tax_Exempt_No   + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Shipping_Method + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Fax_Number      + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Email_Address   + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Salesprsn_No    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Default_SLS_CD  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Shipping_Method + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Cust_Type       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Price_Level     + END_FIELD;
end;

{ TEntitySale_Invoice }
function TEntitySaleInvoice.Print: String;
begin
 Result :=                                             BEGIN_NEW_LINE +
            BEGIN_FIELD + Invoice_No      + END_FIELD +FIELD_SEPARATOR+
                          Invoice_Date    + FIELD_SEPARATOR+
            BEGIN_FIELD + Division_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Customer_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Default_Whse    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Tax_Schedule    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Terms_Code      + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Salesprsn       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Line_Type       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Item_Number     + END_FIELD +FIELD_SEPARATOR+
                          Discount        + FIELD_SEPARATOR+
            BEGIN_FIELD + Subj_to_Exempt  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + WareHouse_Code  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Cost_Type       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Product_Line    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Unit_of_Measure + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Lot_Serno_Dist  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Cogs_Account    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Reg_Sales_Acnt  + END_FIELD +FIELD_SEPARATOR+
                          Price_Ovrrddn   + FIELD_SEPARATOR+
            BEGIN_FIELD + Kit_Item        + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Bkord_Comp_LN   + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Skip_Comp       + END_FIELD +FIELD_SEPARATOR+
                          Um_Conv_Factor  + FIELD_SEPARATOR+
            BEGIN_FIELD + GL_Sales_Accnt  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + EmptyField      + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Misc_Item_Flag  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Misc_Item       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Stand_Kit_Bill  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Tax_Class       + END_FIELD +FIELD_SEPARATOR+
                          Qty_Ordered     + FIELD_SEPARATOR+
                          Qty_Shipped     + FIELD_SEPARATOR+
                          Qty_Backordered + FIELD_SEPARATOR+
                          Unit_Price      + FIELD_SEPARATOR+
                          Extension       + FIELD_SEPARATOR+
                          Taxable_Amt     + FIELD_SEPARATOR+
                          Non_Tax_Amt     + FIELD_SEPARATOR+
                          Sales_Tax       + FIELD_SEPARATOR+
            BEGIN_FIELD + Line_Disc_Perct + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Unit_Cost       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Item_Desc       + END_FIELD +FIELD_SEPARATOR+
                          Ship_Date       + FIELD_SEPARATOR+
                          Order_Date      + FIELD_SEPARATOR+
                          Invoice_due_dt  + FIELD_SEPARATOR+
                          Discount_Due_Dt + FIELD_SEPARATOR+
            BEGIN_FIELD + Bill_to_Name    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Bill_to_Addrs1  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Bill_to_Addrs2  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Bill_to_City    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Bill_to_State   + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Bill_to_Zip_CD  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_Code    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_Name    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_Addrs1  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_Addrs2  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_City    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_State   + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Ship_to_Zip_CD  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Comm_Desc_Line1 + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Comm_Desc_Line2 + END_FIELD +FIELD_SEPARATOR+
                          Charge_AMT      + FIELD_SEPARATOR+
            BEGIN_FIELD + Misc_Slash      + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Misc_Code       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Description     + END_FIELD +FIELD_SEPARATOR+
                          Freight;
end;

{ TEntityPayment }

function TEntityPayment.Print: String;
begin
 Result :=                                             BEGIN_NEW_LINE +
            BEGIN_FIELD + Bank_Code       + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Deposit_Number  + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Division_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Customer_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Customer_Name   + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Batch_Number    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Invoice_No      + END_FIELD +FIELD_SEPARATOR+
                          Amount_Posted   + FIELD_SEPARATOR+
                          Dep_Post_Date   + FIELD_SEPARATOR+
            BEGIN_FIELD + Document_No     + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Deposit_Type    + END_FIELD +FIELD_SEPARATOR+
            BEGIN_FIELD + Payment_Type    + END_FIELD +FIELD_SEPARATOR+
                          Deposit_Balance + FIELD_SEPARATOR+
                          Cust_Post_Amt;
end;

end.

