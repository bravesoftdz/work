unit uMntEntityList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentToolBarList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, ImgList, mrConfigList, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  XiButton, uMRSQLParam, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  Menus, dxPSCore, dxPScxGridLnk;

type
  TMntEntityList = class(TParentToolBarList)
    procedure ConfigListGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure ConfigListAfterStart(Sender: TObject);
  private
    FEntityType : Integer;
  public
    { Public declarations }
  end;

implementation

uses uDMMaintenance, uParamFunctions, uParentCustomList, uDMPet;

{$R *.dfm}

procedure TMntEntityList.ConfigListGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
var
  sPath : String;
begin

  Case FEntityType of
    PT_CUSTOMER    : sPath := PT_PATH_CUSTOMER;
    PT_VENDOR      : sPath := PT_PATH_VENDOR;
    PT_COMMISSION  : sPath := PT_PATH_COMMISSION;
    PT_SALESPERSON : sPath := PT_PATH_SALESPERSON;
    PT_GUIDE       : sPath := PT_PATH_GUIDE;
    PT_AGENCY      : sPath := PT_PATH_AGENCY;
    PT_OTHER       : sPath := PT_PATH_OTHER;
    PT_MANUFACTURE : sPath := PT_PATH_MANUFACTURE;
    PT_BREEDER     : sPath := DMPet.GetPropertyDomain('PctBreederDefaultEntityTypePath');
  end;

  Filter.AddKey('TP.Path').AsString := sPath;
  Filter.KeyByName('TP.Path').Condition := tcLikeStartWith;

  Filter.AddKey('P.Desativado').AsInteger := cmbListData.ItemIndex;
  Filter.KeyByName('P.Desativado').Condition := tcEquals;

end;

procedure TMntEntityList.ConfigListAfterStart(Sender: TObject);
begin
  inherited;
  FEntityType := StrToInt(ParseParam(Params, 'EntityType'));
end;


initialization
  RegisterClass(TMntEntityList);


end.
