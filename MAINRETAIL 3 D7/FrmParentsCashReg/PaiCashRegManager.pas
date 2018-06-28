unit PaiCashRegManager;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DB, DBTables, Grids, DBGrids, StdCtrls, LblEffct,
  Buttons, ComCtrls, Mask, DateBox, ADODB, Variants, uPai, siComp, siLangRT,
  uTefConsts, uFrmTEFOptions;

type
  TFrmPaiCashRegManager = class(TFrmPai)
    tmrOverLoad: TTimer;
    lbCRInfo: TLabel;
    pnlOverLoad: TPanel;
    lblOverLoad: TLabel;
    lblCashOverLoad: TLabel;
    Panel1: TPanel;
    BtnCloseCash: TSpeedButton;
    BtnDeposit: TSpeedButton;
    imgPw: TImage;
    Bevel1: TBevel;
    btnCashConfig: TSpeedButton;
    Bevel2: TBevel;
    btnNewPDV: TButton;
    pnlTEF: TPanel;
    btnCancelTEF: TSpeedButton;
    pnlFiscal: TPanel;
    btnCancelInvvoice: TSpeedButton;
    lbCashInfo: TLabel;
    lbMRInfo: TLabel;
    btnAddCash: TSpeedButton;
    btnCashHistory: TSpeedButton;
    btnMenuFiscal: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tmrOverLoadTimer(Sender: TObject);
    procedure BtnDepositClick(Sender: TObject);
    procedure btnAddCashClick(Sender: TObject);
    procedure BtnCloseCashClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgPwClick(Sender: TObject);
    procedure btnCashConfigClick(Sender: TObject);
    procedure btnCancelInvvoiceClick(Sender: TObject);
    procedure btnNewPDVClick(Sender: TObject);
    procedure btnCashHistoryClick(Sender: TObject);
    procedure btnCancelTEFClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnMenuFiscalClick(Sender: TObject);
  private
    { Private declarations }
    sOpen,
    sShowConfig,
    sHideConfig,
    sAt,
    sCashInfo   : String;
    MyIDCashRegMov  : Integer;
    IsOverLoad      : Boolean;
    procedure ReleasePW;
    procedure RefreshPW;
  public
    { Public declarations }
    procedure Start(IDCashRegMov : integer; IsCaixaMode : Boolean);
  end;

implementation

uses uDM, uCashRegClose, uCashRegWidraw, uMsgBox, uSystemConst,
     uPassword, uCashRegPetty, uMsgConstant, uNumericFunctions,
     uDateTimeFunctions, uDMGlobal, uCashRegConfig, uMRPDV,
     uFrmPDVLog, uTefDedicado, uFrmMenufiscal;

{$R *.DFM}

procedure TFrmPaiCashRegManager.Start(IDCashRegMov : integer; IsCaixaMode : Boolean);
var
  fCashRegName,
  fOpenUser    : String;
  fStatus      : Integer;
  fOpenDate    : TDateTime;
begin
  MyIDCashRegMov := IDCashRegMov;

  // Mostra a caixa que esta sendo usada
  DM.fPOS.GetCashRegisterInfo(IDCashRegMov, fCashRegName, fOpenUser, fStatus, fOpenDate);

  DM.fCashRegister.Name := fCashRegName;

  lbCRInfo.Caption   := Trim(fCashRegName) + sOpen + Trim(fOpenUser) + sAt +
                            DateTimeToStr(fOpenDate);

  if fStatus = ST_CASHREG_CLOSE then
  begin
    MsgBox('Caixa fechado com error._Por favor, abrir o sistema novamente e verificar o último fechamento.', vbOKOnly + vbSuperCritical);
    DM.fCashRegister.SalesFileName := '';
    Self.Close;
    Exit;
  end;

  // Testa o status da caixa para ver se pode Fazer depositos, pettycash ou fecha-la
  BtnDeposit.Enabled  := (fStatus = ST_CASHREG_OPEN);
  btnAddCash.Enabled := BtnDeposit.Enabled;
  // So deixa dar Close se estiver no modo caixa
  BtnCloseCash.Enabled := BtnDeposit.Enabled and IsCaixaMode;

  pnlFiscal.Visible :=  DM.fCashRegister.FiscalPrinter;
  pnlTEF.Visible := (DM.fCashRegister.FiscalPrinter and (DM.fCashRegister.UseTef <> TEF_NONE));

  //Homologacao BA
  lbCashInfo.Caption := sCashInfo + CASH_HOMOLOG;
  lbCashInfo.Hint    := sCashInfo + CASH_VERSION;

  if not pnlTEF.Visible then
     Self.Height := 395;

  if not pnlFiscal.Visible then
     Self.Height := 305;

  btnCashHistory.Visible := (DM.PersistenceType = ptTXT);

  ShowModal;

