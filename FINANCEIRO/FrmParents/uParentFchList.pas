unit uParentFchList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, Grids,FormConfig, Db, DBTables, Buttons, StdCtrls,
  ExtCtrls, BrowseConfig, ComCtrls, dxBar, dxCntner, dxTL,
  dxDBGrid, ImgList, dxDBCtrl, ADODB, PowerADOQuery, uDataBaseFunctions,
  siComp, siLangRT;

type
  TParentFchList = class(TParentFch)
    quFchBrw: TPowerADOQuery;
    dsFchBrw: TDataSource;
    FormBrwConfig: TBrowseConfig;
    pnlBottomAlign: TPanel;
    pnlRightSpace: TPanel;
    pnlLeftSpace: TPanel;
    PPageControl: TPageControl;
    tsBrowse: TTabSheet;
    pnlBrw: TPanel;
    pnlBrwCmd: TPanel;
    pnlBrwTitleTop: TPanel;
    pnlBrwTitle: TPanel;
    grbFchBrw: TdxDBGrid;
    pnlBrwTitleBotton: TPanel;
    pnlBrwEspacoEsquerdo: TPanel;
    ImgTrash: TImage;
    imgFolder: TImage;
    btFchBrwRemove: TSpeedButton;
    btFchBrwDetalhe: TSpeedButton;
    btFchBrwNovo: TSpeedButton;
    btFchBrwRestaura: TSpeedButton;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure btFchBrwNovoClick(Sender: TObject);
    procedure btFchBrwDetalheClick(Sender: TObject);
    procedure grbFchBrwDblClick(Sender: TObject);
    procedure quFchBrwAfterOpen(DataSet: TDataSet);
    procedure btFchBrwRemoveClick(Sender: TObject);
    procedure quFchBrwBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure imgFolderDblClick(Sender: TObject);
    procedure ImgTrashDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFchBrwRestauraClick(Sender: TObject);
    procedure grbFchBrwTopRowChanged(Sender: TObject);
    procedure dsFchBrwStateChange(Sender: TObject);
  private
    { Private declarations }

    OriginalTitleFontColor, OriginalTitleColor: Integer;

    OriginalBrwSQL: String;
    KeyField1, KeyField2: Integer;
    CorCinza    : Boolean;
    FirstFieldIndex: Integer;
    procedure SetBrwCommand;
    procedure ControlaFoco(ComFoco: Boolean);
    procedure SetPageControl(Pageindex: integer); override;
  protected
    FchBrwForm  : TParentFch;

    procedure OnBeforeDeleteItem; virtual;
    procedure FchListRefresh;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uDM, uMsgBox, uSQLFunctions, uSystemTypes, uMsgConstant;


procedure TParentFchList.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  quFchBrw.Requery;
  // Preenche os FilterFields, que são utilizados para a sugestão automatica
  // da chave extrangeira na ficha
  quFchBrw.FilterFields.Clear;
  quFchBrw.FilterValues.Clear;

  if quForm.Parameters.Count = 1 then
    begin
      quFchBrw.FilterFields.Add(quForm.Parameters.Items[0].Name);
      quFchBrw.FilterValues.Add(VarToStr(quForm.Parameters.Items[0].Value));
    end;

  if quForm.Parameters.Count = 2 then
    begin
      quFchBrw.FilterFields.Add(quForm.Parameters.Items[1].Name);
      quFchBrw.FilterValues.Add(VarToStr(quForm.Parameters.Items[1].Value));
    end;

  if quForm.Parameters.Count = 3 then
    begin
      quFchBrw.FilterFields.Add(quForm.Parameters.Items[2].Name);
      quFchBrw.FilterValues.Add(VarToStr(quForm.Parameters.Items[2].Value));
    end;

end;

procedure TParentFchList.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  with quFchBrw do
    if Active then
      Close;

end;

procedure TParentFchList.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FchBrwForm) then
     FreeAndNil(FchBrwForm);

  // Desfaz a mudança do pagecontrol
  if PPageControl.PageCount = 1 then
    begin
      PPageControl.Pages[0].Parent := PPageControl;
    end;

end;

procedure TParentFchList.btFchBrwNovoClick(Sender: TObject);
var
   ID1, ID2: String;

begin
  inherited;
  ID1 := '';
  ID2 := '';

  ControlaFoco(False);

  if FchBrwForm.Start(btInc, Self.quFchBrw, False, ID1, ID2, '', MyUserRights, grbFchBrw) then
    begin
      Self.TocaFicha;
    end;

  ControlaFoco(True);
end;

procedure TParentFchList.ControlaFoco(ComFoco: Boolean);
var
   i: integer;
begin
  if ComFoco then
    begin
      pnlPTitulo.Color := OriginalTitleColor;
      lblPTitulo.Font.Color := OriginalTitleFontColor;

      lblNavegacao.Color := cl3DLight;

     imgOn.Visible := True;
     imgOff.Visible := False;

    end
  else
    begin
      lblPTitulo.Font.Color := clSilver;
      pnlPTitulo.Color := clGray;

      lblNavegacao.ParentColor := True;

     imgOn.Visible := False;
     imgOff.Visible := True;

  end;
  btLoopInc.Enabled := ComFoco;

  // Deliga todos os botoes da barra
  for i := 0 to (ComponentCount -1) do
    begin
      if (Components[I] is TBitBtn) then
        begin
          TBitBtn(Components[i]).Enabled := ComFoco;
        end;

      if (Components[I] is TSpeedButton) then
        begin
          TSpeedButton(Components[i]).Enabled := ComFoco;
        end;
    end;

