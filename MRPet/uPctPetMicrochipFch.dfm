inherited PctPetMicrochipFch: TPctPetMicrochipFch
  Caption = 'PctPetMicrochipFch'
  ClientHeight = 175
  ClientWidth = 332
  PixelsPerInch = 96
  TextHeight = 13
  object edtMicrochipNum: TmrDBEdit [0]
    Left = 112
    Top = 72
    Width = 145
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'MicrochipNum'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 1
    EditLabel.Width = 78
    EditLabel.Height = 13
    EditLabel.Caption = 'Microchip Num : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scMicrochip: TmrDBSuperCombo [1]
    Left = 112
    Top = 46
    Width = 145
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    Visible = False
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ProviderListName = 'dspLuPetMicrochip'
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'Microchip :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDMicrochip'
  end
  inherited pnlBottom: TPanel
    Top = 147
    Width = 332
    TabOrder = 2
    inherited btnOk: TXiButton
      Left = 177
    end
    inherited btnCancel: TXiButton
      Left = 255
    end
  end
  inherited pnlTitulo: TPanel
    Width = 332
    TabOrder = 3
    inherited lbLoop: TLabel
      Left = 276
    end
    inherited btnLoop: TXiButton
      Left = 304
    end
  end
  inherited dsFch: TDataSource
    Left = 100
  end
  inherited PrintFch: TPrintDialog
    Left = 152
  end
  inherited ConfigFch: TmrConfigFch
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 40
  end
end
