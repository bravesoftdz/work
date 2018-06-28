unit uSerasaHTML;

interface

uses Windows, SysUtils, Classes, Sockets, uSerasaTypes, uSerasaConsts,
     uSerasaFunctions, Dialogs;

type
  TSerasaSearch = class(TComponent)
  private
    FSerasaHeader: TSerasaHeader;
    FClient : TTcpClient;
    sResponse, sResponseUncripted: String;
    FLastResult: String;
    FWaitingResponse: Boolean;
    FRemoteHost: String;
    FRemotePort: String;
    procedure TCPClientReceive(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    function TrataResposta(sResposta: String): String;
    procedure TCPClientConnect(Sender: TObject);
    procedure TCPClientError(Sender: TObject; SocketError: Integer);
    procedure DisconnectSocket;
    procedure ResetSearch;
    procedure SetRemoteHost(const Value: String);
    procedure SetRemotePort(const Value: String);

  public
    property SerasaHeader: TSerasaHeader read FSerasaHeader write fSerasaHeader;
    property LastResult: String read FLastResult;
    property RemoteHost: String read FRemoteHost write SetRemoteHost;
    property RemotePort: String read FRemotePort write SetRemotePort;
    constructor Create(AOwner: TComponent);override;
    Destructor Destroy;override;
    procedure DoSearch;
  end;

implementation



{ TSerasaSearch }


function TSerasaSearch.TrataResposta(sResposta: String) : String;
var
  sTemp : String;
  CodResposta,
  UltimaResposta: Integer;
  stlHTML : TStringList;
  TheHeader : String;
begin
  sTemp          := sResposta;

  if Length(sTemp) < Length(SerasaHeader.ToHeader) then
  begin
    ShowMessage(StringReplace(sTemp, #3, '', [rfReplaceAll]));
    Result := '';
    Exit;
  end;

  TheHeader      := Copy(SerasaHeader.ToHeader, 25, 16);

  stlHTML        := TStringList.Create;
  CodResposta    := -1;
  UltimaResposta := -1;

  Delete(sTemp, 1, 300);

  stlHTML.Add('<html>');
  stlHTML.Add('  <head>');
  stlHTML.Add('  </head>');
  stlHTML.Add('  <body>');

  while Copy(sTemp, 1, 2) <> COD_FINALIZACAO do
  begin
    If CodResposta <> 90 then
    begin
      CodResposta := StrToInt(Copy(sTemp, 1, 2));
    end;

    if UltimaResposta <> CodResposta then
    begin
      if UltimaResposta <> -1 then
      stlHTML.Add('    </table>');
      stlHTML.Add('    <BR>');
    end;


    case CodResposta of
      00:
        begin
          stlHTML.Add(Reg00ToHTML(Copy(sTemp, 1, TAM_REG00), SerasaHeader.TipoDocumentoPesquisa, UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG00);
        end;

      02:
        begin
          stlHTML.Add(Reg02ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      04:
        begin
          stlHTML.Add(Reg04ToHTML(Copy(sTemp, 1, TAM_REG04), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG04);
        end;

      05:
        begin
          stlHTML.Add(Reg05ToHTML(Copy(sTemp, 1, TAM_REG05), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG05);
        end;

      06:
        begin
          stlHTML.Add(Reg06ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      08:
        begin
          stlHTML.Add(Reg08ToHTML(Copy(sTemp, 1, TAM_REG08), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG08);
        end;

      10:
        begin
          stlHTML.Add(Reg10ToHTML(Copy(sTemp, 1, TAM_REG10), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG10);
        end;

      12:
        begin
          stlHTML.Add(Reg12ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      14:
        begin
          stlHTML.Add(Reg14ToHTML(Copy(sTemp, 1, TAM_REG14), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG14);
        end;

      16:
        begin
          stlHTML.Add(Reg16ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      18:
        begin
          stlHTML.Add(Reg18ToHTML(Copy(sTemp, 1, TAM_REG18), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG18);
        end;

      20:
        begin
          stlHTML.Add(Reg20ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      22:
        begin
          stlHTML.Add(Reg22ToHTML(Copy(sTemp, 1, TAM_REG22), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG22);
        end;

      24:
        begin
          stlHTML.Add(Reg24ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      26:
        begin
          stlHTML.Add(Reg26ToHTML(Copy(sTemp, 1, TAM_REG26), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG26);
        end;

      28:
        begin
          stlHTML.Add(Reg28ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      30:
        begin
          stlHTML.Add(Reg30ToHTML(Copy(sTemp, 1, TAM_REG30), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG30);
        end;

      32:
        begin
          stlHTML.Add(Reg32ToHTML(Copy(sTemp, 1, TAM_REG32), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG32);
        end;

      34:
        begin
          stlHTML.Add(Reg34ToHTML(Copy(sTemp, 1, TAM_REG34), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG34);
        end;

      36:
        begin
          stlHTML.Add(Reg36ToHTML(Copy(sTemp, 1, TAM_REG36), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG36);
        end;

      38:
        begin
          stlHTML.Add(Reg38ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      40:
        begin
          stlHTML.Add(Reg40ToHTML(Copy(sTemp, 1, TAM_REG40), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG40);
        end;

      42:
        begin
          stlHTML.Add(Reg42ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;

      44:
        begin
          stlHTML.Add(Reg44ToHTML(Copy(sTemp, 1, TAM_REG44), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG44);
        end;

      46:
        begin
          stlHTML.Add(Reg46ToHTML(Copy(sTemp, 1, TAM_REG46), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG46);
        end;

      48:
        begin
          stlHTML.Add(Reg48ToHTML(Copy(sTemp, 1, TAM_REG48), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG48);
        end;


      50:
        begin
          stlHTML.Add(Reg50ToHTML(Copy(sTemp, 1, TAM_REG_NADA_CONSTA)));
          Delete(sTemp, 1, TAM_REG_NADA_CONSTA);
        end;


      52:
        begin
          stlHTML.Add(Reg52ToHTML(Copy(sTemp, 1, TAM_REG52), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG52);
        end;

      54:
        begin
          stlHTML.Add(Reg54ToHTML(Copy(sTemp, 1, TAM_REG54), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG54);
        end;

      90:
        begin
          stlHTML.Add(Reg90ToHTML(Copy(sTemp, 1, TAM_REG90), UltimaResposta <> CodResposta));
          Delete(sTemp, 1, TAM_REG90);
        end;

      else
        raise Exception.CreateFmt(MSG_ERRO_RETORNO_INVALIDO, [Copy(sTemp, 1, 2)]);
    end;

    UltimaResposta := CodResposta;
    if TheHeader = Copy(sTemp, 1, 16) then
      Delete(sTemp, 1, 300);
  end;
  stlHTML.Add('    </table>');
  stlHTML.Add('  </body>');
  stlHTML.Add('</html>');

  Result := stlHTML.GetText;
end;

procedure TSerasaSearch.TCPClientReceive(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var
  I : Integer;
begin
  if not FWaitingResponse then
    Exit;

  try
    for I := 0 to DataLen-1{Length(Buf)} do
    begin
      if Buf[I] = #3 then
      begin
        FClient.Disconnect;
        sResponseUncripted := DescriptografaSERASA(sResponse);
        FLastResult := TrataResposta(sResponseUncripted);
        FWaitingResponse := False;
        Break;
      end;
      sResponse := sResponse + Buf[I];
    end;
  except
    FWaitingResponse := False;
  end;
end;

procedure TSerasaSearch.TCPClientConnect(Sender: TObject);
var
  Buf: array[0..999] of Char;
  Header: String;
begin
  Header := SerasaHeader.ToHeader;
  Header := CriptografaSERASA(Header) + #3;
  FClient.SendBuf(pchar(Header)^, length(Header), 0);
  FillChar(Buf, Length(Buf), #0);
  while FClient.ReceiveBuf(Buf, Length(Buf)) >= Length(Buf) do
  begin
    FillChar(Buf, Length(Buf), #0);
    Sleep(0);
  end;
end;

procedure TSerasaSearch.TCPClientError(Sender: TObject;
  SocketError: Integer);
begin
  ShowMessage('Error : ' + IntToStr(SocketError));
end;

constructor TSerasaSearch.Create(AOwner: TComponent);
begin
  inherited Create(AOWner);
  FClient            := TTcpClient.Create(Self);
  FClient.RemoteHost := FRemoteHost;
  FClient.RemotePort := FRemotePort;
  FClient.OnConnect  := TCPClientConnect;
  FClient.OnReceive  := TCPClientReceive;
  FClient.OnError    := TCPClientError;
  FSerasaHeader      := TSerasaHeader.Create;
  with FSerasaHeader do
  begin
    Transacao             := HEADER_COD_TRANS;
    TransacaoContratada   := HEADER_COD_TRANS_CONTRATADA;
    CodigoRelease         := HEADER_COD_RELEASE;
  end;
  ResetSearch;
end;

destructor TSerasaSearch.Destroy;
begin
  DisconnectSocket;
  FClient.Free;
  FSerasaHeader.Free;
  inherited;
end;

procedure TSerasaSearch.DisconnectSocket;
begin
  if FClient.Connected then
    FClient.Disconnect;
end;

procedure TSerasaSearch.ResetSearch;
begin
  FLastResult        := '';
  sResponse          := '';
  sResponseUncripted := '';
  DisconnectSocket;
  FWaitingResponse := False;
end;

procedure TSerasaSearch.DoSearch;
begin
  ResetSearch;
  FWaitingResponse := True;
  FClient.Connect;
end;

procedure TSerasaSearch.SetRemoteHost(const Value: String);
begin
  FRemoteHost := Value;
  FClient.RemoteHost := FRemoteHost;
end;

procedure TSerasaSearch.SetRemotePort(const Value: String);
begin
  FRemotePort := Value;
  FClient.RemotePort := FRemotePort;
end;

end.
