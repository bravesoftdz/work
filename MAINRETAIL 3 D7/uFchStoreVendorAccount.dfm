inherited FchStoreVendorAccount: TFchStoreVendorAccount
  Left = 348
  Top = 258
  Width = 400
  Height = 190
  BorderIcons = [biSystemMenu]
  Caption = 'New Vendor Account'
  PixelsPerInch = 96
  TextHeight = 13
  object lblAccount: TLabel [0]
    Left = 32
    Top = 80
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Account :'
  end
  object lblVendor: TLabel [1]
    Left = 38
    Top = 36
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vendor :'
  end
  inherited Panel1: TPanel
    Top = 122
    Width = 392
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 392
      inherited Panel3: TPanel
        Width = 392
      end
    end
    inherited hhh: TPanel
      Left = 176
      Width = 216
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
    Height = 116
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 389
    Height = 116
    TabOrder = 4
  end
  inherited EspacamentoSuperior: TPanel
    Width = 392
    TabOrder = 5
  end
  object cmbFornecedor: TSuperComboADO [6]
    Left = 84
    Top = 32
    Width = 273
    Height = 21
    TabOrder = 0
    Text = 'cmbFornecedor'
    LookUpSource = DM.dsLookUpFornecedor
    DropDownRows = 15
    ShowEditCode = True
    IDLanguage = 0
  end
  object edtAccount: TEdit [7]
    Left = 84
    Top = 76
    Width = 117
    Height = 21
    MaxLength = 32
    TabOrder = 1
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchStoreVendorAccount.sil'
    Left = 12
    Top = 4
  end
  object quStoreVendorAccount: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Account'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 35
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'SVA.IDStoreVendorAccount'
      'FROM'
      #9'Mnt_StoreVendorAccount SVA'
      'WHERE'
      #9'SVA.IDPessoa = :IDPessoa'
      #9'AND'
      #9'SVA.Account = :Account'
      #9'AND'
      #9'SVA.IDStore = :IDStore')
    Left = 266
    Top = 64
    object quStoreVendorAccountIDStoreVendorAccount: TIntegerField
      FieldName = 'IDStoreVendorAccount'
    end
  end
end
