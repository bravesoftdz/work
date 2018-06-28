unit uDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDM, Db, DBTables, uSystemTypes, uHandleError, uSystemConst,
  IniFiles, ADODB, RCADOQuery, PowerADOQuery, LookUpADOQuery;

Const
  TRIAL_LIMIT = 6000;

type

  TOMSystem = Class
    private
      fStartMode      : Char;
      fValidLicense   : Boolean;
    public
      property StartMode      : Char    read fStartMode      write fStartMode;
      property ValidLicense   : Boolean read fValidLicense   write fValidLicense;
  end;

  TDM = class(TParentDM)
    quUsuario: TLookUpADOQuery;
    dsLookUpUsuario: TDataSource;
    quEmpresa: TLookUpADOQuery;
    dsLookUpEmpresa: TDataSource;
    quEmpresaIDEmpresa: TIntegerField;
    quEmpresaCodigoEmpresa: TStringField;
    quEmpresaEmpresa: TStringField;
    dsLUContaCorrente: TDataSource;
    quContaCorrente: TLookUpADOQuery;
    quContaCorrenteIDContaCorrente: TIntegerField;
    quContaCorrenteCodigoContaCorrente: TStringField;
    dsLUQuitacaoMeio: TDataSource;
    quQuitacaoMeio: TLookUpADOQuery;
    dsLUPessoaTipo: TDataSource;
    quPessoaTipo: TLookUpADOQuery;
    dsLULancamentoTipo: TDataSource;
    quLancamentoTipo: TLookUpADOQuery;
    dsLUPessoa: TDataSource;
    quPessoa: TLookUpADOQuery;
    dsLUDocumentoTipo: TDataSource;
    quDocumentoTipo: TLookUpADOQuery;
    quDocumentoTipoIDDocumentoTipo: TIntegerField;
    quDocumentoTipoCodigoDocumentoTipo: TStringField;
    quDocumentoTipoDocumentoTipo: TStringField;
    quLancamentoTipoIDLancamentoTipo: TIntegerField;
    quLancamentoTipoLancamentoTipo: TStringField;
    quLancamentoTipoPathName: TStringField;
    quLancamentoTipoPath: TStringField;
    dsLUCentroCusto: TDataSource;
    quCentroCusto: TLookUpADOQuery;
    dsLUMoeda: TDataSource;
    quMoeda: TLookUpADOQuery;
    quMoedaIDMoeda: TIntegerField;
    quMoedaCodigoMoeda: TStringField;
    quMoedaMoeda: TStringField;
    quBanco: TLookUpADOQuery;
    dsLUBanco: TDataSource;
    quBancoIDBanco: TIntegerField;
    quBancoCodigoBanco: TStringField;
    quBancoBanco: TStringField;
    quBancoAgencia: TLookUpADOQuery;
    dsLUBancoAgencia: TDataSource;
    quBancoAgenciaIDBancoAgencia: TIntegerField;
    quBancoAgenciaCodigoBancoAgencia: TStringField;
    quBancoAgenciaBancoAgencia: TStringField;
    dsLUMenuItem: TDataSource;
    quMenuItem: TLookUpADOQuery;
    quMenuItemIDMenuItem: TIntegerField;
    quMenuItemMenu: TStringField;
    quMenuItemMenuItem: TStringField;
    dsLUDesdobramentoTipo: TDataSource;
    quDesdobramentoTipo: TLookUpADOQuery;
    quDesdobramentoTipoIDDesdobramentoTipo: TIntegerField;
    quDesdobramentoTipoIDDocumentoTipo: TIntegerField;
    quDesdobramentoTipoDesdobramentoTipo: TStringField;
    quDesdobramentoTipoCodigoDesdobramentoTipo: TStringField;
    quDesdobramentoTipoIdentificadorDesdobramento: TStringField;
    quDesdobramentoTipoHidden: TBooleanField;
    quDesdobramentoTipoSystem: TBooleanField;
    quDesdobramentoTipoDesativado: TBooleanField;
    quContaCorrenteNumero: TStringField;
    quLancamentoTipoCodigoContabil: TStringField;
    quPessoaTipoIDTipoPessoa: TIntegerField;
    quPessoaTipoTipoPessoa: TStringField;
    quPessoaTipoJuridico: TIntegerField;
    quPessoaTipoPathName: TStringField;
    quPessoaIDPessoa: TIntegerField;
    quPessoaCode: TIntegerField;
    quPessoaPessoa: TStringField;
    quPessoaDesativado: TIntegerField;
    quPessoaHidden: TIntegerField;
    quPessoaSystem: TBooleanField;
    quQuitacaoMeioIDMeioPag: TIntegerField;
    quQuitacaoMeioMeioPag: TStringField;
    quCentroCustoIDCentroCusto: TIntegerField;
    quCentroCustoCodigoCentroCusto: TStringField;
    quCentroCustoCentroCusto: TStringField;
    quLookUpStore: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    dsLookUpStore: TDataSource;
    LookUpUser: TLookUpADOQuery;
    LookUpUserIDUser: TIntegerField;
    LookUpUserSystemUser: TStringField;
    dsLookUpUser: TDataSource;
    LookUpEstado: TLookUpADOQuery;
    LookUpEstadoIDEstado: TStringField;
    LookUpEstadoEstado: TStringField;
    dsLookUpEstado: TDataSource;
    LookUpTipoPessoa: TLookUpADOQuery;
    LookUpTipoPessoaIDTipoPessoa: TIntegerField;
    LookUpTipoPessoaPathName: TStringField;
    LookUpTipoPessoaPath: TStringField;
    dsLookUpTipoPessoa: TDataSource;
    LookUpPais: TLookUpADOQuery;
    LookUpPaisIDPais: TIntegerField;
    LookUpPaisCodPais: TStringField;
    LookUpPaisPais: TStringField;
    dsLookUpPais: TDataSource;
    quLookUpMeioPagBatch: TLookUpADOQuery;
    dsLookUpMeioPagBatch: TDataSource;
    quLookUpMeioPagBatchIDMeioPag: TAutoIncField;
    quLookUpMeioPagBatchMeioPag: TStringField;
    quLookUpFornecedor: TLookUpADOQuery;
    dsLookUpFornecedor: TDataSource;
    quLookUpFornecedorIDPessoa: TAutoIncField;
    quLookUpFornecedorIDFornecedor: TAutoIncField;
    quLookUpFornecedorPessoa: TStringField;
    quLookUpFornecedorCode: TIntegerField;
    quCompany: TLookUpADOQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    dsCompany: TDataSource;
    quUsuarioIDUser: TAutoIncField;
    quUsuarioCodSystemUser: TStringField;
    quUsuarioSystemUser: TStringField;
    quUserType: TLookUpADOQuery;
    quUserTypeIDUserType: TIntegerField;
    quUserTypeName: TStringField;
    dsLookUpUserType: TDataSource;
    spGetNextID: TADOStoredProc;
    quSrvParam: TADOQuery;
    quSrvParamIDParam: TIntegerField;
    quSrvParamSrvParameter: TStringField;
    quSrvParamSrvValue: TStringField;
    quLookupSaleTax: TLookUpADOQuery;
    dsLookupSaleTax: TDataSource;
    quLookupSaleTaxIDTaxCategory: TIntegerField;
    quLookupSaleTaxTaxCategory: TStringField;
    quLookupPurchaseTax: TLookUpADOQuery;
    LookupPurchaseTax: TDataSource;
    quLookupPurchaseTaxIDTaxCategory: TIntegerField;
    quLookupPurchaseTaxTaxCategory: TStringField;
    quLookUpMunicipio: TLookUpADOQuery;
    dsLookUpMunicipio: TDataSource;
    quLookUpMunicipioIDMunicipio: TIntegerField;
    quLookUpMunicipioCodigo: TStringField;
    quLookUpMunicipioDescricao: TStringField;
    procedure DMDestroy(Sender: TObject);
    procedure DMCreate(Sender: TObject);
    function quMoedaClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quQuitacaoMeioClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quContaCorrenteClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quBancoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quBancoAgenciaClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quPessoaClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quEmpresaClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLancamentoTipoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quCentroCustoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quDocumentoTipoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quDesdobramentoTipoClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quUsuarioClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function quLookUpMunicipioClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
  private
    { Private declarations }
    FHandleError              : THandleError;
    slProperty                : TStringList;
    FIDMoedaPadrao            : Integer;
    FIDMoedaCotacaoPadrao     : Integer;
    FMoedaPadrao              : String;
    FSiglaMoedaPadrao         : String;
    FIDDefaultCompany         : Integer;
    FTaxInCost                : Boolean;

    procedure InitMoedaPadrao;

    function  GetIDCentroCustoPadrao  : Integer;

    function  GetIDMoedaPadrao        : Integer;
    function  GetIDMoedaCotacaoPadrao : Integer;
    function  GetMoedaPadrao          : String;
    function  GetSiglaMoedaPadrao     : String;
    function  GetIDDefaultCompany     : Integer;
    function  GetTaxInCost            : Boolean;

  public
    { Public declarations }
    SitAberto, SitParteQuitado, SitQuitado,
    SitCancelado, SitJuridico : Integer;

    fSystem  : TOMSystem;      //System information

    sSisUser : string;

    function GetNextID(Const sTabela: String): LongInt;

    procedure CreateLancSituacao;

    procedure SetError(ErrorType: Integer; sSource, sError: String);
    function GetPaymentMediaType(IDMeioPag: Integer): Integer;

    function GetPropertyValues(MProperty: String): TStringList;
    procedure PropertyValuesRefresh;

    function NewQuery: TADOQuery;
    function RunSQL(RunSQL:String): Boolean;
    function RunSQLEx(RunSQL:String): Integer;


    property IDCentroCustoPadrao : Integer read GetIDCentroCustoPadrao;

    property IDMoedaCotacaoPadrao : Integer read GetIDMoedaCotacaoPadrao;
    property IDMoedaPadrao        : Integer read GetIDMoedaPadrao;
    property MoedaPadrao          : String  read GetMoedaPadrao;
    property SiglaMoedaPadrao     : String  read GetSiglaMoedaPadrao;
    property IDDefaultCompany     : Integer read GetIDDefaultCompany write FIDDefaultCompany;
    property TaxInCost            : Boolean read GetTaxInCost;
  end;

