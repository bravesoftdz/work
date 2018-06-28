unit uFchRound;

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
  TFchRound = class(TbrwFrmParentBrw)
    grdBrowseDBMinValue: TcxGridDBColumn;
    grdBrowseDBMaxValue: TcxGridDBColumn;
    quBrowseIDRoundingTableRange: TIntegerField;
    quBrowseMinValue: TBCDField;
    quBrowseMaxValue: TBCDField;
    quBrowseRoundValues: TStringField;
    quBrowseRoundType: TIntegerField;
    quFormIDRoundingTable: TIntegerField;
    quFormRoundingTable: TStringField;
    quBrowseIDRoundingTable: TIntegerField;
    lbRoundName: TLabel;
    edtRoundName: TDBEdit;
    Label35: TLabel;
    quBrowseRoundTypeName: TStringField;
    grdBrowseDBRoundTypeName: TcxGridDBColumn;
    grdBrowseDBRoundValues: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure btRemoveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAddClick(Sender: TObject);
  private
    sUp,
    sDown,
    sNear : String;
    procedure OnCreateFicha; override;
  public
    { Public declarations }
  end;

implementation

uses uFchRoundRange, uDMGlobal, uDM, uMsgBox, uMsgConstant;
{$R *.dfm}

{ TFchRound }

procedure TFchRound.OnCreateFicha;
begin
  inherited;
  brwForm  := TFchRoundRange.Create(Self);
end;

procedure TFchRound.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sUp   := 'Up';
           sDown := 'Down';
           sNear := 'Nearest';
           end;

     LANG_PORTUGUESE :
           begin
           sUp   := 'Cima';
           sDown := 'Baixo';
           sNear := '+ Proximo';
           end;

     LANG_SPANISH :
           begin
           sUp   := 'Up';
           sDown := 'Down';
           sNear := 'Nearest';
           end;
   end;

end;

procedure TFchRound.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;

   case quBrowseRoundType.AsInteger of
    1 : quBrowseRoundTypeName.AsString := sUp;
    2 : quBrowseRoundTypeName.AsString := sDown;
    3 : quBrowseRoundTypeName.AsString := sNear;
   end;

end;

procedure TFchRound.btRemoveClick(Sender: TObject);
begin
  inherited;
    if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
      begin
        try
          with DM.quFreeSQL do
            begin
              Close;       // Verificar vazio
              SQL.Text := 'Delete from RoundingTableRange where IDRoundingTableRange ='+InttoStr(quBrowseIDRoundingTableRange.AsInteger);
              ExecSQL;
              Close;
            end;
          BrowseRefresh('');
          //quForm.Edit;
        except
          MsgBox(MSG_CRT_NOT_DEL_PURCHASE, vbCritical + vbOkOnly);
        end;
      end;
end;

procedure TFchRound.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F4 then
  begin
    if not quBrowse.IsEmpty then
    begin
      if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
      begin
        with DM.quFreeSQL do
        begin
          Close;       // Verificar vazio
          SQL.Text := 'Delete from RoundingTableRange where IDRoundingTableRange ='+InttoStr(quBrowseIDRoundingTableRange.AsInteger);
          ExecSQL;
          Close;
        end;
        BrowseRefresh('');
      end;
    end;
  end
  else
   inherited;

end;

procedure TFchRound.btAddClick(Sender: TObject);
begin

  if (trim(edtRoundName.Text) = '') then begin
      MsgBox(MSG_INF_OBLIGATORY_ROUNDNAME, vbCritical + vbOkOnly);
      edtRoundName.SetFocus;
      exit;
  end;

  inherited;

end;

end.
