inherited DMServer: TDMServer
  object ConnectionTester: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=MainRetailDB;Data Source=(local)'
    ConnectionTimeout = 10
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 45
    Top = 232
  end
end