end;

procedure TFrmPaiCashRegManager.FormCreate(Sender: TObject);
begin
  inherited;
  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sOpen       := ', opened by ';
           sAt         := ' at ';
           sShowConfig := '&Show configuration';
           sHideConfig := '&Hide configuration';
           sCashInfo   := 'POS';
           end;

     LANG_PORTUGUESE :
           begin
           sOpen       := ', aberta por ';
           sAt         := ' em ';
           sShowConfig := 'Mo&strar configuração';
           sHideConfig := 'Ocultar configuração';
           sCashInfo   := 'PDV';
           end;

     LANG_SPANISH :
           begin
           sOpen       := ', abrió por ';
           sAt         := ' en ';
           sShowConfig := 'Mue&stre configuración';
           sHideConfig := 'E&sconda configuration';
           sCashInfo   := 'POS';
           end;
   end;

end;

procedure TFrmPaiCashRegManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Screen.Cursor := crDefault;
  Action := caFree;
end;

procedure TFrmPaiCashRegManager.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of

    VK_F2 : begin
              if DM.fCashRegister.Fiscal then
                 btnCancelInvvoiceClick(btnCancelInvvoice);
            end;

    VK_F3 : begin
              btnCashConfigClick(btnCashConfig);
            end;

    VK_F4 : begin
              btnCashHistoryClick(btnCashHistory);
            end;

    VK_F5 : begin
            if (DM.fCashRegister.Fiscal) and (pnlTEF.Visible) then
               with TFrmTEFOptions.Create(Self) do
                 Start;
            end;

    VK_F9 : begin //Close Register
            if BtnCloseCash.Enabled then
               BtnCloseCashClick(BtnCloseCash);
            end;

    VK_F10 : begin //Deposit
            if BtnDeposit.Enabled then
               BtnDepositClick(BtnDeposit);
            end;

    VK_F11 : begin //Petty Cash
            if btnAddCash.Enabled then
               btnAddCashClick(btnAddCash);
            end;
  end;

end;


procedure TFrmPaiCashRegManager.tmrOverLoadTimer(Sender: TObject);
begin
  inherited;
  pnlOverLoad.Visible := IsOverLoad;

  if IsOverLoad then
  begin
    MessageBeep(0);
    if lblCashOverLoad.Font.Color = clMaroon then
    begin
      lblCashOverLoad.Font.Color := clRed;
      lblOverLoad.Font.Color     := clRed;
      pnlOverLoad.Color          := clMaroon;
    end
    else
    begin
      lblCashOverLoad.Font.Color := clMaroon;
      lblOverLoad.Font.Color     := clMaroon;
      pnlOverLoad.Color          := clBlack;
    end;
  end;
end;

procedure TFrmPaiCashRegManager.BtnDepositClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    if not Password.HasFuncRight(60) then
    begin
      MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
      Exit;
    end;

    with TCashRegWidraw.Create(Self) do
      Start(MyIDCashRegMov);
  end;

  RefreshPW;

  Screen.Cursor := crDefault;
  

end;

procedure TFrmPaiCashRegManager.btnAddCashClick(Sender: TObject);
begin
  inherited;

  // Troca de Petty Cash
  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    if not Password.HasFuncRight(61) then
    begin
      MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
      Exit;
    end;

    with TCashRegPetty.Create(Self) do
      Start(MyIDCashRegMov);
  end;

  RefreshPW;

  Screen.Cursor := crDefault;

