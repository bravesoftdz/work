unit mrMsgBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

const
  vbOKOnly	         = 0;	  // Display OK button only.
  vbOKCancel	       = 1;	  // Display OK and Cancel buttons.
  vbAbortRetryIgnore = 2;	  // Display Abort, Retry, and Ignore buttons.
  vbYesNoCancel	     = 3;	  // Display Yes, No, and Cancel buttons.
  vbYesNo	           = 4;	  // Display Yes and No buttons.
  vbRetryCancel	     = 5;	  // Display Retry and Cancel buttons.

  vbCritical	       = 16;	// Display Critical Message icon.
  vbQuestion	       = 32;	// Display Query icon.
  vbWaring           = 48;  // Display Warning Message icon.
  vbExclamation	     = 48;	// Display Warning Message icon.
  vbInformation	     = 64;	// Display Information Message icon.

  vbDefaultButton1   = 512; // First button is default.
  vbDefaultButton2   = 256;	// Second button is default.
  vbDefaultButton3   = 0; 	// Third button is default.

  vbOK	             = 1;
  vbCancel	         = 2;
  vbAbort	           = 3;
  vbRetry	           = 4;
  vbIgnore	         = 5;
  vbYes	             = 6;
  vbNo	             = 7;

  BUTTON_HEIGHT      = 79;

// MessageBox
function MsgBox(Titles : String; Option: Integer; ErrorMsg : String = '') : Integer;
function MsgBoxError(Titles : String; sError: String; Option: Integer) : Integer;

type
  TmrMsgBoxFrm = class(TForm)
    Critico: TImage;
    Informacao: TImage;
    Alerta: TImage;
    Questao: TImage;
    lblExplanation: TLabel;
    lblTitle: TLabel;
    Button3: TButton;
    Button2: TButton;
    Button1: TButton;
    Image1: TImage;
    mmError: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    MyResult: Integer;
  public
    function Start(Titles : String; Option: Integer; sError: String) : Integer;
end;

var
  mrMsgBoxFrm: TmrMsgBoxFrm;

implementation

uses uStringFunctions, XBASE;

{$R *.DFM}

function MsgBox(Titles : String; Option: Integer; ErrorMsg : String) : Integer;
begin
  if mrMsgBoxFrm = nil then
    mrMsgBoxFrm := TmrMsgBoxFrm.Create(Application);

  Result := mrMsgBoxFrm.Start(Titles, Option, ErrorMsg);
end;

function MsgBoxError(Titles : String; sError: String; Option: Integer) : Integer;
begin
  if mrMsgBoxFrm = nil then
    mrMsgBoxFrm := TmrMsgBoxFrm.Create(Application);

  Result := mrMsgBoxFrm.Start(Titles, Option, sError);
end;

function TmrMsgBoxFrm.Start(Titles : String; Option: Integer; sError: String) : Integer;
var
  DialogUnits : TPoint;
  MinWidthTitulo, MinWidthMsg, Icon, Buttons, DefaultButton: Integer;
  IniLeft, WidthButton, MinHeightTitulo, MinHeightMsg, i, Cont: Integer;
  SubTitle: array[1..3] of String;
  Substr : String;
  s, sTitle, sExplanation, sCaption: String;
  TextRect: TRect;
