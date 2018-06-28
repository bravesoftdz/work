unit SuperEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSuperEdit = class(TEDit)
  private
    { Private declarations }
    FOnPressEnter : TNotifyEvent;
  protected
    { Protected declarations }
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN; {handle esc}
  public
    { Public declarations }
  published
    { Published declarations }
    property OnPressEnter : TNotifyEvent read FOnPressEnter write FOnPressEnter;
  end;

procedure Register;

implementation


procedure TSuperEdit.CNKeyDown(var Message: TWMKeyDown);
begin
   with Message do
     // Ambos os casos nao continua a capturar a tecla
     case charcode of
        VK_RETURN  : begin
                       if Assigned(OnPressEnter) then
                          FOnPressEnter(Self);
                       Exit;
                     end;
     end;
   inherited;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TSuperEdit]);
end;

end.
