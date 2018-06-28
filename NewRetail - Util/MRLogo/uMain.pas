unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, DB, ADODB;

type
  TfrmMain = class(TForm)
    ADOCon: TADOConnection;
    quSystem: TADODataSet;
    rdMainRetail: TRadioButton;
    rd360Pet: TRadioButton;
    imgMR: TImage;
    img360Pet: TImage;
    Panel1: TPanel;
    btnSave: TBitBtn;
    btnClose: TBitBtn;
    quSystemVersionNo: TIntegerField;
    quSystemMRLogo: TBlobField;
    imgTraining: TImage;
    rdTraining: TRadioButton;
    rbMultServer: TRadioButton;
    imgMultServer: TImage;
    procedure btnCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    procedure LoadRegistry;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses uParamFunctions, ufrmServerInfo, uDMGlobal, uSystemConst, Registry,
     uNumericFunctions, uOperationSystem;

{$R *.dfm}

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
 buf: tmemorystream;
begin

  LoadRegistry;
  quSystem.Open;
  buf := tmemorystream.create();

  try

    if rd360Pet.Checked then
    begin
      img360Pet.Picture.Bitmap.SaveToStream(buf);
      buf.seek(0, soFromBeginning);
    end
    else if rdTraining.Checked then
    begin
      imgTraining.Picture.Bitmap.SaveToStream(buf);
      buf.seek(0, soFromBeginning);
    end
    else if rbMultServer.Checked then
    begin
      imgMultServer.Picture.Bitmap.SaveToStream(buf);
      buf.seek(0, soFromBeginning);
    end;

   quSystem.Edit;
   if rdMainRetail.Checked then
      quSystemMRLogo.Clear
   else
      TBlobField(quSystem.Fieldbyname('MRLogo')).LoadFromStream(buf);

   quSystem.Post;

   ShowMessage('Logo changed');

  finally
    buf.Free;
    quSystem.Close;
    ADOCon.Close;
  end;
end;

procedure TfrmMain.LoadRegistry;
var
  sResult : String;
  FrmServrInfo : TFrmServerInfo;
  bAbort : Boolean;
  cStartType : Char;

  sServer, sDB,
  sUserName, sPW : String;
  bWinLogin, bUseNetLib : Boolean;
  buildInfo: String;
begin

  with TRegistry.Create do
  begin

   if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
   else
      RootKey := HKEY_LOCAL_MACHINE;

   OpenKey('SOFTWARE\Applenet\MainRetail', True);
   if not ValueExists('DefaultLanguage') then
      DMGlobal.IDLanguage := LANG_ENGLISH
   else
      DMGlobal.IDLanguage := ReadInteger('DefaultLanguage');

   if not ValueExists('LangPath') then
      WriteString('LangPath', ExtractFilePath(ParamStr(0)) + LANG_DIRECTORY);
   DMGlobal.LangFilesPath := ReadString('LangPath');

   CloseKey;
   Free;
  end;

  //Pegar os Parametros 1 - DataBase, 2 - Backup Path,
  //3 - user name, and 4 - password
  FrmServrInfo  := TFrmServerInfo.Create(self);
  Try
     cStartType := '4';
     sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);
  Finally
     FrmServrInfo.Free;
  end;

  FrmServrInfo := nil;
  try
      FrmServrInfo  := TFrmServerInfo.Create(self);
      cStartType := '3';
      sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);

      While not bAbort do
        try
           sServer    := ParseParam(sResult, SV_SERVER);
           sDB        := ParseParam(sResult, SV_DATABASE);
           sUserName  := ParseParam(sResult, SV_USER);
           sPW        := ParseParam(sResult, SV_PASSWORD);
           bWinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
           bUseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');

         if not bWinLogin then
            if bUseNetLib then
               sResult := SetConnectionStr(sUserName, sPW, sDB, sServer)
            else
               sResult := SetConnectionStrNoNETLIB(sUserName, sPW, sDB,sServer)
         else
            if bUseNetLib then
               sResult := SetWinConnectionStr(sDB, sServer)
            else
               sResult := SetWinConnectionStrNoNETLIB(sDB, sServer);

        ADOCon.ConnectionString := sResult;
        ADOCon.Open;
        bAbort := True;
        except
           on E: Exception do
              begin
              sResult := FrmServrInfo.Start(cStartType, True, E.Message, bAbort);
              end;
           end;

  finally
    FrmServrInfo.Free;
  end;


end;

end.
