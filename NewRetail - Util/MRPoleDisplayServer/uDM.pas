unit uDM;

interface

uses
  SysUtils, Classes, DB, DBClient, Forms, IdBaseComponent, IdComponent,
  IdTCPServer, uInvoicePollDisplayConst, IniFiles, IdSocketHandle, Dialogs, uInvoicePollDisplay, uDMThread;

const
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

  SVR = 'Settings';
  SVR_IP = 'IP';
  SVR_PORT = 'Port';
  SVR_LANGUAGE = 'Language';


type
  TMRPDSConnectionData = class
    FActualHeader: TMRPDSHeader;
    FState: Integer;
    FDMThread: TDMThread;
  end;

  TDM = class(TDataModule)
    cdsAdvertising: TClientDataSet;
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
    cdsPoleDisplayClient: TClientDataSet;
    cdsPoleDisplayClientDescription: TStringField;
    cdsPoleDisplayClientIPAddress: TStringField;
    cdsCrossSaleItem: TClientDataSet;
    cdsCrossSaleItemID: TIntegerField;
    cdsCrossSaleItemFileName: TStringField;
    cdsCrossSaleItemFileType: TIntegerField;
    cdsCrossSaleItemDuration: TIntegerField;
    IdTCPServer: TIdTCPServer;
    cdsPoleDisplayClientPort: TIntegerField;
    cdsPoleDisplayClientID: TFloatField;
    cdsCrossSaleItemHistory: TClientDataSet;
    cdsCrossSaleItemHistoryModel: TStringField;
    cdsCrossSaleItemHistoryItemDate: TDateTimeField;
    cdsCrossSaleItemHistoryRegister: TStringField;
    cdsCrossSaleItemModelNum: TStringField;
    cdsCrossSaleItemCrossDescription: TStringField;
    cdsCrossSaleItemCrossSalePrice: TCurrencyField;
    cdsCrossSaleItemModelCategory: TStringField;
    cdsCrossSaleItemModelSubCategory: TStringField;
    cdsCrossSaleItemModelGroup: TStringField;
    cdsAdvertisingID: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsAdvertisingNewRecord(DataSet: TDataSet);
    procedure cdsAdvertisingCalcFields(DataSet: TDataSet);
    procedure IdTCPServerException(AThread: TIdPeerThread;
      AException: Exception);
    procedure IdTCPServerExecute(AThread: TIdPeerThread);
    procedure IdTCPServerConnect(AThread: TIdPeerThread);
    procedure IdTCPServerDisconnect(AThread: TIdPeerThread);
  private
    FServerIP : String;
    FServerPort : Integer;
    FLocalPath : String;

    procedure CloseAdvertising;
    procedure OpenAdvertising;
    procedure LoadAdvertising;

    procedure ClosePoleClient;
    procedure OpenPoleClient;
    procedure LoadPoleClient;
    procedure SavePoleClient;

    procedure CloseCrossSaleItem;
    procedure OpenCrossSaleItem;
    procedure LoadCrossSaleItem;

    procedure CloseCrossSaleItemHistory;
    procedure OpenCrossSaleItemHistory;
    procedure LoadCrossSaleItemHistory;
    procedure SaveCrossSaleItemHistory(AModel, ARegister : String; ADate: TDateTime);


    procedure StartServer;
    procedure StopServer;
    procedure AddPoleClient(AText : String);
    function RequestCrossSellItem(AText : String): String;
  public
    FLastDesc: Integer;

    FConfigFile: TIniFile;
    procedure RefreshAdvertising;
    procedure SaveAdvertising;
    procedure RefreshCrossSaleItem;
    procedure SaveCrossSaleItem;


    procedure RefreshSettings;

    property LocalPath : String read FLocalPath;
    property ServerIP : String read FServerIP write FServerIP;
    property ServerPort : Integer read FServerPort write FServerPort;
  end;

var
  DM: TDM;

implementation

uses uParamFunctions, uPoleDisplay, uDMGlobal;

{$R *.dfm}

procedure TDM.CloseAdvertising;
begin
  with cdsAdvertising do
    if Active then
      Close;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FLastDesc := 0;

  FLocalPath := ExtractFilePath(Application.ExeName);

  if not FileExists(ChangeFileExt( Application.ExeName, '.ini')) then
    FileCreate(ChangeFileExt( Application.ExeName, '.ini'));

  FConfigFile := TIniFile.Create(ChangeFileExt( Application.ExeName, '.ini'));

  RefreshSettings;
  OpenPoleClient;
  OpenCrossSaleItem;
  OpenCrossSaleItemHistory;
  OpenAdvertising;
  LoadAdvertising;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  StopServer;
  FreeAndNil(FConfigFile);
  CloseAdvertising;
  ClosePoleClient;
  CloseCrossSaleItem;
  CloseCrossSaleItemHistory;
