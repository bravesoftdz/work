unit uSisPropertyEditorFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, DBCtrls, dxCntner, dxTL, dxDBGrid, StdCtrls, Buttons,
  ExtCtrls, Db, DBTables, dxDBCtrl, ADODB, siComp, siLangRT;

type
  TSisPropertyEditorFrm = class(TParentDialogFrm)
    dxDBGrid1: TdxDBGrid;
    quProperty: TADOQuery;
    quValue: TADOQuery;
    dsProperty: TDataSource;
    dsValue: TDataSource;
    dxDBGrid2: TdxDBGrid;
    quPropertyProperty: TStringField;
    dxDBGrid2Property: TdxDBGridMaskColumn;
    quValuePropertyValue: TStringField;
    dxDBGrid1PropertyValue: TdxDBGridMaskColumn;
    pnlComando: TPanel;
    btRemoveValue: TSpeedButton;
    btNewValue: TSpeedButton;
    Splitter1: TSplitter;
    quValueProperty: TStringField;
    Panel1: TPanel;
    lblPTituloShadow: TLabel;
    lblPTitulo: TLabel;
    imgOn: TImage;
    btNovaPropriedade: TSpeedButton;
    btRemovePropriedade: TSpeedButton;
    procedure btNewValueClick(Sender: TObject);
    procedure btRemoveValueClick(Sender: TObject);
    procedure quValueNewRecord(DataSet: TDataSet);
    procedure btCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure quValueAfterPost(DataSet: TDataSet);
    procedure dsValueDataChange(Sender: TObject; Field: TField);
    procedure btNovaPropriedadeClick(Sender: TObject);
    procedure btRemovePropriedadeClick(Sender: TObject);
  private
    { Private declarations }
    sEnter,
    sProperty : String;
  public
    { Public declarations }
  end;


implementation

uses uDM, uMsgBox, uSisMain, uMsgConstant, uDMGlobal;

{$R *.DFM}


procedure TSisPropertyEditorFrm.btNewValueClick(Sender: TObject);
begin
  inherited;
  with quValue do
      begin
      if (State in dsEditModes) then
         if(quValuePropertyValue.AsString <> '') then
           Post
         else
           Cancel;
      Append;
      end;
end;

procedure TSisPropertyEditorFrm.btRemoveValueClick(Sender: TObject);
begin
  inherited;

  if MsgBox(MSG_QST_SURE, vbQuestion + vbYesNo) = vbYes then
     quValue.Delete;

end;

procedure TSisPropertyEditorFrm.quValueNewRecord(DataSet: TDataSet);
begin
  inherited;
  with quValue do
    FieldByName('Property').AsString := Parameters.ParamByName('Property').Value;
end;

procedure TSisPropertyEditorFrm.btCancelClick(Sender: TObject);
begin
  inherited;
  DM.PropertyValuesRefresh;
  Close;
end;

procedure TSisPropertyEditorFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  quProperty.Close;
  with quValue do
    begin
      if State in dsEditModes then
        Post;
      Close;
    end;
  Action := caFree;
end;

procedure TSisPropertyEditorFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Caption := Application.Title;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sEnter    := 'Property editor';
           sProperty := 'Enter the name of new property:';
           end;
    LANG_PORTUGUESE :
           begin
           sEnter    := 'Editor de propriedades';
           sProperty := 'Entre com a nova propriedade:';
           end;

    LANG_SPANISH :
           begin
           sEnter    := 'Editor de propriedades';
           sProperty := 'Entre com a nova propriedade:';
           end;
  end;


end;

procedure TSisPropertyEditorFrm.FormDestroy(Sender: TObject);
begin
  inherited;
  //quProperty.UnPrepare;
  //quValue.UnPrepare;
end;

procedure TSisPropertyEditorFrm.FormShow(Sender: TObject);
begin
  inherited;
  quProperty.Open;
  quValue.Open;
end;

procedure TSisPropertyEditorFrm.quValueAfterPost(DataSet: TDataSet);
var
  PropertyValue: String;
begin
  inherited;
  // Dou o refresh para garantir a ordenação

  with quValue do
    begin
      DisableControls;
      PropertyValue := quValuePropertyValue.AsString;
      Close;
      Open;
      Locate('PropertyValue', PropertyValue, []);
      EnableControls;
    end;

end;

procedure TSisPropertyEditorFrm.dsValueDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btRemoveValue.Enabled := not quValue.IsEmpty;
end;

procedure TSisPropertyEditorFrm.btNovaPropriedadeClick(Sender: TObject);
var
  NovaPropriedade: String;
begin
  inherited;
  // Incluo uma nova propriedade
  NovaPropriedade := InputBox(sEnter, sProperty, '');

  if NovaPropriedade <> '' then
    begin
      DM.RunSQL( 'INSERT Sis_PropertyDomain (Property, PropertyValue) ' +
                 'VALUES (' + #39 + NovaPropriedade + #39 + ', ' +
                 #39 + 'FirstValue' + #39 + ')');

      quProperty.Close;
      quProperty.Open;
      quValue.Close;
      quValue.Open;
    end;

end;

procedure TSisPropertyEditorFrm.btRemovePropriedadeClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_SURE, vbQuestion + vbYesNo) = vbYes then
    begin
      DM.RunSQL('DELETE Sis_PropertyDomain WHERE Property = ' + #39 + quPropertyProperty.AsString + #39);

      quProperty.Close;
      quProperty.Open;
      quValue.Close;
      quValue.Open;
    end;


end;

Initialization
  RegisterClass(TSisPropertyEditorFrm);


end.
