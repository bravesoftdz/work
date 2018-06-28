unit uPctPetSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSearchForm, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ExtCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, XiButton, cxContainer, cxTextEdit, StdCtrls,
  uMRSQLParam, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, mrSuperCombo;

type
  TPctPetSearch = class(TParentSearchForm)
    cdsSearchIDPet: TIntegerField;
    cdsSearchIDSpecies: TIntegerField;
    cdsSearchIDPorte: TIntegerField;
    cdsSearchIDBreed: TIntegerField;
    cdsSearchIDStatus: TIntegerField;
    cdsSearchIDBreeder: TIntegerField;
    cdsSearchName: TStringField;
    cdsSearchSex: TStringField;
    cdsSearchColor: TStringField;
    cdsSearchSKU: TStringField;
    cdsSearchPenNum: TStringField;
    cdsSearchVendorCost: TBCDField;
    cdsSearchMSRP: TBCDField;
    cdsSearchSalePrice: TBCDField;
    cdsSearchPromoPrice: TBCDField;
    cdsSearchUSDA: TStringField;
    cdsSearchCollar: TStringField;
    cdsSearchSire: TStringField;
    cdsSearchDam: TStringField;
    cdsSearchWhelpDate: TDateTimeField;
    cdsSearchPurchaseDate: TDateTimeField;
    cdsSearchNotes: TStringField;
    cdsSearchSystem: TBooleanField;
    cdsSearchHidden: TBooleanField;
    cdsSearchDesativado: TBooleanField;
    cdsSearchSpecies: TStringField;
    cdsSearchPorte: TStringField;
    cdsSearchBreed: TStringField;
    cdsSearchStatusCode: TStringField;
    cdsSearchStatus: TStringField;
    cdsSearchPessoa: TStringField;
    cdsSearchTelefone: TStringField;
    grdListDBTableViewIDPet: TcxGridDBColumn;
    grdListDBTableViewIDSpecies: TcxGridDBColumn;
    grdListDBTableViewIDPorte: TcxGridDBColumn;
    grdListDBTableViewIDBreed: TcxGridDBColumn;
    grdListDBTableViewIDStatus: TcxGridDBColumn;
    grdListDBTableViewIDBreeder: TcxGridDBColumn;
    grdListDBTableViewName: TcxGridDBColumn;
    grdListDBTableViewSex: TcxGridDBColumn;
    grdListDBTableViewColor: TcxGridDBColumn;
    grdListDBTableViewSKU: TcxGridDBColumn;
    grdListDBTableViewPenNum: TcxGridDBColumn;
    grdListDBTableViewVendorCost: TcxGridDBColumn;
    grdListDBTableViewMSRP: TcxGridDBColumn;
    grdListDBTableViewSalePrice: TcxGridDBColumn;
    grdListDBTableViewPromoPrice: TcxGridDBColumn;
    grdListDBTableViewUSDA: TcxGridDBColumn;
    grdListDBTableViewCollar: TcxGridDBColumn;
    grdListDBTableViewSire: TcxGridDBColumn;
    grdListDBTableViewDam: TcxGridDBColumn;
    grdListDBTableViewWhelpDate: TcxGridDBColumn;
    grdListDBTableViewPurchaseDate: TcxGridDBColumn;
    grdListDBTableViewNotes: TcxGridDBColumn;
    grdListDBTableViewSystem: TcxGridDBColumn;
    grdListDBTableViewHidden: TcxGridDBColumn;
    grdListDBTableViewDesativado: TcxGridDBColumn;
    grdListDBTableViewSpecies: TcxGridDBColumn;
    grdListDBTableViewPorte: TcxGridDBColumn;
    grdListDBTableViewBreed: TcxGridDBColumn;
    grdListDBTableViewStatusCode: TcxGridDBColumn;
    grdListDBTableViewStatus: TcxGridDBColumn;
    grdListDBTableViewPessoa: TcxGridDBColumn;
    grdListDBTableViewTelefone: TcxGridDBColumn;
    edtSKU: TcxTextEdit;
    lbSKU: TLabel;
    scBreed: TmrSuperCombo;
    scStatus: TmrSuperCombo;
    scSpecies: TmrSuperCombo;
    procedure cdsSearchBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPet, uDMPetCenter, uParamFunctions;

{$R *.dfm}

procedure TPctPetSearch.cdsSearchBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sIDStore : String;
begin
  inherited;

  if FParams <> '' then
    sIDStore := ParseParam(FParams, 'IDStore');

  with TMRSQLParam.Create do
    try
      if (edtSKU.Text <> '') then
      begin
        AddKey('P.SKU').AsString := edtSKU.Text;
        KeyByName('P.SKU').Condition := tcLike;
      end;

      if (scBreed.Text <> '') then
      begin
        AddKey('P.IDBreed').AsString := scBreed.EditValue;
        KeyByName('P.IDBreed').Condition := tcEquals;
      end;

      if (scStatus.Text <> '') then
      begin
        AddKey('P.IDStatus').AsString := scStatus.EditValue;
        KeyByName('P.IDStatus').Condition := tcEquals;
      end;

      if (scSpecies.Text <> '') then
      begin
        AddKey('P.IDSpecies').AsString := scSpecies.EditValue;
        KeyByName('P.IDSpecies').Condition := tcEquals;
      end;

      if (sIDStore <> '') then
      begin
        AddKey('P.IDStore').AsString := sIDStore;
        KeyByName('P.IDStore').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;
end;

procedure TPctPetSearch.FormCreate(Sender: TObject);
begin
  inherited;
  scBreed.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scStatus.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scSpecies.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
end;

initialization
  RegisterClass(TPctPetSearch);

end.
