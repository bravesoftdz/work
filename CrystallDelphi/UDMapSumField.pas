unit UDMapSumField;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeMapSummaryFieldsDlg = class(TForm)
    pnlSummaryFields: TPanel;
    lblNumber: TLabel;
    lblCount: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    btnOk: TButton;
    lblFieldName: TLabel;
    editFieldName: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateSummaryFields;
    procedure InitializeControls(OnOff: boolean);
    procedure btnOkClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure editFieldNameExit(Sender: TObject);
  private
    { Private declarations }
  public
    Crs : TCrpeMapSummaryFields;
    SummaryIndex : integer;
  end;

var
  CrpeMapSummaryFieldsDlg: TCrpeMapSummaryFieldsDlg;
  bSumFields             : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.FormCreate(Sender: TObject);
begin
  bSumFields := True;
  LoadFormPos(Self);
  SummaryIndex := -1;
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateSummaryFields;
end;
{------------------------------------------------------------------------------}
{ UpdateSummaryFields                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.UpdateSummaryFields;
var
  i : smallint;
  OnOff : boolean;
begin
  SummaryIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crs.Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Crs.Count > 0);
    {Get Groups Index}
    if OnOff then
    begin
      if Crs.ItemIndex > -1 then
        SummaryIndex := Crs.ItemIndex
      else
        SummaryIndex := 0;
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
    if SummaryIndex < 0 then SummaryIndex := 0;
    lbNumbers.ItemIndex := SummaryIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpeMapSummaryFieldsDlg.lbNumbersClick(Sender: TObject);
begin
  SummaryIndex := lbNumbers.ItemIndex;
  editFieldName.Text := Crs[SummaryIndex].FieldName;
end;
{------------------------------------------------------------------------------}
{ editFieldNameExit                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.editFieldNameExit(Sender: TObject);
begin
  if (Crs.Cr = nil) then Exit;
  if Crs.ItemIndex < 0 then Exit;
  if Crs.Item.FieldName <> editFieldName.Text then
    Crs.Item.FieldName := editFieldName.Text;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.btnOkClick(Sender: TObject);
begin
  editFieldNameExit(Self);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeMapSummaryFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSumFields := False;
  Release;
end;



end.
