unit uFrmDrawerKickLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData,
  DateBox, Mask, SuperComboADO, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, ADODB, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Buttons;

type
  TFrmDrawerKickLog = class(TDialogParent)
    Panel3: TPanel;
    pnlButtons: TPanel;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    btFilter: TSpeedButton;
    pnlDivisoria2: TPanel;
    grdBrowseSearch: TcxGrid;
    grdBrowseSearchDB: TcxGridDBTableView;
    grdBrowseSearchLevel: TcxGridLevel;
    quDrawerKickLog: TADOQuery;
    dsDrawerKickLog: TDataSource;
    grdBrowseSearchDBMovDate: TcxGridDBColumn;
    grdBrowseSearchDBTypeName: TcxGridDBColumn;
    quDrawerKickLogTypeName: TStringField;
    pnlBasicFilter: TPanel;
    lblType: TLabel;
    Label1: TLabel;
    lbFrom: TLabel;
    lbTo: TLabel;
    cbxType: TComboBox;
    scUser: TSuperComboADO;
    btnUserAll: TButton;
    Button2: TButton;
    DateInicio: TDateBox;
    DateFim: TDateBox;
    btSearch: TBitBtn;
    quDrawerKickLogIDDrawerKickLog: TIntegerField;
    quDrawerKickLogSystemUser: TStringField;
    quDrawerKickLogIDCashRegister: TIntegerField;
    quDrawerKickLogMovDate: TDateTimeField;
    quDrawerKickLogType: TIntegerField;
    quDrawerKickLogCashRegisterName: TStringField;
    grdBrowseSearchDBDBColumn1: TcxGridDBColumn;
    procedure Button2Click(Sender: TObject);
    procedure btnUserAllClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quDrawerKickLogCalcFields(DataSet: TDataSet);
    procedure btExcelClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btFilterClick(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
  private
    sSale,
    sCloseReg,
    sWidraw,
    sPettyCash,
    sNoSale,
    sOpenCash : String;
    FIDCashRegister : Integer;
    AView  : TcxCustomGridTableView;
    procedure LoadImages;
  public
    function Start(IDCashRegister: Integer): Boolean;
  end;

var
  FrmDrawerKickLog: TFrmDrawerKickLog;

implementation

{$R *.dfm}

uses uDM, uDMGlobal, uMsgBox, uMsgConstant, uFrmExport, uSystemConst, uDateTimeFunctions;

function TFrmDrawerKickLog.Start(IDCashRegister: Integer): Boolean;
var
  AOptions : TcxGridStorageOptions;
  ASaveViewName : String;
  fRegistryPath : String;
begin

  FIDCashRegister := IDCashRegister;

  with quDrawerKickLog do
  begin
    Close;
    Parameters.ParamByName('IDCashRegister').Value := FIDCashRegister;
    Open;
  end;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
     TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  LoadImages;

  if (ShowModal = mrOk) then
    result := True
  else
    result := False;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
  quDrawerKickLog.Close;
end;

procedure TFrmDrawerKickLog.Button2Click(Sender: TObject);
begin
  inherited;
  cbxType.ItemIndex := 0;
end;

procedure TFrmDrawerKickLog.btnUserAllClick(Sender: TObject);
begin
  inherited;
  scUser.LookUpValue := '';
  scUser.Text := '<'+btnUserAll.Caption+'>';
end;

procedure TFrmDrawerKickLog.btSearchClick(Sender: TObject);
var
 sSQL, sWhere: String;
begin
  if scUser.LookUpValue <> '' then
    sWhere := sWhere + ' AND DKL.IDUser = ' + scUser.LookUpValue;

  if (cbxType.ItemIndex <> 0) then
    sWhere := sWhere + ' AND DKL.Type = ' + InttoStr(cbxType.ItemIndex);

  if DateInicio.Text <> '' then
    sWhere := sWhere + ' AND DKL.MovDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39);

  if DateFim.Text <> '' then
    sWhere := sWhere + ' AND DKL.MovDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);

  sSQL := 'SELECT '+
          ' IDDrawerKickLog, '+
          ' SU.SystemUser, '+
          ' DKL.IDCashRegister, '+
          ' DKL.MovDate, '+
          ' DKL.Type, '+
          ' CR.Name as CashRegisterName '+
          'FROM '+
          ' Sal_DrawerKickLog DKL '+
          ' JOIN SystemUser SU ON (SU.IDUser = DKL.IDUser) '+
          ' JOIN CashRegister CR ON (CR.IDCashRegister = DKL.IDCashRegister) '+
          'WHERE '+
          ' DKL.IDCashRegister = ' +  IntToStr(FIDCashRegister) + sWhere;

   With quDrawerKickLog do
      begin
      Close;
      SQL.Text := sSQL;
      Open;
      end;
end;

procedure TFrmDrawerKickLog.FormCreate(Sender: TObject);
begin
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sSale      := 'Sale';
      sCloseReg  := 'CloseReg';
      sWidraw    := 'Widraw';
      sPettyCash := 'PettyCash';
      sNoSale    := 'NoSale';
      sOpenCash  := 'Opencash';
    end;

    LANG_PORTUGUESE :
    begin
      sSale      := 'Venda';
      sCloseReg  := 'Fechamento de caixa';
      sWidraw    := 'Depósito';
      sPettyCash := 'Suprimento';
      sNoSale    := 'Abriu sem venda';
      sOpenCash  := 'Abertura de caixa';
    end;

    LANG_SPANISH :
    begin
      sSale      := 'Venta';
      sCloseReg  := 'Registro cercano ';
      sWidraw    := 'Widraw';
      sPettyCash := 'Efectivo pequeño';
      sNoSale    := 'Ninguna venta';
      sOpenCash  := 'Abrir el efectivo ';
    end;
  end;

  AView := TcxCustomGridTableView(grdBrowseSearch.FocusedView);

end;

procedure TFrmDrawerKickLog.quDrawerKickLogCalcFields(DataSet: TDataSet);
begin
  case quDrawerKickLogType.AsInteger of
    1: quDrawerKickLogTypeName.AsString := sSale;
    2: quDrawerKickLogTypeName.AsString := sCloseReg;
    3: quDrawerKickLogTypeName.AsString := sWidraw;
    4: quDrawerKickLogTypeName.AsString := sPettyCash;
    5: quDrawerKickLogTypeName.AsString := sNoSale;
    6: quDrawerKickLogTypeName.AsString := sOpenCash;
   end;
end;

procedure TFrmDrawerKickLog.btExcelClick(Sender: TObject);
begin
  If (not quDrawerKickLog.Active) or
    (quDrawerKickLog.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(grdBrowseSearch, Self.Caption);
end;

procedure TFrmDrawerKickLog.btGroupClick(Sender: TObject);
begin
  inherited;


  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBrowseSearch do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;

end;

procedure TFrmDrawerKickLog.btColumnClick(Sender: TObject);
begin
  inherited;
  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmDrawerKickLog.btFilterClick(Sender: TObject);
begin
  inherited;
  if btFilter.Down then
    begin
    TcxGridDBTableView(AView).Filtering.Visible := fvAlways;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := True;
    end
  else
    begin
    TcxGridDBTableView(AView).Filtering.Visible := fvNever;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := False;
    end;
end;

procedure TFrmDrawerKickLog.AplicarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFrmDrawerKickLog.CancelarClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmDrawerKickLog.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_FILTER, btFilter.Glyph);
end;

end.
