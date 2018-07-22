unit MenuPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, LblEffct, DB, DBTables, Buttons, Grids, DBGrids, Registry,
  inifiles, jpeg, ComCtrls, ToolWin, ADODB, ShellAPI, siComp,
  siLangRT, uSystemObj, uSystemConst, uOperationSystem, Menus;

const
  MAX_SHORTCUTS = 9;

  MRBUILD =  625; //622;
  DBBUILD =  350; //347;

type
  TMenuItem = record
    CountSubMenu : Integer;
    Name         : string;
  end;

  TSubMenuItem = record
    IDMenu, IDSubMenu : Integer;
    Image, Shortcut   : Integer;
    Name, Tip         : string;
    Enabled           : boolean;
  end;

  TMainMenu = class(TForm)
    quSubMenu: TADOQuery;
    quSubMenuIDMenu: TIntegerField;
    quSubMenuIDSubMenu: TIntegerField;
    quSubMenuName: TStringField;
    quSubMenuTip: TStringField;
    quSubMenuParentMenu: TStringField;
    tmrTime: TTimer;
    quParamTimerCash: TADOQuery;
    quParamTimerCashSrvParameter: TStringField;
    quParamTimerCashSrvValue: TStringField;
    quParamTimerCashDefaultValue: TStringField;
    quParamTimerCashDescription: TStringField;
    tmrCashier: TTimer;
    tmTestMessage: TTimer;
    PanelControl: TPanel;
    PnlPointOfSale: TPanel;
    pnlUtil: TPanel;
    pnlOfficeM: TPanel;
    pnlMaintenace: TPanel;
    pnlCommission: TPanel;
    pnlInventory: TPanel;
    pnlPurchasing: TPanel;
    pnlMediaResult: TPanel;
    pnlSalesSupporte: TPanel;
    lbPOSShortCut: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbSaleSupShortCut: TLabel;
    Label2: TLabel;
    lbAdvertiseShortCut: TLabel;
    Label10: TLabel;
    lbPurchaseShortCut: TLabel;
    Label11: TLabel;
    lbInventoryShortCut: TLabel;
    Label12: TLabel;
    lbCommissionShortCut: TLabel;
    Label14: TLabel;
    lbMaintenanceShortCut: TLabel;
    Label1: TLabel;
    lbOMShortCut: TLabel;
    lblSystemExit: TLabel;
    lbUtilShortCut: TLabel;
    pnlExit: TPanel;
    Label3: TLabel;
    lbExitShortCut: TLabel;
    tmrTrialCount: TTimer;
    quSubMenuEnabled: TBooleanField;
    siLang: TsiLangRT;
    pnlLeft: TPanel;
    Shape7: TShape;
    pnlSistemInfo: TPanel;
    lbSisUser: TLabel;
    lbSisStore: TLabel;
    quSubMenuShortcut: TIntegerField;
    quSubMenuImageIndex: TIntegerField;
    lbSM1: TLabelEffect;
    lbSM2: TLabelEffect;
    lbSM3: TLabelEffect;
    lbSM4: TLabelEffect;
    lbSM5: TLabelEffect;
    lbSM6: TLabelEffect;
    lbSM7: TLabelEffect;
    lbSM8: TLabelEffect;
    lbSM9: TLabelEffect;
    lbSM10: TLabelEffect;
    lbSM11: TLabelEffect;
    lbSM12: TLabelEffect;
    lbSM13: TLabelEffect;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    lbDemo: TLabel;
    TIP: TLabel;
    imgCashierOpen: TImage;
    lblCashier: TLabel;
    pnlControl: TPanel;
    pnlShortcuts: TPanel;
    shpShortCut: TShape;
    lbShortCuts: TLabel;
    pnlSCControl: TPanel;
    pnlSC1: TPanel;
    imgSC1: TImage;
    lbSC1: TStaticText;
    pnlSC2: TPanel;
    imgSC2: TImage;
    lbSC2: TStaticText;
    pnlSC3: TPanel;
    imgSC3: TImage;
    lbSC3: TStaticText;
    pnlSC4: TPanel;
    imgSC4: TImage;
    lbSC4: TStaticText;
    pnlSC6: TPanel;
    imgSC6: TImage;
    lbSC6: TStaticText;
    pnlSC5: TPanel;
    imgSC5: TImage;
    lbSC5: TStaticText;
    pnlSC8: TPanel;
    imgSC8: TImage;
    lbSC8: TStaticText;
    pnlSC9: TPanel;
    imgSC9: TImage;
    lbSC9: TStaticText;
    pnlSC7: TPanel;
    imgSC7: TImage;
    lbSC7: TStaticText;
    pnlSystem: TPanel;
    shpSystem: TShape;
    imgManagerClose: TImage;
    imgManagerOpen: TImage;
    Label13: TLabel;
    lbLogIn: TLabel;
    lblOdblClick: TLabel;
    imgSystemInfo: TImage;
    lbSysInfo: TLabel;
    lbMenuColor: TLabel;
    imgMenuColor: TImage;
    pnlHelp: TPanel;
    shpHelp: TShape;
    Label6: TLabel;
    lbTip: TLabel;
    imgTip: TImage;
    imgHelp: TImage;
    lbHelp: TLabel;
    pnlDiv1: TPanel;
    Panel1: TPanel;
    Shape4: TShape;
    Image14: TImage;
    lbSM14: TLabelEffect;
    Shape6: TShape;
    lblVersion: TLabel;
    lbModule: TLabel;
    Label4: TLabel;
    Shape5: TShape;
    lbHelpShort: TLabel;
    lbLogShort: TLabel;
    lblClockShadow: TLabel;
    lblClock: TLabel;
    Panel3: TPanel;
    imgTop: TImage;
    Panel2: TPanel;
    imgClientLogo: TImage;
    Label5: TLabel;
    imgLanguage: TImage;
    imgBackup: TImage;
    lbBackup: TLabel;
    imgOnlineHelp: TImage;
    lbOnlineHelp: TLabel;
    imgMessage: TImage;
    lbMessage: TLabel;
    lbPowered: TLabel;
    Image15: TImage;
    lbSM15: TLabelEffect;
    Image16: TImage;
    lbSM16: TLabelEffect;
    lbVersion: TLabel;
    Image17: TImage;
    quSubMenuVisible: TBooleanField;
    PopupMenu1: TPopupMenu;
    procedure MenuMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SubMenuMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SubMenuMouseDown(Sender: TObject; Button: TMouseButton;
                               Shift: TShiftState; X, Y: Integer);
    procedure SubMenuMouseUp(Sender: TObject; Button: TMouseButton;
                               Shift: TShiftState; X, Y: Integer);
    procedure SubMenuClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblSystemExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAtuVersaoClick(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure lblCashierDblClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure tmrCashierTimer(Sender: TObject);
    procedure tmTestMessageTimer(Sender: TObject);
    procedure tmrTrialCountTimer(Sender: TObject);
    procedure lbDemoClick(Sender: TObject);
    procedure imgTipClick(Sender: TObject);
    procedure quSubMenuBeforeOpen(DataSet: TDataSet);
    procedure lblOdblClickClick(Sender: TObject);
    procedure imgSystemInfoClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
    procedure imgMenuColorClick(Sender: TObject);
    procedure imgSC1Click(Sender: TObject);
    procedure imgLanguageClick(Sender: TObject);
    procedure lbBackupClick(Sender: TObject);
    procedure imgOnlineHelpClick(Sender: TObject);
    procedure lbMessageClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnReasonClick(Sender: TObject);
  private
    { Private declarations }
    fFirstTime       : Boolean;
    fScreenHelp,
    fHowToHelp,
    fOnlineHelpPage  : String;
    OldKeyMode       : Boolean;
    lbOldOverMenu    : TLabel;
    lbOldOverSubMenu : TLabelEffect;
    OldPoint         : TPoint;
    ID1, ID2         : String;
    fFchParamType    : Integer;
    procedure ShowSubMenu(Sender: TObject);
    procedure SetSubMenu(Txt: string; IDSubMenu: integer; Enabled: boolean; Count: integer; Img:Integer);
    procedure LoadMenu;
    procedure ConstructMenuMain;
    procedure MyIdle(Sender: TObject; var Done: Boolean);
    procedure CallTip;
    procedure CallHelp;
    procedure CallOnlineHelp;
    procedure CallBackup;
    procedure GetShortCutsImg;
    procedure SetShortCut(ID, Img:Integer; Text, Hint:String);
    function ParamDefault(IDMenu, IDSubMenu : Integer):String;
  public
    { Public declarations }
    vtMenu            : array[0..50]  of TMenuItem;
    vtSubMenu         : array[0..200] of TSubMenuItem;
    vtShortCuts       : array[1..MAX_SHORTCUTS] of String;
    IDMenu, IDSubMenu : integer;
    property FchParamType : Integer read fFchParamType write fFchParamType;
    procedure RefreshColor;
  end;

var
  MainMenu: TMainMenu;

implementation

{$R *.DFM}

uses uDM,
     uDMGlobal,
     uMsgConstant,
     uSystemTypes,
     uEncryptFunctions,
     uFileFunctions,
     uWebFunctions,
     uFrmUserMessager,
     ExitQue,             { Close Query Padrao }
     uPassword,           { Password }
     uBrwModel,           { Browse de Modelos }
     uBrwGroup,           { Browse de Grupos de Modelos }
     uBrwUser,            { Browse dos Usuarios do Sistema }
     uBrwUserType,        { Browse de Tipos de Usuario }
     uBrwInventMovType,   { Browse de Tipos Movimentação de Estoque }
     uBrwCashRegister,    { Browse de CashRegister }
     uBrwCashRegMov,      { Browse de CashRegister Movements}
     uCashRegWidraw,      { Cash Register Widraw }
     uCashRegManager,     { Cash Register Close }
     uFrmParameter,       { Parametros }
     uBrwSpecialPrice,    { Browse de Special Prices }
     uBrwStore,           { Browse de Stores }
     uBrwSaleRequest,     { Browse de Sales Request }
     uQueryInventory,     { Query Inventory }
     uBrwDeliverType,     { Browse de Deliver Type }
     uNewPreSales,        { New PreSale }
     uEditPreSale,        { Edit PreSale }
     uFchParam,           { Parametros Locais }
     uBrwMidia,           { browse padrao de midias }
     uBrwInvoice,         { Browse de Invoices }
     uBrwRepairCli,
     uBrwRepairInv,
     uBrwInventoryMov,    { Modulo de Inventory Movement }
     uBrwPurchase,       { Browse de Purchases }
     uBrwNewPO,              { Browse de Purchases Orders }
     uBrwInventory,
     uBrwTrajeto,
     uBrwCostType,
     uBrwTouristGroup,
     uCashRegOpen,
     uFrmPagaGuia,
     uFrmPagaAgencia,
     uFrmPagaVendedor,
     uFrmPagaOther,
     uFchModel,
     uBrwHotel,
     uBrwModelTransf,
     uTourGroupResult,
     uMenuItem,
     uFrmInventoryCount,
     uMsgBox,
     uAskManager,
     uInventoryCleanUp,
     uBrwCotation,
     uFrmTransferData,
     uFrmHourResult,
     uBrwPessoa,
     uBrwMeioPag,
     uBrwTaxCategory,
     uFrmTimeControl,
     uMediaResults,
     uBrwColor,
     uBrwSize,
     ufrmLanguageMR,
     ufrmLanguage,
     uFrmSystemInfo,
     uParamFunctions,
     uFrmPricingSetup,
     PaiDeBrowses,
     uFrmMainPOS,
     uFrmBarcodePrint,
     uFrmAccountCard,
     uFrmTeleMarketing,
     uFrmPromotionSetup,
     ubrwMovDocument,
     uFrmServiceOrder,
     MRPuppySettings,
     TagView,
     MRPuppyIntegrationCls, AdjustQtyReasonView;


procedure TMainMenu.GetShortCutsImg;
begin
  //Help
  DM.imgSmall.GetBitmap(BTN18_LAMP,imgTip.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTN18_HELP,imgHelp.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTN18_ONLINEHELP,imgOnlineHelp.Picture.Bitmap);

  //System
  DM.imgSmall.GetBitmap(BTN18_COMPUTER,imgSystemInfo.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTN18_DISPLAY,imgMenuColor.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTM18_FLAGS,imgLanguage.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTM18_BACKUP,imgBackup.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTM18_BACKUP,imgBackup.Picture.Bitmap);
  DM.imgSmall.GetBitmap(BTN18_MESSAGE,imgMessage.Picture.Bitmap);

end;

function TMainMenu.ParamDefault(IDMenu, IDSubMenu : Integer):String;
var
sMenu, sSubMenu : String;
i : integer;
bFound : Boolean;
begin

  sMenu  := vtMenu[IDMenu].Name;

  i := 0;
  bFound := False;

  while (i <= High(vtSubMenu)) and not bFound do
    begin
    If (vtSubMenu[i].IDMenu = IDMenu) and (vtSubMenu[i].IDSubMenu = IDSubMenu) then
       begin
       DM.fMainMenu.Image       := vtSubMenu[i].Image;
       DM.fMainMenu.MenuName    := sMenu;
       DM.fMainMenu.SubMenuName := vtSubMenu[i].Name;
       sSubMenu                 := vtSubMenu[i].Name;
       bFound                   := True;
       end;
    inc(i);
    end;
  Result := 'MenuCaption='+sMenu +';SubMenuCaption='+sSubMenu+';';
end;

procedure TMainMenu.ConstructMenuMain;
Var
bShow : Boolean;
begin
 With DM.quFreeSQL do
    begin
    if Active then
       Close;
    SQL.Clear;
    SQL.Add('SELECT IDMenu, Visible');
    SQL.Add('FROM MenuMain (NOLOCK) ');

    Open;
    First;

    While not EOF do
      begin
        bShow := FieldByName('Visible').AsBoolean;
        Case FieldByName('IDMenu').AsInteger of
           1 : PnlPointOfSale.Visible   := bShow;
           2 : pnlSalesSupporte.Visible := bShow;
           3 : pnlMediaResult.Visible   := bShow;
           4 : pnlPurchasing.Visible    := bShow;
           5 : pnlInventory.Visible     := bShow;
           6 : pnlCommission.Visible    := bShow;
           7 : pnlMaintenace.Visible    := bShow;
           8 : pnlOfficeM.Visible       := bShow;
           9 : pnlUtil.Visible          := bShow;
        end;
      Next;
      end;

    Close;
    end;
end;

procedure TMainMenu.ShowSubMenu(Sender: TObject);
var
   lbMenuItem : TLabel;
   Idx, Count : Integer;
   Out        : Boolean;

   procedure ClearImg(img:TImage);
   begin
   img.Picture := nil;
   end;
Begin
     lbMenuItem := TLabel(Sender);
     Out := False;

     // Desliga todos os panels do SubMenu
     lbSM1.Visible      := False;
     lbSM2.Visible      := False;
     lbSM3.Visible      := False;
     lbSM4.Visible      := False;
     lbSM5.Visible      := False;
     lbSM6.Visible      := False;
     lbSM7.Visible      := False;
     lbSM8.Visible      := False;
     lbSM9.Visible      := False;
     lbSM10.Visible     := False;
     lbSM11.Visible     := False;
     lbSM12.Visible     := False;
     lbSM13.Visible     := False;
     lbSM14.Visible     := False;
     lbSM15.Visible     := False;
     lbSM16.Visible     := False;

     ClearImg(Image1);
     ClearImg(Image2);
     ClearImg(Image3);
     ClearImg(Image4);
     ClearImg(Image5);
     ClearImg(Image6);
     ClearImg(Image7);
     ClearImg(Image8);
     ClearImg(Image9);
     ClearImg(Image10);
     ClearImg(Image11);
     ClearImg(Image12);
     ClearImg(Image13);
     ClearImg(Image14);
     ClearImg(Image15);
     ClearImg(Image16);

     // Seta os Itens do SubMenu
     Idx := 1;
     while (Idx <= High(vtSubMenu)) and not Out do
      Begin
        if vtSubMenu[Idx].IDMenu = lbMenuItem.Tag then
         begin
           for Count := 1 to vtMenu[IDMenu].CountSubMenu do
             begin
               SetSubMenu(vtSubMenu[Idx + Count -1].Name,
                          vtSubMenu[Idx + Count -1].IDSubMenu,
                          vtSubMenu[Idx + Count -1].Enabled,
                          Count,
                          vtSubMenu[Idx + Count -1].Image);

             end;
           Out := True;
         end;
        Inc(Idx);
      end;

end;

procedure TMainMenu.SetSubMenu(Txt: string; IDSubMenu: integer; Enabled: boolean;
                               Count: integer; Img : Integer);
begin
 case Count of
   1:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM1.caption  := Txt;
       lbSM1.visible  := True;
       lbSM1.Tag      := IDSubMenu;
       Image1.Visible := True;
       Case IDMenu of
         1 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         2 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         6 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
         9 : DM.imgSubMenu.GetBitmap(Img,Image1.Picture.Bitmap);
       End;

     end;
   2:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM2.caption := Txt;
       lbSM2.visible := True;
       lbSM2.Tag     := IDSubMenu;
       Case IDMenu of
         1 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         2 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         6 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         7 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
         9 : DM.imgSubMenu.GetBitmap(Img,Image2.Picture.Bitmap);
       End;

     end;
   3:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM3.caption := Txt;
       lbSM3.visible := True;
       lbSM3.Tag     := IDSubMenu;
       Case IDMenu of
         1 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         2 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         6 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
         9 : DM.imgSubMenu.GetBitmap(Img,Image3.Picture.Bitmap);
       End;
     end;
   4:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM4.caption := Txt;
       lbSM4.visible := True;
       lbSM4.Tag     := IDSubMenu;
       Case IDMenu of
         1 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         2 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         6 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
         9 : DM.imgSubMenu.GetBitmap(Img,Image4.Picture.Bitmap);
       End;
     end;
   5:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM5.caption := Txt;
       lbSM5.visible := True;
       lbSM5.Tag     := IDSubMenu;
       Case IDMenu of
         1 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
         2 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
         6 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image5.Picture.Bitmap);
       End;
     end;
   6:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM6.caption := Txt;
       lbSM6.visible := True;
       lbSM6.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image6.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image6.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image6.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image6.Picture.Bitmap);
         6 : DM.imgSubMenu.GetBitmap(Img,Image6.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image6.Picture.Bitmap);
       End;
     end;
   7:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM7.caption := Txt;
       lbSM7.visible := True;
       lbSM7.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image7.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image7.Picture.Bitmap);
         4 : DM.imgSubMenu.GetBitmap(Img,Image7.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image7.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image7.Picture.Bitmap);
       End;
     end;
   8:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM8.caption := Txt;
       lbSM8.visible := True;
       lbSM8.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image8.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image8.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image8.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image8.Picture.Bitmap);
       End;
     end;
   9:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM9.caption := Txt;
       lbSM9.visible := True;
       lbSM9.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image9.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image9.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image9.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image9.Picture.Bitmap);
       End;
     end;
   10:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM10.caption := Txt;
       lbSM10.visible := True;
       lbSM10.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image10.Picture.Bitmap);
         3 : DM.imgSubMenu.GetBitmap(Img,Image10.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image10.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image10.Picture.Bitmap);
       End;
     end;
   11:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM11.caption := Txt;
       lbSM11.visible := True;
       lbSM11.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image11.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image11.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image11.Picture.Bitmap);
       End;
     end;
   12:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM12.caption := Txt;
       lbSM12.visible := True;
       lbSM12.Tag     := IDSubMenu;
       Case IDMenu of
         2 : DM.imgSubMenu.GetBitmap(Img,Image12.Picture.Bitmap);
         5 : DM.imgSubMenu.GetBitmap(Img,Image12.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image12.Picture.Bitmap);
       End;
     end;
   13:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM13.caption := Txt;
       lbSM13.visible := True;
       lbSM13.Tag     := IDSubMenu;
       Case IDMenu of
         5 : DM.imgSubMenu.GetBitmap(Img,Image13.Picture.Bitmap);
         8 : DM.imgSubMenu.GetBitmap(Img,Image13.Picture.Bitmap);
       End;
     end;
   14:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM14.caption := Txt;
       lbSM14.visible := True;
       lbSM14.Tag     := IDSubMenu;
       Case IDMenu of
         5 : DM.imgSubMenu.GetBitmap(Img,Image14.Picture.Bitmap);
       End;
     end;

   15:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM15.caption := Txt;
       lbSM15.visible := True;
       lbSM15.Tag     := IDSubMenu;
       Case IDMenu of
         5 : DM.imgSubMenu.GetBitmap(Img,Image15.Picture.Bitmap);
       End;
     end;

   16:
     begin
       if (not Enabled) and (trim(Txt) <> '') then
         Txt := '* '+ Txt;
       lbSM16.caption := Txt;
       lbSM16.visible := True;
       lbSM16.Tag     := IDSubMenu;
       Case IDMenu of
         5 : DM.imgSubMenu.GetBitmap(Img,Image16.Picture.Bitmap);
       End;
     end;


 end;
