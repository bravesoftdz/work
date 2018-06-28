unit uFisPersistence;

interface

Uses SysUtils, uDM, Classes, uHandleError, EFiscal, uNumericFunctions;

function AddTipo60ResumoDiario(ACaller : TComponent; nIDInvoice: Integer): Boolean;
function AddTipo60ResumoItem(ACaller : TComponent; nIDInvoice: Integer; stlpreInvID: TStringList): Boolean;

implementation


function AddTipo60ResumoDiario(ACaller : TComponent; nIDInvoice: Integer): Boolean;
Var
  sNumeroSerie,
  sData,
  sHora: String;
  dDataImpressora: TDateTime;
  OldShortDateFormat : String;
Const
  sSQL = 'SELECT NumeroSerie FROM Fis_Registro60ResumoDiario ' +
          'WHERE NumeroSerie = %S AND ' +
          'DataEmissao = Convert(DateTime, %S, 3) AND '+
          'CodigoProdutoServico = %S';

  sSQLInsert = 'INSERT INTO Fis_Registro60ResumoDiario' +
                '(DataEmissao, NumeroSerie, CodigoProdutoServico, Qtde,' +
                'ValorProdutoServico,BaseCalculoICMS, ValorICMS,'+
                ' SituacaoTributaria)'+
                'VALUES (Convert(DateTime, %S, 3), %S, %S, %S, %S, %S, %S, %S)';


  sSQLUpdate = 'UPDATE Fis_Registro60ResumoDiario SET ' +
               'Qtde = Qtde + %S, '+
               'ValorProdutoServico = ValorProdutoServico + %S, ' +
               'BaseCalculoICMS = BaseCalculoICMS + %S, ' +
               'ValorICMS = ValorICMS + %S ' +
               'WHERE DataEmissao = Convert(DateTime, %S, 3) AND '+
               ' NumeroSerie = %S AND CodigoProdutoServico = %S';

