unit uFrmNewPOTransferConsult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, siComp, siLangRT, StdCtrls,
  LblEffct, ExtCtrls, ADODB;

const
  SCREEN_CONSULT = 0;
  SCREEN_POST    = 1;

type
  TFrmNewPOTransferConsult = class(TFrmParent)
    cxTransferMaster: TcxGrid;
    cxTransferMasterDBTableView1: TcxGridDBTableView;
    cxTransferMasterLevel1: TcxGridLevel;
    cxTransferDetailcxGridDBTableView1: TcxGridDBTableView;
    cxTransferDetailcxGridLevel1: TcxGridLevel;
    dsTransferDetail: TDataSource;
    dsTransferMaster: TDataSource;
    cdsTransferMaster: TClientDataSet;
    cdsTransferMasterIDLojaOrigem: TIntegerField;
    cdsTransferMasterIDLojaDestino: TIntegerField;
    cdsTransferMasterData: TDateTimeField;
    cdsTransferMasterIDUser: TIntegerField;
    cdsTransferMasterIDModel: TIntegerField;
    cdsTransferMasterCostPrice: TCurrencyField;
    cdsTransferMasterTax: TCurrencyField;
    cdsTransferMasterQty: TFloatField;
    cdsTransferMasterDescription: TStringField;
    cdsTransferMasterNumber: TStringField;
    cdsTransferMasterLojaOrigem: TStringField;
    cdsTransferMasterLojaDestino: TStringField;
    cdsTransferMasterModel: TStringField;
    cdsTransferMasterSystemUser: TStringField;
    cxTransferMasterDBTableView1Number: TcxGridDBColumn;
    cxTransferMasterDBTableView1LojaOrigem: TcxGridDBColumn;
    cxTransferMasterDBTableView1LojaDestino: TcxGridDBColumn;
    cdsTransferDetail: TClientDataSet;
    cxTransferDetailcxGridDBTableView1Qty: TcxGridDBColumn;
    cxTransferDetailcxGridDBTableView1Description: TcxGridDBColumn;
    cxTransferDetailcxGridDBTableView1Model: TcxGridDBColumn;
    cxTransferDetail: TcxGrid;
    btSave: TButton;
    qryModelDescription: TADOQuery;
    qryModelDescriptionDescription: TStringField;
    qryInsertTransf: TADOQuery;
    qryInsertTransfDet: TADOQuery;
    stpInvTransfOut: TADOStoredProc;
    chkPrint: TCheckBox;
    procedure btCloseClick(Sender: TObject);
    procedure dsTransferMasterDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
  private
    sClose,
    sSave,
    sExec,
    sCancel : String;

    FStartType : Integer;
    function VerifiesExists(IDLojaOrigem,IDLojaDestino : Integer): Boolean;
    procedure SetNumbersCDSDetail;
    procedure SetDescriptionCDSDetail;
    procedure CloseDataSets;
    function getDescription(IDModel: Integer): String;
    procedure RefreshCaption;
    function InsertModelTransf: Boolean;
    function FilterCDSTransfer(cds: TClientDataSet): TClientDataSet;
  public
    function Start(cdsTransfer: TClientDataSet; iStartType : Integer): OleVariant;
  end;

implementation

uses uDM, uDMGlobal, uMsgBox, uFrmPrintTranfer;

{$R *.dfm}

{ TFrmNewPOTransferConsult }

function TFrmNewPOTransferConsult.Start(cdsTransfer: TClientDataSet;
   iStartType : Integer): OleVariant;
var
  i : Integer;
begin

  if cdsTransfer.RecordCount <> 0 then
    begin
      cdsTransferDetail.CloneCursor(cdsTransfer, False);
      cdsTransferDetail.Filtered := False;

      SetDescriptionCDSDetail;

      cdsTransferMaster.DisableControls;
      try
        cdsTransferMaster.CreateDataSet;

        i := 1;
        cdsTransfer.First;
        while not cdsTransfer.Eof do
        begin
          if not VerifiesExists(cdsTransfer.FieldByName('IDLojaOrigem').AsInteger,
                                cdsTransfer.FieldByName('IDLojaDestino').AsInteger) then
          begin
            cdsTransferMaster.Append;
            cdsTransferMasterIDModel.Value       := cdsTransfer.FieldByName('IDModel').AsInteger;
            cdsTransferMasterModel.Value         := cdsTransfer.FieldByName('Model').AsString;
            cdsTransferMasterIDLojaOrigem.Value  := cdsTransfer.FieldByName('IDLojaOrigem').AsInteger;
            cdsTransferMasterIDLojaDestino.Value := cdsTransfer.FieldByName('IDLojaDestino').AsInteger;
            cdsTransferMasterData.Value          := cdsTransfer.FieldByName('Data').AsDateTime;
            cdsTransferMasterDescription.Value   := getDescription(cdsTransfer.FieldByName('IDModel').AsInteger);
            cdsTransferMasterIDUser.Value        := cdsTransfer.FieldByName('IDUser').AsInteger;
            cdsTransferMasterQty.Value           := cdsTransfer.FieldByName('Qty').AsFloat;

            if cdsTransfer.FieldByName('Number').AsString <> '' then
              cdsTransferMasterNumber.Value        := cdsTransfer.FieldByName('Number').AsString
            else
              cdsTransferMasterNumber.Value        := IntToStr(i) + FormatDateTime('mmddyyyyyhhmmss',cdsTransfer.FieldByName('Data').AsDateTime);

            cdsTransferMasterLojaOrigem.Value    := cdsTransfer.FieldByName('LojaOrigem').AsString;
            cdsTransferMasterLojaDestino.Value   := cdsTransfer.FieldByName('LojaDestino').AsString;
            cdsTransferMaster.Post;
          end;
            inc(i);
            cdsTransfer.Next;
        end;
      finally
        cdsTransferMaster.EnableControls;
      end;

      FStartType := iStartType;
      RefreshCaption;

      ShowModal;

      if ModalResult = mrOK then
        begin
          SetNumbersCDSDetail;
          Result := cdsTransferDetail.Data;
          if FStartType = SCREEN_POST then
             InsertModelTransf;
        end
      else
        begin
          Result := cdsTransfer.Data;
        end;

      CloseDataSets;
    end
  else
    begin
      ShowModal;
      Result := cdsTransfer.Data;
    end;
