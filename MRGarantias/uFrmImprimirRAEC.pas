unit uFrmImprimirRAEC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, Provider, DB, DBClient, ppDB, ppDBPipe, ppParameter,
  ppStrtch, ppRichTx, ppBands, ppCtrls, jpeg, ppPrnabl, ppClass, ppCache,
  ppComm, ppRelatv, ppProd, ppReport, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, ComCtrls, StdCtrls,
  cxButtons, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, ExtCtrls;

type
  TFrmImprimirRAEC = class(TForm)
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
    dsForm: TDataSource;
    dspForm: TDataSetProvider;
    quForm: TADODataSet;
    quFormMovDate: TDateTimeField;
    quFormStoreID: TIntegerField;
    quFormSequencyNum: TIntegerField;
    quFormSalePrice: TBCDField;
    quFormQty: TFloatField;
    quFormIDPreInvMovExchange: TIntegerField;
    quFormModel: TStringField;
    quFormDescription: TStringField;
    quFormFabricante: TStringField;
    quFormSerialNumber: TStringField;
    quFormValorProduto: TBCDField;
    quFormGarantiaTipo: TStringField;
    quFormGarantiaMeses: TIntegerField;
    quFormGarantiaFabrica: TIntegerField;
    quFormDescProduto: TStringField;
    quFormDocumento: TStringField;
    quFormFormaPagamento: TStringField;
    quFormInicioVigencia: TDateTimeField;
    quFormTerminoVigencia: TDateTimeField;
    quFormLoja: TStringField;
    quFormNome: TStringField;
    quFormEndereco: TStringField;
    quFormBairro: TStringField;
    quFormCEP: TStringField;
    quFormCidade: TStringField;
    quFormUF: TStringField;
    quFormCidadeUFCEP: TStringField;
    quFormDataNascimento: TDateTimeField;
    quFormCPF: TStringField;
    i: TStringField;
    quFormIdentidadeOrgaoEmissor: TStringField;
    quFormIdentidadeDataExpedicao: TDateTimeField;
    quFormIdentidadeExpedicaoOrgao: TStringField;
    quFormTelefone: TStringField;
    quFormCelular: TStringField;
    quFormSaleCode: TStringField;
    quFormInvoiceCode: TStringField;
    quFormIDInvoice: TIntegerField;
    quFormIDPreSaleParent: TIntegerField;
    quFormNotaFiscalProduto: TStringField;
    quProduct: TADOQuery;
    quProductIDModel: TIntegerField;
    quProductDescription: TStringField;
    quProductSalePrice: TBCDField;
    dspProduct: TDataSetProvider;
    cdsProduct: TClientDataSet;
    cdsProductIDModel: TIntegerField;
    cdsProductDescription: TStringField;
    cdsProductSalePrice: TBCDField;
    dsProduct: TDataSource;
    pnlTop: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edtDataInicial: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    btnExec: TcxButton;
    sbMain: TStatusBar;
    pnlCentro: TPanel;
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
    Panel1: TPanel;
    btnImprimir: TcxButton;
    btnFechar: TcxButton;
    quFormDataEnvio: TDateTimeField;
    cdsFormDataEnvio: TDateTimeField;
    quFormIDModelGarantia: TIntegerField;
    cdsFormIDModelGarantia: TIntegerField;
    quFormIDModel: TIntegerField;
    cdsFormIDModel: TIntegerField;
    grdGarantiasTableViewCheck: TcxGridDBColumn;
    quFormChecado: TBooleanField;
    cdsFormChecado: TBooleanField;
    quFormIDPreSale: TIntegerField;
    cdsFormIDPreSale: TIntegerField;
    procedure btnExecClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsFormIDModelChange(Sender: TField);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure grdGarantiasTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
  private
    procedure GetMonth;
    procedure OpenProduct;
    procedure CloseProduct;
    procedure SetProduto(IDModel: Integer);
    procedure UpdateXML;
    procedure UpdateRecord(cdsSource: TClientDataSet);
    procedure InsertRecord(cdsSource: TClientDataSet);

    procedure GetInvoiceIDs(var AIDPreSales, AIDPreSaleParents, AIDInvoices: String);
    function RetornaChecado: Boolean;
  end;

implementation

uses ppTypes, DateUtils, uFrmMain;

