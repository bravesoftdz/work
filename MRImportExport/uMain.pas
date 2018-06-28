unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, ComCtrls, uDebugFunctions;

Const
  IMG_CATALOG = 0;
  IMG_IMPORT  = 1;
  IMG_EXPORT  = 2;

  OPT_CATALOG = 1;
  OPT_EXPORT  = 2;
  OPT_IMPORT  = 3;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    imgLine: TImage;
    imgSelection: TImage;
    Label5: TLabel;
    Label9: TLabel;
    lbOption: TLabel;
    lblVersion: TLabel;
    Label10: TLabel;
    Shape8: TShape;
    Panel2: TPanel;
    lbImport: TLabel;
    lbExport: TLabel;
    lbCatalog: TLabel;
    imgCatalogSmall: TImage;
    imgExport: TImage;
    imgImport: TImage;
    imgSmall: TImageList;
    Shape6: TShape;
    pnlMain: TPanel;
    pnlSelection: TPanel;
    lbSelection: TLabel;
    lbPowered: TLabel;
    Label8: TLabel;
    imgConnection: TImage;
    pgSelection: TPageControl;
    tsIntro: TTabSheet;
    tsCatalog: TTabSheet;
    tsExport: TTabSheet;
    tsImport: TTabSheet;
    imgSearchCatalog: TImage;
    lbCatalogSearch: TLabel;
    imgComperPrice: TImage;
    lbComperDesc: TLabel;
    lbPriceComper: TLabel;
    Image9: TImage;
    lbInventoryUpdate: TLabel;
    Label13: TLabel;
    imgExpPO: TImage;
    lbExpPO: TLabel;
    Label2: TLabel;
    imgImpotPO: TImage;
    lbImpPO: TLabel;
    Label15: TLabel;
    Image11: TImage;
    lbImpEntiry: TLabel;
    Label19: TLabel;
    Image10: TImage;
    lbImpInv: TLabel;
    Label17: TLabel;
    imgPeachtree: TImage;
    lbPeachtree: TLabel;
    lbPeachDesc: TLabel;
    lbCatalogSearchInfo: TLabel;
    imgSysnc: TImage;
    lbSyncData: TLabel;
    Label4: TLabel;
    Image1: TImage;
    lbPetCenter: TLabel;
    lbPetCenterDetail: TLabel;
    lbUser: TLabel;
    lbExpirationInfo: TLabel;
    lbLicense: TLabel;
    lbQuickDesc: TLabel;
    lbQuickBooks: TLabel;
    Image3: TImage;
    Image2: TImage;
    LblVendorFile: TLabel;
    Label3: TLabel;
    procedure lbColumnsMouseLeave(Sender: TObject);
    procedure lbColumnsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure PersonMouseLeave(Sender: TObject);
    procedure PersonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbExpPOMouseLeave(Sender: TObject);
    procedure lbExpPOMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label10Click(Sender: TObject);
    procedure lbCatalogMouseEnter(Sender: TObject);
    procedure lbCatalogMouseLeave(Sender: TObject);
    procedure lbCatalogClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbPriceComperClick(Sender: TObject);
    procedure lbImpPOClick(Sender: TObject);
    procedure lbImpEntiryClick(Sender: TObject);
    procedure lbImpInvClick(Sender: TObject);
    procedure lbExpPOClick(Sender: TObject);
    procedure lbInventoryUpdateClick(Sender: TObject);
    procedure lbCatalogSearchClick(Sender: TObject);
    procedure lbPeachtreeClick(Sender: TObject);
    procedure lbSyncDataClick(Sender: TObject);
    procedure lbPetCenterClick(Sender: TObject);
    procedure lbLicenseClick(Sender: TObject);
    procedure lbQuickBooksClick(Sender: TObject);
    procedure LblVendorFileClick(Sender: TObject);
  private
    procedure LoadImage;
    procedure HidePanels;
    procedure LoadParams;
    procedure ShowPanel(Option:Integer);
    function ValidateLogin : Boolean;
    function ValidateModule(Module : String) : Boolean; 
    function CallAutoLogin(PW: String): Boolean;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uWizImportPO, uWizImportCatalog, uFrmServerConnection, uWizImportPerson,
  uWizImportInventory, uDMImportExport, uWizExportPO, uFrmInventoryUpdate, ULogin,
  uFrmCatalogSearch, uFrmPeachtree, uFrmCatalogSyncData, uWizImportPet,
  uUserObj, uMainRetailKeyConst, uMsgBox, uFrmQuickBooks, uWizImportVendorCatalog;

