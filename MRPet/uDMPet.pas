unit uDMPet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMGlobalNTier, SConnect, DB, DBClient, MConnect, ImgList,
  siComp, uUserObj, IdBaseComponent, IdComponent;

const
  URL_VERSION     = 'http://petcenter.360pet.com/2d1d26.html?mv_pc=';
  URL_SUP_VERSION = 'http://petcenter.360pet.com/2d1d26supplies.html';
  URL_HLP_VERSION = 'http://petcenter.360pet.com/2d1d26help.html';

type
  TDMPet = class(TDMGlobalNTier)
    PetCenterConn: TSharedConnection;
    MaintenanceConn: TSharedConnection;
    LookUpMaintenanceConn: TSharedConnection;
    LookUpPetConn: TSharedConnection;
    SearchPetConn: TSharedConnection;
    cdsPropertyDomain: TClientDataSet;
    cdsPropertyDomainProperty: TStringField;
    cdsPropertyDomainPropertyValue: TStringField;
    LookUpInventoryConn: TSharedConnection;
    ReportConn: TSharedConnection;
    cdsSysModule: TClientDataSet;
    cdsSysModuleModuleInfo: TStringField;
    cdsSysModuleVersionNo: TIntegerField;
    cdsSysModuleBuildNo: TIntegerField;
    cdsSysModuleSeats: TStringField;
    cdsSysModuleVersionType: TStringField;
    cdsSysModuleRestricForms: TMemoField;
    cdsParam: TClientDataSet;
    cdsParamIDParam: TIntegerField;
    cdsParamSrvParameter: TStringField;
    cdsParamSrvValue: TStringField;
    cdsParamSrvType: TStringField;
    cdsParamIDMenu: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FUser : TUser;
    FWebNews : String;
    FOnlineHelp : String;
    FWebMain : String;
    FLocalPath : String;
    FMRKey : String;
    FClientRpl : Boolean;
    FCorpRpl : Boolean;
    FPetIntegration : Boolean;
    procedure LoadWebInfo;
  protected
    procedure OnAfterConnect; override;
  public
    property SystemUser : TUser        read FUser            write FUser;
    property WebNews    : String       read FWebNews         write FWebNews;
    property OnlineHelp : String       read FOnlineHelp      write FOnlineHelp;
    property WebMain    : String       read FWebMain         write FWebMain;
    property LocalPath  : String       read FLocalPath       write FLocalPath;
    property MRKey      : String       read FMRKey           write FMRKey;
    property ClientRpl  : Boolean      read FClientRpl       write FClientRpl;
    property CorpRpl    : Boolean      read FCorpRpl         write FCorpRpl;
    property PetIntegration : Boolean  read FPetIntegration  write FPetIntegration;

    procedure SetPropertyDomain(AProperty: String; AValue : Variant);
    function GetPropertyDomain(AProperty: String) : Variant;
    procedure ApplyUpdatePropertyDomain;
    function Login : Boolean;
  end;

var
  DMPet: TDMPet;

implementation

uses uDMGlobal, uLoginForm, uMainRetailKeyConst;

{$R *.dfm}

procedure TDMPet.DataModuleCreate(Sender: TObject);
begin
  inherited;
  CreateControls;
  FUser := TUser.Create;
  FLocalPath := ExtractFilePath(Application.ExeName);
  LoadWebInfo;
end;

procedure TDMPet.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FUser);
end;

function TDMPet.GetPropertyDomain(AProperty: String): Variant;
begin
  Result := Null;
  with cdsPropertyDomain do
    if Active then
    begin
      if Locate('Property', AProperty, []) then
        Result := FieldByName('PropertyValue').Value;
    end;
end;

procedure TDMPet.SetPropertyDomain(AProperty: String; AValue: Variant);
begin
  with cdsPropertyDomain do
    if Active then
    begin
      if Locate('Property', AProperty, []) then
      begin
        Edit;
        FieldByName('PropertyValue').AsString := VarToStr(AValue);
        Post;
      end;
    end;
end;

procedure TDMPet.LoadWebInfo;
begin
  FWebMain    := URL_VERSION;
  FWebNews    := URL_SUP_VERSION;
  FOnlineHelp := URL_HLP_VERSION;
end;

procedure TDMPet.OnAfterConnect;
begin
  inherited;
  
  with cdsPropertyDomain do
    if not Active then
      Open;

  with cdsSysModule do
    if not Active then
    begin
      Open;
      DataSetControl.RestrictForms := FieldByName('RestricForms').AsString;
    end;

  with cdsParam do
    if not Active then
      Open;

  if cdsParam.Locate('IDParam', 91, []) then
  begin
    FPetIntegration := (cdsParam.FieldByName('SrvValue').AsString <> '');
  end
  else
    FPetIntegration := False;

  FClientRpl                            := ActiveConnection.AppServer.IsClientServer;
  FCorpRpl                              := ActiveConnection.AppServer.IsCorpServer;
  DataSetControl.SoftwareExpired        := ActiveConnection.AppServer.SoftwareAccess(SOFTWARE_PC);
  DataSetControl.SoftwareExpirationDate := ActiveConnection.AppServer.SoftwareGetExpDate(SOFTWARE_PC);
  FMRKey                                := ActiveConnection.AppServer.SoftwareKey;

end;


procedure TDMPet.ApplyUpdatePropertyDomain;
begin
  with cdsPropertyDomain do
    if Active then
      ApplyUpdates(0);
end;

function TDMPet.Login : Boolean;
begin

  if (FUser.ID = 0) then
  begin
    with TLoginForm.Create(Self) do
    try
      Result := Start;
    finally
      Free;
      end;
  end
  else
    Result := True;
end;

end.
