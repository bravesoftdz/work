unit uDM;

interface

uses
  SysUtils, Classes, DB, DBClient, mrConfigTable, Provider, ADODB, Windows;

type
  TDM = class(TDataModule)
    ADOConnection: TADOConnection;
    qryMRPetSate: TADOQuery;
    dspMRPetSale: TDataSetProvider;
    ctMRPetSale: TmrConfigTable;
    cdsMRPetSale: TClientDataSet;
    dsMRPetSale: TDataSource;
    qryMRPetInventory: TADOQuery;
    dspMRPetInventory: TDataSetProvider;
    cdsMRPetInventory: TClientDataSet;
    dsMRPetInventory: TDataSource;
    cdsMRPetInventoryIDPet: TIntegerField;
    cdsMRPetInventorySKU: TStringField;
    cdsMRPetInventorySex: TStringField;
    cdsMRPetInventoryColor: TStringField;
    cdsMRPetInventoryPenNum: TStringField;
    cdsMRPetInventoryVendorCost: TBCDField;
    cdsMRPetInventoryMSRP: TBCDField;
    cdsMRPetInventorySalePrice: TBCDField;
    cdsMRPetInventoryPromoPrice: TBCDField;
    cdsMRPetInventoryUSDA: TStringField;
    cdsMRPetInventoryCollar: TStringField;
    cdsMRPetInventorySire: TStringField;
    cdsMRPetInventoryDam: TStringField;
    cdsMRPetInventoryWhelpDate: TDateTimeField;
    cdsMRPetInventoryPurchaseDate: TDateTimeField;
    cdsMRPetInventoryNotes: TStringField;
    cdsMRPetInventorySpecies: TStringField;
    cdsMRPetInventoryPort: TStringField;
    cdsMRPetInventoryBreed: TStringField;
    cdsMRPetInventoryStatusCode: TStringField;
    cdsMRPetInventoryStatus: TStringField;
    cdsMRPetInventoryBreeder: TStringField;
    cdsMRPetInventoryPhoneAreaCode: TStringField;
    cdsMRPetInventoryBreederPhone: TStringField;
    cdsMRPetInventoryStore: TStringField;
    cdsMRPetInventoryWeightEntryDate: TDateTimeField;
    cdsMRPetInventoryWeight: TBCDField;
    cdsMRPetInventoryRegistry: TStringField;
    cdsMRPetInventoryRegistrationNum: TStringField;
    ctMRPetInventory: TmrConfigTable;
    procedure cdsMRPetSaleBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure ctMRPetSaleBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure DataModuleCreate(Sender: TObject);
  private
    FSaleDate : TDateTime;
    FKey : String;
    function getKey : WideString;
    function FormatSaleFile(dDate : TDateTime) : String;
    function FormatPetInventoryFile(ADate : TDateTime) : String;
    function OpenConnection : Boolean;
    function CloseConnection : Boolean;
    function serviceIsRunning(arg_serviceName: String): Boolean;
    function formatDateTimeFixed(arg_saleDate: TDateTime): TDateTime;
    procedure AddLog(Text: String);
  public
    FQtyDecimal: Integer;
    FEnableLog : Boolean;
    function SendPetDate(ASaleDate : TDateTime; ASaleData, AInvData : Boolean) : Boolean;
  end;

var
  DM: TDM;

implementation

uses uSQLFunctions, uMRSQLParam, uMainRetailTransferData, Forms, uMainRetailKey,
     ufrmServerInfo, uSystemConst, uParamFunctions, uMainRetailKeyConst,
     uSaveToFile, WinSvc;

{$R *.dfm}

procedure TDM.AddLog(Text:String);
var
  fFile : TSaveFile;
begin
  if FEnableLog then
  begin
    fFile := TSaveFile.Create;
    try
      fFile.FilePath := ExtractFilepath(Application.ExeName) + 'petdatalog.txt';
      fFile.OpenFile;
      Text := FormatDateTime('mm/dd/yyyy hh:mm ', now) + Text;
      fFile.InsertText(Text,0);
      fFile.CreateFile;
    finally
      FreeAndNil(fFile);
    end;
  end;
end;


procedure TDM.cdsMRPetSaleBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try

      AddKey('MovDate1').AsString := FormatDateTime('mm/dd/yyyy', Trunc(FSaleDate));
      KeyByName('MovDate1').Condition := tcGreaterThanEqual;
      KeyByName('MovDate1').Field := 'IM.MovDate';

      AddKey('MovDate2').AsString := FormatDateTime('mm/dd/yyyy', Trunc(FSaleDate+1));
      KeyByName('MovDate2').Condition := tcLessThan;
      KeyByName('MovDate2').Field := 'IM.MovDate';

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

function TDM.SendPetDate(ASaleDate: TDateTime; ASaleData, AInvData : Boolean): Boolean;
var
  FMRFTPTransfer : TMRFTPTransfer;
  sFile : String;
