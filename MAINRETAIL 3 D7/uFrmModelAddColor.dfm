inherited FrmModelAddColor: TFrmModelAddColor
  Left = 263
  Top = 185
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Add Vertical'
  ClientHeight = 116
  ClientWidth = 282
  Font.Name = 'Tahoma'
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 13
    Top = 33
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = 'Description :'
  end
  inherited Panel1: TPanel
    Top = 75
    Width = 282
    inherited EspacamentoInferior: TPanel
      Width = 282
      inherited Panel3: TPanel
        Width = 282
      end
    end
    inherited hhh: TPanel
      Left = 138
      Width = 144
      inherited sbHelp: TSpeedButton
        Left = 325
        Width = 93
        Visible = False
      end
      object Button1: TButton [1]
        Left = 72
        Top = 3
        Width = 66
        Height = 31
        Cancel = True
        Caption = 'Close'
        ModalResult = 2
        TabOrder = 0
        TabStop = False
      end
      inherited btClose: TButton
        Left = 2
        Caption = 'Save'
        Default = True
        ModalResult = 1
        TabOrder = 1
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 69
  end
  inherited EspacamentoDireito: TPanel
    Left = 279
    Height = 69
  end
  inherited EspacamentoSuperior: TPanel
    Width = 282
  end
  object scColor: TSuperComboADO [5]
    Left = 77
    Top = 30
    Width = 181
    Height = 21
    TabOrder = 4
    Text = 'scColor'
    LookUpSource = DM.dsLookUpColor
    DropDownRows = 10
    IDLanguage = 0
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelAddColor.sil'
  end
  object spAddColor: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_AddColor;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDColor'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 247
    Top = 7
  end
end
