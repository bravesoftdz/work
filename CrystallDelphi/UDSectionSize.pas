unit UDSectionSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSectionSizeDlg = class(TForm)
    pnlSectionHeight: TPanel;
    lblHeight: TLabel;
    lblSection: TLabel;
    editHeight: TEdit;
    rgUnits: TRadioGroup;
    lbSections: TListBox;
    memoSectionHeight: TMemo;
    btnOk: TButton;
    btnClear: TButton;
    lblWidth: TLabel;
    editWidth: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbSectionsClick(Sender: TObject);
    procedure editHeightExit(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateSectionSize;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure editHeightEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    SIndex   : Smallint;
    PrevSize : string;
  end;

var
  CrpeSectionSizeDlg: TCrpeSectionSizeDlg;
  bSectionSize      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.FormCreate(Sender: TObject);
begin
  bSectionSize := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.FormShow(Sender: TObject);
begin
  UpdateSectionSize;
end;
{------------------------------------------------------------------------------}
{ UpdateSectionSize procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.UpdateSectionSize;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    SIndex := -1;
  end
  else
  begin
    OnOff := (Cr.SectionSize.Count > 0);
    {Get SectionSize Index}
    if OnOff then
    begin
      if Cr.SectionSize.ItemIndex > -1 then
        SIndex := Cr.SectionSize.ItemIndex
      else
        SIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  if OnOff then
  begin
    lbSections.Items.AddStrings(Cr.SectionFormat.Names);
    lbSections.ItemIndex := SIndex;
    lbSectionsClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.InitializeControls(OnOff: boolean);
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
{ lbSectionsClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.lbSectionsClick(Sender: TObject);
begin
  SIndex := lbSections.ItemIndex;
  Cr.SectionSize[SIndex];
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ editHeightEnter procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.editHeightEnter(Sender: TObject);
begin
  PrevSize := editHeight.Text;
end;
{------------------------------------------------------------------------------}
{ editHeightExit procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.editHeightExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(editHeight.Text) then
      editHeight.Text := PrevSize
    else
    begin
      Cr.SectionSize.Item.Height := InchesStrToTwips(editHeight.Text);
      UpdateSectionSize; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(editHeight.Text) then
      editHeight.Text := PrevSize
    else
      Cr.SectionSize.Item.Height := StrToInt(editHeight.Text);
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.rgUnitsClick(Sender: TObject);
begin
  editHeight.OnExit := nil;
  case rgUnits.ItemIndex of
    {Inches}
    0 : begin
          editHeight.Text := TwipsToInchesStr(Cr.SectionSize.Item.Height);
          editWidth.Text := TwipsToInchesStr(Cr.SectionSize.Item.Width);
        end;
    {Twips}
    1 : begin
          editHeight.Text := IntToStr(Cr.SectionSize.Item.Height);
          editWidth.Text := IntToStr(Cr.SectionSize.Item.Width);
        end;
  end;
  editHeight.OnExit := editHeightExit;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.btnClearClick(Sender: TObject);
begin
  Cr.SectionSize.Clear;
  UpdateSectionSize;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if not IsStrEmpty(Cr.ReportName) then
    editHeightExit(editHeight);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSectionSizeDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSectionSize := False;
  Release;
end;


end.


