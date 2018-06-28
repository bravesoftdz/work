unit UDPictures;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpePicturesDlg = class(TForm)
    pnlPictures: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
    btnOk: TButton;
    btnClear: TButton;
    gbCropFrom: TGroupBox;
    lblCropLeft: TLabel;
    lblCropRight: TLabel;
    lblCropTop: TLabel;
    lblCropBottom: TLabel;
    editCropLeft: TEdit;
    editCropRight: TEdit;
    editCropTop: TEdit;
    editCropBottom: TEdit;
    gbScaling: TGroupBox;
    lblScalingWidth: TLabel;
    lblScalingHeight: TLabel;
    editScalingWidth: TEdit;
    editScalingHeight: TEdit;
    lblPercent1: TLabel;
    lblPercent2: TLabel;
    rgUnits: TRadioGroup;
    btnBorder: TButton;
    btnFormat: TButton;
    gbFormat: TGroupBox;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblSection: TLabel;
    lblWidth: TLabel;
    lblHeight: TLabel;
    editTop: TEdit;
    editLeft: TEdit;
    editWidth: TEdit;
    editHeight: TEdit;
    cbSection: TComboBox;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdatePictures;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
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
    PIndex    : smallint;
    PrevSize : string;
  end;

var
  CrpePicturesDlg: TCrpePicturesDlg;
  bPictures      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDBorder, UDFormat;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.FormCreate(Sender: TObject);
begin
  bPictures := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  PIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.FormShow(Sender: TObject);
begin
  UpdatePictures;
end;
{------------------------------------------------------------------------------}
{ UpdatePictures                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.UpdatePictures;
var
  i     : smallint;
  OnOff : boolean;
begin
  PIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Pictures.Count > 0);
    {Get Pictures Index}
    if OnOff then
    begin
      if Cr.Pictures.ItemIndex > -1 then
        PIndex := Cr.Pictures.ItemIndex
      else
        PIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Fill Section ComboBox}
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    for i := 0 to Cr.Pictures.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Pictures.Count);
    lbNumbers.ItemIndex := PIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.InitializeControls(OnOff: boolean);
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
{ lbNumbersClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  PIndex := lbNumbers.ItemIndex;
  OnOff := (Cr.Pictures[PIndex].Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  editScalingWidth.Text := CrFloatingToStr(Cr.Pictures.Item.ScalingWidth);
  editScalingHeight.Text := CrFloatingToStr(Cr.Pictures.Item.ScalingHeight);
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.Pictures.Item.Section);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.editSizeExit(Sender: TObject);
begin
  if TEdit(Sender).Name = 'editScalingWidth' then
  begin
    Cr.Pictures.Item.ScalingWidth := CrStrToFloating(TEdit(Sender).Text);
    Exit;
  end;
  if TEdit(Sender).Name = 'editScalingHeight' then
  begin
    Cr.Pictures.Item.ScalingHeight := CrStrToFloating(TEdit(Sender).Text);
    Exit;
  end;

  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editCropTop' then
        Cr.Pictures.Item.CropTop := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editCropLeft' then
        Cr.Pictures.Item.CropLeft := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editCropBottom' then
        Cr.Pictures.Item.CropBottom := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editCropRight' then
        Cr.Pictures.Item.CropRight := InchesStrToTwips(TEdit(Sender).Text);


      if TEdit(Sender).Name = 'editTop' then
        Cr.Pictures.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Pictures.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Pictures.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Pictures.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdatePictures; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Pictures.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Pictures.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Pictures.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Pictures.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editCropLeft.Text := TwipsToInchesStr(Cr.Pictures.Item.CropLeft);
    editCropRight.Text := TwipsToInchesStr(Cr.Pictures.Item.CropRight);
    editCropTop.Text := TwipsToInchesStr(Cr.Pictures.Item.CropTop);
    editCropBottom.Text := TwipsToInchesStr(Cr.Pictures.Item.CropBottom);
    editTop.Text := TwipsToInchesStr(Cr.Pictures.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.Pictures.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.Pictures.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.Pictures.Item.Height);
  end
  else  {twips}
  begin
    editCropLeft.Text := IntToStr(Cr.Pictures.Item.CropLeft);
    editCropRight.Text := IntToStr(Cr.Pictures.Item.CropRight);
    editCropTop.Text := IntToStr(Cr.Pictures.Item.CropTop);
    editCropBottom.Text := IntToStr(Cr.Pictures.Item.CropBottom);
    editTop.Text := IntToStr(Cr.Pictures.Item.Top);
    editLeft.Text := IntToStr(Cr.Pictures.Item.Left);
    editWidth.Text := IntToStr(Cr.Pictures.Item.Width);
    editHeight.Text := IntToStr(Cr.Pictures.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.cbSectionChange(Sender: TObject);
begin
  Cr.Pictures.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.Pictures.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.Pictures.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.btnClearClick(Sender: TObject);
begin
  Cr.Pictures.Clear;
  UpdatePictures;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdatePictures call}
  if (not IsStrEmpty(Cr.ReportName)) and (PIndex > -1) then 
  begin
    editSizeExit(editCropLeft);
    editSizeExit(editCropRight);
    editSizeExit(editCropTop);
    editSizeExit(editCropBottom);
    editSizeExit(editScalingWidth);
    editSizeExit(editScalingHeight);
    editSizeExit(editTop);
    editSizeExit(editWidth);
    editSizeExit(editLeft);
    editSizeExit(editHeight);
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePicturesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bPictures := False;
  Release;
end;


end.
