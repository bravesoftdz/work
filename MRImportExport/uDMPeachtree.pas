unit uDMPeachtree;

interface

uses
  SysUtils, Classes, PAW_TLB, Messages, Dialogs, DB, DBClient;

const

  RESULT_OPERATION_SUCCEED = 0;
  RESULT_KEY_NOT_FOUND     = 4;
  RESULT_DUPLICATED_KEY    = 5;
  RESULT_INVALID_KEY_NO    = 6;
  RESULT_NO_MORE_RECORDS   = 9;
  RESULT_INVALID_FILENAME  = 11;
  RESULT_FILE_NOT_FOUND    = 12;
  RESULT_CURRUPTED_RECORD  = 22;
  RESULT_FILE_IN_USE       = 85;


type
  TCompanyInfo = class
    Version : Double;
    CompanyName : String;
    AddrLine : String;
    AddrCity : String;
    AddrState : String;
    AddrPostalCode : String;
    AddrCountry : String;
    Telephone : String;
    Fax : String;
    BusinessType : String;
  end;

  TSale = class
    Amount : Currency;
    InvoiceNumber : String;
    SalesTaxCode : String;
    GLMainAccount : String;
    CashAccount : String;
    NRecord : Integer;
  end;

  TCustomerInfo = class
    index : Integer;
    CustomerID : String;
    BillToAddress1 : String;
    BillToCity : String;
    BillToCountry : String;
    BillToName : String;
    BillToState : String;
    BillToZipCode : String;
    Contact : String;
    CustomerSinceDate : TDateTime;
    CustomerType : String;
    Email : String;
    Fax : String;
    Web : String;
    Tel1 : String;
    SalesRepID : String;
  end;

  TDMPeachtree = class(TDataModule)
    cdsUser: TClientDataSet;
    cdsUserUserName: TStringField;
    cdsUserPassword: TStringField;
    cdsChatAccount: TClientDataSet;
    cdsChatAccountDescription: TStringField;
    cdsChatAccountAccountID: TStringField;
    cdsChatAccountAccountTypeDescription: TStringField;
    cdsSaleTax: TClientDataSet;
    cdsSaleTaxSalesTaxCode: TStringField;
    cdsSaleTaxDescription: TStringField;
    dsUser: TDataSource;
    dsChartAccount: TDataSource;
    dsSaleTax: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FStatus : Integer;
    FCompanyPath : String;

    FCompanyInfo : TCompanyInfo;
    FBTrieve: TBtrieve;
    FPeachw : TPeachw;
    FSelectCompany : TSelectCompany;
    FCompanyInformation: TCompanyInformation;

    procedure LoadCompanyInfo;
    procedure LoadUsers;
    procedure LoadChartOfAccount;
    procedure LoadSaleTax;

    procedure ValidateCustomer(CustInfo: TCustomerInfo);
    function getCurrentPeriod : Integer;
    function getCurrentForDate(dDate : TDateTime) : Integer;
    function getStartDateForPeriod(iPeriod : Integer) : TDateTime;

    procedure AddFirstLineItem(SalesJournal : TSalesJournal; CustomerInfo : TCustomerInfo);
    procedure AddPayment(AInvoice : TSale; CustomerInfo : TCustomerInfo);

  public
    function Init(ACompanyFolder : String): Boolean;
    function OpenConnection : Boolean;
    function CloseConnection : Boolean;

    function SaveSale(AInvoice : TSale; FCustomerInfo : TCustomerInfo) : Boolean;

    property CompanyInfo : TCompanyInfo read FCompanyInfo;
  end;

var
  DMPeachtree: TDMPeachtree;

implementation

uses DateUtils, Variants;

{$R *.dfm}

