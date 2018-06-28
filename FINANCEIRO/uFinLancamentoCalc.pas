unit uFinLancamentoCalc;

interface

const
  FIN_LANCAMENTO_SINGLE = 0;
  FIN_LANCAMENTO_PARENT = 1;
  FIN_LANCAMENTO_CHILD  = 2;


//############ Disbursiment ###############  
//Recalcula o Total do Disbursement Parent
function UpdateTotalDisbursement(sIDLancamentoParent:String):Boolean;

//Atualiza as Alteracao do Disbursement Parent e dos Filhos
procedure UpdateDisbursementFields(sIDLancamento, sIDLancamentoParent:String);

//Atualiza os disbursements filhos
procedure UpdateDisbursementsChildren(sIDLancamentoParent:String);

//Atualiza o status dos filho only
procedure UpdateStatusChildren(sIDLancamentoParent:String);

//Atualiza o status do Pai e Filhos
procedure UpdateStatusParent(sIDLancamento, sIDLancamentoParent:String);

//retorn a list de IDLancamentos para alteracao
function GetIDLancamentos(sIDLancamento, sIDLancamentoParent:String):String;

//verifica se o Parent tem disbursemente
function HasDisbursement(IDLancParent:integer):Boolean;


//############ Temp Table AQuitar ###############
procedure DeleteAQuitar(IDLancamento: integer); //Deleta as records na Temp Tbl Aquitar
procedure InsereAQuitar(IDLancamento: integer; bHasParent:Boolean); //Insere Lancamentos na Temp Tbl Aquitar
procedure CreateAQuitar; //Create a TmpTable AQuitar

//############ Payment ###############
function OnBeforePay:Boolean;
function OnAfterPay:Boolean;

function GetTotalQuitado(IDLanc:Integer):Currency;


implementation

uses uDM, Sysutils;

function GetIDLancamentos(sIDLancamento, sIDLancamentoParent:String):String;
begin
    with DM.quFreeSQL do
       begin
       if Active then
          Close;
       SQL.Clear;
       SQL.Add('Select IDLancamento');
       SQL.Add('From Fin_Lancamento');
       SQL.Add('Where IDLancamentoParent = '+ sIDLancamentoParent);
       SQL.Add('and IDLancamento <> ' + sIDLancamento);
       Open;
       if IsEmpty then
          Result := sIDLancamentoParent
       else
          begin
          First;
          Result := sIDLancamentoParent + ', ';
          While not EOF do
             begin
             Result := Result + FieldByName('IDLancamento').AsString;
             Next;
             If not EOF then
                Result := Result + ', ';
             end;
          end;

       Close;
       end;
end;


procedure UpdateStatusParent(sIDLancamento, sIDLancamentoParent:String);
var
  sIDLancamentos : String;
begin

  if (sIDLancamento = '') or (sIDLancamentoParent = '') then
     Exit;

  sIDLancamentos := GetIDLancamentos(sIDLancamento,sIDLancamentoParent);

  with DM.quFreeSQL do
     begin
     if Active then
        Close;

     SQL.Clear;
     SQL.Add('UPDATE L');
     SQL.Add('SET L.Desativado = LO.Desativado,');
     SQL.Add('L.Hidden         = LO.Hidden');
     SQL.Add('FROM Fin_Lancamento L, Fin_Lancamento LO');
     SQL.Add('WHERE L.IDLancamento In ('+sIDLancamentos+')');
     SQL.Add('AND LO.IDLancamento = ' + sIDLancamento);
     ExecSQL;
     end;

end;

procedure UpdateStatusChildren(sIDLancamentoParent:String);
begin

  if sIDLancamentoParent = '' then
     Exit;

  with DM.quFreeSQL do
     begin
     if Active then
        Close;

     SQL.Clear;
     SQL.Add('UPDATE L');
     SQL.Add('SET L.Desativado = LO.Desativado,');
     SQL.Add('L.Hidden         = LO.Hidden');
     SQL.Add('FROM Fin_Lancamento L, Fin_Lancamento LO');
     SQL.Add('WHERE L.IDLancamentoParent = '+sIDLancamentoParent+'');
     SQL.Add('AND LO.IDLancamento = ' + sIDLancamentoParent);
     ExecSQL;
     end;
end;



