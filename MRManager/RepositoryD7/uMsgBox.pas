unit uMsgBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

const
  vbOKOnly	         = 0;	// Display OK button only.
  vbOKCancel	         = 1;	// Display OK and Cancel buttons.
  vbAbortRetryIgnore     = 2;	// Display Abort, Retry, and Ignore buttons.
  vbYesNoCancel	         = 3;	// Display Yes, No, and Cancel buttons.
  vbYesNo	         = 4;	// Display Yes and No buttons.
  vbRetryCancel	         = 5;	// Display Retry and Cancel buttons.

  vbCritical	         = 16;	// Display Critical Message icon.
  vbQuestion	         = 32;	// Display Query icon.
  vbWaring               = 48;  // Display Warning Message icon.
  vbExclamation	         = 48;	// Display Warning Message icon.
  vbInformation	         = 64;	// Display Information Message icon.
  vbSuperCritical        = 80;  //Display Super Critical Message icon.

  vbDefaultButton1       = 512; // First button is default.
  vbDefaultButton2       = 256;	// Second button is default.
  vbDefaultButton3       = 0;	// Third button is default.

  vbOK	                 = 1;
  vbCancel	         = 2;
  vbAbort	         = 3;
  vbRetry	         = 4;
  vbIgnore	         = 5;
  vbYes	                 = 6;
  vbNo	                 = 7;

  TITLE_MAXWIDTH         = 449;
  MSG_MAXWIDTH           = 449;

  TITLEMSG_SPACING       = 7;

  HEIGTH_Adjust          = 80;
  WIDTH_Adjust           = 78;

  SCREEN_MinWidth        = 284;
  SCREEN_MinHeigth       = 125;

// MessageBox
procedure SetMsgBoxLand(IDLang:Integer);
function MsgBox(Titles : String; Option: Integer) : Integer;
function MsgBoxError(Titles : String; sError: String; Option: Integer) : Integer;

type
  TFrmMsgBox = class(TForm)
    Critico: TImage;
    Informacao: TImage;
    Alerta: TImage;
    Questao: TImage;
    MSG: TLabel;
    Titulo: TLabel;
    Panel1: TPanel;
    Button3: TButton;
    Button2: TButton;
    Button1: TButton;
    tmrBlink: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure tmrBlinkTimer(Sender: TObject);
  private
    { Private declarations }
    MyResult: Integer;
    Vez : Boolean;
  public
    { Public declarations }
    function Start(Titles : String; Option: Integer) : Integer;
end;

var
  FrmMsgBox: TFrmMsgBox;
  fIDLang : Integer;
  sCancel, sIgnore,
  sRepeat, sAbort,
  sNo, sYes : String;

implementation

uses xBase;

{$R *.DFM}

procedure SetMsgBoxLand(IDLang:Integer);
begin
  fIDLang := IDLang;

  Case fIDLang of
   //English
   1 : begin
       sCancel := '&Cancel';
       sIgnore := '&Ignore';
       sRepeat := '&Repeat';
       sAbort  := '&Abort';
       sNo     := '&No';
       sYes    := '&Yes';
       end;
   //Portuguese
   2 : begin
       sCancel := '&Cancelar';
       sIgnore := '&Ignorar';
       sRepeat := '&Repetir';
       sAbort  := '&Abortar';
       sNo     := '&Não';
       sYes    := '&Sim';
       end;
   //Spanish
   3 : begin
       sCancel := '&Cancele';
       sIgnore := '&Ignore';
       sRepeat := '&Repita';
       sAbort  := '&Aborte';
       sNo     := '&No';
       sYes    := '&Sí';
       end;
   //English
   else begin
       sCancel := '&Cancel';
       sIgnore := '&Ignore';
       sRepeat := '&Repeat';
       sAbort  := '&Abort';
       sNo     := '&No';
       sYes    := '&Yes';
       end;
  end;
  
end;

function MsgBox(Titles : String; Option: Integer) : Integer;
begin
  Result := TFrmMsgBox.Create(Application).Start(Titles, Option);
end;

