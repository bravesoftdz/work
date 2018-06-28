inherited PctBreedFch: TPctBreedFch
  Caption = 'Breed'
  ClientHeight = 173
  ClientWidth = 341
  PixelsPerInch = 96
  TextHeight = 13
  object edtBreed: TmrDBEdit [0]
    Left = 108
    Top = 76
    Width = 169
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Breed'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    EditLabel.Width = 38
    EditLabel.Height = 13
    EditLabel.Caption = 'Breed : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  inherited pnlBottom: TPanel
    Top = 145
    Width = 341
    TabOrder = 1
    inherited btnOk: TXiButton
      Left = 186
    end
    inherited btnCancel: TXiButton
      Left = 264
    end
  end
  inherited pnlTitulo: TPanel
    Width = 341
    Caption = '  Breed'
    TabOrder = 2
    inherited lbLoop: TLabel
      Left = 285
    end
    inherited btnLoop: TXiButton
      Left = 313
    end
  end
  inherited dsFch: TDataSource
    Left = 92
    Top = 32
  end
  inherited PrintFch: TPrintDialog
    Left = 144
    Top = 36
  end
  inherited ConfigFch: TmrConfigFch
    Left = 32
    Top = 36
  end
end
