unit uDMPetCenter;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, cxContainer, cxEdit, Variants, SyncObjs,
  IdBaseComponent, IdComponent, IdTCPServer, IdSocketHandle, uMRParam, uPetCenterCli,
  Dialogs, ADODB, Provider;

const
  PET_STATUS_AVAILABLE = 1;
  PET_STATUS_ONHOLD    = 2;
  PET_STATUS_ISOLATION = 3;
  PET_STATUS_RETURN    = 4;
  PET_STATUS_SOLD      = 5;
  PET_STATUS_EXCEPTION = 6;

  STATE_WAITING_HEADER = 0;
  STATE_WAITING_BODY = 1;

type
  TMRPetConnectionData = class
    FState: Integer;
    FStreamSizeExpected: LongInt;
    FActualHeader: TInvoiceStreamHeader;
    FConnectionParams: TMRParams;
    FReportData : OleVariant;
    FDefaultPrinter : String;
    FPreview : Boolean;
  end;

  TDMPetCenter = class(TDataModule)
    cxStyleController: TcxEditStyleController;
    cdsRepWarranty: TClientDataSet;
    cdsRepWarrantyIDWarrantyReport: TIntegerField;
    cdsRepWarrantyIDSpecies: TIntegerField;
    cdsRepWarrantyReport: TBlobField;
    cdsRepWarrantyReportDate: TDateTimeField;
    cdsRepWarrantyReportName: TStringField;
    cdsLoadRepWarranty: TClientDataSet;
    cdsLoadRepWarrantyIDWarrantyReport: TIntegerField;
    cdsLoadRepWarrantyIDSpecies: TIntegerField;
    cdsLoadRepWarrantyReport: TBlobField;
    cdsLoadRepWarrantyReportDate: TDateTimeField;
    cdsLoadRepWarrantyReportName: TStringField;
    IdTCPServer: TIdTCPServer;
    cdsSpecies: TClientDataSet;
    cdsSpeciesIDSpecies: TIntegerField;
    cdsSpeciesSpecies: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsLoadRepWarrantyBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure IdTCPServerConnect(AThread: TIdPeerThread);
    procedure IdTCPServerDisconnect(AThread: TIdPeerThread);
    procedure IdTCPServerException(AThread: TIdPeerThread;
      AException: Exception);
    procedure IdTCPServerExecute(AThread: TIdPeerThread);
  private
    FReportsLoaded : Boolean;
    FRepID : Integer;
    FRepField : String;
    //CS: TCriticalSection;
    procedure LoadAllReports;
  public
    function GetWarrantyReport(AFieldName: String; AID : Integer) : TMemoryStream;
    function FormatAddress(AAddress, ACity, AState, AZip : Variant) : String;
    procedure StartPrinterServer;
    procedure StopPrinterServer;
    function SendInventoryDate: Boolean;
    function PrintSale(AIDPreSale : Integer) : Boolean;
  end;

var
  DMPetCenter: TDMPetCenter;

implementation

uses uMRSQLParam, uDMWarrantyPrintThread, uNTierConsts, uDMPet;

{$R *.dfm}

{ TDMPetCenter }

function TDMPetCenter.GetWarrantyReport(AFieldName: String; AID : Integer): TMemoryStream;
begin
  //CS.Enter;
  try
    Result := nil;
    cdsRepWarranty.First;
    FRepField := AFieldName;
    FRepID := AID;
    cdsRepWarranty.First;
    if cdsRepWarranty.Locate(AFieldName, AID, []) then
    begin
      Result := TMemoryStream.Create();
      TBlobField(cdsRepWarranty.FieldByName('Report')).SaveToStream(Result);
      Result.seek(0, soFromBeginning);
    end
    else
    try
      cdsLoadRepWarranty.Open;
      if not cdsLoadRepWarranty.IsEmpty then
      begin
        Result := TMemoryStream.Create();
        TBlobField(cdsLoadRepWarranty.FieldByName('Report')).SaveToStream(Result);
        Result.seek(0, soFromBeginning);
        cdsRepWarranty.Append;
        cdsRepWarranty.FieldByName('IDWarrantyReport').Value := cdsLoadRepWarranty.FieldByName('IDWarrantyReport').Value;
        cdsRepWarranty.FieldByName('IDSpecies').Value := cdsLoadRepWarranty.FieldByName('IDSpecies').Value;
        cdsRepWarranty.FieldByName('ReportDate').Value := cdsLoadRepWarranty.FieldByName('ReportDate').Value;
        cdsRepWarranty.FieldByName('ReportName').Value := cdsLoadRepWarranty.FieldByName('ReportName').Value;
        TBlobField(cdsRepWarranty.FieldByName('Report')).LoadFromStream(Result);
        cdsRepWarranty.Post;
      end;
    finally
      cdsLoadRepWarranty.Close;
    end;
  finally
    //CS.Leave;
  end;
