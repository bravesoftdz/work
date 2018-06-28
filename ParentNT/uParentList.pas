unit uParentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentCustomList, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, ExtCtrls, 
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Buttons, mrConfigList,
  XiButton, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, ImgList;

type
  TParentList = class(TParentCustomList)
  private
    { Private declarations }
  protected
    procedure SetCommandOptionsVisibility; override;
    procedure DoShowList; override;
    procedure CreateCommandControls; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TParentList }

procedure TParentList.DoShowList;
begin
  ShowModal;
end;

procedure TParentList.SetCommandOptionsVisibility;
begin

end;

procedure TParentList.CreateCommandControls;
begin

end;

end.
