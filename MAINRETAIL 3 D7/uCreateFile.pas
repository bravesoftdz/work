unit uCreateFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, ExtCtrls, StdCtrls, Grids, PaiDeForms,
  Db, DBTables, PowerADOQuery, Mask, ADODb, siComp, siLangRT,
  siDialog, LblEffct;

type
  TFrmCreateFile = class(TFrmParentForms)
    Panel1: TPanel;
    Panel2: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    LbTotal: TLabel;
    Label2: TLabel;
    SbMoveDates: TSpeedButton;
    SbOpen: TSpeedButton;
    LbPath: TLabel;
    Label1: TLabel;
    PanelPO: TPanel;
    Label3: TLabel;
    IDVendor: TLabel;
    LbVendorName: TLabel;
    PBar: TProgressBar;
    StringGrid1: TStringGrid;
    OD: TsiOpenDialog;
    btClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SbOpenClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure SbMoveDatesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Lista : TStringList;
    sModel, sDesc, sCost : String;
    function RetirarErro(sTexto:String):String;
    procedure PreencherGrid;
  public
    { Public declarations }
    procedure Start(Query,SaveQuery:TPowerADOQuery; QueryComper:TADOQuery);
  end;

var
  FrmCreateFile: TFrmCreateFile;
  sFileName : string;
  quTemp, quSave : TPowerADOQuery;
  quComper : TADOQuery;

implementation

uses uFchCotation, uMsgBox, uMsgConstant, uDMGlobal, uDM;

{$R *.DFM}

function TFrmCreateFile.RetirarErro(sTexto:String):String;
var x,y:integer;
begin
x := 0;
y := Length(sTexto);
 While x <= y do
   begin
      If not (sTexto[x] in ['0'..'9','.',',']) then
         Delete(sTexto,x,1);
   inc(x);
   end;
 Result := sTexto;
end;

procedure TFrmCreateFile.Start(Query,SaveQuery:TPowerADOQuery; QueryComper:TADOQuery);
begin
  quTemp := Query;
  quSave := SaveQuery;
  quTemp.Open;
  quComper := QueryComper;
end;

procedure TFrmCreateFile.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sModel := 'Model';
           sDesc  := 'Description';
           sCost  := 'Cost Price';
           end;

     LANG_PORTUGUESE :
           begin
           sModel := 'Modelo';
           sDesc  := 'Descrição';
           sCost  := 'Preço de Custo';
           end;

     LANG_SPANISH :
           begin
           sModel := 'Modelo';
           sDesc  := 'Descripción';
           sCost  := 'Precio de Costo';
           end;
   end;


 LbPath.Caption := '';
 Label1.Visible := False;
 Lista := TStringList.Create;
 StringGrid1.Cells[0,0] := sModel;
 StringGrid1.Cells[1,0] := sDesc;
 StringGrid1.Cells[2,0] := sCost;


end;

procedure TFrmCreateFile.SbOpenClick(Sender: TObject);
begin
 OD.Execute;
 If OD.FileName <> '' then
    begin
    Lista.Clear;
    Lista.LoadFromFile(OD.FileName);
    PreencherGrid;
    LbPath.Caption := OD.FileName;
    Label1.Visible := true;
    //Botoes
    SbMoveDates.Enabled := True;
    PanelPO.Visible     := True;
    end;
end;

procedure TFrmCreateFile.btCloseClick(Sender: TObject);
begin
Close;
end;

procedure TFrmCreateFile.SbMoveDatesClick(Sender: TObject);
var
  x,y : integer;
begin
  //Passa os Params
  quSave.Parameters.ParamByName('IDCotacao').Value    := quTemp.Fields[2].AsInteger;
  quSave.Parameters.ParamByName('IDFornecedor').Value := StrToInt(IDVendor.Caption);
  //Abro a query
  quSave.Open;
  If quSave.RecordCount = 0 then
  begin
    MsgBox(MSG_CRT_QUOTE, vbCritical + vbOkOnly);
    exit;
  end;

  //ProccessBar
  PBar.Visible := True;
  PBar.Max := quSave.RecordCount;
  //First Register
  quComper.Open;

  Try
    qucomper.DisableControls;
    quSave.DisableControls;
    x := 1;

    While x <= quSave.RecordCount do
    begin
      //Copiar da Celula
      y := 1;
      quSave.First;
      quComper.First;

      While y <= quSave.RecordCount do
      begin
        If Trim(quComper.FieldByName('Model').AsString) = Trim(StringGrid1.Cells[0,x]) then
        begin
          quSave.Edit;

          try
            DecimalSeparator := '.';
            quSave.FieldByName('Cost').AsCurrency := StrToCurr(RetirarErro(Trim(StringGrid1.Cells[2,x])));
          except
            try
              DecimalSeparator := ',';
              quSave.FieldByName('Cost').AsCurrency := StrToCurr(RetirarErro(Trim(StringGrid1.Cells[2,x])));
            except
              MsgBox('erro', vbCritical + vbOkOnly);
              exit;
            end;
          end;

          quSave.Post;
          Break;
        end;
        inc(y);
        quComper.Next;
        quSave.Next;
      end;

      inc(x);
      PBar.StepBy(x);
    end;
  Finally
    //Botoes
    qucomper.EnableControls;
    quSave.EnableControls;
    Close;
  end;
end;

procedure TFrmCreateFile.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  quTemp.Close;
  quSave.Close;
  Lista.Free;
end;

procedure TFrmCreateFile.PreencherGrid;
Var
sCampo, sLines: String;
x, y : integer;
begin
  sLines := Lista.Text;
  y := 1;
  quComper.Open;
  StringGrid1.RowCount := quComper.RecordCount+1;
  //Nao esta pegando todos os regitros
  While y <= quComper.RecordCount do
     begin
     x := Pos('->', sLines)+2;
     If x = 2 then
        Break;
     sLines := Copy(sLines,x,length(sLines));
     StringGrid1.Cells[0,y] := Trim(Copy(sLines,0,(Pos('|', sLines)-1)));
     sLines := Copy(sLines,(Pos('|', sLines)+1),length(sLines));

     x := Pos('|', sLines);
     StringGrid1.Cells[1,y] := Trim(Copy(sLines,0,(Pos('|', sLines)-1)));
     sLines := Copy(sLines,(Pos('|', sLines)+1),length(sLines));

     x := Pos('|', sLines);
     StringGrid1.Cells[2,y] := RetirarErro(Trim(Copy(sLines,0,(Pos('|', sLines)-1))));
     sLines := Copy(sLines,(Pos('|', sLines)+1),length(sLines));

     inc(y);
     end;
   quComper.Close;
end;

end.
