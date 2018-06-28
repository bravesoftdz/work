unit uParentListInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, ImgList, dxBar, StdCtrls, Buttons, ExtCtrls, dxTL,
  dxDBCtrl, dxDBGrid, dxCntner, Db, ADODB, PowerADOQuery, siComp, siLangRT;

type
  TParentListInfo = class(TParentFixedFrm)
    grid: TdxDBGrid;
    quBrowse: TPowerADOQuery;
    dsBrowse: TDataSource;
    procedure gridCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure gridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure OpenBrowse;
    procedure CloseBrowse;
    procedure RefreshBrowse;
  protected

    MySugg : TStringList;

    procedure CallBrowse;

  public
    { Public declarations }

    procedure Start(Parametro: String; UserRights: String; Suggestion : TStringList); Override;
  end;

implementation

uses uDM, uSisMain, uNumericFunctions, uParamFunctions;

{$R *.DFM}

procedure TParentListInfo.CallBrowse;
begin

  with SisMain do
     ShowBrowse(MyStrToInt(ParseParam(MyParametro, 'IDMenu')), MySugg);

end;

procedure TParentListInfo.OpenBrowse;
begin

  with quBrowse do
     if not Active then
        Open;

  grid.FullExpand;      

end;

procedure TParentListInfo.CloseBrowse;
begin

  with quBrowse do
     if Active then
        Close;

end;

procedure TParentListInfo.RefreshBrowse;
begin

  CloseBrowse;
  OpenBrowse;

end;


procedure TParentListInfo.Start(Parametro: String; UserRights: String; Suggestion : TStringList);
begin

  Application.ProcessMessages;

  MyParametro := Trim(Parametro);

  OpenBrowse;

  lblModulo.Caption := self.Caption;
  lblModuloSadow.Caption := self.Caption;

  Show;

end;



procedure TParentListInfo.gridCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
begin
  inherited;


  //if ANode.HasChildren then
     //Exit;

  if ANode.Selected then
     begin
     AColor := clWhite;
     AFont.Color := clGray;
     end;

end;

procedure TParentListInfo.gridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  inherited;

   with grid, grid.HotTrackInfo do
      if (ANode = Node) and (AColumn.Index = Column) then
         begin
         AFont.Color := clBlue;
         AFont.Style := Afont.Style + [fsUnderline];
         end;

end;

procedure TParentListInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  CloseBrowse;

  MySugg.Free;

end;

procedure TParentListInfo.FormCreate(Sender: TObject);
begin
  inherited;

  MySugg := TStringList.Create;

end;

procedure TParentListInfo.FormActivate(Sender: TObject);
begin
  inherited;

  RefreshBrowse;

end;

end.
