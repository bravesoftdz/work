
unit MRPuppySettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Buttons, ComCtrls, siComp, siLangRT, StdCtrls,
  LblEffct, ExtCtrls, DBCtrls, ADODB, Mask, DBClient, Provider,
  MRPuppyIntegrationCls;

type
  TfrmPuppySetting = class(TFrmParent)
    PageControl: TPageControl;
    tabGlobal: TTabSheet;
    tabLocal: TTabSheet;
    btnSave: TBitBtn;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel4: TPanel;
    gridServicesDBTableView1: TcxGridDBTableView;
    gridServicesLevel1: TcxGridLevel;
    gridServices: TcxGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lkpPetCateg: TDBLookupComboBox;
    lkpServCateg: TDBLookupComboBox;
    lkpKitCateg: TDBLookupComboBox;
    gridServicesDBTableView1DBColumn2: TcxGridDBColumn;
    gridServicesDBTableView1DBColumn3: TcxGridDBColumn;
    openSale: TOpenDialog;
    openAvaile: TOpenDialog;
    pnWait: TPanel;
    qryPetCategory: TADOQuery;
    dsPetCategory: TDataSource;
    qryGlobal: TADOQuery;
    qryLocal: TADOQuery;
    qryGlobalDetail: TADOQuery;
    dsGlobal: TDataSource;
    dsLocal: TDataSource;
    dsGlobalDetail: TDataSource;
    dspGlobalDetail: TDataSetProvider;
    cdsGlobalDetail: TClientDataSet;
    dsModel: TDataSource;
    qryModel: TADOQuery;
    grbPuppy: TGroupBox;
    grbAvail: TGroupBox;
    Label4: TLabel;
    edtSaleExec: TDBEdit;
    btnSalePath: TBitBtn;
    gridServicesDBTableView1DBColumn1: TcxGridDBColumn;
    gridServicesDBTableView1DBColumn4: TcxGridDBColumn;
    gridServicesDBTableView1DBColumn5: TcxGridDBColumn;
    qryKitCategory: TADOQuery;
    dsKitCategory: TDataSource;
    qryPetServiceCategory: TADOQuery;
    dsPetService: TDataSource;
    cmbServer: TDBComboBox;
    Label5: TLabel;
    pnAvail: TPanel;
    Label6: TLabel;
    edtAvail: TDBEdit;
    Label7: TLabel;
    cmbPetFrequency: TDBComboBox;
    btnRun: TBitBtn;
    btnAvailPath: TBitBtn;
    Edit1: TEdit;
    Label8: TLabel;
    btnSaveSchedule: TBitBtn;
    Label9: TLabel;
    procedure btnSalePathClick(Sender: TObject);
    procedure btnAvailPathClick(Sender: TObject);
    procedure edtSaleExecMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtAvailMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
//    procedure cmbServerCloseUp(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure lkpPetCategCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lkpKitCategCloseUp(Sender: TObject);
    procedure lkpServCategCloseUp(Sender: TObject);
    procedure cmbPetFrequencyChange(Sender: TObject);
    procedure cmbServerChange(Sender: TObject);
    procedure btnSaveScheduleClick(Sender: TObject);
  private
    { Private declarations }
    PuppyIntegration: TMRPuppyIntegration;
    function OpenGlobalSettting: boolean;
    function OpenGlobalSettingDetail: boolean;
    function OpenLocalSetting: boolean;
    function OpenPetCategory: boolean;
    function OpenKitCategory: boolean;
    function OpenServiceCategory: boolean;

    function getPetCategory: String;
    function getPetKitCategory: String;
    function getPetServiceCategory: String;

    function getGlobalSettingSQL: String;
    function getGlobalSettingDetailSQL: String;
    function getLocalSettingSQL: String;
    function setServiceToModel(cdsDetailSetting: TClientDataSet): boolean;
    function UpdateServiceModel(cdsDetailSetting: TClientDataset): boolean;
    function getMaxId(tableName, IdName: String): Integer;
    function ValidatePuppySettings: boolean;

    //amfsouza May 14, 2012
    function getValidIdModel(description: String): Integer;
  public
    { Public declarations }
    sParam: String;

    function Start: boolean;
  end;

