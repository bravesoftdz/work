unit uFrmStore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Buttons, MemoStr, PaideFichaTab, ComCtrls, Grids,
  DateBox, jpeg, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  DBGrids, SMDBGrid, SubListPanel;

type
  TbrwFrmStore = class(TbrwFrmTabParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    tbBasic: TTabSheet;
    dbspCompany: TDBSuperComboADO;
    Label11: TLabel;
    Label10: TLabel;
    DBEdit5: TDBEdit;
    MemoFax: TDbMemoStr;
    Label9: TLabel;
    Label46: TLabel;
    DBEditBeeper: TDBEdit;
    DbEditCellular: TDBEdit;
    Label45: TLabel;
    Label6: TLabel;
    dbedtPhone: TDBEdit;
    dbedtZip: TDBEdit;
    DBSCEstado: TDBSuperComboADO;
    Label3: TLabel;
    Label7: TLabel;
    dbedtCity: TDBEdit;
    dbedtAddress: TDBEdit;
    Label5: TLabel;
    Label4: TLabel;
    bdedtName: TDBEdit;
    Label8: TLabel;
    tsTicket: TTabSheet;
    Label38: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    tbCategoryTax: TTabSheet;
    dsStore: TDataSource;
    tbTimeZone: TTabSheet;
    Panel5: TPanel;
    quFormIDStore: TAutoIncField;
    quFormName: TStringField;
    quFormAddress: TStringField;
    quFormIDEstado: TStringField;
    quFormCity: TStringField;
    quFormZip: TStringField;
    quFormTelephone: TStringField;
    quFormIDEmpresa: TIntegerField;
    quFormFax: TStringField;
    quFormBeeper: TStringField;
    quFormCellular: TStringField;
    quFormContato: TStringField;
    quFormHourDefault: TStringField;
    Panel6: TPanel;
    Label29: TLabel;
    scTaxCategory: TDBSuperComboADO;
    cmbServerLocation: TComboBox;
    Label30: TLabel;
    pnlTimeZone: TPanel;
    DBEdit2: TDBEdit;
    Label31: TLabel;
    Label33: TLabel;
    btnSetTax: TSpeedButton;
    tbPaymentType: TTabSheet;
    Label19: TLabel;
    scContaCorrente: TDBSuperComboADO;
    dsPayment: TDataSource;
    quPayment: TADOQuery;
    Panel9: TPanel;
    quPaymentIDMeioPag: TIntegerField;
    quPaymentMeioPag: TStringField;
    quPaymentIDStore: TIntegerField;
    quPaymentIDContaCorrente: TIntegerField;
    quPaymentNumero: TStringField;
    quPaymentTipo: TStringField;
    pnlPayment: TPanel;
    grdCategry: TSMDBGrid;
    grdStore: TSMDBGrid;
    TicketInfo: TSubListPanel;
    quFormEmail: TStringField;
    quFormWebPage: TStringField;
    Label12: TLabel;
    edtEmail: TDBEdit;
    Label13: TLabel;
    edtWebPage: TDBEdit;
    edtStartPreSale: TEdit;
    Label14: TLabel;
    Label16: TLabel;
    edtStartInvoice: TEdit;
    pnlTaxGov: TPanel;
    Label17: TLabel;
    scImpostosCateg: TDBSuperComboADO;
    btnSetTaxGov: TSpeedButton;
    quStore: TADOQuery;
    quStoreIDGroup: TIntegerField;
    quStoreGroupName: TStringField;
    quStoreIDTaxCategory: TIntegerField;
    quStoreTaxCategory: TStringField;
    quStoreTax: TBCDField;
    quStoreImposto: TStringField;
    quStoreTaxImposto: TBCDField;
    quStoreIDSaleTax: TIntegerField;
    chbFranchise: TDBCheckBox;
    quFormFranchise: TBooleanField;
    tsVendorAccount: TTabSheet;
    pnlVendorAccount: TPanel;
    pnlVendorAccountTitle: TPanel;
    grdVendorAccount: TSMDBGrid;
    pnlButtons: TPanel;
    btRemoveVendorAccount: TSpeedButton;
    btAddVendorAccount: TSpeedButton;
    quVendorAccount: TADOQuery;
    dsVendorAccount: TDataSource;
    quVendorAccountIDStoreVendorAccount: TIntegerField;
    quVendorAccountIDPessoa: TIntegerField;
    quVendorAccountIDStore: TIntegerField;
    quVendorAccountAccount: TStringField;
    quVendorAccountVendor: TStringField;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    procedure quStoreAfterEdit(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure scTaxCategorySelectItem(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure cmbServerLocationChange(Sender: TObject);
    procedure PostOnExit(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btnSetTaxClick(Sender: TObject);
    procedure scContaCorrenteSelectItem(Sender: TObject);
    procedure scTaxCategoryEnter(Sender: TObject);
    procedure edtStartPreSaleChange(Sender: TObject);
    procedure edtStartInvoiceChange(Sender: TObject);
    procedure scImpostosCategSelectItem(Sender: TObject);
    procedure btnSetTaxGovClick(Sender: TObject);
    procedure btAddVendorAccountClick(Sender: TObject);
    procedure btRemoveVendorAccountClick(Sender: TObject);
    procedure bdedtNameKeyPress(Sender: TObject; var Key: Char);
  private
    procedure RefreshTab;

    procedure WMTIMECHANGE(var Message: TWMTIMECHANGE);
      message WM_TIMECHANGE;
    function GetTimeZoneOffset: integer;

    function DaylightSavings(DT : TDateTime): Boolean;
    function LocalTimeToUniversal(LT : TDateTime): TDateTime;
    function UniversalTimeToLocal(UT : TDateTime): TDateTime;

    procedure RefreshServerLocation;
    procedure GetServerLocation;
    procedure SetServerLocation;

    procedure StoreRefresh;
    procedure PaymentRefresh;

    procedure VendorAccountRefresh;
    procedure VendorAccountOpen;
    procedure VendorAccountClose;

    function ValidTax: Boolean;
    function ValidPayment: Boolean;
    procedure FillInitialCounters;
    procedure UpdateInitialCounters;

    procedure EnableGovTax(b: Boolean);
  protected
    function BeforeChange: boolean; override;
    function OnAfterSaveChange(var iError: Integer):Boolean; override;
  end;

var
  TZInfo : TTimeZoneInformation;


implementation

uses uDM, uMsgBox, uNumericFunctions, uMsgConstant, uDMGlobal, uSystemConst,
  uFchStoreVendorAccount;

{$R *.DFM}


function TbrwFrmStore.ValidTax:Boolean;
begin

   with DM.quFreeSQL do
     begin
     if Active then
        Close;

     SQL.Clear;

     SQL.Add('SELECT STG.IDStore ');
     SQL.Add('FROM StoreToTabGroup STG');
     SQL.Add('JOIN TabGroup TG ON (TG.IDGroup = STG.IDGroup)');
     SQL.Add('WHERE STG.IDStore = ' + quFormIDStore.AsString);
     SQL.Add('AND STG.IDTaxCategory IS NULL');
     SQL.Add('AND TG.Hidden=0 AND TG.Desativado=0');

     Open;

     Result := (RecordCount = 0);

     Close;

     end;

end;

function TbrwFrmStore.ValidPayment:Boolean;
begin

   with DM.quFreeSQL do
     begin
     if Active then
        Close;

     SQL.Clear;

     SQL.Add('SELECT MPS.IDStore ');
     SQL.Add('FROM MeioPagToStore MPS');
     SQL.Add('JOIN MeioPag MP ON (MP.IDMeioPag = MPS.IDMeioPag)');
     SQL.Add('WHERE MPS.IDStore = ' + quFormIDStore.AsString);
     SQL.Add('AND MPS.IDContaCorrente IS NULL');
     SQL.Add('AND MP.Hidden=0 AND MP.Desativado=0');
     SQL.Add('AND MP.ParentType = ''Batch''');

     Open;

     Result := (RecordCount = 0);

     Close;

     end;

end;


function TbrwFrmStore.BeforeChange: boolean;
begin

     Result := True;

     if not ValidTax then
        begin
        PageControl.ActivePage := tbCategoryTax;
        RefreshTab;
        MsgBox(MSG_CRT_ERROR_TAX_CATEG, vbCritical + vbOkOnly);
        Result := False;
        Exit;
        end;

     if not ValidPayment then
        begin
        PageControl.ActivePage := tbPaymentType;
        RefreshTab;
        MsgBox(MSG_CRT_ERROR_PAYMENT_TYPE, vbCritical + vbOkOnly);
        Result := False;
        Exit;
        end;

end;


procedure TbrwFrmStore.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormHourDefault.AsInteger := 0;
  quFormFranchise.AsBoolean   := False;
  edtStartInvoice.Text := '1';
  edtStartPreSale.Text := '1';
  RefreshTab;
end;


procedure TbrwFrmStore.PageControlChange(Sender: TObject);
begin
  inherited;
  RefreshTab;
end;

procedure TbrwFrmStore.quStoreAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TbrwFrmStore.RefreshTab;
begin
  if PageControl.ActivePage = tbCategoryTax then
  begin
    with quStore do
    begin
      if Active then
        Close;
      quStore.Parameters.ParamByName('IDStore').Value := quFormIDStore.AsInteger;
      Open;
    end;
  end
  else if PageControl.ActivePage = tbPaymentType then
  begin
    with quPayment do
    begin
      if Active then
        Close;
      quStore.Parameters.ParamByName('IDStore').Value := quFormIDStore.AsInteger;
      Open;
    end;
  end
  else if PageControl.ActivePage = tsTicket then
    TicketInfo.Param := 'IDStore='+quFormIDStore.AsString + ';'
  else if PageControl.ActivePage = tsVendorAccount then
    VendorAccountRefresh;
end;

procedure TbrwFrmStore.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshServerLocation;
  GetServerLocation;
  RefreshTab;
  FillInitialCounters;
end;

//TimeZone

procedure TbrwFrmStore.WMTIMECHANGE(var Message: TWMTIMECHANGE);
var Error : integer;
begin
  { Get Time Zone information from the system }
  Error := GetTimeZoneInformation(TZInfo);

  { Value returned by GetTimeZoneInformation identifies time zone setting  }
  { for system date and time; provided here for informational purposes     }
  case Error of
    0 : { Unknown };
    1 : { Standard Time };
    2 : { Daylight Time };
  end;
end;

function TbrwFrmStore.GetTimeZoneOffset: integer;
var DT, UT : TDateTime;
begin
  try
    { Convert edit string to time }
    DT := Time;
  except
    on Exception do
       begin  { set time to midnight }
       DT := 0.0;
       end;
  end;  { try..except }
  { Combine Date and Time }
  DT := int(Date) + DT;
  { Convert local time to UTC }
  UT := LocalTimeToUniversal(DT);

  If DT >= UT then
    Result := MyStrToInt('+'+FormatDateTime('h',(DT - UT)))
  else
    Result := MyStrToInt('-'+FormatDateTime('h',(DT - UT)));

end;


procedure TbrwFrmStore.FormCreate(Sender: TObject);
var
Error : integer;
begin
  inherited;
  { Get Time Zone information from the system }
  Error := GetTimeZoneInformation(TZInfo);
  { Value returned by GetTimeZoneInformation identifies time zone setting  }
  { for system date and time; provided here for informational purposes     }
  case Error of
    0 : { Unknown };
    1 : { Standard Time };
    2 : { Daylight Time };
  end;
  { Initialize EditTime.EditText }
  TicketInfo.CreateSubList;

  EnableGovTax(DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE]);
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddVendorAccount.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveVendorAccount.Glyph);
end;

function TbrwFrmStore.DaylightSavings(DT : TDateTime): Boolean;
var D, M, Y, WeekNo : word;
  DTBegins, STBegins : TDateTime;
begin
  { Get Year / Month / Day of DateTime passed to function: }
  DecodeDate(DT, Y, M, D);

  { If TZInfo.DaylightDate.wMonth is zero, Daylight Time not implemented:  }
  if (TZInfo.DaylightDate.wMonth = 0) then
    Result := False
  else  { Daylight Time is implemented }
    begin
      { If wYear equals zero, use relative SystemTime format: }
      if (TZInfo.StandardDate.wYear = 0) then
        begin  { Relative SystemTime format }
          { Calculate DateTime Daylight Time begins using relative format: }
          { wDay defines which wDayOfWeek is used for time change:         }
          { wDay of 1 identifies the first occurrence of wDayOfWeek in the }
          { month; 2..4 identify the second through fourth occurrence.     }
          { A value of 5 identifies the last occurrence in the month.      }

          { Start at beginning of Daylight month }
          DTBegins := EncodeDate(Y, TZInfo.DaylightDate.wMonth, 1);
          case TZInfo.DaylightDate.wDay of
            1,2,3,
            4 : begin
                  { Get to first occurrence of wDayOfWeek                  }
                  { Key point: SysUtils.DayOfWeek is unary-based           }
                  {            TZInfo.Daylight.wDay is zero-based          }
                  while (SysUtils.DayOfWeek(DTBegins) - 1) <>
                         TZInfo.DaylightDate.wDayOfWeek do
                    DTBegins := DTBegins + 1;
                  WeekNo := 1;
                  if TZInfo.DaylightDate.wDay <> 1 then
                    repeat
                      DTBegins := DTBegins + 7;
                      inc(WeekNo);
                    until (WeekNo = TZInfo.DaylightDate.wDay);

                  { Encode time at which Daylight Time begins }
                  with TZInfo.DaylightDate do
                    DTBegins := DTBegins + EncodeTime(wHour, wMinute, 0, 0);
                end;
            5 : begin
                  { Count down from end of month to day of week. Recall   }
                  { that we set DTBegins to the first day of the month;   }
                  { go to the first day of the next month and decrement:  }
                  DTBegins := IncMonth(DTBegins, 1);
                  DTBegins := DTBegins - 1;
                  while SysUtils.DayOfWeek(DTBegins) - 1 <>
                        TZInfo.DaylightDate.wDayOfWeek do
                    DTBegins := DTBegins -1;
                  { Encode time at which Daylight Time begins }
                  with TZInfo.DaylightDate do
                    DTBegins := DTBegins + EncodeTime(wHour, wMinute, 0, 0);
                end;
          end;  { case }

          { Calculate DateTime Standard Time begins using relative format  }
          { Start at beginning of Standard month }
          STBegins := EncodeDate(Y, TZInfo.StandardDate.wMonth, 1);
          case TZInfo.StandardDate.wDay of
            1,2,3,
            4 : begin
                  { Get to first occurrence of wDayOfWeek                  }
                  { Key point: SysUtils.DayOfWeek is unary-based           }
                  {            TZInfo.Standard.wDay is zero-based          }
                  while (SysUtils.DayOfWeek(STBegins) - 1) <>
                         TZInfo.StandardDate.wDayOfWeek do
                    STBegins := STBegins + 1;
                  WeekNo := 1;
                  if TZInfo.StandardDate.wDay <> 1 then
                    repeat
                      STBegins := STBegins + 7;
                      inc(WeekNo);
                    until (WeekNo = TZInfo.StandardDate.wDay);

                  { Encode time at which Standard Time begins }
                  with TZInfo.StandardDate do
                    STBegins := STBegins + EncodeTime(wHour, wMinute, 0, 0);
                end;
            5 : begin
                  { Count down from end of month to day of week. Recall   }
                  { that we set STBegins to the first day of the month;   }
                  { go to the first day of the next month and decrement:  }
                  STBegins := IncMonth(STBegins, 1);
                  STBegins := STBegins - 1;
                  while SysUtils.DayOfWeek(STBegins) - 1 <>
                        TZInfo.StandardDate.wDayOfWeek do
                    STBegins := STBegins -1;
                  { Encode time at which Standard Time begins }
                  with TZInfo.StandardDate do
                    STBegins := STBegins + EncodeTime(wHour, wMinute, 0, 0);
                end;
          end;  { case }
        end
      else
        begin  { Absolute SystemTime format }
          with TZInfo.DaylightDate do
            begin
              DTBegins := EncodeDate(wYear, wMonth, wDay);
              DTBegins := DTBegins + EncodeTime(wHour, wMinute, 0, 0);
            end;
          with TZInfo.StandardDate do
            begin
              STBegins := EncodeDate(wYear, wMonth, wDay);
              STBegins := STBegins + EncodeTime(wHour, wMinute, 0, 0);
            end;
        end;

      { Finally! How does DT compare to DTBegins and STBegins? }
      if (TZInfo.DaylightDate.wMonth < TZInfo.StandardDate.wMonth) then
        { Northern Hemisphere }
        Result := (DT >= DTBegins) AND (DT < STBegins)
      else
        { Southern Hemisphere }
        Result := (DT < STBegins) OR (DT >= DTBegins);
    end;
end;

function TbrwFrmStore.LocalTimeToUniversal(LT : TDateTime): TDateTime;
var UT : TDateTime; TZOffset : integer;  { offset in minutes }
begin
  { Initialize UT to something so the compiler won't complain... }
  UT := LT;
  { Determine offset in effect for DateTime LT: }
  if DaylightSavings(LT) then
    TZOffset := TZInfo.Bias + TZInfo.DaylightBias
  else
    TZOffset := TZInfo.Bias + TZInfo.StandardBias;
  { Apply offset }
  if (TZOffset > 0) then  { Time Zones west of Greenwich }
    UT := LT + EncodeTime(TZOffset DIV 60, TZOffset MOD 60, 0, 0)
  else
    if (TZOffset = 0) then  { Time Zone = Greenwich }
      UT := LT
    else
      if (TZOffset < 0) then  { Time Zones east of Greenwich }
        UT := LT - EncodeTime(abs(TZOffset) DIV 60, abs(TZOffset) MOD 60, 0, 0);
  { Return Universal Time }
  Result := UT;
end;

function TbrwFrmStore.UniversalTimeToLocal(UT : TDateTime): TDateTime;
var LT : TDateTime; TZOffset : integer;  { offset in minutes }
begin
  { Initialize LT to something so the compiler won't complain... }
  LT := UT;
  { Determine offset in effect for DateTime UT: }
  if DaylightSavings(UT) then
    TZOffset := TZInfo.Bias + TZInfo.DaylightBias
  else
    TZOffset := TZInfo.Bias + TZInfo.StandardBias;
  { Apply offset }
  if (TZOffset > 0) then  { Time Zones west of Greenwich }
    LT := UT - EncodeTime(TZOffset DIV 60, TZOffset MOD 60, 0, 0)
  else
    if (TZOffset = 0) then  { Time Zone = Greenwich }
      LT := UT
    else
      if (TZOffset < 0) then  { Time Zones east of Greenwich }
        LT := UT + EncodeTime(abs(TZOffset) DIV 60, abs(TZOffset) MOD 60, 0, 0);
  { Return Local Time }
  Result := LT;
end;


procedure TbrwFrmStore.scTaxCategorySelectItem(Sender: TObject);
begin
  inherited;
  StoreRefresh;

  btnSetTax.Enabled := True;

end;

procedure TbrwFrmStore.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1960);
end;

procedure TbrwFrmStore.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  SetServerLocation;

end;

procedure TbrwFrmStore.cmbServerLocationChange(Sender: TObject);
begin
  inherited;
  quForm.Edit;
  
  if MyStrToInt(quFormHourDefault.AsString) = 0 then
    quFormHourDefault.AsInteger := GetTimeZoneOffset;


  RefreshServerLocation;



end;

procedure TbrwFrmStore.SetServerLocation;
begin
  if cmbServerLocation.ItemIndex = 0 then
    quFormHourDefault.AsInteger := 0;

end;

procedure TbrwFrmStore.GetServerLocation;
begin
   if quFormHourDefault.AsString = '0' then
      cmbServerLocation.ItemIndex := 0
   else
      cmbServerLocation.ItemIndex := 1;

  RefreshServerLocation;

end;

procedure TbrwFrmStore.RefreshServerLocation;
begin
  if cmbServerLocation.ItemIndex = 0 then
      pnlTimeZone.Visible := False
  else
      pnlTimeZone.Visible := True;

end;


procedure TbrwFrmStore.PostOnExit(Sender: TObject);
begin
  inherited;
  with TDBGrid(Sender).DataSource.DataSet do
    if Active then
      if State in dsEditModes then
        Post;

end;

procedure TbrwFrmStore.PaymentRefresh;
var
  sID: String;
begin
  inherited;

  sID := quPaymentIDMeioPag.AsString;

  with quPayment do
    begin
      if State in dsEditModes then
        Post;
      Close;
      Open;
      Locate('IDMeioPag', sID, []);
    end;

end;

procedure TbrwFrmStore.StoreRefresh;
var
  sID: String;
begin
  inherited;

  sID := quStoreIDGroup.AsString;

  with quStore do
    begin
      if State in dsEditModes then
        Post;
      Close;
      Open;
      Locate('IDGroup', sID, []);
    end;

end;

procedure TbrwFrmStore.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  with quStore do
    if Active then
      begin
        if State in dsEditModes then
          Post;
        Close;
      end;

end;

procedure TbrwFrmStore.btnSetTaxClick(Sender: TObject);
begin
  inherited;

  if scTaxCategory.LookUpValue <> '' then
     with DM.quFreeSQL do
       begin
       if Active then
          Close;
       SQL.Clear;
       SQL.Add('UPDATE StoreToTabGroup ');
       SQL.Add('SET IDTaxCategory = ' + scTaxCategory.LookUpValue);
       SQL.Add('WHERE IDStore = ' + quFormIDStore.AsString);
       ExecSQL;

       StoreRefresh;
       end;

end;

procedure TbrwFrmStore.scContaCorrenteSelectItem(Sender: TObject);
begin
  inherited;

  PaymentRefresh;

end;

procedure TbrwFrmStore.scTaxCategoryEnter(Sender: TObject);
begin
  inherited;
  //error no superBUGcombo
  quStore.Edit;
end;

procedure TbrwFrmStore.FillInitialCounters;
begin
  edtStartPreSale.Tag := 1;
  edtStartInvoice.Tag := 1;
  try
    edtStartPreSale.Text :=
        DM.DescCodigo(['Tabela'],
                      [QuotedStr('Invoice.SaleCode' + quFormIDStore.AsString)],
                      'Sis_CodigoIncremental', 'UltimoCodigo');

    edtStartInvoice.Text :=
        DM.DescCodigo(['Tabela'],
                      [QuotedStr('Invoice.InvoiceCode' + quFormIDStore.AsString)],
                      'Sis_CodigoIncremental', 'UltimoCodigo');

    edtStartPreSale.Modified := False;
    edtStartInvoice.Modified := False;
  finally
    edtStartPreSale.Tag := 0;
    edtStartInvoice.Tag := 0;
  end;
end;


procedure TbrwFrmStore.UpdateInitialCounters;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    if edtStartPreSale.Modified then
    begin
      DM.GetNextID('Invoice.SaleCode' + quFormIDStore.AsString);
      if Trim(edtStartPreSale.Text) <> '' then
      begin
        SQL.Clear;
        SQL.Add('UPDATE Sis_CodigoIncremental');
        SQL.Add('SET UltimoCodigo = ' + Trim(edtStartPreSale.Text));
        SQL.Add('WHERE Tabela = ' + QuotedStr('Invoice.SaleCode' + quFormIDStore.AsString));
        ExecSQL;
      end;
    end;


    if edtStartInvoice.Modified then
    begin
      DM.GetNextID('Invoice.InvoiceCode' + quFormIDStore.AsString);
      if Trim(edtStartPreSale.Text) <> '' then
      begin
        SQL.Clear;
        SQL.Add('UPDATE Sis_CodigoIncremental');
        SQL.Add('SET UltimoCodigo = ' + Trim(edtStartInvoice.Text));
        SQL.Add('WHERE Tabela = ' + QuotedStr('Invoice.InvoiceCode' + quFormIDStore.AsString));
        ExecSQL;
      end;
    end;
  end;
end;

procedure TbrwFrmStore.edtStartPreSaleChange(Sender: TObject);
begin
  inherited;
  if TComponent(Sender).Tag = 0 then
    quForm.Edit;
end;

procedure TbrwFrmStore.edtStartInvoiceChange(Sender: TObject);
begin
  inherited;
  if TComponent(Sender).Tag = 0 then
    quForm.Edit;
end;

function TbrwFrmStore.OnAfterSaveChange(var iError: Integer): Boolean;
begin
  UpdateInitialCounters;
end;

procedure TbrwFrmStore.scImpostosCategSelectItem(Sender: TObject);
begin
  inherited;

  StoreRefresh;

  btnSetTaxGov.Enabled := True;

end;

procedure TbrwFrmStore.btnSetTaxGovClick(Sender: TObject);
begin
  inherited;

  if scTaxCategory.LookUpValue <> '' then
     with DM.quFreeSQL do
       begin
       if Active then
          Close;
       SQL.Clear;
       SQL.Add('UPDATE StoreToTabGroup ');
       SQL.Add('SET IDSaleTax = ' + scImpostosCateg.LookUpValue);
       SQL.Add('WHERE IDStore = ' + quFormIDStore.AsString);
       ExecSQL;

       StoreRefresh;
       end;

end;

procedure TbrwFrmStore.EnableGovTax(b: Boolean);
begin
   pnlTaxGov.Visible := b;
   grdCategry.Columns[3].Visible := b;
   grdCategry.Columns[4].Visible := b;
end;

procedure TbrwFrmStore.btAddVendorAccountClick(Sender: TObject);
begin
  inherited;
  with TFchStoreVendorAccount.Create(Self) do
    if Start(quFormIDStore.AsInteger) then
      VendorAccountRefresh;
end;

procedure TbrwFrmStore.VendorAccountClose;
begin
  with quVendorAccount do
    if Active then
      Close;
end;

procedure TbrwFrmStore.VendorAccountOpen;
begin
  with quVendorAccount do
    if not Active then
    begin
      Parameters.ParamByName('IDStore').Value := quFormIDStore.AsInteger;
      Open;
    end;
end;

procedure TbrwFrmStore.VendorAccountRefresh;
begin
  VendorAccountClose;
  VendorAccountOpen;
end;

procedure TbrwFrmStore.btRemoveVendorAccountClick(Sender: TObject);
begin
  inherited;
  if (quVendorAccount.Active) and (quVendorAccountIDStoreVendorAccount.AsInteger <> 0) then
  begin
    DM.RunSQL('DELETE Mnt_StoreVendorAccount WHERE IDStoreVendorAccount = ' + quVendorAccountIDStoreVendorAccount.AsString);
    VendorAccountRefresh;
  end;
end;

procedure TbrwFrmStore.bdedtNameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if (Key = '''') then
  begin
    Key := #0;
    MessageBeep($FFFFFFFF);
  end;

end;

end.
