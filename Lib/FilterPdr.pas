unit FilterPdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, LblEffct, ExtCtrls, Buttons, Mask, DB, DBTables,
  PaiDeBrowses;

type
  TbrwFilter = class(TFrmParent)
    Button1: TButton;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblValor: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CampoBox: TComboBox;
    OpBox: TComboBox;
    EditValor: TMaskEdit;
    BtnAdic: TBitBtn;
    BtnClear: TBitBtn;
    MemoExpr: TMemo;
    BtnAnd: TBitBtn;
    BtnOr: TBitBtn;
    BtnAbrePar: TBitBtn;
    BtnFechaPar: TBitBtn;
    HistBox: TComboBox;
    Panel6: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CampoBoxChange(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure BtnAdicClick(Sender: TObject);
    procedure BtnAndClick(Sender: TObject);
    procedure BtnOrClick(Sender: TObject);
    procedure BtnAbreParClick(Sender: TObject);
    procedure BtnFechaParClick(Sender: TObject);
    procedure HistBoxChange(Sender: TObject);
    procedure MemoExprChange(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure OpBoxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    fldQuery   : TQuery;
    MybrwForm  : TbrwParent;
    CampoList   : TStringList;
    IndexExpr   : String;
    function DescOper  : String;
    function DescValue : String;
    procedure AndOrChange(IsEnabled : boolean);
    procedure AddHistorico(TextInd, IndexInd : String);
    procedure ResetHistBox;
  public
    { Public declarations }
    function Start(fchQuery : TQuery; brwForm : TbrwParent) : Boolean;
  end;

var
  brwFilter : TBrwFilter;

implementation

uses uMsgBox, uStringFunctions, uDataBaseFunctions, uVarianteFunctions;

const aOpFiltro : array[0..9] of String =
                  ('=', '<>', '>', '<', '>=', '<=', 'like', 'like', 'like', 'is null');

var
  aHistTab, aHistInd, aHistPos : Variant;
  TabPos      : integer;
  lFirst      : boolean = True;
  IsHistorico : boolean;

{$R *.DFM}

function TBrwFilter.Start(fchQuery : TQuery; brwForm : TbrwParent) : Boolean;
var
   i : byte;
begin
   fldQuery   := fchQuery;
   MybrwForm  := brwForm;

   { Preenche o CampoBox com os Campos que tem Tag > 0 e
     StringList associado se trocou de dataset }
   if True then
     begin
      { Reseta Boxes }
      CampoList.Clear;
      CampoBox.Clear;
      lFirst := False;

      // Seta os captions
      lblMenu.Caption    := brwForm.lblSubMenu.Caption;
      lblSubMenu.Caption := 'Filtering';

      // Apaga valores antigos
      BtnClearClick(nil);

      { Reseta HistBox }
      ResetHistBox;

      with fldQuery do
       for i := 0 to (FieldCount - 1) do
         if (Fields[i].Tag = 0) and not (Fields[i].Calculated) then
           begin
            CampoBox.Items.Add(Fields[i].DisplayName);
            CampoList.Add(Fields[i].FieldName);
           end;
     end;

   { Habilita/Desabilita HistBox }
   HistBox.Enabled := (HistBox.Items.Count > 0);

   { Seta a escolha inicial }
   CampoBox.ItemIndex := 0;
   OpBox.ItemIndex    := 0;
   EditValor.Text     := '';
   CampoBoxChange(CampoBox);

   ShowModal;

   Result := (ModalResult = mrOK);
end;

procedure TBrwFilter.FormCreate(Sender: TObject);
begin
   inherited;

   CampoList := TStringList.Create;
   { Cria VariantArrays }
   { HistTab -> guarda as tabelas guardadas no filtro }
   aHistTab := VarArrayCreate([0, 0], varOleStr);
   aHistTab[0] := '';
   { HistInd -> guarda os indices guardados nas tabelas}
   aHistInd := VarArrayCreate([0, 24, 0, 24, 0, 0], varOleStr);
   { HistPos -> guarda o último índice quardado no HistTab }
   aHistPos := VarArrayCreate([0, 0], varInteger);
   aHistPos[0] := 0;
end;

procedure TBrwFilter.FormDestroy(Sender: TObject);
begin
   CampoList.Free;
end;

procedure TBrwFilter.CampoBoxChange(Sender: TObject);
var
   MyField : TField;
begin
   MyField := fldQuery.FieldByName(CampoList.Strings[CampoBox.ItemIndex]);
   with EditValor do
   begin
     EditMask  := MyField.EditMask;
     if MyField.DataType = ftString then
        MaxLength := MyField.Size
     else
        MaxLength := 0;
     Text := '';
   end;
   // Seta a op para 0
   OpBox.ItemIndex := 0;
end;

procedure TBrwFilter.BtnClearClick(Sender: TObject);
begin
     MemoExpr.Clear;
     IndexExpr := '';
     AndOrChange(False);
     HistBox.ItemIndex := -1;
     IsHistorico := False;
end;

procedure TBrwFilter.BtnAdicClick(Sender: TObject);
begin
     if EditValor.Visible and
        (EditValor.Text = '') then
        raise Exception.create('Valor não pode estar vazio');

     { Adiciona ao Texto }
     IncMemoTxt(MemoExpr, ' ( ' +
                CampoBox.Items[CampoBox.ItemIndex] + ' ' +
                OpBox.Items[OpBox.ItemIndex] + ' ' +
                EditValor.EditText + ' )');
     { Adiciona ao Filtro }
     IncString(IndexExpr, ' ( ' +
               CampoList.Strings[CampoBox.ItemIndex] + ' ' +
               DescOper + ' ' + DescValue + ' )');

     AndOrChange(True);
end;

procedure TBrwFilter.BtnAndClick(Sender: TObject);
begin
     { Adiciona ao Texto }
     IncMemoTxt(MemoExpr, ' AND');
     { Adiciona ao Filtro }
     IncString(IndexExpr, ' AND');
     AndOrChange(False);
end;

procedure TBrwFilter.BtnOrClick(Sender: TObject);
begin
     { Adiciona ao Texto }
     IncMemoTxt(MemoExpr, ' OR');
     { Adiciona ao Filtro }
     IncString(IndexExpr, ' OR');
     AndOrChange(False);
end;

procedure TBrwFilter.BtnAbreParClick(Sender: TObject);
begin
     { Adiciona ao Texto }
     IncMemoTxt(MemoExpr, ' (');
     { Adiciona ao Filtro }
     IncString(IndexExpr, ' (');
     AndOrChange(False);
end;

procedure TBrwFilter.BtnFechaParClick(Sender: TObject);
var
   MemoText : String;
begin
  if MemoExpr.Text <> '' then
    begin
     if MemoExpr.Text[Length(MemoExpr.Text)] = '(' then
       begin
        MemoText := MemoExpr.Text;
        Delete(MemoText, Length(MemoText)-1 , 2);
        MemoExpr.Text := MemoText;
        Delete(IndexExpr, Length(IndexExpr)-1, 2);
       end
     else
       begin
        { Adiciona ao Texto }
        IncMemoTxt(MemoExpr, ' )');
        { Adiciona ao Filtro }
        IncString(IndexExpr, ' )');
       end;
    end;
end;

function TBrwFilter.DescOper : String;
begin
    Result := aOpFiltro[OpBox.ItemIndex];
end;

function TBrwFilter.DescValue : String;
var
   MyField : TField;
begin
   MyField := fldQuery.FieldByName(CampoList.Strings[CampoBox.ItemIndex]);
   // Teste de is null
   case OpBox.ItemIndex of
        9 : Result := '';   // Is Null
        8 : Result := Chr(39) + '%' + EditValor.Text +
                      '%' + Chr(39);  // Containing
        7 : Result := Chr(39) + '%' + EditValor.Text +
                      Chr(39); // ending
        6 : Result := Chr(39) + EditValor.Text + '%' +
                      Chr(39); // beginning
   else
      Result := ConvSQLValue(MyField, EditValor.Text);
   end;
end;

procedure TBrwFilter.AndOrChange(IsEnabled : boolean);
begin
     BtnAnd.Enabled  := IsEnabled;
     BtnOr.Enabled   := IsEnabled;
     BtnAdic.Enabled := not IsEnabled;
end;

procedure TBrwFilter.AddHistorico(TextInd, IndexInd : String);
begin
   if not IsHistorico then
     begin
      aHistInd[0, aHistPos[TabPos], TabPos] := TextInd;
      aHistInd[aHistPos[TabPos], 0, TabPos] := IndexInd;
      HistBox.Items.Add(TextInd);
      aHistPos[TabPos] := aHistPos[TabPos] + 1;
     end;
end;

procedure TBrwFilter.HistBoxChange(Sender: TObject);
begin
     if HistBox.ItemIndex > -1 then
       begin
        { Adiciona ao Texto e Expressao do indice }
        MemoExpr.Text := HistBox.Text;
        IndexExpr := aHistInd[HistBox.ItemIndex, 0, TabPos];
        AndOrChange(True);
        IsHistorico := True;
       end;
end;

procedure TBrwFilter.MemoExprChange(Sender: TObject);
begin
     IsHistorico := False;
end;

procedure TBrwFilter.ResetHistBox;
var
   i, TotPos : integer;
   lFound    : boolean;
begin
     lFound := False;
     HistBox.Clear;

     { Procura se tabela ja esta guardada }
{     for TabPos := 0 to VarHigh(aHistTab)-1 do
      begin
//       lFound := (aHistTab[TabPos] = MybrwForm.GetActualSQL);
       if lFound then Break;
      end;}

     if not lFound then
      begin
        TabPos := VarHigh(aHistTab);
        { seta o aHistTab com nova Tabela no filtro }
//        aHistTab[TabPos] := MybrwForm.OriginalSQL;
        Inc(TabPos);
        { aumenta Variant Arrays para próxima Tabela }
        VarArrayRedim(aHistTab, TabPos);
        VarArrayRedim(aHistInd, TabPos);
        VarArrayRedim(aHistPos, TabPos);
        Dec(TabPos);
      end
     else
      begin
        { coloca no HistBox os índices antigos }
        TotPos := aHistPos[TabPos];
        if TotPos > 0 then
         begin
           for i := 0 to TotPos - 1 do
             HistBox.Items.Add(aHistInd[0, i, TabPos]);
         end;
      end;
end;

procedure TbrwFilter.btCloseClick(Sender: TObject);
begin
  inherited;

  try
    with MybrwForm do
     begin
      WhereGenFilter := IndexExpr;
      if ExecBrowseSQL(True) = 0 then
        begin
         WhereGenFilter := '';
         MsgBox('Filter returned no rows', vbOkOnly + vbExclamation);
         RollBackSQL;
        end
      else
        Self.ModalResult := mrOK;
     end;

    { Adiciona ao Histórico }
    AddHistorico(MemoExpr.Text, IndexExpr);
  except
    on exception do
     begin
      MybrwForm.WhereGenFilter := '';
      MybrwForm.RollBackSQL;
      raise Exception.Create('Invalid filter expression');
     end;
  end;
end;

procedure TbrwFilter.OpBoxChange(Sender: TObject);
var
   IsVisible : boolean;
begin
  inherited;
  // teste de like
  if (OpBox.ItemIndex > 5) and (OpBox.ItemIndex < 9) and
     not (fldQuery.FieldByName(CampoList.Strings[CampoBox.ItemIndex]).DataType
          in [ftString, ftMemo]) then
  begin
       OpBox.ItemIndex := 0;
       raise exception.create('Operation not supported for this field type');
  end;

  IsVisible := not (OpBox.ItemIndex = 9);
  LblValor.Visible := IsVisible;
  EditValor.Visible := IsVisible;
end;

procedure TbrwFilter.Button1Click(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

end.
