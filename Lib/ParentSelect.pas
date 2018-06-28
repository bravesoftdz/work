unit ParentSelect;

{
  Seleção de dados automatizada.
  Cada Panel do pnlMainSelect corresponde a uma
  determinada seleção. Cada um deles possue Tag
  igual a posição do item selecionado no
  set TSelect. Retorna property SelList que e um
  StringList como resultado da seleção e Boolean se
  usuário deu OK
}

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs, PaideTodosGeral;

const MIN_HEIGHT = 135;
      DIF_HEIGHT = 30;

type
  TFchSelectParent = class(TFrmParentAll)
    pnlParent: TPanel;
    pnlParent3: TPanel;
    pnlParent4: TPanel;
    pnlParent2: TPanel;
    btClose: TButton;
    Button1: TButton;
    pnlMainSelect: TPanel;
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    LocalSel : TStringList;
    FRelSpecial : Boolean;
    FAuxValue   : String;
    procedure SetAllInvisible;
  protected
    procedure CheckValues; virtual;
  public
    { Public declarations }
    IndexSel : TStringList;
    function Select(Titulo : String;
                    aSelect : array of String) : Boolean;
    property AuxValue   : String  read FAuxValue   write FAuxValue;
    property RelSpecial : Boolean read FRelSpecial write FRelSpecial;
  end;

var
  FchSelectParent: TFchSelectParent;

implementation

{$R *.DFM}

uses xBase, DateBox, SuperCombo;

function TFchSelectParent.Select(Titulo : String;
                                 aSelect : array of String) : Boolean;
var
   i, j : byte;
   ContHeight : integer;
begin
  { seta o caption }
  Caption := 'Selecting - ' + Titulo;

  { Sera variáveis }
  ContHeight := 0;
  LocalSel.Clear;

  { Seta todos panels para Visible False }
  SetAllInvisible;

  { Seleciona os tipos de seleção }
  for i := Low(aSelect) to High(aSelect) do
   begin
    LocalSel.Add(aSelect[i]);
    with TPanel(FindComponent(aSelect[i])) do
     begin
       // Cuida da ordem que que aparecem na tela
       Inc(ContHeight, Height);
       Top := ContHeight - Height;
       Visible   := True;
       TabOrder  := i;
       { se for primeiro seta o foco inicial }
       if i = Low(aSelect) then
         for j := 0 to (ControlCount - 1) do
          if (Controls[j] is TWinControl) and
             (TWinControl(Controls[j]).TabOrder = 0) then
            begin
             ActiveControl := TWinControl(Controls[j]);
             Break;
            end;
     end;
   end;

  { Seta a altura fo form }
  Height := Max(ContHeight + DIF_HEIGHT, MIN_HEIGHT);

  Result := (ShowModal = mrOK);
end;

procedure TFchSelectParent.SetAllInvisible;
var
  i : byte;
begin
  with pnlMainSelect do
   for i := 0 to (ControlCount - 1) do
     if (Controls[i] is TPanel) then
        TPanel(Controls[i]).Visible := False;
end;

procedure TFchSelectParent.BtnOKClick(Sender: TObject);
var
  i, j : byte;
begin
  if (MessageDlg('Confirma seleção',
      mtConfirmation, mbOKCancel, 0) = mrCancel) then
      Exit;

  { Retorna em IndexSel o texto da seleção }
  IndexSel.Clear;

  with LocalSel do
   for i := 0 to (Count - 1) do
     with TPanel(FindComponent(Strings[i])) do
       for j := 0 to (ControlCount - 1) do
         begin
           if (Controls[j] is TDateBox) then
              TDateBox(Controls[j]).Validate;
           if TWinControl(Controls[j]).TabOrder = 0 then
              if (Controls[j] is TCustomEdit) then
                IndexSel.Add(TCustomEdit(Controls[j]).Text)
              else if (Controls[j] is TRadioGroup) then
                IndexSel.Add(IntToStr(TRadioGroup(Controls[j]).ItemIndex))
              else if (Controls[j] is TSuperCombo) then
                IndexSel.Add(TSuperCombo(Controls[j]).LookUpValue);
         end;

  CheckValues;

  ModalResult := mrOk;
end;

procedure TFchSelectParent.FormCreate(Sender: TObject);
begin
  IndexSel    := TStringList.Create;
  LocalSel    := TStringList.Create;
  FRelSpecial := False;
end;

procedure TFchSelectParent.CheckValues;
begin
  { método para ser herdado }
end;





end.

