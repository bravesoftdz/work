unit uFrmQuickBooks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, StdCtrls, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, Buttons, Mask,
  DateBox, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DBClient, Menus,
  uDMQuickBooks, uDMImportExport, ADODB, Provider;

type
  TFrmQuickBooks = class(TFrmParent)
    Panel1: TPanel;
    Label9: TLabel;
    lbVersion: TLabel;
    imgPeachtree: TImage;
    Shape8: TShape;
    lbSelection: TLabel;
    pnlMenu: TPanel;
    lbInvoices: TLabel;
    lbCustomer: TLabel;
    imgInvoices: TImage;
    imgSelect2: TImage;
    Shape6: TShape;
    imgExit: TImage;
    lbExit: TLabel;
    lbMRVersion: TLabel;
    pgOption: TPageControl;
    tsCustomer: TTabSheet;
    tsSale: TTabSheet;
    pnlFilter: TPanel;
    Label13: TLabel;
    lbFrom: TLabel;
    Label5: TLabel;
    cbxStore: TcxLookupComboBox;
    dtStart: TDateBox;
    dtEnd: TDateBox;
    btnSearch: TBitBtn;
    btnUpdate: TBitBtn;
    cdsInvoice: TClientDataSet;
    cdsInvoiceMarked: TBooleanField;
    cdsInvoiceInvoiceCode: TStringField;
    cdsInvoiceInvoiceDate: TDateTimeField;
    cdsInvoiceTotalInvoice: TBCDField;
    cdsInvoiceCustomer: TStringField;
    cdsInvoiceIDInvoice: TIntegerField;
    cdsInvoiceMediaID: TIntegerField;
    cdsInvoiceFirstName: TStringField;
    cdsInvoiceLastName: TStringField;
    cdsInvoiceIDPreSale: TIntegerField;
    cdsInvoiceCanceled: TBooleanField;
    cdsInvoiceSubTotal: TBCDField;
    cdsInvoiceTax: TBCDField;
    cdsInvoiceLayaway: TBooleanField;
    cdsInvoiceAditionalExpenses: TBCDField;
    cdsInvoiceSaleCode: TStringField;
    cdsInvoiceAccInvoiceNumber: TStringField;
    cdsInvoiceAccGLMainAccount: TStringField;
    cdsInvoiceAccSalesTaxCode: TStringField;
    cdsInvoiceAccCashAccount: TStringField;
    cdsInvoiceAccCustomerID: TStringField;
    dsInvoice: TDataSource;
    grdSales: TcxGrid;
    grdSalesDBTableView: TcxGridDBTableView;
    grdSalesLevel: TcxGridLevel;
    popSelection: TPopupMenu;
    Selectall1: TMenuItem;
    UnSelectAll1: TMenuItem;
    imgConfig: TImage;
    lbConfig: TLabel;
    cdsCategory: TClientDataSet;
    imgItems: TImage;
    lbItems: TLabel;
    tsItems: TTabSheet;
    cxgrdCustomer: TcxGrid;
    cxgrdDBCustomer: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    pnlComple: TPanel;
    lbResult: TLabel;
    btnComplete: TButton;
    pbExportSales: TProgressBar;
    cxgrdCategory: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    dsCategory: TDataSource;
    cdsCategoryIDCategory: TIntegerField;
    cdsCategoryCategory: TStringField;
    cxGridDBTableView2IDCategory: TcxGridDBColumn;
    cxGridDBTableView2Category: TcxGridDBColumn;
    Panel2: TPanel;
    btnSearchCustomer: TBitBtn;
    cdsEntity: TClientDataSet;
    dsEntity: TDataSource;
    cdsEntityIDPessoa: TIntegerField;
    cdsEntityIDTipoPessoa: TIntegerField;
    cdsEntityPath: TStringField;
    cdsEntityPessoa: TStringField;
    cdsEntityTelefone: TStringField;
    cdsEntityCellular: TStringField;
    cdsEntityFax: TStringField;
    cdsEntityCode: TIntegerField;
    cdsEntitySystem: TBooleanField;
    cdsEntityDesativado: TIntegerField;
    cdsEntityHidden: TIntegerField;
    cdsEntityCountry: TStringField;
    cdsEntityStateName: TStringField;
    cdsEntityState: TStringField;
    cdsEntityAddress: TStringField;
    cdsEntityCity: TStringField;
    cdsEntityZip: TStringField;
    cdsEntityEmail: TStringField;
    cdsEntityContact: TStringField;
    cdsEntityFederalID: TStringField;
    cdsEntitySalesTax: TStringField;
    cdsEntityDriverLicense: TStringField;
    cdsEntityJobDoc: TStringField;
    cdsEntityUserCode: TStringField;
    cdsEntitySocialSecurity: TStringField;
    cdsEntitySCDate: TDateTimeField;
    cdsEntitySCGov: TStringField;
    cdsEntityLastName: TStringField;
    cdsEntityFirstName: TStringField;
    cdsEntityCPF: TStringField;
    cdsEntityCGC: TStringField;
    cdsEntityCustomerCard: TStringField;
    cdsEntityNeighborwood: TStringField;
    cdsEntityPhoneAreaCode: TStringField;
    cdsEntityCellAreaCode: TStringField;
    cdsEntityNascimento: TDateTimeField;
    cxgrdDBCustomerPessoa: TcxGridDBColumn;
    cxgrdDBCustomerTelefone: TcxGridDBColumn;
    cxgrdDBCustomerState: TcxGridDBColumn;
    cxgrdDBCustomerAddress: TcxGridDBColumn;
    cxgrdDBCustomerCity: TcxGridDBColumn;
    cxgrdDBCustomerZip: TcxGridDBColumn;
    cxgrdDBCustomerEmail: TcxGridDBColumn;
    cxgrdDBCustomerContact: TcxGridDBColumn;
    cxgrdDBCustomerPhoneAreaCode: TcxGridDBColumn;
    Label1: TLabel;
    edtCustomerName: TEdit;
    cdsInvoiceTelefone: TStringField;
    cdsInvoiceCountry: TStringField;
    cdsInvoiceState: TStringField;
    cdsInvoiceAddress: TStringField;
    cdsInvoiceCity: TStringField;
    cdsInvoiceZip: TStringField;
    cdsInvoiceEmail: TStringField;
    cdsInvoiceContact: TStringField;
    cdsInvoicePhoneAreaCode: TStringField;
    cdsInvoiceFax: TStringField;
    cdsSaleItem: TClientDataSet;
    cdsSaleItemModelID: TIntegerField;
    cdsSaleItemCaseQty: TBCDField;
    cdsSaleItemModel: TStringField;
    cdsSaleItemDescription: TStringField;
    cdsSaleItemCategory: TStringField;
    cdsSaleItemSuggRetail: TBCDField;
    cdsSaleItemQty: TBCDField;
    cdsSaleItemExchangeInvoice: TIntegerField;
    cdsSaleItemSalePrice: TBCDField;
    cdsSaleItemCostPrice: TBCDField;
    cdsSaleItemDiscount: TBCDField;
    cdsSaleItemItemTotalSold: TBCDField;
    cdsSaleItemIDUser: TIntegerField;
    cdsSaleItemIDComission: TIntegerField;
    cdsSaleItemIDInventoryMov: TIntegerField;
    cdsSaleItemTax: TBCDField;
    cdsSaleItemNotVerifyQty: TBooleanField;
    cdsSaleItemIDDepartment: TIntegerField;
    cdsSaleItemRequestCustomer: TBooleanField;
    cdsSaleItemPuppyTracker: TBooleanField;
    cdsSaleItemPromo: TBooleanField;
    cdsSaleItemSellingPrice: TBCDField;
    cdsSaleItemIDMovParent: TIntegerField;
    cdsSalePayment: TClientDataSet;
    cdsSalePaymentIDLancamento: TIntegerField;
    cdsSalePaymentValorNominal: TBCDField;
    cdsSalePaymentMeioPag: TStringField;
    cdsSalePaymentTipo: TIntegerField;
    cdsSalePaymentDataLancamento: TDateTimeField;
    imgTimeClock: TImage;
    lbTimeClock: TLabel;
    tsTimeClock: TTabSheet;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cxTimeStore: TcxLookupComboBox;
    dtTimeStart: TDateBox;
    dtTimeEnd: TDateBox;
    btnTimeSearch: TBitBtn;
    grdTimeClock: TcxGrid;
    cxGridDBTimeClock: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    cdsTimeClock: TClientDataSet;
    dsTimeClock: TDataSource;
    cdsTimeClockEnterDate: TDateTimeField;
    cdsTimeClockExitDate: TDateTimeField;
    cdsTimeClockWorkedHour: TDateTimeField;
    cdsTimeClockWorkHourPay: TIntegerField;
    cdsTimeClockWorkMunitPay: TBCDField;
    cdsTimeClockPessoa: TStringField;
    cdsTimeClockIDUser: TIntegerField;
    cdsTimeClockStore: TStringField;
    cxGridDBTimeClockPessoa: TcxGridDBColumn;
    cxGridDBTimeClockStore: TcxGridDBColumn;
    cxGridDBTimeClockEnterDate: TcxGridDBColumn;
    cxGridDBTimeClockExitDate: TcxGridDBColumn;
    cxGridDBTimeClockWorkedHour: TcxGridDBColumn;
    cxGridDBTimeClockWorkHourPay: TcxGridDBColumn;
    cxGridDBTimeClockWorkMunitPay: TcxGridDBColumn;
    cxGridDBTimeClockIDUser: TcxGridDBColumn;
    cdsTimeClockMarked: TBooleanField;
    cxGridDBTimeClockMarked: TcxGridDBColumn;
    btnMarkTime: TBitBtn;
    cdsImportTime: TClientDataSet;
    StringField1: TStringField;
    DateTimeField1: TDateTimeField;
    cdsImportTimeWorkedHour: TDateTimeField;
    cdsQBCashRegMov: TClientDataSet;
    dsQBCashRegMov: TDataSource;
    cdsQBCashRegMovMarked: TBooleanField;
    cdsQBCashRegMovIDCashRegMov: TIntegerField;
    cdsQBCashRegMovOpenTime: TDateTimeField;
    cdsQBCashRegMovTotalCash: TBCDField;
    cdsQBCashRegMovGrandTotal: TCurrencyField;
    grdSalesDBTableViewMarked: TcxGridDBColumn;
    grdSalesDBTableViewTransNum: TcxGridDBColumn;
    grdSalesDBTableViewOpenTime: TcxGridDBColumn;
    grdSalesDBTableViewGrandTotal: TcxGridDBColumn;
    cdsQBPayments: TClientDataSet;
    cdsQBPaymentsIDMeioPag: TIntegerField;
    cdsQBPaymentsMeioPag: TStringField;
    cdsQBPaymentsAmount: TBCDField;
    cdsQBCashRegMovCashRegister: TStringField;
    grdSalesDBTableViewCashRegister: TcxGridDBColumn;
    cdsQBCashRegMovTotalCheck: TBCDField;
    cdsQBCashRegMovIDStore: TIntegerField;
    cdsQBCashRegMovTransDate: TDateTimeField;
    cdsQBCashRegMovTransNum: TStringField;
    grdSalesDBTableViewTransDate: TcxGridDBColumn;
    cdsQBCashRegItem: TClientDataSet;
    cdsQBCashRegItemIDGroup: TIntegerField;
    cdsQBCashRegItemCategory: TStringField;
    cdsQBCashRegItemItemTotalSold: TBCDField;
    cdsQBCashRegItemTax: TBCDField;
    cdsQBCashRegMovTotalTax: TCurrencyField;
    cdsQBCashRegMovTotalPetty: TBCDField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbExitClick(Sender: TObject);
    procedure cdsInvoiceBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnSearchClick(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure UnSelectAll1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbConfigClick(Sender: TObject);
    procedure btnCompleteClick(Sender: TObject);
    procedure cdsEntityBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnSearchCustomerClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure cdsSalePaymentBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsTimeClockBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnTimeSearchClick(Sender: TObject);
    procedure cdsSaleItemBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsQBCashRegMovBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsQBPaymentsBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsQBCashRegItemBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FDMQuickBooks : TDMQuickBooks;
    iCurrenctInvoice, iCurrenctIDPreSale, iCurrentIDCashRegMov : Integer;
    function QuickBooksConnect : Boolean;
    procedure ShowPanel(iOption: Integer);
    procedure LoadValues;
    procedure CreateItems;
    procedure CreateCustomers;
    procedure CreateSales;
    procedure CreateRevMov;
    procedure CreateTimeClock;

    procedure OpenItems;
    procedure CloseItems;

    procedure OpenCustomer;
    procedure CloseCustomer;

    procedure OpenCashRegMov;
    procedure CloseCashRegMov;

    procedure GetTotalPayment(var APositive, ANegative : Currency);

    procedure InsertTestMemoCredit;
  public
    function Start : Boolean;
  end;


implementation

uses uMRSQLParam, uDateTimeFunctions, uFrmQuickBooksConfig, DateUtils,
  uParamFunctions, ibqitem, uNumericfunctions;

{$R *.dfm}

{ TFrmQuickBooks }

function TFrmQuickBooks.Start: Boolean;
begin

  Result := False;

  if QuickBooksConnect then
  begin
    LoadValues;
    ShowModal;
    Result := True;
  end;

end;

procedure TFrmQuickBooks.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  CloseItems;
  CloseCustomer;
  CloseCashRegMov;

  FreeAndNil(FDMQuickBooks);

  DMImportExport.CloseStore;
  DMImportExport.ImportConn.Connected := False;

end;

procedure TFrmQuickBooks.lbExitClick(Sender: TObject);
begin
  inherited;
  ShowPanel(TLabel(Sender).Tag);
end;

procedure TFrmQuickBooks.ShowPanel(iOption: Integer);
begin
  case iOption of
    0 : Close;
    1 : begin
          pgOption.ActivePage := tsSale;
          lbSelection.Caption := tsSale.Caption;
        end;
    2 : begin
          pgOption.ActivePage := tsCustomer;
          lbSelection.Caption := tsCustomer.Caption;
        end;
    3 : begin
          OpenItems;
          pgOption.ActivePage := tsItems;
          lbSelection.Caption := tsItems.Caption;
        end;
    4 : begin
          pgOption.ActivePage := tsTimeClock;
          lbSelection.Caption := tsTimeClock.Caption;
        end;
  end;
end;

procedure TFrmQuickBooks.cdsInvoiceBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('IDInvoice');
    Param.KeyByName('IDInvoice').AsInteger := 0;
    Param.KeyByName('IDInvoice').Condition := tcDifferent;

    Param.AddKey('InvoiceDate');
    Param.KeyByName('InvoiceDate').AsString  := MyFormatDate(Trunc(dtStart.Date));
    Param.KeyByName('InvoiceDate').Condition := tcGreaterThanEqual;
    Param.KeyByName('InvoiceDate').Field     := 'InvoiceDate';

    Param.AddKey('InvoiceDate1');
    Param.KeyByName('InvoiceDate1').AsString  := MyFormatDate(Trunc(dtEnd.Date+1));
    Param.KeyByName('InvoiceDate1').Condition := tcLessThan;
    Param.KeyByName('InvoiceDate1').Field     := 'InvoiceDate';

    if cbxStore.EditValue > 0 then
    begin
      Param.AddKey('IDStore');
      Param.KeyByName('IDStore').AsInteger := cbxStore.EditValue;
      Param.KeyByName('IDStore').Condition := tcEquals;
      Param.KeyByName('IDStore').Field     := 'I.IDStore';
    end;

    OwnerData := Param.ParamString;
  finally
    FreeAndNil(Param);
  end;

end;

procedure TFrmQuickBooks.btnSearchClick(Sender: TObject);
begin
  inherited;

  try
    Screen.Cursor := crHourGlass;
    CloseCashRegMov;
    OpenCashRegMov;
    grdSalesDBTableView.DataController.Groups.FullExpand;
    {
    with cdsInvoice do
    begin
      if Active then
        Close;
      Open;
    end;
    }
  finally
    Screen.Cursor := crDefault;
  end;
  
end;

procedure TFrmQuickBooks.LoadValues;
begin
  //dtStart.Date := InicioMes(Now);
  //dtEnd.Date   := FimMes(Now);

  dtStart.Date := Trunc(Now);
  dtEnd.Date   := Trunc(Now);

  dtTimeStart.Date := Trunc(InicioMes(Now));
  dtTimeEnd.Date   := Trunc(FimMes(Now));

  grdSalesDBTableView.OptionsView.GroupByBox := False;

  ShowPanel(1);

  DMImportExport.ImportConn.Connected := True;
  DMImportExport.OpenStore;

  if DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc') = '' then
    lbConfigClick(Self);
    
end;

procedure TFrmQuickBooks.Selectall1Click(Sender: TObject);
var
  cds : TClientDataSet;
begin
  inherited;

  if pgOption.ActivePage = tsSale then
  begin
    //cds := cdsInvoice;
    cds := cdsQBCashRegMov;
  end else if pgOption.ActivePage = tsTimeClock then
  begin
    cds := cdsTimeClock;
  end;

  with cds do
    if Active then
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if not FieldByName('Marked').AsBoolean then
        begin
          Edit;
          FieldByName('Marked').AsBoolean := True;
          Post;
        end;
        Next;
      end;
    finally
      EnableControls;
      end;

end;

procedure TFrmQuickBooks.UnSelectAll1Click(Sender: TObject);
var
  cds : TClientDataSet;
begin
  inherited;

  if pgOption.ActivePage = tsSale then
  begin
    //cds := cdsInvoice;
    cds := cdsQBCashRegMov;
  end else if pgOption.ActivePage = tsTimeClock then
  begin
    cds := cdsTimeClock;
  end;

  with cds do
    if Active then
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if FieldByName('Marked').AsBoolean then
        begin
          Edit;
          FieldByName('Marked').AsBoolean := False;
          Post;
        end;
        Next;
      end;
    finally
      EnableControls;
      end;

end;

function TFrmQuickBooks.QuickBooksConnect: Boolean;
begin

  with FDMQuickBooks do
  begin
    ConnectionMode  := CON_TYPE_DONT_CARE;
    ApplicationName := 'MainRetail';
    CompanyFile     := '';
    Result          := Connect;
  end;

end;

procedure TFrmQuickBooks.FormCreate(Sender: TObject);
begin
  inherited;
  FDMQuickBooks := TDMQuickBooks.Create(Self);
end;

procedure TFrmQuickBooks.lbConfigClick(Sender: TObject);
begin
  inherited;
  with TFrmQuickBooksConfig.Create(Self) do
    Start;
end;

procedure TFrmQuickBooks.CreateItems;
var
  QBItem : TQBItem;
begin

  QBItem := TQBItem.Create(FDMQuickBooks.GetConnectionString);
  try
    Screen.Cursor := crHourGlass;

    QBItem.SetConnectionStr(FDMQuickBooks.GetConnectionString);

    QBItem.Account := DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc');

    pbExportSales.Visible := True;
    Application.ProcessMessages;
    
    OpenItems;
    with cdsCategory do
    begin
      DisableControls;
      First;

      pbExportSales.Position := 0;
      pbExportSales.Max      := RecordCount;

      while not EOF do
      begin
        QBItem.ItemName      := Copy(FieldByName('Category').AsString, 0, 30);
        QBItem.Desc          := FieldByName('Category').AsString;
        QBItem.SalesTaxCode  := '';
        QBItem.Price         := 0;

        QBItem.AddItem;

        pbExportSales.Position := pbExportSales.Position + 1;
        Application.ProcessMessages;

        Next;
      end;

      First;
      EnableControls;
    end;

  finally
    pbExportSales.Visible := False;
    FreeAndNil(QBItem);
    Screen.Cursor := crDefault;
  end;

end;

procedure TFrmQuickBooks.CloseItems;
begin
  with cdsCategory do
    if Active then
      Close;
end;

procedure TFrmQuickBooks.OpenItems;
begin
  with cdsCategory do
    if not Active then
      Open;
end;

procedure TFrmQuickBooks.btnCompleteClick(Sender: TObject);
begin
  inherited;

  try
    btnComplete.Enabled := False;

    if pgOption.ActivePage = tsItems then
    begin
      CreateItems;
    end else if pgOption.ActivePage = tsCustomer then
    begin
      CreateCustomers;
    end else if pgOption.ActivePage = tsSale then
    begin
      //CreateSales;
      CreateRevMov;
    end else if pgOption.ActivePage = tsTimeClock then
    begin
      CreateTimeClock;
    end;

  finally
    btnComplete.Enabled := True;
  end;

end;

procedure TFrmQuickBooks.cdsEntityBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('P.Pessoa');
    Param.KeyByName('P.Pessoa').AsString := edtCustomerName.Text;
    Param.KeyByName('P.Pessoa').Condition := tcLikeStartWith;


    OwnerData := Param.ParamString;
  finally
    FreeAndNil(Param);
  end;

end;

procedure TFrmQuickBooks.btnSearchCustomerClick(Sender: TObject);
begin
  inherited;

  try
    Screen.Cursor := crHourGlass;
    CloseCustomer;
    OpenCustomer;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TFrmQuickBooks.CreateTimeClock;
var
  QBTimeClock : TQBTimeClock;
  fDateTime : TDateTime;
begin

  QBTimeClock := TQBTimeClock.Create(FDMQuickBooks.GetConnectionString);
  try
    Screen.Cursor := crHourGlass;

    QBTimeClock.SetConnectionStr(FDMQuickBooks.GetConnectionString);

    pbExportSales.Visible := True;
    lbResult.Visible      := False;

    with cdsTimeClock do
    begin
      DisableControls;

      First;

      pbExportSales.Position := 0;
      pbExportSales.Max      := RecordCount;
      Application.ProcessMessages;

      try
        cdsImportTime.CreateDataSet;

        while not EOF do
        begin
          if FieldByName('Marked').AsBoolean then
          begin
            if not cdsImportTime.Locate('EnterDate', FormatDateTime('mm/dd/yyyy', FieldByName('EnterDate').AsDateTime), []) then
            begin
              cdsImportTime.Append;
              fDateTime                                          := Trunc(FieldByName('EnterDate').AsDateTime);
              cdsImportTime.FieldByName('EnterDate').AsString    := FormatDateTime('mm/dd/yyyy', fDateTime);
              cdsImportTime.FieldByName('Pessoa').AsString       := 'EMP_' + FieldByName('Pessoa').AsString;
              cdsImportTime.FieldByName('WorkedHour').AsDateTime := FDMQuickBooks.AddHoursToDate(fDateTime, FormatDateTime('hh:mm', (FieldByName('WorkedHour').AsDatetime)));
            end
            else
            begin
              cdsImportTime.Edit;
              cdsImportTime.FieldByName('WorkedHour').AsDateTime := FDMQuickBooks.AddHoursToDate(cdsImportTime.FieldByName('WorkedHour').AsDateTime, FormatDateTime('hh:mm', FieldByName('WorkedHour').AsDateTime));
            end;
            cdsImportTime.Post;
          end;
          pbExportSales.Position := pbExportSales.Position + 1;
          Application.ProcessMessages;
          Next;
        end;

        cdsImportTime.First;
        pbExportSales.Position := 0;
        pbExportSales.Max      := cdsImportTime.RecordCount;
        Application.ProcessMessages;

        while not cdsImportTime.EOF do
        begin

          QBTimeClock.Employee  := cdsImportTime.FieldByName('Pessoa').AsString;
          QBTimeClock.TransDate := FormatDateTime('mm/dd/yyyy', cdsImportTime.FieldByName('EnterDate').AsDateTime);
          QBTimeClock.Duration  := FormatDateTime('hh:mm', cdsImportTime.FieldByName('WorkedHour').AsDateTime);
          QBTimeClock.AddTimeClock;

          pbExportSales.Position := pbExportSales.Position + 1;
          Application.ProcessMessages;
          cdsImportTime.Next;
        end;



      finally
        cdsImportTime.Close;
      end;

      First;
      EnableControls;

      lbResult.Caption := IntToStr(pbExportSales.Max) + ' timeclock(s) exported to QuickBooks.';
      lbResult.Visible := True;

    end;

  finally
    pbExportSales.Visible := False;
    FreeAndNil(QBTimeClock);
    Screen.Cursor := crDefault;
  end;

end;

procedure TFrmQuickBooks.CreateCustomers;
var
  QBCustomer : TQBCustomer;
begin

  QBCustomer := TQBCustomer.Create(FDMQuickBooks.GetConnectionString);
  try
    Screen.Cursor := crHourGlass;

    QBCustomer.SetConnectionStr(FDMQuickBooks.GetConnectionString);

    pbExportSales.Visible := True;

    with cdsEntity do
    begin
      DisableControls;

      First;

      pbExportSales.Position := 0;
      pbExportSales.Max      := RecordCount;
      Application.ProcessMessages;

      while not EOF do
      begin

        QBCustomer.CustomerName  := FieldByName('Pessoa').AsString;
        QBCustomer.Address       := FieldByName('Address').AsString;
        QBCustomer.City          := FieldByName('City').AsString;
        QBCustomer.State         := FieldByName('State').AsString;
        QBCustomer.Zip           := FieldByName('Zip').AsString;
        QBCustomer.ContactName   := FieldByName('Contact').AsString;
        QBCustomer.Country       := FieldByName('Country').AsString;
        QBCustomer.Phone         := FieldByName('PhoneAreaCode').AsString + ' ' + FieldByName('Telefone').AsString;
        QBCustomer.Fax           := FieldByName('Fax').AsString;
        QBCustomer.Email         := FieldByName('Email').AsString;

        QBCustomer.AddCustomer;

        pbExportSales.Position := pbExportSales.Position + 1;
        Application.ProcessMessages;

        Next;
      end;

      First;
      EnableControls;
    end;

  finally
    pbExportSales.Visible := False;
    FreeAndNil(QBCustomer);
    Screen.Cursor := crDefault;
  end;

end;

procedure TFrmQuickBooks.CloseCustomer;
begin
  with cdsEntity do
    if Active then
      Close;
end;

procedure TFrmQuickBooks.OpenCustomer;
begin
  with cdsEntity do
    if not Active then
      Open;
end;

procedure TFrmQuickBooks.btnUpdateClick(Sender: TObject);
var
  P : TPoint;
begin
  inherited;
  GetCursorPos(P);
  popSelection.Popup(P.X, P.Y);
end;

procedure TFrmQuickBooks.CreateSales;
var
  iSalesImported : Integer;
  FQBInvoice : TQBInvoice;
  FQBItem : TQBItem;
  FQBPayment : TQBPayment;
  FAccount : String;
begin

{
  lbResult.Visible := False;
  with cdsInvoice do
    if not Active then
      ShowMessage('No sale to export')
    else
    try
      DisableControls;
      lbResult.Visible := False;
      pbExportSales.Visible := True;
      Application.ProcessMessages;
      Screen.Cursor := crHourGlass;

      First;

      pbExportSales.Position := 0;
      pbExportSales.Max      := RecordCount;
      iSalesImported         := 0;


      FQBInvoice := TQBInvoice.Create(FDMQuickBooks.GetConnectionString);
      try
        while not EOF do
        begin
          if FieldByName('Marked').AsBoolean then
          begin
            if FieldByName('Customer').AsString <> '' then
              FQBInvoice.CustomerName  := FieldByName('Customer').AsString
            else
              FQBInvoice.CustomerName  := 'None';
            FQBInvoice.City            := FieldByName('City').AsString;
            FQBInvoice.Country         := FieldByName('Country').AsString;
            FQBInvoice.Address         := FieldByName('Address').AsString;
            FQBInvoice.ContactName     := FieldByName('Contact').AsString;
            FQBInvoice.Phone           := FieldByName('PhoneAreaCode').AsString + ' ' +FieldByName('Telefone').AsString;
            FQBInvoice.Fax             := FieldByName('Fax').AsString;
            FQBInvoice.Email           := FieldByName('Email').AsString;
            FQBInvoice.Zip             := FieldByName('Zip').AsString;
            FQBInvoice.State           := FieldByName('State').AsString;
            FQBInvoice.TransactionDate := FormatDateTime('mm/dd/yyyy', FieldByName('InvoiceDate').AsDateTime);
            FQBInvoice.RefNumber       := FieldByName('AccInvoiceNumber').AsString;

            iCurrenctInvoice   := FieldByName('IDInvoice').AsInteger;
            iCurrenctIDPreSale := FieldByName('IDPreSale').AsInteger;

            if (FieldByName('TotalInvoice').AsCurrency > 0) then
              FAccount := DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc')
            else
              FAccount := DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc');


            try

              cdsSaleItem.Open;
              cdsSaleItem.First;
              while not cdsSaleItem.EOF do
              begin
                FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                FQBItem.ItemName := Copy(cdsSaleItem.FieldByName('Category').AsString, 0, 30);
                FQBItem.Desc     := cdsSaleItem.FieldByName('Category').AsString;
                FQBItem.Price    := ABS(cdsSaleItem.FieldByName('ItemTotalSold').AsCurrency);
                FQBItem.Qty      := ABS(cdsSaleItem.FieldByName('Qty').AsFloat);
                FQBItem.Account  := FAccount;

                FQBInvoice.SaleItems.Add(FQBItem);
                cdsSaleItem.Next;
              end;

              //Criar um produto chamado Tax, pois o invoice esta ficand com diferenca
              if (not cdsSaleItem.IsEmpty) and (FieldByName('Tax').AsCurrency <> 0) then
              begin
                FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                FQBItem.ItemName := 'Sale Tax';
                FQBItem.Desc     := 'Sale Tax';
                FQBItem.Price    := ABS(FieldByName('Tax').AsCurrency);
                FQBItem.Account  := FAccount;
                FQBItem.Qty      := 1;

                FQBInvoice.SaleItems.Add(FQBItem);
              end;

            finally
              cdsSaleItem.Close;
            end;

            try

              cdsSalePayment.Open;
              cdsSalePayment.First;

              while not cdsSalePayment.EOF do
              begin
                FQBPayment := TQBPayment.Create(FDMQuickBooks.GetConnectionString);
                FQBPayment.PaymentMethod   := cdsSalePayment.FieldByName('MeioPag').AsString;
                FQBPayment.TransactionDate := FormatDateTime('mm/dd/yyyy', cdsSalePayment.FieldByName('DataLancamento').AsDateTime);
                FQBPayment.Amount          := ABS(cdsSalePayment.FieldByName('ValorNominal').AsCurrency);
                FQBPayment.DefaulPayment   := DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod');
                FQBPayment.CustomerName    := FQBInvoice.CustomerName;
                FQBPayment.RefNumber       := FQBInvoice.RefNumber;

                FQBInvoice.Payments.Add(FQBPayment);
                cdsSalePayment.Next;
              end;

            finally
              cdsSalePayment.Close;
            end;

            FQBInvoice.Add;
            inc(iSalesImported);
          end;

          pbExportSales.Position := pbExportSales.Position + 1;
          Application.ProcessMessages;

          Next;
        end;

      finally
        FreeAndNil(FQBInvoice);
      end;

      lbResult.Caption := IntToStr(iSalesImported) + ' transaction(s) exported to QuickBooks.';
      lbResult.Visible := True;
    finally
      Screen.Cursor := crDefault;
      pbExportSales.Visible := False;
      Application.ProcessMessages;
      EnableControls;
    end;
 }
end;

procedure TFrmQuickBooks.cdsSalePaymentBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('L.IDPreSale');
    Param.KeyByName('L.IDPreSale').AsInteger := iCurrenctIDPreSale;
    Param.KeyByName('L.IDPreSale').Condition := tcEquals;

    OwnerData := Param.ParamString;
    
  finally
    FreeAndNil(Param);
  end;


end;

procedure TFrmQuickBooks.cdsTimeClockBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('P.Desativado');
    Param.KeyByName('P.Desativado').AsInteger := 0;
    Param.KeyByName('P.Desativado').Condition := tcEquals;

    Param.AddKey('EnterDate');
    Param.KeyByName('EnterDate').AsString  := MyFormatDate(Trunc(dtTimeStart.Date));
    Param.KeyByName('EnterDate').Condition := tcGreaterThanEqual;
    Param.KeyByName('EnterDate').Field     := 'TC.EnterDate';

    Param.AddKey('EnterDate1');
    Param.KeyByName('EnterDate1').AsString  := MyFormatDate(Trunc(dtTimeEnd.Date+1));
    Param.KeyByName('EnterDate1').Condition := tcLessThan;
    Param.KeyByName('EnterDate1').Field     := 'TC.EnterDate';

    Param.AddKey('ExitDate');
    Param.KeyByName('ExitDate').AsString  := '';
    Param.KeyByName('ExitDate').Condition := tcDifferent;
    Param.KeyByName('ExitDate').Field     := 'TC.ExitDate';


    if cxTimeStore.EditValue > 0 then
    begin
      Param.AddKey('IDStore');
      Param.KeyByName('IDStore').AsInteger := cxTimeStore.EditValue;
      Param.KeyByName('IDStore').Condition := tcEquals;
      Param.KeyByName('IDStore').Field     := 'TC.IDStore';
    end;

    OwnerData := Param.ParamString;
  finally
    FreeAndNil(Param);
  end;

end;

procedure TFrmQuickBooks.btnTimeSearchClick(Sender: TObject);
begin
  inherited;

  try
    Screen.Cursor := crHourGlass;
    with cdsTimeClock do
    begin
      if Active then
        Close;
      Open;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TFrmQuickBooks.cdsSaleItemBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('IM.DocumentID');
    Param.KeyByName('IM.DocumentID').AsInteger := iCurrenctInvoice;
    Param.KeyByName('IM.DocumentID').Condition := tcEquals;

    OwnerData := Param.ParamString;
  finally
    FreeAndNil(Param);
  end;

end;

procedure TFrmQuickBooks.cdsQBCashRegMovBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('CRMDate');
    Param.KeyByName('CRMDate').AsString  := MyFormatDate(Trunc(dtStart.Date));
    Param.KeyByName('CRMDate').Condition := tcGreaterThanEqual;
    Param.KeyByName('CRMDate').Field     := 'CRM.OpenTime';

    Param.AddKey('CRMDate1');
    Param.KeyByName('CRMDate1').AsString  := MyFormatDate(Trunc(dtEnd.Date+1));
    Param.KeyByName('CRMDate1').Condition := tcLessThan;
    Param.KeyByName('CRMDate1').Field     := 'CRM.OpenTime';

    if cbxStore.EditValue > 0 then
    begin
      Param.AddKey('IDStore');
      Param.KeyByName('IDStore').AsInteger := cbxStore.EditValue;
      Param.KeyByName('IDStore').Condition := tcEquals;
      Param.KeyByName('IDStore').Field     := 'I.IDStore';
    end;

    OwnerData := Param.ParamString;
  finally
    FreeAndNil(Param);
  end;

end;

procedure TFrmQuickBooks.CloseCashRegMov;
begin
  with cdsQBCashRegMov do
    if Active then
      Close;
end;

procedure TFrmQuickBooks.OpenCashRegMov;
begin
  with cdsQBCashRegMov do
    if not Active then
      Open;
end;

procedure TFrmQuickBooks.CreateRevMov;
var
  iSalesImported : Integer;
  FQBSales : TQBSales;
  FQBCreditMemo : TQBCreditMemo;
  FQBItem : TQBItem;
  FQBPayment : TQBPayment;
  FAccount, sColumn : String;
  cPositivePayment, cNegativePayment : Currency;
  FTransDate : TDateTime;
begin
  lbResult.Visible := False;
  with cdsQBCashRegMov do
    if not Active then
      ShowMessage('No sale to export')
    else
    try
      DisableControls;
      lbResult.Visible := False;
      pbExportSales.Visible := True;
      Application.ProcessMessages;
      Screen.Cursor := crHourGlass;

      First;

      pbExportSales.Position := 0;
      pbExportSales.Max      := RecordCount;
      iSalesImported         := 0;

      sColumn := DMImportExport.GetAppProperty('QuickBooks', 'PaymentColumns');

      while not EOF do
      begin

        if FieldByName('Marked').AsBoolean then
        begin

          //Sales Header
          if (FQBSales = nil) then
          begin
            FQBSales                 := TQBSales.Create(FDMQuickBooks.GetConnectionString);
            FQBSales.CustomerName    := 'MRSale';
            FQBSales.TransactionDate := FormatDateTime('mm/dd/yyyy', FieldByName('OpenTime').AsDateTime);
            FQBSales.RefNumber       := 'MR' + FieldByName('TransNum').AsString;
          end;

          iCurrentIDCashRegMov     := FieldByName('IDCashRegMov').AsInteger;
          GetTotalPayment(cPositivePayment, cNegativePayment);

          //Credit Memo Header
          if (cNegativePayment <> 0) and (FQBCreditMemo = nil) then
          begin
            FQBCreditMemo                 := TQBCreditMemo.Create(FDMQuickBooks.GetConnectionString);
            FQBCreditMemo.CustomerName    := 'MRSale';
            FQBCreditMemo.TransactionDate := FormatDateTime('mm/dd/yyyy', FieldByName('OpenTime').AsDateTime);
            FQBCreditMemo.RefNumber       := 'CM' + FieldByName('TransNum').AsString;
          end;

          //Items
          try
            cdsQBCashRegItem.Open;
            cdsQBCashRegItem.First;
            if FQBSales <> nil then
            begin
              while not cdsQBCashRegItem.EOF do
              begin
                FQBSales.AppendPayment(cdsQBCashRegItem.FieldByName('Category').AsString,
                                       DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc'),
                                       MyRound(cdsQBCashRegItem.FieldByName('ItemTotalSold').AsCurrency, 2),
                                       1, itNonInventory);

                cdsQBCashRegItem.Next;
              end;

              FQBSales.AppendPayment('SalesTax',
                                     DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc'),
                                     FieldByName('TotalTax').AsCurrency, 1, itNonInventory);

              if FieldByName('TotalPetty').AsCurrency <> 0 then                       
                FQBSales.AppendPayment('PettyCash',
                                       DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc'),
                                       (FieldByName('TotalPetty').AsCurrency * -1), 1, itNonInventory);
            end;

          finally
            cdsQBCashRegItem.Close;
          end;

          //Item Payments
          try

            //Cash Payment
            if FieldByName('TotalCash').AsCurrency > 0 then
            begin
              if FQBSales <> nil then
                FQBSales.AppendPayment(ParseParam(sColumn, 'Cash'),
                                       DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod'),
                                       (FieldByName('TotalCash').AsCurrency * -1),
                                       1, itPayment);
            end;

            //Check Payment
            if FieldByName('TotalCheck').AsCurrency > 0 then
            begin
              if FQBSales <> nil then
                FQBSales.AppendPayment(ParseParam(sColumn, 'Check'),
                                       DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod'),
                                       (FieldByName('TotalCheck').AsCurrency * -1),
                                       1, itPayment);
            end;


            cdsQBPayments.First;

            while not cdsQBPayments.EOF do
            begin
              if (cdsQBPayments.FieldByName('Amount').AsCurrency > 0) then
              begin
                if FQBSales <> nil then
                  FQBSales.AppendPayment(ParseParam(sColumn, cdsQBPayments.FieldByName('MeioPag').AsString),
                                         DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod'),
                                         (cdsQBPayments.FieldByName('Amount').AsCurrency * -1),
                                         1, itPayment);

              end
              else if (cdsQBPayments.FieldByName('Amount').AsCurrency < 0) then
              begin
                //Add a positive product to zero the invoice
                if (FQBCreditMemo <> nil) then
                begin
                  FQBCreditMemo.AppendCreditMemo('MRItemAdjust',
                                                 DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc'),
                                                 ABS(cdsQBPayments.FieldByName('Amount').AsCurrency),
                                                 1, itNonInventory);

                  FQBCreditMemo.AppendCreditMemo(ParseParam(sColumn, cdsQBPayments.FieldByName('MeioPag').AsString),
                                                 DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc'),
                                                 cdsQBPayments.FieldByName('Amount').AsCurrency,
                                                 1, itPayment);
                  end;
              end;


              cdsQBPayments.Next;
            end;

          finally
            cdsQBPayments.Close;
          end;

        end;

      pbExportSales.Position := pbExportSales.Position + 1;
      Application.ProcessMessages;

      FTransDate := FieldByName('TransDate').AsDateTime;

      Next;

      if cdsQBCashRegMov.EOF or (FTransDate <> FieldByName('TransDate').AsDateTime) then
      begin

        if (FQBSales <> nil) then
        begin
          FQBSales.CreateItemAdjust('MRItemAdjust', DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc'));
          FQBSales.Add;
          FreeAndNil(FQBSales);
          inc(iSalesImported);
        end;

        if (FQBCreditMemo <> nil) then
        begin
          FQBCreditMemo.Add;
          FreeAndNil(FQBCreditMemo);
        end;

      end;

    end;

    lbResult.Caption := IntToStr(iSalesImported) + ' transaction(s) exported to QuickBooks.';
    lbResult.Visible := True;
  finally
    Screen.Cursor := crDefault;
    pbExportSales.Visible := False;
    Application.ProcessMessages;
    EnableControls;
  end;


        {
        if FieldByName('Marked').AsBoolean then
        begin
          FQBSales := TQBSales.Create(FDMQuickBooks.GetConnectionString);

          try

            FQBSales.CustomerName    := 'MRSale';
            FQBSales.TransactionDate := FormatDateTime('mm/dd/yyyy', FieldByName('OpenTime').AsDateTime);
            FQBSales.RefNumber       := 'MR' + FieldByName('IDCashRegMov').AsString;

            iCurrentIDCashRegMov     := FieldByName('IDCashRegMov').AsInteger;
            GetTotalPayment(cPositivePayment, cNegativePayment);

            if (cNegativePayment <> 0) then
            begin
              FQBCreditMemo                 := TQBCreditMemo.Create(FDMQuickBooks.GetConnectionString);
              FQBCreditMemo.CustomerName    := 'MRSale';
              FQBCreditMemo.TransactionDate := FormatDateTime('mm/dd/yyyy', FieldByName('OpenTime').AsDateTime);
              FQBCreditMemo.RefNumber       := 'CM' + FieldByName('IDCashRegMov').AsString;
            end;

            //Item
            if cPositivePayment <> 0 then
            begin
              FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
              FQBItem.ItemName := 'MRProduct';
              FQBItem.Desc     := 'MRProduct';
              FQBItem.Price    := cPositivePayment;
              FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'SalesAcc');
              FQBItem.Qty      := 1;
              FQBSales.SaleItems.Add(FQBItem);
            end;

              //Payments
              try

                //Cash Payment
                if FieldByName('TotalCash').AsCurrency > 0 then
                begin
                    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                    FQBItem.ItemName := 'Cash';
                    FQBItem.Desc     := 'Cash';
                    FQBItem.Price    := FieldByName('TotalCash').AsCurrency * -1;
                    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod');
                    FQBItem.Qty      := 1;
                    FQBItem.ItemType := itPayment;
                    FQBSales.SaleItems.Add(FQBItem);
                end;

                //Check Payment
                if FieldByName('TotalCheck').AsCurrency > 0 then
                begin
                    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                    FQBItem.ItemName := 'Check';
                    FQBItem.Desc     := 'Check';
                    FQBItem.Price    := FieldByName('TotalCheck').AsCurrency * -1;
                    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod');
                    FQBItem.Qty      := 1;
                    FQBItem.ItemType := itPayment;
                    FQBSales.SaleItems.Add(FQBItem);
                end;


                cdsQBPayments.First;

                while not cdsQBPayments.EOF do
                begin
                  if (cdsQBPayments.FieldByName('Amount').AsCurrency > 0) then
                  begin
                    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                    FQBItem.ItemName := ParseParam(sColumn, cdsQBPayments.FieldByName('MeioPag').AsString);
                    FQBItem.Desc     := ParseParam(sColumn, cdsQBPayments.FieldByName('MeioPag').AsString);
                    FQBItem.Price    := cdsQBPayments.FieldByName('Amount').AsCurrency * -1;
                    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'PaymentMethod');
                    FQBItem.Qty      := 1;
                    FQBItem.ItemType := itPayment;
                    FQBSales.SaleItems.Add(FQBItem);
                  end
                  else if (cdsQBPayments.FieldByName('Amount').AsCurrency < 0) then
                  begin
                    //Add a positive product to zero the invoice
                    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                    FQBItem.ItemName := 'MRProduct';
                    FQBItem.Desc     := 'MRProduct';
                    FQBItem.Price    := ABS(cdsQBPayments.FieldByName('Amount').AsCurrency);
                    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc');
                    FQBItem.Qty      := 1;
                    if (FQBCreditMemo <> nil) then
                      FQBCreditMemo.SaleItems.Add(FQBItem);

                    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
                    FQBItem.ItemName := ParseParam(sColumn, cdsQBPayments.FieldByName('MeioPag').AsString);
                    FQBItem.Desc     := ParseParam(sColumn, cdsQBPayments.FieldByName('MeioPag').AsString);
                    FQBItem.Price    := cdsQBPayments.FieldByName('Amount').AsCurrency;
                    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc');
                    FQBItem.Qty      := 1;
                    if (FQBCreditMemo <> nil) then
                      FQBCreditMemo.SaleItems.Add(FQBItem);
                  end;


                  cdsQBPayments.Next;
                end;

              finally
                cdsQBPayments.Close;
              end;

            FQBSales.Add;

            if (FQBCreditMemo <> nil) then
              FQBCreditMemo.Add;


            inc(iSalesImported);

          finally
            FreeAndNil(FQBSales);
            if (FQBCreditMemo <> nil) then
              FreeAndNil(FQBCreditMemo);
          end;


        end;
        }


