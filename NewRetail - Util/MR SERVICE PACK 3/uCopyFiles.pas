unit uCopyFiles;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ShellAPI, FileCtrl;

type
  TfrmCopyFiles = class(TForm)
    btnClose: TButton;
    btnOK: TButton;
    edtPath: TEdit;
    lbLocalPath: TLabel;
    sbOpen: TSpeedButton;
    OD: TOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbOpenClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    fPath : String;
    procedure StartCopy(sFrom, sTo: String);
  public
    { Public declarations }
    function Start(sTitle, sPath:String):boolean;
  end;

implementation

{$R *.DFM}

function TfrmCopyFiles.Start(sTitle, sPath:String):boolean;
begin

   fPath := sPath;
   lbLocalPath.Caption := 'Where are ' + sTitle + ' located?';

   OD.InitialDir := 'C:\Program Files\Applications Network\Main Retail';

   if DirectoryExists(OD.InitialDir) then
      edtPath.Text := OD.InitialDir+'\';

   ShowModal;
   Result := (ModalResult = MrOK);

end;

procedure TfrmCopyFiles.btnCloseClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmCopyFiles.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCopyFiles.sbOpenClick(Sender: TObject);
begin
   if OD.Execute then
      edtPath.Text := ExtractFilePath(OD.FileName);
end;

procedure TfrmCopyFiles.StartCopy(sFrom, sTo: String);
var
  FO: TSHFileOpStruct;
begin

  if not DirectoryExists(sFrom) then
     Exit;

  FO.Wnd    := Handle;
  FO.wFunc  := FO_COPY;
  FO.pFrom  := PChar(IncludeTrailingBackSlash(sFrom) + '*.*'#0#0);
  FO.pTo    := PChar(IncludeTrailingBackSlash(sTo) + #0#0);
  FO.fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_ALLOWUNDO or FOF_SIMPLEPROGRESS;
              ShFileOperation(FO);

end;


procedure TfrmCopyFiles.btnOKClick(Sender: TObject);
begin

  if (Trim(edtPath.Text) = '') or not DirectoryExists(edtPath.Text) then
     begin
     ShowMessage('Invalid directory');
     ModalResult := mrNone;
     Exit;
     end;

  StartCopy(fPath, edtPath.Text);

end;

end.


