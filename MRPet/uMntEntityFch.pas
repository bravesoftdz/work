unit uMntEntityFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit,
  cxCheckBox, mrDBCheckBox, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, mrDBComboBox, DBClient,
  StdCtrls;

type
  TMntEntityFch = class(TParentButtonFch)
    edtFullName: TmrDBEdit;
    chkCompany: TmrDBCheckBox;
    scEntityType: TmrDBSuperCombo;
    edtAddress: TmrDBEdit;
    edtCity: TmrDBEdit;
    scState: TmrDBSuperCombo;
    edtZip: TmrDBEdit;
    edtLastName: TmrDBEdit;
    edtFirstName: TmrDBEdit;
    scCountry: TmrDBSuperCombo;
    edtPhone: TmrDBEdit;
    edtCel: TmrDBEdit;
    edtFax: TmrDBEdit;
    mrDBEdit1: TmrDBEdit;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure chkCompanyPropertiesChange(Sender: TObject);
    procedure scEntityTypeBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    FEntityType : Integer;
    FPath : String;
    procedure DisplayEntityList;
    procedure RefreshEntityType;
  public
    { Public declarations }
  end;

implementation

uses uDMMaintenance, uParamFunctions, uDMPet, uMRSQLParam,
  uParentCustomFch, uSystemTypes;

{$R *.dfm}

procedure TMntEntityFch.ConfigFchAfterStart(Sender: TObject);
begin
  FEntityType := StrToInt(ParseParam(Params, 'EntityType'));
  DisplayEntityList;

  scEntityType.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Entity Type;');
  scState.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=State;');
  scCountry.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Country;');
  inherited;
end;

procedure TMntEntityFch.DisplayEntityList;
begin

  Case FEntityType of
   PT_CUSTOMER    : FPath := PT_PATH_CUSTOMER;
   PT_VENDOR      : FPath := PT_PATH_VENDOR;
   PT_COMMISSION  : FPath := PT_PATH_COMMISSION;
   PT_SALESPERSON : FPath := PT_PATH_SALESPERSON;
   PT_GUIDE       : FPath := PT_PATH_GUIDE;
   PT_AGENCY      : FPath := PT_PATH_AGENCY;
   PT_OTHER       : FPath := PT_PATH_OTHER;
   PT_MANUFACTURE : FPath := PT_PATH_MANUFACTURE;
   PT_BREEDER     : FPath := DMPet.GetPropertyDomain('PctBreederDefaultEntityTypePath');
  end;

end;


procedure TMntEntityFch.RefreshEntityType;
begin
  if (chkCompany.EditValue = Null) or (not chkCompany.EditValue) then
  begin
    edtFullName.Visible  := False;
    edtFullName.Required := False;

    edtFirstName.Visible  := True;
    edtFirstName.Required := True;

    edtLastName.Visible  := True;
    edtLastName.Required := True;
  end
  else
  begin
    edtFullName.Visible  := True;
    edtFullName.Required := True;

    edtFirstName.Visible  := False;
    edtFirstName.Required := False;

    edtLastName.Visible  := False;
    edtLastName.Required := False;
  end;
end;

procedure TMntEntityFch.chkCompanyPropertiesChange(Sender: TObject);
begin
  inherited;
  RefreshEntityType;
end;

procedure TMntEntityFch.scEntityTypeBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      AddKey('Path').AsString := FPath;
      KeyByName('Path').Condition := tcLikeStartWith;

      AddKey('Desativado').AsBoolean := False;
      KeyByName('Desativado').Condition := tcEquals;

      AddKey('Hidden').AsBoolean := False;
      KeyByName('Hidden').Condition := tcEquals;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TMntEntityFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;

  if FEntityType = PT_BREEDER then
    DataSet.FieldByName('IDTipoPessoa').Value := DMPet.GetPropertyDomain('PctBreederDefaultEntityType')
  else
    DataSet.FieldByName('IDTipoPessoa').AsInteger := FEntityType;
  DataSet.FieldByName('Juridico').AsBoolean := not (FEntityType in [PT_CUSTOMER, PT_SALESPERSON, PT_COMMISSION, PT_BREEDER]);
  
end;

initialization
  RegisterClass(TMntEntityFch);


end.
