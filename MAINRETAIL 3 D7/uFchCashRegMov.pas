unit uFchCashRegMov;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Grids, DBGrids, Buttons, ComCtrls,
  uFchCashRegMovConf, ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  SMDBGrid, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TFchCashRegMov = class(TbrwFrmParent)
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFormIDCashRegMov: TIntegerField;
    quFormIDCashRegister: TIntegerField;
    quFormOpenTime: TDateTimeField;
    quFormIDOpenUser: TIntegerField;
    quFormIDCashRegStatus: TIntegerField;
    quFormTotalSales: TFloatField;
    quFormTotalWidraw: TFloatField;
    quFormOpenDeposit: TFloatField;
    quFormFinalWidraw: TFloatField;
    quFormTotalPetty: TFloatField;
    quFormFinalCount: TFloatField;
    DBSuperCombo1: TDBSuperComboADO;
    Label3: TLabel;
    DBSuperCombo2: TDBSuperComboADO;
    quLogDeposit: TPowerADOQuery;
    dsLogDeposit: TDataSource;
    quLogDepositLogTime: TDateTimeField;
    quLogDepositSystemUser: TStringField;
    quLogDepositCashierDeposit: TFloatField;
    quLogDepositConferedDeposit: TFloatField;
    quLogDepositDifference: TFloatField;
    Panel8: TPanel;
    Panel9: TPanel;
    Label25: TLabel;
    DBEdit13: TDBEdit;
    quLancTotal: TADOQuery;
    dsLancTotal: TDataSource;
    lbRetirada: TLabel;
    DBEdit14: TDBEdit;
    Label30: TLabel;
    Label31: TLabel;
    DBEdit16: TDBEdit;
    Label32: TLabel;
    Shape4: TShape;
    Label33: TLabel;
    DBEdit17: TDBEdit;
    Label34: TLabel;
    Panel12: TPanel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Shape6: TShape;
    Label44: TLabel;
    Panel13: TPanel;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    quFormCalcDeposit: TFloatField;
    quFormSystemDifference: TFloatField;
    quFormManagerCount: TFloatField;
    quFormManagerDifference: TFloatField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btConf: TSpeedButton;
    quLogPetty: TADOQuery;
    dsLogPetty: TDataSource;
    quLogPettySystemUser: TStringField;
    quLogPettyLogTime: TDateTimeField;
    quLogPettyTotalCash: TFloatField;
    quLogDepositIDCashRegLog: TIntegerField;
    btCashConf: TSpeedButton;
    SpeedButton1: TSpeedButton;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    quLancTotalPre: TADOQuery;
    dsLancTotalPre: TDataSource;
    quFormFinalDifference: TFloatField;
    quLogDepositLogDocument: TStringField;
    quLancTotalPreMeioPag: TStringField;
    quLancTotalPreValor: TFloatField;
    quLancTotalMeioPag: TStringField;
    quLancTotalValor: TFloatField;
    Label11: TLabel;
    Panel5: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Shape1: TShape;
    Label9: TLabel;
    Label10: TLabel;
    Panel6: TPanel;
    DBEdit1: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    btnPrint: TSpeedButton;
    quLogDepositIDCashRegTipoLog: TIntegerField;
    quLogDepositObs: TStringField;
    quLogPettyObs: TStringField;
    grdDeposits: TcxGrid;
    grdDepositsDB: TcxGridDBTableView;
    grdDepositsLevel: TcxGridLevel;
    grdDepositsDBLogDocument: TcxGridDBColumn;
    grdDepositsDBLogTime: TcxGridDBColumn;
    grdDepositsDBSystemUser: TcxGridDBColumn;
    grdDepositsDBCashierDeposit: TcxGridDBColumn;
    grdDepositsDBConferedDeposit: TcxGridDBColumn;
    grdDepositsDBDifference: TcxGridDBColumn;
    grdDepositsDBObs: TcxGridDBColumn;
    btnOBS: TSpeedButton;
    grdPettyCashs: TcxGrid;
    grdPettyCashDB: TcxGridDBTableView;
    grdPettyCashLevel: TcxGridLevel;
    quLogPettyIDCashRegLog: TIntegerField;
    quLogPettyReason: TStringField;
    grdPettyCashDBSystemUser: TcxGridDBColumn;
    grdPettyCashDBLogTime: TcxGridDBColumn;
    grdPettyCashDBTotalCash: TcxGridDBColumn;
    grdPettyCashDBObs: TcxGridDBColumn;
    grdPettyCashDBReason: TcxGridDBColumn;
    btnPettOBS: TSpeedButton;
    grdPaymentTypes: TcxGrid;
    grdPaymentTypesDB: TcxGridDBTableView;
    grdPaymentTypesLevel: TcxGridLevel;
    grdPaymentTypesDBMeioPag: TcxGridDBColumn;
    grdPaymentTypesDBValor: TcxGridDBColumn;
    grdLancTotalPres: TcxGrid;
    grdLancTotalPresDB: TcxGridDBTableView;
    grdLancTotalPresLevel: TcxGridLevel;
    grdLancTotalPresDBMeioPag: TcxGridDBColumn;
    grdLancTotalPresDBValor: TcxGridDBColumn;
    quFormTotalDeposit: TBCDField;
    lbPettyCash: TLabel;
    DBEdit3: TDBEdit;
    Label12: TLabel;
    lbPettTotal: TLabel;
    DBEdit6: TDBEdit;
    Label13: TLabel;
    Label6: TLabel;
    DBEdit7: TDBEdit;
    Label14: TLabel;
    lbRetirada2: TLabel;
    DBEdit8: TDBEdit;
    Label17: TLabel;
    quLogDepositReason: TStringField;
    grdDepositsDBReason: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quFormCalcFields(DataSet: TDataSet);
    procedure btConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dsFormDataChange(Sender: TObject; Field: TField);
    procedure btCashConfClick(Sender: TObject);
    procedure dsLogDepositDataChange(Sender: TObject; Field: TField);
    procedure btCloseClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure quLogDepositAfterOpen(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure grdDepositDblClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnOBSClick(Sender: TObject);
    procedure btnPettOBSClick(Sender: TObject);
  private
    { Private declarations }
    sChecked,
    sUnchecked : String;
    FchCashRegMovConf : TFchCashRegMovConf;
  public
    { Public declarations }
  end;

implementation

uses uDM, uItemsCalc, uSystemTypes, uDMGlobal, uSystemConst, PaiDeTodos,
     uPrintCashReg;

{$R *.DFM}

procedure TFchCashRegMov.FormShow(Sender: TObject);
begin
  inherited;
  quLogDeposit.Open;
  quLogPetty.Open;
  quLancTotal.Open;
  quLancTotalPre.Open;
end;

procedure TFchCashRegMov.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quLogDeposit.Close;
  quLogPetty.Close;
  quLancTotal.Close;
  quLancTotalPre.Close;
end;

procedure TFchCashRegMov.quFormCalcFields(DataSet: TDataSet);
begin
  inherited;
  quFormCalcDeposit.AsFloat      := quFormTotalWidraw.AsFloat + quFormFinalWidraw.AsFloat;
  quFormSystemDifference.AsFloat := quFormCalcDeposit.AsFloat - quFormTotalSales.AsFloat + quFormTotalPetty.AsFloat - quFormTotalDeposit.AsFloat;
  quFormManagerDifference.AsFloat:= quFormManagerCount.AsFloat - quFormCalcDeposit.AsFloat;
  quFormFinalDifference.AsFloat  := quFormManagerCount.AsFloat - quFormTotalSales.AsFloat + quFormTotalPetty.AsFloat - quFormTotalDeposit.AsFloat;
end;

procedure TFchCashRegMov.btConfClick(Sender: TObject);
var
  PosID1, PosID2 : String;
  TotManager : Double;
begin
  inherited;
  if FchCashRegMovConf.Start(btAlt, quLogDeposit, False, PosID1, PosID2, nil) then
  begin
    quLogDeposit.Close;
    quLogDeposit.Open;

    // Recalcula o total do manager
    with quLogDeposit do
    begin
      TotManager := 0;
      DisableControls;
      while not eof do
      begin
        TotManager := TotManager + quLogDepositConferedDeposit.AsFloat;
        Next;
      end;
      EnableControls;
    end;

    quForm.Edit;
    quFormManagerCount.AsFloat := TotManager;
    quForm.Post;

    quLogDeposit.Locate('IDCashRegLog', PosID1, []);
  end;
end;

procedure TFchCashRegMov.FormCreate(Sender: TObject);
begin
  inherited;
  FchCashRegMovConf := TFchCashRegMovConf.Create(self);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sChecked   := '&Checked';
           sUnchecked := '&Unchecked';
           end;

     LANG_PORTUGUESE :
           begin
           sChecked   := 'Mar&cado';
           sUnchecked := 'Desmar&cado';
           end;

     LANG_SPANISH :
           begin
           sChecked   := '&Chequeado';
           sUnchecked := 'No &Chequeado';
           end;
   end;

   if fIsRestricForm then
      begin
      btConf.Visible     := False;
      btConf.Enabled     := False;
      btCashConf.Visible := False;
      end;

end;

procedure TFchCashRegMov.FormDestroy(Sender: TObject);
begin
  inherited;
  FchCashRegMovConf.Free;
end;

procedure TFchCashRegMov.dsFormDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  if fIsRestricForm then
     Exit;

  if quFormIDCashRegStatus.AsInteger = ST_CASHREG_CLOSE then
    btCashConf.Caption := sChecked
  else if quFormIDCashRegStatus.AsInteger = ST_CASHREG_CONF then
    btCashConf.Caption := sUnchecked;

  btCashConf.Visible := (quFormIDCashRegStatus.AsInteger = ST_CASHREG_CLOSE) or
                        (quFormIDCashRegStatus.AsInteger = ST_CASHREG_CONF);
end;

procedure TFchCashRegMov.btCashConfClick(Sender: TObject);
begin
  inherited;
  quForm.Edit;

  if quFormIDCashRegStatus.AsInteger = ST_CASHREG_CLOSE then
    quFormIDCashRegStatus.AsInteger := ST_CASHREG_CONF
  else
    quFormIDCashRegStatus.AsInteger := ST_CASHREG_CLOSE;

  quForm.Post;

  if quFormIDCashRegStatus.AsInteger = ST_CASHREG_CONF then
  begin
    btCloseClick(nil);
    ModalResult := mrOK;
  end;
end;

procedure TFchCashRegMov.dsLogDepositDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btConf.Enabled   := not (quLogDeposit.EOF and quLogDeposit.Bof);
  btnPrint.Enabled := (quLogDepositIDCashRegTipoLog.AsInteger = 4);
end;

procedure TFchCashRegMov.btCloseClick(Sender: TObject);
begin
  inherited;
  FieldKey1 := quFormIDCashRegMov.AsString;
  RefreshBrowse;
end;

procedure TFchCashRegMov.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  with TFrmItemsCalc.Create(Self) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TFchCashRegMov.quLogDepositAfterOpen(DataSet: TDataSet);
var
  PossuiZero : Boolean;
begin
  // ** Verifica se há alguma conferencia pendente (igual a 0)
  // ** Se houver não habilita o Cash Conference
  PossuiZero := False;
  with quLogDeposit do
  begin
    DisableControls;
    First;
    while (not Eof) and (not PossuiZero) do
    begin
      PossuiZero := (quLogDepositConferedDeposit.AsFloat = 0)
                     and (quLogDepositCashierDeposit.AsFloat <> 0 ) ;
      Next;
    end;
    First;
    EnableControls;
  end;

  btCashConf.Enabled := not PossuiZero;
end;

procedure TFchCashRegMov.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1090);
end;

procedure TFchCashRegMov.grdDepositDblClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crHourGlass;

  if btConf.Enabled then
    btConfClick(nil);

  Screen.Cursor := crDefault;

end;

procedure TFchCashRegMov.btnPrintClick(Sender: TObject);
begin
  inherited;

  // Imprime o ticket do fechamento caixa
  if (DM.fPrintReceipt.PrintReceipt and (quLogDepositIDCashRegTipoLog.AsInteger = 4))then
    with TPrintCashReg.Create(Self) do
      Start(quLogDepositIDCashRegLog.AsInteger, TICKET_CASH_CLOSE);
      
end;

procedure TFchCashRegMov.btnOBSClick(Sender: TObject);
begin
  inherited;
  grdDepositsDB.Preview.Visible := not grdDepositsDB.Preview.Visible;
end;

procedure TFchCashRegMov.btnPettOBSClick(Sender: TObject);
begin
  inherited;
  grdPettyCashDB.Preview.Visible := not grdPettyCashDB.Preview.Visible;
end;

end.
