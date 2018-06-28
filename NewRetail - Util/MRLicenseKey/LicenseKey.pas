unit LicenseKey;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ActnList, Buttons, ExtCtrls, ImgList;

type
  TfrmLicenseKey = class(TForm)
    imgList: TImageList;
    Image1: TImage;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    action: TActionList;
    actClose: TAction;
    Label1: TLabel;
    Label2: TLabel;
    edtNumber: TEdit;
    cmbModule: TComboBox;
    Label3: TLabel;
    dtpNextDate: TDateTimePicker;
    GroupBox2: TGroupBox;
    btnGenerate: TBitBtn;
    actGenerate: TAction;
    edtKey1: TEdit;
    edtKey3: TEdit;
    edtkey5: TEdit;
    edtKey2: TEdit;
    edtKey4: TEdit;
    Label4: TLabel;
    Edit1: TEdit;
    procedure actGenerateExecute(Sender: TObject);
    procedure cmbModuleCloseUp(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLicenseKey: TfrmLicenseKey;

implementation
uses DataModule, db, uParamFunctions, uEncryptFunctions, uOperationSystem;

{$R *.dfm}

{ TfrmLicenseKey }


procedure TfrmLicenseKey.actGenerateExecute(Sender: TObject);
var
  sKey: String;
  sModule: String;
  ds: TDataSet;
  bUpdate: boolean;
begin
  ds := dm.getModuleInfo;
  sKey := ParseParam(DecodeServerInfo(ds.fieldByname('ModuleInfo').AsString, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU), '#Key#=');

  edit1.Text := DecodeServerInfo(ds.fieldByname('ModuleInfo').AsString, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU) ;

  if sKey <> '' then
     sKey := '#Key#='+sKey+';'
  else
     sKey := '#Key#=N;';

  if ( cmbModule.itemIndex = 0 ) then
    sModule := '4';

  freeAndNil(ds);  
  bUpdate := dm.UpdateModuleInfo(EncodeServerInfo('#Module#='+ sModule +';#Date#='+ dateTimeToStr(dtpNextDate.Date) +';'+sKey, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU));

  if ( bUpdate ) then begin
     edtKey1.Text := encodeServerInfo(sKey, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU);
//     edtKey2 := encodeServerInfo(sModule, 'ModInfo',

  end;


  Screen.Cursor:= crDefault;

  Close;
end;

procedure TfrmLicenseKey.cmbModuleCloseUp(Sender: TObject);
begin
  cmbModule.ItemIndex := 0;
end;

procedure TfrmLicenseKey.actCloseExecute(Sender: TObject);
begin
  close;
end;

end.
