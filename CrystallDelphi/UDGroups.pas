unit UDGroups;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32, Buttons;

type
  TCrpeGroupsDlg = class(TForm)
    pnlGroups: TPanel;
    lblFieldName: TLabel;
    lblNumber: TLabel;
    lblCondition: TLabel;
    lblDirection: TLabel;
    lblGroupType: TLabel;
    editFieldName: TEdit;
    lbNumbers: TListBox;
    cbCondition: TComboBox;
    cbDirection: TComboBox;
    cbKeepTogether: TCheckBox;
    cbRepeatGH: TCheckBox;
    cbGroupType: TComboBox;
    btnOk: TButton;
    btnClear: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    gbTopN: TGroupBox;
    lblSortType: TLabel;
    cbSortType: TComboBox;
    lblNGroups: TLabel;
    editNGroups: TEdit;
    cbIncludeOthers: TCheckBox;
    lblSortField: TLabel;
    editSortField: TEdit;
    gbHierarchy: TGroupBox;
    cbEnabled: TCheckBox;
    lblInstanceField: TLabel;
    editInstanceField: TEdit;
    lblParentField: TLabel;
    editParentField: TEdit;
    lblIndent: TLabel;
    editIndent: TEdit;
    rbInches: TRadioButton;
    rbTwips: TRadioButton;
    btnSortField: TButton;
    cbCustomizeGroupName: TCheckBox;
    editOthersName: TEdit;
    lblOthersName: TLabel;
    sbFormulaBlue: TSpeedButton;
    sbFormulaRed: TSpeedButton;
    sbGroupNameFormula: TSpeedButton;
    lblGroupNameFormula: TLabel;
    procedure lbNumbersClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbGroupTypeChange(Sender: TObject);
    procedure cbDirectionChange(Sender: TObject);
    procedure cbSortTypeChange(Sender: TObject);
    procedure cbConditionChange(Sender: TObject);
    procedure cbKeepTogetherClick(Sender: TObject);
    procedure cbRepeatGHClick(Sender: TObject);
    procedure cbIncludeOthersClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UpdateGroups;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure cbEnabledClick(Sender: TObject);
    procedure rbInchesClick(Sender: TObject);
    procedure rbTwipsClick(Sender: TObject);
    procedure editIndentEnter(Sender: TObject);
    procedure editIndentExit(Sender: TObject);
    procedure btnSortFieldClick(Sender: TObject);
    procedure lbNumbersDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbNumbersDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure editFieldNameEnter(Sender: TObject);
    procedure editFieldNameExit(Sender: TObject);
    procedure editSortFieldEnter(Sender: TObject);
    procedure editSortFieldExit(Sender: TObject);
    procedure editInstanceFieldEnter(Sender: TObject);
    procedure editInstanceFieldExit(Sender: TObject);
    procedure editParentFieldEnter(Sender: TObject);
    procedure editParentFieldExit(Sender: TObject);
    procedure editNGroupsEnter(Sender: TObject);
    procedure editNGroupsExit(Sender: TObject);
    procedure editOthersNameExit(Sender: TObject);
    procedure cbCustomizeGroupNameClick(Sender: TObject);
    procedure sbGroupNameFormulaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    GIndex   : smallint;
    PrevSize : string;
    PrevName : string;
  end;

var
  CrpeGroupsDlg: TCrpeGroupsDlg;
  bGroups      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDGroupSortFields, UDFormulaEdit;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.FormCreate(Sender: TObject);
begin
  bGroups := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.FormShow(Sender: TObject);
begin
  UpdateGroups;
