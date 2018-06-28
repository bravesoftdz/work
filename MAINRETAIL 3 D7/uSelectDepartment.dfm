inherited SelectDepartment: TSelectDepartment
  Left = 380
  Top = 238
  Width = 326
  Height = 141
  BorderIcons = []
  Caption = 'SelectDepartment'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 13
    Top = 37
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Department :'
  end
  inherited Panel1: TPanel
    Top = 66
    Width = 318
    inherited EspacamentoInferior: TPanel
      Width = 318
      inherited Panel3: TPanel
        Width = 318
      end
    end
    inherited hhh: TPanel
      Left = 107
      Width = 211
      inherited btClose: TButton
        Left = 74
        OnClick = btCloseClick
      end
      object btOK: TButton
        Left = 143
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        TabOrder = 1
        TabStop = False
        OnClick = btOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 60
  end
  inherited EspacamentoDireito: TPanel
    Left = 315
    Height = 60
  end
  inherited EspacamentoSuperior: TPanel
    Width = 318
  end
  object cmbDepartment: TSuperComboADO [5]
    Left = 80
    Top = 31
    Width = 165
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = cmbDepartmentChange
    CodeLength = 300
    LookUpSource = DM.dsLookupDepartment
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  inherited siLang: TsiLangRT
    Left = 28
    Top = 56
  end
end