procedure UpdateDisbursementsChildren(sIDLancamentoParent : String);
begin

  if sIDLancamentoParent = '' then
     Exit;

  with DM.quFreeSQL do
     begin
     if Active then
        Close;

     SQL.Clear;
     SQL.Add('UPDATE L');
     SQL.Add('SET L.IDEmpresa           = LO.IDEmpresa,');
     SQL.Add('L.IDCentroCusto           = LO.IDCentroCusto,');
     SQL.Add('L.IDPessoaTipo            = LO.IDPessoaTipo,');
     SQL.Add('L.IDPessoa                = LO.IDPessoa,');
     SQL.Add('L.IDDocumentoTipo         = LO.IDDocumentoTipo,');
     SQL.Add('L.IDDesdobramentoTipo     = LO.IDDesdobramentoTipo,');
     SQL.Add('L.IDQuitacaoMeioPrevisto  = LO.IDQuitacaoMeioPrevisto,');
     SQl.Add('L.IDContaCorrentePrevista = LO.IDContaCorrentePrevista,');
     SQL.Add('L.DataEmissao             = LO.DataEmissao,');
     SQL.Add('L.DataVencimento          = LO.DataVencimento,');
     SQL.Add('L.NumDesdobramento        = LO.NumDesdobramento,');
     SQL.Add('L.NumDocumento            = LO.NumDocumento,');
     SQL.Add('L.NumMeioQuitPrevisto     = LO.NumMeioQuitPrevisto,');
     SQL.Add('L.FavorecidoPrevisto      = LO.FavorecidoPrevisto,');
     SQL.Add('L.Desativado              = LO.Desativado,');
     SQL.Add('L.Hidden                  = LO.Hidden');
     SQL.Add('FROM Fin_Lancamento L, Fin_Lancamento LO');
     SQL.Add('WHERE L.IDLancamentoParent = '+sIDLancamentoParent+'');
     SQL.Add('AND LO.IDLancamento = ' + sIDLancamentoParent);
     ExecSQL;
     end;

end;

procedure UpdateDisbursementFields(sIDLancamento, sIDLancamentoParent:String);
var
  sIDLancamentos : String;
begin

  if (sIDLancamento = '') or (sIDLancamentoParent = '') then
     Exit;

  sIDLancamentos := GetIDLancamentos(sIDLancamento,sIDLancamentoParent);

  with DM.quFreeSQL do
     begin
     if Active then
        Close;

     SQL.Clear;
     SQL.Add('UPDATE L');
     SQL.Add('SET L.IDEmpresa           = LO.IDEmpresa,');
     SQL.Add('L.IDCentroCusto           = LO.IDCentroCusto,');
     SQL.Add('L.IDPessoaTipo            = LO.IDPessoaTipo,');
     SQL.Add('L.IDPessoa                = LO.IDPessoa,');
     SQL.Add('L.IDDocumentoTipo         = LO.IDDocumentoTipo,');
     SQL.Add('L.IDDesdobramentoTipo     = LO.IDDesdobramentoTipo,');
     SQL.Add('L.IDQuitacaoMeioPrevisto  = LO.IDQuitacaoMeioPrevisto,');
     SQl.Add('L.IDContaCorrentePrevista = LO.IDContaCorrentePrevista,');
     SQL.Add('L.DataEmissao             = LO.DataEmissao,');
     SQL.Add('L.DataVencimento          = LO.DataVencimento,');
     SQL.Add('L.NumDesdobramento        = LO.NumDesdobramento,');
     SQL.Add('L.NumDocumento            = LO.NumDocumento,');
     SQL.Add('L.NumMeioQuitPrevisto     = LO.NumMeioQuitPrevisto,');
     SQL.Add('L.FavorecidoPrevisto      = LO.FavorecidoPrevisto,');
     SQL.Add('L.Desativado              = LO.Desativado,');
     SQL.Add('L.Hidden                  = LO.Hidden');
     SQL.Add('FROM Fin_Lancamento L, Fin_Lancamento LO');
     SQL.Add('WHERE L.IDLancamento In ('+sIDLancamentos+')');
     SQL.Add('AND LO.IDLancamento = ' + sIDLancamento);
     ExecSQL;
     end;

end;


