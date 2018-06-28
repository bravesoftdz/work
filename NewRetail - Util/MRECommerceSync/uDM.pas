unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB, mrConfigTable, Provider, PowerADOQuery,
  LookUpADOQuery, IniFiles, Windows, Forms, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, SOAPHTTPTrans, ExtCtrls, DBClient,
  IdMessage, IdMessageClient, IdSMTP;

const
   SYNC_VERSION = '1.0.0.22';

type
  TMainRetailInfo = class
    FIDStore: Integer;
    FIDInventoryStore: Integer;
    FIDCashReg: Integer;
    FIDUser: Integer;
    FIDCommission: Integer;
    FIDMedia: Integer;
    FIDFreight: Integer;
    FIDPersonType: Integer;
    FPaymentList: String;
  end;

  TECommerceInfo = class
    FUser: String;
    FPW: String;
    FURL: String;
    FStatusPedido: Integer;
    FEstoque: Integer;
    FExportarDepartamento: Boolean;
    FProdutoUnicaCategoria: Boolean;
    FCategoriaUnica: Integer;
    FDescCategoriaUnica : String;
  end;

  TImpExpInfo = class
    DiasImportacao: Integer;
    ImportacaoAuto: Boolean;
    MinImportacao: Integer;
    ImportacaoCliente: Boolean;
    ImportacaoPedido: Boolean;
    DiasExportacao: Integer;
    ExportacaoAuto: Boolean;
    MinExportacao: Integer;
    ExportacaoFabricante: Boolean;
    ExportacaoEstoque: Boolean;
    ExportacaoQuantidade: Boolean;
  end;

  TDM = class(TDataModule)
    ADOCon: TADOConnection;
    qryInventoryItem: TADOQuery;
    qryInventoryItemIDModel: TIntegerField;
    qryInventoryItemModel: TStringField;
    qryInventoryItemDescription: TStringField;
    qryInventoryItemColor: TStringField;
    qryInventoryItemSizeName: TStringField;
    qryInventoryItemCodColor: TStringField;
    qryInventoryItemCodSize: TStringField;
    qryInventoryItemLastMovDate: TDateTimeField;
    qryInventoryItemDateLastCost: TDateTimeField;
    qryInventoryItemVendorCost: TBCDField;
    qryInventoryItemOtherCost: TBCDField;
    qryInventoryItemFreightCost: TBCDField;
    qryInventoryItemFinalCost: TBCDField;
    qryInventoryItemSellingPrice: TBCDField;
    qryInventoryItemModelType: TStringField;
    qryInventoryItemReplacementCost: TBCDField;
    qryInventoryItemPromotionPrice: TBCDField;
    qryInventoryItemDiscountPerc: TFloatField;
    qryInventoryItemClassification: TStringField;
    qryInventoryItemCaseQty: TBCDField;
    qryInventoryItemVerify: TBooleanField;
    qryInventoryItemAvgCost: TBCDField;
    qryInventoryItemRealMarkUpValue: TBCDField;
    qryInventoryItemRealMarkUpPercent: TBCDField;
    qryInventoryItemMarginPercent: TBCDField;
    qryInventoryItemMarginValue: TBCDField;
    qryInventoryItemDateLastSellingPrice: TDateTimeField;
    qryInventoryItemSuggRetail: TBCDField;
    qryInventoryItemTotQtyOnHand: TBCDField;
    qryInventoryItemTotQtyOnRepair: TBCDField;
    qryInventoryItemTotQtyOnPreSale: TBCDField;
    qryInventoryItemTotQtyOnPrePurchase: TBCDField;
    qryInventoryItemTotQtyOnOrder: TBCDField;
    qryInventoryItemIDManufacturer: TIntegerField;
    qryInventoryItemManufacturer: TStringField;
    qryInventoryItemSubCategory: TStringField;
    qryInventoryItemMGroup: TStringField;
    qryInventoryItemName: TStringField;
    qryInventoryItemIDGroup: TIntegerField;
    qryInventoryItemIDModelGroup: TIntegerField;
    qryInventoryItemIDModelSubGroup: TIntegerField;
    qryInventoryItemIDUserLastSellingPrice: TIntegerField;
    qryInventoryItemUserLastSellingPrice: TStringField;
    qryInventoryItemMarkup: TBCDField;
    qryInventoryItemFloatPercent: TIntegerField;
    qryInventoryItemIDBarcode: TStringField;
    qryInventoryItemPeso: TBCDField;
    qryInventoryItemMark: TBooleanField;
    dsLookUpStore: TDataSource;
    quLookUpStore: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    LookUpCashReg: TLookUpADOQuery;
    LookUpCashRegIDCashRegister: TIntegerField;
    LookUpCashRegName: TStringField;
    dsLookUpCashReg: TDataSource;
    spCheckOpenCash: TADOStoredProc;
    LookUpUser: TLookUpADOQuery;
    LookUpUserIDUser: TIntegerField;
    LookUpUserSystemUser: TStringField;
    dsLookUpUser: TDataSource;
    quLookUpGroup: TLookUpADOQuery;
    quLookUpGroupIDGroup: TIntegerField;
    quLookUpGroupName: TStringField;
    quLookUpGroupPathName: TStringField;
    quLookUpGroupUserCode: TStringField;
    dsLookUpGroup: TDataSource;
    dsLookUpSalesPerson: TDataSource;
    LookUpSalesPerson: TLookUpADOQuery;
    LookUpSalesPersonIDPessoa: TIntegerField;
    LookUpSalesPersonIDComissionado: TIntegerField;
    LookUpSalesPersonCode: TIntegerField;
    LookUpSalesPersonPessoa: TStringField;
    LookUpUserComissionID: TIntegerField;
    quPayments: TADODataSet;
    quPaymentsIDMeioPag: TIntegerField;
    quPaymentsMeioPag: TStringField;
    FTP: TIdFTP;
    HTTPReqRespCatalog: THTTPReqResp;
    quCategory: TADODataSet;
    quCategoryIDGroup: TIntegerField;
    quCategoryName: TStringField;
    quManufacturer: TADODataSet;
    quManufacturerIDPessoa: TIntegerField;
    quManufacturerPessoa: TStringField;
    quProduct: TADODataSet;
    quProductIDModel: TIntegerField;
    quProductModel: TStringField;
    quProductVendorCost: TBCDField;
    quProductSellingPrice: TBCDField;
    quProductIDCategoria: TIntegerField;
    quProductCategoria: TStringField;
    quProductIDFabricante: TIntegerField;
    quProductFabricante: TStringField;
    tmrImport: TTimer;
    tmrExport: TTimer;
    quInventory: TADODataSet;
    quInventoryModelID: TIntegerField;
    quInventoryQtyOnHand: TBCDField;
    quInventoryQtyOnPreSale: TBCDField;
    quCategoryIDDepartment: TIntegerField;
    quCategoryDepartment: TStringField;
    quSKU: TADODataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    IntegerField2: TIntegerField;
    StringField3: TStringField;
    IntegerField3: TIntegerField;
    StringField4: TStringField;
    quProductBarcode: TStringField;
    quSKUBarcode: TStringField;
    quManufacturerDesativado: TBooleanField;
    quProductDescription: TStringField;
    quSKUDescription: TStringField;
    quProductIDDepartment: TIntegerField;
    quSKUDesativado: TBooleanField;
    quProductDesativado: TBooleanField;
    quCategoryCatDesativado: TBooleanField;
    quCategoryDepDesativado: TBooleanField;
    quProductDepartment: TStringField;
    quSKUIDDepartment: TIntegerField;
    quSKUDepartment: TStringField;
    cdsLog: TClientDataSet;
    cdsLogID: TIntegerField;
    cdsLogMsgError: TStringField;
    cdsLogDateTime: TDateTimeField;
    quSKUIDModelParent: TIntegerField;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    dsLookUpMedia: TDataSource;
    quLookUpMedia: TLookUpADOQuery;
    dsLookUpOtherCosts: TDataSource;
    quLookUpOtherCosts: TLookUpADOQuery;
    quLookUpMediaIDMedia: TIntegerField;
    quLookUpMediaMedia: TStringField;
    quLookUpOtherCostsIDCostType: TIntegerField;
    quLookUpOtherCostsCostType: TStringField;
    dsLookUpPersonType: TDataSource;
    quLookUpPersonType: TLookUpADOQuery;
    quLookUpPersonTypeIDTipoPessoa: TIntegerField;
    quLookUpPersonTypePathName: TStringField;
    quHasCustomer: TADOQuery;
    quHasSale: TADOQuery;
    quInsertCustomer: TADOQuery;
    quCommission: TADOQuery;
    quSKUSizeName: TStringField;
    quSKUColor: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure tmrImportTimer(Sender: TObject);
    procedure tmrExportTimer(Sender: TObject);
  private
    FIni: TIniFile;
    procedure LoadConnection;

    function SendEmailLog(AURL, ANameFile, ATipoProcesso: String) : Boolean;
  public
    FLastLogFileName: String;
    MRInfo: TMainRetailInfo;
    ECommerceInfo: TECommerceInfo;
    ImpExpInfo: TImpExpInfo;

    procedure LoadAppValues;

    procedure OpenConnection;
    procedure CloseConnection;

    procedure AppendLog(AMsg: String);
    procedure SaveToLog(AID: Integer; AMsgError: String);
    procedure PostLog(AMsg: String);
    procedure OpenErrorLog;
    function HasErrorLog : Boolean;

    function IniReadString(ASession, AKey : String) : String;
    procedure IniWriteString(ASession, AKey, AValue : String);
    function GetCashRegMov(AIDCashReg : Integer) : Integer;

    function GetPaymentName(IDPayment : Integer) : String;
    function GetPaymentID(APayment : String) : Integer;

    function DecodeStr(sValue, sText : String) : String;
    function EncodeStr(sValue, sText : String) : String;

    function SendEmailLogText(AURL, AText, AFile: String) : Boolean;

    function GetNewID(ATabela: String): Integer;

  end;

