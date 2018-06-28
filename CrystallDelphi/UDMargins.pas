unit UDMargins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeMarginsDlg = class(TForm)
    pnlMargins: TPanel;
    rgMarginScale: TRadioGroup;
    pnlMargins2: TPanel;
    editTop: TEdit;
    editLeft: TEdit;
    editRight: TEdit;
    editBottom: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClearClick(Sender: TObject);
    procedure rgMarginScaleClick(Sender: TObject);
    procedure editTopChange(Sender: TObject);
    procedure editRightChange(Sender: TObject);
    procedure editLeftChange(Sender: TObject);
    procedure editBottomChange(Sender: TObject);
    procedure editMarginsKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateMargins;
  private
    { Private declarations }
    crTop,
    crLeft,
    crBottom,
    crRight    : smallint;
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeMarginsDlg : TCrpeMarginsDlg;
  bMargins       : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.FormCreate(Sender: TObject);
begin
  bMargins := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.FormShow(Sender: TObject);
begin
  crTop := Cr.Margins.Top;
  crBottom := Cr.Margins.Bottom;
  crLeft := Cr.Margins.Left;
  crRight := Cr.Margins.Right;
  UpdateMargins;
end;
{------------------------------------------------------------------------------}
{ UpdateMargins                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.UpdateMargins;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  {Update components}
  if OnOff then
  begin
    editTop.Text := IntToStr(Cr.Margins.Top);
    editLeft.Text := IntToStr(Cr.Margins.Left);
    editRight.Text := IntToStr(Cr.Margins.Right);
    editBottom.Text := IntToStr(Cr.Margins.Bottom);
    pnlMargins2.BevelOuter := bvRaised;
    rgMarginScaleClick(Self);
    editTop.SetFocus;
    editTop.SelectAll;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.InitializeControls(OnOff: boolean);
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
{ rgMarginScaleClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.rgMarginScaleClick(Sender: TObject);
var
  sTmp : string;
begin
  editTop.OnChange := nil;
  editBottom.OnChange := nil;
  editRight.OnChange := nil;
  editLeft.OnChange := nil;
  {Scale set to Inches}
  if rgMarginScale.ItemIndex = 0 then
  begin
    Str((Cr.Margins.Top / 1440):0:2, sTmp);
    editTop.Text := sTmp;
    Str((Cr.Margins.Left / 1440):0:2, sTmp);
    editLeft.Text := sTmp;
    Str((Cr.Margins.Right / 1440):0:2, sTmp);
    editRight.Text := sTmp;
    Str((Cr.Margins.Bottom / 1440):0:2, sTmp);
    editBottom.Text := sTmp;
  end
  {Scale set to Twips}
  else
  begin
    editTop.Text := IntToStr(Cr.Margins.Top);
    editLeft.Text := IntToStr(Cr.Margins.Left);
    editRight.Text := IntToStr(Cr.Margins.Right);
    editBottom.Text := IntToStr(Cr.Margins.Bottom);
  end;
  editTop.OnChange := editTopChange;
  editBottom.OnChange := editBottomChange;
  editRight.OnChange := editRightChange;
  editLeft.OnChange := editLeftChange;
end;
{------------------------------------------------------------------------------}
{ editMarginsKeyPress procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.editMarginsKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Sender is TEdit) then
    Exit;
  {Entry in inches}
  if rgMarginScale.ItemIndex = 0 then
  begin
    {Allow numbers or decimals}
    if ((Key >= '0') and (Key <= '9')) or (Key = '.') then
    begin
      if (Key = '.') then
      begin
        {Allow a dot if all text is selected}
        if (Length(TEdit(Sender).Text) = TEdit(Sender).SelLength) then
          Exit;
        {Do not allow dot if it already exists}
        if Pos('.', TEdit(Sender).Text) <> 0 then
        begin
          Key := Char(0);
          Exit;
        end;
      end;
      try
        StrToFloat(TEdit(Sender).Text + Key);
      except
        Application.MessageBox('Value too large!','Entry Error',
          MB_APPLMODAL + MB_ICONHAND + MB_OK);
        Key := Char(0);
      end;
      if StrToFloat(TEdit(Sender).Text + Key) > 22.75 then
      begin
        Application.MessageBox('Value too large!' + Chr(10) +
          'Must not be greater than 22.75 inches.','Entry Error',
          MB_APPLMODAL + MB_ICONHAND + MB_OK);
        Key := Char(0);
      end;
    end
    else if Key <> Char(8) then
      Key := Char(0);
  end
  {Entry in twips}
  else
  begin
    {Allow numbers}
    if ((Key >= '0') and (Key <= '9')) then
    begin
      try
        StrToInt(TEdit(Sender).Text + Key);
      except
        Application.MessageBox('Value too large!','Entry Error',
          MB_APPLMODAL + MB_ICONHAND + MB_OK);
        Key := Char(0);
      end;
      if StrToInt(TEdit(Sender).Text + Key) > 32768 then
      begin
        Application.MessageBox('Value too large!' + Chr(10) +
          'Must not be greater than 32768 twips.','Entry Error',
          MB_APPLMODAL + MB_ICONHAND + MB_OK);
        Key := Char(0);
      end;
    end
    else if Key <> Char(8) then
      Key := Char(0);
  end;
end;
{------------------------------------------------------------------------------}
{ editTopChange procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.editTopChange(Sender: TObject);
begin
  if Length(editTop.Text) <> 0 then
  begin
    case rgMarginScale.ItemIndex of
      {Inches}
      0: Cr.Margins.Top := Round(StrToFloat(editTop.Text) * 1440);
      {Twips}
      1: Cr.Margins.Top := StrToInt(editTop.Text);
    end;
  end
  else
    Cr.Margins.Top := 0;
end;
{------------------------------------------------------------------------------}
{ editLeftChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.editLeftChange(Sender: TObject);
begin
  if Length(editLeft.Text) <> 0 then
  begin
    case rgMarginScale.ItemIndex of
      {Inches}
      0: Cr.Margins.Left := Round(StrToFloat(editLeft.Text) * 1440);
      {Twips}
      1: Cr.Margins.Left := StrToInt(editLeft.Text);
    end;
  end
  else
    Cr.Margins.Left := 0;
end;
{------------------------------------------------------------------------------}
{ editRightChange procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.editRightChange(Sender: TObject);
begin
  if Length(editLeft.Text) <> 0 then
  begin
    case rgMarginScale.ItemIndex of
      {Inches}
      0: Cr.Margins.Right := Round(StrToFloat(editRight.Text) * 1440);
      {Twips}
      1: Cr.Margins.Right := StrToInt(editRight.Text);
    end;
  end
  else
    Cr.Margins.Right := 0;
end;
{------------------------------------------------------------------------------}
{ editBottomChange procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.editBottomChange(Sender: TObject);
begin
  if Length(editLeft.Text) <> 0 then
  begin
    case rgMarginScale.ItemIndex of
      {Inches}
      0: Cr.Margins.Bottom := Round(StrToFloat(editBottom.Text) * 1440);
      {Twips}
      1: Cr.Margins.Bottom := StrToInt(editBottom.Text);
    end;
  end
  else
    Cr.Margins.Bottom := 0;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.btnClearClick(Sender: TObject);
begin
  Cr.Margins.Clear;
  UpdateMargins;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeMarginsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    Cr.Margins.Top := crTop;
    Cr.Margins.Bottom := crBottom;
    Cr.Margins.Left := crLeft;
    Cr.Margins.Right := crRight;
  end;
  bMargins := False;
  Release;
end;


end.
