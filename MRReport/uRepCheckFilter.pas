unit uRepCheckFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, StdCtrls, cxControls, cxContainer, cxEdit,
  cxCheckBox;

type
  TRepCheckFilter = class(TRepParentFilter)
    cbxFilter: TcxCheckBox;
    procedure FormShow(Sender: TObject);
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

{$R *.dfm}

{ TRepParentCheckFilter }

function TRepCheckFilter.GetValue: Variant;
begin
  Result := cbxFilter.Checked;
end;

procedure TRepCheckFilter.FormShow(Sender: TObject);
begin
  inherited;
  cbxFilter.Properties.Caption := lblFilter.Caption;
end;

function TRepCheckFilter.GetFilterString: String;
begin
  if cbxFilter.Checked then
    Result := cbxFilter.Properties.Caption + '; ';
end;

initialization
  RegisterClass(TRepCheckFilter);

end.
