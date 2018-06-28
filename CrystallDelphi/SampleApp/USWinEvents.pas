unit USWinEvents;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, StdCtrls, Buttons, ExtCtrls, ClipBrd, Dialogs;

type
  TCrpeWindowEventsDlg = class(TForm)
    SaveDialog1: TSaveDialog;
    pnlBottom: TPanel;
    pnlUpper: TPanel;
    pnlTopEdge: TPanel;
    memoWindowEvents: TMemo;
    pnlRightEdge: TPanel;
    pnlLeftEdge: TPanel;
    pnlBBar2: TPanel;
    sbActivatedEvents: TSpeedButton;
    sbClear: TSpeedButton;
    sbCut: TSpeedButton;
    sbCopy: TSpeedButton;
    sbPaste: TSpeedButton;
    sbSaveToFile: TSpeedButton;
    btnOk: TButton;
    procedure sbActivatedEventsClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure sbCutClick(Sender: TObject);
    procedure sbCopyClick(Sender: TObject);
    procedure sbPasteClick(Sender: TObject);
    procedure sbSaveToFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CrpeWindowEventsDlg : TCrpeWindowEventsDlg;
  bWindowEventsDlg    : Boolean;

implementation

uses UCrpeUtl, USActvEvents, UnitMain;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.FormCreate(Sender: TObject);
begin
  LoadFormSize(Self);
  bWindowEventsDlg := True;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.FormShow(Sender: TObject);
begin
  memoWindowEvents.Clear;
end;
{------------------------------------------------------------------------------}
{ sbActivatedEventsClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.sbActivatedEventsClick(Sender: TObject);
begin
  CrpeActiveEventsDlg := TCrpeActiveEventsDlg.Create(Application);
  CrpeActiveEventsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ sbClearClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.sbClearClick(Sender: TObject);
begin
  memoWindowEvents.Clear;
end;
{------------------------------------------------------------------------------}
{ sbCutClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.sbCutClick(Sender: TObject);
begin
  memoWindowEvents.CutToClipboard;
end;
{------------------------------------------------------------------------------}
{ sbCopyClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.sbCopyClick(Sender: TObject);
begin
  memoWindowEvents.CopyToClipboard;
end;
{------------------------------------------------------------------------------}
{ sbPasteClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.sbPasteClick(Sender: TObject);
begin
  if Clipboard.HasFormat(CF_TEXT) then
    memoWindowEvents.PasteFromClipboard;
end;
{------------------------------------------------------------------------------}
{ sbSaveToFileClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.sbSaveToFileClick(Sender: TObject);
begin
  SaveDialog1.Title := 'Save Window Events List...';
  SaveDialog1.FileName := '*.txt';
  SaveDialog1.Filter := 'Text files (*.TXT)|*.txt|All files (*.*)|*.*';
  if SaveDialog1.Execute then
    memoWindowEvents.Lines.SaveToFile(SaveDialog1.FileName);
end;
{------------------------------------------------------------------------------}
{ btnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.btnOKClick(Sender: TObject);
begin
  SaveFormSize(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeWindowEventsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bWindowEventsDlg := False;
  Release;
end;


end.