var
  DM: TDM;

implementation

uses ufrmServerInfo, uParamFunctions, uEncryptFunctions, uFrmImport,
  uFrmExport, DateUtils;

{$R *.dfm}

{ TDM }

procedure TDM.OpenConnection;
begin
  if not ADOCon.Connected then
  begin
    LoadConnection;
    ADOCon.Open;
  end;
end;

procedure TDM.CloseConnection;
begin
  if ADOCon.Connected then
    ADOCon.Close;
end;

procedure TDM.LoadConnection;
var
  sResult: String;
  FrmServrInfo: TFrmServerInfo;
  bAbort: Boolean;
  cStartType: Char;
  sServer, sDB,
  sUserName, sPW: String;
  bWinLogin, bUseNetLib: Boolean;
begin

  //Pegar os Parametros 1 - DataBase, 2 - Backup Path,
  //3 - user name, and 4 - password
  FrmServrInfo  := TFrmServerInfo.Create(self);
  try
    cStartType := '4';
    sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);
  finally
    FrmServrInfo.Free;
  end;

  FrmServrInfo := nil;
  try
    FrmServrInfo  := TFrmServerInfo.Create(self);
    cStartType := '3';
    sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);

    while not bAbort do
    try
      sServer    := ParseParam(sResult, SV_SERVER);
      sDB        := ParseParam(sResult, SV_DATABASE);
      sUserName  := ParseParam(sResult, SV_USER);
      sPW        := ParseParam(sResult, SV_PASSWORD);
      bWinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
      bUseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');

      if not bWinLogin then
        if bUseNetLib then
          sResult := SetConnectionStr(sUserName, sPW, sDB, sServer)
        else
          sResult := SetConnectionStrNoNETLIB(sUserName, sPW, sDB,sServer)
      else
        if bUseNetLib then
          sResult := SetWinConnectionStr(sDB, sServer)
        else
          sResult := SetWinConnectionStrNoNETLIB(sDB, sServer);

      ADOCon.ConnectionString := sResult;
      bAbort := True;
    except
      on E: Exception do
      begin
        sResult := FrmServrInfo.Start(cStartType, True, E.Message, bAbort);
      end;
    end;

  finally
    FrmServrInfo.Free;
  end;