end;

procedure TFrmPaiCashRegManager.BtnCloseCashClick(Sender: TObject);
var
  IDCashReg : integer;
begin
  inherited;
  Screen.Cursor := crHourGlass;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    if not Password.HasFuncRight(59) then
    begin
      MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
      Exit;
    end;

    with TCashRegClose.Create(Self) do
    begin
      Start(MyIDCashRegMov);
      if (DM.CheckCashRegState(IDCashReg) = CASHREG_CLOSE) then
        Self.Close;
    end;
  end;

  RefreshPW;

  Screen.Cursor := crDefault;
  
end;

procedure TFrmPaiCashRegManager.RefreshPW;
begin

  //imgPw.Visible := Password.PermanentLogOn;

end;

procedure TFrmPaiCashRegManager.ReleasePW;
begin
  if Password.PermanentLogOn then
     Password.PermanentLogOn := False;

  RefreshPW;
     
end;

procedure TFrmPaiCashRegManager.FormShow(Sender: TObject);
begin
  inherited;
  RefreshPW;
end;

procedure TFrmPaiCashRegManager.imgPwClick(Sender: TObject);
begin
  inherited;
  ReleasePW;
end;

procedure TFrmPaiCashRegManager.btnCashConfigClick(Sender: TObject);
begin
  inherited;

  if Password.PermanentLogOn then
     Password.PermanentLogOn := False;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     if DM.CanAccessMenu(8,6,DM.fUser.Password) then
        with TFrmCashRegConfig.Create(Self) do
           Start(OPEN_TYPE_ALTER)
     else
        MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);
         
end;

procedure TFrmPaiCashRegManager.btnCancelInvvoiceClick(Sender: TObject);
begin
  inherited;

  if not Password.HasFuncRight(88) then
    MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation)
  else
    DM.fPOS.CancelaUltimoCupom(MyIDCashRegMov);
end;

procedure TFrmPaiCashRegManager.btnNewPDVClick(Sender: TObject);
var
  sSenha : String;
begin
  inherited;

  //Valida o grande total da impressora
  if DM.fCashRegister.FiscalPrinter and (not DM.VerifyGrandeTotal) then
  begin
    sSenha := InputBox('Entre com a senha de desenvolvedor', 'Senha', '');
    if (sSenha = '') or ((sSenha <> '') and (sSenha <> 'mainretail')) then
    begin
      MsgBox('Senha invalida!', vbCritical + vbOkOnly);
      Exit;
    end
    else
      DM.CreateGrandTotal;

    if not DM.VerifyGrandeTotal then
    begin
      MsgBox('Grande Total Invalido._Não será possível efetuar vendas!', vbOKOnly + vbSuperCritical);
      Exit;
    end;
  end;

  if Password.PermanentLogOn then
     Password.PermanentLogOn := False;

  if not Password.Start(1,1) then
     Exit;

  with TFrmMRPDV.Create(Self) do
     Start(MyIDCashRegMov);
     
end;

procedure TFrmPaiCashRegManager.btnCashHistoryClick(Sender: TObject);
begin
  inherited;

  if Password.PermanentLogOn then
     Password.PermanentLogOn := False;

  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
     if DM.CanAccessMenu(1,2,DM.fUser.Password) then
        with TFrmPDVLog.Create(Self) do
           Start
     else
        MsgBox(MSG_INF_CANNOT_ACCESS_MODULE, vbOKOnly + vbInformation);


end;

procedure TFrmPaiCashRegManager.btnCancelTEFClick(Sender: TObject);
begin
  inherited;
  
  with TFrmTEFOptions.Create(Self) do
    Start;

end;

procedure TFrmPaiCashRegManager.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(20);
end;

procedure TFrmPaiCashRegManager.btnMenuFiscalClick(Sender: TObject);
begin
  inherited;
  with TFrmMenufiscal.Create(Self) do
    Start;
end;

end.

