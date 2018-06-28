unit uFrmPagaAgencia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, DBCtrls, DateBox, Db, DBTables, Grids,
  StdCtrls, Mask, ComCtrls, LblEffct, ExtCtrls, Buttons, Menus, ADODB,
  SuperComboADO, DBGrids, ppDB, ppDBPipe, ppModule, daDataModule, ppCtrls, ppBands,
  ppClass, ppPrnabl, ppCache, ppComm, ppRelatv, ppProd, ppReport, raCodMod,
  ppVar, siComp, siLangRT, SMDBGrid;

type
  TFrmPagaAgencia = class(TFrmParent)
    dsHistPag: TDataSource;
    quHistPag: TADOQuery;
    pnlTip: TPanel;
    lblTip: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    Panel11: TPanel;
    spCalcComiss: TADOStoredProc;
    spPayCommission: TADOStoredProc;
    Label11: TLabel;
    btPrint: TSpeedButton;
    spDelPayComiss: TADOStoredProc;
    mnuPayment: TPopupMenu;
    RestorePayment1: TMenuItem;
    pnlTroca: TPanel;
    Label23: TLabel;
    btSave: TSpeedButton;
    editNewValor: TEdit;
    btAplicar: TButton;
    btCancel: TButton;
    Label4: TLabel;
    EditValorOriginal: TEdit;
    quHistPagIDLancamento: TIntegerField;
    quHistPagIDPessoa: TIntegerField;
    quHistPagDataLancamento: TDateTimeField;
    quHistPagValorNominal: TFloatField;
    quHistPagTotalQuitado: TFloatField;
    spHelp: TSpeedButton;
    dsAgencyCommis: TDataSource;
    quAgencyCommis: TADOQuery;
    rpAgencyCommisOld: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppLabel1: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText1: TppDBText;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppDBCalc4: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    daDataModule1: TdaDataModule;
    ppAgencyCommis: TppDBPipeline;
    quAgencyCommisTipTouristGroup: TStringField;
    quAgencyCommisIDAgency: TAutoIncField;
    quAgencyCommisAgencyName: TStringField;
    quAgencyCommisIDInvoice: TIntegerField;
    quAgencyCommisFirstName: TStringField;
    quAgencyCommisLastName: TStringField;
    quAgencyCommisInvoiceDate: TDateTimeField;
    quAgencyCommisMovSale: TBCDField;
    quAgencyCommisMovCost: TBCDField;
    quAgencyCommisModel: TStringField;
    quAgencyCommisDescription: TStringField;
    quAgencyCommisMovCommission: TBCDField;
    quAgencyCommisQty: TFloatField;
    Panel5: TPanel;
    Label5: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Shape1: TShape;
    Label16: TLabel;
    Label17: TLabel;
    Label8: TLabel;
    Adjusted: TLabel;
    btPreviewCommission: TSpeedButton;
    btAddCommission: TSpeedButton;
    Panel7: TPanel;
    scAgencia: TSuperComboADO;
    editPayDate: TDateBox;
    pnlInicio: TPanel;
    Label18: TLabel;
    Label20: TLabel;
    btRefresh: TSpeedButton;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    editCommission: TEdit;
    editValor: TEdit;
    Label1: TLabel;
    sbPaymentType: TSuperComboADO;
    Label6: TLabel;
    Label7: TLabel;
    scBanckAccount: TSuperComboADO;
    Label14: TLabel;
    quHistPagUsuario: TStringField;
    rpAgencyCommis: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLine1: TppLine;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppDetailBand2: TppDetailBand;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable1: TppSystemVariable;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppDBText16: TppDBText;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppDBCalc8: TppDBCalc;
    ppDBCalc9: TppDBCalc;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppLine2: TppLine;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppDBCalc11: TppDBCalc;
    ppDBCalc12: TppDBCalc;
    raCodeModule1: TraCodeModule;
    daDataModule2: TdaDataModule;
    grdPayment: TSMDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbInicioChange(Sender: TObject);
    procedure dsHistPagDataChange(Sender: TObject; Field: TField);
    procedure btPrintClick(Sender: TObject);
    procedure RestorePayment1Click(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btAplicarClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure RecalcValue;
    procedure btRefreshClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btAddCommissionClick(Sender: TObject);
    procedure btPreviewCommissionClick(Sender: TObject);
    procedure rpAgencyCommisPreviewFormCreate(Sender: TObject);
    procedure grdPaymentDblClick(Sender: TObject);
    procedure sbPaymentTypeSelectItem(Sender: TObject);
  private
    { Private declarations }
    Divida, Commis: Currency;
    merda, Ajustou: boolean;
    OriginalTipWidth: Integer;
    Adjust, AjusteComiss : Double;
    PercAjuste : Real;
    procedure Refresh;

    procedure SPRefreshWhere(sWhere:String);
    procedure PrintAgency(iPaid:Integer);


    //HistPag
    procedure HistPagClose;
    procedure HistPagOpen;
    procedure HistPagRefresh;

  public
    { Public declarations }
  end;

implementation

uses uDM, uPassword, XBase, uPrintComissReceipt, uMsgBox, uMsgConstant,
     uNumericFunctions, uSqlFunctions, uDateTimeFunctions, uDMGlobal;

{$R *.DFM}


procedure TFrmPagaAgencia.HistPagClose;
begin
   with quHistPag do
      if Active then
         Close;
end;

procedure TFrmPagaAgencia.HistPagOpen;
begin
  with quHistPag do
     if not Active then
        begin
        Parameters.ParambyName('IDPessoa').Value := StrToInt(scAgencia.LookUpValue);
        Open;
        end;
end;

procedure TFrmPagaAgencia.HistPagRefresh;
begin
  HistPagClose;
  HistPagOpen;
end;

procedure TFrmPagaAgencia.PrintAgency(iPaid:Integer);
var
  sWhere : String;
begin

  sWhere := ' I.IDInvoice IS NOT NULL';
  sWhere := sWhere + ' AND TG.IDAgency = ' + scAgencia.LookUpValue;

  if iPaid = 0 then
     begin
     sWhere := sWhere + ' AND TG.IDLancPagAgencia IS NULL';
     sWhere := sWhere + ' AND I.InvoiceDate >=  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbInicio.Date)) );
     sWhere := sWhere + ' AND I.InvoiceDate <  ' + QuotedStr( FormatDateTime('mm/dd/yyyy',(dbFim.Date+1)) );
     end
  else
     sWhere := sWhere + ' AND TG.IDLancPagAgencia = ' + IntToStr(iPaid);


  SPRefreshWhere(sWhere);

  rpAgencyCommis.Print;

end;

procedure TFrmPagaAgencia.SPRefreshWhere(sWhere:String);
var
  sOldSQL : String;
begin
    with quAgencyCommis do
       begin
       Close;

       sOldSQL  := SQL.Text;
       SQL.Text := ChangeWhereClause(sOldSQL, sWhere, True);

       Open;
       end;
end;

procedure TFrmPagaAgencia.Refresh;
begin
  if merda then
     Abort;

  { Se uma das datas for em branco aborta}
  if scAgencia.LookUpValue = '' then
     begin
     MsgBox(MSG_INF_CHOOSE_NAME, vbOKOnly + vbInformation);
     scAgencia.SetFocus;
     Abort;
     end;

  Screen.Cursor := crHourGlass;

  //Refresh do Historio de Pagamentos
  HistPagRefresh;

  {
  Recalculo do valor da comissão
  }
  with spCalcComiss do
    begin
      Parameters.ParambyName('@IDAgency').Value    := StrToInt(scAgencia.LookUpValue);
      Parameters.ParambyName('@DataInicio').Value  := dbInicio.Date;
      Parameters.ParambyName('@DataFim').Value     := (dbFim.Date+1);
      Parameters.ParambyName('@Date').Value        := Now;
      ExecProc;

      // Inclui o Ajuste da comissao
      AjusteComiss := MyStrToFloat(DM.DescCodigo(['IDPessoa'], [scAgencia.LookUpValue], 'Pessoa', 'AjusteComiss'));

      Adjusted.Visible := (AjusteComiss <> 0);

      Commis := MyRound(Parameters.ParambyName('@Commission').Value, 2);

      if commis = 0 then
         editCommission.Text := '0.00'
      else
         editCommission.Text := MyFloatToStr(round((Commis + AjusteComiss) * 100) / 100);

//**      editCommission.Text := FloatToStrF(Commis, ffCurrency, 20, 2);

      editValor.Text := editCommission.Text;

      // ** Valor original da comissao
      editValorOriginal.Text := MyFloatToStr(round(Commis * 100) / 100);

      btAddCommission.Enabled := Commis <> 0;
      btPreviewCommission.Enabled := Commis <> 0;
    end;

  Screen.Cursor := crDefault;

end;

procedure TFrmPagaAgencia.FormShow(Sender: TObject);
var
  Day, Month, year : Word;

begin
  inherited;

  pnlInicio.Visible      := Password.HasFuncRight(23);

  Merda := True;
  DecodeDate(Date, Year, Month, Day);
  if Month = 1 then
    begin
      Month := 12;
      Year := Year - 2;
    end
  else
    begin
      Month := Month -1;
      Year := Year - 1;
    end;
  dbInicio.Date := EncodeDate(Year, Month, 1);
  dbFim.Date := Date;
  Merda := False;

  editPayDate.Date := Date;

  scAgencia.SetFocus;

  sbPaymentType.LookUpValue := '1';
  scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt('1'), DM.fStore.ID));
  
