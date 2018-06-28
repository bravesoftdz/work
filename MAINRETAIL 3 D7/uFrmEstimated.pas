unit uFrmEstimated;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DateBox, Mask, SuperComboADO, DBCtrls, ADODB, PowerADOQuery, SubListPanel,
  cxLookAndFeelPainters, cxButtons, Menus, uFrmAddItems, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, uInvoice;

type
  TFrmEstimated = class(TFrmParentAll)
    pnlBasicFilter: TPanel;
    Label3: TLabel;
    lbFrom: TLabel;
    lbTo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    pblGO: TPanel;
    pnlAviso: TPanel;
    btnExec: TSpeedButton;
    cmbStore: TSuperComboADO;
    Button2: TButton;
    DateInicio: TDateBox;
    DateFim: TDateBox;
    cbmDocs: TComboBox;
    edtDocs: TEdit;
    cbmName: TComboBox;
    edtNames: TEdit;
    edtHoldNumber: TEdit;
    pnlInvoices: TPanel;
    grdEstimated: TcxGrid;
    grdEstimatedDB: TcxGridDBTableView;
    grdEstimatedLevel: TcxGridLevel;
    Splitter1: TSplitter;
    pnlDetail: TPanel;
    pnlControl: TPanel;
    Panel2: TPanel;
    TimeAviso: TTimer;
    btNewEstimated: TSpeedButton;
    btRemoveEst: TSpeedButton;
    btRemoveEstItem: TSpeedButton;
    btNewEstItem: TSpeedButton;
    dsEstimated: TDataSource;
    Label5: TLabel;
    scUser: TSuperComboADO;
    Button1: TButton;
    grdEstimatedDBIDEstimated: TcxGridDBColumn;
    grdEstimatedDBName: TcxGridDBColumn;
    grdEstimatedDBPessoa: TcxGridDBColumn;
    quEstimatedItems: TPowerADOQuery;
    dsEstimatedItems: TDataSource;
    grdEstItems: TcxGrid;
    grdEstItemsDB: TcxGridDBTableView;
    cxgrdEstItems: TcxGridLevel;
    quEstimatedItemsIDEstimatedItem: TIntegerField;
    quEstimatedItemsIDModel: TIntegerField;
    quEstimatedItemsModel: TStringField;
    quEstimatedItemsDescription: TStringField;
    grdEstItemsDBQty: TcxGridDBColumn;
    grdEstItemsDBSalePrice: TcxGridDBColumn;
    grdEstItemsDBModel: TcxGridDBColumn;
    grdEstItemsDBDescription: TcxGridDBColumn;
    quEstimatedItemsGrandTotal: TCurrencyField;
    grdEstItemsDBGrandTotal: TcxGridDBColumn;
    SubWebModelInfo: TSubListPanel;
    grdEstimatedDBSystemUser: TcxGridDBColumn;
    btnPrint: TBitBtn;
    Splitter2: TSplitter;
    chUpdatePrice: TCheckBox;
    quEstimatedItemsEstSalePrice: TBCDField;
    quEstimatedItemsSellingPrice: TBCDField;
    quEstimatedItemsSalePrice: TCurrencyField;
    quEstimated: TPowerADOQuery;
    quEstimatedIDEstimated: TIntegerField;
    quEstimatedEstimatedDate: TDateTimeField;
    quEstimatedTotal: TBCDField;
    quEstimatedOBS: TStringField;
    quEstimatedName: TStringField;
    quEstimatedPessoa: TStringField;
    quEstimatedSystemUser: TStringField;
    quEstimatedIDUser: TIntegerField;
    chkImported: TCheckBox;
    quEstimatedOBS2: TStringField;
    quEstimatedItemsQty: TFloatField;
    grdEstItemsDBID: TcxGridDBColumn;
    btOpenEstItem: TSpeedButton;
    cmdUpdEstimatedItemCode: TADOCommand;
    quEstimatedItemsCode: TIntegerField;
    grdEstItemsDBCode: TcxGridDBColumn;
    btnAddQuick: TSpeedButton;
    pmAddItem: TPopupMenu;
    miAddItem: TMenuItem;
    miQuickEntry: TMenuItem;
    quEstimatedIDPessoa: TIntegerField;
    quEstimatedItemsManufacturer: TStringField;
    grdEstItemsDBManufacturer: TcxGridDBColumn;
    btPOItemPreview: TSpeedButton;
    btCustomizeColumns: TSpeedButton;
    btGroup: TSpeedButton;
    gridPrinter: TdxComponentPrinter;
    gridPrinterLink: TdxGridReportLink;
    quEstimatedItemsDepartment: TStringField;
    grdEstItemsDBDepartment: TcxGridDBColumn;
    quEstimatedIDStore: TIntegerField;
    btOpenEstimated: TSpeedButton;
    quEstimatedIDPreSale: TIntegerField;
    quEstimatedIDTouristGroup: TIntegerField;
    btnCreateHold: TSpeedButton;
    quCostumerFile: TPowerADOQuery;
    quCostumerFileIDPessoa: TIntegerField;
    quCostumerFileIDTipoPessoa: TIntegerField;
    btnConfirm: TSpeedButton;
    quEstimatedIDDeliverType: TIntegerField;
    quEstimatedDeliverDate: TDateTimeField;
    quEstimatedDeliverAddress: TStringField;
    quEstimatedDeliverOBS: TStringField;
    quEstimatedTotalDiscount: TBCDField;
    quEstimatedConfirmed: TBooleanField;
    quEstimatedItemsExtSalePrice: TBCDField;
    procedure TimeAvisoTimer(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btNewEstimatedClick(Sender: TObject);
    procedure quEstimatedItemsCalcFields(DataSet: TDataSet);
    procedure grdEstimatedDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btRemoveEstClick(Sender: TObject);
    procedure btNewEstItemClick(Sender: TObject);
    procedure btRemoveEstItemClick(Sender: TObject);
    procedure edtHoldNumberChange(Sender: TObject);
    procedure grdEstItemsDBCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure dsEstimatedDataChange(Sender: TObject; Field: TField);
    procedure btOpenEstItemClick(Sender: TObject);
    procedure dsEstimatedItemsDataChange(Sender: TObject; Field: TField);
    procedure grdEstItemsDBDblClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure miQuickEntryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btPOItemPreviewClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btCustomizeColumnsClick(Sender: TObject);
    procedure btOpenEstimatedClick(Sender: TObject);
    procedure quEstimatedAfterScroll(DataSet: TDataSet);
    procedure grdEstimatedDBDblClick(Sender: TObject);
    procedure btnCreateHoldClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
  private
    FrmAddItems: TFrmAddItems;
    AView: TcxCustomGridTableView;
    fAutoUpdatePrice : Boolean;
    fUpdateDays : Integer;
    fConfirmEst : Boolean;
    AFrmInvoice : TFrmInvoice;
    AIDCashRegMov : Integer;

    procedure AtivaAviso;
    procedure DesativaAviso;

    procedure RefreshModelInfo;

    procedure OpenEstimated;
    procedure CloseEstimated;
    procedure RefreshEstimated;
    procedure RefreshAll;
    procedure OpenEstimatedItem;

    procedure CloseEstimatedItem;

    procedure ReOrderEstimatedItemCode;

    procedure InsertEstimatedItemList(AList: TList);

    function GetWhereClause:String;

    function ValidadeCustomer : Boolean;

    procedure UpdateConfirmedStatus;
  public
    function StartImport(FFrmInvoice : TFrmInvoice; FIDCashRegMov : Integer): Boolean;
    function Start : Boolean;
    procedure RefreshEstimatedItem;
  end;

implementation

uses uDM, uDateTimeFunctions, uMsgBox, uMsgConstant, uFrmEstimatedNew,
     uFrmEstimatedItemNew, uFrmEstimatedPrint, uSystemConst, uSystemTypes,
     uContentClasses, uNumericFunctions, Math, DateUtils, uFrmImportEstimated,
     uFchPessoa, uFrmEstimatedInfo, uPassword;

{$R *.dfm}

procedure TFrmEstimated.CloseEstimated;
begin
  with quEstimated do
    if Active then
      Close;
end;

function TFrmEstimated.GetWhereClause:String;
var
 sField, sField1 : String;
begin
  Result := '';

  // filtro por Store
  if cmbStore.LookUpValue <> '' then
    Result := ' E.IDStore = ' + cmbStore.LookUpValue
  else if DM.fStore.StoreList <> '' then
    Result := ' E.IDStore IN ('+ DM.fStore.StoreList +')';

  if chkImported.Checked then
  begin
    if Result <> '' then
      Result := Result + ' AND ';
    Result := Result + ' E.IDPreSale IS NOT NULL ';
  end
  else
  begin
    if Result <> '' then
      Result := Result + ' AND ';
    Result := Result + ' E.IDPreSale IS NULL ';
  end;

  if edtHoldNumber.Text <> '' then
  begin
    Result := Result + ' AND E.IDEstimated Like ' + QuotedStr('%' + trim(edtHoldNumber.Text) + '%');
  end
  else
  begin
    if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
    begin
      Result := Result + ' AND (E.EstimatedDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                         ' E.EstimatedDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39) + ') ';
    end
    else
      begin
        MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
        Exit;
      end;
    end;

  if scUser.LookUpValue <> '' then
    Result := Result + ' AND E.IDUser = ' + scUser.LookUpValue;

  //Customer Options
  case cbmName.ItemIndex of
    0 : sField := '';
    1 : sField := ' P.PessoaFirstName';
    2 : sField := ' P.PessoaLastName';
    3 : sField := ' P.Pessoa';
  end;

  case cbmDocs.ItemIndex of
    0 : sField1 := '';
    1 : sField1 := ' P.OrgaoEmissor';
    2 : sField1 := ' P.CartTrabalho';
    3 : sField1 := ' P.CustomerCard';
    4 : sField1 := ' P.CPF';
  end;

  case cbmName.ItemIndex of
    0:; //Todos
    else //Add like
      Result := Result + ' AND ' + sField+ ' Like ' + QuotedStr('%' + trim(edtNames.Text) + '%');
  end;

  case cbmDocs.ItemIndex of
    0: ;//Todos
    else //Add like
      Result := Result + ' AND ' + sField1+ ' Like ' + QuotedStr('%' + trim(edtDocs.Text) + '%');
  end;

  if Result <> '' then
    Result := 'WHERE ' + Result;
