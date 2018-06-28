unit uOMTranslateScript;

interface

uses uDM, uDMGlobal;

const
   //ENGLISH ********************************
   BANK_ENG =     'Update Fin_Banco Set Banco = ''Company Accounts'' Where IDBanco = 1002 ';

   BANKBRANCH_ENG =
                  'Update Fin_BancoAgencia Set BancoAgencia = ''Bank Branch'' Where IDBancoAgencia = 1001 ';

   COSTCENTER_ENG =
                  'Update Fin_CentroCusto Set CentroCusto = ''All Stores'' Where IDCentroCusto = 1 ';
   BANKACC_ENG =
                  'Update Fin_ContaCorrente Set Numero = ''CASH'' Where IDContaCorrente = 101 '+ #13#10 +
                  'Update Fin_ContaCorrente Set Numero = ''CHECKING ACCT'' Where IDContaCorrente = 104 '+ #13#10 +
                  'Update Fin_ContaCorrente Set Numero = ''PETTY CASH'' Where IDContaCorrente = 105 ';

   DISBURS_ENG =
                  'Update Fin_DesdobramentoTipo Set DesdobramentoTipo = ''Multiple'', IdentificadorDesdobramento = ''Multiple #'' Where IDDesdobramentoTipo = 1001 ';

   CHARTACC_ENG =
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Incoming'' Where IDLancamentoTipo = 0 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Expenses'' Where IDLancamentoTipo = 1 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Sales'' Where IDLancamentoTipo = 2 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Commission Refunds'' Where IDLancamentoTipo = 3 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Commission'' Where IDLancamentoTipo = 4 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Commission Corrections'' Where IDLancamentoTipo = 5 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Commission Payments'' Where IDLancamentoTipo = 6 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Cost of good'' Where IDLancamentoTipo = 7 ';

   //PORTUGUESE ********************************
   BANK_BR =      'Update Fin_Banco Set Banco = ''Banco Empresa'' Where IDBanco = 1002';

   BANKBRANCH_BR =
                  'Update Fin_BancoAgencia Set BancoAgencia = ''Ag. Bancária'' Where IDBancoAgencia = 1001';

   COSTCENTER_BR =
                  'Update Fin_CentroCusto Set CentroCusto = ''Todas as lojas'' Where IDCentroCusto = 1 ';

   BANKACC_BR =
                  'Update Fin_ContaCorrente Set Numero = ''CAIXA'' Where IDContaCorrente = 101 '+ #13#10 +
                  'Update Fin_ContaCorrente Set Numero = ''CONTA CORRENTE'' Where IDContaCorrente = 104 '+ #13#10 +
                  'Update Fin_ContaCorrente Set Numero = ''CAIXA PEQ.'' Where IDContaCorrente = 105 ';

   DISBURS_BR =
                  'Update Fin_DesdobramentoTipo Set DesdobramentoTipo = ''Múltiplo'', IdentificadorDesdobramento = ''Nº Parcela'' Where IDDesdobramentoTipo = 1001 ';

   CHARTACC_BR =
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Receitas'' Where IDLancamentoTipo = 0 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Despesas'' Where IDLancamentoTipo = 1 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Vendas'' Where IDLancamentoTipo = 2 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comissão Reembolso'' Where IDLancamentoTipo = 3 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comissão'' Where IDLancamentoTipo = 4 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comissão Correções'' Where IDLancamentoTipo = 5 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comissão Pagamento'' Where IDLancamentoTipo = 6 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Custo de Mercadorias'' Where IDLancamentoTipo = 7 ';


   //SPANISH ********************************
   BANK_SPN =      'Update Fin_Banco Set Banco = ''Cuenta'' Where IDBanco = 1002';

   BANKBRANCH_SPN =
                  'Update Fin_BancoAgencia Set BancoAgencia = ''Rama Bancaria'' Where IDBancoAgencia = 1001';

   COSTCENTER_SPN =
                  'Update Fin_CentroCusto Set CentroCusto = ''Todo Tiendas'' Where IDCentroCusto = 1 ';

   BANKACC_SPN =
                  'Update Fin_ContaCorrente Set Numero = ''DINERO EFECTIVO'' Where IDContaCorrente = 101 '+ #13#10 +
                  'Update Fin_ContaCorrente Set Numero = ''CUENTA CORRIENTE'' Where IDContaCorrente = 104 '+ #13#10 +
                  'Update Fin_ContaCorrente Set Numero = ''CAJA CHICA'' Where IDContaCorrente = 105 ';

   DISBURS_SPN =
                  'Update Fin_DesdobramentoTipo Set DesdobramentoTipo = ''Múltiplo'', IdentificadorDesdobramento = ''Nº Múltiplo'' Where IDDesdobramentoTipo = 1001 ';

   CHARTACC_SPN =
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Entrante'' Where IDLancamentoTipo = 0 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Gastos'' Where IDLancamentoTipo = 1 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Ventas'' Where IDLancamentoTipo = 2 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comisión Reintegra'' Where IDLancamentoTipo = 3 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comisión'' Where IDLancamentoTipo = 4 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comisionar las Correcciones'' Where IDLancamentoTipo = 5 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Comisionar los Pagos'' Where IDLancamentoTipo = 6 '+ #13#10 +
                  'Update Fin_LancamentoTipo Set LancamentoTipo = ''Costo de mercadorias'' Where IDLancamentoTipo = 7 ';


