unit uPctPetList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentToolBarList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, Menus, dxPSCore, dxPScxGridLnk, ImgList, mrConfigList,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  XiButton, uMRSQLParam, ComCtrls, mrSubListPanel, uParentCustomList,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, StdCtrls;

type
  TPctPetList = class(TParentToolBarList)
    pgPetHistory: TPageControl;
    tsTreatment: TTabSheet;
    tsMedicalCondition: TTabSheet;
    slpTreatmentGrid: TmrSubListPanel;
    btnShowDetail: TXiButton;
    slpMedicalCondition: TmrSubListPanel;
    btnPetSale: TXiButton;
    scStatus: TmrSuperCombo;
    scBreed: TmrSuperCombo;
    btnPrintWarranty: TXiButton;
    lbSKU: TLabel;
    edtMicrochip: TcxTextEdit;
    procedure ConfigListGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure ConfigListAfterStart(Sender: TObject);
    procedure slpTreatmentGridGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentGridGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure btnShowDetailClick(Sender: TObject);
    procedure pgPetHistoryChange(Sender: TObject);
    procedure dsListDataChange(Sender: TObject; Field: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure slpMedicalConditionGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMedicalConditionGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure btnPetSaleClick(Sender: TObject);
    procedure btnPrintWarrantyClick(Sender: TObject);
  private
    procedure RefreshPetDetail;
  protected
    procedure LoadImages; override;
  public
    { Public declarations }
  end;


implementation
  
uses uDMPetCenter, uDMPet, uClasseFunctions, uParentSearchForm,
     uPctWarrantyPrintForm, mrMsgBox;

{$R *.dfm}

procedure TPctPetList.ConfigListGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  //Sempre que a query do servidor tiver join, tem que comentar o inherited; e colocar o desativado
  //Se nao vai dar Ambiguous column name 'Desativado'
  Filter.AddKey('P.Desativado').AsInteger := cmbListData.ItemIndex;
  Filter.KeyByName('P.Desativado').Condition := tcEquals;

  if (scStatus.EditValue <> Null ) and (scStatus.EditValue <> 0) then
  begin
    Filter.AddKey('P.IDStatus').AsInteger := scStatus.EditValue;
    Filter.KeyByName('P.IDStatus').Condition := tcEquals;
  end;

  if (scBreed.EditValue <> Null ) and (scBreed.EditValue <> 0) then
  begin
    Filter.AddKey('P.IDBreed').AsInteger := scBreed.EditValue;
    Filter.KeyByName('P.IDBreed').Condition := tcEquals;
  end;

  if (edtMicrochip.Text <> '')then
  begin
    Filter.AddKey('MicrochipNum').AsString := edtMicrochip.Text;
    Filter.KeyByName('MicrochipNum').Condition := tcLike;
  end;


end;

procedure TPctPetList.ConfigListAfterStart(Sender: TObject);
begin
  scBreed.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, '');
  scStatus.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, '');
  slpTreatmentGrid.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Apply Treatment;');
  slpMedicalCondition.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Apply Treatment;');
  inherited;
  scStatus.EditValue := PET_STATUS_AVAILABLE;
end;

procedure TPctPetList.slpTreatmentGridGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PT.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PT.IDPet').Condition := tcEquals;
  end;
  
end;

procedure TPctPetList.slpTreatmentGridGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;
  
end;

procedure TPctPetList.RefreshPetDetail;
begin
  if pnlBottom.Visible then
  case pgPetHistory.ActivePageIndex of
    0 : slpTreatmentGrid.RefreshSubList;
    1 : slpMedicalCondition.RefreshSubList;
  end;
end;

procedure TPctPetList.LoadImages;
begin
  inherited;
  imgBrowser.GetBitmap(BTN_LIST_DETAIL, btnShowDetail.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_SALELIST, btnPetSale.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_PRINT, btnPrintWarranty.Glyph);
end;

procedure TPctPetList.btnShowDetailClick(Sender: TObject);
begin
  inherited;
  pnlBottom.Visible := not pnlBottom.Visible;
  RefreshPetDetail;
end;

procedure TPctPetList.pgPetHistoryChange(Sender: TObject);
begin
  inherited;
  RefreshPetDetail;
end;

procedure TPctPetList.dsListDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  RefreshPetDetail;
end;

procedure TPctPetList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  slpTreatmentGrid.FreeSubList;
  slpMedicalCondition.FreeSubList;
end;

procedure TPctPetList.slpMedicalConditionGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PMC.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PMC.IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetList.slpMedicalConditionGetForeignKeyValue(
  Sender: TObject; var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetList.btnPetSaleClick(Sender: TObject);
var
  Form : TForm;
  sSKU : String;
begin

  sSKU := '';
  if DataSet.Active then
    sSKU := DataSet.FieldByName('SKU').AsString;

  Form := CreateForm(Self, 'TPctPetSaleSearch');
  try
    TParentSearchForm(Form).Search('SKU='+sSKU+';MenuDisplay=Search Puppy Sale;');
  finally
    FreeAndNil(Form);
  end;

end;

procedure TPctPetList.btnPrintWarrantyClick(Sender: TObject);
var
  Form : TForm;
  WPD: TWarrantyPrintData;
  MS : TMemoryStream;
  i : Integer;
begin

  if DataSet.Active then
    for I := 0 to grdListDBTableView.Controller.SelectedRowCount-1 do
    begin
      DataSet.RecNo := grdListDBTableView.Controller.SelectedRecords[i].RecordIndex+1;
      if (DataSet.FieldByName('IDPet').AsInteger > 0) then
      begin
        Form := CreateForm(Self, 'TPctWarrantyPrintForm');
        try
          try
            WPD := TWarrantyPrintData.Create;
            try
              WPD.IDPet := DataSet.FieldByName('IDPet').AsInteger;
              WPD.IDSpecies := DataSet.FieldByName('IDSpecies').AsInteger;
              MS := DMPetCenter.GetWarrantyReport('IDSpecies', WPD.IDSpecies);
              try
                TPctWarrantyPrintForm(Form).dsDBPet.DataSet := TPctWarrantyPrintForm(Form).cdsEmptyPet;
                TPctWarrantyPrintForm(Form).MSReport := MS;
                TPctWarrantyPrintForm(Form).PrintReport(WPD, False);
              finally
                FreeAndNil(MS);
                end;
            finally
              WPD.Free;
            end;
          except
            MsgBox('Report error._Check report configuration', vbCritical + vbOKOnly);
          end;
        finally
          FreeAndNil(Form);
        end;
      end;
    end;


end;

initialization
  RegisterClass(TPctPetList);

end.
