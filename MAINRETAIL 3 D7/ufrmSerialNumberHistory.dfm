inherited viewSerialNumberHistory: TviewSerialNumberHistory
  Left = 724
  Top = 316
  Caption = 'History Serial Numbers'
  ClientHeight = 440
  ClientWidth = 437
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 401
    Width = 437
    inherited Bevel1: TBevel
      Width = 437
    end
    inherited Panel2: TPanel
      Left = 287
      inherited Aplicar: TButton
        Left = 78
        OnClick = AplicarClick
      end
    end
  end
  object Panel3: TPanel [1]
    Left = 0
    Top = 0
    Width = 437
    Height = 401
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pgSerial: TPageControl
      Left = 0
      Top = 0
      Width = 437
      Height = 401
      ActivePage = tsOnSale
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tsOnSale: TTabSheet
        Caption = 'S/N entry'
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 429
          Height = 370
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 349
            Height = 370
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'Panel5'
            TabOrder = 0
            object Panel7: TPanel
              Left = 0
              Top = 172
              Width = 349
              Height = 29
              Align = alTop
              Caption = 'Serial Numbers '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object Panel8: TPanel
              Left = 0
              Top = 29
              Width = 349
              Height = 143
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Panel8'
              TabOrder = 1
              object gridSerialOnSale: TcxGrid
                Left = 0
                Top = 0
                Width = 349
                Height = 143
                Align = alClient
                TabOrder = 0
                LookAndFeel.Kind = lfFlat
                object gridSerialOnSaleDBTableView: TcxGridDBTableView
                  DataController.DataSource = dsSerialCurrent
                  DataController.Filter.Criteria = {FFFFFFFF0000000000}
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsCustomize.ColumnFiltering = False
                  OptionsData.Deleting = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GroupByBox = False
                  object gridSerialOnSaleDBTableViewSerialNumber: TcxGridDBColumn
                    DataBinding.FieldName = 'SerialNumber'
                    SortOrder = soDescending
                  end
                  object gridSerialOnSaleDBTableViewIdentificationNumber: TcxGridDBColumn
                    DataBinding.FieldName = 'IdentificationNumber'
                  end
                end
                object gridSerialOnSaleLevel: TcxGridLevel
                  GridView = gridSerialOnSaleDBTableView
                end
              end
            end
            object Panel9: TPanel
              Left = 0
              Top = 0
              Width = 349
              Height = 29
              Align = alTop
              Caption = 'Serial Number ( Current Sale )'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
            end
            object Panel10: TPanel
              Left = 0
              Top = 201
              Width = 349
              Height = 169
              Align = alClient
              BevelOuter = bvNone
              Caption = 'Panel8'
              TabOrder = 3
              object gridSerialNumber: TcxGrid
                Left = 0
                Top = 0
                Width = 349
                Height = 169
                Align = alClient
                TabOrder = 0
                LookAndFeel.Kind = lfFlat
                object cxGridDBTableView1: TcxGridDBTableView
                  DataController.DataSource = dsSerialNumber
                  DataController.Filter.Criteria = {FFFFFFFF0000000000}
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsCustomize.ColumnFiltering = False
                  OptionsData.Deleting = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsView.ColumnAutoWidth = True
                  OptionsView.GroupByBox = False
                  object cxGridDBColumn1: TcxGridDBColumn
                    DataBinding.FieldName = 'SerialNumber'
                    SortOrder = soAscending
                  end
                  object cxGridDBColumn2: TcxGridDBColumn
                    DataBinding.FieldName = 'IdentificationNumber'
                  end
                end
                object cxGridLevel1: TcxGridLevel
                  GridView = cxGridDBTableView1
                end
              end
            end
          end
          object Panel6: TPanel
            Left = 349
            Top = 0
            Width = 80
            Height = 370
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object btRemove: TSpeedButton
              Left = 5
              Top = 3
              Width = 74
              Height = 29
              Caption = '&Remove'
              Flat = True
              Glyph.Data = {
                06030000424D06030000000000003600000028000000100000000F0000000100
                180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
                2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
                EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
                2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
                ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
                00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
                30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
                31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
                00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
                0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
                FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
                0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FF}
            end
          end
        end
      end
      object tsInventory: TTabSheet
        Caption = 'Inventory'
        ImageIndex = 1
        object grdInvSerial: TcxGrid
          Left = 0
          Top = 0
          Width = 341
          Height = 205
          TabOrder = 0
          LookAndFeel.Kind = lfFlat
          object grdInvSerialDBTableView: TcxGridDBTableView
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'Serial'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object grdInvSerialDBTableViewName: TcxGridDBColumn
              DataBinding.FieldName = 'Name'
              Width = 163
            end
            object grdInvSerialDBTableViewSerial: TcxGridDBColumn
              DataBinding.FieldName = 'Serial'
              Width = 176
            end
          end
          object grdInvSerialLevel: TcxGridLevel
            GridView = grdInvSerialDBTableView
          end
        end
      end
      object tsTransfer: TTabSheet
        Caption = 'Transfer'
        ImageIndex = 2
        object Label4: TLabel
          Left = 10
          Top = 7
          Width = 156
          Height = 13
          Caption = 'Select serial number(s) to transfer'
        end
        object clbSerial: TCheckListBox
          Left = 0
          Top = 196
          Width = 429
          Height = 174
          Align = alBottom
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    Left = 376
    Top = 81
  end
  object dsSerialCurrent: TDataSource
    OnDataChange = dsSerialCurrentDataChange
    Left = 30
    Top = 102
  end
  object dsSerialNumber: TDataSource
    OnDataChange = dsSerialNumberDataChange
    Left = 35
    Top = 223
  end
end