begin
  Result := True;
  Try
    sNumeroSerie := DM.EFiscal1.IncChar(sNumeroSerie, 15, ' ', 'L');
    DM.EFiscal1.NumeroSerie(sNumeroSerie);
    sNumeroSerie := Trim(sNumeroSerie);

    sData := DM.EFiscal1.IncChar(sData, 6, ' ', 'L');
    sHora := DM.EFiscal1.IncChar(sHora, 6, ' ', 'L');

    DM.EFiscal1.DataHoraImpressora(sData, sHora);

    OldShortDateFormat := ShortDateFormat;
    Try
      ShortDateFormat := 'dd/mm/yy';
      If Pos('/', sData) = 0 Then
        dDataImpressora := StrToDate(Copy(sData, 1, 2) + '/' + Copy(sData, 3, 2) + '/' + Copy(sData, 5, 2))
      Else
        dDataImpressora := StrToDate(sData);

      With DM.quFreeSQL Do
      Try
        If Active Then Close;
        SQL.Clear;
        SQL.Add('SELECT');
        SQL.Add('  Fis.CodFiscal,');
        SQL.Add('  SUM(InventoryMov.Qty) SumQty,');
        SQL.Add('  SUM(InventoryMov.SalePrice * InventoryMov.Qty) SumSalePrice,');
        SQL.Add('  SUM((InventoryMov.SalePrice * InventoryMov.Qty) - InventoryMov.Discount) CalcBase,');
        SQL.Add('  LTRIM(STR(InventoryMovTax.Tax * 10000)) AS Tax,');
        SQL.Add('  (SUM((InventoryMov.SalePrice * InventoryMov.Qty) - InventoryMov.Discount) * InventoryMovTax.Tax)AS ValorICMS');
        SQL.Add('FROM');
        SQL.Add('  InventoryMov (NOLOCK) INNER JOIN');
        SQL.Add('  Model (NOLOCK)');
        SQL.Add('    ON InventoryMov.ModelID = Model.IDModel INNER JOIN');
        SQL.Add('  (SELECT Model.IDModel, COALESCE(MIN(BarCode.IDBARCODE), Model) AS CodFiscal FROM Model LEFT JOIN BARCODE ON (Model.IDModel = BarCode.IDModel) GROUP BY Model.IDModel, Model.Model) Fis');
        SQL.Add('    ON Model.IDModel = Fis.IDModel INNER JOIN');
        SQL.Add('  InventoryMovTax (NOLOCK)');
        SQL.Add('    ON InventoryMov.IDInventoryMov = InventoryMovTax.IDInventoryMov');
        SQL.Add('WHERE');
        SQL.Add('  InventoryMov.InventMovTypeID = 1');
        SQL.Add(Format('  AND DocumentID = %D', [nIDInvoice]));
        SQL.Add('GROUP BY');
        SQL.Add('  Fis.CodFiscal,');
        SQL.Add('  InventoryMovTax.Tax');
        Open;
        While Not EOF Do
        begin
          // Aqui verificar se existe senão, deve inserir.
          If DM.SelectReturnsRow(ACaller, Format(sSQL,
                                              [sNumeroSerie,
                                               QuotedStr(FormatDateTime('dd/mm/yy', dDataImpressora)),
                                               QuotedStr(FieldByName('CodFiscal').AsString)])) Then
          begin
            Result := Result And
            DM.DynamicRunSQL(ACaller,
                               Format(sSQLUpdate,
                                      [
                                      MyFormatCur(FieldByName('SumQty').AsFloat, '.'),
                                      MyFormatCur(FieldByName('SumSalePrice').AsFloat, '.'),
                                      MyFormatCur(FieldByName('CalcBase').AsFloat, '.'),
                                      MyFormatCur(FieldByName('ValorICMS').AsFloat, '.'),
                                      QuotedStr(FormatDateTime('dd/mm/yy', dDataImpressora)),
                                      QuotedStr(sNumeroSerie),
                                      QuotedStr(FieldByName('CodFiscal').AsString)]));
          end
          Else
            begin
              Result := Result And
              DM.DynamicRunSQL(ACaller,
                               Format(sSQLInsert,
                                      [QuotedStr(FormatDateTime('dd/mm/yy', dDataImpressora)),
                                      sNumeroSerie,
                                      QuotedStr(FieldByName('CodFiscal').AsString),
                                      MyFormatCur(FieldByName('SumQty').AsFloat, '.'),
                                      MyFormatCur(FieldByName('SumSalePrice').AsFloat, '.'),
                                      MyFormatCur(FieldByName('CalcBase').AsFloat, '.'),
                                      MyFormatCur(FieldByName('ValorICMS').AsFloat, '.'),
                                      QuotedStr(DM.EFiscal1.IncCharEx(FieldByName('Tax').AsString, 4, '0','L'))]));
            end;
          Next;
        end;

      Finally
        Close;
      End;
    Finally
      ShortDateFormat := OldShortDateFormat;
    End;
  Except
    On E: Exception Do
    begin
      Result := False;
      DM.SetError(CRITICAL_ERROR, ACaller.Name, 'FrmFastSale.AddTipo60ResumoDiario' + #13#10 + E.Message);
    end;
  End;
end;


function AddTipo60ResumoItem(ACaller : TComponent; nIDInvoice: Integer; stlpreInvID: TStringList): Boolean;
Var
  sNumeroCupom,
  sData,
  sHora: String;
  dDataImpressora: TDateTime;
  OldShortDateFormat : String;
  RegTipo60Mestre : TRegTipo60Mestre;
Const
  sSQLInsert = 'INSERT INTO Fis_Registro60Item' +
                '(DataEmissao, NumeroSerie, NumeroOrdem, NumeroItem, ' +
                'CodigoProdutoServico, Qtde, ValorUnitario, '+
                'BaseCalculoICMS, ValorICMS, SituacaoTributaria, ModeloDocumentoFiscal) ' +
                'VALUES (Convert(DateTime, %S, 3), %S, %S, %S, %S, %S, %S, %S, %S, %S, %S)';
begin
  Result := True;
  Try
    DM.EFiscal1.RelatorioTipo60Mestre(RegTipo60Mestre);

    sNumeroCupom := DM.EFiscal1.IncCharEx(sNumeroCupom, 6, ' ', 'L');
    DM.EFiscal1.NumeroCupom(sNumeroCupom);
    sNumeroCupom := Trim(sNumeroCupom);

    sData := DM.EFiscal1.IncCharEx(sData, 6, ' ', 'L');
    sHora := DM.EFiscal1.IncCharEx(sHora, 6, ' ', 'L');

    DM.EFiscal1.DataHoraImpressora(sData, sHora);

    OldShortDateFormat := ShortDateFormat;
    Try
      ShortDateFormat := 'dd/mm/yy';
      If Pos('/', sData) = 0 Then
        dDataImpressora := StrToDate(Copy(sData, 1, 2) + '/' + Copy(sData, 3, 2) + '/' + Copy(sData, 5, 2))
      Else
        dDataImpressora := StrToDate(sData);

      With DM.quFreeSQL Do
      Try
        If Active Then Close;
        SQL.Clear;
        SQL.Add('SELECT');
        SQL.Add('  InventoryMov.PreInventoryMovID,');
        SQL.Add('  Fis.CodFiscal,');
        SQL.Add('  InventoryMov.Qty,');
        SQL.Add('  InventoryMov.SalePrice,');
        SQL.Add('  (InventoryMov.SalePrice * InventoryMov.Qty) - Discount  AS BaseCalcICMS,');
        SQL.Add('  STR(InventoryMovTax.Tax * 10000, 4, 0) Tax,');
        SQL.Add('  ((InventoryMov.SalePrice * InventoryMov.Qty) - Discount) * InventoryMovTax.Tax as ValorICMS');
        SQL.Add('FROM');
        SQL.Add('  InventoryMov INNER JOIN');
        SQL.Add('  Model');
        SQL.Add('    ON InventoryMov.ModelID = Model.IDModel INNER JOIN');
        SQL.Add('  (SELECT Model.IDModel, COALESCE(MIN(BarCode.IDBARCODE), Model) AS CodFiscal FROM Model LEFT JOIN BARCODE ON (Model.IDModel = BarCode.IDModel) GROUP BY Model.IDModel, Model.Model) Fis');
        SQL.Add('    ON Model.IDModel = Fis.IDModel INNER JOIN');
        SQL.Add('  InventoryMovTax');
        SQL.Add('    ON InventoryMov.IDInventoryMov = InventoryMovTax.IDInventoryMov');
        SQL.Add('WHERE');
        SQL.Add('  InventoryMov.InventMovTypeID = 1');
        SQL.Add(Format('  AND DocumentID = %D', [nIDInvoice]));
        Open;
        While Not EOF Do
        begin
          Result := Result And
          DM.DynamicRunSQL(ACaller,
                           Format(sSQLInsert,
                                  [QuotedStr(FormatDateTime('dd/mm/yy', dDataImpressora)),
                                  Trim(RegTipo60Mestre.sNumeroSerie),
                                  sNumeroCupom,
                                  IntToStr(stlpreInvID.IndexOf(FieldByName('PreInventoryMovID').AsString)+1),
                                  QuotedStr(FieldByName('CodFiscal').AsString),
                                  MyFormatCur(FieldByName('Qty').AsFloat, '.'),
                                  MyFormatCur(FieldByName('SalePrice').AsFloat, '.'),
                                  MyFormatCur(FieldByName('BaseCalcICMS').AsFloat, '.'),
                                  MyFormatCur(FieldByName('ValorICMS').AsFloat, '.'),
                                  QuotedStr(DM.EFiscal1.IncCharEx(Trim(FieldByName('Tax').AsString), 4, '0','L')),
                                  QuotedStr(Trim(RegTipo60Mestre.sModelo))]));
          Next;
        end;

      Finally
        Close;
      End;
    Finally
      ShortDateFormat := OldShortDateFormat;
    End;
  Except
    On E: Exception Do
    begin
      Result := False;
      DM.SetError(CRITICAL_ERROR, ACaller.Name, 'FrmFastSale.AddTipo60ResumoDiario' + #13#10 + E.Message);
    end;
  End;
end;

end.
