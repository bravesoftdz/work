unit MRpuppyIntegrationCls;

interface
uses classes,SysUtils, DbClient, ADODB, DB, Variants, ShellAPI, Forms, Windows, Dialogs,
     Messages, StdCtrls, Buttons, ExtCtrls, ComCtrls, IniFiles, ActiveX,
     Email, MsTask, MsTaskUtils, uDataBaseOperation, uOperationSystem,
     ShFolder, IdHashMessageDigest, idHash, AbBrowse, AbMeter,
     AbBase, AbZBrows, AbUnzper;

type
    TCategoryType = ( tcPet, tcMicroChip, tcService, tcKit, tcOther );

    TMRPuppyIntegration = class
    private
       FPetCategory: Integer;
       FPetKitCategory: Integer;
       FPetServiceCategory: Integer;
       FGroupPet: Integer;
       FGroupMicroChip: Integer;
       FGroupService: Integer;
       FCategoryType: TCategoryType;
       FStoreID: Integer;
       FMicroChipSubList: TStringList;

       FCdsMicroChip: TClientDataSet;
       FServiceMapSubList: TStringList;
       FCdsServiceMap: TClientDataSet;

       FFileExeNameSale: String;
       FFileExeName360Import: String;

       FCdsPuppy: TClientDataSet;
       FPuppy: TStringList;
       FConnection: TADOConnection;
       FRunExeFileName: String;

       FListValidColumn: TStringList;

       //amfsouza 03.15.2012
       function modelFound(var idModel: Integer; ref: String; categoryType: TCategoryType = tcPet): Boolean;

       //amfsouza 03.13.2012 functions to decide how repair
       function puppyFound(ref: String): Integer;
       function microchipFound(ref: String): String;
       function serviceFound(ref: String): Integer;
       function kitFound(ref: String): Integer;
       function addPuppyToKit(kit, puppy: Integer): Boolean;
       function deleteMicroChip(microchip: String): Boolean;
       function addMicrochipToKit(kit: Integer; microchip: String): Boolean;
       function addMicrochipToBarcode(microchip : String; kit, recno: Integer): Boolean;
       function addMicrochipToPet(idKit: Integer; microchip: String): Boolean;
       function addServiceToKit(kit, service: Integer): Boolean;
       function createPuppy(ref, breed, description: String; cost, price: Currency): Integer;
       function createKit(ref, breed: String; IdPuppy: Integer): Integer;
       function createService(service: String): Integer;
       function createMicrochip(microchip: String): Integer;

       function puppyFoundInKit(kit, puppy: Integer): Boolean;
       function microchipFoundInKit(kit, microchip: Integer): Boolean;
       function serviceFoundInKit(kit, service: Integer): Boolean;

       function getDataDealt(tabPosition: Integer; line: String ): String;
       function getMapToSplittedLine(complete_line: String): TStringList;

       function getMacAddress: String;

       //routine copied from MRWizard.
           { Alex 05/04/2011 }
       Class Function IsWOW64 : Boolean;
       Function WinVersion : string;
       Function ReturnWindowsFolder( piFolderId : Integer = -1) : String; OverLoad;
       Function RunAsAdminAndWaitForCompletion( psFileName : String; psParameters : String ): Boolean;
       Function CreateWindowsProcessAsUser( psCommandLine  : String;
                                         psUsername     : String;
                                         psUserPassword : String;
                                         pbShowOnScreen : Boolean ) : Integer;

       function ValidateMicroChip(microchip: String): boolean;
       function getParamString(IdInvoice, IdPresale: Integer; refund: boolean): String;
       function AssignToServices(ref: String): boolean;
       function GetNextCode(const TableName, FieldName: WideString; SQLConnection: TADOConnection): Integer;
       function ExecuteExternalProgram: String;

       //function insertAll(ref, breed, description: String; cost, price: Currency): boolean;

       function LinkPuppyToKit(id_puppy, id_kit: Integer): Boolean;

       function updateAll(ref, breed, description: String; cost, price: Currency): boolean;

       function verifyPuppyInPetCategory(ref: String): Integer; overload;

       procedure activateKitIfNotAvailable(petKitSelected: Integer);
       function getKitUsingPuppy(id_puppy: Integer): Integer;
       function getKitUsingPuppyFromKitDescription(var id_puppy: Integer; ref: String): Integer;

       procedure activateServiceIfNotAvailable(petServiceSelected: Integer);
       function verifyService(IdKit: Integer): Integer;
       function UpdatePuppy(IdPuppy: Integer; breed, description: String; cost, price: Currency): boolean;
       function UpdateKit(IdKit: Integer; description: String; cost, price: Currency): boolean;
       function UpdateService(idService, idPuppy, idKit: Integer ; description: String; cost, price: Currency): boolean;
       function DealingServices(ref: String; idPuppy, idKit: Integer; cost, price: Currency): boolean;
       function DealingMicrochips(IdPuppy, IdKit: Integer; ref: String): boolean;
       function UpdateMicrochip(IdPuppy, IdKit: Integer; ref: String): boolean;

       function renameModel(ref: String; idModel: Integer): boolean;
       function renameInsertPuppy(ref, breed, description: String; cost, price: Currency; idModel: Integer): Boolean;
       function renameInsertKit(ref, description: String; idModel: Integer): Boolean;
       function renameInsertService(ref, descrition: String; cost, price: Currency; idModel: Integer): Boolean;

       function getServiceMapList: TStringList;
       function getCdsPuppy: TClientDataSet;
       function getCdsServiceMapList: TClientDataSet;
       function getMicroChipList: TStringList;
       function getTextInfo(startAt, endAt: Integer; line: String): String; overload;
       function getTextInfo(line: TStringList; index: Integer): String; overload;
       function splitList(line: String): TStringList;
       function savePuppyToMRDatabase: boolean;
       function recordFound(select, join, where: String; value: variant): Integer;
       function getCategory(category: TCategoryType): Integer;
       function getIndexService(line: String): Integer;
       function getPhoneNumber(areaCode, phone: String): String;

       procedure OpenLocalSettings;
       procedure openGlobalSettings;

       procedure setPetCategory(const Value: Integer);
       procedure MoveRecordToCds;
       procedure setStoreId(const Value: Integer);
       procedure setFileExeName360Import(const Value: String);
       procedure setFileExeNameSale(const Value: String);
       procedure setPetKitCategory(const Value: Integer);
       procedure setPetServiceCategory(const Value: Integer);
    public
       property MacAddress: String read getMacAddress;
       property getRunExeFileName: String read FRunExeFileName;
       property FileExeNameSale: String write setFileExeNameSale;
       property FileExeName360Import: String write setFileExeName360Import;
       property StoreId: Integer write setStoreId;
       property PetCategory: Integer write setPetCategory;
       property PetKitCategory: Integer write setPetKitCategory;
       property PetServiceCategory: Integer write setPetServiceCategory;
       property MicroChipList: TStringList read getMicroChipList;
       property ServiceMapList: TStringList read getServiceMapList;
       property CdsPuppy: TClientDataSet read getCdsPuppy;
       property CdsServiceMapList: TClientDataSet read getCdsServiceMapList;
       constructor Create(connection: TADOConnection);
       destructor Destroy; override;

       //amfsouza 10.06.2011 - return is a model is a puppy or not.
       function verifyPuppyInPetCategory(idModel: Integer): boolean; overload;
       function RunNow: boolean;
       function PuppySoldToPuppyTracker(IdInvoice, IdPreSale: Integer; return: boolean = false): boolean;
       function createWindowsService(puppyTrackerServer: boolean): boolean;
    end;


  function CreateProcessWithLogon(lpUsername: PWChar;
                                  lpDomain: PWChar;
                                  lpPassword: PWChar;
                                  dwLogonFlags: DWORD;
                                  lpApplicationName: PWChar;
                                  lpCommandLine: PWChar;
                                  dwCreationFlags: DWORD;
                                  lpEnvironment: Pointer;
                                  lpCurrentDirectory: PWChar;
                                  const lpStartupInfo: TStartupInfo;
                                  var lpProcessInfo: TProcessInformation): BOOL; stdcall;



implementation
uses UFileFunctions, uStringFunctions, uObjectServices, StrUtils,
     uDebugFunctions;


//amfsouza 09.29.2011 - begin
function CoCreateGuid(var guid: TGUID): HResult; stdcall; far external 'ole32.dll';

function Get_MACAddress: string;
var
   Lib: Cardinal;
   Func: function(GUID: PGUID): Longint; stdcall;
   GUID1, GUID2: TGUID;
begin
   Result := '';
   Lib := LoadLibrary('rpcrt4.dll');
   if Lib <> 0 then begin
     @Func := GetProcAddress(Lib, 'UuidCreateSequential');
     if Assigned(Func) then begin
       if (Func(@GUID1) = 0) and
          (Func(@GUID2) = 0) and
          (GUID1.D4[2] = GUID2.D4[2]) and
          (GUID1.D4[3] = GUID2.D4[3]) and
          (GUID1.D4[4] = GUID2.D4[4]) and
          (GUID1.D4[5] = GUID2.D4[5]) and
          (GUID1.D4[6] = GUID2.D4[6]) and
          (GUID1.D4[7] = GUID2.D4[7]) then begin
           Result :=
             IntToHex(GUID1.D4[2], 2) + '-' +
             IntToHex(GUID1.D4[3], 2) + '-' +
             IntToHex(GUID1.D4[4], 2) + '-' +
             IntToHex(GUID1.D4[5], 2) + '-' +
             IntToHex(GUID1.D4[6], 2) + '-' +
             IntToHex(GUID1.D4[7], 2);
       end;
     end;
   end;
end;
//amfsouza 09.29.2011 - end


function CreateProcessWithLogon; external advapi32 name 'CreateProcessWithLogonW';

class function TMRPuppyIntegration.IsWOW64: Boolean;
type
  TIsWow64Process = function( // Type of IsWow64Process API fn
    Handle: THandle;
    var Res: BOOL
  ): BOOL; stdcall;
var
  IsWow64Result: BOOL;              // result from IsWow64Process
  IsWow64Process: TIsWow64Process;  // IsWow64Process fn reference
begin
  // Try to load required function from kernel32
  IsWow64Process := GetProcAddress(
    GetModuleHandle('kernel32'), 'IsWow64Process'
  );
  if Assigned(IsWow64Process) then
  begin
    // Function is implemented: call it
    if not IsWow64Process(GetCurrentProcess, IsWow64Result) then
      raise Exception.Create('Bad process handle');
    // Return result of function
    Result := IsWow64Result;
  end
  else
    // Function not implemented: can't be running on Wow64
    Result := False;
end;


{ TMRPuppyGlobalSetting }
constructor TMRPuppyIntegration.Create(connection: TADOConnection);
begin
   FConnection := connection;
   // to get separated each service from a groups
   FServiceMapSubList := TStringList.Create;
   FServiceMapSubList.Duplicates := dupIgnore;
   FServiceMapSubList.Delimiter  := ',';


   FPuppy           := TStringList.Create;
   FPuppy.Duplicates := dupIgnore;
   FPuppy.Delimiter := chr(9); // tab character
//   FPuppy.QuoteChar := #9;

   // to get separated each microchip from a groups
   FMicroChipSubList  := TStringList.Create;
   FMicroChipSubList.Duplicates := dupIgnore;
   FMicroChipSubList.Delimiter  := ',';

   // to save on the future in database.
   FCdsServiceMap     := TClientDataSet.Create(nil);
   FCdsServiceMap.FieldDefs.add('IdModel', ftInteger, 0, false);
   FCdsServiceMap.FieldDefs.Add('Ref', ftString, 10, false);          // Puppy
   FCdsServiceMap.FieldDefs.Add('Service', ftString, 30, true);       //service = model
   FcdsServiceMap.FieldDefs.Add('Description', ftString, 50, true);
   FCdsServiceMap.FieldDefs.Add('price', ftCurrency);                // default = 0.00
   FCdsServiceMap.FieldDefs.Add('RequireOnSale', ftBoolean, 0, true);   // default = false
   FcdsServiceMap.CreateDataSet;

   FCdsMicroChip := TClientDataSet.Create(nil);
   FCdsMicrochip.FieldDefs.Add('Model', ftInteger, 0, true);
   FCdsMicroChip.FieldDefs.Add('Microchip', ftString, 30, true);
   FCdsMicroChip.CreateDataSet;

   // create cds to fill after, on read txt file
   FCdsPuppy       := TClientDataSet.Create(nil);
   FCdsPuppy.FieldDefs.Add('Ref', ftString, 10, true);
   FCdsPuppy.FieldDefs.Add('Collar', ftString, 20, true);
   FCdsPuppy.FieldDefs.Add('Cost', ftCurrency);
   FCdsPuppy.FieldDefs.Add('Price', ftCurrency);
   FCdsPuppy.FieldDefs.Add('Breed', ftString, 25, true);
   FCdsPuppy.FieldDefs.Add('Sex', ftString, 7, true);
   FCdsPuppy.CreateDataSet;

   FListValidColumn := TStringList.Create;


   //LocalSettings
   OpenLocalSettings;

   // global settings
   openGlobalSettings;
