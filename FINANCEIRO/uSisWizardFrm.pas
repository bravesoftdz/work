unit uSisWizardFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentModal, ExtCtrls, ComCtrls, StdCtrls, dxCntner, dxEditor, dxExEdtr,
  dxEdLib, CheckLst, Buttons, Mask, SuperComboADO, Grids, jpeg, ImgList,
  dxtree, Db, ADODB, PowerADOQuery, dxTL, dxDBCtrl, dxDBGrid, dxDBCGrid,
  dxDBTLCl, dxGrClms, uQuicken, uQuickBooks,uPeachTree, Menus, siComp,
  siLangRT, DateBox;

const
   SOFTWARE_QUICKEN    = 0;
   SOFTWARE_QUICKBOOKS = 1;
   SOFTWARE_PEACHTREE  = 2;
   SOFTWARE_MSMONEY    = 3;

   SINGLE_RECORD = 1;
   PARENT_RECORD = 2;
   DISBUR_RECORD = 3;
   TRANFER_RECORD = 4;

type
  TAdvStringGrid = class(TStringGrid)
  Public
    Procedure DeleteRow(ARow:LongInt); Override;
    Procedure DeleteColumn(AColumn:LongInt); Override;
  end;

type
  TSisWizardFrm = class(TParentModalFrm)
    Panel1: TPanel;
    Bevel1: TBevel;
    lblProgress: TLabel;
    btnBack: TButton;
    btnNext: TButton;
    btnClose: TButton;
    Notebook1: TNotebook;
    ImgIntro: TImage;
    Label28: TLabel;
    Label36: TLabel;
    Panel12: TPanel;
    pnlTopic2: TPanel;
    lblTopic2: TLabel;
    Shape5: TShape;
    pnlTopic3: TPanel;
    lblTopic3: TLabel;
    Shape6: TShape;
    pnlTopic4: TPanel;
    lblTopic4: TLabel;
    Shape2: TShape;
    ImgSummary: TImage;
    Label29: TLabel;
    Label37: TLabel;
    memSummary: TMemo;
    ProgressBar1: TProgressBar;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    ImgCateg: TImage;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel4: TPanel;
    imgTrans: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    scBankAcccount: TSuperComboADO;
    Label11: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    imgFile: TImage;
    Label12: TLabel;
    Label13: TLabel;
    pnlAccInfo: TPanel;
    Label14: TLabel;
    cbxTransType: TComboBox;
    Label15: TLabel;
    lbDirOption: TLabel;
    edtPath: TEdit;
    sbOpenFile: TSpeedButton;
    Label16: TLabel;
    SD: TSaveDialog;
    gridCategory: TStringGrid;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    ImgBank: TImage;
    Panel6: TPanel;
    Label8: TLabel;
    Shape1: TShape;
    sbRefreshList: TSpeedButton;
    Panel7: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    ImgSoftware: TImage;
    Label20: TLabel;
    treeSoftware: TdxTreeView;
    imgSmall: TImageList;
    lbSoftware: TLabel;
    btnHelp: TButton;
    dxDBCGrid1: TdxDBCGrid;
    quRecords: TPowerADOQuery;
    dsRecords: TDataSource;
    quPreRecords: TPowerADOQuery;
    quRecordsIDRecord: TIntegerField;
    quRecordsRecordDate: TDateTimeField;
    quRecordsAmount: TBCDField;
    quRecordsCategory: TStringField;
    quRecordsNumDoc: TStringField;
    quRecordsPayee: TStringField;
    quRecordsMemo: TStringField;
    quRecordsIDRecordParent: TIntegerField;
    dxDBCGrid1IDRecord: TdxDBGridMaskColumn;
    dxDBCGrid1RecordDate: TdxDBGridDateColumn;
    dxDBCGrid1Amount: TdxDBGridMaskColumn;
    dxDBCGrid1Category: TdxDBGridMaskColumn;
    dxDBCGrid1NumDoc: TdxDBGridMaskColumn;
    dxDBCGrid1Payee: TdxDBGridMaskColumn;
    dxDBCGrid1Memo: TdxDBGridMaskColumn;
    dxDBCGrid1IDRecordParent: TdxDBGridMaskColumn;
    quPreRecordsIDQuitacao: TAutoIncField;
    quPreRecordsAmount: TBCDField;
    quPreRecordsRecordDate: TDateTimeField;
    quPreRecordsDocMumber: TStringField;
    quPreRecordsPayee: TStringField;
    quPreRecordsMemo: TStringField;
    quPreRecordsPagando: TBooleanField;
    quPreRecordsIDTransferencia: TIntegerField;
    Panel8: TPanel;
    Label21: TLabel;
    Shape3: TShape;
    quInsertRecords: TADOCommand;
    dxDBCGrid1Disb: TdxDBGridImageColumn;
    quRecordsRecordType: TIntegerField;
    quPreRecordsMeioPag: TStringField;
    quPreRecordsTipo: TIntegerField;
    quRecordsPaymentType: TIntegerField;
    dxDBCGrid1PaidWith: TdxDBGridColumn;
    quRecordsPaidWith: TStringField;
    quPreRecordsContaCorrentDebit: TStringField;
    quPreRecordsContaCorrenteCredit: TStringField;
    quPreRecordsDataReconciliacao: TDateTimeField;
    quRecordsReconciled: TStringField;
    dxDBCGrid1Reconciled: TdxDBGridColumn;
    popTransaction: TPopupMenu;
    btDeleteLine: TMenuItem;
    lbLabel: TLabel;
    dateFrom: TDateBox;
    dateTo: TDateBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Notebook1PageChanged(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure sbOpenFileClick(Sender: TObject);
    procedure gridCategorySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure treeSoftwareClick(Sender: TObject);
    procedure sbRefreshListClick(Sender: TObject);
    procedure btDeleteLineClick(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sName,
    sDescrip,
    sIncExp,
    sCode,
    sHidden,
    sExportar,
    sFile,
    sSystemType,
    sType,
    sFinish,
    sNext,
    sQuicken,
    sQB,
    sPeachTree,
    sMoney : String;

    MyQuicken    : TQuicken;
    MyQuickBooks : TQuickBooks;
    MyPeachTree  : TPeachTree;

    sAccountInfo : String;
    iSoftware : Integer;

    procedure ImportCategory;
    procedure ClearCategory;

    procedure SetupSoftwareInfo;

    procedure BuildCategoryList;
    procedure BuildBankTransaction;
    procedure BuildTransaction;

    //Software Option
    function ValidatePage:Boolean;
    procedure StartPage;

    procedure NavigatePage(Sender:TObject);
    function GenerateFile:Boolean;
    function CreateData:Boolean;

    procedure CreateTempTable;
    procedure DeleteDropTempTable(IsDelete:Boolean);

    procedure OpenPreRecord;
    procedure FillRecords;
    function GetCategoryName(sIDCategory:String):String;
  public
    { Public declarations }
    procedure Start(sIDBankAcc:String; DateIni,DateEnd:TDate);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uNumericFunctions;

{$R *.DFM}

function TSisWizardFrm.CreateData:Boolean;
begin

  Try

     Result := True;

      case iSoftware of
         SOFTWARE_QUICKEN,
         SOFTWARE_MSMONEY    : MyQuicken    := TQuicken.Create;
         SOFTWARE_QUICKBOOKS : MyQuickBooks := TQuickBooks.Create;
         SOFTWARE_PEACHTREE  : MyPeachTree  := TPeachTree.Create;
      end;

     //Create the select options
     BuildBankTransaction;

     //Create the categories selected
     BuildCategoryList;

     //Create the bank transaction
     BuildTransaction;

  except
     Result := False;
  end;


end;

procedure TSisWizardFrm.SetupSoftwareInfo;
var
  i : integer;
begin

  cbxTransType.Items.Clear;

  case iSoftware of
       SOFTWARE_QUICKEN :
           begin
           for i := 0 to High(AQuickenBankTypeList) do
               cbxTransType.Items.Add(AQuickenBankTypeList[i]);
           SD.Filter := 'Quicken Interchange Format|*.QIF|All file|*.*';
           end;

       SOFTWARE_QUICKBOOKS :
           begin
           for i := 0 to High(AQuickBooksBankAccList) do
               cbxTransType.Items.Add(AQuickBooksBankAccList[i]);
           SD.Filter := 'QuickBooks Format|*.IIF|All file|*.*';
           end;

       SOFTWARE_PEACHTREE :
           begin
           cbxTransType.Items.Add('General Bank Account');
           SD.Filter := 'PeachTree Format|*.CSV|All file|*.*';
           end;

       SOFTWARE_MSMONEY :
           begin
           for i := 0 to High(AQuickenBankTypeList) do
               cbxTransType.Items.Add(AQuickenBankTypeList[i]);
           SD.Filter := 'Microsoft Money Format|*.QIF|All file|*.*';
           end;
  end;

end;

procedure TSisWizardFrm.BuildTransaction;
var
  iTrans : Integer;
  sTransType : String;
  sCategory  : String;
  sCleared   : String;

  procedure BuildChildren(sIDRecord:String);
  begin
    with DM.quFreeSQL do
        begin
        if Active then
           Close;

        SQL.Clear;

        SQL.Add('SELECT Amount, Category, RecordDate, NumDoc, Payee, Memo, Reconciled');
        SQL.Add('FROM #RecordsList');
        SQL.Add('WHERE IDRecordParent = ' + sIDRecord);
        Open;

        First;

        While not EOF do
            begin
               case iSoftware of
                    SOFTWARE_QUICKEN,
                    SOFTWARE_MSMONEY    :
                         MyQuicken.AddTransSplit(iTrans,
                                                 FieldByName('Category').AsString,
                                                 FormatFloat('#,##0.00', FieldByName('Amount').AsCurrency),
                                                 FieldByName('Memo').AsString);
                    SOFTWARE_QUICKBOOKS :
                         MyQuickBooks.AddTransSplit(iTrans,
                                                    sTransType,
                                                    FieldByName('Category').AsString,
                                                    FormatFloat('#,##0.00', (FieldByName('Amount').AsCurrency*-1)),
                                                    FormatDateTime('mm/dd/yyyy', FieldByName('RecordDate').AsDateTime),
                                                    FieldByName('NumDoc').AsString,
                                                    FieldByName('Payee').AsString,
                                                    FieldByName('Memo').AsString,
                                                    FieldByName('Reconciled').AsString[1]);

                    SOFTWARE_PEACHTREE : ;                                

               end;

            Next;
            end;

        Close;
        end;
  end;

begin

  Try
     quRecords.DisableControls;

     with quRecords do
         begin
         If not Active then
            Exit;

         First;

         //Loop para montar os records
         While not EOF do
            begin
            //Se for Simgle ou Parent only, se for disbursement vai ser gravado
            //na funcao BuildChildren
            If quRecordsRecordType.AsInteger <> DISBUR_RECORD then
               begin
               iTrans := 0;

               if quRecordsAmount.AsCurrency > 0 then
                  sTransType := DEPOSIT_TRANSACTION    //Deposit
               else
                  sTransType := CHECK_TRANSACTION;     //Credit

               if quRecordsRecordType.AsInteger = TRANFER_RECORD then
                  sTransType := TRANSFERENCE_TRANSACTION;  //Transaction


               case iSoftware of
                    SOFTWARE_QUICKEN,
                    SOFTWARE_MSMONEY    :
                       begin
                       if quRecordsReconciled.AsString = 'Y' then
                          sCleared := 'X'
                       else
                          sCleared := '';

                       iTrans := MyQuicken.AddTransaction (FormatDateTime('mm/dd/yyyy', quRecordsRecordDate.AsDateTime),
                                                           FormatFloat('#,##0.00', quRecordsAmount.AsCurrency),
                                                           quRecordsCategory.AsString,
                                                           quRecordsNumDoc.AsString,
                                                           quRecordsPayee.AsString,
                                                           quRecordsMemo.AsString,
                                                           sCleared);
                       end;

                    SOFTWARE_QUICKBOOKS :
                       begin
                       {Each transaction has one Debit and Credit account}
                       iTrans := MyQuickBooks.AddTransaction(sTransType,
                                                             scBankAcccount.Text,
                                                             FormatFloat('#,##0.00', quRecordsAmount.AsCurrency),
                                                             FormatDateTime('mm/dd/yyyy', quRecordsRecordDate.AsDateTime),
                                                             quRecordsNumDoc.AsString,
                                                             quRecordsPayee.AsString,
                                                             quRecordsMemo.AsString,
                                                             quRecordsReconciled.AsString[1]); //Reconciled


                       //Category Type
                       if quRecordsRecordType.AsInteger = SINGLE_RECORD then
                          sCategory := quRecordsCategory.AsString //Normal Category
                       else if quRecordsRecordType.AsInteger = TRANFER_RECORD then
                          sCategory := quRecordsPayee.AsString; //Bank that will receive the transfer

                       //Insert Disbursement
                       if quRecordsRecordType.AsInteger in [SINGLE_RECORD, TRANFER_RECORD] then
                                 MyQuickBooks.AddTransSplit(iTrans,
                                                            sTransType,
                                                            sCategory,
                                                            FormatFloat('#,##0.00', (quRecordsAmount.AsCurrency)*-1),
                                                            FormatDateTime('mm/dd/yyyy', quRecordsRecordDate.AsDateTime),
                                                            quRecordsNumDoc.AsString,
                                                            quRecordsPayee.AsString,
                                                            quRecordsMemo.AsString,
                                                            quRecordsReconciled.AsString[1]); //Reconciled
                       end;

                    SOFTWARE_PEACHTREE :
                       begin

                       end;
               end;


               //Se for Parent, Monta os Filho antes de fechar o registro
               if quRecordsRecordType.AsInteger = PARENT_RECORD then
                  BuildChildren(quRecordsIDRecord.AsString);
               end;

            Next;
            end;
         end;

   Finally
      quRecords.EnableControls;
   end;

end;

function TSisWizardFrm.GetCategoryName(sIDCategory:String):String;
  begin
  with DM.quFreeSQL do
      begin
      if Active then
         Close;

      SQL.Clear;
      SQL.Add('SELECT LT.LancamentoTipo');
      SQL.Add('FROM Fin_LancamentoTipo LT');
      SQL.Add('WHERE LT.IDLancamentoTipo = ' + sIDCategory);
      Open;

      Result := FieldByName('LancamentoTipo').AsString;

      Close;
      end;
  end;


procedure TSisWizardFrm.FillRecords;
var
   recID,
   recIDParent,
   recDate,
   recAmount,
   recDocNum,
   recPayee,
   recMemo,
   recType,
   recCategoty,
   recPaymentType,
   recReconciled : string;

   bHasDisbursement : Boolean;

   iIDRec : integer;

   //###### SUB-FUNCTIONS #######
   procedure InsertValues;
      begin

      if recDate = '' then
         recDate := 'Null';

      if recDocNum = '' then
         recDocNum := 'Null';

      if recPayee = '' then
         recPayee := 'Null';

      if recMemo = '' then
         recMemo := 'Null'
      else
         recMemo := QuotedStr(recMemo);

      if recPaymentType = '' then
         recPaymentType := '0';

      with quInsertRecords do
           begin
           CommandText := 'Insert #RecordsList (IDRecord, RecordDate, Amount, Category, NumDoc, '+
                          'Payee, Memo, IDRecordParent, RecordType, PaymentType, Reconciled)' +
                          'Values ('+recID+','+recDate+','+recAmount+','+QuotedStr(recCategoty)+','+recDocNum +
                          ','+recPayee+','+recMemo+','+recIDParent+','+recType+','+recPaymentType+','+recReconciled+')';
           Execute; 
           end;
      //Proximo Registro
      inc(iIDRec);

      end;

   function hasDisbursement(sIDQuitacao:String):Boolean;
      begin
      with DM.quFreeSQL do
          begin
          if Active then
             Close;

          SQL.Clear;
          SQL.Add('SELECT DISTINCT LT.LancamentoTipo');
          SQL.Add('FROM Fin_LancQuit LQ (NOLOCK)');
          SQL.Add('INNER JOIN dbo.Fin_Lancamento L (NOLOCK) ON ( L.IDLancamento = LQ.IDLancamento )');
          SQL.Add('INNER JOIN dbo.Fin_LancamentoTipo LT (NOLOCK) ON ( L.IDLancamentoTipo = LT.IDLancamentoTipo )');
          SQL.Add('WHERE LQ.IDQuitacao = ' + sIDQuitacao);
          SQL.Add('AND L.Desativado = 0');
          Open;

          Result := (RecordCount > 1);

          if Result then
             recType := '2'; //Disbursement parent icon

          //Signifia que tem uma Categoria
          if RecordCount = 1 then
             recCategoty := FieldByName('LancamentoTipo').AsString
          else
             //Set a Categoria do inicial
             if quPreRecordsPagando.AsBoolean then
                recCategoty := GetCategoryName('1')
             else
                recCategoty := GetCategoryName('0');
          Close;
          end;
      end;

   function InsertDisbursement(sIDQuitacao:String):Boolean;
      begin
      with DM.quFreeSQL do
          begin
          if Active then
             Close;

          SQL.Clear;
          SQL.Add('SELECT L.IDLancamento, LT.LancamentoTipo, LQ.DataQuitacao, ');
          SQL.Add('((LQ.ValorQuitado + LQ.ValorJuros) * (1 - 2*L.Pagando) ) as ValorQuitado, L.Historico ');
          SQL.Add('FROM Fin_LancQuit LQ (NOLOCK) ');
          SQL.Add('INNER JOIN dbo.Fin_Lancamento L (NOLOCK) ON ( L.IDLancamento = LQ.IDLancamento )');
          SQL.Add('INNER JOIN dbo.Fin_LancamentoTipo LT (NOLOCK) ON ( L.IDLancamentoTipo = LT.IDLancamentoTipo )');
          SQL.Add('WHERE LQ.IDQuitacao = ' + sIDQuitacao);
          SQL.Add('AND L.Desativado = 0');
          Open;

          //Signifia que tem uma Categoria
          First;

          recIDParent := recID;
          recPayee    := '';
          recDocNum   := '';
          recType     := '3'; //Disbursement icon

          While not EOF do
             begin
             recID       := IntToStr(iIDRec);
             recCategoty := FieldByName('LancamentoTipo').AsString;
             recAmount   := MyFormatCur(FieldByName('ValorQuitado').AsCurrency,'.');
             recMemo     := FieldByName('Historico').AsString;
             recDate     := QuotedStr(FormatDateTime('mmddyyyy',FieldByName('DataQuitacao').AsDateTime));
             InsertValues;
             Next;
             end;

          Close;
          end;
      end;


begin

  with quPreRecords do
     begin
     First;

     iIDRec := 1;

     While not EOF do
        begin
        //Jogo os valores iniciais para os campos
        recID       := IntToStr(iIDRec);
        recIDParent := 'Null';
        recType     := '1'; //Single record icon
        recDate     := QuotedStr(FormatDateTime('mmddyyyy',quPreRecordsRecordDate.AsDateTime));
        recAmount   := MyFormatCur(quPreRecordsAmount.asCurrency, '.');
        recPayee    := QuotedStr(quPreRecordsPayee.AsString);
        recMemo     := quPreRecordsMemo.AsString;
        recDocNum   := '';
        //Reconciled record
        if not quPreRecordsDataReconciliacao.IsNull then
           recReconciled := QuotedStr('Y')
        else
           recReconciled := QuotedStr('N');
           
        //Se for transfer nao precisa procurar por disbursement
        if quPreRecordsIDTransferencia.AsInteger <> 0 then
           begin
           recCategoty      := quPreRecordsMeioPag.AsString;
           bHasDisbursement := False;
           recType          := '4'; //Tranfer icon

           //Coloco a ContaCorrent como Payee
           if quPreRecordsAmount.AsCurrency < 0 then
              recPayee      := QuotedStr(quPreRecordsContaCorrenteCredit.AsString)
           else
              recPayee      := QuotedStr(quPreRecordsContaCorrentDebit.AsString);
           end
        else
           begin
           //Somentent se for check grava o Check Num
           if quPreRecordsTipo.AsInteger = DM.GetConst('QuitacaoMeioTipo_Cheque') then
              recDocNum := QuotedStr(quPreRecordsDocMumber.AsString);

           //Seleciona o Payment Type do record
           recPaymentType := quPreRecordsTipo.AsString;

           //Verificar se tem existe Disbursement
           bHasDisbursement := hasDisbursement(quPreRecordsIDQuitacao.asString);
           end;

        //Gravo o Documento
        InsertValues;

        //Gravo os subDocumentes (Disbursement)
        if bHasDisbursement then
           InsertDisbursement(quPreRecordsIDQuitacao.AsString);

        Next;
        end;
        
     end;
end;

procedure TSisWizardFrm.OpenPreRecord;
begin

  with quPreRecords do
     begin
     if Active then
        Close;

     Parameters.ParamByName('DateIni').Value := dateFrom.Date;
     Parameters.ParamByName('DateEnd').Value := dateTo.Date+1;
     Parameters.ParamByName('IDContaCorrente').Value := StrToInt(scBankAcccount.LookUpValue);
     Open;

     //Criio a Tabela temp
     CreateTempTable;

     //Preenche a Tbl Temp
     FillRecords;

     //Fecho a TblPre
     Close;
     end;
     
end;

procedure TSisWizardFrm.DeleteDropTempTable(IsDelete:Boolean);
begin

  with DM.quFreeSQL do
    begin
      if Active then
         Close;
         if isDelete then
            SQL.Text := 'DELETE #RecordsList'
         else
            SQL.Text := 'DROP TABLE #RecordsList';

      Try
        ExecSQL;
      Except
      end;  
    end;

end;

procedure TSisWizardFrm.CreateTempTable;
begin

  // Tenta criar a Tabela Temporária no Server
  // se não conseguir e porque ela já existe.
  try
    with DM.quFreeSQL do
      begin
        if Active then
           Close;
        SQL.Text := 'CREATE TABLE #RecordsList ( ' +
                    'IDRecord       int NOT NULL, ' +
                    'RecordDate     datetime NULL, ' +
                    'Amount         Money NULL, ' +
                    'NumDoc         VarChar(20) NULL, ' +
                    'Payee          VarChar(60) NULL, ' +
                    'Memo           VarChar(255) NULL, ' +
                    'IDRecordParent int NULL, ' +
                    'RecordType     int NULL, ' +
                    'Category       VarChar(65) NULL, ' +
                    'PaymentType    int NULL, ' +
                    'Reconciled     VarChar(1) NULL  )';
        ExecSQL;
      end;
  except
    // Como existe esvazia a tabela temporaria, exvazia-a.
    DeleteDropTempTable(True);
  end;


end;

Procedure TAdvStringGrid.DeleteRow(ARow:LongInt);
Begin
 Inherited DeleteRow(ARow)
End;

Procedure TAdvStringGrid.DeleteColumn(AColumn:LongInt);
Begin
 Inherited DeleteColumn(AColumn)
End;

procedure TSisWizardFrm.BuildBankTransaction;
var
  iAcc : integer;
begin

  iAcc := cbxTransType.ItemIndex;

  case iSoftware of
       SOFTWARE_QUICKEN,
       SOFTWARE_MSMONEY    : MyQuicken.SetBank(scBankAcccount.Text, iAcc, iAcc);
       SOFTWARE_QUICKBOOKS : MyQuickBooks.SetBank(scBankAcccount.Text, '', iAcc);
       SOFTWARE_PEACHTREE  : MyPeachTree.SetBank(scBankAcccount.LookUpValue,
                                                 scBankAcccount.Text, IntToStr(iAcc), 'FALSE');
  end;

end;

procedure TSisWizardFrm.BuildCategoryList;
var
  iRow : integer;
  sCategType : String;
begin

  case iSoftware of

        SOFTWARE_QUICKEN,
        SOFTWARE_MSMONEY :
              begin
              with gridCategory do
                  for iRow:=1 to RowCount-1 do
                     if Trim(gridCategory.Rows[iRow].Text) <> '' then
                      MyQuicken.AddCategory(Cells[0,iRow], Cells[1,iRow], Cells[2,iRow]);
              end;


        SOFTWARE_QUICKBOOKS :
              begin
              with gridCategory do
                  for iRow:=1 to RowCount-1 do
                     if Trim(gridCategory.Rows[iRow].Text) <> '' then
                        MyQuickBooks.AddChartOfAccount(Cells[0,iRow], Cells[1,iRow], Cells[2,iRow]);
              end;

        SOFTWARE_PEACHTREE :
              begin
              with gridCategory do
                  for iRow:=1 to RowCount-1 do
                     if Trim(gridCategory.Rows[iRow].Text) <> '' then
                        MyPeachTree.AddChartOfAccount(Cells[3,iRow], Cells[1,iRow], Cells[2,iRow], Cells[4,iRow]);
              end;
  end;

end;

procedure TSisWizardFrm.ClearCategory;
begin

    gridCategory.RowCount  := 2;

    gridCategory.FixedCols := 0;
    gridCategory.FixedRows := 1;

    gridCategory.Cells[0,0] := sName;
    gridCategory.Cells[1,0] := sDescrip;
    gridCategory.Cells[2,0] := sIncExp;
    gridCategory.Cells[3,0] := sCode;
    gridCategory.Cells[4,0] := sHidden;

    gridCategory.Rows[1].Clear;   

end;

procedure TSisWizardFrm.ImportCategory;
var
  iRow : integer;
begin

  with DM.quFreeSQL do
     begin

     if Active then
        Close;

     SQL.Clear;
     SQL.Add('SELECT LT.LancamentoTipo,');
     SQL.Add('LT.CodigoContabil,');
     SQL.Add('(CASE Desativado WHEN 0 THEN ''FALSE'' ELSE ''TRUE'' END) AS Active,');
     case iSoftware of
          SOFTWARE_QUICKEN,
          SOFTWARE_MSMONEY    : SQL.Add('(CASE LT.Pagando WHEN 0 THEN ''I'' ELSE ''E'' END) as Type');
          SOFTWARE_QUICKBOOKS : SQL.Add('(CASE LT.Pagando WHEN 0 THEN ''INC'' ELSE ''EXP'' END) as Type');
          SOFTWARE_PEACHTREE  : SQL.Add('(CASE LT.Pagando WHEN 0 THEN ''21'' ELSE ''24'' END) as Type');
     end;
     SQL.Add('FROM Fin_LancamentoTipo LT');
     SQL.Add('WHERE LT.Hidden = 0 AND LT.Desativado = 0');
     SQL.Add('ORDER BY LT.Pagando');
     Open;

     gridCategory.RowCount := RecordCount;

     First;
     iRow := 1;
     //Fill out the Grid

     While not EOF do
        begin
        gridCategory.Cells[0,iRow] := FieldByName('LancamentoTipo').AsString;
        gridCategory.Cells[1,iRow] := FieldByName('LancamentoTipo').AsString;
        gridCategory.Cells[2,iRow] := FieldByName('Type').AsString;
        gridCategory.Cells[3,iRow] := FieldByName('CodigoContabil').AsString;
        gridCategory.Cells[4,iRow] := FieldByName('Active').AsString;
        inc(iRow);
        Next;
        end;

     Close;
     end;

end;

procedure TSisWizardFrm.StartPage;
var
  sSoftware : String;
begin


  if Notebook1.ActivePage = 'Category' then
     begin
     case iSoftware of
         SOFTWARE_QUICKEN,
         SOFTWARE_MSMONEY    : lbLabel.Caption := 'Income = I'   + #13#10 + 'Expense = E';
         SOFTWARE_QUICKBOOKS : lbLabel.Caption := 'Income = INC' + #13#10 + 'Expense = EXP';
         SOFTWARE_PEACHTREE  : lbLabel.Caption := 'Income = 21'  + #13#10 + 'Expense = 24';
         end;

     end
  else if Notebook1.ActivePage = 'pgSummary' then
     begin
     case iSoftware of
         SOFTWARE_QUICKEN    : sSoftware := 'Quicken Interchange Format (QIF)';
         SOFTWARE_QUICKBOOKS : sSoftware := 'QuickBooks Format (IIF)';
         SOFTWARE_PEACHTREE  : sSoftware := 'PeachTree Format (CSV)';
         SOFTWARE_MSMONEY    : sSoftware := 'Microsoft Money Format (QIF)';
         end;

     memSummary.Clear;
     memSummary.Lines.Add(sExportar + sSoftware);
     memSummary.Lines.Add('=================================');
     memSummary.Lines.Add(sAccountInfo);
     memSummary.Lines.Add(sFile + edtPath.Text);
     end;



end;

function TSisWizardFrm.ValidatePage:Boolean;
begin

  Result := True;


  if Notebook1.ActivePage = 'Software' then
     begin

     if treeSoftware.Selected.Index = -1 then
        begin
        MsgBox(MSG_INF_SELECT_SOFTWARE, vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;

     SetupSoftwareInfo;

     end
  else if Notebook1.ActivePage = 'Bank' then
     begin
     if scBankAcccount.LookUpValue = '' then
        begin
        MsgBox(MSG_INF_CHOOSE_BANK, vbInformation + vbOKOnly);
        scBankAcccount.SetFocus;
        Result := False;
        Exit;
        end;

     if cbxTransType.Text = '' then
        begin
        MsgBox(MSG_INF_SELECT_TRANS_TYPE, vbInformation + vbOKOnly);
        cbxTransType.SetFocus;
        Result := False;
        Exit;
        end;

     //Information to be displayed on the summary
     sAccountInfo := sSystemType + scBankAcccount.Text + #13#10 +
                     sType + cbxTransType.Text;

     end
  else if Notebook1.ActivePage = 'Category' then
     begin
     end
  else if Notebook1.ActivePage = 'Transaction' then
     begin
     if (not quRecords.Active) or (quRecords.IsEmpty) then
        begin
        MsgBox(MSG_INF_NO_DATA_TO_EXPORT, vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;
     end
  else if Notebook1.ActivePage = 'File' then
     begin
     if (Trim(edtPath.Text) = '') or (Pos('.', edtPath.Text) = 0) then
        begin
        MsgBox(MSG_INF_PART1_INVALID_FILE_NAME + #13#10 +
               MSG_INF_PART2_INVALID_FILE_NAME + #13#10, vbCritical + vbOKOnly);
        edtPath.SetFocus;
        Result := False;
        end;
        
     end;


end;

function TSisWizardFrm.GenerateFile:Boolean;
begin

  case iSoftware of
     SOFTWARE_QUICKEN,
     SOFTWARE_MSMONEY    : Result := MyQuicken.SaveDataToFile(edtPath.Text);
     SOFTWARE_QUICKBOOKS : Result := MyQuickBooks.SaveDataToFile(edtPath.Text);
     SOFTWARE_PEACHTREE  : Result := MyPeachTree.SaveDataToFile(edtPath.Text);
  end;

  if Result then
     MsgBox(MSG_INF_PART_FILE_CREATED_AT + edtPath.Text, vbInformation + vbOKOnly)
  else
     MsgBox(MSG_CRT_CREATIBG_FILE_ERROR, vbInformation + vbOKOnly);

  Close;

end;

procedure TSisWizardFrm.NavigatePage(Sender:TObject);
begin

    Case TButton(Sender).Tag of

      1 : Notebook1.PageIndex := (Notebook1.PageIndex-1);

      2 : Notebook1.PageIndex := (Notebook1.PageIndex+1);

      3 : begin
          if CreateData then
             GenerateFile
          else
            MsgBox(MSG_CRT_CREATING_DATA_ERROR, vbCritical + vbOKOnly);
          end;
    end;

end;


procedure TSisWizardFrm.Start(sIDBankAcc:String; DateIni,DateEnd:TDate);
begin

   //initial values
   Notebook1.PageIndex := 0;
   iSoftware := -1;

   ClearCategory;

   if sIDBankAcc <> '' then
      scBankAcccount.LookUpValue := sIDBankAcc;

   dateFrom.Date := DateIni;
   dateTo.Date   := DateEnd;

   ShowModal;
   
end;

procedure TSisWizardFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Assigned(MyQuicken) then
     MyQuicken.Free;

  if Assigned(MyQuickBooks) then
     MyQuickBooks.Free;

  if Assigned(MyPeachTree) then
     MyPeachTree.Free; 

  quRecords.Close;
  DeleteDropTempTable(False);
  Action := caFree;

end;

procedure TSisWizardFrm.Notebook1PageChanged(Sender: TObject);
begin
  inherited;

  btnBack.Enabled := not (Notebook1.PageIndex = 0);

  if Notebook1.PageIndex = 0 then
     Notebook1.Color := clWhite
  else
     Notebook1.Color := clMenu;

  if (Notebook1.Pages.Count-1) = Notebook1.PageIndex then
     begin
     btnNext.Caption := sFinish;
     btnNext.Tag     := 3;
     end
  else
     begin
     btnNext.Caption := sNext;
     btnNext.Tag     := 2;
     end;

  StartPage;
  
end;

procedure TSisWizardFrm.btnBackClick(Sender: TObject);
begin
  inherited;

  if (TButton(Sender).Tag = 2) then
     if (not ValidatePage) then
        Exit;

  NavigatePage(Sender);

end;

procedure TSisWizardFrm.sbOpenFileClick(Sender: TObject);
var
  sFile : String;
  sExt  : String;
begin
  inherited;

  if SD.Execute then
     begin
     sFile := LowerCase(SD.FileName);

     case iSoftware of
        SOFTWARE_QUICKEN,
        SOFTWARE_MSMONEY    : sExt := '.qif';
        SOFTWARE_QUICKBOOKS : sExt := '.iif';
        SOFTWARE_PEACHTREE  : sExt := '.csv';
     end;

     if Pos(sExt, sFile) = 0 then
        sFile := sFile + sExt;

     edtPath.Text := sFile;
     end;
end;

procedure TSisWizardFrm.gridCategorySetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);

var
  sResult : String;
begin
  inherited;

    if ACol = 2 then
       begin

       sResult := Value;

       sResult := UpperCase(sResult);

       if not ((sResult = 'E') or (sResult = 'I')) then
          begin
          MsgBox(MSG_INF_NOT_VALID_CATEG_TYPE, vbInformation + vbOKOnly);

          end;
       end;
end;

procedure TSisWizardFrm.SpeedButton1Click(Sender: TObject);
begin
  inherited;

  ImportCategory;

end;

procedure TSisWizardFrm.SpeedButton4Click(Sender: TObject);
begin
  inherited;

  ClearCategory;
  
end;

procedure TSisWizardFrm.SpeedButton3Click(Sender: TObject);
begin
  inherited;

  TAdvStringGrid(gridCategory).DeleteRow(gridCategory.Row);

end;

procedure TSisWizardFrm.FormCreate(Sender: TObject);
begin
  inherited;

  ImgSummary.Picture.Assign(ImgIntro.Picture);
  ImgCateg.Picture.Assign(ImgBank.Picture);
  ImgTrans.Picture.Assign(ImgBank.Picture);
  imgFile.Picture.Assign(ImgBank.Picture);
  ImgSoftware.Picture.Assign(ImgBank.Picture);

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sName       := 'Name';
           sDescrip    := 'Description';
           sIncExp     := 'Income/Expense';
           sCode       := 'Code';
           sHidden     := 'Hidden';
           sExportar   := 'Exporting data to ';
           sFile       := 'File: ';
           sSystemType := 'System account: ';
           sType       := 'Type: ';
           sFinish     := '&Finish';
           sNext       := 'Ne&xt >>';
           sQuicken    := 'The data will be exported to ''Quicken File.''' + #13#10 +
                          'The data file can be importate from Quicken 2001. ' +
                          'See help file to learn how to import a QIF file using Quiken.';
           sQB         := 'The data will be exported to ''QuickBooks File.''' + #13#10 +
                          'The data file can be importate from QuickBooks Pro 2001/2002. ' +
                          'See help file to learn how to import a IIF file using QuickBooks.';
           sPeachTree  := 'The data will be exported to ''Peach Tree File.''' + #13#10 +
                          'The data file can be importate from PeachTree Accounting 2002. ' +
                          'Peachtree will only import the Chart of Account list. ' +
                          'See help file to learn how to import a CSV file using PeachTree.';
           sMoney       := 'The data will be exported to ''MSMoney File.''' + #13#10 +
                           'The data file can be importate from Microsoft Money 2002. ' +
                           'See help file to learn how to import a QIF file using MS Money.';
           end;
    LANG_PORTUGUESE :
           begin
           sName       := 'Nome';
           sDescrip    := 'Descrição';
           sIncExp     := 'Receita/Desp.';
           sCode       := 'Cod';
           sHidden     := 'Oculto';
           sExportar   := 'Exportar dados para ';
           sFile       := 'Arquivo: ';
           sSystemType := 'Conta de Sistema: ';
           sType       := 'Tipo: ';
           sFinish     := '&Finalizar';
           sNext       := 'Pro&ximo >>';
           sQuicken    := 'Os dados serão exportados para ''Quicken File.''' + #13#10 +
                          'Este arquivo poderá ser importado pelo Quicken 2001. ' +
                          'Veja a ajuda para aprender como importar o arquivo QIF usando o Quiken.';
           sQB         := 'Os dados serão exportados para ''QuickBooks File.''' + #13#10 +
                          'Este arquivo poderá ser importado pelo QuickBooks Pro 2001/2002. ' +
                          'Veja a ajuda para aprender como importar o arquivo IIF usando o QuickBooks.';
           sPeachTree  := 'Os dados serão exportados para ''Peach Tree File.''' + #13#10 +
                          'Este arquivo poderá ser importado pelo PeachTree Accounting 2002. ' +
                          'Peachtree só importará a lista de categorias. ' +
                          'Veja a ajuda para aprender como importar o arquivo CSV usando o PeachTree.';
           sMoney      := 'Os dados serão exportados para ''MSMoney File.''' + #13#10 +
                          'Este arquivo poderá ser importado pelo Microsoft Money 2002. ' +
                          'Veja a ajuda para aprender como importar o arquivo QIF usando o MS Money.';
           end;
    LANG_SPANISH :
           begin
           sName       := 'Nombre';
           sDescrip    := 'Descripción';
           sIncExp     := 'Income/Expense';
           sCode       := 'Code';
           sHidden     := 'Hidden';
           sExportar   := 'Exportar datos para ';
           sFile       := 'Archivo: ';
           sSystemType := 'Cuenta del Sistema: ';
           sType       := 'Tipo: ';
           sFinish     := '&Finalizar';
           sNext       := 'Pró&ximo >>';
           sQuicken    := 'Los datos serán exportados para ''Quicken File.''' + #13#10 +
                          'Este archivo podrá ser importado por el Quicken 2001. ' +
                          'Vea la ayuda para aprender a cómo importar el archivo QIF usando el Quiken.';
           sQB         := 'Los datos serán exportados para ''QuickBooks File.''' + #13#10 +
                          'Este archivo podrá ser importado por el QuickBooks Pro 2001/2002. ' +
                          'Vea la ayuda para aprender a cómo importar el archivo IIF usando el QuickBooks.';
           sPeachTree  := 'Los datos serán exportados para ''Peach Tree File.''' + #13#10 +
                          'Este archivo podrá ser importado por el PeachTree Accounting 2002. ' +
                          'Peachtree sólo importará la lista de categorias. ' +
                          'Vea la ayuda para aprender a cómo importar el archivo CSV usando el PeachTree.';
           sMoney      := 'Los datos serán exportados para ''MSMoney File.''' + #13#10 +
                          'Este archivo podrá ser importado por el Microsoft Money 2002. ' +
                          'Vea la ayuda para aprender a cómo importar el archivo QIF usando el MS Money.';
           end;
  end;


end;

procedure TSisWizardFrm.treeSoftwareClick(Sender: TObject);
begin
  inherited;

  lbSoftware.Visible := True;

  case treeSoftware.Selected.Index of
       0 : begin
           iSoftware := SOFTWARE_QUICKEN;
           lbSoftware.Caption := sQuicken;
           end;

       1 : begin
           iSoftware := SOFTWARE_QUICKBOOKS;
           lbSoftware.Caption := sQB;
           end;

       2  : begin
           iSoftware := SOFTWARE_PEACHTREE;
           lbSoftware.Caption := sPeachTree;
            end;

       3 : begin
           iSoftware := SOFTWARE_MSMONEY;
           lbSoftware.Caption := sMoney;
           end;


  end;

end;

procedure TSisWizardFrm.sbRefreshListClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crHourGlass;

  OpenPreRecord;

  //Refresh a Lista
  quRecords.Close;
  quRecords.Open;

  Screen.Cursor := crDefault;

end;

procedure TSisWizardFrm.btDeleteLineClick(Sender: TObject);
var
   BMB   : TBookMarkStr;
begin
  inherited;

  //Nao pode deletar Disbursement
  //Se deletar o Pai, tem que deletar os filhos
  if (quRecords.Active) and (quRecords.RecNo <> -1) then
     if quRecordsRecordType.AsInteger = DISBUR_RECORD then
        MsgBox(MSG_INF_NOT_DEL_TRANS_SPLITED + #13#10 , vbInformation + vbOKOnly)
     else
        begin

        BMB := quRecords.Bookmark;

        with DM.quFreeSQL do
           begin
           if Active then
              Close;
           SQL.Add('DELETE #RecordsList');
           SQL.Add('WHERE IDRecord = ' + quRecordsIDRecord.AsString );
           SQL.Add('OR IDRecordParent = ' + quRecordsIDRecord.AsString );
           ExecSQL;
           end;

        quRecords.Requery;

        quRecords.BookMark := BMB;
        end;

end;

end.
