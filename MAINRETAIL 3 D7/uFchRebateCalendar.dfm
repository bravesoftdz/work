inherited FchRebateCalendar: TFchRebateCalendar
  Left = 359
  Top = 207
  Caption = ''
  ClientHeight = 364
  ClientWidth = 440
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 440
    inherited Image1: TImage
      Width = 166
    end
    inherited lblMenu: TLabel
      Left = 179
    end
    inherited EspacamentoSuperior: TPanel
      Width = 440
      inherited EEE: TPanel
        Width = 440
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 393
    end
  end
  inherited Panel1: TPanel
    Top = 323
    Width = 440
    inherited EspacamentoInferior: TPanel
      Width = 440
      inherited Panel3: TPanel
        Width = 440
      end
    end
    inherited hhh: TPanel
      Left = 219
    end
  end
  inherited pnlKey: TPanel
    Width = 440
    Height = 1
    inherited Panel4: TPanel
      Top = -1
      Width = 440
    end
  end
  inherited pnlDetail: TPanel
    Top = 41
    Width = 434
    Height = 282
    object lblDescription: TLabel
      Left = 56
      Top = 28
      Width = 60
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Description :'
      FocusControl = edtDescription
      ParentBiDiMode = False
    end
    object lblDaysOfWeek: TLabel
      Left = 42
      Top = 164
      Width = 74
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Days of Week :'
      ParentBiDiMode = False
    end
    object lblDiscountPerc: TLabel
      Left = 44
      Top = 84
      Width = 72
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Discount Perc :'
      FocusControl = edtDiscountPerc
      ParentBiDiMode = False
    end
    object lblStartDate: TLabel
      Left = 59
      Top = 112
      Width = 57
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Start Date :'
      ParentBiDiMode = False
    end
    object lblEndDate: TLabel
      Left = 65
      Top = 140
      Width = 51
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'End Date :'
      ParentBiDiMode = False
    end
    object lblStore: TLabel
      Left = 83
      Top = 56
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
      FocusControl = edtDescription
    end
    object lbNeedX: TLabel
      Left = 353
      Top = 26
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
    object Label1: TLabel
      Left = 177
      Top = 82
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
    object Label2: TLabel
      Left = 273
      Top = 110
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
    object Label3: TLabel
      Left = 273
      Top = 166
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
    object edtDescription: TDBEdit
      Left = 120
      Top = 24
      Width = 229
      Height = 21
      DataField = 'Description'
      DataSource = dsForm
      TabOrder = 0
    end
    object edtDiscountPerc: TDBEdit
      Left = 120
      Top = 80
      Width = 53
      Height = 21
      DataField = 'DiscountPerc'
      DataSource = dsForm
      TabOrder = 3
    end
    object dbStartDate: TcxDBDateEdit
      Left = 120
      Top = 108
      Width = 78
      Height = 21
      DataBinding.DataSource = dsForm
      DataBinding.DataField = 'StartDate'
      Properties.ShowTime = False
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfFlat
      Style.ButtonStyle = bts3D
      TabOrder = 4
    end
    object dbStartTime: TcxDBTimeEdit
      Left = 195
      Top = 108
      Width = 75
      Height = 21
      DataBinding.DataSource = dsForm
      DataBinding.DataField = 'StartDate'
      Properties.Alignment.Horz = taRightJustify
      Properties.TimeFormat = tfHourMin
      Style.BorderStyle = ebs3D
      Style.ButtonStyle = bts3D
      TabOrder = 5
    end
    object dbEndTime: TcxDBTimeEdit
      Left = 196
      Top = 136
      Width = 75
      Height = 21
      DataBinding.DataSource = dsForm
      DataBinding.DataField = 'EndDate'
      Properties.Alignment.Horz = taRightJustify
      Properties.TimeFormat = tfHourMin
      Style.BorderStyle = ebs3D
      Style.ButtonStyle = bts3D
      TabOrder = 7
    end
    object dbEndDate: TcxDBDateEdit
      Left = 120
      Top = 136
      Width = 78
      Height = 21
      DataBinding.DataSource = dsForm
      DataBinding.DataField = 'EndDate'
      Properties.ShowTime = False
      Style.BorderStyle = ebs3D
      Style.LookAndFeel.Kind = lfFlat
      Style.ButtonStyle = bts3D
      TabOrder = 6
    end
    object cbxDayOfWeek: TCheckListBox
      Left = 120
      Top = 164
      Width = 149
      Height = 98
      ItemHeight = 13
      Items.Strings = (
        'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday')
      TabOrder = 8
    end
    object scStore: TDBSuperComboADO
      Tag = 99
      Left = 120
      Top = 52
      Width = 229
      Height = 21
      TabOrder = 1
      Text = 'scStore'
      FilterSugest = True
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDStore'
      DataSource = dsForm
    end
    object btStoreAll: TButton
      Left = 352
      Top = 52
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 2
      OnClick = btStoreAllClick
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 41
    Height = 282
  end
  inherited EspacamentoDireito: TPanel
    Left = 437
    Top = 41
    Height = 282
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchRebateCalendar.sil'
  end
  inherited dsForm: TDataSource
    Left = 316
    Top = 4
  end
  inherited quForm: TPowerADOQuery
    CommandText = 
      'SELECT '#13#10#9'SR.IDRebateCalendar,'#13#10#9'SR.Description,'#13#10#9'SR.IDStore,'#13#10 +
      #9'SR.DaysOfWeek,'#13#10#9'SR.DiscountPerc,'#13#10#9'SR.StartDate,'#13#10#9'SR.EndDate'#13 +
      #10'FROM'#13#10#9'Sal_RebateCalendar SR '#13#10'WHERE'#13#10#9'SR.IDRebateCalendar = :I' +
      'DRebateCalendar'
    Parameters = <
      item
        Name = 'IDRebateCalendar'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 188
    Top = 4
    object quFormIDRebateCalendar: TIntegerField
      FieldName = 'IDRebateCalendar'
    end
    object quFormDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object quFormIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quFormDaysOfWeek: TStringField
      FieldName = 'DaysOfWeek'
      Size = 14
    end
    object quFormDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
    object quFormStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object quFormEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
  end
  inherited FormConfig: TFormConfig
    ConfirmPost = False
    AutoIncField = 'IDRebateCalendar'
    RequiredFields.Strings = (
      'Description'
      'DiscountPerc'
      'StartDate')
    Left = 252
    Top = 4
  end
end