{$R *.dfm}

procedure TFrmMain.lbColumnsMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TFrmMain.lbColumnsMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
  Screen.Cursor := crHandPoint;
end;

procedure TFrmMain.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
  Screen.Cursor := crHandPoint;
end;

procedure TFrmMain.Label1MouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TFrmMain.PersonMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TFrmMain.PersonMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
  Screen.Cursor := crHandPoint;
end;

procedure TFrmMain.lbExpPOMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TFrmMain.lbExpPOMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
  Screen.Cursor := crHandPoint;
end;

procedure TFrmMain.Label10Click(Sender: TObject);
begin
  with TFrmServerConnection.Create(Self) do
  try
    Start(1);
  finally
    Free;
  end;
end;

procedure TFrmMain.HidePanels;
begin
 pgSelection.ActivePage := tsIntro;
end;

procedure TFrmMain.LoadImage;
begin
  imgSmall.GetBitmap(IMG_CATALOG, imgCatalogSmall.Picture.Bitmap);
  imgSmall.GetBitmap(IMG_IMPORT, imgImport.Picture.Bitmap);
  imgSmall.GetBitmap(IMG_EXPORT, imgExport.Picture.Bitmap);
end;

procedure TFrmMain.ShowPanel(Option: Integer);
begin
  HidePanels;
  case Option of
   OPT_CATALOG : pgSelection.ActivePage := tsCatalog;
   OPT_IMPORT  : pgSelection.ActivePage := tsImport;
   OPT_EXPORT  : pgSelection.ActivePage := tsExport;
  end;
end;

procedure TFrmMain.lbCatalogMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [fsBold];
end;

procedure TFrmMain.lbCatalogMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
end;

procedure TFrmMain.lbCatalogClick(Sender: TObject);
begin
  lbSelection.Caption := TLabel(Sender).Caption;
  ShowPanel(TLabel(Sender).Tag);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  LoadImage;
  HidePanels;
  LoadParams;
end;

procedure TFrmMain.lbPriceComperClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_CAT_PRICE_COM) then
    with TFrmInventoryUpdate.Create(Self) do
    try
      Start(1);
    finally
      free;
    end;
end;

procedure TFrmMain.lbImpPOClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_IMP_PO) then
    with TWizImportPO.Create(Self) do
    try
      Start;
    finally
      free;
    end;
end;

procedure TFrmMain.lbImpEntiryClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_IMP_ENTITY) then
    with TWizImportPerson.Create(Self) do
    try
      Start;
    finally
      Free;
    end;
end;

procedure TFrmMain.lbImpInvClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_IMP_INV) then
    with TWizImportInventory.Create(Self) do
    try
      Start;
    finally
      Free;
    end;
end;

procedure TFrmMain.lbExpPOClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_EXP_PO) then
    with TWizExportPO.Create(Self) do
    try
      Start;
    finally
      Free;
    end;
end;

procedure TFrmMain.lbInventoryUpdateClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_CAT_INV_UPD) then
    with TFrmInventoryUpdate.Create(Self) do
    try
      Start(2);
    finally
      Free;
    end;
end;

