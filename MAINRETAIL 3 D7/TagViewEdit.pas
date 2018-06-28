unit TagViewEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, FormConfig, ADODB, PowerADOQuery,
  siComp, siLangRT, StdCtrls, Buttons, LblEffct, dbClient, PromoDTO;

type
  TfrmTagViewEdit = class(TbrwFrmParent)
    Panel5: TPanel;
    Splitter1: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnlComand: TPanel;
    btAdd: TSpeedButton;
    btRemove: TSpeedButton;
    btColumn: TSpeedButton;
    grdBrowse: TcxGrid;
    grdBrowseDB: TcxGridDBTableView;
    grdBrowseLevel: TcxGridLevel;
    grdTag: TcxGrid;
    grdTagDB: TcxGridDBTableView;
    grdTagLevel: TcxGridLevel;
    Bevel1: TBevel;
    grdBrowseDBDBColumn1: TcxGridDBColumn;
    grdBrowseDBDBColumn2: TcxGridDBColumn;
    Label1: TLabel;
    grdTagDBDBColumn1: TcxGridDBColumn;
    grdTagDBDBColumn2: TcxGridDBColumn;
    edtTag: TEdit;
    Panel9: TPanel;
    addPriceBreak: TSpeedButton;
    spbRemove: TSpeedButton;
    dsTagPriceBreak: TDataSource;
    dsTagModel: TDataSource;
    grdBrowseDBDBColumn3: TcxGridDBColumn;
    grdBrowseDBDBColumn4: TcxGridDBColumn;
    grdBrowseDBDBColumn5: TcxGridDBColumn;
    grdBrowseDBDBColumn6: TcxGridDBColumn;
    grdBrowseDBDBColumn7: TcxGridDBColumn;
    grdBrowseDBDBColumn8: TcxGridDBColumn;
    grdBrowseDBDBColumn9: TcxGridDBColumn;
    btActive: TButton;
    btDeactivate: TButton;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure dsFormStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure addPriceBreakClick(Sender: TObject);
    procedure spbRemoveClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btNextRecClick(Sender: TObject);
    procedure btLastRecClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btActiveClick(Sender: TObject);
    procedure btDeactivateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fIdTag: Integer;
    fRegistryPath: String;
    AViewGridModel, viewGridPrice : TcxCustomGridTableView;
    fOper: String[1];
    fTagBrowsePriceBreak: TADOStoredProc;
    fTagBrowseModel: TADOStoredProc;
    fTagSelected: TADOStoredProc;
    procedure btCloseClick(Sender: TObject);
    procedure navigate(arg_idTag: Integer);
    procedure insertTagModel(arg_cdsModel: TClientDataset; arg_oper: String; arg_idTag: Integer);
    procedure upsertTag(arg_idTag: Integer; arg_tagName: String);
    procedure ActivateAll(argIdModelList: String);
    procedure DeactivateAll(argIdModelList: string);
    function GetIdModelList(): String;
    procedure RefreshTagModel();
    procedure DisableAllControls();
  public
    { Public declarations }
    function start(arg_tagSelected: TADOStoredProc; arg_oper: String = 'I'): Boolean; overload;
    function Start(tagSelected: TDiscountPurchase; oper: String = 'U'): Boolean; overload;
  end;


implementation
uses uDM, TagQtyPriceBreakViewEdit, addTagModelView, uSystemConst, uMsgBOX, uMsgConstant,
  PaiDeTodos;

{$R *.dfm}

procedure TfrmTagViewEdit.btCloseClick(Sender: TObject);
begin
//  inherited;

end;

function TfrmTagViewEdit.start(arg_tagSelected: TADOStoredProc; arg_oper: String = 'I'): Boolean;
var
  AOptions: TcxGridStorageOptions;
begin
  lblUserName.Caption := DM.fUser.UserName;
  lblUserName.Left := Label15.Left + Label15.Width + 3;
  lblUserName.Top := Label15.Top;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AViewGridModel), fRegistryPath, AOptions);

  fOper := arg_oper;
  fTagSelected := arg_tagSelected;

  if ( arg_oper = 'I' ) then begin
     fIdTag := 0;
     navigate(-1);
     edtTag.Clear;
  end
  else begin
     fIdTag := ftagSelected.fieldByName('idTag').Value;
     navigate(fIdTag);
     edtTag.Text := arg_tagSelected.fieldByName('TagName').Value;
  end;

  showModal;

  DM.SaveGridToRegistry(TcxGridDBTableView(AViewGridModel), fRegistryPath, True, AOptions);

  result := true;
end;

procedure TfrmTagViewEdit.quFormAfterOpen(DataSet: TDataSet);
begin
//  inherited;