end;

procedure TDMPetCenter.DataModuleCreate(Sender: TObject);
begin
  FReportsLoaded := False;
  //CS := TCriticalSection.Create;
  cdsRepWarranty.CreateDataSet;
end;

procedure TDMPetCenter.DataModuleDestroy(Sender: TObject);
begin
  StopPrinterServer;
  cdsRepWarranty.Close;
  //CS.Free;
end;

procedure TDMPetCenter.cdsLoadRepWarrantyBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try
      if (FRepID <> 0) then
      begin
        AddKey(FRepField).AsInteger := FRepID;
        KeyByName(FRepField).Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

function TDMPetCenter.FormatAddress(AAddress, ACity, AState,
  AZip: Variant): String;
var
  sAddress, sCity, sState, sZip : String;
begin

  if (AAddress <> Null) then
    sAddress := AAddress;

  if (ACity <> Null) then
    sCity := ACity;

  if (AState <> Null) then
    sState := AState;

  if (AZip <> Null) then
    sZip := AZip;

  Result := sAddress + ' ' + sCity;
  if sState <> '' then
    Result := Result + ', ' + sState;
  Result := Result + ' ' + sZip;

end;

procedure TDMPetCenter.IdTCPServerConnect(AThread: TIdPeerThread);
begin

  AThread.Data := TMRPetConnectionData.Create;
  with TMRPetConnectionData(AThread.Data) do
  begin
    FState          := STATE_WAITING_HEADER;
    FDefaultPrinter := DMPet.GetAppProperty('WarrantyRep', 'PrinterName');
    FPreview        := False;

    FConnectionParams := TMRParams.Create;

    FConnectionParams.AddKey(CON_PARAM_TYPE);
    FConnectionParams.KeyByName(CON_PARAM_TYPE).AsString := DMPet.FConType;

    FConnectionParams.AddKey(CON_PARAM_CLIENT_ID);
    FConnectionParams.KeyByName(CON_PARAM_CLIENT_ID).AsString := DMPet.FClientID;

    FConnectionParams.AddKey(CON_PARAM_HOST);
    FConnectionParams.KeyByName(CON_PARAM_HOST).AsString := DMPet.FHost;

    FConnectionParams.AddKey(CON_PARAM_PORT);
    FConnectionParams.KeyByName(CON_PARAM_PORT).AsString := DMPet.FPort;

    FConnectionParams.AddKey(CON_PARAM_SOFTWARE);
    FConnectionParams.KeyByName(CON_PARAM_SOFTWARE).AsString := DMPet.FSoftware;

    FReportData := cdsRepWarranty.Data;
  end;

end;

procedure TDMPetCenter.IdTCPServerDisconnect(AThread: TIdPeerThread);
var
  ThreadData : TMRPetConnectionData;
begin

  ThreadData := TMRPetConnectionData(AThread.Data);
  FreeAndNil(ThreadData.FConnectionParams);
  AThread.Data := nil;
  FreeAndNil(ThreadData);
  
end;

procedure TDMPetCenter.IdTCPServerException(AThread: TIdPeerThread;
  AException: Exception);
begin

  if AException.Message = 'EIdConnClosedGracefully'  then
  begin
    //process some code here if you want.
  end;

end;

procedure TDMPetCenter.IdTCPServerExecute(AThread: TIdPeerThread);
var
  ReceivingStream : TMemoryStream;
  ConData : TMRPetConnectionData;
  FInvoiceInfo : TInvoiceInfo;
  FDMThread : TDMWarrantyPrintThread;
begin

  ConData := TMRPetConnectionData(AThread.Data);

  if AThread.Connection.Connected then
    case ConData.FState of
      STATE_WAITING_HEADER:
      begin
        ReceivingStream := TMemoryStream.Create;
        try
          AThread.Connection.ReadStream(ReceivingStream, SizeOf(TInvoiceStreamHeader));
          ReceivingStream.Seek(0, soFromBeginning);
          ConData.FActualHeader := TInvoiceStreamHeader(ReceivingStream.Memory^);
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

          case ConData.FActualHeader.PCComponentType of
            ictInvoice:
            begin
              FInvoiceInfo := TInvoiceInfo(ReceivingStream.Memory^);
              FDMThread := TDMWarrantyPrintThread.Create(nil);
              try
                with FDMThread do
                try
                  Preview             := ConData.FPreview;
                  DefaulPrinter       := ConData.FDefaultPrinter;
                  cdsRepWarranty.Data := ConData.FReportData;
                  ConnectionParams    := ConData.FConnectionParams;
                  PrintWarrantyFromMainRetail(FInvoiceInfo.IDPreSale);
                except
                  //on e: exception do
                  //  Writeln(e.message);
                end;
              finally
                FreeAndNil(FDMThread);
              end;
            end;
          end;

        finally
          FreeAndNil(ReceivingStream);
        end;
        ConData.FState := STATE_WAITING_HEADER;
      end;
    end;

