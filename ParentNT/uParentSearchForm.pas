unit uParentSearchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, XiButton, ExtCtrls, DBClient;

type
  TParentSearchForm = class(TParentForm)
    pnlTop: TPanel;
    pnlFilter: TPanel;
    pnlRefresh: TPanel;
    btnRefresh: TXiButton;
    pnlLeft: TPanel;
    pnlBottom: TPanel;
    pnlRight: TPanel;
    grdList: TcxGrid;
    grdListDBTableView: TcxGridDBTableView;
    grdListLevel: TcxGridLevel;
    btnOk: TXiButton;
    btnCancel: TXiButton;
    dsSearch: TDataSource;
    tmList: TTimer;
    cxStyleRepository: TcxStyleRepository;
    styHeader: TcxStyle;
    styBackGround: TcxStyle;
    stySelection: TcxStyle;
    cdsSearch: TClientDataSet;
    procedure RefreshSearch(Sender: TObject);
    procedure tmListTimer(Sender: TObject);
  private
    FKeyFieldName : String;
    function GetResultValue : Variant;
    procedure GetKeyField;
  protected
    FParams: String;
    procedure RefreshSearchList;
    procedure AfterSetParams; virtual;
  public
    function Search(AParams: String = ''): Variant;
  end;

implementation

uses uParamFunctions;

{$R *.dfm}

procedure TParentSearchForm.AfterSetParams;
begin
  Self.Caption := ParseParam(FParams, 'MenuDisplay');
end;

procedure TParentSearchForm.GetKeyField;
var
  i: Integer;
begin
  with cdsSearch do
    for i := 0 to Fields.Count-1 do
      if (pfInKey in Fields[i].ProviderFlags) then
      begin
        FKeyFieldName := Fields[i].FieldName;
        Break;
      end;
end;

function TParentSearchForm.GetResultValue: Variant;
begin
  Result := cdsSearch.FieldByName(FKeyFieldName).Value;
end;

procedure TParentSearchForm.RefreshSearch(Sender: TObject);
begin
  RefreshSearchList;
end;

procedure TParentSearchForm.RefreshSearchList;
begin
  with cdsSearch do
  begin
    if Active then
      Close;
    Open;
  end;
end;

function TParentSearchForm.Search(AParams: String = ''): Variant;
begin
  Result := Null;
  FParams := AParams;
  AfterSetParams;
  GetKeyField;
  ShowModal;
  if ModalResult = mrOk then
    Result := GetResultValue;
end;

procedure TParentSearchForm.tmListTimer(Sender: TObject);
begin
  inherited;
  if pnlRefresh.ParentColor then
    pnlRefresh.Color := clGreen
  else
    pnlRefresh.ParentColor := True;
end;

end.