begin
  // Primeiro separo as partes do titles
  i := POS('->', Titles);
  if i = 0 then
  begin
    // Só tem uma parte
    sTitle := Titles;
  end
  else
  begin
    // Tem mais de uma, separo a primeira
    sTitle := LeftStr(Titles, i-1);
    Titles := Copy(Titles, i+1, Length(Titles));

    // Testo se tem outra parte
    i := POS('->', Titles);
    if i = 0 then
    begin
      // Não tem outra parte
      sExplanation := Titles;
    end
    else
    begin
      // Tem mais, o cation
      sExplanation := LeftStr(Titles, i-1);
      sCaption := Copy(Titles, i, Length(Titles));
    end;
  end;

  // Agora que ja esta tudo separado, vou alimento os labels
  lblTitle.Caption := sTitle;
  lblExplanation.Caption := sExplanation;
  if sCaption <> '' then
    Self.Caption := sCaption
  else
    Self.Caption := Application.Title;

  // Especial para msg de erros
  mmError.Visible := (sError <> '');
  mmError.Text := sError;

  // Tenho que descobrir o tamanho ideal do form e seta-lo.
  // Width
  with lblTitle do
  begin
    Canvas.Font := lblTitle.Font;
    i := (BUTTON_HEIGHT * 2) + Canvas.TextWidth(sTitle);
  end;

  if i > 480 then
    Self.Width := 480
  else
    Self.Width := i;

  // Height
  if sError <> '' then
  begin
    Self.Height := 344;
    mmError.Height := 147;
    mmError.Top := 120;
  end
  else
  begin
    with lblExplanation do
    begin
      Canvas.Font := Font;
      i := Round(Canvas.TextWidth(sExplanation) / Width + 4);
      Self.Height := Top + (i * Canvas.TextHeight(sExplanation)) + BUTTON_HEIGHT;
    end;
  end;

  // Separo as Opcoes
  DefaultButton := Round(Option / 256) * 256;
  Option        := Option - DefaultButton;
  Icon          := round(Option / 16) * 16;
  Option        := Option - Icon;
  Buttons       := Option;

  // Mostro a imagem correta
  Critico.Visible    := False;
  Questao.Visible    := False;
  Alerta.Visible     := False;
  Informacao.Visible := False;

  case Icon of
    vbCritical   : Critico.Visible    := True;
    vbQuestion   : Questao.Visible    := True;
    vbExclamation: Alerta.Visible     := True;
    vbInformation: Informacao.Visible := True;
  end;

  // Mostro os botoes corretos
  case Buttons of
    vbOKOnly:
    begin
      Button1.Visible    := True;
      Button1.Tag        := vbOK;
      Button1.Caption    := '&Ok';
      Button1.Cancel     := True;

      Button2.Visible    := False;
      Button3.Visible    := False;
    end;

    vbOKCancel:
    begin
      Button1.Visible    := True;
      Button1.Tag        := vbCancel;
      Button1.Caption    := '&Cancel';
      Button1.Cancel     := True;

      Button2.Visible    := True;
      Button2.Tag        := vbOK;
      Button2.Caption    := '&Ok';
      Button2.Cancel     := False;

      Button3.Visible    := False;
    end;

    vbAbortRetryIgnore:
    begin
      Button1.Visible := True;
      Button1.Tag     := vbIgnore;
      Button1.Caption := '&Ignore';
      Button1.Cancel  := True;

      Button2.Visible := True;
      Button2.Tag     := vbRetry;
      Button2.Caption := '&Repeate';
      Button2.Cancel  := False;

      Button3.Visible := True;
      Button3.Tag     := vbAbort;
      Button3.Caption := '&Abort';
      Button3.Cancel  := False;
    end;

    vbYesNoCancel:
    begin
      Button1.Visible := True;
      Button1.Tag     := vbCancel;
      Button1.Caption := '&Cancel';
      Button1.Cancel  := True;

      Button2.Visible := True;
      Button2.Tag     := vbNo;
      Button2.Caption := '&No';
      Button2.Cancel  := False;

      Button3.Visible := True;
      Button3.Tag     := vbYes;
      Button3.Caption := '&Yes';
      Button2.Cancel  := False;
    end;

    vbYesNo:
    begin
      Button1.Visible := True;
      Button1.Tag     := vbNo;
      Button1.Caption := '&No';
      Button1.Cancel  := True;

      Button2.Visible := True;
      Button2.Tag     := vbYes;
      Button2.Caption := '&Yes';
      Button2.Cancel  := False;

      Button3.Visible := False;
    end;

    vbRetryCancel:
    begin
      Button1.Visible := True;
      Button1.Tag     := vbCancel;
      Button1.Caption := '&Cancel';
      Button1.Cancel  := True;

      Button2.Visible := True;
      Button2.Tag     := vbRetry;
      Button2.Caption := '&Repeate';
      Button2.Cancel  := False;

      Button3.Visible := False;
    end;
  end;

  // define o botao default
  case DefaultButton of
    vbDefaultButton1:
      begin
        Button1.Default := True;
        ActiveControl   := Button1;
      end;

    vbDefaultButton2:
      if Button2.Visible then
      begin
        Button2.Default := True;
        ActiveControl   := Button2;
      end
      else
      begin
        Button1.Default := True;
        ActiveControl   := Button1;
      end;

    vbDefaultButton3:
      if Button3.Visible then
      begin
        Button3.Default := True;
        ActiveControl   := Button3;
      end
      else
      begin
        if Button2.Visible then
        begin
          Button2.Default := True;
          ActiveControl   := Button2;
        end
        else
        begin
          Button1.Default := True;
          ActiveControl   := Button1;
        end;
      end;
  end;

   // define a Posicao dos botoes na tela
   WidthButton := 0;
   if Button1.Visible then
      Inc(WidthButton, Button1.Width);
   if Button2.Visible then
      Inc(WidthButton, Button2.Width + 3);
   if Button3.Visible then
      Inc(WidthButton, Button3.Width + 3);

   IniLeft := Round(Width/2) - Round(WidthButton/2);

   if Button3.Visible then
   begin
    Button3.Left := IniLeft;
    IniLeft      := IniLeft + Button3.Width + 3;
   end;
   if Button2.Visible then
   begin
    Button2.Left := IniLeft;
    IniLeft      := IniLeft + Button2.Width + 3;
   end;
   if Button1.Visible then
      Button1.Left := IniLeft;

   // Define a posicao que a janela aparecera
   Left := (Screen.Width div 2) - (Width div 2);
   Top  := (Screen.Height div 2) - (Height div 2);

   ShowModal;
   Result := MyResult;
end;

procedure TmrMsgBoxFrm.Button1Click(Sender: TObject);
begin
  MyResult := TButton(Sender).Tag;
  Close;
end;

end.
