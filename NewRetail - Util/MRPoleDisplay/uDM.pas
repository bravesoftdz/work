unit uDM;

interface

uses
  SysUtils, Classes, IniFiles, Forms, DB, DBClient, Graphics,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ExtCtrls, uInvoicePollDisplay, uThreadConnectMRPDS;

const
  SCREEN_CONF              = 'Screen';
  SCREEN_CONF_MOVING_TEXT  = 'MovingText';
  SCREEN_CONF_TEXT_SPEED   = 'TextSpeed';
  SCREEN_CONFIG_TEXT_SIZE  = 'TextSize';
  SCREEN_CONFIG_TEXT_COLOR  = 'TextColor';
  SCREEN_CONF_RECEIPT_POS  = 'ReceiptPos';
  SCREEN_CONF_RECEIPT_LOGO = 'Logo';
  SCREEN_CONF_VIDEO_TOP    = 'VideoTop';
  SCREEN_CONF_VIDEO_LEFT   = 'VideoLeft';
  SCREEN_CONF_VIDEO_RIGHT  = 'VideoRight';
  SCREEN_CONF_VIDEO_BOTTOM = 'VideoBottom';
  SCREEN_CONF_COMPUTER_IP  = 'PollDisplayIP';
  SCREEN_CONF_COMPUTER_PORT= 'PollDisplayPort';
  SCREEN_CONF_STORE_ADD1   = 'StoreAddress1';
  SCREEN_CONF_STORE_ADD2   = 'StoreAddress2';
  SCREEN_CONF_STORE_ADD3   = 'StoreAddress3';
  SCREEN_CONF_RECEIPT_BACKCOLOR = 'ReceiptBackColor';
  SCREEN_CONF_RECEIPT_TEXTCOLOR = 'ReceiptTextColor';
  SCREEN_CONF_LEFT              = 'ScreenLeft';
  SCREEN_CONF_TOP               = 'ScreenTop';
  SCREEN_CONF_HEIGHT            = 'ScreenHeight';
  SCREEN_CONF_WIDTH             = 'ScreenWidth';
  SCREEN_SVR_STATION            = 'Svr_Station';
  SCREEN_SVR_IP                 = 'Svr_IP';
  SCREEN_SVR_PORT               = 'Svr_Port';
  SCREEN_IDLANGUAGE             = 'IDLang';
  SCREEN_RESIZE_ADV             = 'ResizeAdv';

  ADV_BITMAP = 0;
  ADV_JPG    = 1;
  ADV_VIDEO  = 2;
  ADV_FLASH  = 3;
  ADV_WEB    = 4;

  ADV_BITMAP_EXT = 'Bitmap|*.bmp';
  ADV_JPG_EXT    = 'JPG|*.jpg';
  ADV_VIDEO_EXT  = 'Video|*.mpg|all|*.*';
  ADV_FLASH_EXT  = 'Flash File|*.swf';
  ADV_WEB_EXT    = 'HTML|*.html|ASP|*.asp';