end;

procedure TMainMenu.SubMenuMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
     NowKeyMode : Boolean;
     lbOverSubMenu : TLabelEffect;
     Idx           : integer;
     NowPoint      : TPoint;
begin
     // Guarda a posicao antiga do mouse
     NowKeyMode := ([ssShift, ssAlt, ssCtrl] = Shift) and (X+Y = 0);
     NowPoint.X := X;
     NowPoint.Y := Y;

     if not OldKeyMode then
        begin
          if not NowKeyMode then
             OldPoint   := TLabelEffect(Sender).ClientToScreen(NowPoint);
        end
     else
        begin
          if not NowKeyMode then
            begin
             NowPoint := TLabelEffect(Sender).ClientToScreen(NowPoint);
             // Testa se mouse se mantem nas mesmas coordenadas
             if ( (OldPoint.X <> NowPoint.X) or (OldPoint.Y <> NowPoint.Y) ) then
                OldKeyMode := False
             else
                Exit;
            end;
        end;

     if NowKeyMode then
        OldKeyMode := True;

     lbOverSubMenu := TlabelEffect(Sender);

     IDSubMenu := lbOverSubMenu.Tag;

     if not assigned(lbOldOverSubMenu) then
       Begin
         lbOverSubMenu.font.color := DM.fMainMenu.SubMenuHighlight;
         lbOverSubMenu.Font.Style := [fsBold,fsUnderline];
         lbOldOverSubMenu := lbOverSubMenu;
       end
     else
       if lbOverSubMenu <> lbOldOverSubMenu then
       Begin
         //lbOldOverSubMenu.Font.Color := clGray;
         lbOldOverSubMenu.Font.Color := DM.fMainMenu.SubMenuColor;
         lbOldOverSubMenu.Font.Style := [fsBold];

         lbOverSubMenu.font.color := DM.fMainMenu.SubMenuHighlight;
         lbOverSubMenu.Font.Style := [fsBold,fsUnderline];
         lbOldOverSubMenu := lbOverSubMenu;
       end;
     // Seta o Tip
     Idx := 1;
     while (vtSubMenu[Idx].IDMenu <> IDMenu) or (vtSubMenu[Idx].IDSubMenu <> IDSubMenu) do
           Inc(Idx);

     Tip.Caption := vtSubMenu[Idx].Tip;

