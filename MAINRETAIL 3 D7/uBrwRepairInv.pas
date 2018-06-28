unit uBrwRepairInv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables,  Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB,
  RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwRepairInv = class(TbrwParent)
    Shape2: TShape;
    Label5: TLabel;
    Shape3: TShape;
    Label6: TLabel;
    quBrowseIDRepair: TIntegerField;
    quBrowseFase: TStringField;
    quBrowseSentDate: TDateTimeField;
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowsePessoa: TStringField;
    quBrowseCost: TFloatField;
    Shape1: TShape;
    Label1: TLabel;
    quBrowseTipoRepair: TIntegerField;
    Shape4: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cbxStatus: TComboBox;
    quBrowseSerialNumber: TStringField;
    quBrowseDefect: TStringField;
    quBrowseReturnDate: TDateTimeField;
    quBrowseStore: TStringField;
    btAreaTodas: TButton;
    cmbStore: TSuperComboADO;
    Label7: TLabel;
    grdBrowseDBIDRepair: TcxGridDBColumn;
    grdBrowseDBSentDate: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBPessoa: TcxGridDBColumn;
    grdBrowseDBCost: TcxGridDBColumn;
    grdBrowseDBQty: TcxGridDBColumn;
    grdBrowseDBSerialNumber: TcxGridDBColumn;
    grdBrowseDBDefect: TcxGridDBColumn;
    grdBrowseDBReturnDate: TcxGridDBColumn;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBFase: TcxGridDBColumn;
    quBrowseQty: TFloatField;
    grdBrowseDBVendorCode: TcxGridDBColumn;
    quBrowseVendorCode: TStringField;
    quVendorCode: TADOQuery;
    quVendorCodeVendorCode: TStringField;
    quBrowseIDFornecedor: TIntegerField;
    quBrowseIDModel: TIntegerField;
    btnPrintRepair: TSpeedButton;
    Panel: TPanel;
    lbFrom: TLabel;
    Label4: TLabel;
    cbxStatusDate: TComboBox;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    lblVendor: TLabel;
    scVendor: TSuperComboADO;
    btnVendorAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cbxStatusChange(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure cmbStoreSelectItem(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure btnPrintRepairClick(Sender: TObject);
    procedure btnVendorAllClick(Sender: TObject);
  private
    function ModelVendorCode(IDModel, IDVendor : Integer) : String;
  protected
    procedure LoadImages; override;
  end;

implementation

{$R *.DFM}

uses uFchRepair, uDM, uMsgBox, uDateTimeFunctions, uMsgConstant, uDMGlobal,
  uFrmPrintRepair;


procedure TbrwRepairInv.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchRepair.Create(Self);
  TFchRepair(brwForm).Tipo := 2;

  cbxStatus.ItemIndex := 4;

  cbxStatusDate.ItemIndex := 0;

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  cmbStore.LookUpValue := intToStr(DM.fStore.ID);

end;

procedure TbrwRepairInv.cbxStatusChange(Sender: TObject);
begin
  inherited;
  //Ativa o pisca do BtnGo
  AtivaAviso;
end;

procedure TbrwRepairInv.btnExecClick(Sender: TObject);
Var
DateType : String;
begin
  inherited;
  case cbxStatus.ItemIndex of
    0: aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'In Store' + Chr(39);
    1: aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Send to Vendor' + Chr(39);
    2: aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Back from Vendor' + Chr(39);
    3: aWhereBasicFilters[0] := 'R.Fase = ' + Chr(39) + 'Credit Issued' + Chr(39) + 'AND TipoRepair = 4';
    4: aWhereBasicFilters[0] := '';
  end;

  case cbxStatusDate.ItemIndex of
    0: DateType := 'R.SentDate';
    1: DateType := 'R.ReturnDate';
  end;

  aWhereBasicFilters[1] := DateType + ' >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                           DateType + ' < '+ Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);

  if cmbStore.LookUpValue = '' then
    aWhereBasicFilters[2] := 'R.IDStore IN ('+ DM.fStore.StoreList +')'
  else
    aWhereBasicFilters[2] := 'R.IDStore = ' + cmbStore.LookUpValue;

  if scVendor.LookUpValue = '' then
    aWhereBasicFilters[3] := ''
  else
    aWhereBasicFilters[3] := 'R.IDFornecedor = ' + scVendor.LookUpValue;

  ExecBrowseSQL(True);


  //Desativa o pisca do BtnGo
  DesativaAviso;
end;

procedure TbrwRepairInv.CommandClick(Sender: TObject);
begin
  //Verificar se pode deletar o item
  if Sender = btRemove then
    if (quBrowseFase.AsString <> 'Back from Vendor') then
    begin
      MsgBox(MSG_CRT_NO_DELETE_REPAIR, vbCritical + vbOkOnly);
      Exit;
    end;

  inherited;
end;

procedure TbrwRepairInv.DateInicioChange(Sender: TObject);
begin
  inherited;

  //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
     AtivaAviso;

end;

procedure TbrwRepairInv.btAreaTodasClick(Sender: TObject);
begin
  inherited;

  cmbStore.LookUpValue  := '';
  cmbStore.Text         := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;

end;

procedure TbrwRepairInv.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwRepairInv.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;
  quBrowseVendorCode.AsString := ModelVendorCode(quBrowseIDModel.AsInteger, quBrowseIDFornecedor.AsInteger);
end;

function TbrwRepairInv.ModelVendorCode(IDModel, IDVendor: Integer): String;
begin
  Result := '';

  with quVendorCode do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := IDModel;
      Parameters.ParamByName('IDVendor').Value := IDVendor;
      Open;
      while not EOF do
      begin
        if Result = '' then
          Result := quVendorCodeVendorCode.AsString
        else
          Result := Result + '; ' + quVendorCodeVendorCode.AsString;
        Next;
      end;
      Close;
    end;
end;

procedure TbrwRepairInv.LoadImages;
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_PRINT, btnPrintRepair.Glyph);
end;

procedure TbrwRepairInv.btnPrintRepairClick(Sender: TObject);
var
  sIDRepairs: String;
begin
  inherited;
  
  if (quBrowse.Active) and (not quBrowse.IsEmpty) then
  begin
    sIDRepairs := '';

    with quBrowse do
    try
      DisableControls;
      First;
      while not Eof do
      begin
        if sIDRepairs <> '' then
          sIDRepairs := sIDRepairs + ',';
        sIDRepairs := sIDRepairs + FieldByName('IDRepair').AsString;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;

    with TFrmPrintRepair.Create(Self) do
      Start(sIDRepairs);
      
  end;
end;

procedure TbrwRepairInv.btnVendorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<' + btnVendorAll.Caption + '>';

  AtivaAviso;
end;

end.
