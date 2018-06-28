unit uPayment;

interface

uses
  SysUtils, ADODB, uMRTraceControl, uDocumentInfo, Dialogs;

type
  TPayment = class
  private
    FIDStore: Integer;
    FIDCashRegMov: Integer;
    FIDCustomer: Integer;
    FPaymentDate: TDateTime;
    FIDCentroCusto: Integer;
    FIDLancamentoTipo: Integer;
    FIDContaCorrente: Integer;
    FIDEmpresa: Integer;
    FSucessMsg: String;
    FPaymentIndex: Integer;
    FDocumentType: TDocumentType;
    FIDServiceOrder: Integer;
    FPaymentMemo: String;
    FSaveIdPaymentDebitCard: integer;
    procedure setSaveIdPaymentDebitCard(const Value: integer);
    procedure UpdateCashRegMov;
    procedure SetDefaultValues;
    function GetNewIDPayment: Integer;
    function GetInsertParameters: String;
  protected
    // Alex 09/27/2015
    FPaymentType : String;

    FADOConnection: TADOConnection;
    FTraceControl: TMRTraceControl;
    FIDUser: Integer;
    FIDPreSale: Integer;
    FIDPaymentType: Integer;
    FPaymentValue: Currency;
    // Antonio M F Souza, Jan 18 2013
    FInvoiceValueFromCashRegister: Currency;
    FIDMeioPrevisto: Integer;

    FIDPayment: Integer;
    FErrorMsg: String;
    FRemovePaymentWhenDeleting : Boolean;  // Alex 10/05/2015 

    procedure InsertPayment;
    procedure FillParameters(ACmdPayment : TADOCommand); virtual;
    procedure BeforeProcessPayment; virtual;
    procedure OnProcessPayment; virtual;
    procedure AfterProcessPayment; virtual;
    procedure BeforeDeletePayment; virtual;
    procedure SetProperties(ADSPayment: TADODataSet); virtual;
    procedure setIdMeioPrevisto(arg_cardType: String);
    function getIdMeioPrevisto(): Integer;


    function GetAutoProcess: Boolean; virtual;
    function GetSQLFields: String; virtual;
    function CanUpdateCashregMov : Boolean; virtual;
  public
    constructor Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl); virtual;
    procedure LoadPayment;
    function ValidatePayment: Boolean; virtual;
    function ProcessPayment: Boolean;
    function GetPaymentType: Integer; virtual;
    function CanDelete: Boolean; virtual;
    function DeletePayment: Boolean;

    property ADOConnection: TADOConnection read FADOConnection write FADOConnection;
    property TraceControl: TMRTraceControl read FTraceControl write FTraceControl;
    property AutoProcess: Boolean read GetAutoProcess;
    property PaymentIndex: Integer read FPaymentIndex write FPaymentIndex;
    property IDPayment: Integer read FIDPayment write FIDPayment;
    property IDPreSale: Integer read FIDPreSale write FIDPreSale;
    property IDServiceOrder: Integer read FIDServiceOrder write FIDServiceOrder;
    property IDStore: Integer read FIDStore write FIDStore;
    property IDCashRegMov: Integer read FIDCashRegMov write FIDCashRegMov;
    property IDUser: Integer read FIDUser write FIDUser;
    property IDCustomer: Integer read FIDCustomer write FIDCustomer;
    property IDPaymentType: Integer read FIDPaymentType write FIDPaymentType;
    property PaymentDate: TDateTime read FPaymentDate write FPaymentDate;
    property PaymentValue: Currency read FPaymentValue write FPaymentValue;
    property IDCentroCusto: Integer read FIDCentroCusto write FIDCentroCusto;
    property IDLancamentoTipo: Integer read FIDLancamentoTipo write FIDLancamentoTipo;
    property IDContaCorrente: Integer read FIDContaCorrente write FIDContaCorrente;
    property IDEmpresa: Integer read FIDEmpresa write FIDEmpresa;
    property ErrorMsg: String read FErrorMsg write FErrorMsg;
    property SucessMsg: String read FSucessMsg write FSucessMsg;
    property PaymentMemo: String read FPaymentMemo write FPaymentMemo;

    //amfsouza 04.15.2011 - to force identification when debit card.
    property SaveIdPaymentDebitCard: integer write setSaveIdPaymentDebitCard;

    property DocumentType: TDocumentType read FDocumentType write FDocumentType;
    property InvoiceValueFromCashRegister: Currency read FInvoiceValueFromCashRegister write FInvoiceValueFromCashRegister;
  end;

implementation

uses Classes, DB, uSystemConst, Math, Variants, uDebugFunctions, uDM;

