unit uFrmGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, DBClient, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxLookAndFeelPainters, StdCtrls, cxButtons,
  ExtCtrls, ADODB, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, ComCtrls;

type
  TFrmGeraArquivo = class(TForm)
    grdGarantias: TcxGrid;
    grdGarantiasTableView: TcxGridDBTableView;
    grdGarantiasTableViewInvoiceCode: TcxGridDBColumn;
    grdGarantiasTableViewDescription: TcxGridDBColumn;
    grdGarantiasTableViewDBGarantiaMeses: TcxGridDBColumn;
    grdGarantiasTableViewQty: TcxGridDBColumn;
    grdGarantiasTableViewDBGarantiaFabrica: TcxGridDBColumn;
    grdGarantiasTableViewSalePrice: TcxGridDBColumn;
    grdGarantiasTableViewNFProduto: TcxGridDBColumn;
    grdGarantiasTableViewDBColumn1: TcxGridDBColumn;
    grdGarantiasTableViewValorProduto: TcxGridDBColumn;
    grdGarantiasTableViewIDInventoryMov: TcxGridDBColumn;
    grdGarantiasTableViewIDInvoice: TcxGridDBColumn;
    grdGarantiasTableViewModel: TcxGridDBColumn;
    grdGarantiasTableViewStoreID: TcxGridDBColumn;
    grdGarantiasTableViewDiscount: TcxGridDBColumn;
    grdGarantiasTableViewMovDate: TcxGridDBColumn;
    grdGarantiasLevel: TcxGridLevel;
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
    cdsFormIDModel: TIntegerField;
    cdsFormNotaFiscalProduto: TStringField;
    dsForm: TDataSource;
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    quExchange: TADOQuery;
    quExchangeMovDate: TDateTimeField;
    Panel2: TPanel;
    btnFechar: TcxButton;
    btnGerarArquivo: TcxButton;
    Label3: TLabel;
    edtDataInicial: TcxDateEdit;
    Label4: TLabel;
    edtDataFinal: TcxDateEdit;
    btnGO: TcxButton;
    cdsFormDataEnvio: TDateTimeField;
    sbMain: TStatusBar;
    procedure btnGerarArquivoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnGOClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ExportaArquivo;
    function GetTransactionType: String;
  end;

implementation

uses DateUtils, Math, uFrmMain;

{$R *.dfm}