end;

destructor TMRPuppyIntegration.Destroy;
begin
  freeAndNil(FCdsPuppy);
  freeAndNil(FCdsMicrochip);
  freeAndNil(FCdsServiceMap);
  freeAndNil(FPuppy);
  freeAndNil(FServiceMapSubList);
  freeAndNil(FMicrochipSubList);
  freeAndNil(FListValidColumn);
  inherited;
end;

function TMRPuppyIntegration.getCdsPuppy: TClientDataSet;
begin
  result := FCdsPuppy;
end;

function TMRPuppyIntegration.getCdsServiceMapList: TClientDataSet;
begin
   result := FCdsServiceMap;
end;

function TMRPuppyIntegration.getMicroChipList: TStringList;
begin
   result := FMicroChipSubList;
end;

function TMRPuppyIntegration.getServiceMapList: TStringList;
begin
   result := FServiceMapSubList;
end;

function TMRPuppyIntegration.getTextInfo(startAt, endAt: Integer; line: String): String;
begin
   result := copy(line, startAt, endAt);
end;

function TMRPuppyIntegration.getTextInfo(line: TStringList;
  index: Integer): String;
begin
  result := line.Strings[index];
end;

(*
function TMRPuppyIntegration.insertAll(ref, breed, description: String; cost, price: Currency): boolean;
var
  IdPuppy: Integer;
  IdKit: Integer;
begin
    result := true;
    try
       IdPuppy := createPuppy(ref, breed, description, cost, price);

       IdKit   := createKit(ref, breed, IdPuppy);

       createService(ref, IdPuppy, IdKit);
       createMicroChip(ref, IdPuppy, IdKit);

    except on e: Exception do begin
             result := false;
             raise exception.Create(' Fail to insert: ' + ref + ' ' + e.Message) ;
           end;
    end;
end;
*)

procedure TMRPuppyIntegration.MoveRecordToCds;
var i, k: integer;
    recordLine: TStringList;
    splitRecordLine: TStringList;
    mapToSplitted: TStringList;
    correctIndex: Integer;
    sLine, blankMicrochip: String;
    relativePosition: Integer;
    fieldText: String;
    columnPosition: Integer;
    tabPositionStr: String;
begin
   blankMicrochip := DupeString(' ', 15);
   recordLine := TStringList.Create;
   recordLine.Delimiter := chr(9);
//   recordLine.QuoteChar := chr(39);

   try
   for i:= 0 to FPuppy.Count - 1 do begin

       if ( i = 0 ) then
          continue;

//       showMessage('In the loop, Line: 225, counter: ' + intToStr(i));

       recordLine.Text := FPuppy[i] + chr(9);
       mapToSplitted := getMapToSplittedLine(recordLine.Text);

       FCdsPuppy.Append;

       // get Ref position 0, if all fields complete
       columnPosition := FListValidColumn.IndexOf('0');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FCdsPuppy.FieldByName('Ref').Value := fieldText;
       end;

       // get Collar position 1 if all fields complete
       columnPosition := FListValidColumn.IndexOf('1');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FCdsPuppy.FieldByName('Collar').Value := fieldText;
       end;

       // get Microchip position 2 if all fields complete
       columnPosition := FListValidColumn.IndexOf('2');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FMicroChipSubList.DelimitedText := fieldText;

           for k:= 0 to FMicroChipSubList.Count -1 do begin

               if ( not validateMicrochip(getTextInfo(FMicroChipSubList, k)) ) then
                   continue;

               FCdsMicroChip.Append;
               FCdsMicroChip.FieldByName('Model').Value := FCdsPuppy.fieldByName('Ref').Value;

               FCdsMicroChip.FieldByName('Microchip').Value := getTextInfo(FMicroChipSubList, k);
               FCdsMicroChip.Post;

           end;
       end;

       // get Cost  position 3 if all fields complete
       columnPosition := FListValidColumn.IndexOf('3');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FCdsPuppy.FieldByName('Cost').Value := fieldText;
       end;

       // get Price position 4 if all fields complete
       columnPosition := FListValidColumn.IndexOf('4');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FCdsPuppy.FieldByName('Price').Value := fieldText;
       end;

       // get Breed position 5 if all fields complete
       columnPosition := FListValidColumn.IndexOf('5');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FCdsPuppy.FieldByName('Breed').Value := fieldText;
       end;

       // get sex  position 6 if all fields complete
       columnPosition := FListValidColumn.IndexOf('6');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FCdsPuppy.FieldByName('Sex').Value := fieldText;
       end;

       // get service map position 7 if exists
       columnPosition := FListValidColumn.IndexOf('7');
       if ( columnPosition > -1 ) then begin
           // AmfSouza November 10, 2012 - length to tabPositionStr becomes dynamic instead, 2 by hard code
           tabPositionStr := copy(mapToSplitted[columnPosition], (pos(',', mapToSplitted[columnPosition])+1), length(mapToSplitted[columnPosition]));
           fieldText := getDataDealt(strToInt(tabPositionStr), recordLine.Text );
           FServiceMapSubList.DelimitedText := fieldText;

           for k:= 0 to FServiceMapSubList.Count - 1 do begin
               FCdsServiceMap.Append;
               FCdsServiceMap.FieldByName('Ref').Value := FCdsPuppy.fieldByName('Ref').Value;
               FCdsServiceMap.FieldByName('service').Value := getTextInfo(FServiceMapSubList, k);
               FCdsServiceMap.FieldByName('Description').Value := FCdsServiceMap.FieldByName('service').Value;
               FCdsServiceMap.FieldByName('Price').Value := 0;
               FCdsServiceMap.FieldByName('RequireOnSale').Value := False;
               FCdsServiceMap.Post;
           end;
       end;
       freeAndNil(mapToSplitted);

   end; //end-for
   except
      on e: Exception do begin
         raise Exception.Create('Fail to move records: ' + e.Message);
      end;
   end;
end;

function TMRPuppyIntegration.recordFound(select,  join, where: String; value: variant): Integer;
var
   qrySeek: TADOQuery;
   sqlSeek: String;
begin
   try
       result := -1;
       qrySeek      := TADOQuery.Create(nil);

       qrySeek.Connection      := FConnection;
       sqlSeek := select + join + where;
       qrySeek.SQL.Text := sqlSeek;
       qrySeek.Parameters.ParamByName('param').Value := value;
       qrySeek.Open;

       if ( not qrySeek.isEmpty ) then
          result := qrySeek.fieldByName('IdModel').AsInteger;
   finally
       freeAndNil(qrySeek);
   end;

end;

function TMRPuppyIntegration.renameModel(ref: String; idModel: Integer): boolean;
var
   qry: TADOQUery;
begin
    result := true;
    try
        try
          //rename model

          qry := TADOQuery.Create(nil);
          qry.Connection := FConnection;

          qry.SQL.Text :=
            'update model set model = :model ' +
            ' where IdModel = :param';
          qry.Parameters.ParamByName('model').Value := ref;
          qry.Parameters.ParamByName('param').Value := idModel;
          qry.ExecSQL;
        except on e: Exception do begin
               result := false;
               raise exception.Create(' Failed to rename model: ' + ref + ' ' +  e.Message);
            end;
        end;
    finally
       freeAndNil(qry);
    end;
end;

function TMRPuppyIntegration.RunNow: boolean;
begin
  try
   //execute external program to create a txt file and get it.
   FPuppy.LoadFromFile(ExecuteExternalProgram);
//(*to debug*)   FPuppy.LoadFromFile(FFileExeName360Import);

   MoveRecordToCds;
   result := savePuppyToMRDatabase;
  except
     on e: Exception do begin
        raise Exception.Create('Fail to Import PuppyTracker Information: ' + e.Message);
     end;
  end;
end;

function TMRPuppyIntegration.savePuppyToMRDatabase: boolean;
var
   field: TField;
   found: boolean;
   breed, sex, collar: String;
   cost, price: currency;
   ref: String;
   i: Integer;
   modelDescription: String;
   select, join, where: String;
   idPuppy, idKit: Integer;
   idModel: Integer;
   kitRef: String;
   isModelPuppy: Boolean;
   isModelExists: Boolean;
begin
   FConnection.BeginTrans;

   try
     if ( not FCdsPuppy.IsEmpty ) then begin
        FCdsPuppy.First;
        while ( not FCdsPuppy.Eof ) do begin

           // ref
           field := FCdsPuppy.Fields.FindField('Ref');
           if ( field <> nil ) then begin
              ref := Field.Value;
           end;

           // breed
           field := FcdsPuppy.Fields.FindField('Breed');
           if ( field <> nil ) then
              breed := field.Value;

           //sex
           field := FcdsPuppy.Fields.FindField('Sex');
           if ( field <> nil ) then begin
              if ( field.IsNull ) then
                 sex := 'Unknown'
              else
                 sex := field.Value;
           end;

           // collar
           field := FCdsPuppy.Fields.FindField('Collar');
           if ( field <> nil ) then
              collar := field.Value;

           modelDescription := breed + ' - ' + sex + ' (' + collar + ')';

           // Price
           field := FcdsPuppy.Fields.FindField('Price');
           if ( field <> nil ) then
              price := field.AsCurrency;

           // Cost
           field := FcdsPuppy.Fields.FindField('Cost');
           if ( field <> nil ) then
              cost := field.AsCurrency;

           isModelExists := modelFound(idModel, ref, tcOther);

           // ( ** puppy ** )
           if ( isModelExists ) then begin
              if ( modelFound(idModel, ref, tcPet) ) then begin // found in pet category
                 UpdatePuppy(idModel, breed, modelDescription, cost, price)
              end
              else begin
                 renameModel((ref+'_ptrename'), idModel);
                 idPuppy := createPuppy(ref, breed, modelDescription, cost, price);
              end;
           end
           else begin
              idPuppy := createPuppy(ref, breed, modelDescription, cost, price);
           end;

           // ( ** kit ** )
           if ( isModelExists ) then begin
               idKit := kitFound(ref);
           		if ( kitFound(ref) > - 1 ) then begin
                   UpdateKit(idKit, (ref+'-kit'), cost, price)
               end
               else begin
                   renameModel((ref+'-kit_ptrename'), idModel);
                   idKit := createKit(ref, breed, idPuppy);
               end;
           end
           else begin
               idKit := createKit(ref, breed, idPuppy);
           end;

           // ( ** services ** )
           debugToFile('Dealing Services-begin - Save Puppy to MRDB');
           dealingServices(ref, idPuppy, idKit, cost, price);
           debugToFile('Dealing Services-end - Save Puppy to MRDB');

           // ( ** microchips ** )
           debugToFile('Dealing Microchips-begin - Save Puppy to MRDB');
           dealingMicrochips(idPuppy, idKit, ref);
           debugToFile('Dealing Microchips-end - Save Puppy to MRDB');

           FCdsPuppy.Next;
        end;
     end;


     FConnection.CommitTrans;
     result := true;
   except
         on e: Exception do begin
            FConnection.RollbackTrans;
            raise exception.Create(' Found issue when trying save to database. Ref = '+ quotedStr(ref)+ ' message: '+ e.Message);
         end
   end;
end;

function TMRPuppyIntegration.updateAll(ref, breed, description: String; cost, price: Currency): boolean;
var
  IdPuppy: Integer;
  IdKit: Integer;
begin
    result := true;
    try
       //verify if ref in Pet category
       IdPuppy := verifyPuppyInPetCategory(ref);
       if ( idPuppy > -1 ) then begin
           UpdatePuppy(idPuppy, breed, description, cost, price);

           // verify if puppy has a kit and get them.
           IdKit   := getKitUsingPuppy(IdPuppy);
           ActivateKitIfNotAvailable(FPetKitCategory);

           // for any reason, puppy is not associated to kit
           if ( idKit = -1 ) then
              idKit := getKitUsingPuppyFromKitDescription(IdPuppy, ref);

           if ( idKit > - 1 ) then begin
           // puppy exist, kit exist must be associated.
              LinkPuppyToKit(idPuppy, idKit);
           end;

           //amfsouza 12.12.2011
           ActivateServiceIfNotAvailable(FPetServiceCategory);
           debugToFile('Dealing Services-begin - Update All');
           DealingServices(ref, idPuppy, idKit, 0, 0);
           debugToFile('Dealing Services-end - Update All');

           debugToFile('Dealing Microchips-begin - Update All');
           DealingMicrochips(idPuppy, idKit, ref);
           debugToFile('Dealing Microchips-end - Update All');

       end;
    except on e: Exception do begin
             result := false;
             raise exception.Create(' Fail to Update: ' + ref + ' ' + e.Message) ;
           end;
    end;

