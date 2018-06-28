unit uDMExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMParent, ADODB, DB, DBClient, ImgList, uSaveToFile;

const
  REG_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';

type

  TBasicClass = class
  public
    function Insert : Boolean; virtual; abstract;
  end;

  TCashRegister = class(TBasicClass)
  public
    IDCashRegister : Integer;
    RegisterName   : String;
    IsAssociated   : Boolean;
    function Insert : Boolean; override;
  end;

  TModelSize = class(TBasicClass)
  public
    IDSize     : Integer;
    SizeName   : String;
    function Insert : Boolean; override;
  end;

  TModelColor = class(TBasicClass)
  public
    IDColor     : Integer;
    ColorName   : String;
    function Insert : Boolean; override;
  end;

  TMicrochip = class(TBasicClass)
  public
    IDMicrochip : Integer;
    IDModel     : Integer;
    Microchip   : String;
    Amount      : Currency;
    function Find : Boolean;
    function Insert : Boolean; override;
  end;

  TModel = class(TBasicClass)
  public
    IDCategory  : Integer;
    IDModel     : Integer;
    Barcode     : String;
    Model       : String;
    Description : String;
    Qty         : Double;
    CostPrice   : Double;
    SalePrice   : Double;
    ModelType   : Char;
    function Find : Boolean;
    function Insert : Boolean; override;
  end;

  TModelChild = class(TBasicClass)
  public
    IDModelParent : Integer;
    IDModel       : Integer;
    IDSize        : Integer;
    IDColor       : Integer;
    Qty           : Double;
    SalePrice     : Double;
    function Insert : Boolean; override;
  end;

  TPessoaTipo = class(TBasicClass)
  public
    IDTipoPessoaRoot : Integer;
    IDTipoPessoa : Integer;
    TipoPessoa   : String;
    Path         : String;
    function Insert : Boolean; override;
  end;


  TPessoa = class(TBasicClass)
  public
    IDPessoa     : Integer;
    IDTipoPessoa : String;
    Path         : String;
    PessoaName   : String;
    FName        : String;
    LName        : String;
    Phone        : String;
    Juridico     : String;
    function Insert : Boolean; override;
  end;

  TTax = class(TBasicClass)
  public
    IDSaleTax : Integer;
    SaleTaxName : String;
    SaleTax : Double;
    BrazilMode : Boolean;
    IDEncargos : Integer;
    EncargosVendas : Double;
    IDIPI : Integer;
    IPI : Double;
    IDCOFINS : Integer;
    COFINS : Double;
    IDPIS : Integer;
    PIS : Double;
    function Insert : Boolean; override;
  end;


  TParams = class(TBasicClass)
  public
    TaxOnCost : Boolean;
    ExemptTaxOnSale : Boolean;
    SimpleTax : Boolean;
    PostDateSale : Boolean;
    MaxNumberForPostDate : Integer;
    DeliveryFeature : Boolean;
    function Insert : Boolean; override;
  end;

  TStore = class(TBasicClass)
  public
    ID : Integer;
    StoreName : String;
    Address : String;
    City : String;
    Neighborhood : String;
    Zip : String;
    IDState : String;
    StoreState : String;
    Tel : String;
    Fax : String;
    Email : String;
    Web : String;
    TicketHeader : String;
    TicketLayawayFooter : String;
    TicketTaxIsemptFooter : String;
    Contat : String;
    function Insert : Boolean; override;
  end;


  TCategory = class(TBasicClass)
  public
    IDCategory   : Integer;
    Category     : String;
    SizeAndColor : Boolean;
    PackModel : Boolean;
    PackModelAddItems : Boolean;
    PuppyTracker : Boolean;
    function Find : Boolean;
    function Insert : Boolean; override;
  end;


  TDMExport = class(TDMParent)
    cdsCategory: TClientDataSet;
    cdsCategoryID: TIntegerField;
    cdsCategoryCategory: TStringField;
    cdsCategoryMarkup: TFloatField;
    cdsCategorySizeAndColor: TBooleanField;
    dsCategory: TDataSource;
    dsModel: TDataSource;
    cdsModel: TClientDataSet;
    cdsModelCategory: TStringField;
    cdsModelModel: TStringField;
    cdsModelDescription: TStringField;
    cdsModelCostPrice: TCurrencyField;
    cdsModelSalePrice: TCurrencyField;
    cdsModelQty: TFloatField;
    cdsModelBarcode: TStringField;
    cmdFree: TADOCommand;
    cdsUser: TClientDataSet;
    dsUser: TDataSource;
    cdsUserIDUser: TIntegerField;
    cdsUserUserName: TStringField;
    cdsUserPassword: TStringField;
    cdsUserIDUserType: TIntegerField;
    cdsVendor: TClientDataSet;
    dsVendor: TDataSource;
    cdsVendorIDVendor: TIntegerField;
    cdsVendorVendor: TStringField;
    cdsVendorPhone: TStringField;
    cdsSize: TClientDataSet;
    cdsColor: TClientDataSet;
    cdsGrid: TClientDataSet;
    dsSize: TDataSource;
    dsColor: TDataSource;
    dsGrid: TDataSource;
    cdsSizeIDSize: TIntegerField;
    cdsSizeMSize: TStringField;
    cdsColorIDColor: TIntegerField;
    cdsColorMColor: TStringField;
    cdsGridModel: TStringField;
    cdsGridMSize: TStringField;
    cdsGridMColor: TStringField;
    cdsGridQty: TFloatField;
    cdsGridSalePrice: TCurrencyField;
    cdsCategorySizeList: TWideStringField;
    cdsCategoryColorList: TWideStringField;
    cdsModelSizeAndColor: TBooleanField;
    cdsModelIDModel: TIntegerField;
    spAddSize: TADOStoredProc;
    spAddColor: TADOStoredProc;
    cdsCategorySystem: TBooleanField;
    cdsPetCustomer: TClientDataSet;
    cdsPetCustomerID: TStringField;
    cdsPetCustomerStore: TStringField;
    cdsPetCustomerAddress: TStringField;
    cdsPetCustomerCity: TStringField;
    cdsPetCustomerState: TStringField;
    cdsPetCustomerZip: TStringField;
    cdsPetCustomerPhone: TStringField;
    cdsPetCustomerFax: TStringField;
    cdsPetCustomerEmail: TStringField;
    cdsPetCustomerWeb: TStringField;
    cdsPetCustomerContact1: TStringField;
    cdsPetCustomerPhone1: TStringField;
    cdsPetCustomerEmail1: TStringField;
    cdsPetCustomerAddress2: TStringField;
    cdsPetCustomerCountry: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsCategoryNewRecord(DataSet: TDataSet);
    procedure cdsModelBeforePost(DataSet: TDataSet);
  private
    FSQLCommands : TStringList;
  public
    FModelOldValue : String;
    FCategoryOldValue : String;
    FParams : TParams;
    FStore : TStore;
    FTax : TTax;
    IDLanguage : Integer;

    function StartDatabaseConnection: Boolean;
    procedure WriteConnectionDefaultValues;
    procedure AddLog(AText : String);

    function CreateMainRetailData : Boolean;

    function GetInsStr(Str: string): string;

    procedure RunCommand(Query : TADOQuery);
    procedure SaveSQLCommands;
    function IsEmptyDataBase : Boolean;

    procedure OpenModel;
    procedure CloseModel;
    procedure AppendModel;
    procedure LoadModels(BusinessType : String);
    function GetIDModel(Model : String): Integer;

    procedure OpenCategory;
    procedure CloseCategory;
    procedure AppendCategory;
    procedure LoadCategories(BusinessType : String);
    function GetIDCategory(Category : String): Integer;
    function SizeAndColorCategory(Category : String; var SizeList, ColorList : String):Boolean;

    procedure OpenUser;
    procedure CloseUser;
    procedure CreateDefaulUsers;

    procedure OpenVendor;
    procedure CloseVendor;
    procedure CreateDefaulVendors;

    procedure OpenSize;
    procedure CloseSize;
    procedure LoadSize;
    function GetIDSize(MSize : String):Integer;

    procedure OpenColor;
    procedure CloseColor;
    procedure LoadColor;
    function GetIDColor(MColor : String):Integer;

    procedure OpenGrid;
    procedure CloseGrid;
    procedure LoadGrid;
    procedure RemoveGridModel(Model : String);
    procedure LoadGridModel(Model, Category : String; Qty : Double; Sale : Currency);
    procedure ChangeGridModel(ModelOld, ModelNew : String);

    procedure BuildCashRegister;
    procedure BuildUsers;
    procedure BuildCategories;
    procedure BuildVendor;
    procedure BuildModel;
    procedure BuildModelChild;
    procedure SaveRegistryInfo;
    procedure SaveWinStartUp(AKey, ASoftware : String);
    procedure DeleteWinStartUp(AKey : String);
    function RegKeyExist(AKey : string) : Boolean;

    function FieldExist(cds: TClientDataSet; Field, Value: String):Boolean;
    function ValueExist(ATable, AField1, AField2, AValue1, AValue2 : String) : Boolean;

    function CreateGuid: string;

    function CreatePetWrdFile : Boolean;
    function DeletePetWrdFile : Boolean;
    function CheckPetWrdFile : Boolean;

    //Pet Data
    function InsertBreed(ABreed : String):Boolean;
    function InsertColor(AColor : String):Boolean;
    function InsertMedicalCondition(AMedical, ASubMedical : String):Boolean;
    function InsertTreamtne(ATreatment, AManu : String; AType : Integer):Boolean;
  end;

