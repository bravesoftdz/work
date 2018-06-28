unit uMainReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, DB, Mask, siComp, Wininet;

type
  TFrmMainReport = class(TForm)
    Panel1: TPanel;
    lblUserName: TLabel;
    hhh: TPanel;
    spHelp: TSpeedButton;
    btClose: TButton;
    btnLogin: TBitBtn;
    btnReport: TBitBtn;
    btnUpDates: TBitBtn;
    lbInfo: TLabel;
    Bevel1: TBevel;
    lbVersion: TLabel;
    lbDateBase: TLabel;
    siLang: TsiLang;
    procedure btCloseClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnUpDatesClick(Sender: TObject);
  private
    { Private declarations }
    fExternalCall : Boolean;
    function GetInetFile(const fileURL, FileName: String): boolean;
  public
    { Public declarations }
  end;

var
  FrmMainReport: TFrmMainReport;

implementation

uses uDM, uDMGlobal, uPassword, uParamFunctions, uwebFunctions, uSQLObj;

{$R *.dfm}

procedure TFrmMainReport.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMainReport.btnReportClick(Sender: TObject);
begin

  if Password.Start(3,4) then
     if not(DM.ppReportExplorer1.Execute) then
        begin
        lbInfo.Caption := 'Error: ' + DM.ppReportExplorer1.ErrorMessage;
        MessageBeep(0);
        end;

  if fExternalCall then
     Close;

end;

procedure TFrmMainReport.FormCreate(Sender: TObject);
begin
  fExternalCall       := False;
  lbInfo.Caption      := '';
  lblUserName.Caption := '';
  lbDateBase.Caption  := DM.fSQLConnectParam.DBAlias + ' ('+DM.fSQLConnectParam.Server+')';

  //Parameters
  If ParamCount=1 then
     begin
     fExternalCall     := True;
     DM.fUser.Password := ParseParam(ParamStr(1), 'PW');
     end;

  DMGlobal.imgLarge.GetBitmap(34, btnLogin.Glyph);
  DMGlobal.imgLarge.GetBitmap(35, btnReport.Glyph);
  DMGlobal.imgLarge.GetBitmap(36, btnUpDates.Glyph);

end;

procedure TFrmMainReport.btnLoginClick(Sender: TObject);
begin
  Password.PermanentLogOn := False;
  if Password.Start(3,4) then
     lblUserName.Caption := DM.fUser.UserName;
end;

procedure TFrmMainReport.FormShow(Sender: TObject);
begin

  if DM.fUser.Password <> '' then
     if Password.Login(DM.fUser.Password) then
        begin
        lblUserName.Caption := DM.fUser.UserName;
        btnReportClick(Self);
        end;
        
end;

procedure TFrmMainReport.btnUpDatesClick(Sender: TObject);
var
 FileOnNet,
 LocalFileName,
 sLocal: string;
 oStream : TStream;