end;

procedure TFrmEstimated.OpenEstimated;
begin
  with quEstimated do
    if not Active then
    begin
      CommandText := 'SELECT E.IDEstimated, E.EstimatedDate, E.IDStore, E.IDPessoa, E.Total, E.OBS, E.OBS2, E.IDPreSale, S.Name, P.Pessoa, SU.IDUser, SU.SystemUser, E.IDTouristGroup, ' +
                     'E.IDDeliverType, E.DeliverDate, E.DeliverAddress, E.DeliverOBS, E.TotalDiscount, E.Confirmed ' +
                     'FROM Estimated E (NOLOCK) '+
                     'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = E.IDPEssoa) ' +
                     'JOIN Store S (NOLOCK) ON (S.IDStore = E.IDStore) ' +
                     'JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = E.IDUser) ' + GetWhereClause;
      Open;
    end;
end;

procedure TFrmEstimated.RefreshEstimated;
begin
  CloseEstimated;
  OpenEstimated;

  grdEstimatedDB.DataController.Groups.FullExpand;
  grdEstimatedDB.DataController.GotoFirst;
end;

procedure TFrmEstimated.TimeAvisoTimer(Sender: TObject);
begin
  inherited;
  if pnlAviso.ParentColor = True then
    pnlAviso.Color := clNavy
  else
    pnlAviso.ParentColor := True;
