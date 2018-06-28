unit uParentButtonSubList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentCustomSubList, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, ImgList, mrConfigList,
  ExtCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  XiButton, uParentCustomList;

type
  TParentButtonSubList = class(TParentCustomSubList)
    btnNew: TXiButton;
    btnOpen: TXiButton;
    btnDelete: TXiButton;
  private
    { Private declarations }
  protected
    procedure SetCommandOptionsVisibility; override;
    procedure LoadImages; override;
    procedure RestrictForm; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TParentButtonSubList }

procedure TParentButtonSubList.LoadImages;
begin
  inherited;
  imgBrowser.GetBitmap(BTN_LIST_DELETE, btnDelete.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_OPEN, btnOpen.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_NEW, btnNew.Glyph);
end;

procedure TParentButtonSubList.RestrictForm;
begin
  inherited;
  btnNew.Enabled    := False;
  btnDelete.Enabled := False;
end;

procedure TParentButtonSubList.SetCommandOptionsVisibility;
var
 mrCommandOption : TmrCommandOption;
begin
  inherited;

  mrCommandOption := TmrCommandOption(btnNew.Tag);
  btnNew.Enabled := (mrCommandOption in ConfigList.CommandOptions);

  mrCommandOption := TmrCommandOption(btnOpen.Tag);
  btnOpen.Enabled := (mrCommandOption in ConfigList.CommandOptions);

  mrCommandOption := TmrCommandOption(btnDelete.Tag);
  btnDelete.Enabled := (mrCommandOption in ConfigList.CommandOptions);

end;

end.