end;

procedure TDM.LoadAdvertising;
begin
  if FileExists(FLocalPath + 'SVR_Advertising.xml') then
    cdsAdvertising.LoadFromFile(FLocalPath + 'SVR_Advertising.xml');
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

procedure TDM.SaveAdvertising;
begin
  cdsAdvertising.SaveToFile(FLocalPath + 'SVR_Advertising.xml');
end;

procedure TDM.cdsAdvertisingNewRecord(DataSet: TDataSet);
begin
  cdsAdvertisingDuration.AsInteger           := 10;
  cdsAdvertisingVideoControl.AsBoolean       := False;
  cdsAdvertisingStartDate.AsDateTime         := Trunc(Now);
  cdsAdvertisingEndDate.AsDateTime           := Trunc(IncMonth(Now, 4));
  cdsAdvertisingType.AsInteger               := 1;
  cdsAdvertisingDescription.AsString         := IntToStr(FLastDesc+1);
  cdsAdvertisingDisplayDescription.AsBoolean := False;
  cdsAdvertisingID.AsFloat                   := StrToFloat(FormatDateTime('mmddyyyyhhnnss', now));
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

procedure TDM.RefreshSettings;
begin
  FServerIP           := FConfigFile.ReadString(SVR, SVR_IP, '');
  FServerPort         := FConfigFile.ReadInteger(SVR, SVR_PORT, 7887);
  DMGlobal.IDLanguage := FConfigFile.ReadInteger(SVR, SVR_LANGUAGE, 1);
  StartServer;
end;

procedure TDM.StartServer;
var
  Binding : TIdSocketHandle;
begin

  if IdTCPServer.Active then
    IdTCPServer.Active := False;

  if FServerIP <> '' then
  begin
    IdTCPServer.Bindings.Clear;
    try
      Binding            := IdTCPServer.Bindings.Add;
      Binding.IP         := FServerIP;
      Binding.Port       := FServerPort;
      IdTCPServer.Active := True;
    except
      on E : Exception do
      begin
        ShowMessage(E.Message);
      end;
      end;
  end;
end;

procedure TDM.IdTCPServerException(AThread: TIdPeerThread;
  AException: Exception);
begin
  if AException.Message = 'EIdConnClosedGracefully'  then
  begin
    //process some code here if you want.
  end;
end;

procedure TDM.IdTCPServerExecute(AThread: TIdPeerThread);
var
  ConData: TMRPDSConnectionData;
  HeaderStream, SendingStream,
  ReceivingStream: TMemoryStream;
  SendingHeader: TMRPDSHeader;
