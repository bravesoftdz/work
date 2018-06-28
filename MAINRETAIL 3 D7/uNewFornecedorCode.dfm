inherited NewFornecedorCode: TNewFornecedorCode
  Left = 147
  Top = 191
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'New Vendor Code'
  ClientHeight = 169
  ClientWidth = 401
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 38
    Top = 36
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vendor :'
  end
  object Label2: TLabel [1]
    Left = 47
    Top = 79
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Code :'
  end
  inherited Panel1: TPanel
    Top = 128
    Width = 401
    inherited EspacamentoInferior: TPanel
      Width = 401
      inherited Panel3: TPanel
        Width = 401
      end
    end
    inherited hhh: TPanel
      Left = 185
      Width = 216
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        ModalResult = 2
      end
      object btOK: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        ModalResult = 1
        TabOrder = 1
        TabStop = False
        OnClick = btOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 122
  end
  inherited EspacamentoDireito: TPanel
    Left = 398
    Height = 122
  end
  inherited EspacamentoSuperior: TPanel
    Width = 401
  end
  object cmbFornecedor: TSuperComboADO [6]
    Left = 82
    Top = 32
    Width = 293
    Height = 21
    TabOrder = 4
    Text = '<Select the Vendor>'
    LookUpSource = DM.dsLookUpFornecedor
    DropDownRows = 15
    IDLanguage = 0
  end
  object edtCode: TEdit [7]
    Left = 82
    Top = 75
    Width = 203
    Height = 21
    MaxLength = 32
    TabOrder = 5
  end
  object quVendorCode: TADOQuery [8]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'VendorCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 35
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'VC.IDVendorModelCode'
      'FROM'
      #9'VendorModelCode VC (NOLOCK)'
      'WHERE'
      #9'VC.IDPessoa = :IDPessoa'
      #9'AND'
      #9'VC.VendorCode = :VendorCode'
      #9'AND'
      #9'VC.IDModel = :IDModel')
    Left = 282
    Top = 64
    object quVendorCodeIDVendorModelCode: TIntegerField
      FieldName = 'IDVendorModelCode'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_NewFornecedorCode.sil'
  end
end
