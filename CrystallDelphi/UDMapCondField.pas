unit UDMapCondField;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeMapConditionFieldsDlg = class(TForm)
    pnlMapConditionFields: TPanel;
    lblNumber: TLabel;
    lblCount: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    btnOk: TButton;
    lblFieldName: TLabel;
    editFieldName: TEdit;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateConditions;
    procedure InitializeControls(OnOff: boolean);
    procedure btnOkClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure editFieldNameExit(Sender: TObject);
  private
    { Private declarations }
  public
    Crs : TCrpeMapConditionFields;
    CondIndex : integer;
  end;

var
  CrpeMapConditionFieldsDlg: TCrpeMapConditionFieldsDlg;
  bMapConditions           : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.FormCreate(Sender: TObject);
begin
  bMapConditions := True;
  LoadFormPos(Self);
  CondIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateConditions;
end;
{------------------------------------------------------------------------------}
{ UpdateConditions                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.UpdateConditions;
var
  i : smallint;
  OnOff : boolean;
begin
  CondIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crs.Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Crs.Count > 0);
    {Get Index}
    if OnOff then
    begin
      if Crs.ItemIndex > -1 then
        CondIndex := Crs.ItemIndex
      else
        CondIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Crs.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crs.Count);
    if CondIndex < 0 then CondIndex := 0;
    lbNumbers.ItemIndex := CondIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ Initialize                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.lbNumbersClick(Sender: TObject);
begin
  CondIndex := lbNumbers.ItemIndex;
  editFieldName.Text := Crs[CondIndex].FieldName;
end;
{------------------------------------------------------------------------------}
{ editFieldNameExit                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.editFieldNameExit(Sender: TObject);
begin
  if (Crs.Cr = nil) then Exit;
  if Crs.ItemIndex < 0 then Exit;
  if Crs.Item.FieldName <> editFieldName.Text then
    Crs.Item.FieldName := editFieldName.Text;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.btnOkClick(Sender: TObject);
begin
  editFieldNameExit(Self);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeMapConditionFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bMapConditions := False;
  Release;
end;



end.
