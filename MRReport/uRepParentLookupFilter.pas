unit uRepParentLookupFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentFilter, DB, DBClient, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, StdCtrls, siComp;

type
  TRepParentLookupFilter = class(TRepParentFilter)
    lcFilter: TcxLookupComboBox;
    cdsFilter: TClientDataSet;
    dsFilter: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure OpenDataSet;
    procedure CloseDataSet;
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

{$R *.dfm}

procedure TRepParentLookupFilter.FormShow(Sender: TObject);
begin
  inherited;
  OpenDataSet;
end;

procedure TRepParentLookupFilter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseDataSet;
end;

procedure TRepParentLookupFilter.CloseDataSet;
begin
  with cdsFilter do
    if Active then
      Close;
end;

function TRepParentLookupFilter.GetValue: Variant;
begin
  if lcFilter.EditValue = null then
    Result := 0
  else
    Result := lcFilter.EditValue;
end;

procedure TRepParentLookupFilter.OpenDataSet;
begin
  with cdsFilter do
    if not Active then
      Open;
end;

function TRepParentLookupFilter.GetFilterString: String;
begin
  if Trim(lcFilter.Text) <> '' then
    Result := lblFilter.Caption + ' ' + lcFilter.Text+'; ';
end;

end.