end;

procedure TMRPuppyIntegration.setPetCategory(const Value: Integer);
begin
  FPetCategory := Value;
end;

function TMRPuppyIntegration.splitList(line: String): TStringList;
var
   splitLine: TStringList;
begin
   splitLine := TStringList.Create;
//   splitLine.Delimiter :=

end;

procedure TMRPuppyIntegration.setStoreId(const Value: Integer);
begin
   FStoreID := value;
end;

procedure TMRPuppyIntegration.setFileExeName360Import(const Value: String);
begin
   FFileExeName360Import := value;
end;

procedure TMRPuppyIntegration.setFileExeNameSale(const Value: String);
begin
   FFileExeNameSale := Value;
end;

function TMRPuppyIntegration.ExecuteExternalProgram: String;
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
  ExecuteFile, ParamString, StartInString: string;
  pathFileCreated: String;
begin
    result := '';
    try
      {"\\Workstation1\StoresApplication\StoreOnSite360AvailabilityExport.exe" "--	getavailable,\\MainRetailServer\AvailablePups\AvailFile.txt"}
      ExecuteFile := FFileExeName360Import;
      pathFileCreated := ExtractFilePath(FFileExeName360Import) + 'AvailFile.txt';
//      showmessage('Execute file path  : ' + ExecuteFile);
//      showmessage('AvailFile file path: ' + pathFileCreated);


//      paramString := '-- getavailable, \\MainRetailServer\AvailablePups\AvailFile.txt';
      paramString := '-- getavailable, ' + pathFileCreated;
//      showmessage('Run parameter: ' + ParamString);

      FRunExeFileName := ParamString;

      //amfsouza 11.08.2011 - was lacking double quotes
      ParamString := '"'+paramString+'"';

      FillChar(SEInfo, SizeOf(SEInfo), 0) ;
      SEInfo.cbSize       := SizeOf(TShellExecuteInfo) ;
      SEInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
      SEInfo.Wnd          := Application.Handle;
      SEInfo.lpFile       := PChar(ExecuteFile);
      SEInfo.lpParameters := PChar(paramString);
      SEInfo.nShow        := SW_HIDE;

      if ShellExecuteEx(@SEInfo) then begin
        repeat
          Application.ProcessMessages;
          GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
        until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
      end;
//      showMessage('ExitCode    : ' + intToStr(exitcode));
//      showMessage('Still Active: ' + intToStr(STILL_ACTIVE));
      result := pathFileCreated;

    except
        on e: Exception do begin
           raise exception.Create('Fail to run Shell: ' +  e.Message);
        end;
   end;
end;

function TMRPuppyIntegration.PuppySoldToPuppyTracker(IdInvoice, IdPreSale: Integer; return: boolean = false): boolean;
var
  SEInfo: TShellExecuteInfo;
  ExitCode: DWORD;
  ExecuteFile, ParamString, StartInString: string;
begin
    try
      result := false;
      DebugToFile('Inside PuppySoldPuppyTracker method');
      (*
          #Return
          \\Workstation1\StoresApplication\StoreOnSitePostedSalePrintAll.exe" "--Return -ref 1"

          # Post Sale
          \\Workstation1\StoresApplication\StoreOnSitePostedSalePrintAll.exe" "--postsale -ref 1 -price 389.99 -services MChipBundL,AKCBundl -invoice 12345 -salesperson jimmy -first Darrell -last Offutt -address 123 no main -address2  -city webb city -state mo -zip 11223 -country usa -phone 111-222-3333 -email myemail@sbcglobal.net"

          if ( return ) then
               paramString := '-- Return -ref 1, '
          else
             paramString := '-- postsale -ref 1 - price';
      *)
//          FConnection := connection;
          OpenLocalSettings;
          ExecuteFile := FFileExeNameSale;
          ExecuteFile := '"'+ExecuteFile+'"';
          DebugToFile('file to execute -> ' + ExecuteFile);
          //paramString := inputBox('Complete exe path', 'Path', ExecuteFile);

          //mount run parameters
          paramString := getParamString(IdInvoice, IdPreSale, return);

          paramString := '"'+paramString+'"';
          DebugToFile('run parameters -> ' + paramString);

         // paramString := inputbox('Sale run parameter', 'Parameter', paramstring);

          FillChar(SEInfo, SizeOf(SEInfo), 0) ;
          SEInfo.cbSize       := SizeOf(TShellExecuteInfo) ;
          SEInfo.fMask        := SEE_MASK_NOCLOSEPROCESS;
          SEInfo.Wnd          := Application.Handle;
          SEInfo.lpFile       := PChar(ExecuteFile);
          SEInfo.lpParameters := PChar(paramString);
          SEInfo.nShow        := SW_SHOWNOACTIVATE;

          DebugToFile('call ShellExecute using execute file and run parameters');
          if ShellExecuteEx(@SEInfo) then begin
            repeat
              Application.ProcessMessages;
              GetExitCodeProcess(SEInfo.hProcess, ExitCode) ;
            until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
          end;
          result := true;
          DebugToFile('command executed with success -> (exit code) = ' + intToStr(exitCode));
   except
         on e: Exception do begin
            raise Exception.Create('Fail to  call ' + FFileExeNameSale + ', ExitCode = ' + IntToStr(ExitCode) + ': ' + e.Message);
            result := false;
         end;
   end;
end;


function TMRPuppyIntegration.getCategory(category: TCategoryType): Integer;
var
   qrySelect: TADOQUery;
   select, where: String;
begin
   try
      select := 'select IdGroup from TabGroup';
      where  := ' where upper(name) = :name';
      qrySelect := TADOQuery.Create(nil);
      qrySelect.Connection := FConnection;
      qrySelect.SQL.Text := select + where;

      case category of
         tcPet : qrySelect.Parameters.ParamByName('name').Value      := 'PETS';
         tcMicroChip: qrySelect.Parameters.ParamByName('name').Value := 'MICROCHIPS';
         tcService: qrySelect.Parameters.ParamByName('name').Value   := 'SERVICES';
      end;

      qrySelect.Open;
      if ( not qrySelect.IsEmpty ) then
        result := qrySelect.fieldByName('IdGroup').Value;
   finally
      freeAndNil(qrySelect);
   end;
end;


function TMRPuppyIntegration.getIndexService(line: String): Integer;
var
   i: Integer;
   index: Integer;
