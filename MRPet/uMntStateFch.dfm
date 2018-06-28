inherited MntStateFch: TMntStateFch
  Caption = 'State'
  ClientHeight = 161
  ClientWidth = 293
  PixelsPerInch = 96
  TextHeight = 13
  object edtCode: TmrDBEdit [0]
    Left = 108
    Top = 47
    Width = 121
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDEstado'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 1
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Code :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtState: TmrDBEdit [1]
    Left = 108
    Top = 82
    Width = 121
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Estado'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 2
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'State :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  inherited pnlBottom: TPanel
    Top = 133
    Width = 293
    TabOrder = 3
    inherited btnOk: TXiButton
      Left = 138
    end
    inherited btnCancel: TXiButton
      Left = 216
    end
  end
  inherited pnlTitulo: TPanel
    Width = 293
    Caption = '  State'
    TabOrder = 0
    inherited lbLoop: TLabel
      Left = 238
    end
    inherited btnLoop: TXiButton
      Left = 265
    end
  end
  inherited dsFch: TDataSource
    Left = 92
    Top = 0
  end
  inherited PrintFch: TPrintDialog
    Left = 144
    Top = 4
  end
  inherited ConfigFch: TmrConfigFch
    Connection = 'MaintenanceConn'
    ProviderName = 'dspEstado'
    Left = 32
    Top = 4
  end
end