begin

  Result := False;

  try
    if ( openConnection ) then begin
      if ASaleData then begin
        AddLog('Openning sale query');
        ASaleDate := trunc(AsaleDate);
        fSaleDate := ASaleDate;
        cdsMRPetSale.Open; 
        try
          if not cdsMRPetSale.IsEmpty then
          begin
            addLog('sale found');
            FMRFTPTransfer := TMRFTPTransfer.Create;
            fmrFTPTransfer.setTimeOut(7000);
            addLog('time out configured');
            try
              sFile := FormatSaleFile(Trunc(FSaleDate));
              AddLog('Saving sale XML file ' + sfile);
              cdsMRPetSale.SaveToFile(sFile, dfXML);
              AddLog('Sale XML file saved! ' + sfile);

              // setting time out
              FMRFTPTransfer.FZipFile := True;
              FMRFTPTransfer.FDeleteFileAfterSend := True;
              AddLog('Sending sale file');
              FMRFTPTransfer.SendFile(sFile, True);
              Result := True;
              AddLog('Sale file sent!');
            finally
              FreeAndNil(FMRFTPTransfer);
            end;
          end else begin
                  addLog('sale not found');
              end;

        finally
          cdsMRPetSale.Close;
        end;

        AddLog('Closing sale query');
        closeConnection();
      end;



    end else begin
           addLog('cannot open');
        end;

  except on e: Exception do
    addLog(e.Message)
  end;


end;

procedure TDM.ctMRPetSaleBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sWhere: WideString;
  Where: TMRSQLParam;
begin

  try
    Where := TMRSQLParam.Create;
    Where.ParamString := OwnerData;

    sWhere := Where.GetWhereSQL +
                 //' AND IM.InventMovTypeID = 1 AND IM.DocumentID IN (SELECT IDInvoice FROM Invoice I (NOLOCK) WHERE PuppyTracker = 1) ORDER BY IM.DocumentID ';
                 ' AND IM.InventMovTypeID in (1, 3) ORDER BY IM.DocumentID ';
    OwnerData := sWhere;

  finally
    FreeAndNil(Where);
  end;

end;

function TDM.getKey: WideString;
var
  MRKey : TMRKey;
begin
  try
    MRKey := TMRKey.Create(ADOConnection);
    MRKey.VerifyKey(SOFTWARE_PC);
    Result := MRKey.FKey;
  finally
    FreeAndNil(MRKey);
    end;
end;

function TDM.FormatSaleFile(dDate: TDateTime): String;
begin

  Result := ExtractFilePath(Application.ExeName) + 'sales_' +
            FormatDateTime('YYYYMMDD', dDate) + '_' + FKey + '.xml';

end;

function TDM.FormatPetInventoryFile(ADate: TDateTime): String;
begin

  Result := ExtractFilePath(Application.ExeName) + 'petinfo_' +
            FormatDateTime('YYYYMMDD', ADate) + '_' +
            FKey + '.xml';

end;

function TDM.CloseConnection: Boolean;
begin
  if ADOConnection.Connected then
    ADOConnection.Close;

  AddLog('CONNECTION CLOSED');
end;

function TDM.OpenConnection: Boolean;
var
  sResult : String;
  FrmServrInfo : TFrmServerInfo;
  bAbort : Boolean;
  cStartType : Char;

  sServer, sDB,
  sUserName, sPW : String;
  bWinLogin, bUseNetLib : Boolean;

begin


  //Pegar os Parametros 1 - DataBase, 2 - Backup Path,
  //3 - user name, and 4 - password
  FrmServrInfo  := TFrmServerInfo.Create(self);
  Try
     cStartType := '4';
     sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);
  Finally
     FrmServrInfo.Free;
  end;

  FrmServrInfo := nil;
  try
      FrmServrInfo  := TFrmServerInfo.Create(self);
      cStartType := '3';
      sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);

      While not bAbort do
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


        // work around to avoid connection is already opened.
        if ( ADOConnection.Connected ) then begin
           ADOConnection.Connected := false;
        end;

        ADOConnection.ConnectionString := sResult;
        AddLog('Before OPEN CONNECTION');
        ADOConnection.Open;
        bAbort := True;
        Result := True;
        except
           on E: Exception do
              begin
              sResult := FrmServrInfo.Start(cStartType, True, E.Message, bAbort);
              AddLog('Database connection fail');
              end;
           end;

  finally
    FrmServrInfo.Free;
  end;


end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  saleDate: TDateTime;
  saleSelected: Boolean;
begin

  DM.FEnableLog := false;

  if ( not serviceIsRunning('PetDataService') ) then begin

      if ParamCount > 0 then begin

        if ParamCount > 1 then begin
           DM.FEnableLog := (ParamStr(2) = '1');
        end;

        if ParamStr(1) <> '' then
        try
          addLog('Petdata version 7.0');
          addLog(paramStr(1));
          saleDate := StrToDate(ParamStr(1));
          saleSelected := true;
        except on e:exception do begin
             addLog(e.message);
             saleDate := Trunc(Now-1);
             addLog(DateToStr(saleDate));
          end;
        end;

      end;


      try
          addLog(datetostr(saleDate));
          Fkey := getKey;
          DM.SendPetDate(saleDate, saleSelected, false);
          addLog('end petdate portion');
      except on e:exception do
          addLog('error when running Petdate ' + e.Message);
      end;
  end;

end;

function TDM.serviceIsRunning(arg_serviceName: String): Boolean;
var
    serviceManager, service:THandle;
    serviceStatus:SERVICE_STATUS;
begin

 result := false;

 serviceManager := OpenSCManager(nil, nil, SC_Manager_Connect);
 service  := OpenService(serviceManager, pchar(arg_serviceName), SC_Manager_All_Access);

 if QueryServiceStatus(serviceManager, serviceStatus) then begin
   result := ( SERVICE_RUNNING = serviceStatus.dwCurrentState );
 end;

 CloseServiceHandle(service);
 CloseServiceHandle(serviceManager);
end;

function TDM.formatDateTimeFixed(arg_saleDate: TDateTime): TDateTime;
var
  strDate: String;
begin
  strDate := formatDateTime('mm/dd/yyyy', arg_saleDate);
  result := strToDateTime(strDate);
end;

end.
