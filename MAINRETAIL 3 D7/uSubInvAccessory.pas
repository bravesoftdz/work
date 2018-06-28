unit uSubInvAccessory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DB, ADODB, StdCtrls, DBCtrls,
  ExtCtrls, dbcgrids;

type
  TSubInvAccessory = class(TParentSub)
    quAccessory: TADOQuery;
    quAccessoryIDInvAccessory: TIntegerField;
    quAccessoryIDModel: TIntegerField;
    quAccessoryModel: TStringField;
    dsAccessory: TDataSource;
    quAccessoryHint: TStringField;
    quAccessoryLargeImage: TStringField;
    quAccessorySellingPrice: TBCDField;
    quAccessoryf: TIntegerField;
    gridSuggestion: TDBCtrlGrid;
    DBText1: TDBText;
    DBText2: TDBText;
    lblTitle: TLabel;
    quAccessoryTotQtyOnHand: TFloatField;
    procedure quAccessoryAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fIDModel : Integer;
    sNoRecs,
    sRec : String;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uDMGlobal, uParamFunctions, DBTables;

{$R *.dfm}

{ TSubInvAccessory }

procedure TSubInvAccessory.AfterSetParam;
begin
  inherited;

 if FParam = '' then
    Exit;

 fIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
 DataSetRefresh;

end;

procedure TSubInvAccessory.DataSetClose;
begin
  inherited;
  with quAccessory do
    if Active then
       Close;
end;

procedure TSubInvAccessory.DataSetOpen;
begin
  inherited;
  with quAccessory do
    if not Active then
       begin
       Parameters.ParamByName('IDModel').Value := fIDModel;
       Open;
       end;
end;

procedure TSubInvAccessory.DataSetRefresh;
begin
 DataSetClose;
 DataSetOpen;
end;

procedure TSubInvAccessory.quAccessoryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.RecordCount = 0 then
     begin
     lblTitle.Caption       := sNoRecs;
     gridSuggestion.Visible := False;
     end
  else
     begin
     lblTitle.Caption       := Format(sRec, [DataSet.RecordCount]);
     gridSuggestion.Visible := True;
     end;
end;

procedure TSubInvAccessory.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sNoRecs := 'No suggestion';
           sRec    := 'There are (%D) Suggestions';
           end;

     LANG_PORTUGUESE :
           begin
           sNoRecs := 'Sem sugestão de vendas';
           sRec    := 'Existem (%D) Sugestão de vendas';
           end;

     LANG_SPANISH :
           begin
           sNoRecs := 'No Sugerencias';
           sRec    := 'Existem (%D) sugerencia de ventas';
           end;
   end;

end;

initialization
   RegisterClass(TSubInvAccessory);

end.
