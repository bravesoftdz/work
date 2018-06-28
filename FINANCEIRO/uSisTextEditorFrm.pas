unit uSisTextEditorFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, ImgList, dxBar, Buttons, ExtCtrls, StdCtrls, jpeg,
  ComCtrls, dxBarExtItems, RichEdit, siComp, siLangRT;

type
  TsisTextEditorFrm = class(TParentFixedFrm)
    Editor: TRichEdit;
    btnNew: TdxBarButton;
    btnOpen: TdxBarButton;
    btnSave: TdxBarButton;
    btnPrint: TdxBarButton;
    btnCopy: TdxBarButton;
    btnCut: TdxBarButton;
    btnPaste: TdxBarButton;
    cbxTextColor: TdxBarColorCombo;
    cbxSize: TdxBarCombo;
    btnBold: TdxBarButton;
    btnItalic: TdxBarButton;
    btnUnderline: TdxBarButton;
    btnAlignLeft: TdxBarButton;
    btnAlignCenter: TdxBarButton;
    btnAlignRight: TdxBarButton;
    btnBullets: TdxBarButton;
    cbxFontName: TdxBarFontNameCombo;
    lbPos: TLabel;
    btnClear: TdxBarButton;
    btnUndo: TdxBarButton;
    FindDialog: TFindDialog;
    FontDialog: TFontDialog;
    ReplaceDialog: TReplaceDialog;
    btnReplace: TdxBarButton;
    btnFind: TdxBarButton;
    btnSelectAll: TdxBarButton;
    procedure EditorSelectionChange(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure cbxFontNameChange(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure cbxFontNameClick(Sender: TObject);
    procedure cbxTextColorChange(Sender: TObject);
    procedure cbxTextColorClick(Sender: TObject);
    procedure btnBoldClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure btnAlignLeftClick(Sender: TObject);
    procedure btnAlignCenterClick(Sender: TObject);
    procedure btnAlignRightClick(Sender: TObject);
    procedure btnBulletsClick(Sender: TObject);
    procedure cbxSizeChange(Sender: TObject);
    procedure cbxSizeClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
  private
    { Private declarations }
    FUpdating: Boolean;
    procedure SetModified(Value: Boolean);

  public
    procedure Start(Parametro: String; UserRights: String; Suggestion : TStringList); virtual;
    { Public declarations }
  end;

var
  sisTextEditorFrm: TsisTextEditorFrm;

implementation

{$R *.DFM}

procedure TsisTextEditorFrm.Start(Parametro: String; UserRights: String; Suggestion : TStringList);
begin
  //init

  Show;

end;

procedure TsisTextEditorFrm.EditorSelectionChange(Sender: TObject);
var Col, Row : integer;
begin
  inherited;

  Row := SendMessage(Editor.Handle, EM_LINEFROMCHAR, Editor.SelStart, 0);
  Col := Editor.SelStart - SendMessage(Editor.Handle, EM_LINEINDEX, Row, 0);

  with Editor, SelAttributes do
      begin
      FUpdating := True;

          try
             lbPos.Caption := Format('Line: %3d   Col: %3d', [1 + Row, 1 + Col]);

             btnCopy.Enabled   := SelLength > 0;
             btnCut.Enabled    := btnCopy.Enabled;
             btnClear.Enabled  := btnCopy.Enabled;
             btnPaste.Enabled  := ((SendMessage(Editor.Handle, EM_CANPASTE, 0, 0) <> 0) and btnSave.Enabled);

             cbxSize.Text      := IntToStr(Size);
             cbxFontName.Text  := Name;

             btnBold.Down      := fsBold in Style;
             btnItalic.Down    := fsItalic in Style;
             btnUnderline.Down := fsUnderline in Style;

             btnBullets.Down   := Boolean(Paragraph.Numbering);

             case Ord(Paragraph.Alignment) of
               0: btnAlignLeft.Down   := True;
               1: btnAlignRight.Down  := True;
               2: btnAlignCenter.Down := True;
             end;

             cbxTextColor.Color := Editor.SelAttributes.Color;

          finally
            FUpdating := False;
          end;
     end;


end;

procedure TsisTextEditorFrm.EditorChange(Sender: TObject);
begin
  inherited;

  if Editor = nil then
     Exit;

  Editor.OnSelectionChange(Editor);

  SetModified(Editor.Modified);

  btnUndo.Caption := '&Undo';
  btnUndo.Enabled := SendMessage(Editor.Handle, EM_CANUNDO, 0, 0) <> 0;

end;

procedure TsisTextEditorFrm.SetModified(Value: Boolean);
begin

  Editor.Modified := Value;

  {if Value then
     StatusBar.Panels[1].Text := 'Modified'
  else
     StatusBar.Panels[1].Text := '';

  if FileName <> '' then
     dxBarButtonSave.Enabled := Value;}

end;


procedure TsisTextEditorFrm.cbxFontNameChange(Sender: TObject);
begin
  inherited;

  if not FUpdating then
     Editor.SelAttributes.Name := cbxFontName.Text;

end;

procedure TsisTextEditorFrm.FindDialogFind(Sender: TObject);
var
  StartPos, FindLength, FoundAt: Integer;
  Flags: TSearchTypes;
  P: TPoint;
  CaretR, R, IntersectR: TRect;
begin

  with Editor, TFindDialog(Sender) do
      begin
      if frDown in Options then
         begin
         if SelLength = 0 then
            StartPos := SelStart
         else
            StartPos := SelStart + SelLength;
         FindLength := Length(Text) - StartPos;
         end
      else
         begin
         StartPos := SelStart;
         FindLength := -StartPos;
         end;

     Flags := [];

    if frMatchCase in Options then
       Include(Flags, stMatchCase);

    if frWholeWord in Options then
       Include(Flags, stWholeWord);

    Screen.Cursor := crHourglass;

    FoundAt := Editor.FindText(FindText, StartPos, FindLength, Flags);

    if not (frReplaceAll in Options) then
       Screen.Cursor := crDefault;

    if FoundAt > -1 then
       if frReplaceAll in Options then
          begin
          SelStart := FoundAt;
          SelLength := Length(FindText);
          end
       else
          begin
          SetFocus;
          SelStart := FoundAt;
          SelLength := Length(FindText);

          GetCaretPos(P);
          P := ClientToScreen(P);
          CaretR := Rect(P.X, P.Y, P.X + 2, P.Y + 20);
          GetWindowRect(Handle, R);
          if IntersectRect(IntersectR, CaretR, R) then
              if P.Y < Screen.Height div 2 then
                 Top := P.Y + 40
              else
                 Top := P.Y - (R.Bottom - R.Top + 20);
          end
     else
       if not (frReplaceAll in Options) then
         Application.MessageBox('Text not found', 'Information', MB_ICONINFORMATION);
    end;
end;

procedure TsisTextEditorFrm.cbxFontNameClick(Sender: TObject);
begin
  inherited;

  FontDialog.Font.Assign(Editor.SelAttributes);

  if FontDialog.Execute then
    Editor.SelAttributes.Assign(FontDialog.Font);

end;

procedure TsisTextEditorFrm.cbxTextColorChange(Sender: TObject);
begin
  inherited;

    if not FUpdating then
       Editor.SelAttributes.Color := cbxTextColor.Color;

end;

procedure TsisTextEditorFrm.cbxTextColorClick(Sender: TObject);
begin
  inherited;

  FontDialog.Font.Assign(Editor.SelAttributes);

  if FontDialog.Execute then
     Editor.SelAttributes.Assign(FontDialog.Font);

end;

procedure TsisTextEditorFrm.btnBoldClick(Sender: TObject);
begin
  inherited;

  with Editor.SelAttributes do
    if btnBold.Down then
      Style := Style + [fsBold]
    else
      Style := Style - [fsBold];

end;

procedure TsisTextEditorFrm.btnItalicClick(Sender: TObject);
begin
  inherited;

  with Editor.SelAttributes do
     if btnItalic.Down then
        Style := Style + [fsItalic]
     else
        Style := Style - [fsItalic];

end;

procedure TsisTextEditorFrm.btnUnderlineClick(Sender: TObject);
begin
  inherited;

  with Editor.SelAttributes do
    if btnUnderline.Down then
       Style := Style + [fsUnderline]
    else
       Style := Style - [fsUnderline];


end;

procedure TsisTextEditorFrm.btnAlignLeftClick(Sender: TObject);
begin
  inherited;

   if TdxBarButton(Sender).Down then
      Editor.Paragraph.Alignment := TAlignment(0)
    else
      Editor.Paragraph.Alignment := taLeftJustify;

end;

procedure TsisTextEditorFrm.btnAlignCenterClick(Sender: TObject);
begin
  inherited;

    if TdxBarButton(Sender).Down then
       Editor.Paragraph.Alignment := TAlignment(2)
    else
       Editor.Paragraph.Alignment := taLeftJustify;

end;

procedure TsisTextEditorFrm.btnAlignRightClick(Sender: TObject);
begin
  inherited;

  if TdxBarButton(Sender).Down then
     Editor.Paragraph.Alignment := TAlignment(1)
   else
     Editor.Paragraph.Alignment := taLeftJustify;

end;

procedure TsisTextEditorFrm.btnBulletsClick(Sender: TObject);
begin
  inherited;

  Editor.Paragraph.Numbering := TNumberingStyle(btnBullets.Down);

end;

procedure TsisTextEditorFrm.cbxSizeChange(Sender: TObject);
begin
  inherited;

    if not FUpdating then
       Editor.SelAttributes.Size := StrToInt(cbxSize.Text);

end;

procedure TsisTextEditorFrm.cbxSizeClick(Sender: TObject);
begin
  inherited;

   FontDialog.Font.Assign(Editor.SelAttributes);

   if FontDialog.Execute then
      Editor.SelAttributes.Assign(FontDialog.Font);

end;

procedure TsisTextEditorFrm.btnUndoClick(Sender: TObject);
begin
  inherited;
  SendMessage(Editor.Handle, EM_UNDO, 0, 0);
end;

procedure TsisTextEditorFrm.btnClearClick(Sender: TObject);
begin
  inherited;

  Editor.ClearSelection; 

end;

procedure TsisTextEditorFrm.ReplaceDialogReplace(Sender: TObject);
var
  ReplacedCount, OldSelStart, PrevSelStart: Integer;
  S: string;
begin
  inherited;

  with Editor, TReplaceDialog(Sender) do
      begin
      ReplacedCount := 0;
      OldSelStart := SelStart;

      if frReplaceAll in Options then
         Screen.Cursor := crHourglass;

      repeat
        if (SelLength > 0) and ((SelText = FindText) or
           (not (frMatchCase in Options) and
           (AnsiUpperCase(SelText) = AnsiUpperCase(FindText)))) then
            begin
            SelText := ReplaceText;
            Inc(ReplacedCount);
            end;

        PrevSelStart := SelStart;
        FindDialogFind(Sender);

        until not (frReplaceAll in Options) or (SelStart = PrevSelStart);

        if frReplaceAll in Options then
           begin
           Screen.Cursor := crDefault;
           if ReplacedCount = 0 then
              S := 'Text not found'
           else
              begin
              SelStart := OldSelStart;
              S := Format('Replace All', [ReplacedCount]);
              end;

          Application.MessageBox(PChar(S), 'Information',  MB_ICONINFORMATION);
        end;
      end;

end;

procedure TsisTextEditorFrm.btnReplaceClick(Sender: TObject);
begin
  inherited;

  Editor.SelLength := 0;
  ReplaceDialog.Execute;

end;

procedure TsisTextEditorFrm.btnFindClick(Sender: TObject);
begin
  inherited;

  Editor.SelLength := 0;
  FindDialog.Execute;

end;

procedure TsisTextEditorFrm.btnSelectAllClick(Sender: TObject);
begin
  inherited;

  Editor.SelectAll; 

end;

end.