{$R *.dfm}

procedure TFrmImprimirRAEC.btnExecClick(Sender: TObject);
var
  cdsVerify: TClientDataSet;
begin
  try
    Screen.Cursor := crHourGlass;
    if (edtDataInicial.Text <> '') and (edtDataFinal.Text <> '') then
    begin
      with cdsForm do
      begin
        DisableControls;
        Close;
        FetchParams;
        Params.ParamByName('DataInicial').Value := edtDataInicial.Date;
        Params.ParamByName('DataFinal').Value := edtDataFinal.Date;
        Open;
        GetMonth;
        OpenProduct;
        EnableControls;
      end;
    end
    else
      MessageDlg('É necessário o preenchimento das datas.',mtWarning, [mbOK],0);


  //Verificar se já foi impresso o que está sendo buscado acima.
  //Caso já tenha sido impresso, será deletado do cdsForm.

    cdsVerify := TClientDataSet.Create(Self);
    if FileExists(ChangeFileExt((Application.ExeName), '.xml')) then
    begin
      if not cdsVerify.Active then
        cdsVerify.LoadFromFile(ChangeFileExt((Application.ExeName), '.xml'));

      cdsVerify.Filtered := False;
      cdsVerify.Filter := 'MovDate >= ' + QuotedStr(edtDataInicial.Text) + ' AND MovDate <= ' + QuotedStr(edtDataFinal.Text);
      cdsVerify.Filtered := True;
      cdsForm.First;
      cdsVerify.First;
      while not cdsVerify.Eof do
      begin
        if cdsVerify.FieldByName('Checado').AsBoolean then
          if (cdsForm.Locate('IDPreSale;IDModel', VarArrayOf([cdsVerify.FieldByName('IDPreSale').AsInteger, cdsVerify.FieldByName('IDModel').AsInteger]), [])) then
          begin
            cdsForm.Delete;
          end;
        cdsVerify.Next;
      end;
    end;

    sbMain.Panels[0].Text := 'Total de ' + IntToStr(cdsForm.RecordCount) + ' Garantias.';
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmImprimirRAEC.GetMonth;
var
  wDay, wMonth, wYear: Word;
  sDescricao: String;
begin
  with cdsForm do
  begin
    First;
    while not Eof do
    begin
      Edit;
      sDescricao := StringReplace(FieldByName('Description').AsString, ' ', '', [rfReplaceAll]);
      DecodeDate(FieldByName('MovDate').AsDateTime, wYear, wMonth, wDay);

      if pos('+12M', sDescricao) > 0 then
      begin
        FieldByName('GarantiaTipo').AsString := '012012';
        FieldByName('GarantiaMeses').AsInteger := 12;
      end
      else if pos('+24M', sDescricao) > 0 then
      begin
        FieldByName('GarantiaTipo').AsString := '024024';
        FieldByName('GarantiaMeses').AsInteger := 24;
      end
      else if pos('+36M', sDescricao) > 0 then
      begin
        FieldByName('GarantiaTipo').AsString := '036036';
        FieldByName('GarantiaMeses').AsInteger := 36;
      end
      else if pos('+48M', sDescricao) > 0 then
      begin
        FieldByName('GarantiaTipo').AsString := '048048';
        FieldByName('GarantiaMeses').AsInteger := 48;
      end;

      IncAMonth(wYear, wMonth, wDay, FieldByName('GarantiaFabrica').AsInteger);
      FieldByName('InicioVigencia').AsDateTime := EncodeDate(wYear, wMonth, wDay);

      IncAMonth(wYear, wMonth, wDay, FieldByName('GarantiaMeses').AsInteger);
      FieldByName('TerminoVigencia').AsDateTime := EncodeDate(wYear, wMonth, wDay)-1;

      Post;
      Next;
    end;
    First;
  end;
end;

procedure TFrmImprimirRAEC.FormShow(Sender: TObject);
begin
  edtDataInicial.Date := EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edtDataFinal.Date := EncodeDate(YearOf(Now), MonthOf(Now), DaysInMonth(Now));
end;

procedure TFrmImprimirRAEC.OpenProduct;
var
  sSQL,
  sIDPreSales,
  sIDPreSaleParents,
  sIDInvoices: String;