{ TPayment }

constructor TPayment.Create(AADOConnection: TADOConnection; ATraceControl: TMrTraceControl);
begin
  FADOConnection := AADOConnection;
  FTraceControl := ATraceControl;

  FRemovePaymentWhenDeleting := True; // Alex 10/05/2015
end;

procedure TPayment.InsertPayment;
var
  CmdPayment : TADOCommand;
begin
  FTraceControl.TraceIn(Self.ClassName + '.InsertPayment');

  SetDefaultValues;
  FIDPayment := GetNewIDPayment;

  CmdPayment := TADOCommand.Create(nil);
  with CmdPayment do
  try
    Connection := FADOConnection;
    CommandText := 'INSERT INTO Fin_Lancamento (' + GetSQLFields + ')' +
                   'VALUES (' + GetInsertParameters + ')';

    FillParameters(CmdPayment);
//    showmessage(CommandText);

    Execute;

    //after insert in database I need reset to avoid mistakes.
    FSaveIdPaymentDebitCard := 0

  finally
    FreeAndNil(CmdPayment);
  end;

  FTraceControl.TraceOut;
end;

function TPayment.CanDelete: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.CanDelete');

 // showmessage('can delete');

  with TADODataSet.Create(nil) do
  try
    try
      Connection := FADOConnection;
      CommandText := 'SELECT * FROM Fin_LancQuit (NOLOCK) WHERE IDLancamento = :IDLancamento';
      Parameters.ParamByName('IDLancamento').Value := FIDPayment;
      Open;

      Result := IsEmpty;
    finally
      Free;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ErrorMsg := E.Message;
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TPayment.ProcessPayment: Boolean;
begin
  (* I think we have be a hook in that method to configure correct config *)
  FTraceControl.TraceIn(Self.ClassName + '.ProcessPayment');
  Result := True;

  try
    if ValidatePayment then
    begin
      //Antonio: BeforeProcessPayment will be called by a child class of TPayment (
      BeforeProcessPayment;

      try
        FADOConnection.BeginTrans;
        InsertPayment;
        UpdateCashRegMov;
        OnProcessPayment;
        FADOConnection.CommitTrans;
      except
         on E: Exception do
          begin
            Result := False;
            FADOConnection.RollbackTrans;
            ErrorMsg := E.Message;
            //FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
          end;
      end;

      AfterProcessPayment;
    end;
   except
     on E: Exception do
      begin
        Result := False;
        ErrorMsg := E.Message;
        //FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
      end;
   end;

  FTraceControl.TraceOut;
end;

function TPayment.DeletePayment: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.DeletePayment');
  Result := True;

      // Alex 10/05/2015
  //if ( FRemovePaymentWhenDeleting = False ) Then begin
     BeforeDeletePayment();
  // end;

  if ( FRemovePaymentWhenDeleting = False ) Then begin
     exit;
  end;

  try
    with TADOCommand.Create(nil) do
    try
      Connection := FADOConnection;
      CommandText := 'DELETE Fin_Lancamento WHERE IDLancamento = :IDLancamento';
      Parameters.ParamByName('IDLancamento').Value := FIDPayment;
      Execute;
    finally
      Free;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      ErrorMsg := E.Message;
      FTraceControl.SaveTrace(FIDUser, E.Message, Self.ClassName);
    end;
  end;

  FTraceControl.TraceOut;
end;

function TPayment.ValidatePayment: Boolean;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ValidatePayment');
  Result := FIDPayment = 0;
  FTraceControl.TraceOut;
end;

function TPayment.GetNewIDPayment: Integer;
begin
  FTraceControl.TraceIn(Self.ClassName + '.GetNewIDLancamento');
  Result := 0;

  with TADOStoredProc.Create(nil) do
  try
    Connection := FADOConnection;
    ProcedureName := 'sp_Sis_GetNextCode;1';
    Parameters.Refresh;
    Parameters.ParamByName('@Tabela').Value := 'Fin_Lancamento.IDLancamento';
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

procedure TPayment.UpdateCashRegMov;
begin
  FTraceControl.TraceIn(Self.ClassName + '.ValidatePayment');
  if (FIDCashRegMov <> 0) and CanUpdateCashregMov then
  begin
    with TADOCommand.Create(nil) do
    try
      Connection := FADOConnection;
      CommandText := 'UPDATE CashRegMov ' +
                     'SET TotalSales = IsNull(TotalSales, 0) + ROUND(IsNull(:Value,0),2) ' +
                     'WHERE IDCashRegMov = :IDCashRegMov';
      Parameters.ParamByName('IDCashRegMov').Value := FIDCashRegMov;
      Parameters.ParamByName('Value').Value := FPaymentValue;
      Execute;
    finally
      Free;
    end;
  end;

  FTraceControl.TraceOut;