procedure TFrmGeraArquivo.btnGerarArquivoClick(Sender: TObject);
begin
  if not cdsForm.IsEmpty then
  begin
    ExportaArquivo;
    with cdsForm do
    begin
      First;
      while not Eof do
      begin
        Edit;
        FieldByName('DataEnvio').AsDateTime := Now;
        Post;
        //Next;
      end;
    end;
  end
  else
    MessageDlg('Não foi possivel fazer a exportação.'+#13+'Nenhum item para exportar.', mtWarning, [mbOK], 0);

  cdsForm.SaveToFile(ChangeFileExt((Application.ExeName), '.xml'), dfXMLUTF8);

end;

procedure TFrmGeraArquivo.ExportaArquivo;
var
  iLine, iAtiva, iCancelada, iAnulada: Integer;
  sHeader, sBody, sFooter, sTransType, sZip: String;
  tfFile: TextFile;
begin
  iAtiva := 0;
  iCancelada := 0;
  iAnulada := 0;

  if OpenDialog.Execute then
  try
    Screen.Cursor := crHourGlass;
    AssignFile(tfFile, OpenDialog.FileName);
    Rewrite(tfFile);

    iLine := 1;
    sHeader := '01';
    sHeader := sHeader + FormatFloat('000000', StrToFloat(IntToStr(iLine)));
    sHeader := sHeader + '01';
    sHeader := sHeader + FrmPrincipal.GetAppProperty('Default', 'CodigoRevendedor');
    sHeader := sHeader + FrmPrincipal.GetAppProperty('Default', 'NomeRevendedor');
    sHeader := sHeader + FormatFloat('00', MonthOf(Now)) + FormatFloat('00', YearOf(Now));
    sHeader := sHeader + StringOfChar(' ', 598);
    Writeln(tfFile, sHeader);

    with cdsForm do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        Inc(iLine);
        sBody := '02';
        sBody := sBody + FormatFloat('000000', StrToFloat(IntToStr(iLine)));
        sTransType := GetTransactionType;
        iAtiva := iAtiva + IfThen(sTransType = 'NS', 1, 0);
        iCancelada := iCancelada + IfThen(sTransType = 'XS', 1, 0);
        iAnulada := iAnulada + IfThen(sTransType = 'XX', 1, 0);
        sBody := sBody + sTransType;
        sBody := sBody + FormatFloat('0000000000', cdsFormStoreID.Value); // Código Numérico da Loja.
        sBody := sBody + FormatFloat('000000000000000', cdsFormSequencyNum.Value); //Número do Certificado.
        sBody := sBody + FormatFloat('00', MonthOf(cdsFormMovDate.AsDateTime)) + FormatFloat('00', DayOf(cdsFormMovDate.AsDateTime)) + FormatFloat('00', YearOf(cdsFormMovDate.AsDateTime)); //Data Venda Garantia.
        sBody := sBody + cdsFormNome.AsString + StringOfChar(' ', 60 - Length(cdsFormNome.AsString)); //Nome do Consumidor.
        sBody := sBody + StringOfChar(' ', 20);
        sZip := StringReplace(StringReplace(cdsFormCEP.AsString, '-', '', [rfReplaceAll]), ' ', '', [rfReplaceAll]);
        sBody := sBody + sZip + StringOfChar(' ', 10 - Length(sZip));
        sBody := sBody + cdsFormEndereco.AsString + StringOfChar(' ', 45 - Length(cdsFormEndereco.AsString));
        sBody := sBody + StringOfChar(' ', 45);
        sBody := sBody + cdsFormCidade.AsString + StringOfChar(' ', 45 - Length(cdsFormCidade.AsString));
        sBody := sBody + cdsFormUF.AsString + StringOfChar(' ', 30 - Length(cdsFormUF.AsString));
        sBody := sBody + cdsFormBairro.AsString + StringOfChar(' ', 30 - Length(cdsFormBairro.AsString));
        sBody := sBody + cdsFormModel.AsString + StringOfChar(' ', 30 - Length(cdsFormModel.AsString));
        sBody := sBody + 'Y';
        sBody := sBody + Copy(cdsFormFabricante.AsString, 1, 15) + StringOfChar(' ', 15 - Length(Copy(cdsFormFabricante.AsString, 1, 15)));
        sBody := sBody + cdsFormDescProduto.AsString + StringOfChar(' ', 80 - Length(cdsFormDescProduto.AsString));
        sBody := sBody + cdsFormSerialNumber.AsString + StringOfChar(' ', 20 - Length(cdsFormSerialNumber.AsString));
        sBody := sBody + StringReplace(FormatFloat('00000000.00', cdsFormValorProduto.AsFloat), ',', '', []);
        sBody := sBody + FormatFloat('00', MonthOf(cdsFormMovDate.AsDateTime)) + FormatFloat('00', DayOf(cdsFormMovDate.AsDateTime)) + FormatFloat('00', YearOf(cdsFormMovDate.AsDateTime));
        sBody := sBody + StringReplace(FormatFloat('00000000.00', cdsFormSalePrice.AsFloat), ',', '', []);
        sBody := sBody + '2';
        sBody := sBody + cdsFormGarantiaTipo.AsString;
        sBody := sBody + StringOfChar(' ', 30);
        sBody := sBody + cdsFormSaleCode.AsString + StringOfChar(' ', 20 - Length(cdsFormSaleCode.AsString));
        sBody := sBody + cdsFormCPF.AsString + StringOfChar(' ', 20 - Length(cdsFormCPF.AsString));
        sBody := sBody + StringOfChar('0', 48);
        sBody := sBody + FormatFloat('00', MonthOf(cdsFormDataNascimento.AsDateTime)) + FormatFloat('00', DayOf(cdsFormDataNascimento.AsDateTime)) + FormatFloat('00', YearOf(cdsFormDataNascimento.AsDateTime));
        sBody := sBody + cdsFormIdentidade.AsString + StringOfChar(' ', 15 - Length(cdsFormIdentidade.AsString));
        sBody := sBody + 'RG' + StringOfChar(' ', 8);
        sBody := sBody + FormatFloat('00', MonthOf(cdsFormIdentidadeDataExpedicao.AsDateTime)) + FormatFloat('00', DayOf(cdsFormIdentidadeDataExpedicao.AsDateTime)) + FormatFloat('00', YearOf(cdsFormIdentidadeDataExpedicao.AsDateTime));
        sBody := sBody + cdsFormIdentidadeOrgaoEmissor.AsString + StringOfChar(' ', 15 - Length(cdsFormIdentidadeOrgaoEmissor.AsString));

        Writeln(tfFile, sBody);
        Next;
      end;
      First;
      EnableControls;
    end;

    Inc(iLine);
    sFooter := '03';
    sFooter := sFooter + FormatFloat('000000', StrToFloat(IntToStr(iLine)));
    sFooter := sFooter + FormatFloat('000000', StrToFloat(IntToStr(iAtiva)));
    sFooter := sFooter + FormatFloat('000000', StrToFloat(IntToStr(iCancelada)));
    sFooter := sFooter + FormatFloat('000000', StrToFloat(IntToStr(iAnulada)));
    sFooter := sFooter + StringOfChar(' ', 628);
    Writeln(tfFile, sFooter);

    MessageDlg('Exportação concluida.', mtWarning, [mbOK], 0);

    CloseFile(tfFile);
    Screen.Cursor := crDefault;
  except
    on E:Exception do
      MessageDlg('Erro ao exportar o arquivo.', mtWarning, [mbOK], 0);
  end;
end;

function TFrmGeraArquivo.GetTransactionType: String;
begin
  if cdsFormQty.AsFloat > 0 then
    Result := 'NS'
  else
  begin
    with quExchange do
    try
      if Active then
        Close;
      Parameters.ParamByName('IDPreInvMovExchange').Value := cdsFormIDPreInvMovExchange.Value;
      Open;

      if IsEmpty then
        Result := 'XS'
      else
        if MonthOf(cdsFormMovDate.AsDateTime) = MonthOf(FieldByName('MovDate').Value) then
          Result := 'XX'
        else
          Result := 'XS';
    finally
      Close;
    end;

  end;
end;

procedure TFrmGeraArquivo.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmGeraArquivo.btnGOClick(Sender: TObject);
begin
  if not FileExists(ChangeFileExt((Application.ExeName), '.xml')) then
    MessageDlg('Erro ao abrir o arquivo.'+#13+'Arquivo não foi gerado.', mtWarning, [mbOK],0)
  else
  begin
    if not cdsForm.Active then
      cdsForm.LoadFromFile(ChangeFileExt((Application.ExeName), '.xml'));

    cdsForm.Filtered := False;
    cdsForm.Filter := 'MovDate >= ' + QuotedStr(DateToStr(edtDataInicial.Date)) + ' AND MovDate <= ' + QuotedStr(DateToStr(edtDataFinal.Date)) + ' AND DataEnvio = Null';
    cdsForm.Filtered := True;
    sbMain.Panels[0].Text := 'Total de ' + IntToStr(cdsForm.RecordCount) + ' Garantias.';
  end;
end;

procedure TFrmGeraArquivo.FormShow(Sender: TObject);
begin
  edtDataInicial.Date := EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edtDataFinal.Date := EncodeDate(YearOf(Now), MonthOf(Now), DaysInMonth(Now));
end;

end.
