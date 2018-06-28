unit uFrmCountInventoryConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  CheckLst, DB, ADODB;

type
  TFrmCountInventoryConfig = class(TFrmParentAll)
    btOk: TButton;
    clbCategory: TCheckListBox;
    edtNumItem: TEdit;
    lbNumItem: TLabel;
    Label1: TLabel;
    cmbPrint: TComboBox;
    quCategory: TADOQuery;
    quCategoryIDGroup: TIntegerField;
    quCategoryName: TStringField;
    cmdUpdPrint: TADOCommand;
    cmdUpdCategory: TADOCommand;
    cmdUpdNumItens: TADOCommand;
    Label9: TLabel;
    Label2: TLabel;
    quGetCategory: TADOQuery;
    quGetPrint: TADOQuery;
    quGetPrintPropertyValue: TStringField;
    quGetCategoryPropertyValue: TStringField;
    quGetNumber: TADOQuery;
    quGetNumberPropertyValue: TStringField;
    btCheckAll: TSpeedButton;
    btUnCheckAll: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btCheckAllClick(Sender: TObject);
    procedure btUnCheckAllClick(Sender: TObject);
  private
    sCategory : String;
    fCategList: TStringList;

    //Get
    procedure GetCategoryList;
    procedure GetCategory;

    procedure GetNumberOfItens;
    procedure GetPrintWhen;

    //Set
    procedure SetCategoryRights;

    //Update
    procedure UpdateNumberOfItens;
    procedure UpdatePrintWhen;
    procedure UpdateCategory;

    procedure CategoryOpen;
    procedure CategoryClose;

    procedure CheckAll(AType: Boolean);

    function VerifyCheckID(AID: Integer):Boolean;
    function ApplyUpdate:Boolean;

  public
    function Start:Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmCountInventoryConfig }

function TFrmCountInventoryConfig.Start: Boolean;
begin
  GetNumberOfItens;
  GetPrintWhen;
  GetCategory;
  GetCategoryList;
  
  ShowModal;
  Result := (ModalResult = mrOk);
end;

procedure TFrmCountInventoryConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(fCategList);
  Action := caFree;
end;

procedure TFrmCountInventoryConfig.GetCategoryList;
var
  i: Integer;
begin
  with quCategory do
  try
    Open;
    First;
    while not Eof do
    begin
      i := clbCategory.Items.Add(quCategoryName.AsString);
      clbCategory.Checked[i] := VerifyCheckID(quCategoryIDGroup.AsInteger);
      Next;
    end;
  finally
    Close;
  end;
end;

procedure TFrmCountInventoryConfig.SetCategoryRights;
var
  i: Integer;
begin
  CategoryOpen;
  sCategory := '';

  with clbCategory do
    for i := 0 to Items.Count-1 do
      if Checked[i] then
        if quCategory.Locate('Name', Items[i], []) then
        begin
          if sCategory <> '' then
            sCategory := sCategory + ', ' + quCategoryIDGroup.AsString
          else
            sCategory := ' ' + quCategoryIDGroup.AsString;
        end;
end;

procedure TFrmCountInventoryConfig.CategoryOpen;
begin
  with quCategory do
    if not Active then
      Open;
end;

procedure TFrmCountInventoryConfig.CategoryClose;
begin
  with quCategory do
    if Active then
      Close;
end;

procedure TFrmCountInventoryConfig.GetNumberOfItens;
begin
  with quGetNumber do
  begin
    if Active then
      Close;
    Parameters.ParamByName('Property').Value := 'InvCountConfigNumItens';
    Open;
  end;

  edtNumItem.Text := quGetNumberPropertyValue.AsString;

end;

procedure TFrmCountInventoryConfig.GetPrintWhen;
begin

  with quGetPrint do
  begin
    if Active then
      Close;
    Parameters.ParamByName('Property').Value := 'InvCountConfigPrintWhen';
    Open;
  end;

  cmbPrint.ItemIndex := StrToInt(quGetPrintPropertyValue.AsString);

end;

procedure TFrmCountInventoryConfig.GetCategory;
begin
  with quGetCategory do
  begin
    if Active then
      Close;
    Parameters.ParamByName('Property').Value := 'InvCountConfigCategory';
    Open;
  end;

  fCategList.CommaText := StringReplace(quGetCategoryPropertyValue.AsString,',','',[rfReplaceAll]);
end;

function TFrmCountInventoryConfig.ApplyUpdate: Boolean;
begin
  try
    Result := True;
    SetCategoryRights;
    UpdateCategory;
    UpdateNumberOfItens;
    UpdatePrintWhen;
  except
    on E: Exception do
    begin
      Result := False;
      MsgBox('Error on Apply Updates_' + E.Message, vbCritical + vbOkOnly );
    end;
  end;
end;

procedure TFrmCountInventoryConfig.UpdateNumberOfItens;
begin
  with cmdUpdNumItens do
  begin
    Parameters.ParamByName('PropertyValue').Value := edtNumItem.Text;
    Parameters.ParamByName('Property').Value := 'InvCountConfigNumItens';
    Execute;
  end;
end;

procedure TFrmCountInventoryConfig.UpdatePrintWhen;
begin
  with cmdUpdPrint do
  begin
    Parameters.ParamByName('PropertyValue').Value := cmbPrint.ItemIndex;
    Parameters.ParamByName('Property').Value := 'InvCountConfigPrintWhen';
    Execute;
  end;
end;

procedure TFrmCountInventoryConfig.UpdateCategory;
begin
  with cmdUpdCategory do
  begin
    Parameters.ParamByName('PropertyValue').Value := sCategory;
    Parameters.ParamByName('Property').Value := 'InvCountConfigCategory';
    Execute;
  end;
end;

procedure TFrmCountInventoryConfig.btOkClick(Sender: TObject);
begin
  inherited;
  if not ApplyUpdate then
    ModalResult := mrNone;
end;

function TFrmCountInventoryConfig.VerifyCheckID(AID: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to fCategList.Count -1 do
    if IntToStr(AID) = fCategList.Strings[i] then
    begin
      Result := True;
      Break;
    end;
end;

procedure TFrmCountInventoryConfig.FormCreate(Sender: TObject);
begin
  inherited;
  fCategList := TStringList.Create;
end;

procedure TFrmCountInventoryConfig.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCountInventoryConfig.CheckAll(AType: Boolean);
var
  i: Integer;
begin
  for i:= 0 to clbCategory.Count -1 do
    clbCategory.Checked[i] := AType;
end;

procedure TFrmCountInventoryConfig.btCheckAllClick(Sender: TObject);
begin
  inherited;
  CheckAll(True);
end;

procedure TFrmCountInventoryConfig.btUnCheckAllClick(Sender: TObject);
begin
  inherited;
  CheckAll(False);
end;

end.
