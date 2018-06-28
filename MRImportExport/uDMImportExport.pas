unit uDMImportExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MConnect, SConnect, DB, DBClient, ImgList, siComp,
  uDMGlobalNTier, IniFiles, ADODB, uUserObj, Registry;

type
  TDMImportExport = class(TDMGlobalNTier)
    ImportConn: TSharedConnection;
    cdsLookupStore: TClientDataSet;
    dtsLookupStore: TDataSource;
    cdsLookupVendor: TClientDataSet;
    dtsLookupVendor: TDataSource;
    cdsLookupUser: TClientDataSet;
    dtsLookupUser: TDataSource;
    cdsLUCatalogVendor: TClientDataSet;
    dtsLUCatalogVendor: TDataSource;
    cdsLookupVendorIDVendor: TIntegerField;
    cdsLookupVendorVendor: TStringField;
    ExportConn: TSharedConnection;
    cdsLookupCategory: TClientDataSet;
    dtsLookupCategory: TDataSource;
    CatalogConn: TSharedConnection;
    LookupInvConn: TSharedConnection;
    cdsLookupSubCategory: TClientDataSet;
    dtsLookupSubCategory: TDataSource;
    dtsLookupGroup: TDataSource;
    cdsLookupGroup: TClientDataSet;
    cdsLUCatalogDepartment: TClientDataSet;
    dtsLUCatalogDepartment: TDataSource;
    cdsLUCatalogCategory: TClientDataSet;
    dtsLUCatalogCategory: TDataSource;
    cdsLUCatalogSubCategory: TClientDataSet;
    dtsLUCatalogSubCategory: TDataSource;
    PetCenterConn: TSharedConnection;
    MaintConn: TSharedConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  protected
    procedure OnAfterConnect; override;
  public
    FUser    : TUser;
    FMRKey : String;
    FSoftwareExpired : Boolean;
    FSoftwareExpirationDate : TDateTime;
    procedure OpenStore;
    procedure OpenVendor;
    procedure OpenUser;
    procedure OpenCatalogVendor;
    procedure OpenCatalogDepartment;
    procedure OpenCatalogCategory;
    procedure OpenCatalogSubCategory;
    procedure OpenCategory;
    procedure OpenSubCategory;
    procedure OpenGroup;
    procedure CloseStore;
    procedure CloseVendor;
    procedure CloseUser;
    procedure CloseCatalogVendor;
    procedure CloseCatalogDepartment;
    procedure CloseCatalogCategory;
    procedure CloseCatalogSubCategory;
    procedure CloseCategory;
    procedure CloseSubCategory;
    procedure CloseGroup;

    function InsertConfigImport(AIDPessoa, AImportType: Integer;
      ACrossColumn: String; ACaseCost: Boolean): String;
    function GetConfigImport(AIDPessoa: Integer; AImportType: Smallint;
      var ACrossColumn : String; var ACaseCost : WordBool) : String;

    function InsertConfigExport(AIDPessoa: Integer; ADelimiterSeparator,
      ADecimalSeparator, AHeaderConfig, AFileFormat: String;
      AHeaderFile: Boolean; AExportType: Integer) : String;

    function GetConfigExport(AIDPessoa, AExportType: Integer;
      var ADelimiterSeparator, ADecimalSeparator, AHeaderConfig,
      AFileFormat: String; var AHeaderFile: WordBool): String;
  end;

var
  DMImportExport: TDMImportExport;

implementation

uses uOperationSystem, uDMGlobal, uMainRetailKeyConst;

{$R *.dfm}

{ TDMImport }

procedure TDMImportExport.OpenStore;
begin
  with cdsLookupStore do
    if not Active then
      Open;
end;

procedure TDMImportExport.CloseStore;
begin
  with cdsLookupStore do
    if Active then
      Close;
end;

procedure TDMImportExport.CloseUser;
begin
  with cdsLookupUser do
    if Active then
      Close;
end;

procedure TDMImportExport.OpenUser;
begin
  with cdsLookupUser do
    if not Active then
      Open;
end;

procedure TDMImportExport.CloseVendor;
begin
  with cdsLookupVendor do
    if Active then
      Close;
end;

procedure TDMImportExport.OpenVendor;
begin
  with cdsLookupVendor do
    if not Active then
      Open;
end;

procedure TDMImportExport.CloseCatalogVendor;
begin
  with cdsLUCatalogVendor do
    if Active then
      Close;
end;

procedure TDMImportExport.OpenCatalogVendor;
begin
  with cdsLUCatalogVendor do
    if not Active then
      Open;
end;

procedure TDMImportExport.CloseCategory;
begin
  with cdsLookupCategory do
    if Active then
      Close;
end;

procedure TDMImportExport.OpenCategory;
begin
  with cdsLookupCategory do
    if not Active then
      Open;
end;

procedure TDMImportExport.DataModuleCreate(Sender: TObject);
Var
  buildInfo: String;