end;

procedure TFrmPagaAgencia.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPagaAgencia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  //Close HistPag
  HistPagClose;

  Action := caFree;

end;


procedure TFrmPagaAgencia.dbInicioChange(Sender: TObject);
begin
  inherited;
  if TestDate(dbInicio.Text) then
      spCalcComiss.Parameters.ParambyName('@DataInicio').Value := Int(dbInicio.Date);

  if TestDate(dbFim.Text) then
      spCalcComiss.Parameters.ParambyName('@DataFim').Value := Int(dbFim.Date) + 1;
end;


procedure TFrmPagaAgencia.dsHistPagDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btPrint.Enabled         := not (quHistPag.EOF and quHistPag.BOF);
  RestorePayment1.Enabled := btPrint.Enabled;
end;

procedure TFrmPagaAgencia.btPrintClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_CONFIRM_REPRINT, vbYesNo + vbQuestion) = vbNo then
    Exit;

  // Imprime recibo
  with TPrintComissReceipt.Create(Self) do
       Start(quHistPagIDLancamento.AsInteger, COMIS_AGENCY, True);
end;



procedure TFrmPagaAgencia.RestorePayment1Click(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_CONFIRM_RESTORE, vbYesNo + vbQuestion) = vbYes then
    begin
      Screen.Cursor := crHourGlass;

      with spDelPayComiss do
        begin
          Parameters.ParambyName('@IDAgency').Value        := StrToInt(scAgencia.LookUpValue);
          Parameters.ParambyName('@IDLancamento').Value    := quHistPagIDLancamento.AsInteger;
          ExecProc;
        end;

      Refresh;
      Screen.Cursor := crDefault;

    end;
