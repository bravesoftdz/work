unit uFinQuitacaoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FormConfig, Db, DBTables, Grids, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, Mask, BrowseConfig, ComCtrls,
  dxBar, uParentFchList, dxDBGrid, dxCntner, dxTL, dxDateEdit,
  dxDBDateEdit, ImgList, dxDBCtrl, ADODB, PowerADOQuery, SuperComboADO,
  dxEditor, dxExEdtr, dxEdLib, dxDBELib, siComp, siLangRT, DateBox;

type
  TFinQuitacaoFch = class(TParentFchList)
    quFormIDQuitacao: TIntegerField;
    quFormPagando: TBooleanField;
    quFormIDContaCorrente: TIntegerField;
    quFormIDUsuarioQuitacao: TIntegerField;
    quFormValorQuitacao: TFloatField;
    quFormValorJuros: TFloatField;
    quFormDataDesbloqueio: TDateTimeField;
    quFormIDQuitacaoMeio: TIntegerField;
    quFormNumeroMeioQuit: TStringField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    DBSuperCombo1: TDBSuperComboADO;
    scContaCorrente: TDBSuperComboADO;
    Label1: TLabel;
    lblContaCorrente: TLabel;
    Label5: TLabel;
    quFchBrwIDQuitacao: TIntegerField;
    quFchBrwIDLancamento: TIntegerField;
    quFchBrwValorJuros: TFloatField;
    quFchBrwValorQuitado: TFloatField;
    Label7: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    quFormIDBancoAgencia: TIntegerField;
    quFormIDBanco: TIntegerField;
    quFormFavorecido: TStringField;
    grbFchBrwIDLancamento: TdxDBGridMaskColumn;
    grbFchBrwValorJuros: TdxDBGridMaskColumn;
    grbFchBrwValorQuitado: TdxDBGridMaskColumn;
    pnlControl: TPanel;
    pnlNum: TPanel;
    lblNumDocQuitacao: TLabel;
    Label4: TLabel;
    DocQuit: TDBEdit;
    pnlFavorecido: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    DBEdit1: TDBEdit;
    pnlAmount: TPanel;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    pnlMemo: TPanel;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    quFormString: TStringField;
    pnlQuitMeio: TPanel;
    lblQuitacaoMeio: TLabel;
    lbQuitStart: TLabel;
    scQuitacaoMeio: TDBSuperComboADO;
    grbFchBrwDiscount: TdxDBGridMaskColumn;
    quFchBrwDiscount: TCurrencyField;
    quFormDataQuitacao: TDateTimeField;
    dxDBDateEdit1: TdxDBDateEdit;
    procedure scQuitacaoMeioSelectItem(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure grbFchBrwDblClick(Sender: TObject);
    procedure dsFchBrwDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure quFchBrwAfterOpen(DataSet: TDataSet);
    procedure quFchBrwValorQuitadoChange(Sender: TField);
    procedure quFchBrwCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    //Translation
    sInvParam,
    sPayment,
    sAddPay,
    sUpdatePay,
    sDebitAcc,
    sPayType,
    sLisTransc,
    sCreditAcc : String;

    UserTime: Boolean;
    Pagando: Boolean;

    function TestOnBeforeSave: boolean; override;

    procedure GetNextCheckNumber;
    function ValidCheckNumber:Boolean;

    procedure RefreshTotal;
    procedure OnBeforeStart; override;
    procedure OnAfterStart; override;
    procedure  OnAfterSaveData; override;
  public
    { Public declarations }

  end;

implementation

{$R *.DFM}

uses uDM, uSisSenha, uMsgBox, uSystemTypes, uParamFunctions, uSystemConst,
     uMsgConstant, uDMGlobal;


function TFinQuitacaoFch.ValidCheckNumber:Boolean;
begin

  Result := True;

  if (not quFormPagando.AsBoolean)         or
     (quFormNumeroMeioQuit.AsString = '')  or
     (quFormIDContaCorrente.AsString = '') or
     (quFormIDQuitacaoMeio.AsInteger <= 0) then
     Exit;

  with DM.quFreeSQL do
    begin
      if Active then
         Close;
      SQL.Clear;
      SQL.Add('SELECT                                                  ');
      SQL.Add('    MQ.Tipo                                             ');
      SQL.Add('FROM                                                    ');
      SQL.Add('    Fin_Quitacao Q                                      ');
      SQL.Add('    JOIN MeioPag MQ ON (MQ.IDMeioPag = Q.IDQuitacaoMeio)');
      SQL.Add('WHERE                                                   ');
      SQL.Add('    Q.Pagando = 1                                       ');
      SQL.Add('    AND                                                 ');
      SQL.Add('    Q.IDContaCorrente = ' +scContaCorrente.LookUpValue+'');
      SQL.Add('    AND                                                 ');
      SQL.Add('    Q.IDQuitacaoMeio = ' +scQuitacaoMeio.LookUpValue+'  ');
      SQL.Add('    AND                                                 ');
      SQL.Add('    Q.NumeroMeioQuit = ' +QuotedStr(quFormNumeroMeioQuit.AsString)+'');
      Open;
      if Fields[0].AsInteger = QuitacaoMeioTipo_Cheque then
         Result := IsEmpty;
      Close;
    end;

end;

function TFinQuitacaoFch.TestOnBeforeSave: boolean;
begin
   inherited TestOnBeforeSave;

    Result := False;

    if not ValidCheckNumber then
       if MsgBox(MSQ_QST_PART1_CHECK_USES +
                 quFormNumeroMeioQuit.AsString +
                 MSQ_QST_PART2_CHECK_USES, vbQuestion + vbYesNo) = vbNo then
                 Exit;


    Result := True;
end;

procedure TFinQuitacaoFch.OnBeforeStart;
var
  R: String;
begin

  R := ParseParam(MyParametro, 'Pagando');

  if R <> '' then
    begin
      if R = '1' then
        Pagando := True
      else if R = '0' then
        Pagando := False
      else ShowMessage(sInvParam);
    end;
end;

procedure TFinQuitacaoFch.OnAfterStart;
begin
  pnlQuitMeio.Visible := True;
end;

procedure TFinQuitacaoFch.scQuitacaoMeioSelectItem(Sender: TObject);
begin
  inherited;

  if quFormIDQuitacaoMeio.AsInteger = 0 then
    begin
      pnlNum.Visible                := False;
      pnlFavorecido.Visible         := False;
      quFormFavorecido.Required     := False;
      quFormNumeroMeioQuit.Required := False;
      Exit;
    end;


  //Inicializo os valores comuns
  pnlFavorecido.Visible         := quFormPagando.AsBoolean;
  quFormFavorecido.Required     := quFormPagando.AsBoolean;
  pnlNum.Visible                := True;
  quFormNumeroMeioQuit.Required := True;
  pnlQuitMeio.Visible           := True;

  //Adjustmen Balance ou Transferencia nao mostra o meio quit
  if (quFormIDQuitacaoMeio.AsInteger = -1) or
     (quFormIDQuitacaoMeio.AsInteger = 12) then
     begin
     pnlQuitMeio.Visible           := False;
     pnlFavorecido.Visible         := False;
     quFormFavorecido.Required     := False;
     pnlNum.Visible                := False;
     quFormNumeroMeioQuit.Required := False;
     end;

  with DM.quFreeSQL do
    begin
      if Active then
         Close;
      SQL.Text := 'SELECT IdentificadorDocumento, Tipo, ParentType FROM MeioPag ' +
                  'WHERE IDMeioPag = ' + quFormIDQuitacaoMeio.AsString;
      Open;
      lblNumDocQuitacao.caption := Fields[0].AsString + ' :';
      quFormNumeroMeioQuit.DisplayLabel := Fields[0].AsString;

      //Nao mostra o Payee, DocMumber, Payment Type
      if LowerCase(Trim(Fields[2].AsString)) = 'batch' then
         begin
         pnlFavorecido.Visible         := False;
         quFormFavorecido.Required     := False;
         pnlNum.Visible                := False;
         quFormNumeroMeioQuit.Required := False;
         pnlQuitMeio.Visible           := False;
         end;

      if Fields[1].AsInteger = DM.GetConst('QuitacaoMeioTipo_Especie') then
        begin
          pnlNum.Visible := False;
          quFormNumeroMeioQuit.Required := False;
        end;
      Close;
    end;

  //Set a ordem dos panel
  pnlQuitMeio.Top   := 0;
  pnlNum.Top        := 22;
  pnlAmount.Top     := 49;
  pnlFavorecido.Top := 73;
  pnlMemo.Top       := 98;


  //preenche o check automatico, se necessario
  GetNextCheckNumber;

  DocQuit.Enabled := True;
  DocQuit.Color := clWindow;

end;

procedure TFinQuitacaoFch.GetNextCheckNumber;
var
   iNextCheck:Integer;
begin

  if (not quFormPagando.AsBoolean) or
     (quFormNumeroMeioQuit.AsString <> '') or
     (quFormIDQuitacaoMeio.AsString = '') or
     (quFormIDContaCorrente.AsString = '') then
     Exit;

  iNextCheck := 0;

  with DM.quFreeSQL do
    begin
      if Active then
         Close;
      SQL.Clear;
      SQL.Add('SELECT TOP 1                                            ');
      SQL.Add('    Q.NumeroMeioQuit,                                   ');
      SQL.Add('    MQ.Tipo                                             ');
      SQL.Add('FROM                                                    ');
      SQL.Add('    Fin_Quitacao Q                                      ');
      SQL.Add('    JOIN MeioPag MQ ON (MQ.IDMeioPag = Q.IDQuitacaoMeio)');
      SQL.Add('WHERE                                                   ');
      SQL.Add('    Q.Pagando = 1                                       ');
      SQL.Add('    AND                                                 ');
      SQL.Add('    Q.IDContaCorrente = ' +scContaCorrente.LookUpValue+'');
      SQL.Add('    AND                                                 ');
      SQL.Add('    Q.IDQuitacaoMeio = ' +scQuitacaoMeio.LookUpValue+'  ');
      SQL.Add('ORDER BY                                                ');
      SQL.Add('    Q.DataQuitacao Desc                                 ');
      Open;

      if Fields[1].AsInteger = QuitacaoMeioTipo_Cheque then
         begin
         if IsEmpty then //primeiro check number
            iNextCheck := 100
         else
            iNextCheck := StrToIntDef(Fields[0].AsString, 0);
         end;
      Close;
    end;


  if iNextCheck <> 0 then
     quFormNumeroMeioQuit.AsString := IntToStr(iNextCheck+1);

end;

procedure TFinQuitacaoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormPagando.AsBoolean := Pagando;
  quFormIDUsuarioQuitacao.AsInteger := SisSenha.IDUsuario;
  quFormDataQuitacao.AsDateTime := Now;

end;

procedure TFinQuitacaoFch.RefreshTotal;
begin
end;
      //Display labels dos fields

procedure TFinQuitacaoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // Funções de refresh da tela, na abertura e na navegação

  if quFormPagando.AsBoolean then
    begin
      // é a quitacao de um pagamento.
      EntidadeNome := sPayment;

      if frmCommand = btInc then
        lblPTitulo.Caption := sAddPay
      else
        lblPTitulo.Caption := sUpdatePay;

      // Ajusta os DisplayLabel
      quFormIDContaCorrente.DisplayLabel := sDebitAcc;
      quFormIDQuitacaoMeio.DisplayLabel := sPayType;

      pnlBrwTitle.Caption       := sLisTransc;
      lblContaCorrente.caption  := sDebitAcc + ' :';
      lblQuitacaoMeio.caption   := sPayType + ' :';
      lblNumDocQuitacao.caption := '';
    end
  else
    begin
      // é a quitacao de um recebimento.
      EntidadeNome := sPayment;

      if frmCommand = btInc then
        lblPTitulo.Caption := sAddPay
      else
        lblPTitulo.Caption := sUpdatePay;

      // Ajusta os DisplayLabel
      quFormIDContaCorrente.DisplayLabel := sCreditAcc;
      quFormIDQuitacaoMeio.DisplayLabel := sPayType;

      pnlBrwTitle.Caption       := sLisTransc;
      lblContaCorrente.caption  := sCreditAcc + ' :';
      lblQuitacaoMeio.caption   := sPayType + ' :';
      lblNumDocQuitacao.caption := '';
    end;

  UserTime := True;
  scQuitacaoMeioSelectItem(nil);
end;

procedure TFinQuitacaoFch.grbFchBrwDblClick(Sender: TObject);
begin
  //inherited;

end;

procedure TFinQuitacaoFch.dsFchBrwDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if (quFchBrw.State in dsEditModes) AND NOT UserTime then
    RefreshTotal;
end;

procedure TFinQuitacaoFch.FormCreate(Sender: TObject);
begin
  inherited;
  UserTime := False;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sInvParam  := 'Invalid parameter !';
           sPayment   := 'Payment';
           sAddPay    := 'Adding payment';
           sUpdatePay := 'Updating payment';
           sDebitAcc  := 'Debit account';
           sPayType   := 'Payment Type';
           sLisTransc := ' List of transactions ';
           sCreditAcc := 'Credit account';
           end;
    LANG_PORTUGUESE :
           begin
           sInvParam  := 'Inválido Parâmetro !';
           sPayment   := 'Pagamento';
           sAddPay    := 'Adicionar';
           sUpdatePay := 'Atualizar';
           sDebitAcc  := 'Conta Débito';
           sPayType   := 'Tipo de Pagamento';
           sLisTransc := ' Lista de Transações ';
           sCreditAcc := 'Conta Crédito';
           end;
    LANG_SPANISH :
           begin
           sInvParam  := 'Inválido Parámetro !';
           sPayment   := 'Pago';
           sAddPay    := 'Adicionando pago';
           sUpdatePay := 'Actualizando pago';
           sDebitAcc  := 'Cuenta Débito';
           sPayType   := 'Tipo del Pago';
           sLisTransc := ' Lista de Transacciones ';
           sCreditAcc := 'Cuenta de Crédito';
           end;
  end;

end;

procedure TFinQuitacaoFch.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  UserTime := False;
end;

procedure TFinQuitacaoFch.FormShow(Sender: TObject);
begin
  inherited;
  if frmCommand = btInc then
    begin
      grbFchBrwValorJuros.ReadOnly   := False;
      grbFchBrwValorQuitado.ReadOnly := False;
      grbFchBrwDiscount.ReadOnly     := True;
      with DM.NewQuery do
        begin
         if Active then
            Close;
         // Inclui os Lancamentos relacionados na tabela temporaria #AQuitar
          SQL.Text := 'INSERT Fin_LancQuit (IDLancamento, IDQuitacao, ValorQuitado, DataQuitacao, IDUsuarioQuitacao, ValorJuros)' +
                      ' (SELECT L.IDLancamento, ' + quFormIDQuitacao.AsString +
                      ' , IsNull(Q.ValorAQuitar, L.ValorNominal - L.TotalQuitado), GetDate() ' +
                      ' , ' + IntToStr(SisSenha.IDUsuario) +
                      ' , IsNull(Q.ValorDiscount, 0)  ' +
                      ' FROM #AQuitar Q, Fin_Lancamento L WHERE L.IDLancamento = Q.IDLancamento )';
          ExecSQL;
          quFchBrw.Requery;
          Close;

          // Preenche automaticamente a ContaCorrente o meio de quitacao e o favorecido
          SQL.Text := 'SELECT IDContaCorrente, IDQuitacaoMeio, Favorecido, NumeroMeioQuit, ValorDiscount ' +
                      ' FROM #AQuitar';
          Open;
          if Fields[0].AsInteger <> -1 then
            quFormIDContaCorrente.AsInteger := Fields[0].AsInteger;

          if Fields[1].AsInteger <> -1 then
            quFormIDQuitacaoMeio.AsInteger := Fields[1].AsInteger;

          if Fields[2].AsString <> '' then
            quFormFavorecido.AsString := Fields[2].AsString;

          if Fields[3].AsString <> '' then
            quFormNumeroMeioQuit.AsString := Fields[3].AsString;

          if Fields[4].AsCurrency < 0 then
             begin
             grbFchBrwDiscount.Visible   := True;
             grbFchBrwDiscount.ColIndex  := 1;
             grbFchBrwValorJuros.Visible := False;
             end
          else
             begin
             grbFchBrwDiscount.Visible    := False;
             grbFchBrwValorJuros.ColIndex := 1;
             grbFchBrwValorJuros.Visible  := True;
             end;

          Close;
          Free;

        end;
    end
  else
    begin
      // Trava as alterações aos lancamentos
      grbFchBrwValorJuros.ReadOnly   := True;
      grbFchBrwDiscount.ReadOnly     := True;
      grbFchBrwValorQuitado.ReadOnly := True;
    end;
  scQuitacaoMeioSelectItem(nil);

end;

procedure TFinQuitacaoFch.quFchBrwAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if DataSet.RecordCount = 0 then
     begin
     pnlBottomAlign.Visible := False;
     pnlAmount.Visible      := True;
     end
  else
     begin
     pnlBottomAlign.Visible := True;
     pnlAmount.Visible      := False;
     end;

end;

procedure TFinQuitacaoFch.quFchBrwValorQuitadoChange(Sender: TField);
begin
  inherited;

  //So recebe o disconto se pagar full document
  if (frmCommand = btInc) and (quFchBrwDiscount.AsCurrency > 0) then
     quFchBrwValorJuros.AsCurrency := 0;

end;

procedure TFinQuitacaoFch.quFchBrwCalcFields(DataSet: TDataSet);
begin
  inherited;
  quFchBrwDiscount.AsCurrency := -1 * quFchBrwValorJuros.AsCurrency;
end;

procedure TFinQuitacaoFch.OnAfterSaveData;
begin

  with DM.NewQuery do
  begin
   if Active then
      Close;
    SQL.Text := 'UPDATE Fin_LancQuit SET DataQuitacao = :DataQuitacao ' +
                'WHERE IDQuitacao = ' + quFormIDQuitacao.AsString;
    Parameters.ParamByName('DataQuitacao').Value := dxDBDateEdit1.Date;
    ExecSQL;
    Close;
  end;

end;

Initialization
  RegisterClass(TFinQuitacaoFch);


end.
