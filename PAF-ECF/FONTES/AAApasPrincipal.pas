unit pasPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmPrincipal = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    txtRazaoSocial: TEdit;
    Label3: TLabel;
    txtNumero: TEdit;
    txtEndereco: TEdit;
    Label2: TLabel;
    txtComplemento: TEdit;
    Label4: TLabel;
    txtBairro: TEdit;
    Label5: TLabel;
    txtCidade: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    txtCEP: TEdit;
    txtTelefone: TEdit;
    Label8: TLabel;
    txtDDDTelefone: TEdit;
    Label9: TLabel;
    txtDDDFax: TEdit;
    txtFax: TEdit;
    txtContato: TEdit;
    Label10: TLabel;
    GroupBox2: TGroupBox;
    txtMes: TEdit;
    Label11: TLabel;
    txtAno: TEdit;
    Label12: TLabel;
    GroupBox3: TGroupBox;
    check60M: TCheckBox;
    check60A: TCheckBox;
    check60D: TCheckBox;
    check75: TCheckBox;
    check60R: TCheckBox;
    check60I: TCheckBox;
    cmdGerar: TButton;
    cmdSair: TButton;
    procedure cmdGerarClick(Sender: TObject);
    procedure cmdSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

function Bematech_FI_AbrePortaSerial : Integer; StdCall; External 'BEMAFI32.DLL';
function Bematech_FI_FechaPortaSerial: Integer; StdCall; External 'BEMAFI32.DLL' Name 'Bematech_FI_FechaPortaSerial';
function Bematech_FI_RelatorioSintegraMFD( iRelatorios : Integer;
                                           cArquivo    : String;
                                           cMes        : String;
                                           cAno        : String;
                                           cRazaoSocial: String;
                                           cEndereco   : String;
                                           cNumero     : String;
                                           cComplemento: String;
                                           cBairro     : String;
                                           cCidade     : String;
                                           cCEP        : String;
                                           cTelefone   : String;
                                           cFax        : String;
                                           cContato    : String ): Integer; StdCall; External 'BEMAFI32.DLL';


{$R *.DFM}


// Botão que executa a geração do relatório para o Sintegra.
procedure TfrmPrincipal.cmdGerarClick(Sender: TObject);
var iRetorno, iRelatorios: Integer;
begin

   Screen.Cursor := crHourGlass;

   // Abre a porta serial

   iRetorno := Bematech_FI_AbrePortaSerial();
   if iRetorno <> 1 then
      begin
         Application.MessageBox( 'Ocorreu um erro na abertura da porta serial', 'Apenção', MB_IconInformation + MB_OK );
         Screen.Cursor := crDefault;
      end
   else

   // Verifica quais registros serão gerados no relatorio
   iRelatorios := 0;
   if Check60M.Checked = True then iRelatorios := iRelatorios + 1;
   if Check60A.Checked = True then iRelatorios := iRelatorios + 2;
   if Check60D.Checked = True then iRelatorios := iRelatorios + 4;
   if Check60I.Checked = True then iRelatorios := iRelatorios + 8;
   if Check60R.Checked = True then iRelatorios := iRelatorios + 16;
   if Check75.Checked  = True then iRelatorios := iRelatorios + 32;

   // Apaga o arquivo SINTEGRA.TXT se existir
   if FileExists( 'SINTEGRA.TXT' ) then
      DeleteFile( 'SINTEGRA.TXT' );

   // Chama a função da dll bemafi32 para gerar o relatorio
   iRetorno := Bematech_FI_RelatorioSintegraMFD( iRelatorios,
                                                 'SINTEGRA.TXT',
                                                 txtMes.Text,
                                                 txtAno.Text,
                                                 txtRazaoSocial.Text,
                                                 txtEndereco.Text,
                                                 txtNumero.Text,
                                                 txtComplemento.Text,
                                                 txtBairro.Text,
                                                 txtCidade.Text,
                                                 txtCEP.Text,
                                                 txtDDDTelefone.Text + txtTelefone.Text,
                                                 txtDDDFax.Text + txtFax.Text,
                                                 txtContato.Text );
    if iRetorno <> 1 Then
       Application.MessageBox( 'Ocorreu um erro na geração do relatório sintegra.', 'Atenção', + MB_IconInformation + MB_OK );

    // Abre o arquivo sintegra.txt no notepad
    if FileExists( 'SINTEGRA.TXT' ) then
       begin
          Application.MessageBox( 'Arquivo SINTEGRA.TXT, gerado com sucesso !', 'Atenção', MB_IconInformation + MB_OK );
          WinExec( pchar( 'NOTEPAD.EXE' + ' ' + ExtractFilePath( Application.ExeName ) + 'SINTEGRA.TXT' ), SW_SHOW );
       end;   

    // Fecha a porta serial
    iRetorno := Bematech_FI_FechaPortaSerial();
    If iRetorno <> 1 Then
        Application.MessageBox( 'Ocorreu um erro ao tentar fechar a porta serial.', 'Atenção', + MB_IconInformation + MB_OK );

   Screen.Cursor := crDefault;

end;

procedure TfrmPrincipal.cmdSairClick(Sender: TObject);
begin
   Application.Terminate;
   Exit;
end;

end.
