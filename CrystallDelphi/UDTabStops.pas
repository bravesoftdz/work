unit UDTabStops;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, UCrpe32, StdCtrls, ExtCtrls;

type
  TCrpeTabStopsDlg = class(TForm)
    pnlTabStops: TPanel;
    lblNames: TLabel;
    lblFieldName: TLabel;
    lblCount: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    cbAlignment: TComboBox;
    btnOk: TButton;
    btnClear: TButton;
    lblOffset: TLabel;
    editOffset: TEdit;
    rgUnits: TRadioGroup;
    btnAdd: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure cbAlignmentChange(Sender: TObject);
    procedure editOffsetEnter(Sender: TObject);
    procedure editOffsetExit(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateTabStops;
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Crt      : TCrpeTabStops;
    TIndex   : integer;
    PrevSize : string;
  end;

var
  CrpeTabStopsDlg: TCrpeTabStopsDlg;

implementation

{$R *.DFM}

uses UCrpeUtl, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnAdd.Tag := 1;
  TIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.FormShow(Sender: TObject);
begin
  UpdateTabStops;
end;
{------------------------------------------------------------------------------}
{ UpdateTabStops                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.UpdateTabStops;
var
  OnOff : boolean;
  i     : integer;
begin
  TIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crt.Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Crt.Count > 0);
    {Get TabStops Index}
    if OnOff then
    begin
      if Crt.ItemIndex > -1 then
        TIndex := Crt.ItemIndex
      else
        TIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Crt.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crt.Count);
    lbNumbers.ItemIndex := TIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
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
procedure TCrpeTabStopsDlg.lbNumbersClick(Sender: TObject);
begin
  TIndex := lbNumbers.ItemIndex;
  cbAlignment.ItemIndex := Ord(Crt[TIndex].Alignment);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbAlignmentChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.cbAlignmentChange(Sender: TObject);
begin
  Crt.Item.Alignment := TCrHorizontalAlignment(cbAlignment.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editOffsetEnter                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.editOffsetEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editOffsetExit                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.editOffsetExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(editOffset.Text) then
      editOffset.Text := PrevSize
    else
    begin
      Crt.Item.Offset := InchesStrToTwips(editOffset.Text);
      UpdateTabStops; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(editOffset.Text) then
      editOffset.Text := PrevSize
    else
      Crt.Item.Offset := StrToInt(editOffset.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
    editOffset.Text := TwipsToInchesStr(Crt.Item.Offset)
  else  {twips}
    editOffset.Text := IntToStr(Crt.Item.Offset);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnAddClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.btnAddClick(Sender: TObject);
var
  s1 : string;
  i  : integer;
begin
  if InputQuery('Add TabStop', 'Specify Tab Offset (in twips - 1440 twips per inch):', s1) then
  begin
    if IsNumeric(s1) then
    begin
      i := StrToInt(s1);
      Crt.Add(haLeft, i);
      UpdateTabStops;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.btnDeleteClick(Sender: TObject);
begin
  Crt.Delete(TIndex);
  UpdateTabStops;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.btnClearClick(Sender: TObject);
begin
  Crt.Clear;
  UpdateTabStops;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeTabStopsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
