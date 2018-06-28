unit uFrmPagaOther;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, DBCtrls, DateBox, Db, DBTables, Grids,
  StdCtrls, Mask, ComCtrls, LblEffct, ExtCtrls, Buttons,
  ADODB, SuperComboADO, ppDB, ppDBPipe, daDataModule, ppModule, raCodMod, ppCtrls,
  ppBands, ppClass, ppVar, ppPrnabl, ppCache, ppComm, ppRelatv, ppProd,
  ppReport, siComp, siLangRT, DBGrids, SMDBGrid;

type
  TFrmPagaOther = class(TFrmParent)
    dsHistPag: TDataSource;
    quHistPag: TADOQuery;
    Panel10: TPanel;
    Image6: TImage;
    Image7: TImage;
    lblTip: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    Panel11: TPanel;
    spPayCommission: TADOStoredProc;
    Label11: TLabel;
    spCalcComiss: TADOStoredProc;
    btPrint: TSpeedButton;
    spHelp: TSpeedButton;
    Panel5: TPanel;
    Label4: TLabel;
    Label20: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    btPreviewCommission: TSpeedButton;
    btAddCommission: TSpeedButton;
    pnlInicio: TPanel;
    Panel6: TPanel;
    sbPaymentType: TSuperComboADO;
    scBanckAccount: TSuperComboADO;
    scPessoa: TSuperComboADO;
    editPayDate: TDateBox;
    Label18: TLabel;
    dbInicio: TDateBox;
    Label2: TLabel;
    dbFim: TDateBox;
    btRefresh: TSpeedButton;
    Label7: TLabel;
    editCommission: TEdit;
    Label19: TLabel;
    Label5: TLabel;
    editExtorno: TEdit;
    Label9: TLabel;
    Label21: TLabel;
    editCorrecao: TEdit;
    Label23: TLabel;
    Shape2: TShape;
    Label6: TLabel;
    editValor: TEdit;
    Label22: TLabel;
    quHistPagIDLancamento: TAutoIncField;
    quHistPagDataLancamento: TDateTimeField;
    quHistPagValorNominal: TBCDField;
    quHistPagUsuario: TStringField;
    rpOtherCommis: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel9: TppLabel;
    ppLabel8: TppLabel;
    ppLabel1: TppLabel;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel10: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppDetailBand1: TppDetailBand;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText1: TppDBText;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLine2: TppLine;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppOtherCommis: TppDBPipeline;
    quOtherCommis: TADOQuery;
    dsOtherCommis: TDataSource;
    quOtherCommisIDInvoice: TIntegerField;
    quOtherCommisFirstName: TStringField;
    quOtherCommisLastName: TStringField;
    quOtherCommisOthers: TStringField;
    quOtherCommisInvoiceDate: TDateTimeField;
    quOtherCommisMovSale: TBCDField;
    quOtherCommisMovCost: TBCDField;
    quOtherCommisModel: TStringField;
    quOtherCommisDescription: TStringField;
    quOtherCommisMovCommission: TBCDField;
    grdPayment: TSMDBGrid;
    quOtherCommisQty: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btRefreshClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdPaymentDblClick(Sender: TObject);
    procedure btAddCommissionClick(Sender: TObject);
    procedure btPreviewCommissionClick(Sender: TObject);
    procedure rpOtherCommisPreviewFormCreate(Sender: TObject);
    procedure sbPaymentTypeSelectItem(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Extorno, Correcao, Commis, Valor : Currency;
    Inside : Boolean;
    Merda : Boolean;
    procedure Refresh;

    procedure HistPagClose;
    procedure HistPagOpen;
    procedure HistPagRefresh;

    procedure OthersRefreshWhere(sWhere:String);
    procedure PrintOthers(iPaid:Integer);

  public
    { Public declarations }
  end;

implementation

uses uDM, XBase, uPrintComissReceipt, uMsgBox, uMsgConstant,
     uNumericFunctions, uSqlFunctions, uDateTimeFunctions, uDMGlobal;

{$R *.DFM}

procedure TFrmPagaOther.OthersRefreshWhere(sWhere:String);
var
  sOldSQL : String;
begin
    with quOtherCommis do
       begin
       Close;

       sOldSQL  := SQL.Text;
       SQL.Text := ChangeWhereClause(sOldSQL, sWhere, True);

       Open;
       end;
end;

procedure TFrmPagaOther.PrintOthers(iPaid:Integer);
var
  sWhere : String;
begin

  sWhere := ' I.IDInvoice IS NOT NULL';
  sWhere := sWhere + ' AND I.OtherComissionID = ' + scPessoa.LookUpValue;

  if iPaid = 0 then
     begin
     sWhere := sWhere + ' AND I.IDLancPagOtherCom IS NULL';
     sWhere := sWhere + ' AND I.InvoiceDate >=  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbInicio.Date)) );
     sWhere := sWhere + ' AND I.InvoiceDate <  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbFim.Date+1)) );
     end
  else
     sWhere := sWhere + ' AND I.IDLancPagOtherCom = ' + IntToStr(iPaid);


  OthersRefreshWhere(sWhere);

  rpOtherCommis.Print;

end;

procedure TFrmPagaOther.HistPagClose;
begin
  with quHistPag do
     if Active then
        Close;
end;

procedure TFrmPagaOther.HistPagOpen;
begin
   with quHistPag do
     if not Active then
        begin
        Parameters.ParambyName('IDPessoa').Value := StrToInt(scPessoa.LookUpValue);
        Open;
        end;
end;



procedure TFrmPagaOther.HistPagRefresh;
begin
   HistPagClose;
   HistPagOpen;
end;


procedure TFrmPagaOther.Refresh;
begin
  if merda then
     abort;

  //Se uma das datas for em branco aborta
   if scPessoa.LookUpValue = '' then
      begin
      MsgBox(MSG_INF_CHOOSE_NAME, vbOKOnly + vbInformation);
      scPessoa.SetFocus;
      Abort;
      end;


  Screen.Cursor := crHourGlass;

  //Refresh do Historio de Pagamentos
  HistPagRefresh;

 //Recalculo do valor da comissão
  with spCalcComiss do
    begin
      Parameters.ParambyName('@IDOtherComission').Value := StrToInt(scPessoa.LookUpValue);

      Parameters.ParambyName('@DataInicio').Value := dbInicio.Date;

      Parameters.ParambyName('@DataFim').Value := dbFim.Date+1;
      ExecProc;

      Commis := Parameters.ParambyName('@Commission').Value;
      Extorno := Parameters.ParambyName('@Extorno').Value;
      Correcao := Parameters.ParambyName('@Correcao').Value;

      Valor := MyRound(Commis - Extorno + Correcao, 2);

      editCommission.Text := FloatToStrF(Commis, ffCurrency, 20, 2);
      editExtorno.Text := FloatToStrF(Extorno, ffCurrency, 20, 2);
      editCorrecao.Text := FloatToStrF(Correcao, ffCurrency, 20, 2);

      editValor.Text := MyFloatToStr(valor);
    end;

  btPreviewCommission.Enabled := Valor <> 0;
  btAddCommission.Enabled     := Valor <> 0;

  Screen.Cursor := crDefault;

end;

procedure TFrmPagaOther.FormShow(Sender: TObject);
var
  Day, Month, year : Word;

begin
  inherited;

  Merda := True;

  DecodeDate(Date, Year, Month, Day);

  dbFim.Date := EncodeDate(Year, Month, 1) - 1;

  if Month = 1 then
    begin
      Month := 12;
      Year := Year - 1;
    end
  else
    begin
      Month := Month - 1;
    end;
  dbInicio.Date := EncodeDate(Year, Month, 1);

  editPayDate.Date := Date;

  Merda := False;

  sbPaymentType.LookUpValue  := '1';
  scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt('1'), DM.fStore.ID));

