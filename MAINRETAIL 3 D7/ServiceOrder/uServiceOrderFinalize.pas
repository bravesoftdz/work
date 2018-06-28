unit uServiceOrderFinalize;

interface

uses
  ADODB, uMRTraceControl, Contnrs, uDMServiceOrder;

type
  TServiceOrderFinalize = class
  private
    FADOConnection  : TADOConnection;
    FTraceControl   : TMRTraceControl;
    FIDServiceOrder : Integer;
    FSQLCommand     : TADOCommand;
    FIDUser         : Integer;
    FIDStore        : Integer;

    function UpdateserviceOrderItems : Boolean;
    function UpdateServiceOrder : Boolean;

  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl);
    destructor Destroy; Override;

    property IDServiceOrder : Integer   read FIDServiceOrder  write FIDServiceOrder;
    property IDUser         : Integer   read FIDUser          write FIDUser;
    property IDStore        : Integer   read FIDStore         write FIDStore;

    function ProccessServiceOrder(var AError : String) : Boolean;
  end;


implementation

uses SysUtils;

{ TServiceOrderFinalize }

constructor TServiceOrderFinalize.Create(AADOConnection: TADOConnection;
  ATraceControl: TMrTraceControl);
begin
  FADOConnection := AADOConnection;
  FTraceControl  := ATraceControl;
  FSQLCommand    := TADOCommand.Create(nil);

  FSQLCommand.Connection := FADOConnection;
end;

destructor TServiceOrderFinalize.Destroy;
begin
  FreeAndNil(FSQLCommand);
  inherited;
end;

function TServiceOrderFinalize.ProccessServiceOrder(var AError: String): Boolean;
begin

  Result := False;

  FTraceControl.TraceIn('TSaleFinalize.ProccessServiceOrder');

  FADOConnection.BeginTrans;

  try
    //1 - Atualiza os campos do Service Order
    UpdateServiceOrder;
    //2 - Atualiza os itens do Service Order
    UpdateserviceOrderItems;

    FADOConnection.CommitTrans;
    
    Result := True;
  except
    on E: Exception do
    begin
      FADOConnection.RollbackTrans;
      Result := False;
      AError := E.Message;
      FTraceControl.SaveTrace(IDUser, AError, 'TSaleFinalize');
    end;
  end;

  FTraceControl.TraceOut;

end;

function TServiceOrderFinalize.UpdateServiceOrder: Boolean;
begin

  Result := False;

  FTraceControl.TraceIn('TServiceOrderFinalize.UpdateServiceOrder');

  try
    with FSQLCommand do
    begin
      CommandText := 'UPDATE Ser_Serviceorder ' +
                     'SET SOCloseDate = :SOCloseDate, IDSOStatus = :IDSOStatus ' +
                     'WHERE IDServiceOrder = :IDServiceOrder';

      Parameters.ParamByName('SOCloseDate').Value    := Now;
      Parameters.ParamByName('IDSOStatus').Value     := SO_STATUS_CLOSE;
      Parameters.ParamByName('IDServiceOrder').Value := IDServiceOrder;
      Execute;
    end;

  except
    on E: Exception do
      raise Exception.Create('-100: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

function TServiceOrderFinalize.UpdateserviceOrderItems: Boolean;
begin

  Result := False;

  FTraceControl.TraceIn('TServiceOrderFinalize.UpdateserviceOrderItems');

  try
    with FSQLCommand do
    begin
      CommandText := 'UPDATE Ser_SOItem ' +
                     'SET EndDate = :EndDate ' +
                     'WHERE IDServiceOrder = :IDServiceOrder AND EndDate IS NULL ';

      Parameters.ParamByName('EndDate').Value        := Now;
      Parameters.ParamByName('IDServiceOrder').Value := IDServiceOrder;
      Execute;
    end;

  except
    on E: Exception do
      raise Exception.Create('-101: ' + E.Message);
  end;

  FTraceControl.TraceOut;

end;

end.
