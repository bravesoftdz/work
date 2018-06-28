unit uFrmPromoPrizeItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Buttons, Mask, SuperComboADO, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, DBClient, Provider, ADODB;

type
  TfrmPromoPrizeItem = class(TFrmParent)
    Panel5: TPanel;
    lblCategory: TLabel;
    lblGroup: TLabel;
    lblSubGroup: TLabel;
    btnCategClear: TButton;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    btSearch: TBitBtn;
    scModel: TSuperComboADO;
    Label11: TLabel;
    Button1: TButton;
    scVendor: TSuperComboADO;
    lblVendor: TLabel;
    btnAllVendor: TButton;
    pnlButtons: TPanel;
    btSelectAll: TSpeedButton;
    btUnSelectAll: TSpeedButton;
    Panel9: TPanel;
    grdPromoPrizeItensFilter: TcxGrid;
    grdPromoPrizeItensFilterDB: TcxGridDBTableView;
    grdPromoPrizeItensFilterLevel: TcxGridLevel;
    quModel: TADODataSet;
    dspModel: TDataSetProvider;
    cdsPromoPrizeItem: TClientDataSet;
    dtsPromoPrizeItem: TDataSource;
    quModelIDModel: TIntegerField;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    cdsPromoPrizeItemIDModel: TIntegerField;
    cdsPromoPrizeItemModel: TStringField;
    cdsPromoPrizeItemDescription: TStringField;
    grdPromoPrizeItensFilterDBIDModel: TcxGridDBColumn;
    grdPromoPrizeItensFilterDBModel: TcxGridDBColumn;
    grdPromoPrizeItensFilterDBDescription: TcxGridDBColumn;
    grdPromoPrizeItensFilterDBValidation: TcxGridDBColumn;
    btSave: TButton;
    quModelValidation: TBooleanField;
    cdsPromoPrizeItemValidation: TBooleanField;
    scCategory: TSuperComboADO;
    scManufacturer: TSuperComboADO;
    btFabricanteAll: TButton;
    lblManufacturer: TLabel;
    cdsResult: TClientDataSet;
    cdsResultIDModel: TIntegerField;
    cdsResultModel: TStringField;
    cdsResultDescription: TStringField;
    procedure btnAllVendorClick(Sender: TObject);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
  private
    FIDPromoItem: Integer;

    procedure RefreshRequest;
    procedure CheckAll(AValue: Boolean);
    procedure VerifyEnabledCheck;
    function AddPromoPrizeItem: Boolean;
    function NotExistsPrizeItem(AIDModel :Integer): Boolean;
  public
    function Start(AIDPromoItem: integer): Boolean;
  end;

implementation

uses uDM;

{$R *.dfm}

procedure TfrmPromoPrizeItem.btnAllVendorClick(Sender: TObject);
begin
  scVendor.LookUpValue := '';
  scVendor.Text := '<-->';
end;

procedure TfrmPromoPrizeItem.btnCategClearClick(Sender: TObject);
begin
  scCategory.LookUpValue := '';
  scCategory.Text := '<-->';
end;

procedure TfrmPromoPrizeItem.btnGroupClearClick(Sender: TObject);
begin
  scGroup.LookUpValue := '';
  scGroup.Text := '<-->';
end;

procedure TfrmPromoPrizeItem.btnSubGroupClearClick(Sender: TObject);
begin
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<-->';
end;

procedure TfrmPromoPrizeItem.Button1Click(Sender: TObject);
begin
  scModel.LookUpValue := '';
  scModel.Text := '<-->';
end;

procedure TfrmPromoPrizeItem.btSearchClick(Sender: TObject);
begin
  RefreshRequest;
end;

procedure TfrmPromoPrizeItem.RefreshRequest;
begin
  with cdsPromoPrizeItem do
  try
    Close;
    Screen.Cursor := crHourGlass;
    FetchParams;

    //Params.ParambyName('IDPromoItem').Value := FIDPromoItem;

    if scModel.LookUpValue <> '' then
      Params.ParambyName('IDModel').Value := StrToInt(scModel.LookUpValue)
    else
      Params.ParambyName('IDModel').Value := Null;

    if scCategory.LookUpValue <> '' then
      Params.ParambyName('GroupID').Value := StrToInt(scCategory.LookUpValue)
    else
      Params.ParambyName('GroupID').Value := Null;

    if scGroup.LookUpValue <> '' then
      Params.ParambyName('IDModelGroup').Value := StrToInt(scGroup.LookUpValue)
    else
      Params.ParambyName('IDModelGroup').Value := Null;

    if scSubGroup.LookUpValue <> '' then
      Params.ParambyName('IDModelSubGroup').Value := StrToInt(scSubGroup.LookUpValue)
    else
      Params.ParambyName('IDModelSubGroup').Value := Null;

    if scVendor.LookUpValue <> '' then
      Params.ParambyName('IDPessoa').Value := StrToInt(scVendor.LookUpValue)
    else
      Params.ParambyName('IDPessoa').Value := Null;

    if scManufacturer.LookUpValue <> '' then
      Params.ParambyName('IDFabricante').Value := StrToInt(scManufacturer.LookUpValue)
    else
      Params.ParambyName('IDFabricante').Value := Null;

    Open;
    VerifyEnabledCheck;

 //   showmessage(format('records %d' , [cdsPromoPrizeItem.recordcount]));


  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPromoPrizeItem.btSelectAllClick(Sender: TObject);