function MsgBoxError(Titles : String; sError: String; Option: Integer) : Integer;
begin
  if FrmMsgBox = nil then
    FrmMsgBox := TFrmMsgBox.Create(Application);

  Result := FrmMsgBox.Start(Titles, Option);
  //Result := FrmMsgBox.Start(Titles, Option, sError);
end;

Function TFrmMsgBox.Start(Titles : String; Option: Integer) : Integer;
var
   DialogUnits : TPoint;
   MinWidthTitulo, MinWidthMsg, Icon, Buttons, DefaultButton    : Integer;
   IniLeft, WidthButton, MinHeightTitulo, MinHeightMsg, i, Cont : Integer;
   SubTitle                     : array[1..3] of String;
   Substr : String;
   TextRect: TRect;
begin
     // Separa a string Titles, separadas por '_'
     // 1o vem o titulo em negrito
     // 2o vem o titulo de baixo
     // 3o vem o caption da tela, se nao passado ele atribui o default

     SubStr := '';
     Cont   := 1;
     SubTitle[1] := '';
     SubTitle[2] := '';
     SubTitle[3] := '';
     for i := 1 to Length(Titles) do
       begin

         if (Titles[i] = '_') or (i = Length(Titles)) then
           begin
            if (i = Length(Titles)) then
               SubStr := SubStr + Titles[i];

            SubTitle[Cont] := SubStr;
            Inc(Cont);
            SubStr := '';
           end
         else
           begin
            SubStr := SubStr + Titles[i];
           end;
       end;

     Titulo.Caption   := SubTitle[1];
     Msg.Caption      := SubTitle[2];

     if SubTitle[3] = '' then
        Caption := Application.Title
     else
        Caption := SubTitle[3];

     DefaultButton    := Round(Option / 256) * 256;
     Option           := Option - DefaultButton;

     Icon             := round(Option / 16) * 16;
     Option           := Option - Icon;

     Buttons          := Option;

     Critico.Visible    := False;
     Questao.Visible    := False;
     Alerta.Visible     := False;
     Informacao.Visible := False;

     case Icon of
          vbCritical      : Critico.Visible    := True;
          vbSuperCritical : Critico.Visible    := True;
          vbQuestion      : Questao.Visible    := True;
          vbExclamation   : Alerta.Visible     := True;
          vbInformation   : Informacao.Visible := True;
     end;

     case Buttons of
          vbOKOnly           :
            begin
                 Button1.Visible    := True;
                 Button1.Tag        := vbOK;
                 Button1.Caption    := '&Ok';
                 Button1.Cancel     := True;

                 Button2.Visible    := False;
                 Button3.Visible    := False;
            end;

          vbOKCancel         :
            begin
                 Button1.Visible    := True;
                 Button1.Tag        := vbCancel;
                 Button1.Caption    := sCancel;
                 Button1.Cancel     := True;

                 Button2.Visible    := True;
                 Button2.Tag        := vbOK;
                 Button2.Caption    := '&Ok';
                 Button2.Cancel     := False;

                 Button3.Visible    := False;
            end;

          vbAbortRetryIgnore :
            begin
                 Button1.Visible := True;
                 Button1.Tag     := vbIgnore;
                 Button1.Caption := sIgnore;
                 Button1.Cancel  := True;

                 Button2.Visible := True;
                 Button2.Tag     := vbRetry;
                 Button2.Caption := sRepeat;
                 Button2.Cancel  := False;

                 Button3.Visible := True;
                 Button3.Tag     := vbAbort;
                 Button3.Caption := sAbort;
                 Button3.Cancel  := False;
            end;

          vbYesNoCancel      :
            begin
                 Button1.Visible := True;
                 Button1.Tag     := vbCancel;
                 Button1.Caption := sCancel;
                 Button1.Cancel  := True;

                 Button2.Visible := True;
                 Button2.Tag     := vbNo;
                 Button2.Caption := sNo;
                 Button2.Cancel  := False;

                 Button3.Visible := True;
                 Button3.Tag     := vbYes;
                 Button3.Caption := sYes;
                 Button2.Cancel  := False;
            end;

          vbYesNo            :
            begin
                 Button1.Visible := True;
                 Button1.Tag     := vbNo;
                 Button1.Caption := sNo;
                 Button1.Cancel  := True;

                 Button2.Visible := True;
                 Button2.Tag     := vbYes;
                 Button2.Caption := sYes;
                 Button2.Cancel  := False;

                 Button3.Visible := False;
            end;

          vbRetryCancel      :
            begin
                 Button1.Visible := True;
                 Button1.Tag     := vbCancel;
                 Button1.Caption := sCancel;
                 Button1.Cancel  := True;

                 Button2.Visible := True;
                 Button2.Tag     := vbRetry;
                 Button2.Caption := sRepeat;
                 Button2.Cancel  := False;

                 Button3.Visible := False;
            end;
     end;

     // define o botao default
     case DefaultButton of
          vbDefaultButton1 : begin
                              Button1.Default := True;
                              ActiveControl   := Button1;
                             end;
          vbDefaultButton2 : if Button2.Visible then
                               begin
                                Button2.Default := True;
                                ActiveControl   := Button2;
                               end
                             else
                               begin
                                Button1.Default := True;
                                ActiveControl   := Button1;
                               end;
          vbDefaultButton3 : if Button3.Visible then
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

     // Define se existe titulo, ou mensagem
     Titulo.Visible := not (Titulo.caption = '');
     Msg.Visible    := not (Msg.caption = '');

     // Define a largura e altura da tela
     if Titulo.Visible then
       begin
         Canvas.Font := Titulo.Font;
         SetRect(TextRect, 0, 0, TITLE_MAXWIDTH, 0);
         DrawText(Canvas.Handle, PChar(Titulo.caption), Length(Titulo.caption), TextRect,
                  DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK);

         MinWidthTitulo  := textrect.right-textrect.left;
         MinHeightTitulo := textrect.bottom-textrect.top;

         // Define o Top da Msg
         Msg.Top := Titulo.Top + MinHeightTitulo + TITLEMSG_SPACING;
         Titulo.Height := MinHeightTitulo;

         Inc(MinWidthTitulo, WIDTH_Adjust);
       end
     else
       begin
         MinWidthTitulo  := 0;
         MinHeightTitulo := 0;
         Msg.Top := Titulo.Top;
       end;

     if Msg.Visible then
       begin
         Canvas.Font := Msg.Font;
         SetRect(TextRect, 0, 0, MSG_MAXWIDTH, 0);
         DrawText(Canvas.Handle, PChar(Msg.caption), Length(Msg.caption), TextRect,
                  DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK);

         MinWidthMsg  := textrect.right-textrect.left;
         MinHeightMsg := textrect.bottom - textrect.top + 20;

         Msg.Height := MinHeightMsg;

         Inc(MinWidthMsg, WIDTH_Adjust);

         Msg.BringToFront;
       end
     else
       begin
         MinWidthMsg  := 0;
         MinHeightMsg := 0;
       end;

     Width := Max(SCREEN_MinWidth, MinWidthTitulo);
     Width := Max(Width, MinWidthMsg);

     Height := Max(SCREEN_MinHeigth, MinHeightTitulo + MinHeightMsg + HEIGTH_Adjust);

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

     // LIga o timer que pisca
     if (Icon = vbSuperCritical) then
       begin
         tmrBlink.Enabled := True;
         Self.Color := clRed;
       end
     else
       begin
         tmrBlink.Enabled := False;
         Self.Color := clBtnFace;
       end;


     ShowModal;
     // Desliga o timer que pisca
     tmrBlink.Enabled := False;
     Result := MyResult;

end;

procedure TFrmMsgBox.Button1Click(Sender: TObject);
begin
     MyResult := TButton(Sender).Tag;
     Close;
end;

procedure TFrmMsgBox.tmrBlinkTimer(Sender: TObject);
begin
   if Vez then
     begin
       Self.Color := clRed;
     end
   else
     begin
       Self.Color := clBtnFace;
     end;
   Vez := not Vez;
end;

end.
