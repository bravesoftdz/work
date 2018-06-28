unit uCreditCardFunction;

interface

uses Classes, StrUtils;

type
  TTransactionReturn = (ttrSuccessfull, ttrNotSuccessfull, ttrError, ttrException);

  TNeedSwipeEvent       = procedure(Sender: TObject; var SwipedTrack: WideString;
                                    var ACanceled: Boolean) of object;
  TAfterSucessfullSwipe = procedure(Sender: TObject; const ACardNumber,
                                    ACardMember, ACardExpireDate: WideString) of object;
  TNeedTroutDEvent = procedure(Sender: TObject; var ATrouD, ARefNo, AAuthCode: WideString;
                               var ACanceled: Boolean) of object;

  function ParseTrack(const ATrack: String; var ACard, AName, ADate,
      ATrack2: WideString): Boolean;

  function CopyLevelIIData(ASwiped: WideString): WideString;


implementation

function CopyLevelIIData(ASwiped: WideString): WideString;
var
  strTmp: WideString;
  posSemicolumn, posQuestion: Integer;
begin
  strTmp := ASwiped;

  posSemicolumn := Pos(';', strTmp);
  Delete(strTmp, 1, posSemicolumn);

  posQuestion   := Pos('?', strTmp);
  strTmp := Copy(strTmp, 1, posQuestion - 1);

  Result := strTmp;
end;


function ParseTrack(const ATrack: String; var ACard, AName, ADate,
      ATrack2: WideString): Boolean;
var
  n, n2, n3,
  c, c2, c3,
  e, e2,  e3: Integer;
  track, d, m, y: WideString;
  t, t2, t3: integer;
begin
  Result := False;
//  try
    track := ATrack;

    if (Length(ATrack) > 0) and (RightStr(ATrack, 1) = '?') then
    begin
      c := PosEx(';', track);
      if (c > 0) then
      begin
        c2 := PosEx('=', track);
        c := c + 1;
        c3 := c2 - c;
        if (c3 > 0) then
          begin
            ACard := Copy(track, c , c3);
          end;
      end;

      n := PosEx('^', track, 1);
      if (n > 0) then
      begin
        n2 := PosEx('^', track, n + 1);
        n := n + 1;
        n3 := n2 - n;
        if (n3 > 0) then
          begin
            AName := Copy(track, n, n3);
          end;
      end;
    end;

    e := PosEx('=', track, 1);
    if (e > 0) then
    begin
      e := e + 1;
      e2 := e + 4;
      e3 := e2 - e;
      if (e3 > 0) then
       begin
         d := Copy(Track, e, e3);
       end;
      m := Copy(d, 3, 2);
      y := Copy(d, 1, 2);
      ADate := m + y;
    end;

    t := PosEx(';', track, 1);
    if (t > 0) then
    begin
       t2 := PosEx('?',track, t);
       t := t + 1;
       t3 := t2 - t;
       if (t3 > 0) then
         begin
           ATrack2 := Copy(track, t, t3);
         end;
    end;
    Result := True;
//  except
//    Result := False;
//  end;
end;

end.