begin
  //GetInvoiceIDs(sIDPreSales, sIDPreSaleParents, sIDInvoices);
  sIDPreSales := cdsFormIDPreSale.AsString;
  sIDPreSaleParents := cdsFormIDPreSaleParent.AsString;
  sIDInvoices := cdsFormIDInvoice.AsString;

  if (sIDInvoices <> '') or (sIDPreSaleParents <> '') then
    with quProduct do
    begin
      CloseProduct;
      sSQL := 'SELECT ' +
                  '  M.IDModel, ' +
                  '  M.Description, ' +
                  '  IM.SalePrice ' +
                  'FROM ' +
                  '  Model M ' +
                  '  JOIN InventoryMov IM ON (M.IDModel = IM.ModelID) ' +
                  'WHERE ' +
                  '  IM.InventMovTypeID = 1 ' +
                  '  AND M.GroupID <> 100 ';

      if (sIDInvoices <> '') and (sIDPreSaleParents <> '') and (sIDPreSales <> '') then
        sSQL := sSQL +
                  '  AND (IM.DocumentID in (' + sIDInvoices + ') ' +
                  '       OR IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSale in (' + sIDPreSaleParents + '))' +
                  '       OR IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSaleParent in (' + sIDPreSales + ')))'
      else if (sIDInvoices <> '') and (sIDPreSaleParents <> '') then
        sSQL := sSQL +
                  '  AND (IM.DocumentID in (' + sIDInvoices + ') ' +
                  '       OR IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSale in (' + sIDPreSaleParents + ')))'
      else if (sIDInvoices <> '') and (sIDPreSales <> '') then
        sSQL := sSQL +
                  '  AND (IM.DocumentID in (' + sIDInvoices + ') ' +
                  '       OR IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSaleParent in (' + sIDPreSales + ')))'
      else if (sIDPreSaleParents <> '') and (sIDPreSales <> '') then
        sSQL := sSQL +
                  '  AND (IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSale in (' + sIDPreSaleParents + '))' +
                  '       OR IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSaleParent in (' + sIDPreSales + ')))'
      else if sIDInvoices <> '' then
        sSQL := sSQL +
                  '  AND IM.DocumentID in (' + sIDInvoices + ')'
      else if sIDPreSales <> '' then
        sSQL := sSQL +
                  '  AND IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSaleParent in (' + sIDPreSales + '))'
      else if sIDPreSaleParents <> '' then
        sSQL := sSQL +
                  '  AND IM.DocumentID in (SELECT IDInvoice FROM Invoice WHERE IDPreSale in (' + sIDPreSaleParents + '))';

      SQL.Text := sSQL;
      cdsProduct.Open;
    end;
end;

procedure TFrmImprimirRAEC.SetProduto(IDModel: Integer);
var
  cds :TClientDataSet;
begin
  cds := TClientDataSet.Create(Self);
  cds.CloneCursor(cdsProduct, False, True);

  if cds.Locate('IDModel', IDModel, []) then
  begin
    cdsFormDescProduto.AsString    := cds.FieldByName('Description').AsString;
    cdsFormValorProduto.AsCurrency := cds.FieldByName('SalePrice').AsCurrency;
  end;
end;

procedure TFrmImprimirRAEC.cdsFormIDModelChange(Sender: TField);
begin
  if cdsForm.State in dsEditModes then
    SetProduto(cdsFormIDModel.AsInteger);
end;

procedure TFrmImprimirRAEC.CloseProduct;
begin
  with cdsProduct do
  begin
    if Active then
      Close;
  end;
end;

procedure TFrmImprimirRAEC.btnImprimirClick(Sender: TObject);
begin

  try
    Screen.Cursor := crHourGlass;

    if not RetornaChecado then
      MessageDlg('Favor selecionar a(s) Garantia(s) a ser(em) impressa(s) ', mtWarning, [mbOK],0)
    else
    begin
      UpdateXML;
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
  finally
    btnExecClick(Self);
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmImprimirRAEC.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImprimirRAEC.UpdateXML;
var
  cdsUpdate: TClientDataSet;