end;

procedure TFrmNewPOTransferConsult.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmNewPOTransferConsult.dsTransferMasterDataChange(
  Sender: TObject; Field: TField);
begin
  cdsTransferDetail.DisableControls;
  try
    cdsTransferDetail.Filtered := False;
    cdsTransferDetail.Filter   := Format('IDLojaOrigem = %D AND IDLojaDestino = %D',
                              [
                                cdsTransferMaster.FieldByName('IDLojaOrigem').AsInteger,
                                cdsTransferMaster.FieldByName('IDLojaDestino').AsInteger
                              ]);
    cdsTransferDetail.Filtered := True;
  finally
    cdsTransferDetail.EnableControls;
  end;
end;

function TFrmNewPOTransferConsult.VerifiesExists(IDLojaOrigem,
  IDLojaDestino: Integer): Boolean;
begin
  Result := cdsTransferMaster.Locate('IDLojaOrigem;IDLojaDestino', VarArrayOf([IDLojaOrigem,IDLojaDestino]), []);
end;

procedure TFrmNewPOTransferConsult.SetNumbersCDSDetail;
begin
  cdsTransferMaster.First;
  while not cdsTransferMaster.Eof do
  begin
    cdsTransferDetail.First;
    while not cdsTransferDetail.Eof do
    begin
      if (cdsTransferMaster.FieldByName('IDLojaOrigem').AsInteger = cdsTransferDetail.FieldByName('IDLojaOrigem').AsInteger) and
         (cdsTransferMaster.FieldByName('IDLojaDestino').AsInteger = cdsTransferDetail.FieldByName('IDLojaDestino').AsInteger) then
        begin
        cdsTransferDetail.Edit;

        if cdsTransferMaster.FieldByName('Number').AsString <> '' then
          cdsTransferDetail.FieldByName('Number').AsString := cdsTransferMaster.FieldByName('Number').AsString
        else
          cdsTransferDetail.FieldByName('Number').AsString := cdsTransferMaster.FieldByName('Data').AsString;

        cdsTransferDetail.Post;
        end;
      cdsTransferDetail.Next;
    end;
    cdsTransferMaster.Next;
  end;
end;

procedure TFrmNewPOTransferConsult.CloseDataSets;
begin
  cdsTransferMaster.Close;
  cdsTransferDetail.Close;
end;

function TFrmNewPOTransferConsult.getDescription(IDModel: Integer): String;
begin
  with qryModelDescription do
  begin
   try
     if Active then
       Close;
     Parameters.ParamByName('IDModel').Value := IDModel;
     Open;

     Result := FieldByName('Description').AsString;
   finally
     Close;
   end;  
  end;

end;

procedure TFrmNewPOTransferConsult.SetDescriptionCDSDetail;
begin
  cdsTransferDetail.First;
  while not cdsTransferDetail.Eof do
  begin
    cdsTransferDetail.Edit;
    cdsTransferDetail.FieldByName('Description').AsString := getDescription(cdsTransferDetail.FieldByName('IDModel').AsInteger);
    cdsTransferDetail.Post;
    cdsTransferDetail.Next;
  end;

end;

procedure TFrmNewPOTransferConsult.RefreshCaption;
begin

  case FStartType of
    SCREEN_CONSULT
          : begin
            btSave.Caption  := sSave;
            btClose.Caption := sClose;
            end;
    SCREEN_POST
          : begin
            btSave.Caption  := sExec;
            btClose.Caption := sCancel;
            end;
  end;

end;

procedure TFrmNewPOTransferConsult.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sClose  := '&Close';
           sSave   := '&Save';
           sExec   := 'Tran&sfer';
           sCancel := '&Cancel';
           end;

     LANG_PORTUGUESE :
           begin
           sClose  := 'Fe&char';
           sSave   := '&Salvar';
           sExec   := 'Tran&sferir';
           sCancel := '&Cancelar';
           end;

     LANG_SPANISH :
           begin
           sClose  := '&Cerrar';
           sSave   := '&Salvar';
           sExec   := 'Tran&sferir';
           sCancel := '&Cancele';
           end;
   end;

