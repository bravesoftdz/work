inherited SubModelImage: TSubModelImage
  Left = 243
  Top = 143
  Width = 416
  Height = 359
  BorderIcons = [biSystemMenu]
  Caption = 'SubModelImage'
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object imgItem: TImage [0]
    Left = 0
    Top = 0
    Width = 408
    Height = 291
    Align = alClient
  end
  object Bevel1: TBevel [1]
    Left = 0
    Top = 0
    Width = 408
    Height = 291
    Align = alClient
  end
  object pnlButtom: TPanel [2]
    Left = 0
    Top = 291
    Width = 408
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object hhh: TPanel
      Left = 258
      Top = 0
      Width = 150
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object btClose: TButton
        Left = 77
        Top = 6
        Width = 66
        Height = 31
        Cancel = True
        Caption = '&Close'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btCloseClick
      end
    end
  end
  object quModelImage: TADODataSet [3]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'M.LargeImage'#13#10'FROM'#13#10#9'Model M'#13#10'WHERE'#13#10#9'M.IDModel = :IDMo' +
      'del'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 215
    Top = 20
    object quModelImageLargeImage: TStringField
      FieldName = 'LargeImage'
      Size = 255
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelImage.sil'
  end
end
