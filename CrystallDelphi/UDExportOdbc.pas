unit UDExportOdbc;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
  UCrpe32;

type
  TCrpeOdbcDlg = class(TForm)
    pnlOdbc: TPanel;
    lblSource: TLabel;
    lblUser: TLabel;
    lblPassword: TLabel;
    lblTable: TLabel;
    editSource: TEdit;
    editUser: TEdit;
    editPassword: TEdit;
    editTable: TEdit;
    btnSelect: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    cbPrompt: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbPromptClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeOdbcDlg: TCrpeOdbcDlg;

implementation

{$R *.DFM}

uses UDExportOptions, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.FormShow(Sender: TObject);
begin
  editSource.Text := Cr.ExportOptions.ODBC.Source;
  editUser.Text := Cr.ExportOptions.ODBC.User;
  editPassword.Text := Cr.ExportOptions.ODBC.Password;
  editTable.Text := Cr.ExportOptions.ODBC.Table;
  cbPrompt.Checked := Cr.ExportOptions.ODBC.Prompt;
end;
{------------------------------------------------------------------------------}
{ cbPromptClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.cbPromptClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  OnOff := (cbPrompt.Checked = False);
  editSource.Enabled := OnOff;
  editUser.Enabled := OnOff;
  editPassword.Enabled := OnOff;
  editTable.Enabled := OnOff;
  editSource.Color := ColorState(OnOff);
  editUser.Color := ColorState(OnOff);
  editPassword.Color := ColorState(OnOff);
  editTable.Color := ColorState(OnOff);
  btnSelect.Enabled := OnOff;
end;
{------------------------------------------------------------------------------}
{ btnSelectClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.btnSelectClick(Sender: TObject);
const
  SQL_SUCCESS           = 0;
  SQL_DRIVER_PROMPT     = 2;
  SQL_SUCCESS_WITH_INFO = 1;
  SQL_DATA_SOURCE_NAME  = 2;
type
  MyUChar = array[0..255] of char;
  TSQLAllocEnv = function (var henv: Pointer): SmallInt stdcall;
  TSQLAllocConnect = function (henv: Pointer; var hdbc: Pointer): SmallInt stdcall;
  TSQLDriverConnect = function (hdbc: Pointer; window: hWnd;
    szConnStrIn: MyUChar; cbConnStrIn: SmallInt; szConnStrOut: MyUChar;
    cbConnStrOutMax: SmallInt; var pcbConnStrOut: Pointer;
    fDriverCompletion: Word ): SmallInt stdcall;
  TSQLGetInfo = function (hdbc: Pointer; fInfoType: SmallInt;
    rgbInfoValue: PChar; cbInfoValueMax: SmallInt;
    var pcbInfoValue: SmallInt): SmallInt stdcall;
var
  henv : Pointer;
  hdbc : Pointer;
  ConIn, ConOut : MyUChar;
  LenIn, LenOut : SmallInt;
  RetCode : SmallInt;
  TotOut : Pointer;
  x : SmallInt;
  Temp : PChar;
  hODBC32 : THandle;
  SQLAllocEnv: TSQLAllocEnv;
  SQLAllocConnect: TSQLAllocConnect;
  SQLDriverConnect: TSQLDriverConnect;
  SQLGetInfo: TSQLGetInfo;
begin
  LenIn := 256;
  LenOut := 256;
  henv := Nil;
  hdbc := Nil;

  hODBC32 := LoadLibrary('ODBC32.DLL');
  if (hODBC32 < HINSTANCE_ERROR) then
  begin
    MessageDlg('ODBC32.DLL could not be loaded.', mtError, [mbOk], 0);
    Exit;
  end;

  SQLAllocEnv := GetProcAddress(hODBC32, 'SQLAllocEnv');
  if TSQLAllocEnv(SQLAllocEnv)(henv) <> SQL_SUCCESS then
  begin
    MessageDlg('ODBC Connect Failed.', mtError, [mbOk], 0);
    Exit;
  end;

  SQLAllocConnect := GetProcAddress(hODBC32, 'SQLAllocConnect');
  if TSQLAllocConnect(SQLAllocConnect)(henv, hdbc) <> SQL_SUCCESS then
  begin
    MessageDlg('ODBC Connect Failed.', mtError, [mbOk], 0);
    Exit;
  end;

  FillChar(ConIn, 256, ' ');
  SQLDriverConnect := GetProcAddress(hODBC32, 'SQLDriverConnect');
  RetCode := TSQLDriverConnect(SQLDriverConnect)(hdbc, Self.Handle, ConIn,
    LenIn, ConOut, LenOut, TotOut, SQL_DRIVER_PROMPT);
  Refresh;
  if ((Retcode <> SQL_SUCCESS) and (Retcode <> SQL_SUCCESS_WITH_INFO)) then
  begin
    MessageDlg('ODBC Connect Failed.', mtError, [mbOk], 0);
    Exit;
  end;

  Temp := StrAlloc(255);
  SQLGetInfo := GetProcAddress(hODBC32, 'SQLGetInfo');
  RetCode := TSQLGetInfo(SQLGetInfo)(hdbc, SQL_DATA_SOURCE_NAME, Temp, 255, x);
  if (Retcode <> SQL_SUCCESS) AND (RetCode <> SQL_SUCCESS_WITH_INFO) then
  begin
    MessageDlg('ODBC Connect Failed.', mtError, [mbOk], 0);
    StrDispose(Temp);
    Exit;
  end;
  editSource.Text := StrPas(Temp);
  StrDispose(Temp);
end;
{------------------------------------------------------------------------------}
{ btnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.btnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.ODBC.Source := editSource.Text;
  Cr.ExportOptions.ODBC.User := editUser.Text;
  Cr.ExportOptions.ODBC.Password := editPassword.Text;
  Cr.ExportOptions.ODBC.Table := editTable.Text;
  Cr.ExportOptions.ODBC.Prompt := cbPrompt.Checked;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeOdbcDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;



end.
