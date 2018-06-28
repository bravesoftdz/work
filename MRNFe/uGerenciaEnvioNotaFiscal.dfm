object Form1: TForm1
  Left = 405
  Top = 237
  Width = 576
  Height = 402
  Caption = 'frmGerenciaEnvioNF'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    568
    368)
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Envia'
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 136
    Top = 40
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'Filtro Situacao'
  end
  object ComboBox2: TComboBox
    Left = 392
    Top = 40
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'Data Fim'
  end
  object Button5: TButton
    Left = 120
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Consulta'
    TabOrder = 3
  end
  object Button7: TButton
    Left = 232
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Cancela'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 344
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Imprime danfe'
    TabOrder = 5
  end
  object Button4: TButton
    Left = 456
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Inutiliza numeral'
    TabOrder = 6
  end
  object ComboBox3: TComboBox
    Left = 264
    Top = 40
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Text = 'Data Inicio'
  end
  object ComboBox4: TComboBox
    Left = 8
    Top = 40
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 8
    Text = 'Filtro origem'
  end
  object grdNF: TDBGrid
    Left = 8
    Top = 72
    Width = 553
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dmSQL.dsNotaFiscal
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Selecionado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Origem'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Referencia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Situacao'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataEnvio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataResposta'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataCancelamento'
        Width = 97
        Visible = True
      end>
  end
end
