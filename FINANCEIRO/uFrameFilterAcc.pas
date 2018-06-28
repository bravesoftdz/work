unit uFrameFilterAcc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, StdCtrls, Buttons, Mask, SuperComboADO, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, siComp, siLangRT;

type
  TFrameFilterAcc = class(TFrame)
    quTempTable: TADOCommand;
    dateIni: TdxDateEdit;
    dateFim: TdxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    scBank: TSuperComboADO;
    Label3: TLabel;
    scBKAcc: TSuperComboADO;
    Label4: TLabel;
    scEntity: TSuperComboADO;
    Label5: TLabel;
    scEntType: TSuperComboADO;
    btnBank: TSpeedButton;
    btnBKAcc: TSpeedButton;
    btnEntType: TSpeedButton;
    btnEntity: TSpeedButton;
    Label6: TLabel;
    cbxStatus: TComboBox;
    cbxFilterDate: TComboBox;
    Label7: TLabel;
    scRecordType: TSuperComboADO;
    btnRecType: TSpeedButton;
    Label8: TLabel;
    scDocType: TSuperComboADO;
    SpeedButton1: TSpeedButton;
    siLangFrame: TsiLangRT;
    procedure scEntTypeSelectItem(Sender: TObject);
    procedure btnBankClick(Sender: TObject);
    procedure btnBKAccClick(Sender: TObject);
    procedure btnEntTypeClick(Sender: TObject);
    procedure btnEntityClick(Sender: TObject);
    procedure btnRecTypeClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    aWhereBasicFilter : array [1..20] of String;

    function ValidateFields: boolean;
    function GetWhereClause: String;
  public
    { Public declarations }
    TempTableName: String;

    function CreateTempTable: boolean;
    function DropTempTable: boolean;
    function CreateEmptyTempTable: boolean;
    function GetFilterText: String;

    procedure ResetFilters;

    procedure Init;
    procedure UnInit;

  end;

implementation

uses uDM, uMsgBox, uDateTimeFunctions, uMsgConstant, uDMGlobal;

{$R *.DFM}

procedure TFrameFilterAcc.UnInit;
begin
   //Free;
end;

procedure TFrameFilterAcc.Init;
var
  i : Integer;
begin

  // Reseta String Where variaveis
  for i := Low(aWhereBasicFilter) to High(aWhereBasicFilter) do
   aWhereBasicFilter[i] := '';

  DateIni.Date := FirstDateMonth;
  DateFim.Date := LastDateMonth;

  cbxStatus.ItemIndex := 0;
  cbxFilterDate.ItemIndex := 0;

  //Setup Language  
  if (DMGlobal.IDLanguage <> 1) and (siLangFrame.StorageFile <> '') then
     begin
     if FileExists(DMGlobal.LangFilesPath + siLangFrame.StorageFile) then
        siLangFrame.LoadAllFromFile(DMGlobal.LangFilesPath + siLangFrame.StorageFile, True)
      else
        MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);
     end;


end;

procedure TFrameFilterAcc.ResetFilters;
begin

  cbxStatus.ItemIndex := 0;
  cbxFilterDate.ItemIndex := 0;

  scBank.LookUpValue := '';
  scBank.Text := '<->';

  scBKAcc.LookUpValue := '';
  scBKAcc.Text := '<->';

  scEntType.LookUpValue := '';
  scEntType.Text := '<->';

  scEntity.LookUpValue := '';
  scEntity.Text := '<->';

end;

function TFrameFilterAcc.GetFilterText: String;
begin
//Filter Fileds

  Result := cbxFilterDate.Text + ' ' + DateIni.Text + ' '+Label1.Caption+' ' + DateFim.Text + '; ';

  if cbxStatus.ItemIndex <> 0 then
     Result := Result + ' '+Label6.Caption+' ' + cbxStatus.Text;

  if scBank.LookUpValue <> '' then
     Result := Result + ' '+Label3.Caption+' ' + scBank.Text + '; ';

  if scBKAcc.LookUpValue <> '' then
     Result := Result + ' '+Label2.Caption+' ' + scBKAcc.Text + '; ';

  if scEntType.LookUpValue <> '' then
     Result := Result + ' '+Label5.Caption+' ' + scEntType.Text + '; ';

  if scEntity.LookUpValue <> '' then
     Result := Result + ' '+Label4.Caption+' ' + scEntity.Text + '; ';

  if scRecordType.LookUpValue <> '' then
     Result := Result + ' '+Label7.Caption+' ' + scRecordType.Text + '; ';

  if scDocType.LookUpValue <> '' then
     Result := Result + ' '+ Label8.Caption+ ' ' + scDocType.Text + '; ';

