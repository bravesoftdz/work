unit FileDlg;

interface

uses
{$IFDEF WIN32}
  Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
 SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TFileDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    FileBox: TListBox;
    SelectedFile: TEdit;
    procedure FileBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FileDialog: TFileDialog;

implementation

{$R *.DFM}

procedure TFileDialog.FileBoxClick(Sender: TObject);
begin
  SelectedFile.Text := FileBox.Items[FileBox.ItemIndex];
end;

end.