end;

procedure TParentFchList.btFchBrwDetalheClick(Sender: TObject);
var
   ID1, ID2: String;

begin
  inherited;
  ID1 := quFchBrw.Fields[0].AsString;
  ID2 := '';

  if FchBrwForm.Start(btAlt, Self.quFchBrw, False, ID1, ID2, '', MyUserRights, grbFchBrw) then
    begin
      Self.TocaFicha;
    end;
end;

procedure TParentFchList.grbFchBrwDblClick(Sender: TObject);
begin
  inherited;
  if btFchBrwDetalhe.Enabled then
    btFchBrwDetalheClick(nil);
end;

procedure TParentFchList.quFchBrwAfterOpen(DataSet: TDataSet);
begin
  inherited;
//  lblLinhas.Caption := ' ' + IntToStr(quFchBrw.RecordCount) + ' Linha(s)';
end;

procedure TParentFchList.btFchBrwRemoveClick(Sender: TObject);
var
  Ret         : Boolean;
  DeleteTable : String;
  aKeys       : Variant;
  MyFieldKey1, MyFieldKey2 : Integer;
  MyFieldKey1Name, MyFieldKey2Name : String;

begin
  Ret := False;

  DeleteTable := GetSQLFirstTableName(quFchBrw.CommandText);

  MyFieldKey1 := KeyField1;
  MyFieldKey1Name := quFchBrw.Fields[MyFieldKey1].FieldName;

  MyFieldKey2 := KeyField2;
  if MyFieldKey2 >= 0 then
    MyFieldKey2Name := quFchBrw.Fields[MyFieldKey2].FieldName;

  if FormBrwConfig.MostraDesativado = STD_DESATIVADO then
    begin
      if (MsgBox(MSG_QST_DELETE_PERMANENT, vbYesNo + vbQuestion) = vbYes) then
        begin
           OnBeforeDeleteItem;
           if MyFieldKey2 >= 0 then
              Ret := SystemDeleteItem(DM.quFreeSQL,
                                      DeleteTable,
                                      [MyFieldKey1Name,
                                       MyFieldKey2Name],
                                      [quFchBrw.Fields[MyFieldKey1].AsString,
                                       quFchBrw.Fields[MyFieldKey2].AsString],
                                      [quFchBrw.Fields[MyFieldKey1].DataType,
                                       quFchBrw.Fields[MyFieldKey2].DataType],
                                      FormBrwConfig.CheckSystemOnDelete, True)
           else
              Ret := SystemDeleteItem(DM.quFreeSQL,
                                      DeleteTable,
                                      [MyFieldKey1Name],
                                      [quFchBrw.Fields[MyFieldKey1].AsString],
                                      [quFchBrw.Fields[MyFieldKey1].DataType],
                                      FormBrwConfig.CheckSystemOnDelete, True);
        end;
    end
  else
    begin
      if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
        begin
           OnBeforeDeleteItem;

           if MyFieldKey2 >= 0 then
              Ret := SystemDeleteItem(DM.quFreeSQL,
                                      DeleteTable,
                                      [MyFieldKey1Name,
                                       MyFieldKey2Name],
                                      [quFchBrw.Fields[MyFieldKey1].AsString,
                                       quFchBrw.Fields[MyFieldKey2].AsString],
                                      [quFchBrw.Fields[MyFieldKey1].DataType,
                                       quFchBrw.Fields[MyFieldKey2].DataType],
                                      FormBrwConfig.CheckSystemOnDelete, FormBrwConfig.RealDeletion)
           else
              Ret := SystemDeleteItem(DM.quFreeSQL,
                                      DeleteTable,
                                      [MyFieldKey1Name],
                                      [quFchBrw.Fields[MyFieldKey1].AsString],
                                      [quFchBrw.Fields[MyFieldKey1].DataType],
                                      FormBrwConfig.CheckSystemOnDelete, FormBrwConfig.RealDeletion);
        end;
    end;

    if Ret then
      begin
        Self.TocaFicha;
        quFchBrw.Requery;
      end;
end;

procedure TParentFchList.quFchBrwBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  // Seta para mostar os Hiddens e Desativados;
  quFchBrw.CommandText := ChangeSQLState( OriginalBrwSQL,
                                       FormBrwConfig.MostraDesativado,
                                       FormBrwConfig.MostraHidden );
end;

procedure TParentFchList.FormCreate(Sender: TObject);
var
   aBrwKeys: Variant;
