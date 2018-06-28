unit uFrmDescriptionPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Buttons, PanelRights, ADODB, Provider,
  DBClient, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls;

type
  TFrmDescriptionPrice = class(TFrmParent)
    dsDescriptionPrice: TDataSource;
    cdsDescriptionPrice: TClientDataSet;
    dspDescriptionPrice: TDataSetProvider;
    qryDescriptionPrice: TADOQuery;
    pnlButton: TPanelRights;
    btRemove: TSpeedButton;
    btAdd: TSpeedButton;
    grdModelPrice: TcxGrid;
    grdModelPriceDBTableView: TcxGridDBTableView;
    grdModelPriceLevel: TcxGridLevel;
    qryDescriptionPriceIDDescriptionPrice: TIntegerField;
    qryDescriptionPriceDescriptionPrice: TStringField;
    cdsDescriptionPriceIDDescriptionPrice: TIntegerField;
    cdsDescriptionPriceDescriptionPrice: TStringField;
    grdModelPriceDBTableViewIDDescriptionPrice: TcxGridDBColumn;
    grdModelPriceDBTableViewDescriptionPrice: TcxGridDBColumn;
    btSave: TButton;
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dspDescriptionPriceBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
  private
    function CanDelete: Boolean;
  public
    function Start: Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmDescriptionPrice }

function TFrmDescriptionPrice.Start: Boolean;
begin
  cdsDescriptionPrice.Open;

  ShowModal;

  cdsDescriptionPrice.Close;
  Result := ModalResult = mrOk;
end;

procedure TFrmDescriptionPrice.btAddClick(Sender: TObject);
begin
  inherited;
  cdsDescriptionPrice.Append;
end;

procedure TFrmDescriptionPrice.btRemoveClick(Sender: TObject);
begin
  inherited;
  if CanDelete then
    cdsDescriptionPrice.Delete
  else
    MsgBox(MSG_CRT_NO_DEL_RECORD, vbInformation + vbOKOnly);
end;

procedure TFrmDescriptionPrice.btSaveClick(Sender: TObject);
begin
  inherited;
  if cdsDescriptionPrice.ApplyUpdates(-1) > 0 then
  begin
    MsgBox(MSG_CRT_ERROR_OCURRED, vbCritical + vbOKOnly);
    ModalResult := mrNone;
  end;
end;

procedure TFrmDescriptionPrice.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_ADD, btAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemove.Glyph);
end;

procedure TFrmDescriptionPrice.dspDescriptionPriceBeforeUpdateRecord(
  Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  inherited;
  if UpdateKind = ukInsert then
  begin
    DeltaDS.Edit;
    DeltaDS.FieldByName('IDDescriptionPrice').Value := DM.GetNextID('Inv_DescriptionPrice.IDDescriptionPrice');
    DeltaDS.Post;
  end;
end;

function TFrmDescriptionPrice.CanDelete: Boolean;
begin
  Result := True;

  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT');
    SQL.Add('  COUNT(IDP.IDDescriptionPrice) Total');
    SQL.Add('FROM');
    SQL.Add('  Inv_DescriptionPrice IDP');
    SQL.Add('  LEFT JOIN (SELECT IDDescriptionPrice FROM Inv_ModelPrice WHERE IDDescriptionPrice = :IMPIDDescriptionPrice) IMP ON (IDP.IDDescriptionPrice = IMP.IDDescriptionPrice)');
    SQL.Add('  LEFT JOIN (SELECT IDDescriptionPrice FROM Inv_StorePrice WHERE IDDescriptionPrice = :ISPIDDescriptionPrice) ISP ON (IDP.IDDescriptionPrice = ISP.IDDescriptionPrice)');
    SQL.Add('  LEFT JOIN (SELECT IDDescriptionPrice FROM Inv_MovPrice WHERE IDDescriptionPrice = :MPIDDescriptionPrice) MP ON (IDP.IDDescriptionPrice = MP.IDDescriptionPrice)');
    SQL.Add('WHERE');
    SQL.Add('  IMP.IDDescriptionPrice IS NOT NULL');
    SQL.Add('  OR ISP.IDDescriptionPrice IS NOT NULL');
    SQL.Add('  OR MP.IDDescriptionPrice IS NOT NULL');

    Parameters.ParamByName('IMPIDDescriptionPrice').Value := cdsDescriptionPriceIDDescriptionPrice.Value;
    Parameters.ParamByName('ISPIDDescriptionPrice').Value := cdsDescriptionPriceIDDescriptionPrice.Value;
    Parameters.ParamByName('MPIDDescriptionPrice').Value := cdsDescriptionPriceIDDescriptionPrice.Value;
    Open;

    Result := FieldByName('Total').AsInteger = 0;
  finally
    Close;
  end;
end;

end.
