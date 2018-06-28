unit SelectCorporateView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls,
  StoreCls, StoreDAO, StoreSysRegistryCls, SysRegistryDAO, ADODB;

type
  TdlgSelectCorpView = class(TDialogParent)
    Label1: TLabel;
    cbbStores: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
  private
    { Private declarations }
    store: TStoreRegistry;
    storeDao: TStoreDAO;
    stores: TList;
    connection: TADOConnection;
  public
    { Public declarations }
    function start(connection: TADOConnection): Boolean;
  end;

implementation
uses uDM, SysRegistryCls;

{$R *.dfm}

{ TdlgSelectCorpView }

function TdlgSelectCorpView.start(connection: TADOConnection): Boolean;
var
  sysRegDAO: TSysRegistryDAO;
  i: Integer;
begin
  self.connection := connection;
  storeDao := TStoreDAO.create(self.connection);
  stores := storeDao.getStores();

  for i:= 0 to stores.Count - 1 do begin
      //cbbStores.Items.Add(TStoreSysRegistry(stores[i]).AtributeName);
      cbbStores.AddItem(TStoreRegistry(stores[i]).Name, TObject(stores[i]));
  end;

  for i:= (stores.Count - 1) downto 0 do begin
      stores.Delete(i);
  end;

  stores.Free;

  sysRegDAO := TSysRegistryDAO.create(connection);
  if ( not sysRegDAO.isEmpty ) then begin
      ModalResult := mrOK;
  end
  else
      self.ShowModal;
  freeAndNil(sysRegDAO);
end;

procedure TdlgSelectCorpView.FormCreate(Sender: TObject);
var
  stores: TList;
begin
  inherited;
  stores := TList.Create;
end;

procedure TdlgSelectCorpView.AplicarClick(Sender: TObject);
var
  sysRegistryDao: TSysRegistryDAO;
  sysRegistry: TSysRegistry;
  store: TStoreRegistry;
begin
  inherited;
  sysRegistry := TStoreSysRegistry.Create;
  store := TStoreRegistry(cbbStores.Items.Objects[cbbStores.ItemIndex]);

  sysRegistry.AttributeValue := intToStr(store.IdStore);
  sysRegistry.AttributeName := 'Database.Default.IDStore';
  sysRegistry.AttributeType := 'Int';
  sysRegistry.ConstraintValue := '1';
  sysRegistry.ConstraintType := 2;

  sysRegistryDao := TSysRegistryDAO.create(self.connection);
  sysRegistryDao.setRegistry(sysRegistry);
  sysRegistryDao.insert();

  freeAndNil(store);
  freeAndNil(sysRegistry);
  FreeAndNil(sysRegistryDAO);

  ModalResult := mrOK;
  close();
end;

end.
