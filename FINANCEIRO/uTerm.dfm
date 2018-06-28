object Term: TTerm
  Left = 240
  Top = 205
  Width = 379
  Height = 301
  Caption = 'Term'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label14: TLabel
    Left = 5
    Top = 30
    Width = 277
    Height = 13
    Caption = 'Registre aqui os descontos para pagamentos antecipados.'
  end
  object btNew: TSpeedButton
    Left = 294
    Top = 55
    Width = 70
    Height = 25
    Caption = 'New'
    Enabled = False
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      888888888888888888888800000000000888880FFFFFFFFF0888880FFFFFFFFF
      0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF
      0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F0
      8888880FFFFFF008888888000000008888888888888888888888}
    Margin = 3
    OnClick = btNewClick
  end
  object btDelete: TSpeedButton
    Tag = 2
    Left = 294
    Top = 80
    Width = 70
    Height = 25
    Caption = 'Remove'
    Enabled = False
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888888888888888888888808888888888088800088888888888880000888888
      8088888000888888088888880008888008888888800088008888888888000008
      8888888888800088888888888800000888888888800088008888888000088880
      0888880000888888008888000888888888088888888888888888}
    Margin = 3
    OnClick = btDeleteClick
  end
  object btPost: TSpeedButton
    Left = 294
    Top = 110
    Width = 70
    Height = 25
    Caption = 'Ok'
    Flat = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    Margin = 3
    NumGlyphs = 2
    OnClick = btPostClick
  end
  object btCancelPost: TSpeedButton
    Tag = 2
    Left = 294
    Top = 135
    Width = 70
    Height = 25
    Caption = 'Cancel'
    Flat = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    Margin = 3
    NumGlyphs = 2
    OnClick = btCancelPostClick
  end
  object Panel8: TPanel
    Left = 0
    Top = 0
    Width = 371
    Height = 18
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = '  Default Terms for this vendor'
    Color = clBtnShadow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object grdTerm: TdxDBGrid
    Left = 5
    Top = 55
    Width = 286
    Height = 211
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'DueDateShift'
    SummaryGroups = <>
    SummarySeparator = ', '
    TabOrder = 1
    OnKeyDown = grdTermKeyDown
    LookAndFeel = lfFlat
    Options = [egoColumnSizing, egoColumnMoving, egoEditing, egoTabs, egoTabThrough, egoCanDelete, egoConfirmDelete, egoCanNavigation, egoCancelOnExit, egoImmediateEditor, egoCanInsert, egoLoadAllRecords, egoAutoWidth]
    OptionsEx = [egoUseBitmap, egoBandHeaderWidth, egoBandSizing, egoBandMoving, egoVertThrough, egoEnterThrough, egoEnterShowEditor, egoDragScroll, egoAutoSort]
    object grdTermDueDateShift: TdxDBGridMaskColumn
      Caption = 'Days'
      Sorted = csUp
      BandIndex = 0
      RowIndex = 0
      FieldName = 'DueDateShift'
    end
    object grdTermDiscount: TdxDBGridMaskColumn
      Caption = 'Discount % '
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Discount'
    end
  end
  object quTerm: TQuery
    OnNewRecord = quTermNewRecord
    DatabaseName = 'RETAILDB'
    RequestLive = True
    SQL.Strings = (
      'SELECT'
      '      IDPessoa,'
      '      DueDateShift,'
      '      Discount'
      'FROM'
      '      PessoaTerm PT'
      'WHERE'
      '      PT.IDPessoa = :IDPessoa')
    Left = 317
    Top = 176
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IDPessoa'
        ParamType = ptUnknown
      end>
    object quTermIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Origin = 'RETAILDB.PessoaTerm.IDPessoa'
    end
    object quTermDueDateShift: TIntegerField
      FieldName = 'DueDateShift'
      Origin = 'RETAILDB.PessoaTerm.DueDateShift'
    end
    object quTermDiscount: TIntegerField
      FieldName = 'Discount'
      Origin = 'RETAILDB.PessoaTerm.Discount'
      DisplayFormat = '#0.00 %'
    end
  end
  object dsTerm: TDataSource
    DataSet = quTerm
    OnStateChange = dsTermStateChange
    Left = 317
    Top = 226
  end
end
