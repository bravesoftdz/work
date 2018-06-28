unit uHandleException;

interface

uses SysUtils, Dialogs, DB, DBClient, Forms, Windows, Classes;

const
  EXCEPTION_HINT = '_As instruções para suporte encontran-se na caixa abaixo.';

type
  EmrException = class(Exception)
  private
    FTitle: String;
  public
    constructor Create(Message: String; ATitle: String = '');
    property Title: String read FTitle;
  end;

  EmrReconcileError = class(Exception)
  private
    FUpdateKind: TUpdateKind;
    FUpdateMsg1: String;
    FUpdateMsg2: String;
  public
    constructor Create(Message: String; AUpdateKind: TUpdateKind);
    property UpdateKind: TUpdateKind read FUpdateKind;
    property UpdateMsg1: String read FUpdateMsg1;
    property UpdateMsg2: String read FUpdateMsg2;
  end;

procedure HandleException(Sender: TObject; E: Exception);

implementation

uses uMsgBox, uNTTraceControl, uDMApplicationHub;

{ EewException }

constructor EmrException.Create(Message: String; ATitle: String);
begin
  FTitle := ATitle;
  inherited Create(Message);
end;

{ EmrReconcileError }

constructor EmrReconcileError.Create(Message: String;
  AUpdateKind: TUpdateKind);
begin
  FUpdateKind := AUpdateKind;
  case FUpdateKind of
    ukInsert:
      begin
        FUpdateMsg1 := 'gravação';
        FUpdateMsg2 := 'salvo';
      end;
    ukModify:
      begin
        FUpdateMsg1 := 'alteração';
        FUpdateMsg2 := 'alterado';
      end;
    ukDelete:
      begin
        FUpdateMsg1 := 'exclusão';
        FUpdateMsg2 := 'removido';
      end;
  end;
  MsgBoxError('', Message, vbCritical + vbOKOnly);
  //inherited Create(Message);
end;

{ Functions and Procedures }

procedure HandleException(Sender: TObject; E: Exception);
var
  ExceptionMethodName, ExceptionFormClass, ExceptionMsg: String;
begin
  // Get trace exception
  if DMApplicationHub.TraceControl.LastTrace = '' then
    ExceptionMethodName := 'Method: Unknown.Exception'
  else
    ExceptionMethodName := 'Method: ' + DMApplicationHub.TraceControl.LastTrace + '.Exception';

  // Get form
  if Screen.ActiveForm = nil then
    ExceptionFormClass := 'Unknown'
  else
    ExceptionFormClass := Screen.ActiveForm.ClassName;

  // Save trace at server
  //DMApplicationHub.TraceControl.SaveTrace(SisUsuario.ID, E.Message, ExceptionFormClass);

  ExceptionFormClass := 'Form Class: ' + ExceptionFormClass;

  // Show exception dialog
  if E is EmrReconcileError then
    ExceptionMsg := 'Ocorreu um erro durante a ' + EmrReconcileError(E).UpdateMsg1 +
      ' do registro e nada foi ' + EmrReconcileError(E).UpdateMsg2 + '!'
  else if E is EmrException then
    ExceptionMsg := EmrException(E).Title
  else
    ExceptionMsg := 'Ocorreu um erro interno no sistema!';

  MsgBoxError(ExceptionMsg + EXCEPTION_HINT, ExceptionFormClass + #13#10 +
    ExceptionMethodName + #13#10#13#10 + E.Message,
    vbCritical + vbOKOnly);
end;

end.
