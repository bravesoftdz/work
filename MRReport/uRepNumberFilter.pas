unit uRepNumberFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxSpinEdit, StdCtrls;

type
  TRepNumberFilter = class(TRepParentFilter)
    seNumber: TcxSpinEdit;
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

{$R *.dfm}

{ TRepNumberFilter }

function TRepNumberFilter.GetFilterString: String;
begin
  if Trim(seNumber.Text) <> '' then
    Result := lblFilter.Caption + ' ' + Trim(seNumber.Text)+'; ';
end;

function TRepNumberFilter.GetValue: Variant;
begin
  Result := seNumber.Value;
end;

initialization
  RegisterClass(TRepNumberFilter)

end.