begin
  inherited;
  FUser := TUser.Create;
  // Abre o registry
  with TRegistry.Create( KEY_READ OR $0100 ) do
    Try

     { Alex = 07/01/2011 }
     //RootKey := HKEY_LOCAL_MACHINE;
     if ( getOS(buildInfo) = osW7 ) then
        RootKey:= HKEY_CURRENT_USER
     else
        RootKey:= HKEY_LOCAL_MACHINE;


      OpenKey('SOFTWARE\Applenet\MainRetail', True);
      IDDefaulStore := ReadInteger('DefaultStoreID');
    finally
      Free;
    end;
end;

procedure TDMImportExport.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FUser);
  inherited;
end;

procedure TDMImportExport.CloseGroup;
begin
  with cdsLookupGroup do
    if Active then
      Close;
end;

procedure TDMImportExport.CloseSubCategory;
begin
  with cdsLookupSubCategory do
    if Active then
      Close;
end;

procedure TDMImportExport.OpenGroup;
begin
  with cdsLookupGroup do
    if not Active then
      Open;
end;

procedure TDMImportExport.OpenSubCategory;
begin
  with cdsLookupSubCategory do
    if not Active then
      Open;
end;

procedure TDMImportExport.OpenCatalogCategory;
begin
  with cdsLUCatalogCategory do
    if not Active then
      Open;
end;

procedure TDMImportExport.OpenCatalogDepartment;
begin
  with cdsLUCatalogDepartment do
    if not Active then
      Open;
end;

procedure TDMImportExport.OpenCatalogSubCategory;
begin
  with cdsLUCatalogSubCategory do
    if not Active then
      Open;
end;

procedure TDMImportExport.CloseCatalogCategory;
begin
  with cdsLUCatalogCategory do
    if Active then
      Close;
end;

procedure TDMImportExport.CloseCatalogDepartment;
begin
  with cdsLUCatalogDepartment do
    if Active then
      Close;
end;

procedure TDMImportExport.CloseCatalogSubCategory;
begin
  with cdsLUCatalogSubCategory do
    if Active then
      Close;
end;


procedure TDMImportExport.OnAfterConnect;
begin
  inherited;
  FSoftwareExpired := ActiveConnection.AppServer.SoftwareAccess(SOFTWARE_IE);
  FSoftwareExpirationDate := ActiveConnection.AppServer.SoftwareGetExpDate(SOFTWARE_IE);
  FMRKey := ActiveConnection.AppServer.SoftwareKey;
end;

function TDMImportExport.InsertConfigImport(AIDPessoa, AImportType: Integer;
  ACrossColumn: String; ACaseCost: Boolean): String;
var
  sError: String;
begin
  ImportConn.AppServer.InsertConfigImport(AIDPessoa, AImportType,
                                          ACrossColumn, ACaseCost, sError);
  Result := sError;
end;

function TDMImportExport.GetConfigImport(AIDPessoa: Integer;
  AImportType: Smallint; var ACrossColumn: String;
  var ACaseCost: WordBool): String;
var
  sCrossColumn, sError: String;
  bCaseCost: WordBool;
begin
  ImportConn.AppServer.GetConfigImport(AIDPessoa, AImportType,
                                       sCrossColumn, bCaseCost, sError);
  ACrossColumn := sCrossColumn;
  ACaseCost := bCaseCost;

  Result := sError;
end;

function TDMImportExport.InsertConfigExport(AIDPessoa: Integer;
  ADelimiterSeparator, ADecimalSeparator, AHeaderConfig, AFileFormat: String;
  AHeaderFile: Boolean; AExportType: Integer): String;
var
  sError: String;
begin
  ExportConn.AppServer.InsertConfigExport(AIDPessoa, ADelimiterSeparator,
                                          ADecimalSeparator, AHeaderConfig,
                                          AFileFormat, AHeaderFile, AExportType,
                                          sError);
  Result := sError;
end;

function TDMImportExport.GetConfigExport(AIDPessoa, AExportType: Integer;
  var ADelimiterSeparator, ADecimalSeparator, AHeaderConfig,
  AFileFormat: String; var AHeaderFile: WordBool): String;
var
  sDelimiterSeparator, sDecimalSeparator, sHeaderConfig, sFileFormat, sError: String;
  sHeaderFile: WordBool;
begin
  ExportConn.AppServer.GetConfigExport(AIDPessoa, AExportType,
                                        sDelimiterSeparator, sDecimalSeparator,
                                        sHeaderConfig, sFileFormat,
                                       sHeaderFile, sError);

  ADelimiterSeparator := sDelimiterSeparator;
  ADecimalSeparator := sDecimalSeparator;
  AHeaderConfig := sHeaderConfig;
  AFileFormat := sFileFormat;
  AHeaderFile := sHeaderFile;

  Result := sError;
end;

end.
