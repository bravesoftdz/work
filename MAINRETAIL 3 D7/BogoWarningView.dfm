object vwBogoWarning: TvwBogoWarning
  Left = 317
  Top = 42
  BorderStyle = bsSingle
  Caption = 'Promotion Detected'
  ClientHeight = 796
  ClientWidth = 1166
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 16
  object GrbBuy: TGroupBox
    Left = 0
    Top = 0
    Width = 1166
    Height = 361
    Align = alTop
    Caption = ' BOGO Buy X '
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object cxGridPromoConfict: TcxGrid
      Left = 2
      Top = 46
      Width = 1162
      Height = 313
      Align = alClient
      TabOrder = 0
      object cxGridDBTableViewBogoBuy: TcxGridDBTableView
        DataController.DataSource = dsBuyX
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        object cxGridDBTableViewBogoBuyDBColumn1: TcxGridDBColumn
          Caption = 'Id Promo'
          DataBinding.FieldName = 'IdDiscount'
          Visible = False
        end
        object cxGridDBTableViewBogoBuyDBColumn2: TcxGridDBColumn
          Caption = 'Promotion'
          DataBinding.FieldName = 'DiscountName'
          SortOrder = soAscending
          Width = 111
        end
        object cxGridDBTableViewBogoBuyDBColumn5: TcxGridDBColumn
          Caption = 'Tipo Promotion'
          DataBinding.FieldName = 'DiscType'
          Width = 120
        end
        object cxGridDBTableViewBogoBuyDBColumn3: TcxGridDBColumn
          Caption = 'Begin Time'
          DataBinding.FieldName = 'beginTimeOfDay'
          Width = 131
        end
        object cxGridDBTableViewBogoBuyDBColumn4: TcxGridDBColumn
          Caption = 'End Time'
          DataBinding.FieldName = 'EndTimeOfDay'
          Width = 156
        end
        object cxGridDBTableViewBogoBuyDBColumn6: TcxGridDBColumn
          Caption = ' Label (Tag )'
          DataBinding.FieldName = 'TagName'
          Width = 125
        end
        object cxGridDBColumn7: TcxGridDBColumn
          Caption = 'Model'
          DataBinding.FieldName = 'model'
          Width = 75
        end
        object cxGridDBTableViewBogoBuyDBColumn8: TcxGridDBColumn
          Caption = 'Description'
          DataBinding.FieldName = 'description'
          Width = 233
        end
        object cxGridDBTableViewBogoBuyDBColumn11: TcxGridDBColumn
          Caption = 'Buy X Quantity'
          DataBinding.FieldName = 'MinQuantity'
          Width = 125
        end
        object cxGridDBTableViewBogoBuyDBColumn15: TcxGridDBColumn
          Caption = 'Selling Price'
          DataBinding.FieldName = 'SellingPrice'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Width = 123
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = cxGridDBTableViewBogoBuy
      end
    end
    object pnlBuyWarning: TPanel
      Left = 2
      Top = 18
      Width = 1162
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      Color = clYellow
      TabOrder = 1
    end
  end
  object grbGet: TGroupBox
    Left = 0
    Top = 361
    Width = 1166
    Height = 435
    Align = alClient
    Caption = ' BOGO Get Y '
    Color = 33023
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object pnlGetWarning: TPanel
      Left = 2
      Top = 18
      Width = 1162
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      Color = 33023
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 2
      Top = 405
      Width = 1162
      Height = 28
      Align = alBottom
      BevelOuter = bvNone
      Color = clYellow
      TabOrder = 1
      object cbxKeepWarning: TCheckBox
        Left = 40
        Top = 5
        Width = 391
        Height = 17
        Caption = 'Don'#39't show anymore THIS Promotion to THIS Invoice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object cxGrid1: TcxGrid
      Left = 2
      Top = 51
      Width = 1162
      Height = 354
      Align = alClient
      TabOrder = 2
      object cxGridDBTableView1: TcxGridDBTableView
        DataController.DataSource = dsGetY
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ExpandMasterRowOnDblClick = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        object cxGridDBTableView1DBColumn6: TcxGridDBColumn
          Caption = 'Model'
          DataBinding.FieldName = 'model'
          Width = 93
        end
        object cxGridDBColumn9: TcxGridDBColumn
          Caption = 'Description'
          DataBinding.FieldName = 'description'
          SortOrder = soDescending
          Width = 250
        end
        object cxGridDBColumn12: TcxGridDBColumn
          Caption = 'Selling Price'
          DataBinding.FieldName = 'SellingPrice'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Width = 119
        end
        object cxGridDBTableView1DBColumn1: TcxGridDBColumn
          Caption = 'Discount'
          DataBinding.FieldName = 'RewardAmount'
          Width = 86
        end
        object cxGridDBTableView1DBColumn2: TcxGridDBColumn
          Caption = 'Get Y Quantity'
          DataBinding.FieldName = 'RewardQuantity'
          Width = 140
        end
        object cxGridDBTableView1DBColumn4: TcxGridDBColumn
          Caption = 'Amount Type'
          DataBinding.FieldName = 'AmountType'
          Width = 123
        end
        object cxGridDBTableView1DBColumn3: TcxGridDBColumn
          Caption = 'Is Free?'
          DataBinding.FieldName = 'IsFree'
          Width = 100
        end
        object cxGridDBTableView1DBColumn5: TcxGridDBColumn
          Caption = 'Buy And'
          DataBinding.FieldName = 'BuyAnd'
          Width = 104
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object dsBuyX: TDataSource
    Left = 177
    Top = 23
  end
  object dsGetY: TDataSource
    Left = 405
    Top = 264
  end
end
