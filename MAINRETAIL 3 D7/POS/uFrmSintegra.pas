unit uFrmSintegra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, IniFiles;

const
  SINTEGRA_CONFIG = 'Sintegra.ini';

type
  TFrmSintegra = class(TFrmPai)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    txtRazaoSocial: TEdit;
    txtNumero: TEdit;
    txtEndereco: TEdit;
    txtComplemento: TEdit;
    txtBairro: TEdit;
    txtCidade: TEdit;
    txtCEP: TEdit;
    txtTelefone: TEdit;
    txtDDDTelefone: TEdit;
    txtDDDFax: TEdit;
    txtFax: TEdit;
    txtContato: TEdit;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    txtMes: TEdit;
    txtAno: TEdit;
    GroupBox3: TGroupBox;
    check60M: TCheckBox;
    check60A: TCheckBox;
    check60D: TCheckBox;
    check75: TCheckBox;
    check60R: TCheckBox;
    check60I: TCheckBox;
    btnGerar: TButton;
    chekTodos: TCheckBox;
    Label13: TLabel;
    edtCodConvenio: TEdit;
    Label14: TLabel;
    edtCodNatureza: TEdit;
    Label16: TLabel;
    edtCodFinalidade: TEdit;
    Label17: TLabel;
    edtEstado: TEdit;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chekTodosClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    FSintegraFile: TIniFile;
    function GerarSintegra : Boolean;
    procedure LoadValues;
    procedure SaveValues;
  public
    function Start : Boolean;
  end;

implementation

uses uDM, uDateTimeFunctions, DateUtils;

{$R *.dfm}

{ TFrmSintegra }

function TFrmSintegra.GerarSintegra: Boolean;
var
  iRelatorios: Integer;
  sArquivo : String;
  sDataIni, sDataFim : String;
  bResult : Boolean;
  sRetorno : String;
begin

  // Verifica quais registros serão gerados no relatorio
  iRelatorios := 0;
  if Check60M.Checked = True then iRelatorios := iRelatorios + 1;
  if Check60A.Checked = True then iRelatorios := iRelatorios + 2;
  if Check60D.Checked = True then iRelatorios := iRelatorios + 4;
  if Check60I.Checked = True then iRelatorios := iRelatorios + 8;
  if Check60R.Checked = True then iRelatorios := iRelatorios + 16;
  if Check75.Checked  = True then iRelatorios := iRelatorios + 32;

  sArquivo := 'SINTEGRA.TXT';

  sDataIni := FormatDateTime('dd/mm/yyyy', BuildDate('01', txtMes.Text, txtAno.Text));
  sDataFim := FormatDateTime('dd/mm/yyyy', AddMonth(BuildDate('01', txtMes.Text, txtAno.Text)));

  if (((DM.fPrintReceipt.ECFPrinterName = 'BematechMP40') or (DM.fPrintReceipt.ECFPrinterName = 'BematechMP20'))
     or (chekTodos.Checked and (DM.fPrintReceipt.ECFPrinterName = 'Daruma')) ) then
  begin
    bResult := DM.EFiscal1.SintegraGerarRegistros(sDataIni,
                                       sDataFim,
                                       edtEstado.Text,
                                       txtDDDFax.Text + txtFax.Text,
                                       edtCodConvenio.Text,
                                       edtCodNatureza.Text,
                                       edtCodFinalidade.Text,
                                       txtEndereco.Text,
                                       txtNumero.Text,
                                       txtComplemento.Text,
                                       txtBairro.Text,
                                       txtCEP.Text,
                                       txtContato.Text,
                                       txtDDDTelefone.Text + txtTelefone.Text,
                                       sArquivo,
                                       txtMes.Text,
                                       txtAno.Text,
                                       txtRazaoSocial.Text,
                                       txtCidade.Text,
                                       iRelatorios);
  end else
  begin
    if Check60M.Checked then bResult := DM.EFiscal1.SintegraGerarRegistro60M(sDataIni, sDataFim, sRetorno);
    if Check60A.Checked then bResult := DM.EFiscal1.SintegraGerarRegistro60A(sDataIni, sDataFim, sRetorno);
    if Check60D.Checked then bResult := DM.EFiscal1.SintegraGerarRegistro60D(sDataIni, sDataFim, sRetorno);
    if Check60I.Checked then bResult := DM.EFiscal1.SintegraGerarRegistro60I(sDataIni, sDataFim, sRetorno);
    if Check60R.Checked then bResult := DM.EFiscal1.SintegraGerarRegistro60R(sDataIni, sDataFim, sRetorno);
  end;


