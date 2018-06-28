unit uCashRegOpen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, Mask, LblEffct, ExtCtrls, DBCtrls, DB, DBTables,
  Buttons, ADODB, SuperComboADO, siComp, siLangRT;

type
  TCashRegOpen = class(TFrmParent)
    Label1: TLabel;
    Label2: TLabel;
    Label23: TLabel;
    EditTime: TEdit;
    btCancel: TButton;
    cmbUser: TSuperComboADO;
    Panel10: TPanel;
    Label12: TLabel;
    Panel11: TPanel;
    grpCoin: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Edit0100: TEdit;
    Edit050: TEdit;
    Edit025: TEdit;
    Edit010: TEdit;
    Edit005: TEdit;
    Edit001: TEdit;
    EditTot001: TEdit;
    EditTot005: TEdit;
    EditTot010: TEdit;
    EditTot025: TEdit;
    EditTot050: TEdit;
    EditTot0100: TEdit;
    grpBill: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Edit100: TEdit;
    Edit50: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit10: TEdit;
    Edit20: TEdit;
    EditTot100: TEdit;
    EditTot50: TEdit;
    EditTot20: TEdit;
    EditTot10: TEdit;
    EditTot5: TEdit;
    EditTot2: TEdit;
    EditTot1: TEdit;
    EditTotCash: TEdit;
    Panel4: TPanel;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    pnlOpenMessage: TPanel;
    Panel5: TPanel;
    Image5: TImage;
    Image8: TImage;
    Label5: TLabel;
    Label6: TLabel;
    btOpenCash: TSpeedButton;
    tmrOpenMessage: TTimer;
    pnlOther: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label10: TLabel;
    Panel6: TPanel;
    Label7: TLabel;
    EditTotCounted: TEdit;
    spHelp: TSpeedButton;
    cmbTotalCard: TEdit;
    btnTotalCard: TSpeedButton;
    cmbTotalPre: TEdit;
    btnPostDate: TSpeedButton;
    cmbTotalCheck: TEdit;
    btnCheckTotal: TSpeedButton;
    cmbTotalOther: TEdit;
    btnOtherTotal: TSpeedButton;
    Image4: TImage;
    lbDebit: TLabel;
    cmbTotalDebit: TEdit;
    btnTotalDebit: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btOpenCashClick(Sender: TObject);
    procedure tmrOpenMessageTimer(Sender: TObject);
    procedure AtuTotals(Sender : TObject);
    procedure spHelpClick(Sender: TObject);
    procedure Edit100KeyPress(Sender: TObject; var Key: Char);
    procedure cmbTotalCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTotalCardClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FScreenType : Integer;
    FIDCashReg : Integer;
    TotCountGeral,
    TotCashGeral : Double;
    fCall : Integer;
    procedure MakeDeposit(TestField:Boolean);
    function TestaPreenchimento(grpBox : TGroupBox) : Boolean;
  public
    function Start(ScreenType : Integer; IDCashReg : Integer) : Boolean;
  end;

implementation

uses uDM, uCashRegManager, uPrintCashReg, uMsgBox, uItemsCalc, uSystemConst,
     uMsgConstant, uNumericFunctions, uCharFunctions, uDMGlobal, uFrmMainPOS;

{$R *.DFM}

procedure TCashRegOpen.FormShow(Sender: TObject);
begin
  inherited;
  btClose.Visible := False;
  pnlOpenMessage.Visible := True;

  // Seta o usuario e time
  cmbUser.LookUpValue := IntToStr(DM.fUser.ID);
  EditTime.Text       := DateTimeToStr(Now);

  fCall := -1;
  
end;

procedure TCashRegOpen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCashRegOpen.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCashRegOpen.btCloseClick(Sender: TObject);
begin
  inherited;

  MakeDeposit(True);

end;

function TCashRegOpen.TestaPreenchimento(grpBox : TGroupBox) : Boolean;
var
  i : integer;
