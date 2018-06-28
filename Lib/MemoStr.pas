unit MemoStr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, DB;

type
  TDbMemoStr = class(TDBMemo)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure TDBMemoStr.CMExit(var Message: TCMExit);
begin
  if (Field is TStringField) then
    try
      with DataSource.DataSet do
        if State in dsEditModes then
           UpdateRecord;
    except
      SetFocus;
      raise;
    end;
//  SetFocused(False);
  inherited;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TDbMemoStr]);
end;

end.
