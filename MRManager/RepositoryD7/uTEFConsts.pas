unit uTEFConsts;

interface

const
  TEF_NONE = 0;
  TEF_DIAL = 1;
  TEF_DEDICADO = 2;

  TEF_DIAL_XPRESS = 0;
  TEF_DIAL_HIPER = 1;

  TEF_DIAL_NAMES: array [0..1] of String = ('TEF Dial', 'TEF Hipercard');

  TEF_PARCELAMENTO_LOJA = 1;
  TEF_PARCELAMENTO_ADM = 2;

  TEF_PAYMENTS: set of byte = [10..21, 23..58, 60..64, 70..99];

  TEF_BANDEIRA_FININVEST = 32;


implementation

end.
