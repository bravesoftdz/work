unit uFchSOStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchSOStatus = class(TbrwFrmParent)
    quFormIDSOStatus: TIntegerField;
    quFormSOStatus: TStringField;
    quFormColor: TStringField;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    pnlMenuHighlight: TPanel;
    Label13: TLabel;
    CD: TColorDialog;
    procedure pnlMenuHighlightClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

procedure TFchSOStatus.pnlMenuHighlightClick(Sender: TObject);
begin
  inherited;
  CD.Color := TPanel(Sender).Color;
  if CD.Execute then
     TPanel(Sender).Color := CD.Color;
end;

procedure TFchSOStatus.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if quFormColor.AsString <> '' then
    pnlMenuHighlight.Color := StringToColor(quFormColor.AsString);
end;

procedure TFchSOStatus.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quFormColor.AsString := ColorToString(pnlMenuHighlight.Color);
end;

end.
