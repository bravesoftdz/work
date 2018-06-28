unit uFrmTransferImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, ADODB,
  PowerADOQuery;

type
  TFrmTransferImport = class(TFrmParent)
    quTransfer: TPowerADOQuery;
    quTransferIDModel: TIntegerField;
    quTransferModel: TStringField;
    quTransferDescription: TStringField;
    quTransferIDModelTransfDet: TIntegerField;
    quTransferIDModelTransf: TIntegerField;
    quTransferCostPrice: TBCDField;
    grdTransfer: TcxGrid;
    grdTransferDB: TcxGridDBTableView;
    grdTransferLevel: TcxGridLevel;
    dsTransfer: TDataSource;
    grdTransferDBIDModel: TcxGridDBColumn;
    grdTransferDBModel: TcxGridDBColumn;
    grdTransferDBDescription: TcxGridDBColumn;
    grdTransferDBIDModelTransfDet: TcxGridDBColumn;
    grdTransferDBIDModelTransf: TcxGridDBColumn;
    grdTransferDBQtyTransfer: TcxGridDBColumn;
    grdTransferDBCostPrice: TcxGridDBColumn;
    quTransferCostTotal: TCurrencyField;
    grdTransferDBCostTotal: TcxGridDBColumn;
    btnImport: TButton;
    quTransferQtyTransfer: TFloatField;
    cmdInsModelTransfDet: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quTransferCalcFields(DataSet: TDataSet);
    procedure btnImportClick(Sender: TObject);
    procedure quTransferAfterOpen(DataSet: TDataSet);
  private
    fResult, fHasLot : Boolean;
    fIDTransferOUT,
    fIDTransferIN: Integer;
    function ImportTransfer : Boolean;
  public
    function Start(TransferNumber: String; IDTransferIN: Integer):Boolean;
    function AutoStart(TransferNumber: String; IDTransferIN: Integer; var IDTransferOUT: Integer;
                       var bHasLot : Boolean ):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uMsgBox, uDMParent, uHandleError;

{$R *.dfm}

procedure TFrmTransferImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmTransferImport.Start(TransferNumber:String; IDTransferIN:Integer): Boolean;
begin

  fResult := False;

  with quTransfer do
  begin
    if Active then
      Close;
    Parameters.ParamByName('Number').Value := TransferNumber;
    Open;
    fIDTransferOUT := quTransferIDModelTransf.AsInteger;
    fIDTransferIN := IDTransferIN;
  end;

  ShowModal;
  Result := fResult;
end;

procedure TFrmTransferImport.quTransferCalcFields(DataSet: TDataSet);
begin
  inherited;
  quTransferCostTotal.AsCurrency := quTransferQtyTransfer.AsFloat *
                                    quTransferCostPrice.AsCurrency; 
end;

procedure TFrmTransferImport.btnImportClick(Sender: TObject);
begin
  inherited;
  if (not quTransfer.Active) or (quTransfer.RecordCount = 0) then
    Exit;

  fResult := ImportTransfer;
end;

procedure TFrmTransferImport.quTransferAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnImport.Enabled := not quTransfer.IsEmpty; 
end;

function TFrmTransferImport.AutoStart(TransferNumber: String;
  IDTransferIN: Integer; var IDTransferOUT: Integer; var bHasLot : Boolean): Boolean;
begin

  fResult := False;
  fHasLot := False;

  with quTransfer do
  try
    if Active then
       Close;
    Parameters.ParamByName('IDModelTransf').Value := IDTransferOUT;
    Open;
    fIDTransferOUT := quTransferIDModelTransf.AsInteger;
    fIDTransferIN := IDTransferIN;
    IDTransferOUT := fIDTransferOUT;
    btnImportClick(Self);
    Result := fResult;
    bHasLot := fHasLot;
  finally
    Close;
    end;
  Self.Close;
end;

function TFrmTransferImport.ImportTransfer : Boolean;
var
  iIDModelTransfDet: Integer;
begin

  try

    with DM.quFreeSQL do
    begin
      if Active then
        Close;

      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('  MTD.IDModel,');
      SQL.Add('  MTD.Qty,');
      SQL.Add('  MTD.Tax,');
      SQL.Add('  MTD.CostPrice,');
      SQL.Add('  MTD.AvgCost,');
      SQL.Add('  MTD.IDLote,');
      SQL.Add('  MT.IDLojaOrigem,');
      SQL.Add('  MT.IDLojaDestino');
      SQL.Add('FROM');
      SQL.Add('  ModelTransfDet MTD (NOLOCK)');
      SQL.Add('  JOIN ModelTransf MT (NOLOCK) ON (MTD.IDModelTransf = MT.IDModelTransf)');
      SQL.Add('WHERE');
      SQL.Add('  MTD.IDModelTransf = :IDTransfOUT');
      Parameters.ParamByName('IDTransfOUT').Value := fIDTransferOUT;
      Open;

      try

        while not Eof do
        begin
          iIDModelTransfDet := DM.GetNextID('ModelTransfDet.IDModelTransfDet');

          cmdInsModelTransfDet.Parameters.ParamByName('IDModelTransfDet').Value := iIDModelTransfDet;
          cmdInsModelTransfDet.Parameters.ParamByName('IDTransfIN').Value := fIDTransferIN;
          cmdInsModelTransfDet.Parameters.ParamByName('ModelID').Value := FieldByName('IDModel').Value;
          cmdInsModelTransfDet.Parameters.ParamByName('Qty').Value := FieldByName('Qty').Value;
          cmdInsModelTransfDet.Parameters.ParamByName('CostPrice').Value := FieldByName('CostPrice').Value;
          cmdInsModelTransfDet.Parameters.ParamByName('Tax').Value := FieldByName('Tax').Value;
          cmdInsModelTransfDet.Parameters.ParamByName('AvgCost').Value := FieldByName('AvgCost').Value;
          cmdInsModelTransfDet.Parameters.ParamByName('IDLote').Value := FieldByName('IDLote').Value;
          cmdInsModelTransfDet.Execute;


        if FieldByName('IDLote').AsInteger <> 0 then
        begin
          DM.FDMInventory.LotAdjust(FieldByName('IDModel').AsInteger,
                                    FieldByName('IDLojaDestino').AsInteger,
                                    FieldByName('IDLote').AsInteger,
                                    FieldByName('Qty').AsFloat,
                                    2);
          fHasLot := True;
        end;

          Next;
        end;

      finally
        Close;
      end;

      Result := True;
    end;
  except
    on E : Exception do
    begin
      Result := False;
      DM.SetError(CRITICAL_ERROR, Self.Name, 'TFrmTransferImport.ImportTransfer' + #13#10 + E.Message);
      MsgBox('Error: ' + E.Message, vbInformation + vbOkOnly);
    end;
  end;
end;

end.
