unit uFchMargem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichasBrowse, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxGridCustomPopupMenu, cxGridPopupMenu, dxPSCore,
  dxPScxGridLnk, FormConfig, ADODB, PowerADOQuery, siComp, siLangRT,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchMargem = class(TbrwFrmParentBrw)
    quFormIDMargemTable: TIntegerField;
    quFormMargemTable: TStringField;
    quBrowseIDMargemTableRange: TIntegerField;
    quBrowseIDMargemTable: TIntegerField;
    quBrowseMinValue: TBCDField;
    quBrowseMaxValue: TBCDField;
    quBrowsePercentage: TFloatField;
    edtMargemName: TDBEdit;
    Label35: TLabel;
    lbRoundName: TLabel;
    grdBrowseDBMinValue: TcxGridDBColumn;
    grdBrowseDBMaxValue: TcxGridDBColumn;
    grdBrowseDBPercentage: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FchMargem: TFchMargem;

implementation

uses uFchMargemRange, uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFchMargem.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchMargemRange.Create(Self);
end;

procedure TFchMargem.btRemoveClick(Sender: TObject);
begin
  inherited;
    if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
      begin
        try
          with DM.quFreeSQL do
            begin
              Close;       // Verificar vazio
              SQL.Text := 'Delete from MargemTableRange where IDMargemTableRange ='+InttoStr(quBrowseIDMargemTableRange.AsInteger);
              ExecSQL;
              Close;
            end;
          BrowseRefresh('');
        except
          MsgBox(MSG_CRT_NOT_DEL_PURCHASE, vbCritical + vbOkOnly);
        end;
      end;

end;

end.
