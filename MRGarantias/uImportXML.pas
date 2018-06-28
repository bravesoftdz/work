unit uImportXML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls, Buttons,
  cxControls, cxContainer, cxEdit, cxTextEdit, DBClient;

type
  TFrmImportXML = class(TForm)
    Panel1: TPanel;
    btnOk: TcxButton;
    edtCodRevendedor: TcxTextEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    OpenDialog: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    cdsLocal : TClientDataSet;
    cdsImport: TClientDataSet;

    procedure InsertLocal(cdsSource:TClientDataSet);
  public
    { Public declarations }
  end;

var
  FrmImportXML: TFrmImportXML;

implementation

uses uFrmMain, DB;

{$R *.dfm}

procedure TFrmImportXML.FormShow(Sender: TObject);
begin
  edtCodRevendedor.SetFocus;
end;

procedure TFrmImportXML.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog.Execute;
  edtCodRevendedor.Text := OpenDialog.FileName;
end;

procedure TFrmImportXML.btnOkClick(Sender: TObject);
var
  bRetorno: Boolean;
begin

  cdsLocal := TClientDataSet.Create(Self);
  cdsImport:= TClientDataSet.Create(Self);
  
  begin
    if not (edtCodRevendedor.Text = '') then
    try
      if not FileExists(ChangeFileExt((Application.ExeName), '.xml')) then
      begin
        cdsImport.LoadFromFile(edtCodRevendedor.Text);
        cdsImport.SaveToFile(ChangeFileExt((Application.ExeName), '.xml'), dfXMLUTF8);
      end
      else
      begin
        Screen.Cursor := crHourGlass;
        cdsLocal.LoadFromFile(ChangeFileExt((Application.ExeName), '.xml'));
        cdsImport.LoadFromFile(edtCodRevendedor.Text);

        cdsLocal.First;
        cdsImport.First;
        while not cdsImport.Eof do
        begin
          if cdsImport.FieldByName('Checado').AsBoolean then
            if not (cdsLocal.Locate('IDPreSale;IDModel', VarArrayOf([cdsImport.FieldByName('IDPreSale').AsInteger, cdsImport.FieldByName('IDModel').AsInteger]), [])) then
            begin
              InsertLocal(cdsLocal);
              bRetorno := True;
            end;
          cdsImport.Next;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
      cdsLocal.SaveToFile(ChangeFileExt((Application.ExeName), '.xml'), dfXMLUTF8);
      if bRetorno then
        ShowMessage('Dados importados com sucesso !!')
      else
        ShowMessage('Não houve modificação nos dados !!');
      Close;
    end
    else
      ShowMessage('Favor especificar o caminho do arquivo !!');
  end;

end;