end;

procedure TFrmQuickBooks.cdsQBPaymentsBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('L.IDCashRegMov');
    Param.KeyByName('L.IDCashRegMov').AsInteger := iCurrentIDCashRegMov;
    Param.KeyByName('L.IDCashRegMov').Condition := tcEquals;

    OwnerData := Param.ParamString;

  finally
    FreeAndNil(Param);
  end;


end;

procedure TFrmQuickBooks.GetTotalPayment(var APositive, ANegative : Currency);
begin

  APositive := 0;
  ANegative := 0;

  if cdsQBCashRegMov.FieldByName('TotalCash').AsCurrency > 0 then
    APositive := cdsQBCashRegMov.FieldByName('TotalCash').AsCurrency
  else
    ANegative := cdsQBCashRegMov.FieldByName('TotalCash').AsCurrency;

  if cdsQBCashRegMov.FieldByName('TotalCheck').AsCurrency > 0 then
    APositive := APositive + cdsQBCashRegMov.FieldByName('TotalCheck').AsCurrency
  else
    ANegative := ANegative + cdsQBCashRegMov.FieldByName('TotalCheck').AsCurrency;


  cdsQBPayments.Open;
  cdsQBPayments.First;

  while not cdsQBPayments.EOF do
  begin
    if cdsQBPayments.FieldByName('Amount').AsCurrency > 0  then
      APositive := APositive + cdsQBPayments.FieldByName('Amount').AsCurrency
    else
      ANegative := ANegative - ABS(cdsQBPayments.FieldByName('Amount').AsCurrency);

    cdsQBPayments.Next;
  end;

