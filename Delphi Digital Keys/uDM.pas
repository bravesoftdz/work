unit uDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Inifiles, E2Query, PowerQuery, LookUpQuery, ADODB,
  RCADOQuery, PowerADOQuery, LookUpADOQuery, uFunctions, DECUtil, Cipher, Hash;

type

  TDM = class(TDataModule)
    ADODatabaseConnect: TADOConnection;
    qryLookUpState: TLookUpADOQuery;
    dsLookUpState: TDataSource;
    qryLookUpStateIDState: TAutoIncField;
    qryLookUpStateStateName: TStringField;
    qryLookupCity: TLookUpADOQuery;
    dsLookupCity: TDataSource;
    qryLookupCityIDCity: TAutoIncField;
    qryLookupCityCityName: TStringField;
    qryLookupCompany: TLookUpADOQuery;
    dsLookupCompany: TDataSource;
    qryLookupCompanyIDCompany: TIntegerField;
    qryLookupCompanyCompanyName: TStringField;
    qryLookupCountry: TLookUpADOQuery;
    dsLookupCountry: TDataSource;
    qryLookupCountryIDCountry: TAutoIncField;
    qryLookupCountryCountryName: TStringField;
    qryLookupGroup: TLookUpADOQuery;
    qryLookupGroupIDGroup: TAutoIncField;
    qryLookupGroupGroupName: TStringField;
    dsLookupGroup: TDataSource;
    qryRebuildIdent: TADOQuery;
    qryRebuildIdentTABLE_NAME: TStringField;
    qryFreeSQL: TADOQuery;
    qryLookupHotelCateg: TLookUpADOQuery;
    dsLookupHotelCateg: TDataSource;
    qryLookupHotelCategIDHotelCategory: TAutoIncField;
    qryLookupHotelCategHotelCategoryName: TStringField;
    dsLookupContact: TDataSource;
    qryLookupContact: TLookUpADOQuery;
    qryLookupContactIDContact: TAutoIncField;
    qryLookupContactContactName: TStringField;
    qryLookUpAccomType: TLookUpADOQuery;
    dsLookUpAccomType: TDataSource;
    qryLookUpAccomTypeIDAccommodationType: TAutoIncField;
    qryLookUpAccomTypeAccommodationTypeName: TStringField;
    qryLookUpCarType: TLookUpADOQuery;
    dsCarType: TDataSource;
    qryLookUpCarTypeIDCarType: TAutoIncField;
    qryLookUpCarTypeCarTypeName: TStringField;
    qryLookupRoute: TLookUpADOQuery;
    dsLookupRoute: TDataSource;
    qryLookupRouteIDRoute: TAutoIncField;
    qryLookupRouteRouteName: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    function qryLookupGroupClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookUpStateClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookupCityClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookupCountryClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookupHotelCategClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookupContactClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookUpAccomTypeClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookUpCarTypeClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function qryLookupRouteClickButton(Sender: TADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
  private
    { Private declarations }
    sServer : String;
    sUser   : string;
    sPW     : string;
    sDBName : string;


// ###### encode\decode types ############
//  fmtDEFAULT     =    -1;     // use DefaultStringFormat
//  fmtNONE        =     0;     // allways an Empty String, nothing Action
//  fmtCOPY        =     1;     // One to One binary (input = output)
//  fmtHEX         =    16;     // Hexadecimal
//  fmtHEXL        =  1016;     // Hexadecimal lowercase
//  fmtMIME64      = $1064;     // MIME Base 64
//  fmtUU          = $5555;     // UU Coding  $5555 = 'UU'
//  fmtXX          = $5858;     // XX Coding  $5858 = 'XX'


// ###### Chipher Mode ############
//0 - cmCTS=Cipher Text Stealing
//1 - cmCBC=Cipher Block Chaining
//2 - cmCFB=Cipher Feedback
//3 - cmOFB=Output Feedback
//4 - cmECB=Electronic Code Book


    procedure DecodeServerInfo(sServerInfo:string);
    function EncodeServerInfo:string;

  public
    { Public declarations }

    function RunSQL(RunSQL: String): Boolean;

    procedure SetupConnection;

    procedure DB_RebuildIdentity;
  end;

var
  DM: TDM;

implementation

uses Registry,
     uConstants,
     //Fch
     uGroupFch,
     uCountryFch,
     uStateFch,
     uCityFch,
     uHotelCategoryFch,
     uContactFch,
     uAccommodationTypeFch,
     uCarTypeFch,
     uRouteFch;

{$R *.DFM}

function TDM.EncodeServerInfo:string;
var
 sResult : string;
begin

  sServer := '#SRV#=' +sServer+';';
  sDBName := '#DB#='  +sDBName+';';
  sUser   := '#USER#='+sUser  +';';
  sPW     := '#PW#='  +sPW    +';';

  sResult := sServer + sDBName + sUser + sPW;

  with TCipher_Blowfish.Create('Server', nil) do
     try
       //cmCTS=Cipher Text Stealing
       Mode := TCipherMode(0);

       Result := CodeString(sResult, paEncode, fmtUU);

     finally
     Free;
     end;
end;

procedure TDM.DecodeServerInfo(sServerInfo:string);
function GetServerParam(sText, sConstant:String):String;
   var
   iPos, i : Integer;
   begin
     iPos := Pos(sConstant, sText) + Length(sConstant);

     for i := iPos to Length(sText) do
        begin
        if sText[i] <> ';' then
           Result := Result + sText[i]
        else
           Break;
        end;
   end;

var
 sResult : string;
begin

  sResult := sServerInfo;

  with TCipher_Blowfish.Create('Server', nil) do
     try
       //cmCTS=Cipher Text Stealing
       Mode := TCipherMode(0);

       sResult := CodeString(sResult, paDecode, fmtUU);

     finally
     Free;
     end;

  sServer := GetServerParam(sResult, '#SRV#=');
  sDBName := GetServerParam(sResult, '#DB#=');
  sUser   := GetServerParam(sResult, '#USER#=');
  sPW     := GetServerParam(sResult, '#PW#=');

  //encode the sResult
end;

procedure TDM.SetupConnection;
var
sConnection : string;
Reg         : TRegistry;
begin

  Reg         := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;


  Reg.OpenKey('SOFTWARE\RCOSTA\', True);

  if not Reg.ValueExists('ServerInfo') then
     begin
     sServer  := InputBox('Server Config', 'Server IP :', '0.0.0.0');
     sUser    := InputBox('Server Config', 'User Name :', 'sa');
     sPW      := InputBox('Server Config', 'Password :', '');
     sDBName  := InputBox('Server Config', 'Data Base Name :', 'DemoDB');

     //Encriptografar os dados;

     Reg.WriteString('ServerInfo', EncodeServerInfo);
     end;

  //Desencriptografar os dados;
  DecodeServerInfo(Reg.ReadString('ServerInfo'));

  Reg.CloseKey;

  Reg.Free;

  if sPW <> '' then
     sPW := 'Password=' + sPW;

  sConnection := 'Provider=SQLOLEDB.1;Persist Security Info=False;'+sPW+
                 'User ID='+sUser+'; Initial Catalog='+sDBName+';Data Source='+sServer+';' +
                 'Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;';

  ADODatabaseConnect.ConnectionString := sConnection;

end;

procedure TDM.DB_RebuildIdentity;
begin
  Screen.Cursor := crHourGlass;
  with qryRebuildIdent do
   begin
     Open;
     while not Eof do
       begin
         qryFreeSQL.SQL.Text := 'DBCC CHECKIDENT (' + qryRebuildIdentTABLE_NAME.AsString + ')';
         try
           qryFreeSQL.ExecSQL;
         except
         end;
         Next;
       end;
     Close;
   end;
  Screen.Cursor := crDefault;
end;


function TDM.RunSQL(RunSQL: String): Boolean;
begin

  with qryFreeSQL do
    begin
      Close;
      SQL.Text := RunSQL;
      try
        ExecSQL;
        Result := True;
      except
        Result := False;
      end;
    end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  //ADO
  ADODatabaseConnect.Close;

  //SetUp Connection - Golden Coast
  SetupConnection;

  ADODatabaseConnect.Open;

end;

function TDM.qryLookupGroupClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  with TFrmGroupFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookUpGroup), PosID1, PosID2, 'Group');
       Free;
       end;