end;


function TFrameFilterAcc.DropTempTable: boolean;
begin

  if TempTableName <> '' then
    try
      with DM.quFreeSQL do
        begin
          Close;
          SQL.Text := 'DROP TABLE ' + TempTableName;
          ExecSQL;
        end;
      Result := True;
    except
      Result := False;
    end;
end;


function TFrameFilterAcc.CreateEmptyTempTable: boolean;
begin

    try
       if TempTableName <> '' then
          with quTempTable do
            begin
            CommandText := ' SELECT	I.IDInvoice '+
                           ' INTO ' + TempTableName +
                           ' FROM Invoice I ' +
                           ' WHERE 0=1';
            Execute;
            end;
      Result := True;
    except
      Result := False;
    end;
end;


function TFrameFilterAcc.CreateTempTable: boolean;
var
  iRecordsAffected : Integer;
begin

  if TempTableName <> '' then
     try
       with quTempTable do
          begin

          if cbxFilterDate.ItemIndex <> 4 then
              CommandText := ' SELECT L.IDLancamento as IDRecord, Q.IDQuitacao as IDPayment ' +
                             ' INTO ' + TempTableName +
                             ' FROM Fin_Lancamento L ' +
                             ' LEFT OUTER JOIN Fin_LancQuit LQ ON (LQ.IDLancamento = L.IDLancamento) ' +
                             ' LEFT OUTER JOIN Fin_Quitacao Q ON (LQ.IDQuitacao = Q.IDQuitacao) ' +
                             ' LEFT OUTER JOIN Fin_ContaCorrente CC ON (Q.IDContaCorrente = CC.IDContaCorrente) ' +
                             ' LEFT OUTER JOIN Invoice I ON (L.IDPreSale = I.IDPreSale) ' +
                             ' LEFT OUTER JOIN MeioPag MP ON (MP.IDMeioPag = L.IDQuitacaoMeioPrevisto) ' +
                             ' WHERE ' + GetWhereClause +
                             ' GROUP BY L.IDLancamento, Q.IDQuitacao '
          else
              CommandText := ' SELECT L.IDLancamento as IDRecord, Q.IDQuitacao as IDPayment' +
                             ' INTO ' + TempTableName +
                             ' FROM Fin_Quitacao Q ' +
                             ' LEFT OUTER JOIN Fin_LancQuit LQ ON (LQ.IDQuitacao = Q.IDQuitacao) ' +
                             ' LEFT OUTER JOIN Fin_Lancamento L ON (LQ.IDLancamento = L.IDLancamento) ' +
                             ' LEFT OUTER JOIN Fin_ContaCorrente CC ON (Q.IDContaCorrente = CC.IDContaCorrente) ' +
                             ' LEFT OUTER JOIN Invoice I ON (L.IDPreSale = I.IDPreSale) ' +
                             ' LEFT OUTER JOIN MeioPag MP ON (MP.IDMeioPag = Q.IDQuitacaoMeio) ' +
                             ' WHERE ' + GetWhereClause +
                             ' GROUP BY L.IDLancamento, Q.IDQuitacao';

          Execute(iRecordsAffected,eoAsyncExecute);
          if iRecordsAffected = 0 then
             MsgBox(MSG_INF_NO_DATA_FOUND, vbOKOnly + vbInformation);


          end;
      except
          Result := False;
      end;

end;


function TFrameFilterAcc.GetWhereClause: String;
var
 i : integer;
 sField, sStatus : string;