end;

function TPayment.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_CASH;
end;

function TPayment.GetSQLFields: String;
var
  IDField: String;

begin

  case FDocumentType of
    dtInvoice: IDField := 'IDPreSale';
    dtServiceOrder: IDField := 'IDServiceOrder';
  end;


  Result := 'IDLancamento,' +
            IDField + ',' +
            'IDCashRegMov,' +
            'IDEmpresa,' +
            'IDPessoa,' +
            'IDUsuarioLancamento,' +
            'IDLancamentoTipo,' +
            'IDCentroCusto,' +
            'IDContaCorrentePrevista,' +
            'Pagando,' +
            'IDQuitacaoMeioPrevisto,' +
            'DataLancamento,' +
            'DataVencimento,' +
            'ValorNominal,' +
            'Situacao';
end;

function TPayment.GetInsertParameters: String;
begin
  Result := ':' + StringReplace(GetSQLFields, ',', ',:', [rfReplaceAll]);
end;

procedure TPayment.SetDefaultValues;
begin
  FTraceControl.TraceIn(Self.ClassName + '.SetDefaultValues');

  with TADODataSet.Create(nil) do
  try
    Connection := FADOConnection;
    CommandText := 'SELECT ' +
                   '  S.IDCentroCusto, ' +
                   '  MPS.IDContaCorrente, ' +
                   '  S.IDEmpresa, ' +
                   '  MP.IDLancamentoTipo ' +
                   'FROM ' +
                   '  Store S (NOLOCK) ' +
                   '  JOIN MeioPagToStore MPS (NOLOCK) ON (S.IDStore = MPS.IDStore) ' +
                   '  JOIN MeioPag MP (NOLOCK) ON (MPS.IDMeioPag = MP.IDMeioPag) ' +
                   'WHERE ' +
                   '  S.IDStore = :IDStore ' +
                   '  AND MPS.IDMeioPag = :IDMeioPag';
    Parameters.ParamByName('IDStore').Value := FIDStore;
    Parameters.ParamByName('IDMeioPag').Value := FIDPaymentType;
    Open;

    FIDCentroCusto    := FieldByName('IDCentroCusto').AsInteger;
    FIDContaCorrente  := FieldByName('IDContaCorrente').AsInteger;
    FIDLancamentoTipo := FieldByName('IDLancamentoTipo').AsInteger;
    FIDEmpresa := FieldByName('IDEmpresa').AsInteger;
  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

procedure TPayment.OnProcessPayment;
begin
  // para ser herdado
end;

procedure TPayment.FillParameters(ACmdPayment: TADOCommand);
begin
  with ACmdPayment do
  begin
    Parameters.ParamByName('IDLancamento').Value := FIDPayment;

    case FDocumentType of
      dtInvoice:
                 begin
                 Parameters.ParamByName('IDPreSale').Value    := FIDPreSale;
                 end;
      dtServiceOrder:
                 begin
                 Parameters.ParamByName('IDServiceOrder').Value := FIDServiceOrder;
                 end;
    end;

    Parameters.ParamByName('IDCashRegMov').Value            := FIDCashRegMov;
    Parameters.ParamByName('IDEmpresa').Value               := FIDEmpresa;
    Parameters.ParamByName('IDPessoa').Value                := FIDCustomer;
    Parameters.ParamByName('IDUsuarioLancamento').Value     := FIDUser;
    Parameters.ParamByName('IDLancamentoTipo').Value        := FIDLancamentoTipo;
    Parameters.ParamByName('IDCentroCusto').Value           := FIDCentroCusto;
    Parameters.ParamByName('IDContaCorrentePrevista').Value := FIDContaCorrente;
    Parameters.ParamByName('Pagando').Value                 := 0;

   // # changing this point to get IDquitacaoMeioPrevisto based on mapping in client parameter
   parameters.ParamByName('IDQuitacaoMeioPrevisto').Value := getIdMeioPrevisto();

   (*
    //amfsouza 04.15.2011
    if ( FSaveIdPaymentDebitCard > 0 ) then
        Parameters.ParamByName('IDQuitacaoMeioPrevisto').Value  := FSaveIdPaymentDebitCard
    else
        Parameters.ParamByName('IDQuitacaoMeioPrevisto').Value  := FIDPaymentType;
    *)

    Parameters.ParamByName('DataLancamento').Value          := FPaymentDate;
    Parameters.ParamByName('DataVencimento').Value          := FPaymentDate;
    Parameters.ParamByName('ValorNominal').Value            := FPaymentValue;
    Parameters.ParamByName('Situacao').Value                := 1;
  end;
