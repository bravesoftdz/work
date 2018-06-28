unit uBrwCashRegMov;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask, PanelRights, Menus, BrowseConfig, DateBox,
  ImgList, ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu,
  SuperComboADO, uSystemTypes;

type
  TbrwCashRegMov = class(TbrwParent)
    quBrowseIDCashRegMov: TIntegerField;
    quBrowseSystemUser: TStringField;
    quBrowseOpenTime: TDateTimeField;
    quBrowseCashRegStatus: TStringField;
    quBrowseCashRegister: TStringField;
    btInvoice: TSpeedButton;
    quBrowseTotalSales: TFloatField;
    quBrowseTotalDeposit: TFloatField;
    quBrowseDifference: TFloatField;
    pnlTotals: TPanel;
    btTotals: TSpeedButton;
    btManage: TSpeedButton;
    quBrowseIDCashRegStatus: TIntegerField;
    Panel4: TPanel;
    grdBrowseDBIDCashRegMov: TcxGridDBColumn;
    grdBrowseDBOpenTime: TcxGridDBColumn;
    grdBrowseDBCashRegister: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    grdBrowseDBCashRegStatus: TcxGridDBColumn;
    grdBrowseDBTotalSales: TcxGridDBColumn;
    grdBrowseDBTotalDeposit: TcxGridDBColumn;
    grdBrowseDBDifference: TcxGridDBColumn;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    lbCashRegister: TLabel;
    scCashRegister: TSuperComboADO;
    btCashRegisaterAll: TButton;
    btnPrintOffice: TSpeedButton;
    quBrowseIDCashRegister: TIntegerField;
    quBrowseTotalPetty: TBCDField;
    grdBrowseDBTotalPetty: TcxGridDBColumn;
    quBrowseTotalPayIn: TBCDField;
    grdBrowseDBTotalPayIn: TcxGridDBColumn;
    cbStores: TComboBox;
    btnAllStore: TButton;
    labStores: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btInvoiceClick(Sender: TObject);
    procedure btTotalsClick(Sender: TObject);
    procedure dsBrowseDataChange(Sender: TObject; Field: TField);
//MR-57    procedure btManageClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure btCashRegisaterAllClick(Sender: TObject);
    procedure btnPrintOfficeClick(Sender: TObject);
  protected
    procedure OnBeforeCommandClick(pCommand : TBtnCommandType); override;
    procedure OnAfterCommandClick(pCommand : TBtnCommandType); override;
  private
    FSubMenuName : String;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uDM, uFchCashRegMov, uBrwInvoice, uCashRegTotal, uCashRegManager, uMsgBox,
     uMsgConstant, uNumericFunctions, uDateTimeFunctions, uDMGlobal, uSystemConst,
     PaiDeTodos, uPassword, uCashRegClose;

procedure TbrwCashRegMov.FormCreate(Sender: TObject);
begin
  inherited;

  brwForm := TFchCashRegMov.Create(Self);

  btnPrintOffice.Visible := (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE);

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  (* MR-57
  if fIsRestricForm then
     begin
     btManage.Visible := False;
     end;
  *)
end;

procedure TbrwCashRegMov.FormShow(Sender: TObject);
begin
  inherited;
  
  DateInicio.Date := Date;
  DateFim.Date := Date;
  scCashRegister.LookUpValue := IntToStr(DM.fCashRegister.IDDefault);
  scCashRegister.Enabled     := Password.HasFuncRight(62);
  btCashRegisaterAll.Visible := scCashRegister.Enabled;

  grdBrowse.SetFocus;

  //Make Btn Add invisible
  btAdd.Enabled    := False;
  btAdd.Visible    := False;
  btRemove.Visible := False;
  btRemove.Enabled := False;

  FSubMenuName := DM.fMainMenu.SubMenuName;
  
end;

procedure TbrwCashRegMov.btInvoiceClick(Sender: TObject);
var
  sSubMenuName: String;
begin
  inherited;
  // chama browse de invoice
  with TBrwInvoice.Create(self) do
    try
      aWhereBasicFilters[1]    := 'CashRegMovID = ' + quBrowseIDCashRegMov.AsString;
      aWhereBasicFilters[5]    := 'IsNull(I.Canceled, 0) = 0';
      sSubMenuName                := DM.fMainMenu.SubMenuName;
      DM.fMainMenu.SubMenuName := quBrowseCashRegister.AsString;
      StartCashRegMov;
    finally
      DM.fMainMenu.SubMenuName := sSubMenuName;
    end;
end;

procedure TbrwCashRegMov.btTotalsClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  with TCashRegTotal.Create(Self) do
    Start(Trunc(DateInicio.Date), Trunc(DateFim.Date));
end;


procedure TbrwCashRegMov.dsBrowseDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btInvoice.Enabled := not (quBrowse.eof and quBrowse.Bof);
// MR-57  btManage.Enabled  := btInvoice.Enabled;
end;

(* MR-57
procedure TbrwCashRegMov.btManageClick(Sender: TObject);
var
  OldPos : integer;
begin
  inherited;
  if quBrowseIDCashRegStatus.AsInteger = ST_CASHREG_CONF then
  begin
    MsgBox(MSG_INF_NOT_MANAGE_CR, vbOKOnly + vbInformation);
    Exit;
  end;

  with TCashRegManager.Create(Self) do
    Start(quBrowseIDCashRegMov.AsInteger, quBrowseIDCashRegister.AsInteger,
          DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE], False);

  with quBrowse do
  begin
    OldPos := quBrowseIDCashRegMov.AsInteger;
    DisableControls;
    Close;
    Open;
    Locate('IDCashRegMov', OldPos, []);
    EnableControls;
  end;
end;
*)

procedure TbrwCashRegMov.btnExecClick(Sender: TObject);
begin
  inherited;
  if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
  begin
    aWhereBasicFilters[0] := 'OpenTime >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                             'OpenTime < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);

    if scCashRegister.LookUpValue <> '' then
       aWhereBasicFilters[1] := 'CashRegister.IDCashRegister = ' + scCashRegister.LookUpValue
    else
       aWhereBasicFilters[1] := '';

    ExecBrowseSQL(True);
  end;
  DesativaAviso;
end;

procedure TbrwCashRegMov.DateInicioChange(Sender: TObject);
begin
  inherited;

  //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
     AtivaAviso;

end;

procedure TbrwCashRegMov.btCashRegisaterAllClick(Sender: TObject);
begin
  inherited;
  scCashRegister.LookUpValue := '';
  scCashRegister.Text := '<'+btCashRegisaterAll.Caption+'>';   
end;

procedure TbrwCashRegMov.btnPrintOfficeClick(Sender: TObject);
begin
  inherited;

  if (quBrowse.Active) and (quBrowseIDCashRegMov.AsInteger <> 0) then
    with TCashRegClose.Create(Self) do
       RePrintOffice(quBrowseIDCashRegMov.AsInteger,
                     DM.fStore.ID,
                     quBrowseOpenTime.AsDateTime);
                     
end;

procedure TbrwCashRegMov.OnBeforeCommandClick(pCommand: TBtnCommandType);
begin
  inherited;
  if (quBrowse.Active) then
  begin
    FSubMenuName := DM.fMainMenu.SubMenuName;
    DM.fMainMenu.SubMenuName := quBrowseCashRegister.AsString;
  end;
end;

procedure TbrwCashRegMov.OnAfterCommandClick(pCommand: TBtnCommandType);
begin
  inherited;
  DM.fMainMenu.SubMenuName := FSubMenuName;
end;

end.
