unit ubrwCotation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeBrowses, Db, BrowseConfig, Menus, DBTables, Grids, Buttons, PanelRights, LblEffct, ExtCtrls, StdCtrls,
  Mask, DateBox, SuperComboADO, RadioButtonAll,
  ImgList, ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwCotation = class(TbrwParent)
    quBrowseIDCotacao: TIntegerField;
    quBrowseCotacao: TStringField;
    quBrowseDataCotacao: TDateTimeField;
    quBrowseUltimaEmissao: TDateTimeField;
    scStore: TSuperComboADO;
    Label3: TLabel;
    btStoreAll: TButton;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    grdBrowseDBIDCotacao: TcxGridDBColumn;
    grdBrowseDBDataCotacao: TcxGridDBColumn;
    grdBrowseDBCotacao: TcxGridDBColumn;
    grdBrowseDBUltimaEmissao: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure btStoreAllClick(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure scStoreSelectItem(Sender: TObject);
    procedure CommandClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  brwCotation: TbrwCotation;

implementation

uses uFchCotation, uDM, uDateTimeFunctions, uDMGlobal;

{$R *.DFM}

procedure TbrwCotation.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchCotation.Create(Self);

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  scStore.LookUpValue := intToStr(DM.fStore.ID);
end;

procedure TbrwCotation.btnExecClick(Sender: TObject);
begin
  inherited;
  aWhereBasicFilters[0] :=  'C.DataCotacao >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                            'C.DataCotacao < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);

  if scStore.LookUpValue = '' then
    aWhereBasicFilters[1]  := 'C.IDStore IN ('+ DM.fStore.StoreList +')'
  else
     aWhereBasicFilters[1] := 'C.IDStore = ' + scStore.LookUpValue;

  ExecBrowseSQL(True);

  DesativaAviso;
end;

procedure TbrwCotation.btStoreAllClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text        := '<'+btStoreAll.Caption+'>';

  AtivaAviso;
end;

procedure TbrwCotation.DateInicioChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwCotation.scStoreSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwCotation.CommandClick(Sender: TObject);
begin
  inherited;
  btnExecClick(Self);
end;

end.
