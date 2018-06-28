unit UDPrintOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpePrintOptionsDlg = class(TForm)
    pnlPrintOptions: TPanel;
    lblCopies: TLabel;
    lblOutputFileName: TLabel;
    rgPages: TRadioGroup;
    editStopPage1: TEdit;
    editStartPage2: TEdit;
    editStopPage2: TEdit;
    cbCollation: TCheckBox;
    editOutputFileName: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    btnPrompt: TButton;
    editCopies: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure editCopiesChange(Sender: TObject);
    procedure cbCollationClick(Sender: TObject);
    procedure rgPagesClick(Sender: TObject);
    procedure editOutputFileNameChange(Sender: TObject);
    procedure btnPromptClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdatePrintOptions;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure editStartPage2Change(Sender: TObject);
    procedure editStopPage2Change(Sender: TObject);
    procedure editStopPage1Change(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr              : TCrpe;
    rCollation      : Boolean;
    rCopies         : Word;
    rOutputFileName : string;
    rStartPage      : Word;
    rStopPage       : Word;
  end;

var
  CrpePrintOptionsDlg: TCrpePrintOptionsDlg;
  bPrintOptions      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.FormCreate(Sender: TObject);
begin
  bPrintOptions := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.FormShow(Sender: TObject);
begin
  {Store PrintOptions settings}
  rCollation        := Cr.PrintOptions.Collation;
  rCopies           := Cr.PrintOptions.Copies;
  rOutputFileName   := Cr.PrintOptions.OutputFileName;
  rStartPage        := Cr.PrintOptions.StartPage;
  rStopPage         := Cr.PrintOptions.StopPage;
  UpdatePrintOptions;
end;
{------------------------------------------------------------------------------}
{ UpdatePrintOptions procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.UpdatePrintOptions;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  OnOff := not IsStrEmpty(Cr.ReportName);
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Copies}
    editCopies.Text := IntToStr(Cr.PrintOptions.Copies);
    {Start/Stop Page}
    rgPages.OnClick := nil;
    if Cr.PrintOptions.StartPage = 1 then
    begin
      if Cr.PrintOptions.StopPage = 1 then
        rgPages.ItemIndex := 1
      else if Cr.PrintOptions.StopPage = 65535 then
        rgPages.ItemIndex := 0
      else
      begin
        rgPages.ItemIndex := 2;
        editStopPage1.Text := IntToStr(Cr.PrintOptions.StopPage);
      end;
    end
    else if Cr.PrintOptions.StartPage > 1 then
    begin
      rgPages.ItemIndex := 3;
      editStartPage2.Text := IntToStr(Cr.PrintOptions.StartPage);
      editStopPage2.Text := IntToStr(Cr.PrintOptions.StopPage);
    end
    else
      rgPages.ItemIndex := 0;
    rgPages.OnClick := rgPagesClick;
    {Collation}
    cbCollation.Checked := Cr.PrintOptions.Collation;
    {OutputFileName}
    editOutputFileName.Text := Cr.PrintOptions.OutputFileName;
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.InitializeControls(OnOff: boolean);
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
{ rgPagesClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.rgPagesClick(Sender: TObject);
var
  nPage : integer;
begin
  case rgPages.ItemIndex of
    {All}
    0: begin
         Cr.PrintOptions.StartPage := 1;
         Cr.PrintOptions.StopPage := 65535;
       end;
    {First Page}
    1: begin
         Cr.PrintOptions.StartPage := 1;
         Cr.PrintOptions.StopPage := 1;
       end;
    {Page 1 to ...}
    2: begin
         Cr.PrintOptions.StartPage := 1;
         if IsNumeric(editStopPage1.Text) then
           nPage := StrToInt(editStopPage1.Text)
         else
         begin
           editStopPage1.Text := '0';
           nPage := 0;
         end;
         Cr.PrintOptions.StopPage := nPage;
       end;
    {Page ... to ...}
    3: begin
         {StartPage}
         if IsNumeric(editStartPage2.Text) then
           nPage := StrToInt(editStartPage2.Text)
         else
         begin
           editStartPage2.Text := '0';
           nPage := 0;
         end;
         Cr.PrintOptions.StartPage := nPage;
         {StopPage}
         if IsNumeric(editStopPage2.Text) then
           nPage := StrToInt(editStopPage2.Text)
         else
         begin
           editStopPage2.Text := '0';
           nPage := 0;
         end;
         Cr.PrintOptions.StopPage := nPage;
       end;
  end;
end;
{------------------------------------------------------------------------------}
{ editCopiesChange procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.editCopiesChange(Sender: TObject);
begin
  if IsNumeric(editCopies.Text) then
    Cr.PrintOptions.Copies := StrToInt(editCopies.Text);
end;
{------------------------------------------------------------------------------}
{ cbCollationClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.cbCollationClick(Sender: TObject);
begin
  Cr.PrintOptions.Collation := cbCollation.Checked;
end;
{------------------------------------------------------------------------------}
{ editStopPage2Change procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.editStopPage1Change(Sender: TObject);
begin
  if IsNumeric(editStopPage1.Text) then
    Cr.PrintOptions.StopPage := StrToInt(editStopPage1.Text);
end;
{------------------------------------------------------------------------------}
{ editStartPage2Change procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.editStartPage2Change(Sender: TObject);
begin
  if IsNumeric(editStartPage2.Text) then
    Cr.PrintOptions.StartPage := StrToInt(editStartPage2.Text);
end;
{------------------------------------------------------------------------------}
{ editStopPage2Change procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.editStopPage2Change(Sender: TObject);
begin
  if IsNumeric(editStopPage2.Text) then
    Cr.PrintOptions.StopPage := StrToInt(editStopPage2.Text);
end;
{------------------------------------------------------------------------------}
{ editOutputFileNameChange procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.editOutputFileNameChange(Sender: TObject);
begin
  Cr.PrintOptions.OutputFileName := editOutputFileName.Text;
end;
{------------------------------------------------------------------------------}
{ btnPromptClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.btnPromptClick(Sender: TObject);
begin
  Cr.PrintOptions.Prompt;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.btnClearClick(Sender: TObject);
begin
  Cr.PrintOptions.Clear;
  UpdatePrintOptions;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpePrintOptionsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Original Settings}
    Cr.PrintOptions.Collation := rCollation;
    Cr.PrintOptions.Copies := rCopies;
    Cr.PrintOptions.OutputFileName := rOutputFileName;
    Cr.PrintOptions.StartPage := rStartPage;
    Cr.PrintOptions.StopPage := rStopPage;
  end;
  bPrintOptions := False;
  Release;
end;


end.

