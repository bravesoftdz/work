unit uFrmSERASA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DateBox, Mask, SuperComboADO, OleCtrls, SHDocVw, uSerasaHTML, IniFiles;

type
  TFrmSERASA = class(TFrmParentAll)
    btnSearch: TButton;
    Panel5: TPanel;
    Panel2: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbDate: TLabel;
    lbAmount: TLabel;
    scBank: TSuperComboADO;
    EditDepositDate: TDateBox;
    edtAmount: TEdit;
    pnlCustomer: TPanel;
    shpHelp: TShape;
    lbCustomerInfo: TLabel;
    lbName: TLabel;
    lbDoc: TLabel;
    lbPhone: TLabel;
    edtName: TEdit;
    edtCustomerDocument: TEdit;
    edtPhone: TEdit;
    Panel4: TPanel;
    Shape2: TShape;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtLogin: TEdit;
    edtPw: TEdit;
    webResult: TWebBrowser;
    cmbTipoConsulta: TComboBox;
    pnlInitial: TPanel;
    edtInitialCheck: TEdit;
    edtDigitiIni: TEdit;
    pnlFinal: TPanel;
    edtFinalCheck: TEdit;
    edtDigitEnd: TEdit;
    Label8: TLabel;
    edtDDD: TEdit;
    Label9: TLabel;
    edtServer: TEdit;
    Label10: TLabel;
    edtPort: TEdit;
    Label11: TLabel;
    edtDoc: TEdit;
    Label12: TLabel;
    edtStation: TEdit;
    sbEditConnection: TSpeedButton;
    btnPrint: TButton;
    cmbOpcaoConsulta: TComboBox;
    Label13: TLabel;
    edtBranch: TEdit;
    edtAccount: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure cmbTipoConsultaChange(Sender: TObject);
    procedure edtServerChange(Sender: TObject);
    procedure sbEditConnectionClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
    FSerasa : TSerasaSearch;
    FInitialCheck, FFinalCheck : String;
    fIniFile   : TIniFile;
    fResult    : String;
    fHasChange : Boolean;
    procedure LoadSerasa;
    procedure SaveSerasa;
  public
    { Public declarations }
    function Start(CustomerName, CustomerDocument, CustomerDDD, CustomerFone, Bank,
                   InitalCheck, FinalCheck: String; Date: TDateTime; Valor: Double):String;
  end;

implementation

uses uDM, uSerasaTypes, uNumericFunctions, uEncryptFunctions, uParamFunctions;

{$R *.dfm}

{ TFrmSERASA }

function FormataFixo(Formato : String; Valor: Double;SepDec, SepMil : Char): String;
var
  OldDecimalSeparator,
  OldThousandSeparator : Char;
begin
  OldDecimalSeparator  := DecimalSeparator;
  OldThousandSeparator := ThousandSeparator;
  try
    Result := FormatFloat(Formato, Valor);
  finally
    DecimalSeparator  := OldDecimalSeparator;
    ThousandSeparator := OldThousandSeparator;
  end;
end;

function TFrmSERASA.Start(CustomerName, CustomerDocument, CustomerDDD, CustomerFone, Bank,
                   InitalCheck, FinalCheck: String; Date: TDateTime; Valor: Double):String;
begin
   edtName.Text             := CustomerName;
   edtCustomerDocument.Text := CustomerDocument;
   edtPhone.Text            := CustomerFone;
   edtDDD.Text              := CustomerDDD;

   scBank.LookUpValue       := Bank;

   edtBranch.Clear;
   edtAccount.Clear;


   edtInitialCheck.Text     := InitalCheck;
   edtFinalCheck.Text       := FinalCheck;

   FInitialCheck            := InitalCheck;
   FFinalCheck              := FinalCheck;

   EditDepositDate.Date     := Date;


   edtAmount.Text           := MyFloatToStr(Valor);

   LoadSerasa;

   fHasChange := False;

   ShowModal;

   if fHasChange then
      SaveSerasa;

   Result := '';
end;