var
  frmPuppySetting: TfrmPuppySetting;

implementation
uses uDM;

{$R *.dfm}

{ TfrmPuppySetting }

function TfrmPuppySetting.Start: boolean;
begin
  //amfsouza 09.29.2011 - begin
  PuppyIntegration := TMRPuppyIntegration.Create(dm.ADODBConnect);
  PuppyIntegration.StoreId := dm.fStore.IDStoreSale;
  //amfsouza 09.29.2011 - end

  OpenLocalSetting;
  if ( qryLocal.IsEmpty ) then
     qryLocal.Insert
  else
     qryLocal.Edit;

  OpenPetCategory;
  OpenKitCategory;
  OpenServiceCategory;
  OpenGlobalSettting;

  qryModel.Open;

  if ( lkpPetCateg.Text <> '' ) then
    lkpPetCategCloseUp(self);

  if ( lkpKitCateg.Text <> '' ) then
    lkpKitCategCloseUp(self);

  if ( lkpServCateg.Text <> '' ) then
    lkpServCategCloseUp(self);

  if ( qryLocal.State = dsInsert ) then
      cmbServer.ItemIndex := cmbServer.Items.IndexOf('False')
  else
     cmbServer.ItemIndex  := cmbServer.Items.IndexOf(qryLocal.fieldByName('PuppyInstalled').Value);
  cmbServerChange(self);
  result := ShowModal = mrOK;
end;

procedure TfrmPuppySetting.btnSalePathClick(Sender: TObject);
begin
  inherited;
  if ( openSale.Execute ) then begin
     edtSaleExec.Text := openSale.FileName;
  end;
end;

procedure TfrmPuppySetting.btnAvailPathClick(Sender: TObject);
begin
  inherited;
  if ( openAvaile.Execute ) then begin
     edtAvail.Text := openAvaile.FileName;
  end;
end;

procedure TfrmPuppySetting.edtSaleExecMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ( trim(edtSaleExec.Text) <> '' ) then
     edtSaleExec.Hint := edtSaleExec.Text;
end;

procedure TfrmPuppySetting.edtAvailMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ( trim(edtAvail.Text) <> '' ) then
     edtAvail.Hint := edtAvail.Text;
end;

(*
procedure TfrmPuppySetting.cmbServerCloseUp(Sender: TObject);
begin
  inherited;
  pnAvail.Visible := ( cmbServer.ItemIndex = 0 );
end;
*)

procedure TfrmPuppySetting.btnRunClick(Sender: TObject);
var
   endProcess: boolean;
begin
  inherited;

  if ( not ValidatePuppySettings ) then
     exit;


  try
      pnWait.Visible := true;
      pnWait.Align   := alClient;

      PuppyIntegration.FileExeName360Import := edtAvail.Text;
      PuppyIntegration.FileExeNameSale      := edtSaleExec.Text;

      endProcess := PuppyIntegration.RunNow;

      edit1.Text := PuppyIntegration.getRunExeFileName;
      pnWait.Repaint;
      Application.ProcessMessages;

      if ( not cdsGlobalDetail.Active ) then begin
          OpenGlobalSettingDetail;
          cdsGlobalDetail.Open;
          TFloatField(cdsGlobalDetail.FieldByName('price')).DisplayFormat := '#,##0.00';
      end;

      PuppyIntegration.CdsServiceMapList.Filter := 'IdModel > 0';
      PuppyIntegration.CdsServiceMapList.Filtered := true;
      while ( not PuppyIntegration.CdsServiceMapList.Eof ) do begin
         cdsGlobalDetail.Filter   := 'ServiceMap = ' + quotedStr(PuppyIntegration.CdsServiceMapList.fieldByName('Service').Value);// + ' and IdModel is not NULL';
         cdsGlobalDetail.Filtered := true;
         if ( cdsGlobalDetail.IsEmpty ) then begin
            cdsGlobalDetail.Append;
            cdsGlobalDetail.FieldByName('ServiceMap').Value := PuppyIntegration.CdsServiceMapList.fieldByname('service').Value;
            cdsGlobalDetail.FieldByName('IdModel').Value := PuppyIntegration.CdsServiceMapList.fieldByname('idmodel').Value;
            cdsGlobalDetail.fieldByName('price').value := 0;
            cdsGlobalDetail.fieldByName('description').value := PuppyIntegration.CdsServiceMapList.fieldByname('service').Value;
            cdsGlobalDetail.FieldByName('requireonsale').Value := false;
            cdsGlobalDetail.Post;
         end;
         PuppyIntegration.CdsServiceMapList.Next;
      end;

      cdsGlobalDetail.Filtered := false;
      pnWait.Visible := false;
      pageControl.ActivePageIndex := 0;
  except
      on e:Exception do begin
         raise Exception.Create(e.Message);
      end;
  end;
