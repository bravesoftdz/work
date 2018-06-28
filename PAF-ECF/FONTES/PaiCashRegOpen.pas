unit PaiCashRegOpen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, DBCtrls, DB, DBTables,
  Buttons, ADODB, SuperComboADO, uPai, siComp, siLangRT;

type
  TFrmPaiCashRegOpen = class(TFrmPai)
    Label1: TLabel;
    Label2: TLabel;
    Label23: TLabel;
    EditTime: TEdit;
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
    tmrOpenMessage: TTimer;
    pnlOther: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label10: TLabel;
    Panel6: TPanel;
    Label7: TLabel;
    EditTotCounted: TEdit;
    cmbTotalCard: TEdit;
    btnTotalCard: TSpeedButton;
    cmbTotalPre: TEdit;
    btnPostDate: TSpeedButton;
    cmbTotalCheck: TEdit;
    btnCheckTotal: TSpeedButton;
    cmbTotalOther: TEdit;
    btnOtherTotal: TSpeedButton;
    btCancel: TButton;
    btOpenCash: TButton;
    cmbUser: TDBLookupComboBox;
    btnSetup: TButton;
    btnLog: TButton;
    lbDebit: TLabel;
    cmbTotalDebit: TEdit;
    btnTotalDebit: TSpeedButton;
    btnMenuFiscal: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure tmrOpenMessageTimer(Sender: TObject);
    procedure AtuTotals(Sender : TObject);
    procedure spHelpClick(Sender: TObject);
    procedure Edit100KeyPress(Sender: TObject; var Key: Char);
    procedure cmbTotalCardKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTotalCardClick(Sender: TObject);
    procedure btOpenCashClick(Sender: TObject);
    procedure btnSetupClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnMenuFiscalClick(Sender: TObject);
  private
    { Private declarations }
    fCall : Integer;
    function TestaPreenchimento(grpBox : TGroupBox) : Boolean;
  protected
    TotCountGeral,
    TotCashGeral : Double;
    function TestBeforeOpen:Boolean; virtual;
  public
    { Public declarations }
  end;

implementation

uses uDM, uCashRegManager, uPrintCashReg, uMsgBox, uItemsCalc, uSystemConst,
     uMsgConstant, uNumericFunctions, uCharFunctions, uDMGlobal,
     uFilePersistence, uCashRegConfig, uPassword, uFrmPDVLog, uFrmMenufiscal;

{$R *.DFM}

procedure TFrmPaiCashRegOpen.FormShow(Sender: TObject);
begin
  inherited;
  btClose.Visible := False;
  pnlOpenMessage.Visible := True;

  // Seta o usuario e time
  cmbUser.KeyValue := DM.fUser.ID;
  EditTime.Text    := DateTimeToStr(Now);

  fCall := -1;
  
end;

procedure TFrmPaiCashRegOpen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPaiCashRegOpen.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TFrmPaiCashRegOpen.TestBeforeOpen:Boolean;
begin
  Result := True;
end;

procedure TFrmPaiCashRegOpen.btCloseClick(Sender: TObject);
var
  IDCashRegMov,
  IDCashRegLog : Integer;
  ReducaoZ: TRegReducaoZ;
  fData : TDateTime;