end;


procedure TFrmPagaAgencia.Label2DblClick(Sender: TObject);
begin

  pnlTip.Width := 408;

  pnlTroca.Visible := True;

  editNewValor.text := MyFloatToStr(MyStrToFloat(editValor.text));
  editNewValor.SetFocus;
end;

procedure TFrmPagaAgencia.FormCreate(Sender: TObject);
begin
  inherited;
  OriginalTipWidth := pnlTip.Width;

  if fIsRestricForm then
     begin
     btAddCommission.Visible := False;
     RestorePayment1.Enabled := False;
     end;

end;

procedure TFrmPagaAgencia.btCancelClick(Sender: TObject);
begin
  inherited;
  pnlTip.Width := OriginalTipWidth;
end;

procedure TFrmPagaAgencia.btAplicarClick(Sender: TObject);
begin
  inherited;

  btSaveClick(nil);

  if Ajustou then
     begin
       editCommission.text := MyFloatToStr(MyStrToFloat(editNewValor.text));

       RecalcValue;

       pnlTip.Width := OriginalTipWidth;
     end;
end;

procedure TFrmPagaAgencia.btSaveClick(Sender: TObject);
begin
  inherited;

  Adjust := MyRound(MyStrToFloat(editNewValor.Text)-MyStrToFloat(editCommission.Text), 2);

  if (MsgBox(MSG_QST_PART1_CONFIRM_ADJST + MyFloatToStr(Adjust) + MSG_QST_PART2_CONFIRM_ADJST,
     vbYesNo + vbQuestion) = vbYes) then
     begin
       with DM.quFreeSQL do
            begin
              SQL.Text := 'UPDATE Pessoa SET AjusteComiss = ' +
                           MyFloatToStr(Adjust + AjusteComiss) + // acumula o ajuste
                          'WHERE IDPessoa = ' + scAgencia.LookUpValue;
              ExecSQL;
            end;
       Ajustou := True;
     end
  else
    Ajustou := False;
