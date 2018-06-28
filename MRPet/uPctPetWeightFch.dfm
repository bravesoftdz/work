inherited PctPetWeightFch: TPctPetWeightFch
  Caption = 'PctPetWeightFch'
  ClientHeight = 182
  ClientWidth = 296
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 154
    Width = 296
    TabOrder = 2
    inherited btnOk: TXiButton
      Left = 141
    end
    inherited btnCancel: TXiButton
      Left = 219
    end
  end
  object edtWhelpDate: TmrDBDateEdit [1]
    Left = 87
    Top = 57
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'EntryDate'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    EditLabel.Width = 59
    EditLabel.Height = 13
    EditLabel.Caption = 'Entry Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtWeight: TmrDBCurrencyEdit [2]
    Left = 87
    Top = 97
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Weight'
    Properties.DecimalPlaces = 4
    Properties.DisplayFormat = '0.0000;-0.0000'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 1
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Weight :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  inherited pnlTitulo: TPanel
    Width = 296
    TabOrder = 3
    inherited lbLoop: TLabel
      Left = 243
    end
    inherited btnLoop: TXiButton
      Left = 268
    end
  end
  inherited dsFch: TDataSource
    Left = 104
    Top = 32
  end
  inherited PrintFch: TPrintDialog
    Left = 156
    Top = 36
  end
  inherited ConfigFch: TmrConfigFch
    Left = 44
    Top = 36
  end
end
