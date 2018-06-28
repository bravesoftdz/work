unit uPctPetTreatmentSubList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonSubList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, ImgList, mrConfigList,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  XiButton, uParentCustomList;

type
  TPctPetTreatmentSubList = class(TParentButtonSubList)
    Bevel1: TBevel;
    btnViewNotes: TXiButton;
    procedure btnViewNotesClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure LoadImages; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TPctPetTreatmentSubList }

procedure TPctPetTreatmentSubList.LoadImages;
begin
  inherited;
  imgBrowser.GetBitmap(BTN_LIST_DETAIL, btnViewNotes.Glyph);
end;

procedure TPctPetTreatmentSubList.btnViewNotesClick(Sender: TObject);
begin
  inherited;
  grdListDBTableView.Preview.Visible := not grdListDBTableView.Preview.Visible;
end;

initialization
  RegisterClass(TPctPetTreatmentSubList);


end.
