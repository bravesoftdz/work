inherited PctTreatmentLotFch: TPctTreatmentLotFch
  Caption = 'PctTreatmentLotFch'
  ClientHeight = 188
  ClientWidth = 319
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 160
    Width = 319
    TabOrder = 2
    inherited btnOk: TXiButton
      Left = 164
    end
    inherited btnCancel: TXiButton
      Left = 242
    end
  end
  inherited pnlTitulo: TPanel
    Width = 319
    TabOrder = 3
    inherited lbLoop: TLabel
      Left = 264
    end
    inherited btnLoop: TXiButton
      Left = 291
    end
  end
  object edtMfg: TmrDBEdit [2]
    Left = 112
    Top = 57
    Width = 157
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'LotNumber'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'Lot Number : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtPurchaseDate: TmrDBDateEdit [3]
    Left = 112
    Top = 104
    Width = 157
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'ExpirationDate'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 1
    EditLabel.Width = 77
    EditLabel.Height = 13
    EditLabel.Caption = 'Purchase Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  inherited dsFch: TDataSource
    Left = 96
    Top = 36
  end
  inherited PrintFch: TPrintDialog
    Left = 148
    Top = 40
  end
  inherited ConfigFch: TmrConfigFch
    Left = 36
    Top = 40
  end
end