end;

procedure TFrmEstimated.btnExecClick(Sender: TObject);
begin
  inherited;
  RefreshAll;
  DesativaAviso;
end;

procedure TFrmEstimated.AtivaAviso;
begin
  TimeAviso.Enabled := True;
end;

procedure TFrmEstimated.DesativaAviso;
begin
  TimeAviso.Enabled := False;
end;

procedure TFrmEstimated.Button1Click(Sender: TObject);
begin
  inherited;
  scUser.LookUpValue := '';
  scUser.Text := '<-->';
  AtivaAviso;
end;

procedure TFrmEstimated.Button2Click(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text := '<-->';
  AtivaAviso;
end;

procedure TFrmEstimated.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseEstimatedItem;
  CloseEstimated;

  Action := caFree;
end;

procedure TFrmEstimated.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TFrmEstimated.Start: Boolean;
var
  sRegistryPath: String;
begin
  DateInicio.Date := FirstDateMonth;
  DateFim.Date := LastDateMonth;
  scUser.LookUpValue := IntToStr(DM.fUser.ID);
  sRegistryPath := MR_BRW_REG_PATH + Self.Caption;

  DM.LoadGridFromRegistry(grdEstItemsDB, sRegistryPath, [gsoUseFilter, gsoUseSummary]);

  fUpdateDays := DM.fSystem.SrvParam[PARAM_UPDATE_BUDGET_PRICE];
  fConfirmEst := DM.fSystem.SrvParam[PARAM_CONFIRM_BUDGET];
  btnCreateHold.Visible := (AFrmInvoice <> nil);
  btnConfirm.Visible := fConfirmEst;
  ShowModal;

  DM.SaveGridToRegistry(grdEstItemsDB, sRegistryPath, True, [gsoUseFilter, gsoUseSummary]);
  Result := True;
end;

function TFrmEstimated.StartImport(FFrmInvoice : TFrmInvoice; FIDCashRegMov : Integer): Boolean;
begin
  AFrmInvoice := FFrmInvoice;
  AIDCashRegMov := FIDCashRegMov;
  Start;
end;

procedure TFrmEstimated.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btNewEstimated.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btNewEstItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnCreateHold.Glyph);
  DM.imgSmall.GetBitmap(BTN18_CONFIRMED, btnConfirm.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btOpenEstItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN, btOpenEstimated.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveEst.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveEstItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_PREVIEW,btPOItemPreview.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btCustomizeColumns.Glyph);
  AView := TcxCustomGridTableView(grdEstItems.FocusedView);
  SubWebModelInfo.CreateSubList;
