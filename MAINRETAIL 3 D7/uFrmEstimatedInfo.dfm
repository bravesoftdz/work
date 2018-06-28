inherited FrmEstimatedInfo: TFrmEstimatedInfo
  Left = 211
  Top = 215
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Estimated Info'
  ClientHeight = 299
  ClientWidth = 389
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 258
    Width = 389
    inherited EspacamentoInferior: TPanel
      Width = 389
      inherited Panel3: TPanel
        Width = 389
      end
    end
    inherited hhh: TPanel
      Left = 151
      Width = 238
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 169
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 100
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 252
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 386
    Height = 252
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 389
    Visible = False
  end
  object pgInfo: TPageControl [4]
    Left = 3
    Top = 6
    Width = 383
    Height = 252
    ActivePage = tsPayments
    Align = alClient
    TabOrder = 4
    object tsDeliver: TTabSheet
      Caption = 'Deliver'
      object Label4: TLabel
        Left = 24
        Top = 38
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type :'
      end
      object Label2: TLabel
        Left = 338
        Top = 37
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
      object cmbDelType: TDBSuperComboADO
        Tag = 2
        Left = 58
        Top = 35
        Width = 276
        Height = 21
        TabOrder = 0
        Text = 'cmbDelType'
        LookUpSource = DM.dsLookUpDeliverType
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        ShowEditCode = True
        IDLanguage = 0
        DataField = 'IDDeliverType'
        DataSource = dsUpEstimated
      end
      object pnlConfirmDeliver: TPanel
        Left = 0
        Top = 75
        Width = 375
        Height = 149
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Label6: TLabel
          Left = 10
          Top = 16
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'Address :'
        end
        object Label5: TLabel
          Left = 27
          Top = 87
          Width = 29
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date :'
          Visible = False
        end
        object Label28: TLabel
          Left = 27
          Top = 53
          Width = 28
          Height = 13
          Caption = 'OBS :'
          FocusControl = edtDelOBS
        end
        object Label1: TLabel
          Left = 336
          Top = 13
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
        object EditDelDate: TDBDateBox
          Tag = 2
          Left = 58
          Top = 84
          Width = 96
          Height = 21
          ReadOnly = False
          TabOrder = 0
          Visible = False
          Language = Portuguese
          DataField = 'DeliverDate'
          DataSource = dsUpEstimated
        end
        object EditDelAddress: TDBEdit
          Tag = 2
          Left = 58
          Top = 13
          Width = 276
          Height = 21
          DataField = 'DeliverAddress'
          DataSource = dsUpEstimated
          TabOrder = 1
        end
        object edtDelOBS: TDBEdit
          Left = 58
          Top = 49
          Width = 276
          Height = 21
          DataField = 'DeliverOBS'
          DataSource = dsUpEstimated
          TabOrder = 2
        end
      end
    end
    object tsPayments: TTabSheet
      Caption = 'Payments'
      ImageIndex = 1
      object Label12: TLabel
        Left = 0
        Top = 8
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Caption = 'Payment Type :'
      end
      object lbObs: TLabel
        Left = 45
        Top = 31
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'OBS :'
      end
      object lbAmount: TLabel
        Left = 211
        Top = 8
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Amount :'
      end
      object btnAdd: TSpeedButton
        Left = 256
        Top = 52
        Width = 54
        Height = 22
        Caption = 'Add'
        Margin = 4
        OnClick = btnAddClick
      end
      object btnDell: TSpeedButton
        Left = 313
        Top = 52
        Width = 53
        Height = 22
        Caption = 'Delete'
        Margin = 4
        OnClick = btnDellClick
      end
      object lbDate: TLabel
        Left = 223
        Top = 33
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date :'
      end
      object grdBrowse: TcxGrid
        Left = 0
        Top = 75
        Width = 375
        Height = 149
        Align = alBottom
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdBrowseDB: TcxGridDBTableView
          DataController.DataSource = dsUpPayment
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPaymentCondition'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Amount'
              Column = grdBrowseDBAmount
            end>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.Column = grdBrowseDBOBS
          Preview.MaxLineCount = 1
          Preview.Visible = True
          object grdBrowseDBImageIndex: TcxGridDBColumn
            Caption = '    '
            DataBinding.FieldName = 'ImageIndex'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = DMGlobal.imgPayments
            Properties.Items = <
              item
                ImageIndex = 0
                Value = '0'
              end
              item
                ImageIndex = 1
                Value = '1'
              end
              item
                ImageIndex = 2
                Value = '2'
              end
              item
                ImageIndex = 3
                Value = '3'
              end
              item
                ImageIndex = 4
                Value = '4'
              end
              item
                ImageIndex = 5
                Value = '5'
              end
              item
                ImageIndex = 6
                Value = '6'
              end
              item
                ImageIndex = 7
                Value = '67'
              end
              item
                ImageIndex = 8
                Value = '8'
              end
              item
                ImageIndex = 9
                Value = '9'
              end
              item
                ImageIndex = 10
                Value = '10'
              end
              item
                ImageIndex = 11
                Value = '11'
              end
              item
                ImageIndex = 12
                Value = '12'
              end
              item
                ImageIndex = 13
                Value = '13'
              end
              item
                ImageIndex = 14
                Value = '14'
              end
              item
                ImageIndex = 15
                Value = '15'
              end>
            Properties.LargeImages = DMGlobal.imgPayments
            Width = 26
          end
          object grdBrowseDBMeioPag: TcxGridDBColumn
            DataBinding.FieldName = 'MeioPag'
            Width = 183
          end
          object grdBrowseDBEstimetedDate: TcxGridDBColumn
            DataBinding.FieldName = 'EstimetedDate'
            Width = 84
          end
          object grdBrowseDBAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            Width = 80
          end
          object grdBrowseDBOBS: TcxGridDBColumn
            DataBinding.FieldName = 'OBS'
            Width = 198
          end
        end
        object grdBrowseLevel: TcxGridLevel
          GridView = grdBrowseDB
        end
      end
      object cmbPayType: TSuperComboADO
        Tag = 1
        Left = 78
        Top = 4
        Width = 125
        Height = 21
        TabOrder = 1
        LookUpSource = DM.dsLookUpMeioPag
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object edtObs: TEdit
        Left = 78
        Top = 27
        Width = 125
        Height = 21
        Ctl3D = True
        MaxLength = 100
        ParentCtl3D = False
        TabOrder = 2
      end
      object EditSalePrice: TSuperEditCurrency
        Left = 256
        Top = 3
        Width = 109
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        Text = '0.00'
        OnClick = EditSalePriceClick
        OnEnter = EditSalePriceEnter
        OnKeyPress = EditSalePriceKeyPress
        Alignment = taRightJustify
        DisplayFormat = '0.00'
      end
      object dtPayment: TDateBox
        Left = 256
        Top = 28
        Width = 110
        Height = 21
        TabOrder = 4
        InputTime = False
      end
    end
  end
  object quUpEstimated: TPowerADOQuery [5]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'E.IDEstimated,'#13#10#9'E.IDDeliverType,'#13#10#9'E.DeliverDate,'#13#10#9'E' +
      '.DeliverAddress,'#13#10#9'E.DeliverOBS,'#13#10#9'E.TotalDiscount,'#13#10#9'E.Confirme' +
      'd'#13#10'FROM'#13#10#9'Estimated E (NOLOCK) '#13#10'WHERE'#13#10#9'E.IDEstimated = :IDEsti' +
      'mated'#13#10#9
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDEstimated'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 44
    Top = 133
    object quUpEstimatedIDEstimated: TIntegerField
      FieldName = 'IDEstimated'
    end
    object quUpEstimatedIDDeliverType: TIntegerField
      FieldName = 'IDDeliverType'
    end
    object quUpEstimatedDeliverDate: TDateTimeField
      FieldName = 'DeliverDate'
    end
    object quUpEstimatedDeliverAddress: TStringField
      FieldName = 'DeliverAddress'
      Size = 100
    end
    object quUpEstimatedDeliverOBS: TStringField
      FieldName = 'DeliverOBS'
      Size = 255
    end
    object quUpEstimatedTotalDiscount: TBCDField
      FieldName = 'TotalDiscount'
      Precision = 19
    end
    object quUpEstimatedConfirmed: TBooleanField
      FieldName = 'Confirmed'
    end
  end
  object dsUpEstimated: TDataSource [6]
    DataSet = quUpEstimated
    Left = 47
    Top = 182
  end
  object dsUpPayment: TDataSource [7]
    DataSet = quUpPayment
    Left = 167
    Top = 182
  end
  object quUpPayment: TADODataSet [8]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PC.IDPaymentCondition,'#13#10'        MP.IDMeioPag,'#13#10'        ' +
      'MP.MeioPag,'#13#10'        MP.ImageIndex,'#13#10#9'PC.Amount,'#13#10#9'PC.OBS,'#13#10#9'PC.' +
      'EstimetedDate'#13#10'FROM'#13#10'        Sal_PaymentCondition PC (NOLOCK)'#13#10' ' +
      '       Join MeioPag MP (NOLOCK) on ( PC.IDMeioPag = MP.IDMeioPag' +
      ' )'#13#10'WHERE'#13#10#9'PC.IDEstimated = :IDEstimated'#13#10#9'OR'#13#10#9'PC.IDPreSale = ' +
      ':IDPreSale'
    Parameters = <
      item
        Name = 'IDEstimated'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 167
    Top = 134
    object quUpPaymentIDPaymentCondition: TIntegerField
      FieldName = 'IDPaymentCondition'
    end
    object quUpPaymentIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quUpPaymentMeioPag: TStringField
      DisplayLabel = 'Payment'
      FieldName = 'MeioPag'
      Size = 50
    end
    object quUpPaymentImageIndex: TIntegerField
      DisplayLabel = '     '
      FieldName = 'ImageIndex'
    end
    object quUpPaymentEstimetedDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'EstimetedDate'
      DisplayFormat = 'ddddd'
    end
    object quUpPaymentAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quUpPaymentOBS: TStringField
      FieldName = 'OBS'
      Size = 100
    end
  end
  object cmdInsertPayment: TADOCommand [9]
    CommandText = 
      'INSERT Sal_PaymentCondition (IDPaymentCondition, IDEstimated, ID' +
      'MeioPag, Amount, OBS, EstimetedDate, IDPreSale)'#13#10'VALUES (:IDPaym' +
      'entCondition, :IDEstimated, :IDMeioPag, :Amount, :OBS, :Estimete' +
      'dDate, :IDPreSale)'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPaymentCondition'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDEstimated'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDMeioPag'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Amount'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end
      item
        Name = 'EstimetedDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 295
    Top = 122
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmEstimatedInfo.sil'
  end
end