end;

procedure TfrmTagViewEdit.quFormPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
//  inherited;

end;

procedure TfrmTagViewEdit.dsFormStateChange(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmTagViewEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
//  inherited;

end;

procedure TfrmTagViewEdit.FormCreate(Sender: TObject);
begin
//  inherited;
  AViewGridModel := TcxCustomGridTableView(grdBrowse.FocusedView);

end;

procedure TfrmTagViewEdit.FormDestroy(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmTagViewEdit.btAddClick(Sender: TObject);
var
  frmTagModelEdit : TfrmAddTagModel;
  cdsModels: TClientDataset;
begin
//  inherited;
  try
    frmTagModelEdit := TfrmAddTagModel.Create(self);
    frmTagModelEdit.Start(0, 0, 0);
    cdsModels := frmTagModelEdit.cdsItemsToDropDown;

    if ( cdsModels <> nil ) then begin
       upsertTag(fIdTag, edtTag.Text); // get a valid IdTag if there is no yet.
       insertTagModel(cdsModels, 'I', fIdTag);
    end;

    navigate(fIdTag);
  finally
    freeAndNil(frmTagModelEdit);
  end;
end;

procedure TfrmTagViewEdit.addPriceBreakClick(Sender: TObject);
var
  frmTagQtyPriceBreak: TfrmTagQtyPriceBreak;
begin
//  inherited;
  try

    if ( trim(edtTag.Text) = '' ) then begin
       MsgBox(MSG_CRT_TAG_NOBLANK, vbCritical + vbOKOnly);
       edtTag.SetFocus();
       exit;
    end;

    upsertTag(fIdTag, edtTAg.Text);

    frmTagQtyPriceBreak := TfrmTagQtyPriceBreak.Create(self);

    frmTagQtyPriceBreak.start(fIdTag, 'I');
    navigate(fIdTag);
  except
     on e: Exception do begin
        raise Exception.Create(e.message);
     end;
  end;
end;

procedure TfrmTagViewEdit.spbRemoveClick(Sender: TObject);
begin
//  inherited;
  dm.callSpTagQtyPriceBreakDelete(fTagBrowsePriceBreak.fieldByName('IdTag').Value, fTagBrowsePriceBreak.fieldByName('MinQuantity').Value);
  navigate(fTagBrowsePriceBreak.fieldByName('IdTag').Value);
end;

procedure TfrmTagViewEdit.btFirstRecClick(Sender: TObject);
begin
//  inherited;
  fTagSelected.First;
  edtTag.Text := fTagSelected.fieldByName('TagName').Value;
  navigate(fTagSelected.fieldByName('IdTag').Value);
end;

procedure TfrmTagViewEdit.navigate(arg_idTag: Integer);
begin
  fTagBrowsePriceBreak := dm.callSpTagQtyPriceBreakSelect(arg_idTag);
  dsTagPriceBreak.DataSet := fTagBrowsePriceBreak;

  fTagBrowseModel := dm.callSpTagModelSelect(arg_idTag);
  dsTagModel.DataSet := fTagBrowseModel;

  btRemove.Enabled := not fTagBrowseModel.IsEmpty;


end;

procedure TfrmTagViewEdit.btPriorRecClick(Sender: TObject);
begin
  //inherited;
  fTagSelected.Prior;
  edtTag.Text := fTagSelected.fieldByName('TagName').Value;
  navigate(fTagSelected.fieldByName('IdTag').Value);
end;

procedure TfrmTagViewEdit.btNextRecClick(Sender: TObject);
begin
 // inherited;
  fTagSelected.Next;
  edtTag.Text := fTagSelected.fieldByName('TagName').Value;
  navigate(fTagSelected.fieldByName('IdTag').Value);
end;

procedure TfrmTagViewEdit.btLastRecClick(Sender: TObject);
begin
 // inherited;
  fTagSelected.Last;
  edtTag.Text := fTagSelected.fieldByName('TagName').Value;
  navigate(fTagSelected.fieldByName('IdTag').Value);
end;

procedure TfrmTagViewEdit.insertTagModel(arg_cdsModel: TClientDataset; arg_oper: String; arg_idTag: Integer);
begin
   arg_cdsModel.first;
   while ( not arg_cdsModel.Eof ) do begin
     dm.callSpTagModelUpSert(arg_idTag, arg_cdsModel.fieldByName('IdModel').Value);
     arg_cdsModel.Next;
   end;

   navigate(fIdTag);

end;

procedure TfrmTagViewEdit.btRemoveClick(Sender: TObject);
begin
//  inherited;
  dm.callSpTagModelDelete(fTagBrowseModel.fieldByName('PKTagModel').Value);
  navigate(fIdTag);
end;

procedure TfrmTagViewEdit.btColumnClick(Sender: TObject);
begin
//  inherited;
  TcxGridDBTableView(AViewGridModel).Controller.Customization := not
                  TcxGridDBTableView(AViewGridModel).Controller.Customization;
end;

procedure TfrmTagViewEdit.upsertTag(arg_idTag: Integer;
  arg_tagName: String);
begin
    if ( arg_idTag <= 0 ) then begin
       dm.callSpTagUpSert(fIdTag, edtTag.Text, 'I');
    end else begin
           dm.callSpTagUpSert(fIdTag, edtTag.Text, 'U');
        end;

end;

procedure TfrmTagViewEdit.btCancelClick(Sender: TObject);
begin
  upsertTag(fIdTag, edtTag.Text);
  inherited;

end;

procedure TfrmTagViewEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ( ( key = VK_F2 ) and ( btAdd.Enabled )) then begin
     btAddClick(sender);
  end else if ( ( key = VK_F4 ) and ( btRemove.Enabled ) ) then begin
           btRemoveClick(sender);
      end;
end;

procedure TfrmTagViewEdit.ActivateAll(argIdModelList: String);
begin
  if ( length(argIdModelList) > 0 ) then begin
     dm.ActivateTagModel(fIdTag, argIdModelList, TRUE);
     RefreshTagModel();
  end;
end;

procedure TfrmTagViewEdit.DeactivateAll(argIdModelList: String);
begin
  if ( length(argIdModelList) > 0 ) then begin
      dm.ActivateTagModel(fIdTag, argIdModelList, FALSE);
      RefreshTagModel();
  end;
end;

function TfrmTagViewEdit.GetIdModelList(): String;
var
  i: Integer;
  idModelList: String;
  AView: TcxGridDBTableView;
begin
  Aview := grdBrowseDB;
  Aview.DataController.DataSet.DisableControls;
  if ( AView.Controller.SelectedRowCount > 0 ) then begin
      Aview.DataController.DataSet.First;
      for i := 0 to PRED(Aview.Controller.SelectedRowCount) do begin
         if ( idModelList = '' ) then begin
            idModelList := Aview.DataController.DataSet.fieldByName('IdModel').AsString;
         end else begin
                 idModelList := idModelList + ', ' + Aview.DataController.DataSet.fieldByName('IdModel').AsString;
             end;
           Aview.DataController.DataSet.Next;
      end;
      result := idModelList;
  end else begin
           ShowMessage('There are no rows selected');
      end;

  Aview.Controller.ClearSelection;
  Aview.DataController.DataSet.EnableControls;

end;

procedure TfrmTagViewEdit.RefreshTagModel();
begin
   navigate(fIdTag);
end;

procedure TfrmTagViewEdit.btActiveClick(Sender: TObject);
begin
  inherited;
  ActivateAll(GetIdModelList());
end;

procedure TfrmTagViewEdit.btDeactivateClick(Sender: TObject);
begin
  inherited;
  DeactivateAll(GetIdModelList());
end;

procedure TfrmTagViewEdit.FormShow(Sender: TObject);
begin
//  inherited;

end;

function TfrmTagViewEdit.start(tagSelected: TDiscountPurchase;
  oper: String): Boolean;
var
  AOptions: TcxGridStorageOptions;
begin
  lblUserName.Caption := DM.fUser.UserName;
  lblUserName.Left := Label15.Left + Label15.Width + 3;
  lblUserName.Top := Label15.Top;

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AViewGridModel), fRegistryPath, AOptions);

  navigate(TDiscountPurchase(tagSelected).getIDTag());
  edtTag.Text := TDiscountPurchase(tagSelected).getName();
  DisableAllControls();
  showModal;

  DM.SaveGridToRegistry(TcxGridDBTableView(AViewGridModel), fRegistryPath, True, AOptions);

  result := true;

end;

procedure TfrmTagViewEdit.DisableAllControls;
begin

  // Antonio, 2017 Oct 10 Panel1.Enabled := false;

  // navigation
  btFirstRec.Enabled := false;
  btPriorRec.Enabled := btFirstRec.Enabled;
  btNextRec.Enabled := btFirstRec.Enabled;
  btLastRec.Enabled := btFirstRec.Enabled;

  // activate / deactivate buttons
  btActive.Enabled := btFirstRec.Enabled;
  btDeactivate.Enabled := btFirstRec.Enabled;

  // close and cancel buttons
  btClose.Enabled := true;
  btCancel.Enabled := btFirstRec.Enabled;

  pnlComand.Enabled := false;
end;

end.