end;

procedure TMainMenu.MenuMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
     lbOverMenu : TLabel;
     Image      : TImage;
     NowKeyMode : Boolean;
     NowPoint   : TPoint;
begin
     TIP.Caption := '';

     Image      := TImage(Sender);
     lbOverMenu := Tlabel(Sender);

     NowPoint.X := X;
     NowPoint.Y := Y;

     // Guarda a posicao antiga do mouse
     NowKeyMode := ([ssShift, ssAlt, ssCtrl] = Shift) and (X+Y = 0);

     if not OldKeyMode then
        begin
          if not NowKeyMode then
             OldPoint   := TLabel(Sender).ClientToScreen(NowPoint);
        end
     else
        begin
          if not NowKeyMode then
            begin
             NowPoint := TLabelEffect(Sender).ClientToScreen(NowPoint);
             // Testa se mouse se mantem nas mesmas coordenadas
             if ( (OldPoint.X <> NowPoint.X) or (OldPoint.Y <> NowPoint.Y) ) then
                OldKeyMode := False
             else
                Exit;
            end;
        end;

     If NowKeyMode then
        OldKeyMode := True;


     If Sender is TImage then
        IDMenu := Image.Tag
     else
        IDMenu := lbOverMenu.Tag;

     if not assigned(lbOldOverMenu) then
      Begin
         lbOldOverMenu := lbOverMenu;
         if IDMenu < (vtMenu[0].CountSubMenu+1) then
           begin
            //lbOverMenu.font.color := clRed;
            lbOverMenu.font.color  := DM.fMainMenu.MenuColorHighlight;
            lbOverMenu.font.Style  := [fsBold];
            lbOverMenu.Color       := DM.fMainMenu.BackGroundColor;
            lbOverMenu.Transparent := False;
            ShowSubMenu(Sender);
            end
         else
           begin
            //lbOverMenu.font.color := clRed;
            lbOverMenu.font.color  := DM.fMainMenu.MenuColorHighlight;
            lbOverMenu.font.Style  := [fsBold];
            lbOverMenu.Color       := DM.fMainMenu.BackGroundColor;
            lbOverMenu.Transparent := False;
           end;
      end
     else
      if lbOverMenu <> lbOldOverMenu then
       Begin
         //lbOldOverMenu.Font.Color := clSilver;
         lbOldOverMenu.Font.Color  := DM.fMainMenu.MenuColor;
         lbOldOverMenu.font.Style  := [];
         lbOldOverMenu.Color       := DM.fMainMenu.BackGroundColor;
         lbOldOverMenu.Transparent := True;
         lbOldOverMenu := lbOverMenu;
         if IDMenu < (vtMenu[0].CountSubMenu+1) then
           begin
             //lbOverMenu.font.color := clRed;
             lbOverMenu.font.color  := DM.fMainMenu.MenuColorHighlight;
             lbOverMenu.font.Style  := [fsBold];
             lbOverMenu.Transparent := False;
             ShowSubMenu(Sender);
             end
         else
           begin
             //lbOverMenu.font.color := clRed;
             lbOverMenu.font.color  := DM.fMainMenu.MenuColorHighlight;
             lbOverMenu.font.Style  := [fsBold];
             lbOverMenu.Transparent := False;
             ShowSubMenu(Sender);
           end;
         if assigned(lbOldOverSubMenu) then
           begin
            //lbOldOverSubMenu.font.color := clGray;
            lbOldOverSubMenu.font.color  := DM.fMainMenu.SubMenuColor;
            lbOldOverSubMenu.font.Style  := [fsBold];
            lbOldOverSubMenu := nil;
           end;
       end;
end;

procedure TMainMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  with TExitQuery.Create(Self) do
     CanClose := (ShowModal = mrOK);
end;


procedure TMainMenu.SubMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   //TLabelEffect(Sender).EffectStyle := esSunken;
end;

procedure TMainMenu.SubMenuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //TLabelEffect(Sender).EffectStyle := LblEffct.esRaised;
end;

procedure TMainMenu.LoadMenu;
var
  Count, OldMenu, SubCount : Integer;
begin
   // Zera a captura das teclas
   OldKeyMode := False;

   //Deixa para a rotina de tratamento das setas do teclado
   IDSubMenu := 0;
   OldMenu   := 0;

   with quSubMenu do
     begin
       Open;
       Count     := 1;
       SubCount  := 0;
       while not eof do
         begin
           if OldMenu <> quSubMenuIDMenu.AsInteger then
             begin
              // Testa se e novo menu
              vtMenu[quSubMenuIDMenu.AsInteger].Name  := quSubMenuParentMenu.AsString;
              OldMenu := quSubMenuIDMenu.AsInteger;
              SubCount := 0;
             end;

           vtSubMenu[Count].IDMenu    := quSubMenuIDMenu.AsInteger;
           vtSubMenu[Count].IDSubMenu := quSubMenuIDSubMenu.AsInteger;
           vtSubMenu[Count].Name      := quSubMenuName.AsString;
           vtSubMenu[Count].Tip       := quSubMenuTip.AsString;


           //amfsouza 09.08.2011: to puppytracker integration
           if ( (vtSubMenu[count].IDSubMenu = 14) and (vtSubMenu[count].IDMenu = 8) ) then
               vtSubMenu[Count].Enabled   := ( DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] = 'True' )
           else
               vtSubMenu[Count].Enabled   := quSubMenuEnabled.AsBoolean;

           vtSubMenu[Count].Image     := quSubMenuImageIndex.AsInteger;
           vtSubMenu[Count].Shortcut  := quSubMenuShortcut.AsInteger;
           Inc(Count);
           Inc(SubCount);

           vtMenu[quSubMenuIDMenu.AsInteger].CountSubMenu := SubCount;
           // Totaliza o total de itens no Menu
           vtMenu[0].CountSubMenu := quSubMenuIDMenu.AsInteger;
           //SetShortcuts
           if ((quSubMenuShortcut.AsInteger)>0) and
              (quSubMenuShortcut.AsInteger<=MAX_SHORTCUTS) then
              begin
              pnlShortcuts.Visible := True;
              vtShortCuts[quSubMenuShortcut.AsInteger] := 'M='+quSubMenuIDMenu.AsString+';'+
                                                          'S='+quSubMenuIDSubMenu.AsString+';';
              SetShortCut(quSubMenuShortcut.AsInteger,
                          quSubMenuImageIndex.AsInteger,
                          quSubMenuName.AsString,
                          quSubMenuTip.AsString);
              end;
           Next;

         end;

       Close;
     end;

