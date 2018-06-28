inherited FrmFastSale2: TFrmFastSale2
  Top = -12
  BorderStyle = bsNone
  Caption = 'FrmFastSale2'
  ClientHeight = 564
  ClientWidth = 793
  PixelsPerInch = 96
  TextHeight = 14
  inherited Shape6: TShape
    Top = 507
    Width = 771
    Height = 5
    Visible = False
  end
  inherited Shape7: TShape
    Width = 8
    Height = 450
    Visible = False
  end
  inherited Shape8: TShape
    Visible = False
  end
  inherited pnlPayment: TPanel [3]
    Left = 680
    Top = 224
    Width = 71
    Visible = False
    inherited Label17: TLabel
      Width = 71
      Visible = False
    end
  end
  inherited pnlBottom: TPanel [4]
    Top = 523
    Width = 793
    inherited Panel9: TPanel
      Width = 793
      inherited Panel3: TPanel
        Width = 793
      end
    end
    inherited hhh: TPanel
      Left = 289
      Width = 504
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btCancel: TButton
        Left = 383
      end
      inherited btReceive: TBitBtn
        Left = 147
      end
      object btHold: TButton
        Left = 270
        Top = 2
        Width = 103
        Height = 31
        Cancel = True
        Caption = 'Ho&ld'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        TabStop = False
        OnClick = btHoldClick
      end
    end
  end
  inherited pnlTop: TPanel [5]
    Width = 793
    inherited Image1: TImage
      Width = 521
    end
    inherited Label3: TLabel
      Left = 577
    end
    inherited EspacamentoSuperior: TPanel
      Width = 793
      inherited EEE: TPanel
        Width = 793
      end
    end
  end
  inherited pnlItem: TPanel [6]
    Left = 0
    Top = 37
    Width = 793
    Height = 486
    Align = alClient
    object lbModel: TLabel [0]
      Left = 23
      Top = 17
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Model'
      Font.Charset = ANSI_CHARSET
      Font.Color = 10446848
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btRemoveItem: TSpeedButton
      Top = 201
      Visible = False
    end
    inherited btDiscountItem: TSpeedButton
      Top = 176
      Visible = False
    end
    inherited btSerial: TSpeedButton
      Top = 240
      Visible = False
    end
    inherited Label6: TLabel
      Width = 793
      Visible = False
    end
    inherited Label1: TLabel
      Left = 616
      Top = 207
    end
    inherited Label7: TLabel
      Left = 35
      Top = 46
      Alignment = taRightJustify
    end
    inherited btAddItem: TSpeedButton
      Top = 151
      Visible = False
    end
    inherited Label25: TLabel
      Left = 670
      Top = 346
      Visible = False
    end
    inherited Label24: TLabel
      Left = 672
      Top = 302
      Visible = False
    end
    inherited Label4: TLabel
      Left = 673
      Top = 262
      Visible = False
    end
    inherited panel8: TPanel [13]
      Top = 232
      TabOrder = 7
      Visible = False
    end
    inherited edtBarcode: TEdit [14]
      Left = 575
      Top = 218
      TabOrder = 2
    end
    object Edit1: TEdit [15]
      Left = 578
      Top = 193
      Width = 178
      Height = 22
      Hint = 'In case of refund, type negative quantity'
      TabStop = False
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnEnter = edtBarcodeEnter
      OnExit = edtBarcodeExit
      OnKeyDown = edtQtyKeyDown
      OnKeyPress = edtQtyKeyPress
    end
    inherited edtQty: TEdit [16]
      Left = 64
      Top = 43
      TabStop = True
      TabOrder = 1
    end
    inherited edtZip: TDBEdit [17]
      Left = 670
      Top = 362
      TabOrder = 3
      Visible = False
    end
    inherited scMedia: TDBSuperComboADO [18]
      Left = 671
      Top = 317
      TabOrder = 4
      Visible = False
    end
    inherited scCustomer: TDBSuperComboADO [19]
      Left = 672
      Top = 277
      Width = 100
      TabOrder = 5
      Visible = False
    end
    inherited grdItems: TSMDBGrid [20]
      Left = 0
      Top = 75
      Width = 793
      Height = 411
      Anchors = [akLeft, akTop, akBottom]
      FixedColor = clCream
      TabOrder = 6
      Columns = <
        item
          Expanded = False
          FieldName = 'Qty'
          Width = 29
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Model'
          Width = 156
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Description'
          Width = 235
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SalesPerson'
          Width = 199
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SalePrice'
          Width = 67
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
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'TotalItem'
          Width = 78
          Visible = True
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'Tax'
          Visible = False
          FooterType = ftCustom
        end
        item
          Expanded = False
          FieldName = 'SerialNumber'
          Visible = False
          FooterType = ftCustom
        end>
    end
    object cmbModel: TSuperComboADO
      Left = 64
      Top = 13
      Width = 517
      Height = 22
      Color = 8454143
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = 'cmbModel'
      CodeLength = 350
      LookUpSource = DM.dsLookUpModelPack
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      ShowEditCode = True
      EditCodePos = taEditCodeRight
      IDLanguage = 0
      OnSelectItem = cmbModelSelectItem
    end
    object GroupBox1: TGroupBox
      Left = 595
      Top = 0
      Width = 185
      Height = 67
      Caption = 'Sales option'
      Font.Charset = ANSI_CHARSET
      Font.Color = 10446848
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Label8: TLabel
        Left = 9
        Top = 16
        Width = 96
        Height = 13
        Caption = 'F9 - Search Produto'
        Font.Charset = ANSI_CHARSET
        Font.Color = 10446848
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 9
        Top = 31
        Width = 86
        Height = 13
        Caption = 'F10 - Ver Estoque'
        Font.Charset = ANSI_CHARSET
        Font.Color = 10446848
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 9
        Top = 47
        Width = 78
        Height = 13
        Caption = 'F11 - Open Hold'
        Font.Charset = ANSI_CHARSET
        Font.Color = 10446848
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  inherited pnlPaymentType: TPanel
    Left = 233
    Top = 198
    Width = 293
    Color = clWhite
    ParentColor = False
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
      Visible = False
    end
    inherited spPayVisa: TSpeedButton
      Visible = False
    end
    inherited spPayMaster: TSpeedButton
      Visible = False
    end
    inherited spPayAmerican: TSpeedButton
      Visible = False
    end
    inherited Label10: TLabel
      Left = 74
      Top = 7
      Alignment = taCenter
    end
    inherited btnPartialPayment: TSpeedButton
      Left = 58
      Top = 137
    end
    inherited cmbPaymentType: TSuperComboADO
      Left = 10
    end
    inherited pnlShowAuthorization: TPanel
      Left = 49
      Top = 79
      Width = 200
      Height = 56
      inherited Label12: TLabel
        Top = 1
      end
      inherited EditAuthorization: TEdit
        Top = 25
      end
    end
  end
  inherited pnlShowCash: TPanel [8]
    Left = 243
    Top = 368
    Width = 269
    Color = clWhite
    ParentColor = False
    Visible = False
    inherited Shape4: TShape
      Width = 269
      Brush.Color = clWhite
      Pen.Color = clGray
      Pen.Style = psInsideFrame
    end
    inherited lblReceived: TLabel
      Left = 10
      Font.Color = 10446848
    end
    inherited spLine: TShape
      Left = 36
      Width = 226
      Brush.Color = 10446848
    end
    inherited lblChange: TLabel
      Left = 61
      Font.Color = 10446848
    end
    inherited EditChange: TStaticText
      Left = 134
      Width = 119
      Color = clWhite
      Font.Color = clRed
    end
    inherited EditReceived: TMemo
      Left = 135
      Width = 119
      Color = clWhite
      Font.Color = clNavy
    end
  end
  inherited pnlTotal: TPanel [9]
    Left = 531
    Top = 493
    Width = 239
    Height = 27
    Anchors = [akRight, akBottom]
    Color = clWhite
    inherited Shape3: TShape
      Left = 15
      Width = 221
      Height = 27
      Align = alNone
      Brush.Color = clWhite
      Pen.Color = clGray
      Pen.Style = psSolid
    end
    inherited Shape1: TShape
      Visible = False
    end
    inherited Label13: TLabel
      Visible = False
    end
    inherited Label14: TLabel
      Left = 49
      Top = -28
      Visible = False
    end
    inherited Label18: TLabel
      Left = 351
      Top = 16
      Visible = False
    end
    inherited Label20: TLabel
      Visible = False
    end
    inherited Label21: TLabel
      Left = 346
      Top = 9
    end
    inherited Label16: TLabel
      Left = 18
      Top = 2
      Font.Color = 10446848
    end
    inherited edtTotalTax: TDBEdit
      Visible = False
    end
    inherited edtSubTotal: TDBEdit
      Top = 37
      Width = 161
      Visible = False
    end
    inherited edtTotalInvoice: TDBEdit
      Left = 69
      Top = 1
      Width = 162
      Color = clWhite
      Font.Color = clNavy
    end
  end
  inherited quBarCode: TADOQuery
    Left = 260
    Top = 290
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmFastSale2.sil'
  end
end