begin

  case cbxFilterDate.ItemIndex of
    0 : sField := ' L.DataLancamento ';
    1 : sField := ' L.DataEmissao ';
    2 : sField := ' LQ.DataQuitacao ';
    3 : sField := ' L.DataVencimento ';
    4 : sField := ' Q.DataQuitacao ';
  end;

  aWhereBasicFilter[1] := sField + ' >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',DateIni.Date)) + ' AND ' +
                          sField + ' <  ' + QuotedStr(FormatDateTime('mm/dd/yyyy',DateFim.Date+1));


  if scBank.LookUpValue <> '' then
    aWhereBasicFilter[2] := ' CC.IDBanco = ' + scBank.LookUpValue
  else
    aWhereBasicFilter[2] := '';

  if scBKAcc.LookUpValue <> '' then
    aWhereBasicFilter[3] := ' Q.IDContaCorrente = ' + scBKAcc.LookUpValue
  else
    aWhereBasicFilter[3] := '';

  if scEntType.LookUpValue <> '' then
    aWhereBasicFilter[4] := ' L.IDPessoaTipo = ' + scEntType.LookUpValue
  else
    aWhereBasicFilter[4] := '';

  if scEntity.LookUpValue <> '' then
    aWhereBasicFilter[5] := ' L.IDPessoa = ' + scEntity.LookUpValue
  else
    aWhereBasicFilter[5] := '';

  if cbxStatus.ItemIndex = 0 then
     aWhereBasicFilter[6] := ''
  else
     aWhereBasicFilter[6] := 'L.Situacao = ' + IntToStr(cbxStatus.ItemIndex);

  if scRecordType.LookUpValue <> '' then
     aWhereBasicFilter[7] := ' L.IDLancamentoTipo = ' + scRecordType.LookUpValue
  else
     aWhereBasicFilter[7] := '';

  if scDocType.LookUpValue <> '' then
     aWhereBasicFilter[8] := ' L.IDDocumentoTipo = ' + scDocType.LookUpValue
  else
     aWhereBasicFilter[8] := '';

  //Soment os lancamentos Filhos
  aWhereBasicFilter[9] := ' ((IsNull(L.LancamentoType,0) = 0) OR (L.LancamentoType = 2))';

  for i := Low(aWhereBasicFilter) to High(aWhereBasicFilter) do
    if aWhereBasicFilter[i] <> '' then
       begin
       if Result <> '' then
          Result := Result + ' AND ';
       Result := Result + '(' + aWhereBasicFilter[i] + ')';
       end;


end;


function TFrameFilterAcc.ValidateFields: boolean;
begin
// Vaildade Fields

end;


procedure TFrameFilterAcc.scEntTypeSelectItem(Sender: TObject);
begin

 if (scEntType.LookUpValue <> Trim(scEntity.FilterValues.Text)) then
    with scEntity do
       begin
       FilterFields.Clear;
       FilterValues.Clear;
       FilterFields.Add('IDTipoPessoa');
       FilterValues.Add(scEntType.LookUpvalue);
       end;

end;

procedure TFrameFilterAcc.btnBankClick(Sender: TObject);
begin

  scBank.LookUpValue := '';
  scBank.Text := '<'+btnBank.Caption+'>';

end;

procedure TFrameFilterAcc.btnBKAccClick(Sender: TObject);
begin

  scBKAcc.LookUpValue := '';
  scBKAcc.Text := '<'+btnBKAcc.Caption+'>';

end;

procedure TFrameFilterAcc.btnEntTypeClick(Sender: TObject);
begin

  scEntType.LookUpValue := '';
  scEntType.Text := '<'+btnEntType.Caption+'>';

  scEntity.FilterFields.Clear;
  scEntity.FilterValues.Clear;


end;

procedure TFrameFilterAcc.btnEntityClick(Sender: TObject);
begin

  scEntity.LookUpValue := '';
  scEntity.Text := '<'+btnEntity.Caption+'>';

end;

procedure TFrameFilterAcc.btnRecTypeClick(Sender: TObject);
begin

  scRecordType.LookUpValue := '';
  scRecordType.Text := '<'+btnRecType.Caption+'>';

end;

procedure TFrameFilterAcc.SpeedButton1Click(Sender: TObject);
begin

  scDocType.LookUpValue := '';
  scDocType.Text := '<'+SpeedButton1.Caption+'>';

end;

end.