begin
   index := 0;
   for i:= 0 to length(line) - 1 do begin
      if ( pos(#9, line[i]) > 0 ) then
         inc(index);
   end;

   result := index;

end;


function TMRPuppyIntegration.GetNextCode(const TableName, FieldName: WideString; SQLConnection: TADOConnection): Integer;
var
  TableField: String;
  bEmpty : Boolean;
begin
  TableField := TableName + '.' + FieldName;

  try

    ///  Começa Novo
    with TADOQuery.Create(nil) do
    try
      Connection := SQLConnection;

      SQL.Text := ' SELECT UltimoCodigo FROM Sis_CodigoIncremental WITH (NOLOCK) WHERE Tabela = ' + QuotedStr(TableField);

      Open;
      bEmpty := IsEmpty;
      Result := FieldByName('UltimoCodigo').AsInteger + 1;

    finally
      Close;
      Free;
    end;

     //Cria o campo caso nao tenha
    if bEmpty then
      SQLConnection.Execute('INSERT Sis_CodigoIncremental (Tabela, UltimoCodigo) VALUES (' + QuotedStr(TableField) + ',0)');

    //Salva o proximo registro
    SQLConnection.Execute(' UPDATE  Sis_CodigoIncremental SET UltimoCodigo = UltimoCodigo + 1 '+
           ' FROM Sis_CodigoIncremental WHERE Tabela = ' + QuotedStr(TableField));

  except
    Result := -1;
  end;
end;

function TMRPuppyIntegration.AssignToServices(ref: String): boolean;
var
   newIdModel, newIdService: Integer;
   qryPuppyToMR: TADOQuery;
begin
    try
        try
           qryPuppyToMR := TADOQuery.Create(nil);
           qryPuppyToMR.Connection := FConnection;

           qryPuppyToMR.SQL.Text := 'select IdModel from Model where model =:model';
           qryPuppyToMR.Parameters.ParamByName('model').Value := ref;
           qryPuppyToMR.Open;
           newIdModel := qryPuppyToMR.fieldByname('IdModel').Value;

           FCdsServiceMap.Filter := 'Ref = ' + ref;
           FcdsServiceMap.Filtered := true;

           while ( not FCdsServiceMap.Eof ) do begin
                qryPuppyToMR.SQL.Text := 'select IdModel from model where model =:model and groupId =:group';
                qryPuppyToMR.Parameters.ParamByName('model').Value := FcdsServiceMap.fieldByname('service').Value;
                qryPuppyToMR.Parameters.ParamByName('group').Value := FPetServiceCategory;
                qryPuppyToMR.Open;

                if ( not qryPuppyToMR.IsEmpty ) then begin
                   newIdService := qryPuppyToMR.fieldByname('IdModel').Value;

                   FCdsServiceMap.Edit;
                   FCdsServiceMap.FieldByName('IdModel').Value := newIdService;
                   FCdsServiceMap.Post;
                end;
                FCdsServiceMap.Next;
           end;
        except
           result := false;
        end;
    finally
       FCdsServiceMap.Filter := '';
       FCdsServiceMap.Filtered := false;
       FCdsServiceMap.Last;
       freeAndNil(qryPuppyToMR);
    end;
end;

procedure TMRPuppyIntegration.setPetKitCategory(const Value: Integer);
begin
  FPetKitCategory := value;
end;

function TMRPuppyIntegration.createPuppy(ref, breed, description: String;
  cost, price: Currency): Integer;
var
   qryPuppyToMR: TADOQUery;
   select, join, where: String;
   field: TField;
   newIdModel, newIdInventory, idRefModel: Integer;
   found: Integer;
begin
   try
      try
        qryPuppyToMR := TADOQuery.Create(nil);
        qryPuppyToMR.Connection := FConnection;

        qryPuppyToMR.SQL.Text := 'select IdModel from Model where model =:ref';
        qryPuppyToMR.Parameters.ParamByName('ref').Value := ref;
        qryPuppyToMR.Open;

        // amfsouza May 06, 2013
        if ( not qryPuppyToMR.IsEmpty ) then begin
           idRefModel := qryPuppyToMR.fieldByname('IdModel').Value;
           result := idRefModel;
           exit;
        end;

        newIdModel := GetNextCode('Model', 'IdModel', FConnection);

        select := 'select IdModel from Model';
        join   := '';
        where  := ' where Idmodel =:param';
        found  :=  ( recordFound(select, join, where, newIdModel) );

        if ( found = -1  ) then begin
            // save puppy to MR
            qryPuppyToMR.SQL.Text :=
              'insert into model(IdModel, GroupID, Model, Description, SellingPrice, VendorCost, LastMovDate, ClasseABC, AvgCost,  TotQtyOnHand)' +
              ' values (:idmodel, :category, :model, :description, :price, :cost, :date, :classABC, :AvgCost, :TotQtyOnHand)';
            qryPuppyToMR.Parameters.ParamByName('idmodel').Value :=  newIdModel;
            qryPuppyToMR.Parameters.ParamByName('category').Value := FPetCategory;
            qryPuppyToMR.Parameters.ParamByName('model').Value := ref;
            qryPuppyToMR.Parameters.ParamByName('description').Value := description;
            qryPuppyToMR.Parameters.ParamByName('price').Value := price;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := cost;

            //amfsouza 11.10.2011
            qryPuppyToMR.Parameters.ParamByName('date').Value := now();

            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('Avgcost').Value := cost;
            qryPuppyToMR.Parameters.ParamByName('TotQtyOnHand').Value := 1;
            qryPuppyToMR.ExecSQL;


            newIdInventory := GetNextCode('Inventory', 'IdInventory', FConnection);

            //Inventory
            qryPuppyToMR.SQL.Text :=
             ' insert into Inventory(StoreID, ModelID, IdInventory, UltimaMovimentacao, SellingPrice, StoreCostPrice, ClassABC, qtyOnHand )' +
             ' values (:storeId, :modelId, :idinventory, :lastMov,  :sellingPrice, :cost, :classABC, :qtyOnHand) ';
            qryPuppyToMR.Parameters.ParamByName('storeId').Value := FStoreID;
            qryPuppyToMR.Parameters.ParamByName('modelId').Value := newIdModel;

            //amfsouza 11.10.2011
            qryPuppyToMR.Parameters.ParamByName('lastMov').Value := Now();

            qryPuppyToMR.Parameters.ParamByName('idinventory').Value := newIdInventory;
            qryPuppyToMR.Parameters.ParamByName('sellingprice').Value := price;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := cost;
            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('qtyOnHand').Value := 1;
            qryPuppyToMR.ExecSQL;

            result := newIdModel;
        end;
      except
          on e:Exception do begin
             result := -1;
             raise Exception.Create('Exception found in createPuppy method: ' + e.Message);
          end;
      end;
   finally
        freeAndNil(qryPuppyToMR);
   end;
end;

function TMRPuppyIntegration.createKit(ref, breed: String;  IdPuppy: Integer): Integer;
var
   qryPuppyToMR: TADOQUery;
   select, join, where: String;
   field: TField;
   newIdModel, newIdInventory, idRefModel: Integer;
   found: Integer;
   description: String[30];
begin
   try
      try

        description := Ref + '-Kit';

        qryPuppyToMR := TADOQuery.Create(nil);
        qryPuppyToMR.Connection := FConnection;

        newIdModel := GetNextCode('Model', 'IdModel', FConnection);

        select := 'select IdModel from Model m ';
        join   := '';
        where  := ' where m.model =:param';

        found  :=  ( recordFound(select, join, where, description) );

        if ( found = -1 ) then begin

            // create kit to MR
            qryPuppyToMR.SQL.Text :=
              'insert into model(IdModel, GroupID, Model, Description, SellingPrice, VendorCost, LastMovDate, ClasseABC, ModelType,  AvgCost,  TotQtyOnHand)' +
              ' values (:idmodel, :category, :model, :description, :price, :cost, :date, :classABC, :modeltype, :AvgCost, :TotQtyOnHand)';
            qryPuppyToMR.Parameters.ParamByName('idmodel').Value :=  newIdModel;
            qryPuppyToMR.Parameters.ParamByName('category').Value := FPetKitCategory;
            qryPuppyToMR.Parameters.ParamByName('model').Value := description;
            qryPuppyToMR.Parameters.ParamByName('description').Value := description;
            qryPuppyToMR.Parameters.ParamByName('price').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := 0;

            //amfsouza 11.10.2011
            qryPuppyToMR.Parameters.ParamByName('date').Value := Now();

            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('modeltype').Value := 'K';
            qryPuppyToMR.Parameters.ParamByName('Avgcost').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('TotQtyOnHand').Value := 1;
            qryPuppyToMR.ExecSQL;

            newIdInventory := GetNextCode('Inventory', 'IdInventory', FConnection);

            //Inventory
            qryPuppyToMR.SQL.Text :=
             ' insert into Inventory(StoreID, ModelID, IdInventory, UltimaMovimentacao, SellingPrice, StoreCostPrice, ClassABC, qtyOnHand )' +
             ' values (:storeId, :modelId, :idinventory, :lastDate,  :sellingPrice, :cost, :classABC, :qtyOnHand) ';
            qryPuppyToMR.Parameters.ParamByName('storeId').Value := FStoreID;
            qryPuppyToMR.Parameters.ParamByName('modelId').Value := newIdModel;
            qryPuppyToMR.Parameters.ParamByName('idinventory').Value := newIdInventory;

            qryPuppyToMR.Parameters.ParamByName('lastDate').Value := Now();

            qryPuppyToMR.Parameters.ParamByName('sellingprice').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('qtyOnHand').Value := 1;
            qryPuppyToMR.ExecSQL;


            // associate the kit to puppy
            qryPuppyToMR.SQL.Text := 'insert into PackModel (IdPackModel, IdModel, Qty) ' +
                                     ' values (:idkit, :idpuppy, :qty) ';
            qryPuppyToMR.Parameters.ParamByName('idkit').Value := newIdModel;
            qryPuppyToMR.Parameters.ParamByName('idpuppy').Value := IdPuppy;
            qryPuppyToMR.Parameters.ParamByName('qty').Value     := 1;
            qryPuppyToMR.ExecSQL;

            result := newIdModel;
        end
        else
           result := found;
      except
          on e:Exception do begin
             result := -1;
             raise Exception.create('Exception found in createKit method: ' + e.Message);
          end;
      end;
   finally
        freeAndNil(qryPuppyToMR);
   end;
end;


function TMRPuppyIntegration.getParamString(IdInvoice, IdPresale: Integer; refund: boolean): String;
var
  qryMRSale, qryPerson, qryPet, qryService: TADOQuery;
  runParameters: String;
  listServices: String;
  phone: String;
  puppy: String;
  price: String;
begin
   try
       try
          // pet
          qryPet    := TADOQuery.Create(nil);
          qryPet.Connection := FConnection;
          qryPet.SQL.Text :=
                          'select m.IdModel, m.GroupId ' +
                          'from Model m ' +
                          'join PT_GlobalSetting p on m.GroupID = p.IDPetCategory '+
                          'where m.IdModel = :idmodel';

          // service
          qryService    := TADOQuery.Create(nil);
          qryService.Connection := FConnection;
          qryService.SQL.Text :=
                          'select m.IdModel, m.GroupId ' +
                          'from Model m ' +
                          'join PT_GlobalSetting p on m.GroupID = p.IDServiceCategory ' +
                          'where m.IdModel = :idmodel';

          qryPerson := TADOquery.Create(nil);
          qryPerson.Connection := FConnection;
          qryPerson.SQL.Text := 'select SystemUser from SystemUser where IdUser = :iduser';


          qryMRSale := TADOQuery.Create(nil);
          qryMRSale.Connection := FConnection;
          qryMRSale.SQL.Text :=
            'select m.IDModel,  ' +
            ' m.Model,          ' +
            ' im.SalePrice,     ' +
            ' (im.SalePrice - im.discount) as price, ' +  // Antonio Feb 25, 2014
            ' im.DocumentID,    ' +
            ' c.FirstName,      ' +
            ' c.LastName,       ' +
            ' c.Address,        ' +
            ' c.City,           ' +
            ' C.State,          ' +
            ' c.Zip,            ' +
            ' c.Country,        ' +
            ' c.phoneareacode,  ' +
            ' c.Telefone,       ' +
            ' c.Email,          ' +
            ' m.groupId,        ' +
            ' tg.IDGroup,       ' +
            ' im.IDUser         ' +
            'from Invoice i '+
            'join InventoryMov im on im.DocumentID = i.IdInvoice '+
            'join Model m on im.ModelId = m.IdModel ' +
            'join TabGroup tg on m.GroupID = tg.IDGroup  ' +
            'join vwPessoa c on i.idCustomer = c.idPessoa ' + // Antonio 2014 Jan 13, MR-163
            'where i.IDPresale = :idpresale';

          qryMRSale.Parameters.ParamByName('idpresale').Value := IdPresale;
          qryMRSale.Open;

          //get puppy
          qryMRSale.First;
          while ( not qryMRSale.Eof ) do begin
              qryPet.Close;
              qryPet.parameters.parambyname('idmodel').value := qryMRSale.fieldByname('idmodel').value;
              qryPet.open;

              if ( not qrypet.IsEmpty ) then begin
                 // Antonio, Oct 19, 2013 - MR-66
                 puppy := trim(stringReplace(qryMRSale.fieldByname('model').asString, 'PET', '',  [rfReplaceAll, rfIgnoreCase]));

                 // Antonio Feb 24, 2014
                 price := qryMRSale.fieldByname('price').AsString;
                 break;
              end;

              qryMRSale.Next;
          end;

          //get service
          qryMRSale.First;
          while ( not qryMRSale.Eof ) do begin
              qryService.Close;
              qryService.parameters.parambyname('idmodel').value := qryMRSale.fieldByname('idmodel').value;
              qryService.open;

              if ( not qryService.IsEmpty ) then begin
                 if ( listServices <> '' ) then
                     // Antonio, 2013 Nov 12 - (MR-66/MR-103)
                     listServices := listServices + ',' + qryMRSale.fieldByName('model').AsString
                 else
                     // Antonio, 2013 Nov 12, (MR-66/MR-103)
                     listServices := qryMRSale.fieldByName('model').AsString;
              end;

              qryMRSale.Next;
          end;

          runParameters := '--postsale -ref ' + puppy;
          runParameters := runParameters + ' -price ' + price;

          runParameters := runParameters + ' -services ' + listServices;

          runParameters := runParameters + ' -invoice ' + qryMRSale.fieldByName('DocumentID').AsString;

          qryPerson.Parameters.ParamByName('iduser').Value := qryMRSale.fieldByName('IdUser').Value;
          qryPerson.Open;

          runParameters := runParameters + ' -salesperson ' + qryPerson.fieldByName('SystemUser').AsString;
          runParameters := runParameters + ' -first ' + qryMRSale.fieldByname('FirstName').AsString;
          runParameters := runParameters + ' -last ' + qryMRSale.fieldByname('LastName').AsString;
          runParameters := runParameters + ' -address ' + qryMRSale.fieldByname('Address').AsString;
          runParameters := runParameters + ' -address2 ' + '';
          runParameters := runParameters + ' -city ' + qryMRSale.fieldByname('city').AsString;
          runParameters := runParameters + ' -state ' + qryMRSale.fieldByname('state').AsString;
          runParameters := runParameters + ' -zip ' + qryMRSale.fieldByname('zip').AsString;
          runParameters := runParameters + ' -country ' + qryMRSale.fieldByname('country').AsString;

          //amfsouza 04.27.2012 - under test... verifying parenthesis
          phone := qryMRSale.fieldbyName('phoneareacode').AsString + ' ' + qryMRSale.fieldbyName('telefone').AsString;

          runParameters := runParameters + ' -phone ' + phone;
          runParameters := runParameters + ' -email ' + qryMRSale.fieldByname('email').AsString;

          if ( refund ) then begin
             runParameters := '--return -ref ' + puppy;
          end;

          result := runParameters;

       except
           on e: exception do begin
              Result := '';
              raise Exception.Create('Failed to prepare run parameters ' + e.Message);
           end;
       end;

   finally
       freeAndNil(qryMRSale);
       freeAndNil(qryPerson);
       freeAndNil(qryPet);
       freeAndNil(qryService);
   end;

end;

procedure TMRPuppyIntegration.OpenLocalSettings;
var
  qryLocal: TADOQuery;
begin
  try
     try
        qryLocal := TADOQuery.Create(nil);
        qryLocal.Connection := FConnection;
        qryLocal.SQL.Text := 'select * from PT_LocalSetting where MacAddress =:address';
        qryLocal.Parameters.ParamByName('address').Value := Get_MACAddress;
        qryLocal.Open;

        if ( not qryLocal.IsEmpty ) then begin
           FFileExeNameSale      := qryLocal.fieldByname('PathToSaleExec').AsString;
           FFileExeName360Import := qryLocal.fieldByName('PathToAvail').AsString;
           // frequency pet avail
        end
(*        else
           Application.MessageBox('Local settings not found', 'Local Settings', mb_OK + MB_ICONWARNING);
*)   except
        raise;
     end;
  finally
     freeAndNil(qryLocal);
  end;
end;

procedure TMRPuppyIntegration.setPetServiceCategory(const Value: Integer);
begin
  FPetServiceCategory := value;
end;

function TMRPuppyIntegration.ValidateMicroChip(microchip: String): boolean;
type
   TDigitNumber = set of '0'..'9';
   TDigitLetter = set of 'A'..'F';
var
   digitNumber: TDigitNumber;
   digitLetter: TDigitLetter;
   i: Integer;
   validNumber: boolean;
   validLetter: boolean;
   onlyNumber: String;
   onlyLetter: String;
begin

   digitNumber := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
   digitLetter := ['A', 'B', 'C', 'D', 'E', 'F']; 

   if pos('.', microchip ) <> 0 then begin
      result := false;
      exit;
   end;



   //get digit stands number (0..9)
   i := 0;
   while i < Length(microchip) - 1 do begin
       if ( microchip[i] in digitNumber ) then
          onlyNumber := onlyNumber + microchip[i];
       inc(i);
   end;

   //get digit stands letter (A...F)
   i := 0;
   while i < Length(microchip) - 1 do begin
       if ( microchip[i] in digitLetter ) then
          onlyLetter := onlyLetter + microchip[i];
       inc(i);
   end;

   //validate number
   if ( onlyNumber <> '' ) then begin
       for i:= 1 to Length(onlyNumber) do
           validNumber := (onlyNumber[i] in digitNumber );
   end;


   //validate letter
   if ( onlyLetter <> '' ) then begin
       for i:= 1 to Length(onlyLetter) do
           validLetter := ( onlyLetter[i] in digitLetter );
   end;

   if ( (onlyNumber <> '') and (onlyLetter = '')  ) then
      result := validNumber
   else if ( (onlyNumber = '') and (onlyLetter <> '') ) then
           result := validLetter
   else if ( (onlyNumber <> '') and (onlyLetter <> '') ) then
           result := validNumber and validLetter;
end;

function TMRPuppyIntegration.getPhoneNumber(areaCode,
  phone: String): String;
begin
  result := phone; // by default
//  if ( areaCode = '' ) then begin


//  end;

end;

function TMRPuppyIntegration.RunAsAdminAndWaitForCompletion(psFileName,
  psParameters: String): Boolean;
Var
  ShellInformation : TShellExecuteInfo;
  ExitCode: DWORD;
  Handle: THandle;

Begin

//  If ( WinVersion() = 'WindowsXP' )  Then Begin

    CreateWindowsProcessAsUser( psFileName + ' ' + psParameters,
                                'Pinogy',
                                'IHittgv!',
                                False );

//  End;

  debugtofile('schedule = ' + psFileName + ' ' + psParameters);

  ZeroMemory(@ShellInformation, SizeOf(ShellInformation));

  ShellInformation.cbSize := SizeOf(TShellExecuteInfo);
  ShellInformation.Wnd    := Handle;
  ShellInformation.fMask  := ( SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS );

  If ( Pos( '.MSI', psFileName ) > 0 )
  Then ShellInformation.lpVerb := PChar('OPEN')
  Else ShellInformation.lpVerb := PChar('RUNAS');

  ShellInformation.lpFile := PChar( psFileName );
  ShellInformation.nShow  := SW_HIDE;

  If ( psParameters <> '' ) Then ShellInformation.lpParameters := PChar( psParameters );

  If   ShellExecuteEx( @ShellInformation ) then begin

    Repeat

      Application.ProcessMessages;
      GetExitCodeProcess( ShellInformation.hProcess, ExitCode );

    Until ( (ExitCode <> STILL_ACTIVE) Or ( Application.Terminated ) );

  End;

  Result := ( ExitCode = 0 );

  if ( result ) then
      debugtofile('there is a schedule to puppy');

end;

function TMRPuppyIntegration.ReturnWindowsFolder(
  piFolderId: Integer): String;
Var
  P : Array[0..MAX_PATH] of char;
  ProgramFilesDir: string;
  iFolderId : Integer;
Begin

  iFolderId := CSIDL_PROGRAM_FILES;
  If ( piFolderId > 0 ) Then iFolderId := piFolderId;

  if SHGetFolderPath(0,   iFolderId, 0,0, @P[0]) = S_OK then
    ProgramFilesDir := P
  else
    ProgramFilesDir := 'C:\Program Files';

   Result := ProgramFilesDir;

end;

function TMRPuppyIntegration.createWindowsService(puppyTrackerServer: boolean): boolean;
var
  sCommandText: String;
begin
    If ( WinVersion() = 'Windows7' ) Then begin
        sCommandText       := ReturnWindowsFolder( CSIDL_SYSTEM ) + '\SCHTASKS.EXE';
        debugTofile('W7 = ' + sCommandText);
    end
    Else begin
      sCommandText       := ReturnWindowsFolder() + '\MAINRETAIL\SCHTASKS.EXE';
      debugTofile('another OS = ' + sCommandText);
    end;


    if ( puppyTrackerServer ) then begin
        debugtofile('is puppy tracker server');
        //delete windows service if already exists

        RunAsAdminAndWaitForCompletion( '"'+sCommandText+'"', '/DELETE /TN "MR-PT Integration"            /F ' );

        (*
        // to future - daily
        RunAsAdminAndWaitForCompletion( sCommandText, '/CREATE /TN "MR-PT Integration" /TR "'+
            ReturnWindowsFolder() + '\MAINRETAIL\MAINRETAIL.EXE --Import_PT" /RU SYSTEM /SC DAILY /ST 23:01:00 ' );
        *)

        // (in use ) create a windows service
(*
"C:\Program Files\MAINRETAIL\SCHTASKS.EXE" /CREATE /TN "MR-PT Integration"
/TR "\"C:\Program Files\MAINRETAIL\MAINRETAIL.EXE\"
--Import_PT" /RU Pinogy -RP IHittgv! /SC HOURLY /ST 08:35:00
*)

        RunAsAdminAndWaitForCompletion( '"'+sCommandText+'"', '/CREATE /TN "MR-PT Integration" /TR "'+'\'+'"' +
              ReturnWindowsFolder() + '\MAINRETAIL\MAINRETAIL.EXE\" --import_PT" /RU Pinogy -RP IHittgv! /SC HOURLY /ST 08:35:00');

    end;
(*
    else
        //delete windows service if already exists
        RunAsAdminAndWaitForCompletion( sCommandText, '/DELETE /TN "MR-PT Integration"            /F ' );
*)
end;

function TMRPuppyIntegration.WinVersion: string;
var
  VersionInfo: TOSVersionInfo;
begin

  Result:='';

  VersionInfo.dwOSVersionInfoSize:=SizeOf(VersionInfo);

  GetVersionEx(VersionInfo);
  case VersionInfo.dwPlatformId of
    1:
      case VersionInfo.dwMinorVersion of
         0: Result:='Windows95';
        10: Result:='Windows98';
        90: Result:='WindowsMe';
      end;
    2:
      case VersionInfo.dwMajorVersion of
        3: Result:='WindowsNT3.51';
        4: Result:='WindowsNT4.0';
        5: case VersionInfo.dwMinorVersion of
            0: Result:='Windows2000';
            1: Result:='WindowsXP';
           end;
        6: Result:='Windows7';
      end;
  end;

  if (Result='') then
    Result:='Windows version not recognized. '+ #13 + #13 +
            'Plataform     = ' + IntToStr( VersionInfo.dwPlatformId )   +
            'Major Version = ' + IntToStr( VersionInfo.dwMajorVersion ) +
            'Minor Version = ' + IntToStr( VersionInfo.dwMinorVersion );
end;

function TMRPuppyIntegration.CreateWindowsProcessAsUser(psCommandLine,
  psUsername, psUserPassword: String; pbShowOnScreen: Boolean): Integer;
Const
  LOGON_WITH_PROFILE        = 1;
  LOGON_NETCREDENTIALS_ONLY = 2;

Var

  wsUsername,
  wsDomain,
  wsPassword,
  wsCommandLine : WideString;

  pwsUsername,
  pwsDomain,
  pwsPassword,
  pwsCommandLine: PWideChar;

  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;
Begin

  wsUsername     := psUsername;
  wsDomain       := '';
  wsPassword     := psUserPassword;
  wsCommandLine  := psCommandLine;

  pwsUsername    := Addr( wsUsername[1] );
  pwsDomain      := Addr( wsDomain[1] );
  pwsPassword    := Addr( wsPassword[1] );
  pwsCommandLine := Addr( wsCommandLine[1] );

  FillChar( StartupInfo, SizeOf( TStartupInfo ), 0 );

  StartupInfo.cb      := SizeOf( TStartupInfo );
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  If ( pbShowOnScreen = True )
  Then StartupInfo.wShowWindow := 1
  Else StartupInfo.wShowWindow := 0;

  If Not CreateProcessWithLogon( pwsUsername,
                                 pwsDomain,
                                 pwsPassword,
                                 LOGON_WITH_PROFILE,
                                 nil,
                                 pwsCommandLine,
                                 CREATE_DEFAULT_ERROR_MODE,
                                 nil,
                                 nil,
                                 StartupInfo,
                                 ProcessInfo )
  Then Begin
    debugtofile('process is not created');

    Result := -1;
    RaiseLastOSError;

  End Else Begin

    WaitforSingleObject( ProcessInfo.hProcess, INFINITE );

    CloseHandle( ProcessInfo.hThread );
    CloseHandle( ProcessInfo.hProcess );

    Result := 0;

    debugtofile('process have been created');

  End;


end;

function TMRPuppyIntegration.UpdateKit(IdKit: Integer; description: String; cost, price: Currency): boolean;
var
   qryPuppyToMR: TADOQUery;
   IdInventory: Integer;
begin
   try
      try
        result := false;

        qryPuppyToMR := TADOQuery.Create(nil);
        qryPuppyToMR.Connection := FConnection;

        // Kit to puppy
        qryPuppyToMR.SQL.Text :=
          'update model set GroupID =:category, Description =:description, SellingPrice =:price, VendorCost =:cost, LastMovDate =:date, classeABC =:classABC' +
          ' where Idmodel =:idmodel ';
        qryPuppyToMR.Parameters.ParamByName('idmodel').Value := IdKit;
        qryPuppyToMR.Parameters.ParamByName('description').Value := description;
        qryPuppyToMR.Parameters.ParamByName('price').Value := 0;
        qryPuppyToMR.Parameters.ParamByName('cost').Value := 0;
        qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
        qryPuppyToMR.Parameters.ParamByName('category').Value := FPetKitCategory;
        qryPuppyToMR.Parameters.ParamByName('date').Value := now();
        qryPuppyToMR.ExecSQL;

        //Inventory
        qryPuppyToMR.SQL.Text :=
        'select m.IdModel, I.IdInventory '+
        'from Inventory I '+
        'join Model m on I.ModelID = m.IDModel '+
        'where i.ModelId =:idmodel and i.StoreId =:storeId ';

        qryPuppyToMR.Parameters.ParamByName('idmodel').Value := IdKit;
        qryPuppyToMR.Parameters.ParamByName('storeId').Value := FStoreID;

        qryPuppyToMR.Open;

        if ( not qryPuppyToMR.IsEmpty ) then begin

            IdInventory := qryPuppyToMR.fieldByName('IdInventory').Value;

            qryPuppyToMR.SQL.Text :=
             ' update Inventory set SellingPrice =:sellingPrice, StoreCostPrice =:cost, classABC =:classABC, '+
             ' qtyOnHand =:qtyOnHand, UltimaMovimentacao =:date ' +
             ' where ModelId =:modelId and StoreId =:storeId and IdInventory =:IdInventory';
            qryPuppyToMR.Parameters.ParamByName('storeId').Value := FStoreID;
            qryPuppyToMR.Parameters.ParamByName('modelId').Value := IdKit;
            qryPuppyToMR.Parameters.ParamByName('sellingprice').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('qtyOnHand').Value := 1;
            qryPuppyToMR.Parameters.ParamByName('IdInventory').Value := IdInventory;
            qryPuppyToMR.Parameters.ParamByName('date').Value := now();

            qryPuppyToMR.ExecSQL;
        end;

        result := true;

      except
          on e:Exception do begin
             result := false;
             raise;
          end;
      end;
   finally
        freeAndNil(qryPuppyToMR);
   end;
end;

function TMRPuppyIntegration.UpdatePuppy(IdPuppy: Integer; breed, description: String; cost, price: Currency): boolean;
var
   qryPuppyToMR: TADOQUery;
   idInventory: Integer;
begin
   try
      try
        result := false;
        qryPuppyToMR := TADOQuery.Create(nil);
        qryPuppyToMR.Connection := FConnection;

        qryPuppyToMR.SQL.Text :=
          'update model set GroupID =:category, Description =:description, SellingPrice =:price, VendorCost =:cost, LastMovDate =:date, classeABC =:classABC' +
          ' where Idmodel =:idmodel ';

        qryPuppyToMR.Parameters.ParamByName('idmodel').Value := IdPuppy;
        qryPuppyToMR.Parameters.ParamByName('description').Value := description;
        qryPuppyToMR.Parameters.ParamByName('price').Value := price;
        qryPuppyToMR.Parameters.ParamByName('cost').Value := cost;
        qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
        qryPuppyToMR.Parameters.ParamByName('category').Value := FPetCategory;
        qryPuppyToMR.Parameters.ParamByName('date').Value := now();

        qryPuppyToMR.ExecSQL;

        //Inventory
        qryPuppyToMR.SQL.Text :=
        'select m.IdModel, I.IdInventory '+
        'from Inventory I '+
        'join Model m on I.ModelID = m.IDModel '+
        'where I.ModelId =:idmodel and I.StoreId =:storeid';

        qryPuppyToMR.Parameters.ParamByName('idmodel').Value := IdPuppy;
        qryPuppyToMR.Parameters.ParamByName('storeid').Value := FStoreID;
        qryPuppyToMR.Open;

        if ( not qryPuppyToMR.IsEmpty ) then begin
            IdInventory := qryPuppyToMR.fieldByName('IdInventory').Value;

            qryPuppyToMR.SQL.Text :=
             ' update Inventory set  SellingPrice =:sellingPrice, StoreCostPrice =:cost, classABC =:classABC, '+
             ' qtyOnHand =:qtyOnHand, UltimaMovimentacao =:date ' +
             ' where ModelId =:modelId and StoreId =:storeId and IdInventory =:IdInventory';
            qryPuppyToMR.Parameters.ParamByName('storeId').Value := FStoreID;
            qryPuppyToMR.Parameters.ParamByName('modelId').Value := IdPuppy;
            qryPuppyToMR.Parameters.ParamByName('sellingprice').Value := price;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := cost;
            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('qtyOnHand').Value := 1;
            qryPuppyToMR.Parameters.ParamByName('IdInventory').Value := IdInventory;
            qryPuppyToMR.Parameters.ParamByName('date').Value := now();
            qryPuppyToMR.ExecSQL;
        end;
        result := true;

      except
          on e:Exception do begin
             result := false;
             raise Exception.Create('Exception found in updatePuppy method: ' +e.Message);
          end;
      end;
   finally
        freeAndNil(qryPuppyToMR);
   end;
end;

function TMRPuppyIntegration.verifyPuppyInPetCategory(
  ref: String): Integer;
var
  qry: TADOQuery;
  sql: String;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := FConnection;

    result := -1;

    sql :=
      'select m.IdModel ' +
      'from Model m ' +
      'join TabGroup t on m.GroupID = t.IDGroup ' +
      'where  t.PuppyTracker = 1 ' +
      '   and t.packmodel = 0 ' +
      '   and t.service = 0 ' +
      '   and m.model = :ref ';

     qry.SQL.Text := sql;
     qry.Parameters.ParamByName('ref').Value := ref;
     qry.Open;

     if ( not qry.IsEmpty ) then
        result := qry.fieldbyname('Idmodel').Value;

  finally
    freeAndNil(qry);
  end;

end;


function TMRPuppyIntegration.UpdateService(idService, idPuppy, idKit: Integer ; description: String; cost, price: Currency): boolean;
var
  qryPuppyToMR: TADOQuery;
  idInventory: Integer;
begin
   try
     try
        qryPuppyToMR := TADOQuery.Create(nil);
        qryPuppyToMR.Connection := FConnection;

        // Service to puppy
        qryPuppyToMR.SQL.Text :=
          'update model set GroupID =:category, Description =:description, SellingPrice =:price, VendorCost =:cost, LastMovDate =:date, classeABC =:classABC' +
          ' where Idmodel =:idmodel ';

        qryPuppyToMR.Parameters.ParamByName('idmodel').Value := idService;
        qryPuppyToMR.Parameters.ParamByName('description').Value := description;
        qryPuppyToMR.Parameters.ParamByName('price').Value := 0;
        qryPuppyToMR.Parameters.ParamByName('cost').Value := 0;
        qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
        qryPuppyToMR.Parameters.ParamByName('category').Value := FPetServiceCategory;
        qryPuppyToMR.Parameters.ParamByName('date').Value := now();
        qryPuppyToMR.ExecSQL;

        //Inventory
        qryPuppyToMR.SQL.Text :=
        'select m.IdModel, I.IdInventory '+
        'from Inventory I '+
        'join Model m on I.ModelID = m.IDModel '+
        'where I.ModelId =:idmodel and I.StoreId =:storeid';

        qryPuppyToMR.Parameters.ParamByName('idmodel').Value := IdService;
        qryPuppyToMR.Parameters.ParamByName('storeid').Value := FStoreID;

        qryPuppyToMR.Open;
        if ( not qryPuppyToMR.IsEmpty ) then begin
            IdInventory := qryPuppyToMR.fieldByName('IdInventory').Value;

            qryPuppyToMR.SQL.Text :=
             ' update Inventory set SellingPrice =:sellingPrice, StoreCostPrice =:cost, classABC =:classABC, '+
             ' qtyOnHand =:qtyOnHand, UltimaMovimentacao =:date ' +
             ' where ModelId =:modelId and StoreId =:storeId and IdInventory =:IdInventory';
            qryPuppyToMR.Parameters.ParamByName('storeId').Value := FStoreID;
            qryPuppyToMR.Parameters.ParamByName('modelId').Value := IdService;
            qryPuppyToMR.Parameters.ParamByName('sellingprice').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('cost').Value := 0;
            qryPuppyToMR.Parameters.ParamByName('classABC').Value := 'E';
            qryPuppyToMR.Parameters.ParamByName('qtyOnHand').Value := 1;
            qryPuppyToMR.Parameters.ParamByName('IdInventory').Value := IdInventory;
            qryPuppyToMR.Parameters.ParamByName('date').Value := now();
            qryPuppyToMR.ExecSQL;

            // associate the kit to service
            qryPuppyToMR.SQL.Text :=
            'select Idmodel from PackModel where IdModel =:idservice and IdPackModel =:idKit';
            qryPuppyToMR.Parameters.ParamByName('idservice').Value := idService;
            qryPuppyToMR.Parameters.ParamByName('idkit').Value := idKit;

            qryPuppyToMR.Open;

            if ( qryPuppyToMR.IsEmpty ) then begin
                qryPuppyToMR.SQL.Text := 'insert into PackModel (IdPackModel, IdModel, Qty) ' +
                                         ' values (:idkit, :idservice, :qty) ';
                qryPuppyToMR.Parameters.ParamByName('idkit').Value := idKit;
                qryPuppyToMR.Parameters.ParamByName('idservice').Value := IdService;
                qryPuppyToMR.Parameters.ParamByName('qty').Value     := 1;
                qryPuppyToMR.ExecSQL;

                //amfsouza 10.25.2011 - update ServiceMap, inserting IdModel
                FCdsServiceMap.Edit;
                FcdsServiceMap.FieldByName('IdModel').Value := IdService;
                FCdsServiceMap.Post;

            end;
        end;
        result := true;
     except

     end;
   finally
       freeAndNil(qryPuppyToMR);
   end;
end;

function TMRPuppyIntegration.verifyService(IdKit: Integer): Integer;
var
  qry: TADOQuery;
  sql: String;
  IdService: Integer;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := FConnection;

    result := -1;

    sql := 'select IdModel from PackModel where IdPackModel =:kit';
    qry.SQL.Text := sql;
    qry.Parameters.ParamByName('kit').Value := idKit;
    qry.Open;

    idService := qry.fieldByName('IdModel').Value;

    sql :=
      'select m.IdModel ' +
      'from Model m ' +
      'join TabGroup t on m.GroupID = t.IDGroup ' +
      'where  t.PuppyTracker = 1 ' +
      '   and t.service = 1 ' +
      '   and m.Idmodel = :idservice ';

     qry.SQL.Text := sql;
     qry.Parameters.ParamByName('idservice').Value := IdService;
     qry.Open;

     if ( not qry.IsEmpty ) then
        result := qry.fieldbyname('Idmodel').Value;

  finally
    freeAndNil(qry);
  end;

end;

function TMRPuppyIntegration.UpdateMicrochip(IdPuppy, IdKit: Integer; ref: String): boolean;
var
   qryPuppyToMR: TADOQUery;
   select, join, where: String;
   field: TField;
   IdModel, newIdKit, newIdPack, newIdMicroChip: Integer;
   i, k: Integer;
   found: Integer;
begin
   try
      try
        qryPuppyToMR := TADOQuery.Create(nil);
        qryPuppyToMR.Connection := FConnection;

        // Microchip
        FCdsMicroChip.Filter := 'Model = ' + ref;
        FCdsMicroChip.Filtered := true;
        i:= 0;
        while ( not FCdsMicrochip.Eof ) do begin
            try
                (* must be a method *)
                //associate barcode to kit
                select := 'select IdBarcode, IdModel from barcode';
                join   := '';
                where  := ' where IdBarcode =:param and IdModel = ' + intToStr(IdKit);

                qryPuppyToMR.SQL.Text := select + join + where;
                qryPuppyToMR.Parameters.ParamByName('param').Value := FCdsMicrochip.FieldByName('Microchip').Value;
                qryPuppyToMR.Open;

                if ( not qryPuppyToMR.IsEmpty ) then
                   IdModel := qryPuppyToMR.fieldByName('IdModel').Value;

                found  :=  ( recordFound(select, join, where, FCdsMicrochip.FieldByName('Microchip').Value) );

                if ( found  = -1 ) then begin
                   qryPuppyToMR.SQL.Text := 'delete from barcode where IdBarcode =:barcode';
                   qryPuppyToMR.Parameters.ParamByName('barcode').Value := FCdsMicroChip.fieldByName('Microchip').Value;
                   qryPuppyToMR.ExecSQL;
                end;

                inc(i);
                qryPuppyToMR.SQL.Text := 'insert into barcode (IdBarcode, IdModel, Data, BarcodeOrder, Qty) values(:idbarcode, :idmodel, :date, :order, :qty)';
                qryPuppyToMR.Parameters.ParamByName('idbarcode').Value := FCdsMicroChip.fieldByName('Microchip').Value;
                qryPuppyToMR.Parameters.ParamByName('idmodel').Value := IdKit;
                qryPuppyToMR.Parameters.ParamByName('date').Value := now;
                qryPuppyToMR.Parameters.ParamByName('order').Value := FCdsMicroChip.RecNo;
                qryPuppyToMR.Parameters.ParamByName('qty').Value := NULL;
                qryPuppyToMR.ExecSQL;

                //associate microchip to pet_microchip. I have to associate with model, instead kit.
                newIdMicroChip := GetNextCode('Pet_Microchip', 'IDMicrochip', FConnection);
                qryPuppyToMR.SQL.Text := 'insert into Pet_Microchip (IdMicrochip, Microchip, Amount, System, Hidden, Desativado, IdModel ) ' +
                                      ' values (:id, :microchip, :amount, :system, :hidden, :disable, :idkit )';
                qryPuppyToMR.Parameters.ParamByName('id').Value := newIdMicroChip;
                qryPuppyToMR.Parameters.ParamByName('microchip').Value := FCdsMicroChip.fieldByName('Microchip').Value;
                qryPuppyToMR.Parameters.ParamByName('amount').Value := 0;
                qryPuppyToMR.Parameters.ParamByName('system').Value := 0;
                qryPuppyToMR.Parameters.ParamByName('hidden').Value := 0;
                qryPuppyToMR.Parameters.ParamByName('disable').Value := 0;
                qryPuppyToMR.Parameters.ParamByName('idkit').Value := IdKit; //model, not kit.
                qryPuppyToMR.ExecSQL;

                FcdsMicroChip.Next;
            except
                FCdsMicroChip.Next;
            end;
        end;

      except
          on e:Exception do begin
             raise;
          end;
      end;
   finally
        freeAndNil(qryPuppyToMR);
   end;
end;

function TMRPuppyIntegration.getMacAddress: String;
begin
   result := Get_MACAddress;
end;

function TMRPuppyIntegration.DealingMicrochips(IdPuppy, IdKit: Integer;
  ref: String): boolean;
var
   idBarcode: String;
   sql: String;
begin
    try
      //get ther services to one puppy
      FCdsMicroChip.Filter := 'Model = ' + ref;
      FCdsMicroChip.Filtered := true;

      // to each service seek in barcode
      while ( not FCdsMicroChip.Eof ) do begin

          idBarcode := microchipFound(FCdsMicroChip.fieldByname('microchip').Value);

          if ( idBarcode = 'no_barcode' ) then begin
             addMicrochipToBarcode(FCdsMicroChip.fieldByname('microchip').Value,
                                   idkit, FCdsMicroChip.RecNo);
          end
          else begin
              deleteMicrochip(idBarcode);
              addMicrochipToBarcode(FCdsMicroChip.fieldByname('microchip').Value,
                                   idkit, FCdsMicroChip.RecNo);
          end;

          FCdsMicroChip.Next;
      end;
    except
        on e:Exception do begin
           raise Exception.Create('Exception found in dealingMicrochips: ' + e.message) ;
        end;
    end;
end;

function TMRPuppyIntegration.DealingServices(ref: String; idPuppy,
  idKit: Integer; cost, price: Currency): boolean;
var
   idService: Integer;
   idModel: Integer;
   isModelExists: Boolean;
begin
   debugToFile('Inside DealingServices-begin');

   //get ther services to one puppy. ref means puppy in servicemap list.
   FCdsServiceMap.Filter := 'Ref = ' + ref;
   FcdsServiceMap.Filtered := true;

   debugToFile('Filter to Service Map Started to Ref = ' + ref);
   debugToFile('Loop for ServiceMaps - begin');

   try
       while ( not FCdsServiceMap.Eof ) do begin
            debugToFile('Looking for service');

            isModelExists := modelFound(idModel, fcdsServiceMap.fieldByName('service').AsString, tcOther);

            if ( isModelExists ) then begin
               if ( modelFound(idModel, fcdsServiceMap.fieldByName('service').AsString, tcService ) ) then begin
                  UpdateService(idModel, idPuppy, idKit, fcdsServiceMap.fieldByName('service').AsString, cost, price);
                  FCdsServiceMap.Edit;
                  FCdsServiceMap.FieldByName('IdModel').Value := idService;
                  FCdsServiceMap.Post;
               end
               else begin
                  renameModel((ref+'_ptrename'), idModel);
                  idService := createService(fcdsServiceMap.fieldByName('Service').AsString);
               end;
            end
            else begin
               idService := createService(fcdsServiceMap.fieldByName('Service').AsString);
            end;

            if ( not serviceFoundInKit(idKit, idService) ) then
               addServiceToKit(idKit, idService);

            FCdsServiceMap.Next;
       end;
   except
       on e: Exception do begin
          raise Exception.Create('Exception found in dealingServices method: ' + e.Message)
       end;
   end;

   debugToFile('Loop for ServiceMaps - end');
   debugToFile('Inside DealingServices-end');

end;

function TMRPuppyIntegration.verifyPuppyInPetCategory(idModel: Integer): boolean;
var
  qry: TADOQuery;
  sql: String;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := FConnection;

    result := false;

    sql :=
      'select m.IdModel ' +
      'from Model m ' +
      'join TabGroup t on m.GroupID = t.IDGroup ' +
      'where  t.PuppyTracker = 1 ' +
      '   and t.packmodel = 0 ' +
      '   and t.service = 0 ' +
      '   and m.Idmodel = :idmodel ';

    qry.SQL.Text := sql;
    qry.Parameters.ParamByName('idmodel').Value := idModel;
    qry.Open;

    result := ( not qry.IsEmpty )

  finally
     freeAndNil(qry);
  end;

end;

procedure TMRPuppyIntegration.activateKitIfNotAvailable(
  petKitSelected: Integer);
var
   qry: TADOQuery;
begin
   try
     qry := TADOQuery.Create(nil);
     qry.Connection := FConnection;
     qry.SQL.Add('update TabGroup set desativado = 0 where IdGroup =:kitselected');
     qry.Parameters.ParamByName('kitselected').Value := petKitSelected;
     qry.ExecSQL;
   finally
     freeAndNil(qry);
   end;
end;

procedure TMRPuppyIntegration.activateServiceIfNotAvailable(
  petServiceSelected: Integer);
var
   qry: TADOQuery;
begin
   try
     qry := TADOQuery.Create(nil);
     qry.Connection := FConnection;
     qry.SQL.Add('update TabGroup set desativado = 0 where IdGroup =:serviceselected');
     qry.Parameters.ParamByName('serviceselected').Value := petServiceSelected;
     qry.ExecSQL;
   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.getDataDealt(tabPosition: Integer; line: String ): String;
var
   i: Integer;
   text: String;
begin
   result := '';
   i := tabPosition - 1;
   while ( (i >= 0) and (line[i] <> chr(9)) and (line[i] <> #0) )  do begin
        text := text + line[i];
        dec(i);
   end;

   text := ReverseString(text);
   result := text;

end;

function TMRPuppyIntegration.getMapToSplittedLine(complete_line: String): TStringList;
var
   line: TStringList;
   i: Integer;
   column: Integer;
begin
   column := 0;
   line := TStringList.Create();
   for i := 0 to ( length(complete_line) - 1 ) do begin
       if ( complete_line[i] = chr(9) ) then begin
          line.Add( intToStr(column) + ',' + intToStr(i) );
          FListValidColumn.Add(intToStr(column));
          inc(column);
       end;
   end;
   result := line;
end;


procedure TMRPuppyIntegration.openGlobalSettings;
var
  qryGlobal: TADOQuery;
begin
  try
     try
        qryGlobal := TADOQuery.Create(nil);
        qryGlobal.Connection := FConnection;
        qryGlobal.SQL.Text := 'select * from PT_GlobalSetting';
        qryGlobal.Open;

        if ( not qryGlobal.IsEmpty ) then begin
           FPetCategory        := qryGlobal.fieldByname('IdPetCategory').AsInteger;
           FPetKitCategory     := qryGlobal.fieldByName('IdKitCategory').AsInteger;
           FPetServiceCategory := qryGlobal.fieldByname('IdServiceCategory').AsInteger;
        end
(*        else
           Application.MessageBox('Local settings not found', 'Local Settings', mb_OK + MB_ICONWARNING);
*)   except
        raise;
     end;
  finally
     freeAndNil(qryGlobal);
  end;
end;

function TMRPuppyIntegration.getKitUsingPuppy(id_puppy: Integer): Integer;
var
  qry: TADOQuery;
  sql: String;
  IdModelKit: Integer;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := FConnection;

    result := -1;

    //try get a kit where puppy is in.
    sql :=  'select IdPackModel from PackModel where Idmodel =:idmodel';

    qry.SQL.Text := sql;
    qry.Parameters.ParamByName('idmodel').Value := Id_Puppy;
    qry.Open;

    // if there is a kit to puppy
    if ( not qry.IsEmpty() ) then begin
        IdModelKit := qry.fieldByname('IdPackModel').Value;

        // get this kit
        sql :=
          'select m.IdModel ' +
          'from Model m ' +
          'join TabGroup t on m.GroupID = t.IDGroup ' +
          'where  t.PuppyTracker = 1 ' +
          '   and t.packmodel = 1 ' +
          '   and m.IdModel = :idmodelKit ';

         qry.SQL.Text := sql;
         qry.Parameters.ParamByName('idmodelkit').Value := idModelKit;
         qry.Open;

         if ( not qry.IsEmpty ) then
            result := qry.fieldbyname('Idmodel').Value;
    end;
  finally
    freeAndNil(qry);
  end;

end;

function TMRPuppyIntegration.getKitUsingPuppyFromKitDescription(
 var id_puppy: Integer; ref: String): Integer;
var
  qry: TADOQuery;
  sql: String;
  IdModelKit: Integer;
  kitModel: String;
  idPuppyToLinkWithKit: Integer;
begin
  try
    qry := TADOQuery.Create(nil);
    qry.Connection := FConnection;

    result := -1;


    //try get a kit where puppy is in.
    sql :=  'select IdModel, model from Model where model like :kit';

    qry.SQL.Text := sql;
    qry.Parameters.ParamByName('kit').Value := '%-'+ref+'-Kit%';
    qry.Open;

    if ( not qry.IsEmpty ) then
       idModelKit := qry.fieldByName('IdModel').AsInteger;

    // The idea here is get Idmodel related to puppy.
    sql := 'select Idmodel from Model where model = :ref';
    qry.SQL.Text := sql;
    qry.Parameters.ParamByName('ref').Value := ref;
    qry.Open;

    // puppy was found
    if ( not qry.IsEmpty ) then begin
       idPuppyToLinkWithKit := qry.fieldByName('IdModel').AsInteger;
       id_puppy := idPuppyToLinkWithKit;
    end;

    result := idModelKit;

  finally
    freeAndNil(qry);
  end;
end;

function TMRPuppyIntegration.LinkPuppyToKit(id_puppy,
  id_kit: Integer): Boolean;
var
  qryPuppyToMR: TADOQuery;
begin
    try
        try
            result := false;
            // associate the kit to puppy
            qryPuppyToMR := TADOQuery.Create(nil);
            qryPuppyToMR.Connection := FConnection;
            qryPuppyToMR.SQL.Text :=
            'delete from PackModel where IdPackModel = :kit ' +
            ' and IdModel = :puppy ' +
            ' and IdModel in ( select IdModel from Model m ' +
            ' join PT_GlobalSetting g on m.GroupId = g.IdPetCategory) ';
            qryPuppyToMR.Parameters.ParamByName('kit').Value := id_kit;
            qryPuppyToMR.Parameters.ParamByName('puppy').Value := Id_Puppy;
            qryPuppyToMR.ExecSQL;

            // associate the kit to puppy
            qryPuppyToMR.SQL.Text := 'insert into PackModel (IdPackModel, IdModel, Qty) ' +
                                     ' values (:idkit, :idpuppy, :qty) ';
            qryPuppyToMR.Parameters.ParamByName('idkit').Value := id_kit;
            qryPuppyToMR.Parameters.ParamByName('idpuppy').Value := Id_Puppy;
            qryPuppyToMR.Parameters.ParamByName('qty').Value     := 1;
            qryPuppyToMR.ExecSQL;

            result := true;

        except
            result := false;
        end;
    finally
        freeAndNil(qryPuppyToMR);
    end;
end;

function TMRPuppyIntegration.kitFound(ref: String): Integer;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := -1;
     sql := 'select IdModel, model '+
         'from Model m '+
         'join TabGroup t on m.groupID = t.idGroup '+
         'join PT_GlobalSetting g on g.idKitCategory = m.groupId '+
         'where model = :kit';
         try
             qry := TADOQuery.Create(nil);
             qry.Connection := FConnection;
             qry.SQL.Text := sql;
             qry.Parameters.ParamByName('kit').Value := ref+'-Kit';
             qry.open;

             if ( not qry.FieldByName('idModel').IsNull ) then
                result := qry.fieldByname('idModel').asInteger;

         except
            on e: Exception do begin
               raise Exception.Create('Exception found in kitFound routine: ' + e.message);
            end;
         end;
   finally
     freeAndNil(qry);
   end;

end;

function TMRPuppyIntegration.microchipFound(ref: String): String;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := 'no_barcode';
     sql := 'select IdBarcode, IdModel from Barcode where IdBarcode =:microchip';
     qry := TADOQuery.Create(nil);
     qry.Connection := FConnection;
     qry.SQL.Text := sql;
     try
       qry.Parameters.ParamByName('microchip').Value := FCdsMicroChip.fieldByname('microchip').Value;
       qry.open;

       if ( not qry.FieldByName('IdBarcode').IsNull ) then
          result := qry.fieldByname('IdBarcode').asString;

     except
        on e: Exception do begin
            raise Exception.Create('Exception found in microchipFound method: ' + e.Message);
        end;

     end;
   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.puppyFound(ref: String): Integer;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := -1;
     sql := 'select IdModel, model '+
         'from Model m '+
         'join TabGroup t on m.groupID = t.idGroup '+
         'join PT_GlobalSetting g on g.idPetCategory = m.groupId '+
         'where model = :ref';
         try
             qry := TADOQuery.Create(nil);
             qry.Connection := FConnection;
             qry.SQL.Text := sql;
             qry.Parameters.ParamByName('ref').Value := ref;
             qry.open;

             if ( not qry.FieldByName('idModel').IsNull ) then
                result := qry.fieldByname('idModel').asInteger;

         except on e: Exception do begin
                raise Exception.Create('Exception in PuppyFound routine: ' + e.Message);

                end;
         end;
   finally
     freeAndNil(qry);
   end;

end;

function TMRPuppyIntegration.serviceFound(ref: String): Integer;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := -1;
     sql := 'select IdModel, model '+
         'from Model m '+
         'join TabGroup t on m.groupID = t.idGroup '+
         'join PT_GlobalSetting g on g.idServiceCategory = m.groupId '+
         'where model = :ref';
     try
     qry := TADOQuery.Create(nil);
     qry.Connection := FConnection;
     qry.SQL.Text := sql;
     qry.Parameters.ParamByName('ref').Value := ref;
     qry.open;

     if ( not qry.FieldByName('idModel').IsNull ) then
        result := qry.fieldByname('idModel').asInteger;
     except
        on e: Exception do begin
            raise Exception.Create('Exception found in serviceFound method: ' + e.Message);
        end;
     end;
   finally
     freeAndNil(qry);
   end;

end;

function TMRPuppyIntegration.microchipFoundInKit(kit,
  microchip: Integer): Boolean;
begin
//
end;

function TMRPuppyIntegration.puppyFoundInKit(kit, puppy: Integer): Boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := false;
     sql := 'select IdPackModel, IdModel '+
         'from PackModel pm '+
         'where IdPackModel = :kit '+
         ' and IdModel = :puppy';
     qry := TADOQuery.Create(nil);
     qry.Connection := FConnection;
     qry.SQL.Text := sql;
     qry.Parameters.ParamByName('kit').Value := kit;
     qry.Parameters.ParamByName('puppy').Value := puppy;

       try
         qry.open;

         result := ( not qry.fieldByname('IdModel').IsNull );
       except
         on E:Exception do begin
            raise Exception.Create('Exception found in puppyFoundInKit method: ' + e.Message);
         end;
       end;
   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.serviceFoundInKit(kit,
  service: Integer): Boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := false;
     sql := 'select IdPackModel, IdModel '+
         'from PackModel pm '+
         'where IdPackModel = :kit '+
         ' and IdModel = :service';
     qry := TADOQuery.Create(nil);
     qry.Connection := FConnection;
     qry.SQL.Text := sql;
     qry.Parameters.ParamByName('kit').Value := kit;
     qry.Parameters.ParamByName('service').Value := service;

     try
       qry.open;
       result := ( not qry.fieldByname('IdModel').IsNull );
     except
       on e: Exception do begin
          raise Exception.Create('Exception found in serviceFoundInKit method: ' + e.message);
       end;
     end;

   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.addMicrochipToKit(kit: Integer; microchip: String): Boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   try
      try
         result := false;
         sql := 'insert into PackModel(IdPackModel, IdModel, Qty) '+
             'values (:packmodel, :microchip, :qty)';
         qry := TADOQuery.Create(nil);
         qry.Connection := FConnection;
         qry.SQL.Text := sql;
         qry.Parameters.ParamByName('packmodel').Value := kit;
         qry.Parameters.ParamByName('microchip').Value := microchip;
         qry.Parameters.ParamByName('qty').Value := 1;
         qry.ExecSQL;
         result := true;
     except
         result := false;
     end
   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.addPuppyToKit(kit, puppy: Integer): Boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   try
      try
         result := false;
         sql := 'insert into PackModel(IdPackModel, IdModel, Qty) '+
             'values(:packmodel, :puppy, :qty)';
         qry := TADOQuery.Create(nil);
         qry.Connection := FConnection;
         qry.SQL.Text := sql;
         qry.Parameters.ParamByName('packmodel').Value := kit;
         qry.Parameters.ParamByName('puppy').Value := puppy;
         qry.Parameters.ParamByName('qty').Value := 1;
         qry.ExecSQL;
         result := true;
     except
         on E: Exception do begin
           raise Exception.Create('Exception found in addPuppyToKit method: ' + e.Message);
         end;
     end
   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.addServiceToKit(kit,
  service: Integer): Boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   try
      try
         result := false;
         sql := 'insert into PackModel(IdPackModel, IdModel, Qty) '+
             'values(:packmodel, :service, :qty)';
         qry := TADOQuery.Create(nil);
         qry.Connection := FConnection;
         qry.SQL.Text := sql;
         qry.Parameters.ParamByName('packmodel').Value := kit;
         qry.Parameters.ParamByName('service').Value := service;
         qry.Parameters.ParamByName('qty').Value := 1;
         qry.ExecSQL;
         result := true;
     except
         on e: Exception do begin
            raise Exception.Create('Exception found in addServiceToKit: ' + e.Message);
         end;
     end
   finally
     freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.createMicrochip(microchip: String): Integer;
begin
  //
end;

function TMRPuppyIntegration.createService(service: String): Integer;
var
   qry: TADOQUery;
   sql: String;
   newIdModel, newIdInventory, IdService: Integer;
   found: boolean;
begin
   debugToFile('Inside Create Service ( service = '+ service +' - begin');
   try
      try

        qry := TADOQuery.Create(nil);
        qry.Connection := FConnection;

        sql := 'select m.IdModel '+
            'from Model m '+
            'join TabGroup t on m.GroupId = t.IdGroup '+
            'join PT_GlobalSetting g on m.GroupId = g.IdServiceCategory '+
            'where model = :service';

        qry.SQL.Text := sql;
        qry.Parameters.ParamByName('service').Value := service;
        qry.Open;

        debugToFile('SQL  = ' + sql );

        debugToFile('Looking for IdModel to this service = '+ service);
        if ( qry.FieldByName('IdModel').IsNull ) then begin
           debugToFile('IdModel not found');
            qry.SQL.Text :=
              'insert into model(IdModel, GroupID, Model, Description, SellingPrice,  VendorCost, LastMovDate, ClasseABC, AvgCost,  TotQtyOnHand )' +
              ' values (:idmodel, :category, :model, :description, :price, :cost, :date, :classABC, :AvgCost, :TotQtyOnHand )';

            debugToFile('Call NextCode function to get Idmodel to Service');
            newIdModel := GetNextCode('Model', 'IDModel', FConnection);
            debugToFile('NewIdModel by GetNextCode = '+ intToStr(newIdModel));
            debugToFile('Try Insert new modelservice in database-begin');
            qry.Parameters.ParamByName('idmodel').Value :=  newIdModel;
            qry.Parameters.ParamByName('category').Value := FPetServiceCategory;
            qry.Parameters.ParamByName('model').Value := FCdsServiceMap.fieldByName('Service').Value;
            qry.Parameters.ParamByName('description').Value := FCdsServiceMap.fieldByName('Service').Value;
            qry.Parameters.ParamByName('price').Value := NULL;
            qry.Parameters.ParamByName('cost').Value := NULL;

            qry.Parameters.ParamByName('date').Value := now();
            qry.Parameters.ParamByName('Avgcost').Value := NULL;
            qry.Parameters.ParamByName('TotQtyOnHand').Value := 1;
            qry.Parameters.ParamByName('classABC').Value := 'E';
            qry.ExecSQL;
            debugToFile('Try Insert new modelservice in database-end');

            debugToFile('Try Update ServiceMap List to grid-begin');
            FCdsServiceMap.Edit;
            FCdsServiceMap.FieldByName('IdModel').Value := newIdModel;
            FCdsServiceMap.Post;
            debugToFile('Try Update ServiceMap List to grid-end');

            debugToFile('Creating Inventory-begin');
            debugToFile('Call GetNextCode to a new IdInventory');
            newIdInventory := GetNextCode('Inventory', 'IdInventory', FConnection);
            debugToFile('Creating Inventory-begin');

            //Inventory
            qry.SQL.Text :=
             ' insert into Inventory(StoreID, ModelID, IdInventory, UltimaMovimentacao, SellingPrice, StoreCostPrice, ClassABC, qtyOnHand )' +
             ' values (:storeId, :modelId, :idinventory, :date, :sellingPrice, :cost, :classABC, :qtyOnHand) ';
            qry.Parameters.ParamByName('storeId').Value := FStoreID;
            qry.Parameters.ParamByName('modelId').Value := newIdModel;
            qry.Parameters.ParamByName('idinventory').Value := newIdInventory;
            qry.Parameters.ParamByName('date').Value := now();
            qry.Parameters.ParamByName('sellingprice').Value := 0;
            qry.Parameters.ParamByName('cost').Value := 0;
            qry.Parameters.ParamByName('classABC').Value := 'E';
            qry.Parameters.ParamByName('qtyOnHand').Value := 1;

            debugToFile('SQL to Insert Inventory = '+ qry.SQL.Text);
            debugToFile('Try Insert Inventory-begin');
            qry.ExecSQL;
            debugToFile('Try Insert Inventory-end');

            result := newIdModel;
            debugToFile('New IdModel(service) created = '+ intToStr(newIdModel));
        end;

      except
          on e:Exception do begin
             raise Exception.Create('Exception found in createService method '+ e.Message);
          end;
      end;
   finally
        freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.addMicrochipToBarcode(microchip : String; kit, recno: Integer): Boolean;
var
   qry: TADOQuery;
begin
   try
      try
          result := false;
          qry := TADOQuery.Create(nil);
          qry.Connection := FConnection;
          qry.SQL.Text := 'insert into Barcode (IdBarcode, IdModel, Data, BarcodeOrder, Qty) values (:idbarcode, :idmodel, :date, :order, :qty)';
          qry.Parameters.ParamByName('idbarcode').Value := FCdsMicroChip.fieldByName('Microchip').Value;
          qry.Parameters.ParamByName('idmodel').Value := Kit;
          qry.Parameters.ParamByName('date').Value := now;
          qry.Parameters.ParamByName('order').Value := recno;
          qry.Parameters.ParamByName('qty').Value := NULL;
          qry.ExecSQL;
          result := true;
       except
          on e: exception do
          raise exception.Create('Exception found in addMicrochipToBarcode method: ' + e.Message);
       end;
   finally
       freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.addMicrochipToPet(idKit: Integer;
  microchip: String): Boolean;
var
   qry: TADOQuery;
   newIdPetMicrochip: Integer;
begin
   try
      try
          result := false;
          qry := TADOQuery.Create(nil);
          qry.Connection := FConnection;
          //associate microchip to pet_microchip. I have to associate with model, instead kit.
          newIdPetMicroChip := GetNextCode('Pet_Microchip', 'IDMicrochip', FConnection);
          qry.SQL.Text := 'insert into Pet_Microchip (IdMicrochip, Microchip, Amount, System, Hidden, Desativado, IdModel ) ' +
                                ' values (:id, :microchip, :amount, :system, :hidden, :disable, :idkit )';
          qry.Parameters.ParamByName('id').Value := newIdPetMicroChip;
          qry.Parameters.ParamByName('microchip').Value := microchip;
          qry.Parameters.ParamByName('amount').Value := 0;
          qry.Parameters.ParamByName('system').Value := 0;
          qry.Parameters.ParamByName('hidden').Value := 0;
          qry.Parameters.ParamByName('disable').Value := 0;
          qry.Parameters.ParamByName('idkit').Value := IdKit; //model, not kit.
          qry.ExecSQL;
          result := true;
      except
         on e: Exception do
            raise Exception.Create(e.Message);
      end;
   finally
      freeAndNil(qry);
   end;
end;

function TMRPuppyIntegration.modelFound(var idModel: Integer; ref: String; categoryType: TCategoryType): Boolean;
var
   qry: TADOQuery;
   sql: String;
begin
   try
     result := false;

     case categoryType of
        tcPet:     sql := 'select IdModel, model from '+
                      'Model m join TabGroup t on m.GroupId = t.IdGroup '+
                      'join PT_GlobalSetting p on m.GroupId = p.IdPetCategory '+
                      'where model = :ref';

        tcKit:     sql := 'select IdModel, model from '+
                      'Model m join TabGroup t on m.GroupId = t.IdGroup '+
                      'join PT_GlobalSetting p on m.GroupId = p.IdKitCategory '+
                      'where model = :ref';

        tcService: sql := 'select IdModel, model from '+
                      'Model m join TabGroup t on m.GroupId = t.IdGroup '+
                      'join PT_GlobalSetting p on m.GroupId = p.IdServiceCategory '+
                      'where model = :ref';

        tcOther: sql := 'select IdModel, model from Model where model = :ref'
     end;

     try
         qry := TADOQuery.Create(nil);
         qry.Connection := FConnection;
         qry.SQL.Text := sql;
         qry.Parameters.ParamByName('ref').Value := ref;//+'%';
         qry.open;

         if ( not qry.fieldByName('IdModel').isNull ) then
             idModel := qry.fieldByname('idModel').Value;

         result := not qry.fieldByname('idModel').IsNull;
     except
         on e: Exception do begin
             raise Exception.Create('Exception found in ModelFound method: ' + e.Message);
         end;
     end;;
   finally
     freeAndNil(qry);
   end;

end;

function TMRPuppyIntegration.renameInsertKit(ref, description: String;
  idModel: Integer): Boolean;
var
   qry: TADOQUery;
   kitRef: String;
begin
    result := true;
    try
        try
          //rename model

          kitRef := ref+'-Kit';

          qry := TADOQuery.Create(nil);
          qry.Connection := FConnection;

          qry.SQL.Text :=
            'update model set model = :model ' +
            ' where IdModel = :param';

          qry.Parameters.ParamByName('model').Value := kitRef;
          qry.Parameters.ParamByName('param').Value := idModel;
          qry.ExecSQL;
        except on e: Exception do begin
               result := false;
               raise exception.Create(' Exception found in renameInsertKit method: ' + ref + ' ' +  e.Message);
            end;
        end;
    finally
       freeAndNil(qry);
    end;
end;

function TMRPuppyIntegration.renameInsertPuppy(ref, breed,
  description: String; cost, price: Currency; idModel: Integer): Boolean;
var
   qry: TADOQUery;
begin
    result := true;
    try
        try
          //rename model
          qry := TADOQuery.Create(nil);
          qry.Connection := FConnection;

          qry.SQL.Text :=
            'update model set model = :model ' +
            ' where IdModel = :param';

          qry.Parameters.ParamByName('model').Value := ref;
          qry.Parameters.ParamByName('param').Value := idModel;
          qry.ExecSQL;
        except on e: Exception do begin
               result := false;
               raise exception.Create(' Failed to rename model: ' + ref + ' ' +  e.Message);
            end;
        end;
    finally
       freeAndNil(qry);
    end;
end;

function TMRPuppyIntegration.renameInsertService(ref, descrition: String;
  cost, price: Currency; idModel: Integer): Boolean;
var
   qry: TADOQUery;
begin
    result := true;
    try
        try
          //rename model
          qry := TADOQuery.Create(nil);
          qry.Connection := FConnection;

          qry.SQL.Text :=
            'update model set model = :model ' +
            ' where IdModel = :param';

          qry.Parameters.ParamByName('model').Value := ref;
          qry.Parameters.ParamByName('param').Value := idModel;
          qry.ExecSQL;
        except on e: Exception do begin
               result := false;
               raise exception.Create('Exception found in renameInsertService method: ' + ref + ' ' +  e.Message);
            end;
        end;
    finally
       freeAndNil(qry);
    end;
end;

function TMRPuppyIntegration.deleteMicroChip(microchip: String): Boolean;
var
  qry: TADOQuery;
begin
   try
       qry := TADOQuery.Create(nil);
       qry.Connection := FConnection;

       qry.SQL.Text := 'delete from barcode where IdBarcode =:barcode';
       try
           qry.Parameters.ParamByName('barcode').Value := microchip;
           qry.ExecSQL;
       except
           on e: Exception do begin
               raise Exception.Create('Exception found in deleteMicrochip method: ' + e.Message);
           end;
       end;
   finally
     freeAndNil(qry);
   end;
end;

end.
