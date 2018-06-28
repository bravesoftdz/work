unit uDMValidateTextFile;

interface

uses
  SysUtils, Classes, ADODB, DBClient, DB;

type
  TDMValidateTextFile = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSQLConnection: TADOConnection;
    FTextFile: TClientDataSet;
    FLinkedColumns: TStringList;
    FImpExpConfig: TStringList;
    FLog: TStringList;    
  public
    function Validate: Boolean; virtual; abstract;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property TextFile: TClientDataSet read FTextFile write FTextFile;
    property LinkedColumns: TStringList read FLinkedColumns write FLinkedColumns;
    property ImpExpConfig: TStringList read FImpExpConfig write FImpExpConfig;
    property Log: TStringList read FLog write FLog;
  end;

implementation

{$R *.dfm}

procedure TDMValidateTextFile.DataModuleCreate(Sender: TObject);
begin
  FTextFile := TClientDataSet.Create(nil);
  FLinkedColumns := TStringList.Create;
  FImpExpConfig  := TStringList.Create;
  FLog := TStringList.Create;
end;

procedure TDMValidateTextFile.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FTextFile);
  FreeAndNil(FLinkedColumns);
  FreeAndNil(FImpExpConfig);
  FreeAndNil(FLog);
end;

end.