begin
  inherited;
  // Se tiver um tab só, não mostra o pagecontrol
  if PPageControl.PageCount = 1 then
    begin
      PPageControl.Visible := False;
      PPageControl.Pages[0].Parent := pnlBottomAlign;
    end;

  OriginalTitleFontColor := lblPTitulo.Font.Color;
  OriginalTitleColor := pnlPTitulo.Color;

  OriginalBrwSQL := quFchBrw.CommandText;
  FirstFieldIndex := -1;
  CorCinza := True;

  // Pega as chaves da tabela principal do browse
  aBrwKeys := GetTableKeys( DM.quFreeSQL,
                            GetSQLFirstTableName(quFchBrw.CommandText));

  KeyField1 := quFchBrw.FieldByName(aBrwKeys[0]).Index;
  if VarArrayHighBound(aBrwKeys, 1) > 0 then
    KeyField2 := quFchBrw.FieldByName(aBrwKeys[1]).Index
  else
    KeyField2 := -1;

  if quFchBrw.KeyFields = '' then
    quFchBrw.KeyFields := quFchBrw.Fields[KeyField1].FieldName;

  if grbFchBrw.KeyField = '' then
    grbFchBrw.KeyField := quFchBrw.Fields[KeyField1].FieldName;

end;


procedure TParentFchList.imgFolderDblClick(Sender: TObject);
begin
  inherited;
  FormBrwConfig.MostraDesativado := STD_DESATIVADO;
  SetBrwCommand;
  quFchBrw.Requery;
end;

procedure TParentFchList.ImgTrashDblClick(Sender: TObject);
begin
  inherited;
  FormBrwConfig.MostraDesativado := STD_NAODESATIVADO;
  SetBrwCommand;
  quFchBrw.Requery;
end;

procedure TParentFchList.SetBrwCommand;
var
   Lixeira: Boolean;

begin
  // Atualiza os botões do browse
  if formbrwConfig.RealDeletion then
    begin
      ImgTrash.Visible           := False;
      ImgFolder.Visible          := False;
      btFchBrwRestaura.Visible   := False;
      btFchBrwNovo.Visible       := True;
    end
  else
    begin
      Lixeira := (FormbrwConfig.MostraDesativado = STD_DESATIVADO);
      ImgTrash.Visible           := Lixeira;
      ImgFolder.Visible          := not Lixeira;
      btFchBrwRestaura.Visible   := Lixeira;
      btFchBrwNovo.Visible       := not Lixeira;
    end;


end;

procedure TParentFchList.FormShow(Sender: TObject);
var
  i: integer;

begin
  inherited;

  with PPageControl do
    if PageCount > 0 then
      begin
        for i := 0 to (PageCount-1) do
          begin
            if Pages[i].TabVisible then
              begin
                ActivePage := Pages[i];
                Break;
              end;
          end;
      end;

  // Se tiver um tab só, não mostra o pagecontrol
  if PPageControl.PageCount = 1 then
    begin
      PPageControl.Visible := False;
      tsBrowse.Parent := pnlBottomAlign;
      pnlBottomAlign.Parent := Self;
    end;

  SetBrwCommand;

end;

procedure TParentFchList.btFchBrwRestauraClick(Sender: TObject);
var
  Ret : Boolean;
begin
  if not btFchBrwRestaura.Visible then Exit;

  if (MsgBox(MSQ_QST_RETORE, vbYesNo + vbQuestion) = vbYes) then
          begin
             if KeyField2 >= 0 then
                Ret := SystemRestoreItem(DM.quFreeSQL,
                                        GetSQLFirstTableName(quFchBrw.CommandText),
                                        [quFchBrw.Fields[KeyField1].FieldName,
                                         quFchBrw.Fields[KeyField2].FieldName],
                                        [quFchBrw.Fields[KeyField1].AsString,
                                         quFchBrw.Fields[KeyField2].AsString],
                                        [quFchBrw.Fields[KeyField1].DataType,
                                         quFchBrw.Fields[KeyField2].DataType])
             else
                Ret := SystemRestoreItem(DM.quFreeSQL,
                                        GetSQLFirstTableName(quFchBrw.CommandText),
                                        [quFchBrw.Fields[KeyField1].FieldName],
                                        [quFchBrw.Fields[KeyField1].AsString],
                                        [quFchBrw.Fields[KeyField1].DataType]);

            if Ret then
              begin
                quFchBrw.Requery;
                Self.TocaFicha;
              end;
          end;
end;

procedure TParentFchList.grbFchBrwTopRowChanged(Sender: TObject);
begin
  inherited;
  grbFchBrw.invalidate;

end;

procedure TParentFchList.FchListRefresh;
begin
  quFchBrw.Close;
  quFchBrw.Open;
end;


procedure TParentFchList.SetPageControl(Pageindex: integer);
begin

  with PPageControl do
    ActivePage := Pages[PageIndex];

end;

procedure TParentFchList.OnBeforeDeleteItem;
begin
  // Para ser herdado

end;


procedure TParentFchList.dsFchBrwStateChange(Sender: TObject);
var
   MyBo: Boolean;
begin
  inherited;
  with quFchBrw do
    MyBo := NOT (EOF AND BOF);

  btFchBrwDetalhe.Enabled  := MyBo;
  btFchBrwRemove.Enabled   := MyBo;
  btFchBrwRestaura.Enabled := MyBo;


end;

end.
