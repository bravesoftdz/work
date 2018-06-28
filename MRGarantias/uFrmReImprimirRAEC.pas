unit uFrmReImprimirRAEC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, ADODB, Provider, DBClient, ppDB,
  ppDBPipe, ppParameter, ppStrtch, ppRichTx, ppBands, ppCtrls, jpeg,
  ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, ComCtrls,
  StdCtrls, cxButtons, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, ExtCtrls;

type
  TFrmReImprimir = class(TForm)
    pnlTop: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edtDataInicial: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    btnExec: TcxButton;
    sbMain: TStatusBar;
    pnlCentro: TPanel;
    Panel1: TPanel;
    btnImprimir: TcxButton;
    btnFechar: TcxButton;
    ppReport: TppReport;
    ppHeaderBand: TppHeaderBand;
    ppImage: TppImage;
    ppLabel: TppLabel;
    ppLabel1: TppLabel;
    ppDBText26: TppDBText;
    ppDetailBand: TppDetailBand;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLine: TppLine;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppDBText1: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppFooterBand: TppFooterBand;
    ppImage1: TppImage;
    ppLabel37: TppLabel;
    ppLabel42: TppLabel;
    ppLabel41: TppLabel;
    ppRichText1: TppRichText;
    ppImage3: TppImage;
    ppImage2: TppImage;
    ppLabel19: TppLabel;
    ppLabel43: TppLabel;
    ppParameterList1: TppParameterList;
    ppGarantias: TppDBPipeline;
    dsForm: TDataSource;
    grdGarantias: TcxGrid;
    grdGarantiasTableView: TcxGridDBTableView;
    grdGarantiasTableViewInvoiceCode: TcxGridDBColumn;
    grdGarantiasTableViewDescription: TcxGridDBColumn;
    grdGarantiasTableViewDBGarantiaMeses: TcxGridDBColumn;
    grdGarantiasTableViewQty: TcxGridDBColumn;
    grdGarantiasTableViewDBGarantiaFabrica: TcxGridDBColumn;
    grdGarantiasTableViewSalePrice: TcxGridDBColumn;
    grdGarantiasTableViewNFProduto: TcxGridDBColumn;
    grdGarantiasTableViewLookupProduct: TcxGridDBColumn;
    grdGarantiasTableViewDBColumn1: TcxGridDBColumn;
    grdGarantiasTableViewValorProduto: TcxGridDBColumn;
    grdGarantiasTableViewIDInventoryMov: TcxGridDBColumn;
    grdGarantiasTableViewIDInvoice: TcxGridDBColumn;
    grdGarantiasTableViewModel: TcxGridDBColumn;
    grdGarantiasTableViewStoreID: TcxGridDBColumn;
    grdGarantiasTableViewDiscount: TcxGridDBColumn;
    grdGarantiasTableViewMovDate: TcxGridDBColumn;
    grdGarantiasLevel: TcxGridLevel;
    grdGarantiasTableViewCheck: TcxGridDBColumn;
    cdsForm: TClientDataSet;
    cdsFormMovDate: TDateTimeField;
    cdsFormStoreID: TIntegerField;
    cdsFormSequencyNum: TIntegerField;
    cdsFormSalePrice: TBCDField;
    cdsFormQty: TFloatField;
    cdsFormIDPreInvMovExchange: TIntegerField;
    cdsFormModel: TStringField;
    cdsFormDescription: TStringField;
    cdsFormFabricante: TStringField;
    cdsFormSerialNumber: TStringField;
    cdsFormValorProduto: TBCDField;
    cdsFormGarantiaTipo: TStringField;
    cdsFormGarantiaMeses: TIntegerField;
    cdsFormGarantiaFabrica: TIntegerField;
    cdsFormDescProduto: TStringField;
    cdsFormDocumento: TStringField;
    cdsFormFormaPagamento: TStringField;
    cdsFormInicioVigencia: TDateTimeField;
    cdsFormTerminoVigencia: TDateTimeField;
    cdsFormLoja: TStringField;
    cdsFormNome: TStringField;
    cdsFormEndereco: TStringField;
    cdsFormBairro: TStringField;
    cdsFormCEP: TStringField;
    cdsFormCidade: TStringField;
    cdsFormUF: TStringField;
    cdsFormCidadeUFCEP: TStringField;
    cdsFormDataNascimento: TDateTimeField;
    cdsFormCPF: TStringField;
    cdsFormIdentidade: TStringField;
    cdsFormIdentidadeOrgaoEmissor: TStringField;
    cdsFormIdentidadeDataExpedicao: TDateTimeField;
    cdsFormIdentidadeExpedicaoOrgao: TStringField;
    cdsFormTelefone: TStringField;
    cdsFormCelular: TStringField;
    cdsFormSaleCode: TStringField;
    cdsFormInvoiceCode: TStringField;
    cdsFormIDInvoice: TIntegerField;
    cdsFormIDPreSaleParent: TIntegerField;
    cdsFormNotaFiscalProduto: TStringField;
    cdsFormDataEnvio: TDateTimeField;
    cdsFormIDModelGarantia: TIntegerField;
    cdsFormIDModel: TIntegerField;
    cdsFormChecado: TBooleanField;
    grdGarantiasTableViewDataEnvio: TcxGridDBColumn;
    procedure btnExecClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);

    function RetornaChecado: Boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReImprimir: TFrmReImprimir;

implementation

uses ppTypes, DateUtils;

{$R *.dfm}

procedure TFrmReImprimir.btnExecClick(Sender: TObject);
begin

  if not FileExists(ChangeFileExt((Application.ExeName), '.xml')) then
    MessageDlg('Erro ao abrir arquivo'+#13+'Arquivo não foi gerado.', mtWarning, [mbOK],0)
  else
  begin
    with cdsForm do
    begin
      if not Active then
        LoadFromFile(ChangeFileExt((Application.ExeName), '.xml'));
      Filtered := False;
      Filter := 'MovDate >= ' + QuotedStr(edtDataInicial.Text) + 'AND MovDate <= ' + QuotedStr(edtDataFinal.Text);
      Filtered := True;
      sbMain.Panels[0].Text := 'Total de ' + IntToStr(cdsForm.RecordCount) + ' Garantias.';
    end;
  end;
end;

procedure TFrmReImprimir.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmReImprimir.btnImprimirClick(Sender: TObject);
begin
  if not RetornaChecado then
    MessageDlg('Favor selecionar a(s) Garantia(s) a ser(em) impressa(s) ', mtWarning, [mbOK],0)
  else
  begin
    with cdsForm do
    begin
      First;
      while not Eof do
      begin
        if cdsFormChecado.AsBoolean then
        begin
          ppReport.DeviceType := dtScreen;
          ppReport.Print;
        end;
      Next;
      end;
    end;
  end;
end;

function TFrmReImprimir.RetornaChecado: Boolean;
begin
  Result := False;

  with cdsForm do
  begin
    First;
    while not Eof do
    begin
      if cdsFormChecado.AsBoolean then
        Result := True;
      Next;
    end;
  end;
end;

procedure TFrmReImprimir.FormShow(Sender: TObject);
begin
  edtDataInicial.Date := EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edtDataFinal.Date := EncodeDate(YearOf(Now), MonthOf(Now), DaysInMonth(Now));
end;

end.