begin
  ConData := TMRPDSConnectionData(AThread.Data);

  if AThread.Connection.Connected then
  case ConData.FState of
    STATE_WAITING_HEADER:
    begin
      ReceivingStream := TMemoryStream.Create;
      try
        AThread.Connection.ReadStream(ReceivingStream, SizeOf(TMRPDSHeader));
        ReceivingStream.Seek(0, soFromBeginning);
        ConData.FActualHeader := TMRPDSHeader(ReceivingStream.Memory^);
      finally
        FreeAndNil(ReceivingStream);
      end;
      ConData.FState := STATE_WAITING_BODY;
    end;

    STATE_WAITING_BODY:
    begin
      ReceivingStream := TMemoryStream.Create;
      try
        AThread.Connection.ReadStream(ReceivingStream, ConData.FActualHeader.ByteCount);
        ReceivingStream.Seek(0, soFromBeginning);


        if (ConData.FActualHeader.BodyType in [pdsAdvertising, pdsCrossSaleItem ,pdsCrossSaleItemHistory]) then
        begin
          SendingStream := TMemoryStream.Create;
          try
            HeaderStream := TMemoryStream.Create;
            try
              case ConData.FActualHeader.BodyType of

                pdsAdvertising:
                begin
                  ConData.FDMThread.LoadAdvertiseStream(SendingStream);
                end;

                pdsCrossSaleItem:
                begin
                  ConData.FDMThread.LoadCrossSaleItemStream(SendingStream);
                end;

                pdsCrossSaleItemHistory:
                begin
                  ConData.FDMThread.LoadCrossSaleItemHistoryStream(SendingStream);
                end;


              end;

              SendingHeader.BodyType := ConData.FActualHeader.BodyType;
              SendingHeader.ByteCount := SendingStream.Size;

              HeaderStream.WriteBuffer(SendingHeader, SizeOf(TMRPDSHeader));
              HeaderStream.Seek(0, soFromBeginning);

              AThread.Connection.WriteStream(HeaderStream);
              AThread.Connection.WriteStream(SendingStream);

            finally
              HeaderStream.Clear;
              HeaderStream.Free;
            end;
          finally
            SendingStream.Clear;
            SendingStream.Free;
          end;
        end;
      finally
        FreeAndNil(ReceivingStream);
      end;
      ConData.FState := STATE_WAITING_HEADER;
    end;

  end;

  (*
  AOutPut := AThread.Connection.ReadLn;

  // Requisição
  if Copy(AOutPut, 0, Length(SVR_POLE_DISPLAY_CLIENT + ';')) = (SVR_POLE_DISPLAY_CLIENT+';') then
    AddPoleClient(AOutPut)

  // Retorna CDS de Venda casada
  else if Copy(AOutPut, 0, Length(CROSS_SELL + ';')) = (CROSS_SELL+';') then
  begin
    AInput := RequestCrossSellItem(AOutPut);
    if AInput <> '' then
      AThread.Connection.WriteLn(AInput);
  end

  // Retorna CDS de Advertising
  else if Copy(AOutPut, 0, Length(ADVERTISING_LIST + ';')) = (ADVERTISING_LIST+';') then
  begin
    OpenAdvertising;
    with cdsAdvertising do
    begin
      try
        Filtered := False;
        Filter := 'StartDate <= ' + QuotedStr(FormatDateTime('ddddd', Now)) +
                  ' AND EndDate > ' + QuotedStr(FormatDateTime('ddddd', Now));
        Filtered := True;

        First;
        AInput := '';
        while not EOF do
        begin
          if AInput = '' then
            AInput := FieldByName('ID').AsString
          else if FieldByName('ID').AsString <> '' then
            AInput := AInput + ',' + FieldByName('ID').AsString;
          Next;
        end;
      finally
        Filtered := False;
        Filter := '';
        Filtered := True;
      end;
      AThread.Connection.WriteLn(AInput);
    end;

  // Retorna CDS cada Advertising totalmente e exclusivo pelo ID
  end else if Copy(AOutPut, 0, Length(ADVERTISING_ID)) = (ADVERTISING_ID) then
  begin
    OpenAdvertising;
    with cdsAdvertising do
    begin
      First;
      AInput := '';
      if Locate('ID', ParseParam(AOutPut, ADVERTISING_ID),[]) then
      begin
        AInput := FormatAdvertising(FieldByName('ID').AsString,
                                    FieldByName('Description').AsString,
                                    FieldByName('FileName').AsString,
                                    FormatDateTime('yyyy-mm-dd', FieldByName('StartDate').AsDateTime),
                                    FormatDateTime('yyyy-mm-dd', FieldByName('EndDate').AsDateTime),
                                    FieldByName('DaysOfWeek').AsString,
                                    FieldByName('Type').AsString,
                                    FieldByName('Duration').AsString,
                                    FieldByName('VideoControl').AsString,
                                    FieldByName('DisplayDescription').AsString,
                                    FieldByName('Hours').AsString);

        AThread.Connection.WriteLn(AInput);
      end;
    end;
  end;
  *)
end;

procedure TDM.AddPoleClient(AText: String);
begin

  if (ParseParam(AText, SVR_POLE_DISPLAY_CLIENT_IP) <> '') then
    with cdsPoleDisplayClient do
    begin
      if not Locate('IPAddress', ParseParam(AText, SVR_POLE_DISPLAY_CLIENT_IP), []) then
      begin
        Append;
        FieldByName('ID').AsFloat           := StrToFloat(FormatDateTime('mmddyyyyhhnnss', now));
        FieldByName('Description').AsString := ParseParam(AText, SVR_POLE_DISPLAY_CLIENT_DESCRIPTION);
        FieldByName('IPAddress').AsString   := ParseParam(AText, SVR_POLE_DISPLAY_CLIENT_IP);
        FieldByName('Port').AsInteger       := StrToInt(ParseParam(AText, SVR_POLE_DISPLAY_CLIENT_PORT));
        Post;
        SavePoleClient;
      end;
    end;
    
end;

procedure TDM.ClosePoleClient;
begin
  with cdsPoleDisplayClient do
    if Active then
      Close;
end;

procedure TDM.OpenPoleClient;
begin
  with cdsPoleDisplayClient do
    if not Active then
    begin
      CreateDataSet;
      LoadPoleClient;
    end;
end;

procedure TDM.LoadPoleClient;
begin
  if FileExists(FLocalPath + 'SVR_PoleClient.xml') then
    cdsPoleDisplayClient.LoadFromFile(FLocalPath + 'SVR_PoleClient.xml');
end;

procedure TDM.SavePoleClient;
begin
  try
    cdsPoleDisplayClient.SaveToFile(FLocalPath + 'SVR_PoleClient.xml');
  except
    end;
end;

function TDM.RequestCrossSellItem(AText: String): String;
var
  iCount : Integer;