var
  DMExport: TDMExport;

implementation

uses IniFiles, StrUtils, uParamFunctions, uFrmServerinfo, uMsgBox,
  uTranslateScript, Registry, uSystemConst, ComObj, ActiveX, uEncryptFunctions,
  uOperationSystem;

{$R *.dfm}

{ TDMExport }

function TDMExport.CreateGuid: string;
var
  ID: TGUID;
begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
    Result := GUIDToString(ID);
end;

procedure TDMExport.AppendCategory;
begin
  with cdsCategory do
    if Active then
      Append;
end;

procedure TDMExport.AppendModel;
begin
  with cdsModel do
    if Active then
      Append;
end;

procedure TDMExport.CloseCategory;
begin
  with cdsCategory do
    if Active then
      Close;
end;

procedure TDMExport.CloseModel;
begin
  with cdsModel do
    if Active then
      Close;
end;

procedure TDMExport.CloseUser;
begin
  with cdsUser do
    if Active then
      Close;
end;


procedure TDMExport.LoadCategories(BusinessType: String);
var
  FCategoryFile : TIniFile;
  FSections : TStringList;
  FFileName : String;
  i : Integer;
begin
  FFileName := LocalPath+'Category\'+BusinessType + '.ini';
  if FileExists(FFileName) then
  begin
    FCategoryFile := TIniFile.Create(FFileName);
    try
      FSections := TStringList.Create;
      try
        FCategoryFile.ReadSections(FSections);

        for i := 0 to FSections.Count-1 do
        begin
          with cdsCategory do
            if Active then
            begin
              Append;
              FieldByName('Category').Value     := FSections.Strings[i];
              FieldByName('Markup').Value       := FCategoryFile.ReadFloat(FSections.Strings[i], 'Markup', 100);
              FieldByName('SizeAndColor').Value := FCategoryFile.ReadBool(FSections.Strings[i], 'SizeAndColor', False);
              FieldByName('SizeList').Value     := FCategoryFile.ReadString(FSections.Strings[i], 'SizeList', '');
              FieldByName('ColorList').Value    := FCategoryFile.ReadString(FSections.Strings[i], 'ColorList', '');
              FieldByName('System').Value       := True; 
              Post;
            end;
        end;

        OpenColor;
        OpenSize;
        cdsCategory.First;
      finally
        FreeAndNil(FCategoryFile);
        end;
    finally
      FreeAndNil(FCategoryFile);
      end;
  end;
end;

procedure TDMExport.LoadModels(BusinessType: String);
var
  FFileData : TStringList;
  FFileName : String;
begin
  FFileName := LocalPath+'Category\'+BusinessType + '.xml';
  if FileExists(FFileName) then
  begin
    FFileData := TStringList.Create;
    try
      FFileData.LoadFromFile(FFileName);
      cdsModel.XMLData := FFileData.Text;
      cdsModel.First;
    finally
      FreeAndNil(FFileData);
    end;
  end;
end;

procedure TDMExport.OpenCategory;
begin
  with cdsCategory do
    if not Active then
      CreateDataSet;
end;

procedure TDMExport.OpenModel;
begin
  with cdsModel do
    if not Active then
      CreateDataSet;
end;

procedure TDMExport.OpenUser;
begin
  with cdsUser do
    if not Active then
    begin
      CreateDataSet;
      CreateDefaulUsers;
    end;
end;


procedure TDMExport.DataModuleCreate(Sender: TObject);
begin
  inherited;

  FParams := TParams.Create;
  FStore := TStore.Create;
  FTax := TTax.Create;

  cdsCategory.CreateDataSet;
  cdsModel.CreateDataSet;

  FSQLCommands := TStringList.Create;

  SetMsgBoxLand(1);

end;

procedure TDMExport.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FParams);
  FreeAndNil(FStore);
  FreeAndNil(FTax);

  cdsCategory.Close;
  cdsModel.Close;

  FreeAndNil(FSQLCommands);
end;

procedure TDMExport.cdsCategoryNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsCategory.FieldByName('Markup').Value       := 100;
  cdsCategory.FieldByName('SizeAndColor').Value := False;
end;

function TDMExport.GetInsStr(Str: string): string;
begin
  //Returns 'NULL' for blank text in Edit
  if Trim(Str) <> '' then
    Result := QuotedStr(Trim(Str))
  else
    Result := 'NULL';
end;

procedure TDMExport.CreateDefaulUsers;
var
  sUserName : String;
begin

  case IDLanguage of
    1 : sUserName := 'User';
    2 : sUserName := 'Usuario';
  end;

  with cdsUser do
  begin
    Append;
    FieldByName('UserName').Value   := sUserName + '1';
    FieldByName('Password').Value   := '1';
    FieldByName('IDUserType').Value := 1;
    Post;
  end;

  with cdsUser do
  begin
    Append;
    FieldByName('UserName').Value   := sUserName + '2';
    FieldByName('Password').Value   := '2';
    FieldByName('IDUserType').Value := 2;
    Post;
  end;

  with cdsUser do
  begin
    Append;
    FieldByName('UserName').Value   := sUserName + '3';
    FieldByName('Password').Value   := '3';
    FieldByName('IDUserType').Value := 4;
    Post;
  end;

end;

function TDMExport.CreateMainRetailData: Boolean;
begin

  FModelOldValue    := '';
  FCategoryOldValue := '';

  Result := StartDatabaseConnection;

  if Result then
    try
      //TRanslation
      TranslateDatabase(IDLanguage, quFreeSQL);
      ADODBConnect.BeginTrans;
      //Store
      FStore.Insert;
      //User
      BuildUsers;
      //Param
      FParams.Insert;
      //Cash Register
      BuildCashRegister;
      //Tax
      FTax.Insert;
      //Vendor
      BuildVendor;
      //Category
      BuildCategories;
      //Model
      BuildModel;
      //Model Child
      BuildModelChild;
      ADODBConnect.CommitTrans;
      SaveSQLCommands;
      SaveRegistryInfo;
    except
      on E: Exception do
      begin
        ADODBConnect.RollbackTrans;
        FSQLCommands.Add(E.Message);
        SaveSQLCommands;
        MsgBox('Error:' + E.Message, vbOkOnly + vbInformation);
        Result := False;
      end;
    end;
      
end;

function TDMExport.StartDatabaseConnection: Boolean;
var
  sResult : String;
  FrmServrInfo : TFrmServerInfo;
  cStartType   : char;
  bAbort       : Boolean;
