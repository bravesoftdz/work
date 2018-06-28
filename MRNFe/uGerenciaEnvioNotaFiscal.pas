unit uGerenciaEnvioNotaFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    Button2: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button5: TButton;
    Button7: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    grdNF: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses udmSQL;

{$R *.dfm}

end.
