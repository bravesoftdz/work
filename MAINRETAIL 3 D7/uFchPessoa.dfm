inherited FchPessoa: TFchPessoa
  Left = 281
  Top = 95
  Caption = 'FchPessoa'
  ClientHeight = 476
  ClientWidth = 691
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 691
    TabOrder = 4
    DesignSize = (
      691
      40)
    inherited Image1: TImage
      Width = 417
    end
    inherited lblMenu: TLabel
      Left = 521
    end
    inherited EspacamentoSuperior: TPanel
      Width = 691
      inherited EEE: TPanel
        Width = 691
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 644
    end
  end
  inherited Panel1: TPanel
    Top = 435
    Width = 691
    TabOrder = 3
    inherited EspacamentoInferior: TPanel
      Width = 691
      inherited Panel3: TPanel
        Width = 691
      end
    end
    inherited hhh: TPanel
      Left = 470
      inherited btClose: TButton
        Caption = '&OK'
      end
    end
  end
  inherited pnlDetail: TPanel [2]
    Top = 62
    Width = 691
    Height = 52
    TabOrder = 0
    object lblTipoPessoa: TLabel
      Left = -11
      Top = 6
      Width = 92
      Height = 16
      Alignment = taRightJustify
      Caption = 'Category Type :'
    end
    object pnlPersonal: TPanel
      Left = 0
      Top = 0
      Width = 691
      Height = 25
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object lblPessoa: TLabel
        Left = 10
        Top = 7
        Width = 71
        Height = 16
        Alignment = taRightJustify
        Caption = 'First Name :'
      end
      object Label21: TLabel
        Left = 250
        Top = 3
        Width = 14
        Height = 23
        Caption = '*'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label31: TLabel
        Left = 255
        Top = 5
        Width = 69
        Height = 16
        Alignment = taRightJustify
        Caption = 'Last Name :'
      end
      object Label33: TLabel
        Left = 496
        Top = 3
        Width = 14
        Height = 23
        Caption = '*'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object editPessoa: TDBEdit
        Left = 85
        Top = 2
        Width = 163
        Height = 21
        AutoSize = False
        DataField = 'PessoaFirstName'
        DataSource = dsForm
        MaxLength = 20
        TabOrder = 0
      end
      object dbEditLastName: TDBEdit
        Left = 326
        Top = 2
        Width = 169
        Height = 21
        AutoSize = False
        DataField = 'PessoaLastName'
        DataSource = dsForm
        TabOrder = 1
      end
    end
    object scPessoaTipo: TDBSuperComboADO
      Left = 85
      Top = 3
      Width = 427
      Height = 21
      TabStop = False
      AutoSize = False
      TabOrder = 3
      Text = 'scPessoaTipo'
      CodeLength = 96
      LookUpSource = DM.dsLookUpTipoPessoa
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      OnSelectItem = scPessoaTipoSelectItem
      DataField = 'IDTipoPessoa'
      DataSource = dsForm
    end
    object pnlBusiness: TPanel
      Left = 0
      Top = 25
      Width = 691
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object Label34: TLabel
        Left = 18
        Top = 6
        Width = 62
        Height = 16
        Alignment = taRightJustify
        Caption = 'Company :'
      end
      object Label35: TLabel
        Left = 496
        Top = 3
        Width = 14
        Height = 23
        Caption = '*'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbedtCompany: TDBEdit
        Left = 85
        Top = 2
        Width = 410
        Height = 21
        AutoSize = False
        DataField = 'Pessoa'
        DataSource = dsForm
        TabOrder = 0
      end
    end
    object TipoCli: TRadioGroup
      Left = 517
      Top = -3
      Width = 80
      Height = 51
      Items.Strings = (
        'Personal'
        'Business')
      TabOrder = 2
      OnClick = TipoCliClick
    end
  end
  inherited pnlKey: TPanel [3]
    Top = 114
    Width = 691
    Height = 0
    TabOrder = 1
    inherited Panel4: TPanel
      Top = 0
      Width = 691
      Height = 0
      Visible = False
    end
  end
  inherited PageControl: TPageControl
    Top = 157
    Width = 685
    Height = 278
    ActivePage = tsHistory
    HotTrack = True
    TabOrder = 2
    TabStop = False
    OnChange = PageControlChange
    object Basic: TTabSheet
      Caption = 'Basic'
      object pnlFisico: TPanel
        Tag = 2
        Left = 0
        Top = 216
        Width = 677
        Height = 106
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label10: TLabel
          Left = 21
          Top = 8
          Width = 106
          Height = 16
          Alignment = taRightJustify
          Caption = 'Social Security # :'
        end
        object Label11: TLabel
          Left = 326
          Top = 8
          Width = 111
          Height = 16
          Alignment = taRightJustify
          Caption = 'Driver'#39's Licence # :'
        end
        object Label9: TLabel
          Left = 62
          Top = 34
          Width = 65
          Height = 16
          Alignment = taRightJustify
          Caption = 'Birth Date :'
        end
        object Label16: TLabel
          Left = 47
          Top = 58
          Width = 80
          Height = 16
          Alignment = taRightJustify
          Caption = 'Employee ID :'
        end
        object lbHasCPF: TLabel
          Left = 315
          Top = 58
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lnHasIdent: TLabel
          Left = 315
          Top = 8
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasBirth: TLabel
          Left = 315
          Top = 34
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbDriversLinc: TLabel
          Left = 581
          Top = 3
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbProfession: TLabel
          Left = 367
          Top = 34
          Width = 68
          Height = 16
          Alignment = taRightJustify
          Caption = 'Profession :'
        end
        object lbSex: TLabel
          Left = 77
          Top = 82
          Width = 50
          Height = 16
          Alignment = taRightJustify
          Caption = 'Gender :'
        end
        object DBEdit9: TDBEdit
          Left = 130
          Top = 5
          Width = 184
          Height = 24
          DataField = 'Identidade'
          DataSource = dsForm
          TabOrder = 1
        end
        object DBEdit10: TDBEdit
          Left = 441
          Top = 1
          Width = 130
          Height = 24
          DataField = 'CartMotorista'
          DataSource = dsForm
          TabOrder = 4
        end
        object DBEdit12: TDBEdit
          Left = 130
          Top = 55
          Width = 183
          Height = 24
          DataField = 'CPF'
          DataSource = dsForm
          TabOrder = 3
          OnExit = DBEdit12Exit
          OnKeyPress = EditFederalIDKeyPress
        end
        object DBDateBox1: TDBDateBox
          Left = 130
          Top = 31
          Width = 185
          Height = 24
          ReadOnly = False
          TabOrder = 2
          InputTime = False
          DataField = 'Nascimento'
          DataSource = dsForm
        end
        object pnlCPF: TPanel
          Left = 129
          Top = 5
          Width = 189
          Height = 26
          BevelOuter = bvNone
          TabOrder = 0
          object DBEdit3: TDBEdit
            Left = 2
            Top = 1
            Width = 68
            Height = 24
            DataField = 'Identidade'
            DataSource = dsForm
            TabOrder = 0
            OnExit = DBEdit12Exit
          end
          object DBEdit4: TDBEdit
            Left = 71
            Top = 1
            Width = 31
            Height = 24
            DataField = 'OrgaoEmissor'
            DataSource = dsForm
            TabOrder = 1
            OnExit = DBEdit12Exit
          end
          object DBDateBox2: TDBDateBox
            Left = 102
            Top = 1
            Width = 84
            Height = 24
            ReadOnly = False
            TabOrder = 2
            InputTime = False
            DataField = 'DataExpedicao'
            DataSource = dsForm
          end
        end
        object scProfession: TDBSuperComboADO
          Left = 440
          Top = 31
          Width = 132
          Height = 24
          TabOrder = 5
          Text = 'scProfession'
          CodeLength = 5
          LookUpSource = DM.dsLookUpRamoAtividade
          DropDownRows = 10
          IDLanguage = 0
          DataField = 'IDRamoAtividade'
          DataSource = dsForm
        end
        object rgGender: TRadioGroup
          Left = 130
          Top = 76
          Width = 183
          Height = 30
          Columns = 2
          Items.Strings = (
            'Male'
            'Female')
          TabOrder = 6
          OnEnter = rgGenderEnter
        end
      end
      object pnlJuridico: TPanel
        Tag = 1
        Left = 0
        Top = 322
        Width = 677
        Height = 81
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label2: TLabel
          Left = 95
          Top = 8
          Width = 32
          Height = 16
          Alignment = taRightJustify
          Caption = 'DBA :'
        end
        object Label17: TLabel
          Left = 46
          Top = 33
          Width = 81
          Height = 16
          Alignment = taRightJustify
          Caption = 'Federal ID # :'
        end
        object Label18: TLabel
          Left = 49
          Top = 58
          Width = 78
          Height = 16
          Alignment = taRightJustify
          Caption = 'Sales Tax # :'
        end
        object Label20: TLabel
          Left = 387
          Top = 34
          Width = 48
          Height = 16
          Alignment = taRightJustify
          Caption = 'Contact:'
        end
        object lbHasNomeJur: TLabel
          Left = 573
          Top = 6
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasContact: TLabel
          Left = 573
          Top = 30
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasIncEst: TLabel
          Left = 298
          Top = 32
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lnHasInscMun: TLabel
          Left = 298
          Top = 56
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object EditDBA: TDBEdit
          Left = 130
          Top = 5
          Width = 441
          Height = 24
          DataField = 'NomeJuridico'
          DataSource = dsForm
          TabOrder = 0
        end
        object EditFederalID: TDBEdit
          Left = 130
          Top = 30
          Width = 166
          Height = 24
          DataField = 'InscEstadual'
          DataSource = dsForm
          TabOrder = 1
          OnExit = EditFederalIDExit
          OnKeyPress = EditFederalIDKeyPress
        end
        object EditSalesTax: TDBEdit
          Left = 130
          Top = 55
          Width = 166
          Height = 24
          DataField = 'InscMunicipal'
          DataSource = dsForm
          TabOrder = 2
        end
        object EditContact: TDBEdit
          Left = 440
          Top = 30
          Width = 132
          Height = 24
          DataField = 'Contato'
          DataSource = dsForm
          TabOrder = 3
        end
      end
      object pnlAddress: TPanel
        Left = 0
        Top = 23
        Width = 677
        Height = 193
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label8: TLabel
          Left = 394
          Top = 31
          Width = 44
          Height = 16
          Alignment = taRightJustify
          Caption = 'Phone :'
        end
        object Label6: TLabel
          Left = 100
          Top = 104
          Width = 27
          Height = 16
          Alignment = taRightJustify
          Caption = 'ZIP :'
        end
        object Label7: TLabel
          Left = 88
          Top = 81
          Width = 39
          Height = 16
          Alignment = taRightJustify
          Caption = 'State :'
        end
        object Label5: TLabel
          Left = 97
          Top = 56
          Width = 30
          Height = 16
          Alignment = taRightJustify
          Caption = 'City :'
        end
        object Label3: TLabel
          Left = 72
          Top = 6
          Width = 55
          Height = 16
          Alignment = taRightJustify
          Caption = 'Address :'
        end
        object Label22: TLabel
          Left = 396
          Top = 82
          Width = 40
          Height = 16
          Alignment = taRightJustify
          Caption = 'Email :'
          FocusControl = EditEMail
        end
        object Label23: TLabel
          Left = 368
          Top = 153
          Width = 70
          Height = 16
          Alignment = taRightJustify
          Caption = 'HomePage :'
        end
        object Label4: TLabel
          Left = 408
          Top = 130
          Width = 29
          Height = 16
          Alignment = taRightJustify
          Caption = 'Fax :'
        end
        object Label45: TLabel
          Left = 391
          Top = 58
          Width = 48
          Height = 16
          Alignment = taRightJustify
          Caption = 'Cellular:'
          FocusControl = DbEditCellular
        end
        object Label46: TLabel
          Left = 396
          Top = 106
          Width = 42
          Height = 16
          Alignment = taRightJustify
          Caption = 'Pager :'
          FocusControl = DBEditBeeper
        end
        object Label24: TLabel
          Left = 72
          Top = 129
          Width = 53
          Height = 16
          Alignment = taRightJustify
          Caption = 'Country :'
        end
        object Label19: TLabel
          Left = 38
          Top = 31
          Width = 88
          Height = 16
          Alignment = taRightJustify
          Caption = 'Neighborhood :'
          FocusControl = edtBairro
        end
        object lbHasAdr: TLabel
          Left = 580
          Top = 5
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasBairro: TLabel
          Left = 317
          Top = 29
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasCty: TLabel
          Left = 317
          Top = 55
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasStat: TLabel
          Left = 317
          Top = 79
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasZip: TLabel
          Left = 317
          Top = 102
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasPhone: TLabel
          Left = 581
          Top = 30
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasCountry: TLabel
          Left = 317
          Top = 127
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasCel: TLabel
          Left = 581
          Top = 56
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasEmail: TLabel
          Left = 580
          Top = 79
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasBeeper: TLabel
          Left = 579
          Top = 103
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasFax: TLabel
          Left = 580
          Top = 127
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasHomePage: TLabel
          Left = 579
          Top = 152
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbMunicipio: TLabel
          Left = 62
          Top = 152
          Width = 63
          Height = 16
          Alignment = taRightJustify
          Caption = 'City Code :'
        end
        object lbHasCodMunicipio: TLabel
          Left = 316
          Top = 148
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lbHasCustCard: TLabel
          Left = 580
          Top = 172
          Width = 14
          Height = 23
          Caption = '*'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label32: TLabel
          Left = 330
          Top = 175
          Width = 108
          Height = 16
          Alignment = taRightJustify
          Caption = 'Customer Card # :'
        end
        object edtZIP: TDBEdit
          Left = 130
          Top = 101
          Width = 184
          Height = 24
          DataField = 'CEP'
          DataSource = dsForm
          TabOrder = 6
        end
        object scState: TDBSuperComboADO
          Left = 130
          Top = 78
          Width = 184
          Height = 24
          TabOrder = 5
          Text = 'scState'
          CodeLength = 5
          LookUpSource = DM.dsLookUpEstado
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDEstado'
          DataSource = dsForm
        end
        object edtCity: TDBEdit
          Left = 130
          Top = 53
          Width = 184
          Height = 24
          DataField = 'Cidade'
          DataSource = dsForm
          TabOrder = 4
        end
        object edtAddress: TDBEdit
          Left = 130
          Top = 3
          Width = 309
          Height = 24
          DataField = 'Endereco'
          DataSource = dsForm
          TabOrder = 0
        end
        object EditEMail: TDBEdit
          Left = 441
          Top = 77
          Width = 134
          Height = 24
          DataField = 'Email'
          DataSource = dsForm
          TabOrder = 13
          OnExit = EditEMailExit
        end
        object EditHomePage: TDBEdit
          Left = 441
          Top = 150
          Width = 131
          Height = 24
          DataField = 'HomePage'
          DataSource = dsForm
          TabOrder = 16
        end
        object MemoFax: TDbMemoStr
          Left = 441
          Top = 126
          Width = 133
          Height = 21
          DataField = 'Fax'
          DataSource = dsForm
          TabOrder = 15
        end
        object DbEditCellular: TDBEdit
          Left = 480
          Top = 54
          Width = 96
          Height = 24
          DataField = 'Cellular'
          DataSource = dsForm
          TabOrder = 12
          OnExit = DbEditCellularExit
        end
        object DBEditBeeper: TDBEdit
          Left = 441
          Top = 101
          Width = 134
          Height = 24
          DataField = 'Beeper'
          DataSource = dsForm
          TabOrder = 14
        end
        object scCountry: TDBSuperComboADO
          Left = 130
          Top = 125
          Width = 184
          Height = 24
          TabOrder = 7
          Text = 'scCountry'
          CodeLength = 5
          LookUpSource = DM.dsLookUpPais
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDPais'
          DataSource = dsForm
        end
        object edtBairro: TDBEdit
          Left = 130
          Top = 28
          Width = 184
          Height = 24
          DataField = 'Bairro'
          DataSource = dsForm
          TabOrder = 3
        end
        object edtPhoneDDD: TDBEdit
          Left = 441
          Top = 28
          Width = 39
          Height = 24
          DataField = 'PhoneAreaCode'
          DataSource = dsForm
          TabOrder = 10
          OnExit = edtPhoneDDDExit
        end
        object edtCellDDD: TDBEdit
          Left = 441
          Top = 54
          Width = 38
          Height = 24
          DataField = 'CellAreaCode'
          DataSource = dsForm
          TabOrder = 11
          OnExit = edtCellDDDExit
        end
        object chkExempSaleTax: TDBCheckBox
          Left = 130
          Top = 172
          Width = 191
          Height = 17
          Caption = 'Exempt Sales Tax'
          DataField = 'SalesTaxExempt'
          DataSource = dsForm
          TabOrder = 9
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object edtNumero: TDBEdit
          Left = 442
          Top = 3
          Width = 61
          Height = 24
          DataField = 'ComplementoNum'
          DataSource = dsForm
          TabOrder = 1
        end
        object edtComplement: TDBEdit
          Left = 504
          Top = 3
          Width = 72
          Height = 24
          DataField = 'Complemento'
          DataSource = dsForm
          TabOrder = 2
        end
        object scMunicipio: TDBSuperComboADO
          Left = 130
          Top = 148
          Width = 184
          Height = 24
          TabOrder = 8
          Text = 'scMunicipio'
          CodeLength = 5
          LookUpSource = DM.dsLookupMunicipio
          DropDownRows = 18
          IDLanguage = 0
          DataField = 'IDMunicipio'
          DataSource = dsForm
        end
        object edtCustomerCard: TDBEdit
          Left = 441
          Top = 171
          Width = 131
          Height = 24
          Color = 16769734
          DataField = 'CustomerCard'
          DataSource = dsForm
          TabOrder = 17
        end
        object edtPhone: TDBEdit
          Left = 482
          Top = 27
          Width = 95
          Height = 24
          DataField = 'Telefone'
          DataSource = dsForm
          TabOrder = 18
          OnExit = edtPhoneExit
        end
      end
      object pnlSearchZip: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object sbSearchZip: TSpeedButton
          Left = 131
          Top = 1
          Width = 174
          Height = 22
          Caption = 'Search ZIP - Press (F2)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            4D85D0908AA9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF6FC5FD458ADE908AA9FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF6FC5FD458ADE908AA9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6DC1FD478CD2908AA9EA
            CFA9EACFA9EACFA9EACFA9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF6DC1FDB5968AEACFA9FFF9C9FFFFDAF9F0DAD8B798FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFEACFA9EAC7ADFF
            F3BDFFFDD2FFFFEBFFFFFFFDFBF3D8B798FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFEACFA9FBEEBDFFE2B1FFFDD2FFFFEDFFFFF7FFFFE6DABF
            A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFEACFA9FFF5C1FF
            E8B3FFF7C5FFFFDAFFFFDEFFFFD6DEC5A8FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFEACFA9F5E6D0FFF5DEFFE6B9FFF1B9FFF3BDFFF9CAD6AD
            98FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD8B798FB
            F6F4FFF3CEFDE6B7FFEEBFE6BF9CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFD8B798D8B798DEC3A4D8B7A6FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          Margin = 1
          OnClick = sbSearchZipClick
        end
      end
      object pnlOBS: TPanel
        Left = 0
        Top = 403
        Width = 677
        Height = 54
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 4
        object lbOBS: TLabel
          Left = 93
          Top = 10
          Width = 31
          Height = 16
          Alignment = taRightJustify
          Caption = 'Obs :'
        end
        object memOBS: TDBMemo
          Left = 130
          Top = 10
          Width = 441
          Height = 36
          DataField = 'OBS'
          DataSource = dsForm
          MaxLength = 150
          TabOrder = 0
        end
      end
    end
    object tsPet: TTabSheet
      Caption = 'Pet'
      ImageIndex = 8
      object btnDelPet: TSpeedButton
        Left = 507
        Top = 52
        Width = 80
        Height = 24
        Caption = '&Remove'
        Flat = True
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        Margin = 5
        OnClick = btnDelPetClick
      end
      object btnAddPet: TSpeedButton
        Left = 507
        Top = 4
        Width = 80
        Height = 24
        Caption = 'A&dd'
        Flat = True
        Glyph.Data = {
          B6020000424DB60200000000000036000000280000000D000000100000000100
          18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
          D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
          DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
          D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
          FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
          7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
          FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
          E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
          EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
          FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
          8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
          FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
          F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
          FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
          7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
          F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
          E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
          9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
        Margin = 5
        OnClick = btnAddPetClick
      end
      object btnOpenPet: TSpeedButton
        Tag = 1
        Left = 507
        Top = 28
        Width = 80
        Height = 24
        Caption = 'De&tail'
        Flat = True
        Glyph.Data = {
          46050000424D4605000000000000360000002800000012000000120000000100
          2000000000001005000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0023A8D6008FD8F40047BFE9002DB1E0007AAE
          EE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0015A3D4008BD5F40094E3
          FF0078DAFF0065D2F90054C9F10047C1EA0053C9EE00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000BA0
          D30077CEF000A3EAFF0081E7FF0081E7FF0081E7FF0081E7FF007CE6FD0072DD
          F70066D8F40055CEEF0055CEEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0027ADDE005FC5F4009DE4F400A6FFFF0099FDFF0095F9FF0095F9
          FF0099FDFF0092F8FF0097FBFF0085EAFF0087E7FF0055CEEF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF002AAFDE0055C4F10086D5ED00B9FCFD00A3FD
          FF00A3FDFF00A3FDFF00A3FDFF00A3FDFF00A3FDFF0090F2FF0097E4FF009FEC
          F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002BB0DE006DD5FA005AC8
          ED0075D2EE0093DEF100B7EBFB00CDF9FF00C1FDFF00BCFDFF00BCFDFF00A3EF
          FF009AE3FF00CFF5FC0077A4EA00FF00FF00FF00FF00FF00FF00FF00FF0038B8
          E30082E8FF0075DEFC0077E0FA0050BFE7004ABEEA0059C0E600D1EFF400D3FF
          FF00D3FFFF00B2EEFF009CE0F40044A1540077C0BA00FF00FF00FF00FF00FF00
          FF00FF00FF003DBCE4008EF5FF008EF5FF008EF5FF008EF5FF008EF5FF0082F1
          FF003EC1E40052C1E50050C4EA0044B8D6002C9B5E003CC667002A9F4D00FF00
          FF00FF00FF00FF00FF00FF00FF0043C0E7009FFEFF009CFFFF009CFFFF00A0FF
          FF00AEFFFF00ABFFFF00A4FDFF0096FCFF0071E0E2002C9F6B002DBB57005AE3
          840049D06C002A9F4D00FF00FF00FF00FF00FF00FF0050C4EB00BCFDFF00A5FC
          FF009DFEFF00B7F9FC0091DEF10074D7F1006BD5F1006BD7E70067BE85002BA9
          430051DA79005AE384005AE384004AC76900FF00FF00FF00FF00FF00FF0042BB
          E8008ED7F2009EE3F500B0ECF80092D7F5004DA8EA00FF00FF00FF00FF00FF00
          FF0078B178004C9D4F0033BD56005AE3840042C6640049AC560073AB6E00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00439059003CC96C005BA17700FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006775670029B551003797
          5400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0088608D007E547A005D4A63004C725500209D
          2D0023973800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A4A2A8005A9D
          550066A56200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00}
        Margin = 5
        OnClick = btnAddPetClick
      end
      object grdPet: TcxGrid
        Left = 0
        Top = 0
        Width = 505
        Height = 247
        Align = alLeft
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdPetDBTableView: TcxGridDBTableView
          DataController.DataSource = dsPet
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPet'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object grdPetDBTableViewIDPet: TcxGridDBColumn
            DataBinding.FieldName = 'IDPet'
            Visible = False
          end
          object grdPetDBTableViewName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Width = 91
          end
          object grdPetDBTableViewSex: TcxGridDBColumn
            DataBinding.FieldName = 'Sex'
            Width = 54
          end
          object grdPetDBTableViewPorte: TcxGridDBColumn
            DataBinding.FieldName = 'Porte'
            Width = 82
          end
          object grdPetDBTableViewBreed: TcxGridDBColumn
            DataBinding.FieldName = 'Breed'
            Width = 86
          end
          object grdPetDBTableViewSpecies: TcxGridDBColumn
            DataBinding.FieldName = 'Species'
            Width = 99
          end
          object grdPetDBTableViewWhelpDate: TcxGridDBColumn
            DataBinding.FieldName = 'WhelpDate'
            Width = 91
          end
        end
        object grdPetLevel: TcxGridLevel
          GridView = grdPetDBTableView
        end
      end
    end
    object PurchaseHistory: TTabSheet
      Caption = 'Purchase History'
      object pnlPurchaseHistoryFilter: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label21312312: TLabel
          Left = 255
          Top = 8
          Width = 39
          Height = 16
          Alignment = taRightJustify
          Caption = 'From :'
        end
        object Label48213: TLabel
          Left = 408
          Top = 8
          Width = 11
          Height = 16
          Alignment = taRightJustify
          Caption = 'to'
        end
        object btPHGo: TSpeedButton
          Left = 529
          Top = 4
          Width = 56
          Height = 21
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          NumGlyphs = 2
          ParentFont = False
          OnClick = btPHGoClick
        end
        object dtPHIni: TDateBox
          Left = 297
          Top = 4
          Width = 87
          Height = 24
          TabOrder = 0
          InputTime = False
          Language = Portuguese
        end
        object dtPHFim: TDateBox
          Left = 424
          Top = 4
          Width = 87
          Height = 24
          TabOrder = 1
          InputTime = False
          Language = Portuguese
        end
      end
      object dxDBGridPH: TSMDBGrid
        Left = 0
        Top = 30
        Width = 677
        Height = 217
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsPurchaseHistory
        FixedColor = 14607076
        Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Flat = True
        Groupings = <>
        GridStyle.Style = gsCustom
        GridStyle.OddColor = clWindow
        GridStyle.EvenColor = 14607076
        FooterColor = clBtnFace
        ExOptions = [eoAutoWidth, eoKeepSelection]
        RegistryKey = 'Software\Scalabium'
        RegistrySection = 'SMDBGrid'
        WidthOfIndicator = 11
        DefaultRowHeight = 20
        ScrollBars = ssVertical
        ColCount = 8
        RowCount = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'Model'
            Width = 107
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Category'
            Width = 107
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'MovDate'
            Width = 49
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Qty'
            Width = 22
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'CostPrice'
            Title.Alignment = taRightJustify
            Width = 69
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Freight'
            Title.Alignment = taRightJustify
            Width = 69
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'OtherCost'
            Title.Alignment = taRightJustify
            Width = 69
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Total'
            Title.Alignment = taRightJustify
            Width = 127
            Visible = True
            FooterType = ftCustom
          end>
      end
    end
    object InvoiceHistory: TTabSheet
      Caption = 'Invoice History'
      ImageIndex = 2
      object pgSale: TPageControl
        Left = 0
        Top = 25
        Width = 677
        Height = 222
        ActivePage = tsInvoiceItens
        Align = alClient
        TabOrder = 0
        object tsInvoice: TTabSheet
          Caption = 'Invoice'
          object dxDBGrid2: TSMDBGrid
            Left = 0
            Top = 0
            Width = 669
            Height = 191
            Align = alClient
            BorderStyle = bsNone
            DataSource = dsInvoiceHistory
            FixedColor = 14607076
            Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = dxDBGrid2DblClick
            Flat = True
            Groupings = <>
            GridStyle.Style = gsCustom
            GridStyle.OddColor = clWindow
            GridStyle.EvenColor = 14607076
            FooterColor = clBtnFace
            ExOptions = [eoAutoWidth, eoKeepSelection]
            RegistryKey = 'Software\Scalabium'
            RegistrySection = 'SMDBGrid'
            WidthOfIndicator = 11
            DefaultRowHeight = 20
            ScrollBars = ssVertical
            RowCount = 2
            Columns = <
              item
                Expanded = False
                FieldName = 'Hold'
                Width = 121
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'IDInvoice'
                Width = 73
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'InvoiceDate'
                Width = 112
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Store'
                Width = 204
                Visible = True
                FooterType = ftCustom
              end
              item
                Expanded = False
                FieldName = 'Value'
                Title.Alignment = taRightJustify
                Width = 102
                Visible = True
                FooterType = ftCustom
              end>
          end
        end
        object tsInvoiceItens: TTabSheet
          Caption = 'Invoice Items'
          ImageIndex = 1
          object grdBrowse: TcxGrid
            Left = 0
            Top = 0
            Width = 554
            Height = 191
            Align = alClient
            TabOrder = 0
            LookAndFeel.Kind = lfFlat
            object grdBrowseDB: TcxGridDBTableView
              DataController.DataSource = dsInvoiceItem
              DataController.Filter.Criteria = {FFFFFFFF0000000000}
              DataController.Summary.DefaultGroupSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'Qty'
                  Column = grdBrowseDBQty
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'Discount'
                  Column = grdBrowseDBDiscount
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  Position = spFooter
                  FieldName = 'SalePrice'
                  Column = grdBrowseDBSalePrice
                end>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'Qty'
                  Column = grdBrowseDBQty
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'Discount'
                  Column = grdBrowseDBDiscount
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  FieldName = 'SalePrice'
                  Column = grdBrowseDBSalePrice
                end>
              DataController.Summary.SummaryGroups = <>
              Filtering.MaxDropDownCount = 50
              Filtering.Visible = fvNever
              OptionsBehavior.IncSearch = True
              OptionsCustomize.ColumnFiltering = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.ColumnAutoWidth = True
              OptionsView.Footer = True
              OptionsView.GridLines = glHorizontal
              OptionsView.GroupByBox = False
              OptionsView.GroupFooters = gfVisibleWhenExpanded
              OptionsView.HeaderAutoHeight = True
              OptionsView.HeaderEndEllipsis = True
              Preview.AutoHeight = False
              Preview.MaxLineCount = 2
              object grdBrowseDBInvoiceDate: TcxGridDBColumn
                Caption = 'Date'
                DataBinding.FieldName = 'InvoiceDate'
                Width = 47
              end
              object grdBrowseDBCategory: TcxGridDBColumn
                DataBinding.FieldName = 'Category'
                Width = 61
              end
              object grdBrowseDBModel: TcxGridDBColumn
                DataBinding.FieldName = 'Model'
                Width = 61
              end
              object grdBrowseDBDescription: TcxGridDBColumn
                DataBinding.FieldName = 'Description'
                Width = 101
              end
              object grdBrowseDBQty: TcxGridDBColumn
                DataBinding.FieldName = 'Qty'
                Width = 69
              end
              object grdBrowseDBDiscount: TcxGridDBColumn
                DataBinding.FieldName = 'Discount'
                Width = 54
              end
              object grdBrowseDBSalePrice: TcxGridDBColumn
                DataBinding.FieldName = 'SalePrice'
                Width = 76
              end
            end
            object grdBrowseLevel: TcxGridLevel
              GridView = grdBrowseDB
            end
          end
          object Panelm6: TPanel
            Left = 554
            Top = 0
            Width = 115
            Height = 191
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object btGroup: TSpeedButton
              Tag = 3
              Left = 2
              Top = 30
              Width = 111
              Height = 25
              AllowAllUp = True
              GroupIndex = 88997
              Caption = '&Grouping'
              Flat = True
              Margin = 7
              Spacing = 8
              OnClick = btGroupClick
            end
            object btExcel: TSpeedButton
              Tag = 6
              Left = 2
              Top = 4
              Width = 111
              Height = 26
              Hint = 'Export grid'
              Caption = 'F6 E&xport'
              Flat = True
              Margin = 4
              ParentShowHint = False
              ShowHint = True
              Spacing = 5
              OnClick = btExcelClick
            end
          end
        end
      end
      object pnlInvoiceHsitoryFilter: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label26: TLabel
          Left = 249
          Top = 7
          Width = 39
          Height = 16
          Alignment = taRightJustify
          Caption = 'From :'
        end
        object Label28: TLabel
          Left = 404
          Top = 7
          Width = 11
          Height = 16
          Alignment = taRightJustify
          Caption = 'to'
        end
        object btIHGo: TSpeedButton
          Left = 521
          Top = 2
          Width = 56
          Height = 21
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          NumGlyphs = 2
          ParentFont = False
          OnClick = btIHGoClick
        end
        object dtIHIni: TDateBox
          Left = 294
          Top = 3
          Width = 87
          Height = 24
          TabOrder = 0
          InputTime = False
          Language = Portuguese
        end
        object dtIHFim: TDateBox
          Left = 421
          Top = 3
          Width = 87
          Height = 24
          TabOrder = 1
          InputTime = False
          Language = Portuguese
        end
      end
    end
    object GroupHistory: TTabSheet
      Caption = 'Group History'
      ImageIndex = 3
      object pnlGroupHistoryFilter: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 249
          Top = 8
          Width = 39
          Height = 16
          Alignment = taRightJustify
          Caption = 'From :'
        end
        object Label14: TLabel
          Left = 403
          Top = 8
          Width = 11
          Height = 16
          Alignment = taRightJustify
          Caption = 'to'
        end
        object btGHGo: TSpeedButton
          Left = 529
          Top = 4
          Width = 56
          Height = 21
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          NumGlyphs = 2
          ParentFont = False
          OnClick = btGHGoClick
        end
        object dtGHIni: TDateBox
          Left = 293
          Top = 4
          Width = 87
          Height = 24
          TabOrder = 0
          InputTime = False
          Language = Portuguese
        end
        object dtGHFim: TDateBox
          Left = 421
          Top = 4
          Width = 87
          Height = 24
          TabOrder = 1
          InputTime = False
          Language = Portuguese
        end
      end
      object dxDBGridGH: TSMDBGrid
        Left = 0
        Top = 30
        Width = 677
        Height = 217
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsGroupHistory
        FixedColor = 14607076
        Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = dxDBGridGHDblClick
        Flat = True
        Groupings = <>
        GridStyle.Style = gsCustom
        GridStyle.OddColor = clWindow
        GridStyle.EvenColor = 14607076
        FooterColor = clBtnFace
        ExOptions = [eoAutoWidth, eoKeepSelection]
        RegistryKey = 'Software\Scalabium'
        RegistrySection = 'SMDBGrid'
        WidthOfIndicator = 11
        DefaultRowHeight = 20
        ScrollBars = ssVertical
        ColCount = 6
        RowCount = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'EnterDate'
            Width = 71
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Guide'
            Width = 152
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Agency'
            Width = 140
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'NumTourist'
            Width = 86
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'QTYInvoice'
            Width = 86
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'TotalInvoice'
            Title.Alignment = taRightJustify
            Width = 85
            Visible = True
            FooterType = ftCustom
          end>
      end
    end
    object Accounting: TTabSheet
      Caption = 'Office Manager'
      ImageIndex = 4
      object pnlAccountingFilter: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label29: TLabel
          Left = 250
          Top = 8
          Width = 39
          Height = 16
          Alignment = taRightJustify
          Caption = 'From :'
        end
        object Label30: TLabel
          Left = 403
          Top = 8
          Width = 11
          Height = 16
          Alignment = taRightJustify
          Caption = 'to'
        end
        object btAGo: TSpeedButton
          Left = 529
          Top = 4
          Width = 56
          Height = 21
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          NumGlyphs = 2
          ParentFont = False
          OnClick = btAGoClick
        end
        object dtAIni: TDateBox
          Left = 293
          Top = 4
          Width = 87
          Height = 24
          TabOrder = 0
          InputTime = False
          Language = Portuguese
        end
        object dtAFim: TDateBox
          Left = 418
          Top = 4
          Width = 87
          Height = 24
          TabOrder = 1
          InputTime = False
          Language = Portuguese
        end
      end
      object grdAccount: TcxGrid
        Left = 0
        Top = 30
        Width = 677
        Height = 217
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdAccountDBTableView: TcxGridDBTableView
          DataController.DataSource = dsAccount
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDLancamento'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'ValorNominal'
              Column = grdAccountDBTableViewValorNominal
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'TotalQuitado'
              Column = grdAccountDBTableViewTotalQuitado
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          object grdAccountDBTableViewIDLancamento: TcxGridDBColumn
            DataBinding.FieldName = 'IDLancamento'
            Visible = False
          end
          object grdAccountDBTableViewPagando: TcxGridDBColumn
            DataBinding.FieldName = 'Pagando'
            Visible = False
          end
          object grdAccountDBTableViewHistorico: TcxGridDBColumn
            DataBinding.FieldName = 'Historico'
            Visible = False
          end
          object grdAccountDBTableViewDataFimQuitacao: TcxGridDBColumn
            DataBinding.FieldName = 'DataFimQuitacao'
            Visible = False
          end
          object grdAccountDBTableViewLancamentoTipo: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'LancamentoTipo'
            Width = 253
          end
          object grdAccountDBTableViewDataVencimento: TcxGridDBColumn
            Caption = 'Due Date'
            DataBinding.FieldName = 'DataVencimento'
            Width = 139
          end
          object grdAccountDBTableViewValorNominal: TcxGridDBColumn
            Caption = 'Account'
            DataBinding.FieldName = 'ValorNominal'
            Width = 96
          end
          object grdAccountDBTableViewTotalQuitado: TcxGridDBColumn
            Caption = 'Paid'
            DataBinding.FieldName = 'TotalQuitado'
            Width = 95
          end
        end
        object grdAccountLevel: TcxGridLevel
          GridView = grdAccountDBTableView
        end
      end
    end
    object tsVendorTerm: TTabSheet
      Caption = 'Vendor Terms'
      ImageIndex = 5
      object Label13: TLabel
        Left = 5
        Top = 46
        Width = 277
        Height = 16
        Caption = 'Inform here the discounts for advance payments'
        Visible = False
      end
      object btNew: TSpeedButton
        Left = 294
        Top = 72
        Width = 70
        Height = 25
        Caption = 'New'
        Enabled = False
        Flat = True
        Glyph.Data = {
          B6020000424DB60200000000000036000000280000000D000000100000000100
          18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
          D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
          DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
          D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
          FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
          7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
          FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
          E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
          EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
          FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
          8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
          FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
          F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
          FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
          7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
          F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
          E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
          9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
        Margin = 3
        OnClick = btNewClick
      end
      object btDelete: TSpeedButton
        Tag = 2
        Left = 294
        Top = 97
        Width = 70
        Height = 25
        Caption = 'Remove'
        Enabled = False
        Flat = True
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        Margin = 3
        OnClick = btDeleteClick
      end
      object btPost: TSpeedButton
        Left = 294
        Top = 127
        Width = 70
        Height = 25
        Caption = 'Ok'
        Flat = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        Margin = 3
        NumGlyphs = 2
        OnClick = btPostClick
      end
      object btCancelPost: TSpeedButton
        Tag = 2
        Left = 294
        Top = 152
        Width = 70
        Height = 25
        Caption = 'Cancel'
        Flat = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        Margin = 3
        NumGlyphs = 2
        OnClick = btCancelPostClick
      end
      object lbOCMin: TLabel
        Left = 14
        Top = 30
        Width = 101
        Height = 16
        Alignment = taRightJustify
        Caption = 'PO Min. Amount :'
        FocusControl = DBEdit5
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 677
        Height = 18
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '  Default Terms for this vendor'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object grdTerm: TSMDBGrid
        Left = 3
        Top = 66
        Width = 283
        Height = 222
        DataSource = dsTerm
        FixedColor = 14607076
        Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = grdTermKeyDown
        Flat = True
        Groupings = <>
        GridStyle.Style = gsCustom
        GridStyle.OddColor = clWindow
        GridStyle.EvenColor = clWindow
        FooterColor = clBtnFace
        ExOptions = [eoAutoWidth, eoKeepSelection]
        RegistryKey = 'Software\Scalabium'
        RegistrySection = 'SMDBGrid'
        WidthOfIndicator = 11
        DefaultRowHeight = 20
        ScrollBars = ssVertical
        ColCount = 2
        RowCount = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'DueDateShift'
            Width = 118
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Discount'
            Width = 143
            Visible = True
            FooterType = ftCustom
          end>
      end
      object DBEdit5: TDBEdit
        Left = 120
        Top = 26
        Width = 93
        Height = 24
        DataField = 'Limite'
        DataSource = dsForm
        TabOrder = 0
      end
    end
    object tsCredit: TTabSheet
      Caption = 'Store Credit'
      ImageIndex = 6
      object btAddCredit: TSpeedButton
        Left = 507
        Top = 4
        Width = 80
        Height = 24
        Caption = 'A&dd'
        Flat = True
        Glyph.Data = {
          B6020000424DB60200000000000036000000280000000D000000100000000100
          18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
          D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
          DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
          D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
          FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
          7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
          FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
          E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
          EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
          FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
          8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
          FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
          F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
          FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
          7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
          F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
          E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
          9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
        Margin = 5
        OnClick = btAddCreditClick
      end
      object btDelCredit: TSpeedButton
        Left = 507
        Top = 28
        Width = 80
        Height = 24
        Caption = '&Remove'
        Flat = True
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        Margin = 5
        OnClick = btDelCreditClick
      end
      object pnlPODetail: TPanel
        Left = 305
        Top = 300
        Width = 199
        Height = 57
        BevelOuter = bvNone
        Color = clBtnShadow
        TabOrder = 0
        object Label39: TLabel
          Left = 24
          Top = 39
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Available :'
          Color = clGray
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Label25: TLabel
          Left = 0
          Top = 0
          Width = 199
          Height = 17
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Totals'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label43: TLabel
          Left = 51
          Top = 21
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Used :'
          Color = clGray
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object edtNotUsed: TEdit
          Left = 87
          Top = 38
          Width = 111
          Height = 16
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object edtUsed: TEdit
          Left = 87
          Top = 21
          Width = 111
          Height = 16
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
      end
      object grdStoreCredit: TcxGrid
        Left = 0
        Top = 4
        Width = 505
        Height = 293
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdStoreCreditDBTableView: TcxGridDBTableView
          DataController.DataSource = dsCustomerCredits
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDCustomerCredit'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object grdStoreCreditDBTableViewIDCustomerCredit: TcxGridDBColumn
            DataBinding.FieldName = 'IDCustomerCredit'
            Visible = False
          end
          object grdStoreCreditDBTableViewIsUsed: TcxGridDBColumn
            DataBinding.FieldName = 'IsUsed'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayUnchecked = 'False'
            Width = 45
          end
          object grdStoreCreditDBTableViewStore: TcxGridDBColumn
            DataBinding.FieldName = 'Store'
            Width = 142
          end
          object grdStoreCreditDBTableViewSystemUser: TcxGridDBColumn
            DataBinding.FieldName = 'SystemUser'
            Width = 130
          end
          object grdStoreCreditDBTableViewCreditDate: TcxGridDBColumn
            DataBinding.FieldName = 'CreditDate'
            Width = 61
          end
          object grdStoreCreditDBTableViewExpirationDate: TcxGridDBColumn
            DataBinding.FieldName = 'ExpirationDate'
            Width = 59
          end
          object grdStoreCreditDBTableViewAmount: TcxGridDBColumn
            DataBinding.FieldName = 'Amount'
            Width = 66
          end
        end
        object grdStoreCreditLevel: TcxGridLevel
          GridView = grdStoreCreditDBTableView
        end
      end
    end
    object tsStoreAccount: TTabSheet
      Caption = 'Store Acc.'
      ImageIndex = 12
      object lbStoreAccountLimit: TLabel
        Left = 5
        Top = 49
        Width = 120
        Height = 16
        Alignment = taRightJustify
        Caption = 'Store Account Limit :'
      end
      object chkDeliquent: TDBCheckBox
        Left = 128
        Top = 21
        Width = 171
        Height = 13
        Caption = 'Delinquent Customer'
        DataField = 'Nonpayer'
        DataSource = dsForm
        TabOrder = 0
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object DBEdit6: TDBEdit
        Left = 128
        Top = 46
        Width = 121
        Height = 24
        DataField = 'StoreAccountLimit'
        DataSource = dsForm
        TabOrder = 1
        OnChange = DBEdit6Change
      end
    end
    object tsVendorTax: TTabSheet
      Caption = 'Vendor Tax'
      ImageIndex = 7
      object lbVendorTax: TLabel
        Left = 9
        Top = 8
        Width = 85
        Height = 16
        Alignment = taRightJustify
        Caption = 'Tax Category :'
      end
      object btnNewVendorTax: TSpeedButton
        Left = 344
        Top = 30
        Width = 70
        Height = 25
        Caption = 'Add'
        Flat = True
        Glyph.Data = {
          B6020000424DB60200000000000036000000280000000D000000100000000100
          18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
          D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
          DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
          D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
          FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
          7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
          FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
          E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
          EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
          FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
          8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
          FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
          F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
          FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
          FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
          7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
          F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
          E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
          9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
        Margin = 3
        OnClick = btnNewVendorTaxClick
      end
      object btnRemovTax: TSpeedButton
        Tag = 2
        Left = 344
        Top = 55
        Width = 70
        Height = 25
        Caption = 'Remove'
        Enabled = False
        Flat = True
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        Margin = 3
        OnClick = btnRemovTaxClick
      end
      object scVendorAddTax: TSuperComboADO
        Left = 97
        Top = 5
        Width = 243
        Height = 24
        TabOrder = 0
        LookUpSource = DM.dsLookUpTaxCategPur
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object SMDBGrid1: TSMDBGrid
        Left = 5
        Top = 30
        Width = 336
        Height = 220
        BorderStyle = bsNone
        DataSource = dsVendorTax
        FixedColor = 14607076
        Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Flat = True
        Groupings = <>
        GridStyle.Style = gsCustom
        GridStyle.OddColor = clWindow
        GridStyle.EvenColor = 14607076
        FooterColor = clBtnFace
        ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
        RegistryKey = 'Software\Scalabium'
        RegistrySection = 'SMDBGrid'
        WidthOfIndicator = 11
        DefaultRowHeight = 20
        ScrollBars = ssVertical
        ColCount = 3
        RowCount = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'TaxCategory'
            Width = 174
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Tax'
            Width = 89
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Debit'
            Width = 55
            Visible = True
            FooterType = ftCustom
          end>
      end
    end
    object tsModelCod: TTabSheet
      Caption = 'Model Code'
      ImageIndex = 9
      object btnDelVCode: TSpeedButton
        Left = 510
        Top = 10
        Width = 71
        Height = 24
        Caption = '&Remove'
        Flat = True
        Glyph.Data = {
          06030000424D06030000000000003600000028000000100000000F0000000100
          180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
          2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
          EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
          2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
          ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
          00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
          30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
          31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
          00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
          0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
          FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
          0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF}
        OnClick = btnDelVCodeClick
      end
      object grdVendorCode: TSMDBGrid
        Left = 8
        Top = 10
        Width = 493
        Height = 298
        BorderStyle = bsNone
        DataSource = dsVendorCode
        FixedColor = 14607076
        Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Flat = True
        Groupings = <>
        GridStyle.Style = gsCustom
        GridStyle.OddColor = clWindow
        GridStyle.EvenColor = clWindow
        FooterColor = clBtnFace
        ExOptions = [eoAutoWidth, eoDisableDelete, eoDisableInsert, eoKeepSelection]
        RegistryKey = 'Software\Scalabium'
        RegistrySection = 'SMDBGrid'
        WidthOfIndicator = 11
        DefaultRowHeight = 20
        ScrollBars = ssVertical
        ColCount = 3
        RowCount = 2
        Columns = <
          item
            Expanded = False
            FieldName = 'Model'
            Width = 136
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'Description'
            Width = 268
            Visible = True
            FooterType = ftCustom
          end
          item
            Expanded = False
            FieldName = 'VendorCode'
            Width = 70
            Visible = True
            FooterType = ftCustom
          end>
      end
    end
    object tsHistory: TTabSheet
      Caption = 'Customer History'
      ImageIndex = 10
      object pnlHistoryAdd: TPanel
        Left = 593
        Top = 0
        Width = 84
        Height = 247
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btnHistoryAdd: TSpeedButton
          Left = 4
          Top = 4
          Width = 80
          Height = 24
          Caption = 'A&dd'
          Flat = True
          Margin = 5
          OnClick = btnHistoryAddClick
        end
        object btnHistoryDelete: TSpeedButton
          Left = 4
          Top = 52
          Width = 80
          Height = 24
          Caption = '&Remove'
          Flat = True
          Margin = 5
          OnClick = btnHistoryDeleteClick
        end
        object btnHistoryEdit: TSpeedButton
          Left = 4
          Top = 28
          Width = 80
          Height = 24
          Caption = '&Detail'
          Flat = True
          Margin = 5
          OnClick = btnHistoryEditClick
        end
      end
      object grdHistory: TcxGrid
        Left = 0
        Top = 0
        Width = 593
        Height = 247
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdHistoryDB: TcxGridDBTableView
          DataController.DataSource = dsPessoaHistory
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPessoaHistory'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.Column = grdHistoryDBObs
          Preview.MaxLineCount = 2
          Preview.Visible = True
          object grdHistoryDBSystemUser: TcxGridDBColumn
            Caption = 'User'
            DataBinding.FieldName = 'SystemUser'
            Width = 79
          end
          object grdHistoryDBPessoaHistoryType: TcxGridDBColumn
            Caption = 'Type'
            DataBinding.FieldName = 'PessoaHistoryType'
            Width = 82
          end
          object grdHistoryDBPessoaHistoryResult: TcxGridDBColumn
            Caption = 'Result'
            DataBinding.FieldName = 'PessoaHistoryResult'
            Width = 102
          end
          object grdHistoryDBMovDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'MovDate'
            Width = 96
          end
          object grdHistoryDBObs: TcxGridDBColumn
            DataBinding.FieldName = 'Obs'
            Width = 143
          end
        end
        object grdHistoryLevel: TcxGridLevel
          GridView = grdHistoryDB
        end
      end
    end
    object tsAddress: TTabSheet
      Caption = 'Customer Address'
      ImageIndex = 11
      object Panel5: TPanel
        Left = 593
        Top = 0
        Width = 84
        Height = 247
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btAddAddress: TSpeedButton
          Left = 4
          Top = 4
          Width = 80
          Height = 24
          Caption = ' A&dd'
          Flat = True
          Glyph.Data = {
            B6020000424DB60200000000000036000000280000000D000000100000000100
            18000000000080020000D40E0000D40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF00B28780D6ACA4D6ACA4D6ACA4D6ACA4D6ACA4D6AAA2D6A7A0D6A89DD6AA97
            D6AA97D6AA97A0726A00BD988FFCE7D8FFE7D4FFE6D2FFE4CEFFE4CEFFE0C7FF
            DCBEFFDCBDFFD9B4FFD6AEFFD4B1AB7D7300C79F91FBF0E4FFEEDDFFEBD6FFE9
            D2FFE7CEFFE7CEFFE2C5FFDFBDFFDFBDFFD9B2FFD5B0AB7D7300C7A093FBF2E9
            FFF3E7FFEEDCFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4FFDFBDFFDEBCFFD6BBAB7C
            7600CCA89EFCF4ECFFF6EDFFF3E7FFEEDDFFEBD6FFE9D2FFE7CEFFE6CDFFE2C4
            FFDFBDFFD7C0B6847D00CFA9A1FFF7F1FFF8EFFFF6EDFFF3E8FFEEDCFFEBD6FF
            E9D2FFE7CEFFE7CEFFE2C4FFD7C0B7857E00D8B1A3FFF8F6FFFAF0FFF8EFFFF6
            EDFFF2E6FFEDDCFFEAD5FFE8D1FFE7CEFFE6CDFFDDCAB7868000DBB4A6FFFDFF
            FFFCF9FFFBF0FFF9EFFFF6EDFFF3E8FFEEDDFFEBD6FFE9D2FFE7CEFFDFCEBD93
            8C00E1BBA6FFFDFFFFFEFEFFFCF8FFFBF0FFF8EFFFF6EDFFF3E7FFEDDCFFEBD6
            FFE9D2FFDDCCBD918A00E7C0A6FFFDFFFFFFFFFFFDFCFFFBF6FFFAF4FFF8EFFF
            F6EDFFF2E6FFECDAFED8CCFCC6BEBD8C8500E9C3A8FFFFFFFFFFFFFFFFFFFFFD
            FBFFFBF6FFFBF0FFF8EFF6E7DEE4BFB3DFA49DE09492C2877B00EDC7ABFFFFFF
            FFFFFFFFFFFFFFFFFFFFFDFCFFFBF8FFFAF0E6D1C5C8947CE19D56D58D48CA97
            7F00F2CFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFDFBFFFBF6E6D2C6D7AD90
            F4BD7EDE9A8DFF00FF00F3CEAEFFF9F4FBF6F0F9F5F0F7F4F0F7EEECF3EDECF0
            E9E6DCC6BED3A588E7A496FF00FFFF00FF00ECBD97E7BD9FE5BC9CE3BB9CE2BA
            9CE2B79AE0B69ADEB598D0A48BCE9A7DFF00FFFF00FFFF00FF00}
          Margin = 5
          OnClick = btAddAddressClick
        end
        object btRemoveAddress: TSpeedButton
          Left = 4
          Top = 52
          Width = 80
          Height = 24
          Caption = '&Remove'
          Flat = True
          Glyph.Data = {
            06030000424D06030000000000003600000028000000100000000F0000000100
            180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
            2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
            EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
            2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
            ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
            00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
            30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
            31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
            00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
            0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
            FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
            0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF}
          Margin = 5
          OnClick = btRemoveAddressClick
        end
        object btDetailAddress: TSpeedButton
          Left = 4
          Top = 28
          Width = 80
          Height = 24
          Caption = '&Detail'
          Flat = True
          Glyph.Data = {
            46050000424D4605000000000000360000002800000012000000120000000100
            2000000000001005000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF0023A8D6008FD8F40047BFE9002DB1E0007AAE
            EE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0015A3D4008BD5F40094E3
            FF0078DAFF0065D2F90054C9F10047C1EA0053C9EE00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000BA0
            D30077CEF000A3EAFF0081E7FF0081E7FF0081E7FF0081E7FF007CE6FD0072DD
            F70066D8F40055CEEF0055CEEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF0027ADDE005FC5F4009DE4F400A6FFFF0099FDFF0095F9FF0095F9
            FF0099FDFF0092F8FF0097FBFF0085EAFF0087E7FF0055CEEF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF002AAFDE0055C4F10086D5ED00B9FCFD00A3FD
            FF00A3FDFF00A3FDFF00A3FDFF00A3FDFF00A3FDFF0090F2FF0097E4FF009FEC
            F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002BB0DE006DD5FA005AC8
            ED0075D2EE0093DEF100B7EBFB00CDF9FF00C1FDFF00BCFDFF00BCFDFF00A3EF
            FF009AE3FF00CFF5FC0077A4EA00FF00FF00FF00FF00FF00FF00FF00FF0038B8
            E30082E8FF0075DEFC0077E0FA0050BFE7004ABEEA0059C0E600D1EFF400D3FF
            FF00D3FFFF00B2EEFF009CE0F40044A1540077C0BA00FF00FF00FF00FF00FF00
            FF00FF00FF003DBCE4008EF5FF008EF5FF008EF5FF008EF5FF008EF5FF0082F1
            FF003EC1E40052C1E50050C4EA0044B8D6002C9B5E003CC667002A9F4D00FF00
            FF00FF00FF00FF00FF00FF00FF0043C0E7009FFEFF009CFFFF009CFFFF00A0FF
            FF00AEFFFF00ABFFFF00A4FDFF0096FCFF0071E0E2002C9F6B002DBB57005AE3
            840049D06C002A9F4D00FF00FF00FF00FF00FF00FF0050C4EB00BCFDFF00A5FC
            FF009DFEFF00B7F9FC0091DEF10074D7F1006BD5F1006BD7E70067BE85002BA9
            430051DA79005AE384005AE384004AC76900FF00FF00FF00FF00FF00FF0042BB
            E8008ED7F2009EE3F500B0ECF80092D7F5004DA8EA00FF00FF00FF00FF00FF00
            FF0078B178004C9D4F0033BD56005AE3840042C6640049AC560073AB6E00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00439059003CC96C005BA17700FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF006775670029B551003797
            5400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF0088608D007E547A005D4A63004C725500209D
            2D0023973800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A4A2A8005A9D
            550066A56200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00}
          Margin = 5
          OnClick = btDetailAddressClick
        end
      end
      object grdAddress: TcxGrid
        Left = 0
        Top = 0
        Width = 593
        Height = 247
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object cxGridDBTableView1: TcxGridDBTableView
          DataController.DataSource = dsAddress
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPessoaAddress'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          Preview.Visible = True
          object cxGridDBTableViewAddress: TcxGridDBColumn
            DataBinding.FieldName = 'Address'
            Width = 164
          end
          object cxGridDBTableViewNeighborhood: TcxGridDBColumn
            DataBinding.FieldName = 'Neighborhood'
            Visible = False
          end
          object cxGridDBTableViewCity: TcxGridDBColumn
            DataBinding.FieldName = 'City'
            Width = 78
          end
          object cxGridDBTableViewState: TcxGridDBColumn
            Caption = 'State'
            DataBinding.FieldName = 'Estado'
            Width = 82
          end
          object cxGridDBTableViewZIP: TcxGridDBColumn
            DataBinding.FieldName = 'ZIP'
            Width = 43
          end
          object cxGridDBTableViewCountry: TcxGridDBColumn
            Caption = 'Country'
            DataBinding.FieldName = 'Pais'
            Width = 53
          end
          object cxGridDBTableViewName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Width = 82
          end
          object cxGridDBTableViewCompanyReg: TcxGridDBColumn
            DataBinding.FieldName = 'CompanyReg'
            Visible = False
          end
          object cxGridDBTableViewIDPessoaAddress: TcxGridDBColumn
            DataBinding.FieldName = 'IDPessoaAddress'
            Visible = False
          end
          object cxGridDBTableViewIDPessoa: TcxGridDBColumn
            DataBinding.FieldName = 'IDPessoa'
            Visible = False
          end
          object cxGridDBTableViewIDTaxCategory: TcxGridDBColumn
            DataBinding.FieldName = 'IDTaxCategory'
            Visible = False
          end
          object cxGridDBTableViewIDPais: TcxGridDBColumn
            DataBinding.FieldName = 'IDPais'
            Visible = False
          end
          object cxGridDBTableViewIDEstado: TcxGridDBColumn
            DataBinding.FieldName = 'IDEstado'
            Visible = False
          end
          object cxGridDBTableViewSystem: TcxGridDBColumn
            DataBinding.FieldName = 'System'
            Visible = False
          end
          object cxGridDBTableViewHidden: TcxGridDBColumn
            DataBinding.FieldName = 'Hidden'
            Visible = False
          end
          object cxGridDBTableViewDesativado: TcxGridDBColumn
            DataBinding.FieldName = 'Desativado'
            Visible = False
          end
          object cxGridDBTableViewIsBillTo: TcxGridDBColumn
            DataBinding.FieldName = 'IsBillTo'
            Visible = False
            Width = 50
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 157
    Height = 278
    TabOrder = 5
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 688
    Top = 157
    Height = 278
    TabOrder = 6
    Visible = False
  end
  object pnCommission: TPanel [7]
    Left = 0
    Top = 114
    Width = 691
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 7
    Visible = False
    object Label12: TLabel
      Left = 24
      Top = 5
      Width = 121
      Height = 16
      Caption = 'Agency commission :'
    end
    object edtCoord: TDBEdit
      Left = 125
      Top = 2
      Width = 60
      Height = 24
      DataField = 'ComissaoSobreGuia'
      DataSource = dsForm
      TabOrder = 0
    end
  end
  object pnGuia: TPanel [8]
    Left = 0
    Top = 138
    Width = 691
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 8
    Visible = False
    object DBCheckBox2: TDBCheckBox
      Left = 15
      Top = 3
      Width = 221
      Height = 13
      Caption = 'Deduct Agency commision  from Agenty.'
      DataField = 'DescontaCoordenacao'
      DataSource = dsForm
      TabOrder = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  object pnlInfo: TPanel [9]
    Left = 0
    Top = 40
    Width = 691
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 9
    object lblCode: TLabel
      Left = 42
      Top = 4
      Width = 38
      Height = 16
      Alignment = taRightJustify
      Caption = 'Code :'
    end
    object Label27: TLabel
      Left = 228
      Top = 2
      Width = 40
      Height = 16
      Alignment = taRightJustify
      Caption = 'Store :'
    end
    object Label41: TLabel
      Left = 491
      Top = 4
      Width = 31
      Height = 16
      Alignment = taRightJustify
      Caption = 'User:'
    end
    object DBEdit2: TDBEdit
      Left = 85
      Top = 1
      Width = 66
      Height = 24
      TabStop = False
      DataField = 'UserCode'
      DataSource = dsForm
      TabOrder = 0
    end
    object scStore: TDBSuperComboADO
      Tag = 1
      Left = 270
      Top = -1
      Width = 213
      Height = 24
      TabStop = False
      TabOrder = 1
      Text = 'scStore'
      CodeLength = 5
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 10
      ShowBtnAddNew = False
      IDLanguage = 0
      DataField = 'IDStore'
      DataSource = dsForm
    end
    object scUser: TDBSuperComboADO
      Left = 525
      Top = 1
      Width = 156
      Height = 24
      TabStop = False
      TabOrder = 2
      Text = 'scUser'
      LookUpSource = DM.dsLookUpUser
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
      DataField = 'IDUser'
      DataSource = dsForm
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FchPessoa.sil'
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A73744D756C74694C696E65730D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E670101010D
      0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01496E66
      6F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D
      0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101
      010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641626F72
      740101010D0A5265747279012652657472790101010D0A49676E6F7265012649
      676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C
      014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965732074
      6F2026416C6C0101010D0A48656C70012648656C700101010D0A737453747269
      6E67730D0A73744F74686572537472696E67730D0A7175466F726D2E436F6D6D
      616E6454657874010101010D0A7175466F726D2E436F6E6E656374696F6E5374
      72696E67010101010D0A7175466F726D2E46696C746572010101010D0A717546
      6F726D2E496E6465784669656C644E616D6573010101010D0A7175466F726D2E
      4B65794669656C6473010101010D0A466F726D436F6E6669672E456E74696461
      64654E6F6D65010101010D0A73744C6F63616C65730D0A43757272656E637920
      537472696E6701240101010D0A54686F7573616E6420536570617261746F7201
      2C0101010D0A446563696D616C20536570617261746F72012E0101010D0A4461
      746520536570617261746F72012F0101010D0A53686F7274204461746520466F
      726D6174014D2F642F797979790101010D0A4C6F6E67204461746520466F726D
      617401646464642C204D4D4D4D2064642C20797979790101010D0A54696D6520
      536570617261746F72013A0101010D0A54696D6520414D20537472696E670141
      4D0101010D0A54696D6520504D20537472696E6701504D0101010D0A53686F72
      742054696D6520466F726D617401683A6D6D20414D504D0101010D0A4C6F6E67
      2054696D6520466F726D617401683A6D6D3A737320414D504D0101010D0A5368
      6F7274204D6F6E7468204E616D6573014A616E2C4665622C4D61722C4170722C
      4D61792C4A756E2C4A756C2C4175672C5365702C4F63742C4E6F762C44656301
      01010D0A4C6F6E67204D6F6E7468204E616D6573014A616E756172792C466562
      72756172792C4D617263682C417072696C2C4D61792C4A756E652C4A756C792C
      4175677573742C53657074656D6265722C4F63746F6265722C4E6F76656D6265
      722C446563656D6265720101010D0A53686F727420446179204E616D65730153
      756E2C4D6F6E2C5475652C5765642C5468752C4672692C5361740101010D0A4C
      6F6E6720446179204E616D65730153756E6461792C4D6F6E6461792C54756573
      6461792C5765646E65736461792C54687572736461792C4672696461792C5361
      7475726461790101010D0A7374436F6C6C656374696F6E730D0A737443686172
      536574730D0A}
  end
  inherited dsForm: TDataSource
    Left = 50
    Top = 273
  end
  object dsPurchaseHistory: TDataSource [12]
    DataSet = dstPurchaseHistory
    Left = 51
    Top = 388
  end
  inherited quForm: TPowerADOQuery
    CursorType = ctStatic
    BeforeClose = quFormBeforeClose
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT '#13#10#9'P.IDPessoa, '#13#10#9'P.Pessoa, '#13#10#9'P.IDTipoPessoa, '#13#10#9'P.IDSto' +
      're, '#13#10#9'P.NomeJuridico, '#13#10#9'P.Endereco,'#13#10#9'P.Cidade, '#13#10#9'P.CEP, '#13#10#9'P' +
      '.Pais, '#13#10#9'P.Telefone, '#13#10#9'P.Cellular, '#13#10#9'P.PhoneAreaCode, '#13#10#9'P.Ce' +
      'llAreaCode, '#13#10#9'P.Fax, '#13#10#9'P.Beeper, '#13#10#9'P.Contato, '#13#10#9'P.Email, '#13#10#9 +
      'P.OBS, '#13#10#9'P.Juridico, '#13#10#9'P.TotalMovimentado, '#13#10#9'P.Limite, '#13#10#9'P.N' +
      'ascimento, '#13#10#9'P.IDEstado, '#13#10#9'P.DiaQuitacao, '#13#10#9'P.IDPessoaBoss, '#13 +
      #10#9'P.IDTipoPessoaFilho, '#13#10#9'P.IDRamoAtividade, '#13#10#9'P.CPF,'#13#10#9'P.CGC, ' +
      #13#10#9'P.Identidade, '#13#10#9'P.CartTrabalho, '#13#10#9'P.InscEstadual, '#13#10#9'P.Insc' +
      'Municipal, '#13#10#9'P.Contatos, '#13#10#9'P.NumAtrasos, '#13#10#9'P.DiasAtraso,'#13#10#9'P.' +
      'NumTransacoes, '#13#10#9'P.HomePage, '#13#10#9'P.OrgaoEmissor, '#13#10#9'P.Bairro, '#13#10 +
      #9'P.NumMovimentacoes, '#13#10#9'P.System, '#13#10#9'P.Desativado, '#13#10#9'P.Hidden, ' +
      #13#10#9'P.ComissaoSobreGuia, '#13#10#9'P.DescontaCoordenacao, '#13#10#9'P.AjusteCom' +
      'iss, '#13#10#9'P.IDUser, '#13#10#9'P.ShortName, '#13#10#9'P.Short_Name, '#13#10#9'P.Code, '#13#10 +
      #9'P.IDTipoPessoaRoot, '#13#10#9'P.IDPais, '#13#10#9'P.PessoaLastName, '#13#10#9'P.Cust' +
      'omerCard, '#13#10#9'P.PessoaFirstName,'#13#10#9'P.UserCode,'#13#10#9'P.CartMotorista,' +
      #13#10#9'P.DataExpedicao,'#13#10#9'P.CreationDate,'#13#10#9'P.SalesTaxExempt,'#13#10#9'P.Se' +
      'xo,'#13#10#9'P.Complemento,'#13#10#9'P.ComplementoNum,'#13#10#9'P.IDMunicipio,'#13#10#9'P.St' +
      'oreAccountLimit,'#13#10#9'P.Nonpayer'#13#10'FROM '#13#10#9'Pessoa P'#13#10#13#10'Where IDPesso' +
      'a = :IDPessoa'#13#10' '#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 51
    Top = 322
    object quFormIDPessoa: TIntegerField
      DisplayLabel = 'IDpessoa'
      FieldName = 'IDPessoa'
    end
    object quFormPessoa: TStringField
      DisplayLabel = 'Company'
      FieldName = 'Pessoa'
      Origin = 'RETAIL.Pessoa.Pessoa'
      Size = 50
    end
    object quFormPessoaFirstName: TStringField
      DisplayLabel = 'First Name'
      FieldName = 'PessoaFirstName'
      Origin = 'RETAIL.Pessoa.PessoaFirstName'
      Size = 30
    end
    object quFormPessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 50
    end
    object quFormIDTipoPessoa: TIntegerField
      FieldName = 'IDTipoPessoa'
      Origin = 'RETAIL.Pessoa.IDTipoPessoa'
    end
    object quFormIDStore: TIntegerField
      FieldName = 'IDStore'
      Origin = 'RETAIL.Pessoa.IDStore'
    end
    object quFormEndereco: TStringField
      DisplayLabel = 'Address'
      FieldName = 'Endereco'
      Origin = 'RETAIL.Pessoa.Endereco'
      Size = 80
    end
    object quFormCidade: TStringField
      DisplayLabel = 'City'
      FieldName = 'Cidade'
      Origin = 'RETAIL.Pessoa.Cidade'
      Size = 40
    end
    object quFormIDEstado: TStringField
      DisplayLabel = 'IDState'
      FieldName = 'IDEstado'
      Origin = 'RETAIL.Pessoa.IDEstado'
      FixedChar = True
      Size = 3
    end
    object quFormIDPais: TIntegerField
      DisplayLabel = 'IDCountry'
      FieldName = 'IDPais'
      Origin = 'RETAIL.Pessoa.IDPais'
    end
    object quFormCEP: TStringField
      DisplayLabel = 'ZIP'
      FieldName = 'CEP'
      Origin = 'RETAIL.Pessoa.CEP'
      FixedChar = True
      Size = 12
    end
    object quFormTelefone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'Telefone'
      Origin = 'RETAIL.Pessoa.Telefone'
      Size = 40
    end
    object quFormNomeJuridico: TStringField
      FieldName = 'NomeJuridico'
      Origin = 'RETAIL.Pessoa.NomeJuridico'
      Size = 50
    end
    object quFormPais: TStringField
      FieldName = 'Pais'
      Origin = 'RETAIL.Pessoa.Pais'
      Size = 21
    end
    object quFormCellular: TStringField
      FieldName = 'Cellular'
      Origin = 'RETAIL.Pessoa.Cellular'
      FixedChar = True
      Size = 18
    end
    object quFormFax: TStringField
      FieldName = 'Fax'
      Origin = 'RETAIL.Pessoa.Fax'
      Size = 40
    end
    object quFormBeeper: TStringField
      FieldName = 'Beeper'
      Origin = 'RETAIL.Pessoa.Beeper'
      FixedChar = True
      Size = 25
    end
    object quFormContato: TStringField
      FieldName = 'Contato'
      Origin = 'RETAIL.Pessoa.Contato'
      Size = 50
    end
    object quFormEmail: TStringField
      FieldName = 'Email'
      Origin = 'RETAIL.Pessoa.Email'
      Size = 50
    end
    object quFormOBS: TStringField
      FieldName = 'OBS'
      Origin = 'RETAIL.Pessoa.OBS'
      Size = 100
    end
    object quFormJuridico: TBooleanField
      FieldName = 'Juridico'
      Origin = 'RETAIL.Pessoa.Juridico'
    end
    object quFormTotalMovimentado: TFloatField
      FieldName = 'TotalMovimentado'
      Origin = 'RETAIL.Pessoa.TotalMovimentado'
    end
    object quFormLimite: TFloatField
      FieldName = 'Limite'
      Origin = 'RETAIL.Pessoa.Limite'
      DisplayFormat = '#,##0.00'
    end
    object quFormNascimento: TDateTimeField
      FieldName = 'Nascimento'
      Origin = 'RETAIL.Pessoa.Nascimento'
    end
    object quFormDiaQuitacao: TIntegerField
      FieldName = 'DiaQuitacao'
      Origin = 'RETAIL.Pessoa.DiaQuitacao'
    end
    object quFormIDPessoaBoss: TIntegerField
      FieldName = 'IDPessoaBoss'
      Origin = 'RETAIL.Pessoa.IDPessoaBoss'
    end
    object quFormIDTipoPessoaFilho: TIntegerField
      FieldName = 'IDTipoPessoaFilho'
      Origin = 'RETAIL.Pessoa.IDTipoPessoaFilho'
    end
    object quFormIDRamoAtividade: TIntegerField
      FieldName = 'IDRamoAtividade'
      Origin = 'RETAIL.Pessoa.IDRamoAtividade'
    end
    object quFormCPF: TStringField
      FieldName = 'CPF'
      Size = 30
    end
    object quFormCGC: TStringField
      FieldName = 'CGC'
      Origin = 'RETAIL.Pessoa.CGC'
      Size = 30
    end
    object quFormIdentidade: TStringField
      FieldName = 'Identidade'
      Origin = 'RETAIL.Pessoa.Identidade'
      Size = 30
    end
    object quFormCartTrabalho: TStringField
      FieldName = 'CartTrabalho'
      Origin = 'RETAIL.Pessoa.CartTrabalho'
      Size = 30
    end
    object quFormInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Origin = 'RETAIL.Pessoa.InscEstadual'
      Size = 30
    end
    object quFormInscMunicipal: TStringField
      FieldName = 'InscMunicipal'
      Origin = 'RETAIL.Pessoa.InscMunicipal'
      Size = 30
    end
    object quFormContatos: TStringField
      FieldName = 'Contatos'
      Origin = 'RETAIL.Pessoa.Contatos'
      Size = 255
    end
    object quFormNumAtrasos: TIntegerField
      FieldName = 'NumAtrasos'
      Origin = 'RETAIL.Pessoa.NumAtrasos'
    end
    object quFormDiasAtraso: TIntegerField
      FieldName = 'DiasAtraso'
      Origin = 'RETAIL.Pessoa.DiasAtraso'
    end
    object quFormNumTransacoes: TIntegerField
      FieldName = 'NumTransacoes'
      Origin = 'RETAIL.Pessoa.NumTransacoes'
    end
    object quFormHomePage: TStringField
      FieldName = 'HomePage'
      Origin = 'RETAIL.Pessoa.HomePage'
      Size = 200
    end
    object quFormOrgaoEmissor: TStringField
      FieldName = 'OrgaoEmissor'
      Origin = 'RETAIL.Pessoa.OrgaoEmissor'
      Size = 50
    end
    object quFormBairro: TStringField
      FieldName = 'Bairro'
      Origin = 'RETAIL.Pessoa.Bairro'
      Size = 50
    end
    object quFormNumMovimentacoes: TIntegerField
      FieldName = 'NumMovimentacoes'
      Origin = 'RETAIL.Pessoa.NumMovimentacoes'
    end
    object quFormSystem: TBooleanField
      FieldName = 'System'
      Origin = 'RETAIL.Pessoa.System'
    end
    object quFormDesativado: TIntegerField
      FieldName = 'Desativado'
      Origin = 'RETAIL.Pessoa.Desativado'
    end
    object quFormHidden: TIntegerField
      FieldName = 'Hidden'
    end
    object quFormComissaoSobreGuia: TFloatField
      FieldName = 'ComissaoSobreGuia'
      Origin = 'RETAIL.Pessoa.ComissaoSobreGuia'
    end
    object quFormDescontaCoordenacao: TBooleanField
      FieldName = 'DescontaCoordenacao'
      Origin = 'RETAIL.Pessoa.DescontaCoordenacao'
    end
    object quFormAjusteComiss: TFloatField
      FieldName = 'AjusteComiss'
    end
    object quFormIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quFormShortName: TStringField
      FieldName = 'ShortName'
      Size = 15
    end
    object quFormCode: TIntegerField
      FieldName = 'Code'
    end
    object quFormIDTipoPessoaRoot: TIntegerField
      FieldName = 'IDTipoPessoaRoot'
      Origin = 'RETAIL.Pessoa.IDTipoPessoaRoot'
    end
    object quFormCustomerCard: TStringField
      FieldName = 'CustomerCard'
      Origin = 'RETAIL.Pessoa.CustomerCard'
    end
    object quFormShort_Name: TStringField
      FieldName = 'Short_Name'
      Size = 30
    end
    object quFormPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object quFormCellAreaCode: TStringField
      FieldName = 'CellAreaCode'
      Size = 5
    end
    object quFormCartMotorista: TStringField
      FieldName = 'CartMotorista'
      Size = 15
    end
    object quFormDataExpedicao: TDateTimeField
      FieldName = 'DataExpedicao'
    end
    object quFormCreationDate: TDateTimeField
      FieldName = 'CreationDate'
    end
    object quFormSalesTaxExempt: TBooleanField
      FieldName = 'SalesTaxExempt'
    end
    object quFormSexo: TBooleanField
      FieldName = 'Sexo'
    end
    object quFormComplemento: TStringField
      FieldName = 'Complemento'
    end
    object quFormComplementoNum: TIntegerField
      FieldName = 'ComplementoNum'
    end
    object quFormIDMunicipio: TIntegerField
      FieldName = 'IDMunicipio'
    end
    object quFormStoreAccountLimit: TBCDField
      FieldName = 'StoreAccountLimit'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quFormNonpayer: TBooleanField
      FieldName = 'Nonpayer'
    end
    object quFormUserCode: TStringField
      FieldName = 'UserCode'
      Size = 6
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    ConfirmCancel = False
    AutoIncField = 'IDpessoa'
    RequiredFields.Strings = (
      'IDTipoPessoa')
    DependentTables.Strings = (
      'PessoaTerm')
    DependentTableKeys.Strings = (
      'IDPessoa')
    Left = 517
    Top = 124
  end
  object quGroupHistory: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'DataIni'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDAgency'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDGuide'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'TG.IDTouristGroup,'
      #9'TG.EnterDate,'
      #9'TG.NumTourist,'
      #9'A.Pessoa as Agency,'
      #9'G.Pessoa as Guide,'
      #9'count(I.IDInvoice) as QTYInvoice,'
      #9'I.IDPreSale,'
      
        #9'Sum(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax) as' +
        ' TotalInvoice'
      'FROM'
      #9'TouristGroup TG (NOLOCK)'
      #9'Join Pessoa A (NOLOCK) on (TG.IDAgency = A.IDPessoa)'
      #9'Join Pessoa G (NOLOCK) on (TG.IDGuide = G.IDPessoa)'
      
        #9'Join Invoice I (NOLOCK) on (TG.IDTouristGroup = I.IDTouristGrou' +
        'p)'
      'WHERE'
      #9'TG.EnterDate >= :DataIni'
      #9'AND TG.EnterDate < :DataFim'
      #9'AND TG.IDAgency = IsNull(:IDAgency, TG.IDAgency)'
      #9'AND TG.IDGuide = IsNull(:IDGuide, TG.IDGuide)'
      #9'AND I.IDInvoice IS NOT NULL'
      'GROUP BY'
      #9'TG.IDTouristGroup,'
      #9'TG.EnterDate,'
      #9'TG.NumTourist,'
      #9'A.Pessoa,'
      #9'G.Pessoa,'
      #9'I.IDPreSale')
    Left = 378
    Top = 389
    object quGroupHistoryEnterDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'EnterDate'
      DisplayFormat = 'ddddd'
    end
    object quGroupHistoryGuide: TStringField
      DisplayLabel = 'Agent'
      FieldName = 'Guide'
      Size = 50
    end
    object quGroupHistoryNumTourist: TIntegerField
      DisplayLabel = 'Qty Persons'
      FieldName = 'NumTourist'
    end
    object quGroupHistoryAgency: TStringField
      FieldName = 'Agency'
      Size = 50
    end
    object quGroupHistoryQTYInvoice: TIntegerField
      DisplayLabel = 'Qty Invoices'
      FieldName = 'QTYInvoice'
    end
    object quGroupHistoryTotalInvoice: TFloatField
      DisplayLabel = 'Invoice Total'
      FieldName = 'TotalInvoice'
      DisplayFormat = '#,##0.00'
    end
    object quGroupHistoryIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
    end
    object quGroupHistoryIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
  end
  object dsGroupHistory: TDataSource
    DataSet = quGroupHistory
    Left = 393
    Top = 399
  end
  object dsAccount: TDataSource
    DataSet = quAccount
    Left = 362
    Top = 352
  end
  object dsInvoiceHistory: TDataSource
    DataSet = dstInvoiceHistory
    Left = 136
    Top = 389
  end
  object dsTerm: TDataSource
    DataSet = quTerm
    OnStateChange = dsTermStateChange
    Left = 274
    Top = 393
  end
  object quTerm: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterEdit = quTermAfterEdit
    OnNewRecord = quTermNewRecord
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '      IDPessoa,'
      '      DueDateShift,'
      '      Discount'
      'FROM'
      '      PessoaTerm PT (NOLOCK)'
      'WHERE'
      '      PT.IDPessoa =  :IDPessoa'
      '')
    Left = 274
    Top = 438
    object quTermIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quTermDueDateShift: TIntegerField
      DisplayLabel = 'Days'
      FieldName = 'DueDateShift'
    end
    object quTermDiscount: TBCDField
      DisplayLabel = 'Discount % '
      FieldName = 'Discount'
      Precision = 19
    end
  end
  object dstPurchaseHistory: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10'      PI.IDPurchase ,'#13#10'      M.Model ,'#13#10'      TG.Name as' +
      ' Category,'#13#10'      PI.MovDate ,'#13#10'      PI.Qty ,'#13#10'      PI.CostPri' +
      'ce ,'#13#10'      PI.Freight,'#13#10'      PI.OtherCost,'#13#10'      (PI.Qty * PI' +
      '.CostPrice) + PI.Freight + PI.OtherCost as Total'#13#10#13#10'FROM'#13#10'      ' +
      '  vwPurchaseItem PI (NOLOCK)'#13#10'        JOIN Model M (NOLOCK) ON (' +
      'PI.ModelID = M.IDModel)'#13#10'        JOIN TabGroup TG (NOLOCK) ON (M' +
      '.GroupID = TG.IDGroup)'#13#10'WHERE'#13#10'        PI.IDFornecedor = :IDTipo' +
      'Pessoa'#13#10'        AND'#13#10'        PI.MovDate >= :DataInicio'#13#10'        ' +
      'AND'#13#10'        PI.MovDate < :DataFim'#13#10#13#10'ORDER BY'#13#10'        PI.MovDa' +
      'te Desc'#13#10#13#10' '#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicio'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 47
    Top = 439
    object dstPurchaseHistoryIDPurchase: TIntegerField
      FieldName = 'IDPurchase'
    end
    object dstPurchaseHistoryModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object dstPurchaseHistoryCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object dstPurchaseHistoryMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object dstPurchaseHistoryCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dstPurchaseHistoryFreight: TBCDField
      FieldName = 'Freight'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dstPurchaseHistoryOtherCost: TBCDField
      FieldName = 'OtherCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dstPurchaseHistoryTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dstPurchaseHistoryQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object dstInvoiceHistory: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'I.SaleCode as Hold,'#13#10#9'I.InvoiceCode as IDInvoice,'#13#10#9'I.I' +
      'nvoiceDate,'#13#10#9'S.Name as Store,'#13#10#9'(I.SubTotal - I.InvoiceDiscount' +
      ' - I.ItemDiscount + I.Tax) as Value'#13#10'FROM'#13#10#9'Invoice I (NOLOCK)'#13#10 +
      #9'JOIN Store S (NOLOCK) ON (I.IDStore = S.IDStore)'#13#10'WHERE'#13#10#9'I.Inv' +
      'oiceDate >= :DataIni'#13#10#9'AND I.InvoiceDate < :DataFim'#13#10#9'AND I.IDCu' +
      'stomer = :IDPessoa'#13#10#9'AND I.IDInvoice IS NOT NULL'#13#10'ORDER BY'#13#10#9'I.I' +
      'nvoiceDate DESC'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'DataIni'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 136
    Top = 440
    object dstInvoiceHistoryInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object dstInvoiceHistoryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object dstInvoiceHistoryValue: TBCDField
      DisplayLabel = 'Total'
      FieldName = 'Value'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dstInvoiceHistoryHold: TStringField
      FieldName = 'Hold'
    end
    object dstInvoiceHistoryIDInvoice: TStringField
      FieldName = 'IDInvoice'
    end
  end
  object quCustomerCredits: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'IDCustomer'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'C.IDCustomerCredit,'
      #9'S.Name as Store,'
      #9'SU.SystemUser,'
      #9'C.CreditDate,'
      #9'C.ExpirationDate,'
      #9'C.Amount,'
      #9'C.IsUsed'
      'FROM'
      #9'CustomerCredit C (NOLOCK)'
      #9'LEFT JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = C.IDUSer)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = C.IDStore)'
      'WHERE'
      #9'C.IDPessoa = :IDCustomer')
    Left = 358
    Top = 263
    object quCustomerCreditsIDCustomerCredit: TIntegerField
      FieldName = 'IDCustomerCredit'
    end
    object quCustomerCreditsStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quCustomerCreditsSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quCustomerCreditsCreditDate: TDateTimeField
      FieldName = 'CreditDate'
    end
    object quCustomerCreditsExpirationDate: TDateTimeField
      FieldName = 'ExpirationDate'
    end
    object quCustomerCreditsAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quCustomerCreditsIsUsed: TBooleanField
      DisplayLabel = 'Used'
      FieldName = 'IsUsed'
    end
  end
  object dsCustomerCredits: TDataSource
    DataSet = quCustomerCredits
    Left = 392
    Top = 187
  end
  object quGetTotalCredit: TADOQuery
    Connection = DM.ADODBConnect
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  SUM(ISNULL(Amount, 0)) AS TotalCredit'
      'FROM'
      #9'CustomerCredit (NOLOCK)')
    Left = 388
    Top = 453
    object quGetTotalCreditTotalCredit: TBCDField
      FieldName = 'TotalCredit'
      Precision = 19
    end
  end
  object quVendorTax: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDVendor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'VT.IDVendorTax,'
      #9'VT.IDPessoa,'
      #9'VT.IDGroup,'
      #9'VT.IDTaxCategory,'
      #9'TG.TaxCategory,'
      #9'TG.Tax,'
      #9'TG.Debit'
      'FROM'
      #9'VendorTax VT (NOLOCK)'
      
        #9'JOIN TaxCategory TG (NOLOCK) ON (TG.IDTaxCategory = VT.IDTaxCat' +
        'egory)'
      'WHERE'
      #9'IDPessoa = :IDVendor')
    Left = 238
    Top = 334
    object quVendorTaxIDVendorTax: TIntegerField
      FieldName = 'IDVendorTax'
    end
    object quVendorTaxIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quVendorTaxIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quVendorTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quVendorTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quVendorTaxTax: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '0.00%'
      Precision = 19
    end
    object quVendorTaxDebit: TBooleanField
      FieldName = 'Debit'
    end
  end
  object dsVendorTax: TDataSource
    DataSet = quVendorTax
    OnStateChange = dsVendorTaxStateChange
    Left = 237
    Top = 288
  end
  object quPet: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPet,'
      #9'P.Name,'
      #9'P.Sex,'
      #9'PP.Porte,'
      #9'PB.Breed,'
      #9'PS.Species,'
      #9'P.WhelpDate'
      'FROM'
      #9'Pet_PessoaToPet PTP (NOLOCK)'
      #9'JOIN Pet P (NOLOCK) ON (P.IDPet = PTP.IDPet)'
      
        #9'LEFT OUTER JOIN Pet_Porte PP (NOLOCK) ON (PP.IDPorte = P.IDPort' +
        'e)'
      
        #9'LEFT OUTER JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBree' +
        'd)'
      
        #9'LEFT OUTER JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.ID' +
        'Species)'
      'WHERE'
      #9'PTP.IDPessoa = :IDPessoa')
    Left = 603
    Top = 203
    object quPetIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object quPetName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object quPetSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object quPetPorte: TStringField
      DisplayLabel = 'Size'
      FieldName = 'Porte'
      Size = 50
    end
    object quPetSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object quPetBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object quPetWhelpDate: TDateTimeField
      DisplayLabel = 'DOB'
      FieldName = 'WhelpDate'
      DisplayFormat = 'ddddd'
    end
  end
  object dsPet: TDataSource
    DataSet = quPet
    OnStateChange = dsPetStateChange
    Left = 602
    Top = 297
  end
  object spGetPessoaRoot: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Pessoa_GetPessoaRoot;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDTipoPessoa'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPessoa'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Code'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDTipoPessoaRoot'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 337
    Top = 339
  end
  object quVendorCode: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'VM.IDVendorModelCode,'
      #9'VM.IDPessoa,'
      #9'VM.IDModel,'
      #9'VM.VendorCode,'
      #9'M.Model,'
      #9'M.Description'
      'FROM'
      #9'VendorModelCode VM (NOLOCK)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = VM.IDModel)'
      'WHERE'
      #9'VM.IDPessoa = :IDPessoa')
    Left = 501
    Top = 467
    object quVendorCodeIDVendorModelCode: TIntegerField
      FieldName = 'IDVendorModelCode'
      Visible = False
    end
    object quVendorCodeIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
      Visible = False
    end
    object quVendorCodeIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object quVendorCodeModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quVendorCodeDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quVendorCodeVendorCode: TStringField
      DisplayLabel = 'Code'
      FieldName = 'VendorCode'
      Size = 10
    end
  end
  object dsVendorCode: TDataSource
    DataSet = quVendorCode
    OnStateChange = dsVendorCodeStateChange
    Left = 621
    Top = 259
  end
  object quPessoaHistory: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'Select'#13#10#9'PH.IDPessoaHistory,'#13#10#9'PH.IDPessoa,'#13#10#9'PH.IDUser,'#13#10#9'PH.ID' +
      'PessoaHistoryType,'#13#10#9'PH.IDPessoaHistoryResult,'#13#10#9'PH.MovDate,'#13#10#9'P' +
      'H.Obs,'#13#10#9'SU.SystemUser,'#13#10#9'PHT.PessoaHistoryType,'#13#10#9'PHR.PessoaHis' +
      'toryResult'#13#10'From'#13#10#9'Mnt_PessoaHistory PH (NOLOCK)'#13#10#9'JOIN SystemUs' +
      'er SU (NOLOCK) ON (PH.IDUser = SU.IDUser)'#13#10#9'JOIN Mnt_PessoaHisto' +
      'ryType PHT (NOLOCK) ON(PH.IDPessoaHistoryType = PHT.IDPessoaHist' +
      'oryType)'#13#10#9'JOIN Mnt_PessoaHistoryResult PHR (NOLOCK) ON (PH.IDPe' +
      'ssoaHistoryResult = PHR.IDPessoaHistoryResult)'#13#10'Where'#13#10#9'PH.IDPes' +
      'soa = :IDPessoa'#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 22
    Top = 200
    object quPessoaHistoryIDPessoaHistory: TIntegerField
      FieldName = 'IDPessoaHistory'
    end
    object quPessoaHistoryIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quPessoaHistoryIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quPessoaHistoryIDPessoaHistoryType: TIntegerField
      FieldName = 'IDPessoaHistoryType'
    end
    object quPessoaHistoryIDPessoaHistoryResult: TIntegerField
      FieldName = 'IDPessoaHistoryResult'
    end
    object quPessoaHistoryMovDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'MovDate'
    end
    object quPessoaHistoryObs: TStringField
      FieldName = 'Obs'
      Size = 255
    end
    object quPessoaHistorySystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      Size = 50
    end
    object quPessoaHistoryPessoaHistoryType: TStringField
      DisplayLabel = 'Type'
      FieldName = 'PessoaHistoryType'
      Size = 30
    end
    object quPessoaHistoryPessoaHistoryResult: TStringField
      DisplayLabel = 'Result'
      FieldName = 'PessoaHistoryResult'
      Size = 30
    end
  end
  object dsPessoaHistory: TDataSource
    DataSet = quPessoaHistory
    Left = 385
    Top = 298
  end
  object dsAddress: TDataSource
    DataSet = quAddress
    OnDataChange = dsAddressDataChange
    Left = 387
    Top = 217
  end
  object quAddress: TPowerADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PA.IDPessoaAddress,'#13#10#9'PA.IDPessoa,'#13#10#9'PA.Name,'#13#10#9'PA.Addr' +
      'ess,'#13#10#9'PA.Neighborhood,'#13#10#9'PA.City,'#13#10#9'PA.ZIP,'#13#10#9'PA.IDTaxCategory,' +
      #13#10#9'PA.IDPais,'#13#10#9'PA.IDEstado,'#13#10#9'PA.CompanyReg,'#13#10#9'PA.System,'#13#10#9'PA.' +
      'Hidden,'#13#10#9'PA.Desativado,'#13#10#9'PA.IsBillTo,'#13#10#9'P.Pais,'#13#10#9'E.Estado'#13#10'FR' +
      'OM'#13#10#9'Mnt_PessoaAddress PA (NOLOCK)'#13#10#9'LEFT JOIN Pais P (NOLOCK) O' +
      'N (PA.IDPais = P.IDPais)'#13#10#9'LEFT JOIN Estado E (NOLOCK) ON (PA.ID' +
      'Estado = E.IDestado)'#13#10'WHERE'#13#10#9'PA.IDPessoa = :IDPessoa'
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 335
    Top = 217
    object quAddressIDPessoaAddress: TIntegerField
      FieldName = 'IDPessoaAddress'
    end
    object quAddressIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quAddressName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quAddressAddress: TStringField
      FieldName = 'Address'
      Size = 50
    end
    object quAddressNeighborhood: TStringField
      FieldName = 'Neighborhood'
      Size = 30
    end
    object quAddressCity: TStringField
      FieldName = 'City'
    end
    object quAddressZIP: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object quAddressIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quAddressIDPais: TIntegerField
      FieldName = 'IDPais'
    end
    object quAddressIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quAddressCompanyReg: TStringField
      FieldName = 'CompanyReg'
      Size = 30
    end
    object quAddressSystem: TBooleanField
      FieldName = 'System'
    end
    object quAddressHidden: TBooleanField
      FieldName = 'Hidden'
    end
    object quAddressDesativado: TBooleanField
      FieldName = 'Desativado'
    end
    object quAddressIsBillTo: TBooleanField
      FieldName = 'IsBillTo'
    end
    object quAddressPais: TStringField
      FieldName = 'Pais'
      Size = 50
    end
    object quAddressEstado: TStringField
      FieldName = 'Estado'
      Size = 50
    end
  end
  object quAccount: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Inicio'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Fim'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'L.IDLancamento,'
      #9'L.IDPessoa,'
      #9'L.DataVencimento,'
      #9'LT.LancamentoTipo,'
      #9'L.DataFimQuitacao,'
      #9'L.ValorNominal,'
      #9'L.TotalQuitado,'
      #9'L.Pagando,'
      #9'L.Historico'
      'FROM'
      #9'Fin_LancamentoTipo LT (NOLOCK)'
      
        #9'JOIN Fin_Lancamento L (NOLOCK) ON (L.IDLancamentoTipo = LT.IDLa' +
        'ncamentoTipo)'
      'WHERE'
      #9'L.IDPessoa = :IDPessoa'
      #9'AND L.DataLancamento >= :Inicio'
      #9'AND L.DataLancamento < (:Fim + 1)'
      #9'AND L.Desativado = 0')
    Left = 347
    Top = 442
    object quAccountIDLancamento: TIntegerField
      DisplayWidth = 10
      FieldName = 'IDLancamento'
      Origin = 'Fin_Lancamento.IDLancamento'
    end
    object quAccountDataVencimento: TDateTimeField
      DisplayLabel = 'Due Date'
      DisplayWidth = 18
      FieldName = 'DataVencimento'
      Origin = 'Fin_Lancamento.DataVencimento'
      DisplayFormat = 'ddddd'
    end
    object quAccountLancamentoTipo: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 65
      FieldName = 'LancamentoTipo'
      Origin = 'Fin_LancamentoTipo.LancamentoTipo'
      Size = 65
    end
    object quAccountDataFimQuitacao: TDateTimeField
      DisplayLabel = 'Quita'#231#227'o'
      DisplayWidth = 18
      FieldName = 'DataFimQuitacao'
      Origin = 'Fin_Lancamento.DataFimQuitacao'
      DisplayFormat = 'ddddd'
    end
    object quAccountValorNominal: TFloatField
      DisplayLabel = 'Amount'
      DisplayWidth = 10
      FieldName = 'ValorNominal'
      Origin = 'Fin_Lancamento.ValorNominal'
      DisplayFormat = '#,##0.00'
    end
    object quAccountTotalQuitado: TFloatField
      DisplayLabel = 'Paid'
      DisplayWidth = 10
      FieldName = 'TotalQuitado'
      Origin = 'Fin_Lancamento.TotalQuitado'
      DisplayFormat = '#,##0.00'
    end
    object quAccountPagando: TBooleanField
      DisplayWidth = 5
      FieldName = 'Pagando'
      Origin = 'Fin_Lancamento.Pagando'
    end
    object quAccountHistorico: TMemoField
      DisplayWidth = 10
      FieldName = 'Historico'
      Origin = 'RETAILDB.Fin_Lancamento.Historico'
      BlobType = ftMemo
    end
    object quAccountIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
  end
  object cmdStoreAccLog: TADOCommand
    CommandText = 
      'INSERT Sal_StoreAccountLimetLog (IDStoreAccountLimtLog, IDPessoa' +
      ', IDUser, LogDate, Amount)'#13#10'VALUES (:ID, :IDPessoa, :IDUser, :Lo' +
      'gDate, :Amount)'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'ID'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'IDPessoa'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'IDUser'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'LogDate'
        DataType = ftDateTime
        Size = -1
        Value = 0d
      end
      item
        Name = 'Amount'
        DataType = ftBCD
        Size = -1
        Value = 0c
      end>
    Left = 437
    Top = 469
  end
  object dstInvoiceItem: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'CONVERT(DATETIME, CONVERT(VARCHAR, I.PreSaleDate,112)) ' +
      'as InvoiceDate,'#13#10#9'IM.Qty,'#13#10#9'IM.Discount,'#13#10#9'((IM.QTY * IM.SalePri' +
      'ce) - IM.Discount) as SalePrice,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'T' +
      'G.Name as Category,'#13#10'                I.InvoiceCode'#13#10#9#13#10'FROM'#13#10#9'In' +
      'voice I (NOLOCK)'#13#10#9'JOIN Store S (NOLOCK) ON (I.IDStore = S.IDSto' +
      're)'#13#10#9'JOIN InventoryMov IM (NOLOCK) ON (I.IDInvoice = IM.Documen' +
      'tID AND IM.InventmovTypeID = 1) '#13#10#9'JOIN Model M (NOLOCK) ON (M.I' +
      'DModel = IM.ModelID)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup ' +
      '= M.GroupID)'#13#10'WHERE'#13#10#9'I.InvoiceDate >= :DataIni'#13#10#9'AND I.InvoiceD' +
      'ate < :DataFim'#13#10#9'AND I.IDCustomer = :IDPessoa'#13#10#9'AND I.IDInvoice ' +
      'IS NOT NULL'#13#10'ORDER BY'#13#10#9'I.InvoiceDate DESC'#13#10
    Parameters = <
      item
        Name = 'DataIni'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFim'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 214
    Top = 438
    object dstInvoiceItemInvoiceDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'InvoiceDate'
      DisplayFormat = 'ddddd'
    end
    object dstInvoiceItemQty: TBCDField
      FieldName = 'Qty'
      DisplayFormat = '0.##'
      Precision = 32
    end
    object dstInvoiceItemDiscount: TBCDField
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object dstInvoiceItemSalePrice: TBCDField
      FieldName = 'SalePrice'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
    object dstInvoiceItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object dstInvoiceItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object dstInvoiceItemCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
  end
  object dsInvoiceItem: TDataSource
    DataSet = dstInvoiceItem
    Left = 211
    Top = 395
  end
end