begin
  Result := False;
  FrmServrInfo := nil;
  try
      FrmServrInfo  := TFrmServerInfo.Create(self);
      //D - Demo, 1,2,3,4 - Modules
      cStartType := '4';
      WriteConnectionDefaultValues;
      sResult := FrmServrInfo.Start(cStartType, False, '', bAbort);

      While not bAbort do
        try
           fSQLConnectParam.Server    := ParseParam(sResult, SV_SERVER);
           fSQLConnectParam.DBAlias   := ParseParam(sResult, SV_DATABASE);
           fSQLConnectParam.UserName  := ParseParam(sResult, SV_USER);
           fSQLConnectParam.PW        := ParseParam(sResult, SV_PASSWORD);
           fSQLConnectParam.WinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
           fSQLConnectParam.UseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');

         if not fSQLConnectParam.WinLogin then
            if fSQLConnectParam.UseNetLib then
               sResult := SetConnectionStr(fSQLConnectParam.UserName,
                                           fSQLConnectParam.PW,
                                           fSQLConnectParam.DBAlias,
                                           fSQLConnectParam.Server)
            else
               sResult := SetConnectionStrNoNETLIB(fSQLConnectParam.UserName,
                                                   fSQLConnectParam.PW,
                                                   fSQLConnectParam.DBAlias,
                                                   fSQLConnectParam.Server)
         else
            if fSQLConnectParam.UseNetLib then
               sResult := SetWinConnectionStr(fSQLConnectParam.DBAlias,
                                              fSQLConnectParam.Server)
            else
               sResult := SetWinConnectionStrNoNETLIB(fSQLConnectParam.DBAlias,
                                                      fSQLConnectParam.Server);

        ADOConnectionString := sResult;
        ADOConnectionOpen;
        Result := True;
        bAbort := True;
        except
           on E: Exception do
              begin
              sResult := FrmServrInfo.Start(cStartType, True, E.Message, bAbort);
              Result  := False;
              end;
           end;

  finally
    FrmServrInfo.Free;
  end;

end;

procedure TDMExport.BuildUsers;
var
 IDP, IDS : Integer;
 Pessoa : TPessoa;
begin

  with cdsUser do
  begin
    First;
    while not Eof do
    begin

      Pessoa := TPessoa.Create;
      try
        Pessoa.IDTipoPessoa := '4';
        Pessoa.Path         := '.003.001';
        Pessoa.PessoaName   := FieldByName('UserName').AsString;
        Pessoa.FName        := FieldByName('UserName').AsString;
        Pessoa.LName        := FieldByName('UserName').AsString;
        Pessoa.Phone        := '';
        Pessoa.Juridico     := '0';
        Pessoa.Insert;
        IDP := Pessoa.IDPessoa;
      finally
        FreeAndNil(Pessoa);
      end;

      //Adiciona Usuario
      quFreeSQL.SQL.Clear;
      IDS := GetNextID('SystemUser.IDUser');
      quFreeSQL.SQL.Add('INSERT INTO SystemUser (IDUser, SystemUser, CodSystemUser, PW, UserTypeID, StoresAccess, ComissionID)');
      quFreeSQL.SQL.Add(' VALUES ('+ IntToStr(IDS)  +', '+
                           QuotedStr(FieldByName('UserName').AsString) +', '+
                           QuotedStr(FieldByName('UserName').AsString) +', '+
                           QuotedStr(FieldByName('Password').AsString) +', '+
                           IntToStr(FieldByName('IDUserType').AsInteger) +', '+
                           IntToStr(FStore.ID) +', '+
                           IntToStr(IDP) + ')');
      RunCommand(quFreeSQL);

      Edit;
      FieldByName('IDUser').AsInteger := IDS;
      Post;

      Next;
    end;
  end;

end;

procedure TDMExport.RunCommand(Query: TADOQuery);
var
  cmd : String;
begin

  try
    cmd := Query.SQL.GetText;
    FSQLCommands.Add(cmd);
    FSQLCommands.Add('GO');
    FSQLCommands.Add('');
    Query.ExecSQL;

  except
    on E: Exception do
      DMExport.AddLog('RunCommand : msg = ' + E.Message + '. Cmd = ' + cmd);
  end;

end;

procedure TDMExport.BuildCategories;
var
  Category : TCategory;
  IDC : Integer;
begin

  with cdsCategory do
  begin
    First;
    while not Eof do
    begin

      Category := TCategory.Create;
      try
        Category.Category     := FieldByName('Category').AsString;
        Category.SizeAndColor := FieldByName('SizeAndColor').AsBoolean;
        Category.Insert;
        IDC := Category.IDCategory;
      finally
        FreeAndNil(Category);
      end;

      Edit;
      FieldByName('ID').AsInteger := IDC;
      Post;

      Next;
    end;
  end;

end;

procedure TDMExport.SaveSQLCommands;
begin
  FSQLCommands.SaveToFile(LocalPath + 'MRWizard.sql');
end;


procedure TDMExport.CloseVendor;
begin
  with cdsVendor do
    if Active then
      Close;
end;

procedure TDMExport.CreateDefaulVendors;
var
  sUserName : String;
begin

  case IDLanguage of
    1 : sUserName := 'Vendor';
    2 : sUserName := 'Fornecedor';
  end;


  with cdsVendor do
  begin
    Append;
    FieldByName('Vendor').Value   := sUserName + ' 1';
    FieldByName('Phone').Value    := '1111-1111';
    Post;
  end;

  with cdsVendor do
  begin
    Append;
    FieldByName('Vendor').Value   := sUserName + ' 2';
    FieldByName('Phone').Value    := '2222-2222';
    Post;
  end;

  with cdsVendor do
  begin
    Append;
    FieldByName('Vendor').Value   := sUserName + ' 3';
    FieldByName('Phone').Value    := '3333-3333';
    Post;
  end;

end;

procedure TDMExport.OpenVendor;
begin
  with cdsVendor do
    if not Active then
    begin
      CreateDataSet;
      CreateDefaulVendors;
    end;
end;

procedure TDMExport.BuildVendor;
var
  Pessoa : TPessoa;
  IDP : Integer;
begin

  with cdsVendor do
  begin
    First;
    while not Eof do
    begin

      Pessoa := TPessoa.Create;
      try
        Pessoa.IDTipoPessoa := '2';
        Pessoa.Path         := '.002';
        Pessoa.PessoaName   := FieldByName('Vendor').AsString;
        Pessoa.FName        := '';
        Pessoa.LName        := '';
        Pessoa.Phone        := FieldByName('Phone').AsString;
        Pessoa.Juridico     := '1';
        Pessoa.Insert;
        IDP := Pessoa.IDPessoa;
      finally
        FreeAndNil(Pessoa);
      end;

      Edit;
      FieldByName('IDVendor').AsInteger := IDP;
      Post;

      Next;
    end;
  end;


end;

procedure TDMExport.BuildModel;
var
  Model : TModel;
  s1, s2 : String;
begin

  with cdsModel do
  begin
    First;
    while not Eof do
    begin

      Model := TModel.Create;
      try
        Model.IDCategory  := GetIDCategory(FieldByName('Category').AsString);
        Model.Barcode     := FieldByName('Barcode').AsString;
        Model.Model       := FieldByName('Model').AsString;
        Model.Description := FieldByName('Description').AsString;
        Model.Qty         := FieldByName('Qty').AsFloat;
        Model.CostPrice   := FieldByName('CostPrice').AsCurrency;
        Model.SalePrice   := FieldByName('SalePrice').AsCurrency;

        if SizeAndColorCategory(FieldByName('Category').AsString, s1, s2) then
        begin
          Model.ModelType := 'M';
        end
        else
        begin
          Model.ModelType := 'R';
        end;

        if Model.Insert then
        begin
          Edit;
          FieldByName('IDModel').AsInteger := Model.IDModel;
          Post;
        end;
      finally
        FreeAndNil(Model);
      end;

      Next;
    end;
  end;

end;

function TDMExport.GetIDCategory(Category: String): Integer;
begin
  if cdsCategory.Locate('Category', Category, []) then
    Result := cdsCategory.FieldByName('ID').AsInteger
  else
    Result := 0;
end;

procedure TDMExport.BuildCashRegister;
var
  CashRegister : TCashRegister;
begin

  CashRegister := TCashRegister.Create;
  try
    CashRegister.RegisterName := 'Caixa01';
    CashRegister.IsAssociated := True;
    CashRegister.Insert;
  finally
    FreeAndNil(CashRegister);
  end;

end;

