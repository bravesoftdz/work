object DMImportTextFile: TDMImportTextFile
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 682
  Top = 260
  Height = 227
  Width = 307
  object qryInsConfigImport: TADOQuery
    Parameters = <
      item
        Name = 'IDConfigImport'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPessoa'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'ImportType'
        DataType = ftSmallint
        Size = -1
        Value = Null
      end
      item
        Name = 'CrossColumn'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'CaseCost'
        DataType = ftBoolean
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO Sis_ConfigImport'
      #9'(IDConfigImport,'
      #9'IDPessoa,'
      #9'ImportType,'
      #9'CrossColumn,'
      #9'CaseCost)'
      'VALUES'
      #9'(:IDConfigImport,'
      #9':IDPessoa,'
      #9':ImportType,'
      #9':CrossColumn,'
      #9':CaseCost)')
    Left = 40
    Top = 10
  end
  object qryUpdConfigImport: TADOQuery
    Parameters = <
      item
        Name = 'CrossColumn'
        DataType = ftMemo
        Size = -1
        Value = Null
      end
      item
        Name = 'CaseCost'
        DataType = ftBoolean
        Size = -1
        Value = Null
      end
      item
        Name = 'IDConfigImport'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'UPDATE Sis_ConfigImport'
      #9'SET CrossColumn=:CrossColumn,'
      #9'CaseCost=:CaseCost'
      'WHERE IDConfigImport = :IDConfigImport')
    Left = 45
    Top = 80
  end
end
