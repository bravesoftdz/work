unit uDMReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMGlobalNTier, SConnect, DB, DBClient, MConnect, ImgList,
  siComp, IniFiles, uUserObj;

type
  TDMReport = class(TDMGlobalNTier)
    ReportConn: TSharedConnection;
    LuInventoryConn: TSharedConnection;
    LuMaintenanceConn: TSharedConnection;
    LuPurchaseConn: TSharedConnection;
    LuPetConn: TSharedConnection;
    LuSOConn: TSharedConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  protected
    procedure OnAfterConnect; override;
  public
    FUser    : TUser;
    FAppPath : String;
    FConnString : String;
    procedure SetReportPath;
  end;

var
  DMReport: TDMReport;

implementation

{$R *.dfm}

procedure TDMReport.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FUser := TUser.Create;
  SetReportPath;
end;

procedure TDMReport.SetReportPath;
var
  ReportPath: String;
begin
  with FAppInfo do
  begin
    ReportPath := ReadString('Default', 'ReportPath', '');
    FAppPath   := ReportPath;
    LanguageDispatcher.ActiveLanguage := (StrToIntDef(DMReport.GetAppProperty('Default', 'IDLanguage'),0)+1);

    if ReportPath = '' then
       WriteString('Default', 'ReportPath', '');
  end;
end;

procedure TDMReport.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FUser);
end;

procedure TDMReport.OnAfterConnect;
begin
  inherited;
  FConnString := ActiveConnection.AppServer.GetConnectionString;
end;

end.