begin

  if not FileExists(ChangeFileExt((Application.ExeName), '.xml')) then
     cdsForm.SaveToFile(ChangeFileExt((Application.ExeName), '.xml'), dfXMLUTF8);

  cdsUpdate := TClientDataSet.Create(Self);
  cdsUpdate.LoadFromFile(ChangeFileExt((Application.ExeName), '.xml'));

  cdsForm.First;
  while not cdsForm.Eof do
  begin
    if cdsFormChecado.AsBoolean then
    begin
      if cdsUpdate.Locate('IDInvoice;IDModelGarantia', VarArrayOf([cdsFormIDInvoice.AsInteger, cdsFormIDModelGarantia.Value]),[]) then
      begin
        if cdsUpdate.FieldByName('DataEnvio').IsNull then
        begin
          UpdateRecord(cdsUpdate);
        end;
      end
      else
      begin
        InsertRecord(cdsUpdate);
      end;
    end;
    cdsForm.Next;
  end;
  cdsUpdate.SaveToFile(ChangeFileExt((Application.ExeName), '.xml'), dfXMLUTF8);

end;

procedure TFrmImprimirRAEC.InsertRecord(cdsSource: TClientDataSet);
begin
  with cdsForm do
  begin
    cdsSource.Append;

    cdsSource.FieldByName('MovDate').AsDateTime                   := cdsFormMovDate.AsDateTime;
    cdsSource.FieldByName('StoreID').AsInteger                    := cdsFormStoreID.AsInteger;
    cdsSource.FieldByName('SequencyNum').AsInteger                := cdsFormSequencyNum.AsInteger;
    cdsSource.FieldByName('SalePrice').AsCurrency                 := cdsFormSalePrice.AsCurrency;
    cdsSource.FieldByName('Qty').AsFloat                          := cdsFormQty.AsFloat;
    cdsSource.FieldByName('IDPreInvMovExchange').AsInteger        := cdsFormIDPreInvMovExchange.AsInteger;
    cdsSource.FieldByName('Model').AsString                       := cdsFormModel.AsString;
    cdsSource.FieldByName('Description').AsString                 := cdsFormDescription.AsString;
    cdsSource.FieldByName('Fabricante').AsString                  := cdsFormFabricante.AsString;
    cdsSource.FieldByName('SerialNumber').AsString                := cdsFormSerialNumber.AsString;
    cdsSource.FieldByName('ValorProduto').AsCurrency              := cdsFormValorProduto.AsCurrency;
    cdsSource.FieldByName('GarantiaTipo').AsString                := cdsFormGarantiaTipo.AsString;
    cdsSource.FieldByName('GarantiaMeses').AsInteger              := cdsFormGarantiaMeses.AsInteger;
    cdsSource.FieldByName('GarantiaFabrica').AsInteger            := cdsFormGarantiaFabrica.AsInteger;
    cdsSource.FieldByName('DescProduto').AsString                 := cdsFormDescProduto.AsString;
    cdsSource.FieldByName('Documento').AsString                   := cdsFormDocumento.AsString;
    cdsSource.FieldByName('FormaPagamento').AsString              := cdsFormFormaPagamento.AsString;
    cdsSource.FieldByName('InicioVigencia').AsDateTime            := cdsFormInicioVigencia.AsDateTime;
    cdsSource.FieldByName('TerminoVigencia').AsDateTime           := cdsFormTerminoVigencia.AsDateTime;
    cdsSource.FieldByName('Loja').AsString                        := cdsFormLoja.AsString;
    cdsSource.FieldByName('Nome').AsString                        := cdsFormNome.AsString;
    cdsSource.FieldByName('Endereco').AsString                    := cdsFormEndereco.AsString;
    cdsSource.FieldByName('Bairro').AsString                      := cdsFormBairro.AsString;
    cdsSource.FieldByName('CEP').AsString                         := cdsFormCEP.AsString;
    cdsSource.FieldByName('Cidade').AsString                      := cdsFormCidade.AsString;
    cdsSource.FieldByName('UF').AsString                          := cdsFormUF.AsString;
    cdsSource.FieldByName('CidadeUFCEP').AsString                 := cdsFormCidadeUFCEP.AsString;
    cdsSource.FieldByName('DataNascimento').AsDateTime            := cdsFormDataNascimento.AsDateTime;
    cdsSource.FieldByName('CPF').AsString                         := cdsFormCPF.AsString;
    cdsSource.FieldByName('Identidade').AsString                  := cdsFormIdentidade.AsString;
    cdsSource.FieldByName('IdentidadeOrgaoEmissor').AsString      := cdsFormIdentidadeOrgaoEmissor.AsString;
    cdsSource.FieldByName('IdentidadeDataExpedicao').AsDateTime   := cdsFormIdentidadeDataExpedicao.AsDateTime;
    cdsSource.FieldByName('IdentidadeExpedicaoOrgao').AsString    := cdsFormIdentidadeExpedicaoOrgao.AsString;
    cdsSource.FieldByName('Telefone').AsString                    := cdsFormTelefone.AsString;
    cdsSource.FieldByName('Celular').AsString                     := cdsFormCelular.AsString;
    cdsSource.FieldByName('SaleCode').AsString                    := cdsFormSaleCode.AsString;
    cdsSource.FieldByName('InvoiceCode').AsString                 := cdsFormInvoiceCode.AsString;
    cdsSource.FieldByName('IDInvoice').AsInteger                  := cdsFormIDInvoice.AsInteger;
    cdsSource.FieldByName('IDPreSaleParent').AsInteger            := cdsFormIDPreSaleParent.AsInteger;
    cdsSource.FieldByName('IDModel').AsInteger                    := cdsFormIDModel.AsInteger;
    cdsSource.FieldByName('NotaFiscalProduto').AsString           := cdsFormNotaFiscalProduto.AsString;
    cdsSource.FieldByName('IDModelGarantia').AsInteger            := cdsFormIDModelGarantia.AsInteger;
    cdsSource.FieldByName('Checado').AsBoolean                    := cdsFormChecado.AsBoolean;