procedure TFrmImportXML.InsertLocal(cdsSource:TClientDataSet);
begin

  with cdsSource do
  begin
    cdsSource.Append;

    cdsSource.FieldByName('MovDate').AsDateTime                   := cdsImport.FieldByName('MovDate').AsDateTime;
    cdsSource.FieldByName('StoreID').AsInteger                    := cdsImport.FieldByName('StoreID').AsInteger;
    cdsSource.FieldByName('SequencyNum').AsInteger                := cdsImport.FieldByName('SequencyNum').AsInteger;
    cdsSource.FieldByName('SalePrice').AsCurrency                 := cdsImport.FieldByName('SalePrice').AsCurrency;
    cdsSource.FieldByName('Qty').AsFloat                          := cdsImport.FieldByName('Qty').AsFloat;
    cdsSource.FieldByName('IDPreInvMovExchange').AsInteger        := cdsImport.FieldByName('IDPreInvMovExchange').AsInteger;
    cdsSource.FieldByName('Model').AsString                       := cdsImport.FieldByName('Model').AsString;
    cdsSource.FieldByName('Description').AsString                 := cdsImport.FieldByName('Description').AsString;
    cdsSource.FieldByName('Fabricante').AsString                  := cdsImport.FieldByName('Fabricante').AsString;
    cdsSource.FieldByName('SerialNumber').AsString                := cdsImport.FieldByName('SerialNumber').AsString;
    cdsSource.FieldByName('ValorProduto').AsCurrency              := cdsImport.FieldByName('ValorProduto').AsCurrency;
    cdsSource.FieldByName('GarantiaTipo').AsString                := cdsImport.FieldByName('GarantiaTipo').AsString;
    cdsSource.FieldByName('GarantiaMeses').AsInteger              := cdsImport.FieldByName('GarantiaMeses').AsInteger;
    cdsSource.FieldByName('GarantiaFabrica').AsInteger            := cdsImport.FieldByName('GarantiaFabrica').AsInteger;
    cdsSource.FieldByName('DescProduto').AsString                 := cdsImport.FieldByName('DescProduto').AsString;
    cdsSource.FieldByName('Documento').AsString                   := cdsImport.FieldByName('Documento').AsString;
    cdsSource.FieldByName('FormaPagamento').AsString              := cdsImport.FieldByName('FormaPagamento').AsString;
    cdsSource.FieldByName('InicioVigencia').AsDateTime            := cdsImport.FieldByName('InicioVigencia').AsDateTime;
    cdsSource.FieldByName('TerminoVigencia').AsDateTime           := cdsImport.FieldByName('TerminoVigencia').AsDateTime;
    cdsSource.FieldByName('Loja').AsString                        := cdsImport.FieldByName('Loja').AsString;
    cdsSource.FieldByName('Nome').AsString                        := cdsImport.FieldByName('Nome').AsString;
    cdsSource.FieldByName('Endereco').AsString                    := cdsImport.FieldByName('Endereco').AsString;
    cdsSource.FieldByName('Bairro').AsString                      := cdsImport.FieldByName('Bairro').AsString;
    cdsSource.FieldByName('CEP').AsString                         := cdsImport.FieldByName('CEP').AsString;
    cdsSource.FieldByName('Cidade').AsString                      := cdsImport.FieldByName('Cidade').AsString;
    cdsSource.FieldByName('UF').AsString                          := cdsImport.FieldByName('UF').AsString;
    cdsSource.FieldByName('CidadeUFCEP').AsString                 := cdsImport.FieldByName('CidadeUFCEP').AsString;
    cdsSource.FieldByName('DataNascimento').AsDateTime            := cdsImport.FieldByName('DataNascimento').AsDateTime;
    cdsSource.FieldByName('CPF').AsString                         := cdsImport.FieldByName('CPF').AsString;
    cdsSource.FieldByName('Identidade').AsString                  := cdsImport.FieldByName('Identidade').AsString;
    cdsSource.FieldByName('IdentidadeOrgaoEmissor').AsString      := cdsImport.FieldByName('IdentidadeOrgaoEmissor').AsString;
    cdsSource.FieldByName('IdentidadeDataExpedicao').AsDateTime   := cdsImport.FieldByName('IdentidadeDataExpedicao').AsDateTime;
    cdsSource.FieldByName('IdentidadeExpedicaoOrgao').AsString    := cdsImport.FieldByName('IdentidadeExpedicaoOrgao').AsString;
    cdsSource.FieldByName('Telefone').AsString                    := cdsImport.FieldByName('Telefone').AsString;
    cdsSource.FieldByName('Celular').AsString                     := cdsImport.FieldByName('Celular').AsString;
    cdsSource.FieldByName('SaleCode').AsString                    := cdsImport.FieldByName('SaleCode').AsString;
    cdsSource.FieldByName('InvoiceCode').AsString                 := cdsImport.FieldByName('InvoiceCode').AsString;
    cdsSource.FieldByName('IDInvoice').AsInteger                  := cdsImport.FieldByName('IDInvoice').AsInteger;
    cdsSource.FieldByName('IDPreSaleParent').AsInteger            := cdsImport.FieldByName('IDPreSaleParent').AsInteger;
    cdsSource.FieldByName('IDModel').AsInteger                    := cdsImport.FieldByName('IDModel').AsInteger;
    cdsSource.FieldByName('NotaFiscalProduto').AsString           := cdsImport.FieldByName('NotaFiscalProduto').AsString;
    cdsSource.FieldByName('IDModelGarantia').AsInteger            := cdsImport.FieldByName('IDModelGarantia').AsInteger;
    cdsSource.FieldByName('Checado').AsBoolean                    := cdsImport.FieldByName('Checado').AsBoolean;
    cdsSource.FieldByName('IDPreSale').AsInteger                  := cdsImport.FieldByName('IDPreSale').AsInteger;
    //cdsSource.FieldByName('DataEnvio').AsDateTime                 := cdsImport.FieldByName('DataEnvio').AsDateTime;

    cdsSource.Post;
  end;

end;

end.