end;

procedure TFrmEstimated.btNewEstimatedClick(Sender: TObject);
begin
  inherited;
  with TFrmEstimatedNew.Create(Self) do
    if Start(nil, True) then
    begin
      RefreshEstimated;
      quEstimated.Last;
    end;
end;

procedure TFrmEstimated.quEstimatedItemsCalcFields(DataSet: TDataSet);
var
 SalePrice: Currency;
begin
  inherited;
  if chUpdatePrice.Checked then
    SalePrice := quEstimatedItemsSellingPrice.AsCurrency
  else
    SalePrice := quEstimatedItemsEstSalePrice.AsCurrency;

  quEstimatedItemsSalePrice.AsCurrency := SalePrice;

  quEstimatedItemsGrandTotal.AsCurrency := quEstimatedItemsQty.AsFloat * SalePrice;
  //quEstimatedItemsGrandTotal.AsCurrency := quEstimatedItemsExtSalePrice.AsCurrency;
  //FormatFloat('0.00', quEstimatedItemsQty.AsFloat * SalePrice);
end;

procedure TFrmEstimated.CloseEstimatedItem;
begin
  with quEstimatedItems do
    if Active then
      Close;
end;

procedure TFrmEstimated.OpenEstimatedItem;
begin
  with quEstimatedItems do
  if not Active then
  begin
    Parameters.ParamByName('IDEstimated').Value := quEstimatedIDEstimated.AsInteger;
    Open;
  end;
end;

procedure TFrmEstimated.RefreshEstimatedItem;
begin
  CloseEstimatedItem;
  OpenEstimatedItem;

  grdEstItemsDB.ViewData.Expand(True);
end;

procedure TFrmEstimated.grdEstimatedDBCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  RefreshEstimatedItem;
  RefreshModelInfo;
end;

procedure TFrmEstimated.btRemoveEstClick(Sender: TObject);
begin
  inherited;
  if (not quEstimated.Active) or (quEstimatedIDEstimated.AsString = '') then
    Exit;

  if (DM.fUser.IDUserType <> USER_TYPE_ADMINISTRATOR) and
     (DM.fUser.ID <> quEstimatedIDUser.AsInteger) then
  begin
    MsgBox(MSG_CRT_BUDGET_NO_DELETE, vbOKOnly + vbInformation);
    Exit;
  end;

  if MsgBox(MSG_QST_DELETE, vbQuestion + vbYesNo) = vbYes then
  begin
    try
      DM.ADODBConnect.BeginTrans;
      with DM.quFreeSQL do
      begin
        if Active then
          Close;

        SQL.Clear;
        SQL.Add('DELETE Sal_PaymentCondition WHERE IDEstimated = ' + quEstimatedIDEstimated.AsString);
        ExecSQL;

        SQL.Clear;
        SQL.Add('DELETE EstimatedItem WHERE IDEstimated = ' + quEstimatedIDEstimated.AsString);
        ExecSQL;

        SQL.Clear;
        SQL.Add('DELETE Estimated WHERE IDEstimated = ' + quEstimatedIDEstimated.AsString);
        ExecSQL;
        
      end;
      DM.ADODBConnect.CommitTrans;
    except
      DM.ADODBConnect.RollbackTrans;
      raise;
    end;
    RefreshAll;
  end;
