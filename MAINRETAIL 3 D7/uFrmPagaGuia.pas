unit uFrmPagaGuia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, DBCtrls, DateBox, Db, DBTables, Grids, Variants,
  StdCtrls, Mask, ComCtrls, LblEffct, ExtCtrls, Buttons,
  Menus, ADODB, SuperComboADO, RCADOQuery, PowerADOQuery, LookUpADOQuery,
  ppModule, daDataModule, ppCtrls, ppBands, ppClass, ppPrnabl, ppCache, ppProd,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, DBGrids, raCodMod, ppVar,
  siComp, siLangRT, SMDBGrid;

type
  TFrmPagaGuia = class(TFrmParent)
    dsHistPagGuia: TDataSource;
    quHistPagGuia: TADOQuery;
    pnlTip: TPanel;
    lblTip: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    spPayCommission: TADOStoredProc;
    Label11: TLabel;
    spCalcComiss: TADOStoredProc;
    btPrint: TSpeedButton;
    pnlTroca: TPanel;
    Label23: TLabel;
    editNewValor: TEdit;
    btAplicar: TButton;
    btCancel: TButton;
    btSave: TSpeedButton;
    btStatment: TSpeedButton;
    mnuReceipt: TPopupMenu;
    DetailedStatement1: TMenuItem;
    N1: TMenuItem;
    RestorePayments: TMenuItem;
    spDelPayComiss: TADOStoredProc;
    Label4: TLabel;
    EditValorOriginal: TEdit;
    quHistPagGuiaIDLancamento: TIntegerField;
    quHistPagGuiaIDPessoa: TIntegerField;
    quHistPagGuiaDataLancamento: TDateTimeField;
    quHistPagGuiaTotalQuitado: TFloatField;
    spHelp: TSpeedButton;
    quAgentCommis: TADOQuery;
    dsAgentCommis: TDataSource;
    ppAgentCommis: TppDBPipeline;
    rpAgentCommis: TppReport;
    Panel5: TPanel;
    Label1: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label19: TLabel;
    Shape2: TShape;
    Label22: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label21: TLabel;
    scGuide: TSuperComboADO;
    editPayDate: TDateBox;
    editCommission: TEdit;
    editValor: TEdit;
    editAmortizacao: TEdit;
    pnlInicio: TPanel;
    Label18: TLabel;
    Label20: TLabel;
    btRefresh: TSpeedButton;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    editDivida: TEdit;
    Adjusted: TLabel;
    Panel11: TPanel;
    Panel6: TPanel;
    btPreviewCommission: TSpeedButton;
    btAddCommission: TSpeedButton;
    ppHeaderBand1: TppHeaderBand;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel9: TppLabel;
    ppLabel8: TppLabel;
    ppLabel1: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppFooterBand1: TppFooterBand;
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
    daDataModule1: TdaDataModule;
    raCodeModule1: TraCodeModule;
    ppLine1: TppLine;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel10: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable2: TppSystemVariable;
    Label5: TLabel;
    sbPaymentType: TSuperComboADO;
    Label12: TLabel;
    Label13: TLabel;
    scBanckAccount: TSuperComboADO;
    Label14: TLabel;
    quHistPagGuiaUsuario: TStringField;
    grdPayment: TSMDBGrid;
    quGuiaPayAll: TADOQuery;
    quGuiaPayAllTipTouristGroup: TStringField;
    quGuiaPayAllIDAgent: TIntegerField;
    quGuiaPayAllAgentName: TStringField;
    quGuiaPayAllIDInvoice: TStringField;
    quGuiaPayAllFirstName: TStringField;
    quGuiaPayAllLastName: TStringField;
    quGuiaPayAllInvoiceDate: TDateTimeField;
    quGuiaPayAllMovSale: TBCDField;
    quGuiaPayAllMovCost: TBCDField;
    quGuiaPayAllModel: TStringField;
    quGuiaPayAllDescription: TStringField;
    quGuiaPayAllMovCommission: TBCDField;
    quGuiaPayAllQty: TBCDField;
    quAgentCommisTipTouristGroup: TStringField;
    quAgentCommisIDAgent: TIntegerField;
    quAgentCommisAgentName: TStringField;
    quAgentCommisIDInvoice: TStringField;
    quAgentCommisFirstName: TStringField;
    quAgentCommisLastName: TStringField;
    quAgentCommisInvoiceDate: TDateTimeField;
    quAgentCommisMovSale: TBCDField;
    quAgentCommisMovCost: TBCDField;
    quAgentCommisModel: TStringField;
    quAgentCommisDescription: TStringField;
    quAgentCommisMovCommission: TBCDField;
    quAgentCommisQty: TBCDField;
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btPrintClick(Sender: TObject);
    procedure dbInicioChange(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure btAplicarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure editAmortizacaoChange(Sender: TObject);
    procedure RecalcValue;
    procedure btStatmentClick(Sender: TObject);
    procedure DetailedStatement1Click(Sender: TObject);
    procedure dsHistPagGuiaDataChange(Sender: TObject; Field: TField);
    procedure RestorePaymentsClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdPaymentDblClick(Sender: TObject);
    procedure btAddCommissionClick(Sender: TObject);
    procedure rpAgentCommisPreviewFormCreate(Sender: TObject);
    procedure btPreviewCommissionClick(Sender: TObject);
    procedure sbPaymentTypeSelectItem(Sender: TObject);
  private
    { Private declarations }
    AjusteComiss, Divida, Commis, Valor : Currency;
    Inside, IsrbAllClicked : Boolean;
    Merda, Ajustou  : Boolean;
    OriginalTipWidth: Integer;
    PercAjuste : Real;
    bIsOffice: Boolean;
    
    procedure RefreshCalcComiss;
    procedure Refresh;

    procedure SPRefreshWhere(sWhere:String);
    procedure PrintAgent(iPaid:Integer);

    procedure HistPagGuiaClose;
    procedure HistPagGuiaOpen;
    procedure HistPagGuiaRefresh;

  public
    { Public declarations }
  end;

implementation

uses uDM, uPassword, XBase, uPrintGuideReceipt{, uRptGuideStatement}, uMsgBox,
     uMsgConstant, uNumericFunctions, uSqlFunctions, uDateTimeFunctions,
     uDMGlobal, uSystemConst;

{$R *.DFM}

var
  Adjust: Double;


procedure TFrmPagaGuia.HistPagGuiaClose;
begin

   with quHistPagGuia do
      if Active then
         Close;

end;

procedure TFrmPagaGuia.HistPagGuiaOpen;
begin

  with quHistPagGuia do
     if not Active then
        begin
        Parameters.ParambyName('IDGuide').Value := MyStrToInt(scGuide.LookUpValue);
        Open;
        end;

end;

procedure TFrmPagaGuia.HistPagGuiaRefresh;
begin

  HistPagGuiaClose;
  HistPagGuiaOpen;

end;


procedure TFrmPagaGuia.PrintAgent(iPaid:Integer);
var
  sWhere : String;
begin

  if not bIsOffice then
  begin
    sWhere := ' I.IDInvoice IS NOT NULL';
    sWhere := sWhere + ' AND TG.IDGuide = ' + scGuide.LookUpValue;

    if iPaid = 0 then
       begin
       sWhere := sWhere + ' AND TG.IDLancPagGuia IS NULL';
       sWhere := sWhere + ' AND I.InvoiceDate >=  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbInicio.Date)) );
       sWhere := sWhere + ' AND I.InvoiceDate <  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbFim.Date+1)) );
       end
    else
       sWhere := sWhere + ' AND TG.IDLancPagGuia = ' + IntToStr(iPaid);
  end
  else
  begin
    sWhere := ' TG.IDGuide = ' + scGuide.LookUpValue;

    if iPaid = 0 then
       begin
       sWhere := sWhere + ' AND TG.IDLancPagGuia IS NULL';
       sWhere := sWhere + ' AND I.PreSaleDate >=  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbInicio.Date)) );
       sWhere := sWhere + ' AND I.PreSaleDate <  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbFim.Date+1)) );
       end
    else
       sWhere := sWhere + ' AND TG.IDLancPagGuia = ' + IntToStr(iPaid);
  end;


  SPRefreshWhere(sWhere);

  rpAgentCommis.Print;

end;

procedure TFrmPagaGuia.SPRefreshWhere(sWhere:String);
var
  sOldSQL : String;
begin

  with TADOQuery(dsAgentCommis.DataSet) do
  begin
    Close;

    sOldSQL  := SQL.Text;
    SQL.Clear;
    SQL.Text := ChangeWhereClause(sOldSQL, sWhere, True);
    Open;
  end;

end;


procedure TFrmPagaGuia.Refresh;
begin

  if merda then
    abort;

    { Se uma das datas for em branco aborta}
  if Trim(scGuide.Text) = '' then
     begin
     MsgBox(MSG_INF_CHOOSE_NAME, vbOKOnly + vbInformation);
     scGuide.SetFocus;
     Abort;
     end;

  Screen.Cursor := crHourGlass;

  //Refresh do Historio de Pagamentos
  HistPagGuiaRefresh;

  try
    IsrbAllClicked := False;
  finally
    IsrbAllClicked := True;
  end;



  {
  Recalculo do valor da comissão
  }
  with spCalcComiss do
    begin
      Parameters.ParambyName('@IDGuide').Value        := MyStrToInt(scGuide.LookUpValue);
      Parameters.ParambyName('@Date').Value           := Now;
      Parameters.ParambyName('@DataInicio').Value     := dbInicio.Date;
      Parameters.ParambyName('@DataFim').Value        := (dbFim.Date+1);
      Parameters.ParambyName('@IsPre').Value          := bIsOffice;
      Parameters.ParambyName('@IDTouristGroup').Value := Null;
    end;

  RefreshCalcComiss;

  Screen.Cursor := crDefault;
end;

procedure TFrmPagaGuia.FormShow(Sender: TObject);
begin
  inherited;

  pnlInicio.Visible := Password.HasFuncRight(22);

  Merda := True;

  dbInicio.Date := FirstDateMonth;
  dbFim.Date := LastDateMonth;

  Merda := False;

  editPayDate.Date := Now();

  sbPaymentType.LookUpValue := '1';

  scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt('1'), DM.fStore.ID));

  bIsOffice := not DM.fSystem.SrvParam[PARAM_CALC_COMMISSION_ON_INVOICE];

  if bIsOffice then
    dsAgentCommis.DataSet := quGuiaPayAll
  else
    dsAgentCommis.DataSet := quAgentCommis;


