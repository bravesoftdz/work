unit UDPathEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, {$WARNINGS OFF}FileCtrl{$WARNINGS ON};

type
  TCrpePathDlg = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirListBox1: TDirectoryListBox;
    EditDestPath: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure BtnOKClick(Sender: TObject);
    procedure DirListBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    rPath : string;
  end;

var
  CrpePathDlg: TCrpePathDlg;

implementation

{$R *.DFM}

uses UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePathDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpePathDlg.FormShow(Sender: TObject);
begin
  if DirectoryExists(rPath) then
    DirListBox1.Directory := rPath;
  editDestPath.Text := DirListBox1.Directory;
end;
{------------------------------------------------------------------------------}
{ DirListBox1Change                                                            }
{------------------------------------------------------------------------------}
procedure TCrpePathDlg.DirListBox1Change(Sender: TObject);
begin
  editDestPath.Text := DirListBox1.Directory;
end;
{------------------------------------------------------------------------------}
{ BtnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpePathDlg.BtnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  rPath := DirListBox1.Directory;
end;
{------------------------------------------------------------------------------}
{ DriveComboBox1Change                                                         }
{------------------------------------------------------------------------------}
procedure TCrpePathDlg.DriveComboBox1Change(Sender: TObject);
begin
  DirListBox1.Directory := DriveComboBox1.DirList.Directory;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpePathDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
