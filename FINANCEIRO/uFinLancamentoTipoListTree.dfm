inherited FinLancamentoTipoListTree: TFinLancamentoTipoListTree
  Caption = 'FinLancamentoTipoListTree'
  PixelsPerInch = 96
  TextHeight = 13
  inherited DBTreeView: TdxDBTreeView
    DisplayField = 'CodigoContabil;LancamentoTipo'
    KeyField = 'IDLancamentoTipo'
    ListField = 'LancamentoTipo'
    ParentField = 'IDLancamentoTipoParent'
  end
  inherited ilSmallButtons: TImageList [5]
  end
  inherited quRefresh: TADOQuery [6]
  end
  inherited siLang: TsiLangRT [7]
    StorageFile = 'OM_FinLancamentoTipoListTree.sil'
  end
  inherited bmMDI: TdxBarManager [8]
    Bars = <
      item
        Caption = 'Tree'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 396
        FloatTop = 286
        FloatClientWidth = 23
        FloatClientHeight = 66
        ItemLinks = <
          item
            Item = bbNovoSubItem
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = bbAbreItem
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            Item = bbRemoveItem
            UserGlyph.Data = {00000000}
            Visible = True
          end
          item
            BeginGroup = True
            Item = btPrint
            UserGlyph.Data = {00000000}
            Visible = True
          end>
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    CanCustomize = False
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      28
      0)
    inherited bbNovoItem: TdxBarButton
      Visible = ivNever
    end
    inherited bbNovoSubItem: TdxBarButton
      Caption = 'New Item'
      Hint = 'New Item'
    end
  end
  inherited quTreeView: TADOQuery
    SQL.Strings = (
      'SELECT '
      #9'LT.IDLancamentoTipo,'
      #9'LT.IDLancamentoTipoParent,'
      #9'LT.LancamentoTipo,'
      #9'LT.CodigoContabil'
      'FROM'
      #9'Fin_LancamentoTipo LT')
    object quTreeViewIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quTreeViewIDLancamentoTipoParent: TIntegerField
      FieldName = 'IDLancamentoTipoParent'
    end
    object quTreeViewLancamentoTipo: TStringField
      FieldName = 'LancamentoTipo'
      Size = 65
    end
    object quTreeViewCodigoContabil: TStringField
      FieldName = 'CodigoContabil'
      Size = 35
    end
  end
end