var
  DM: TDM;

implementation

{$R *.DFM}

uses
          uMsgBox,
          uParamFunctions,
          uDMGlobal,
          Registry,
          uMsgConstant,
          uDateTimeFunctions,
          // Sistema
          uSisSelPerfilDlg,
          uSisUsuarioFch,
          uSisEmpresaFch,
          uSisMoedaFch,
          uSisSenha,
          uSisPessoaFch,
          uSisMunicipio,
          uFrmServerInfo,
          uModuleConfig,
          uSystemObj,
          uEncryptFunctions,
          uOperationSystem,
          
          // Financeiro
          uFinLancamentoTipoFch,
          uFinQuitacaoMeioFch,
          uFinContaCorrenteFch,
          uFinDocumentoTipoFch,
          uFinCentroCustoFch,
          uFinCentroCustoTBrw,
          uFinLancamentoTipoTBrw,
          uFinBancoAgenciaFch,
          uFinBancoFch,
          uFinDesdobramentoTipoFch;

function TDM.GetNextID(Const sTabela: String): LongInt;
begin
  with spGetNextID do
    begin
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
    end;
end;

procedure TDM.SetError(ErrorType: Integer; sSource, sError: String);
begin

  if not Assigned(FHandleError.Connection) then
     FHandleError.Connection := DBADOConnection;

  FHandleError.ErrorDetected(DM.GetNextID(MR_APPHISTORY_ID),
                             ErrorType,
                             SisSenha.IDUsuario,
                             sSource,
                             sError,
                             FormatDateTime('mm/dd/yyyy', Now));