function UpdateTotalDisbursement(sIDLancamentoParent:String):Boolean;
begin

  if sIDLancamentoParent = '' then
     Exit;

  with DM.quFreeSQL do
     begin
     if Active then
        Close;
     SQL.Clear;
     SQL.Add('Update Fin_Lancamento');
     SQL.Add('Set ValorNominal = IsNull((Select Sum(IsNull(ValorNominal,0))');
     SQL.Add('From Fin_Lancamento Where IDLancamentoParent = '+sIDLancamentoParent+'),0)');
     SQl.Add('Where IDLancamento = ' + sIDLancamentoParent);
     ExecSQL;
     end;

end;

procedure DeleteAQuitar(IDLancamento: integer);
begin

  with DM.quFreeSQL do
    begin
      if Active then
         Close;

      if IDLancamento < 0 then
        SQL.Text := 'DELETE #AQuitar'
      else
        SQL.Text := 'DELETE #AQuitar WHERE IDLancamento = ' + IntToStr(IDLancamento);
      ExecSQL;
    end;

end;


procedure InsereAQuitar(IDLancamento: integer; bHasParent:Boolean);
var
  sSQL : String;
begin

  with DM.quFreeSQL do
    begin
      if Active then
         Close;

      sSQL := 'Insert #AQuitar (IDLancamento, ValorAQuitar, IDContaCorrente, Favorecido,                 ' +
              '                 IDQuitacaoMeio, NumeroMeioQuit, ValorDiscount)                           ' +
              'SELECT L.IDLancamento,                                                                    ' +
              '       (L.ValorNominal - L.TotalQuitado),                                                 ' +
              '       IsNull(L.IDContaCorrentePrevista, -1),                                             ' +
              '       IsNull(L.FavorecidoPrevisto,P.Pessoa) as FavorecidoPrevisto,                       ' +
              '       IsNull(L.IDQuitacaoMeioPrevisto, -1), L.NumMeioQuitPrevisto,                       ' +
              '       CASE IsNull(L.TotalQuitado,0)                                                      ' +
              '       WHEN 0                                                                             ' +
              '       THEN IsNull( -1 * (L.ValorNominal - (L.ValorNominal * (1-(LAT.Discount/100)))),0)  ' +
              '       ELSE 0                                                                             ' +
              '       END                                                                                ' +
              'FROM   Fin_Lancamento L (NOLOCK)                                                          ' +
              'LEFT OUTER JOIN dbo.vw_Fin_LancamentoActiveTerm LAT                                       ' +
              '       ON (L.IDLancamento = LAT.IDLancamento)                                             ' +
              'LEFT OUTER JOIN Pessoa P                                                                  ' +
              '       ON (L.IDPessoa = P.IDPessoa)                                                       ';

      if bHasParent then
         sSQl := sSQL + ' WHERE  L.IDLancamentoParent = ' + IntToStr(IDLancamento)
      else
         sSQl := sSQL + ' WHERE  L.IDLancamento = ' + IntToStr(IDLancamento);

      SQL.Text := sSQl;
      ExecSQL;
    end;
end;

procedure CreateAQuitar;
begin

    with DM.quFreeSQL do
      begin
        if Active then
           Close;
        SQL.Text := 'CREATE TABLE #AQuitar ( IDLancamento int NOT NULL, ' +
                    'ValorAQuitar Money NULL, ' +
                    'IDContaCorrente int NULL, ' +
                    'Favorecido VarChar(60) NULL, ' +
                    'IDQuitacaoMeio int NULL, ' +
                    'NumeroMeioQuit VarChar(60) NULL, ' +
                    'ValorDiscount Money NULL )';
        ExecSQL;
      end;
end;

function OnBeforePay:Boolean;
begin
  Result := True;
end;

function OnAfterPay:Boolean;
begin
  Result := True;
end;

function GetTotalQuitado(IDLanc:Integer):Currency;
begin

    with DM.quFreeSQL do
      begin
        if Active then
           Close;
        SQL.Text := 'SELECT SUM(IsNull(ValorQuitado,0)) FROM Fin_LancQuit Q ' +
                    'WHERE Q.IDLancamento = ' + intToStr(IDLanc);
        Open;
        Result := Fields[0].AsCurrency;
        Close;
      end;

end;

function HasDisbursement(IDLancParent:integer):Boolean;
begin

    with DM.quFreeSQL do
      begin
        if Active then
           Close;
        SQL.Text := 'SELECT L.IDLancamento FROM Fin_Lancamento L ' +
                    'WHERE L.IDLancamentoParent = ' + intToStr(IDLancParent);
        Open;
        Result := not IsEmpty; 
        Close;
      end;

end;

end.
