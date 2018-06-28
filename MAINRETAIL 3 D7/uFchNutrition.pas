unit uFchNutrition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, uMsgBox, uMsgConstant;

type
  TFchNutrition = class(TbrwFrmParent)
    quFormDescription: TStringField;
    quFormIDNutrition: TIntegerField;
    DBEdit2: TDBEdit;
    Label43: TLabel;
    pnlVendorList: TPanel;
    btnRemoveNutri: TSpeedButton;
    btnModelNutriUP: TSpeedButton;
    btnModelNutriDown: TSpeedButton;
    pnlNutritionItem: TPanel;
    grdNutritionItem: TcxGrid;
    grdNutritionItemDB: TcxGridDBTableView;
    grdNutritionItemLvl: TcxGridLevel;
    btnAddNutri: TSpeedButton;
    lbDescription: TLabel;
    lbNutItem: TLabel;
    edtNutItem: TEdit;
    edtNutSize: TEdit;
    UpDownItemSize: TUpDown;
    quNutritionItem: TADODataSet;
    dsNutritionItem: TDataSource;
    quNutritionItemIDNutritionItem: TIntegerField;
    quNutritionItemIDNutrition: TIntegerField;
    quNutritionItemDescription: TStringField;
    quNutritionItemFieldLength: TIntegerField;
    quNutritionItemFieldPos: TIntegerField;
    grdNutritionItemDBDescription: TcxGridDBColumn;
    grdNutritionItemDBFieldLength: TcxGridDBColumn;
    grdNutritionItemDBFieldPos: TcxGridDBColumn;
    procedure btnAddNutriClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure btnRemoveNutriClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnModelNutriUPClick(Sender: TObject);
    procedure btnModelNutriDownClick(Sender: TObject);
  private
    function ValidateField: Boolean;
    procedure OpenNutrition;
    procedure CloseNutrition;
    procedure RefreshNutrition;
  public
    { Public declarations }
  end;



implementation

uses uDM, uDMGlobal;

{$R *.dfm}

{ TFchNutrition }

function TFchNutrition.ValidateField: Boolean;
begin

  Result := False;

  if (edtNutItem.Text = '') then
  begin
    MsgBox(MSG_INF_NOT_DESCRIPTION_EMPTY, vbOkOnly + vbExclamation);
    Exit;
  end;

  Result := True;

end;

procedure TFchNutrition.btnAddNutriClick(Sender: TObject);
var
  iPos : Integer;
begin
  inherited;

  if ValidateField then
  begin
  
    with quNutritionItem do
      if Active then
      begin
        iPos := RecordCount + 1;
        Append;
        FieldByName('IDNutritionItem').AsInteger := DM.GetNextID('Inv_NutritionItem.IDNutritionItem');
        FieldByName('IDNutrition').AsInteger     := quFormIDNutrition.AsInteger;
        FieldByName('Description').AsString      := edtNutItem.Text;
        FieldByName('FieldLength').AsInteger     := UpDownItemSize.Position;
        FieldByName('FieldPos').AsInteger        := iPos;
        Post;
      end;

    RefreshNutrition;
  end;

  edtNutItem.Clear;
  edtNutItem.SetFocus;

end;

procedure TFchNutrition.CloseNutrition;
begin
  with quNutritionItem do
    if Active then
      Close;
end;

procedure TFchNutrition.OpenNutrition;
begin
  with quNutritionItem do
    if not Active then
    begin
      Parameters.ParamByName('IDNutrition').Value := quFormIDNutrition.AsInteger;
      Open;
    end;
end;

procedure TFchNutrition.RefreshNutrition;
begin
  CloseNutrition;
  OpenNutrition;
end;

procedure TFchNutrition.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  OpenNutrition;
end;

procedure TFchNutrition.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  CloseNutrition;
end;

procedure TFchNutrition.btnRemoveNutriClick(Sender: TObject);
begin
  inherited;

  with quNutritionItem do
    if Active and (RecordCount > 0) then
    begin
      //if State in dsEditModes then Cancel;
      Delete;
      RefreshNutrition;
    end;

end;

procedure TFchNutrition.FormCreate(Sender: TObject);
begin
  inherited;

  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddNutri.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnRemoveNutri.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DOWN, btnModelNutriDown.Glyph);
  DM.imgSmall.GetBitmap(BTN18_UP, btnModelNutriUP.Glyph);

end;

procedure TFchNutrition.btnModelNutriUPClick(Sender: TObject);
begin
  inherited;

  if not quNutritionItem.IsEmpty then
    with quNutritionItem do
    if Locate('IDNutritionItem', quNutritionItemIDNutritionItem.AsString, []) then
      if not BOF then
      begin
        Edit;
        quNutritionItemFieldPos.AsInteger := quNutritionItemFieldPos.AsInteger - 1;
        Post;
        Prior;
        Edit;
        quNutritionItemFieldPos.AsInteger := quNutritionItemFieldPos.AsInteger + 1;
        Post;
        RefreshNutrition;
      end;

end;

procedure TFchNutrition.btnModelNutriDownClick(Sender: TObject);
begin
  inherited;

  if not quNutritionItem.IsEmpty then
    with quNutritionItem do
    if Locate('IDNutritionItem', quNutritionItemIDNutritionItem.AsString, []) then
      if not BOF then
      begin
        Edit;
        quNutritionItemFieldPos.AsInteger := quNutritionItemFieldPos.AsInteger + 1;
        Post;
        Next;
        Edit;
        quNutritionItemFieldPos.AsInteger := quNutritionItemFieldPos.AsInteger - 1;
        Post;
        RefreshNutrition;
      end;

end;

end.
