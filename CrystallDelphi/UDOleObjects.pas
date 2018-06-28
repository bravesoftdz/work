unit UDOleObjects;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeOleObjectsDlg = class(TForm)
    pnlOleObjects: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
    btnOk: TButton;
    btnClear: TButton;
    lblOleType: TLabel;
    lblUpdateType: TLabel;
    lblLinkSource: TLabel;
    editLinkSource: TEdit;
    rgUnits: TRadioGroup;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblWidth: TLabel;
    lblHeight: TLabel;
    editTop: TEdit;
    editLeft: TEdit;
    editWidth: TEdit;
    editHeight: TEdit;
    lblSection: TLabel;
    cbSection: TComboBox;
    btnBorder: TButton;
    btnFormat: TButton;
    editOleType: TEdit;
    editUpdateType: TEdit;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateOleObjects;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditSizeEnter(Sender: TObject);
    procedure EditSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    OIndex   : smallint;
    PrevSize : string;
  end;

var
  CrpeOleObjectsDlg: TCrpeOleObjectsDlg;
  bOleObjects      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.FormCreate(Sender: TObject);
begin
  bOleObjects := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  editLinkSource.Tag := 1;
  editOleType.Tag := 1;
  editUpdateType.Tag := 1;
  OIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.FormShow(Sender: TObject);
begin
  UpdateOleObjects;
end;
{------------------------------------------------------------------------------}
{ UpdateOleObjects                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.UpdateOleObjects;
var
  OnOff : boolean;
  i     : integer;
begin
  OIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.OleObjects.Count > 0);
    {Get OleObjects Index}
    if OnOff then
    begin
      if Cr.OleObjects.ItemIndex > -1 then
        OIndex := Cr.OleObjects.ItemIndex
      else
        OIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.OleObjects.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.OleObjects.Count);
    lbNumbers.ItemIndex := OIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpeOleObjectsDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  OIndex := lbNumbers.ItemIndex;
  OnOff := (Cr.OleObjects[OIndex].Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  editLinkSource.Text := Cr.OleObjects.Item.LinkSource;
  editOleType.Text := GetEnumName(TypeInfo(TCrOleObjectType),
    Ord(Cr.OleObjects.Item.OleType));
  editUpdateType.Text := GetEnumName(TypeInfo(TCrOleUpdateType),
    Ord(Cr.OleObjects.Item.UpdateType));
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.OleObjects.Item.Section);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.OleObjects.Item.Top);
    editWidth.Text := TwipsToInchesStr(Cr.OleObjects.Item.Width);
    editLeft.Text := TwipsToInchesStr(Cr.OleObjects.Item.Left);
    editHeight.Text := TwipsToInchesStr(Cr.OleObjects.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.OleObjects.Item.Top);
    editWidth.Text := IntToStr(Cr.OleObjects.Item.Width);
    editLeft.Text := IntToStr(Cr.OleObjects.Item.Left);
    editHeight.Text := IntToStr(Cr.OleObjects.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.EditSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ EditSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.EditSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.OleObjects.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.OleObjects.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.OleObjects.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.OleObjects.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateOleObjects; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.OleObjects.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.OleObjects.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.OleObjects.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.OleObjects.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.OleObjects.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.OleObjects.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.OleObjects.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.btnClearClick(Sender: TObject);
begin
  Cr.OleObjects.Clear;
  UpdateOleObjects;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateOleObjects call}
  if (not IsStrEmpty(Cr.ReportName)) and (OIndex > -1) then 
  begin
    editSizeExit(editTop);
    editSizeExit(editLeft);
    editSizeExit(editWidth);
    editSizeExit(editHeight);
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeOleObjectsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bOleObjects := False;
  Release;
end;


end.