end;

procedure TDM.DMCreate(Sender: TObject);
var
  //Client StatUp Variables
  iMinOfUse : Integer;
  sPW, sUser, sDBAlias, sServer, sResult : String;
  FrmServrInfo : TFrmServerInfo;
  buildInfo: String;
begin

  TFrmMsgConstant.Create(Self);

  FrmServrInfo  := TFrmServerInfo.Create(self);
  fSystem       := TOMSystem.Create;

  sResult := FrmServrInfo.Start('5', False);

  sServer  := ParseParam(sResult, '#SRV#');
  sDBAlias := ParseParam(sResult, '#DB#');
  sUser    := ParseParam(sResult, '#USER#');
  sPW      := ParseParam(sResult, '#PW#');


  //Colocation test
  { sServer  := '192.168.100.100';
   sDBAlias := 'ApresentationDB';
   sUser    := 'checkcustomer';
   sPW      := '7740';
   }

  // Default ConnectionString used by the application (SQL Server)
  DBADOConnection.ConnectionString := '';

  //DBADOConnection.ConnectionString := SetConnectionStr(sUser, sPw, SDBAlias, sServer);
  DBADOConnection.ConnectionString := SetConnectionStrNoNETLIB(sUser, sPw, SDBAlias, sServer);

  try
    DBADOConnection.Open;
    FrmServrInfo.Free;
  except
    MsgBox(MSG_CRT_NO_PARAM_SERVER, vbOKOnly + vbInformation);

    //Inicio o frm de Srvr Information
    FrmServrInfo.Start('4', True);
    FrmServrInfo.Free;

    Application.Terminate;
    raise;

  end;

  slProperty   := TStringList.Create;
  FHandleError := THandleError.Create;

