unit UDWindowCursor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeWindowCursorDlg = class(TForm)
    pnlWindowCursors: TPanel;
    lblCursors: TLabel;
    lblWindowArea: TLabel;
    lblCursorTypes: TLabel;
    sboxCursorShapes: TScrollBox;
    imgDefault: TImage;
    shpSelection: TShape;
    imgMagnify: TImage;
    imgHelp: TImage;
    imgAppStart: TImage;
    imgWait: TImage;
    imgNo: TImage;
    imgSizeNS: TImage;
    imgSizeWE: TImage;
    imgSizeNESW: TImage;
    imgSizeNWSE: TImage;
    imgSizeAll: TImage;
    imgUpArrow: TImage;
    imgIBeam: TImage;
    imgCross: TImage;
    imgArrow: TImage;
    lbWindowArea: TListBox;
    cbCursorTypes: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    imgZoomIn: TImage;
    imgReportSection: TImage;
    imgHand: TImage;
    imgGrabHand: TImage;
    imgBackground: TImage;
    procedure lbWindowAreaClick(Sender: TObject);
    procedure imgCursorClick(Sender: TObject);
    procedure cbCursorTypesChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateWindowCursor;
  private
    { Private declarations }
  public
    { Public declarations }
    Cr                 : TCrpe;
    rDetailArea        : TCrWindowCursor;
    rDetailAreaField   : TCrWindowCursor;
    rGraph             : TCrWindowCursor;
    rGroupArea         : TCrWindowCursor;
    rGroupAreaField    : TCrWindowCursor;
    rHyperLink         : TCrWindowCursor;
    rOnDemandSubreport : TCrWindowCursor;
  end;

var
  CrpeWindowCursorDlg: TCrpeWindowCursorDlg;
  bWindowCursor      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.FormCreate(Sender: TObject);
begin
  bWindowCursor := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.FormShow(Sender: TObject);
begin
  {Store current VCL Settings}
  rDetailArea        := Cr.WindowCursor.DetailArea;
  rDetailAreaField   := Cr.WindowCursor.DetailAreaField;
  rGraph             := Cr.WindowCursor.Graph;
  rGroupArea         := Cr.WindowCursor.GroupArea;
  rGroupAreaField    := Cr.WindowCursor.GroupAreaField;
  rHyperLink         := Cr.WindowCursor.HyperLink;
  rOnDemandSubreport := Cr.WindowCursor.OnDemandSubreport;
  UpdateWindowCursor;
end;
{------------------------------------------------------------------------------}
{ UpdateWindowCursor                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.UpdateWindowCursor;
begin
  lbWindowArea.ItemIndex := 0;
  lbWindowAreaClick(Self);
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TScrollBox then
        TScrollBox(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbWindowAreaClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.lbWindowAreaClick(Sender: TObject);
begin
  case lbWindowArea.ItemIndex of
    0: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.DetailArea);
    1: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.DetailAreaField);
    2: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.Graph);
    3: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.GroupArea);
    4: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.GroupAreaField);
    5: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.HyperLink);
    6: cbCursorTypes.ItemIndex := Ord(Cr.WindowCursor.OnDemandSubreport);
  end;
  shpSelection.Left := 2 + (cbCursorTypes.ItemIndex * 32) - sboxCursorShapes.HorzScrollBar.Position;
  sboxCursorShapes.HorzScrollBar.Position := (shpSelection.Left - 2) + sboxCursorShapes.HorzScrollBar.Position;
end;
{------------------------------------------------------------------------------}
{ cbCursorTypesChange                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.cbCursorTypesChange(Sender: TObject);
begin
  case lbWindowArea.ItemIndex of
    0: Cr.WindowCursor.DetailArea := TCrWindowCursor(cbCursorTypes.ItemIndex);
    1: Cr.WindowCursor.DetailAreaField := TCrWindowCursor(cbCursorTypes.ItemIndex);
    2: Cr.WindowCursor.Graph := TCrWindowCursor(cbCursorTypes.ItemIndex);
    3: Cr.WindowCursor.GroupArea := TCrWindowCursor(cbCursorTypes.ItemIndex);
    4: Cr.WindowCursor.GroupAreaField := TCrWindowCursor(cbCursorTypes.ItemIndex);
    5: Cr.WindowCursor.HyperLink := TCrWindowCursor(cbCursorTypes.ItemIndex);
    6: Cr.WindowCursor.OnDemandSubreport := TCrWindowCursor(cbCursorTypes.ItemIndex);
  end;
  shpSelection.Left := 2 + (cbCursorTypes.ItemIndex * 32) - sboxCursorShapes.HorzScrollBar.Position;
  sboxCursorShapes.HorzScrollBar.Position := (shpSelection.Left - 2) + sboxCursorShapes.HorzScrollBar.Position;
end;
{------------------------------------------------------------------------------}
{ imgCursorClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.imgCursorClick(Sender: TObject);
begin
  cbCursorTypes.ItemIndex := TImage(Sender).Tag;
  shpSelection.Left := TImage(Sender).Left - 2;
  case lbWindowArea.ItemIndex of
    0: Cr.WindowCursor.DetailArea := TCrWindowCursor(cbCursorTypes.ItemIndex);
    1: Cr.WindowCursor.DetailAreaField := TCrWindowCursor(cbCursorTypes.ItemIndex);
    2: Cr.WindowCursor.Graph := TCrWindowCursor(cbCursorTypes.ItemIndex);
    3: Cr.WindowCursor.GroupArea := TCrWindowCursor(cbCursorTypes.ItemIndex);
    4: Cr.WindowCursor.GroupAreaField := TCrWindowCursor(cbCursorTypes.ItemIndex);
    5: Cr.WindowCursor.HyperLink := TCrWindowCursor(cbCursorTypes.ItemIndex);
    6: Cr.WindowCursor.OnDemandSubreport := TCrWindowCursor(cbCursorTypes.ItemIndex);
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.btnClearClick(Sender: TObject);
begin
  Cr.WindowCursor.Clear;
  lbWindowArea.ItemIndex := 0;
  lbWindowAreaClick(Self);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowCursorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
  begin
    {Restore Settings}
    Cr.WindowCursor.DetailArea := rDetailArea;
    Cr.WindowCursor.DetailAreaField := rDetailAreaField;
    Cr.WindowCursor.Graph := rGraph;
    Cr.WindowCursor.GroupArea := rGroupArea;
    Cr.WindowCursor.GroupAreaField := rGroupAreaField;
    Cr.WindowCursor.HyperLink := rHyperLink;
    Cr.WindowCursor.OnDemandSubreport := rOnDemandSubreport;
  end;
  bWindowCursor := False;
  Release;
end;


end.
