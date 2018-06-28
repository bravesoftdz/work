unit uEntityFields;

interface

uses Classes, SysUtils, Windows, MConnect, ADODB;

type
  TEntityFields = class(TObject)
  private
    FADOConn : TADOConnection;
    FADODateSet : TADODataSet;
  public
    constructor Create(AADOConn: TADOConnection);
    destructor Destroy; override;
    property ADOConn: TADOConnection read FADOConn write FADOConn;
  end;

implementation

{ TEntityFields }

constructor TEntityFields.Create(AADOConn: TADOConnection);
begin

  FADOConn               := AADOConn;
  FADODateSet            := TADODataSet.Create(nil);
  FADODateSet.Connection := FADOConn;

  inherited Create;
end;

destructor TEntityFields.Destroy;
begin
  FreeAndNil(FADODateSet);
  inherited Destroy;
end;

end.