begin
  inherited;
  // Testa preenchimento dos campos
  if TestaPreenchimento(grpBill) and TestaPreenchimento(grpCoin) then
  begin

    //Testa o comando para abrir a caixa fiscal
    if not TestBeforeOpen then
       Exit;

    fData := Now;

      fData := DM.fCupomFiscal.DataHora;

    btnMenuFiscal.Visible := (True);

    // Abre a caixa
    case DM.PersistenceType of
      ptDB:
      begin
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
                                 DM.fCashRegister.IDDefault,
                                 DM.fUser.ID,
                                 TotCountGeral,
                                 TotCashGeral,
                                 MyStrToFloat(cmbTotalCard.Text),
                                 MyStrToFloat(cmbTotalPre.Text),
                                 MyStrToFloat(cmbTotalCheck.Text),
                                 MyStrToFloat(cmbTotalOther.Text),
                                 MyStrToFloat(cmbTotalDebit.Text),
                                 fData,
                                 DM.fCupomFiscal.COO,
                                 DM.fCupomFiscal.GNF,
                                 IDCashRegMov,
                                 IDCashRegLog);


        if DM.fCashRegister.GeneratePAFSintegra then
        begin
          ReducaoZ := DM.DadosReducaoZ;
          if ReducaoZ.ANumeroSerie <> '' then
            DM.fPOS.InsertReducaoZ(ReducaoZ.AMovDate, ReducaoZ.ANumeroSerie,
                     ReducaoZ.ANumeroLoja, ReducaoZ.ANumeroECF, ReducaoZ.ANumReducaoZ,
                     ReducaoZ.ACOOInicial, ReducaoZ.ACOOFinal, ReducaoZ.ANumCancelamentos,
                     ReducaoZ.AValCancelamentos, ReducaoZ.AValDescontos, ReducaoZ.AGTInicial,
                     ReducaoZ.AGTFinal, ReducaoZ.ASubstituicaoTrib, ReducaoZ.AIsencao,
                     ReducaoZ.ANaoTributavel, ReducaoZ.AAliquota, ReducaoZ.ABaseCalculo,
                     ReducaoZ.AValImposto, ReducaoZ.ATipoECF, ReducaoZ.AMarcaECF,
                     ReducaoZ.AModeloECF, ReducaoZ.AVersaoSBECF, ReducaoZ.ADataInstalacaoSBECF,
                     ReducaoZ.AMFAdicional, ReducaoZ.AContadorReducaoZ, ReducaoZ.AContadorOrdemOperacao,
                     ReducaoZ.AContadorReinicioOperacao, ReducaoZ.ANumeroUsuarioECF, ReducaoZ.AIncideISSQN,
                     ReducaoZ.ADataEmissao, ReducaoZ.ATribReducaoZList);
        end;
      end;

      ptTXT:
      begin
        if DM.fCashRegister.GeneratePAFSintegra then
          ReducaoZ := DM.DadosReducaoZ;

        DM.SaleWritter.OpenCashRegister(MyStrToInt(Edit100.Text),
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
                                   DM.fCashRegister.IDDefault,
                                   DM.fUser.ID,
                                   TotCountGeral,
                                   TotCashGeral,
                                   MyStrToFloat(cmbTotalCard.Text),
                                   MyStrToFloat(cmbTotalPre.Text),
                                   MyStrToFloat(cmbTotalCheck.Text),
                                   MyStrToFloat(cmbTotalOther.Text),
                                   fData,
                                   MyStrToFloat(cmbTotalDebit.Text),
                                   DM.fCupomFiscal.COO,
                                   DM.fCupomFiscal.GNF,
                                   ReducaoZ);
        DM.fCashRegister.SalesFileName := ExtractFileName(DM.SaleWritter.FileName);
      end;
    end;

    if DM.fPrintReceipt.PrintReceipt then
      begin
        with TPrintCashReg.Create(Self) do
          Start(IDCashRegLog, TICKET_CASH_OPEN);
      end;
    Hide;

    with TCashRegManager.Create(Self) do
      Start(IDCashRegMov, True);
    Close;
  end;
end;

function TFrmPaiCashRegOpen.TestaPreenchimento(grpBox : TGroupBox) : Boolean;
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

procedure TFrmPaiCashRegOpen.tmrOpenMessageTimer(Sender: TObject);
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

procedure TFrmPaiCashRegOpen.AtuTotals(Sender : TObject);
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

procedure TFrmPaiCashRegOpen.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(30);
end;

procedure TFrmPaiCashRegOpen.Edit100KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Key := ValidateNumbers(Key);
  
end;

procedure TFrmPaiCashRegOpen.cmbTotalCardKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_F2 then
     begin
       fCall := TEdit(Sender).Tag;
       btnTotalCardClick(Self);
     end;

end;

procedure TFrmPaiCashRegOpen.btnTotalCardClick(Sender: TObject);
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

procedure TFrmPaiCashRegOpen.btOpenCashClick(Sender: TObject);
begin
  inherited;
  // Abre a caixa
  DM.OpenCashRegister;

  // faz animacao de abertura de caixa
  tmrOpenMessage.Enabled:= True;
end;

procedure TFrmPaiCashRegOpen.btnSetupClick(Sender: TObject);
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

procedure TFrmPaiCashRegOpen.btnLogClick(Sender: TObject);
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

procedure TFrmPaiCashRegOpen.btnMenuFiscalClick(Sender: TObject);
begin
  inherited;
  with TFrmMenufiscal.Create(Self) do
    Start;
end;

end.
