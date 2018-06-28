inherited SubGridLayout: TSubGridLayout
  Left = 246
  Top = 204
  Width = 411
  Height = 279
  Caption = 'SubGridLayout'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label23: TLabel [0]
    Left = 5
    Top = 20
    Width = 32
    Height = 13
    Caption = 'Layout'
  end
  object btnEditL: TSpeedButton [1]
    Left = 199
    Top = 16
    Width = 24
    Height = 21
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDD000000000000DDDD0FFFFFFFFFF0DDDD0F00F00000F0DDDD0FFFFFFFFFF0
      DDDD0F00F00000F0DDDD0FFFFFFFFFF0DDDD0FFFFFFF0FF0DDDD0F00FFF080F0
      DDDD0F080F0808000D440FF08080808880440000080808888844DDDDD0808888
      8844DDDDDD0888888044DDDDDDD000000D44DDDDDDDDDDDDDDDD}
    OnClick = btnEditLClick
  end
  object Label24: TLabel [2]
    Left = 259
    Top = 21
    Width = 21
    Height = 13
    Caption = 'Kind'
  end
  object cbxLayout: TComboBox [3]
    Left = 46
    Top = 16
    Width = 150
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbxLayoutChange
  end
  object cbxKind: TComboBox [4]
    Left = 290
    Top = 16
    Width = 84
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 1
    Text = 'Flat'
    OnChange = cbxKindChange
    Items.Strings = (
      'Standard'
      'Flat'
      'Ultra Flat')
  end
  object cxGrid: TcxGrid [5]
    Left = 0
    Top = 52
    Width = 403
    Height = 200
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object cxGridDB: TcxGridDBTableView
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0'
          Kind = skCount
          Column = cxGridDBDBColumn2
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.Visible = fvAlways
      OptionsData.Appending = True
      OptionsData.Deleting = False
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      object cxGridDBDBColumn1: TcxGridDBColumn
        Caption = 'Col1'
      end
      object cxGridDBDBColumn2: TcxGridDBColumn
        Caption = 'Col2'
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDB
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubGridLayout.sil'
  end
end