end;


function TFrmNewPOTransferConsult.InsertModelTransf: Boolean;
var
   iID,
   iIDDet : Integer;
   cdsTransferMaster: TClientDataset;
   cdsTransfer: TClientDataSet;
   sIDTransfers : String;
begin
  Result := True;
  cdsTransfer := TClientDataSet.Create(Self);
  cdsTransfer.Data := cdsTransferDetail.Data;
  DM.ADODBConnect.BeginTrans;
  try


    cdsTransfer.Filtered := False;
    cdsTransferMaster := FilterCDSTransfer(cdsTransfer);
    try
      while not cdsTransferMaster.Eof do
      begin
        iID := DM.GetNextID('ModelTransf.IDModelTransf');

        with qryInsertTransf do
        begin
          Parameters.ParamByName('IDModelTransf').Value := iID;
          Parameters.ParamByName('IDLojaOrigem').Value  := cdsTransferMaster.FieldByName('IDLojaOrigem').Value;
          Parameters.ParamByName('IDLojaDestino').Value := cdsTransferMaster.FieldByName('IDLojaDestino').Value;
          Parameters.ParamByName('IDUser').Value        := cdsTransferMaster.FieldByName('IDUser').Value;
          Parameters.ParamByName('Data').Value          := cdsTransferMaster.FieldByName('Data').Value;
          Parameters.ParamByName('Number').Value        := cdsTransferMaster.FieldByName('Number').Value;
          Parameters.ParamByName('TransferType').Value  := False;
          Parameters.ParamByName('Imported').Value      := 0;
          ExecSQL;


          //
          cdsTransfer.Filtered := False;
          cdsTransfer.Filter   := Format('IDLojaOrigem = %D AND IDLojaDestino = %D',
                                  [
                                    cdsTransferMaster.FieldByName('IDLojaOrigem').AsInteger,
                                    cdsTransferMaster.FieldByName('IDLojaDestino').AsInteger
                                  ]);
          cdsTransfer.Filtered := True;
          //

          while not cdsTransfer.Eof do
          begin
            iIDDet := DM.GetNextID('ModelTransfDet.IDModelTransfDet');

            with qryInsertTransfDet do
            begin
              Parameters.ParamByName('IDModelTransfDet').Value := iIDDet;
              Parameters.ParamByName('IDModelTransf').Value    := iID;
              Parameters.ParamByName('IDModel').Value          := cdsTransfer.FieldByName('IDModel').Value;
              Parameters.ParamByName('CostPrice').Value        := cdsTransfer.FieldByName('CostPrice').Value;
              Parameters.ParamByName('Tax').Value              := cdsTransfer.FieldByName('Tax').Value;
              Parameters.ParamByName('Qty').Value              := cdsTransfer.FieldByName('Qty').Value;
              ExecSQL;
            end;
            cdsTransfer.Next;
          end;
        end;

        stpInvTransfOut.Parameters.ParamByName('@IDModelTransf').Value := iID;
        stpInvTransfOut.ExecProc;

        cdsTransferMaster.Next;

        sIDTransfers := sIDTransfers + IntToStr(iID);
        if not cdsTransferMaster.Eof then
           sIDTransfers := sIDTransfers + ', ';
      end;
    finally
      cdsTransferMaster.Free;
    end;
    cdsTransfer.Filtered := False;
    cdsTransfer.EmptyDataSet;
    DM.ADODBConnect.CommitTrans;

   if chkPrint.Checked then
     with TFrmPrintTransfer.Create(Self) do
       Start(sIDTransfers);

  except
    on E: Exception do
    begin
      Result := False;
      DM.ADODBConnect.RollbackTrans;
      MsgBox(E.Message, vbOKOnly + vbCritical);
    end
  end;
end;

function TFrmNewPOTransferConsult.FilterCDSTransfer(cds: TClientDataSet): TClientDataSet;
begin
  Result := TClientDataSet.Create(self);

  Result.Data := cds.Data;
  Result.EmptyDataSet;

  cds.First;
  while not cds.Eof do
  begin
    if not Result.Locate('IDLojaOrigem;IDLojaDestino', VarArrayOf([cds.FieldByName('IDLojaOrigem').Value,
                                                               cds.FieldByName('IDLojaDestino').Value]), []) then
    begin
      Result.Append;
      Result.FieldByName('IDLojaOrigem').Value  := cds.FieldByName('IDLojaOrigem').Value;
      Result.FieldByName('IDLojaDestino').Value := cds.FieldByName('IDLojaDestino').Value;
      Result.FieldByName('IDUser').Value        := cds.FieldByName('IDUser').Value;
      Result.FieldByName('Data').Value          := cds.FieldByName('Data').Value;
      Result.FieldByName('Number').Value        := cds.FieldByName('Number').Value;
      Result.Post;
    end;
    cds.Next;
  end;
  cds.First;
  Result.First;
end;

end.
