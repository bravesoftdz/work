object FrmMenufiscal: TFrmMenufiscal
  Left = 336
  Top = 157
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Menu Fiscal'
  ClientHeight = 460
  ClientWidth = 326
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtom: TPanel
    Left = 0
    Top = 419
    Width = 326
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object lblUserName: TLabel
      Left = 48
      Top = 16
      Width = 221
      Height = 15
      AutoSize = False
      Caption = 'lblUserName'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label15: TLabel
      Left = 18
      Top = 15
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'User:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object hhh: TPanel
      Left = 176
      Top = 0
      Width = 150
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object spHelp: TSpeedButton
        Tag = 5
        Left = 7
        Top = 6
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
        Visible = False
      end
      object btClose: TButton
        Left = 77
        Top = 6
        Width = 66
        Height = 31
        Cancel = True
        Caption = 'Close'
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
  object pgFiscal: TPageControl
    Left = 0
    Top = 0
    Width = 326
    Height = 419
    ActivePage = tsMenuFiscal
    Align = alClient
    TabOrder = 1
    object tsMenuFiscal: TTabSheet
      Caption = 'Menu Fiscal'
      object btnLeituraX: TBitBtn
        Left = 25
        Top = 4
        Width = 276
        Height = 25
        Caption = 'LX - (Leitura X)'
        TabOrder = 0
        OnClick = btnLeituraXClick
        Margin = 20
      end
      object btnLeituraXSerial: TBitBtn
        Left = 25
        Top = 39
        Width = 276
        Height = 25
        Caption = 'Leitura X pela Serial'
        TabOrder = 1
        OnClick = btnLeituraXSerialClick
        Margin = 20
      end
      object btnReducaoZ: TBitBtn
        Left = 25
        Top = 74
        Width = 276
        Height = 25
        Caption = 'Redu'#231#227'o Z'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnReducaoZClick
        Margin = 20
      end
      object GroupBox1: TGroupBox
        Left = 29
        Top = 106
        Width = 277
        Height = 277
        Caption = '  (LMFC) Leitura da Mem'#243'ria Fiscal  '
        TabOrder = 3
        object btnMFPorData: TBitBtn
          Left = 20
          Top = 109
          Width = 237
          Height = 25
          Caption = 'Por data ...'
          TabOrder = 2
          OnClick = btnMFPorDataClick
          Margin = 30
        end
        object btnMFPorDataMDF: TBitBtn
          Left = 20
          Top = 136
          Width = 237
          Height = 25
          Caption = 'Por data MDF ...'
          TabOrder = 3
          OnClick = btnMFPorDataMDFClick
          Margin = 30
        end
        object btnMFPorSerialMDF: TBitBtn
          Left = 20
          Top = 163
          Width = 237
          Height = 25
          Caption = 'Serial por data MDF ...'
          TabOrder = 4
          OnClick = btnMFPorSerialMDFClick
          Margin = 30
        end
        object btnMFPorReducao: TBitBtn
          Left = 20
          Top = 190
          Width = 237
          Height = 25
          Caption = 'Por Redu'#231#227'o ...'
          TabOrder = 5
          OnClick = btnMFPorReducaoClick
          Margin = 30
        end
        object btnMFPorReducaoMDF: TBitBtn
          Left = 20
          Top = 217
          Width = 237
          Height = 25
          Caption = 'Por Redu'#231#227'o MDF ...'
          TabOrder = 6
          OnClick = btnMFPorReducaoMDFClick
          Margin = 30
        end
        object btnMFSerialPorReducaoMDF: TBitBtn
          Left = 20
          Top = 244
          Width = 237
          Height = 25
          Caption = 'Serial por Redu'#231#227'o MFD...'
          TabOrder = 7
          OnClick = btnMFSerialPorReducaoMDFClick
          Margin = 30
        end
        object btnEspelhoData: TBitBtn
          Left = 20
          Top = 28
          Width = 237
          Height = 25
          Caption = 'Espelho MFD por data ....'
          TabOrder = 0
          OnClick = btnEspelhoDataClick
          Margin = 30
        end
        object btnArqMdf: TBitBtn
          Left = 20
          Top = 83
          Width = 237
          Height = 25
          Caption = 'Arq. MFD'
          TabOrder = 1
          OnClick = btnArqMdfClick
          Margin = 30
        end
        object btnEspelhoCOO: TBitBtn
          Left = 20
          Top = 56
          Width = 237
          Height = 25
          Caption = 'Espelho MFD por COO ....'
          TabOrder = 8
          OnClick = btnEspelhoCOOClick
          Margin = 30
        end
      end
    end
    object tsPAF: TTabSheet
      Caption = 'PAF'
      ImageIndex = 1
      object btnGerarMercServ: TButton
        Left = 20
        Top = 38
        Width = 276
        Height = 25
        Caption = 'Tab. Prod.'
        TabOrder = 1
        OnClick = btnGerarMercServClick
      end
      object btnGerarEstoque: TButton
        Left = 20
        Top = 68
        Width = 276
        Height = 25
        Caption = 'Estoque'
        TabOrder = 2
        OnClick = btnGerarEstoqueClick
      end
      object GroupBox2: TGroupBox
        Left = 5
        Top = 105
        Width = 307
        Height = 156
        Caption = '  Gerar Movimentos e Meios Pag. PAF-ECF '
        TabOrder = 3
        object Label1: TLabel
          Left = 21
          Top = 25
          Width = 59
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data Inicial :'
        end
        object Label2: TLabel
          Left = 25
          Top = 50
          Width = 54
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data Final :'
        end
        object deFinal: TdxDateEdit
          Left = 85
          Top = 45
          Width = 111
          TabOrder = 0
          Date = -700000.000000000000000000
        end
        object deInicial: TdxDateEdit
          Left = 85
          Top = 20
          Width = 111
          TabOrder = 1
          Date = -700000.000000000000000000
        end
        object btnGerarOperacao: TButton
          Left = 16
          Top = 76
          Width = 276
          Height = 25
          Caption = 'Movimento por ECF'
          TabOrder = 2
          OnClick = btnGerarOperacaoClick
        end
        object btnMeioDePagto: TButton
          Left = 16
          Top = 107
          Width = 276
          Height = 25
          Caption = 'Meios de Pagto'
          TabOrder = 3
          OnClick = btnMeioDePagtoClick
        end
      end
      object btnInformacao: TButton
        Left = 21
        Top = 8
        Width = 275
        Height = 25
        Caption = 'Identifica'#231#227'o do PAF-ECF'
        TabOrder = 0
        OnClick = btnInformacaoClick
      end
    end
  end
  object mrPafEcf: TmrPafEcf
    NomePAFECF = 'CASH REGISTER'
    VersaoPAFECF = '1.6'
    CodigoMD5 = '00fe96bc61c96a87414ab6874098b584'
    VersaoERPAFECF = '01.00'
    CaminhoArquivos = 'C:\Program Files\MainRetail\PDV\'
    ChavePublica = 
      'B146872648A6F5222DC919A85DE1131565875FB7FFEDB72652999161D0D4B585' +
      '274A01B4B160EE2C39B7691563F39BA39BEFC966341F818B1154D71911295751' +
      'B6C5478B023B439EC5EE82060432E7122FF2D9490D2ED5430820FAE2EDCC02D9' +
      'AEAE1875B342A707C42980F6C0769EC42F29BD8B13769FCBA2418983A8FBCA6B'
    ChavePrivada = 
      'E9CE8FB7CF8A3D3CD0DF92A55643C1B5368F9D3A24DEEB790BACEC273C802B71' +
      '13170D9D0D171364DE67C68A0D5DB78910AA12D1065C0490C0DA3F172C76D807' +
      'C21A454393B73CB89A4B2EF7A96A417C1D0D4FF909ED3AAB53FBBD9E2169B4F4' +
      '08FA4F33393E6DA2DE76B6A6D1313E99E5BDB135C14DCE6093ED21CCF21F797D'
    PAFECFDesenvolvedora.RazaoSocial = 'SOFTVAR SOLU'#199#213'ES EM INFORM'#193'TICA LTDA'
    PAFECFDesenvolvedora.CNPJ = '06246012000187'
    PAFECFDesenvolvedora.InscricaoMunicipal = '3828071'
    PAFECFDesenvolvedora.InscricaoEstadual = 'ISENTA'
    Left = 221
    Top = 5
  end
  object cdsEstoque: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEstoque'
    Left = 387
    Top = 237
    object cdsEstoqueModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsEstoqueDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsEstoqueUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object cdsEstoqueQuantidade: TBCDField
      FieldName = 'Quantidade'
      Precision = 32
    end
    object cdsEstoqueDataEstoque: TDateTimeField
      FieldName = 'DataEstoque'
      ReadOnly = True
    end
  end
  object qryEstoque: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'M.Model,'
      #9'M.[Description],'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'QtyOnHand Quantidade,'
      #9'GetDate() DataEstoque'
      'FROM'
      #9'Model M'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      #9'LEFT JOIN Inventory I ON (M.IDModel = I.ModelID)'
      'WHERE'
      #9'M.Desativado = 0'
      #9'AND I.StoreID = :IDStore')
    Left = 387
    Top = 147
  end
  object dspEstoque: TDataSetProvider
    DataSet = qryEstoque
    Left = 387
    Top = 192
  end
  object cdsMercadoriaServico: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMercadoriaServico'
    Left = 387
    Top = 97
    object cdsMercadoriaServicoModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsMercadoriaServicoDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsMercadoriaServicoUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object cdsMercadoriaServicoIAT: TStringField
      FieldName = 'IAT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsMercadoriaServicoIPPT: TStringField
      FieldName = 'IPPT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsMercadoriaServicoSituacaoTributaria: TStringField
      FieldName = 'SituacaoTributaria'
      ReadOnly = True
      Size = 1
    end
    object cdsMercadoriaServicoAliquota: TBCDField
      FieldName = 'Aliquota'
      Precision = 19
    end
    object cdsMercadoriaServicoValorUnitario: TBCDField
      FieldName = 'ValorUnitario'
      Precision = 19
    end
  end
  object qryMercadoriaServico: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
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
      #9'M.Model,'
      #9'M.[Description],'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'IsNull(IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'CASE SituacaoTributaria'
      #9#9'WHEN 0 THEN '#39'A'#39' -- Nenhuma'
      #9#9'WHEN 1 THEN '#39'T'#39' -- Tribut'#225'vel (ICMS)'
      #9#9'WHEN 2 THEN '#39'N'#39' -- N'#227'o Tribut'#225'vel'
      #9#9'WHEN 3 THEN '#39'F'#39' -- Substitui'#231#227'o Tribut'#225'ria'
      #9#9'WHEN 4 THEN '#39'I'#39' -- Isento'
      #9#9'WHEN 5 THEN '#39'S'#39' -- ISS (ISSQN)'
      #9'END SituacaoTributaria,'
      #9'TC.Tax Aliquota,'
      #9'M.SellingPrice ValorUnitario'
      'FROM'
      #9'Model M'
      #9'JOIN StoreToTabGroup STG ON (M.GroupID = STG.IDGroup)'
      #9'JOIN TaxCategory TC ON (STG.IDSaleTax = TC.IDTaxCategory)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'M.Desativado = 0'
      #9'AND STG.IDStore = :IDStore')
    Left = 387
    Top = 7
  end
  object dspMercadoriaServico: TDataSetProvider
    DataSet = qryMercadoriaServico
    Left = 387
    Top = 52
  end
  object cdsReducaoZ: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspReducaoZ'
    Left = 477
    Top = 237
    object cdsReducaoZMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsReducaoZTipoECF: TStringField
      FieldName = 'TipoECF'
    end
    object cdsReducaoZMarcaECF: TStringField
      FieldName = 'MarcaECF'
    end
    object cdsReducaoZModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsReducaoZVersaoSBECF: TStringField
      FieldName = 'VersaoSBECF'
      Size = 10
    end
    object cdsReducaoZDataInstalacaoSBECF: TDateTimeField
      FieldName = 'DataInstalacaoSBECF'
    end
    object cdsReducaoZNumeroECF: TIntegerField
      FieldName = 'NumeroECF'
    end
    object cdsReducaoZContadorReducaoZ: TIntegerField
      FieldName = 'ContadorReducaoZ'
    end
    object cdsReducaoZContadorOrdemOperacao: TIntegerField
      FieldName = 'ContadorOrdemOperacao'
    end
    object cdsReducaoZContadorReinicioOperacao: TIntegerField
      FieldName = 'ContadorReinicioOperacao'
    end
    object cdsReducaoZNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsReducaoZVendaBruta: TBCDField
      FieldName = 'VendaBruta'
      ReadOnly = True
      Precision = 19
    end
    object cdsReducaoZIncideISSQN: TBooleanField
      FieldName = 'IncideISSQN'
    end
    object cdsReducaoZDataInicial: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'DataInicial'
      Calculated = True
    end
    object cdsReducaoZDataFinal: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'DataFinal'
      Calculated = True
    end
    object cdsReducaoZMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object cdsReducaoZNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsReducaoZDataEmissao: TDateTimeField
      FieldName = 'DataEmissao'
    end
  end
  object qryReducaoZ: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.MovDate,'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.TipoECF,'
      #9'RZ.MarcaECF,'
      #9'RZ.ModeloECF,'
      #9'RZ.VersaoSBECF,'
      #9'RZ.DataInstalacaoSBECF,'
      #9'RZ.NumeroECF,'
      #9'RZ.ContadorReducaoZ,'
      #9'RZ.ContadorOrdemOperacao,'
      #9'RZ.ContadorReinicioOperacao,'
      #9'RZ.NumeroUsuarioECF,'
      #9'(RZ.GTFinal - RZ.GTInicial) VendaBruta,'
      #9'RZ.IncideISSQN,'
      #9'RZ.DataEmissao'
      'FROM'
      #9'Sal_ReducaoZ RZ'
      'WHERE'
      #9'RZ.MovDate > :DataInicial'
      #9'AND RZ.MovDate <= :DataFinal')
    Left = 477
    Top = 147
  end
  object dspReducaoZ: TDataSetProvider
    DataSet = qryReducaoZ
    Left = 477
    Top = 192
  end
  object cdsTotalizadorParcial: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTotalizadorParcial'
    Left = 577
    Top = 237
    object cdsTotalizadorParcialNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsTotalizadorParcialMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsTotalizadorParcialModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsTotalizadorParcialContadorReducaoZ: TIntegerField
      FieldName = 'ContadorReducaoZ'
    end
    object cdsTotalizadorParcialNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsTotalizadorParcialCodigo: TStringField
      FieldName = 'Codigo'
      Size = 10
    end
    object cdsTotalizadorParcialValorAcumulado: TBCDField
      FieldName = 'ValorAcumulado'
      Precision = 19
    end
  end
  object qryTotalizadorParcial: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.ContadorReducaoZ,'
      #9'RZ.NumeroUsuarioECF,'
      #9'TP.Codigo,'
      #9'TP.ValorAcumulado'
      'FROM'
      #9'Sal_TotalizadorParcial TP'
      #9'JOIN Sal_ReducaoZ RZ ON (TP.IDReducaoZ = RZ.IDReducaoZ)'
      'WHERE'
      #9'RZ.MovDate > :DataInicial'
      #9'AND RZ.MovDate <= :DataFinal')
    Left = 577
    Top = 147
  end
  object dspTotalizadorParcial: TDataSetProvider
    DataSet = qryTotalizadorParcial
    Left = 577
    Top = 192
  end
  object cdsVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVenda'
    Left = 477
    Top = 97
    object cdsVendaNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsVendaMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsVendaModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsVendaNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsVendaContadorDocumento: TIntegerField
      FieldName = 'ContadorDocumento'
      ReadOnly = True
    end
    object cdsVendaContadorOrdemOperacao: TIntegerField
      FieldName = 'ContadorOrdemOperacao'
      ReadOnly = True
    end
    object cdsVendaDataInicioEmissao: TDateTimeField
      FieldName = 'DataInicioEmissao'
      ReadOnly = True
    end
    object cdsVendaValorSubTotal: TBCDField
      FieldName = 'ValorSubTotal'
      Precision = 19
    end
    object cdsVendaValorDesconto: TBCDField
      FieldName = 'ValorDesconto'
      ReadOnly = True
      Precision = 19
    end
    object cdsVendaIndicadorDesconto: TStringField
      FieldName = 'IndicadorDesconto'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaValorAcrescimo: TBCDField
      FieldName = 'ValorAcrescimo'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsVendaIndicadorAcrescimo: TStringField
      FieldName = 'IndicadorAcrescimo'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaValorTotalLiquido: TBCDField
      FieldName = 'ValorTotalLiquido'
      ReadOnly = True
      Precision = 19
    end
    object cdsVendaIndicadorCancelamento: TStringField
      FieldName = 'IndicadorCancelamento'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaCancelamentoAcrescimo: TBCDField
      FieldName = 'CancelamentoAcrescimo'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsVendaOrdemAplicacaoDA: TStringField
      FieldName = 'OrdemAplicacaoDA'
      ReadOnly = True
      Size = 1
    end
    object cdsVendaNomeCliente: TStringField
      FieldName = 'NomeCliente'
      ReadOnly = True
      Size = 50
    end
    object cdsVendaDocumentoCliente: TStringField
      FieldName = 'DocumentoCliente'
      ReadOnly = True
      Size = 30
    end
  end
  object qryVenda: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'IDCashRegister1'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInicial1'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DataFinal1'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCashRegister2'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInicial2'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'DataFinal2'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      '-- VENDAS FINALIZADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(I.InvoiceCode as Int) ContadorDocumento,'
      #9'Cast(I.CupomFiscal as Int) ContadorOrdemOperacao,'
      #9'I.PreSaleDate DataInicioEmissao,'
      #9'I.SubTotal ValorSubTotal,'
      
        #9'(IsNull(I.ItemDiscount, 0) + IsNull(I.InvoiceDiscount, 0)) Valo' +
        'rDesconto,'
      #9#39'V'#39' IndicadorDesconto,'
      #9'0.00 ValorAcrescimo,'
      #9#39'V'#39' IndicadorAcrescimo,'
      
        #9'(I.SubTotal - IsNull(I.ItemDiscount, 0) - IsNull(I.InvoiceDisco' +
        'unt, 0)) ValorTotalLiquido,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 CancelamentoAcrescimo,'
      #9#39'D'#39' OrdemAplicacaoDA,'
      
        #9'(CASE WHEN P.IDPessoa IS NULL THEN I.CompanyName ELSE P.Pessoa ' +
        'END) NomeCliente,'
      
        #9'IsNull((CASE WHEN P.IDPessoa IS NULL THEN I.CompanyCGC ELSE CAS' +
        'E P.Juridico WHEN 0 THEN P.CPF WHEN 1 THEN P.CGC END END), '#39#39') D' +
        'ocumentoCliente'
      'FROM'
      #9'Invoice I'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'LEFT JOIN Pessoa P ON (I.IDCustomer = P.IDPessoa)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister1'
      #9'AND RZ.MovDate > :DataInicial1'
      #9'AND RZ.MovDate <= :DataFinal1'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- VENDAS CANCELADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'SNC.CCF ContadorDocumento,'
      #9'SNC.COO ContadorOrdemOperacao,'
      #9'SNC.DataNota DataInicioEmissao,'
      #9'SNC.SubTotal ValorSubTotal,'
      #9'IsNull(SNC.Desconto, 0) ValorDesconto,'
      #9'SNC.TipoDesconto IndicadorDesconto,'
      #9'0.00 ValorAcrescimo,'
      #9'SNC.TipoAcrescimo IndicadorAcrescimo,'
      #9'(SNC.SubTotal - IsNull(SNC.Desconto, 0)) ValorTotalLiquido,'
      #9#39'S'#39' IndicadorCancelamento,'
      #9'0.00 CancelamentoAcrescimo,'
      #9#39'D'#39' OrdemAplicacaoDA,'
      
        #9'(CASE WHEN P.IDPessoa IS NULL THEN SNC.Cliente ELSE P.Pessoa EN' +
        'D) NomeCliente,'
      
        #9'IsNull((CASE WHEN P.IDPessoa IS NULL THEN SNC.CPFCGC ELSE CASE ' +
        'P.Juridico WHEN 0 THEN P.CPF WHEN 1 THEN P.CGC END END), '#39#39') Doc' +
        'umentoCliente'
      'FROM'
      #9'Sal_NotasCanceladas SNC'
      #9'JOIN CashRegMov CRM ON (SNC.IDCashRegMov = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'LEFT JOIN Pessoa P ON (SNC.IDPessoa = P.IDPessoa)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister2'
      #9'AND RZ.MovDate > :DataInicial2'
      #9'AND RZ.MovDate <= :DataFinal2'
      #9'AND SNC.COO IS NOT NULL')
    Left = 477
    Top = 7
  end
  object dspVenda: TDataSetProvider
    DataSet = qryVenda
    Left = 477
    Top = 52
  end
  object cdsItemVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemVenda'
    Left = 577
    Top = 97
    object cdsItemVendaNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsItemVendaMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsItemVendaModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsItemVendaNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsItemVendaContadorOrdemOperacao: TIntegerField
      FieldName = 'ContadorOrdemOperacao'
      ReadOnly = True
    end
    object cdsItemVendaContadorDocumento: TIntegerField
      FieldName = 'ContadorDocumento'
      ReadOnly = True
    end
    object cdsItemVendaNumeroItem: TIntegerField
      FieldName = 'NumeroItem'
      ReadOnly = True
    end
    object cdsItemVendaCodigoProduto: TStringField
      FieldName = 'CodigoProduto'
      Size = 30
    end
    object cdsItemVendaDescricaoProduto: TStringField
      FieldName = 'DescricaoProduto'
      Size = 50
    end
    object cdsItemVendaQuantidade: TBCDField
      FieldName = 'Quantidade'
      Precision = 32
    end
    object cdsItemVendaUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object cdsItemVendaValorUnitario: TBCDField
      FieldName = 'ValorUnitario'
      Precision = 19
    end
    object cdsItemVendaDesconto: TBCDField
      FieldName = 'Desconto'
      ReadOnly = True
      Precision = 19
    end
    object cdsItemVendaAcrescimo: TBCDField
      FieldName = 'Acrescimo'
      ReadOnly = True
      Precision = 19
    end
    object cdsItemVendaValorTotalLiquido: TBCDField
      FieldName = 'ValorTotalLiquido'
      ReadOnly = True
      Precision = 32
      Size = 6
    end
    object cdsItemVendaTotalizadorParcial: TStringField
      FieldName = 'TotalizadorParcial'
      ReadOnly = True
      Size = 10
    end
    object cdsItemVendaIndicadorCancelamento: TStringField
      FieldName = 'IndicadorCancelamento'
      ReadOnly = True
      Size = 1
    end
    object cdsItemVendaQuantidadeCancelada: TBCDField
      FieldName = 'QuantidadeCancelada'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsItemVendaValorCancelado: TBCDField
      FieldName = 'ValorCancelado'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsItemVendaCancelamentoAcrescimo: TBCDField
      FieldName = 'CancelamentoAcrescimo'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object cdsItemVendaIAT: TStringField
      FieldName = 'IAT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsItemVendaIPPT: TStringField
      FieldName = 'IPPT'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsItemVendaNumCasaDecQtd: TIntegerField
      FieldName = 'NumCasaDecQtd'
      ReadOnly = True
    end
    object cdsItemVendaNumCasaDecVal: TIntegerField
      FieldName = 'NumCasaDecVal'
      ReadOnly = True
    end
  end
  object qryItemVenda: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'IDCashRegister1'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial1'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal1'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCashRegister2'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial2'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal2'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCashRegister3'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial3'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal3'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      '-- ITENS DE VENDAS FINALIZADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(I.CupomFiscal as Int) ContadorOrdemOperacao,'
      #9'Cast(I.InvoiceCode as Int) ContadorDocumento,'
      #9'IsNull(IM.SequencyNum, 1) NumeroItem,'
      #9'M.Model CodigoProduto,'
      #9'M.[Description] DescricaoProduto,'
      #9'IM.Qty Quantidade,'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'IM.SalePrice ValorUnitario,'
      
        #9'(CASE WHEN IM.Discount >= 0 THEN IM.Discount ELSE 0 END) Descon' +
        'to,'
      
        #9'(CASE WHEN IM.Discount < 0 THEN IM.Discount ELSE 0 END) Acresci' +
        'mo,'
      #9'((IM.SalePrice * IM.Qty) - IM.Discount) ValorTotalLiquido,'
      #9'IsNull(IMC.TotalizadorParcial, '#39'01T1800'#39') TotalizadorParcial,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 QuantidadeCancelada,'
      #9'0.00 ValorCancelado,'
      #9'0.00 CancelamentoAcrescimo,'
      #9'IsNull(M.IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'2 NumCasaDecQtd,'
      #9'2 NumCasaDecVal'
      'FROM'
      #9'InventoryMov IM'
      #9'JOIN Invoice I ON (IM.DocumentID = I.IDInvoice)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN Model M ON (IM.ModelID = M.IDModel)'
      
        #9'LEFT JOIN Inv_MovComplement IMC ON (IM.IDInventoryMov = IMC.IDI' +
        'nventoryMov)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister1'
      #9'AND RZ.MovDate > :DataInicial1'
      #9'AND RZ.MovDate <= :DataFinal1'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- ITENS CANCELADOS DE VENDAS FINALIZADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(I.CupomFiscal as Int) ContadorOrdemOperacao,'
      #9'Cast(I.InvoiceCode as Int) ContadorDocumento,'
      #9'IsNull(RI.PosicaoItem, 1) NumeroItem,'
      #9'M.Model CodigoProduto,'
      #9'M.[Description] DescricaoProduto,'
      #9'RI.Qty Quantidade,'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'RI.SalePrice ValorUnitario,'
      
        #9'(CASE WHEN RI.Discount >= 0 THEN RI.Discount ELSE 0 END) Descon' +
        'to,'
      
        #9'(CASE WHEN RI.Discount < 0 THEN RI.Discount ELSE 0 END) Acresci' +
        'mo,'
      #9'((RI.SalePrice * RI.Qty) - RI.Discount) ValorTotalLiquido,'
      #9'IsNull(RI.TotalizadorParcial, '#39'01T1800'#39') TotalizadorParcial,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 QuantidadeCancelada,'
      #9'0.00 ValorCancelado,'
      #9'0.00 CancelamentoAcrescimo,'
      #9'IsNull(M.IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'2 NumCasaDecQtd,'
      #9'2 NumCasaDecVal'
      'FROM'
      #9'Sal_RemovedItem RI'
      #9'JOIN Invoice I ON (RI.IDPreSale = I.IDPreSale)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN Model M ON (RI.IDModel = M.IDModel)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister2'
      #9'AND RZ.MovDate > :DataInicial2'
      #9'AND RZ.MovDate <= :DataFinal2'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- ITENS CANCELADOS DE VENDAS CANCELADAS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'Cast(SNC.COO as Int) ContadorOrdemOperacao,'
      #9'Cast(SNC.CCF as Int) ContadorDocumento,'
      #9'IsNull(RI.PosicaoItem, 1) NumeroItem,'
      #9'M.Model CodigoProduto,'
      #9'M.[Description] DescricaoProduto,'
      #9'RI.Qty Quantidade,'
      #9'IsNull(U.Sigla, '#39'UN'#39') Unidade,'
      #9'RI.SalePrice ValorUnitario,'
      
        #9'(CASE WHEN RI.Discount >= 0 THEN RI.Discount ELSE 0 END) Descon' +
        'to,'
      
        #9'(CASE WHEN RI.Discount < 0 THEN RI.Discount ELSE 0 END) Acresci' +
        'mo,'
      #9'((RI.SalePrice * RI.Qty) - RI.Discount) ValorTotalLiquido,'
      #9'IsNull(RI.TotalizadorParcial, '#39'01T1800'#39') TotalizadorParcial,'
      #9#39'N'#39' IndicadorCancelamento,'
      #9'0.00 QuantidadeCancelada,'
      #9'0.00 ValorCancelado,'
      #9'0.00 CancelamentoAcrescimo,'
      #9'IsNull(M.IndicadorAT, '#39'T'#39') IAT,'
      #9'IsNull(M.IndicadorProducao, '#39'T'#39') IPPT,'
      #9'2 NumCasaDecQtd,'
      #9'2 NumCasaDecVal'
      'FROM'
      #9'Sal_RemovedItem RI'
      
        #9'JOIN Sal_NotasCanceladas SNC ON (RI.IDNotasCanceladas = SNC.IDN' +
        'otasCanceladas)'
      #9'JOIN CashRegMov CRM ON (SNC.IDCashRegMov = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN Model M ON (RI.IDModel = M.IDModel)'
      #9'LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister3'
      #9'AND RZ.MovDate > :DataInicial3'
      #9'AND RZ.MovDate <= :DataFinal3'
      #9'AND SNC.COO IS NOT NULL')
    Left = 577
    Top = 7
  end
  object dspItemVenda: TDataSetProvider
    DataSet = qryItemVenda
    Left = 577
    Top = 52
  end
  object cdsDocumentoGeral: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentoGeral'
    Left = 677
    Top = 97
    object cdsDocumentoGeralNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsDocumentoGeralMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsDocumentoGeralModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsDocumentoGeralNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsDocumentoGeralCOO: TIntegerField
      FieldName = 'COO'
    end
    object cdsDocumentoGeralGNF: TIntegerField
      FieldName = 'GNF'
    end
    object cdsDocumentoGeralGRG: TIntegerField
      FieldName = 'GRG'
      ReadOnly = True
    end
    object cdsDocumentoGeralCDC: TIntegerField
      FieldName = 'CDC'
    end
    object cdsDocumentoGeralDenominacao: TStringField
      FieldName = 'Denominacao'
      ReadOnly = True
      Size = 2
    end
    object cdsDocumentoGeralDataEmissao: TDateTimeField
      FieldName = 'DataEmissao'
    end
  end
  object qryDocumentoGeral: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'IDCashRegister1'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial1'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal1'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDCashRegister2'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial2'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal2'
        Attributes = [paSigned, paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      '-- DOCUMENTOS DE PAGAMENTOS'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'LC.COO,'
      #9'LC.GNF,'
      #9'0 GRG,'
      #9'LC.CDC,'
      #9#39'CC'#39' Denominacao,'
      #9'LC.DataEmissao'
      'FROM'
      #9'Fin_LancamentoComplement LC'
      #9'JOIN Fin_Lancamento L ON (LC.IDLancamento = L.IDLancamento)'
      #9'JOIN Invoice I ON (L.IDPreSale = I.IDPreSale)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister1'
      #9'AND RZ.MovDate > :DataInicial1'
      #9'AND RZ.MovDate <= :DataFinal1'
      #9'AND I.CupomFiscal IS NOT NULL'
      'UNION'
      '-- DOCUMENTOS DE SANGRIA E SUPRIMENTO'
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'IsNull(CRLC.COO, 0) COO,'
      #9'IsNull(CRLC.GNF, 0) GNF,'
      #9'0 GRG,'
      #9'0 CDC,'
      #9#39'CN'#39' Denominacao,'
      #9'CRL.LogTime DataEmissao'
      'FROM'
      #9'CashRegLogComplement CRLC'
      #9'JOIN CashRegLog CRL ON (CRLC.IDCashRegLog = CRL.IDCashRegLog)'
      #9'JOIN CashRegMov CRM ON (CRL.IDCashRegMov = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister2'
      #9'AND RZ.MovDate > :DataInicial2'
      #9'AND RZ.MovDate <= :DataFinal2')
    Left = 677
    Top = 7
  end
  object dspDocumentoGeral: TDataSetProvider
    DataSet = qryDocumentoGeral
    Left = 677
    Top = 52
  end
  object cdsPagamento: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPagamento'
    Left = 677
    Top = 237
    object cdsPagamentoNumeroFabricacao: TStringField
      FieldName = 'NumeroFabricacao'
    end
    object cdsPagamentoMFAdicional: TStringField
      FieldName = 'MFAdicional'
      FixedChar = True
      Size = 1
    end
    object cdsPagamentoModeloECF: TStringField
      FieldName = 'ModeloECF'
    end
    object cdsPagamentoNumeroUsuarioECF: TIntegerField
      FieldName = 'NumeroUsuarioECF'
    end
    object cdsPagamentoCOO: TIntegerField
      FieldName = 'COO'
    end
    object cdsPagamentoCCF: TStringField
      FieldName = 'CCF'
    end
    object cdsPagamentoGNF: TIntegerField
      FieldName = 'GNF'
    end
    object cdsPagamentoMeioPagamento: TStringField
      FieldName = 'MeioPagamento'
      Size = 50
    end
    object cdsPagamentoValorPago: TBCDField
      FieldName = 'ValorPago'
      Precision = 19
    end
    object cdsPagamentoIndicadorEstorno: TStringField
      FieldName = 'IndicadorEstorno'
      ReadOnly = True
      Size = 1
    end
    object cdsPagamentoValorEstorno: TBCDField
      FieldName = 'ValorEstorno'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
  end
  object qryPagamento: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RZ.NumeroSerie NumeroFabricacao,'
      #9'RZ.MFAdicional,'
      #9'RZ.ModeloECF,'
      #9'RZ.NumeroUsuarioECF,'
      #9'LC.COO,'
      #9'I.InvoiceCode CCF,'
      #9'LC.GNF,'
      #9'MP.MeioPag MeioPagamento,'
      #9'L.ValorNominal ValorPago,'
      #9#39'N'#39' IndicadorEstorno,'
      #9'0.00 ValorEstorno'
      'FROM'
      #9'Fin_LancamentoComplement LC'
      #9'JOIN Fin_Lancamento L ON (LC.IDLancamento = L.IDLancamento)'
      #9'JOIN Invoice I ON (L.IDPreSale = I.IDPreSale)'
      #9'JOIN CashRegMov CRM ON (I.CashRegMovID = CRM.IDCashRegMov)'
      
        #9'JOIN Sal_ReducaoZ RZ ON (CRM.IDCashRegister = RZ.IDCashRegister' +
        ')'
      #9'JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)'
      'WHERE'
      #9'RZ.IDCashRegister = :IDCashRegister'
      #9'AND RZ.MovDate > :DataInicial'
      #9'AND RZ.MovDate <= :DataFinal'
      #9'AND I.CupomFiscal IS NOT NULL')
    Left = 677
    Top = 147
  end
  object dspPagamento: TDataSetProvider
    DataSet = qryPagamento
    Left = 677
    Top = 192
  end
  object cdsMeioPagamento: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPagamento'
    Left = 677
    Top = 377
    object cdsMeioPagamentoMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object cdsMeioPagamentoDataPagamento: TStringField
      FieldName = 'DataPagamento'
      Size = 10
    end
    object cdsMeioPagamentoValorPagamento: TBCDField
      FieldName = 'ValorPagamento'
      ReadOnly = True
      Precision = 19
    end
  end
  object dspMeioPagamento: TDataSetProvider
    DataSet = qryMeioPagamento
    Left = 677
    Top = 332
  end
  object qryMeioPagamento: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 600
    Parameters = <
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'MP.MeioPag,'
      
        #9'(CAST(DATEPART(day, L.DataLancamento) AS VARCHAR(2)) + '#39'/'#39' + CA' +
        'ST(DATEPART(month, L.DataLancamento) AS VARCHAR(2)) + '#39'/'#39' + CAST' +
        '(DATEPART(year, L.DataLancamento) AS VARCHAR(4))) DataPagamento,'
      #9'SUM(L.ValorNominal) ValorPagamento'
      'FROM'
      #9'Fin_Lancamento L (NOLOCK)'
      
        #9'JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMe' +
        'ioPag)'
      #9'JOIN Invoice I (NOLOCK) ON (L.IDPreSale = I.IDPreSale)'
      
        #9'JOIN CashRegMov CRM (NOLOCK) ON (I.CashRegMovID = CRM.IDCashReg' +
        'Mov)'
      'WHERE'
      #9'CRM.IDCashRegister = :IDCashRegister'
      #9'AND L.DataLancamento >= :DataInicial'
      #9'AND L.DataLancamento < :DataFinal'
      'GROUP BY'
      #9'MP.MeioPag,'
      
        #9'(CAST(DATEPART(day, L.DataLancamento) AS VARCHAR(2)) + '#39'/'#39' + CA' +
        'ST(DATEPART(month, L.DataLancamento) AS VARCHAR(2)) + '#39'/'#39' + CAST' +
        '(DATEPART(year, L.DataLancamento) AS VARCHAR(4)))')
    Left = 677
    Top = 287
  end
end
