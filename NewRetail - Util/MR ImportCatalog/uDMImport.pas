unit uDMImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMGlobal, MConnect, SConnect, DB, DBClient, ImgList, siComp;

type
  TDMImport = class(TDMGlobal)
    ImportConn: TSharedConnection;
    cdsLookupStore: TClientDataSet;
    dtsLookupStore: TDataSource;
    cdsLookupVendor: TClientDataSet;
    dtsLookupVendor: TDataSource;
    cdsLookupUser: TClientDataSet;
    dtsLookupUser: TDataSource;
  private
    { Private declarations }
  public
  end;

var
  DMImport: TDMImport;

implementation

uses uOperationSystem;

{$R *.dfm}

{ TDMImport }


end.