end;

procedure TFrmEstimated.btNewEstItemClick(Sender: TObject);
var
  iIDEstimated: Integer;
begin
  inherited;
  iIDEstimated := quEstimatedIDEstimated.AsInteger;

  with TFrmEstimatedItemNew.Create(Self) do
    if Start(btInc, iIDEstimated, -1) then
    begin
      UpdateConfirmedStatus;                           
      RefreshEstimatedItem;
      RefreshModelInfo;
    end;
end;

procedure TFrmEstimated.btOpenEstItemClick(Sender: TObject);
var
  iIDEstimated, iIDEstimatedItem: Integer;
begin
  inherited;
  iIDEstimated := quEstimatedIDEstimated.AsInteger;
  iIDEstimatedItem := quEstimatedItemsIDEstimatedItem.AsInteger;

  with TFrmEstimatedItemNew.Create(Self) do
    if Start(btAlt, iIDEstimated, iIDEstimatedItem) then
    begin
      UpdateConfirmedStatus;
      RefreshEstimatedItem;
      RefreshModelInfo;
    end;
end;

procedure TFrmEstimated.btRemoveEstItemClick(Sender: TObject);
begin
  if (not quEstimatedItems.Active) or (quEstimatedItemsIDEstimatedItem.AsString = '') then
    Exit;

  if (DM.fUser.IDUserType <> USER_TYPE_ADMINISTRATOR) and
     (DM.fUser.ID <> quEstimatedIDUser.AsInteger) then
  begin
    MsgBox(MSG_CRT_BUDGET_NO_DELETE, vbOKOnly + vbInformation);
    Exit;
  end;

  if MsgBox(MSG_QST_DELETE, vbQuestion + vbYesNo) = vbYes then
  begin
    try
      with DM.quFreeSQL do
      begin
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('DELETE EstimatedItem WHERE IDEstimatedItem = ' + quEstimatedItemsIDEstimatedItem.AsString);
        ExecSQL;
      end;
    except
      raise;
    end;

    UpdateConfirmedStatus;
    RefreshEstimatedItem;
    RefreshModelInfo;
    ReOrderEstimatedItemCode;
    RefreshEstimatedItem;
  end;
end;

procedure TFrmEstimated.edtHoldNumberChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TFrmEstimated.RefreshAll;
begin
  RefreshEstimated;
  RefreshEstimatedItem;
  RefreshModelInfo;
end;

procedure TFrmEstimated.RefreshModelInfo;
begin
  SubWebModelInfo.Param := 'IDModel='+quEstimatedItemsIDModel.AsString+';ShowOpen=0;BackColor=clWhite;StartImage=;Stretch=F;Bevel=F;';
end;

procedure TFrmEstimated.grdEstItemsDBCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  RefreshModelInfo;
end;


procedure TFrmEstimated.btnPrintClick(Sender: TObject);
var
  iIDEstimated : Integer;
  sOBS, sOBS2 : String;
  dEstimatedDate : TDateTime;
begin
  inherited;

  if (not quEstimated.Active) or (quEstimatedIDEstimated.AsString = '') then
     Exit;

  iIDEstimated   := quEstimatedIDEstimated.AsInteger;
  sOBS           := quEstimatedOBS.AsString;
  sOBS2          := quEstimatedOBS2.AsString;
  dEstimatedDate := quEstimatedEstimatedDate.AsDateTime;

  with TFrmEstimatedPrint.Create(Self) do
     if Start(iIDEstimated, sOBS, sOBS2, fAutoUpdatePrice) then
        RefreshEstimated;

end;

procedure TFrmEstimated.dsEstimatedDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  
  btNewEstItem.Enabled := (quEstimated.Active and (quEstimated.RecordCount > 0));
  btnAddQuick.Enabled := btNewEstItem.Enabled;

  if (fUpdateDays <> 0) then
    fAutoUpdatePrice := (DaysBetween(Now, quEstimatedEstimatedDate.AsDateTime) > fUpdateDays);

  if not chUpdatePrice.Checked then
    chUpdatePrice.Checked := fAutoUpdatePrice;