end;

procedure TDMPetCenter.StartPrinterServer;
var
  Binding : TIdSocketHandle;
begin

  {
  if IdTCPServer.Active then
    IdTCPServer.Active := False;

  IdTCPServer.Bindings.Clear;
  try
    Binding            := IdTCPServer.Bindings.Add;
    Binding.IP         := DMPet.GetAppProperty('PrintServer', 'ServerIP');
    Binding.Port       := StrToIntDef(DMPet.GetAppProperty('PrintServer', 'ServerPort'), 1555);
    IdTCPServer.Active := True;
    LoadAllReports;
  except
    on E : Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
  }

  try
    LoadAllReports;
  except
    on E : Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;


end;

procedure TDMPetCenter.StopPrinterServer;
var
  i: Integer;
  Binding: TIdSocketHandle;
begin

  {if IdTCPServer.Threads <> nil then
  begin
    with IdTCPServer.Threads.LockList do
    try
      for i := 0 to Count - 1 do
        TIdPeerThread(Items[i]).Connection.DisconnectSocket;
    finally
      IdTCPServer.Threads.UnlockList;
    end;
  end;

  if IdTCPServer.Active then
  begin
    IdTCPServer.Active := False;
    while IdTCPServer.Bindings.Count > 0 do
    begin
      Binding := IdTCPServer.Bindings.Items[0];
      FreeAndNil(Binding);
    end;
    IdTCPServer.Bindings.Clear;
  end;
  }

end;

procedure TDMPetCenter.LoadAllReports;
var
  MS : TMemoryStream;
begin

  if not FReportsLoaded then
  begin
    FReportsLoaded := True;
    with cdsSpecies do
    try
      if not Active then
        Open;
      First;
      while not EOF do
      begin
        MS := GetWarrantyReport('IDSpecies', FieldByName('IDSpecies').AsInteger);
        try
        finally
          MS.Free;
          end;
        Next;
      end;
    finally
      Close;
    end;
  end;
  
end;

function TDMPetCenter.SendInventoryDate: Boolean;
begin

end;

function TDMPetCenter.PrintSale(AIDPreSale : Integer): Boolean;
var
  FDMThread : TDMWarrantyPrintThread;
  FConnectionParams: TMRParams;
begin

  Result := False;

  FConnectionParams := TMRParams.Create;
  try

    FConnectionParams.AddKey(CON_PARAM_TYPE);
    FConnectionParams.KeyByName(CON_PARAM_TYPE).AsString := DMPet.FConType;

    FConnectionParams.AddKey(CON_PARAM_CLIENT_ID);
    FConnectionParams.KeyByName(CON_PARAM_CLIENT_ID).AsString := DMPet.FClientID;

    FConnectionParams.AddKey(CON_PARAM_HOST);
    FConnectionParams.KeyByName(CON_PARAM_HOST).AsString := DMPet.FHost;

    FConnectionParams.AddKey(CON_PARAM_PORT);
    FConnectionParams.KeyByName(CON_PARAM_PORT).AsString := DMPet.FPort;

    FConnectionParams.AddKey(CON_PARAM_SOFTWARE);
    FConnectionParams.KeyByName(CON_PARAM_SOFTWARE).AsString := DMPet.FSoftware;

    FDMThread := TDMWarrantyPrintThread.Create(nil);
    try
      with FDMThread do
      try
        Preview             := False;
        DefaulPrinter       := DMPet.GetAppProperty('WarrantyRep', 'PrinterName');
        cdsRepWarranty.Data := Self.cdsRepWarranty.Data;
        ConnectionParams    := FConnectionParams;
        Result := PrintWarrantyFromMainRetail(AIDPreSale);
      except
        //on e: exception do
        //  Writeln(e.message);
      end;
    finally
      FreeAndNil(FDMThread);
    end;
  finally
    freeAndNil(FConnectionParams);
  end;

end;

end.
