unit dxDBCGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxTL, dxDBGrid;

type
  TdxDBCGrid = class(TdxDBGrid)
  private
    { Private declarations }
  protected
    { Protected declarations }
    constructor Create(AOwner : TComponent); Override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

constructor TdxDBCGrid.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Name := 'Costa';
  Parent := TWinControl(AOwner);
  // Seto os valores default para a aplicação
  BorderStyle := bsSingle;
  ArrowsColor := clBlue;
  LookAndFeel := lfFlat;

  Options := Options - [egoEditing]
                     + [egoRowSelect]
                     + [egoLoadAllRecords]
                     + [egoDrawEndEllipsis]
                     + [egoAutoWidth]
                     + [egoCaseInsensitive];

  ShowGrid := False;

end;

procedure Register;
begin
  RegisterComponents('NewPower', [TdxDBCGrid]);
end;

end.
