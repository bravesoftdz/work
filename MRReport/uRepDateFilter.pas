unit uRepDateFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, StdCtrls, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, siComp;

type
  TRepDateFilter = class(TRepParentFilter)
    deDate: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

{$R *.dfm}

{ TRepDateFilter }

function TRepDateFilter.GetFilterString: String;
begin
  if Trim(deDate.Text) <> '' then
    Result := lblFilter.Caption + ' ' + Trim(deDate.Text)+'; ';
end;

function TRepDateFilter.GetValue: Variant;
begin
  Result := FormatDateTime('yyyy,mm,dd', deDate.Date);
end;

procedure TRepDateFilter.FormCreate(Sender: TObject);
begin
  inherited;
  deDate.Date := Trunc(Now);
end;

initialization
  RegisterClass(TRepDateFilter)

end.
