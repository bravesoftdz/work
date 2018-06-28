object FrmPOSSQL: TFrmPOSSQL
  Left = 108
  Top = 140
  Width = 696
  Height = 519
  Caption = 'FrmPOSSQL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 92
    Top = 4
    Width = 102
    Height = 20
    Caption = '#60 Registry'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape1: TShape
    Left = 13
    Top = 24
    Width = 260
    Height = 446
    Brush.Color = clBlue
    Shape = stRoundRect
  end
  object quCrtTypes: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      
        'if not exists (select * from dbo.systypes where name = N'#39'TNumero' +
        'Serie'#39')'
      #9'EXEC sp_addtype N'#39'TNumeroSerie'#39', N'#39'char (20)'#39', N'#39'not null'#39
      ''
      ''
      
        'if not exists (select * from dbo.systypes where name = N'#39'TValorN' +
        'ull'#39')'
      #9'EXEC sp_addtype N'#39'TValorNull'#39', N'#39'money'#39', N'#39'null'#39
      '')
    Left = 72
    Top = 48
  end
  object quCrtReg60Analitico: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      
        'if not exists (select * from dbo.sysobjects where id = object_id' +
        '(N'#39'[dbo].[Fis_Registro60Analitico]'#39') and OBJECTPROPERTY(id, N'#39'Is' +
        'UserTable'#39') = 1)'
      #9'CREATE TABLE [dbo].[Fis_Registro60Analitico] ('
      #9#9'[DataEmissao] [datetime] NOT NULL ,'
      #9#9'[NumeroSerie] [TNumeroSerie] NOT NULL ,'
      
        #9#9'[SituacaoTributaria] [char] (4) COLLATE SQL_Latin1_General_CP1' +
        '_CI_AS NOT NULL ,'
      #9#9'[ValorAcumuladoParcial] [TValorNull] NULL '
      #9') ON [PRIMARY]')
    Left = 72
    Top = 104
  end
  object quCrtReg60Item: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      
        'if not exists (select * from dbo.sysobjects where id = object_id' +
        '(N'#39'[dbo].[Fis_Registro60Item]'#39') and OBJECTPROPERTY(id, N'#39'IsUserT' +
        'able'#39') = 1)'
      #9'CREATE TABLE [dbo].[Fis_Registro60Item] ('
      #9#9'[DataEmissao] [datetime] NOT NULL ,'
      #9#9'[NumeroSerie] [TNumeroSerie] NOT NULL ,'
      
        #9#9'[ModeloDocumentoFiscal] [char] (2) COLLATE SQL_Latin1_General_' +
        'CP1_CI_AS NULL ,'
      #9#9'[NumeroOrdem] [int] NOT NULL ,'
      #9#9'[NumeroItem] [int] NOT NULL ,'
      
        #9#9'[CodigoProdutoServico] [char] (14) COLLATE SQL_Latin1_General_' +
        'CP1_CI_AS NULL ,'
      #9#9'[Qtde] [int] NULL ,'
      #9#9'[ValorUnitario] [TValorNull] NULL ,'
      #9#9'[BaseCalculoICMS] [TValorNull] NULL ,'
      
        #9#9'[SituacaoTributaria] [char] (4) COLLATE SQL_Latin1_General_CP1' +
        '_CI_AS NULL ,'
      #9#9'[ValorICMS] [TValorNull] NULL '
      #9') ON [PRIMARY]')
    Left = 72
    Top = 160
  end
  object quCrtReg60Mestre: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      
        'if not exists (select * from dbo.sysobjects where id = object_id' +
        '(N'#39'[dbo].[Fis_Registro60Mestre]'#39') and OBJECTPROPERTY(id, N'#39'IsUse' +
        'rTable'#39') = 1)'
      #9'CREATE TABLE [dbo].[Fis_Registro60Mestre] ('
      #9#9'[DataEmissao] [datetime] NOT NULL ,'
      
        #9#9'[NumeroSerie] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS' +
        ' NOT NULL ,'
      #9#9'[NumeroOrdem] [int] NULL ,'
      
        #9#9'[ModeloDocumentoFiscal] [char] (2) COLLATE SQL_Latin1_General_' +
        'CP1_CI_AS NULL ,'
      #9#9'[NumeroInicialDia] [int] NULL ,'
      #9#9'[NumeroFinalDia] [int] NULL ,'
      #9#9'[NumeroReducao] [int] NULL ,'
      #9#9'[NumeroReinicioOperacao] [int] NULL ,'
      #9#9'[ValorVendaBruta] [TValorNull] NULL ,'
      #9#9'[ValorTotalGeral] [TValorNull] NULL '
      #9') ON [PRIMARY]')
    Left = 72
    Top = 216
  end
  object quCrtReg60ResumoDiario: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      
        'if not exists (select * from dbo.sysobjects where id = object_id' +
        '(N'#39'[dbo].[Fis_Registro60ResumoDiario]'#39') and OBJECTPROPERTY(id, N' +
        #39'IsUserTable'#39') = 1)'
      #9'CREATE TABLE [dbo].[Fis_Registro60ResumoDiario] ('
      #9#9'[DataEmissao] [datetime] NOT NULL ,'
      #9#9'[NumeroSerie] [TNumeroSerie] NOT NULL ,'
      
        #9#9'[CodigoProdutoServico] [char] (14) COLLATE SQL_Latin1_General_' +
        'CP1_CI_AS NOT NULL ,'
      #9#9'[Qtde] [int] NULL ,'
      #9#9'[ValorProdutoServico] [TValorNull] NULL ,'
      #9#9'[BaseCalculoICMS] [TValorNull] NULL ,'
      #9#9'[ValorICMS] [TValorNull] NULL ,'
      
        #9#9'[SituacaoTributaria] [char] (4) COLLATE SQL_Latin1_General_CP1' +
        '_CI_AS NULL '
      #9') ON [PRIMARY]')
    Left = 72
    Top = 272
  end
end