begin
  CheckAll(True);
end;

procedure TfrmPromoPrizeItem.btUnSelectAllClick(Sender: TObject);
begin
  CheckAll(False);
end;


procedure TfrmPromoPrizeItem.CheckAll(AValue: Boolean);
begin
  with cdsPromoPrizeItem do
   try
     Screen.Cursor := crHourGlass;
     DisableControls;
     dtsPromoPrizeItem.DataSet := nil;
     First;
     while not Eof DO
     begin
       Edit;
       FieldByName('Validation').Value := AValue;
       Post;
       Next;
     end;
   finally
    Screen.Cursor := crDefault;
    EnableControls;
    dtsPromoPrizeItem.DataSet := cdsPromoPrizeItem;
   end;
end;

function TfrmPromoPrizeItem.Start(AIDPromoItem: Integer): Boolean;
begin
  FIDPromoItem := AIDPromoItem;

  VerifyEnabledCheck;

  ShowModal;

  if (ModalResult = mrOk) then
    Result := AddPromoPrizeItem
  else
    Result := False;
end;

function TfrmPromoPrizeItem.AddPromoPrizeItem: Boolean;
var
  IDPromoPrizeItem : Integer;
begin
  cdsResult.Close;
  cdsResult.CreateDataSet;
  with cdsPromoPrizeItem do
  begin
    try
      First;
      while not Eof do
      begin
        if FieldByName('Validation').AsBoolean then
        begin
          cdsResult.Append;
          cdsResultIDModel.Value := cdsPromoPrizeItemIDModel.Value;
          cdsResultModel.Value := cdsPromoPrizeItemModel.Value;
          cdsResultDescription.Value := cdsPromoPrizeItemDescription.Value;
          cdsResult.Post;
        end;
        {
        if FieldByName('Validation').AsBoolean then
          if NotExistsPrizeItem(cdsPromoPrizeItem.FieldByName('IDModel').AsInteger) then
          begin
            IDPromoPrizeItem := DM.GetNextID('Sal_PromoPrizeItem.IDPromoprizeItem');
            DM.RunSQL('INSERT INTO Sal_PromoPrizeitem (IDPromoPrizeItem,IDPromoItem, IDModel) VALUES ( ' + InttoStr(IDPromoprizeItem) + ' , ' + InttoStr(FIDPromoItem) + ' , ' + cdsPromoPrizeItem.FieldByName('IDModel').AsString + ')');
          end;
        }
        Next;
      end;

      Result := True;
    except
      Result := False;
    end;
  end;
end;


procedure TfrmPromoPrizeItem.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmPromoPrizeItem.NotExistsPrizeItem(AIDModel: Integer): Boolean;
begin
  with DM.quFreeSQL do
    begin
      if Active then
        Close;

      SQL.Text := 'SELECT IDModel FROM Sal_PromoPrizeItem (NOLOCK) WHERE IDPromoItem = ' + InttoStr(FIDPromoItem) + ' AND IDModel = ' + InttoStr(AIDModel);
      Open;

      Result := DM.quFreeSQL.IsEmpty;
    end;
end;

procedure TfrmPromoPrizeItem.VerifyEnabledCheck;
begin
  if (cdsPromoPrizeItem.Active = False) or (cdsPromoPrizeItem.RecordCount = 0) then
  begin
    pnlButtons.Enabled    := False;
    btSelectAll.Enabled   := False;
    btUnSelectAll.Enabled := False;
  end
  else
  begin
    pnlButtons.Enabled    := True;
    btSelectAll.Enabled   := True;
    btUnSelectAll.Enabled := True;
  end;
end;

procedure TfrmPromoPrizeItem.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scManufacturer.LookUpValue := '';
  scManufacturer.Text        := '<-->';
end;

end.