end;

procedure TMainMenu.SetShortCut(ID, Img:Integer; Text, Hint:String);
var
 fLabel: TLabel;
 fPanel: TPanel;
 fImage: TImage;
begin

   fPanel := TPanel(FindComponent('pnlSC'+IntToStr(ID)));
   if Assigned(fPanel) then
      fPanel.Visible := True;

   fLabel := TLabel(FindComponent('lbSC'+IntToStr(ID)));
   if Assigned(fLabel) then
      begin
      fLabel.Caption  := Text;
      fLabel.Hint     := Hint;
      fLabel.Tag      := ID
      end;

   fImage := TImage(FindComponent('imgSC'+IntToStr(ID)));
   if Assigned(fImage) then
      begin
      DM.imgSubMenu.GetBitmap(Img,fImage.Picture.Bitmap);
      fImage.Tag     := ID;
      fImage.Hint    := Hint;
      end;

end;

procedure TMainMenu.FormShow(Sender: TObject);
var
  sVersion : String;
  fAutoOpen : Boolean;
begin
  // Acerta o timer
  tmrTimeTimer(nil);
  Application.OnIdle := MyIdle;

  // Trial Counter
  tmrTrialCount.Enabled:= (DM.fSystem.StartMode = SYS_MODULE_TRIAL);

  //Version % Build
  DM.fSystem.VerBuild := 'Build ('+IntToStr(DM.fSystem.Build)+'-'+IntToStr(MRBUILD)+')';
  lblVersion.Caption := DM.fSystem.VerBuild;

  //Module Info
  if DM.fSystem.StartMode = SYS_MODULE_TRIAL then
    DM.fSystem.Module := 'MainRetail - Premium'
  else
  begin
    case DM.fSystem.StartMode of
      SYS_MODULE_1,
      SYS_MODULE_2 : sVersion := 'Basic';
      SYS_MODULE_3 : sVersion := 'Premium';
      SYS_MODULE_4,
      SYS_MODULE_5 : sVersion := 'Enterprise';
    end;
    DM.fSystem.Module := 'MainRetail - '+ sVersion ;
  end;

  lbModule.Caption := DM.fSystem.Module;

  // Seta as coordenadas iniciais
  if not DM.fMainMenu.WindowMode then
  begin
    Left   := 0;
    Top    := 0;
    Height := Screen.Height;
    Width  := Screen.Width;
  end;

  // Guarda Posicao do mouse inicial
  GetCursorPos(OldPoint);

  //Monta o MenuMain
  ConstructMenuMain;

  //Acerta o menu
  LoadMenu;

  //** Só em tempo de desenvolvimento
  //lblODblClickDblClick (Self);

  tmTestMessage.Enabled := True;

  //Rodrigo - Usado para o Demo. D - Demo, F - Full App, E - Error.
  if DM.fSystem.StartMode = SYS_ERROR then
    lbDemo.Visible := False
  else
    lbDemo.Visible := (DM.fSystem.StartMode = SYS_MODULE_TRIAL);

  //if (DM.fSystem.StartMode <> SYS_ERROR) and DM.fSystem.ShowTip then
  //  CallTip;

  //Display images for shortcust
  GetShortCutsImg;

  //Set default param call
  fFchParamType := PARAM_OPEN_ALL;

  lbHelpShort.Left := lbHelp.Left + lbHelp.Width + 3;

  //Verifica se o sistema esta com a chave Valida
  if DM.fSystem.StartMode <> SYS_ERROR then begin
    DM.ValidateLicense;
  end;

  // Max - 19/10/2006
  // Fazer a chamada da SP que processa o saldo de inventário
  //DM.ProcessInventoryBalance;

  fAutoOpen  := False;
  fFirstTime := True;

  case DM.fStartOption of
    START_LAYAWAY :
    begin
      fAutoOpen := True;
      IDMenu    := 1;
      IDSubMenu := 1;
      SubMenuClick(lbSM1);
    end;

    START_INVENT_TYPE :
    begin
      fAutoOpen := True;
      IDMenu    := 5;
      IDSubMenu := 5;
      SubMenuClick(lbSM5);
    end;
  end;

  if (not fAutoOpen) and (DM.fSystem.SrvParam[PARAM_ASK_PASSWORD_BEFORE_OPEN_SOFTWARE]) then
  begin
    IDMenu    := 1;
    IDSubMenu := 1;
    SubMenuClick(lbSM1);
  end;

  fFirstTime := False;

  if Assigned(DM.fSystem.Logo) then
  begin
    imgTop.Picture.Bitmap := DM.fSystem.Logo.Bitmap;
    lbPowered.Visible     := True;
  end;
end;

procedure TMainMenu.CallTip;
begin

  if FileExists(extractfilepath(application.exename)+'MRTip.exe') then
    ExecuteFile(extractfilepath(application.exename)+'MRTip.exe', IntToStr(IDMenu-1), '', SW_SHOW);

end;

procedure TMainMenu.CallHelp;
begin
  try
    ExecuteFile(extractfilepath(application.exename)+fHowToHelp, '', '', SW_SHOW)
  except
    MsgBox(MSG_CRT_NO_HELP,vbOkOnly + vbCritical);
  end;
end;

procedure TMainMenu.CallBackup;
begin
  if FileExists(extractfilepath(application.exename)+'MRBackup.exe') then
    ExecuteFile(extractfilepath(application.exename)+'MRBackup.exe', '', '', SW_SHOW)
end;

procedure TMainMenu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  IncMenu, IncSubMenu, i : Integer;
  IsOpenSub, IsClick : Boolean;
begin
  // Testa se chamou a hot key do Exit
  if (Shift = [ssAlt]) and (Chr(Key) = 'X') then
  begin
    Close;
    Exit;
  end;

  IncMenu := 0;
  IncSubMenu := 0;
  IsClick    := False;

  // Testa se submenu esta desligado
  IsOpenSub := (IDSubMenu <> 0);

  case Key of
    VK_F1: imgHelpClick(self);

    VK_F9: lblOdblClickClick(self);

    VK_DOWN: if IsOpenSub then
               IncSubMenu := 1
             else
               IncMenu := 1;

    VK_UP: if IsOpenSub then
             IncSubMenu := -1
           else
             IncMenu := -1;

    VK_LEFT:
    begin
      IsOpenSub := False;
      if Assigned(lbOldOverSubMenu) then
      begin
        //lbOldOverSubMenu.font.color := clGray;
        lbOldOverSubMenu.font.color := DM.fMainMenu.SubMenuColor;
        lbOldOverSubMenu.font.Style := [fsBold];
        lbOldOverSubMenu := nil;
      end;
    end;

    VK_RIGHT:
    begin
      IDSubMenu := 1;
      IsOpenSub := True;
    end;

    VK_RETURN:
    begin
      if IDMenu = (vtMenu[0].CountSubMenu+1) then
      begin
        Close;
        Exit;
      end
      else
        IsClick := IsOpenSub;
      end;

      //   A,   C,   D,   I,   M,   P,   R,   S,   T,   U,  F,  E
      //  65,  67,  68,  73,  77,  80,  82,  83,  84,  85   70  69 MAIUSCULAS
      // 107, 109, 110, 115, 119, 122, 124, 125, 126, 127          minúsculas

      //82, 124 : begin IsOpenSub := False; IDMenu := 1; IDSubMenu := 1; end; // F de Point of Sale
{      70, 124 : begin IsOpenSub := False; IDMenu := 1; IDSubMenu := 1; end; // F de Point of Sale
      83, 125 : begin IsOpenSub := False; IDMenu := 2; IDSubMenu := 1; end;// S de Sales Support
      84, 126 : begin IsOpenSub := False; IDMenu := 3; IDSubMenu := 1; end;// T de Advertising
      80, 122 : begin IsOpenSub := False; IDMenu := 4; IDSubMenu := 1; end;// P de Purchases
      73, 115 : begin IsOpenSub := False; IDMenu := 5; IDSubMenu := 1; end;// I de Inventory
      67, 109 : begin IsOpenSub := False; IDMenu := 6; IDSubMenu := 1; end;// C de Commissions
      65, 107 : begin IsOpenSub := False; IDMenu := 7; IDSubMenu := 1; end;// A de Office Manager
      77, 119 : begin IsOpenSub := False; IDMenu := 8; IDSubMenu := 1; end;// M de Maintenance
      85, 127 : begin IsOpenSub := False; IDMenu := 9; IDSubMenu := 1; end;// U de Utilities
      //68, 110 : begin IsOpenSub := False; IDMenu := 10; IDSubMenu := 1; end;// D de Exit
      69, 110 : begin IsOpenSub := False; IDMenu := 10; IDSubMenu := 1; end;// D de Exit}

      49,97  : begin IsOpenSub := False; IDMenu := 1; IDSubMenu := 1; end; // 1 de Point of Sale
      50,98  : begin IsOpenSub := False; IDMenu := 2; IDSubMenu := 1; end;// 2 de Sales Support
      51,99  : begin IsOpenSub := False; IDMenu := 3; IDSubMenu := 1; end;// 3 de Advertising
      52,100 : begin IsOpenSub := False; IDMenu := 4; IDSubMenu := 1; end;// 4 de Purchases
      53,101 : begin IsOpenSub := False; IDMenu := 5; IDSubMenu := 1; end;// 5 de Inventory
      54,102 : begin IsOpenSub := False; IDMenu := 6; IDSubMenu := 1; end;// 6 de Commissions
      55,103 : begin IsOpenSub := False; IDMenu := 7; IDSubMenu := 1; end;// 7 de Office Manager
      56,104 : begin IsOpenSub := False; IDMenu := 8; IDSubMenu := 1; end;// 8 de Maintenance
      57,105 : begin IsOpenSub := False; IDMenu := 9; IDSubMenu := 1; end;// 9 de Utilities
      48,96  : begin IsOpenSub := False; IDMenu := 10; IDSubMenu := 1; end;// 0 de Exit

    else
      Exit;
  end;

  if not IsOpenSub then
    Tip.Caption := '';

  if (IDMenu + IncMenu) > (vtMenu[0].CountSubMenu+1) then
    IDMenu := 1
  else if (IDMenu + IncMenu) = 0 then
    IDMenu := vtMenu[0].CountSubMenu+1
  else
    Inc(IDMenu, IncMenu);

  if IDMenu = -1 then
    IDMenu := vtMenu[0].CountSubMenu+1;

  if (IDSubMenu + IncSubMenu) > vtMenu[IDMenu].CountSubMenu then
    IDSubMenu := 1
  else if (IDSubMenu + IncSubMenu) = 0 then
    IDSubMenu := vtMenu[IDMenu].CountSubMenu
  else
    Inc(IDSubMenu, IncSubMenu);

  if (not IsOpenSub) or (vtMenu[IDMenu].CountSubMenu = 0) then
    IDSubMenu := 0;

  // For que habilita os menus
  if not IsOpenSub then
  begin
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TLabel) and (not (Components[i] is TLabelEffect)) and
         (TLabel(Components[i]).Tag = IDMenu) then
      begin
        MenuMouseMove(TObject(Components[i]), [ssShift, ssAlt, ssCtrl], 0, 0);
        Exit;
      end
  end
  else
  begin
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TLabelEffect) and
         (TLabelEffect(Components[i]).Tag = IDSubMenu) then
      begin
        if IsClick then
        begin
          SubMenuMouseDown(TObject(Components[i]), mbLeft, [ssShift], 0, 0);
          SubMenuClick(TObject(Components[i]));
          SubMenuMouseUp(TObject(Components[i]), mbLeft, [ssShift], 0, 0);
        end
        else
          SubMenuMouseMove(TObject(Components[i]), [ssShift, ssAlt, ssCtrl], 0, 0);
          Exit;
        end;
  end;
