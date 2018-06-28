unit uSubModelWebInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData, ADODB, PowerADOQuery,
  StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ExtCtrls, SubListPanel, ComCtrls;

type
  TSubModelWebInfo = class(TParentSub)
    dsFeatures: TDataSource;
    quFeatures: TPowerADOQuery;
    quFeaturesIDInvFeatures: TIntegerField;
    quFeaturesFeature: TStringField;
    quTechFeature: TADOQuery;
    quTechFeatureIDInvTechFeatures: TIntegerField;
    quTechFeatureTechFeature: TStringField;
    dsTechFeature: TDataSource;
    pnlFeatures: TPanel;
    lbFeatures: TLabel;
    grdFetaures: TcxGrid;
    grdFetauresDB: TcxGridDBTableView;
    grdFetauresDBFeature: TcxGridDBColumn;
    cxgrdFetaures: TcxGridLevel;
    grdTechFeatures: TcxGrid;
    grdTechFeaturesDB: TcxGridDBTableView;
    cxGridDBTechFeature: TcxGridDBColumn;
    cxgrdTechFeatures: TcxGridLevel;
    lbTechFeatures: TLabel;
    pgImage: TPageControl;
    tsImage1: TTabSheet;
    tsImage2: TTabSheet;
    SubListImage: TSubListPanel;
    SubListImage2: TSubListPanel;
    procedure FormCreate(Sender: TObject);
    procedure quFeaturesAfterOpen(DataSet: TDataSet);
    procedure quTechFeatureAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    fIDModel : Integer;
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
  end;

implementation

uses uDM, uParamFunctions;

{$R *.dfm}

{ TSubModelWebInfo }

procedure TSubModelWebInfo.AfterSetParam;
begin
  inherited;

  fIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);

  SubListImage.Param  := FParam + 'ImageNum=1;';
  SubListImage2.Param := FParam + 'ImageNum=2;';
  DataSetRefresh;

end;

procedure TSubModelWebInfo.DataSetClose;
begin
  inherited;
  with quFeatures do
     if Active then
        Close;

  with quTechFeature do
     if Active then
        Close;

end;

procedure TSubModelWebInfo.DataSetOpen;
begin
  inherited;
  with quFeatures do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := fIDModel;
        Open;
        end;

  with quTechFeature do
     if not Active then
        begin
        Parameters.ParamByName('IDModel').Value := fIDModel;
        Open;
        end;

end;

procedure TSubModelWebInfo.DataSetRefresh;
begin
   DataSetClose;
   DataSetOpen;
end;

procedure TSubModelWebInfo.FormCreate(Sender: TObject);
begin
  inherited;
  SubListImage.CreateSubList;
  SubListImage2.CreateSubList;
  SubListImage.Param  := 'IDModel=0;ShowOpen=0;BackColor=clGray;StartImage=;Stretch=T;ImageNum=1;';
  SubListImage2.Param := 'IDModel=0;ShowOpen=0;BackColor=clGray;StartImage=;Stretch=T;ImageNum=2;';
  pnlFeatures.Visible := true;
end;

procedure TSubModelWebInfo.quFeaturesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //lbFeatures.Visible := not DataSet.IsEmpty;
end;

procedure TSubModelWebInfo.quTechFeatureAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //lbTechFeatures.Visible := not DataSet.IsEmpty;
end;

initialization
   RegisterClass(TSubModelWebInfo);


end.
