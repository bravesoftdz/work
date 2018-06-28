inherited DMClient: TDMClient
  inherited ADODBConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=RodrigoTestDB;Data Source=(local);Use P' +
      'rocedure for Prepare=1;Auto Translate=True;Packet Size=4096;Work' +
      'station ID=DESENV001;Use Encryption for Data=False;Tag with colu' +
      'mn collation when possible=False'
  end
end