end;

function TDM.qryLookUpStateClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  with TFrmStateFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookupState), PosID1, PosID2, 'State');
       Free;
       end;
end;

function TDM.qryLookupCityClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  with TFrmCityFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookupCity), PosID1, PosID2, 'City');
       Free;
       end;
end;

function TDM.qryLookupCountryClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin
  with TFrmCountryFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookupCountry), PosID1, PosID2, 'Country');
       Free;
       end;
end;

function TDM.qryLookupHotelCategClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin

  with TFrmHotelCategoryFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookupHotelCateg), PosID1, PosID2, 'Hotel Category');
       Free;
       end;

end;

function TDM.qryLookupContactClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin

  with TFrmContactFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookupContact), PosID1, PosID2, 'Contact');
       Free;
       end;

end;

function TDM.qryLookUpAccomTypeClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin

  with TFrmAccommodationTypeFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookUpAccomType), PosID1, PosID2, 'Accommodation Type');
       Free;
       end;

end;

function TDM.qryLookUpCarTypeClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin

  with TFrmCarTypeFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookUpCarType), PosID1, PosID2, 'Car Type');
       Free;
       end;

end;

function TDM.qryLookupRouteClickButton(Sender: TADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin

  with TFrmRouteFch.Create(self) do
       begin
       OpenModal := True;
       Result := Start(ReturnButtonType(ClickedButton), TDataSet(qryLookupRoute), PosID1, PosID2, 'Route');
       Free;
       end;

end;

end.
