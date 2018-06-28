unit uRepTextFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, StdCtrls, cxControls, cxContainer, cxEdit,
  cxTextEdit;

type
  TRepTextFilter = class(TRepParentFilter)
    edFilter: TcxTextEdit;
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

{$R *.dfm}

{ TRepParentEditFilter }

function TRepTextFilter.GetFilterString: String;
begin
  if Trim(edFilter.Text) <> '' then
    Result := lblFilter.Caption + ' ' + Trim(edFilter.Text) +'; ';
end;

function TRepTextFilter.GetValue: Variant;
begin
  Result := edFilter.Text;
end;

initialization
  RegisterClass(TRepTextFilter);

end.
