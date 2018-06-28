inherited FrmNewPOTransfer: TFrmNewPOTransfer
  Left = 167
  Top = 206
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Transfer'
  ClientHeight = 235
  ClientWidth = 453
  PixelsPerInch = 96
  TextHeight = 13
  object lblModel: TLabel [0]
    Left = 14
    Top = 118
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Model :'
  end
  object lblSince: TLabel [1]
    Left = 17
    Top = 54
    Width = 32
    Height = 13
    Alignment = taRightJustify
    Caption = 'Since :'
  end
  object lblTo: TLabel [2]
    Left = 30
    Top = 86
    Width = 19
    Height = 13
    Alignment = taRightJustify
    Caption = 'To :'
  end
  object lblQty: TLabel [3]
    Left = 24
    Top = 150
    Width = 25
    Height = 13
    Alignment = taRightJustify
    Caption = 'Qty :'
  end
  object lblDate: TLabel [4]
    Left = 235
    Top = 54
    Width = 30
    Height = 13
    Alignment = taRightJustify
    Caption = 'Date :'
  end
  object lblUser: TLabel [5]
    Left = 236
    Top = 86
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
  end
  inherited Panel2: TPanel
    Width = 453
    inherited Image1: TImage
      Width = 226
    end
    inherited lblMenu: TLabel
      Left = 237
    end
    inherited EspacamentoSuperior: TPanel
      Width = 453
      inherited EEE: TPanel
        Width = 453
      end
    end
  end
  inherited Panel1: TPanel
    Top = 194
    Width = 453
    inherited EspacamentoInferior: TPanel
      Width = 453
      inherited Panel3: TPanel
        Width = 453
      end
    end
    inherited hhh: TPanel
      Left = 236
      Width = 217
      object spHelp: TSpeedButton [0]
        Tag = 5
        Left = 5
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Help'
        Glyph.Data = {
          0E060000424D0E06000000000000360000002800000016000000160000000100
          180000000000D8050000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFADA6A5BDBABDCECBCECED3D6D6D7D6D6D7D6D6D3
          D6CECBCEC6C3C6ADAEADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
          FFFF00FFFF00FFFF00FFA5A29CC6C3C6D6D7DEDEDFE7D6D7D6D6CBC6D6BEB5D6
          BEB5D6C7C6D6D7D6DEDFE7D6DBDEC6C7C6ADA6A5FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FFFF00FFB5B2ADD6D7D6E7EBEFE7D7CED6A28CC67952BD6539
          BD5D31BD5929BD5D31BD6D4AC69684D6CBC6DEE3E7D6D7D6B5B6B5FF00FFFF00
          FFFF00FF0000FF00FFFF00FFB5B6B5DEDFDEF7F7F7E7C3ADD67D52CE6D39CE6D
          42CE6D42B57D63AD7963B55D31BD5929B55521BD6139CEA694E7E3E7DEDFDEC6
          BEBDFF00FFFF00FF0000FF00FFBDB2ADDEDFDEFFFFFFF7C3ADDE7D4AE78252E7
          8252DE794ACE9E84D6DBDEC6CFD6B58A73BD5D29BD6131BD5929B55529CE967B
          E7E3E7E7E3E7C6B6B5FF00FF0000FF00FFD6D3D6FFFFFFFFD7C6EF8652EF8A5A
          EF8A63E78A5AE77D52DEB6A5FFFFFFD6DFE7B58E7BC65D31C66131BD6131BD5D
          31B55529CEA694E7E7EFDEDFDEFF00FF0000CEC3C6F7F7F7FFFFF7F79A73EF8A
          5AEF9263EF8E63EF8A63E7865ADE865ACEA294BD9684C66D42C66539C66131BD
          6131BD6131BD5929BD6139DECFC6E7EBEFCEC7C60000DEDBDEFFFFFFFFD3BDF7
          8E5AF79263F79263EF8E63EF8A5AE78652DE926BD6AE9CC69684C6714AC66539
          C66539C66131BD6131BD6131BD5521CE9684E7E7E7DEDBDE0000EFEBEFFFFFFF
          FFAE8CF79263F79263F79263EF8E63EF8A5AE78252E7AE9CFFFFFFCED7DEBD7D
          63CE6531C66539C66131BD6131BD6131BD5929C6714ADEDFDEDEDFDE0000F7FB
          FFFFFFFFFFA273F7966BF79263F79263EF8E63EF8A5AE78252DEAA94FFFFFFD6
          D7D6BD8A73C66131C66539C66131BD6131BD6131BD5D31BD6131DECFCEDEE3E7
          0000FFFFFFFFFBF7FF9E73F7966BF79263F79263EF8E63EF8A5AE78252DE8E6B
          FFFBFFF7F7F7C6C3C6B58263C66131C66131C66131BD6131BD5D31BD6131D6C7
          BDDEE3E70000FFFFFFFFFBF7FFA27BFF966BF79263F79263EF8E63EF8A5AE782
          52DE794AD69E84F7F7F7F7F7FFCECFCEB5866BC65D31C66131BD6131BD5D31BD
          6131D6C7BDDEDFE70000FFFFFFFFFFFFFFAA84FF9A6BF7966BF79263EF8A5AE7
          8252E77D4ADE7D4AD66D42CE8663F7EBE7F7F7F7C6C7C6B56D4AC66131BD6131
          BD5D31BD6539DED3CED6D7DE0000F7F7FFFFFFFFFFC39CFF9A6BF7966BF79263
          E7A284E7B6A5D6A28CD67D52D6754ACE6531D69273FFFFFFD6DFDEB58A73BD59
          29BD6131BD5929C67952DEDFDECECFCE0000EFE7E7FFFFFFFFE3CEFF9E73FF9A
          6BFF9263E7BAA5FFFFFFD6DFE7C6927BD66D39CE6531CE8663EFF3F7D6DFE7AD
          8A7BBD5929BD6131BD5529CEA28CDEE3E7BDBABD0000D6CFCEFFFFFFFFFFFFFF
          BA94FF9E6BFF9A6BEFA284FFFBFFF7F3F7CEC7C6C69E8CC69684CEC3BDE7E7E7
          C6CBCEAD715AC65D29BD5929BD6D42DED7D6D6D7DEFF00FF0000FF00FFEFEFEF
          FFFFFFFFF3E7FFAA7BFF9E73FF9A6BE7BEADFFFFFFF7FBFFE7EBEFDEE7EFE7E7
          EFD6D7DEAD968CB55D31BD5D29BD5D29D6B6ADDEE3E7BDBEBDFF00FF0000FF00
          FFFF00FFFFFFFFFFFFFFFFEBDEFFAE84FFA273FF9A6BE7AE94E7D7D6DEDFDED6
          D3D6BDBAB5AD8A7BB56139BD5929BD5D31D6AE9CE7E7E7CECFCEFF00FFFF00FF
          0000FF00FFFF00FFD6D3D6FFFFFFFFFFFFFFF7EFFFC39CFFA273FF9263E7865A
          CE8263C67952BD6939C65929BD5D29C67952D6BEB5E7E7E7D6D3D6FF00FFFF00
          FFFF00FF0000FF00FFFF00FFFF00FFCECBCEFFFBFFFFFFFFFFFFFFFFEBDEFFC7
          ADF7A27BE78A63D67D52CE7D5ACE9273D6B6A5DEDBDEDEE3E7CECFCEFF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFDEDFDEF7F7F7FF
          FFFFFFFFFFFFF7F7EFEBE7E7E3DEE7DFDEDEE3E7DEDFE7D6D7D6BDBEBDFF00FF
          FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          BDB6B5CECBCED6D7D6D6DBDED6DBDED6D7D6CED3D6C6C7C6B5B6B5FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
        Margin = 5
      end
      inherited btClose: TButton
        Left = 146
        Caption = '&Cancel'
        TabOrder = 1
        OnClick = btCloseClick
      end
      object btSave: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = 'Save'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 154
  end
  inherited EspacamentoDireito: TPanel
    Left = 450
    Height = 154
  end
  object cmbModel: TDBSuperComboADO [10]
    Left = 58
    Top = 114
    Width = 383
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 8
    Text = 'cmbModel'
    CodeLength = 85
    LookUpSource = DM.dsLookUpModelMaster
    DropDownRows = 18
    IDLanguage = 0
    DataField = 'IDModel'
    DataSource = dtsTransfer
  end
  object edtUser: TEdit [11]
    Left = 274
    Top = 82
    Width = 167
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 7
  end
  object cmbTo: TDBSuperComboADO [12]
    Left = 59
    Top = 82
    Width = 150
    Height = 21
    Color = clWhite
    TabOrder = 6
    Text = 'cmbTo'
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
    DataField = 'IDLojaDestino'
    DataSource = dtsTransfer
  end
  object cmbSince: TDBSuperComboADO [13]
    Left = 59
    Top = 50
    Width = 150
    Height = 21
    Color = clWhite
    TabOrder = 4
    Text = 'cmbSince'
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
    DataField = 'IDLojaOrigem'
    DataSource = dtsTransfer
  end
  object edtQty: TDBEdit [14]
    Left = 58
    Top = 146
    Width = 63
    Height = 21
    DataField = 'Qty'
    DataSource = dtsTransfer
    TabOrder = 9
  end
  object edtDate: TDBEdit [15]
    Left = 274
    Top = 48
    Width = 169
    Height = 21
    TabStop = False
    Color = clBtnFace
    DataField = 'Data'
    DataSource = dtsTransfer
    TabOrder = 5
  end
  object dtsTransfer: TDataSource [16]
    DataSet = FrmNewPO.cdsTransfer
    Left = 360
    Top = 40
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmNewPOTransfer.sil'
  end
end
