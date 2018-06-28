unit uFrmModelAddSizeColor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, Db,
  ADODB, PowerADOQuery, CheckLst, Variants, Mask, SuperComboADO;

type
  TFrmModelAddSizeColor = class(TFrmParentAll)
    btnSave: TBitBtn;
    quColor: TPowerADOQuery;
    quColorIDColor: TIntegerField;
    quColorCodColor: TStringField;
    quColorColor: TStringField;
    dsColor: TDataSource;
    quSize: TPowerADOQuery;
    quSizeIDSize: TIntegerField;
    quSizeCodSize: TStringField;
    quSizeSizeName: TStringField;
    dsSize: TDataSource;
    Panel9: TPanel;
    pnlTitle6: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    clbSize: TCheckListBox;
    clbColor: TCheckListBox;
    spAddSize: TADOStoredProc;
    spAddColor: TADOStoredProc;
    Label1: TLabel;
    quMatrix: TADOQuery;
    quMatrixIDModel: TAutoIncField;
    quMatrixColor: TStringField;
    quMatrixSizeName: TStringField;
    quMatrixIDSize: TIntegerField;
    quMatrixIDColor: TIntegerField;
    quMatrixIDFabricante: TIntegerField;
    chkBarcodeCreate: TCheckBox;
    quBarcode: TADOQuery;
    quBarcodeIDBarCode: TStringField;
    quBarcodeIDModel: TIntegerField;
    quBarcodeData: TDateTimeField;
    scSize: TSuperComboADO;
    btnSize: TButton;
    btnColor: TButton;
    scColor: TSuperComboADO;
    quMatrixGroupID: TIntegerField;
    quBarcodeBarcodeOrder: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkBarcodeCreateClick(Sender: TObject);
    procedure scSizeSelectItem(Sender: TObject);
    procedure scColorSelectItem(Sender: TObject);
    procedure btnSizeClick(Sender: TObject);
    procedure btnColorClick(Sender: TObject);
  private
    fIDModel : Integer;

    procedure OpenColor;
    procedure CloseColor;

    procedure OpenSize;
    procedure CloseSize;

    procedure DisplayColor;
    procedure DisplaySize;

    procedure SaveColor;
    procedure SaveSize;
  public
    function Start(IDModel:Integer):Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uSQLFunctions;

{$R *.DFM}

procedure TFrmModelAddSizeColor.SaveColor;
var
  i: Integer;
begin
  OpenColor;

  with clbColor do
    for i := 0 to Pred(Items.Count) do
      if Checked[i] then
        if quColor.Locate('Color', Items[i], []) then
        try
          spAddColor.Parameters.ParamByName('@IDModel').Value := fIDModel;
          spAddColor.Parameters.ParamByName('@IDColor').Value := quColorIDColor.AsInteger;
          spAddColor.Parameters.ParamByName('@BarcodeCreate').Value := chkBarcodeCreate.Checked;
          try
            DM.ADODBConnect.BeginTrans;
            spAddColor.ExecProc;
            DM.ADODBConnect.CommitTrans;
          except
            DM.ADODBConnect.RollbackTrans;
            end;
        except
          MsgBox(MSG_CRT_ERROR_ADD_COLOR, vbOkOnly + vbCritical);
        end;

  CloseColor;
end;

procedure TFrmModelAddSizeColor.SaveSize;
var
  i: Integer;
begin
  OpenSize;

  with clbSize do
    for i := 0 to Items.Count-1 do
      if Checked[i] then
        if quSize.Locate('SizeName', Items[i], []) then
        try
          spAddSize.Parameters.ParamByName('@IDModel').Value := fIDModel;
          spAddSize.Parameters.ParamByName('@IDSize').Value  := quSizeIDSize.AsInteger;
          spAddSize.Parameters.ParamByName('@BarcodeCreate').Value := chkBarcodeCreate.Checked;
          try
            DM.ADODBConnect.BeginTrans;
            spAddSize.ExecProc;
            DM.ADODBConnect.CommitTrans;
          except
            DM.ADODBConnect.RollbackTrans;
            end;
        except
          MsgBox(MSG_CRT_ERROR_ADD_COLOR, vbOkOnly + vbCritical);
        end;

  CloseSize;
end;

procedure TFrmModelAddSizeColor.DisplayColor;
begin
  OpenColor;
  clbColor.Items.Clear;

  with quColor do
    while not EOF do
    begin
      clbColor.Items.Add(quColorColor.AsString);
      Next;
    end;

  CloseColor;
end;

procedure TFrmModelAddSizeColor.DisplaySize;
begin

  OpenSize;

  clbSize.Items.Clear;

  with quSize do
     while not EOF do
       begin
       clbSize.Items.Add(quSizeSizeName.AsString);
       Next;
       end;

  CloseSize;


end;

procedure TFrmModelAddSizeColor.OpenColor;
var
  sWhere : String;
begin
  with quColor do
    if not Active then
      begin
      sWhere := ' C.Desativado = 0 AND C.Hidden = 0 ';
      if scColor.LookUpValue <> '' then
         sWhere := sWhere + ' AND CG.IDSizeColorGroup = ' + scColor.LookUpValue;
      CommandText := ChangeWhereClause(CommandText, sWhere, True);
      Open;
      end;
end;

procedure TFrmModelAddSizeColor.CloseColor;
begin

  with quColor do
    if Active then
      Close;

end;

procedure TFrmModelAddSizeColor.OpenSize;
var
  sWhere : String;
begin
  with quSize do
    if not Active then
      begin
      sWhere := ' S.Desativado = 0 AND S.Hidden = 0 ';
      if scSize.LookUpValue <> '' then
         sWhere := sWhere + ' AND SG.IDSizeColorGroup = '+ scSize.LookUpValue;
      CommandText := ChangeWhereClause(CommandText, sWhere, True);
      Open;
      end;
end;

procedure TFrmModelAddSizeColor.CloseSize;
begin
  with quSize do
    if Active then
      Close;
end;

function TFrmModelAddSizeColor.Start(IDModel:Integer):Boolean;
begin
  Result   := False;
  fIDModel := IDModel;
  DisplaySize;
  DisplayColor;

  if (ShowModal = mrOk) then
  begin
    Screen.Cursor := crHourGlass;
    SaveColor;
    SaveSize;
    Screen.Cursor := crDefault;
    Result := True;
  end;
end;

procedure TFrmModelAddSizeColor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmModelAddSizeColor.chkBarcodeCreateClick(Sender: TObject);
begin
  inherited;
  Label1.Visible := chkBarcodeCreate.Checked; 
end;

procedure TFrmModelAddSizeColor.scSizeSelectItem(Sender: TObject);
begin
  inherited;
  //Atualizar a lista de Size
  DisplaySize;
end;

procedure TFrmModelAddSizeColor.scColorSelectItem(Sender: TObject);
begin
  inherited;
  //Atualizar a lista de color
  DisplayColor; 
end;

procedure TFrmModelAddSizeColor.btnSizeClick(Sender: TObject);
begin
  inherited;
  scSize.LookUpValue := '';
  scSize.SetFocus;
  DisplaySize; 
end;

procedure TFrmModelAddSizeColor.btnColorClick(Sender: TObject);
begin
  inherited;
  scColor.LookUpValue := '';
  scColor.SetFocus;
  DisplayColor; 
end;

end.
