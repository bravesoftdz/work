unit uParentCustomSubList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentCustomList, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, ExtCtrls, mrConfigList,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Buttons, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, ImgList,
  XiButton;

type
  TParentCustomSubList = class(TParentCustomList)
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

{ TParentSubList }

procedure TParentCustomSubList.DoShowList;
begin
  Show;
end;

procedure TParentCustomSubList.SetCommandOptionsVisibility;
begin

end;

procedure TParentCustomSubList.CreateCommandControls;
begin

end;


end.
