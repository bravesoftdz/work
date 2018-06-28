inherited FrmFastSaleGrocery: TFrmFastSaleGrocery
  Left = 2
  Top = -12
  Caption = 'XPress Sale'
  Color = clWhite
  PixelsPerInch = 96
  TextHeight = 14
  inherited Shape6: TShape
    Left = 10
    Top = 485
    Width = 776
    Height = 11
    Brush.Color = clNavy
  end
  inherited Shape7: TShape
    Left = 783
    Height = 458
    Brush.Color = clNavy
  end
  inherited Shape8: TShape
    Top = 40
    Height = 453
    Brush.Color = clNavy
  end
  inherited pnlItem: TPanel [3]
    Width = 774
    Height = 443
    Color = clWhite
    object Shape9: TShape [0]
      Left = 390
      Top = 5
      Width = 383
      Height = 437
      Pen.Color = clGray
    end
    inherited btRemoveItem: TSpeedButton
      Left = 191
      Top = 59
      Width = 92
    end
    inherited btDiscountItem: TSpeedButton
      Left = 97
      Top = 59
      Width = 89
    end
    inherited btSerial: TSpeedButton
      Left = 287
      Top = 59
    end
    inherited lblTotalLine: TLabel
      Left = 280
      Top = 36
      Visible = False
    end
    inherited Label6: TLabel
      Width = 774
      Caption = ''
      Color = clNavy
    end
    inherited Label1: TLabel
      Left = 5
      Top = 16
      Font.Color = clNavy
    end
    inherited Label7: TLabel
      Left = 189
      Top = 16
      Font.Color = clNavy
    end
    inherited btAddItem: TSpeedButton
      Left = 7
      Top = 60
      Width = 86
    end
    inherited Label25: TLabel
      Left = 649
      Top = 14
      Font.Color = clNavy
    end
    inherited Label24: TLabel
      Left = 410
      Top = 15
      Font.Color = clNavy
    end
    inherited Label4: TLabel
      Left = 506
      Top = 15
      Font.Color = clNavy
    end
    inherited edtBarcode: TEdit
      Left = 4
      Top = 32
    end
    inherited edtQty: TEdit
      Left = 188
      Top = 32
    end
    inherited edtZip: TDBEdit
      Left = 649
      Top = 30
    end
    inherited scMedia: TDBSuperComboADO
      Left = 409
      Top = 30
    end
    inherited scCustomer: TDBSuperComboADO
      Left = 505
      Top = 30
    end
    inherited grdItems: TSMDBGrid
      Left = 3
      Top = 89
      Width = 380
      Height = 259
      Columns = <
        item
          Expanded = False
          FieldName = 'Description'
          Width = 118
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Qty'
          Width = 40
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Model'
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SalesPerson'
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SalePrice'
          Width = 62
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SuggRetail'
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Discount'
          Width = 42
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'TotalItem'
          Width = 45
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Tax'
          Width = 43
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SerialNumber'
          Visible = False
          FooterType = ftCustom
        end>
    end
    inherited panel8: TPanel
      Left = 409
      Top = 54
      Width = 333
    end
    object SubListImage: TSubListPanel
      Left = 394
      Top = 58
      Width = 376
      Height = 381
      BevelOuter = bvNone
      Caption = 'TSubModelImage'
      Color = clBtnShadow
      TabOrder = 7
      SubListClassName = 'TSubModelImage'
    end
  end
  inherited pnlBottom: TPanel [4]
    Top = 491
    Height = 64
    Color = clNavy
    inherited Label2: TLabel
      Left = 10
      Width = 29
      Height = 15
      Font.Color = clSilver
      Font.Height = -12
      Font.Style = [fsItalic]
    end
    inherited lblUserName: TLabel
      Left = 63
      Top = 8
      Font.Color = clSilver
      Font.Style = [fsBold, fsItalic]
    end
    inherited Panel9: TPanel
      Color = clNavy
      inherited Panel3: TPanel
        BevelOuter = bvNone
      end
    end
    inherited hhh: TPanel
      Height = 58
      inherited spHelp: TSpeedButton
        Left = 91
        Top = 4
        Width = 86
        Height = 51
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        Layout = blGlyphTop
        Margin = -1
        ParentFont = False
      end
      inherited btCancel: TButton
        Left = 186
        Top = 5
        Width = 85
        Height = 50
        Font.Height = -11
      end
      inherited btReceive: TBitBtn
        Left = 282
        Width = 87
        Height = 51
        Hint = 'Press (F10)'
        Caption = '&Pay (F10)'
        Font.Height = -11
        ParentShowHint = False
        ShowHint = True
        Glyph.Data = {
          76050000424D7605000000000000360000002800000015000000150000000100
          18000000000040050000C40E0000C40E00000000000000000000FF00FF63C3E7
          9CDFEFDEEFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009ACEDEEFFF
          52C7F729AEDE29AEDE63C3E794D3F7D6EFFFFF00FFFF00FFFF00FFFF00FFFF00
          FF0071086BA663FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009ACE94D3F7
          9CE3FF7BDFFF73D3FF63D7F752C7F731B6E718A6D64ABEE794D3F7C6EFF7D6EF
          FF088218088218428A39FF00FFFF00FFFF00FFFF00FFFF00FF00009ACE63C3E7
          D6EFFF7BDFFF7BDFFF7BDFFF7BDFFF7BDFFF7BDFFF73D3FF63D7F731B6E731B6
          E708821808A218088218217D21FF00FFFF00FFFF00FFFF00FF00009ACE4ABEE7
          F7F7FF7BDFFF84EBFF7BDFFF298E420882180882180882180882180882180882
          1808821810B63108A21808A218007108FF00FFFF00FFFF00FF00009ACE52C7F7
          9CDFEFADFBFF84EBFF84EBFF298E425AE38442CF7342CF7342CF7331C36B31C3
          6B21BA4A10B63110B63108A21808A218007108FF00FFFF00FF00009ACE52C7F7
          29AEDED6FFFF84EBFF8CF3FF298E425AE3845AE3845AE38442CF7331C36B42CF
          7321BA4A21BA4A10B63110B63108A21808A218007108FF00FF00009ACE63C7FF
          31B6E7F7F7FF9CFFFF8CF3FF298E425AE3845AE3845AE38442CF7342CF7331C3
          6B42CF7321BA4A21BA4A10B63110B63108A218007108FF00FF00009ACE73D3FF
          63C7FF9CDFEFC6FFFF9CFFFF298E424AAA4A21A63921A63921A63921A639189A
          2921BA4A31C36B31C36B21BA4A10B631007108ADD3B5FF00FF00009ACE73D3FF
          63C7FF9CC3DED6FFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFFFF9CFF
          FF21A63931C36B31C36B189A29298E426BCFC6D6EFFFFF00FF00009ACE7BDFFF
          7BDFFF404000BDE7F7F7FFFFE7FFFFD6FFFFC6FFFFC6FFFFADFBFFADFBFFC6FF
          FF21A63942CF73189A29298E42C6EFF7D6FFFF29AEDEFF00FF00009ACE7BDFFF
          7BDFFF515100C6DFE79CC3DE31B6E742B2DE31B6E729AEDEF7FFFFC6FFFFC6FF
          FF21A6390882186BA6639CE3FFE7FFFFE7FFFF29AEDEDEEFFF0018A6D684EBFF
          84EBFF515100008C00008C00008C00009B00009B00009B0029AEDEF7FFFFF7FF
          FF007108A5C79CD6FFFF9CE3FFF7FFFFF7FFFFF7FFFF009ACE0018A6D68CF3FF
          8CF3FF515100008C00008C00008C00008C00009B00009B00009B0029AEDE29AE
          DE29AEDEDEEFFFFFFFFFE7FFFFFFFFFFFFFFFFFFFFFF009ACE0018A6D69CFFFF
          9CFFFF666600008000008C00008C00008C00008C00009B00009B00009B00009B
          0051510073EBFF009ACE009ACE009ACE009ACE009ACE009ACE0018A6D69CFFFF
          9CFFFF666600008000008000008000008C00008C00008C00009B00009B00009B
          005151009CFFFF9CFFFF29AEDEFF00FFFF00FFFF00FFFF00FF0018A6D6D6FFFF
          9CFFFF808000008000008000008000008000008C00008C00009B00009B00009B
          00515100C6FFFFADFBFF29AEDEFF00FFFF00FFFF00FFFF00FF0018A6D6DEEFFF
          E7FFFF808000008000008000008000008000008C00008C000080000080000080
          0051510029AEDE29AEDE29AEDEFF00FFFF00FFFF00FFFF00FF00FF00FF42B2DE
          42B2DE808000008000008000008000008000008000008C000080008080008080
          00404000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FF8080000080000080000080000080000080000080000080008080008080
          00404000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
          FF00FF6666006666006666006666006666006666006666006666004040004040
          00404000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        Layout = blGlyphTop
      end
    end
  end
  inherited pnlTop: TPanel [5]
  end
  inherited pnlPayment: TPanel
    Top = 525
    Width = 31
    Height = 11
    Color = clWhite
    Visible = False
    inherited Label17: TLabel
      Left = 350
      Top = 170
      Width = 66
      Align = alNone
      AutoSize = False
      Visible = False
    end
  end
  inherited pnlPaymentType: TPanel
    Left = 243
    Top = 148
    Width = 288
    Height = 165
    Visible = False
    object Shape2: TShape [0]
      Left = 2
      Top = 15
      Width = 284
      Height = 149
      Pen.Color = clGray
      Shape = stRoundRect
    end
    inherited spPayCash: TSpeedButton
      Left = 8
      Top = 34
    end
    inherited spPayVisa: TSpeedButton
      Left = 83
      Top = 34
      Width = 52
    end
    inherited spPayMaster: TSpeedButton
      Left = 142
      Top = 34
      Width = 58
    end
    inherited spPayAmerican: TSpeedButton
      Left = 208
      Top = 34
    end
    inherited Label10: TLabel
      Left = 69
      Top = 2
      Alignment = taCenter
      Font.Color = clGray
    end
    inherited btnPartialPayment: TSpeedButton
      Left = 88
      Top = 134
      Width = 112
    end
    inherited cmbPaymentType: TSuperComboADO
      Left = 10
      Top = 79
      Width = 268
      Height = 24
      Font.Height = -13
      Font.Style = [fsBold]
    end
    inherited pnlShowAuthorization: TPanel
      Left = 6
      Top = 105
      Width = 277
      Height = 27
      inherited Label12: TLabel
        Left = 4
        Width = 106
        Height = 16
        Font.Color = clGray
        Font.Height = -13
      end
      inherited EditAuthorization: TEdit
        Left = 118
        Top = 1
        Width = 155
        Height = 24
        Font.Height = -13
      end
    end
  end
  inherited pnlTotal: TPanel
    Left = 11
    Top = 396
    Width = 382
    Height = 92
    ParentColor = True
    inherited Shape3: TShape
      Width = 382
      Height = 92
      Brush.Color = 15257787
      Pen.Color = clGray
      Pen.Style = psSolid
      Shape = stRectangle
    end
    inherited Shape1: TShape
      Left = 40
      Top = 58
      Width = 317
      Brush.Color = clNavy
    end
    inherited Label13: TLabel
      Top = 31
      Font.Color = clNavy
    end
    inherited Label14: TLabel
      Font.Color = clNavy
      ParentColor = True
    end
    inherited Label18: TLabel
      Left = 344
      Font.Color = clNavy
    end
    inherited Label20: TLabel
      Left = 344
      Top = 33
      Font.Color = clNavy
    end
    inherited Label21: TLabel
      Left = 344
      Top = 65
      Font.Color = clNavy
    end
    inherited Label16: TLabel
      Top = 62
      Font.Color = clNavy
    end
    inherited edtTotalTax: TDBEdit
      Top = 31
      Width = 214
      Color = clSilver
      Font.Color = clBlack
    end
    inherited edtSubTotal: TDBEdit
      Width = 214
      Color = clSilver
      Font.Color = clBlack
    end
    inherited edtTotalInvoice: TDBEdit
      Top = 62
      Width = 213
      Color = clSilver
      Font.Color = clRed
    end
  end
  inherited pnlShowCash: TPanel
    Left = 245
    Top = 313
    Width = 286
    Height = 78
    Visible = False
    inherited Shape4: TShape
      Top = 6
      Width = 285
      Height = 71
      Align = alNone
      Brush.Color = clWhite
      Pen.Color = clGray
      Pen.Style = psSolid
    end
    inherited lblReceived: TLabel
      Top = 9
      Font.Color = clGray
    end
    inherited spLine: TShape
      Top = 40
      Width = 245
      Brush.Color = clGray
    end
    inherited lblChange: TLabel
      Top = 48
      Font.Color = clGray
    end
    inherited EditChange: TStaticText
      Top = 48
      Width = 134
      Color = clWhite
      Font.Color = clRed
    end
    inherited EditReceived: TMemo
      Top = 9
      Width = 134
      Color = clWhite
      Font.Color = clNavy
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmFastSaleGrocery.sil'
  end
  inherited dsPreSaleItem: TDataSource
    OnDataChange = dsPreSaleItemDataChange
  end
end
