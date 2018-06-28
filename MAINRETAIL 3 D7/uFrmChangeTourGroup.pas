unit uFrmChangeTourGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Db, DBTables, Buttons, Grids, 
  StdCtrls, ExtCtrls, LblEffct, ADODB, siComp, siLangRT, DBGrids, SMDBGrid,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TFrmChangeTourGroup = class(TFrmParent)
    rgPeriodo: TRadioGroup;
    btCancel: TButton;
    quGuide: TADOQuery;
    dsGuide: TDataSource;
    quGuideIDTouristGroup: TIntegerField;
    quGuideTipTouristGroup: TStringField;
    quGuideEnterDate: TDateTimeField;
    Panel4: TPanel;
    pnlButtons: TPanel;
    grdBrowseSearch: TcxGrid;
    grdBrowseSearchDB: TcxGridDBTableView;
    grdBrowseSearchLevel: TcxGridLevel;
    btAdd: TSpeedButton;
    grdBrowseSearchDBIDTouristGroup: TcxGridDBColumn;
    grdBrowseSearchDBTipTouristGroup: TcxGridDBColumn;
    grdBrowseSearchDBEnterDate: TcxGridDBColumn;
    quGuideAgent: TStringField;
    grdBrowseSearchDBAgent: TcxGridDBColumn;
    procedure grdGuideDblClick(Sender: TObject);
    procedure dsGuideDataChange(Sender: TObject; Field: TField);
    procedure btAddClick(Sender: TObject);
    procedure rgPeriodoClick(Sender: TObject);
    procedure grdBrowseSearchDBDblClick(Sender: TObject);
    procedure grdBrowseSearchDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start : Integer;
  end;


implementation

uses uFchTouristGroup, uDM, uSystemTypes, uDMGlobal;

{$R *.DFM}

function TFrmChangeTourGroup.Start : Integer;
begin
  rgPeriodoClick(nil);

  if (ShowModal = mrOk) then
    Result := quGuideIDTouristGroup.AsInteger
  else
    Result := - 1;

  Free;
end;

procedure TFrmChangeTourGroup.grdGuideDblClick(Sender: TObject);
begin
  inherited;
  if btClose.Enabled then
    btClose.Click;
end;

procedure TFrmChangeTourGroup.dsGuideDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btClose.Enabled := ( quGuideIDTouristGroup.AsString <> '' );
end;

procedure TFrmChangeTourGroup.btAddClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  with TFchTouristGroup.Create(self) do
  begin
    ShowCusto := False;
    if Start(btInc, nil, False, PosID1, PosID2, nil) then
      Free;
  end;

  with quGuide do
  begin
    Close;
    Open;
    Last;
  end;
end;

procedure TFrmChangeTourGroup.rgPeriodoClick(Sender: TObject);
begin
  inherited;
  with quGuide do
  begin
      if Active then close;
    Parameters.ParambyName('DataSel').Value := Trunc(Now);
    Parameters.ParambyName('IDStore').Value := DM.fStore.ID;
    case rgPeriodo.ItemIndex of
      0 : Parameters.ParambyName('Faixa').Value := -7200;
      1 : begin
            Parameters.ParambyName('DataSel').Value := Trunc(Now - EncodeTime(6, 0, 0, 0));
            Parameters.ParambyName('Faixa').Value   := 0;
          end;
      2 : Parameters.ParambyName('Faixa').Value := 0;
      3 : Parameters.ParambyName('Faixa').Value := -7;
      4 : Parameters.ParambyName('Faixa').Value := -35;
    end;
    Open;
  end;
end;

procedure TFrmChangeTourGroup.grdBrowseSearchDBDblClick(Sender: TObject);
begin
  inherited;
  if btClose.Enabled then
    btClose.Click;
end;

procedure TFrmChangeTourGroup.grdBrowseSearchDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(TcxCustomGridTableView(grdBrowseSearch.FocusedView)).OptionsBehavior.IncSearchItem := AColumn;
end;

end.