end;

procedure TMainMenu.SubMenuClick(Sender: TObject);
var
  MyCmdLine, sDB,
  sMyParam : String;
  i, IDCashRegMov, iIDPessoa: integer;
  //amfsouza September 10, 2012
  msgCashOpen: String;
  cashRegName: String;

  // Antonio Marcos, May 01, 2015: MR-173 :a hook to window
  hMRWindow: HWND;
  titleMRWindow: array [0..255] of char;
  sizeTitleMRWindow: Integer;
begin
  // Validating if Module is Enabled
  for i:= 0 to High(vtSubMenu) do
  begin
    if (vtSubMenu[i].IDMenu = IDMenu) and
       (vtSubMenu[i].IDSubMenu = IDSubMenu) then
    begin

      if not(vtSubMenu[i].Enabled) then
      begin
        MsgBox(MSG_EXC_MODULE_DISABLE, vbOKOnly + vbInformation);
        Exit;
      end;

      break;
    end;
  end;

  {Aqui entra o tratamento da senha}
  Password.MenuName    := vtMenu[IDmenu].Name;
  Password.SubMenuName := TLabel(Sender).Caption;

  if ((IDMenu = 9) and (IDSubMenu >= 5)) or
     //((IDMenu = 1) and (IDSubMenu = 1)) or // ** Point of Sale / Cash Register
     ((IDMenu = 9) and (IDSubMenu = 1)) or // Help
     ((IDMenu = 2) and (IDSubMenu = 1)) or // ** Sales Suporte / Hold
     ((IDMenu = 7) and (IDSubMenu = 2)) or // Accounting
     Password.Start(IDMenu, IDSubMenu) then
  begin

  if not (((IDMenu = 2) and (IDSubMenu = 1)) or
     ((IDMenu = 7) and (IDSubMenu = 2)) or
     ((IDMenu = 9) and (IDSubMenu >= 5)) or
     ((IDMenu = 9) and (IDSubMenu = 1)))  then
    if not Password.CanAccessMenu(Password.MyMenuItem, Password.MySubMenuItem,
       DM.fUser.Password) then
    begin
      MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
      Exit;
    end;

    sMyParam := ParamDefault(IDMenu, IDSubMenu);

    case (IDMenu * 1000 + IDSubMenu * 10) of
      //---------------------------------------------------------------
      //---------------------  Point Of Sale  ----------------------------
      1010:
      begin // ** Cash Register
        { amfsouza September 10, 2012
        if DM.ExecRunning > 1 then
        begin
          MsgBox(MSG_INF_MORE_THAN_ONE_EXEC, vbOKOnly + vbInformation);
          Exit;
        end;
         }

        if ( dm.IsCashRegisterOpen(dm.fCashRegister.IDDefault) ) then begin
           msgCashOpen := 'Cash Register %s shows as already being open.'+#13#10+
                          'Close the other instance and then try again.'+#13#10 +
                          'If you know there is no other instance, you could override it. Do you wish override ?';

           cashRegName := dm.getCashRegisterName(dm.fCashRegister.IDDefault);
           msgCashOpen := format(msgCashOpen, [cashRegName]);

           if ( Application.MessageBox(PChar(msgCashOpen), 'Cash Register Warning', MB_YESNO + MB_ICONWARNING) = mrYes ) then begin
               // Antonio Marcos: MR-173
               dm.setCashRegister(dm.fCashRegister.IDDefault, false);

              // getting the previous instance
               hMRWindow := FindWindow('TFrmMainPOS', nil);
               sizeTitleMRWindow := 256;
               GetWindowText(hMRWindow, titleMRWindow, sizeTitleMRWindow);
            //   ShowMessage('closing the window: ' + titleMRWindow);

               // close previous instance
               sendMessage(hMRWindow, WM_SYSCOMMAND, SC_CLOSE, 0);

           end else begin
                   exit;
               end;

        end else begin
                // Antonio Marcos: MR-155
                dm.setCashRegister(dm.fCashRegister.IDDefault, true);
                hMRWindow := FindWindow('TFrmMainPOS', nil);
                sizeTitleMRWindow := 256;
                GetWindowText(hMRWindow, titleMRWindow, sizeTitleMRWindow);
            //    ShowMessage('closing the window: ' + titleMRWindow);
            end;

        Screen.Cursor := crHourGlass;
        // Modulo de controle de cash register
        case DM.CheckCashRegState(DM.fCashRegister.IDDefault, IDCashRegMov) of
          CASHREG_OPEN:
          begin
            // Caixa aberta, abre tela de Manipulação
            case DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] of
              CASHREG_TYPE_FULL_POS :
              begin
                with TFrmMainPOS.Create(Self) do
                  Start(SALE_CASHREG, IDCashRegMov);
              end;
              else
                with TCashRegManager.Create(Self) do
                  Start(IDCashRegMov, DM.fCashRegister.IDDefault,
                        DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE], True);
            end;
          end;

          CASHREG_CLOSE:
          begin
            // Caixa Fechada, abre tela da abertura
            with TCashRegOpen.Create(Self) do
              Start(DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE], DM.fCashRegister.IDDefault);
          end;
        end;
        Screen.Cursor := crDefault;
      end;

      1020:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwCashRegMov.Create(Self) do // ** Cash Register History
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      1030:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwInvoice.Create(Self) do // ** Invoice History
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      1040:
      begin
        Screen.Cursor := crHourGlass;
        DM.CallReport(DM.fUser.Password);
        Screen.Cursor := crDefault;
      end;

      1050:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwCashRegister.Create(Self) do // ** Maintenance
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      //---------------------------------------------------------------
      //---------------------  Sales Support ----------------------------
      2010:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmEditPreSale.Create(Self) do // ** Hold
          Start(SALE_PRESALE);
        Screen.Cursor := crDefault;
      end;

      2020:
      begin
        Screen.Cursor := crHourGlass;
        with TQueryInventory.Create(Self) do // ** View Inventory
        begin
          btDetail.Visible := False;
          ShowModal;
        end;
        Screen.Cursor := crDefault;
      end;

      2030:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwSaleRequest.Create(Self) do // ** Sales Person Request
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      2040:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmEditPreSale.Create(Self) do // ** UnLock Hold
          Start(SALE_UNLOCK_PRESALE);
        Screen.Cursor := crDefault;
      end;

      2050:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwRepairCli.Create(Self) do // ** Customer Repair
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      2060:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwPessoa.Create(Self) do // ** Customers File
        begin
          quTreeView.Parameters.ParambyName('Path').Value := '.001%';
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      2070:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmHourResult.Create(Self) do // ** Sales Graphs
          ShowModal;
        Screen.Cursor := crDefault;
      end;

      2080:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmAccountCard.Create(Self) do  //Gift
          Start;
        Screen.Cursor := crDefault;
      end;

      2090:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmTeleMarketing.Create(Self) do //Telemarketing
          Start;
        Screen.Cursor := crDefault;
      end;

      2100:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmPromotionSetup.Create(Self) do //Promotions
          Start;
        Screen.Cursor := crDefault;
      end;

      2110:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwMovDocument.Create(Self) do //Document Control
          Start;
        Screen.Cursor := crDefault;
      end;

      2120:
      begin
        Screen.Cursor := crHourGlass;
        DM.CallReport(DM.fUser.Password);
        Screen.Cursor := crDefault;
      end;

      //-------------------------------------------------------------------
      //---------------------  Advertising   ------------------------------
      3010:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwMidia.Create(Self) do // Media
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3020:
      begin
        Screen.Cursor := crHourGlass;
        with TMediaResults.Create(Self) do //Media Results
          Start;
        Screen.Cursor := crDefault;
      end;

      3030:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwTrajeto.Create(Self) do // ** Routes
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3040:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwCostType.Create(Self) do // ** Expence Category
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3050:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwTouristGroup.Create(Self) do // ** Agency Groups
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3060:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwPessoa.Create(Self) do // ** Outside Agents
        begin
          quTreeView.Parameters.ParambyName('Path').Value := '.003.002%';
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3070:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwHotel.Create(Self) do // ** Hotels
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3080:
      begin
        Screen.Cursor := crHourGlass;
        with TTourGroupResult.Create(Self) do // ** Agency Group Result
          ShowModal;
        Screen.Cursor := crDefault;
      end;

      3090:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwPessoa.Create(Self) do // ** Agency File
        begin
          quTreeView.Parameters.ParambyName('Path').Value := '.003.003%';
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      3100:
      begin
        Screen.Cursor := crHourGlass;
        DM.CallReport(DM.fUser.Password);
        Screen.Cursor := crDefault;
      end;

      //---------------------------------------------------------------
      //---------------------  Purchasing   ---------------------------
      4010:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwCotation.Create(Self) do // ** Price Quotes
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      4020:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwNewPO.Create(Self) do // ** Purchase Orders
          Start;
        Screen.Cursor := crDefault;
      end;

      4030:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwPurchase.Create(Self) do // ** Pre Receiving
        begin
          sParam := sMyParam;
          iPurStatus := 1; //Pre Receive
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      4040:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwPurchase.Create(Self) do // ** Final Receiving
        begin
          sParam := sMyParam;
          iPurStatus := 2; //Final Receive
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      4050:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwPessoa.Create(Self) do // ** Vendor File
        begin
          quTreeView.Parameters.ParambyName('Path').Value := '.002%';
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      4060:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwPurchase.Create(Self) do // ** Purchase History
        begin
          iPurStatus := 3; //Completed
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      4070:
      begin
        Screen.Cursor := crHourGlass;
        DM.CallReport(DM.fUser.Password);
        Screen.Cursor := crDefault;
      end;

      //---------------------------------------------------------------
      //---------------------  Inventory ----------------------------
      5010:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwModel.Create(Self) do // ** Inventory Maintenance
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      5020:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwInventory.Create(Self) do // ** View by Store
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5030:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwGroup.Create(Self) do // ** Category Maintenance  Tree View
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5040:
      begin
              Screen.Cursor := crHourGlass;
              with TBrwPessoa.Create(Self) do // ** Manufacturers Maintenance
                   begin
                   quTreeView.Parameters.ParambyName('Path').Value := '.004%';
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5050:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwInventoryMov.Create(Self) do // ** Movement History
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5060:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwInventMovType.Create(Self) do // ** Movement Types
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5070:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwRepairInv.Create(Self) do // ** Inventory Return
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5080:
      begin
              Screen.Cursor := crHourGlass;
              with TFchModel.Create(Self) do // ** View Inventory by Model
                   begin
                   ShowLookUp := True;
                   Start(btAlt, nil, False, ID1, ID2, nil);
                   Free;
                   end;
              Screen.Cursor := crDefault;
      end;

      5090:
      begin
              Screen.Cursor := crHourGlass;
              with TBrwModelTransf.Create(Self) do // ** Move Items
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5100:
      begin
              Screen.Cursor := crHourGlass;
              with TInventoryCleanUp.Create(Self) do // ** Clean Up Inventory
                   ShowModal;
              Screen.Cursor := crDefault;
      end;

      5110:
      begin
              Screen.Cursor := crHourGlass;
              with TFrmInventoryCount.Create(Self) do // ** Inventory Count
                   Start;
              Screen.Cursor := crDefault;
      end;

      5120:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwColor.Create(Self) do  //Color
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5130:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwSize.Create(Self) do //Size
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      5140: //Barcode Lis
      begin
        with TFrmBarcodePrint.Create(Self) do
          Start('', '');
      end;

      5150: //Pricing Setup
      begin
        Screen.Cursor := crHourGlass;
        with TFrmPricingSetup.Create(Self) do
          Start;
        Screen.Cursor := crDefault;
      end;

      5160: //Report
      begin
        Screen.Cursor := crHourGlass;
        DM.CallReport(DM.fUser.Password);
        Screen.Cursor := crDefault;
      end;

      5170: // Antonio 2014 Apr 08 - Tag
      begin
        Screen.Cursor := crHourGlass;
        with TfrmTagView.Create(self) do begin
          start;
        end;
        // to call new Tag screen
        Screen.Cursor := crDefault;
      end;


      //---------------------------------------------------------------
      //---------------------  Commission  ----------------------------
      6010:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmPagaVendedor.Create(Self) do // ** Sales Person
          ShowModal;
        Screen.Cursor := crDefault;
      end;

      6020:
      begin
              Screen.Cursor := crHourGlass;
              with TFrmPagaGuia.Create(Self) do // ** Pay Agent
                   ShowModal;
              Screen.Cursor := crDefault;
      end;

      6030:
      begin
              Screen.Cursor := crHourGlass;
              with TFrmPagaAgencia.Create(Self) do // ** Pay Agency
                   ShowModal;
              Screen.Cursor := crDefault;
      end;

      6040:
      begin
              Screen.Cursor := crHourGlass;
              with TFrmPagaOther.Create(Self) do  //* Pay Other
                   begin
                   ShowModal;
                   end;
              Screen.Cursor := crDefault;
      end;

      6050:
      begin
              Screen.Cursor := crHourGlass;
              DM.CallReport(DM.fUser.Password);
              Screen.Cursor := crDefault;
      end;

      6060:
      begin
              Screen.Cursor := crHourGlass;
              with TBrwPessoa.Create(Self) do // ** Maintenance
                   begin
                   quTreeView.Parameters.ParambyName('Path').Value := '.003%';
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      //---------------------------------------------------------------
      //---------------------  Accounting  --------------------------

      // Puppy Tracker Integration
      7010: begin
          screen.Cursor := crHourGlass;
          try
              try
                 winExec('PT2MR.exe --config', SW_SHOWNORMAL);
              except
                  on e: Exception do begin
                     MsgBox(MSG_CRT_NO_PUPPYT,vbOkOnly + vbCritical);
                  end;
              end;
          finally
              screen.cursor := crDefault;
          end;
      end;

      7020: begin
          screen.Cursor := crHourGlass;
          try
              try
                 winExec('PT2MR.exe', SW_SHOWNORMAL);
              except
                  on e: Exception do begin
                     MsgBox(MSG_CRT_NO_PUPPYT,vbOkOnly + vbCritical);
                  end;
              end;
          finally
              screen.cursor := crDefault;
          end;
      end;

      //---------------------------------------------------------------
      //---------------------  Maintenance --------------------------

      8010:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwStore.Create(Self) do //Store
                 begin
                 sParam := sMyParam;
                 Start;
                 end;
              Screen.Cursor := crDefault;
      end;

      8020:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwSpecialPrice.Create(Self) do //Special Price
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      8030:
      begin
              Screen.Cursor := crHourGlass;
              with TbrwDeliverType.Create(Self) do //Deliver Type
                   begin
                   sParam := sMyParam;
                   Start;
                   end;
              Screen.Cursor := crDefault;
      end;

      8040:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwUser.Create(Self) do //User
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      8050:
      begin
        Screen.Cursor := crHourGlass;
        with TbrwUserType.Create(Self) do //User Type
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      8060:
      begin
        Screen.Cursor := crHourGlass;
        with TFchParameter.Create(Self) do
          Start(fFchParamType); //Client Parameters
        fFchParamType := PARAM_OPEN_ALL;
        Screen.Cursor := crDefault;
      end;

      8070:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmParameter.Create(Self) do
          ShowModal; //Server Parameters
        Screen.Cursor := crDefault;
      end;

      8080: //NADA
      begin

      end;

      8090:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmMenuItem.Create(Self) do //Menu Items
          ShowModal;
        Screen.Cursor := crDefault;
      end;

      // Adjust Reason  MR-230
      8150: begin
        Screen.Cursor := crHourGlass;
        with TvwAdjustReason.Create(Self) do //Menu Items
          Start();
        Screen.Cursor := crDefault;
      end;

      8100:
      begin
        Screen.Cursor := crHourGlass;
        with TFrmTransferData.Create(self) do //Transfer Data
          ShowModal;
        Screen.Cursor := crDefault;
      end;

      8110:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwMeioPag.Create(self) do //Type of Payments
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      8120:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwTaxCategory.Create(self) do
        begin
          //recebe os parametros para inicializar os campos
          if DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] then
          begin
            BrowseConfig.AutoOpen  := False;
            pnlBasicFilter.Visible := True;
            pblGO.Visible          := True;
          end;
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      8130:
      begin
        Screen.Cursor := crHourGlass;
        with TBrwCostType.Create(Self) do // ** Expence Category
        begin
          sParam := sMyParam;
          Start;
        end;
        Screen.Cursor := crDefault;
      end;

      8140:
      begin
          Screen.Cursor := crHourGlass;
          with TfrmPuppySetting.Create(Self) do // ** PuppyTracker Integration
          begin
            sParam := sMyParam;
            Start;
          end;
          Screen.Cursor := crDefault;
      end;

      
      //---------------------------------------------------------------
      //---------------------  Utilities  -----------------------------
      9010: //Help
      begin
        CallHelp;
      end;

      9020: //Clock
      begin
        Screen.Cursor := crHourGlass;

        with DM.quFreeSQL do
        begin
          if Active then
            Close;
          SQl.Clear;
          SQL.ADD('SELECT P.IDPessoa');
          SQL.ADD('FROM Store S (NOLOCK) , SystemUser SU (NOLOCK) ');
          SQL.ADD('JOIN Pessoa P (NOLOCK) ON ( SU.ComissionID = P.IDPessoa )');
          SQL.ADD('WHERE S.IDStore = '+IntToStr(DM.fStore.ID));
          SQL.ADD('AND SU.IDUser = '+IntToStr(DM.fUser.ID));
          Open;
          if RecordCount = 0 then
          begin
            MsgBox(MSG_INF_NO_ASSOC_COMMITION, vbOKOnly + vbInformation);
            Close;
            exit;
          end;
          iIDPessoa := FieldByName('IDPessoa').AsInteger;
          Close;
        end;

        with TFrmTimeControl.Create(Self) do
          Start(iIDPessoa);

        Screen.Cursor := crDefault;
      end;

      9030: //Shipping e Distribution
      begin
        Screen.Cursor := crHourGlass;

        case DM.CheckCashRegState(DM.fCashRegister.IDShippingReg, IDCashRegMov) of
          CASHREG_OPEN:
          begin
            with TCashRegManager.Create(Self) do
              Start(IDCashRegMov, DM.fCashRegister.IDShippingReg,
                    CASHREG_TYPE_SHIPPING, True);
          end;

          CASHREG_CLOSE:
          begin
            with TCashRegOpen.Create(Self) do
              Start(CASHREG_TYPE_SHIPPING, DM.fCashRegister.IDShippingReg);
          end;
        end;
        Screen.Cursor := crDefault;
      end;

      9040: //Service Order
      begin
        Screen.Cursor := crHourGlass;
        with TFrmServiceOrder.Create(Self) do
          Start;
        Screen.Cursor := crDefault;
      end;

      9050..9090:
      begin
        MyCmdLine := DM.DescCodigo(['IDMenu', 'IDSubMenu'],
                       [IntToStr(IDMenu), IntToStr(IDSubMenu)],
                       'MenuItem', 'CmdLine');
        if MyCmdLine = '' then
          raise exception.Create(MSG_CRT_UTILITY_NOT_DEFINED)
        else
        begin
          Screen.Cursor := crHourGlass;
          // Abre a utility
          ExecuteFile(Trim(MyCmdLine), '', '', SW_SHOW);
          Screen.Cursor := crDefault;
        end;
      end;
    end; //end Case

  end
  else
  begin
    if fFirstTime then
      Application.Terminate;
  end;