end;

function TfrmPuppySetting.getGlobalSettingDetailSQL: String;
begin

  (*result :=
       'select m.model ' +
       ',m.idmodel     ' +
       ',gsd.ServiceMap  ' +
       ',gsd.RequireOnSale '+
       'from model m       '+
       'join tabGroup t on m.GroupID = t.IDGroup '+
       'left outer join PT_GlobalSettingDetail gsd on m.IDModel = gsd.IdModel '+
       'where t.PuppyTracker = 0  ';
   *)

   result := 'select * from PT_GlobalSettingDetail';
end;

function TfrmPuppySetting.getGlobalSettingSQL: String;
begin
  result := 'select * from PT_GlobalSetting';
end;

function TfrmPuppySetting.getLocalSettingSQL: String;
begin
  result := 'select * from PT_LocalSetting where MacAddress =:address';
end;

function TfrmPuppySetting.OpenGlobalSettting: boolean;
begin
   qryGlobal.Connection := dm.ADODBConnect;
   qryGlobal.SQL.Text   := getGlobalSettingSQL;
   try
     qryGlobal.Open;
     result := true;
   except
     on exception do begin
        qryGlobal.Close;
        result := false;
     end;
   end;
end;

function TfrmPuppySetting.OpenLocalSetting: boolean;
begin
   qryLocal.Connection := dm.ADODBConnect;
   qryLocal.SQL.Text   := getLocalSettingSQL;
   qryLocal.Parameters.ParamByName('address').Value := PuppyIntegration.MacAddress;
   try
     qryLocal.Open;
     result := true;

   except
     on exception do begin
        qryLocal.Close;
        result := false;
     end;
   end;
end;

function TfrmPuppySetting.OpenGlobalSettingDetail: boolean;
begin
   qryGlobalDetail.Connection := dm.ADODBConnect;
   qryGlobalDetail.SQL.Text   := getGlobalSettingDetailSQL;
   try
     cdsGlobalDetail.Open;
     result := true;
   except
     on exception do begin
        cdsGlobalDetail.Close;
        result := false;
     end;
   end;
end;

procedure TfrmPuppySetting.btnSaveClick(Sender: TObject);
var
   Id: integer;
