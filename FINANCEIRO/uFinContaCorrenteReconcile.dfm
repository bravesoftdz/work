inherited FinContaCorrenteReconcile: TFinContaCorrenteReconcile
  Left = 278
  Top = 262
  Caption = 'Reconcile Bank Statement'
  ClientHeight = 208
  ClientWidth = 381
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 25
    Top = 34
    Width = 23
    Height = 29
    Caption = '1.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 60
    Top = 44
    Width = 273
    Height = 14
    Caption = 'Enter the following bank statement'#39's information '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 50
    Top = 88
    Width = 91
    Height = 14
    Alignment = taRightJustify
    Caption = 'Opening Balance'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 59
    Top = 130
    Width = 82
    Height = 14
    Alignment = taRightJustify
    Caption = 'Ending Balance'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbReconcDate: TLabel [4]
    Left = 45
    Top = 13
    Width = 71
    Height = 14
    Caption = 'Runtime Info'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 159
  end
  inherited EspacamentoDireito: TPanel
    Left = 378
    Height = 159
  end
  inherited EspacamentoSuperior: TPanel
    Width = 381
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 165
    Width = 381
  end
  inherited pnlPBarra: TPanel
    Top = 171
    Width = 381
    inherited pnlPDAlignRight: TPanel
      Left = 181
    end
    inherited pnlPLinhaSuperior: TPanel
      Width = 381
    end
  end
  object edtOpenBal: TEdit [10]
    Left = 154
    Top = 85
    Width = 136
    Height = 21
    TabOrder = 5
    Text = '0.00'
    OnKeyPress = edtOpenBalKeyPress
  end
  object edtCloseBal: TEdit [11]
    Left = 154
    Top = 127
    Width = 136
    Height = 21
    TabOrder = 6
    Text = '0.00'
    OnKeyPress = edtOpenBalKeyPress
  end
  inherited siLang: TsiLangRT
    StorageFile = 'OM_FinContaCorrenteReconcile.sil'
  end
  object quContaCorrente: TADOQuery
    Connection = DM.DBADOConnection
    Parameters = <
      item
        Name = 'IDContaCorrente'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        UltimoSaldoBancario,'
      '        UltimaReconciliacao'
      'FROM'
      '        Fin_ContaCorrente'
      'WHERE'
      '        IDContaCorrente = :IDContaCorrente')
    Left = 330
    Top = 10
    object quContaCorrenteUltimoSaldoBancario: TFloatField
      FieldName = 'UltimoSaldoBancario'
      Origin = 'RETAILDB.Fin_ContaCorrente.UltimoSaldoBancario'
    end
    object quContaCorrenteUltimaReconciliacao: TDateTimeField
      FieldName = 'UltimaReconciliacao'
      Origin = 'RETAILDB.Fin_ContaCorrente.UltimaReconciliacao'
      DisplayFormat = 'ddddd'
    end
  end
end