procedure TDMExport.CloseColor;
begin
  with cdsColor do
    if Active then
      Close;
end;

procedure TDMExport.CloseGrid;
begin
  with cdsGrid do
    if Active then
      Close;
end;

procedure TDMExport.CloseSize;
begin
  with cdsSize do
    if Active then
      Close;
end;

procedure TDMExport.OpenColor;
begin
  with cdsColor do
    if not Active then
    begin
      CreateDataSet;
      LoadColor;
    end;
end;

procedure TDMExport.OpenGrid;
begin
  with cdsGrid do
    if not Active then
    begin
      CreateDataSet;
      LoadGrid;
    end;
end;

procedure TDMExport.OpenSize;
begin
  with cdsSize do
    if not Active then
    begin
      CreateDataSet;
      LoadSize;
    end;
end;

procedure TDMExport.RemoveGridModel(Model : String);
var
  FilterTmp : String;
begin
  with cdsGrid do
    if Active then
    begin
      FilterTmp := Filter;
      Filtered  := False;
      Filter    := 'Model = ' + QuotedStr(Model);
      Filtered  := True;

      First;
      While (RecordCount <> 0) do
      begin
        Edit;
        Delete;
      end;

      Filtered := False;
      Filter   := FilterTmp;
      Filtered := True;
    end;
end;

procedure TDMExport.ChangeGridModel(ModelOld, ModelNew : String);
var
  FilterTmp : String;
begin
  with cdsGrid do
    if Active then
    begin
      FilterTmp := Filter;
      Filtered  := False;
      Filter    := 'Model = ' + QuotedStr(ModelOld);
      Filtered  := True;

      While not EOF do
      begin
        if cdsGrid.FieldByName('Model').AsString = ModelOld then
        begin
          Edit;
          cdsGrid.FieldByName('Model').AsString := ModelNew;
          Post;
        end;
        First; //Tem que ser o First, pois apos o update com filtro tem que voltar para a 1 linha
      end;

      Filtered := False;
      Filter   := FilterTmp;
      Filtered := True;
    end;
end;


procedure TDMExport.LoadGridModel(Model, Category : String; Qty : Double; Sale : Currency);
var
  FSizeList, FColorList : String;
  STSizeList, STColorList: TStringList;
  i, j : Integer;
begin

  RemoveGridModel(Model);

  with cdsGrid do
    if Active then
    begin
      if SizeAndColorCategory(Category, FSizeList, FColorList) then
      begin
        STSizeList  := TStringList.Create;
        STColorList := TStringList.Create;
        try
          STSizeList.CommaText  := FSizeList;
          STColorList.CommaText := FColorList;
          for i := 0 to (STSizeList.Count-1) do
            for j := 0 to (STColorList.Count-1) do
            begin
              if ((STSizeList.Strings[i] <> '') and (STColorList.Strings[j] <> '')) and 
                 (not Locate('Model;MSize;MColor', VarArrayOf([Model, STSizeList.Strings[i], STColorList.Strings[j]]), [])) then
              begin
                Append;
                FieldByName('Model').Value     := Model;
                FieldByName('MSize').Value     := STSizeList.Strings[i];
                FieldByName('MColor').Value    := STColorList.Strings[j];
                FieldByName('Qty').Value       := Qty;
                FieldByName('SalePrice').Value := Sale;
                Post;
              end;
            end;

        finally
          FreeAndNil(STSizeList);
          FreeAndNil(STColorList);
        end;
      end;

    end;

end;


procedure TDMExport.LoadGrid;
begin

  with cdsModel do
    if Active then
      while not EOF do
      begin
      LoadGridModel(FieldByName('Model').AsString,
                    FieldByName('Category').AsString,
                    FieldByName('Qty').AsFloat,
                    FieldByName('SalePrice').AsCurrency);
      Next;
      end;

end;

procedure TDMExport.LoadColor;
var
  FList : TStringList;
  i : Integer;
begin

  FList := TStringList.Create;

  try
  
    with cdsCategory do
      if Active then
      begin
        First;
        while not EOF do
        begin
        if FieldByName('SizeAndColor').AsBoolean then
          FList.CommaText := FList.CommaText + FieldByName('ColorList').AsString + ',';
        Next;
        end;
      end;

    with cdsColor do
      if Active then
        for i := 0 to (FList.Count-1) do
          if (FList.Strings[i] <> '') and not Locate('MColor', FList.Strings[i], []) then
          begin
            Append;
            FieldByName('MColor').AsString := FList.Strings[i];
            Post;
          end;

  finally
    FreeAndNil(FList);
    end;

end;

procedure TDMExport.LoadSize;
var
  FList : TStringList;
  i : Integer;
begin

  FList := TStringList.Create;

  try
  
    with cdsCategory do
      if Active then
      begin
        First;
        while not EOF do
        begin
        if FieldByName('SizeAndColor').AsBoolean then
          FList.CommaText := FList.CommaText + FieldByName('SizeList').AsString + ',';
        Next;
        end;
      end;

    with cdsSize do
      if Active then
        for i := 0 to (FList.Count-1) do
          if (FList.Strings[i] <> '') and not Locate('MSize', FList.Strings[i], []) then
          begin
            Append;
            FieldByName('MSize').AsString := FList.Strings[i];
            Post;
          end;

  finally
    FreeAndNil(FList);
    end;

end;

function TDMExport.SizeAndColorCategory(Category: String; var SizeList,
  ColorList: String): Boolean;
begin

  Result := False;

  if cdsCategory.Locate('Category', Category, []) then
  begin
    Result    := cdsCategory.FieldByName('SizeAndColor').AsBoolean;
    SizeList  := cdsCategory.FieldByName('SizeList').AsString;
    ColorList := cdsCategory.FieldByName('ColorList').AsString;
  end;

end;


procedure TDMExport.cdsModelBeforePost(DataSet: TDataSet);
var
  s1, s2 : String;
begin
  inherited;

  cdsModel.FieldByName('SizeAndColor').Value := SizeAndColorCategory(cdsModel.FieldByName('Category').AsString, s1, s2);

  if (FModelOldValue <> '') and (FModelOldValue <> DMExport.cdsModel.FieldByName('Model').NewValue) then
  begin
    ChangeGridModel(FModelOldValue, DMExport.cdsModel.FieldByName('Model').NewValue);
  end;

  if (FCategoryOldValue <> '') and (FCategoryOldValue <> DMExport.cdsModel.FieldByName('Category').NewValue) then
  begin
    RemoveGridModel(FModelOldValue);
    LoadGridModel(cdsModel.FieldByName('Model').NewValue,
                  cdsModel.FieldByName('Category').NewValue,
                  cdsModel.FieldByName('Qty').NewValue,
                  cdsModel.FieldByName('SalePrice').NewValue);
  end;

end;


procedure TDMExport.BuildModelChild;
var
  FSize : TModelSize;
  FColor : TModelColor;
  FModelChild : TModelChild;
begin

  FSize := TModelSize.Create;
  FColor := TModelColor.Create;
  FModelChild := TModelChild.Create;
  try

    with cdsSize do
      if Active then
      begin
        First;
        while not EOF do
        begin
          FSize.SizeName := FieldByName('MSize').AsString;
          if FSize.Insert then
          begin
            Edit;
            FieldByName('IDSize').AsInteger := FSize.IDSize;
            Post;
          end;
          Next;
        end;
      end;

    with cdsColor do
      if Active then
      begin
        First;
        while not EOF do
        begin
          FColor.ColorName := FieldByName('MColor').AsString;
          if FColor.Insert then
          begin
            Edit;
            FieldByName('IDColor').AsInteger := FColor.IDColor;
            Post;
          end;
          Next;
        end;
      end;


    with cdsGrid do
      if Active then
      begin
        First;
        while not EOF do
        begin
          FModelChild.IDModelParent := GetIDModel(FieldByName('Model').AsString);
          FModelChild.IDSize        := GetIDSize(FieldByName('MSize').AsString);
          FModelChild.IDColor       := GetIDColor(FieldByName('MColor').AsString);
          FModelChild.Qty           := FieldByName('Qty').AsFloat;
          FModelChild.SalePrice     := FieldByName('SalePrice').AsCurrency;
          FModelChild.Insert;
          Next;
        end;
      end;

  finally
    FreeAndNil(FSize);
    FreeAndNil(FColor);
    FreeAndNil(FModelChild);
    end;