begin
  inherited;
  // I'll need start a transaction to save all information
  try
     dm.ADODBConnect.BeginTrans;

     //save global settings
     if ( dsGlobal.State in [dsInsert, dsEdit] ) then
        qryGlobal.Post;

     //save local settings
     if ( qryLocal.State = dsBrowse ) then begin
        if ( qryLocal.IsEmpty ) then
           qryLocal.Insert
        else
           qryLocal.Edit;
     end;

     if ( qryLocal.State in [dsInsert, dsEdit] ) then begin
        if ( qryLocal.FieldByname('PuppyInstalled').IsNull ) then
            qryLocal.FieldByName('PuppyInstalled').Value := 0;

        if ( not qryLocal.FieldByName('MacAddress').IsNull ) then begin
           if ( qryLocal.FieldByName('MacAddress').Value = PuppyIntegration.MacAddress ) then
              qryLocal.Post
           else
              qryLocal.Cancel;
        end
        else begin
           qryLocal.FieldByName('MacAddress').Value := PuppyIntegration.MacAddress;
           qryLocal.Post;
        end;
     end;

     //get Id
     Id := getMaxId('PT_GlobalSetting', 'Id');

     //save global detail
     cdsGlobalDetail.First;

     while ( not cdsGlobalDetail.Eof ) do begin
         cdsGlobalDetail.Edit;
         cdsGlobalDetail.FieldByName('GlobalSettingId').Value := Id;
         cdsGlobalDetail.FieldByName('IdModel').Value := getValidIdModel(cdsGlobalDetail.fieldByName('ServiceMap').Value);
         cdsGlobalDetail.Post;
         cdsGlobalDetail.Next;
     end;

     //amfsouza, May, 10 2012 to Apply changes.
     if ( cdsGlobalDetail.RecordCount > 0 ) then begin
         if ( cdsGlobalDetail.ChangeCount > 0 ) then begin
            cdsGlobalDetail.ApplyUpdates(-1);
         end;

     end;
     dm.ADODBConnect.CommitTrans;

     // amfsouza 02.10.2012 - PuppyIntegration.createWindowsService(qryLocal.FieldByName('PuppyInstalled').AsBoolean);

  except
     dm.ADODBConnect.RollbackTrans;
  end;
end;

function TfrmPuppySetting.UpdateServiceModel(cdsDetailSetting: TClientDataset): boolean;
var
   qyUpdateModel, qyUpdateInvent, qySelect: TADOQuery;
   sqlModel, sqlInvent, sqlSelect: String;
   idInventory: Integer;
begin
   try
     qyUpdateModel := TADOQuery.Create(nil);
     qyUpdateModel.Connection := dm.ADODBConnect;
     sqlModel := 'update Model set model = :service, description =:description, sellingPrice =:price, RequireOnSale =:require where Idmodel = :Idmodel';
     qyUpdateModel.SQL.Text := sqlModel;

     qyUpdateInvent := TADOquery.Create(nil);
     qyUpdateInvent.Connection := dm.ADODBConnect;
     sqlInvent := ' update Inventory set SellingPrice =:sellingPrice where IdInventory =:idInventory ';
     qyUpdateInvent.SQL.Text   := sqlInvent;

     qySelect := TADOQuery.Create(nil);
     qySelect.Connection := dm.ADODBConnect;

     sqlSelect := 'select m.IdModel, I.IdInventory '+
                  'from Inventory I '+
                  'join Model m on I.ModelID = m.IDModel '+
                  'where m.Idmodel =:idmodel ';
     qySelect.SQL.Text := sqlSelect;

     cdsDetailSetting.First;
     while not cdsDetailSetting.Eof do begin
         qyUpdateModel.Parameters.ParamByName('service').Value := cdsDetailSetting.fieldByName('serviceMap').Value;
         qyUpdateModel.Parameters.ParamByName('description').Value := cdsDetailSetting.fieldByName('description').Value;
         qyUpdateModel.Parameters.ParamByName('price').Value := cdsDetailSetting.fieldByName('price').Value;
         qyUpdateModel.Parameters.ParamByName('require').Value := cdsDetailSetting.fieldByName('RequireOnSale').Value;
         qyUpdateModel.Parameters.ParamByName('Idmodel').Value := cdsDetailSetting.fieldByName('Idmodel').Value;
         qyUpdateModel.ExecSQL;

         qySelect.Parameters.ParamByName('idmodel').Value := cdsDetailSetting.fieldByName('Idmodel').Value;
         qySelect.Open;
         idInventory := qySelect.fieldByName('IdInventory').Value;
         qySelect.Close;

         qyUpdateInvent.SQL.Text   := sqlInvent;
         qyUpdateInvent.Parameters.ParamByName('sellingprice').Value := cdsDetailSetting.fieldByName('price').Value;
         qyUpdateInvent.Parameters.ParamByName('IdInventory').Value := idInventory;
         qyUpdateInvent.ExecSQL;

         cdsDetailSetting.Next;
     end;

   finally
     freeAndNil(qyUpdateModel);
     freeAndNil(qyUpdateInvent);
     freeAndNil(qySelect);
   end;