end;

procedure TMainMenu.lblSystemExitClick(Sender: TObject);
begin
    // Fecha conexao com database
    dm.setCashRegister(dm.fCashRegister.IDDefault, false);

    DM.ADODBConnect.Close;
    Close;
end;

procedure TMainMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    tmTestMessage.Enabled := False;

    // Desliga o Windows
    if DM.fSystem.ShutDownOnExit then
       ExitWindowsEx(EWX_SHUTDOWN, 0);
end;

procedure TMainMenu.btAtuVersaoClick(Sender: TObject);
begin
   //Rodrigo - Verificar
   // Atualiza nova versao do sistema retail
   if ExecuteFile('\\NtServer\SysRetail\Retail.exe', '', '', SW_SHOW) > 0 then
     begin
      DM.ADODBConnect.Close;
      Application.Terminate;
     end;
end;

procedure TMainMenu.tmrTimeTimer(Sender: TObject);
begin
  lblClock.Caption := FormatDateTime('hh:mm AM/PM', Now);
  lblClockShadow.Caption := FormatDateTime('hh:mm AM/PM', Now);
  lblClock.Hint    := FormatDateTime('dddd, mmmm d, yyyy', Now);
end;

procedure TMainMenu.MyIdle(Sender: TObject; var Done: Boolean);
begin

