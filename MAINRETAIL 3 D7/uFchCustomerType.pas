unit uFchCustomerType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, Provider;

type
  TFchCustomerType = class(TbrwFrmParent)
    quDiscount: TADODataSet;
    dtsDiscount: TDataSource;
    quDiscountIDTipoPessoa: TIntegerField;
    quDiscountIDGroup: TIntegerField;
    quDiscountDiscount: TFloatField;
    quDiscountCategory: TStringField;
    pnlDiscount: TPanel;
    pnlDiscountTitle: TPanel;
    grdDiscount: TcxGrid;
    grdDiscountDB: TcxGridDBTableView;
    grdDiscountDBIDTipoPessoa: TcxGridDBColumn;
    grdDiscountDBIDGroup: TcxGridDBColumn;
    grdDiscountDBCategory: TcxGridDBColumn;
    grdDiscountDBDiscount: TcxGridDBColumn;
    grdDiscountLevel: TcxGridLevel;
    lblCustomerType: TLabel;
    edtCustomerType: TDBEdit;
    lblCustomerTypeRequired: TLabel;
    quFormIDTipoCliente: TIntegerField;
    quFormTipoCliente: TStringField;
    quFormPath: TStringField;
    quFormPathName: TStringField;
    dspDiscount: TDataSetProvider;
    cdsDiscount: TClientDataSet;
    cmdInsDiscount: TADOCommand;
    cmdUpdDiscount: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure dspDiscountGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure grdDiscountEnter(Sender: TObject);
    procedure grdDiscountExit(Sender: TObject);
    procedure grdDiscountDBKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure DiscountOpen;
    procedure DiscountClose;
    procedure DiscountSave;

    procedure InsertDiscount;
    procedure UpdateDiscount;
  end;

implementation

uses uDM;

{$R *.dfm}

{ TFchCustomerType }

procedure TFchCustomerType.DiscountClose;
begin
  with cdsDiscount do
  begin
    if Active then
      Close;
  end;
end;

procedure TFchCustomerType.DiscountOpen;
begin
  with cdsDiscount do
    if not Active then
    begin
      FetchParams;
      Params.ParamByName('IDTipoPessoa').Value :=
        quForm.FieldByName('IDTipoCliente').AsInteger;
      Open;
    end
end;

procedure TFchCustomerType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if ModalResult = mrOk then
    DiscountSave;
  DiscountClose;
end;

procedure TFchCustomerType.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DiscountOpen;
end;

procedure TFchCustomerType.dspDiscountGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  inherited;
  TableName := 'Ent_CustomerDiscount';
end;

procedure TFchCustomerType.DiscountSave;
begin
  dtsDiscount.DataSet := nil;

  with cdsDiscount do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('IDTipoPessoa').IsNull) and (FieldByName('Discount').AsFloat > 0) then
        InsertDiscount
      else if FieldByName('Discount').OldValue <> FieldByName('Discount').Value then
        UpdateDiscount;
      Next;
    end;
  end;

  dtsDiscount.DataSet := cdsDiscount;  
end;

procedure TFchCustomerType.InsertDiscount;
begin
  with cmdInsDiscount do
  begin
    Parameters.ParamByName('IDTipoPessoa').Value := quForm.FieldByName('IDTipoCliente').AsInteger;
    Parameters.ParamByName('IDGroup').Value := cdsDiscount.FieldByName('IDGroup').AsInteger;
    Parameters.ParamByName('Discount').Value := cdsDiscount.FieldByName('Discount').AsFloat;
    Execute;
  end;
end;

procedure TFchCustomerType.UpdateDiscount;
begin
  with cmdUpdDiscount do
  begin
    Parameters.ParamByName('IDTipoPessoa').Value := cdsDiscount.FieldByName('IDTipoPessoa').AsInteger;
    Parameters.ParamByName('IDGroup').Value := cdsDiscount.FieldByName('IDGroup').AsInteger;
    Parameters.ParamByName('Discount').Value := cdsDiscount.FieldByName('Discount').AsFloat;
    Execute;
  end;
end;

procedure TFchCustomerType.grdDiscountEnter(Sender: TObject);
begin
  inherited;
  btClose.Default := False;
end;

procedure TFchCustomerType.grdDiscountExit(Sender: TObject);
begin
  inherited;
  btClose.Default := True;
end;

procedure TFchCustomerType.grdDiscountDBKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_Return) and (grdDiscountDBDiscount.Focused) then
  with cdsDiscount do
  begin
  Next;
  if not Eof then
     FieldByName('Discount').FocusControl;
  end;

end;

end.
