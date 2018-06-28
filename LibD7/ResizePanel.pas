unit ResizePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TResizePanel = class(TPanel)
  private
    { Private declarations }
    IsFirst    : Boolean;
    PanelWidth : integer;
    FSpaceInside : integer;
  protected
    { Protected declarations }
    constructor Create( AOwner: TComponent ); override;
    procedure WMSize( var Message: TWMSize ); message WM_SIZE;
  public
    { Public declarations }
  published
    { Published declarations }
    property SpaceInside : integer read FSpaceInside write FSpaceInside default 2;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TResizePanel]);
end;

constructor TResizePanel.Create( AOwner: TComponent );
begin
  inherited Create( AOwner);
  FSpaceInside := 2;
  IsFirst := True;
end;

procedure TResizePanel.WMSize( var Message: TWMSize );
var
  i, LeftPos : integer;
begin
  inherited;
  Exit;
  if ControlCount > 0 then
  begin
       LeftPos := 0;
       for i := 0 to (ControlCount -1) do
        begin
          Controls[i].Left  := LeftPos;
          Controls[i].Width := Round(((Width-1)-((ControlCount-1)*FSpaceInside))/ControlCount);
          Inc(LeftPos, (Controls[i].Width+FSpaceInside));
        end;
  end;
end;

end.
