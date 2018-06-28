object SintegraConfigFrm: TSintegraConfigFrm
  Left = 339
  Top = 221
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#227'o'
  ClientHeight = 182
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 36
    Top = 52
    Width = 84
    Height = 13
    Alignment = taRightJustify
    Caption = 'Arquibo Sintegra :'
  end
  object Label22: TLabel
    Left = 11
    Top = 84
    Width = 109
    Height = 13
    Alignment = taRightJustify
    Caption = 'Caminho do Validador :'
  end
  object Label12: TLabel
    Left = 73
    Top = 20
    Width = 47
    Height = 13
    Alignment = taRightJustify
    Caption = 'Empresa :'
  end
  object Label24: TLabel
    Left = 349
    Top = 20
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 349
    Top = 52
    Width = 14
    Height = 23
    Caption = '*'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 33
    Top = 116
    Width = 87
    Height = 13
    Alignment = taRightJustify
    Caption = 'Caminho do TED :'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 153
    Width = 396
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      396
      29)
    object btnOk: TcxButton
      Left = 239
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 319
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edtFilePath: TcxButtonEdit
    Left = 125
    Top = 48
    Width = 221
    Height = 21
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = edtFilePathPropertiesButtonClick
    TabOrder = 1
  end
  object edtValidator: TcxButtonEdit
    Left = 125
    Top = 80
    Width = 221
    Height = 21
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = edtValidatorPropertiesButtonClick
    TabOrder = 2
  end
  object luCompany: TcxLookupComboBox
    Left = 125
    Top = 16
    Width = 221
    Height = 21
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'IDEmpresa'
    Properties.ListColumns = <
      item
        FieldName = 'Empresa'
      end>
    Properties.ListOptions.GridLines = glNone
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = DMSintegra.dsLuEmpresa
    TabOrder = 0
  end
  object edtTED: TcxButtonEdit
    Left = 125
    Top = 112
    Width = 221
    Height = 21
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = edtTEDPropertiesButtonClick
    TabOrder = 3
  end
  object odgFilePath: TOpenDialog
    Left = 344
    Top = 108
  end
end
