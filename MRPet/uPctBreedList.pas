unit uPctBreedList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentToolBarList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, ImgList, mrConfigList, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  XiButton, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, Menus,
  dxPSCore, dxPScxGridLnk;

type
  TPctBreedList = class(TParentToolBarList)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter;


{$R *.dfm}

initialization
  RegisterClass(TPctBreedList);


end.
