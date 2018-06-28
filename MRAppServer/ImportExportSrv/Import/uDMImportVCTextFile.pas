unit uDMImportVCTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMImportTextFile, DB, ADODB, DBTables, uDMCalcPrice;

type
  TDMImportVCTextFile = class(TDMImportTextFile)
    spPurchaseDo: TADOStoredProc;
    qryInsPurchase: TADOQuery;
    qryGetIDPreInventoryMov: TADOQuery;
    qryInsPurchaseItem: TADOQuery;
    qryInsModel: TADOQuery;
  private
    IsClientServer: Boolean;
    FDMCalcPrice: TDMCalcPrice;
    FIDVendor: Integer;
    FIDPurchase: Integer;
    FVendorCode: String;

    function GetIDVendor(Vendor :String): Integer;
    function GetNewIDVendor(Vendor :String): Integer;
    function GetTpPesLastCode: Integer;

    procedure SetQueryConnections;

    procedure BeforeImport; override;
    procedure AfterImport; override;

    procedure ImportLine; override;

    procedure DeleteModelInformation( IDModel, IDVendor: Integer );
    procedure InsertModelInformation( IDModel, IDVendor: Integer; Description, VendorCode: String;
                                      CaseQty, Cost: Currency; MinQtyPO : Double );
    procedure UpdateModelInformation( IDModel, IDVendor: Integer; Description, VendorCode: String;
                                      CaseQty, Cost: Currency; MinQtyPO : Double );

  end;

implementation

uses uNumericFunctions, uDMGlobal, uSystemConst, uContentClasses, udebugFunctions, uObjectServices;

{$R *.dfm}

{ TDMImportVCFile }

procedure TDMImportVCTextFile.ImportLine;
var
  iIdModel : Integer;
  sDescription : String;

begin

  If ( TextFile.FieldByName('Update').AsInteger = 0 ) Then Exit;

  inherited;

  Try

    { Remove }
    If ( TextFile.FieldByName('ChangeType').Asstring = 'R' ) Then Begin

      Self.DeleteModelInformation( TextFile.FieldByName('IdModel').AsInteger,
                                   FIDVendor );

    { Update }
    End Else If ( TextFile.FieldByName('ChangeType').Asstring = 'U' ) Then Begin

      Try

        Self.UpdateModelInformation( TextFile.FieldByName('IdModel').AsInteger,
                                     FIDVendor,
                                     TextFile.FieldByName('Description').AsString,
                                     TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString,
                                     TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsFloat,
                                     TextFile.FieldByName(LinkedColumns.Values['Cost']).AsFloat,
                                     TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsFloat );
      Except
        On E:Exception Do Begin

          Raise;

        End;

      End;

    { New }
    End Else If ( TextFile.FieldByName('ChangeType').Asstring = 'N' ) Then Begin

      Try

        Self.InsertModelInformation( TextFile.FieldByName('IdModel').AsInteger,
                                     FIDVendor,
                                     TextFile.FieldByName('Description').AsString,
                                     TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString,
                                     TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsFloat,
                                     TextFile.FieldByName(LinkedColumns.Values['Cost']).AsFloat,
                                     TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsFloat );
      Except
        On E:Exception Do Begin

          Raise;

        End;

      End;

    End;

  Finally

  End;

end;


procedure TDMImportVCTextFile.InsertModelInformation( IDModel, IDVendor: Integer; Description, VendorCode: String;
                                                      CaseQty, Cost: Currency; MinQtyPO : Double );
Var
  sSQL : String;
  iIdVendorModelCode, VendorOrder : Integer;