end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FIni);
  FreeAndNil(MRInfo);
  FreeAndNil(ECommerceInfo);
  FreeAndNil(ImpExpInfo);
  CloseConnection;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FLastLogFileName := '';
  FIni             := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'MRECommerceSync.ini');
  MRInfo           := TMainRetailInfo.Create;
  ECommerceInfo    := TECommerceInfo.Create;
  ImpExpInfo       := TImpExpInfo.Create;
  LoadAppValues;

  tmrImport.Enabled  := ImpExpInfo.ImportacaoAuto;
  tmrImport.Interval := (ImpExpInfo.MinImportacao * 60) * 1000;
  tmrExport.Enabled  := ImpExpInfo.ExportacaoAuto;
  tmrExport.Interval := (ImpExpInfo.MinExportacao * 60) * 1000;
end;

function TDM.IniReadString(ASession, AKey: String): String;
begin
  Result := FIni.ReadString(ASession, AKey, '');
end;

procedure TDM.IniWriteString(ASession, AKey, AValue: String);
begin
  FIni.WriteString(ASession, AKey, AValue);
end;

function TDM.GetCashRegMov(AIDCashReg: Integer): Integer;
begin

  with spCheckOpenCash do
    begin
      Parameters.ParambyName('@CashRegID').Value := AIDCashReg;
      ExecProc;

      if Parameters.ParambyName('@IsOpen').Value then
        Result := Parameters.ParambyName('@IDCashRegMov').Value
      else
        Result := -1;
    end;