end;

procedure TMainMenu.lblCashierDblClick(Sender: TObject);
begin
  // Passa para Permanent Log On do Cashier
  if Password.PermanentCashLogOn then
    begin
     Password.PermanentCashLogOn := False;
     imgCashierOpen.Visible      := False;
     tmrCashier.enabled          := False;
     Exit;
    end;

  if Password.Start(-2, -2) then
     begin
       imgCashierOpen.Visible := True;
       tmrCashier.enabled     := True; // ** Liga o timer que controla o tempo
                                       // ** de ociosidade do cashier
     end;
end;

procedure TMainMenu.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // ** Zera a contagem do timer do caixa com o mov. do mouse
  if Password.PermanentLogOn then
    begin
    tmrCashier.Enabled := False;
    tmrCashier.Enabled := True;
    end;
end;

procedure TMainMenu.RefreshColor;
begin

  Label8.Font.Color        := DM.fMainMenu.MenuColor;
  Label9.Font.Color        := DM.fMainMenu.MenuColor;
  Label2.Font.Color        := DM.fMainMenu.MenuColor;
  Label10.Font.Color       := DM.fMainMenu.MenuColor;
  Label11.Font.Color       := DM.fMainMenu.MenuColor;
  Label12.Font.Color       := DM.fMainMenu.MenuColor;
  Label1.Font.Color        := DM.fMainMenu.MenuColor;
  Label14.Font.Color       := DM.fMainMenu.MenuColor;
  Label3.Font.Color        := DM.fMainMenu.MenuColor;
  lblSystemExit.Font.Color := DM.fMainMenu.MenuColor;
  lbSisStore.Font.Color    := DM.fMainMenu.MenuColor;
  lbSisUser.Font.Color     := DM.fMainMenu.MenuColor;


  Label8.Color        := DM.fMainMenu.BackGroundColor;
  Label9.Color        := DM.fMainMenu.BackGroundColor;
  Label2.Color        := DM.fMainMenu.BackGroundColor;
  Label10.Color       := DM.fMainMenu.BackGroundColor;
  Label11.Color       := DM.fMainMenu.BackGroundColor;
  Label12.Color       := DM.fMainMenu.BackGroundColor;
  Label1.Color        := DM.fMainMenu.BackGroundColor;
  Label14.Color       := DM.fMainMenu.BackGroundColor;
  Label3.Color        := DM.fMainMenu.BackGroundColor;
  lblSystemExit.Color := DM.fMainMenu.BackGroundColor;

  lbPOSShortCut.Font.Color         := DM.fMainMenu.MenuColor;
  lbSaleSupShortCut.Font.Color     := DM.fMainMenu.MenuColor;
  lbAdvertiseShortCut.Font.Color   := DM.fMainMenu.MenuColor;
  lbPurchaseShortCut.Font.Color    := DM.fMainMenu.MenuColor;
  lbInventoryShortCut.Font.Color   := DM.fMainMenu.MenuColor;
  lbCommissionShortCut.Font.Color  := DM.fMainMenu.MenuColor;
  lbOMShortCut.Font.Color          := DM.fMainMenu.MenuColor;
  lbMaintenanceShortCut.Font.Color := DM.fMainMenu.MenuColor;
  lbUtilShortCut.Font.Color        := DM.fMainMenu.MenuColor;
  lbExitShortCut.Font.Color        := DM.fMainMenu.MenuColor;

  lbPOSShortCut.Color         := DM.fMainMenu.BackGroundColor;
  lbSaleSupShortCut.Color     := DM.fMainMenu.BackGroundColor;
  lbAdvertiseShortCut.Color   := DM.fMainMenu.BackGroundColor;
  lbPurchaseShortCut.Color    := DM.fMainMenu.BackGroundColor;
  lbInventoryShortCut.Color   := DM.fMainMenu.BackGroundColor;
  lbCommissionShortCut.Color  := DM.fMainMenu.BackGroundColor;
  lbOMShortCut.Color          := DM.fMainMenu.BackGroundColor;
  lbMaintenanceShortCut.Color := DM.fMainMenu.BackGroundColor;
  lbUtilShortCut.Color        := DM.fMainMenu.BackGroundColor;
  lbExitShortCut.Color        := DM.fMainMenu.BackGroundColor;

  lbSM1.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM2.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM3.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM4.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM5.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM6.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM7.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM8.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM9.Font.Color   := DM.fMainMenu.SubMenuColor;
  lbSM10.Font.Color  := DM.fMainMenu.SubMenuColor;
  lbSM11.Font.Color  := DM.fMainMenu.SubMenuColor;
  lbSM12.Font.Color  := DM.fMainMenu.SubMenuColor;
  lbSM13.Font.Color  := DM.fMainMenu.SubMenuColor;
  lbSM14.Font.Color  := DM.fMainMenu.SubMenuColor;
  lbSM15.Font.Color  := DM.fMainMenu.SubMenuColor;
  lbSM16.Font.Color  := DM.fMainMenu.SubMenuColor;


  PanelControl.Color := DM.fMainMenu.MenuBackColor;
  MainMenu.Color     := DM.fMainMenu.BackGroundColor;

  TIP.Font.Color     := DM.fMainMenu.SubMenuHighlight;

  shpHelp.Brush.Color     := DM.fMainMenu.BackGroundColor;
  shpSystem.Brush.Color   := DM.fMainMenu.BackGroundColor;
  shpShortCut.Brush.Color := DM.fMainMenu.BackGroundColor;

  Label13.Font.Color     := DM.fMainMenu.BackGroundColor;
  Label6.Font.Color      := DM.fMainMenu.BackGroundColor;
  lbShortCuts.Font.Color := DM.fMainMenu.BackGroundColor;

  lbShortCuts.Color   := DM.fMainMenu.PanelShorcuts;
  lbSC1.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC2.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC3.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC4.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC5.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC6.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC7.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC8.Font.Color    := DM.fMainMenu.PanelShorcuts;
  lbSC9.Font.Color    := DM.fMainMenu.PanelShorcuts;

  Label13.Color          := DM.fMainMenu.PanelSystem;
  lbLogIn.Font.Color     := DM.fMainMenu.PanelSystem;
  lbLogShort.Font.Color  := DM.fMainMenu.PanelSystem;
  lbMenuColor.Font.Color := DM.fMainMenu.PanelSystem;
  lbSysInfo.Font.Color   := DM.fMainMenu.PanelSystem;
  Label5.Font.Color      := DM.fMainMenu.PanelSystem;
  lbBackup.Font.Color    := DM.fMainMenu.PanelSystem;

  Label6.Color           := DM.fMainMenu.PanelHelp;
  lbTip.Font.Color       := DM.fMainMenu.PanelHelp;
  lbHelp.Font.Color      := DM.fMainMenu.PanelHelp;
  lbHelpShort.Font.Color := DM.fMainMenu.PanelHelp;

  if FileExists(DM.fMainMenu.Logo) then
     imgClientLogo.Picture.LoadFromFile(DM.fMainMenu.Logo);

