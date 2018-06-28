object FrmAvgCostCalculation: TFrmAvgCostCalculation
  Left = 442
  Top = 197
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Avg Cost Calculation'
  ClientHeight = 149
  ClientWidth = 317
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
  object Label1: TLabel
    Left = 43
    Top = 50
    Width = 94
    Height = 13
    Alignment = taRightJustify
    Caption = 'Calc avg cost from :'
  end
  object dtStart: TDateBox
    Left = 145
    Top = 45
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '01/12/2009'
    InputTime = False
  end
  object btnStart: TBitBtn
    Left = 153
    Top = 121
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnClose: TBitBtn
    Left = 238
    Top = 121
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object pnlCalculation: TPanel
    Left = 1
    Top = 2
    Width = 313
    Height = 115
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object Label2: TLabel
      Left = 60
      Top = 19
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Model :'
    end
    object Label3: TLabel
      Left = 33
      Top = 64
      Width = 62
      Height = 13
      Alignment = taRightJustify
      Caption = 'Transaction :'
    end
    object lbModelTotal: TLabel
      Left = 100
      Top = 40
      Width = 3
      Height = 13
    end
    object pbModel: TProgressBar
      Left = 100
      Top = 18
      Width = 150
      Height = 16
      Smooth = True
      Step = 1
      TabOrder = 0
    end
    object pbTrans: TProgressBar
      Left = 100
      Top = 64
      Width = 150
      Height = 16
      Smooth = True
      Step = 1
      TabOrder = 1
    end
  end
  object cdsBalance: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 206
    Top = 182
  end
  object quMovHistory: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'select '#9'movdate,'#13#10#9'(2 * updateonhand-1) * qty as qty,'#13#10#9'cost,'#13#10#9 +
      'idinventmovtype,'#13#10#9'updateonhand'#13#10'   from (select isnull(im.qty, ' +
      '0) as qty,'#13#10#9'isnull(im.costprice, 0) as cost,'#13#10#9'convert(smalldat' +
      'etime, convert(varchar, im.movdate, 103), 103) as movdate,'#13#10#9'imt' +
      '.idinventmovtype,'#13#10#9'imt.updateonhand,'#13#10#9'CASE WHEN im.inventmovty' +
      'peid in (2, 4, 5, 11, 19, 21) THEN 10'#13#10#9'     WHEN im.inventmovty' +
      'peid in (1, 3, 12, 22) THEN 20'#13#10#9'ELSE 99 END as indice'#13#10'   from ' +
      'inventorymov im (nolock)'#13#10#9'join inventorymovtype imt (nolock)'#13#10#9 +
      '  on (im.inventmovtypeid = imt.idinventmovtype)'#13#10'  where im.mode' +
      'lid = :IDModel'#13#10#9'and convert(smalldatetime, convert(varchar, im.' +
      'movdate, 103), 103) >= :Date) x'#13#10'order by x.movdate, x.indice'
    CommandTimeout = 500000
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    Left = 206
    Top = 237
  end
  object quModel: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'M.IDModel'#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10'WHERE'#13#10#9'M.Desativad' +
      'o = 0'#13#10#9'AND'#13#10#9'M.IDModel = IsNull(:IDModel, M.IDModel)'
    CommandTimeout = 360
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 121
    Top = 187
  end
  object quModelLastBalance: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'MB.Qty,'#13#10#9'MB.AvgCostOut,'#13#10#9'MB.BalanceTotal'#13#10'FROM'#13#10#9'Inv_' +
      'ModelBalance MB (NOLOCK)'#13#10'WHERE'#13#10#9'MB.IDModel = :IDModel'#13#10#9'AND MB' +
      '.BalanceDate = ('#9'SELECT MAX(MB.BalanceDate)'#13#10#9#9#9#9'FROM Inv_ModelB' +
      'alance MB'#13#10#9#9#9#9'WHERE MB.IDModel = :IDModel1 AND MB.BalanceDate <' +
      ' :Date'#13#10#9#9#9#9'GROUP BY MB.IDModel)'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'IDModel1'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'Date'
        DataType = ftDateTime
        Size = -1
        Value = 0d
      end>
    Left = 121
    Top = 242
  end
  object cmdInsertBalance: TADOCommand
    CommandText = 
      'IF NOT EXISTS (SELECT IDModel FROM Inv_ModelBalance WHERE IDMode' +
      'l = :IDModel1 AND BalanceDate = :Date)'#13#10'INSERT Inv_ModelBalance ' +
      '(IDModel, BalanceDate, Qty, AvgCostOut, BalanceTotal)'#13#10'VALUES (:' +
      'IDModel, :BalanceDate, :Qty, :AvgCostOut, :BalanceTotal)'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModel1'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'Date'
        DataType = ftDateTime
        Size = -1
        Value = 0d
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'BalanceDate'
        DataType = ftDateTime
        Size = -1
        Value = 0d
      end
      item
        Name = 'Qty'
        DataType = ftBCD
        Size = -1
        Value = 0c
      end
      item
        Name = 'AvgCostOut'
        DataType = ftBCD
        Size = -1
        Value = 0c
      end
      item
        Name = 'BalanceTotal'
        DataType = ftBCD
        Size = -1
        Value = 0c
      end>
    Left = 56
    Top = 192
  end
  object cmdUpdateBalance: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'B'#13#10'SET '#9#13#10#9'B.Qty = :Qty,'#13#10#9'B.AvgCostOut = :AvgCostOut,'#13 +
      #10#9'B.BalanceTotal = :BalanceTotal'#13#10'FROM'#13#10#9'Inv_ModelBalance B'#13#10'WHE' +
      'RE'#13#10#9'B.IDModel = :IDModel'#13#10#9'AND'#13#10#9'B.BalanceDate = :BalanceDate'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Qty'
        DataType = ftFloat
        Size = -1
        Value = 0.000000000000000000
      end
      item
        Name = 'AvgCostOut'
        DataType = ftBCD
        Size = -1
        Value = 0c
      end
      item
        Name = 'BalanceTotal'
        DataType = ftBCD
        Size = -1
        Value = 0c
      end
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'BalanceDate'
        DataType = ftDateTime
        Size = -1
        Value = 0d
      end>
    Left = 61
    Top = 242
  end
  object quModelLastAvgCost: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'MB.AvgCostOut'#13#10'FROM'#13#10#9'Inv_ModelBalance MB (NOLOCK)'#13#10'WHE' +
      'RE'#13#10#9'MB.IDModel = :IDModel'#13#10#9'AND MB.BalanceDate = ('#9'SELECT MAX(M' +
      'B.BalanceDate)'#13#10#9#9#9#9'FROM Inv_ModelBalance MB'#13#10#9#9#9#9'WHERE MB.IDMod' +
      'el = :IDModel1 AND MB.BalanceDate < :Date'#13#10'AND MB.Qty > 0'#13#10#9#9#9#9'G' +
      'ROUP BY MB.IDModel)'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'IDModel1'
        DataType = ftInteger
        Size = -1
        Value = 0
      end
      item
        Name = 'Date'
        DataType = ftDateTime
        Size = -1
        Value = 0d
      end>
    Left = 121
    Top = 302
  end
end