end;

function TDM.GetPaymentName(IDPayment: Integer): String;
begin
  with quPayments do
  begin
    if not Active then
      Open;
    First;
    if Locate('IDMeioPag', IDPayment, []) then
      Result := quPaymentsMeioPag.AsString
    else
      Result := '';
  end;
end;

function TDM.GetPaymentID(APayment: String): Integer;
begin
  with quPayments do
  begin
    if not Active then
      Open;
    First;
    if Locate('MeioPag', APayment, []) then
      Result := quPaymentsIDMeioPag.AsInteger
    else
      Result := 1;
  end;
end;

{
  with FTP do
  begin
    Host        := FServerConnection.FTP;
    Port        := FServerConnection.Port;
    Username    := FServerConnection.User;
    Password    := FServerConnection.PW;
    try
      if not Connected then
        Connect(True, -1);
      Result := True;
    except
     on E: Exception do
     begin
        ShowMessage(E.Message);
     end;
    end;
  end

  with FTP do
  begin
   try
     Get(fFile, ExtractFilepath(Application.ExeName) + TEMP_DIR + fFile, True);
     Result := True;
   except
    on E: Exception do
      ReportError('Erro no arquivo ('+fFile+'): ' + E.Message);
     end;
  end;

  try
     FTP.ChangeDir(fDir);
     Result := True;
  except
    on E: Exception do
      ReportError('Erro trocar dir ('+fDir+'): ' + E.Message);
  end;

}
function TDM.DecodeStr(sValue, sText : String): String;
begin
  Result := DecodeServerInfo(sValue, sText, CIPHER_TEXT_STEALING, FMT_UU);
end;

function TDM.EncodeStr(sValue, sText : String): String;
begin
  Result := EncodeServerInfo(sValue, sText, CIPHER_TEXT_STEALING, FMT_UU);
end;

procedure TDM.LoadAppValues;
begin
  MRInfo.FIDStore          := StrToIntDef(IniReadString('Setting', 'Loja'), 1);
  MRInfo.FIDInventoryStore := StrToIntDef(IniReadString('Setting', 'LojaEstoque'), MRInfo.FIDStore);
  MRInfo.FIDCashReg        := StrToIntDef(IniReadString('Setting', 'Caixa'), 1);
  MRInfo.FIDUser           := StrToIntDef(IniReadString('Setting', 'User'), 1);
  MRInfo.FIDCommission     := StrToIntDef(IniReadString('Setting', 'ComissionID'), 1);
  MRInfo.FIDMedia          := StrToIntDef(IniReadString('Setting', 'Media'), 1);
  MRInfo.FIDFreight        := StrToIntDef(IniReadString('Setting', 'Freight'), 1);
  MRInfo.FIDPersonType     := StrToIntDef(IniReadString('Setting', 'PersonType'), 1);

  MRInfo.FPaymentList      := IniReadString('Payment', 'List');

  ECommerceInfo.FUser                 := IniReadString('ECommerce', 'User');
  ECommerceInfo.FPW                   := DecodeStr(IniReadString('ECommerce', 'PW'), 'password');
  ECommerceInfo.FURL                  := IniReadString('ECommerce', 'URL');
  ECommerceInfo.FStatusPedido         := StrToIntDef(IniReadString('ECommerce', 'StatusPedido'), 0);
  ECommerceInfo.FEstoque              := StrToIntDef(IniReadString('ECommerce', 'Estoque'), 0);
  ECommerceInfo.FExportarDepartamento := FIni.ReadBool('ECommerce', 'ExportarDepartamento', False);

  ECommerceInfo.FProdutoUnicaCategoria := FIni.ReadBool('ECommerce', 'ProdutosUnicaCategoria', False);
  ECommerceInfo.FCategoriaUnica        := StrToIntDef(IniReadString('ECommerce', 'CategoriaUnica'), 0);
  ECommerceInfo.FDescCategoriaUnica    := IniReadString('ECommerce', 'DescCategoriaUnica');

  ImpExpInfo.DiasImportacao       := StrToIntDef(IniReadString('Schedule', 'DiasImportacao'), 1);
  ImpExpInfo.ImportacaoAuto       := FIni.ReadBool('Schedule', 'ImportacaoAuto', False);
  ImpExpInfo.MinImportacao        := StrToIntDef(IniReadString('Schedule', 'MinImportacao'), 1);
  ImpExpInfo.ImportacaoCliente    := FIni.ReadBool('Schedule', 'ImportacaoCliente', False);
  ImpExpInfo.ImportacaoPedido     := FIni.ReadBool('Schedule', 'ImportacaoPedido', False);
  ImpExpInfo.DiasExportacao       := StrToIntDef(IniReadString('Schedule', 'DiasExportacao'), 1);
  ImpExpInfo.ExportacaoAuto       := FIni.ReadBool('Schedule', 'ExportacaoAuto', False);
  ImpExpInfo.MinExportacao        := StrToIntDef(IniReadString('Schedule', 'MinExportacao'), 1);
  ImpExpInfo.ExportacaoFabricante := FIni.ReadBool('Schedule', 'ExportacaoFabricante', False);
  ImpExpInfo.ExportacaoEstoque    := FIni.ReadBool('Schedule', 'ExportacaoEstoque', False);
  ImpExpInfo.ExportacaoQuantidade := FIni.ReadBool('Schedule', 'ExportacaoQuantidade', False);