end;

procedure TFrmPagaGuia.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPagaGuia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  HistPagGuiaClose;

  Action := caFree;
end;

procedure TFrmPagaGuia.btPrintClick(Sender: TObject);
var
   Detail: Boolean;
begin
  inherited;
  // Imprime recibo
  with quHistPagGuia do
    begin
      if not (EOF and BOF) then
        begin
          with TPrintGuideReceipt.Create(Self) do
             Start(quHistPagGuiaIDLancamento.AsInteger, True);
        end;
    end;
end;

procedure TFrmPagaGuia.dbInicioChange(Sender: TObject);
begin
  inherited;

  if TestDate(dbInicio.Text) then
    begin
      spCalcComiss.Parameters.ParambyName('@DataInicio').Value := Int(dbInicio.Date);
    end;

  if TestDate(dbFim.Text) then
    begin
      spCalcComiss.Parameters.ParambyName('@DataFim').Value := Int(dbFim.Date) + 1;
    end;
end;

procedure TFrmPagaGuia.btSaveClick(Sender: TObject);
begin
  inherited;
  Adjust := MyRound(MyStrToFloat(editNewValor.Text)-MyStrToFloat(editCommission.Text), 2);

  if (MsgBox(MSG_QST_PART1_CONFIRM_ADJST + MyFloatToStr(Adjust) + MSG_QST_PART2_CONFIRM_ADJST,
     vbYesNo + vbQuestion) = vbYes) then
    begin
      with DM.quFreeSQL do
        begin
          SQL.Text := 'UPDATE Pessoa SET AjusteComiss = ' +
                       MyFloatToStr(Adjust  + AjusteComiss) +
                      'WHERE IDPessoa = ' + scGuide.LookUpValue;
          ExecSQL;
        end;

      editCommission.text := MyFloatToStr(MyStrToFloat(editNewValor.text));

      Ajustou := True;
    end
  else
    Ajustou := False;