//    cdsSource.FieldByName('DataEnvio').AsDateTime                 := cdsFormDataEnvio.AsDateTime;

    cdsSource.Post;
  end;
end;

procedure TFrmImprimirRAEC.UpdateRecord(cdsSource: TClientDataSet);
begin
  with cdsForm do
  begin
    cdsSource.Edit;

    cdsSource.FieldByName('TerminoVigencia').AsDateTime  := cdsFormTerminoVigencia.AsDateTime;
    cdsSource.FieldByName('InicioVigencia').AsDateTime   := cdsFormInicioVigencia.AsDateTime;
    cdsSource.FieldByName('DescProduto').AsString        := cdsFormDescProduto.AsString;
    cdsSource.FieldByName('GarantiaFabrica').AsInteger   := cdsFormGarantiaFabrica.AsInteger;
    cdsSource.FieldByName('GarantiaMeses').AsInteger     := cdsFormGarantiaMeses.AsInteger;
    cdsSource.FieldByName('GarantiaTipo').AsString       := cdsFormGarantiaTipo.AsString;
    cdsSource.FieldByName('Checado').AsBoolean           := cdsFormChecado.AsBoolean;
//    cdsSource.FieldByName('DataEnvio').AsDateTime        := cdsFormDataEnvio.AsDateTime;

    cdsSource.Post;
  end;
end;
function TFrmImprimirRAEC.RetornaChecado: Boolean;
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

procedure TFrmImprimirRAEC.GetInvoiceIDs(var AIDPreSales, AIDPreSaleParents,
  AIDInvoices: String);
begin
  AIDPreSales := '';
  AIDPreSaleParents := '';
  AIDInvoices := '';

  with cdsForm do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('IDPreSale').AsString <> '' then
      begin
        if AIDPreSales <> '' then
          AIDPreSales := AIDPreSales + ',';
        AIDPreSales := AIDPreSales + FieldByName('IDPreSale').AsString;
      end;

      if FieldByName('IDPreSaleParent').AsString <> '' then
      begin
        if AIDPreSaleParents <> '' then
          AIDPreSaleParents := AIDPreSaleParents + ',';
        AIDPreSaleParents := AIDPreSaleParents + FieldByName('IDPreSaleParent').AsString;
      end;

      if FieldByName('IDInvoice').AsString <> '' then
      begin
        if AIDInvoices <> '' then
          AIDInvoices := AIDInvoices + ',';
        AIDInvoices := AIDInvoices + FieldByName('IDInvoice').AsString;
      end;

      Next;
    end;
    First;
  end;
end;

procedure TFrmImprimirRAEC.grdGarantiasTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  OpenProduct;
end;

end.