end;

procedure TMainMenu.FormCreate(Sender: TObject);
var
   cmd: String;
   i: Integer;
   startIntegration: boolean;
   puppyIntegration: TMRPuppyIntegration;
   IdMessage: Integer;
   fUserList: TStringList;
   sIDUSers: String;
begin

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
            begin
            fScreenHelp     := 'MR_SCREEN_ES.HLP';
            fHowToHelp      := 'MR_HOWTO_ES.HLP';
            fOnlineHelpPage := 'http://support.pinogy.net/';
            end;
     LANG_PORTUGUESE :
            begin
            fScreenHelp     := 'MR_SCREEN_BR.HLP';
            fHowToHelp      := 'MR_HOWTO_BR.HLP';
            fOnlineHelpPage := 'http://support.pinogy.net/';
            end;
     LANG_SPANISH :
            begin
            fScreenHelp     := 'MR_SCREEN_SP.HLP';
            fHowToHelp      := 'MR_HOWTO_SP.HLP';
            fOnlineHelpPage := 'http://support.pinogy.net/';
            end;
  end;


  //Pego o help file
  Application.HelpFile := extractfilepath(application.exename) + fScreenHelp;

  quParamTimerCash.open; // ** abre a tabela de parametros do servidor
  tmrCashier.Interval := (StrToInt(quParamTimerCashSrvValue.Text) * 60000);
  quParamTimerCash.close;

  //Setup Language
  if (DMGlobal.IDLanguage <> LANG_ENGLISH) and (siLang.StorageFile <> '') then
     begin
     if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
        siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
        MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);
     end;


  if DM.fMainMenu.WindowMode then
  begin
    Left   := 0;
    Top    := 0;
    BorderStyle := bsSizeable;
    BorderIcons := [biMinimize,biMaximize,biSystemMenu];
  end;

  RefreshColor;


end;

procedure TMainMenu.tmrCashierTimer(Sender: TObject);
begin
  // ** Tira o UnLock do caixa caso ele tenha ficado ocioso por n minutos
  // ** onde n é definido em Server Parameters
  tmrCashier.enabled          := False;
  PassWord.PermanentCashLogOn := False;
  imgCashierOpen.visible      := False;

  //Password Normal
  Password.PermanentLogOn := False;
  imgManagerOpen.Visible  := False;
  imgManagerClose.Visible := True;
  lbLogIn.Caption         := 'LogIn';
  lbLogShort.Left         := lbLogIn.Left + lbLogIn.Width + 3;
  pnlSistemInfo.Visible   := False;
  DM.fUser.CheckMessage   := False;

  DM.VerifyMessage;
end;

procedure TMainMenu.tmTestMessageTimer(Sender: TObject);
begin
  DM.VerifyMessage;
end;


procedure TMainMenu.tmrTrialCountTimer(Sender: TObject);
var
  iCurCount: integer;
  buildInfo: String;
begin
  with TRegistry.Create do
    try

      // acessa a chave CURRENT_USER se Windows 7
      if ( getOS(buildInfo) = osW7 ) then
        RootKey := HKEY_CURRENT_USER
      else
        RootKey:= HKEY_LOCAL_MACHINE;

      OpenKey('SOFTWARE\Applenet\CurrentVersions', True);
      if not ValueExists('TrialCount') then
      begin
        MsgBox(MSG_CRT_NO_VALID_TRIAL_INFO, vbOKOnly + vbCritical);
        Application.Terminate;
      end;

      iCurCount:= StrToInt(DecodeServerInfo(ReadString('TrialCount'), 'Count', CIPHER_TEXT_STEALING, FMT_UU));
      Inc(iCurCount);

      WriteString('TrialCount', EncodeServerInfo(IntToStr(iCurCount), 'Count', CIPHER_TEXT_STEALING, FMT_UU));
    finally
      Free;
    end;
end;

procedure TMainMenu.lbDemoClick(Sender: TObject);
begin
  OpenURL('http://www.mainretail.com/');
end;

procedure TMainMenu.imgTipClick(Sender: TObject);
begin
  CallTip;
end;

procedure TMainMenu.quSubMenuBeforeOpen(DataSet: TDataSet);
begin
  quSubMenu.Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
end;

procedure TMainMenu.lblOdblClickClick(Sender: TObject);
begin
  // Passa para Permanent Log On
  if Password.PermanentLogOn then
  begin
    Password.PermanentLogOn := False;
    imgManagerOpen.Visible  := False;
    imgManagerClose.Visible := True;
    tmrCashier.Enabled      := False;
    lbLogIn.Caption         := 'Login';
    lbLogShort.Left         := lbLogIn.Left + lbLogIn.Width + 3;
    pnlSistemInfo.Visible   := False;
    DM.fUser.ID             := 0;
    DM.VerifyMessage;
    Exit;
  end
  else
    tmrCashier.Enabled := True;

  Screen.Cursor := crHourGlass;

  if Password.Start(-1, -1) then
  begin
    imgManagerOpen.Visible  := True;
    imgManagerClose.Visible := False;
    lbLogIn.Caption         := 'LogOut';
    lbLogShort.Left         := lbLogIn.Left + lbLogIn.Width + 3;
    pnlSistemInfo.Visible   := True;
    lbSisUser.Caption       := DM.fUser.UserName;
    lbSisStore.Caption      := DM.fStore.Name;
  end;

  Screen.Cursor := crDefault;
end;

procedure TMainMenu.imgSystemInfoClick(Sender: TObject);
begin
  with TFrmSystemInfo.Create(Self) do
     Start; 
end;

procedure TMainMenu.imgHelpClick(Sender: TObject);
begin
  CallHelp;
end;

procedure TMainMenu.imgMenuColorClick(Sender: TObject);
var
  iMOld,
  iSOld : Integer;
begin
  //Chama o FchParam com a opcao de cores do menu
  iMOld     := IDMenu;
  iSOld     := IDSubMenu;

  //Seta o menu de FchParam
  IDMenu    := 8;
  IDSubMenu := 6;
  fFchParamType := PARAM_OPEN_MENU;
  SubMenuClick(nil);

  //Volta para o menu anterior
  IDMenu    := iMOld;
  IDSubMenu := iSOld;
end;

procedure TMainMenu.imgSC1Click(Sender: TObject);
var
  iMOld,
  iSOld : Integer;
begin
  iMOld     := IDMenu;
  iSOld     := IDSubMenu;

  //Seta o menu
  IDMenu    := StrToIntDef(ParseParam(vtShortCuts[TComponent(Sender).Tag],'M'),1);;
  IDSubMenu := StrToIntDef(ParseParam(vtShortCuts[TComponent(Sender).Tag],'S'),1);;
  SubMenuClick(nil);

  //Volta para o menu anterior
  IDMenu    := iMOld;
  IDSubMenu := iSOld;
end;

procedure TMainMenu.imgLanguageClick(Sender: TObject);
begin
   with TfrmLanguageMR.Create(Self) do
      Start(MR);
end;

procedure TMainMenu.lbBackupClick(Sender: TObject);
var
 sDBPath : String;
begin
 //Test Local Server
 with DM.quFreeSQL do
   begin
   if Active then
      Close;
   SQl.Text := 'SELECT filename ' +
               'FROM master..sysdatabases ' +
               'WHERE Name = ' + QuotedStr(DM.fSQLConnectParam.DBAlias);
   Open;
   sDBPath := FieldByName('filename').AsString;
   Close;
   end;

 if (sDBPath='') or (not FileExists(sDBPath)) then
    begin
    MsgBox(MSG_INF_NOT_SERVER, vbOKOnly + vbInformation);
    Exit;
    end;

 //Call Backup
 CallBackup;
 
end;

procedure TMainMenu.CallOnlineHelp;
begin
  OpenURL(fOnlineHelpPage);
end;

procedure TMainMenu.imgOnlineHelpClick(Sender: TObject);
begin
  CallOnlineHelp;
end;

procedure TMainMenu.lbMessageClick(Sender: TObject);
begin
  lblOdblClickClick(Self);

  if DM.fUser.ID <> 0 then
    with TFrmUserMessager.Create(Self) do
      Start;

  Password.PermanentLogOn := False;
  lbSisUser.Caption       := '';
  lbSisStore.Caption      := '';

end;

procedure TMainMenu.FormActivate(Sender: TObject);
var
	msgError: String;
begin
  // Antonio 2013 Nov 08, MR-100
  if ( DBBUILD <> dm.getBuildDbVersion ) then begin
     msgError := 'MainRetail version is not compatible with the database.' + #13#10 +
     					'Call support at 877-360-7381 to correct this issue.';
     MessageDlg(msgError, mtError, [mbOK], 0);
     Application.Terminate;
  end;

  if (DM.fSystem.MRBuildValidate) and (MRBUILD <> DM.fSystem.MRBuild) then begin
    MessageDlg('MainRetail version is out of date. Call support at 877-360-7381 to schedule a time to update.', mtWarning, [mbOK], 0);
  end;
end;

procedure TMainMenu.btnReasonClick(Sender: TObject);
var
   view: TvwAdjustReason;
begin
   view := TvwAdjustReason.Create(Self);
   view.Start();

end;

end.