begin
  Result := True;
  if MyRound(TotCountGeral, 2) < DM.fSystem.SrvParam[PARAM_CASHREGRESTANT] then
    if MsgBox(MSG_QST_OPEN_CASH_LESS_MONEY + FloatToStrF(DM.fSystem.SrvParam[PARAM_CASHREGRESTANT], ffcurrency, 20, 2) + ' ?', vbYesNo + vbQuestion) = vbNo then
    begin
      Result := False;
      Exit;
    end;

  Exit;   // Foi colocado a pedido do Lui
  with grpBox do
    for i := 0 to ControlCount -1 do
      if (Controls[i] is TEdit) and TEdit(Controls[i]).TabStop and
         (TEdit(Controls[i]).Text = '') then
      begin
        MsgBox(MSG_INF_COUNT_ITEMS, vbOKOnly + vbInformation);
        TEdit(Controls[i]).SetFocus;
        Result := False;
        Exit;
      end;
end;

procedure TCashRegOpen.btOpenCashClick(Sender: TObject);
begin
  inherited;
  //Caixa para escritorio
  btOpenCash.Enabled := false;

  if (FScreenType = CASHREG_TYPE_OFFICE) or
     (FScreenType = CASHREG_TYPE_SHIPPING) then
     begin
     MakeDeposit(False);
     Exit;
     end;

  // Abre a caixa
  DM.OpenCashRegister(DRAW_KICK_TYPO_OPEN_CASH);

  // faz animacao de abertura de caixa
  tmrOpenMessage.Enabled:= True;

  // deixar o help button invisivel
  spHelp.Visible:= False;
end;

procedure TCashRegOpen.tmrOpenMessageTimer(Sender: TObject);
begin
  inherited;
  if pnlOpenMessage.Height - 21 < 0 then
  begin
    pnlOpenMessage.Visible := False;
    tmrOpenMessage.Enabled := False;
    btClose.Visible := True;
    Edit100.SetFocus;
  end
  else
    pnlOpenMessage.Height := pnlOpenMessage.Height - 20;
end;

procedure TCashRegOpen.AtuTotals(Sender : TObject);
var
  Razao        : Double;
  EditValor    : TEdit;
begin
  EditValor := TEdit(Sender);

  if EditValor.Tag <> -999999 then
  begin
    Razao     := (EditValor.Tag)/100;

    case EditValor.Tag of
       10000 : EditValor := EditTot100;
       5000  : EditValor := EditTot50;
       2000  : EditValor := EditTot20;
       1000  : EditValor := EditTot10;
        500  : EditValor := EditTot5;
        200  : EditValor := EditTot2;
        100  : if EditValor.Parent.tag = 0 then
                 EditValor := EditTot1
               else
                 EditValor := EditTot0100;
          1  : EditValor := EditTot001;
          5  : EditValor := EditTot005;
         10  : EditValor := EditTot010;
         25  : EditValor := EditTot025;
         50  : EditValor := EditTot050;
    end;

    EditValor.Text := FormatFloat('#,##0.00', MyStrToFloat(TEdit(Sender).Text)*Razao);

    // Atualiza o total geral
    TotCashGeral := MyStrToFloat(Edit100.Text)*100;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit50.Text)*50;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit20.Text)*20;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit10.Text)*10;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit5.Text)*5;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit2.Text)*2;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit1.Text);
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit001.Text)*0.01;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit005.Text)*0.05;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit010.Text)*0.1;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit025.Text)*0.25;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit050.Text)*0.5;
    TotCashGeral := TotCashGeral + MyStrToFloat(Edit0100.Text);

    EditTotCash.Text := FormatFloat('#,##0.00', TotCashGeral);
  end;

  TotCountGeral := TotCashGeral +
                   MyStrToFloat(cmbTotalCard.text)  +
                   MyStrToFloat(cmbTotalPre.text)   +
                   MyStrToFloat(cmbTotalCheck.text) +
                   MyStrToFloat(cmbTotalOther.text) +
                   MyStrToFloat(cmbTotalDebit.text);

  editTotCounted.Text := FormatFloat('#,##0.00', TotCountGeral);

