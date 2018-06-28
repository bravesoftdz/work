unit uGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, Windows, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, dxDateEdit, DateBox,
  ComCtrls;

type
  TReg60A = class
     SitTributaria : String;
     Valor : Currency;
     end;

  TfrmGeraArquivo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SaveDialog: TSaveDialog;
    Panel3: TPanel;
    btnCancela: TBitBtn;
    btnGerar: TBitBtn;
    rgOperacao: TRadioGroup;
    rgFinalidade: TRadioGroup;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edData01: TDateBox;
    edData02: TDateBox;
    pb: TProgressBar;
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SitTrib : String;
    fFristCF,
    fLastCF : Integer;

    lsReg60A : TStringList;
    procedure FreelsReg60A;


    procedure InsertEmpresa;
    procedure InsertReg60M(SerialNumber:String);
    procedure InsertReg60A(SituacaoTrib:String; ValorAliq : Currency);
    procedure BuildReg60A;
    procedure InsertReg60I(NumSerieEquipamento : String; COOCupom, NumItem : Integer;
                          CodProduto, DescProduto : String; Qtd : Double;
                          Valorunitario, BaseICMS : Currency; SitTributaria : String);
    procedure InsertReg60D(NumSerieEquipamento : String; QtdAcumulada : Double;
                           ValorAcumulado, ICMSAcumulada : Currency; SitTributaria : String);


    function PreencherDataSet:Boolean;
    function FormatSitucaoTrib(SitTrib: Integer; Percent: Double): String;
  public
    { Public declarations }
  end;

var
  frmGeraArquivo: TfrmGeraArquivo;

implementation

uses Sintegra, uDados, DB, DateUtils, uRelatorioErro, uDM, uDateTimeFunctions;

{$R *.dfm}

procedure TfrmGeraArquivo.FormShow(Sender: TObject);
begin
  edData01.Date := InicioMes(Now);
  edData02.Date := FimMes(Now);
  edData01.SetFocus;
  rgOperacao.ItemIndex := 0;
  rgFinalidade.ItemIndex := 0;
end;

procedure TfrmGeraArquivo.InsertEmpresa;
begin

  if not Dados.Empresa.Active then
     Dados.Empresa.Open;

  Dados.Empresa.Edit;
  Dados.Empresa.Delete;
  Dados.Empresa.Append;

  Dados.EmpresaRazaoSocial.Value          := DM.fEmpresa.RazaoSocial;
  Dados.EmpresaCNPJ.Value                 := DM.fEmpresa.CNPJ;
  Dados.EmpresaInscEstadual.Value         := DM.fEmpresa.InscEstadual;
  Dados.EmpresaEndereco.Value             := DM.fEmpresa.Endereco;
  Dados.EmpresaComplemento.Value          := DM.fEmpresa.Complemento;
  Dados.EmpresaNumero.Value               := StrtoInt(DM.fEmpresa.Numero);
  Dados.EmpresaBairro.Value               := DM.fEmpresa.Bairro;
  Dados.EmpresaMunicipio.Value            := DM.fEmpresa.Municipio;
  Dados.EmpresaCEP.Value                  := DM.fEmpresa.CEP;
  Dados.EmpresaUF.Value                   := DM.fEmpresa.UF;
  Dados.EmpresaFax.Value                  := DM.fEmpresa.Fax;
  Dados.EmpresaFone.Value                 := DM.fEmpresa.Fone;
  Dados.EmpresaResponsavel.Value          := DM.fEmpresa.Responsavel;
  Dados.EmpresaSubstitutoTributario.Value := StrtoBool(DM.fEmpresa.Tributario);
  Dados.EmpresaContribuinteIPI.Value      := StrtoBool(DM.fEmpresa.IPI);

  Dados.Empresa.Post;

end;