begin

  try

    If ( DMGlobal.qryFreeSQL.Active ) Then DMGlobal.qryFreeSQL.Close;

    VendorOrder := 1;

    { Testar se registro já existe antes de inserir, caso exista então atualizar }
    sSQL := 'SELECT 1 FROM INV_MODELVENDOR ' +
            'WHERE IDPESSOA = ' + IntToStr( IDVendor ) +
            '  AND IDMODEL  = ' + IntToStr( IDModel );

    DMGlobal.qryFreeSQL.SQL.Text := sSQL;
    DMGlobal.qryFreeSQL.Open;

    If ( DMGlobal.qryFreeSQL.IsEmpty ) Then Begin

      sSQL := 'INSERT INTO INV_MODELVENDOR ( IDPESSOA, IDMODEL,  VENDORORDER,  '+
                                            'MINQTYPO, CASEQTY,  '+
                                            'VENDORCOST, COSTLASTCHANGE )'+
              'VALUES ( ' + IntToStr( IDVendor )  + ', ' + IntToStr( IDModel )  + ', ' + IntToStr( VendorOrder ) + ', ' +
                            CurrToStr( MinQtyPO ) + ', ' + CurrToStr( CaseQty ) + ', ' +
                            CurrToStr( Cost )     + ', GETDATE() ) ';

      DMGlobal.ExecuteSQL( sSQL, SQLConnection );


      iIdVendorModelCode := DMGlobal.GetNextCode('VENDORMODELCODE', 'IDVENDORMODELCODE', SQLConnection );

      sSQL := 'INSERT INTO VENDORMODELCODE ( IDVENDORMODELCODE, IDPESSOA, IDMODEL, VENDORCODE )'+
              'VALUES ( ' + IntToStr( iIdVendorModelCode )  + ', ' + IntToStr( IDVendor )  + ', ' +
                            IntToStr( IDModel )             + ', ' + QuotedStr( VendorCode ) + ' ) ';

      DMGlobal.ExecuteSQL( sSQL, SQLConnection );

    End Else Begin

      Self.UpdateModelInformation( IDModel,
                                   IDVendor,
                                   TextFile.FieldByName('Description').AsString,
                                   TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString,
                                   TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsFloat,
                                   TextFile.FieldByName(LinkedColumns.Values['Cost']).AsFloat,
                                   TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsFloat );

    End;


  finally

     DMGlobal.qryFreeSQL.Close();

  end;

end;

procedure TDMImportVCTextFile.DeleteModelInformation( IDModel, IDVendor : Integer );
Var
  sSQL : String;
begin

  try

    If ( DMGlobal.qryFreeSQL.Active ) Then DMGlobal.qryFreeSQL.Close;

    sSQL := 'DELETE FROM INV_MODELVENDOR '+
            'WHERE IDPESSOA = ' + IntToStr( IDVendor ) +
            '  AND IDMODEL  = ' + IntToStr( IDModel );

    DMGlobal.ExecuteSQL( sSQL, SQLConnection );

    sSQL := 'DELETE FROM VENDORMODELCODE '+
            'WHERE IDPESSOA = ' + IntToStr( IDVendor ) +
            '  AND IDMODEL  = ' + IntToStr( IDModel );

    DMGlobal.ExecuteSQL( sSQL, SQLConnection );

  finally

     DMGlobal.qryFreeSQL.Close();

  end;

end;

procedure TDMImportVCTextFile.UpdateModelInformation(IDModel, IDVendor: Integer; Description, VendorCode: String;
                                                     CaseQty, Cost: Currency; MinQtyPO : Double);
Var
  sSQL : String;
  iIdVendorModelCode, VendorOrder : Integer;
