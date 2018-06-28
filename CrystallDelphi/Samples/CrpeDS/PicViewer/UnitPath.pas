unit UnitPath;

interface

uses
  Classes, Forms, Controls, StdCtrls, FileCtrl;

type
  TPathDlg = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirListBox1: TDirectoryListBox;
    EditDestPath: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnNewDir: TButton;
    procedure BtnOKClick(Sender: TObject);
    procedure DirListBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNewDirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    rPath : string;
  end;

var
  PathDlg: TPathDlg;

implementation

{$R *.DFM}

uses Dialogs, SysUtils, Utilities;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TPathDlg.FormCreate(Sender: TObject);
begin
  {hold}
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TPathDlg.FormShow(Sender: TObject);
begin
  if DirectoryExists(rPath) then
    DirListBox1.Directory := rPath;
  editDestPath.Text := DirListBox1.Directory;
end;
{------------------------------------------------------------------------------}
{ DirListBox1Change                                                            }
{------------------------------------------------------------------------------}
procedure TPathDlg.DirListBox1Change(Sender: TObject);
begin
  editDestPath.Text := DirListBox1.Directory;
end;
{------------------------------------------------------------------------------}
{ btnNewDirClick                                                               }
{------------------------------------------------------------------------------}
procedure TPathDlg.btnNewDirClick(Sender: TObject);
var
  sVal  : string;
  sPath : string;
begin
  if InputQuery('Create New Directory', 'Specify New Directory Name', sVal) then
  begin
    sPath := AddBackSlash(editDestPath.Text) + sVal;
    CreateDir(sPath);
    DirListBox1.Update;
    DirListBox1.Directory := sPath;
  end;
end;
{------------------------------------------------------------------------------}
{ BtnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TPathDlg.BtnOKClick(Sender: TObject);
begin
  rPath := DirListBox1.Directory;
end;
{------------------------------------------------------------------------------}
{ DriveComboBox1Change                                                         }
{------------------------------------------------------------------------------}
procedure TPathDlg.DriveComboBox1Change(Sender: TObject);
begin
  DirListBox1.Directory := DriveComboBox1.DirList.Directory;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TPathDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;



end.
