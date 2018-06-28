unit uModuleConfig;

interface

uses
  SysUtils, uDM, AdoDB, uMsgBox, Graphics, DBTables, DB;

procedure ModuleConfig(aModule: char);
function ModuleStart: boolean;

implementation

uses uEncryptFunctions, uParamFunctions, uSystemObj, uDateTimeFunctions;

procedure ModuleConfig(aModule: char);
begin
  with TADOQuery.Create(nil) do
  begin
    Connection:= DM.ADODBConnect;

    SQL.Add('UPDATE MenuItem');
    SQL.Add('SET Enabled=1');
    SQL.Add('WHERE ((IDMenu <> 2) OR (IDSubMenu <> 9))');
    SQL.Add(' AND ((IDMenu <> 9) OR (IDSubMenu <> 3))');
    SQL.Add(' ');

    // Disabling MenuItems according to Module #
    //Todos os Modulos pode ter o Office Manager agora
    case aModule of
      '1': begin
        SQL.Add('UPDATE MenuItem');
        SQL.Add('SET Enabled=0 WHERE');
        SQL.Add('(IDMenu = 1 AND IDSubMenu = 3) OR'); //Invoice History
        SQL.Add('(IDMenu = 2) OR'); //All Sales Support Menu
        SQL.Add('(IDMenu = 3) OR'); //All Advertising Menu
        SQL.Add('(IDMenu = 4 AND IDSubMenu = 1) OR');  //Price Quote
        SQL.Add('(IDMenu = 4 AND IDSubMenu = 2) OR');  //Purchase Orders
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 2) OR');  //View by Store
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 7) OR');  //Inventory Returns
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 9) OR');  //Transfer Items
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 10) OR'); //Reset Inventory
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 12) OR'); //Color
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 13) OR'); //Size
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 14) OR'); //Barcode List
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 15) OR'); //Adjust Price
        SQL.Add('(IDMenu = 6 AND IDSubMenu = 2) OR'); //Outside Agent
        SQL.Add('(IDMenu = 6 AND IDSubMenu = 3) OR'); //Agency
        SQL.Add('(IDMenu = 6 AND IDSubMenu = 4) OR'); //Others
        SQL.Add('(IDMenu = 6 AND IDSubMenu = 5) OR'); //Reports
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 2) OR'); //Special Prices
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 3) OR'); //Delivery Types
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 9) OR'); //Menu Items
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 10) OR'); //Transfer Data
        //SQL.Add('(IDMenu = 8 AND IDSubMenu = 12) OR'); //Tax Categories
        SQL.Add('(IDMenu = 9 AND IDSubMenu = 2)'); //Time Clock
      end;
       'D','2': begin
        SQL.Add('UPDATE MenuItem');
        SQL.Add('SET Enabled=0 WHERE');
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 1) OR'); //Invoice On hold
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 2) OR'); //View Inventory
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 3) OR'); //Sales Person request
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 4) OR'); //Unlock Hold
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 5) OR'); //Customer Repair
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 6) OR'); //Customer file
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 7) OR'); //Graphs
        SQL.Add('(IDMenu = 3) OR'); //All Advertising Menu
        SQL.Add('(IDMenu = 4 AND IDSubMenu = 1) OR'); //Price Quotes
        SQL.Add('(IDMenu = 4 AND IDSubMenu = 2) OR'); //Purchase Orders
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 2) OR'); //View by Store
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 7) OR'); //Inventory Returns
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 9) OR'); //Transfer Items
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 10) OR'); //Reset Inventory
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 11) OR'); //Physical Inventory
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 12) OR'); //Color
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 13) OR'); //Size
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 14) OR'); //Barcode List
        SQL.Add('(IDMenu = 5 AND IDSubMenu = 15) OR'); //Adjust Price
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 2) OR'); //Special Prices
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 3) OR'); //Delivery Types
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 9) OR'); //Menu Items
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 10) OR'); //Transfer Data
        SQL.Add('(IDMenu = 9 AND IDSubMenu = 2)'); //Time Clock
      end;
      '3': begin
        SQL.Add('UPDATE MenuItem');
        SQL.Add('SET Enabled=0 WHERE');
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 3) OR'); //Sales Person Request
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 5) OR'); //Customer Repair
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 6) OR'); //Customer File
        SQL.Add('(IDMenu = 2 AND IDSubMenu = 7) OR'); //Sales Graphs
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 2) OR'); //Media Results
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 3) OR'); //Pickup Routes
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 4) OR'); //Expense Categories
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 5) OR'); //Group History
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 6) OR'); //Outside Agents
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 7) OR'); //Pickup Locations
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 8) OR'); //Agency Group Results
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 9) OR'); //Agency File
        SQL.Add('(IDMenu = 3 AND IDSubMenu = 10) OR'); //Reports
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 2) OR'); //Special Prices
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 3) OR'); //Delivery Types
        SQL.Add('(IDMenu = 8 AND IDSubMenu = 10)'); //Transfer Data
      end;
    end;

    if SQL.Count > 0 then
      ExecSQL;

    Free;
  end;
end;

function ModuleStart: boolean;
var
  sModInfo: string;
begin
  Result:= false;

  with TADOQuery.Create(nil) do
  begin
    Connection:= DM.ADODBConnect;

    SQL.Add('SELECT ModuleInfo, VersionNo, BuildNo, VersionType, RestricForms, MRLogo, MRBuild FROM Sys_Module');
    Open;
    if IsEmpty then
      Exit;

    sModInfo               := DecodeServerInfo(FieldByName('ModuleInfo').AsString, 'ModInfo', CIPHER_TEXT_STEALING, FMT_UU);
    DM.fSystem.Version     := FieldByName('VersionNo').AsInteger;
    DM.fSystem.Build       := FieldByName('BuildNo').AsInteger;
    DM.fSystem.VersionType := FieldByName('VersionType').AsString;
    DM.fSystem.MRBuild     := FieldByName('MRBuild').AsInteger;
    
    if not FieldByName('MRLogo').IsNull then
    begin
      try
        DM.fSystem.Logo := TPicture.Create;
        DM.fSystem.Logo.Assign(FieldByName('MRLogo'));
      except
      end;
    end;

    DM.BuildRestricForms(FieldByName('RestricForms').AsString);

    Close;

    //Extracting Module #
    DM.fSystem.StartMode    := ParseParam(sModInfo, '#Module#=')[1];
    //Extract License Key
    DM.fSystem.ValidLicense := (ParseParam(sModInfo, '#Key#=')='Y');
    //Setar a data do sistema
    DM.fSystem.SystemDate   := Trunc(Now);
    //Expiration Date
    if (ParseParam(sModInfo, '#Expire#=')='') then
       DM.fSystem.ExpirationDate := Trunc(Now-1)
    else
       DM.fSystem.ExpirationDate := StrToInt(ParseParam(sModInfo, '#Expire#='));

    if not(DM.fSystem.StartMode in [SYS_MODULE_TRIAL, SYS_MODULE_1..SYS_MODULE_5]) then
      Exit;

    ModuleConfig(DM.fSystem.StartMode);

    Free;
  end;

  Result:= true;
end;

end.