end;

procedure TFrmSintegra.LoadValues;
begin

  txtRazaoSocial.Text   := FSintegraFile.ReadString('Info','RazaoSocial', '');
  txtEndereco.Text      := FSintegraFile.ReadString('Info','Endereco', '');
  txtNumero.Text        := FSintegraFile.ReadString('Info','Numero', '');
  txtComplemento.Text   := FSintegraFile.ReadString('Info','Complemento', '');
  txtBairro.Text        := FSintegraFile.ReadString('Info','Bairro', '');
  txtCidade.Text        := FSintegraFile.ReadString('Info','Cidade', '');
  txtCEP.Text           := FSintegraFile.ReadString('Info','CEP', '');
  txtDDDTelefone.Text   := FSintegraFile.ReadString('Info','DDDTel', '');
  txtTelefone.Text      := FSintegraFile.ReadString('Info','Tel', '');
  txtDDDFax.Text        := FSintegraFile.ReadString('Info','DDDFax', '');
  txtFax.Text           := FSintegraFile.ReadString('Info','Fax', '');
  txtContato.Text       := FSintegraFile.ReadString('Info','Contato', '');
  edtCodConvenio.Text   := FSintegraFile.ReadString('Info','CodConvenio', '');
  edtCodNatureza.Text   := FSintegraFile.ReadString('Info','CodNatureza', '');
  edtCodFinalidade.Text := FSintegraFile.ReadString('Info','CodFinalidade', '');
  edtEstado.Text        := FSintegraFile.ReadString('Info','Estado', '');

  txtMes.Text           := IntToStr(MonthOf((InicioDoMes(Now)-1)));
  txtAno.Text           := IntToStr(YearOf((InicioDoMes(Now)-1)));

end;

function TFrmSintegra.Start: Boolean;
begin
  LoadValues;
  ShowModal;
  Result := True;
end;

procedure TFrmSintegra.btnGerarClick(Sender: TObject);
begin
  inherited;
  try
    Cursor := crHourGlass;
    SaveValues;
    GerarSintegra;
  finally
    Cursor := crDefault;
  end;
end;

procedure TFrmSintegra.FormCreate(Sender: TObject);
begin
  inherited;
  FSintegraFile := TIniFile.Create(DM.LocalPath + SINTEGRA_CONFIG);
end;

procedure TFrmSintegra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(FSintegraFile);
  inherited;
end;

procedure TFrmSintegra.SaveValues;
begin

  FSintegraFile.WriteString('Info','RazaoSocial', txtRazaoSocial.Text);
  FSintegraFile.WriteString('Info','Endereco', txtEndereco.Text);
  FSintegraFile.WriteString('Info','Numero', txtNumero.Text);
  FSintegraFile.WriteString('Info','Complemento', txtComplemento.Text);
  FSintegraFile.WriteString('Info','Bairro', txtBairro.Text);
  FSintegraFile.WriteString('Info','Cidade', txtCidade.Text);
  FSintegraFile.WriteString('Info','CEP', txtCEP.Text);
  FSintegraFile.WriteString('Info','DDDTel', txtDDDTelefone.Text);
  FSintegraFile.WriteString('Info','Tel', txtTelefone.Text);
  FSintegraFile.WriteString('Info','DDDFax', txtDDDFax.Text);
  FSintegraFile.WriteString('Info','Fax', txtFax.Text);
  FSintegraFile.WriteString('Info','Contato', txtContato.Text);
  FSintegraFile.WriteString('Info','CodConvenio', edtCodConvenio.Text);
  FSintegraFile.WriteString('Info','CodNatureza', edtCodNatureza.Text);
  FSintegraFile.WriteString('Info','CodFinalidade', edtCodFinalidade.Text);
  FSintegraFile.WriteString('Info','Estado', edtEstado.Text);

end;

procedure TFrmSintegra.chekTodosClick(Sender: TObject);
begin
  inherited;

  Check60M.Checked := chekTodos.Checked;
  Check60A.Checked := chekTodos.Checked;
  Check60D.Checked := chekTodos.Checked;
  Check60I.Checked := chekTodos.Checked;
  Check60R.Checked := chekTodos.Checked;
  Check75.Checked  := chekTodos.Checked;

end;

procedure TFrmSintegra.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
