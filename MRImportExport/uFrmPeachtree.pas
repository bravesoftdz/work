unit uFrmPeachtree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, StdCtrls, ExtCtrls, ComCtrls, ImgList, uDMPeachtree,
  Buttons, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Mask,
  DateBox, DB, DBClient, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB,
  Provider, DBCtrls, Menus;

type
  TFrmPeachtree = class(TFrmParent)
    Panel1: TPanel;
    Label9: TLabel;
    lbVersion: TLabel;
    imgPeachtree: TImage;
    lbCompany: TLabel;
    Panel2: TPanel;
    lbCatalog: TLabel;
    pgOption: TPageControl;
    tsConfig: TTabSheet;
    tsSale: TTabSheet;
    Shape8: TShape;
    Label1: TLabel;
    imgSelect1: TImage;
    imgSmall: TImageList;
    imgSelect2: TImage;
    lbCompanyFolder: TLabel;
    edtCompanyFolder: TEdit;
    Label2: TLabel;
    edtCompany: TEdit;
    Label3: TLabel;
    edtAddress: TEdit;
    edtCity: TEdit;
    edtState: TEdit;
    edtZip: TEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    pnlFilter: TPanel;
    Shape6: TShape;
    Label13: TLabel;
    cbxStore: TcxLookupComboBox;
    lbFrom: TLabel;
    dtStart: TDateBox;
    Label5: TLabel;
    dtEnd: TDateBox;
    Label6: TLabel;
    Bevel2: TBevel;
    lbSelection: TLabel;
    btnClear: TSpeedButton;
    btnSearch: TBitBtn;
    cdsInvoice: TClientDataSet;
    dsInvoice: TDataSource;
    grdSales: TcxGrid;
    grdSalesDBTableView: TcxGridDBTableView;
    grdSalesLevel: TcxGridLevel;
    cdsInvoiceIDInvoice: TIntegerField;
    cdsInvoiceMediaID: TIntegerField;
    cdsInvoiceFirstName: TStringField;
    cdsInvoiceLastName: TStringField;
    cdsInvoiceCustomer: TStringField;
    cdsInvoiceInvoiceDate: TDateTimeField;
    cdsInvoiceIDPreSale: TIntegerField;
    cdsInvoiceCanceled: TBooleanField;
    cdsInvoiceTotalInvoice: TBCDField;
    cdsInvoiceSubTotal: TBCDField;
    cdsInvoiceTax: TBCDField;
    cdsInvoiceLayaway: TBooleanField;
    cdsInvoiceAditionalExpenses: TBCDField;
    cdsInvoiceSaleCode: TStringField;
    cdsInvoiceInvoiceCode: TStringField;
    cdsInvoiceAccGLMainAccount: TStringField;
    cdsInvoiceAccInvoiceNumber: TStringField;
    cdsInvoiceAccSalesTaxCode: TStringField;
    cdsInvoiceAccCashAccount: TStringField;
    grdSalesDBTableViewCustomer: TcxGridDBColumn;
    grdSalesDBTableViewInvoiceDate: TcxGridDBColumn;
    grdSalesDBTableViewTotalInvoice: TcxGridDBColumn;
    grdSalesDBTableViewInvoiceCode: TcxGridDBColumn;
    grdSalesDBTableViewAccGLMainAccount: TcxGridDBColumn;
    grdSalesDBTableViewAccInvoiceNumber: TcxGridDBColumn;
    grdSalesDBTableViewAccSalesTaxCode: TcxGridDBColumn;
    grdSalesDBTableViewAccCashAccount: TcxGridDBColumn;
    grdSalesDBTableViewAccCustomerID: TcxGridDBColumn;
    cdsInvoiceAccCustomerID: TStringField;
    Bevel3: TBevel;
    cdsInvoiceMarked: TBooleanField;
    grdSalesDBTableViewMarked: TcxGridDBColumn;
    btnUpdate: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    cbxSalesTax: TcxLookupComboBox;
    cbxGLMainAcc: TcxLookupComboBox;
    cbxCashAcc: TcxLookupComboBox;
    btnAddQuick: TSpeedButton;
    popSelection: TPopupMenu;
    Selectall1: TMenuItem;
    UnSelectAll1: TMenuItem;
    btnSaveSale: TButton;
    pnlComple: TPanel;
    btnComplete: TButton;
    pbExportSales: TProgressBar;
    imgExit: TImage;
    Label11: TLabel;
    lbMRVersion: TLabel;
    Label12: TLabel;
    edtCustomerID: TEdit;
    lbResult: TLabel;
    procedure btnSaveSaleClick(Sender: TObject);
    procedure lbCatalogClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClearClick(Sender: TObject);
    procedure cdsInvoiceBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnSearchClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure UnSelectAll1Click(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnCompleteClick(Sender: TObject);
  private
    DMPeachtree : TDMPeachtree;
    procedure LoadImage;
    function PeachTreeStart : Boolean;
    function PeachDLLRegister : Boolean;
    procedure ShowPanel(iOption: Integer);
    function ValidateField : Boolean;
  public
    procedure Start;
  end;

implementation

uses uFileFunctions, uDMImportExport, uDateTimeFunctions, uMRSQLParam,
  Math;

{$R *.dfm}

procedure TFrmPeachtree.LoadImage;
begin
  imgSmall.GetBitmap(0, imgSelect1.Picture.Bitmap);
  imgSmall.GetBitmap(0, imgSelect2.Picture.Bitmap);
  imgSmall.GetBitmap(1, imgExit.Picture.Bitmap);
end;


function TFrmPeachtree.PeachDLLRegister: Boolean;
begin

  try
    if not FileExists('C:\Windows\System32\pawcom280.dll') then
      if FileExists(ExtractFilePath(Application.ExeName) + 'pawcom280.dll') then
      begin
        CopyFile(ExtractFilePath(Application.ExeName) + 'pawcom280.dll', 'C:\Windows\System32\pawcom280.dll', True);
        ExecuteFile('regsvr32.exe', 'C:\Windows\System32\pawcom280.dll /s', '', 1);
      end;
    Result := True;
  except
    Result := False;
    end;

end;

function TFrmPeachtree.PeachTreeStart : Boolean;
var
  sCompanyFolder : String;
begin

  Result := False;

  sCompanyFolder := DMImportExport.GetAppProperty('PeachTree', 'CompanyDir');

  if sCompanyFolder = '' then
  begin
    sCompanyFolder := 'C:\Program Files\Sage Software\Peachtree\Company\';
    sCompanyFolder := InputBox('Peachtree', 'Company folder:', sCompanyFolder);
  end;

  if DMPeachtree.Init(sCompanyFolder) then
  begin
    lbVersion.Caption := 'Peachtree version (' + FloatToStr(DMPeachtree.CompanyInfo.Version) + ')';
    lbCompany.Caption := DMPeachtree.CompanyInfo.CompanyName + ' (' + DMPeachtree.CompanyInfo.BusinessType + ')';
    DMImportExport.SetAppProperty('PeachTree', 'CompanyDir', sCompanyFolder);

    edtCompanyFolder.Text := sCompanyFolder;
    edtCompany.Text       := DMPeachtree.CompanyInfo.CompanyName;
    edtAddress.Text       := DMPeachtree.CompanyInfo.AddrLine;
    edtCity.Text          := DMPeachtree.CompanyInfo.AddrCity;
    edtState.Text         := DMPeachtree.CompanyInfo.AddrState;
    edtZip.Text           := DMPeachtree.CompanyInfo.AddrPostalCode;

    Result := True;
  end
  else
    MessageDlg('Error initializing.',mtwarning,[mbok],0);

end;

procedure TFrmPeachtree.Start;
begin

  LoadImage;

  DMPeachtree := TDMPeachtree.Create(Self);
  try
    if PeachDLLRegister then
      if PeachTreeStart then
        ShowModal;
  finally
    FreeAndNil(DMPeachtree);
    end;


end;

procedure TFrmPeachtree.btnSaveSaleClick(Sender: TObject);
var
  FSale : TSale;
  FCustomerInfo : TCustomerInfo;
begin
  inherited;

  FSale := TSale.Create;
  FCustomerInfo := TCustomerInfo.Create;
  try


    FSale.InvoiceNumber  := '1000000';
    FSale.SalesTaxCode   := 'GACHER';
    FSale.GLMainAccount  := '11000';
    FSale.CashAccount    := '12000';
    FSale.Amount         := 100;

    FCustomerInfo.CustomerID := 'RODCOST';
    FCustomerInfo.BillToName := 'Rodrigo Costa';

    DMPeachtree.SaveSale(FSale, FCustomerInfo);
  finally
    FreeAndNil(FSale);
    FreeAndNil(FCustomerInfo);
    end;

end;

procedure TFrmPeachtree.lbCatalogClick(Sender: TObject);
begin
  inherited;
  ShowPanel(TLabel(Sender).Tag);
end;

procedure TFrmPeachtree.ShowPanel(iOption : Integer);
begin
  case iOption of
    0 : Close;
    1 : begin
          pgOption.ActivePage := tsSale;
          lbSelection.Caption := tsSale.Caption;
        end;
    2 : begin
          pgOption.ActivePage := tsConfig;
          lbSelection.Caption := tsConfig.Caption;
        end;
  end;
end;

procedure TFrmPeachtree.FormShow(Sender: TObject);
begin
  inherited;
  DMImportExport.ImportConn.Connected := True;
  DMImportExport.OpenStore;

  cbxGLMainAcc.EditValue := DMImportExport.GetAppProperty('PeachTree', 'GLMainAcc');
  cbxCashAcc.EditValue   := DMImportExport.GetAppProperty('PeachTree', 'CashAcc');
  cbxSalesTax.EditValue  := DMImportExport.GetAppProperty('PeachTree', 'SalesTax');
  edtCustomerID.Text     := DMImportExport.GetAppProperty('PeachTree', 'CustomerID');

  dtStart.Date := InicioMes(Now);
  dtEnd.Date   := FimMes(Now);
  ShowPanel(1);
end;

procedure TFrmPeachtree.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if cbxGLMainAcc.EditValue <> Null then
    DMImportExport.SetAppProperty('PeachTree', 'GLMainAcc', cbxGLMainAcc.EditValue);

  if (cbxCashAcc.EditValue <> Null) then
    DMImportExport.SetAppProperty('PeachTree', 'CashAcc', cbxCashAcc.EditValue);

  if (cbxSalesTax.EditValue <> Null) then
    DMImportExport.SetAppProperty('PeachTree', 'SalesTax', cbxSalesTax.EditValue);

  DMImportExport.SetAppProperty('PeachTree', 'CustomerID', Trim(edtCustomerID.Text));

  DMImportExport.CloseStore;
  DMImportExport.ImportConn.Connected := False;
end;

procedure TFrmPeachtree.btnClearClick(Sender: TObject);
begin
  inherited;
  edtCompanyFolder.Clear;
  DMImportExport.SetAppProperty('PeachTree', 'CompanyDir', edtCompanyFolder.Text);
end;

procedure TFrmPeachtree.cdsInvoiceBeforeGetRecords(Sender: TObject;
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

procedure TFrmPeachtree.btnSearchClick(Sender: TObject);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    with cdsInvoice do
    begin
      if Active then
        Close;
      Open;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmPeachtree.btnAddQuickClick(Sender: TObject);
var
  P : TPoint;
begin
  inherited;
  GetCursorPos(P);
  popSelection.Popup(P.X, P.Y);
end;

procedure TFrmPeachtree.Selectall1Click(Sender: TObject);
begin
  inherited;

  with cdsInvoice do
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

procedure TFrmPeachtree.UnSelectAll1Click(Sender: TObject);
begin
  inherited;

  with cdsInvoice do
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

procedure TFrmPeachtree.btnUpdateClick(Sender: TObject);
begin
  inherited;

  with cdsInvoice do
    if Active then
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if FieldByName('Marked').AsBoolean then
        begin
          Edit;
          if (FieldByName('AccCustomerID').AsString = '') then
            FieldByName('AccCustomerID').AsString := UpperCase(Copy(FieldByName('FirstName').AsString,1, 5) + Copy(FieldByName('LastName').AsString, 1, 5));

          if (cbxGLMainAcc.EditValue <> Null) then
            FieldByName('AccGLMainAccount').AsString := cbxGLMainAcc.EditValue;

          if (cbxCashAcc.EditValue <> Null) then
            FieldByName('AccCashAccount').AsString := cbxCashAcc.EditValue;

          if (cbxSalesTax.EditValue <> Null) then
            FieldByName('AccSalesTaxCode').AsString := cbxSalesTax.EditValue;

          if (Trim(edtCustomerID.Text) <> '') then
            FieldByName('AccCustomerID').AsString := edtCustomerID.Text;

          Post;
        end;
        Next;
      end;
    finally
      EnableControls;
      end;

end;

procedure TFrmPeachtree.btnCompleteClick(Sender: TObject);
var
  FSale : TSale;
  FCustomerInfo : TCustomerInfo;
  SalesImported : Integer;
begin
  inherited;
  lbResult.Visible := False;
  with cdsInvoice do
    if not Active then
    begin
      ShowMessage('No sale to export');
    end
    else
    try
      Screen.Cursor := crHourGlass;
      pbExportSales.Visible := True;
      pbExportSales.Max     := RecordCount;
      btnComplete.Enabled   := False;
      DisableControls;
      SalesImported := 0;
      First;
      while not EOF do
      begin
        if ValidateField then
        begin
          FSale := TSale.Create;
          FCustomerInfo := TCustomerInfo.Create;
          try
            FSale.InvoiceNumber  := FieldByName('AccInvoiceNumber').AsString;
            FSale.SalesTaxCode   := FieldByName('AccSalesTaxCode').AsString;  //'GACHER';
            FSale.GLMainAccount  := FieldByName('AccGLMainAccount').AsString; //'11000';
            FSale.CashAccount    := FieldByName('AccCashAccount').AsString;   //'12000';
            FSale.Amount         := FieldByName('TotalInvoice').AsCurrency;

            FCustomerInfo.CustomerID := FieldByName('AccCustomerID').AsString;
            FCustomerInfo.BillToName := FieldByName('Customer').AsString;

            if DMPeachtree.SaveSale(FSale, FCustomerInfo) then
              inc(SalesImported);
          finally;
            FreeAndNil(FSale);
            FreeAndNil(FCustomerInfo);
            end;
        end;
        pbExportSales.Position := pbExportSales.Position + 1;
        Next;
      end;
    finally
      EnableControls;
      pbExportSales.Visible := False;
      lbResult.Visible := True;
      lbResult.Caption := IntToStr(SalesImported) + ' sale(s) exported to peachtree.';
      Screen.Cursor := crDefault;
      btnComplete.Enabled := True;
      end;
end;


function TFrmPeachtree.ValidateField: Boolean;
begin
  Result := False;

  with cdsInvoice do
    if FieldByName('Marked').AsBoolean then
    Result := (FieldByName('AccCustomerID').AsString <> '') or
              (FieldByName('AccGLMainAccount').AsString <> '') or
              (FieldByName('AccCashAccount').AsString <> '') or
              (FieldByName('AccSalesTaxCode').AsString <> '');


end;

end.
