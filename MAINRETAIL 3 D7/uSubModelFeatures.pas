unit uSubModelFeatures;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, ADODB, DB, PowerADOQuery, StdCtrls;

type
  TSubModelFeatures = class(TParentSub)
    quFeatures: TPowerADOQuery;
    quFeaturesIDInvFeatures: TIntegerField;
    quFeaturesFeature: TStringField;
    quTechFeature: TADOQuery;
    quTechFeatureIDInvTechFeatures: TIntegerField;
    quTechFeatureTechFeature: TStringField;
    memFeatures: TMemo;
  private
    fIDModel : Integer;
    procedure DataSetRefresh;
    procedure AddFeatuesLines;
  protected
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
    procedure AfterSetParam; override;
  public
    { Public declarations }
  end;


implementation

uses uDM, uParamFunctions;

{$R *.dfm}

{ TSubModelFeatures }

procedure TSubModelFeatures.AddFeatuesLines;
begin

  memFeatures.Clear;

  with quFeatures do
    begin
    First;
    while not EOF do
       begin
       memFeatures.Lines.Add(' * ' + quFeaturesFeature.AsString);
       Next;
       end;
    end;

  with quTechFeature do
    begin
    First;
    while not EOF do
       begin
       memFeatures.Lines.Add(' * ' + quTechFeatureTechFeature.AsString);
       Next;
       end;
    end;

  if memFeatures.Lines.Count > 9 then
     memFeatures.ScrollBars := ssVertical
  else
     memFeatures.ScrollBars := ssNone; 

end;

procedure TSubModelFeatures.AfterSetParam;
var
  fColor : String;
begin
  inherited;

  fIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
  fColor   := ParseParam(FParam, 'BackColor');

  if fColor <> '' then
     Self.Color := StringToColor(fColor)
  else
     Self.Color := clWhite;

  memFeatures.Color := Self.Color;

  DataSetRefresh;

end;

procedure TSubModelFeatures.DataSetClose;
begin
  inherited;

  with quFeatures do
     if Active then
        Close;

  with quTechFeature do
     if Active then
        Close;
  
end;

procedure TSubModelFeatures.DataSetOpen;
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

  AddFeatuesLines;

end;

procedure TSubModelFeatures.DataSetRefresh;
begin
   DataSetClose;
   DataSetOpen;
end;

initialization
   RegisterClass(TSubModelFeatures);


end.