function TFrmMain.ValidateLogin: Boolean;
begin
  try
    DMImportExport.OpenConnection;

    if DMImportExport.FUser.Password = '' then
    begin
      with TRepLoginFrm.Create(Self) do
      try
        Result := Start;
        lbUser.Caption := DMImportExport.FUser.UserName;
        lbExpirationInfo.Visible := False;

        if DMImportExport.FSoftwareExpired then
        begin
          lbExpirationInfo.Visible := True;
          lbExpirationInfo.Caption := 'Software expired since ' + FormatDateTime('ddddd', DMImportExport.FSoftwareExpirationDate);
        end
        else if ((DMImportExport.FSoftwareExpirationDate - 10) < Trunc(Now)) then
        begin
          lbExpirationInfo.Visible := True;
          lbExpirationInfo.Caption := 'Software will expire on ' + FormatDateTime('ddddd', DMImportExport.FSoftwareExpirationDate);
        end;

        lbLicense.Visible := True;

      finally
        Free;
      end;
    end
    else
      Result := True;
  except
    on E: Exception do
      begin
        Result := False;
        MsgBox(E.Message, vbCritical + vbOkOnly);
       end;
  end;
end;

procedure TFrmMain.lbCatalogSearchClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_CAT_SRCH) then
    with TFrmCatalogSearch.Create(Self) do
    try
      Start;
    finally
      Free;
    end;
end;

procedure TFrmMain.lbPeachtreeClick(Sender: TObject);
begin

  if ValidateLogin and ValidateModule(SOFTWARE_IE_EXP_PEACHTREE) then
    with TFrmPeachtree.Create(self) do
      Start;
      
end;


procedure TFrmMain.lbSyncDataClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_CAT_SYNC) then
    with TFrmCatalogSyncData.Create(Self) do
      Start;
end;

procedure TFrmMain.lbPetCenterClick(Sender: TObject);
begin
  if ValidateLogin and ValidateModule(SOFTWARE_IE_IMP_PET) then
    with TWizImportPet.Create(Self) do
    try
      Start;
    finally
      Free;
    end;
end;

procedure TFrmMain.LoadParams;
begin

  if ParamCount > 0 then
  begin
    if ParamStr(1) = 'PET' then
    begin
     pgSelection.ActivePage := tsImport;
     if (ParamCount > 1) and (ParamStr(2) <> '') then
     begin
       CallAutoLogin(ParamStr(2));
       lbPetCenter.OnClick(Self);
       Close;
     end;
    end;
  end;

end;


function TFrmMain.CallAutoLogin(PW: String): Boolean;
begin
  if PW <> '' then
  begin
    with TRepLoginFrm.Create(Self) do
    try
      Result := AutoLogin(PW);
      lbUser.Caption := DMImportExport.FUser.UserName;
    finally
      Free;
    end;
  end
  else
    Result := True;
end;

function TFrmMain.ValidateModule(Module: String): Boolean;
begin

  Result := False;

  if not DMImportExport.ActiveConnection.AppServer.SoftwareModuleAccess(SOFTWARE_IE, Module) then
  begin
    MsgBox('You do not have access for this module.', vbInformation + vbOKOnly);
    Exit;
  end;

  Result := True;

end;

procedure TFrmMain.lbLicenseClick(Sender: TObject);
begin
  with TFrmServerConnection.Create(Self) do
  try
    Start(2);
  finally
    Free;
  end;

end;

procedure TFrmMain.lbQuickBooksClick(Sender: TObject);
begin

  if ValidateLogin and ValidateModule(SOFTWARE_IE_EXP_QB) then
    with TFrmQuickBooks.Create(Self) do
    try
      Start;
    finally
      Free;
    end;

end;

{ Alex 29/03/2011 }
procedure TFrmMain.LblVendorFileClick(Sender: TObject);
begin

  If ( ValidateLogin And ValidateModule( SOFTWARE_IE_IMP_VC ) ) Then Begin

    With TWizImportVendorCatalog.Create( Self ) Do Begin
      Try
        Start;
      Finally
        Free;
      End;
    End;

  End;

end;

end.
