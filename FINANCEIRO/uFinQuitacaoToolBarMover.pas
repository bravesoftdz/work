unit uFinQuitacaoToolBarMover;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, ToolWin, ImgList;

type
  TFinQuitacaoToolBarMover = class(TForm)
    Moving: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    SecondCaption: TLabel;
    ToolButton3: TToolButton;
    btLimpa: TToolButton;
    btRetira: TToolButton;
    Panel1: TPanel;
    procedure TButtonClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function FormHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sRecord,
    sForm,
    sIclude1,
    sIncludeAll,
    sRemove1,
    sRemoveAll : String;
    brwForm: TObject;

  public
    { Public declarations }

  end;

implementation

{$R *.DFM}

uses uFinLancamentoList, uFinQuitacaoMoverHelp, uDMGlobal;

procedure TFinQuitacaoToolBarMover.TButtonClick(Sender: TObject);
begin
  with TFinLancamentoList(Self.Owner) do
    begin
      case TButton(Sender).Tag of
        0: IncluiSelecionado;
        1: IncluiVisao;
        2: ExcluiTodos;
        3: ExcluiSelecionado;
      end;

      with quAQuitar do
        begin
          btLimpa.Enabled := not (EOF and BOF);
          btRetira.Enabled := not (EOF and BOF);
        end;
    end;
end;

procedure TFinQuitacaoToolBarMover.FormDeactivate(Sender: TObject);
begin
     SecondCaption.Color := clInactiveCaption;
     SecondCaption.Font.Color := clInactiveCaptionText;
end;

procedure TFinQuitacaoToolBarMover.FormActivate(Sender: TObject);
begin
     SecondCaption.Color := clActiveCaption;
     SecondCaption.Font.Color := clCaptionText;
end;

procedure TFinQuitacaoToolBarMover.FormShow(Sender: TObject);
var
   MyBo: Boolean;

begin
   with TFinLancamentoList(Self.Owner).quAQuitar do
      MyBo := not (EOF and BOF);

  btLimpa.Enabled := MyBo;
  btRetira.Enabled := MyBo;

end;

function TFinQuitacaoToolBarMover.FormHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
begin
   TFinLancamentoList(Self.Owner).FinQuitacaoMoverHelp.ShowModal;
end;

procedure TFinQuitacaoToolBarMover.FormCreate(Sender: TObject);
begin
  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sRecord     := 'Records to be paid';
           sForm       := 'Records';
           sIclude1    := 'Include highlighted invoice at records to be paid.';
           sIncludeAll := 'Include all invoices at records to be paid.';
           sRemove1    := 'Clear entire list to be paid.';
           sRemoveAll  := 'Clear highlighted invoice from records to be paid.';

           end;
    LANG_PORTUGUESE :
           begin
           sRecord     := 'Adicionar lançamento';
           sForm       := 'Registro';
           sIclude1    := 'Adicionar todos os registros selecionados.';
           sIncludeAll := 'Adicionar todos os registros.';
           sRemove1    := 'Limpar todos os registros';
           sRemoveAll  := 'Limpar os registros selecionados.';
           end;

    LANG_SPANISH :
           begin
           sRecord     := 'Records to be paid';
           sForm       := 'Records';
           sIclude1    := 'Include highlighted invoice at records to be paid.';
           sIncludeAll := 'Include all invoices at records to be paid.';
           sRemove1    := 'Clear entire list to be paid.';
           sRemoveAll  := 'Clear highlighted invoice from records to be paid.';
           end;
  end;

  SecondCaption.Caption := sRecord;
  Self.Caption          := sForm;
  ToolButton1.Hint      := sIclude1;
  ToolButton2.Hint      := sIncludeAll;
  btLimpa.Hint          := sRemove1;
  btRetira.Hint         := sRemoveAll;

end;

end.
