inherited MntCountryFch: TMntCountryFch
  Left = 243
  Caption = 'Country'
  ClientHeight = 175
  ClientWidth = 267
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBottom: TPanel
    Top = 147
    Width = 267
    TabOrder = 2
    inherited btnOk: TXiButton
      Left = 112
    end
    inherited btnCancel: TXiButton
      Left = 190
    end
  end
  object edtCoutry: TmrDBEdit [1]
    Left = 108
    Top = 88
    Width = 121
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Pais'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 1
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Country :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtCode: TmrDBEdit [2]
    Left = 108
    Top = 47
    Width = 121
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'CodPais'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 0
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Code :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  inherited pnlTitulo: TPanel
    Width = 267
    TabOrder = 3
    inherited lbLoop: TLabel
      Left = 212
    end
    inherited btnLoop: TXiButton
      Left = 239
    end
  end
  inherited dsFch: TDataSource
    Left = 84
    Top = 40
  end
  inherited PrintFch: TPrintDialog
    Left = 136
    Top = 44
  end
  inherited ConfigFch: TmrConfigFch
    Connection = 'MaintenanceConn'
    ProviderName = 'dspPais'
    Left = 24
    Top = 44
  end
end