procedure TfrmGeraArquivo.InsertReg60M(SerialNumber:String);
begin
  {
  Dados.Registro60MDataEmissao.Value;
  Dados.Registro60MNumSerieEquipamento.Value;
  Dados.Registro60MNumeroECF.Value;
  Dados.Registro60MCOOInicial.Value;
  Dados.Registro60MCOOFinal.Value;
  Dados.Registro60MContReducaoZ.Value;
  Dados.Registro60MContReinicioOper.Value;
  Dados.Registro60MVendaBruta.Value;
  Dados.Registro60MGTFinal.Value;
  Dados.Registro60MModeloDoc.Value := 1;
  }
end;

procedure TfrmGeraArquivo.FreelsReg60A;
var
  AReg60A : TReg60A;
begin
  while (lsReg60A.Count > 0) do
     begin
     AReg60A := TReg60A(lsReg60A.Objects[0]);
     AReg60A.Free;
     lsReg60A.Delete(0); 
     end;
  FreeAndNil(lsReg60A);
end;

procedure TfrmGeraArquivo.BuildReg60A;
var
  i : integer;
begin

  for i:=0 to lsReg60A.Count-1 do
    begin
    Dados.Registro60A.Append;
    Dados.Registro60ASitTributaria.Value  := TReg60A(lsReg60A.Objects[i]).SitTributaria;
    Dados.Registro60AValorAcumulado.Value := TReg60A(lsReg60A.Objects[i]).Valor;
    Dados.Registro60A.Post;
    end;

end;

procedure TfrmGeraArquivo.InsertReg60A(SituacaoTrib : String; ValorAliq : Currency);
var
  AReg60A : TReg60A;
  iIndex : integer;
begin

  iIndex := lsReg60A.IndexOf(SituacaoTrib);
  if iIndex  = -1 then
     begin
     AReg60A := TReg60A.Create;
     AReg60A.SitTributaria := SituacaoTrib;
     AReg60A.Valor         := ValorAliq;
     lsReg60A.AddObject(SituacaoTrib, AReg60A);
     end
  else
     begin
     TReg60A(lsReg60A.Objects[iIndex]).Valor := TReg60A(lsReg60A.Objects[iIndex]).Valor + ValorAliq;
     end;

end;

procedure TfrmGeraArquivo.InsertReg60I(NumSerieEquipamento : String; COOCupom, NumItem : Integer;
    CodProduto, DescProduto : String; Qtd : Double;
    Valorunitario, BaseICMS : Currency; SitTributaria : String);
begin

  Dados.Registro60I.Append;

  Dados.Registro60ICOOCupom.Value      := COOCupom;
  Dados.Registro60INumItem.Value       := NumItem;
  Dados.Registro60ICodProduto.Value    := CodProduto;
  Dados.Registro60IQuantidade.Value    := Qtd;
  Dados.Registro60IValorunitario.Value := Valorunitario;
  Dados.Registro60IBaseICMS.Value      := BaseICMS;
  Dados.Registro60ISitTributaria.Value := SitTributaria;

  Dados.Registro60I.Post;
  
end;

procedure TfrmGeraArquivo.InsertReg60D(NumSerieEquipamento : String; QtdAcumulada : Double;
   ValorAcumulado, ICMSAcumulada : Currency; SitTributaria : String);
begin

 {
 Dados.Registro60DCodProduto.Value;
 Dados.Registro60DQuantAcumulada.Value;
 Dados.Registro60DValorAcumulado.Value;
 Dados.Registro60DBaseICMSAcumulada.Value;
 Dados.Registro60DSitTributaria.Value;
 }
 
end;

function TfrmGeraArquivo.FormatSitucaoTrib(SitTrib : Integer; Percent : Double) : String;
begin
  //1 - Tributável
  //2 - Não Tributável
  //3 - Substituição Tributária
  //4 - Isento
  //5 - ISS

 case SitTrib of
   1 : Result := FormatFloat('0000',((Percent)*10000));
   2 : Result := 'N';
   3 : Result := 'F';
   4 : Result := 'I';
   5 : Result := 'ISS'
   else Result := 'I';
 end;

