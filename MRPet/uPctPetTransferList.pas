unit uPctPetTransferList;

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
  XiButton, cxCalendar, StdCtrls, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, mrSuperCombo, uMRSQLParam;

type
  TPctPetTransferList = class(TParentToolBarList)
    dtFrom: TcxDateEdit;
    dtTo: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    scStoreFrom: TmrSuperCombo;
    scStoreTo: TmrSuperCombo;
    procedure ConfigListAfterStart(Sender: TObject);
    procedure ConfigListGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uClasseFunctions, mrMsgBox, uDateTimeFunctions;


{$R *.dfm}

procedure TPctPetTransferList.ConfigListAfterStart(Sender: TObject);
begin

  scStoreFrom.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Store;');
  scStoreTo.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Store;');

  inherited;

  dtFrom.Date := FirstDateMonth;
  dtTo.Date   := LastDateMonth;
  
end;

procedure TPctPetTransferList.ConfigListGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  if (dtFrom.EditValue <> Null ) then
  begin
    Filter.AddKey('TransferDate1').AsString     := MyFormatDate(Trunc(dtFrom.Date));
    Filter.KeyByName('TransferDate1').Field     := 'T.TransferDate';
    Filter.KeyByName('TransferDate1').Condition := tcGreaterThanEqual;
  end;

  if (dtTo.EditValue <> Null ) then
  begin
    Filter.AddKey('TransferDate2').AsString     := MyFormatDate(Trunc(dtTo.Date)+1);
    Filter.KeyByName('TransferDate2').Field     := 'T.TransferDate';
    Filter.KeyByName('TransferDate2').Condition := tcLessThan;
  end;

  if (scStoreFrom.EditValue <> Null ) and (scStoreFrom.EditValue <> 0) then
  begin
    Filter.AddKey('T.IDStoreSource').AsInteger := scStoreFrom.EditValue;
    Filter.KeyByName('T.IDStoreSource').Condition := tcEquals;
  end;

  if (scStoreTo.EditValue <> Null ) and (scStoreTo.EditValue <> 0) then
  begin
    Filter.AddKey('T.IDStoreDest').AsInteger := scStoreTo.EditValue;
    Filter.KeyByName('T.IDStoreDest').Condition := tcEquals;
  end;

end;

initialization
  RegisterClass(TPctPetTransferList);


end.
