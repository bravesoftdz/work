unit uSysModules;

interface

uses Classes, SysUtils, Variants, ADODB;

const
  //Import/Export
  CAT_PRICE_COM  = 'CAT_PRICE_COM'; //Catalog - Price Comparison
  CAT_INV_UPD    = 'CAT_INV_UPD';   //Catalog - Inventory Update
  CAT_SRCH       = 'CAT_SRCH';      //Catalog - Catalog Search
  CAT_SYNC       = 'CAT_SYNC';      //Catalog - Synchronize Data

  EXP_PO         = 'EXP_PO';        //Export - Purchase Order
  EXP_PEACHTREE  = 'EXP_PEACHTREE'; //Export - Peachtree

  IMP_PO         = 'IMP_PO';        //Import - Purchase Order File
  IMP_INV        = 'IMP_INV';       //Import - Inventory File
  IMP_ENTITY     = 'IMP_ENTITY';    //Import - Entity File
  IMP_PET        = 'IMP_PET';       //Import - Pet File

type
  TSoftware = class
    SoftwareName : String;    
    Expires : TDateTime;
    Computers : Integer;
    Users : Integer;
    Modules : WideString;
  end;

  TMainRetailSystem = class
    Key : String;
    FSoftwareList : TStringList;
    FQuery : TADOQuery;
    FADODBConnect: TADOConnection;
    function GetKey : Boolean;
    public
      constructor Create();
      destructor Destroy(); override;
  end;

{
  1 - Pegar a chave do banco
  2 - baixar do site http://license.mainretail.net/4D57ED29-7F37-464B-89B9-FD1A1ECAB4AE.lic
  3 - Comparar a chave
  4 - Preencher o objeto de software com modulos
  5 - Gravar os modulos no banco de dados
}

implementation

{ TMainRetailSystem }

constructor TMainRetailSystem.Create;
begin
  FSoftwareList := TStringList.Create;
  FQuery := TADOQuery.Create(nil);
end;

destructor TMainRetailSystem.Destroy;
var
  obj : TObject;
begin
  if Assigned(FSoftwareList) then
  begin
    while FSoftwareList.Count > 0 do
    begin
      obj := FSoftwareList.Objects[0];
      if (obj <> nil) then
        FreeAndNil(obj);
      FSoftwareList.Delete(0);
    end;
    FreeAndNil(FSoftwareList);
  end;

  FreeAndNil(FQuery);

  inherited;
end;

function TMainRetailSystem.GetKey: Boolean;
begin
  Result := True;

  FQuery.Connection := FADODBConnect;


end;

end.
