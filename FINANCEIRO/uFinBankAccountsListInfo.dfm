inherited FinBankAccountsListInfo: TFinBankAccountsListInfo
  HelpContext = 24
  Caption = 'FinBankAccountsListInfo'
  PixelsPerInch = 96
  TextHeight = 13
  inherited grid: TdxDBGrid
    ShowGroupPanel = False
    SummaryGroups = <
      item
        DefaultGroup = True
        SummaryItems = <
          item
            ColumnName = 'gridBanco'
            SummaryField = 'SaldoAtual'
            SummaryFormat = ' - Amount Total = #,##0.00'
            SummaryType = cstSum
          end
          item
            ColumnName = 'gridSaldoAtual'
            SummaryField = 'SaldoAtual'
            SummaryFormat = '#,###,##0.00'
            SummaryType = cstSum
          end>
        Name = 'SumBalance'
      end>
    Font.Style = [fsBold]
    OnClick = gridClick
    Filter.Criteria = {00000000}
    ShowHeader = False
    object gridNumero: TdxDBGridMaskColumn
      Caption = 'Account Number'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Numero'
    end
    object gridBanco: TdxDBGridMaskColumn
      Caption = ' '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Sorted = csUp
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Banco'
      GroupIndex = 0
    end
    object gridSaldoAtual: TdxDBGridMaskColumn
      Caption = 'Balance'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SaldoAtual'
      SummaryFooterType = cstSum
      SummaryFooterField = 'SaldoAtual'
      SummaryFooterFormat = '#,###,##0.00'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FinBankAccountsListInfo.sil'
  end
  inherited bmMDI: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      0
      0)
  end
  inherited quBrowse: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10'        SUM((Q.ValorQuitacao + Q.ValorJuros) * (1 - 2*Q.' +
      'Pagando)) as SaldoAtual,'#13#10#9'CC.Numero,'#13#10#9'CC.IDContaCorrente,'#13#10#9'B.' +
      'Banco'#13#10'FROM'#13#10'        Fin_Quitacao Q'#13#10#9'JOIN ('#13#10#9#9'SELECT'#13#10#9#9#9'CC.ID' +
      'ContaCorrente,'#13#10#9#9#9'CC.Numero,'#13#10#9#9#9'CC.IDBanco'#13#10#9#9'FROM'#13#10#9#9#9'Fin_Con' +
      'taCorrente CC'#13#10#9#9'WHERE'#13#10#9#9#9'Desativado = 0'#13#10#9#9' ) CC ON (CC.IDCont' +
      'aCorrente = Q.IDCOntaCorrente)'#13#10#9'JOIN Fin_Banco B ON ( CC.IDBanc' +
      'o = B.IDBanco )'#13#10#9#13#10'WHERE'#13#10'        Q.Desativado = 0'#13#10'GROUP BY'#13#10#9 +
      'CC.Numero,'#13#10#9'CC.IDContaCorrente,'#13#10#9'B.Banco'
    object quBrowseSaldoAtual: TBCDField
      FieldName = 'SaldoAtual'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBrowseNumero: TStringField
      FieldName = 'Numero'
      Size = 35
    end
    object quBrowseIDContaCorrente: TIntegerField
      FieldName = 'IDContaCorrente'
    end
    object quBrowseBanco: TStringField
      FieldName = 'Banco'
      Size = 35
    end
  end
end