end;

procedure TFrmEstimated.dsEstimatedItemsDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btOpenEstItem.Enabled := (quEstimatedItems.Active and (quEstimatedItems.RecordCount > 0));
  btRemoveEstItem.Enabled := (quEstimatedItems.Active and (quEstimatedItems.RecordCount > 0));
end;

procedure TFrmEstimated.grdEstItemsDBDblClick(Sender: TObject);
begin
  inherited;
  if btOpenEstItem.Enabled then
    btOpenEstItemClick(Sender);
end;

procedure TFrmEstimated.ReOrderEstimatedItemCode;
var
  iCode: Integer;
begin
  iCode := 0;

  with quEstimatedItems do
    if RecordCount > 0 then
    try
      First;
      while not Eof do
      begin
        Inc(iCode);
        cmdUpdEstimatedItemCode.Parameters.ParamByName('IDEstimatedItem').Value :=
          FieldByName('IDEstimatedItem').AsInteger;
        cmdUpdEstimatedItemCode.Parameters.ParamByName('Code').Value := iCode;
        cmdUpdEstimatedItemCode.Execute;
        Next;
      end;
    finally
      First;
    end;
end;

procedure TFrmEstimated.btnAddQuickClick(Sender: TObject);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  pmAddItem.Popup(P.X, P.Y);
end;

procedure TFrmEstimated.miQuickEntryClick(Sender: TObject);
var
  ItemList: TList;
begin
  inherited;
  if not Assigned(FrmAddItems) then
    FrmAddItems := TFrmAddItems.Create(Self);

  ItemList := FrmAddItems.Start(quEstimatedIDPessoa.AsInteger, [dcQty, dcSalePrice], []);
  InsertEstimatedItemList(ItemList);
  RefreshEstimatedItem;
  RefreshModelInfo;
end;

procedure TFrmEstimated.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FrmAddItems);
end;

procedure TFrmEstimated.InsertEstimatedItemList(AList: TList);
var
  i, iIDEstimatedItem: Integer;
begin
  for i := 0 to Pred(AList.Count) do
  begin
    iIDEstimatedItem := DM.GetNextID(MR_INV_ESTIMATED_ITEM_ID);

    with DM.quFreeSQL do
    begin
      if Active then
        Close;

      SQL.Clear;
      SQL.Add('INSERT INTO EstimatedItem (IDEstimatedItem, IDEstimated, Code, IDModel, Qty, SalePrice)');
      SQL.Add('(SELECT ' + IntToStr(iIDEstimatedItem) + ',' + quEstimatedIDEstimated.AsString + ', IsNull(MAX(Code), 0) + 1, ' + IntToStr(TAddItem(AList[i]).IDModel) + ',');
      SQL.Add(MyFormatDouble(TAddItem(AList[i]).Qty, '.') + ', ' + MyFormatDouble(TAddItem(AList[i]).SellingPrice, '.'));
      SQL.Add(' FROM EstimatedItem (NOLOCK) WHERE IDEstimated = ' + quEstimatedIDEstimated.AsString + ')');
      ExecSQL;
    end;
  end;
end;

procedure TFrmEstimated.btPOItemPreviewClick(Sender: TObject);
begin
  inherited;
  gridPrinterLink.Caption := Self.Caption;
  gridPrinter.Preview(True, nil);
end;

procedure TFrmEstimated.btGroupClick(Sender: TObject);
begin
  inherited;
  if btGroup.Down then
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True
  else
  begin
    with grdEstItems do
      begin
        // Retiro todos os grupos
        while TcxGridDBTableView(AView).GroupedItemCount > 0 do
          TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
        TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
      end;
  end;
end;

procedure TFrmEstimated.btCustomizeColumnsClick(Sender: TObject);
begin
  inherited;
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmEstimated.btOpenEstimatedClick(Sender: TObject);
begin
  inherited;
  with TFrmEstimatedNew.Create(Self) do
    if Start(quEstimated, False) then
    begin
      RefreshEstimated;
      quEstimated.Last;
    end;
end;