end;

function TDMExport.GetIDModel(Model: String): Integer;
begin
  if cdsModel.Locate('Model', Model, []) then
    Result := cdsModel.FieldByName('IDModel').AsInteger
  else
    Result := 0;
end;

function TDMExport.GetIDSize(MSize: String): Integer;
begin
  if cdsSize.Locate('MSize', MSize, []) then
    Result := cdsSize.FieldByName('IDSize').AsInteger
  else
    Result := 0;
end;

function TDMExport.GetIDColor(MColor: String): Integer;
begin
  if cdsColor.Locate('MColor', MColor, []) then
    Result := cdsColor.FieldByName('IDColor').AsInteger
  else
    Result := 0;
end;

function TDMExport.IsEmptyDataBase: Boolean;
begin

 Result := True;

  try
    Screen.Cursor := crHourGlass;
    if StartDatabaseConnection then
      with quFreeSQL do
      begin
        if Active then
          Close;
        SQL.Clear;
        SQL.Add('SELECT IDStore From Store Where IDStore <> 0');
        Open;
        Result := IsEmpty;
        Close;
      end;
  finally
    Screen.Cursor := crDefault;
    ADOConnectionClose;
    end;
    
end;

function TDMExport.FieldExist(cds: TClientDataSet; Field, Value: String): Boolean;
var
  TempCDS : TClientDataSet;
  FieldPos : Integer;
begin
  TempCDS := TClientDataSet.Create(Self);
  try
    FieldPos := cds.RecNo;
    TempCDS.CloneCursor(cds, False);
    TempCDS.Filtered := False;
    TempCDS.Filter := Field + ' = ' + QuotedStr(Value);
    TempCDS.Filtered := True;
    Result := (TempCDS.RecordCount >= 1);
  finally
    FreeAndNil(TempCDS);
  end;
end;

procedure TDMExport.SaveRegistryInfo;
var
  sDecimal, sThousand, sDate : String;
  buildInfo: String;
begin

  case IDLanguage of
  1 : begin
       sDecimal  := '.';
       sThousand := ',';
       sDate     := 'mm/dd/yyyy';
      end;
  2 : begin
       sDecimal  := ',';
       sThousand := '.';
       sDate     := 'dd/mm/yyyy';
      end;
  end;

 // Abre o registry
 with TRegistry.Create do
     begin

       if ( getOS(buildInfo) = osW7 ) then
          RootKey := HKEY_CURRENT_USER
       else
          RootKey := HKEY_LOCAL_MACHINE;

       OpenKey(REGISTRY_PATH, True);

       if not ValueExists('DefaultCashRegID') then
          WriteInteger('DefaultCashRegID', 0);
       if not ValueExists('DefaultStoreID') then
          WriteInteger('DefaultStoreID', 1);
       if not ValueExists('DefaultLanguage') then
          WriteInteger('DefaultLanguage', IDLanguage);
       if not ValueExists('DefaultDecimalSeparator') then
          WriteString('DefaultDecimalSeparator', sDecimal);
       if not ValueExists('DefaultThousandSeparator') then
          WriteString('DefaultThousandSeparator', sThousand);
       if not ValueExists('DefaultDateFormat') then
          WriteString('DefaultDateFormat', sDate);
       Free;
     end;

end;


procedure TDMExport.SaveWinStartUp(AKey, ASoftware: String);
var
  buildInfo: String;
begin

  with TRegistry.Create do
  begin

    if ( getOS(buildInfo) = osw7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REG_PATH, False);
    if not ValueExists(AKey) then
       WriteString(AKey, ASoftware);
    Free;
  end;

end;

procedure TDMExport.DeleteWinStartUp(AKey: String);
var
  buildInfo: String;
begin
  with TRegistry.Create do
  begin

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;
      
    OpenKey(REG_PATH, False);
    if ValueExists(AKey) then
      DeleteValue(AKey);
    Free;
  end;
end;

function TDMExport.RegKeyExist(AKey: string): Boolean;
var
  buildInfo: String;
