unit AddTagModelView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPromoItem, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ADODB, siComp, siLangRT, Buttons,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, Mask, SuperComboADO,
  StdCtrls, LblEffct, ExtCtrls;

type
  TfrmAddTagModel = class(TFrmPromoItem)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    sysRegistry: TClientDataset;
    procedure Save;
  public
    { Public declarations }
    cdsItemsToDropDown: TClientDataset;
    function start(AID, AIDPromoItem, APromoType :Integer): Boolean;
  end;

implementation

uses uDM, SysRegistryDAO;

{$R *.dfm}

procedure TfrmAddTagModel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;


end;

procedure TfrmAddTagModel.btSaveClick(Sender: TObject);
begin
//  inherited;
   save;
end;

procedure TfrmAddTagModel.Save;
begin
   cdsItemsToDropDown := cdsPromoItems;
  // save state component to system_registry
  try
    if ( not sysRegistry.FieldByName('Id').IsNull ) then begin
       dm.updateTagModelRegistryAttName(intToStr(cbTypeSearch.itemIndex), sysRegistry.fieldByName('Id').Value);
    end;
  except
    on e: Exception do begin
       raise e.Create(format('Erro found: %s', [e.Message]));
    end;
  end;
end;

procedure TfrmAddTagModel.FormCreate(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmAddTagModel.FormDestroy(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmAddTagModel.FormShow(Sender: TObject);
var
  attName: String;
begin
//  inherited;
  // read from system_registry
  attName := 'TagModel.cbTypeSearch.ItemIndex';
  sysRegistry := dm.getTagModelRegistryAttName(attName);

  if (trim(attName) = trim(sysRegistry.fieldByName('AttributeName').asstring) ) then
    cbTypeSearch.ItemIndex := strToInt(sysRegistry.fieldByName('AttributeValue').Value)
  else
     dm.insertTagModelRegistryAttName(intToStr(cbTypeSearch.itemIndex));

end;

function TfrmAddTagModel.start(AID, AIDPromoItem,
  APromoType: Integer): Boolean;
begin
  lblUserName.Caption := DM.fUser.UserName;
  lblUserName.Left := Label15.Left + Label15.Width + 3;
  lblUserName.Top := Label15.Top;

  cdsPromoItems.CreateDataSet;
  
  ShowModal;

  ModalResult := mrOk;

end;

procedure TfrmAddTagModel.btCloseClick(Sender: TObject);
begin
  //inherited;
  freeAndNil(sysRegistry);
  close;


end;

end.
