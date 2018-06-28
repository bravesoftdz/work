unit uSystemTypes;

interface

uses
  Forms, uNTUpdateControl, Classes, uMRSQLParam;

type
  TActionType = (atAppend, atEdit, atBrowse);

  TOnTestFilter = procedure (Sender: TObject; var ApplyFilter: Boolean) of object;
  TOnGetParams = procedure (Sender: TObject; var Params: String) of object;
  TOnGetFilter = procedure (Sender: TObject; var Filter: TMRSQLParam) of object;
  TOnBeforeDeleteRecord = procedure(Sender: TObject; var Apply: Boolean) of object;
  TOnBeforeApplyChanges = procedure(Sender: TObject; var Apply: Boolean) of object;
  TOnBeforeGetRecords = procedure(Sender: TObject; var OwnerData: OleVariant) of object;
  TOnSetActiveTab = procedure(Sender: TObject; var TabIndex: Integer) of object;
  TOnCanNavigate = procedure(Sender: TObject; var CanNavigate: Boolean) of object;
  TOnGetForeignKeyValue = procedure (Sender: TObject; var ForeignKeyValue: TMRSQLParam) of object;
  TOnGetTransaction = procedure (Sender: TObject; var ATransaction: TmrTransaction) of object;
  TOnTestAddItem = procedure (Sender: TObject; var AddItem: Boolean) of object;
  TOnTestRemoveItem = procedure (Sender: TObject; var RemoveItem: Boolean) of object;
  TOnVersionModeEvent = procedure (Sender: TObject; Active: Boolean) of object;
  TOnGetTaskRequest = procedure (TaskRequest: String; var Response: String) of object;
  TOnGetFilterText = function (Sender: TObject): String of object;
  TOnSelectChange = procedure (Sender: TObject; SingleSelected, MultiSelected: boolean) of object;
  TOnSetTitle = procedure(Sender: TObject) of object;
  TOnGetProviderName = function (Sender: TObject): String of object;
  TOnBeforeOpenSearch = procedure (Sender: TObject) of object;


  TCaixa         = array[0..12] of Integer;
  TCaixaPotencia = array[0..12] of Double;

  TBtnCommandType = (btInc, btAlt, btExc, btPos, btFlt, btImp, btExp, btRest, btAgrupa, btSelCol, btRodape, btGrade);

  TDesativadoState = (STD_DESATIVADO, STD_NAODESATIVADO, STD_AMBOSDESATIVADO);
  TOrderByState    = (STD_ORDER_ASC, STD_ORDER_DESC);
  THiddenState     = (STD_HIDDEN, STD_NAOHIDDEN, STD_AMBOSHIDDEN);

  TSetCommandType = set of TBtnCommandType;
const

  aCaixaPotencia : TCaixaPotencia = (
                                    100,
                                    50,
                                    20,
                                    10,
                                    5,
                                    2,
                                    1,
                                    1,
                                    0.5,
                                    0.25,
                                    0.1,
                                    0.05,
                                    0.01
                                    );

  BT_FLT = 0;
  BT_INC = 1;
  BT_ALT = 2;
  BT_EXC = 3;
  BT_CON = 4;
  BT_POS = 5;
  BT_IMP = 6;
  BT_REF = 7;
                                    

implementation

end.