begin

  Screen.Cursor := crHourGlass;

  //Download Arquivo
  sLocal        := ExtractFilePath(Application.ExeName);
  FileOnNet     := 'http://www.mainretail.com/download/mrreportupdates.zip';
  LocalFileName := 'mrreportupdates.zip';
  {
  try
    GetInetFile(FileOnNet,LocalFileName);
  except
    end;

  if not FileExists(sLocal+'mrreportupdates.zip') then
     begin
     Exit;
     end;
  with DM.AbUnZipper do
     begin
     FileName      := sLocal+'mrreportupdates.zip';
     BaseDirectory := sLocal;
     ExtractFiles('*.*');
     CloseArchive;
     end;

  if not FileExists(sLocal+'mrreportupdates.mdb') then
     begin
     Exit;
     end;
  }
  DM.cntAccessReport.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+sLocal+'mrreportupdates.mdb'+';Persist Security Info=False';
  DM.cntAccessReport.Open;

  if DM.euDatabase.Connected then
     DM.euDatabase.Open;

  try

   if not DM.cntAccessReport.Connected then
      Exit;

   DM.quMROpenReport.Open;

   with DM.quNewRepItem do
      begin
      if not Active then
         begin
         Parameters.ParamByName('Idiome').Value := DMGlobal.IDLanguage;  
         Open;
         end;
      {
      while not EOF do
         begin
         if not DM.quMROpenReport.Locate('itemID', DM.quNewRepItemItemID.AsInteger, []) then
            begin

            oStream := DM.quNewRepItem.CreateBlobStream(DM.quNewRepItemTemplate,bmRead);

            //Insert
            DM.quMROpenReport.Append;

            DM.ppReport1.Template.LoadFromStream(oStream);

            //DM.quMROpenReportTemplate.LoadFromStream(oStream);
            //DM.quMROpenReportTemplate.AsVariant := DM.ppReport1;
            //DM.quMROpenReportTemplate.Assign(DM.quNewRepItemTemplate);
            //DM.quMROpenReportTemplate.AsVariant  := DM.quNewRepItemTemplate.AsVariant;
            DM.quMROpenReportItemID.AsInteger    := DM.quNewRepItemItemID.AsInteger;
            DM.quMROpenReportFolderID.AsInteger  := DM.quNewRepItemFolderID.AsInteger;
            DM.quMROpenReportItemType.AsInteger  := 1;
            DM.quMROpenReportVersion.AsInteger   := DM.quNewRepItemVersion.AsInteger;
            DM.quMROpenReportSystem.AsBoolean    := True;
            DM.quMROpenReportModified.AsDateTime := DM.quNewRepItemModified.AsDateTime;
            DM.quMROpenReportName.AsString       := DM.quNewRepItemRepName.AsString;
            DM.quMROpenReportHint.AsString       := DM.quNewRepItemHint.AsString;
            DM.quMROpenReportSize.AsInteger      := DM.quNewRepItemRepSize.AsInteger;
            DM.quMROpenReport.Post;
            oStream.Free;
            end
         else
            begin
            if DM.quMROpenReportVersion.AsInteger <> DM.quNewRepItemVersion.AsInteger then
               begin
               //Update
               DM.quMROpenReport.Edit;
               DM.quMROpenReportTemplate.AsVariant  := DM.quNewRepItemTemplate.AsVariant;
               DM.quMROpenReportItemID.AsInteger    := DM.quNewRepItemItemID.AsInteger;
               DM.quMROpenReportFolderID.AsInteger  := DM.quNewRepItemFolderID.AsInteger;
               DM.quMROpenReportName.AsString       := DM.quNewRepItemRepName.AsString;
               DM.quMROpenReportHint.AsString       := DM.quNewRepItemHint.AsString;
               DM.quMROpenReportItemType.AsInteger  := 1;
               DM.quMROpenReportVersion.AsInteger   := DM.quNewRepItemVersion.AsInteger;
               DM.quMROpenReportModified.AsDateTime := DM.quNewRepItemModified.AsDateTime;
               DM.quMROpenReportSize.AsInteger      := DM.quNewRepItemRepSize.AsInteger;
               DM.quMROpenReport.Post;
               end;
            end;
         Next;
         end;}
      end;

  finally;
    DM.quNewRepItem.Close;
    DM.cntAccessReport.Close;
    DM.quMROpenReport.Close;
    Screen.Cursor := crDefault;
    ShowMessage('Restart application');
    end;

   DeleteFile(sLocal+'mrreportupdates.zip');
   DeleteFile(sLocal+'mrreportupdates.mdb');

   Close;
   
end;

function TFrmMainReport.GetInetFile(const fileURL, FileName: String): boolean;
const BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: File;
  sAppName: string;
begin
 Result:=False;
 sAppName := ExtractFileName(Application.ExeName);
 hSession := InternetOpen(PChar(sAppName),
                INTERNET_OPEN_TYPE_PRECONFIG,
               nil, nil, 0);
 try
  hURL := InternetOpenURL(hSession,
            PChar(fileURL),
            nil,0,0,0);
  try
   AssignFile(f, FileName);
   Rewrite(f,1);
   repeat
    InternetReadFile(hURL, @Buffer,
                     SizeOf(Buffer), BufferLen);
    BlockWrite(f, Buffer, BufferLen);
    FlashWindow(Application.Handle,True);
   until BufferLen = 0;
   CloseFile(f);
   Result:=True;
  finally
   InternetCloseHandle(hURL)
  end
 finally
  InternetCloseHandle(hSession)
 end;

end;

end.