type
  TScreenConfig = class
    FMovingText : WideString;
    FTextSpeed  : Integer;
    FTextSize   : Integer;
    FReceiptPos : Integer;
    FIDLanguage : Integer;
    FLogo       : String;
    FVideoLeft  : Integer;
    FVideoTop   : Integer;
    FVideoRight : Integer;
    FVideoBottom: Integer;
    FComputerIP : String;
    FCompPort   : Integer;
    FStoreAdd1  : String;
    FStoreAdd2  : String;
    FStoreAdd3  : String;
    FReceiptBackColor : TColor;
    FReceiptTextColor : TColor;
    FTextColor : TColor;
    FStationName : String;
    FServerIP : String;
    FServerPort   : Integer;
    FAutoResizeAdv : Boolean;
  end;


  TDM = class(TDataModule)
    cdsAdvertising: TClientDataSet;
    IdTCPClient: TIdTCPClient;
    tmrSyncAdv: TTimer;
    cdsAdvertisingDescription: TStringField;
    cdsAdvertisingFileName: TStringField;
    cdsAdvertisingStartDate: TDateTimeField;
    cdsAdvertisingEndDate: TDateTimeField;
    cdsAdvertisingDaysOfWeek: TStringField;
    cdsAdvertisingDaysOfWeekString: TStringField;
    cdsAdvertisingType: TIntegerField;
    cdsAdvertisingTypeString: TStringField;
    cdsAdvertisingDuration: TIntegerField;
    cdsAdvertisingVideoControl: TBooleanField;
    cdsAdvertisingDisplayDescription: TBooleanField;
    cdsAdvertisingHours: TStringField;
    cdsSaleSuggestion: TClientDataSet;
    cdsSaleSuggestionFileName: TStringField;
    cdsSaleSuggestionFileType: TIntegerField;
    cdsSaleSuggestionDuration: TIntegerField;
    cdsCrossSaleItem: TClientDataSet;
    cdsCrossSaleItemID: TIntegerField;
    cdsCrossSaleItemModelNum: TStringField;
    cdsCrossSaleItemModelCategory: TStringField;
    cdsCrossSaleItemModelSubCategory: TStringField;
    cdsCrossSaleItemModelGroup: TStringField;
    cdsCrossSaleItemFileName: TStringField;
    cdsCrossSaleItemFileType: TIntegerField;
    cdsCrossSaleItemDuration: TIntegerField;
    cdsCrossSaleItemCrossDescription: TStringField;
    cdsCrossSaleItemCrossSalePrice: TCurrencyField;
    cdsAdvertisingID: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsAdvertisingCalcFields(DataSet: TDataSet);
    procedure tmrSyncAdvTimer(Sender: TObject);
  private
    FLocalPath : String;
    FIP : String;
    FPort : Integer;
    FThreadConnectMRPDS: TThreadConnectMRPDS;

    procedure CloseAdvertising;
    procedure OpenAdvertising;
    procedure LoadAdvertising;

    procedure CloseCrossSale;
    procedure OpenCrossSale;
    procedure LoadCrossSale;
    procedure AddCrossSaleItem(AFile : String; AType, ATimer : Integer);
    procedure SaveCrossSaleItemHistory(AModelNum, ARegister : String; ADate : TDateTime);
    procedure SynchMRPDS;
    procedure ThreadConnectMRPDSTerminate(Sender: TObject);

    procedure AfterSynchAdvertising;
    procedure AfterSynchCrossSaleItem;


  public
    FScreenConfig : TScreenConfig;
    FConfigFile: TIniFile;
    procedure RefreshScreenConfig;
    procedure RefreshAdvertising;
    procedure SaveAdvertising;
    procedure RefreshCrossSale;


    procedure SetServerConn(AIP : String; APort : Integer);
    function GetCrossSaleItems(AModelNum, ARegister : String): Boolean;

    property LocalPath : String read FLocalPath;
    procedure ClearCrossSale;
  end;

var
  DM: TDM;

implementation

uses uPoleDisplay, uInvoicePollDisplayConst, uParamFunctions,
     uDateTimeFunctions, uDMGlobal;

{$R *.dfm}

procedure TDM.CloseAdvertising;
begin
  with cdsAdvertising do
    if Active then
      Close;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin

  FLocalPath := ExtractFilePath(Application.ExeName);

  if not FileExists(ChangeFileExt( Application.ExeName, '.ini')) then
    FileCreate(ChangeFileExt( Application.ExeName, '.ini'));

  FConfigFile := TIniFile.Create(ChangeFileExt( Application.ExeName, '.ini'));
  FScreenConfig := TScreenConfig.Create;

  tmrSyncAdv.Enabled := True;

  RefreshScreenConfig;

  DMGlobal.IDLanguage := FScreenConfig.FIDLanguage;


  SynchMRPDS;

  OpenAdvertising;
  OpenCrossSale;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  if IdTCPClient.Connected then
  begin
    IdTCPClient.DisconnectSocket;
    IdTCPClient.Disconnect;
  end;
  FreeAndNil(FConfigFile);
  FreeAndNil(FScreenConfig);
  CloseAdvertising;
  CloseCrossSale;
end;

procedure TDM.SaveAdvertising;
begin
  try
    cdsAdvertising.SaveToFile(FLocalPath + 'Advertising.xml', dfXMLUTF8);
  except
    end;
end;

procedure TDM.LoadAdvertising;
begin
  if FileExists(FLocalPath + 'Advertising.xml') then
    cdsAdvertising.LoadFromFile(FLocalPath + 'Advertising.xml');