end;

procedure TFrmPagaGuia.Label2DblClick(Sender: TObject);
begin
  inherited;


  pnlTip.Width := 421;

  pnlTroca.Visible := True;

  editNewValor.text := MyFloatToStr(MyStrToFloat(editValor.text));
  editNewValor.SetFocus;
end;

procedure TFrmPagaGuia.btAplicarClick(Sender: TObject);
begin
  inherited;

  btSaveClick(nil);

  if Ajustou then
     begin
       RecalcValue;
       pnlTip.Width := OriginalTipWidth;
     end;
end;

procedure TFrmPagaGuia.FormCreate(Sender: TObject);
begin
  inherited;
  IsrbAllClicked := True;
  OriginalTipWidth := pnlTip.Width;

  if fIsRestricForm then
     begin
     btAddCommission.Visible := False;
     end;

end;

procedure TFrmPagaGuia.btCancelClick(Sender: TObject);
begin
  inherited;

  pnlTip.Width := OriginalTipWidth;

end;

procedure TFrmPagaGuia.editAmortizacaoChange(Sender: TObject);
begin
  inherited;
  RecalcValue;
end;

procedure TFrmPagaGuia.RecalcValue;
var
   x: Currency;

begin
  X := MyRound(MyStrToFloat(editCommission.Text) -
               MyStrToFloat(editAmortizacao.Text), 2);

  editValor.Text := MyFloatToStr(X)