end;

function TfrmPuppySetting.OpenPetCategory: boolean;
begin
   qryPetCategory.Connection := dm.ADODBConnect;
   qryPetCategory.SQL.Text      := getPetCategory;
   try
     qryPetCategory.Open;
     result := true;
   except
     on exception do begin
        qryPetCategory.Close;
        result := false;
     end;
   end;
end;

function TfrmPuppySetting.getPetCategory: String;
begin
   result := 'select * from tabGroup where puppytracker = 1 and PackModel = 0 and Service = 0';
end;

procedure TfrmPuppySetting.lkpPetCategCloseUp(Sender: TObject);
var
  openOK: boolean;
  i: Integer;
begin
  inherited;
  openOK := OpenGlobalSettingDetail;

  if ( lkpPetCateg.keyValue > - 1 ) then begin
      PuppyIntegration.PetCategory := lkpPetCateg.KeyValue;
      lkpPetCateg.Enabled := ( qryPetCategory.FieldByName('desativado').Value = 0 );

      cdsGlobalDetail.Filtered := false;
      if ( not cdsGlobalDetail.IsEmpty ) then begin
         cdsGlobalDetail.Filter   := 'GlobalSettingID = ' + (qryGlobal.fieldByName('Id').asString);
         cdsGlobalDetail.Filtered := true;
      end;
  end;
end;

function TfrmPuppySetting.setServiceToModel(cdsDetailSetting: TClientDataSet): boolean;
var
   qyUpdate: TADOQuery;
   sql: String;
begin
   try
     qyUpdate := TADOQuery.Create(nil);
     qyUpdate.Connection := dm.ADODBConnect;
     sql := 'update Model set serviceMap = :service where Idmodel = :Idmodel';
     qyUpdate.SQL.Text := sql;

     cdsDetailSetting.First;
     while not cdsDetailSetting.Eof do begin
         qyUpdate.Parameters.ParamByName('service').Value := cdsDetailSetting.fieldByName('serviceMap').Value;
         qyUpdate.Parameters.ParamByName('Idmodel').Value := cdsDetailSetting.fieldByName('Idmodel').Value;
         qyUpdate.ExecSQL;
         cdsDetailSetting.Next;
     end;

   finally
     freeAndNil(qyUpdate);
   end;

end;

procedure TfrmPuppySetting.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 0;
end;

procedure TfrmPuppySetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  freeAndNil(PuppyIntegration);
  inherited;

end;

function TfrmPuppySetting.getMaxId(tableName, IdName: String): Integer;
var
   sql: String;
   qryMax: TADOQuery;
begin
   try
     qryMax := TADOQuery.Create(nil);
     qryMax.Connection := dm.ADODBConnect;
     sql := 'select Max('+IdName+') maxID from ' + tableName;
     qryMax.SQL.Text := SQL;
     qryMax.Open;
     result := qryMax.fieldByname('maxID').Value;
   finally
     freeAndNil(qryMax);
   end;

end;

function TfrmPuppySetting.OpenKitCategory: boolean;
begin
   qryKitCategory.Connection := dm.ADODBConnect;
   qryKitCategory.SQL.Text      := getPetKitCategory;
   try
     qryKitCategory.Open;
     result := true;
   except
     on exception do begin
        qryKitCategory.Close;
        result := false;
     end;
   end;

end;

function TfrmPuppySetting.getPetKitCategory: String;
begin
   result := 'select * from tabGroup where PackModel = 1 and puppytracker = 1';
end;