end;

procedure TPayment.AfterProcessPayment;
begin
  // para ser herdado
end;

procedure TPayment.BeforeProcessPayment;
begin
  // para ser herdado
end;

procedure TPayment.LoadPayment;
var
  DSPayment: TADODataSet;
begin
  FTraceControl.TraceIn(Self.ClassName + '.LoadPayment');

  DSPayment := TADODataSet.Create(nil);

  with DSPayment do
  try
    Connection := FADOConnection;

    case FDocumentType of
      dtInvoice: CommandText := 'SELECT ' + StringReplace(GetSQLFields, 'IDPreSale', 'L.IDPreSale', [rfReplaceAll]) + ',IDStore' +
                   ' FROM Fin_Lancamento L (NOLOCK) ' +
                   ' JOIN Invoice I (NOLOCK) ON (L.IDPresale = I.IDPreSale)' +
                   ' WHERE L.IDLancamento = :IDLancamento';
      dtServiceOrder: CommandText := 'SELECT ' + StringReplace(GetSQLFields, 'IDServiceOrder', 'L.IDServiceOrder', [rfReplaceAll]) + ',IDStore' +
                   ' FROM Fin_Lancamento L (NOLOCK) ' +
                   ' JOIN Ser_ServiceOrder S (NOLOCK) ON (L.IDServiceOrder = S.IDServiceOrder)' +
                   ' WHERE L.IDLancamento = :IDLancamento';
    end;


    Parameters.ParamByName('IDLancamento').Value := FIDPayment;
    Open;

    if not IsEmpty then
      SetProperties(DSPayment);

  finally
    Free;
  end;

  FTraceControl.TraceOut;
end;

procedure TPayment.SetProperties(ADSPayment: TADODataSet);
begin
  FTraceControl.TraceIn(Self.ClassName + '.SetProperties');

  with ADSPayment do
  begin
    FIDStore         := FieldByName('IDStore').AsInteger;
    FIDCashRegMov    := FieldByName('IDCashRegMov').AsInteger;
    FIDCustomer      := FieldByName('IDPessoa').AsInteger;
    FPaymentDate     := FieldByName('DataLancamento').AsDateTime;
    FIDCentroCusto   := FieldByName('IDCentroCusto').AsInteger;
    FIDContaCorrente := FieldByName('IDContaCorrentePrevista').AsInteger;
    FIDEmpresa       := FieldByName('IDEmpresa').AsInteger;
    FIDUser          := FieldByName('IDUsuarioLancamento').AsInteger;

    case FDocumentType of
      dtInvoice: FIDPreSale := FieldByName('IDPreSale').AsInteger;
      dtServiceOrder: FIDServiceOrder := FieldByName('IDServiceOrder').AsInteger;
    end;

    FIDPaymentType   := FieldByName('IDQuitacaoMeioPrevisto').AsInteger;
    FPaymentValue    := FieldByName('ValorNominal').AsCurrency;
  end;

  FTraceControl.TraceOut;
end;

function TPayment.GetAutoProcess: Boolean;
begin
  Result := False;
end;

procedure TPayment.BeforeDeletePayment;
begin
  // para ser herdado
end;

function TPayment.CanUpdateCashregMov: Boolean;
begin
  Result := True;
end;

procedure TPayment.setSaveIdPaymentDebitCard(const Value: integer);
begin
  FSaveIdPaymentDebitCard := value;
end;


procedure TPayment.setIdMeioPrevisto(arg_cardType: String);
var
  processor, cardID: String;
  idMeioPag: Integer;
  select: TADOQuery;
  saveIdPaymentType: Integer;
begin
  try
      try
         saveIdPaymentType := FIDPaymentType;
         select := TADOQuery.Create(nil);
         select.Connection := FADOConnection;
         select.sql.add('select IdMeioPag from MeioPag where meiopag = :param_meiopag');
         select.Parameters.ParamByName('param_meiopag').Value := arg_cardType;
         select.Open;

         if ( not select.IsEmpty ) then begin
            idMeioPag := select.fieldByName('IDMeioPag').Value;
            // Alex 09/27/2015
            //FIDPayment := idMeioPag;
            FIDPaymentType := idMeioPag;
         end;
      except
         on e: Exception do begin
              FIDPaymentType := saveIdPaymentType;
         end;
      end;
  finally
     freeAndNil(select);
  end;

end;

function TPayment.getIdMeioPrevisto: Integer;
begin
  result := FIDPaymentType;
end;

end.
