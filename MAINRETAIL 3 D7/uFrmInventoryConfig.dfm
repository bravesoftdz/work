inherited FrmInventoryConfig: TFrmInventoryConfig
  Left = 286
  Top = 132
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Inventory Config'
  ClientHeight = 534
  ClientWidth = 459
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 493
    Width = 459
    inherited EspacamentoInferior: TPanel
      Width = 459
      inherited Panel3: TPanel
        Width = 459
      end
    end
    inherited hhh: TPanel
      Left = 245
      Width = 214
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        Cancel = True
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 76
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        TabOrder = 1
        TabStop = False
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 487
  end
  inherited EspacamentoDireito: TPanel
    Left = 456
    Height = 487
  end
  inherited EspacamentoSuperior: TPanel
    Width = 459
  end
  object PageControl1: TPageControl [4]
    Left = 3
    Top = 6
    Width = 453
    Height = 487
    ActivePage = tsCurveABC
    Align = alClient
    TabOrder = 4
    object tsCurveABC: TTabSheet
      Caption = '  Curve ABC  '
      object GroupBox3: TGroupBox
        Left = 48
        Top = 44
        Width = 329
        Height = 95
        TabOrder = 0
        object lbPeriod: TLabel
          Left = 22
          Top = 64
          Width = 90
          Height = 13
          Alignment = taRightJustify
          Caption = 'Period (in months) :'
        end
        object Label14: TLabel
          Left = 12
          Top = 12
          Width = 305
          Height = 41
          AutoSize = False
          Caption = 
            'Enter the number of months of sales history that the system will' +
            ' use to calculate the class and order point.'
          WordWrap = True
        end
        object edtPeriod: TEdit
          Left = 120
          Top = 60
          Width = 41
          Height = 21
          TabOrder = 0
          OnKeyPress = edtPeriodKeyPress
        end
      end
      object GroupBox4: TGroupBox
        Left = 48
        Top = 283
        Width = 329
        Height = 122
        TabOrder = 2
        object Label1: TLabel
          Left = 14
          Top = 82
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'A (%) :'
        end
        object Label2: TLabel
          Left = 114
          Top = 83
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'B (%) :'
        end
        object Label3: TLabel
          Left = 218
          Top = 82
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'C (%) :'
        end
        object Label13: TLabel
          Left = 12
          Top = 19
          Width = 305
          Height = 45
          AutoSize = False
          Caption = 
            'Enter the % that each class represents. Example. A=80%, B=15%, C' +
            '=5%. The total must always equal 100%.'
          WordWrap = True
        end
        object edtClassAPerc: TEdit
          Left = 52
          Top = 78
          Width = 41
          Height = 21
          TabOrder = 0
          OnKeyPress = edtPeriodKeyPress
        end
        object edtClassBPerc: TEdit
          Left = 152
          Top = 79
          Width = 41
          Height = 21
          TabOrder = 1
          OnKeyPress = edtPeriodKeyPress
        end
        object edtClassCPerc: TEdit
          Left = 256
          Top = 78
          Width = 41
          Height = 21
          TabOrder = 2
          OnKeyPress = edtPeriodKeyPress
        end
      end
      object GroupBox5: TGroupBox
        Left = 48
        Top = 164
        Width = 329
        Height = 100
        TabOrder = 1
        object Label15: TLabel
          Left = 31
          Top = 66
          Width = 81
          Height = 13
          Alignment = taRightJustify
          Caption = 'Calculation type :'
        end
        object Label16: TLabel
          Left = 12
          Top = 17
          Width = 305
          Height = 35
          AutoSize = False
          Caption = 
            'Select what type of calculation will be used on ABC classificati' +
            'on.'
          WordWrap = True
        end
        object cbxCalcType: TComboBox
          Left = 120
          Top = 63
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Qty and Profit'
          Items.Strings = (
            'Qty and Profit'
            'Profit and Qty')
        end
      end
    end
    object tsAutoReq: TTabSheet
      Caption = '  Auto Request  '
      ImageIndex = 1
      object Label8: TLabel
        Left = 28
        Top = 9
        Width = 118
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sales period (in months) :'
      end
      object lbStoreToAutoRequest: TLabel
        Left = 38
        Top = 35
        Width = 108
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store to auto request  :'
      end
      object edtSalesPeriodo: TEdit
        Left = 148
        Top = 5
        Width = 47
        Height = 21
        TabOrder = 0
        OnKeyPress = edtPeriodKeyPress
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 238
        Width = 428
        Height = 93
        Caption = '   Safety Stock   '
        TabOrder = 4
        object Label4: TLabel
          Left = 34
          Top = 71
          Width = 10
          Height = 13
          Alignment = taRightJustify
          Caption = 'A:'
        end
        object Label5: TLabel
          Left = 170
          Top = 71
          Width = 10
          Height = 13
          Alignment = taRightJustify
          Caption = 'B:'
        end
        object Label6: TLabel
          Left = 314
          Top = 71
          Width = 10
          Height = 13
          Alignment = taRightJustify
          Caption = 'C:'
        end
        object Label11: TLabel
          Left = 8
          Top = 18
          Width = 413
          Height = 43
          AutoSize = False
          Caption = 
            'The period (in days) that the product cannot be empty on the inv' +
            'entory.  This period will be used to calculate the quantity that' +
            ' will be requested by the system based on the daily sales averag' +
            'e.'
          WordWrap = True
        end
        object edtPurchaseClassA: TEdit
          Left = 48
          Top = 67
          Width = 41
          Height = 21
          TabOrder = 0
          OnKeyPress = edtPeriodKeyPress
        end
        object edtPurchaseClassB: TEdit
          Left = 184
          Top = 67
          Width = 41
          Height = 21
          TabOrder = 1
          OnKeyPress = edtPeriodKeyPress
        end
        object edtPurchaseClassC: TEdit
          Left = 328
          Top = 67
          Width = 41
          Height = 21
          TabOrder = 2
          OnKeyPress = edtPeriodKeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 9
        Top = 335
        Width = 428
        Height = 119
        Caption = '   Adjust Order Point   '
        TabOrder = 5
        object Label9: TLabel
          Left = 153
          Top = 95
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'B (%):'
        end
        object Label10: TLabel
          Left = 297
          Top = 95
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'C (%):'
        end
        object Label12: TLabel
          Left = 8
          Top = 18
          Width = 413
          Height = 65
          AutoSize = False
          Caption = 
            'You can adjust your order point so the system will order items s' +
            'ooner. This is helpful during holiday seasons when you need more' +
            ' stock on hand. Ex. If the order point in the system is 10 and y' +
            'ou enter a variance of 30% then the new order point will be 13. ' +
            'Items will now be ordered when the inventory reaches 13 instead ' +
            'of 10. At the end of the season you may return to 0% and the sys' +
            'tem will order using the normal order point.'
          WordWrap = True
        end
        object Label7: TLabel
          Left = 17
          Top = 95
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'A (%):'
        end
        object edtMarginClassA: TEdit
          Left = 48
          Top = 91
          Width = 41
          Height = 21
          TabOrder = 0
          OnKeyPress = edtPeriodKeyPress
        end
        object edtMarginClassB: TEdit
          Left = 184
          Top = 91
          Width = 41
          Height = 21
          TabOrder = 1
          OnKeyPress = edtPeriodKeyPress
        end
        object edtMarginClassC: TEdit
          Left = 328
          Top = 91
          Width = 41
          Height = 21
          TabOrder = 2
          OnKeyPress = edtPeriodKeyPress
        end
      end
      object scStore: TSuperComboADO
        Left = 148
        Top = 32
        Width = 155
        Height = 21
        TabOrder = 1
        Text = '<-->'
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnStoreAll: TButton
        Left = 309
        Top = 32
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 2
        TabStop = False
        OnClick = btnStoreAllClick
      end
      object gbxClassesRequest: TGroupBox
        Left = 9
        Top = 159
        Width = 428
        Height = 73
        Caption = '   Classes to auto request   '
        TabOrder = 6
        object lblClassRequest: TLabel
          Left = 8
          Top = 18
          Width = 413
          Height = 31
          AutoSize = False
          Caption = 
            'Check the box of the classes you would like to auto-request. Ite' +
            'ms in unchecked boxes will not appear on purchase orders.'
          WordWrap = True
        end
        object chxClassA: TCheckBox
          Left = 48
          Top = 52
          Width = 37
          Height = 17
          Caption = 'A'
          TabOrder = 0
        end
        object chxClassB: TCheckBox
          Left = 184
          Top = 52
          Width = 41
          Height = 17
          Caption = 'B'
          TabOrder = 1
        end
        object chxClassC: TCheckBox
          Left = 328
          Top = 52
          Width = 41
          Height = 17
          Caption = 'C'
          TabOrder = 2
        end
      end
      object gbDefaulLeadTime: TGroupBox
        Left = 10
        Top = 57
        Width = 428
        Height = 92
        Caption = '  Lead Time   '
        TabOrder = 3
        object lbLeadDesc: TLabel
          Left = 9
          Top = 17
          Width = 413
          Height = 41
          AutoSize = False
          Caption = 
            'The number of days to add to the safety stock value when a vendo' +
            'r has no lead time statistics available.  Lead time is the numbe' +
            'r of days it takes from the time a PO is created until it is rec' +
            'eived.'
          WordWrap = True
        end
        object lbLeadTime: TLabel
          Left = 39
          Top = 67
          Width = 93
          Height = 13
          Alignment = taRightJustify
          Caption = 'Default Lead Time :'
        end
        object edtLeadTime: TEdit
          Left = 138
          Top = 63
          Width = 47
          Height = 21
          TabOrder = 0
          OnKeyPress = edtPeriodKeyPress
        end
      end
    end
  end
  object quPropertyDomain: TADODataSet [5]
    Connection = DM.ADODBConnect
    CommandText = 
      #13#10'SELECT'#13#10#9'Property,'#13#10#9'PropertyValue'#13#10'FROM'#13#10#9'Sis_PropertyDomain'#13 +
      #10'WHERE'#13#10#9'Property in('#39'ABCCalcPeriodInMonth'#39', '#39'AutoRequestSalePer' +
      'iodInMonth'#39','#13#10#9#39'ClassAPerc'#39', '#39'ClassBPerc'#39', '#39'ClassCPerc'#39', '#39'POTime' +
      'SetupClassAInDays'#39','#13#10#9#39'POTimeSetupClassBInDays'#39', '#39'POTimeSetupCla' +
      'ssCInDays'#39', '#39'PercSecurityMarginClassA'#39','#13#10#9#39'PercSecurityMarginCla' +
      'ssB'#39', '#39'PercSecurityMarginClassC'#39', '#39'StoreToAutoRequest'#39', '#13#10#9#39'Auto' +
      'RequestClassA'#39', '#39'AutoRequestClassB'#39', '#39'AutoRequestClassC'#39', '#39'ABCCa' +
      'lcType'#39', '#13#10#9#39'AutoRequestLeadTime'#39')'
    Parameters = <>
    Left = 268
    Top = 4
  end
  object cmdUpdPropertyDomain: TADOCommand [6]
    CommandText = 
      'UPDATE'#13#10#9'Sis_PropertyDomain'#13#10'SET'#13#10#9'PropertyValue = :PropertyValu' +
      'e'#13#10'WHERE'#13#10#9'Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 380
    Top = 4
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmInventoryConfig.sil'
  end
end
