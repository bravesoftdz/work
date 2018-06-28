inherited DMImportPersonTextFile: TDMImportPersonTextFile
  OldCreateOrder = True
  Left = 458
  Top = 173
  Height = 250
  Width = 264
  object cmdInsPessoa: TADOCommand
    CommandText = 
      'INSERT INTO Pessoa'#13#10#9'(IDPessoa,'#13#10#9'IDTipoPessoa,'#13#10#9'IDStore,'#13#10#9'IDT' +
      'ipoPessoaRoot,'#13#10#9'IDUSer,'#13#10#9'IDEstado,'#13#10#9'Pessoa,'#13#10#9'PessoaFirstName' +
      ','#13#10#9'PessoaLastName,'#13#10#9'ShortName,'#13#10#9'NomeJuridico,'#13#10#9'Endereco,'#13#10#9'C' +
      'idade,'#13#10#9'CEP,'#13#10#9'Pais,'#13#10#9'Telefone,'#13#10#9'Cellular,'#13#10#9'Fax,'#9#13#10#9'Contato,' +
      #13#10#9'Email,'#13#10#9'OBS,'#13#10#9'Nascimento,'#13#10#9'CPF,'#13#10#9'CGC,'#13#10#9'Identidade,'#13#10#9'Car' +
      'tTrabalho,'#13#10#9'InscEstadual,'#13#10#9'InscMunicipal,'#13#10#9'OrgaoEmissor,'#13#10#9'Ba' +
      'irro,'#13#10#9'CartMotorista,'#13#10#9'Juridico,'#13#10#9'Code,'#13#10#9'PhoneAreaCode,'#13#10#9'Ce' +
      'llAreaCode,'#13#10#9'CreationDate'#13#10#9')'#13#10'VALUES'#13#10#9'(:IDPessoa,'#13#10#9':IDTipoPe' +
      'ssoa,'#13#10#9':IDStore,'#13#10#9':IDTipoPessoaRoot,'#13#10#9':IDUSer,'#13#10#9':IDEstado,'#13#10 +
      #9':Pessoa,'#13#10#9':PessoaFirstName,'#13#10#9':PessoaLastName,'#13#10#9':ShortName,'#13#10 +
      #9':NomeJuridico,'#13#10#9':Endereco,'#13#10#9':Cidade,'#13#10#9':CEP,'#13#10#9':Pais,'#13#10#9':Tele' +
      'fone,'#13#10#9':Cellular,'#13#10#9':Fax,'#9#13#10#9':Contato,'#13#10#9':Email,'#13#10#9':OBS,'#13#10#9':Nas' +
      'cimento,'#13#10#9':CPF,'#13#10#9':CGC,'#13#10#9':Identidade,'#13#10#9':CartTrabalho,'#13#10#9':Insc' +
      'Estadual,'#13#10#9':InscMunicipal,'#13#10#9':OrgaoEmissor,'#13#10#9':Bairro,'#13#10#9':CartM' +
      'otorista,'#13#10#9':Juridico,'#13#10#9':Code,'#13#10#9':PhoneAreaCode,'#13#10#9':CellAreaCod' +
      'e,'#13#10#9':CreationDate'#13#10#9')'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDTipoPessoaRoot'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUSer'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDEstado'
        Attributes = [paNullable]
        DataType = ftString
        Size = 3
        Value = Null
      end
      item
        Name = 'Pessoa'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'PessoaFirstName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'PessoaLastName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'ShortName'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'NomeJuridico'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Endereco'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 80
        Value = Null
      end
      item
        Name = 'Cidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'CEP'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end
      item
        Name = 'Pais'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 21
        Value = Null
      end
      item
        Name = 'Telefone'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Cellular'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 18
        Value = Null
      end
      item
        Name = 'Fax'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 40
        Value = Null
      end
      item
        Name = 'Contato'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Email'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'OBS'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end
      item
        Name = 'Nascimento'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'CPF'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'CGC'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'Identidade'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'CartTrabalho'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'InscEstadual'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'InscMunicipal'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end
      item
        Name = 'OrgaoEmissor'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'Bairro'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end
      item
        Name = 'CartMotorista'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end
      item
        Name = 'Juridico'
        Attributes = [paNullable]
        DataType = ftBoolean
        NumericScale = 255
        Precision = 255
        Size = 2
        Value = Null
      end
      item
        Name = 'Code'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'PhoneAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'CellAreaCode'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 5
        Value = Null
      end
      item
        Name = 'CreationDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    Left = 48
    Top = 152
  end
end