end;

procedure TDM.OpenAdvertising;
begin
  with cdsAdvertising do
    if not Active then
    begin
      CreateDataSet;
      LoadAdvertising;
    end;
end;

procedure TDM.RefreshAdvertising;
begin
  CloseAdvertising;
  OpenAdvertising;
end;

procedure TDM.RefreshCrossSale;
begin
  CloseCrossSale;
  OpenCrossSale;
end;


procedure TDM.RefreshScreenConfig;
begin
  FScreenConfig.FMovingText  := FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_MOVING_TEXT, '');
  FScreenConfig.FTextSpeed   := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_TEXT_SPEED, 1000);
  FScreenConfig.FTextSize    := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONFIG_TEXT_SIZE, 0);
  FScreenConfig.FReceiptPos  := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_RECEIPT_POS, 0);
  FScreenConfig.FLogo        := FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_RECEIPT_LOGO, '');
  FScreenConfig.FVideoLeft   := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_LEFT, 50);
  FScreenConfig.FVideoTop    := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_TOP, 50);
  FScreenConfig.FVideoRight  := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_RIGHT, 300);
  FScreenConfig.FVideoBottom := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_VIDEO_BOTTOM, 300);
  FScreenConfig.FComputerIP  := FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_COMPUTER_IP, '');
  FScreenConfig.FCompPort    := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_CONF_COMPUTER_PORT, 9091);
  FScreenConfig.FStoreAdd1   := FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_STORE_ADD1, '');
  FScreenConfig.FStoreAdd2   := FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_STORE_ADD2, '');
  FScreenConfig.FStoreAdd3   := FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_STORE_ADD3, '');
  FScreenConfig.FReceiptBackColor := StringToColor(FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_RECEIPT_BACKCOLOR, '$00F2E3D0'));
  FScreenConfig.FTextColor        := StringToColor(FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONFIG_TEXT_COLOR, 'clYellow'));
  FScreenConfig.FReceiptTextColor := StringToColor(FConfigFile.ReadString(SCREEN_CONF, SCREEN_CONF_RECEIPT_TEXTCOLOR, 'clBlack'));
  FScreenConfig.FStationName      := FConfigFile.ReadString(SCREEN_CONF, SCREEN_SVR_STATION, '');
  FScreenConfig.FServerIP         := FConfigFile.ReadString(SCREEN_CONF, SCREEN_SVR_IP, '');
  FScreenConfig.FServerPort       := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_SVR_PORT, 7887);
  FScreenConfig.FIDLanguage       := FConfigFile.ReadInteger(SCREEN_CONF, SCREEN_IDLANGUAGE, 1);
  FScreenConfig.FAutoResizeAdv    := FConfigFile.ReadBool(SCREEN_CONF, SCREEN_RESIZE_ADV, False);
  SetServerConn(FScreenConfig.FServerIP, FScreenConfig.FServerPort);
end;

procedure TDM.cdsAdvertisingCalcFields(DataSet: TDataSet);
var
  FWeekDays : String;
