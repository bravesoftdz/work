inherited SubModelImage: TSubModelImage
  Left = 243
  Top = 143
  Width = 350
  Height = 274
  Caption = 'SubModelImage'
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object ImageBevel: TBevel [0]
    Left = 0
    Top = 0
    Width = 342
    Height = 223
    Align = alClient
  end
  object imgItem: TImage [1]
    Left = 0
    Top = 0
    Width = 342
    Height = 223
    Align = alClient
  end
  object pnlImgPath: TPanel [2]
    Left = 0
    Top = 223
    Width = 342
    Height = 24
    Align = alBottom
    TabOrder = 0
    object sbOpenFile: TSpeedButton
      Left = 295
      Top = 2
      Width = 21
      Height = 20
      OnClick = sbOpenFileClick
    end
    object Label1: TLabel
      Left = 24
      Top = 7
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'File :'
    end
    object sbRemove: TSpeedButton
      Left = 317
      Top = 2
      Width = 21
      Height = 20
      OnClick = sbRemoveClick
    end
    object edtLargeImage: TEdit
      Left = 50
      Top = 2
      Width = 242
      Height = 21
      TabOrder = 0
    end
  end
  object quModelImage: TADODataSet [3]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'M.LargeImage,'#13#10#9'M.LargeImage2'#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13 +
      #10'WHERE'#13#10#9'M.IDModel = :IDModel'
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
    object quModelImageLargeImage2: TStringField
      FieldName = 'LargeImage2'
      Size = 255
    end
  end
  object OP: TOpenPictureDialog [4]
    Filter = 'JPEG Image File (*.jpg)|*.jpg|Bitmaps (*.bmp)|*.bmp'
    Left = 280
    Top = 180
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubModelImage.sil'
  end
end