end;
{------------------------------------------------------------------------------}
{ UpdateGroups procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.UpdateGroups;
var
  OnOff : boolean;
  i     : integer;
begin
  GIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Groups.Count > 0);
    {Get Groups Index}
    if OnOff then
    begin
      if Cr.Groups.ItemIndex > -1 then
        GIndex := Cr.Groups.ItemIndex
      else
        GIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  if OnOff then
  begin
    {Fill Numbers ListBox}
    for i := 0 to (Cr.Groups.Count - 1) do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Groups.Count);
    lbNumbers.ItemIndex := GIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioButton then
        TRadioButton(Components[i]).Enabled := OnOff;
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
{ lbNumbersClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;

  procedure SetFormulaButton(sb: TSpeedButton; sList: TStrings);
  begin
    if IsStringListEmpty(sList) then
    begin
      if sb.Tag <> 0 then
      begin
        sb.Glyph := sbFormulaBlue.Glyph;
        sb.Tag := 0;
      end;
    end
    else
    begin
      if sb.Tag <> 1 then
      begin
        sb.Glyph := sbFormulaRed.Glyph;
        sb.Tag := 1;
      end;
    end;
  end;

begin
  GIndex := lbNumbers.ItemIndex;
  {Field}
  editFieldName.Text := Cr.Groups[GIndex].FieldName;
  {Direction}
  cbDirection.ItemIndex := Ord(Cr.Groups.Item.Direction);
  {GroupType & Condition}
  case Ord(Cr.Groups.Item.GroupType) of
    0: begin
         cbGroupType.ItemIndex := 0;
         cbCondition.Clear;
         cbCondition.Items.Add('AnyChange');
         cbCondition.ItemIndex := 0;
       end;
    1: begin
         cbGroupType.ItemIndex := 1;
         cbCondition.Clear;
         cbCondition.Items.Add('dateDaily');
         cbCondition.Items.Add('dateWeekly');
         cbCondition.Items.Add('dateBiWeekly');
         cbCondition.Items.Add('dateSemiMonthly');
         cbCondition.Items.Add('dateMonthly');
         cbCondition.Items.Add('dateQuarterly');
         cbCondition.Items.Add('dateSemiAnnually');
         cbCondition.Items.Add('dateAnnually');
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 1;
       end;
    2: begin
         cbGroupType.ItemIndex := 2;
         cbCondition.Clear;
         cbCondition.Items.Add('boolToYes');
         cbCondition.Items.Add('boolToNo');
         cbCondition.Items.Add('boolEveryYes');
         cbCondition.Items.Add('boolEveryNo');
         cbCondition.Items.Add('boolNextIsYes');
         cbCondition.Items.Add('boolNextIsNo');
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 9;
       end;
    3: begin
         cbGroupType.ItemIndex := 3;
         cbCondition.Clear;
         cbCondition.Items.Add('timeBySecond');
         cbCondition.Items.Add('timeByMinute');
         cbCondition.Items.Add('timeByHour');
         cbCondition.Items.Add('timeByAMPM');
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 15;
       end;
    4: begin
         cbGroupType.ItemIndex := 4;
         cbCondition.Clear;
         cbCondition.Items.Add('dateDaily');
         cbCondition.Items.Add('dateWeekly');
         cbCondition.Items.Add('dateBiWeekly');
         cbCondition.Items.Add('dateSemiMonthly');
         cbCondition.Items.Add('dateMonthly');
         cbCondition.Items.Add('dateQuarterly');
         cbCondition.Items.Add('dateSemiAnnually');
         cbCondition.Items.Add('dateAnnually');
         cbCondition.Items.Add('timeBySecond');
         cbCondition.Items.Add('timeByMinute');
         cbCondition.Items.Add('timeByHour');
         cbCondition.Items.Add('timeByAMPM');
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 19;
       end;
  end;
  {RepeatGH}
  cbRepeatGH.Checked := Cr.Groups.Item.RepeatGH;
  {KeepTogether}
  cbKeepTogether.Checked := Cr.Groups.Item.KeepTogether;
  {Custom Name}
  cbCustomizeGroupName.Checked := Cr.Groups.Item.CustomizeGroupName;
  SetFormulaButton(sbGroupNameFormula, Cr.Groups.Item.GroupNameFormula);
  {TopN}
  cbSortType.ItemIndex := Ord(Cr.Groups.Item.TopN.SortType);
  editNGroups.Text := IntToStr(Cr.Groups.Item.TopN.NGroups);
  editSortField.Text := Cr.Groups.Item.TopN.SortField;
  cbIncludeOthers.Checked := Cr.Groups.Item.TopN.IncludeOthers;
  editOthersName.Text := Cr.Groups.Item.TopN.OthersName;
  {Hierarchy}
  cbEnabled.OnClick := nil;
  cbEnabled.Checked := Cr.Groups.Item.Hierarchy.Enabled;
  cbEnabled.OnClick := cbEnabledClick;
  editInstanceField.Text := Cr.Groups.Item.Hierarchy.InstanceField;
  editParentField.Text := Cr.Groups.Item.Hierarchy.ParentField;
  rbInchesClick(Self);
  {If not Enabled, disable fields}
  OnOff := cbEnabled.Checked;
  editInstanceField.Enabled := OnOff;
  editInstanceField.Color := ColorState(OnOff);
  editParentField.Enabled := OnOff;
  editParentField.Color := ColorState(OnOff);
  editIndent.Enabled := OnOff;
  editIndent.Color := ColorState(OnOff);
end;
{------------------------------------------------------------------------------}
{ lbNumbersDragOver procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.lbNumbersDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Sender is TListBox then
  begin
    if TListBox(Sender).Name = 'lbNumbers' then
      Accept := True;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersDragDrop procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.lbNumbersDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  p : TPoint;
  i : integer;
begin
  p.x := X;
  p.y := y;
  i := lbNumbers.ItemAtPos(p, True);
  if i > -1 then
  begin
    Cr.Groups.Swap(TListBox(Source).ItemIndex, i);
    UpdateGroups;
  end;
end;
{------------------------------------------------------------------------------}
{ rbInchesClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.rbInchesClick(Sender: TObject);
begin
  editIndent.Text := TwipsToInchesStr(Cr.Groups.Item.Hierarchy.Indent);
end;
{------------------------------------------------------------------------------}
{ rbTwipsClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.rbTwipsClick(Sender: TObject);
begin
  editIndent.Text := IntToStr(Cr.Groups.Item.Hierarchy.Indent);
end;
{------------------------------------------------------------------------------}
{ editFieldNameEnter                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editFieldNameEnter(Sender: TObject);
begin
  PrevName := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editFieldNameExit                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editFieldNameExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GIndex = -1 then Exit;
  if not IsStrEmpty(editFieldName.Text) then
    Cr.Groups.Item.FieldName := editFieldName.Text
  else
    editFieldName.Text := PrevName;
end;
{------------------------------------------------------------------------------}
{ editCustomNameExit                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editOthersNameExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GIndex = -1 then Exit;
    Cr.Groups.Item.TopN.OthersName := editOthersName.Text
end;
{------------------------------------------------------------------------------}
{ cbConditionChange procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbConditionChange(Sender: TObject);
begin
  case cbGroupType.ItemIndex of
    {gtOther}
    0: Cr.Groups.Item.Condition := TCrGroupCondition(cbCondition.ItemIndex);
    {gtDate}
    1: Cr.Groups.Item.Condition := TCrGroupCondition(cbCondition.ItemIndex + 1);
    {gtBoolean}
    2: Cr.Groups.Item.Condition := TCrGroupCondition(cbCondition.ItemIndex + 9);
    {gtTime}
    3: Cr.Groups.Item.Condition := TCrGroupCondition(cbCondition.ItemIndex + 15);
    {gtDateTime}
    4: Cr.Groups.Item.Condition := TCrGroupCondition(cbCondition.ItemIndex + 19);
  end;
end;
{------------------------------------------------------------------------------}
{ cbGroupTypeChange procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbGroupTypeChange(Sender: TObject);
begin
  case cbGroupType.ItemIndex of
    {gtOther}
    0: begin
         cbCondition.Clear;
         cbCondition.Items.Add('AnyChange');
         cbCondition.ItemIndex := 0;
         if Ord(Cr.Groups.Item.Condition) > 0 then
           Cr.Groups.Item.Condition := TCrGroupCondition(0);
       end;
    {gtDate}
    1: begin
         cbCondition.Clear;
         cbCondition.Items.Add('dateDaily');
         cbCondition.Items.Add('dateWeekly');
         cbCondition.Items.Add('dateBiWeekly');
         cbCondition.Items.Add('dateSemiMonthly');
         cbCondition.Items.Add('dateMonthly');
         cbCondition.Items.Add('dateQuarterly');
         cbCondition.Items.Add('dateSemiAnnually');
         cbCondition.Items.Add('dateAnnually');
         if (Ord(Cr.Groups.Item.Condition) < 1) or
            (Ord(Cr.Groups.Item.Condition) > 8) then
           Cr.Groups.Item.Condition := TCrGroupCondition(1);
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 1;
       end;
    {gtBoolean}
    2: begin
         cbCondition.Clear;
         cbCondition.Items.Add('boolToYes');
         cbCondition.Items.Add('boolToNo');
         cbCondition.Items.Add('boolEveryYes');
         cbCondition.Items.Add('boolEveryNo');
         cbCondition.Items.Add('boolNextIsYes');
         cbCondition.Items.Add('boolNextIsNo');
         if Ord(Cr.Groups.Item.Condition) < 9 then
           Cr.Groups.Item.Condition := TCrGroupCondition(9);
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 9;
       end;
    {gtTime}
    3: begin
         cbCondition.Clear;
         cbCondition.Items.Add('timeBySecond');
         cbCondition.Items.Add('timeByMinute');
         cbCondition.Items.Add('timeByHour');
         cbCondition.Items.Add('timeByAMPM');
         if Ord(Cr.Groups.Item.Condition) < 15 then
           Cr.Groups.Item.Condition := TCrGroupCondition(15);
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 15;
       end;
    {gtDateTime}
    4: begin
         cbCondition.Clear;
         cbCondition.Items.Add('dateDaily');
         cbCondition.Items.Add('dateWeekly');
         cbCondition.Items.Add('dateBiWeekly');
         cbCondition.Items.Add('dateSemiMonthly');
         cbCondition.Items.Add('dateMonthly');
         cbCondition.Items.Add('dateQuarterly');
         cbCondition.Items.Add('dateSemiAnnually');
         cbCondition.Items.Add('dateAnnually');
         cbCondition.Items.Add('timeBySecond');
         cbCondition.Items.Add('timeByMinute');
         cbCondition.Items.Add('timeByHour');
         cbCondition.Items.Add('timeByAMPM');
         if Ord(Cr.Groups.Item.Condition) < 19 then
           Cr.Groups.Item.Condition := TCrGroupCondition(19);
         cbCondition.ItemIndex := Ord(Cr.Groups.Item.Condition) - 19;
       end;
  end;
  Cr.Groups.Item.GroupType := TCrGroupType(cbGroupType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbDirectionChange procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbDirectionChange(Sender: TObject);
begin
  Cr.Groups.Item.Direction := TCrGroupDirection(cbDirection.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbKeepTogetherClick procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbKeepTogetherClick(Sender: TObject);
begin
  Cr.Groups.Item.KeepTogether := cbKeepTogether.Checked;
end;
{------------------------------------------------------------------------------}
{ cbRepeatGHClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbRepeatGHClick(Sender: TObject);
begin
  Cr.Groups.Item.RepeatGH := cbRepeatGH.Checked;
end;
{------------------------------------------------------------------------------}
{ cbCustomizeGroupNameClick procedure                                          }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbCustomizeGroupNameClick(Sender: TObject);
begin
  Cr.Groups.Item.CustomizeGroupName := cbCustomizeGroupName.Checked;
  UpdateGroups;
end;
{------------------------------------------------------------------------------}
{ sbGroupNameFormulaClick procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.sbGroupNameFormulaClick(Sender: TObject);
var
  GNF : TStrings;
begin
  GNF := Cr.Groups.Item.GroupNameFormula;
  {Create the Formula editing form}
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := GNF;
  CrpeFormulaEditDlg.Caption := TSpeedButton(Sender).Hint;
  CrpeFormulaEditDlg.ShowModal;
  {Update the form}
  UpdateGroups;
end;
{------------------------------------------------------------------------------}
{ cbSortTypeChange procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbSortTypeChange(Sender: TObject);
begin
  Cr.Groups.Item.TopN.SortType := TCrTopNSortType(cbSortType.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editNGroupsEnter procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editNGroupsEnter(Sender: TObject);
begin
  PrevSize := editNGroups.Text;
end;
{------------------------------------------------------------------------------}
{ editNGroupsExit procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editNGroupsExit(Sender: TObject);
begin
  if IsNumeric(editNGroups.Text) then
    Cr.Groups.Item.TopN.NGroups := StrToInt(editNGroups.Text)
  else
    editNGroups.Text := PrevSize;
end;
{------------------------------------------------------------------------------}
{ cbIncludeOthersClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbIncludeOthersClick(Sender: TObject);
begin
  Cr.Groups.Item.TopN.IncludeOthers := cbIncludeOthers.Checked;
end;
{------------------------------------------------------------------------------}
{ editSortFieldEnter                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editSortFieldEnter(Sender: TObject);
begin
  PrevName := editSortField.Text;
end;
{------------------------------------------------------------------------------}
{ editSortFieldExit                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editSortFieldExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GIndex = -1 then Exit;
  if not IsStrEmpty(editSortField.Text) then
    Cr.Groups.Item.TopN.SortField := editSortField.Text
  else
    editSortField.Text := PrevName;
end;
{------------------------------------------------------------------------------}
{ btnSortFieldClick procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.btnSortFieldClick(Sender: TObject);
begin
  CrpeGroupSortFieldsDlg := TCrpeGroupSortFieldsDlg.Create(Application);
  CrpeGroupSortFieldsDlg.Cr := Cr;
  CrpeGroupSortFieldsDlg.ShowModal;
  editSortField.Text := Cr.GroupSortFields.Item.FieldName;
  UpdateGroups;
end;
{------------------------------------------------------------------------------}
{ cbEnabledClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.cbEnabledClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  Cr.Groups.Item.Hierarchy.Enabled := cbEnabled.Checked;
  OnOff := cbEnabled.Checked;
  editInstanceField.Enabled := OnOff;
  editInstanceField.Color := ColorState(OnOff);
  editParentField.Enabled := OnOff;
  editParentField.Color := ColorState(OnOff);
  editIndent.Enabled := OnOff;
  editIndent.Color := ColorState(OnOff);
end;
{------------------------------------------------------------------------------}
{ editInstanceFieldEnter procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editInstanceFieldEnter(Sender: TObject);
begin
  PrevName := editInstanceField.Text;
end;
{------------------------------------------------------------------------------}
{ editInstanceFieldExit procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editInstanceFieldExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GIndex = -1 then Exit;
  if not IsStrEmpty(editInstanceField.Text) then
    Cr.Groups.Item.Hierarchy.InstanceField := editInstanceField.Text
  else
    editInstanceField.Text := PrevName;
end;
{------------------------------------------------------------------------------}
{ editParentFieldEnter procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editParentFieldEnter(Sender: TObject);
begin
  PrevName := editParentField.Text;
end;
{------------------------------------------------------------------------------}
{ editParentFieldExit procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editParentFieldExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GIndex = -1 then Exit;
  if not IsStrEmpty(editParentField.Text) then
    Cr.Groups.Item.Hierarchy.ParentField := editParentField.Text
  else
    editParentField.Text := PrevName;
end;
{------------------------------------------------------------------------------}
{ editIndentEnter procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editIndentEnter(Sender: TObject);
begin
  PrevSize := editIndent.Text;
end;
{------------------------------------------------------------------------------}
{ editIndentExit procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.editIndentExit(Sender: TObject);
begin
  if IsStrEmpty(Cr.ReportName) then Exit;
  if GIndex = -1 then Exit;
  if rbInches.Checked then  {inches}
  begin
    if not IsFloating(editIndent.Text) then
      editIndent.Text := PrevSize
    else
    begin
      Cr.Groups.Item.Hierarchy.Indent := InchesStrToTwips(editIndent.Text);
      UpdateGroups; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(editIndent.Text) then
      editIndent.Text := PrevSize
    else
      Cr.Groups.Item.Hierarchy.Indent := StrToInt(editIndent.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.btnClearClick(Sender: TObject);
begin
  Cr.Groups.Clear;
  UpdateGroups;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.btnOkClick(Sender: TObject);
begin
  editIndentExit(editIndent);
  editFieldNameExit(editFieldName);
  editSortFieldExit(editSortField);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeGroupsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bGroups := False;
  Release;
end;


end.

