unit uFrmPetSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ADODB,
  Buttons, Mask, SuperComboADO;

type
  TFrmPetSearch = class(TDialogParent)
    Panel3: TPanel;
    grdBrowseSearch: TcxGrid;
    grdBrowseSearchDB: TcxGridDBTableView;
    grdBrowseSearchLevel: TcxGridLevel;
    quPet: TADODataSet;
    dsPet: TDataSource;
    btSearch: TBitBtn;
    edSKU: TEdit;
    lbSKU: TLabel;
    lbSubGroup: TLabel;
    scPetSpecies: TSuperComboADO;
    btnSpeciesClear: TButton;
    quPetIDPet: TIntegerField;
    quPetIDSpecies: TIntegerField;
    quPetIDPorte: TIntegerField;
    quPetIDBreed: TIntegerField;
    quPetIDStatus: TIntegerField;
    quPetIDBreeder: TIntegerField;
    quPetName: TStringField;
    quPetSex: TStringField;
    quPetColor: TStringField;
    quPetSKU: TStringField;
    quPetPenNum: TStringField;
    quPetVendorCost: TBCDField;
    quPetMSRP: TBCDField;
    quPetSalePrice: TBCDField;
    quPetPromoPrice: TBCDField;
    quPetUSDA: TStringField;
    quPetCollar: TStringField;
    quPetSire: TStringField;
    quPetDam: TStringField;
    quPetWhelpDate: TDateTimeField;
    quPetPurchaseDate: TDateTimeField;
    quPetNotes: TStringField;
    quPetSystem: TBooleanField;
    quPetHidden: TBooleanField;
    quPetDesativado: TBooleanField;
    quPetSpecies: TStringField;
    quPetPorte: TStringField;
    quPetBreed: TStringField;
    quPetStatusCode: TStringField;
    quPetStatus: TStringField;
    quPetPessoa: TStringField;
    quPetTelefone: TStringField;
    grdBrowseSearchDBSex: TcxGridDBColumn;
    grdBrowseSearchDBColor: TcxGridDBColumn;
    grdBrowseSearchDBSKU: TcxGridDBColumn;
    grdBrowseSearchDBSalePrice: TcxGridDBColumn;
    grdBrowseSearchDBPromoPrice: TcxGridDBColumn;
    grdBrowseSearchDBSpecies: TcxGridDBColumn;
    grdBrowseSearchDBBreed: TcxGridDBColumn;
    grdBrowseSearchDBStatus: TcxGridDBColumn;
    grdBrowseSearchDBPessoa: TcxGridDBColumn;
    Label1: TLabel;
    csBreed: TSuperComboADO;
    btnBreedClear: TButton;
    procedure btnSpeciesClearClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure AplicarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edSKUEnter(Sender: TObject);
    procedure edSKUExit(Sender: TObject);
    procedure grdBrowseSearchDBDblClick(Sender: TObject);
    procedure btnBreedClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIDModel : Integer;
    FIDPet, FIDStatus : Integer;
    FCost, FSale : Currency;
    FSKU : String;
    procedure PrepareFilter;
  public
    function Start(AIDModel : Integer; var AIDPet, AIDStatus : Integer;
         var ACost, ASale : Currency; var ASKU : String) : Boolean;
  end;

implementation

uses uDM, uSQLFunctions;

{$R *.dfm}

{ TFrmPetSearch }

function TFrmPetSearch.Start(AIDModel : Integer; var AIDPet, AIDStatus : Integer;
  var ACost, ASale : Currency; var ASKU : String): Boolean;
begin

  FIDModel  := AIDModel;
  AIDPet    := -1;
  ACost     := 0;
  ASale     := 0;
  AIDStatus := 0;
  ASKU      := '';

  ShowModal;

  Result := (ModalResult = mrOK);

  if Result then
  begin
    AIDPet    := FIDPet;
    ACost     := FCost;
    ASale     := FSale;
    ASKU      := FSKU;
    AIDStatus := FIDStatus;
  end;

end;

procedure TFrmPetSearch.btnSpeciesClearClick(Sender: TObject);
begin
  inherited;
  scPetSpecies.LookUpValue := '';
  scPetSpecies.Text := '<' + btnSpeciesClear.Caption + '>';
end;

procedure TFrmPetSearch.btSearchClick(Sender: TObject);
var
  sWhere : String;
begin
  inherited;

  Screen.Cursor := crHourGlass;
  try
    sWhere := ' P.Desativado = 0 AND P.Hidden = 0 AND P.System = 0 ';

    if Trim(edSKU.Text) <> '' then
      sWhere := sWhere + ' AND P.SKU like ' + QuotedStr('%'+edSKU.Text+'%');

    if scPetSpecies.LookUpValue <> '' then
      sWhere := sWhere + ' AND P.IDSpecies = ' + scPetSpecies.LookUpValue;

    if csBreed.LookUpValue <> '' then
      sWhere := sWhere + ' AND P.IDBreed = ' + csBreed.LookUpValue;

    quPet.Close;  
    quPet.CommandText := ChangeWhereClause(quPet.CommandText, sWhere, True);
    quPet.Open;

  finally
    Screen.Cursor := crDefault;
    end;

end;

procedure TFrmPetSearch.AplicarClick(Sender: TObject);
begin
  inherited;

  if quPet.Active and (not quPet.IsEmpty) then
  begin
    FIDPet    := quPetIDPet.AsInteger;
    FCost     := quPetVendorCost.AsCurrency;
    FSKU      := quPetSKU.AsString;
    FIDStatus := quPetIDStatus.AsInteger;
    if quPetPromoPrice.AsCurrency <> 0 then
      FSale := quPetPromoPrice.AsCurrency
    else
      FSale := quPetSalePrice.AsCurrency;
  end;

end;

procedure TFrmPetSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quPet.Close;
end;

procedure TFrmPetSearch.edSKUEnter(Sender: TObject);
begin
  inherited;
  Aplicar.Default := False;
  btSearch.Default := True;
end;

procedure TFrmPetSearch.edSKUExit(Sender: TObject);
begin
  inherited;
  Aplicar.Default := True;
  btSearch.Default := False;
end;

procedure TFrmPetSearch.grdBrowseSearchDBDblClick(Sender: TObject);
begin
  inherited;
  Aplicar.Click;
end;

procedure TFrmPetSearch.PrepareFilter;
var
  FQuery : TADOQuery;
begin
  try
    FQuery := TADOQuery.Create(Self);
    FQuery.Connection := DM.ADODBConnect;
    FQuery.SQL.Add('SELECT TOP 1 P.IDBreed');
    FQuery.SQL.Add('FROM Pet P');
    FQuery.SQL.Add('WHERE P.IDModel = :IDModel');
    FQuery.Parameters.ParamByName('IDModel').Value := FIDModel;
    FQuery.Open;
    if not FQuery.IsEmpty then
    begin
      csBreed.LookUpValue := FQuery.FieldByName('IDBreed').AsString;
      btSearch.Click;
    end;
  finally
    FQuery.Close;
    FreeAndNil(FQuery);
  end;
end;

procedure TFrmPetSearch.btnBreedClearClick(Sender: TObject);
begin
  inherited;
  csBreed.LookUpValue := '';
  csBreed.Text := '<' + btnBreedClear.Caption + '>';
end;

procedure TFrmPetSearch.FormShow(Sender: TObject);
begin
  inherited;
  PrepareFilter;
end;

end.
