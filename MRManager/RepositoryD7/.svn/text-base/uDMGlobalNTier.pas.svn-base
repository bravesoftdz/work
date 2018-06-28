unit uDMGlobalNTier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMGlobal, SConnect, DB, DBClient, MConnect, ImgList, siComp,
  uNTDataSetControl, uNTUpdateControl, uNTTraceControl;

const
  CON_TYPE_DCOM   = 'DCOM';
  CON_TYPE_SOCKET = 'SOCKET';
  CON_TYPE_WEB    = 'WEB';
  FK_ERROR_ID     = 'COLUMN REFERENCE constraint';

type
  TDMGlobalNTier = class(TDMGlobal)
    DCOMConn: TDCOMConnection;
    SocketConn: TSocketConnection;
    WebConn: TWebConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FActiveConnection : TDispatchConnection;
    FDataSetControl: TmrDataSetControl;
    FUpdateControl: TmrUpdateControl;
    FTraceControl: TmrTraceControl;

    procedure SetParentConnection;
    procedure ActiveConnAfterConnect(Sender: TObject);
    procedure ActiveConnBeforeDisconnect(Sender: TObject);
    procedure ReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    function GetFKError(aFKName: String) : String;
    function ExtractConstraintName(aMessage: String): String;
  protected
    procedure CreateControls;
    procedure DestroyControls;
    procedure OnAfterConnect; virtual;
  public
    FClientID, FConType, FHost, FPort, FSoftware: String;
    procedure SetConnectionProperties;
    procedure OpenConnection;
    procedure CloseConnection;

    property ActiveConnection: TDispatchConnection read FActiveConnection write FActiveConnection;
    property DataSetControl: TmrDataSetControl read FDataSetControl write FDataSetControl;
    property UpdateControl: TmrUpdateControl read FUpdateControl write FUpdateControl;
    property TraceControl: TmrTraceControl read FTraceControl write FTraceControl;
  end;

var
  DMGlobalNTier: TDMGlobalNTier;

implementation

uses uOperationSystem, uHandleException, uMsgBox;

{$R *.dfm}

{ TDMGlobalNTier }

procedure TDMGlobalNTier.CloseConnection;
begin
  if FActiveConnection.Connected then
    FActiveConnection.Connected := False;
end;

procedure TDMGlobalNTier.OpenConnection;
begin
  if not FActiveConnection.Connected then
  try
    FActiveConnection.Connected := True;
  except
    on E: Exception do
    begin
      FActiveConnection.Connected := False;
      raise Exception.Create('It was not possible to establish a connection with the server.');
    end;
  end;
end;

procedure TDMGlobalNTier.SetConnectionProperties;
begin
  with FAppInfo do
  begin
    FConType   := ReadString('Connection', 'Type', '');
    FClientID := ReadString('Connection', 'ClientID', '');
    FHost     := ReadString('Connection', 'Host', '');
    FPort     := ReadString('Connection', 'Port', '');

    if FConType = '' then
    begin
      WriteString('Connection', 'Type', CON_TYPE_DCOM);
      FConType := ReadString('Connection', 'Type', '');
    end;

    if fClientID = '' then
    begin
      WriteString('Connection', 'ClientID', 'Cliente1');
      FClientID := ReadString('Connection', 'ClientID', '');
    end;

    if FHost = '' then
    begin
      WriteString('Connection', 'Host', 'Desenv001');
      FHost := ReadString('Connection', 'Host', '');
    end;

    if FPort = '' then
    begin
      WriteString('Connection', 'Port', '211');
      FPort := ReadString('Connection', 'Port', '');
    end;

    if FConType = CON_TYPE_SOCKET then
    begin
      FActiveConnection := SocketConn;
      TSocketConnection(FActiveConnection).Host := FHost;
      TSocketConnection(FActiveConnection).Port := strToIntDef(FPort, 211);
    end
    else if FConType = CON_TYPE_DCOM then
    begin
      FActiveConnection := DCOMConn;
      TDCOMConnection(FActiveConnection).ComputerName := FHost;
    end
    else if FConType = CON_TYPE_WEB then
    begin
      FActiveConnection := WebConn;
      TWebConnection(FActiveConnection).Proxy := FHost;
    end;
  end;

  FSoftware := Application.Title + ' (' + ReturnComputerName + ')';
  SetParentConnection;
  FActiveConnection.AfterConnect := ActiveConnAfterConnect;
  FActiveConnection.BeforeDisconnect := ActiveConnBeforeDisconnect;
end;

procedure TDMGlobalNTier.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SetConnectionProperties;
end;

procedure TDMGlobalNTier.SetParentConnection;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount-1 do
    if (Self.Components[i] is TSharedConnection) then
      TSharedConnection(Self.Components[i]).ParentConnection := FActiveConnection;
end;

procedure TDMGlobalNTier.DataModuleDestroy(Sender: TObject);
begin
  CloseConnection;
  DestroyControls; 
  inherited;
end;

procedure TDMGlobalNTier.ActiveConnAfterConnect(Sender: TObject);
begin
  FActiveConnection.AppServer.LogIn(fClientID, FSoftware);
  OnAfterConnect;
end;

procedure TDMGlobalNTier.ActiveConnBeforeDisconnect(Sender: TObject);
begin
  FActiveConnection.AppServer.LogOut(fClientID, FSoftware);
end;

procedure TDMGlobalNTier.CreateControls;
begin
  FDataSetControl := TmrDataSetControl.Create(Self);
  FDataSetControl.Connection := ActiveConnection;
  FDataSetControl.OnReconcileError := ReconcileError;

  FUpdateControl := TmrUpdateControl.Create;
  FUpdateControl.Connection := ActiveConnection;
  FUpdateControl.OnReconcileError := ReconcileError;

  FTraceControl := TmrTraceControl.Create;
  FTraceControl.Connection := ActiveConnection;
end;

procedure TDMGlobalNTier.DestroyControls;
begin
  if Assigned(FDataSetControl) then
    FreeAndNil(FDataSetControl);

  if Assigned(FUpdateControl) then
    FreeAndNil(FUpdateControl);

  if Assigned(FTraceControl) then
    FreeAndNil(FTraceControl);
end;

procedure TDMGlobalNTier.ReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Action := raCancel;
  // RollBack a exist Transaction
  if ActiveConnection.AppServer.InTransaction then
    ActiveConnection.AppServer.RollBackTransaction;

  if (UpdateKind = ukDelete) and (ExtractConstraintName(E.Message) <> '') then
    raise Exception.Create(GetFKError(ExtractConstraintName(E.Message)))
  else
    raise Exception.Create(E.Message);
end;

function TDMGlobalNTier.ExtractConstraintName(aMessage: String): String;
var
  iBegin, iEnd: integer;
begin
  iBegin := POS(FK_ERROR_ID, aMessage);
  Result := '';
  if iBegin <> 0 then
  begin
    Result := Copy(aMessage, iBegin + Length(FK_ERROR_ID)+2, Length(aMessage));
    iEnd := POS('''', Result);
    Result := Copy (Result, 1, iEnd-1);
  end;
end;

function TDMGlobalNTier.GetFKError(aFKName: String) : String;
var
  sTableName: String;
begin
  //sTableName := ActiveConnection.AppServer.GetTableNameByFK(aFKName);
  Result := 'Record cannot be deleted._It has reference to another table [' + sTableName + '].';
end;

procedure TDMGlobalNTier.OnAfterConnect;
begin
  //Para ser herdado
end;

end.
