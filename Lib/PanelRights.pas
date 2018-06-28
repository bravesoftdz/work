unit PanelRights;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, uSystemTypes;

type
  TPanelRights = class(TPanel)
  private
    { Private declarations }
    FCommands : TSetCommandType;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure UpdateButtons(lEnabled : Boolean);
    procedure DisableButtons;    
    constructor Create(AOwner : TComponent); override;
  published
    { Published declarations }
    property Commands  : TSetCommandType read FCommands write FCommands default
             [btInc, btAlt, btExc, btPos, btFlt, btImp];
  end;

procedure Register;

implementation

constructor TPanelRights.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FCommands  := [btInc, btAlt, btExc, btPos, btFlt, btImp];
end;

procedure TPanelRights.UpdateButtons(lEnabled : Boolean);
var
  ButtonType : TBtnCommandType;
  i          : integer;
begin
  for i := 0 to ControlCount -1 do
   begin
     // Testa se e TButton
     if (Controls[i] is TButton) or (Controls[i] is TSpeedButton) then
       begin
         if TComponent(Controls[i]).Tag > 5 then
            TButton(Controls[i]).Enabled := lEnabled
         else if TComponent(Controls[i]).Tag >= 0 then
           begin
            ButtonType := TBtnCommandType(TComponent(Controls[i]).Tag);
            if ButtonType in [btInc, btFlt] then
               TButton(Controls[i]).Enabled := (ButtonType in FCommands)
            else
               TButton(Controls[i]).Enabled := (ButtonType in FCommands) and lEnabled;
           end
       end;
   end;

end;

procedure TPanelRights.DisableButtons;
var
  i          : integer;
begin
  for i := 0 to ControlCount -1 do
   begin
     // Testa se e TButton
     if (Controls[i] is TButton) or (Controls[i] is TSpeedButton) then
        if (TComponent(Controls[i]).Tag <= 5) and (TComponent(Controls[i]).Tag >= 0) then
           TButton(Controls[i]).Enabled := False
   end;
end;

procedure Register;
begin
  RegisterComponents('NewPower', [TPanelRights]);
end;

end.