procedure TFrmSERASA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmSERASA.FormCreate(Sender: TObject);
begin
  inherited;
  if not FileExists(DM.LocalPath+'serasa.ini') then
     FileClose(FileCreate(DM.LocalPath+'serasa.ini'));
     
  fIniFile := TIniFile.Create(DM.LocalPath+'serasa.ini');
  FSerasa  := TSerasaSearch.Create(Self);
  with FSerasa.SerasaHeader do
  begin
    MeioAcesso               := '1';
    FuncaoChamada            := '';
  end;
end;

procedure TFrmSERASA.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FSerasa) then
     FreeAndNil(FSerasa);
  if Assigned(fIniFile) then
     FreeAndNil(fIniFile);
end;

procedure TFrmSERASA.btnSearchClick(Sender: TObject);
var
  stlHTML : TstringList;
  URL:OleVariant;
begin
  {
  //SERASA teste
  FSerasa.RemoteHost := '200.245.207.155';
  FSerasa.RemotePort := '3335';
  CNPJSolicitante    := '30862262000126';
  CodigoEstacao      := '000001';
  Login              := '98039686';
  Senha              := '00001576';
  }

  FSerasa.RemoteHost := edtServer.Text;
  FSerasa.RemotePort := edtPort.Text;


  with FSerasa.SerasaHeader do
  begin
    Login                   := edtLogin.Text;
    Senha                   := edtPw.Text;
    CNPJSolicitante         := edtDoc.Text;
    CodigoEstacao           := edtStation.Text;

    DocumentoPesquisa       := StringReplace(edtCustomerDocument.Text, '-', '', [rfReplaceAll]);
    NumeroDDD               := edtDDD.Text;
    NumeroTelefone          := StringReplace(edtPhone.Text, '-', '', [rfReplaceAll]);;
    CodigoBanco             := DM.DescCodigo(['IDBanco'], [scBank.LookUpValue], 'Fin_Banco', 'CodigoBanco');
    NumeroAgencia           := Trim(edtBranch.Text);
    NumeroContaCorrente     := Trim(edtAccount.Text);
    NumeroChequeInicial     := Trim(edtInitialCheck.Text);
    DigitoChequeInicial     := edtDigitEnd.Text;
    NumeroChequeFinal       := Trim(edtFinalCheck.Text);
    DigitoChequeFinal       := edtDigitEnd.Text;
    ValorCheque             := StringReplace(FormataFixo('000000000000.00', MyStrToMoney(edtAmount.Text), ',', '.'), ',', '', [rfReplaceAll]);;
    DataVencimento          := FormatDateTime('DDMMYYYY', EditDepositDate.Date);
    CMC7Inicial             := Trim(edtInitialCheck.Text);
    CMC7Final               := Trim(edtFinalCheck.Text);
    IdentificacaoDadosCheque:= IntToStr(cmbTipoConsulta.ItemIndex + 1);
    OpcoesConsulta          := cmbOpcaoConsulta.Items[cmbOpcaoConsulta.ItemIndex];

    if Length(Trim(DocumentoPesquisa)) = 15 then
      TipoDocumentoPesquisa   := 'J'
    Else
      TipoDocumentoPesquisa   := 'F';
  end;

  FSerasa.DoSearch;
  stlHTML := TStringList.Create;
  try
    stlHTML.Text := FSerasa.LastResult;
    URL := DM.LocalPath+'serasa.htm';
    stlHTML.SaveToFile(URL);
    webResult.Navigate2(URL);
  finally
    stlHTML.Free;
  end;
end;