function TDMPeachtree.CloseConnection: Boolean;
begin

  { Disconnect is already assigned by Delphi so use Disconnect1
    to access PawCom's Discconect method }
  FBTrieve.Disconnect1; // Disconnect Btrieve1
  Result := True;

end;

function TDMPeachtree.OpenConnection: Boolean;
begin

  if FBTrieve.ConnectCount > 0 then
  begin
    Result := True;
  end
  else
  begin

    { PawCom documentation use Connect
     Connect method already exists with Delphi's
     base class for objects, so Delphi changes the name
     from Connect to Connect1 }

    FStatus := FBTrieve.Connect1(FCompanyPath);

    if FStatus = RESULT_OPERATION_SUCCEED then
    begin

      LoadCompanyInfo;

      { Always call Reset after Connect1, Without Reset some file operations
        will not function correctly }

      FBTrieve.Reset;

      Result := (FStatus = RESULT_OPERATION_SUCCEED);

      if FStatus <> RESULT_OPERATION_SUCCEED then
      begin
        MessageDlg('Open Company failed.'+#10+#13+'Status = '+IntToStr(FStatus),mtwarning,[mbok],0);
      end;

    end;

  end;

end;


procedure TDMPeachtree.DataModuleCreate(Sender: TObject);
begin
  FBTrieve := TBtrieve.Create(Self);
  FSelectCompany := TSelectCompany.Create(Self);
  FCompanyInformation := TCompanyInformation.Create(Self);
  FCompanyInfo := TCompanyInfo.Create;
  FPeachw := TPeachw.Create(Self);
end;

procedure TDMPeachtree.DataModuleDestroy(Sender: TObject);
begin
  CloseConnection;
  FreeAndNil(FBTrieve);
  FreeAndNil(FPeachw);
  FreeAndNil(FSelectCompany);
  FreeAndNil(FCompanyInformation);
  FreeAndNil(FCompanyInfo);
end;

function TDMPeachtree.Init(ACompanyFolder : String): Boolean;
begin

  { Opens PawCom's Select Company Dialog }
  { Assigns DOS Name path (ex:  C:\PEACHW\BCS ) }
  //C:\Program Files\Sage Software\Peachtree\Company

  FSelectCompany.CompanyPath := ACompanyFolder;

  FSelectCompany.ShowOpen;
  FCompanyPath := FSelectCompany.CompanyPath;

  { Checks CompanyPath make sure user selected a Company and
    pressed the Ok Button }
  Result := (FCompanyPath <> '');

  if Result then
  try
    if OpenConnection then
    begin
      LoadUsers;
      LoadChartOfAccount;
      LoadSaleTax;
    end;
  finally
    CloseConnection;
    end;

end;

procedure TDMPeachtree.LoadCompanyInfo;
begin
  { Open the Company Information File }
  FCompanyInformation.OpenFile;

  { Position to first (only) record in file }
  FStatus := FCompanyInformation.StepFirst;

  { Check to make sure file was opened }
  if FStatus <> RESULT_OPERATION_SUCCEED then
  begin
    Messagedlg('Unable to read Company Information.'+#10+#13+'Status = '+Inttostr(FStatus),mtwarning,[mbok],0);
    Exit;
  end; // Status <> 0 CompanyInformation1

  //if FCompanyInformation.RealTime then
  //  FCompanyInformation.RealTime := False;

  with FCompanyInformation do
  begin
    CompanyInfo.Version        := Version;
    CompanyInfo.CompanyName    := CompanyName;
    CompanyInfo.AddrLine       := AddrLine1 + ' ' + AddrLine2;
    CompanyInfo.AddrCity       := AddrCity;
    CompanyInfo.AddrState      := AddrState;
    CompanyInfo.AddrPostalCode := AddrPostalCode;
    CompanyInfo.AddrCountry    := AddrCountry;
    CompanyInfo.Telephone      := Telephone;
    CompanyInfo.Fax            := Fax;

    Case BusinessTypeCode of
      0 : CompanyInfo.BusinessType := 'Corporation';
      1 : CompanyInfo.BusinessType := 'S Corporation';
      2 : CompanyInfo.BusinessType := 'PartnerShip';
      3 : CompanyInfo.BusinessType := 'Sole Proprietorship';
      4 : CompanyInfo.BusinessType := 'Limited Liability Company';
      Else CompanyInfo.BusinessType := 'Not Assigned';
    end; // Case BusinessTypeCode
  end;

end;

procedure TDMPeachtree.LoadUsers;
var
  i, Counted : Integer;
  FUser : TUser;
begin

  FUser := TUser.Create(Self);
  try

    if not cdsUser.Active then
      cdsUser.CreateDataSet;

    FStatus := FUser.OpenFile;

    If FStatus = RESULT_OPERATION_SUCCEED then
    begin
      Counted := FUser.RecordCount;
      FUser.StepFirst;

      For i := 0 to (Counted-1) do
      begin
        with cdsUser do
        begin
          Append;
          FieldByName('UserName').AsString := FUser.UserName;
          FieldByName('Password').AsString := FUser.Password;
          Post;
        end;
        FUser.StepNext;
      end;
    end
    else
      MessageDlg('Open User failed.'+#10+#13+'Status = '+IntToStr(FStatus),mtwarning,[mbok],0);

  finally
    FUser.CloseFile;
    FreeAndNil(FUser);
    end;

end;

procedure TDMPeachtree.LoadChartOfAccount;
var
  i, Counted : Integer;
  FChartAcc : TmyChart;
begin

  try
    FChartAcc := TmyChart.Create(Self);
    FStatus := FChartAcc.OpenFile;

    if FStatus = RESULT_OPERATION_SUCCEED then
    begin

      if not cdsChatAccount.Active then
        cdsChatAccount.CreateDataSet;

      Counted := FChartAcc.RecordCount;
      FChartAcc.StepFirst;

      For i := 0 to (Counted-1) do
      begin
        with cdsChatAccount do
        begin
          Append;
          FieldByName('Description').AsString := FChartAcc.AccountDescription2;
          FieldByName('AccountID').AsString := FChartAcc.AccountID;
          FieldByName('AccountTypeDescription').AsString := FChartAcc.AccountTypeDescription;
          Post;
        end;
        FChartAcc.StepNext;
      end;

      {
        0	Cash
        1	Accounts Receivable
        2	Inventory
        3	<not used>
        4	Other Current Assets
        5	Fixed Assets
        6	Accumulated Depreciation
        7	<not used>
        8	Other Assets
        9	<not used>
        10	Accounts Payable
        11	<not used>
        12	Other Current Liabilities
        13	<not used>
        14	Long Term Liabilities
        15	<not used>
        16	Equity-doesn't close
        17	<not used>
        18	Equity-Retained Earnings
        19	Equity-gets closed
        20	<not used>
        21	Income
        22	<not used>
        23	Cost of Sales
        24	Expenses
      }
    end
    else
      MessageDlg('Open User failed.'+#10+#13+'Status = '+IntToStr(FStatus),mtwarning,[mbok],0);
  finally
    FChartAcc.CloseFile;
    FreeAndNil(FChartAcc);
    end;

end;

function TDMPeachtree.SaveSale(AInvoice : TSale; FCustomerInfo : TCustomerInfo): Boolean;
var
  FSale : TSalesJournal;

  i, iPeriod : Integer;

  TrxNumber, NRec : Integer;
  TrxDate : TDateTime;
begin

  Result := False;

  if OpenConnection then
  try
    FSale := TSalesJournal.Create(Self);

    //Open journal so we can perform operations on it
    FStatus := FSale.OpenFile;
    if FStatus <> RESULT_OPERATION_SUCCEED then
    begin
      ShowMessage('Could not open journal');
      Exit;
    end;

    //Put PAW in Batch mode.  PAW should always be put in batch mode first when modifying Journal records.
    //FCompanyInformation.StepFirst;

    //Get the next available TrxNumber for the current period and next journal Nrecord
    TrxDate := Trunc(Now);
    iPeriod := getCurrentForDate(TrxDate);
    if iPeriod = -1 then
    begin
      ShowMessage('Problem getting period, possibly due to previous error. Restart PawCom and try again.');
      Exit;
    end;


    TrxNumber        := FSale.MaxTrxNumberL[iPeriod] + 1;
    NRec             := FSale.MaxNRecord + 1;
    AInvoice.NRecord := NRec;

    if FStatus = RESULT_OPERATION_SUCCEED then
    begin
      //Header
      //Verifica se o invoice existe
      ValidateCustomer(FCustomerInfo);

      if FSale.GetForInvoice(AInvoice.InvoiceNumber) <> 0 then
      begin
        FSale.ClearRecord;

        FSale.Subindex1             := 0;          //The subindex1 code for the record.  Always 0 for Sales Journal records
        FSale.TrxNumberL            := TrxNumber;  //The transaction number for the current record
        FSale.JournalID             := 3;          //The journal ID value for the record.  For the Sales Journal the value is always 3.
        FSale.Period                := iPeriod;    //The period for the current record.  This should be a number between 0 and 41.
        FSale.Subindex2             := 0;          //The subindex2 code for the record.  Normally 0.  A value of 2 indicates a co-partner in Cash Disbursements
        FSale.JournalCode           := 'R';        //The journal code for the record.  For the Sales Journal the journal code is always the letter "R".  Size = 1
        FSale.NRecord               := NRec;       //A unique record number for the current journal record. (IDPreSale)
        FSale.CustomerIndex         := FCustomerInfo.Index; //The index of the customer record for which this record applies.  Corresponds to the index of the Customer ID field on the Peachtree Sales/Invoicing form.
        FSale.CustomerName          := FCustomerInfo.BillToName; //Name of the customer for which this record applies. Corresponds to the Name field on the Peachtree Sales/Invoicing form. Size = 39.
        FSale.ShipToName            := FCustomerInfo.BillToName; //The name the Ship To address on the invoice. Size = 30 before V9, 39 starting at V9.
        FSale.ShipToAddr1           := FCustomerInfo.BillToAddress1; //The first address line for the Ship To address on the invoice. Size = 30
        FSale.ShipToAddr2           := '';      //The second address line for the Ship To address on the invoice. Size = 30
        FSale.ShipToCity            := FCustomerInfo.BillToCity; //The city for the Ship To address on the invoice. Size = 20.
        FSale.ShipToState           := FCustomerInfo.BillToState; //The state the Ship To address on the invoice. Size = 2.
        FSale.ShipToZipcode         := FCustomerInfo.BillToZipCode; //The zipcode for the Ship To address on the invoice. Size = 12
        FSale.ShipToCountry         := FCustomerInfo.BillToCountry;
        FSale.TrxDate               := TrxDate;     //Transaction date for the current record

        FSale.SalesTaxCode          := AInvoice.SalesTaxCode; //The Sales Tax Code associated with this record.  Corresponds to the Sales Tax Code field on the Peachtree Sales/Invoicing form. Size = 8
        FSale.DateDue               := Trunc(Now); //Date on which payment is due. Peachtree calculates this from the terms.
        FSale.DiscountDate          := '';      //Latest date in which an early payment discount can be applied
        FSale.DiscountAmount        := 0;       //The discount amount to apply to the invoice if paid before the discount date.
        FSale.Terms                 := '';      //The "displayed" payment term options in text format. Corresponds to the Terms field on the Peachtree Sales/Invoicing form. Size = 39
        FSale.ShipVia               := 'None';   //The shipping method for the invoice. Corresponds to the Ship Via field on the Peachtree Sales/Invoicing form. Size = 12
        FSale.SalesRepID            := '';      //The EmployeeID of the Sales Rep associated with this record.  Corresponds to the Sales Rep ID field on the Peachtree Sales/Invoicing form. Size = 20.
        FSale.ARAmount              := AInvoice.Amount; //Total amount for the record.  Corresponds to the Invoice Total field on the Peachtree Sales/Invoicing form.
        FSale.Quote                 := False;   //True if this record is a quote.  For V7 Peachtree stores quotes in the Sales Journal record with this flag set to True.  For V8 and later Peachtree has created a separate Quote Journal.  PawCom merges the Quote Journal records with the Sales Journal records, but Quotes are now indicated by a JournalID of 12.
        FSale.NotePrintsAfterItems  := False;   //Indicates where the note should print on an invoice. Corresponds to the checkboxes on Note subform of the Peachtree Sales/Invoicing form
        FSale.BeginningBalanceFlag  := False;   //True if this is a beginning balance record
        FSale.Posted                := False;   //True if the current record has been posted.  For new records this should always be set False.
        FSale.Prepayment            := False;   //Unused field in the same location as the Prepayment check box on other type journal records
        FSale.Note                  := '';      //The note associated with the record. Corresponds to the Note field on Note subform of the Peachtree Sales/Invoicing form. Size = 2000
        FSale.AmountReceived        := AInvoice.Amount;       //Amount received with the invoice.  Corresponds to theAmount Paid at Sale field on the Peachtree Sales/Invoicing form
        FSale.HasPartner            := False;   //True if invoice has an associated cash receipts record.   For more information about partner entries see the section on the Journal Key in Chapter 4
        FSale.DropShip              := False;    //True if this is a Drop Ship Sales Order.  Corresponds to the Drop Ship check box on the Ship To subform of the Peachtree Sales/Invoicing form
        FSale.PaymentDate           := '';       //Date on which the invoice was paid
        FSale.TrxVoidedBy           := 0;        //If the transaction is an invoice and if it has been voided using Void Invoices in Peachtree, then this is the Nrecord number of the voiding transaction.  If this is the voiding invoice, then this field refers to the original invoice

        FSale.ARAccount             := '';      //Accounts Receivable account to use for the record, associated with the A/R Account field on the Peachtree Sales/Invoicing form. For V8 or later the ARAccount information is contained on a separate detail line with LineNo = 0. Size = 15
        FSale.InvoiceNumber         := AInvoice.InvoiceNumber; //Invoice number for this record.  Corresponds to the Invoice # field on the Peachtree Sales/Invoicing form. Peachtree fills this field when the invoice is printed.  Size = 20.
        FSale.RecurrenceIndex       := 0;       //For recurring records, a unique number for the set of recurring entries
        FSale.RecurrenceRate        := 0;       //An integer code for the rate at which recurring entries occur.  The Lookup Recurrence Rate table contains a textual description of the recurrence rate
        FSale.DateCleared           := '';      //Account Reconciliation date on which the record was cleared
        {Testar com 0 para ver se o invoice sera criado}
        FSale.NDistributions        := 0;       //The number of detail lines for the current record
        FSale.NumOrderLines         := 0;       //The total number of displayed lines on the invoice
        {}
        FSale.CustomerPO            := '';      //Customer's Purchase Order number. Corresponds to the Customer PO field on the Peachtree Sales/Invoicing form. Contains "Prepayment" if subindex2 =1 or "Payment" if subindex2 = 2. Size = 20.
        FSale.QuoteGoodThruDate     := '';      //The last date in which a sales quote is valid.  Corresponds to the Good Thru field that shows on the Peachtree Quotes form
        FSale.QuoteNumber           := '';       //If a quote has been converted to a sales invoice and the quote already has a number, this is that number. Corresponds to the quote number that shows on the Peachtree Quotes form. Size = 20
        FSale.ShipDate              := '';       //The ship date for this record.  Corresponds to the Ship Date field on the Peachtree Sales/Invoicing form.
        FSale.SONo                  := '';       //The Sales Order number when the record applies to a Sales Order. Corresponds to the SO # field on the Peachtree Sales/Invoicing form when the Apply to Sales Order tab is selected. Size = 20.
        FSale.DropShipCustomerIndex := FCustomerInfo.index; //The index of the customer for Drop Ship Sales Orders.  Corresponds to the index associated with the Customer ID on the Ship To subform of the Peachtree Sales/Invoicing form.
        FSale.DropShipInvNo         := '';       //The customer's invoice number.  Corresponds to the Invoice # on the Ship To subform of the Peachtree Sales/Invoicing form. Size = 20.

        If FCompanyInfo.Version >= 8.11 then
          FSale.ReceiptDate := FSale.TrxDate; //Data in this field is always the same as the TrxDate for this journal

        if FCompanyInfo.Version >= 9 then
        begin
          FSale.MainAccount  := AInvoice.GLMainAccount;   //The GL account for this journal entry.  Corresponds to GL Account on detail line 0 for V8 and later
          FSale.InternalNote := '';        //An internal note associated with the record that does not print on forms. Size = 2000
        end;

        if FCompanyInfo.Version >= 10 then
        begin
          FSale.GUID                        := FPeachw.GUID; //Universally unique global identifier for record.  Size = 38.
          FSale.ReturnAuthorization         := ''; //The return authorization if record is a credit memo. Size = 20
          FSale.StatementNote               := ''; //Note to print on the statement. Size = 2000
          FSale.PrintBeforeInvoiceReference := False; //Flag indicating a print was requested before the invoice number was specified
          FSale.JrnlTypeEx                  := 0;     //A field that indicates whether the record is a regular entry (value = 0) or a credit memo (value = 2).  For V>=13, 4=a "roll up" transaction created during purge, 5=created during company consolidation
          FSale.EditCount                   := 0;     //Count of how many times the record has been modified since its creation.
        end;

        {
        //Item Detail
        AddFirstLineItem(FSale, FCustomerInfo);

        i := 0;

        FSale.DetailLineNo[i]             := i;       //The detail line number.  For V7 the value returned is always set equal to Index.
        FSale.DetailTrxType[i]            := 0;       //Must be set before Amount. A code identifying what type of transaction this line corresponds to.  Observed values are  0	GL, 1	COS, 2	Inventory, 5	Sales Tax, 6	Freight
        FSale.DetailCostOfSalesTrx[i]     := False; //If true this row should be included in inventory-ledger type calculations and reports
        FSale.DetailQuantity[i]           := 1;       //The quantity associated with the specified detail line, associated with the Quantity fields in the lower part of the Peachtree Sales/Invoicing form
        //FSale.DetailGLAccount[i]          := '11000'; //The GL Account associated with the specified detail line. Size = 15
        FSale.DetailFreightFlag[i]        := False;   //True if freight charges are to be applied to this detail line
        FSale.DetailItemIndex[i]          := 138;     //The index of the item associated with the specified detail line, corresponding to the Item fields in the lower part of the Peachtree Sales/Invoicing form. Note:  For V7 the DetailSalesTaxAuthority and DetailItemIndex fields overlap each other in the Peachtree journal data.  Therefore if you specify one you should NOT specify the other or you will overwrite the first one.
        //FSale.DetailSalesTaxAuthority[i]  := '';    //The Sales Tax Authority associated with the specified detail line. Size = 8
        FSale.DetailAmount[i]             := dAmount;     //The amount associated with a particular detail line of the Sales Journal record, corresponding to the Amount fields in the lower part of the Peachtree Sales/Invoicing form
        FSale.DetailTaxType[i]            := 0;       //The tax type code associated with the specified detail line.
        FSale.DetailJobIndex[i]           := 0;       //The index for the job associated with the specified detail line, corresponding to the Job specified in the Job fields in the lower part of the Peachtree Sales/Invoicing form
        FSale.DetailPhaseIndex[i]         := 0;       //The index for the phase associated with the specified detail line, corresponding to the phase of a job specified in the Job fields in the lower part of the Peachtree Sales/Invoicing form.
        FSale.DetailCostIndex[i]          := 0;       //The index in the Cost Codes table for the job cost associated with the specified detail line
        FSale.DetailUnused1[i]            := 0;       //An unused byte in the detail line for V7.  Always returns 0 for later versions
        //FSale.DetailCostOfSalesAccount[i] := '';      //The COS Account associated with the specified detail line.  For V8 and later the Cost of Sales information is shown on a separate detail line with TrxType = 1. Size = 15.
        //FSale.DetailInventoryAccount[i]   := '';      //For V7 only, the Inventory Account associated with the specified detail line.  For V8 and later the Inventory information is shown on a separate detail line with TrxType = 2.  Size = 15.
        FSale.DetailCostOfSalesAmount[i]  := 0;       //For V7 data, the COS Amount associated with the specified detail line.  For V8 and greater this information is on a separate detail line with TrxType = 1.
        FSale.DetailUnitPrice[i]          := 300;     //The unit price associated with the specified detail line, corresponding to the Unit Price fields in the lower part of the Peachtree Sales/Invoicing form
        FSale.DetailApplyToSO[i]          := False;   //True if the detail line is to be applied to a Sales Order.  Peachtree sets this field True when the Apply to Sales Order tab is selected on the Sales/Invoicing form.
        FSale.DetailSOLine[i]             := 0;       //When an invoice has been applied to a sales order, the corresonding displayed line of the sales order
        FSale.DetailDisplayedLine[i]      := 1;       //The line number of the displayed line of the invoice.
        //FSale.DetailDescription[i]        := 'Assembled Redwood 12-Room Bird House on 14 ft. pole.  Attracts Purple Martins, Bluebirds and Wrens';  //A description for the specified detail line. Corresponds to the Description fields in the lower part of the Peachtree Sales/Invoicing form. Size = 160.
        FSale.DetailCustomerIndex[i]      := FCustomerInfo.index; // The index of the customer for the order.  The value in this field should be identical to the CustomerIndex field.

        If FCompanyInfo.Version > 7 then
            FSale.DetailInvoiceNRecord[i] := 0; //The Nrecord number of the invoice that is associated with the specified detail line

        //FSale.DetailInvoicePaid[i]        := '';    //The Invoice number of the invoice paid by the specified detail line. Size = 20
        FSale.DetailFlag1[i]              := True;  //True if this row is to be included in the general ledger and thus in all financial calculations based on general ledger amounts.  The value is always True for the Sales journal unless this is a beginning balance or subindex2 = 1 or 2.

        //If FCompanyInfo.Version >= 11 then
        //    FSale.DetailGUID[i]           := FPeachw.GUID;  //Universally unique global identifier for record.  Size = 38

        If FCompanyInfo.Version >= 11.5 then
        begin
            FSale.DetailStockingQuantity[i]  := 1;   //Manufacturing and Distribution versions only The stocking quantity associated with the specified detail line.
            FSale.DetailStockingUnitPrice[i] := 300; //Manufacturing and Distribution versions only The stocking unit price associated with the specified detail line.
            //FSale.DetailUMGUID[i]            := FPeachw.GUID;  //Universally unique global identifier for the corresponding Unit of Measure record.  Size = 38.
        end;

        If FCompanyInfo.Version >= 12 then
            FSale.DetailHasSerialNumbers[i] := False; //Flag used on some detail lines to indicate the associated item has serial numbers.

        If FCompanyInfo.Version >= 13 then
            FSale.DetailRetainagePercent[i] := 0; //The percentage amount to withhold for retainage.  Used by Construction version only.
            }

        //Copy the new Sales Journal record to the PAW Journal table
        FStatus := FSale.Insert;
        if FStatus <> RESULT_OPERATION_SUCCEED then
        begin
          ShowMessage('Creation of new record failed.'+#10+#13+' Status = ' + IntToStr(FStatus));
          Exit;
        end;

        FStatus := FSale.GetForInvoice(AInvoice.InvoiceNumber);
        if FStatus <> RESULT_OPERATION_SUCCEED then
        begin
          ShowMessage('Invoice not found. Status = ' + IntToStr(FStatus));
          Exit;
        end;

        //Payment
        AddPayment(AInvoice, FCustomerInfo);

        //Update count of Sales Journal batch records
        //FStatus := FSale.IncrementBatchCount;
        //if FStatus <> RESULT_OPERATION_SUCCEED then
        //begin
        //  ShowMessage('IncrementBatchCount failed.'+#10+#13+' Status = ' + IntToStr(FStatus));
        //  Exit;
        //end;
        Result := True;
      end;
    end
    else
      MessageDlg('Error openning sale.'+#10+#13+'Status = '+IntToStr(FStatus),mtwarning,[mbok],0);
  finally
    CloseConnection;
    FreeAndNil(FSale);
    end;

end;

procedure TDMPeachtree.LoadSaleTax;
var
  i, Counted : Integer;
  FSaleTax : TSalesTaxCode;
begin

  FSaleTax := TSalesTaxCode.Create(Self);
  try

    if not cdsSaleTax.Active then
      cdsSaleTax.CreateDataSet;

    FStatus := FSaleTax.OpenFile;

    If FStatus = RESULT_OPERATION_SUCCEED then
    begin
      Counted := FSaleTax.RecordCount;
      FSaleTax.StepFirst;

      For i := 0 to (Counted-1) do
      begin
        with cdsSaleTax do
        begin
          Append;
          FieldByName('SalesTaxCode').AsString := FSaleTax.SalesTaxCode;
          FieldByName('Description').AsString := FSaleTax.Description;
          Post;
        end;
        FSaleTax.StepNext;
      end;
    end
    else
      MessageDlg('Open Sale Tax failed.'+#10+#13+'Status = '+IntToStr(FStatus),mtwarning,[mbok],0);

  finally
    FSaleTax.CloseFile;
    FreeAndNil(FSaleTax);
    end;

end;

procedure TDMPeachtree.ValidateCustomer(CustInfo: TCustomerInfo);
var
  FCustomer : TCustomer;
begin

  if OpenConnection then
  try
    FCustomer := TCustomer.Create(Self);
    FStatus := FCustomer.OpenFile;

    FStatus := FCustomer.GetEqual(CustInfo.CustomerID);
    if FStatus = RESULT_KEY_NOT_FOUND then
    begin
      FCustomer.CustomerID         := CustInfo.CustomerID;
      FCustomer.BillToName         := CustInfo.BillToName;
      FCustomer.BillPresentment    := False;
      FCustomer.CustomerSinceDate  := Now;
      FCustomer.BillToSalesTaxCode := '';

      if FCompanyInfo.Version >= 10 then
        FCustomer.GUID := FPeachw.GUID;

      FStatus := FCustomer.Insert;

      FStatus := FCustomer.GetEqual(CustInfo.CustomerID);
      if FStatus <> RESULT_OPERATION_SUCCEED then
      begin
        ShowMessage('Customer not found. Status = ' + IntToStr(FStatus));
        Exit;
      end;
    end;

    CustInfo.index             := FCustomer.Index;
    CustInfo.BillToName        := FCustomer.BillToName;
    CustInfo.CustomerID        := FCustomer.CustomerID;
    CustInfo.BillToAddress1    := FCustomer.BillToAddress1;
    CustInfo.BillToCity        := FCustomer.BillToCity;
    CustInfo.BillToCountry     := FCustomer.BillToCountry;
    CustInfo.BillToState       := FCustomer.BillToState;
    CustInfo.BillToZipCode     := FCustomer.BillToZipcode;
    CustInfo.Contact           := FCustomer.Contact;
    CustInfo.CustomerSinceDate := FCustomer.CustomerSinceDate;
    CustInfo.CustomerType      := FCustomer.CustomerType;
    CustInfo.Email             := FCustomer.Email;
    CustInfo.Fax               := FCustomer.Fax;
    CustInfo.Web               := FCustomer.Web;
    CustInfo.Tel1              := FCustomer.Telephone1;
    CustInfo.SalesRepID        := FCustomer.SalesRepID;
    
  finally
    FreeAndNil(FCustomer);
    end;

end;

function TDMPeachtree.getCurrentPeriod: Integer;
var
  FGeneralData : TGeneralData;
begin

  FGeneralData := TGeneralData.Create(Self);
  try
    if OpenConnection then
    begin
      FStatus := FGeneralData.OpenFile;
      if FStatus = RESULT_OPERATION_SUCCEED then
      begin
         FStatus := FGeneralData.Read;
         Result  := FGeneralData.CurrentPeriod;
      end
      else
      begin
        ShowMessage('Could not open General.DAT');
        Result := 0;
      end;
    end;
  finally
    FGeneralData.CloseFile;
    FreeAndNil(FGeneralData);
    end;

end;

function TDMPeachtree.getStartDateForPeriod(iPeriod : Integer) : TDateTime;
var
  FGeneralData : TGeneralData;
  myDate : TDateTime;
begin
  FGeneralData := TGeneralData.Create(Self);
  try
    if OpenConnection then
    begin
      FStatus := FGeneralData.OpenFile;
      FStatus := FGeneralData.Read;
      if FStatus = RESULT_OPERATION_SUCCEED then
      begin
        if (iPeriod < 1) or (iPeriod > 41) then
        begin
          myDate := FGeneralData.PeriodEndDate[0];
          iPeriod := 0;
        end
        else
          myDate := FGeneralData.PeriodStartDate[iPeriod];

        Result := myDate;
      end;
    end;
  finally
    FGeneralData.CloseFile;
    FreeAndNil(FGeneralData);
    end;

end;


function TDMPeachtree.getCurrentForDate(dDate: TDateTime): Integer;
var
  FGeneralData : TGeneralData;
  myPeriod, PeriodDate : Integer;
  Found : Boolean;
begin

  FGeneralData := TGeneralData.Create(Self);
  try
    if OpenConnection then
    begin
      Found := False;
      FStatus := FGeneralData.OpenFile;
      if FStatus = RESULT_OPERATION_SUCCEED then
      begin
         FStatus := FGeneralData.Read;
         Result  := FGeneralData.NumberOfPeriods;
         for myPeriod := 0 to 49 do
           if (myPeriod <= Result) or
              ((myPeriod >= 15) And (myPeriod <= (14 + Result))) or
              ((myPeriod >= 29) And (myPeriod <= (28 + Result))) then
                if VarToStr(FGeneralData.PeriodEndDate[myPeriod]) <> '' then
                begin
                  PeriodDate := FGeneralData.PeriodEndDate[myPeriod];
                  if (Trunc(PeriodDate-dDate) >= 0) then
                  begin
                    Found := True;
                    Break;
                  end;
                end;
         if Found then
           Result := myPeriod
         else
           Result := -1;
      end
      else
      begin
        ShowMessage('Could not open General.DAT');
        Result := 0;
      end;
    end;
  finally
    FGeneralData.CloseFile;
    FreeAndNil(FGeneralData);
    end;
end;

procedure TDMPeachtree.AddFirstLineItem(SalesJournal: TSalesJournal;
     CustomerInfo : TCustomerInfo);
var
  i : Integer;
begin

  i := 0;

  SalesJournal.DetailLineNo[i]             := 0;
  SalesJournal.DetailTrxType[i]            := 0;     //Always 0 for this detail line
  SalesJournal.DetailCostOfSalesTrx[i]     := False;
  SalesJournal.DetailQuantity[i]           := 0;     //Always 0 for this detail line
  SalesJournal.DetailItemIndex[i]          := 0;     //Always 0 for this detail line
  //SalesJournal.DetailDescription[i]        := CustomerInfo.BillToName;
  //SalesJournal.DetailGLAccount[i]          := '11000';
  SalesJournal.DetailUnitPrice[i]          := 0;     //Always 0 for this detail line
  SalesJournal.DetailTaxType[i]            := 0;
  SalesJournal.DetailAmount[i]             := SalesJournal.ARAmount;
  SalesJournal.DetailJobIndex[i]           := 0;
  SalesJournal.DetailPhaseIndex[i]         := 0;
  SalesJournal.DetailCostIndex[i]          := 0;
  //SalesJournal.DetailSalesTaxAuthority[i]  := '';
  SalesJournal.DetailApplyToSO[i]          := False;
  SalesJournal.DetailInvoiceNRecord[i]     := 0;
  SalesJournal.DetailCustomerIndex[i]      := CustomerInfo.index;
  SalesJournal.DetailFlag1[i]              := True;

end;

procedure TDMPeachtree.AddPayment(AInvoice : TSale;
  CustomerInfo: TCustomerInfo);
var
  FCashReceiptJournal : TCashReceiptJournal;
  FDefaultCustomerData : TDefaultCustomerData;

  TrxNumber, NRec, iPeriod : Integer;
  TrxDate : TDateTime;

  i : Integer;
begin

  FCashReceiptJournal := TCashReceiptJournal.Create(Self);
  try
    if OpenConnection then
    begin
      FStatus := FCashReceiptJournal.OpenFile;
      if FStatus = RESULT_OPERATION_SUCCEED then
      begin

        iPeriod := getCurrentPeriod;
        if iPeriod = 0 then
        begin
          ShowMessage('Problem getting period, possibly due to previous error. Restart PawCom and try again.');
          Exit;
        end;

        TrxDate   := getStartDateForPeriod(iPeriod) + 15;
        TrxNumber := FCashReceiptJournal.MaxTrxNumberL[iPeriod] + 1;
        NRec      := FCashReceiptJournal.MaxNRecord + 1;

        FCashReceiptJournal.ClearRecord;

        FCashReceiptJournal.NRecord               := NRec;        //A unique record number for the current journal record.
        FCashReceiptJournal.Period                := iPeriod;     //The period for the current record.  This should be a number between 0 and 41.
        FCashReceiptJournal.TrxNumberL            := TrxNumber;   //The transaction number for the current record
        FCashReceiptJournal.JournalID             := 1;           //The journal ID value for the record.  For the Cash Receipt Journal the value is always 1
        FCashReceiptJournal.Subindex1             := 0;           //The subindex1 code for the record.  Normally 0, but if the receipt is for a Sales Journal record, the value is 1, indicating a partner record that corresponds to a Sales Journal record with an amount paid on the invoice
        FCashReceiptJournal.Subindex2             := 0;           //The subindex2 code for the record.  For the Cash Receipt Journal the value is always 0.
        FCashReceiptJournal.JournalCode           := 'R';         //Journal code for the record.  For the Cash Receipt Journal it should be the letter "R".  Size = 1
        FCashReceiptJournal.TrxDate               := TrxDate;     //Transaction date for the current record.  This corresponds to the Date field on the Peachtree Receipts form
        FCashReceiptJournal.CustomerIndex         := CustomerInfo.index; //The index of the customer record for which this Cash Receipt record applies.
        FCashReceiptJournal.CustomerName          := CustomerInfo.BillToName; //Name of customer to which this Cash Receipts record applies. (May differ from Check Name.) Size = 39.
        FCashReceiptJournal.CheckName             := CustomerInfo.BillToName; //The name for the check. Size = 30 before V9, 39 starting at V9.
        FCashReceiptJournal.CheckAddr1            := CustomerInfo.BillToAddress1; //The first address line for the check. Size = 30.
        FCashReceiptJournal.CheckAddr2            := '';
        FCashReceiptJournal.CheckCity             := CustomerInfo.BillToCity; //The city for the check. Size = 20.
        FCashReceiptJournal.CheckState            := CustomerInfo.BillToState; //The state the check. Size = 2.
        FCashReceiptJournal.CheckZipcode          := CustomerInfo.BillToZipCode; //The zipcode for the check. Size = 12.
        FCashReceiptJournal.CheckCountry          := CustomerInfo.BillToCountry; //The country for the check. Size = 15.
        FCashReceiptJournal.SalesRepID            := CustomerInfo.SalesRepID; //EmployeeID for the Sales Rep for the receipt. Size = 20.
        {mudar}
        FCashReceiptJournal.CashAmount            := AInvoice.Amount; //Total amount for the record.  Corresponds to the Receipt Amount field on the Peachtree Receipts form. (ReceiptAmount - DiscountAmount)
        FCashReceiptJournal.Reference             := AInvoice.InvoiceNumber; //Reference description for the receipt. Corresponds to Reference field on Peachtree Receipts form. Size = 20.
        FCashReceiptJournal.Posted                := True; //True if the current record has been posted.  For new records this should always be set False.
        FCashReceiptJournal.BeginningBalanceFlag  := False; //True if this is a beginning balance record
        FCashReceiptJournal.SalesTaxCode          := AInvoice.SalesTaxCode;  //Sales Tax code for the receipt. Corresponds to the Sales Tax Code field at the bottom of the Peachtree Receipts form. Size = 8.
        FCashReceiptJournal.InvoicesPaid          := -1 * AInvoice.Amount; //(Amount to be paid against the invoice) The total amount that has been paid on invoices when the receipt applies to invoices. -ReceiptAmount
        FCashReceiptJournal.DepositTicketID       := FormatDateTime('mm/dd/yyyy', TrxDate);//Deposit ticket ID associated with receipt.  (Deposit Ticket ID on Peachtree Receipts form.) Size = 8. (Text to describe the deposit ticket)

        FDefaultCustomerData := TDefaultCustomerData.Create(Self);
        try
          FDefaultCustomerData.OpenFile;
          FStatus := FDefaultCustomerData.Read;
          FCashReceiptJournal.PaymentMethod   := FDefaultCustomerData.PaymentMethod[1]; //(Integer code for the payment method) Description of payment method for receipt. (Payment Method field on Peachtree Receipts form.) Size = 20.
          FCashReceiptJournal.DiscountAccount := FDefaultCustomerData.DiscountGLAccount; //The Discount Account associated with the cash receipt. The default value for this field should be the Default Discount GL Account in the Peachtree Default Customer data. For V8 and later the Discount information is presented on a separate detail line.    Size = 15.

          if FCompanyInfo.Version < 8 Then
            FCashReceiptJournal.CashAccount := AInvoice.CashAccount; //Cash account for the record, associated with the Cash Account field on the Peachtree Receipts form.   For V8 and later the Cash Account information is shown on a separate detail line with LineNo = 0. Size = 15.


          if FCompanyInfo.Version >= 9 then
            FCashReceiptJournal.MainAccount := FCashReceiptJournal.CashAccount; //The GL account for this journal entry.  Corresponds to GL Account on detail line 0 for V8 and later.

          if FCompanyInfo.Version >= 10 Then
            FCashReceiptJournal.GUID := FPeachw.GUID; //Universally unique global identifier for record.  Size = 38.

        finally
          FDefaultCustomerData.CloseFile;
          FreeAndNil(FDefaultCustomerData);
          end;

        //Add lines of detail (required)

        FCashReceiptJournal.NDistributions := 1;

        if FCompanyInfo.Version >= 8 then
        begin
          i := 1;
          //FCashReceiptJournal.DetailGLAccount[i]         := AInvoice.CashAccount; //The GL Account associated with the specified detail line.. Size = 15
          FCashReceiptJournal.DetailAmount[i]            := AInvoice.Amount; //The amount associated with a particular detail line of the Cash Receipt record, corresponding to the Amount fields in the lower part of the Peachtree Receipts form
          FCashReceiptJournal.DetailUnitPrice[i]         := 0; //Unit price associated with specified detail line
          //FCashReceiptJournal.DetailDescription[i]       := CustomerInfo.BillToName; //The description associated with the specified detail line, corresponding to the Description fields in the lower part of the Peachtree Receipt s form. Size = 160.
          FCashReceiptJournal.DetailTaxType[i]           := 0; //The tax type code associated with the specified detail line
          FCashReceiptJournal.DetailJobIndex[i]          := 0; //The index for the job associated with the specified detail line, corresponding to the Job specified in the Job fields in the lower part of the Peachtree Receipts form
          FCashReceiptJournal.DetailPhaseIndex[i]        := 0; //The index for the phase associated with the specified detail line, corresponding to the phase of a job specified in the Job fields in the lower part of the Peachtree Receipts form
          FCashReceiptJournal.DetailCostIndex[i]         := 0; //The index in the Cost Codes table for the job cost associated with the specified detail line.
          FCashReceiptJournal.DetailTrxType[i]           := 0; //A code identifying what type of transaction this line corresponds to.  Observed values are: 0 GL, 1 COS, 2 Inventory, 4 Discount, 5 Sales Tax,
          FCashReceiptJournal.DetailLineNo[i]            := 0; //The detail line number.  For V7 the value returned is always set equal to Index
          FCashReceiptJournal.DetailInvoiceNRecord[i]    := AInvoice.NRecord; //The Nrecord number of the invoice that this record pays.
          FCashReceiptJournal.DetailFlag1[i]             := True; //True if this row is to be included in the general ledger and thus in all financial calculations based on general ledger amounts.  Always True for the Cash Receipts journal except for beginning balance records.
          FCashReceiptJournal.DetailCustomerIndex[i]     := CustomerInfo.index; //Same as Customer Index.  Should always be set on writing V8 or higher records
          FCashReceiptJournal.DetailCostOfSalesAmount[i] := AInvoice.Amount; //The COS amount that applies to a particular detail line of the Cash Receipt record.
          if FCompanyInfo.Version >= 11 then
          begin
            //FCashReceiptJournal.DetailGUID[i]        := FPeachw.GUID;
            FCashReceiptJournal.DetailDateCleared[i] := Null;
          end;
        end;

        FStatus := FCashReceiptJournal.Insert;
        if FStatus <> RESULT_OPERATION_SUCCEED then
        begin
          ShowMessage('Payment not inserted. Status = ' + IntToStr(FStatus));
          Exit;
        end;


      end
      else
        ShowMessage('Could not open journal. Status = ' + IntToStr(FStatus));
    end;
  finally
    FCashReceiptJournal.CloseFile;
    FreeAndNil(FCashReceiptJournal);
    end;

end;


end.
