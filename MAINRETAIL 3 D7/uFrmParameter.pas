unit uFrmParameter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, DBCtrls, DB, DBTables, Grids,
  LblEffct, ExtCtrls, Buttons, ADODB, siComp, siLangRT, DBGrids, SMDBGrid,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TFrmParameter = class(TFrmParent)
    dsParam: TDataSource;
    memoDescription: TDBMemo;
    quParam: TADOQuery;
    quParamSrvParameter: TStringField;
    quParamSrvValue: TStringField;
    quParamDescription: TStringField;
    quParamDefaultValue: TStringField;
    quParamSrvType: TStringField;
    spHelp: TSpeedButton;
    grdParameterDBTV: TcxGridDBTableView;
    grdParameterLevel: TcxGridLevel;
    grdParameter: TcxGrid;
    grdParameterDBTVSrvParameter: TcxGridDBColumn;
    grdParameterDBTVSrvValue: TcxGridDBColumn;
    grdParameterDBTVDefaultValue: TcxGridDBColumn;
    quParamMenuName: TStringField;
    grdParameterDBMenuName: TcxGridDBColumn;
    quParamIDParam: TIntegerField;
    grdParameterDBTVIDParam: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure quParamSrvValueValidate(Sender: TField);
  private
    bParamError : Boolean;
    procedure ParamClose;
    procedure ParamPost;
    procedure ParamOpen;
  public
    { Public declarations }
  end;

var
  FrmParameter: TFrmParameter;

implementation

uses uMsgBox, uDM, uMsgConstant, uDMGlobal;

{$R *.DFM}

procedure TFrmParameter.ParamClose;
begin

   ParamPost;

   with quParam do
      if Active then
         Close;

end;

procedure TFrmParameter.ParamOpen;
begin

   with quParam do
      if not Active then
         begin
         Parameters.ParamByName('IDLanguage').Value  := DMGlobal.IDLanguage;
         Parameters.ParamByName('MIDLanguage').Value := DMGlobal.IDLanguage;
         Open;
         end;

end;

procedure TFrmParameter.ParamPost;
begin

  with quParam do
     if Active then
        if State in dsEditModes then
           begin
           Post;
           MsgBox(MSG_INF_CHANGES_SYS, vbOkOnly + vbInformation);
           end;

end;

procedure TFrmParameter.FormShow(Sender: TObject);
begin
  inherited;

  ParamOpen;

end;

procedure TFrmParameter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  Action := caFree;

end;

procedure TFrmParameter.btCloseClick(Sender: TObject);
begin
  inherited;

  if bParamError then
    MsgBox(MSG_CRT_ERROR_VALUE, vbOkOnly);

  ParamClose;

  Close;
end;

procedure TFrmParameter.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(2050);
end;

procedure TFrmParameter.quParamSrvValueValidate(Sender: TField);
var
  VarInt   : Integer;
  VarFloat : Real;
begin

  try

     bParamError := False;

     if Trim(quParamSrvType.text) = 'Integer' then
       VarInt := StrToInt (quParamSrvValue.Text)
     else
       if Trim(quParamSrvType.text) = 'Float' then
          VarFloat := StrToFloat(quParamSrvValue.Text)
     else
       if Trim(quParamSrvType.text) = 'Boolean' then
          if (LowerCase(quParamSrvValue.Text) <> 'true') and
             (LowerCase(quParamSrvValue.Text) <> 'false') then
             strToInt('a'); //Forco um erro

  except
     MsgBox ('Invalid Value', vbOkOnly);
     bParamError := True;
  end;

end;

end.
