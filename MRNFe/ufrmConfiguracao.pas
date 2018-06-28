unit ufrmConfiguracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, SuperComboADO, ComCtrls;

type
  TfrmConfiguracao = class(TForm)
    GroupBox4: TGroupBox;
    Label6: TLabel;
    cbUF: TComboBox;
    rgTipoAmb: TRadioGroup;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    sbtnLogoMarca: TSpeedButton;
    edtLogoMarca: TEdit;
    rgTipoDanfe: TRadioGroup;
    rgFormaEmissao: TRadioGroup;
    GroupBox2: TGroupBox;
    Label25: TLabel;
    sbtnGetCert: TSpeedButton;
    edtNumSerie: TEdit;
    btSalvar: TButton;
    btCancelar: TButton;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    edtEmail: TEdit;
    Label2: TLabel;
    edtWeb: TEdit;
    rgMainRetail: TGroupBox;
    ckValorAdicional: TCheckBox;
    scEmpresa: TSuperComboADO;
    Label3: TLabel;
    chkDescontoItem: TCheckBox;
    Label4: TLabel;
    edtDecimal: TEdit;
    udDecimal: TUpDown;
    Label5: TLabel;
    edtNumCopia: TEdit;
    udNumCopia: TUpDown;
    procedure btSalvarClick(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ReadConfig;
    procedure WriteConfig;
  public
    { Public declarations }
    procedure Start;
  end;

implementation

uses IniFiles, udmNFe, ACBrNFeConfiguracoes, udmSQL;

{$R *.dfm}

{ TForm1 }

procedure TfrmConfiguracao.Start;
begin
  ReadConfig;
  ShowModal;
  dmNFe.ReadConfig;
end;

procedure TfrmConfiguracao.btSalvarClick(Sender: TObject);
begin
  WriteConfig;
  Close;
end;

procedure TfrmConfiguracao.ReadConfig;
begin
  with TIniFile.Create( ChangeFileExt( ParamStr(0), '.ini') ) do
  try
    edtNumSerie.Text         := ReadString( 'Certificado','NumSerie','') ;
    rgFormaEmissao.ItemIndex := ReadInteger( 'Geral','FormaEmissao',0) ;
    cbUF.ItemIndex           := cbUF.Items.IndexOf(ReadString( 'WebService','UF','RJ')) ;
    rgTipoAmb.ItemIndex      := ReadInteger( 'WebService','Ambiente', 0) ;
    rgTipoDanfe.ItemIndex    := ReadInteger( 'Geral','DANFE', 0) ;
    edtLogoMarca.Text        := ReadString( 'Geral','LogoMarca','');
    edtWeb.Text              := ReadString( 'Empresa','Website','');
    edtEmail.Text            := ReadString( 'Empresa','Email','');
    ckValorAdicional.Checked := ReadBool( 'MR','CalcFrete', True);
    chkDescontoItem.Checked  := ReadBool( 'MR','HideDescontoItem', False);
    scEmpresa.LookUpValue    := ReadString( 'MR','IDEmpresa','');
    udDecimal.Position       := StrToIntDef(ReadString('MR','Decimal','2'), 2);
    udNumCopia.Position       := StrToIntDef(ReadString('MR','NumCopia','1'), 1);
  finally
    Free;
  end;
end;

procedure TfrmConfiguracao.WriteConfig;
begin
  with TIniFile.Create( ChangeFileExt( ParamStr(0), '.ini') ) do
  try
      WriteString( 'Certificado','NumSerie', edtNumSerie.Text) ;
      WriteInteger( 'Geral','FormaEmissao', rgFormaEmissao.ItemIndex) ;
      WriteString( 'WebService','UF', cbUF.Text) ;
      WriteInteger( 'WebService','Ambiente', rgTipoAmb.ItemIndex) ;
      WriteInteger( 'Geral','DANFE', rgTipoDanfe.ItemIndex) ;
      WriteString( 'Geral','LogoMarca', edtLogoMarca.Text) ;
      WriteString( 'Empresa', 'Website', edtWeb.Text) ;
      WriteString( 'Empresa', 'Email', edtEmail.Text) ;
      WriteBool('MR', 'CalcFrete', ckValorAdicional.Checked);
      WriteBool('MR', 'HideDescontoItem', chkDescontoItem.Checked);
      WriteString('MR','IDEmpresa', scEmpresa.LookUpValue) ;
      WriteInteger('MR','Decimal', udDecimal.Position) ;
      WriteInteger('MR','NumCopia', udNumCopia.Position) ;
  finally
    Free;
  end;
end;

procedure TfrmConfiguracao.sbtnGetCertClick(Sender: TObject);
begin
  edtNumSerie.Text := dmNFe.ACBrNFe.Configuracoes.Certificados.SelecionarCertificado;
end;

procedure TfrmConfiguracao.sbtnLogoMarcaClick(Sender: TObject);
begin
  with OpenDialog do begin
    Title := 'Selecione o Logo';
    DefaultExt := '*.bmp';
    Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
    InitialDir := ExtractFileDir(application.ExeName);
    if Execute then
    begin
      edtLogoMarca.Text := FileName;
    end;
  end;
end;

procedure TfrmConfiguracao.btCancelarClick(Sender: TObject);
begin
  Close;
end;

end.








