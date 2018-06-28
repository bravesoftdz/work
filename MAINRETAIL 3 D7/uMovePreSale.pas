unit uMovePreSale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, DBTables, DB, Grids, LblEffct, ExtCtrls, StdCtrls, Mask, Buttons,
  ADODB, SuperComboADO, siComp, siLangRT, DBGrids;

type
  TMovePreSale = class(TFrmParent)
    dsOrigem: TDataSource;
    quOrigem: TADOQuery;
    spMove: TADOStoredProc;
    EditCustomer: TEdit;
    quMarkAll: TADOQuery;
    scOrigem: TSuperComboADO;
    quDestino: TADOQuery;
    dsDestino: TDataSource;
    EditIDPreSale: TEdit;
    btMove: TBitBtn;
    btMoveAll: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    quDestinoMarked: TBooleanField;
    quDestinoModel: TStringField;
    quDestinoSalesPerson: TStringField;
    quDestinoMovDate: TDateTimeField;
    quDestinoDiscount: TFloatField;
    quDestinoTotal: TFloatField;
    quDestinoIDPreInventoryMov: TIntegerField;
    quDestinoDescription: TStringField;
    quDestinoDocumentID: TIntegerField;
    quOrigemMarked: TBooleanField;
    quOrigemModel: TStringField;
    quOrigemSalesPerson: TStringField;
    quOrigemMovDate: TDateTimeField;
    quOrigemDiscount: TFloatField;
    quOrigemTotal: TFloatField;
    quOrigemIDPreInventoryMov: TIntegerField;
    quOrigemDescription: TStringField;
    quOrigemDocumentID: TIntegerField;
    grdDestino: TDBGrid;
    grdOrigem: TDBGrid;
    quDestinoQty: TFloatField;
    quOrigemQty: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure scOrigemSelectItem(Sender: TObject);
    procedure btMoveClick(Sender: TObject);
    procedure btMoveAllClick(Sender: TObject);
    procedure dsDestinoDataChange(Sender: TObject; Field: TField);
    procedure dsOrigemDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    MyDocumentID: integer;

  public
    { Public declarations }
    procedure Start(DocumentID: integer ; Customer: String);
  end;

implementation

uses uDM, uDMGlobal;
{$R *.DFM}

procedure TMovePreSale.Start(DocumentID: integer ; Customer: String);
begin
     editCustomer.Text := Customer;
     EditIDPreSale.Text := IntToStr(DocumentID);
     MyDocumentID := DocumentID;
     lblSubMenu.Caption := 'Move items to Hold #' +IntToStr(DocumentID);
     scOrigem.SpcWhereClause := 'IDPreSale <>' + IntToStr(DocumentID);

     ShowModal;
end;

procedure TMovePreSale.FormShow(Sender: TObject);
begin
  inherited;
  with quDestino do
    begin
      if Active then Close;
      Parameters.ParamByName('DocumentID').Value := MyDocumentID;
      Open;
    end;

  with quOrigem do
    begin
      if Active then Close;
      Open;
    end;
end;

procedure TMovePreSale.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if scOrigem.LookUpValue <> '' then
    with quMarkAll do
      begin
        Parameters.ParamByName('DocumentID').Value := StrToInt(scOrigem.LookUpValue);
        Parameters.ParamByName('Value').Value := 0;
        ExecSQL;
      end;

  with quOrigem do
     if Active then Close;

  with quDestino do
     if Active then Close;

  Action := caFree;
end;

procedure TMovePreSale.btCloseClick(Sender: TObject);
begin
  inherited;
    Close;
end;

procedure TMovePreSale.scOrigemSelectItem(Sender: TObject);
begin
  inherited;
  with quOrigem do
    begin
      Close;
      Parameters.ParamByName('DocumentID').Value := StrToInt(scOrigem.LookUpValue);
      Open;
    end;
end;

procedure TMovePreSale.btMoveClick(Sender: TObject);
begin
  inherited;
  with spMove do
    begin
      Parameters.ParamByName('@IDPreSaleOrigem').Value  := StrToInt(scOrigem.LookUpValue);
      Parameters.ParamByName('@IDPreSaleDestino').Value := MyDocumentID;
      ExecProc;
    end;
  FormShow(nil);
end;

procedure TMovePreSale.btMoveAllClick(Sender: TObject);
begin
  inherited;
  with quMarkAll do
    begin
      Parameters.ParamByName('DocumentID').Value := StrToInt(scOrigem.LookUpValue);
      Parameters.ParamByName('Value').Value := 1;
      ExecSQL;
    end;

  with spMove do
    begin
      Parameters.ParamByName('@IDPreSaleOrigem').Value := StrToInt(scOrigem.LookUpValue);
      Parameters.ParamByName('@IDPreSaleDestino').Value := MyDocumentID;
      ExecProc;
    end;
  FormShow(nil);
end;

procedure TMovePreSale.dsDestinoDataChange(Sender: TObject; Field: TField);
var
   NoEmpty: Boolean;

begin
  inherited;
  with quDestino do
    NoEmpty := not (EOF and BOF);

  if NoEmpty then
     grdDestino.Color := clWhite
  else
     grdDestino.Color := clSilver;

  grdDestino.Enabled := NoEmpty;

end;

procedure TMovePreSale.dsOrigemDataChange(Sender: TObject; Field: TField);
var
   NoEmpty: Boolean;
begin
  inherited;
  with quOrigem do
    NoEmpty := not (EOF and BOF);

  if NoEmpty then
     grdOrigem.Color := clWhite
  else
     grdOrigem.Color := clSilver;

  btMove.Enabled := NoEmpty;
  btMoveAll.Enabled := NoEmpty;

  grdOrigem.Enabled := NoEmpty;

end;

end.
