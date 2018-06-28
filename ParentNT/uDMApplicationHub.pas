unit uDMApplicationHub;

interface

uses
  SysUtils, Classes, DB, DBClient, MConnect, SConnect, Forms, uNTDataSetControl,
  uNTUpdateControl, uNTTraceControl, cxContainer, cxEdit;

const
  FK_ERROR_ID = 'COLUMN REFERENCE constraint';

type
  TDMApplicationHub = class(TDataModule)
    conDCOM: TDCOMConnection;
    conTeste: TSharedConnection;
    conSocket: TSocketConnection;
    conWeb: TWebConnection;
    conLookup: TSharedConnection;
    scEdit: TcxEditStyleController;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    fClientID,
    fStore,
    fStation : String;
    FDataSetControl: TmrDataSetControl;
    FUpdateControl: TmrUpdateControl;
    FActiveConnection: TDispatchConnection;
    FTraceControl: TmrTraceControl;
    procedure SetConnectionProperties;
    procedure ReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure ShowFKError(aFKName: String);
    function ExtractConstraintName(aMessage: String): String;
  public
    property ActiveConnection: TDispatchConnection read FActiveConnection write FActiveConnection;
    property DataSetControl: TmrDataSetControl read FDataSetControl write FDataSetControl;
    property UpdateControl: TmrUpdateControl read FUpdateControl write FUpdateControl;
    property TraceControl: TmrTraceControl read FTraceControl write FTraceControl;
  end;

var
  DMApplicationHub: TDMApplicationHub;

implementation

uses IniFiles, uHandleException, mrMsgBox;

{$R *.dfm}

procedure TDMApplicationHub.DataModuleCreate(Sender: TObject);
begin
  SetConnectionProperties;

  FDataSetControl := TmrDataSetControl.Create(Self);
  FDataSetControl.Connection := ActiveConnection;
  FDataSetControl.OnReconcileError := ReconcileError;

  FUpdateControl := TmrUpdateControl.Create;
  FUpdateControl.Connection := ActiveConnection;
  FUpdateControl.OnReconcileError := ReconcileError;

  FTraceControl := TmrTraceControl.Create;
  FTraceControl.Connection := ActiveConnection;
end;

procedure TDMApplicationHub.DataModuleDestroy(Sender: TObject);
begin
  FActiveConnection.AppServer.Logout(fClientID);
  FActiveConnection.Connected := False;
end;

procedure TDMApplicationHub.ReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := raCancel;
  // RollBack a exist Transaction
  if ActiveConnection.AppServer.InTransaction then
    ActiveConnection.AppServer.RollBackTransaction;

  if (UpdateKind = ukDelete) and (ExtractConstraintName(E.Message) <> '') then
    ShowFKError(ExtractConstraintName(E.Message))
  else
    raise EmrReconcileError.Create(E.Message, UpdateKind);
end;

procedure TDMApplicationHub.SetConnectionProperties;
var
  ConType: String;
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'AppClient.ini') do
  try
    ConType := ReadString('Connection', 'Type', '');
    fClientID := ReadString('Connection', 'ClientID', '');
    fStore    := ReadString('Connection', 'Store', '');
    fStation  := ReadString('Connection', 'Station', '');

    if ConType = 'SOCKET' then
    begin
      FActiveConnection := conSocket;
      TSocketConnection(FActiveConnection).Host := ReadString('Connection', 'Host', '');
    end
    else if ConType = 'DCOM' then
    begin
      FActiveConnection := conDCOM;
      TDCOMConnection(FActiveConnection).ComputerName := ReadString('Connection', 'Host', '');
    end
    else if ConType = 'WEB' then
    begin
      FActiveConnection := conWeb;
      TWebConnection(FActiveConnection).Proxy := ReadString('Connection', 'Host', '');
    end;

    conTeste.ParentConnection := FActiveConnection;
    FActiveConnection.ServerName := ReadString('Connection', 'ServerName', '');
    FActiveConnection.ServerGUID := ReadString('Connection', 'ServerGUID', '');
    FActiveConnection.Connected := True;
    FActiveConnection.AppServer.Login(fClientID, fStore, fStation);
  finally
    Free;
  end;
end;

procedure TDMApplicationHub.ShowFKError(aFKName: String);
var
  sTableName: String;
begin
  //sTableName := ActiveConnection.AppServer.GetTableNameByFK(aFKName);
  MsgBox('Registro não pode ser deletado._Ele possui referência na tabela [' + sTableName + '].', vbOkOnly +vbWaring);
end;

function TDMApplicationHub.ExtractConstraintName(aMessage: String): String;
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

end.
