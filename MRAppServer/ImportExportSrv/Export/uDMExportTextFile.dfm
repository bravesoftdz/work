object DMExportTextFile: TDMExportTextFile
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 370
  Top = 242
  Height = 215
  Width = 284
  object qryInsConfigExport: TADOQuery
    Parameters = <
      item
        Name = 'IDConfigExport'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DelimiterSeparator'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'DecimalSeparator'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'HeaderConfig'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'FileFormat'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'HeaderFile'
        DataType = ftBoolean
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
        Name = 'ExportType'
        DataType = ftSmallint
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'INSERT INTO Sis_ConfigExport'
      #9'(IDConfigExport,'
      #9'DelimiterSeparator,'
      #9'DecimalSeparator,'
      #9'HeaderConfig,'
      #9'FileFormat,'
      #9'HeaderFile,'
      #9'IDPessoa,'
      #9'ExportType)'
      'VALUES'
      #9'(:IDConfigExport,'
      #9':DelimiterSeparator,'
      #9':DecimalSeparator,'
      #9':HeaderConfig,'
      #9':FileFormat,'
      #9':HeaderFile,'
      #9':IDPessoa,'
      #9':ExportType)')
    Left = 45
    Top = 15
  end
  object qryUpdConfigExport: TADOQuery
    Parameters = <
      item
        Name = 'DelimiterSeparator'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'DecimalSeparator'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'HeaderConfig'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'FileFormat'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'HeaderFile'
        DataType = ftBoolean
        Size = -1
        Value = Null
      end
      item
        Name = 'IDConfigExport'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'UPDATE Sis_ConfigExport '
      #9'SET DelimiterSeparator = :DelimiterSeparator,'
      #9'DecimalSeparator = :DecimalSeparator,'
      #9'HeaderConfig = :HeaderConfig,'
      #9'FileFormat = :FileFormat,'
      #9'HeaderFile = :HeaderFile'
      'WHERE IDConfigExport = :IDConfigExport')
    Left = 40
    Top = 80
  end
end