procedure TranslateDatabase(Language:Integer);

implementation

uses ADODB;

procedure TranslateDatabase(Language:Integer);
begin
   Case Language of
     LANG_ENGLISH: begin
                   with DM.quFreeSQL do
                      begin
                      if Active then
                         Close;
                      try
                        Connection.BeginTrans;
                        SQL.Text := BANK_ENG;
                        ExecSQL;
                        SQL.Text := BANKBRANCH_ENG;
                        ExecSQL;
                        SQL.Text := COSTCENTER_ENG;
                        ExecSQL;
                        SQL.Text := BANKACC_ENG;
                        ExecSQL;
                        SQL.Text := DISBURS_ENG;
                        ExecSQL;
                        SQL.Text := CHARTACC_ENG;
                        ExecSQL;
                        Connection.CommitTrans;
                      except
                        Connection.RollbackTrans;
                        end;
                      end;
                   end; //End Engligh

     LANG_PORTUGUESE: begin
                   with DM.quFreeSQL do
                      begin
                      if Active then
                         Close;
                      try
                        Connection.BeginTrans;
                        SQL.Text := BANK_BR;
                        ExecSQL;
                        SQL.Text := BANKBRANCH_BR;
                        ExecSQL;
                        SQL.Text := COSTCENTER_BR;
                        ExecSQL;
                        SQL.Text := BANKACC_BR;
                        ExecSQL;
                        SQL.Text := DISBURS_BR;
                        ExecSQL;
                        SQL.Text := CHARTACC_BR;
                        ExecSQL;
                        Connection.CommitTrans;
                      except
                        Connection.RollbackTrans;
                        end;
                      end;
                   end; //End Portuguese

     LANG_SPANISH: begin
                   with DM.quFreeSQL do
                      begin
                      if Active then
                         Close;
                      try
                        Connection.BeginTrans;
                        SQL.Text := BANK_SPN;
                        ExecSQL;
                        SQL.Text := BANKBRANCH_SPN;
                        ExecSQL;
                        SQL.Text := COSTCENTER_SPN;
                        ExecSQL;
                        SQL.Text := BANKACC_SPN;
                        ExecSQL;
                        SQL.Text := DISBURS_SPN;
                        ExecSQL;
                        SQL.Text := CHARTACC_SPN;
                        ExecSQL;
                        Connection.CommitTrans;
                      except
                        Connection.RollbackTrans;
                        end;
                      end;
                   end; //End Spanish
   end;

end;

end.
