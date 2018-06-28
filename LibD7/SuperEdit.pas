unit SuperEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TSuperEdit = class(TEdit)
  private
    FAlignment : TAlignment;
    FOnPressEnter : TNotifyEvent;
    procedure SetAlignment(Value: TAlignment);
  protected
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN; {handle esc}
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  published
    property OnPressEnter : TNotifyEvent read FOnPressEnter write FOnPressEnter;
    property Alignment: TAlignment read FAlignment write SetAlignment;
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

procedure TSuperEdit.CreateParams(var Params: TCreateParams);
  const
  Alignments : array[TAlignment] of LongInt = (ES_Left,ES_Right, ES_Center);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TSuperEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
     begin
     FAlignment := Value;
     RecreateWnd;
     end;
end;

end.
