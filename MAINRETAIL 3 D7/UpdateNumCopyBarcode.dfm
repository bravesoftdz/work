inherited frmUpdateNumCopyBarcode: TfrmUpdateNumCopyBarcode
  Left = 630
  Top = 452
  Caption = 'Update number copy'
  ClientHeight = 152
  ClientWidth = 290
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 5
    Top = 94
    Width = 67
    Height = 13
    Caption = 'Number Copy:'
  end
  object Label2: TLabel [1]
    Left = 5
    Top = 10
    Width = 43
    Height = 13
    Caption = 'Barcode:'
  end
  object Label3: TLabel [2]
    Left = 5
    Top = 36
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object Label4: TLabel [3]
    Left = 5
    Top = 60
    Width = 27
    Height = 13
    Caption = 'Price:'
  end
  inherited Panel1: TPanel
    Top = 113
    Width = 290
    inherited Bevel1: TBevel
      Width = 290
    end
    inherited Panel2: TPanel
      Left = 140
      inherited Cancelar: TButton
        ModalResult = 2
      end
      inherited Aplicar: TButton
        ModalResult = 1
        OnClick = AplicarClick
      end
    end
  end
  object dbedBarcode: TDBEdit [5]
    Left = 75
    Top = 9
    Width = 185
    Height = 21
    Color = clBtnFace
    DataField = 'idbarcode'
    DataSource = dsUpdateNumCopy
    Enabled = False
    TabOrder = 1
  end
  object dbedDescription: TDBEdit [6]
    Left = 75
    Top = 34
    Width = 179
    Height = 21
    Color = clBtnFace
    DataField = 'description'
    DataSource = dsUpdateNumCopy
    Enabled = False
    TabOrder = 2
  end
  object dbedPrice: TDBEdit [7]
    Left = 75
    Top = 60
    Width = 121
    Height = 21
    Color = clBtnFace
    DataField = 'SellingPrice'
    DataSource = dsUpdateNumCopy
    Enabled = False
    TabOrder = 3
  end
  object edtNumCopy: TEdit [8]
    Left = 75
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 4
  end
  inherited siLang: TsiLangRT
    Left = 241
    Top = 41
  end
  object dsUpdateNumCopy: TDataSource
    Left = 215
    Top = 68
  end
end