procedure TfrmPuppySetting.lkpKitCategCloseUp(Sender: TObject);
begin
  inherited;
  if ( lkpKitCateg.KeyValue > -1 ) then begin
      PuppyIntegration.PetKitCategory := lkpKitCateg.KeyValue;
      lkpKitCateg.Enabled := ( qryKitCategory.FieldByName('desativado').Value = 0 );
  end;

end;

function TfrmPuppySetting.getPetServiceCategory: String;
begin
   result := 'select * from TabGroup where Service = 1 and puppytracker = 1';
end;

function TfrmPuppySetting.OpenServiceCategory: boolean;
begin
   qryPetServiceCategory.Connection := dm.ADODBConnect;
   qryPetServiceCategory.SQL.Text      := getPetServiceCategory;
   try
     qryPetServiceCategory.Open;
     result := true;
   except
     on exception do begin
        qryPetServiceCategory.Close;
        result := false;
     end;
   end;
end;

procedure TfrmPuppySetting.lkpServCategCloseUp(Sender: TObject);
begin
  inherited;

  if ( lkpServCateg.KeyValue > - 1 ) then begin
      PuppyIntegration.PetServiceCategory := lkpServCateg.KeyValue;
      lkpServCateg.Enabled := ( qryPetServiceCategory.FieldByName('desativado').Value = 0 );
  end;
end;

function TfrmPuppySetting.ValidatePuppySettings: boolean;
begin
   result := true;
   if ( lkpPetCateg.Text = '' ) then begin
      Application.MessageBox('Pet Category is required to this function. Please correct issue and try again.', 'Require Field', mb_ok + MB_ICONERROR);
      result := false;
   end
   else if ( lkpKitCateg.Text = '' ) then begin
      Application.MessageBox('Pet Kit Category is required to this function. Please correct issue and try again.', 'Require Field', mb_ok + MB_ICONERROR);
      result := false;
   end
   else if (lkpServCateg.Text = '' ) then begin
      Application.MessageBox('Pet Service Category is required to this function. Please correct issue and try again.', 'Require Field', mb_ok + MB_ICONERROR);
      result := false;
   end
   else if ( edtSaleExec.Text = '' ) then begin
      Application.MessageBox('Sale executable is required to this function. Please correct issue and try again.', 'Require Field', mb_ok + MB_ICONERROR);
      result := false;
   end
   else if ( edtAvail.Text = '' ) then begin
      Application.MessageBox('Availability executable is required to this function. Please correct issue and try again.', 'Require Field', mb_ok + MB_ICONERROR);
      result := false;
   end

end;

procedure TfrmPuppySetting.cmbPetFrequencyChange(Sender: TObject);
begin
  inherited;
  ValidatePuppySettings;
end;

procedure TfrmPuppySetting.cmbServerChange(Sender: TObject);
begin
  inherited;
  pnAvail.Visible := ( cmbServer.ItemIndex = 0 );
end;

procedure TfrmPuppySetting.btnSaveScheduleClick(Sender: TObject);
begin
  inherited;
  PuppyIntegration.createWindowsService(qryLocal.FieldByName('PuppyInstalled').AsBoolean);
end;

function TfrmPuppySetting.getValidIdModel(description: String): Integer;
var
  qry: TADOQuery;
begin
  try
     try
       qry := TADOQuery.Create(nil);
       qry.Connection := dm.ADODBConnect;
       qry.SQL.Add('select distinct m.Idmodel, model');
       qry.SQL.Add('from model m');
       qry.SQL.Add('join PackModel pm on m.IDModel = pm.IDModel');
       qry.SQL.Add('join PT_GlobalSetting pg on m.GroupID = pg.IdServiceCategory');
       qry.open;

       qry.Filter := 'model = '+QuotedStr(description);
       qry.Filtered := true;

       if ( qry.RecordCount > 0 ) then
          result := qry.fieldByName('IdModel').Value
       else
          result := -1; // error, move -1

     except
       on e: Exception do begin
          raise Exception.Create('Failed to validate model '+e.Message);
       end;
     end;

  finally
     freeAndNil(qry);
  end;

end;

end.
