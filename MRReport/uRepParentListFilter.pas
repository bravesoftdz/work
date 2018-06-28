unit uRepParentListFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRepParentLookupFilter, Buttons, StdCtrls, DB, DBClient,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxListBox, siComp;

type
  TRepParentListFilter = class(TRepParentLookupFilter)
    btAdd: TSpeedButton;
    btRemove: TSpeedButton;
    clbFilter: TcxListBox;
    btAddAll: TSpeedButton;
    btRemoveAll: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btAddAllClick(Sender: TObject);
    procedure btRemoveAllClick(Sender: TObject);
  private
    FListValues: TStringList;

    procedure FilterLookup;
    procedure AddToList(AID, AValue: String);
    procedure RemoveFromList;
    function GetListValues: String;
  public
    function GetValue: Variant; override;
    function GetFilterString: String; override;
  end;

implementation

uses uRepParentFilter;

{$R *.dfm}

{ TRepParentListFilter }

procedure TRepParentListFilter.AddToList(AID, AValue: String);
begin
  FListValues.Add(AID);
  clbFilter.Items.Add(AValue);

  FilterLookup;
end;

function TRepParentListFilter.GetValue: Variant;
begin
  Result := GetListValues;
end;

procedure TRepParentListFilter.RemoveFromList;
begin
  if clbFilter.ItemIndex <> -1 then
  begin
    FListValues.Delete(clbFilter.ItemIndex);
    clbFilter.DeleteSelected;
  end;

  FilterLookup;
end;

procedure TRepParentListFilter.FormCreate(Sender: TObject);
begin
  inherited;
  FMultValue  := True;
  FListValues := TStringList.Create;
end;

function TRepParentListFilter.GetListValues: String;
var
  i: integer;
begin
  Result := '';

  for i := 0 to Pred(clbFilter.Items.Count) do
    Result := Result + FListValues[i] + ';';
end;

procedure TRepParentListFilter.FilterLookup;
var
  i: Integer;
  sFilter: String;
begin
  sFilter := '';
  cdsFilter.Filtered := True;

  for i := 0 to Pred(clbFilter.Items.Count) do
  begin
    if sFilter <> '' then
      sFilter := sFilter + ' AND ';
    sFilter := sFilter + lcFilter.Properties.KeyFieldNames + ' <> ' + FListValues[i];
  end;

  cdsFilter.Filter := sFilter;
end;

procedure TRepParentListFilter.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListValues);
end;

procedure TRepParentListFilter.btAddClick(Sender: TObject);
begin
  inherited;
  if lcFilter.Text <> '' then
  begin
    AddToList(lcFilter.EditValue, lcFilter.Text);
    lcFilter.SetFocus;
  end;
end;

procedure TRepParentListFilter.btRemoveClick(Sender: TObject);
begin
  inherited;
  RemoveFromList;
end;

procedure TRepParentListFilter.btAddAllClick(Sender: TObject);
begin
  inherited;
  with cdsFilter do
    while not Eof do
    begin
      First;
      AddToList(FieldByName(lcFilter.Properties.KeyFieldNames).AsString,
        FieldByName(lcFilter.Properties.ListFieldNames).AsString);
    end;
end;

procedure TRepParentListFilter.btRemoveAllClick(Sender: TObject);
begin
  inherited;

  FListValues.Clear;
  clbFilter.Clear;
  FilterLookup;

end;

function TRepParentListFilter.GetFilterString: String;
var
  sFilter, sAll : String;
begin

  IDLanguage := 1;

  Case IDLanguage of
    1 : sAll := ' All; ';
    2 : sAll := ' Tudo; ';
    3 : sAll := ' Tudo; ';
  end;

  if cdsFilter.RecordCount = 0 then
  begin
    Result := lblFilter.Caption + sAll;
  end
  else
  begin
    sFilter := StringReplace(clbFilter.Items.CommaText, '"','', [rfReplaceAll]);
    if sFilter <> '' then
      if Length(sFilter) > 100 then
        Result := lblFilter.Caption + ' ' + Copy(sFilter,0,200)+' ...; '
      else
        Result := lblFilter.Caption + ' ' + sFilter+'; ';
  end;
end;

end.
