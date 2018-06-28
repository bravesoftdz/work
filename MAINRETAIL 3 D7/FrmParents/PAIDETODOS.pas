(*
-----------------------------------------------------------------------------------------------------
Version : (288 - 279)
Date    : 01.28.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : if user doubleclick near from form caption,  a pop up appear to him.
Solution: if support or coder,  needs form name pressing "shift + F10" will be enough.
Version : (288 - 280)
-----------------------------------------------------------------------------------------------------
*)

unit PaiDeTodos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, StdCtrls, uDMGlobal,
  ExtCtrls, LblEffct, siComp, siLangRT, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, PowerADOQuery;

type
  TFrmParent = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    EspacamentoSuperior: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    lblSubMenu: TLabelEffect;
    hhh: TPanel;
    lblMenu: TLabel;
    lblUserName: TLabel;
    EEE: TPanel;
    Image1: TImage;
    Label15: TLabel;
    EspacamentoEsquerdo: TPanel;
    EspacamentoDireito: TPanel;
    siLang: TsiLangRT;
    btClose: TButton;
    imgMenu: TImage;
    imgTopIni: TImage;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblSubMenuDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

    //amfsouza June 28, 2012
    class function getBrowserQuery: TPowerADOQuery;
    class procedure setBrowserQuery(value: TPowerAdoQuery);

  protected
    fIsRestricForm : Boolean;
    fLangLoaded : Boolean;
    flbMenuIniPos : Integer;

    procedure CalcLabelMenuLength;
  public
    { Public declarations }
    property BrowserQuery: TPowerADOQuery read getBrowserQuery write setBrowserQuery;
  end;

implementation

{$R *.DFM}
uses uPassword, uDM, PaiDeBrowses, uMsgBox, uMsgConstant;


//amfsouza June 28, 2012
//{$WRITEABLECONST ON}
//const TFrmParent_BrowserQuery: TPowerAdoQuery = nil;
//{$WRITEABLECONST OFF}

var TFrmParent_BrowserQuery: TPowerAdoQuery = nil;



procedure TFrmParent.FormShow(Sender: TObject);
begin

  //Right Menu display
  if flbMenuIniPos = 0 then
     flbMenuIniPos := 10;

  //Load Translation
  if ( DMGlobal.IDLanguage <> LANG_ENGLISH ) then begin

  if (not fLangLoaded) and (siLang.StorageFile <> '') then
      begin
      if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
         siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
         MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);

      fLangLoaded := True;
      end;
  end;

  Caption := Application.Title;

  lblUserName.Caption := DM.fUser.UserName;
  lblUserName.Left := Label15.Left + Label15.Width + 3;
  lblUserName.Top := Label15.Top;

//Rodrigo - Usar no Financeiro
{  with lblUserName do
    if (owner is TBrwParent) or
       (owner is TFrmParent) then
      Caption := ''
    else
      Caption := DM.fUser.UserName;

 with lblUserName do
      Caption := DM.fUser.UserName;      }

  lblMenu.Left := (Image1.Width - lblMenu.Width);

  //Get image
  DM.imgSubMenu.GetBitmap(DM.fMainMenu.Image,imgMenu.Picture.Bitmap);

  //Set os Captions
  lblMenu.Caption    := DM.fMainMenu.MenuName;
  lblSubMenu.Caption := DM.fMainMenu.SubMenuName;
  CalcLabelMenuLength;

end;

procedure TFrmParent.CalcLabelMenuLength;
  function GetSize(leng:Integer):Integer;
  begin
  if leng <= 10 then
     Result := 25
  else if leng < 15 then
     Result := 15
  else
     Result := 14;
  end;
begin
  lblMenu.Left     := (Panel2.Width - lblMenu.Width)-flbMenuIniPos;
  lblSubMenu.Width := length(lblSubMenu.Caption)*GetSize(Length(lblSubMenu.Caption));
  imgTopIni.Width  := lblSubMenu.Width;
end;

procedure TFrmParent.FormCreate(Sender: TObject);
begin
  // Compatibilidade com o SIMain
  if Password <> nil then
    begin
      lblMenu.Caption     := DM.fMainMenu.MenuName;
      lblSubMenu.Caption  := DM.fMainMenu.SubMenuName;
    end;

  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);

  //Usado para nao deichar editar na replicagem
  fIsRestricForm := DM.IsFormsRestric(Self.Name);

end;


procedure TFrmParent.lblSubMenuDblClick(Sender: TObject);
begin
  //amfsouza 01.28.2011 - removed. This approach to support only.
  //ShowMessage('Form : ' + Self.Name);
end;

procedure TFrmParent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // amfsouza 01.28.2011 - if user press shift + F10, supports knows the name of form.
  if ( ssShift in Shift ) and
     ( key = VK_F10 ) then
     showMessage(self.Name);
end;

class function TFrmParent.getBrowserQuery: TPowerADOQuery;
begin
    result := TFrmParent_BrowserQuery;
end;

class procedure TFrmParent.setBrowserQuery(value: TPowerAdoQuery);
begin
   TFrmParent_BrowserQuery := value;
end;

end.