procedure TFrmEstimated.quEstimatedAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btOpenEstimated.Enabled := not quEstimated.IsEmpty;
  btRemoveEst.Enabled     := btOpenEstimated.Enabled;
  btnCreateHold.Enabled   := btOpenEstimated.Enabled;
  btnConfirm.Enabled      := btOpenEstimated.Enabled;
end;

procedure TFrmEstimated.grdEstimatedDBDblClick(Sender: TObject);
begin
  inherited;
  btOpenEstimatedClick(Sender);
end;

procedure TFrmEstimated.btnCreateHoldClick(Sender: TObject);
var
  IDPreSale, IDMedia: Integer;
  fUpdate : Boolean;
begin
  inherited;

  if (not Password.HasFuncRight(84)) then
  begin
    MsgBox(MSG_CRT_BUDGET_NO_CONVERT, vbOKOnly + vbInformation);
  end
  else
  begin

    if fConfirmEst and (not quEstimatedConfirmed.AsBoolean) then
    begin
      MsgBox(MSG_CRT_NO_CONFIRMED_ESTIMATED, vbCritical + vbOkOnly);
      Exit;
    end;

    if fAutoUpdatePrice then
      fUpdate := True
    else
      fUpdate := chUpdatePrice.Checked;

    if quEstimated.Active and (not quEstimated.IsEmpty) then
    begin
      IDPreSale := DM.fPOS.ImportEstimated(quEstimatedIDEstimated.AsInteger,
                                           DM.fCashRegister.IDMedia,
                                           DM.fStore.IDStoreSale,
                                           quEstimatedIDUser.AsInteger,
                                           (DM.fSystem.SrvParam[PARAM_TAX_EXEMPT_ON_SALE]),
                                           fUpdate);

      if IDPreSale <> -1 then
      begin
        AFrmInvoice.Start(IDPreSale, SALE_CASHREG, AIDCashRegMov, True);
        btCloseClick(Sender);
      end;
    end;
  end;

end;

function TFrmEstimated.ValidadeCustomer: Boolean;
var
  PosID1, PosID2 : String;
begin

  Result := False;

  if quEstimated.Active and (not quEstimated.IsEmpty) then
  begin
  
    if (quEstimatedIDPessoa.AsInteger = 0) then
      Result := True
    else
    begin
      quCostumerFile.Parameters.ParamByName('IDPessoa').Value := quEstimatedIDPessoa.AsInteger;
      quCostumerFile.Open;
      if (quCostumerFileIDTipoPessoa.AsInteger = 10) then
      begin
        quCostumerFile.Edit;
        quCostumerFileIDTipoPessoa.AsInteger := PESSOA_TIPO_CLIENTE;
        quCostumerFile.Post;
        quCostumerFile.Close;

        with TFchPessoa.Create(Self) do
        try
          sParam := 'IDTipoPessoa=1;';
          PosID1 := quEstimatedIDPessoa.AsString;
          Result := Start(btAlt, nil, False, PosID1, PosID2, nil);
        finally
          Free;
        end;
      end
      else
        Result := True;
    end;
  end;

end;

procedure TFrmEstimated.btnConfirmClick(Sender: TObject);
var
  iID : Integer;
begin
  inherited;


  if (not Password.HasFuncRight(85)) then
  begin
    MsgBox(MSG_CRT_BUDGET_NO_CONFIRM, vbOKOnly + vbInformation);
  end
  else
  if quEstimated.Active and (not quEstimated.IsEmpty) then
    if ValidadeCustomer then
      with TFrmEstimatedInfo.Create(Self) do
        if Start(quEstimatedIDEstimated.AsInteger) then
        begin
          iID := quEstimatedIDEstimated.AsInteger;
          RefreshAll;
          DesativaAviso;
          quEstimated.Locate('IDEstimated', iID, []);
        end;

end;

procedure TFrmEstimated.UpdateConfirmedStatus;
var
  iID : Integer;
begin

  if quEstimated.Active and (not quEstimated.IsEmpty) and (quEstimatedConfirmed.AsBoolean) then
  begin
    DM.RunSQL('UPDATE Estimated SET Confirmed = 0 WHERE IDEstimated = ' + quEstimatedIDEstimated.AsString);
    iID := quEstimatedIDEstimated.AsInteger;
    RefreshEstimated;
    quEstimated.Locate('IDEstimated', iID, []);
  end;

end;

end.