begin

  Result := '';

  with cdsCrossSaleItem do
    if Locate('ModelNum', ParseParam(AText, CROSS_SELL_ITEM),  []) then
    try
      Filtered := False;
      Filter := 'ModelNum = ' + QuotedStr(ParseParam(AText, CROSS_SELL_ITEM));
      Filtered := True;

      //Save Model to history
      SaveCrossSaleItemHistory(ParseParam(AText, CROSS_SELL_ITEM),
                               ParseParam(AText, CROSS_SELL_REGISTER),
                               Now);
      //Loop Return Item advertising
      iCount := 0;
      First;
      While not EOF do
      begin
        inc(iCount);
        Result := Result + BuildInput(CROSS_ITEMS_FILE + '_' + IntToStr(iCount), FieldByName('FileName').AsString) +
                           BuildInput(CROSS_ITEMS_TYPE + '_' + IntToStr(iCount), FieldByName('FileType').AsString) +
                           BuildInput(CROSS_ITEMS_TIME + '_' + IntToStr(iCount), FieldByName('Duration').AsString);
        Next;
      end;
      Result := CROSS_ITEMS + ';' +
                BuildInput(CROSS_ITEMS_COUNT, intToStr(iCount)) +
                Result;

    finally
      Filtered := False;
      Filter := '';
      Filtered := True;
    end;

end;

procedure TDM.CloseCrossSaleItem;
begin
  with cdsCrossSaleItem do
    if Active then
      Close;
end;

procedure TDM.LoadCrossSaleItem;
begin
  if FileExists(FLocalPath + 'SVR_CrossSaleItem.xml') then
    cdsCrossSaleItem.LoadFromFile(FLocalPath + 'SVR_CrossSaleItem.xml');
end;

procedure TDM.OpenCrossSaleItem;
begin
  with cdsCrossSaleItem do
    if not Active then
    begin
      CreateDataSet;
      LoadCrossSaleItem;
    end;
end;

procedure TDM.SaveCrossSaleItem;
begin
  try
    cdsCrossSaleItem.SaveToFile(FLocalPath + 'SVR_CrossSaleItem.xml');
  except
    end;
end;

procedure TDM.CloseCrossSaleItemHistory;
begin
  with cdsCrossSaleItemHistory do
    if Active then
      Close;
end;

procedure TDM.LoadCrossSaleItemHistory;
begin
  if FileExists(FLocalPath + 'SVR_CrossSaleItemHistory.xml') then
    cdsCrossSaleItemHistory.LoadFromFile(FLocalPath + 'SVR_CrossSaleItemHistory.xml');
end;

procedure TDM.OpenCrossSaleItemHistory;
begin
  with cdsCrossSaleItemHistory do
    if not Active then
    begin
      CreateDataSet;
      LoadCrossSaleItemHistory;
    end;
end;

procedure TDM.SaveCrossSaleItemHistory(AModel, ARegister : String; ADate: TDateTime);
begin

  with cdsCrossSaleItemHistory do
  begin
    Append;
    FieldByName('Model').AsString      := AModel;
    FieldByName('Register').AsString   := ARegister;
    FieldByName('ItemDate').AsDateTime := ADate;
    Post;
  end;

  try
    cdsCrossSaleItemHistory.SaveToFile(FLocalPath + 'SVR_CrossSaleItemHistory.xml');
  except
    end;
    
end;

procedure TDM.RefreshCrossSaleItem;
begin
  CloseCrossSaleItem;
  OpenCrossSaleItem;
end;

procedure TDM.StopServer;
var
  i: Integer;
  Binding: TIdSocketHandle;
begin
  if IdTCPServer.Threads <> nil then
  begin
    with IdTCPServer.Threads.LockList do
    try
      for i := 0 to Count - 1 do
        TIdPeerThread(Items[i]).Connection.DisconnectSocket;
    finally
      IdTCPServer.Threads.UnlockList;
    end;
  end;

  IdTCPServer.Active := False;

  while IdTCPServer.Bindings.Count > 0 do
  begin
    Binding := IdTCPServer.Bindings.Items[0];
    FreeAndNil(Binding);
  end;

  IdTCPServer.Bindings.Clear;
end;

procedure TDM.IdTCPServerConnect(AThread: TIdPeerThread);
begin
  AThread.Data := TMRPDSConnectionData.Create;
  with TMRPDSConnectionData(AThread.Data) do
  begin
    FState := STATE_WAITING_HEADER;
    FDMThread := TDMThread.Create(nil);
  end;
end;

procedure TDM.IdTCPServerDisconnect(AThread: TIdPeerThread);
var
  ThreadData : TMRPDSConnectionData;
begin
  ThreadData := TMRPDSConnectionData(AThread.Data);
  AThread.Data := nil;
  FreeAndNil(ThreadData.FDMThread);
  FreeAndNil(ThreadData);
end;

end.
