unit uVendItemD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFrmVendItemD = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVendItemD: TFrmVendItemD;
  sAliquota: String;

implementation

Uses uDM;

{$R *.DFM}

procedure TFrmVendItemD.Button1Click(Sender: TObject);
var sDesconto, sAcrescimo: String;
begin

    If RadioButton1.Checked = True Then Begin
       sDesconto  := '0';
       sAcrescimo := Edit5.Text;
    End;
    If RadioButton2.Checked = True Then Begin
       sAcrescimo := '0';
       sDesconto  := Edit5.Text;
    End;

    DM.EFiscal1.VendeItemDepartamento(Edit1.Text, Edit2.Text,sAliquota, Edit4.Text, Edit3.Text, sAcrescimo,
    sDesconto,Edit6.Text, Edit7.Text);
end;

// Verifica Alíquota

procedure TFrmVendItemD.ComboBox1Change(Sender: TObject);
begin
    If (ComboBox1.ItemIndex) = 0  Then Begin sAliquota := 'FF' End;
    If (ComboBox1.ItemIndex) = 1  Then Begin sAliquota := 'II' End;
    If (ComboBox1.ItemIndex) = 2  Then Begin sAliquota := 'NN' End;
    If (ComboBox1.ItemIndex) = 3  Then Begin sAliquota := '01' End;
    If (ComboBox1.ItemIndex) = 4  Then Begin sAliquota := '02' End;
    If (ComboBox1.ItemIndex) = 5  Then Begin sAliquota := '03' End;
    If (ComboBox1.ItemIndex) = 6  Then Begin sAliquota := '04' End;
    If (ComboBox1.ItemIndex) = 7  Then Begin sAliquota := '05' End;
    If (ComboBox1.ItemIndex) = 8  Then Begin sAliquota := '06' End;
    If (ComboBox1.ItemIndex) = 9  Then Begin sAliquota := '07' End;
    If (ComboBox1.ItemIndex) = 10 Then Begin sAliquota := '08' End;
    If (ComboBox1.ItemIndex) = 11 Then Begin sAliquota := '09' End;
    If (ComboBox1.ItemIndex) = 12 Then Begin sAliquota := '10' End;
    If (ComboBox1.ItemIndex) = 13 Then Begin sAliquota := '11' End;
    If (ComboBox1.ItemIndex) = 14 Then Begin sAliquota := '12' End;
    If (ComboBox1.ItemIndex) = 15 Then Begin sAliquota := '13' End;
    If (ComboBox1.ItemIndex) = 16 Then Begin sAliquota := '14' End;
    If (ComboBox1.ItemIndex) = 17 Then Begin sAliquota := '15' End;
    If (ComboBox1.ItemIndex) = 18 Then Begin sAliquota := '16' End;
end;

procedure TFrmVendItemD.Button2Click(Sender: TObject);
begin
Close;
end;

End.