end;

procedure TFrmPagaGuia.btStatmentClick(Sender: TObject);
begin
{
   if MsgBox(MSG_QST_PRINT_STATEMENT, vbYesNo + vbQuestion) = vbYes then
     begin
       with TRptGuideStatement.Create(Self) do
         begin
           Start(quHistPagGuiaIDLancamento.AsInteger, False);
           Preview;
           Free;
         end;
     end;
 }    
end;

procedure TFrmPagaGuia.DetailedStatement1Click(Sender: TObject);
begin
  inherited;
{
   if MsgBox(MSG_QST_PRINT_STATEMENT_DET, vbYesNo + vbQuestion) = vbYes then
     begin
       with TRptGuideStatement.Create(Self) do
         begin
           Start(quHistPagGuiaIDLancamento.AsInteger, True);
           Preview;
           Free;
         end;
     end;
   }
end;

procedure TFrmPagaGuia.dsHistPagGuiaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btPrint.Enabled            := not (quHistPagGuia.EOF and quHistPagGuia.BOF);
  btStatment.Enabled         := btPrint.Enabled;
  RestorePayments.Enabled    := btPrint.Enabled;
  DetailedStatement1.Enabled := btPrint.Enabled;
end;

procedure TFrmPagaGuia.RefreshCalcComiss;
begin

  Screen.Cursor := crHourGlass;

  with spCalcComiss do
    begin
      ExecProc;

      // Inclui o Ajuste da comissao
      AjusteComiss := MyStrToFloat(DM.DescCodigo(['IDPessoa'], [scGuide.LookUpValue], 'Pessoa', 'AjusteComiss'));

      Adjusted.Visible := (AjusteComiss <> 0);

      Commis := MyRound(Parameters.ParambyName('@Commission').Value, 2);
      Divida := Parameters.ParambyName('@Divida').Value;

      if commis = 0 then
         editCommission.Text := '0.00'
      else
         editCommission.Text := MyFloatToStr(round((Commis + AjusteComiss) * 100) / 100);

      // ** Valor original da comissao
      editValorOriginal.Text := MyFloatToStr(round(Commis * 100) / 100);

      editDivida.Text     := MyFloatToStr(round(Divida * 100) / 100);

      RecalcValue;
      btAddCommission.Enabled := Commis <> 0;
      btPreviewCommission.Enabled := Commis <> 0;
    end;

  Screen.Cursor := crDefault;

end;

