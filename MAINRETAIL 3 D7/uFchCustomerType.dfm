inherited FchCustomerType: TFchCustomerType
  Left = 352
  Top = 55
  Caption = 'FchCustomerType'
  ClientHeight = 381
  ClientWidth = 427
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 427
    DesignSize = (
      427
      40)
    inherited Image1: TImage
      Width = 153
    end
    inherited lblMenu: TLabel
      Left = 166
    end
    inherited EspacamentoSuperior: TPanel
      Width = 427
      inherited EEE: TPanel
        Width = 427
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 380
    end
  end
  inherited Panel1: TPanel
    Top = 340
    Width = 427
    inherited EspacamentoInferior: TPanel
      Width = 427
      inherited Panel3: TPanel
        Width = 427
      end
    end
    inherited hhh: TPanel
      Left = 206
    end
  end
  inherited pnlKey: TPanel
    Width = 427
    inherited Panel4: TPanel
      Width = 427
    end
  end
  inherited pnlDetail: TPanel
    Width = 421
    Height = 260
    object lblCustomerType: TLabel
      Left = 36
      Top = 6
      Width = 89
      Height = 13
      Alignment = taRightJustify
      Caption = 'Commission Type :'
      FocusControl = edtCustomerType
    end
    object lblCustomerTypeRequired: TLabel
      Left = 355
      Top = 3
      Width = 14
      Height = 23
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlDiscount: TPanel
      Left = 0
      Top = 36
      Width = 421
      Height = 223
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 1
      object pnlDiscountTitle: TPanel
        Left = 0
        Top = 0
        Width = 421
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Discounts for this Customer Type'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object grdDiscount: TcxGrid
        Left = 0
        Top = 16
        Width = 421
        Height = 207
        Align = alClient
        TabOrder = 1
        OnEnter = grdDiscountEnter
        OnExit = grdDiscountExit
        LookAndFeel.Kind = lfFlat
        object grdDiscountDB: TcxGridDBTableView
          OnKeyUp = grdDiscountDBKeyUp
          DataController.DataSource = dtsDiscount
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDGroup'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubSellingPrice'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubFinalCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubVendorCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubFreightCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubOtherCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubRealMarkUpValue'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubSuggRetail'
            end
            item
              Format = '0'
              Kind = skSum
              Position = spFooter
              FieldName = 'PositiveQty'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubSellingPrice'
            end>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdDiscountDBIDTipoPessoa: TcxGridDBColumn
            DataBinding.FieldName = 'IDTipoPessoa'
            Visible = False
          end
          object grdDiscountDBIDGroup: TcxGridDBColumn
            DataBinding.FieldName = 'IDGroup'
            Visible = False
          end
          object grdDiscountDBCategory: TcxGridDBColumn
            DataBinding.FieldName = 'Category'
            Options.Editing = False
            Options.Filtering = False
            Width = 299
          end
          object grdDiscountDBDiscount: TcxGridDBColumn
            DataBinding.FieldName = 'Discount'
            Width = 120
          end
        end
        object grdDiscountLevel: TcxGridLevel
          GridView = grdDiscountDB
        end
      end
    end
    object edtCustomerType: TDBEdit
      Left = 130
      Top = 1
      Width = 221
      Height = 21
      DataField = 'TipoCliente'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 260
  end
  inherited EspacamentoDireito: TPanel
    Left = 424
    Height = 260
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchCustomerType.sil'
  end
  object quDiscount: TADODataSet [7]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'CD.IDTipoPessoa,'#13#10#9'TG.IDGroup,'#13#10#9'IsNull(CD.Discount, 0)' +
      ' Discount,'#13#10#9'TG.Name Category'#13#10'FROM'#13#10#9'TabGroup TG (NOLOCK)'#13#10#9'LEF' +
      'T OUTER JOIN  Ent_CustomerDiscount CD (NOLOCK) ON (CD.IDGroup = ' +
      'TG.IDGroup AND CD.IDTipoPessoa = :IDTipoPessoa)'#13#10'WHERE'#13#10#9'TG.Desa' +
      'tivado = 0'#13#10#9'AND'#13#10#9'TG.Hidden = 0'
    Parameters = <
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 380
    Top = 44
    object quDiscountIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quDiscountIDGroup: TIntegerField
      FieldName = 'IDGroup'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object quDiscountCategory: TStringField
      FieldName = 'Category'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quDiscountDiscount: TFloatField
      FieldName = 'Discount'
      ProviderFlags = [pfInUpdate]
    end
  end
  object dtsDiscount: TDataSource [8]
    DataSet = cdsDiscount
    Left = 380
    Top = 192
  end
  object dspDiscount: TDataSetProvider [9]
    DataSet = quDiscount
    Options = [poIncFieldProps]
    OnGetTableName = dspDiscountGetTableName
    Left = 380
    Top = 92
  end
  object cdsDiscount: TClientDataSet [10]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDiscount'
    Left = 379
    Top = 140
  end
  object cmdInsDiscount: TADOCommand [11]
    CommandText = 
      'INSERT INTO Ent_CustomerDiscount (IDTipoPessoa, IDGroup, Discoun' +
      't)'#13#10'VALUES (:IDTipoPessoa, :IDGroup, :Discount)'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Discount'
        Attributes = [paSigned]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end>
    Left = 75
    Top = 236
  end
  object cmdUpdDiscount: TADOCommand [12]
    CommandText = 
      'UPDATE Ent_CustomerDiscount SET Discount = :Discount WHERE IDTip' +
      'oPessoa = :IDTipoPessoa AND IDGroup = :IDGroup'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Discount'
        Attributes = [paSigned]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 75
    Top = 288
  end
  inherited dsForm: TDataSource
    Left = 12
    Top = 188
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT'#13#10#9'TC.IDTipoCliente,'#13#10#9'TC.TipoCliente,'#13#10#9'TC.Path,'#13#10#9'TC.Pat' +
      'hName'#13#10'FROM'#13#10#9'vwTipoCliente TC'#13#10'WHERE'#13#10#9'TC.IDTipoCliente = :IDTi' +
      'poCliente'
    Parameters = <
      item
        Name = 'IDTipoCliente'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 12
    Top = 140
    object quFormIDTipoCliente: TIntegerField
      FieldName = 'IDTipoCliente'
    end
    object quFormTipoCliente: TStringField
      FieldName = 'TipoCliente'
      Size = 50
    end
    object quFormPath: TStringField
      FieldName = 'Path'
      Size = 150
    end
    object quFormPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
  end
  inherited FormConfig: TFormConfig
    Left = 12
    Top = 92
  end
end
