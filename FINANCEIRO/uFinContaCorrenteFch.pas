unit uFinContaCorrenteFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls,
  uParentFchTab, TeEngine, Series, TeeProcs, Chart,
  DBChart, ComCtrls, Grids, dxBar, dxDateEdit, dxDBDateEdit, dxDBGrid,
  dxGrClms, dxCntner, dxTL, ImgList, dxDBCtrl, dxDBTLCl, ADODB,
  PowerADOQuery, SuperComboADO, dxEditor, dxExEdtr, dxEdLib, dxDBELib,
  siComp, siLangRT, DateBox;

type
  TFinContaCorrenteFch = class(TParentFchTab)
    quFormIDContaCorrente: TIntegerField;
    quFormCodigoContaCorrente: TStringField;
    quFormIDEmpresa: TIntegerField;
    quFormGerente: TStringField;
    quFormDataAbertura: TDateTimeField;
    quFormOBS: TMemoField;
    quFormSystem: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormIDBanco: TIntegerField;
    quFormNumero: TStringField;
    tsCadastro: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit8: TDBEdit;
    DBSuperCombo2: TDBSuperComboADO;
    scBanco: TDBSuperComboADO;
    tsSaldo: TTabSheet;
    quSaldo: TADOQuery;
    quSaldoIDContaCorrente: TIntegerField;
    quSaldoData: TDateTimeField;
    quSaldoSaldo: TFloatField;
    pnlFiltro: TPanel;
    Label19: TLabel;
    spinDia: TEdit;
    quFormSaldoAtual: TFloatField;
    Label21: TLabel;
    DBEdit3: TDBEdit;
    dsSaldo: TDataSource;
    DBChart1: TDBChart;
    Series1: TLineSeries;
    cbValor: TCheckBox;
    grdValor: TdxDBGrid;
    grdValorData: TdxDBGridDateColumn;
    grdValorSaldo: TdxDBGridMaskColumn;
    cmbTipo: TDBComboBox;
    quFormTipo: TStringField;
    udDia: TUpDown;
    Label5: TLabel;
    Label7: TLabel;
    DBEdit4: TDBEdit;
    quFormUltimaReconciliacao: TDateTimeField;
    quFormUltimoSaldoBancario: TBCDField;
    Label14: TLabel;
    DBEdit5: TDBEdit;
    DBDateBox1: TDBDateBox;
    lbOwnNumber: TLabel;
    DBEdit6: TDBEdit;
    Label15: TLabel;
    DBEdit7: TDBEdit;
    quFormNossoNumero: TStringField;
    quFormNossoNumeroDigito: TStringField;
    quFormIDBancoAgencia: TIntegerField;
    lbBankBranch: TLabel;
    scBankAccount: TDBSuperComboADO;
    quFormCarteira: TStringField;
    lbPortfolioNum: TLabel;
    DBEdit9: TDBEdit;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure spinDiaChange(Sender: TObject);
    procedure PPageControlChange(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure cbValorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function  TestOnBeforeSave : boolean; override;

    procedure SaldoOpen;
    procedure SaldoClose;
    procedure SaldoRefresh;

  public
    { Public declarations }
  end;



implementation

uses uDM, uNumericFunctions;

{$R *.DFM}


procedure TFinContaCorrenteFch.SaldoOpen;
begin

  with quSaldo do
    if not Active then
       begin
       Parameters.ParamByName('IDContaCorrente').Value := quFormIDContaCorrente.AsInteger;
       Parameters.ParamByName('Periodo').Value := MyStrToInt(spinDia.Text);
       Open;
       end;

end;

procedure TFinContaCorrenteFch.SaldoClose;
begin

  with quSaldo do
     if Active then
        Close;

end;

procedure TFinContaCorrenteFch.SaldoRefresh;
begin

   SaldoClose;
   SaldoOpen;

end;

procedure TFinContaCorrenteFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  //quFormCodigoContaCorrente.AsString := '#Auto#';

end;

function TFinContaCorrenteFch.TestOnBeforeSave: Boolean;
begin
end;

procedure TFinContaCorrenteFch.spinDiaChange(Sender: TObject);
begin
  inherited;

  SaldoRefresh;

end;

procedure TFinContaCorrenteFch.PPageControlChange(Sender: TObject);
begin
  inherited;
  if PPageControl.ActivePage = tsSaldo then
    spinDiaChange(nil);
end;

procedure TFinContaCorrenteFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if PPageControl.ActivePage = tsSaldo then
    spinDiaChange(nil);

end;

procedure TFinContaCorrenteFch.cbValorClick(Sender: TObject);
begin
  inherited;
  grdValor.Visible := cbValor.Checked;

end;

procedure TFinContaCorrenteFch.FormShow(Sender: TObject);
begin
  inherited;
  cbValorClick(nil);
  
end;

procedure TFinContaCorrenteFch.FormCreate(Sender: TObject);
begin
  inherited;
  cmbTipo.Items := DM.GetPropertyValues('AccountTypes');

end;

procedure TFinContaCorrenteFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  SaldoClose;

end;

Initialization
  RegisterClass(TFinContaCorrenteFch);


end.