end;

procedure TFrmQuickBooks.InsertTestMemoCredit;
var
  FQBCreditMemo : TQBCreditMemo;
  FQBItem : TQBItem;
begin
{
  FQBCreditMemo := TQBCreditMemo.Create(FDMQuickBooks.GetConnectionString);
  try
    FQBCreditMemo.CustomerName    := 'MRSale';
    FQBCreditMemo.TransactionDate := FormatDateTime('mm/dd/yyyy', Now);
    FQBCreditMemo.RefNumber       := 'XXX001';

    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
    FQBItem.ItemName := 'MRProduct';
    FQBItem.Desc     := 'MRProduct';
    FQBItem.Price    := ABS(-5);
    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc');
    FQBItem.Qty      := 1;
    FQBCreditMemo.SaleItems.Add(FQBItem);

    FQBItem          := TQBItem.Create(FDMQuickBooks.GetConnectionString);
    FQBItem.ItemName := 'Visa';
    FQBItem.Desc     := 'Visa';
    FQBItem.Price    := -5;
    FQBItem.Account  := DMImportExport.GetAppProperty('QuickBooks', 'RefoundAcc');
    FQBItem.Qty      := 1;
    FQBCreditMemo.SaleItems.Add(FQBItem);

    FQBCreditMemo.Add;

  finally
    FreeAndNil(FQBCreditMemo);
  end;
 }
end;


procedure TFrmQuickBooks.cdsQBCashRegItemBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  Param: TMRSQLParam;
begin
  inherited;

  try

    Param := TMRSQLParam.Create;

    Param.AddKey('I.CashRegMovID');
    Param.KeyByName('I.CashRegMovID').AsInteger := iCurrentIDCashRegMov;
    Param.KeyByName('I.CashRegMovID').Condition := tcEquals;

    OwnerData := Param.ParamString;

  finally
    FreeAndNil(Param);
  end;


end;

end.