begin

  try

    If ( DMGlobal.qryFreeSQL.Active ) Then DMGlobal.qryFreeSQL.Close;

    VendorOrder := 1;

    { Testar se registro já existe antes de atualizar, caso não exista então inserir }
    sSQL := 'SELECT 1 FROM INV_MODELVENDOR ' +
            'WHERE IDPESSOA = ' + IntToStr( IDVendor ) +
            '  AND IDMODEL  = ' + IntToStr( IDModel );

    DMGlobal.qryFreeSQL.SQL.Text := sSQL;
    DMGlobal.qryFreeSQL.Open;

    If ( DMGlobal.qryFreeSQL.IsEmpty ) Then Begin

      Self.InsertModelInformation( IDModel,
                                   IDVendor,
                                   TextFile.FieldByName('Description').AsString,
                                   TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString,
                                   TextFile.FieldByName(LinkedColumns.Values['CaseQty']).AsFloat,
                                   TextFile.FieldByName(LinkedColumns.Values['Cost']).AsFloat,
                                   TextFile.FieldByName(LinkedColumns.Values['MinQty']).AsFloat );

    End Else Begin

       sSQL := 'UPDATE INV_MODELVENDOR SET '+
               '  VENDORORDER = '   + IntToStr( VendorOrder ) + ', ' +
               '  MINQTYPO =  '     + CurrToStr( MinQtyPO )   + ', ' +
               '  CASEQTY  = '      + CurrToStr( CaseQty )    + ', ' +
               '  VENDORCOST = '    + CurrToStr( Cost )       + ', ' +
               '  COSTLASTCHANGE = GETDATE() '+
               'WHERE '+
               '      IDPESSOA = ' + IntToStr( IDVendor )  +
               '  AND IDMODEL  = ' + IntToStr( IDModel );

      DMGlobal.ExecuteSQL( sSQL, SQLConnection );

      sSQL := 'UPDATE VENDORMODELCODE SET ' +
              '  VENDORCODE = '+ QuotedStr( VendorCode ) + ' ' +
              'WHERE ' +
               '      IDPESSOA = ' + IntToStr( IDVendor )  +
               '  AND IDMODEL  = ' + IntToStr( IDModel )   +
               '  AND VENDORCODE <> ' + QuotedStr( VendorCode );

      DMGlobal.ExecuteSQL( sSQL, SQLConnection );

    End;

  finally

     DMGlobal.qryFreeSQL.Close();

  end;


end;


function TDMImportVCTextFile.GetIDVendor(Vendor: String): Integer;
begin
  with DMGlobal.qryFreeSQL do
  begin
    if Active then
      Close;

    SQL.Text := 'SELECT IDPessoa from Pessoa '+
                ' WHERE Pessoa = ' + QuotedStr(Vendor) + ' AND IDTipoPessoa = 2 ';
    Open;

     if IsEmpty then
       Result := GetNewIDVendor(Vendor)
     else
       Result := FieldByName('IDPessoa').AsInteger;
   end;
end;

function TDMImportVCTextFile.GetNewIDVendor(Vendor: String): Integer;
var
  IDPessoa, Code : Integer;
begin
  Result := -1;

  try
    IDPessoa := DMGlobal.GetNextCode('Pessoa', 'IDPessoa',SQLConnection);
    DMGlobal.RunSQL(' UPDATE TipoPessoa SET LastCode = IsNull(LastCode,0) + 1 ' +
           ' Where IDTipoPessoa = 2 ',SQLConnection);


    Code := GetTpPesLastCode;


    DMGlobal.RunSQL('INSERT INTO Pessoa (IDPessoa,IDTipoPessoa,IDStore,IDTipoPessoaRoot,IDUSer,Pessoa,Juridico,Code) VALUES ' +
           ' (' + InttoStr(IDPessoa) + ' , 2 , ' + ImpExpConfig.Values['Store'] + ' , 2 , ' + ImpExpConfig.Values['User'] +
           ' , ' + QuotedStr(Vendor) + ' , 1 , ' + InttoStr(Code) + ' ) ' , SQLConnection);

    Result := IDPessoa;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;
end;

function TDMImportVCTextFile.GetTpPesLastCode: Integer;
begin
  Try
   with DMGlobal.qryFreeSQL do
   begin
    if Active then
      Close;

    SQL.Text := ' SELECT LastCode from TipoPessoa WHERE IDTipoPessoa = 2 and Path = ''.002'' ';
    Open;

    Result := FieldByName('LastCode').AsInteger;
   end;
  finally
    DMGlobal.qryFreeSQL.Close;
  end;
end;

procedure TDMImportVCTextFile.SetQueryConnections;
begin
  inherited;
  DMGlobal.qryFreeSQL.Connection := SQLConnection;
  qryInsPurchase.Connection := SQLConnection;
  qryGetIDPreInventoryMov.Connection := SQLConnection;
  qryInsPurchaseItem.Connection := SQLConnection;
  spPurchaseDo.Connection := SQLConnection;
end;


procedure TDMImportVCTextFile.BeforeImport;
begin
  inherited;

  SetQueryConnections;

  FIDVendor      := GetIDVendor(ImpExpConfig.Values['Vendor']);
  IsClientServer := DMGlobal.IsClientServer(SQLConnection);

End;


procedure TDMImportVCTextFile.AfterImport;
begin
  inherited;
end;


end.