{  with quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text := 'SELECT Nome FROM Sis_Registro';
      Open;
      Application.Title := Fields[0].AsString;
      Close;
    end;}

  if not ModuleStart then
     begin
     MsgBox(MSG_CRT_NO_MODEL_INFORMTION, vbCritical + vbOKOnly);
     Abort;
     end;

   //validate license key
   if ((fSystem.StartMode <> SYS_MODULE_TRIAL) and (not fSystem.ValidLicense)) then
      begin
      MsgBox(MSG_CRT_ERROR_INVALID_KEY, vbCritical + vbOKOnly);
      Abort;
      end;

   if (fSystem.StartMode = SYS_MODULE_TRIAL) then
   begin
      with TRegistry.Create do
      begin
        try

          if ( getOS(buildInfo) = osW7 ) then
             RootKey:= HKEY_CURRENT_USER
          else
             RootKey := HKEY_LOCAL_MACHINE;

          OpenKey('SOFTWARE\Applenet\CurrentVersions', True);
          if not ValueExists('TrialCount') then
          begin
            MsgBox(MSG_CRT_NO_VALID_TRIAL_INFO, vbOKOnly + vbCritical);
            Application.Terminate;
          end;

          iMinOfUse:= StrToInt(DecodeServerInfo(ReadString('TrialCount'), 'Count', CIPHER_TEXT_STEALING, FMT_UU));
          if iMinOfUse > TRIAL_LIMIT then
          begin
            MsgBox(MSG_INF_ACCOUNT_EXPIRED, vbOKOnly + vbInformation);
            Application.Terminate;
          end
          else
            MsgBox(MSG_INF_PART1_USE_MR+ IntToStr(TRIAL_LIMIT - iMinOfUse) + MSG_INF_PART2_USE_MR,
                                vbOKOnly + vbInformation);

          CloseKey;
        finally
          Free;
        end;
      end;
   end;


   // Seta os parametros do cliente
   with TRegistry.Create do
     begin
       if ( getOS(buildInfo) = osW7 ) then
          RootKey:= HKEY_CURRENT_USER
       else
         RootKey := HKEY_LOCAL_MACHINE;

       OpenKey('SOFTWARE\Applenet\OfficeManager', True);

       if not ValueExists('DefaultLanguage') then
          WriteInteger('DefaultLanguage', 1);
       if not ValueExists('LangPath') then
          WriteString('LangPath', ExtractFilePath(ParamStr(0)) + LANG_DIRECTORY);
       if not ValueExists('DefaultDecimalSeparator') then
          WriteString('DefaultDecimalSeparator', '.');
       if not ValueExists('DefaultThousandSeparator') then
          WriteString('DefaultThousandSeparator', ',');
       if not ValueExists('DefaultDateFormat') then
          WriteString('DefaultDateFormat', 'mm/dd/yyyy');

       DMGlobal.IDLanguage    := ReadInteger('DefaultLanguage');
       DMGlobal.LangFilesPath := ReadString('LangPath');
       DecimalSeparator       := ReadString('DefaultDecimalSeparator')[1];
       ThousandSeparator      := ReadString('DefaultThousandSeparator')[1];
       ShortDateFormat        := ReadString('DefaultDateFormat');
       Free;
     end;

  ChangeLocalSetings(DMGlobal.IDLanguage);

  with quSrvParam do
    begin
    if Active then
       Close;
    Parameters.ParamByName('IDParam').Value := 66;
    Open;
    FTaxInCost := (quSrvParamSrvValue.AsString = 'True');
    Close;
    end;

  inherited;

  FIDMoedaPadrao := -1;

end;

procedure TDM.CreateLancSituacao;
begin

  SitAberto       := GetConst('LancamentoSituacao_Aberto');
  SitParteQuitado := getConst('LancamentoSituacao_ParteQuitado');
  SitQuitado      := getConst('LancamentoSituacao_Quitado');
  SitJuridico     := getConst('LancamentoSituacao_Juridico');
  SitCancelado    := getConst('LancamentoSituacao_Cancelado');


end;

function TDM.NewQuery: TADOQuery;
begin
  Result := TADOQuery.Create(self);
  Result.Connection := DM.DBADOConnection;

end;


procedure TDM.DMDestroy(Sender: TObject);
begin
  inherited;
  slProperty.Free;
  FHandleError.Free;
  FreeAndNil(fSystem); 
end;


procedure TDM.PropertyValuesRefresh;
begin
  slProperty.Clear;

end;

function TDM.GetPropertyValues(MProperty: String): TStringList;
var
  p: integer;

