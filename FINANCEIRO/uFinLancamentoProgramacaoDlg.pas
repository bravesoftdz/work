unit uFinLancamentoProgramacaoDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, StdCtrls, Mask, ExtCtrls, Buttons, DBCtrls,
  Db, DBTables, dxDateEdit, dxDBDateEdit, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, dxDBELib, siComp, siLangRT;

type
  TFinLancamentoProgramacaoDlg = class(TParentDialogFrm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    rgPeriodicidade: TDBRadioGroup;
    dbVencimento: TdxDBDateEdit;
    eDia: TDBEdit;
    eRepeticao: TDBEdit;
    btDeletaRep: TButton;
    lblRep: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgPeriodicidadeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btDeletaRepClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshRep;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uMsgBox, uFinLancamentoFch, uDM, uNumericFunctions, uDateTimeFunctions,
     uMsgConstant;


procedure TFinLancamentoProgramacaoDlg.btOkClick(Sender: TObject);
begin
  inherited;
  // Valida os dados entrados e some com o form

  ModalResult := mrNone;

  if rgPeriodicidade.ItemIndex > 0 then
    begin
      if not TestDate(dbVencimento.Text) then
        begin
          MsgBox(MSG_CRT_NO_VALID_DATE, vbOkOnly + vbInformation);
          dbVencimento.SetFocus;
          Exit;
        end;

      if MyStrToInt(eDia.Text) = 0 then
        begin
          MsgBox(MSG_CRT_NO_VALID_DAY, vbOkOnly + vbInformation);
          eDia.SetFocus;
          Exit;
        end;

      if MyStrToInt(eRepeticao.Text) = 0 then
        begin
          MsgBox(MSG_CRT_NO_VALID_FREQUENCY, vbOkOnly + vbInformation);
          eRepeticao.SetFocus;
          Exit;
        end;
    end;

  ModalResult := mrOk;
end;

procedure TFinLancamentoProgramacaoDlg.FormCreate(Sender: TObject);
begin
  inherited;
  // Preenche o Radio group de periodicidade
  with rgPeriodicidade.Values do
    begin
      Clear;
      Add(IntToStr(DM.GetConst('LancamentoPeriodicidade_Unica')));
      Add(IntToStr(DM.GetConst('LancamentoPeriodicidade_Mensal')));
      Add(IntToStr(DM.GetConst('LancamentoPeriodicidade_Bimensal')));
      Add(IntToStr(DM.GetConst('LancamentoPeriodicidade_Trimestral')));
      Add(IntToStr(DM.GetConst('LancamentoPeriodicidade_Anual')));
    end;
end;

procedure TFinLancamentoProgramacaoDlg.rgPeriodicidadeChange(
  Sender: TObject);
begin
  inherited;
  // Desliga os controles quando não for multiplo
  if rgPeriodicidade.ItemIndex > 0 then
    begin
      // Liga
      dbVencimento.Enabled := True;
      dbVencimento.Color := clWindow;
      eDia.Enabled := True;
      eDia.Color := clWindow;
      eRepeticao.Enabled := True;
      eRepeticao.Color := clWindow;
    end
  else
    begin
      // Desliga
      dbVencimento.Enabled := False;
      dbVencimento.ParentColor := True;
      eDia.Enabled := False;
      eDia.ParentColor := True;
      eRepeticao.Enabled := False;
      eRepeticao.ParentColor := True;
    end;

end;

procedure TFinLancamentoProgramacaoDlg.FormShow(Sender: TObject);
var
   Year, Month, Day: word;
begin
  inherited;

  if TFinLancamentoFch(Owner).quForm.State in dsEditModes then
  begin
  if TFinLancamentoFch(Owner).quFormDataVencimento.AsString <> '' then
    begin
      TFinLancamentoFch(Owner).quFormDataPrimeiraRepeticao.AsDateTime
          := TFinLancamentoFch(Owner).quFormDataVencimento.AsDateTime;
      DecodeDate(TFinLancamentoFch(Owner).quFormDataVencimento.AsDateTime, Year, Month, Day);
      TFinLancamentoFch(Owner).quFormDiaRepeticoes.AsInteger := Day;
    end;
  TFinLancamentoFch(Owner).quFormNumeroRepeticoes.AsInteger := 5;
  end;

  RefreshRep;
  rgPeriodicidadeChange(nil);

end;

procedure TFinLancamentoProgramacaoDlg.RefreshRep;
var
  MyBo: Boolean;
  MyCo: Integer;

begin
  // Calcula o número de reptições que este lancamento possui
  with DM.quFreeSQL do
    begin
      SQL.Text := 'SELECT COUNT(IDLancamento) FROM Fin_Lancamento WHERE IDLancamentoOriginal = ' + TFinLancamentoFch(Self.Owner).quFormIDLancamento.AsString;
      Open;
      case Fields[0].AsInteger of
        0:    lblRep.Caption := 'Record does not have recurrence.';
        1:    lblRep.Caption := 'Record with one recurrence.';
        else lblRep.Caption := 'Record with ' + Fields[0].AsString + ' recurrencies.';
      end;
      if Fields[0].AsInteger = 0 then
        begin
          MyBo := True;
          MyCo := clWindow;
        end
      else
        begin
          MyBo := False;
          MyCo := Self.Color;
        end;
      Close;

      rgPeriodicidade.Enabled := MyBo;

      dbVencimento.Enabled := MyBo;
      dbVencimento.Color := MyCo;

      eDia.Enabled := MyBo;
      eDia.Color := MyCo;

      eRepeticao.Enabled := MyBo;
      eRepeticao.Color := MyCo;

      btDeletaRep.Enabled := not MyBo;

    end;
end;


procedure TFinLancamentoProgramacaoDlg.btDeletaRepClick(Sender: TObject);
begin
  inherited;
  try
    DM.DBADOConnection.BeginTrans;
//    DM.RunSQL('DELETE Fin_Quitacao FROM Fin_LancQuit LQ WHERE LQ.IDQuitacao = Fin_Quitacao.IDQuitacao AND LQ.IDLancamento = ' + TFinLancamentoFch(Self.Owner).quFormIDLancamento.AsString);
//    DM.RunSQL('DELETE Fin_LancQuit WHERE IDLancamento = ' + TFinLancamentoFch(Self.Owner).quFormIDLancamento.AsString);
    With DM.quFreeSQL do
      begin
        SQL.Text := 'DELETE Fin_Lancamento WHERE IDLancamentoOriginal = ' + TFinLancamentoFch(Self.Owner).quFormIDLancamento.AsString;
        ExecSQL;
      end;
    DM.DBADOConnection.CommitTrans;
    MsgBox(MSG_INF_FREQUENCY_DELETED, vbInformation + vbOkOnly);
  except
    DM.DBADOConnection.RollBackTrans;
    MsgBox(MSG_CRT_NO_DEL_FREQUENCY, vbCritical + vbOkOnly);
  end;
  RefreshRep;
end;

end.
