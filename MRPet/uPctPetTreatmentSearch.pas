unit uPctPetTreatmentSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSearchForm, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ExtCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, XiButton, uMRSQLParam, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, StdCtrls;

type
  TPctPetTreatmentSearch = class(TParentSearchForm)
    cbxTreatmentType: TcxImageComboBox;
    lbTreatmentType: TLabel;
    cdsSearchIDTreatment: TIntegerField;
    cdsSearchTreatment: TStringField;
    cdsSearchMfg: TStringField;
    cdsSearchTreatmentLotSize: TIntegerField;
    grdListDBTableViewTreatment: TcxGridDBColumn;
    grdListDBTableViewMfg: TcxGridDBColumn;
    grdListDBTableViewTreatmentLotSize: TcxGridDBColumn;
    lbMfg: TLabel;
    edtMfg: TcxTextEdit;
    procedure cdsSearchBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPet, uDMPetCenter;

{$R *.dfm}

procedure TPctPetTreatmentSearch.cdsSearchBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (cbxTreatmentType.ItemIndex <> -1) then
      begin
        AddKey('TreatmentType').AsInteger := (cbxTreatmentType.ItemIndex + 1);
        KeyByName('TreatmentType').Condition := tcEquals;
      end;

      if (edtMfg.Text <> '') then
      begin
        AddKey('Mfg').AsString := edtMfg.Text;
        KeyByName('Mfg').Condition := tcLike;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

initialization
  RegisterClass(TPctPetTreatmentSearch);

end.
