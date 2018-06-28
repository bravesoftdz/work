unit uFrmDetalheNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Provider, DBCtrls, StdCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TFrmDetalheNota = class(TForm)
    cdsNota: TClientDataSet;
    dspNota: TDataSetProvider;
    dsNota: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBText1: TDBText;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    DBText5: TDBText;
    Label6: TLabel;
    DBText6: TDBText;
    Label4: TLabel;
    DBText4: TDBText;
    Label7: TLabel;
    DBText7: TDBText;
    Label8: TLabel;
    DBText8: TDBText;
    Label9: TLabel;
    DBText9: TDBText;
    Label10: TLabel;
    DBText10: TDBText;
    Label11: TLabel;
    DBText11: TDBText;
    Label12: TLabel;
    DBText12: TDBText;
    Label13: TLabel;
    DBText13: TDBText;
    DBText14: TDBText;
    Label14: TLabel;
    DBText15: TDBText;
    Label15: TLabel;
    DBText16: TDBText;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    DBText17: TDBText;
    Label19: TLabel;
    DBText20: TDBText;
    Label20: TLabel;
    DBText21: TDBText;
    Label21: TLabel;
    DBText22: TDBText;
    Label22: TLabel;
    DBText23: TDBText;
    Label23: TLabel;
    DBText24: TDBText;
    Label24: TLabel;
    DBText25: TDBText;
    Label25: TLabel;
    DBText26: TDBText;
    DBText27: TDBText;
    Label26: TLabel;
    DBText28: TDBText;
    Label27: TLabel;
    DBText29: TDBText;
    Label17: TLabel;
    DBText18: TDBText;
    Label18: TLabel;
    DBText19: TDBText;
    Label28: TLabel;
    DBText30: TDBText;
    grdItems: TcxGrid;
    grdItemsDBTableView1: TcxGridDBTableView;
    grdItemsLevel1: TcxGridLevel;
    dspItem: TDataSetProvider;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    grdItemsDBTableView1M_Model: TcxGridDBColumn;
    grdItemsDBTableView1M_Description: TcxGridDBColumn;
    grdItemsDBTableView1IM_QTY: TcxGridDBColumn;
    grdItemsDBTableView1IM_SalePrice: TcxGridDBColumn;
    grdItemsDBTableView1U_Unidade: TcxGridDBColumn;
    grdItemsDBTableView1U_Sigla: TcxGridDBColumn;
    grdItemsDBTableView1CFOP_Number: TcxGridDBColumn;
    cdsItensIDInventoryMov: TIntegerField;
    cdsItensM_Model: TStringField;
    cdsItensM_Description: TStringField;
    cdsItensIM_QTY: TBCDField;
    cdsItensIM_SalePrice: TBCDField;
    cdsItensU_Unidade: TStringField;
    cdsItensU_Sigla: TStringField;
    cdsItensT_SituacaoTributaria: TIntegerField;
    cdsItensTaxCategoriaPer: TBCDField;
    cdsItensTaxEstadoPerc: TBCDField;
    cdsItensTaxItemPer: TBCDField;
    cdsItensEstadoCliente: TStringField;
    cdsItensEstadoLoja: TStringField;
    cdsItensMVAInterno: TBCDField;
    cdsItensMVAInterestadual: TBCDField;
    cdsItensSitTribItem: TIntegerField;
    cdsItensSitTribCategoria: TIntegerField;
    cdsItensCFOP_Number: TStringField;
    cdsItensT_Aliquota: TCurrencyField;
    GroupBox4: TGroupBox;
    Label29: TLabel;
    DBText31: TDBText;
    Label30: TLabel;
    DBText32: TDBText;
    Label31: TLabel;
    DBText33: TDBText;
    Label32: TLabel;
    DBText34: TDBText;
    Label39: TLabel;
    DBText42: TDBText;
    btEnviar: TButton;
    btFechar: TButton;
    Label33: TLabel;
    DBText35: TDBText;
    cdsItensIM_Discount: TBCDField;
    grdItemsDBTableView1IM_Discount: TcxGridDBColumn;
    grdItemsDBTableView1AliquotaDesc: TcxGridDBColumn;
    cdsItensIM_Frete: TBCDField;
    cdsItensT_AliquotaST: TBCDField;
    cdsItensTotalFrete: TBCDField;
    cdsItensM_SerialNumber: TBooleanField;
    cdsItensM_NCMCodigo: TStringField;
    cdsItensMVAPercent: TCurrencyField;
    cdsItensAliquotaDesc: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure btEnviarClick(Sender: TObject);
    procedure cdsNotaAfterOpen(DataSet: TDataSet);
  private
    FID : Integer;
    FResult : Boolean;
    procedure OpenItem;
  public
    function Start(AOrigem : String; AID : Integer; AEnviar : Boolean):Boolean;
  end;

implementation

uses udmSQL;

{$R *.dfm}

{ TFrmDetalheNota }

procedure TFrmDetalheNota.OpenItem;
begin

  with cdsItens do
  if not Active then
  begin
    FetchParams;
    Params.ParamByName(Params[0].Name).AsInteger := FID;
    Open;
  end;

end;

function TFrmDetalheNota.Start(AOrigem: String; AID: Integer;
  AEnviar : Boolean): Boolean;
begin

  btEnviar.Visible := AEnviar;
  FResult := False;

  FID := AID;
  if AOrigem = 'Venda' then
  begin
    dspNota.DataSet := dmSQL.dsInvoice;
    dspItem.DataSet := dmSQL.dsInvoiceItem;
    with cdsNota do
      if not Active then
      begin
        Params.Clear;
        FetchParams;
        Params.ParamByName('IDInvoice').Value := FID;
        Params.ParamByName('IDEmpresa').Value := dmSQL.GetIDEmpresa;
        Open;
      end;

  end
  else
  begin
    dspNota.DataSet := dmSQL.dsTransferencia;
    dspItem.DataSet := dmSQL.dsTransferenciaItem;
    with cdsNota do
      if not Active then
      begin
        Params.Clear;
        FetchParams;
        Params.ParamByName(Params[0].Name).Value := FID;
        Open;
      end;
  end;

  ShowModal;
  Result := FResult;

end;

procedure TFrmDetalheNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  with cdsNota do
    if Active then
      Close;

  with cdsItens do
    if Active then
      Close;

end;

procedure TFrmDetalheNota.FormShow(Sender: TObject);
begin
  OpenItem;
end;

procedure TFrmDetalheNota.btFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDetalheNota.btEnviarClick(Sender: TObject);
begin
  FResult := True;
  Close;
end;

procedure TFrmDetalheNota.cdsNotaAfterOpen(DataSet: TDataSet);
begin
   TFloatField(dataset.FieldByName('I_SubTotal')).DisplayFormat := '#,##0.00##';
end;

end.