begin
  // Testo se já li no banco esta propriedade
  p := slProperty.IndexOf(MProperty);
  if p = -1 then
    begin
      // Tenho que montar este string list
      slProperty.Add(MProperty);
      p := slProperty.IndexOf(MProperty);
      slProperty.Objects[p] := TStringList.Create;

      with quFreeSQL do
        begin
          Close;
          SQL.Text := 'SELECT PropertyValue ' +
                      'FROM Sis_PropertyDomain ' +
                      'WHERE Property = ' + #39 + MProperty + #39 + ' ' +
                      'ORDER BY PropertyValue';
          Open;
          while not EOF do
            begin
              TStringList(slProperty.Objects[p]).Add(FieldByName('PropertyValue').AsString);
              Next;
            end;
          Close;
        end;
    end;

  Result := TStringList(slProperty.Objects[p]);
end;

procedure TDM.InitMoedaPadrao;
begin
  if FIDMoedaPadrao = -1 then
    begin
      with quFreeSQL do
        begin
          if Active then
             Close;
          SQL.Text := 'SELECT IDMoeda, IDMoedaCotacao, Moeda, Sigla FROM Sis_Moeda Where MoedaPadrao = 1';
          Open;
          FIDMoedaPadrao        := Fields[0].AsInteger;
          FIDMoedaCotacaoPadrao := Fields[1].AsInteger;
          FMoedaPadrao          := Fields[2].AsString;
          FSiglaMoedaPadrao     := Fields[3].AsString;
          Close;
        end;
    end;
end;


Function TDM.GetIDCentroCustoPadrao: Integer;
begin
  if Application.Title = 'Sistema Integrado Nuance Tecidos' then
    Result := -1
  else
    Result := 2;
end;


function  TDM.GetIDDefaultCompany       : Integer;
begin
  Result := FIDDefaultCompany;
end;

Function TDM.GetIDMoedaPadrao    : Integer;
begin
  InitMoedaPadrao;
  Result := FIDMoedaPadrao;
end;


Function TDM.GetIDMoedaCotacaoPadrao    : Integer;
begin
  InitMoedaPadrao;
  Result := FIDMoedaCotacaoPadrao;
end;

Function TDM.GetMoedaPadrao      : String;
begin
  InitMoedaPadrao;
  Result := FMoedaPadrao;
end;

Function TDM.GetSiglaMoedaPadrao : String;
begin
  InitMoedaPadrao;
  Result := FSiglaMoedaPadrao;
end;


function TDM.RunSQL(RunSQL: String): Boolean;
begin
  with quFreeSQL do
    begin
      Close;
      SQL.Text := RunSQL;
      try
        ExecSQL;
        Result := True;
      except
        Result := False;
      end;
    end;
end;

function TDM.RunSQLEx(RunSQL: String): Integer;
begin
  with quFreeSQL do
    begin
      Close;
      SQL.Text := RunSQL;
      ExecSQL;
    end;
end;

function TDM.quMoedaClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TSisMoedaFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quQuitacaoMeioClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinQuitacaoMeioFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quContaCorrenteClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinContaCorrenteFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quBancoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinBancoFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quBancoAgenciaClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinBancoAgenciaFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quPessoaClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TSisPessoaFch.Create(Self) do
    begin
    if (ClickedButton = btInc) and (quPessoa.FilterFields.IndexOf('IDTipoPessoa') <> -1) then
       Param := Param + 'IDTipoPessoa=' +
                quPessoa.FilterValues.Strings[quPessoa.FilterFields.IndexOf('IDTipoPessoa')]+';';

      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quEmpresaClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TSisEmpresaFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quLancamentoTipoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinLancamentoTipoFch.Create(Self) do
     begin
     Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
     Free;
     end;

end;

function TDM.quCentroCustoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  if ClickedButton = btInc then
    begin
      with TFinCentroCustoTBrw.Create(Self) do;
    end
  else
    begin
      with TFinCentroCustoFch.Create(Self) do
        begin
          Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
          Free;
        end;
    end;

end;

function TDM.quDocumentoTipoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinDocumentoTipoFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quDesdobramentoTipoClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TFinDesdobramentoTipoFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.quUsuarioClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TSisUsuarioFch.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

function TDM.GetPaymentMediaType(IDMeioPag: Integer): Integer;
begin
  Result := StrToInt(DescCodigo(['IDMeioPag'], [IntToStr(IDMeioPag)], 'MeioPag', 'Tipo'));
end;

function TDM.GetTaxInCost: Boolean;
begin
  Result := FTaxInCost;
end;

function TDM.quLookUpMunicipioClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  inherited;

  with TSisMunicipio.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, '', '', nil);
      Free;
    end;

end;

end.
