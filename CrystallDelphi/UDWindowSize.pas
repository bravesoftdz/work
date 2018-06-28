unit UDWindowSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeWindowSizeDlg = class(TForm)
    pnlWindowSize: TPanel;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblHeight: TLabel;
    lblWidth: TLabel;
    editLeft: TEdit;
    editTop: TEdit;
    editHeight: TEdit;
    editWidth: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateWindowSize;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    rTop     : smallint;
    rLeft    : smallint;
    rWidth   : smallint;
    rHeight  : smallint;
    PrevSize : string;
  end;

var
  CrpeWindowSizeDlg: TCrpeWindowSizeDlg;
  bWindowSize      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.FormCreate(Sender: TObject);
begin
  bWindowSize := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.FormShow(Sender: TObject);
begin
  {Store current VCL Settings}
  rTop    := Cr.WindowSize.Top;
  rLeft   := Cr.WindowSize.Left;
  rWidth  := Cr.WindowSize.Width;
  rHeight := Cr.WindowSize.Height;
  UpdateWindowSize;
end;
{------------------------------------------------------------------------------}
{ UpdateWindowSize                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.UpdateWindowSize;
begin
  {Enable/Disable controls}
  editTop.Text := IntToStr(Cr.WindowSize.Top);
  editHeight.Text := IntToStr(Cr.WindowSize.Height);
  editLeft.Text := IntToStr(Cr.WindowSize.Left);
  editWidth.Text := IntToStr(Cr.WindowSize.Width);
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.InitializeControls(OnOff: boolean);
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
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.editSizeExit(Sender: TObject);
begin
  if not IsNumeric(TEdit(Sender).Text) then
    TEdit(Sender).Text := PrevSize
  else
  begin
    if TEdit(Sender).Name = 'editTop' then
      Cr.WindowSize.Top := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editLeft' then
      Cr.WindowSize.Left := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editWidth' then
      Cr.WindowSize.Width := StrToInt(TEdit(Sender).Text);
    if TEdit(Sender).Name = 'editHeight' then
      Cr.WindowSize.Height := StrToInt(TEdit(Sender).Text);
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.btnClearClick(Sender: TObject);
begin
  Cr.WindowSize.Clear;
  UpdateWindowSize;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  editSizeExit(editTop);
  editSizeExit(editLeft);
  editSizeExit(editWidth);
  editSizeExit(editHeight);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowSizeDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.WindowSize.Top := rTop;
    Cr.WindowSize.Left := rLeft;
    Cr.WindowSize.Width := rWidth;
    Cr.WindowSize.Height := rHeight;
  end;
  bWindowSize := False;
  Release;
end;


end.