end;

function TfrmGeraArquivo.PreencherDataSet:Boolean;
var
  SitTrub   : String;
  SerialNum : String;
  NumItem   : Integer;
begin

  //Abro a query com os valores
  Result := True;

  if not DM.HasSale(edData01.Date, edData02.Date) then
     begin
     Result := False;
     Application.MessageBox(PAnsiChar('Sem dados para gerar arquivo'), 'Geração', MB_ICONERROR+MB_OK);
     Exit;
     end;

  InsertEmpresa;

  lsReg60A := TStringList.Create;

  try

      if not DM.quImpSerial.Active then
         DM.quImpSerial.Open;

      NumItem := 0;

      while not DM.quImpSerial.EOF do
          begin
          SerialNum := DM.quImpSerialNumeroSeriePrinter.AsString;
          InsertReg60M(SerialNum);
          inc(NumItem);

          //Abrir vendas
          DM.quProduto.Close;
          DM.quProduto.Parameters.ParamByName('Data_Inicial').Value       := edData01.Date;
          DM.quProduto.Parameters.ParamByName('Data_Final').Value         := edData02.Date+1;
          DM.quProduto.Parameters.ParamByName('NumeroSeriePrinter').Value := SerialNum;
          DM.quProduto.Open;
          DM.quProduto.First;
          pb.Visible  := True;
          pb.Position := 0;
          pb.Max      := DM.quProduto.RecordCount;
          Application.ProcessMessages;

          while not (DM.quProduto.EOF) do
             begin
             SitTrib := FormatSitucaoTrib(DM.quProdutoSituacaoTributaria.AsInteger,
                                          DM.quProdutoTax.AsFloat);

             InsertReg60A(SitTrib, DM.quProdutoTaxValue.AsCurrency);

             InsertReg60I(SerialNum,
                          DM.quProdutoCupomFiscal.AsInteger,
                          NumItem,
                          DM.quProdutoModelID.AsString,
                          DM.quProdutoDescription.AsString,
                          DM.quProdutoQty.AsInteger,
                          DM.quProdutoSalePrice.AsCurrency,
                          DM.quProdutoExtSubTotal.AsCurrency,
                          SitTrib);


             //InsertReg60D();

             //Registro 75 - Listagem dos códigos de produto ou serviço utilizado
             if Dados.Registro75.Locate('CodProduto', DM.quProdutoModelID.AsString, []) then
                Dados.Registro75.Delete;
                begin
                Dados.Registro75.Append;
                Dados.Registro75DtValidadeIni.Value   := Now;
                Dados.Registro75DtValidadeFim.Value   := Now+365;
                Dados.Registro75CodProduto.Value      := DM.quProdutoModelID.AsString;
                Dados.Registro75CodNCM.Value          := ''; //Mercosul
                Dados.Registro75Descricao.Value       := DM.quProdutoDescription.AsString;
                Dados.Registro75Unidade.Value         := 'un';
                Dados.Registro75AliquotaIPI.Value     := 0;
                Dados.Registro75AliquotaICMS.Value    := DM.quProdutoTax.AsFloat;
                Dados.Registro75ReducaoBaseCalc.Value := 0;
                Dados.Registro75BaseICMSST.Value      := 0;
                Dados.Registro75.Post;
                end;

             DM.quProduto.Next;
             pb.Position := pb.Position + 1;
             end;

           BuildReg60A;
           DM.quImpSerial.Next;

           end; //Serial

  finally
    DM.quImpSerial.Close;
    FreelsReg60A;
    pb.Visible  := False;
    Application.ProcessMessages;
    end;









    {

    SitTrib : String;
    fFristCF,
    fLastCF : Integer;

    DM.quProduto.First;
    while not (DM.quProduto.EOF) do
     begin


        //1 - Tributável
        //2 - Não Tributável
        //3 - Substituição Tributária
        //4 - Isento
        //5 - ISS

       case DM.quProdutoSituacaoTributaria.AsInteger of
         1 : SitTrib := FormatFloat('0000',((DM.quProdutoTax.AsFloat)*10000));
         2 : SitTrib := 'N';
         3 : SitTrib := 'F';
         4 : SitTrib := 'I';
         5 : SitTrib := 'ISS'
         else SitTrib := 'I';
       end;

      //Dados.Registro60M.First;
      //while not (Dados.Registro60M.EOF) do
     // begin
        with Registro60.Add do
        begin
          DataEmissao      :=   DateOf(DM.quProdutoInvoiceDate.AsDateTime);//Dados.Registro60MDataEmissao.Value;
          NumSerieEquip    :=   DM.quProdutoNumeroSeriePrinter.AsString;//Dados.Registro60MNumSerieEquipamento.Value;
          NumSequencial    :=   1;//Dados.Registro60MNumeroECF.Value;     1;//

          ModDocFiscal := modECF;
          // Pesquizar
          Case Dados.Registro60MModeloDoc.Value of
            1: ModDocFiscal := modECF;
            2: ModDocFiscal := modPDV;
            3: ModDocFiscal := modMaqRegistradora;
          end;

          //Num Primeiro Cupom do dia
          COOInicial       := fFristCF;
          //Num Ultimo Cupom do dia
          COOFinal         := fLastCF;
          ContReducaoZ     := 5;//Dados.Registro60MContReducaoZ.Value;
          ContReinicioOper := 10;//Dados.Registro60MContReinicioOper.Value;
          VendaBruta       := 10;//Dados.Registro60MVendaBruta.Value;
          GTFinal          := 10;//Dados.Registro60MGTFinal.Value;

        Dados.Registro60A.First;
        while not(Dados.Registro60A.Eof) do
        begin
          with Registro60A.Add do
          begin
            NumSerieEquip  := DM.quProdutoNumeroSeriePrinter.AsString;
            SitTributaria  := SitTrib;//Dados.Registro60ASitTributaria.Value;
            ValorAcumulado := 10;//Dados.Registro60AValorAcumulado.Value;
          end;
          Dados.Registro60A.Next;
        end;

        end;


      //  Dados.Registro60M.Next;
      //end;



      //Dados.Registro60R.First;
      //while not(Dados.Registro60R.Eof) do
      //begin
        with Registro60R.Add do
        begin
          Mes              := Strtoint(FormatDateTime('mm',DM.quProdutoMovDate.AsDateTime));//10;//Dados.Registro60RMes.Value;  10;//
          ANo              := Strtoint(FormatDateTime('YYYY',DM.quProdutoMovDate.AsDateTime));//Dados.Registro60RAno.Value;    2005;//
          CodProduto       := DM.quProdutoModel.AsString;//Dados.Registro60RCodProduto.Value;
          Quantidade       := DM.quProdutoQty.AsInteger;//Dados.Registro60RQuantidade.Value;
          ValorAcumProduto := DM.quProdutoExtSubTotal.AsFloat;//Dados.Registro60RValorAcumulado.Value;
          ValorAcumICMS    := DM.quProdutoTaxValue.AsFloat;//Dados.Registro60RValorAcumuladoICMS.Value;
          SitTributaria    := SitTrib;//Dados.Registro60RSitTributaria.Value;
        end;
        //Dados.Registro60R.Next;
      //end;


      with Registro75.Add do
      begin
        ValidadeInicial := Now;
        ValidadeFinal   := Now;
        CodProduto      := DM.quProdutoModel.AsString;
        CodNCM          := '1';
        DescricaoProd   := DM.quProdutoDescription.AsString;
        Unidade         := 'UN';
        AliquotaIPI     := 05;
        AliquotaICMS    := 19;
        ReducaoBaseCalc := 0;
        BaseICMSST      := 0;
      end;

      pb.Position := pb.Position + 1;
      DM.quProduto.Next;
     end;

    pb.Visible  := False;
    Application.ProcessMessages;
    }