procedure TFrmPagaGuia.RestorePaymentsClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_CONFIRM_RESTORE, vbYesNo + vbQuestion) = vbYes then
    begin
      Adjust := 0; // ** para que no próximo pagamento não acumule o ajuste sem
                   // ** que o usuário determine

      with spDelPayComiss do
        begin
          Parameters.ParambyName('@IDGuide').Value         := StrToInt(scGuide.LookUpValue);
          Parameters.ParambyName('@IDLancamento').Value    := quHistPagGuiaIDLancamento.AsInteger;
          ExecProc;
        end;

      Refresh;
    end;
end;

procedure TFrmPagaGuia.btRefreshClick(Sender: TObject);
begin
  inherited;
 if TestDate(dbFim.Text) and TestDate(dbInicio.Text) then
    Refresh;
end;

procedure TFrmPagaGuia.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1890);
end;

procedure TFrmPagaGuia.grdPaymentDblClick(Sender: TObject);
begin
  inherited;
  with quHistPagGuia do
    begin
      if not (EOF and BOF) then
          PrintAgent(quHistPagGuiaIDLancamento.AsInteger);
    end;
end;

procedure TFrmPagaGuia.btAddCommissionClick(Sender: TObject);
var
   MyValor, MyAmo: Double;
begin
  inherited;

  MyValor := MyStrToFloat(editValor.text);

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

  if MsgBox(MSG_QST_CONFIRM_PAYMENT, vbYesNo + vbQuestion) = vbYes then
     begin
       //** Ajusta os valores para armazenar no GroupCost com o novo valor
       PercAjuste := StrToFloat (editValor.text) / Commis;

       Screen.Cursor := crHourGlass;

       with spPayCommission do
            begin
              Parameters.ParambyName('@IDGuide').Value         := StrToInt(scGuide.LookUpValue);
              Parameters.ParambyName('@IDStore').Value         := DM.fStore.ID;
              Parameters.ParambyName('@IDMeioPag').Value       := MyStrToInt(sbPaymentType.LookUpValue);
              Parameters.ParambyName('@IDContaCorrente').Value := MyStrToInt(scBanckAccount.LookUpValue);
              Parameters.ParambyName('@PayDate').Value         := editPayDate.Date;
              Parameters.ParambyName('@Commission').Value      := MyStrToFloat(editValor.text);
              Parameters.ParambyName('@Adjust').Value          := PercAjuste;
              Parameters.ParambyName('@DataIni').Value         := spCalcComiss.Parameters.ParambyName('@DataInicio').Value;
              Parameters.ParambyName('@DataFim').Value         := spCalcComiss.Parameters.ParambyName('@DataFim').Value;
              Parameters.ParambyName('@IDUser').Value          := DM.fUser.ID;
              Parameters.ParambyName('@Date').Value            := Now;
              Parameters.ParambyName('@IDTouristGroup').Value  := spCalcComiss.Parameters.ParambyName('@IDTouristGroup').Value;
              ExecProc;
            end;

       MsgBox(MSG_INF_PART1_COMMISS_PAIED + editValor.text + MSG_INF_PART2_COMMISS_PAIED, vbOKOnly + vbInformation);

       // Faz o ajuste da comissao
       with DM.quFreeSQL do
            begin
              SQL.Text := 'UPDATE Pessoa SET AjusteComiss = ' + MyFloatToStr (Adjust + AjusteComiss) +
                          'WHERE IDPessoa = ' + scGuide.LookUpValue;
              ExecSQL;
            end;

       Refresh;
       Update;

       // Imprime recibo
       with TPrintGuideReceipt.Create(Self) do
            Start(spPayCommission.Parameters.ParambyName('@IDLancamento').Value, False);
     end;

     Screen.Cursor := crDefault;

end;

procedure TFrmPagaGuia.rpAgentCommisPreviewFormCreate(Sender: TObject);
begin
  inherited;

  rpAgentCommis.PreviewForm.WindowState := WSMAXIMIZED;

end;

procedure TFrmPagaGuia.btPreviewCommissionClick(Sender: TObject);
begin
  inherited;

  PrintAgent(0);

end;

procedure TFrmPagaGuia.sbPaymentTypeSelectItem(Sender: TObject);
begin
  inherited;

  if sbPaymentType.LookUpValue <> '' then
     scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt(sbPaymentType.LookUpValue), DM.fStore.ID));

end;

end.
