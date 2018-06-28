unit uVendItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,uSystemConst,uNumericFunctions;

type
  TFrmVendItem = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label5: TLabel;
    Edit4: TEdit;
    GroupBox3: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label6: TLabel;
    Edit5: TEdit;
    GroupBox4: TGroupBox;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label7: TLabel;
    Edit6: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVendItem: TFrmVendItem;
  sAliquota: String;
  sTipoQtde: String;
  iDecimal: String;
  sTipoDesconto: String;

implementation

Uses uDM;

{$R *.DFM}

procedure TFrmVendItem.Button1Click(Sender: TObject);
var sItem: string;
begin

    //  Verifica o Tipo da Quantidade:
    // 'I' para Inteira ou 'F' para Fracionária

    If RadioButton1.Checked = True Then Begin sTipoQtde := 'I' End;
    If RadioButton2.Checked = True Then Begin sTipoQtde := 'F' End;

    // Verifica o Tipo de Decimal:
    // 2 para duas casas ou 3 para três casas

    If RadioButton3.Checked = True Then Begin iDecimal := '2' End;
    If RadioButton4.Checked = True Then Begin iDecimal := '3' End;

    // Verifica o Tipo de Desconto:
    // '%' para percentual ou '$' para valor

    If RadioButton5.Checked = True Then Begin sTipoDesconto := '%' End;
    If RadioButton6.Checked = True Then Begin sTipoDesconto := '$' End;

        //Format item
        sItem :=  FISCAL_ITEM_COD         + Edit1.Text+ ';' + //IDModel
                  FISCAL_ITEM_DESCRIP     + Edit2.Text+ ';' + //Descricao
                  FISCAL_ITEM_ALIQ        + Edit3.Text+ ';' + //Tributo - nome da Taxa
                  FISCAL_ITEM_QTY         + Edit4.Text+ ';' + //Qty
                  FISCAL_ITEM_VALOR_UNIT  + Edit5.Text+ ';' + //Valor
                  FISCAL_ITEM_VALOR_DESC  + Edit6.Text+ ';' + //Desconto
                  FISCAL_ITEM_VALOR_TOTAL + MyFormatCur(StrToInt(Edit4.Text)*StrToCurr(Edit5.Text),DM.fModuloFiscal.Decimal) + ';' + //Valor total
                  FISCAL_ITEM_POSITION    + '1;' + //Posicao do item no grid
                  FISCAL_ITEM_TIPO_QTY    + sTipoQtde    +';' + // 'I' para Inteira ou 'F' para Fracionária
                  FISCAL_ITEM_CASA_DEC    + iDecimal     +';' + // iDecimal := 2
                  FISCAL_ITEM_TIPO_DESC   + sTipoDesconto+';' ; //% ou $

        //Inserir item na impressora fiscal
        DM.EFiscal1.VendeItem(sItem);
end;

procedure TFrmVendItem.Edit4Change(Sender: TObject);
begin
    If RadioButton1.Checked = True Then Begin Edit3.MaxLength := 4; End;
    If RadioButton2.Checked = True Then Begin Edit3.MaxLength := 7; End;
end;

procedure TFrmVendItem.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TFrmVendItem.Edit6Change(Sender: TObject);
begin
    If RadioButton5.Checked = True Then Begin Edit5.MaxLength := 4; End;
    If RadioButton6.Checked = True Then Begin Edit5.MaxLength := 8; End;
end;


// Criação do Conjunto de Alíquotas. É usada a função RetornoAlíquotas para obter as alíquotas
// que estão programadas na impressora

procedure TFrmVendItem.FormCreate(Sender: TObject);
var cAliquotas, cAliq, cVerCaracter, cCompleto: String;
      iConta: Integer;
begin

     for iConta := 1 to 79 do begin cAliquotas := cAliquotas + ' ' end;
     DM.EFiscal1.RetornoAliquotas( cAliquotas );

     for iConta := 1 to Length( Trim( cAliquotas ) ) do begin
         cVerCaracter := Copy( cAliquotas, iConta, 1 );
         if cVerCaracter <> ',' then begin
            cAliq := cAliq + cVerCaracter;
         end else begin
            cCompleto := cCompleto + cAliq + #13;
         end;
     end;         

end;


end.