end;

procedure TFrmPagaAgencia.RecalcValue;
begin
  editValor.Text := editCommission.Text;
end;


procedure TFrmPagaAgencia.btRefreshClick(Sender: TObject);
begin
  inherited;
 if TestDate(dbFim.Text) and TestDate(dbInicio.Text) then
    Refresh;
end;

procedure TFrmPagaAgencia.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1900);
end;

procedure TFrmPagaAgencia.btAddCommissionClick(Sender: TObject);
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

  Screen.Cursor := crHourGlass;

  if MsgBox(MSG_QST_CONFIRM_PAYMENT, vbYesNo + vbQuestion) = vbYes then
     begin
       //** Ajusta os valores para armazenar no GroupCost com o novo valor
       PercAjuste := StrToFloat (editValor.text) / Commis;

       with spPayCommission do
            begin
              Parameters.ParambyName('@IDAgency').Value        := StrToInt(scAgencia.LookUpValue);
              Parameters.ParambyName('@IDStore').Value         := DM.fStore.ID;
              Parameters.ParambyName('@IDMeioPag').Value       := MyStrToInt(sbPaymentType.LookUpValue);
              Parameters.ParambyName('@IDContaCorrente').Value := MyStrToInt(scBanckAccount.LookUpValue);
              Parameters.ParambyName('@PayDate').Value         := editPayDate.Date;
              Parameters.ParambyName('@Commission').Value      := MyValor;
              Parameters.ParambyName('@Adjust').Value          := PercAjuste;
              Parameters.ParambyName('@DataIni').Value         := spCalcComiss.Parameters.ParambyName('@DataInicio').Value;
              Parameters.ParambyName('@DataFim').Value         := spCalcComiss.Parameters.ParambyName('@DataFim').Value;
              Parameters.ParambyName('@IDUser').Value          := DM.fUser.ID;
              ExecProc;
              MsgBox(MSG_INF_PART1_COMMISS_PAIED + editValor.text + MSG_INF_PART2_COMMISS_PAIED, vbOKOnly + vbInformation);
            end;

       // Faz o ajuste da comissao
       with DM.quFreeSQL do
            begin
              SQL.Text := 'UPDATE Pessoa SET AjusteComiss = ' + MyFloatToStr (Adjust + AjusteComiss) +
                          'WHERE IDPessoa = ' + scAgencia.LookUpValue;
              ExecSQL;
            end;

       Refresh;
       Update;

       // Imprime recibo
       with TPrintComissReceipt.Create(Self) do
            Start(spPayCommission.Parameters.ParambyName('@IDLancamento').Value, COMIS_AGENCY, False);
     end;
  Screen.Cursor := crDefault;
end;

procedure TFrmPagaAgencia.btPreviewCommissionClick(Sender: TObject);
begin
  inherited;

   PrintAgency(0);

end;

procedure TFrmPagaAgencia.rpAgencyCommisPreviewFormCreate(Sender: TObject);
begin
  inherited;

  rpAgencyCommis.PreviewForm.WindowState := WSMAXIMIZED;

end;

procedure TFrmPagaAgencia.grdPaymentDblClick(Sender: TObject);
begin
  inherited;

  with quHistPag do
    begin
      if not (EOF and BOF) then
        begin
          PrintAgency(quHistPagIDLancamento.AsInteger);
        end;
    end;


end;

procedure TFrmPagaAgencia.sbPaymentTypeSelectItem(Sender: TObject);
begin
  inherited;

  if sbPaymentType.LookUpValue <> '' then
     scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt(sbPaymentType.LookUpValue), DM.fStore.ID));

end;

end.