end;

procedure TDM.tmrImportTimer(Sender: TObject);
begin
  if ImpExpInfo.ImportacaoAuto then
  begin
    if ImpExpInfo.ImportacaoCliente then
      FrmImport.SincronizarCliente;

    if ImpExpInfo.ImportacaoPedido then
      FrmImport.SincronizarPedido;
  end;
end;

procedure TDM.tmrExportTimer(Sender: TObject);
begin
  if ImpExpInfo.ExportacaoAuto then
  begin
    if ImpExpInfo.ExportacaoFabricante then
      FrmExport.SincronizarFabricante;

    if ImpExpInfo.ExportacaoEstoque then
      FrmExport.SincronizarEstoque;

    if ImpExpInfo.ExportacaoQuantidade then
      FrmExport.SincronizarQuantidade;
  end;
end;

procedure TDM.AppendLog(AMsg: String);
begin
  SaveToLog(-1, 'Versao: ' + SYNC_VERSION + ' - Abertura de Log. ' + AMsg);
end;

procedure TDM.PostLog(AMsg: String);
var
  Year, Month, Day, Hour, Min, Sec, Mil: Word;
begin
  DecodeDateTime(Now, Year, Month, Day, Hour, Min, Sec, Mil);

  FLastLogFileName := 'SyncLog' + IntToStr(Day) + IntToStr(Month) + IntToStr(Year) + IntToStr(Hour) + IntToStr(Min) + '.xml';

  SaveToLog(-1, 'Fechamento de Log. ' + AMsg);
  cdsLog.SaveToFile(Application.GetNamePath + FLastLogFileName);
  cdsLog.Close;
end;

procedure TDM.SaveToLog(AID: Integer; AMsgError: String);
begin

  OpenErrorLog;

  with cdsLog do
  begin
    Append;
    FieldByName('ID').AsInteger := AID;
    FieldByName('MsgError').AsString := AMsgError;
    FieldByName('DateTime').AsDateTime := Now;
    Post;
  end;

end;

function TDM.SendEmailLog(AURL, ANameFile, ATipoProcesso: String): Boolean;
var
 sBody : TStrings;
begin
(*
  IdMessage.Recipients.EMailAddresses := 'posdev@pinogy.com';
  IdMessage.Priority := mpHigh;
  IdMessage.Subject := 'Log MREcommerceSyncERRO - ' + AURL;
  sBody := TStringList.Create;
  sBody.Add('Log file of process ' + ATipoProcesso + ' from client ' + AURL);
  IdMessage.Body := sBody;

  TIdAttachment.create(IdMessage.MessageParts, ANameFile);
  IdSMTP.Connect(1000);
  try
    IdSMTP.Send(IdMessage);
  finally
    IdSMTP.Disconnect;
    FreeAndNil(sBody);
    Result := True;
  end;
*)
end;

function TDM.SendEmailLogText(AURL, AText, AFile: String): Boolean;
begin

  (*
  if AFile = '' then
    AFile := Application.GetNamePath + FLastLogFileName;

  Result := SendEmailLog(AURL, AFile, AText);
  *)
end;

function TDM.GetNewID(ATabela: String): Integer;
begin
  Result := -1;

  with TADOStoredProc.Create(nil) do
  try
    Connection := ADOCon;
    ProcedureName := 'sp_Sis_GetNextCode';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := ATabela;
    Parameters.ParamByName('@NovoCodigo').Value := 0;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;
end;

procedure TDM.OpenErrorLog;
begin
  if not DM.cdsLog.Active then
  begin
    DM.cdsLog.CreateDataSet;
    DM.cdsLog.Open;
  end;
end;

function TDM.HasErrorLog: Boolean;
begin
  Result := DM.cdsLog.Active and (DM.cdsLog.RecordCount > 1);
end;

end.
