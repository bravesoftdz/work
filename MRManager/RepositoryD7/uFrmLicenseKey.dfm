inherited FrmLicenseKey: TFrmLicenseKey
  Left = 236
  Top = 174
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Key validation'
  ClientHeight = 194
  ClientWidth = 353
  Font.Charset = ANSI_CHARSET
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 153
    Width = 353
    inherited EspacamentoInferior: TPanel
      Width = 353
      inherited Panel3: TPanel
        Width = 353
      end
    end
    inherited hhh: TPanel
      Left = 135
      Width = 218
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 143
        Caption = '&Validate'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btCloseClick
      end
      object btnFreeTrial: TButton
        Left = 74
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Free Trial!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnFreeTrialClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 147
  end
  inherited EspacamentoDireito: TPanel
    Left = 350
    Height = 147
  end
  inherited EspacamentoSuperior: TPanel
    Width = 353
  end
  object pnlValidate: TPanel [4]
    Left = 5
    Top = 5
    Width = 341
    Height = 146
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      Left = 0
      Top = 69
      Width = 86
      Height = 13
      Alignment = taRightJustify
      Caption = 'Product Number : '
    end
    object Label2: TLabel
      Left = 58
      Top = 94
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Key : '
    end
    object Image1: TImage
      Left = 29
      Top = 3
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010001002020100000000000A80800001600000028000000
        2000000040000000010010000000000000080000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000EF3DEF3DEF3D00000000EF3DEF3DEF3D00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000007C007CEF3D00000000007C007CEF3D00000000000000000000
        000000000000000000000000000000000000000000000000000000000000EF3D
        EF3DEF3DEF3D007C007CEF3DEF3DEF3D007C007CEF3DEF3DEF3DEF3DEF3DEF3D
        0000000000000000000000000000000000000000EF3DEF3DEF3DEF3DEF3DEF3D
        EF3DEF3DEF3DEF3D007C007CEF3DEF3DEF3D007C007CEF3DEF3DEF3DEF3DEF3D
        000000000000E001E001E001E001E001E001E001E001E001E001E001E001E001
        E001E001E001E001007C007CEF3DEF3DEF3D007C007CE001E001E001E001EF3D
        000000000000E001E001E001E001E001E001E001E001E001E001E001E001E001
        E001E001E001E001E001007C007CEF3DEF3D007C007CE001E001E001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7F007C007C007C007C007C007CFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E001E001E001
        E001E001E001E001E001E001007C007C007C007CFF7FFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FE001FF7FFF7FFF7FFF7FE001FF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7F007C007C007C007CFF7FE001FF7FE001E001EF3D
        000000000000E001E001FF7FFF7FE001E001E001FF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7F007C007C007C007C007C007CFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FE001E001E001E001E001E001
        E001E001E001E001E001007C007C007C007C007C007CFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FE001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7F007C007C007C007C007C007CFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FE001E001E001E001E001E001E001
        E001E001E001E001E001E001007C007C007C007CFF7FFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FE001E001E001E001E001E001E001
        E001E001E001E001E001E001E001E001E001FF7FFF7FFF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FE001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E001FF7FFF7FE001E001EF3D
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FE001E001E001E001E001E001
        E001E001E001E001E001E001E001E001FF7FFF7FFF7FFF7FFF7FE001E0010000
        000000000000E001E001FF7FFF7FE001E001E001FF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E001E001FF7FFF7FE001E0010000
        000000000000E001E001FF7FE001FF7FFF7FFF7FFF7FE001FF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FE001FF7FFF7FFF7FFF7FE001FF7FE001E0010000
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E001E001E001
        E001E001E001E001E001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E0010000
        000000000000E001E001FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FE001E0010000
        000000000000E001E001E001E001E001E001E001E001E001E001E001E001E001
        E001E001E001E001E001E001E001E001E001E001E001E001E001E001E0010000
        000000000000E001E001E001E001E001E001E001E001E001E001E001E001E001
        E001E001E001E001E001E001E001E001E001E001E001E001E001E001E0010000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C7FFFFF8C7F
        FFF80003FF000003800000038000000380000003800000038000000380000003
        8000000380000003800000038000000380000003800000038000000780000007
        8000000780000007800000078000000780000007FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF}
    end
    object Label3: TLabel
      Left = 65
      Top = 3
      Width = 208
      Height = 13
      Caption = 'Please enter Main Retail license key'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 65
      Top = 19
      Width = 255
      Height = 13
      Caption = 'Contact us for more information at www.mainretail.com'
    end
    object Label5: TLabel
      Left = 249
      Top = 95
      Width = 8
      Height = 13
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 155
      Top = 123
      Width = 8
      Height = 13
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 54
      Top = 46
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Date : '
    end
    object Label8: TLabel
      Left = 21
      Top = 124
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Varification : '
    end
    object Label9: TLabel
      Left = 232
      Top = 124
      Width = 8
      Height = 13
      Caption = '-'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
    end
    object edtNumber: TEdit
      Left = 90
      Top = 69
      Width = 346
      Height = 18
      TabStop = False
      BorderStyle = bsNone
      Color = cl3DLight
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtKey: TEdit
      Left = 90
      Top = 91
      Width = 157
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtModule: TEdit
      Left = 262
      Top = 91
      Width = 42
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtDay: TEdit
      Left = 90
      Top = 119
      Width = 61
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtDate: TEdit
      Left = 90
      Top = 46
      Width = 346
      Height = 18
      TabStop = False
      BorderStyle = bsNone
      Color = cl3DLight
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object edtMonth: TEdit
      Left = 167
      Top = 120
      Width = 61
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtYear: TEdit
      Left = 244
      Top = 120
      Width = 61
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object quLicense: TADOQuery [5]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'ModuleInfo'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'Update sys_module '
      'SET ModuleInfo  = :ModuleInfo')
    Left = 25
    Top = 70
  end
end
