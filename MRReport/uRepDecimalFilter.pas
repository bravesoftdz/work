unit uRepDecimalFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, StdCtrls, cxControls, cxContainer, cxEdit,
  cxTextEdit, siComp;

type
  TRepDecimalFilter = class(TRepParentFilter)
    edFilter: TcxTextEdit;
    procedure edFilterKeyPress(Sender: TObject; var Key: Char);
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

uses uCharFunctions;

{$R *.dfm}

{ TRepDecimalFilter }

function TRepDecimalFilter.GetFilterString: String;
begin
  if Trim(edFilter.Text) <> '' then
    Result := lblFilter.Caption + ' ' + Trim(edFilter.Text) +'; ';
end;

function TRepDecimalFilter.GetValue: Variant;
begin
  Result := edFilter.Text;
end;

procedure TRepDecimalFilter.edFilterKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

initialization
  RegisterClass(TRepDecimalFilter)

end.
