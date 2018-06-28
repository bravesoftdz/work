unit UDWindowZoom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, UCrpe32;

type
  TCrpeWindowZoomDlg = class(TForm)
    pnlWindowZoom: TPanel;
    lblMagnification: TLabel;
    btnNext: TSpeedButton;
    tbarMagnification: TTrackBar;
    lblMin: TLabel;
    lblMax: TLabel;
    rgPreview: TRadioGroup;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    procedure FormShow(Sender: TObject);
    procedure UpdateWindowZoom;
    procedure tbarMagnificationChange(Sender: TObject);
    procedure rgPreviewClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr             : TCrpe;
    rMagnification : smallint;
    rPreview       : smallint;
  end;

var
  CrpeWindowZoomDlg: TCrpeWindowZoomDlg;
  bWindowZoom      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.FormCreate(Sender: TObject);
begin
  bWindowZoom := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
  btnClear.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.FormShow(Sender: TObject);
begin
  rMagnification := Cr.WindowZoom.Magnification;
  rPreview := Ord(Cr.WindowZoom.Preview);
  UpdateWindowZoom;
end;
{------------------------------------------------------------------------------}
{ UpdateWindowZoom                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.UpdateWindowZoom;
begin
  tbarMagnification.Position := Cr.WindowZoom.Magnification;
  rgPreview.ItemIndex := Ord(Cr.WindowZoom.Preview);
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TTrackBar then
        TTrackBar(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TSpeedButton then
        TSpeedButton(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ tbarMagnificationChange                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.tbarMagnificationChange(Sender: TObject);
begin
  Cr.WindowZoom.Magnification := tbarMagnification.Position;
  rgPreview.ItemIndex := 3;
  tbarMagnification.Hint := IntToStr(tbarMagnification.Position);
end;
{------------------------------------------------------------------------------}
{ rgPreviewClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.rgPreviewClick(Sender: TObject);
begin
  Cr.WindowZoom.Preview := TCrZoomPreview(rgPreview.ItemIndex);
  if rgPreview.ItemIndex <> 3 then
    Cr.WindowZoom.Magnification := -1;
end;
{------------------------------------------------------------------------------}
{ btnNextClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.btnNextClick(Sender: TObject);
begin
  if rgPreview.ItemIndex < 3 then
    rgPreview.ItemIndex := rgPreview.ItemIndex + 1
  else
    rgPreview.ItemIndex := 0;
  rgPreviewClick(Self);
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.btnClearClick(Sender: TObject);
begin
  Cr.WindowZoom.Clear;
  UpdateWindowZoom;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowZoomDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.WindowZoom.Magnification := rMagnification;
    Cr.WindowZoom.Preview := TCrZoomPreview(rPreview);
  end;
  bWindowZoom := False;
  Release;
end;


end.

