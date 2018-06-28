unit TagView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeBrowses, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxGridCustomPopupMenu, cxGridPopupMenu, dxPSCore,
  dxPScxGridLnk, ExtCtrls, BrowseConfig, ADODB, PowerADOQuery, siComp,
  siLangRT, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  PanelRights, StdCtrls, Buttons, LblEffct, dbClient, TagViewEdit;

type
  TfrmTagView = class(TbrwParent)
    grdBrowseDBDBColumn1: TcxGridDBColumn;
    grdBrowseDBDBColumn2: TcxGridDBColumn;
    spPromo: TSpeedButton;
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure quBrowseAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure grdBrowseDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure spPromoClick(Sender: TObject);
  private
    { Private declarations }
    fTag: TADOStoredProc;
    frmTagViewEdit: TfrmTagViewEdit;
    procedure upSert(arg_oper: String);
    procedure refreshTag();
    procedure deleteTag(arg_idTag: Integer);
  public
    { Public declarations }
    function start(): Boolean;
  end;

implementation
uses uDM, ufchPromo;

{$R *.dfm}

{ TfrmTagView }

function TfrmTagView.start: Boolean;
begin
  lblUserName.Caption := DM.fUser.UserName;
  lblUserName.Left := Label15.Left + Label15.Width + 3;
  lblUserName.Top := Label15.Top;

  refreshTag();
  showModal;
  result := true;
end;

procedure TfrmTagView.quBrowseAfterOpen(DataSet: TDataSet);
begin
  //inherited;

end;

procedure TfrmTagView.quBrowseAfterScroll(DataSet: TDataSet);
begin
  //inherited;

end;

procedure TfrmTagView.FormCreate(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmTagView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  inherited;

end;

procedure TfrmTagView.FormDestroy(Sender: TObject);
begin
//  inherited;
  freeAndNil(fTag);
end;

procedure TfrmTagView.FormShow(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmTagView.CommandClick(Sender: TObject);
begin
//  inherited;
end;

procedure TfrmTagView.btAddClick(Sender: TObject);
begin
//  inherited;
  upsert('I'); // insert
  refreshTag();
end;

procedure TfrmTagView.upSert(arg_oper: String);
begin
  try
     frmTagViewEdit := TfrmTagViewEdit.Create(self);
     frmTagViewEdit.start(fTag, arg_oper);
  finally
     freeAndNil(frmTagViewEdit);
  end;
end;

procedure TfrmTagView.btDetailClick(Sender: TObject);
begin
 // inherited;
   upSert('U'); // update
   refreshTag();
end;

procedure TfrmTagView.refreshTag;
begin
  fTag := dm.callSpTagModelCount();
  dsBrowse.DataSet := fTag;
end;

procedure TfrmTagView.grdBrowseDBDblClick(Sender: TObject);
begin
//  inherited;
  upSert('U'); // update
  refreshTag();
end;

procedure TfrmTagView.deleteTag(arg_idTag: Integer);
begin
  dm.callSpTagDelete(arg_idTag);
end;

procedure TfrmTagView.btRemoveClick(Sender: TObject);
begin
  inherited;
  if ( not fTag.IsEmpty ) then begin
     deleteTag(fTag.fieldByName('IdTag').Value);
     refreshTag();
  end;

end;

procedure TfrmTagView.grdBrowseDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
//  inherited;

end;

procedure TfrmTagView.spPromoClick(Sender: TObject);
var
  view: TFchPromo;
begin
  inherited;
  try
     view := TFchPromo.Create(nil);
     view.start(0);
  finally
     FreeAndNil(view);
  end;

end;

end.
