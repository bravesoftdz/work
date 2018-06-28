inherited FrmAddNutrition: TFrmAddNutrition
  Left = 312
  Top = 215
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Nutrition'
  ClientHeight = 149
  ClientWidth = 357
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 21
    Top = 53
    Width = 45
    Height = 13
    Alignment = taRightJustify
    Caption = 'Nutrition :'
  end
  inherited Panel1: TPanel
    Top = 108
    Width = 357
    inherited EspacamentoInferior: TPanel
      Width = 357
      inherited Panel3: TPanel
        Width = 357
      end
    end
    inherited hhh: TPanel
      Left = 149
      Width = 208
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 137
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 67
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        TabOrder = 1
        TabStop = False
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 102
  end
  inherited EspacamentoDireito: TPanel
    Left = 354
    Height = 102
  end
  inherited EspacamentoSuperior: TPanel
    Width = 357
  end
  object cmbNutrition: TSuperComboADO [5]
    Left = 71
    Top = 49
    Width = 260
    Height = 21
    TabOrder = 4
    LookUpSource = DM.dsLookUpNutrition
    DropDownRows = 18
    IDLanguage = 0
  end
  object cmdInsertNutriItem: TADOCommand [6]
    CommandText = 
      'INSERT Inv_ModelNutrition (IDNutritionItem, IDModel)'#13#10'SELECT NI.' +
      'IDNutritionItem, :IDModel'#13#10'FROM Inv_NutritionItem NI'#13#10'WHERE NI.I' +
      'DNutrition = :IDNutrition'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDNutrition'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 105
    Top = 20
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAddNutrition.sil'
  end
end
