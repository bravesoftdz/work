unit uFrmTimeControlPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, DateBox, LblEffct, PaiDeForms,
  RadioButtonAll, SuperComboADO, ppBands, ppClass, ppDB, ppDBPipe,
  daDataModule, ppModule, raCodMod, ppPrnabl, ppCtrls, ppVar, ppCache,
  ppComm, ppRelatv, ppProd, ppReport, Db, ADODB, siComp, siLangRT,
  PowerADOQuery, LookUpADOQuery;

type
  TfrmTimeControlPrint = class(TFrmParentForms)
    Label2: TLabel;
    Label3: TLabel;
    edtDateIni: TDateBox;
    edtDateFim: TDateBox;
    Panel2: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    pnlAdmUser: TPanel;
    scUser: TSuperComboADO;
    pnlSingleUser: TPanel;
    lbUserN: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    btAreaTodas: TButton;
    quTimeControl: TADODataSet;
    quTimeControlEnterDate: TDateTimeField;
    quTimeControlExitDate: TDateTimeField;
    quTimeControlPessoa: TStringField;
    quTimeControlIDUser: TIntegerField;
    quTimeControlWorkedHour: TDateTimeField;
    quTimeControlWorkMunitPay: TBCDField;
    quTimeControlWorkHourPay: TIntegerField;
    dsTimeControl: TDataSource;
    rpUserTimeClock: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppSystemVariable2: TppSystemVariable;
    ppDetailBand2: TppDetailBand;
    ppFooterBand2: TppFooterBand;
    ppUserTimeClock: TppDBPipeline;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBText1: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    quTimeControlTotalWorkHour: TFloatField;
    quTimeControlWeekDay: TStringField;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppDBText3: TppDBText;
    ppDBText2: TppDBText;
    shpLine: TppShape;
    ppSystemVariable1: TppSystemVariable;
    lbTitle: TppLabel;
    ppLabel6: TppLabel;
    lbUserPrint: TppLabel;
    ppLabel7: TppLabel;
    ppDBText8: TppDBText;
    quTimeControlStore: TStringField;
    spHelp: TSpeedButton;
    btnPrint: TBitBtn;
    btReg: TButton;
    LookUpPerson: TLookUpADOQuery;
    LookUpPersonIDPessoa: TIntegerField;
    LookUpPersonIDComissionado: TIntegerField;
    LookUpPersonPessoa: TStringField;
    LookUpPersonCode: TIntegerField;
    dsLookUpPerson: TDataSource;
    procedure btnPrintClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quTimeControlCalcFields(DataSet: TDataSet);
    procedure rpUserTimeClockPreviewFormCreate(Sender: TObject);
    procedure lbTitlePrint(Sender: TObject);
    procedure lbUserPrintPrint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //Transator
    sJob,
    sThru : String;

    iIDUser : Integer;
    sUserName : string;
  public
    { Public declarations }
    procedure Start (UserID:integer; NameUser:string);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uSqlFunctions, uDateTimeFunctions,
  uPassword, uDMGlobal;

{$R *.DFM}

procedure TfrmTimeControlPrint.Start(UserID:integer; NameUser:string);
begin
  iIDUser := UserID;
  sUserName := NameUser;

  edtDateIni.Date := Date-7;
  edtDateFim.Date := Date;

  If Password.HasFuncRight(39) then
  begin
    //has access users
    scUser.LookUpValue    := IntToStr(iIDUser);
    pnlAdmUser.Visible    := True;
    pnlSingleUser.Visible := False;
  end
  else
  begin
    //has not access users
    lbUserN.Caption       := sUserName;
    pnlAdmUser.Visible    := False;
    pnlSingleUser.Visible := True;
   end;

   ShowModal;
end;

procedure TfrmTimeControlPrint.btnPrintClick(Sender: TObject);
var
sNewWhere : String;
begin
  Screen.Cursor := crHourGlass;

  with quTimeControl do
  begin
    if Active then
       Close;

    sNewWhere := ' TC.EnterDate >= '+ QuotedStr( FormatDateTime('mm/dd/yyyy', edtDateIni.Date) ) +
                 ' AND TC.ExitDate < '+ QuotedStr( FormatDateTime('mm/dd/yyyy',(edtDateFim.Date+1)) );

    if pnlAdmUser.Visible then
       if scUser.LookUpValue <> '' then
          sNewWhere := sNewWhere + ' AND TC.IDPessoa = '+ scUser.LookUpValue;

    if pnlSingleUser.Visible then
       sNewWhere := sNewWhere + ' AND TC.IDPessoa = '+ IntToStr(iIDUser);
    CommandText := ChangeWhereClause(CommandText, sNewWhere, True);
    CommandText := ChangeSQLOrder(CommandText, ' P.Pessoa, TC.EnterDate', 0);
    Open;

    if RecordCount = 0 then
       MsgBox(MSG_CRT_NO_RECORD_REPORT, vbInformation + vbOkOnly)
    else
       rpUserTimeClock.Print;

    Close;
  end;

 Screen.Cursor := crDefault;
end;

procedure TfrmTimeControlPrint.spHelpClick(Sender: TObject);
begin
  Application.HelpContext(10002);
end;

procedure TfrmTimeControlPrint.btAreaTodasClick(Sender: TObject);
begin
  scUser.LookUpValue := '';
  scUser.Text        := '<'+btAreaTodas.Caption+'>';
end;

procedure TfrmTimeControlPrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTimeControlPrint.quTimeControlCalcFields(DataSet: TDataSet);
begin
  quTimeControlWeekDay.AsString := FormatDateTime('dddd', quTimeControlEnterDate.AsDateTime);
  quTimeControlTotalWorkHour.AsFloat := quTimeControlWorkHourPay.AsCurrency + quTimeControlWorkMunitPay.AsCurrency;
end;

procedure TfrmTimeControlPrint.rpUserTimeClockPreviewFormCreate(
  Sender: TObject);
begin
  rpUserTimeClock.PreviewForm.WindowState := WSMAXIMIZED;
end;

procedure TfrmTimeControlPrint.lbTitlePrint(Sender: TObject);
begin
  lbTitle.Caption := sJob + edtDateIni.Text + sThru + edtDateFim.Text;
end;

procedure TfrmTimeControlPrint.lbUserPrintPrint(Sender: TObject);
begin
  lbUserPrint.Caption := sUserName;
end;

procedure TfrmTimeControlPrint.FormCreate(Sender: TObject);
begin
  inherited;
  Case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sJob  := 'Job Detail by Employee for ';
      sThru := ' thru ';
    end;

    LANG_PORTUGUESE :
    begin
      sJob  := 'Hora trabalhada ordenada por empregado desde ';
      sThru := ' até ';
    end;

    LANG_SPANISH :
    begin
      sJob  := 'Hora trabajada ordenada por funcionário desde ';
      sThru := ' hasta ';
    end;
  end;
end;

end.

