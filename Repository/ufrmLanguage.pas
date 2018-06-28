unit ufrmLanguage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, siComp, siLangRT, siDialog, Registry;

Const
   MR = 1;
   OM = 2;

type
  TfrmLanguage = class(TForm)
    btnClose: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgFlags: TImage;
    Label4: TLabel;
    Label5: TLabel;
    btnPath: TButton;
    OD: TsiOpenDialog;
    btnDownload: TButton;
    siLang: TsiLangRT;
    Bevel1: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    RegRoot : String;
    procedure SetLangFile(Path:String);
  public
    { Public declarations }
    procedure Start(Software:Integer);
  end;

implementation

uses uWebFunctions, uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}

procedure TfrmLanguage.Start(Software:Integer);
begin
   Case Software of
      MR : RegRoot := 'SOFTWARE\Applenet\MainRetail';
      OM : RegRoot := 'SOFTWARE\Applenet\OfficeManager';
   end;

   ShowModal;
end;

procedure TfrmLanguage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmLanguage.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLanguage.Label3Click(Sender: TObject);
begin

  OpenURL('http://www.mainretail.com/');

end;

procedure TfrmLanguage.SetLangFile(Path:String);
var
   reg : TRegistry;
begin

   reg := TRegistry.Create;

   Try
     // Abre o registry
     with reg do
       begin
         RootKey := HKEY_LOCAL_MACHINE;
         OpenKey(RegRoot, True);
         WriteString('LangPath', Path);
       end;
   Finally
       reg.CloseKey;
       reg.Free;
     end;
end;


procedure TfrmLanguage.btnPathClick(Sender: TObject);
begin

  OD.InitialDir := DMGlobal.LangFilesPath;

  If OD.Execute and (OD.FileName <> '') then
     begin
     SetLangFile(ExtractFilePath(OD.FileName));
     MsgBox(MSG_INF_CHANGES_SYS, vbInformation + vbOKOnly);
     Close;
     end;

end;

procedure TfrmLanguage.FormCreate(Sender: TObject);
begin

  //Setup Language  
  if (DMGlobal.IDLanguage <> LANG_ENGLISH) and (siLang.StorageFile <> '') then
     begin
     if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
        siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
        MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);
     end;

end;

end.