end;

procedure TfrmGeraArquivo.btnGerarClick(Sender: TObject);
begin

  Dados.RelatorioErro.Clear;

  if not PreencherDataSet then
     Exit;

  with Dados.Sintegra do
  begin
    DataInicial := StrToDate(edData01.Text);
    DataFinal   := StrToDate(edData02.Text);
    case rgOperacao.ItemIndex of
      0: NaturezaOperacao := opeTotal;
      1: NaturezaOperacao := opeInterestSubTributaria;
      2: NaturezaOperacao := opeInterestaduais;
    end;
    case rgFinalidade.ItemIndex of
      0: Finalidade := finNormal;
      1: Finalidade := finRetificacaoTotal;
      2: Finalidade := finRetificacaoAditiva;
      3: Finalidade := finDesfazimento;
    end;
    with Empresa do
    begin
      RazaoSocial          := Dados.EmpresaRazaoSocial.Value;
      CNPJ                 := Dados.EmpresaCNPJ.Value;
      InscEstadual         := Dados.EmpresaInscEstadual.Value;
      Endereco             := Dados.EmpresaEndereco.Value;
      Complemento          := Dados.EmpresaComplemento.Value;
      Numero               := Dados.EmpresaNumero.Value;
      Bairro               := Dados.EmpresaBairro.Value;
      Municipio            := Dados.EmpresaMunicipio.Value;
      CEP                  := Dados.EmpresaCEP.Value;
      UF                   := Dados.EmpresaUF.Value;
      Fax                  := Dados.EmpresaFax.Value;
      Fone                 := Dados.EmpresaFone.Value;
      Responsavel          := Dados.EmpresaResponsavel.Value;
      SubstitutoTributario := Dados.EmpresaSubstitutoTributario.Value;
      ContribuinteIPI      := Dados.EmpresaContribuinteIPI.Value;
    end;

    LimparRegistros;

    Dados.Registro50.First;
    while not(Dados.Registro50.EOF) do
    begin
      with Registro50.Add do
      begin
        CNPJ                := Dados.Registro50CNPJCPF.Value;
        InscEstadual        := Dados.Registro50InscEstadual.Value;
        Data                := Dados.Registro50Data.Value;
        UF                  := Dados.Registro50UF.Value;
        Modelo              := Dados.Registro50Modelo.Value;
        Serie               := Dados.Registro50Serie.Value;
        Numero              := Dados.Registro50Numero.Value;
        Frete               := Dados.Registro50Frete.Value;
        Seguro              := Dados.Registro50Seguro.Value;
        DespAcessoria       := Dados.Registro50DespAcessorias.Value;
        case Dados.Registro50Emitente.Value[1] of
          'P': TipoEmitente := tpeProprio;
          'T': TipoEmitente := tpeTerceiros;
        end;
        case Dados.Registro50Situacao.Value[1] of
          'N': Situacao := nfNormal;
          'S': Situacao := nfCancelado;
          'E': Situacao := nfExtNormal;
          'X': Situacao := nfExtCancelado;
        end;

        Dados.Registro50Aliq.First;
        while not(Dados.Registro50Aliq.Eof) do
        begin
          with Aliquotas.Add do
          begin
            Aliquota       := Dados.Registro50AliqAliquota.Value;
            CFOP           := Dados.Registro50AliqCFOP.Value;
            ValorTotal     := Dados.Registro50AliqValorTotal.Value;
            BaseICMS       := Dados.Registro50AliqBaseICMS.Value;
            ValorICMS      := Dados.Registro50AliqValorICMS.Value;
            IsentasNTribut := Dados.Registro50AliqIsenta_NTrib.Value;
            Outras         := Dados.Registro50AliqOutras.Value;
          end;
          Dados.Registro50Aliq.Next;
        end;

        Dados.Registro50Itens.First;
        while not(Dados.Registro50Itens.EOF) do
        begin
          with Registro54.Add do
          begin
            NumItem      := Dados.Registro50ItensNumItem.Value;
            CFOP         := Dados.Registro50ItensCFOP.Value;
            CST          := Dados.Registro50ItensCST.Value;
            CodProduto   := Dados.Registro50ItensCodProduto.Value;
            Quantidade   := Dados.Registro50ItensQuantidade.Value;
            ValorProduto := Dados.Registro50ItensValorProduto.Value;
            Desconto     := Dados.Registro50ItensDesconto.Value;
            BaseICMS     := Dados.Registro50ItensBaseICMS.Value;
            BaseICMSST   := Dados.Registro50ItensBaseICMSST.Value;
            IPI          := Dados.Registro50ItensValorIPI.Value;
            Aliquota     := Dados.Registro50ItensAliquota.Value;
          end;
          Dados.Registro50Itens.Next;
        end;
      end;
      Dados.Registro50.Next;
    end;
    
    Dados.Registro60M.First;
    while not (Dados.Registro60M.EOF) do
    begin
      with Registro60.Add do
      begin
        DataEmissao      := Dados.Registro60MDataEmissao.Value;
        NumSerieEquip    := Dados.Registro60MNumSerieEquipamento.Value;
        NumSequencial    := Dados.Registro60MNumeroECF.Value;
        Case Dados.Registro60MModeloDoc.Value of
          1: ModDocFiscal := modECF;
          2: ModDocFiscal := modPDV;
          3: ModDocFiscal := modMaqRegistradora;
        end;
        COOInicial       := Dados.Registro60MCOOInicial.Value;
        COOFinal         := Dados.Registro60MCOOFinal.Value;
        ContReducaoZ     := Dados.Registro60MContReducaoZ.Value;
        ContReinicioOper := Dados.Registro60MContReinicioOper.Value;
        VendaBruta       := Dados.Registro60MVendaBruta.Value;
        GTFinal          := Dados.Registro60MGTFinal.Value;

        Dados.Registro60A.First;
        while not(Dados.Registro60A.Eof) do
        begin
          with Registro60A.Add do
          begin
            SitTributaria  := Dados.Registro60ASitTributaria.Value;
            ValorAcumulado := Dados.Registro60AValorAcumulado.Value;
          end;
          Dados.Registro60A.Next
        end;

        Dados.Registro60I.First;
        while not(Dados.Registro60I.Eof) do
        begin
          with Registro60I.Add do
          begin
            COOCupom      := Dados.Registro60ICOOCupom.Value;
            NumItem       := Dados.Registro60INumItem.Value;
            CodProduto    := Dados.Registro60ICodProduto.Value;
            Quantidade    := Dados.Registro60IQuantidade.Value;
            ValorUnitario := Dados.Registro60IValorunitario.Value;
            BaseICMS      := Dados.Registro60IBaseICMS.Value;
            SitTributaria := Dados.Registro60ISitTributaria.Value;
          end;
          Dados.Registro60I.Next
        end;

        Dados.Registro60D.First;
        while not(Dados.Registro60D.Eof) do
        begin
          with Registro60D.Add do
          begin
            CodProduto     := Dados.Registro60DCodProduto.Value;
            QuantAcumulada := Dados.Registro60DQuantAcumulada.Value;
            ValorAcumulado := Dados.Registro60DValorAcumulado.Value;
            BaseCalcICMS   := Dados.Registro60DBaseICMSAcumulada.Value;
            SitTributaria  := Dados.Registro60DSitTributaria.Value;
          end;
          Dados.Registro60D.Next
        end;
      end;

      Dados.Registro60M.Next;
    end;

    Dados.Registro60R.First;
    while not(Dados.Registro60R.Eof) do
    begin
      with Registro60R.Add do
      begin
        Mes              := Dados.Registro60RMes.Value;
        ANo              := Dados.Registro60RAno.Value;
        CodProduto       := Dados.Registro60RCodProduto.Value;
        Quantidade       := Dados.Registro60RQuantidade.Value;
        ValorAcumProduto := Dados.Registro60RValorAcumulado.Value;
        ValorAcumICMS    := Dados.Registro60RValorAcumuladoICMS.Value;
        SitTributaria    := Dados.Registro60RSitTributaria.Value;
      end;
      Dados.Registro60R.Next;
    end;

    Dados.Registro61.First;
    while not(Dados.Registro61.EOF) do
    begin
      with Registro61.Add do
      begin
        DataEmissao  := Dados.Registro61DataEmissao.Value;
        ModeloDoc    := Dados.Registro61ModeloDoc.Value;
        Serie        := Dados.Registro61Serie.Value;
        SubSerie     := Dados.Registro61SubSerie.Value;
        NumInicial   := Dados.Registro61NumeroIncial.Value;
        NumFinal     := Dados.Registro61NumeroFinal.Value;
        ValorTotal   := Dados.Registro61ValorTotal.Value;
        BaseICMS     := Dados.Registro61BaseICMS.Value;
        IsentasNTrib := Dados.Registro61IsentasNTributadas.Value;
        Outras       := Dados.Registro61Outras.Value;
        Aliquota     := Dados.Registro61Aliquota.Value;
      end;
      Dados.Registro61.Next;
    end;

    Dados.Registro61R.First;
    while not(Dados.Registro61R.EOF) do
    begin
      with Registro61R.Add do
      begin
        Mes               := Dados.Registro61RMes.Value;
        Ano               := Dados.Registro61RAno.Value;
        CodProduto        := Dados.Registro61RCodProduto.Value;
        Quantidade        := Dados.Registro61RQuantidade.Value;
        ValorBrutoProduto := Dados.Registro61RValorBruto.Value;
        BaseCalcICMS      := Dados.Registro61RBaseCalcICMS.Value;
        Aliquota          := Dados.Registro61RAliquota.Value;
      end;
      Dados.Registro61R.Next;
    end;

    Dados.Registro74.First;
    while not(Dados.Registro74.Eof) do
    begin
      with Registro74.Add do
      begin
        TipoPosse      := tpo1;
        CNPJ           := Dados.EmpresaCNPJ.Value;
        InscEstadual   := Dados.EmpresaInscEstadual.Value;
        UF             := Dados.EmpresaUF.Value;
        DataInventario := Dados.Registro74DataInventario.Value;
        CodPRoduto     := Dados.Registro74CodProduto.Value;
        Quantidade     := Dados.Registro74Quantidade.Value;
        ValorTotal     := Dados.Registro74ValorTotal.Value;
      end;
      Dados.Registro74.Next;
    end;

    Dados.Registro75.First;
    while not(Dados.Registro75.Eof) do
    begin
      with Registro75.Add do
      begin
        ValidadeInicial := Dados.Registro75DtValidadeIni.Value;
        ValidadeFinal   := Dados.Registro75DtValidadeFim.Value;
        CodProduto      := Dados.Registro75CodProduto.Value;
        CodNCM          := Dados.Registro75CodNCM.Value;
        DescricaoProd   := Dados.Registro75Descricao.Value;
        Unidade         := Dados.Registro75Unidade.Value;
        AliquotaIPI     := Dados.Registro75AliquotaIPI.Value;
        AliquotaICMS    := Dados.Registro75AliquotaICMS.Value;
        ReducaoBaseCalc := Dados.Registro75ReducaoBaseCalc.Value;
        BaseICMSST      := Dados.Registro75BaseICMSST.Value;
      end;
      Dados.Registro75.Next;
    end;

    if SaveDialog.Execute then
    begin
      if GerarArquivo(SaveDialog.FileName) then
      begin
        Application.MessageBox(PAnsiChar(Format('Arquivo "%s" gerado com exito!', [SaveDialog.FileName])), 'Geração', MB_ICONERROR+MB_OK);
        Close;
      end
      else
      begin
        with TfrmRelatorioErro.Create(Self) do
          ShowModal;
      end;
    end;
  end;
end;

end.
