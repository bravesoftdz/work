unit uSystemTypes;

interface

type
  TCaixa         = array[0..12] of Integer;
  TCaixaPotencia = array[0..12] of Double;

  TBtnCommandType = (btInc, btAlt, btExc, btPos, btFlt, btImp, btRest, btAgrupa, btSelCol, btRodape, btGrade);

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