end;

procedure TFrmPagaOther.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPagaOther.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  HistPagClose;
  Action := caFree;
end;

procedure TFrmPagaOther.btRefreshClick(Sender: TObject);
begin
  inherited;
 if TestDate(dbFim.Text) or TestDate(dbInicio.Text) then
    Refresh;
end;

procedure TFrmPagaOther.btPrintClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_CONFIRM_REPRINT, vbYesNo + vbQuestion) = vbNo then
    Exit;

  // Imprime recibo
  with TPrintComissReceipt.Create(Self) do
       Start(quHistPagIDLancamento.AsInteger, COMIS_OTHER, True);

end;

procedure TFrmPagaOther.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1910);
end;

procedure TFrmPagaOther.grdPaymentDblClick(Sender: TObject);
begin
  inherited;

  with quHistPag do
      if not (EOF and BOF) then
        PrintOthers(quHistPagIDLancamento.AsInteger);
        
end;

procedure TFrmPagaOther.btAddCommissionClick(Sender: TObject);
var
   MyValor: Double;
begin
  inherited;
  MyValor := MyStrToFloat(editValor.Text);

  if MyRound(MyValor, 2) = 0 then
    begin
     MsgBox(MSG_INF_NOT_EMPTY_VALUES, vbOKOnly + vbInformation);
     Exit;
    end;

  if sbPaymentType.LookUpValue = '' then
     begin
     MsgBox(MSG_INF_CHOOSE_PAYTYPE, vbOKOnly + vbInformation);
     sbPaymentType.SetFocus;
     Exit;
     end;

  if scBanckAccount.LookUpValue = '' then
     begin
     MsgBox(MSG_INF_CHOOSE_BANK, vbOKOnly + vbInformation);
     scBanckAccount.SetFocus;
     Exit;
     end;


  if MsgBox(MSG_QST_CONFIRM_PAYMENT, vbYesNo + vbQuestion) = vbNo then
    Exit;

  Screen.Cursor := crHourGlass;

  with spPayCommission do
    begin
      Parameters.ParambyName('@IDOtherComission').Value := StrToInt(scPessoa.LookUpValue);
      Parameters.ParambyName('@IDStore').Value          := DM.fStore.ID;
      Parameters.ParambyName('@IDMeioPag').Value        := MyStrToInt(sbPaymentType.LookUpValue);
      Parameters.ParambyName('@IDContaCorrente').Value  := MyStrToInt(scBanckAccount.LookUpValue);
      Parameters.ParambyName('@PayDate').Value          := editPayDate.Date;
      Parameters.ParambyName('@Commission').Value       := MyValor;
      Parameters.ParambyName('@DataIni').Value          := spCalcComiss.Parameters.ParambyName('@DataInicio').Value;
      Parameters.ParambyName('@DataFim').Value          := spCalcComiss.Parameters.ParambyName('@DataFim').Value;
      Parameters.ParambyName('@IDUser').Value           := DM.fUser.ID;
      ExecProc;
    end;

  Screen.Cursor := crDefault;

  MsgBox(MSG_INF_PART1_COMMISS_PAIED + editValor.text + MSG_INF_PART2_COMMISS_PAIED, vbOKOnly + vbInformation);

  Refresh;

  // Imprime recibo
  with TPrintComissReceipt.Create(Self) do
       Start(spPayCommission.Parameters.ParambyName('@IDLancamento').Value, COMIS_OTHER, False);
end;

procedure TFrmPagaOther.btPreviewCommissionClick(Sender: TObject);
begin
  inherited;

  PrintOthers(0);

end;

procedure TFrmPagaOther.rpOtherCommisPreviewFormCreate(Sender: TObject);
begin
  inherited;

  rpOtherCommis.PreviewForm.WindowState := WSMAXIMIZED;

end;

procedure TFrmPagaOther.sbPaymentTypeSelectItem(Sender: TObject);
begin
  inherited;

  if sbPaymentType.LookUpValue <> '' then
     scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt(sbPaymentType.LookUpValue), DM.fStore.ID));
  
end;

procedure TFrmPagaOther.FormCreate(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
     begin
     btAddCommission.Visible := False;
     end;
end;

end.