begin
  with TRegistry.Create do
  begin

    if ( getOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

    OpenKey(REG_PATH, False);
    Result := ValueExists(AKey);
    Free;
  end;
end;

function TDMExport.InsertBreed(ABreed: String): Boolean;
begin

  Result := False;

  with cmdFree do
  begin
    CommandText := 'INSERT Pet_Breed (IDBreed, Breed) VALUES (:IDBreed, :Breed)';
    Parameters.ParamByName('IDBreed').Value := GetNextID('Pet_Breed.IDBreed');
    Parameters.ParamByName('Breed').Value   := ABreed;
    Execute;
    Result := True;
  end;

end;

function TDMExport.InsertColor(AColor : String):Boolean;
begin

  Result := False;

  with cmdFree do
  begin
    CommandText := 'INSERT Pet_Color (IDColor, Color) VALUES (:IDColor, :Color)';
    Parameters.ParamByName('IDColor').Value := GetNextID('Pet_Color.IDColor');
    Parameters.ParamByName('Color').Value   := AColor;
    Execute;
    Result := True;
  end;

end;

function TDMExport.InsertMedicalCondition(AMedical,
  ASubMedical: String): Boolean;
begin

  Result := False;

  with cmdFree do
  begin
    CommandText := 'INSERT Pet_MedicalCondition (IDMedicalCondition, MedicalCondition, SubMedicalCondition) ' +
                   ' VALUES (:IDMedicalCondition, :MedicalCondition, :SubMedicalCondition) ';

    Parameters.ParamByName('IDMedicalCondition').Value  := GetNextID('Pet_MedicalCondition.IDMedicalCondition');
    Parameters.ParamByName('MedicalCondition').Value    := AMedical;
    Parameters.ParamByName('SubMedicalCondition').Value := ASubMedical;
    Execute;
    Result := True;
  end;

end;

function TDMExport.InsertTreamtne(ATreatment, AManu: String;
  AType: Integer): Boolean;
begin

  Result := False;

  with cmdFree do
  begin
    CommandText := 'INSERT Pet_Treatment (IDTreatment, Treatment, TreatmentType, Mfg) ' +
                   ' VALUES (:IDTreatment, :Treatment, :TreatmentType, :Mfg)';

    Parameters.ParamByName('IDTreatment').Value   := GetNextID('Pet_Treatment.IDTreatment');
    Parameters.ParamByName('Treatment').Value     := ATreatment;
    Parameters.ParamByName('TreatmentType').Value := AType;
    Parameters.ParamByName('Mfg').Value           := AManu;

    Execute;
    Result := True;
  end;

end;

function TDMExport.ValueExist(ATable, AField1, AField2, AValue1, AValue2: String): Boolean;
begin

  with quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT ' + AField1);
    SQL.Add('FROM ' + ATable);
    SQL.Add('WHERE ' + AField1 + ' = :Field1');

    if (AField2 <> '') then
      SQL.Add('AND ' + AField2 + ' = :Field2');

    Parameters.ParamByName('Field1').Value := AValue1;

    if (AField2 <> '') then
      Parameters.ParamByName('Field2').Value := AValue2;

    Open;
    Result := not IsEmpty;

  finally
    Close;
  end;

end;

procedure TDMExport.AddLog(AText: String);
var
  fFile : TSaveFile;
begin
  fFile := TSaveFile.Create;
  try
    fFile.FilePath := DMExport.LocalPath + 'pc_log.txt';
    fFile.OpenFile;
    AText := FormatDateTime('mm/dd/yyyy hh:mm ', now) + AText;
    fFile.InsertText(AText, 0);
    fFile.CreateFile;
  finally
    FreeAndNil(fFile);
  end;

end;

procedure TDMExport.WriteConnectionDefaultValues;
var
  sResult : String;
  fRegistryKey : String;
  Reg : TRegistry;
  buildInfo: String;
begin

  fRegistryKey := 'ServerInfo';

  sResult := SV_SERVER   +'(local);'+
             SV_DATABASE +'MainRetailDB;'+
             SV_USER     +'mruser;'+
             SV_PASSWORD +'mruser2000;'+
             SV_WIN_LOGIN+'N;'+
             SV_USE_NETLIB+'N;';

  Try
  
    Reg := TRegistry.Create;

    if ( getOS(buildInfo) = osW7 ) then
      reg.RootKey := HKEY_CURRENT_USER
    else
      reg.RootKey := HKEY_LOCAL_MACHINE;

    Reg.OpenKey('SOFTWARE\AppleNet', True);

    if not Reg.ValueExists(fRegistryKey) then
      Reg.WriteString(fRegistryKey, EncodeServerInfo(sResult, 'Server', CIPHER_TEXT_STEALING, FMT_UU));

  finally
     //Fechar o Registry
     Reg.CloseKey;
     Reg.Free;
  end;

end;

function TDMExport.CheckPetWrdFile: Boolean;
begin
  Result := FileExists(LocalPath + 'WzdPet.txt');

end;

function TDMExport.CreatePetWrdFile: Boolean;
begin
  if not FileExists(LocalPath + 'WzdPet.txt') then
    FileCreate(LocalPath + 'WzdPet.txt');
  Result := True;
end;

function TDMExport.DeletePetWrdFile: Boolean;
begin
  if not FileExists(LocalPath + 'WzdPet.txt') then
    DeleteFile(LocalPath + 'WzdPet.txt');
  Result := True;
end;

{ TTax }

function TTax.Insert: Boolean;
var
  IDP, IDF : Integer;
  PISFormula : String;
begin

  if BrazilMode then
  begin
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDSaleTax := DMExport.GetNextID('TaxCategory.IDTaxCategory');
      SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, SaleTaxType, Debit, SituacaoTributaria)');
      SQL.Add(' VALUES ('+ IntToStr(IDSaleTax) +', '+
              QuotedStr(SaleTaxName) +', '+
              StringReplace(FloatToStr(SaleTax),',','.',[rfReplaceAll]) +',1,2,0,1)');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;
  end
  else
  begin
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDSaleTax := DMExport.GetNextID('TaxCategory.IDTaxCategory');
      SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, SaleTaxType, Debit)');
      SQL.Add(' VALUES ('+ IntToStr(IDSaleTax) +', '+
              QuotedStr(SaleTaxName) +', '+
              StringReplace(FloatToStr(SaleTax),',','.',[rfReplaceAll]) +',1,1,0)');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;

    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDF := DMExport.GetNextID('TaxCategory.IDTaxCategory');
      SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, IDTaxCategoryParent)');
      SQL.Add(' VALUES ('+ IntToStr(IDF)                  +', '+
                       QuotedStr(SaleTaxName) +', '+
                       StringReplace(FloatToStr(SaleTax),',','.',[rfReplaceAll]) + ','+IntToStr(IDSaleTax)+ ')');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;
  end;

  if BrazilMode then
  begin
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDEncargos := DMExport.GetNextID('TaxCategory.IDTaxCategory');
      SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, SaleTaxType)');
      SQL.Add(' VALUES ('+ IntToStr(IDEncargos) +', '+
              QuotedStr('Encargos') +', '+
              StringReplace(FloatToStr(EncargosVendas),',','.',[rfReplaceAll]) +',1,1)');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;

    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDF := DMExport.GetNextID('TaxCategory.IDTaxCategory');
      SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, IDTaxCategoryParent)');
      SQL.Add(' VALUES ('+ IntToStr(IDF) +', '+
                       QuotedStr('Encargos') +', '+
                       StringReplace(FloatToStr(EncargosVendas),',','.',[rfReplaceAll]) + ','+IntToStr(IDEncargos)+ ')');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;
  end;


  if BrazilMode then
  begin
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDP := DMExport.GetNextID('TaxCategory.IDTaxCategory');
      SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, Formula, Debit, IDLancamentoTipo)');
      SQL.Add(' VALUES ('+ IntToStr(IDP) +', '+
              QuotedStr('ICMS') +', '+
              StringReplace(FloatToStr(SaleTax),',','.',[rfReplaceAll]) +',2,'+QuotedStr('(c+f)*p')+', 1, 1 )');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;

    if (COFINS <> 0) then
      with DMExport.quFreeSQL do
      begin
        SQL.Clear;
        IDCOFINS := DMExport.GetNextID('TaxCategory.IDTaxCategory');
        SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, Formula, Debit, IDLancamentoTipo)');
        SQL.Add(' VALUES ('+ IntToStr(IDCOFINS) +', '+
                QuotedStr('COFINS') +', '+
                StringReplace(FloatToStr(COFINS),',','.',[rfReplaceAll]) +',2,'+QuotedStr('(c+f)*p')+', 1, 1 )');
        DMExport.RunCommand(DMExport.quFreeSQL);
      end;

    PISFormula := '';
    IDIPI := 0;
    if (IPI <> 0) then
      with DMExport.quFreeSQL do
      begin
        SQL.Clear;
        IDIPI := DMExport.GetNextID('TaxCategory.IDTaxCategory');
        SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, Formula, Debit, IDLancamentoTipo)');
        SQL.Add(' VALUES ('+ IntToStr(IDIPI) +', '+
                QuotedStr('IPI') +', '+
                StringReplace(FloatToStr(IPI),',','.',[rfReplaceAll]) +',2,'+QuotedStr('(c+f)*p')+',1, 1 )');
        DMExport.RunCommand(DMExport.quFreeSQL);
      end;

    if (PIS <> 0) then
    begin
      if IDIPI = 0 then
        PISFormula := '(c+f)*p'
      else
        PISFormula := '((c+f)+['+IntToStr(IDIPI)+'])*p';

      with DMExport.quFreeSQL do
      begin
        SQL.Clear;
        IDPIS := DMExport.GetNextID('TaxCategory.IDTaxCategory');
        SQL.Add('INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, OperationType, Formula, Debit, IDLancamentoTipo)');
        SQL.Add(' VALUES ('+ IntToStr(IDPIS) +', '+
                QuotedStr('PIS') +', '+
                StringReplace(FloatToStr(PIS),',','.',[rfReplaceAll]) +',2,'+QuotedStr(PISFormula)+',0, 1 )');
        DMExport.RunCommand(DMExport.quFreeSQL);
      end;

    end;
  end;

 Result := True;
end;

{ TParams }

function TParams.Insert: Boolean;
var
  sSrvValue : String;
begin

  //Tax included on cost price
  if TaxOnCost then
    sSrvValue := 'True'
  else
    sSrvValue := 'False';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 66');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Exempt sale tax
  if ExemptTaxOnSale then
    sSrvValue := 'True'
  else
    sSrvValue := 'False';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 64');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Usar cálculo de markup
  if SimpleTax then
    sSrvValue := 'True'
  else
    sSrvValue := 'False';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 72');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Show Post-Date on Sale
  if PostDateSale then
    sSrvValue := 'True'
  else
    sSrvValue := 'False';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 48');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Max number of payments
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(IntToStr(MaxNumberForPostDate)));
    SQL.Add('WHERE IDParam = 58');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Type of Sales screen
  if DeliveryFeature then
    sSrvValue := '2'
  else
    sSrvValue := '1';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 63');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Treat Hold as Invoice on Sale
  if DeliveryFeature then
    sSrvValue := 'True'
  else
    sSrvValue := 'False';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 83');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Limit layaway edits to month created
  if DeliveryFeature then
    sSrvValue := 'True'
  else
    sSrvValue := 'False';
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Param ');
    SQL.Add('SET SrvValue = ' + QuotedStr(sSrvValue));
    SQL.Add('WHERE IDParam = 94');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;

end;

{ TStore }