procedure TFrmSERASA.cmbTipoConsultaChange(Sender: TObject);
begin
  inherited;


  edtBranch.Clear;
  edtAccount.Clear;
  edtInitialCheck.Clear;
  edtFinalCheck.Clear;
  edtDigitiIni.Clear;
  edtDigitEnd.Clear;


  case cmbTipoConsulta.ItemIndex of
    0:
      begin
        edtBranch.Color       := clWindow;
        edtAccount.Color      := clWindow;
        edtInitialCheck.Color := clScrollBar;
        edtFinalCheck.Color   := clScrollBar;
        edtDigitiIni.Color    := clWindow;
        edtDigitEnd.Color     := clWindow;
        edtInitialCheck.Text  := FInitialCheck;
        edtFinalCheck.Text    := FFinalCheck;
        if edtDigitiIni.CanFocus then
          edtDigitiIni.SetFocus;
      end;
    1:
      begin
        edtInitialCheck.Color := clWindow;
        edtFinalCheck.Color   := clWindow;
        edtDigitiIni.Color    := clScrollBar;
        edtDigitEnd.Color     := clScrollBar;
        edtBranch.Color       := clScrollBar;
        edtAccount.Color      := clScrollBar;
        if edtInitialCheck.CanFocus then
          edtInitialCheck.SetFocus;
      end;
  end;

  edtInitialCheck.ReadOnly := cmbTipoConsulta.ItemIndex = 0;
  edtFinalCheck.ReadOnly   := cmbTipoConsulta.ItemIndex = 0;
  edtBranch.ReadOnly       := cmbTipoConsulta.ItemIndex = 0;
  edtAccount.ReadOnly      := cmbTipoConsulta.ItemIndex = 0;
  edtDigitiIni.ReadOnly    := cmbTipoConsulta.ItemIndex <> 0;
  edtDigitEnd.ReadOnly     := cmbTipoConsulta.ItemIndex <> 0;

end;

procedure TFrmSERASA.LoadSerasa;
begin

  fResult := fIniFile.ReadString('Settings', 'Value', '');
  if fResult = '' then
     Exit;
  fResult := DecodeServerInfo(fResult, 'Serasa', CIPHER_TEXT_STEALING, FMT_UU);

  edtServer.Text             := ParseParam(fResult, '#SRV#=');
  edtPort.Text               := ParseParam(fResult, '#PRT#=');
  edtLogin.Text              := ParseParam(fResult, '#LG#=');
  edtPw.Text                 := ParseParam(fResult, '#PW#=');
  edtDoc.Text                := ParseParam(fResult, '#DOC#=');
  edtStation.Text            := ParseParam(fResult, '#EST#=');
  if ParseParam(fResult, '#OPT#=') = '' then
    cmbOpcaoConsulta.ItemIndex := -1
  else
    cmbOpcaoConsulta.ItemIndex := StrToInt(ParseParam(fResult, '#OPT#='));
end;

procedure TFrmSERASA.SaveSerasa;
begin
  fResult := '#SRV#=' + edtServer.Text + ';' +
             '#PRT#=' + edtPort.Text   + ';' +
             '#LG#='  + edtLogin.Text  + ';' +
             '#PW#='  + edtPw.Text     + ';' +
             '#DOC#=' + edtDoc.Text    + ';' +
             '#EST#=' + edtStation.Text + ';'+
             '#OPT#='  + IntToStr(cmbOpcaoConsulta.ItemIndex) + ';';
  fResult := EncodeServerInfo(fResult, 'Serasa', CIPHER_TEXT_STEALING, FMT_UU);
  fIniFile.WriteString('Settings', 'Value', fResult);
end;

procedure TFrmSERASA.edtServerChange(Sender: TObject);
begin
  inherited;
  fHasChange := True;
end;

procedure TFrmSERASA.sbEditConnectionClick(Sender: TObject);
var
 bEnablade : Boolean;
 cColor    : TColor;
begin
  inherited;

  bEnablade := not edtServer.ReadOnly;

  if bEnablade then
     cColor := clSilver
  else
     cColor := clWhite;

  edtServer.Color          := cColor;
  edtPort.Color            := cColor;
  edtDoc.Color             := cColor;
  edtStation.Color         := cColor;
  edtLogin.Color           := cColor;
  edtPw.Color              := cColor;
  cmbOpcaoConsulta.Color   := cColor;

  edtServer.ReadOnly       := bEnablade;
  edtPort.ReadOnly         := bEnablade;
  edtDoc.ReadOnly          := bEnablade;
  edtStation.ReadOnly      := bEnablade;
  edtLogin.ReadOnly        := bEnablade;
  edtPw.ReadOnly           := bEnablade;
  cmbOpcaoConsulta.Enabled := not bEnablade;
end;

procedure TFrmSERASA.btnPrintClick(Sender: TObject);
begin
  inherited;
  //Imprimir
  webResult.ExecWB(OLECMDID_PRINT,OLECMDEXECOPT_DODEFAULT);
end;

end.