end;

procedure TCashRegOpen.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1000);
end;

procedure TCashRegOpen.Edit100KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Key := ValidateNumbers(Key);
  
end;

procedure TCashRegOpen.cmbTotalCardKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_F2 then
     begin
       fCall := TEdit(Sender).Tag;
       btnTotalCardClick(Self);
     end;

end;

procedure TCashRegOpen.btnTotalCardClick(Sender: TObject);
begin
  inherited;

  with TfrmItemsCalc.Create(self) do
     begin
     if ShowModal = mrOK then
        begin
        if fCall = -1 then
           fCall := TSpeedButton(Sender).Tag;
        Case fCall of
         1 : cmbTotalCard.Text  := MyFloatToStr(TotGeral);
         2 : cmbTotalPre.Text   := MyFloatToStr(TotGeral);
         3 : cmbTotalCheck.Text := MyFloatToStr(TotGeral);
         4 : cmbTotalOther.Text := MyFloatToStr(TotGeral);
         5 : cmbTotalDebit.Text := MyFloatToStr(TotGeral);
        end;
       fCall := -1;
     end;

     Free;
     end;
  
end;

procedure TCashRegOpen.FormCreate(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
     begin
     btOpenCash.Enabled := False;
     btClose.Enabled    := False;
     end;
end;

procedure TCashRegOpen.MakeDeposit(TestField: Boolean);
var
  IDCashRegMov,
  IDCashRegLog : Integer;
begin

  // Testa preenchimento dos campos
  if TestField then
     if not (TestaPreenchimento(grpBill) and TestaPreenchimento(grpCoin)) then
        Exit;

  // Abre a caixa
  DM.fPOS.OpenCashRegister(MyStrToInt(Edit100.Text),
                           MyStrToInt(Edit50.Text),
                           MyStrToInt(Edit20.Text),
                           MyStrToInt(Edit10.Text),
                           MyStrToInt(Edit5.Text),
                           MyStrToInt(Edit2.Text),
                           MyStrToInt(Edit1.Text),
                           MyStrToInt(Edit0100.Text),
                           MyStrToInt(Edit050.Text),
                           MyStrToInt(Edit025.Text),
                           MyStrToInt(Edit010.Text),
                           MyStrToInt(Edit005.Text),
                           MyStrToInt(Edit001.Text),
                           FIDCashReg,
                           DM.fUser.ID,
                           TotCountGeral,
                           TotCashGeral,
                           MyStrToFloat(cmbTotalCard.Text),
                           MyStrToFloat(cmbTotalPre.Text),
                           MyStrToFloat(cmbTotalCheck.Text),
                           MyStrToFloat(cmbTotalOther.Text),
                           MyStrToFloat(cmbTotalDebit.Text),
                           Now,
                           IDCashRegMov,
                           IDCashRegLog);


  if DM.fPrintReceipt.PrintReceipt then
    // Imprime o ticket do caixa
    with TPrintCashReg.Create(Self) do
      Start(IDCashRegLog, TICKET_CASH_OPEN);

  Hide;

  case FScreenType of
    CASHREG_TYPE_FULL_POS :
      begin
        with TFrmMainPOS.Create(Self) do
          Start(SALE_CASHREG, IDCashRegMov);
      end;
    else
      with TCashRegManager.Create(Self) do
        Start(IDCashRegMov, FIDCashReg, FScreenType, True);
  end;

  Close;

end;

function TCashRegOpen.Start(ScreenType: Integer; IDCashReg : Integer): Boolean;
begin

  FScreenType := ScreenType;
  FIDCashReg  := IDCashReg;
  ShowModal;

end;

end.
