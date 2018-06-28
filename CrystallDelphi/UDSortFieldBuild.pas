unit UDSortFieldBuild;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeBuildSortFieldDlg = class(TForm)
    pnlBuildSort: TPanel;
    lblSummaryType: TLabel;
    lblSummaryField: TLabel;
    lblGroupField: TLabel;
    lblLeftBracket: TLabel;
    lblRightBracket: TLabel;
    lblComma: TLabel;
    cbSummaryType: TComboBox;
    cbGroupField: TComboBox;
    btnCancel: TButton;
    btnOk: TButton;
    cbSummaryField: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr     : TCrpe;
    rField : string;
  end;

var
  CrpeBuildSortFieldDlg: TCrpeBuildSortFieldDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeBuildSortFieldDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeBuildSortFieldDlg.FormShow(Sender: TObject);
var
  i     : integer;
  s1,s2 : string;
begin
  {Check for Groups}
  cbGroupField.Clear;
  cbGroupField.Items.AddStrings(Cr.Groups.Names);
  {Summary Fields}
  cbSummaryField.Clear;
  cbSummaryField.Items.AddStrings(Cr.Tables.FieldNames);

  {If we are editing, parse the current GroupSortField}
  if Caption = 'Edit GroupSortField' then
  begin
    {Summary Type}
    i := Pos('(', Cr.GroupSortFields.Item.FieldName);
    if i > 0 then
    begin
      s1 := Trim(Copy(Cr.GroupSortFields.Item.FieldName,0,i-1));
      cbSummaryType.ItemIndex := cbSummaryType.Items.IndexOf(s1);
    end;
    {Summary Field}
    s1 := Copy(Cr.GroupSortFields.Item.FieldName,i+1,Length(Cr.GroupSortFields.Item.FieldName));
    i := Pos('}', s1);
    if i > 0 then
    begin
      s2 := Trim(Copy(s1,0,i));
      cbSummaryField.ItemIndex := cbSummaryField.Items.IndexOf(s2);
    end;
    {Group Field}
    s1 := Copy(s1,i+1,Length(s1));
    i := Pos('{', s1);
    if i > 0 then
    begin
      s1 := Trim(Copy(s1,i,Length(s1)));
      i := Pos('}', s1);
      if i > 0 then
      begin
        s2 := Copy(s1,0,i);
        cbGroupField.ItemIndex := cbGroupField.Items.IndexOf(s2);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeBuildSortFieldDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeBuildSortFieldDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeBuildSortFieldDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  rField := '';
  if ModalResult = mrOk then
    rField := cbSummaryType.Text + '(' +
      cbSummaryField.Text + ',' + cbGroupField.Text + ')';
  Release;
end;


end.