function TStore.Insert: Boolean;
begin

  //Insert StoreState
  if Trim(IDState) <> '' then
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDState := Copy(StoreState,1,3);
      SQL.Add('IF NOT EXISTS(SELECT IDEstado FROM Estado WHERE IDEstado = '+
                                QuotedStr(Trim(IDState)) + ')');
      SQL.Add('  INSERT INTO Estado (IDEstado, Estado) VALUES ('+
                                QuotedStr(IDState) +', '+ QuotedStr(IDState) +')');
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;

  //Insert Store
  ID := DMExport.GetNextID('Store.IDStore');

  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO Store (IDStore, Name, Address, City, IDEstado, Zip, Telephone, '+
                           'Fax, Contato, TicketHeader, '+
                           'TicketLayawayFooter, TicketTaxIsemptFooter, Email, WebPage, IDEmpresa)');
    SQL.Add(' VALUES ('+ IntToStr(ID)                 +', '+
                     DMExport.GetInsStr(StoreName)             +', '+
                     DMExport.GetInsStr(Address)               +', '+
                     DMExport.GetInsStr(City)                  +', '+
                     DMExport.GetInsStr(IDState)               +', '+
                     DMExport.GetInsStr(Zip)                   +', '+
                     DMExport.GetInsStr(Tel)                   +', '+
                     DMExport.GetInsStr(Fax)                   +', '+
                     DMExport.GetInsStr(Contat)                +', '+
                     DMExport.GetInsStr(TicketHeader)          +', '+
                     DMExport.GetInsStr(TicketLayawayFooter)   +', '+
                     DMExport.GetInsStr(TicketTaxIsemptFooter) +', '+
                     DMExport.GetInsStr(Email)                 +', '+
                     DMExport.GetInsStr(Web)                   +', 1004)');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  //Atualiza Conta Corrente no MeioPagToStore para a loja.
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('UPDATE MeioPagToStore');
    SQL.Add('SET IDContaCorrente = 101');
    SQL.Add('WHERE IDStore = ' + IntToStr(ID));
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;

end;



{ TPessoa }

function TPessoa.Insert: Boolean;
var
  sCode : String;
begin

  //Get Next Code on the table
  with DMExport.quFreeSQL do
    try
      DMExport.RunSQL('UPDATE TipoPessoa SET LastCode = IsNull(LastCode,0) + 1 Where IDTipoPessoa = ' + IDTipoPessoa);
      Close;
      SQL.Clear;
      SQL.Add('SELECT LastCode From TipoPessoa WHERE IDTipoPessoa = ' + IDTipoPessoa);
      SQL.Add('AND Path = ' + QuotedStr(Path));
      Open;
      sCode := FieldByName('LastCode').AsString;
    finally
      Close;
    end;


  if FName = '' then
    FName := 'NULL';

  if LName = '' then
    LName := 'NULL';

  if Phone = '' then
    Phone := 'NULL';

  //Adiciona Comissionado
  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    IDPessoa := DMExport.GetNextID('Pessoa.IDPessoa');
    SQL.Add('INSERT INTO Pessoa(IDPessoa, Pessoa, PessoaFirstName, PessoaLastName, Code, IDTipoPessoa, IDTipoPessoaRoot, Telefone, Juridico)');
    SQL.Add(' VALUES ('+ IntToStr(IDPessoa)  +', '+
                     QuotedStr(PessoaName) +', '+
                     QuotedStr(FName)+', '+
                     QuotedStr(LName)+', '+
                     sCode+', '+IDTipoPessoa+', '+IDTipoPessoa+','+Phone+','+Juridico+')');
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;

end;

{ TCategory }

function TCategory.Find: Boolean;
begin

  Result := False;

  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT IDGroup FROM TabGroup WHERE Name = :Name');
    Parameters.ParamByName('Name').Value := Category;
    Open;
    if not IsEmpty then
    begin
      IDCategory := FieldByName('IDGroup').AsInteger;
      Result     := True;
    end;
  finally
    Close;
  end;

end;

function TCategory.Insert: Boolean;
var
  IDSaleTax, IDEncargo : String;
begin

  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    IDCategory := DMExport.GetNextID('TabGroup.IDGroup');
    SQL.Add('INSERT INTO TabGroup(IDGroup, Name, SizeAndColor, SalePriceMargemPercent, MSRPMargemPercent, ');
    SQL.Add(' PackModel, PuppyTracker, PackModelAddItems)');
    SQL.Add(' VALUES (:IDGroup, :Name, :SizeAndColor, 0, 0, :PackModel, :PuppyTracker, :PackModelAddItems)');
    Parameters.ParamByName('IDGroup').Value           := IDCategory;
    Parameters.ParamByName('Name').Value              := Category;
    Parameters.ParamByName('SizeAndColor').Value      := SizeAndColor;
    Parameters.ParamByName('PackModel').Value         := PackModel;
    Parameters.ParamByName('PuppyTracker').Value      := PuppyTracker;
    Parameters.ParamByName('PackModelAddItems').Value := PackModelAddItems;

    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  if DMExport.FTax.IDSaleTax <> 0 then
  begin
    if DMExport.FTax.BrazilMode then
    begin
      IDSaleTax := IntToStr(DMExport.FTax.IDEncargos);
      IDEncargo := IntToStr(DMExport.FTax.IDSaleTax);
    end
    else
    begin
      IDSaleTax := IntToStr(DMExport.FTax.IDSaleTax);
      IDEncargo := 'NULL';
    end;

    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      SQL.Add('UPDATE StoreToTabGroup');
      SQL.Add('SET IDTaxCategory = ' + IDSaleTax + ',');
      SQL.Add('IDSaleTax = ' + IDEncargo);
      SQL.Add('WHERE IDGroup = ' + IntToStr(IDCategory));
      SQL.Add('AND IDStore = ' + IntToStr(DMExport.FStore.ID));

      DMExport.RunCommand(DMExport.quFreeSQL);
    end;
  end;

  Result := True;

end;

{ TModel }

function TModel.Find: Boolean;
begin

  Result := False;

  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT IDModel FROM Model WHERE Model = :Model');
    Parameters.ParamByName('Model').Value := Model;
    Open;
    if not IsEmpty then
    begin
      IDModel := FieldByName('IDModel').AsInteger;
      Result  := True;
    end;
  finally
    Close;
  end;

end;

function TModel.Insert: Boolean;
var
  IDInv : Integer;
begin

  if not Find then
  begin
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      IDModel := DMExport.GetNextID('Model.IDModel');
      SQL.Add('INSERT INTO Model(IDModel, GroupID, Model, Description, VendorCost, SellingPrice, ModelType)');
      SQL.Add('VALUES (:IDModel, :GroupID, :Model, :Description, :VendorCost, :SellingPrice, :ModelType)');
      Parameters.ParamByName('IDModel').Value      := IDModel;
      Parameters.ParamByName('GroupID').Value      := IDCategory;
      Parameters.ParamByName('Model').Value        := Model;
      Parameters.ParamByName('Description').Value  := Description;
      Parameters.ParamByName('VendorCost').Value   := CostPrice;
      Parameters.ParamByName('SellingPrice').Value := SalePrice;
      Parameters.ParamByName('ModelType').Value    := ModelType;
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;

    if (Qty > 0) and (ModelType <> 'M') then
      with DMExport.quFreeSQL do
      begin
        SQL.Clear;
        IDInv := DMExport.GetNextID('InventoryMov.IDInventoryMov');
        SQL.Add('INSERT INTO InventoryMov(IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty)');
        SQL.Add('VALUES(:IDInventoryMov, :InventMovTypeID, :DocumentID, :StoreID, :ModelID, :MovDate, :Qty)');
        Parameters.ParamByName('IDInventoryMov').Value  := IDInv;
        Parameters.ParamByName('InventMovTypeID').Value := 5;
        Parameters.ParamByName('DocumentID').Value      := '0';
        Parameters.ParamByName('StoreID').Value         := DMExport.FStore.ID;
        Parameters.ParamByName('ModelID').Value         := IDModel;
        Parameters.ParamByName('MovDate').Value         := Now;
        Parameters.ParamByName('Qty').Value             := Qty;
        DMExport.RunCommand(DMExport.quFreeSQL);
      end;

    if (Barcode <> '') and (ModelType <> 'M') then
      with DMExport.quFreeSQL do
      begin
        SQL.Clear;
        SQL.Add('INSERT INTO Barcode(IDModel, IDBarcode, BarcodeOrder, Data, Qty)');
        SQL.Add('VALUES(:IDModel, :IDBarcode, :BarcodeOrder, :Data, :Qty)');
        Parameters.ParamByName('IDModel').Value      := IDModel;
        Parameters.ParamByName('IDBarcode').Value    := Barcode;
        Parameters.ParamByName('BarcodeOrder').Value := 1;
        Parameters.ParamByName('Data').Value         := Now;
        Parameters.ParamByName('Qty').Value          := 1;
        DMExport.RunCommand(DMExport.quFreeSQL);
      end;
  end;

  Result := True;