begin
  FWeekDays := '';

  if Pos('1,', cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Monday; ';
  if Pos('2,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Tuesday; ';
  if Pos('3,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Wednesday; ';
  if Pos('4,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Thursday; ';
  if Pos('5,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Friday; ';
  if Pos('6,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Saturday; ';
  if Pos('7,' ,cdsAdvertisingDaysOfWeek.AsString) > 0 then
    FWeekDays := FWeekDays + 'Sunday; ';
  cdsAdvertisingDaysOfWeekString.AsString := FWeekDays;


  case cdsAdvertisingType.AsInteger of
   ADV_BITMAP : cdsAdvertisingTypeString.AsString := 'Bitmap';
   ADV_JPG    : cdsAdvertisingTypeString.AsString := 'JPG';
   ADV_VIDEO  : cdsAdvertisingTypeString.AsString := 'Video';
   ADV_FLASH  : cdsAdvertisingTypeString.AsString := 'Flash';
   ADV_WEB    : cdsAdvertisingTypeString.AsString := 'Website';
  end;

end;

procedure TDM.SetServerConn(AIP: String; APort: Integer);
begin
  if (AIP <> '') then
  begin
    {
    if IdTCPClient.Connected then
      IdTCPClient.Disconnect;
    IdTCPClient.Host := AIP;
    IdTCPClient.Port := APort;
    }
    FIP := AIP;
    FPort := APort;
  end;
end;


(*
function TDM.GetCrossSaleItems(AModelNum, ARegister: String): String;
begin

  Result := '';

  try
    if not IdTCPClient.Connected then
      IdTCPClient.Connect(5);

    if IdTCPClient.Connected then
    begin
      IdTCPClient.WriteLn(FormatModelNum(AModelNum, ARegister));
      Result := IdTCPClient.ReadLn();
    end;
  except
  end;

end;
*)

function TDM.GetCrossSaleItems(AModelNum, ARegister: String): Boolean;
begin

  Result := False;

  with cdsCrossSaleItem do
    if Locate('ModelNum', AModelNum,  []) then
    try
      //Save Model to history
      SaveCrossSaleItemHistory(AModelNum, ARegister, Now);

      Filtered := False;
      Filter := 'ModelNum = ' + QuotedStr(AModelNum);
      Filtered := True;

      //Loop Return Item advertising
      First;
      While not EOF do
      begin
        AddCrossSaleItem(FieldByName('FileName').AsString,
                         FieldByName('FileType').AsInteger,
                         FieldByName('Duration').AsInteger);
        Next;
      end;

      Result := True;

    finally
      Filter := '';
      Filtered := False;
    end;

end;


procedure TDM.CloseCrossSale;
begin

  with cdsCrossSaleItem do
    if Active then
      Close;

  with cdsSaleSuggestion do
    if Active then
      Close;

end;

procedure TDM.LoadCrossSale;
begin
  if FileExists(FLocalPath + 'CrossSaleItem.xml') then
    cdsCrossSaleItem.LoadFromFile(FLocalPath + 'CrossSaleItem.xml');
end;

procedure TDM.OpenCrossSale;
begin

  with cdsCrossSaleItem do
    if not Active then
    begin
      CreateDataSet;
      LoadCrossSale;
    end;

  with cdsSaleSuggestion do
    if not Active then
      CreateDataSet;

end;

procedure TDM.AddCrossSaleItem(AFile: String; AType, ATimer: Integer);
begin

  OpenCrossSale;

  with cdsSaleSuggestion do
    if not Locate('FileName', AFile, []) then
    begin
      Append;
      FieldByName('FileName').AsString := AFile;
      FieldByName('FileType').AsInteger := AType;
      FieldByName('Duration').AsInteger := ATimer;
      Post;
    end;
    
end;

procedure TDM.tmrSyncAdvTimer(Sender: TObject);
begin
  tmrSyncAdv.Enabled := False;
  try
    SynchMRPDS;
  finally
    //tmrSyncAdv.Enabled := True;
  end;
end;

procedure TDM.SynchMRPDS;
begin
  if FThreadConnectMRPDS <> nil then
    if FThreadConnectMRPDS.Terminated then
      Exit
    else
      FreeAndNil(FThreadConnectMRPDS);

  FThreadConnectMRPDS := TThreadConnectMRPDS.Create(True);
  FThreadConnectMRPDS.IP := FIP;
  FThreadConnectMRPDS.Port := FPort;
  FThreadConnectMRPDS.FreeOnTerminate := True;
  FThreadConnectMRPDS.OnTerminate := ThreadConnectMRPDSTerminate;
  FThreadConnectMRPDS.AfterSynchAdvertising := AfterSynchAdvertising;
  FThreadConnectMRPDS.AfterSynchCrossSaleItem := AfterSynchCrossSaleItem;

  FThreadConnectMRPDS.Resume;
end;

procedure TDM.ThreadConnectMRPDSTerminate(Sender: TObject);
begin
  FThreadConnectMRPDS := nil;
end;

procedure TDM.ClearCrossSale;
begin

  OpenCrossSale;

  with cdsSaleSuggestion do
  begin
    First;
    while not EOF do
    begin
      Edit;
      Delete;
    end;
  end;

end;

procedure TDM.SaveCrossSaleItemHistory(AModelNum, ARegister: String;
  ADate: TDateTime);
begin
 //
end;

procedure TDM.AfterSynchAdvertising;
begin

end;

procedure TDM.AfterSynchCrossSaleItem;
begin

end;

end.