end;

{ TCashRegister }

function TCashRegister.Insert: Boolean;
begin

  with DMExport.quFreeSQL do
  begin
    IDCashRegister := DMExport.GetNextID('CashRegister.IDCashRegister');
    SQL.Clear;
    SQL.Add('INSERT INTO CashRegister (IDCashRegister, Name, IsAssociated)');
    SQL.Add('VALUES (:IDCashRegister, :Name, :IsAssociated)');
    Parameters.ParamByName('IDCashRegister').Value := IDCashRegister;
    Parameters.ParamByName('Name').Value           := RegisterName;
    Parameters.ParamByName('IsAssociated').Value   := IsAssociated;
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;

end;

{ TModelChild }

function TModelChild.Insert: Boolean;
var
  IDInv : Integer;
begin

  with DMExport.spAddSize do
  begin
   Parameters.ParamByName('@IDModel').Value       := IDModelParent;
   Parameters.ParamByName('@IDSize').Value        := IDSize;
   Parameters.ParamByName('@BarcodeCreate').Value := True;
   ExecProc;
  end;

  with DMExport.spAddColor do
  begin
   Parameters.ParamByName('@IDModel').Value       := IDModelParent;
   Parameters.ParamByName('@IDColor').Value       := IDColor;
   Parameters.ParamByName('@BarcodeCreate').Value := True;
   ExecProc;
  end;

  IDModel := 0;

  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('SELECT IDModel FROM Model');
    SQL.Add('WHERE IDSize = :IDSize AND IDColor = :IDColor AND IDModelParent = :IDParent');
    Parameters.ParamByName('IDSize').Value   := IDSize;
    Parameters.ParamByName('IDColor').Value  := IDColor;
    Parameters.ParamByName('IDParent').Value := IDModelParent;
    Open;
    IDModel := FieldByName('IDModel').AsInteger;
    Close;
  end;

  if IDModel <> 0 then
  begin
    with DMExport.quFreeSQL do
    begin
      SQL.Clear;
      SQL.Add('UPDATE Model');
      SQL.Add('SET SellingPrice = :SellingPrice');
      SQL.Add('WHERE IDModel = :IDModel');
      Parameters.ParamByName('SellingPrice').Value := SalePrice;
      Parameters.ParamByName('IDModel').Value      := IDModel;
      DMExport.RunCommand(DMExport.quFreeSQL);
    end;

    if (Qty <> 0) then
      with DMExport.quFreeSQL do
      begin
        SQL.Clear;
        IDInv := DMExport.GetNextID('InventoryMov.IDInventoryMov');
        SQL.Add('INSERT INTO InventoryMov(IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty)');
        SQL.Add('VALUES(:IDInventoryMov, :InventMovTypeID, :DocumentID, :StoreID, :ModelID, :MovDate, :Qty)');
        Parameters.ParamByName('IDInventoryMov').Value  := IDInv;
        Parameters.ParamByName('InventMovTypeID').Value := 5;
        Parameters.ParamByName('DocumentID').Value      := '0';
        Parameters.ParamByName('StoreID').Value         := DMExport.FStore.ID;
        Parameters.ParamByName('ModelID').Value         := IDModel;
        Parameters.ParamByName('MovDate').Value         := Now;
        Parameters.ParamByName('Qty').Value             := Qty;
        DMExport.RunCommand(DMExport.quFreeSQL);
      end;
  end;

  Result := True;

end;


{ TModelColor }

function TModelColor.Insert: Boolean;
begin

  with DMExport.quFreeSQL do
  begin
    IDColor := DMExport.GetNextID('InvColor.IDColor');
    SQL.Clear;
    SQL.Add('INSERT INTO InvColor (IDColor, Color, CodColor)');
    SQL.Add('VALUES (:IDColor, :Color, :CodColor)');
    Parameters.ParamByName('IDColor').Value  := IDColor;
    Parameters.ParamByName('Color').Value    := ColorName;
    Parameters.ParamByName('CodColor').Value := Trim(Copy(ColorName, 1, 5));
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;
  
end;

{ TModelSize }

function TModelSize.Insert: Boolean;
begin

  with DMExport.quFreeSQL do
  begin
    IDSize := DMExport.GetNextID('InvSize.IDSize');
    SQL.Clear;
    SQL.Add('INSERT INTO InvSize (IDSize, SizeName, CodSize)');
    SQL.Add('VALUES (:IDSize, :SizeName, :CodSize)');
    Parameters.ParamByName('IDSize').Value   := IDSize;
    Parameters.ParamByName('SizeName').Value := SizeName;
    Parameters.ParamByName('CodSize').Value  := Trim(Copy(SizeName, 1, 5));
    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;
  
end;



{ TPessoaTipo }

function TPessoaTipo.Insert: Boolean;
var
  sPath, sPathName : String;
  iPath : Integer;
begin

  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT Path, PathName FROM TipoPessoa WHERE IDTipoPessoa = ' + IntToStr(IDTipoPessoaRoot));
    Open;
    sPath     := FieldByName('Path').AsString;
    sPathName := FieldByName('PathName').AsString;
  finally
    Close;
  end;

  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT Path FROM TipoPessoa WHERE Path like ' + QuotedStr(sPath + '.%'));
    Open;
    iPath := 0;
    While not EOF do
    begin
      if StrToInt(Copy(FieldByName('Path').AsString, 6, 3)) > iPath then
        iPath := StrToInt(Copy(FieldByName('Path').AsString, 6, 3));
      Next;
    end;

    Path := sPath + '.' + FormatFloat('000', iPath+1);
  finally
    Close;
  end;


  IDTipoPessoa := DMExport.GetNextID('TipoPessoa.IDTipoPessoa');

  with DMExport.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO TipoPessoa(IDTipoPessoa, Path, TipoPessoa, PathName, LastCode)');
    SQL.Add(' VALUES (:IDTipoPessoa, :Path, :TipoPessoa, :PathName, :LastCode)');

    Parameters.ParamByName('IDTipoPessoa').Value   := IDTipoPessoa;
    Parameters.ParamByName('Path').Value           := Path;
    Parameters.ParamByName('PathName').Value       := sPathName + '\ ' + TipoPessoa;
    Parameters.ParamByName('TipoPessoa').Value     := TipoPessoa;
    Parameters.ParamByName('LastCode').Value       := 1;

    DMExport.RunCommand(DMExport.quFreeSQL);
  end;

  Result := True;
  
end;

{ TMicrochip }

function TMicrochip.Find: Boolean;
begin

  Result := False;

  with DMExport.quFreeSQL do
  try
    SQL.Clear;
    SQL.Add('SELECT IDMicrochip FROM Pet_Microchip WHERE Microchip = :Microchip');
    Parameters.ParamByName('Microchip').Value := Microchip;
    Open;
    if not IsEmpty then
    begin
      IDMicrochip := FieldByName('IDMicrochip').AsInteger;
      Result  := True;
    end;
  finally
    Close;
  end;

end;

function TMicrochip.Insert: Boolean;
var
  FCommand : TADOCommand;
begin

  if not Find then
  begin
    FCommand := TADOCommand.Create(nil);
    try
      FCommand.Connection := DMExport.ADODBConnect;
      FCommand.CommandText := 'INSERT Pet_Microchip (IDMicrochip, Microchip, Amount, IDModel) ' +
                              'VALUES (:IDMicrochip, :Microchip, :Amount, :IDModel) ';

      FCommand.Parameters.ParamByName('IDMicrochip').Value := DMExport.GetNextID('Pet_Microchip.IDMicrochip');
      FCommand.Parameters.ParamByName('Microchip').Value   := Microchip;
      FCommand.Parameters.ParamByName('Amount').Value      := Amount;
      FCommand.Parameters.ParamByName('IDModel').Value     := IDModel;

      FCommand.Execute();
    finally
      FreeAndNil(FCommand);
    end;
  end;

  Result := True;
    
end;

end.
