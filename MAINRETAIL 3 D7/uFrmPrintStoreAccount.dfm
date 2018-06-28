inherited FrmPrintStoreAccount: TFrmPrintStoreAccount
  Left = 364
  Top = 11
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Printed'
  ClientHeight = 306
  ClientWidth = 301
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton [0]
    Left = 31
    Top = 10
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object ppReport: TppReport
    AutoStop = False
    DataPipeline = ppPayments
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Custom'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 508
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 508001
    PrinterSetup.mmPaperWidth = 88900
    PrinterSetup.PaperSize = 256
    Template.FileName = 
      'C:\Users\OFFICE\Documents\My Dropbox\MainRetail_Reports\V5_Recei' +
      'pts\Receipts\Standard_StoreAcc_Receipt_Footer.rtm'
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'Screen'
    Icon.Data = {
      0000010002002020000001001800A80C0000260000002020000001002000A810
      0000CE0C00002800000020000000400000000100180000000000800C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009D9D9C8988877275
      7569686A73727175767500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000008485847475738A8B8B9B999BA5A3A4A8A7A7A7A6A6A8A8
      A8A6A6A6DCDCDCDFDEDF78787873757500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006D6D6D717272A5A6A5CAC9C9CECECDC5C6C5BABBBBB2B2B2ABABAAA7A7
      A7A1A1A1CCCCCCFFFFFFF8F8F8A3A2A263636300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000686766
      979696CFCDCEE6E5E5E2E2E1D2D2D2C8C8C7BFBEBEB6B6B6AFAFAFA9A9AAA5A5
      A5A1A1A1D5D6D6FFFFFFF7F7F7FFFFFFCDCCCD61616200000000000000000000
      0000000000000000000000000000000000000000000000000000000000E2E0DF
      FFFFFFF3F3F3E5E4E4D9D7D7D1D0CFCBCBC9CBCACBC8C8C7C4C4C4BEBFBFBDBD
      BDB2B3B2A2A2A2EFEFEFFEFEFEF6F6F6FFFFFFF1F0F086868600000000000000
      0000000000000000000000000000000000000000000000000000000000F1F0F1
      F3F2F2EAE9E9E8E8E8E7E6E6E6E6E6E0DFDFCECECEBEBFBEB5B5B5B0B0B0ACAC
      AC9D9D9D6D6D6E858686DCDBDCFFFEFEF7F7F6FFFEFEFEFFFE8D8E8D00000000
      0000000000000000000000000000000000000000000000000000D3D2D2EDEBEB
      F7F7F6F2F1F1E1E1E0C9C8C8BEBEBFBCBCBDBBBABABBBBBBB8B7B7B1B0B1A6A6
      A6A6A7A7C7C7C7B5B4B5939293BBBBBAF9F9F9FBFBFBFFFEFFF6F5F674737200
      0000000000000000000000000000000000000000000000000000DBDBDAE0E1E0
      D0D0D0BBBBBBBCBBBBCFCECEE5E4E4F0EEEEE9E8E9D8D7D8C6C6C7B9B8B8AEAE
      AEA6A6A5BFC0BFD1D4D1D6D7D79394938F8E8CDEDEDEFFFFFFFFFFFFAEAEAA00
      0000000000000000000000000000000000000000000000000000C5C5C5A1A1A1
      CCCCCDE5E4E4F9F8F8F9F8F8F0EFEFE3E3E2D4D3D4C4C3C4BCBBBCBFBDBDC6C6
      C5A3A3A3919191C5C8C5CDCFCEDFE1E0ACADAB7B7A79B3B3B3FFFFFFD8D8D600
      0000000000000000000000000000000000000000000000000000B9BABAD1D1D0
      FFFDFEEFEEEEDBDBDAD6D6D6D4D4D3BFBFBDC5C5C5C9C7C6D0CDCCEAEAEACECD
      CBE1E0E09C9C9CA9A9A8C6C9C6CCCECDE7E8E7D2D2D18181828C8C8BDCDCDC00
      0000000000000000000000000000000000000000000000000000000000C2C0BE
      D2D2D2B2B1B0CDCDCDCFCECDD3D3D1E4E4E4CDCAC9E9E8E7E3E1DFDFDCDCF1F1
      F0D7D4D2E5E4E49C9C9DB4B6B4C4C6C3CACCCAE4E5E4EBEBEB9E9F9E7D7D7E00
      0000000000000000000000000000000000000000000000000000000000ACA8A5
      CCCBCBE0DFDED0CCC9E3E2E1DBDBDAC8C5C5CECFCECECDCBF0F0F0DBD8D8E1DE
      DEEAEAE9E5E4E3E0E1E1B3B3B3E5E6E5D0D2D0D5D6D5E1E2E1F4F5F4AEAEAE00
      0000000000000000000000000000000000000000000000000000000000000000
      AFA9A4D4D4D3E5E5E5DCDAD9DEDDDDD8D6D6CDCDCAD5D5D4D6D4D2F4F3F2E1DF
      DFEFEFF0E1DFDFECECECE7E6E7DCDBDCD1D1D0BDBFBDDBDDDBEDEEEDC8C9C800
      0000000000000000000000000000000000000000000000000000000000000000
      0000009F9C98E3E4E7E1E0DFCCCAC8FAFBFBF2F1F0F7F8F7DDDFE0E8E9EAE2E2
      E3BEBEBE9D9E9E7676776767684B4A4B605F5F3739397A7978DEDEDEDEDEDE00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3AFAEE1E2E3EAEBECDEDFE1ADB0B485888C7575757373727878
      784241421414141111110C0C0E0404044B4B4B3D3E3D1516154E4D4C9A999900
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000A8A6A75B5D5E545250797166AA977EDCC6A2998B7A5256
      5A4B494A0F0F0F1C1C1C2525242525254C4C4C77777633333235363561606000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B7A48FEFD0AAFFDCB2FFD8AFFFD9B1EDD2B0625F
      5D5A5B5D4B4B4A5555555A5A5A5657564F50503D3C3E5453545B5C5B9B9B9B00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E0CDB7FFDAAEFECAA8FED1B1FCD2B5FFE2C3CDC0
      AC949495ADAEAE3D3D3D222222232222161514454544A4A4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFDFC4FFE3CAFADEC5FBDCC4FBE1CCFFFD
      ECC6C4BF0000000000000000000000002529319FA1A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4E6D8FCEBDAF8E9D8F6EADDF9EF
      E2FEFBF4B6B6B6000000000000000000614E30645C4C756C5C877C6800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAD8D5FAF1E5F5EBE1F3EBE0F8F0
      E5FAF9F6ABAEB4000000C29840D09D2EFCB42AEEAC2FF9B927DAAD587F859000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000EFEDECFAF7F5F7F7F6FAFA
      F9F8F7F69FA5AEC7BAA5FFCE44FFC93AFFC338FFC135FFC529BA934E686D7700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000E8E8EAFFFFFFF9FAFBF1F1
      F1E9E7E7BFC1C6B5B3AFC59A43C29645A1844B9D7E469D7D4559504200000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CCCCCCD1D1D10000000000
      000000000000000000009795928E8E90888A9000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
      0FFFFF8003FFFE0001FFF80000FFF800007FF800003FF000001FF000001FF000
      001FF000001FF800001FF800001FFC00001FFE00001FFF00001FFF80001FFFC0
      001FFFC0007FFFE03CFFFFF01C3FFFF0101FFFF8001FFFF8003FFFF9F1FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000002000000040000000010020000000
      00008010000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FDFDFD02FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F1F112E3E4E322DFDFE024D9D8D929CACAC938BBBB
      BB45E8E8E81CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01EEEE
      EE11D8D8D828BDBCBD51A9A8A97A9D9D9C96898887B3727575D269686AE27372
      71F0757675CFA0A1A17FEFEFEF15FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F708C5C5C53A848584857475
      73B98A8B8BD19B999BEBA5A3A4F7A8A7A7FCA7A6A6FFA8A8A8FFA6A6A6FFDCDC
      DCFFDFDEDFFF787878FF737575B2E1E1E122FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E6199FA0A0656D6D6DAC717272E6A5A6A5FFCAC9
      C9FFCECECDFFC5C6C5FFBABBBBFFB2B2B2FFABABAAFFA7A7A7FFA1A1A1FFCCCC
      CCFDFFFFFFFDF8F8F8FFA3A2A2FF636363CBC4C4C33CFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5E5E530686766C3979696FFCFCDCEFFE6E5E5FFE2E2E1FFD2D2
      D2FFC8C8C7FFBFBEBEFFB6B6B6FFAFAFAFFFA9A9AAFFA5A5A5FFA1A1A1FFD5D6
      D6FEFFFFFFFDF7F7F7FDFFFFFFFDCDCCCDFF616162E9A0A0A05FFFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D8D7D764E2E0DFFFFFFFFFFFF3F3F3FFE5E4E4FFD9D7D7FFD1D0
      CFFFCBCBC9FFCBCACBFFC8C8C7FEC4C4C4FFBEBFBFFFBDBDBDFEB2B3B2FFA2A2
      A2FEEFEFEFFDFEFEFEFDF6F6F6FDFFFFFFFDF1F0F0FF868686F2A3A3A35FFEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D5D4D46AF1F0F1FFF3F2F2FFEAE9E9FFE8E8E8FFE7E6E6FFE6E6
      E6FFE0DFDFFECECECEFEBEBFBEFFB5B5B5FEB0B0B0FFACACACFF9D9D9DFE6D6D
      6EFD858686FEDCDBDCFEFFFEFEFDF7F7F6FDFFFEFEFDFEFFFEFF8D8E8DF2A0A0
      A063FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D3D2D280EDEBEBFFF7F7F6FFF2F1F1FFE1E1E0FFC9C8C8FFBEBE
      BFFFBCBCBDFFBBBABAFFBBBBBBFFB8B7B7FFB1B0B1FFA6A6A6FFA6A7A7FEC7C7
      C7FDB5B4B5FD939293FDBBBBBAFDF9F9F9FDFBFBFBFDFFFEFFFDF6F5F6FF7473
      72DBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DBDBDA93E0E1E0FFD0D0D0FFBBBBBBFEBCBBBBFECFCECEFEE5E4
      E4FFF0EEEEFFE9E8E9FFD8D7D8FFC6C6C7FFB9B8B8FFAEAEAEFFA6A6A5FEBFC0
      BFFED1D4D1FFD6D7D7FF939493FE8F8E8CFEDEDEDEFDFFFFFFFDFFFFFFFFAEAE
      AAFAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C59DA1A1A1FFCCCCCDFEE5E4E4FFF9F8F8FFF9F8F8FFF0EF
      EFFFE3E3E2FFD4D3D4FEC4C3C4FEBCBBBCFFBFBDBDFDC6C6C5FEA3A3A3FE9191
      91FEC5C8C5FFCDCFCEFFDFE1E0FEACADABFE7B7A79FDB3B3B3FEFFFFFFFFD8D8
      D6FAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9BABAA5D1D1D0FFFFFDFEFFEFEEEEFEDBDBDAFED6D6D6FED4D4
      D3FDBFBFBDFDC5C5C5FDC9C7C6FDD0CDCCFEEAEAEAFDCECDCBFEE1E0E0FD9C9C
      9CFDA9A9A8FEC6C9C6FFCCCECDFFE7E8E7FFD2D2D1FF818182FF8C8C8BFFDCDC
      DCF9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CDCDCD6BC2C0BEFFD2D2D2FFB2B1B0FDCDCDCDFECFCECDFDD3D3
      D1FDE4E4E4FDCDCAC9FEE9E8E7FDE3E1DFFEDFDCDCFEF1F1F0FDD7D4D2FDE5E4
      E4FD9C9C9DFDB4B6B4FDC4C6C3FECACCCAFFE4E5E4FFEBEBEBFF9E9F9EFF7D7D
      7EEFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F7F70FACA8A59ACCCBCBFEE0DFDEFFD0CCC9FEE3E2E1FDDBDB
      DAFDC8C5C5FDCECFCEFDCECDCBFEF0F0F0FDDBD8D8FEE1DEDEFDEAEAE9FDE5E4
      E3FDE0E1E1FDB3B3B3FDE5E6E5FED0D2D0FFD5D6D5FFE1E2E1FFF4F5F4FFAEAE
      AEEEFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F6F5F410AFA9A4A4D4D4D3FFE5E5E5FEDCDAD9FEDEDD
      DDFDD8D6D6FDCDCDCAFED5D5D4FED6D4D2FEF4F3F2FDE1DFDFFEEFEFF0FDE1DF
      DFFEECECECFDE7E6E7FDDCDBDCFDD1D1D0FDBDBFBDFEDBDDDBFFEDEEEDFFC8C9
      C8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7E5E7259F9C98DAE3E4E7FFE1E0DFFFCCCA
      C8FDFAFBFBFDF2F1F0FDF7F8F7FDDDDFE0FDE8E9EAFDE2E2E3FDBEBEBEFE9D9E
      9EFE767677FE676768FE4B4A4BFE605F5FFE373939FD7A7978FEDEDEDEFFDEDE
      DEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D0CE49B3AFAEBDE1E2E3FBEAEB
      ECFFDEDFE1FDADB0B4FD85888CFD757575FD737372FD787878FE424142FE1414
      14FE111111FE0C0C0EFE040404FE4B4B4BFD3D3E3DFD151615FF4E4D4CFF9A99
      99FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E5E428A8A6A7A25B5D
      5EFE545250FF797166FFAA977EFEDCC6A2FF998B7AFE52565AFD4B494AFF0F0F
      0FFF1C1C1CFD252524FD252525FD4C4C4CFD777776FD333332FF353635FF6160
      60DCFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D3D23EB7A4
      8FEAEFD0AAFFFFDCB2FFFFD8AFFFFFD9B1FFEDD2B0FF625F5DFD5A5B5DF64B4B
      4AFF555555FF5A5A5AFF565756FF4F5050FD3D3C3EFF545354FF5B5C5BFF9B9B
      9B9AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F5F50FE0CD
      B7C3FFDAAEFFFECAA8FFFED1B1FEFCD2B5FEFFE2C3FECDC0ACFE949495AFADAE
      AE8A3D3D3DEE222222FF232222FF161514FF454544DFA4A4A48EC0BFBF66F1F1
      F116FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E3
      E150FFDFC4F6FFE3CAFFFADEC5FEFBDCC4FEFBE1CCFEFFFDECFFC6C4BFE0D5D5
      D541DFDFDF34B9BAB969ABABAC77252931FF9FA1A38BFDFDFD02F0F0F016FAFA
      FA09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF01EDE8E570F4E6D8FBFCEBDAFFF8E9D8FEF6EADDFEF9EFE2FEFEFBF4FFB6B6
      B699FFFFFF00F0F0F014BBBAB95E614E30FF645C4CDB756C5CC7877C68E8B8B8
      BA7CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF01DAD8D5A9FAF1E5FFF5EBE1FEF3EBE0FEF8F0E5FEFAF9F6FFABAE
      B4AEBCB3A673C29840E3D09D2EFEFCB42AFFEEAC2FFFF9B927FFDAAD58FF7F85
      90BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E4E5E566EFEDECFFFAF7F5FEF7F7F6FEFAFAF9FFF8F7F6FF9FA5
      AEB8C7BAA5A1FFCE44FDFFC93AFFFFC338FFFFC135FFFFC529FFBA934EFF686D
      77C1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DFE0E04AE8E8EAFFFFFFFFFFF9FAFBFFF1F1F1FFE9E7E7FFBFC1
      C694B5B3AF8BC59A43FFC29645FFA1844BFF9D7E46FF9D7D45FF595042ED9FA0
      A16CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0F0F020CCCCCC98D1D1D190DCDDDC72E1E1E15DE3E3E34BF8F8
      F813CCCCCC599795929B8E8E908F888A9083999B9E74B2B4B75DCCCCCD3AF9F9
      F906FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFFFFFFF9FFFFFFF9
      FFFFFFF80FFFFF8003FFFE0001FFF80000FFF000007FF000001FF000001FF000
      001FF000001FF000001FF000001FF000001FF000001FF800001FFC00001FFE00
      001FFF00001FFF80001FFF80001FFFC0001FFFC0101FFFE0001FFFF0001FFFF0
      001FFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zs100Percent
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 102
    Top = 7
    Version = '7.02'
    mmColumnWidth = 76200
    DataPipelineName = 'ppPayments'
    object ppDetailBand3: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppSubReport2: TppSubReport
        UserName = 'SubReport3'
        ExpandAll = True
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        ParentPrinterSetup = False
        TraverseAllData = False
        DataPipelineName = 'ppPayments'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 794
        mmWidth = 82042
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport2: TppChildReport
          AutoStop = False
          DataPipeline = ppPayments
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Custom'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 508
          PrinterSetup.mmMarginRight = 0
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 76200
          PrinterSetup.PaperSize = 256
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppPayments'
          object ppDetailBand4: TppDetailBand
            PrintHeight = phDynamic
            mmBottomOffset = 0
            mmHeight = 139436
            mmPrintPosition = 0
            object ppLine2: TppLine
              UserName = 'Line3'
              Pen.Style = psDot
              Weight = 0.750000000000000000
              mmHeight = 2910
              mmLeft = 7938
              mmTop = 99484
              mmWidth = 65617
              BandType = 4
            end
            object ppLabel13: TppLabel
              UserName = 'ppLabel2'
              AutoSize = False
              Caption = 'Customer Signature'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taCentered
              Transparent = True
              mmHeight = 3440
              mmLeft = 3704
              mmTop = 105040
              mmWidth = 69850
              BandType = 4
            end
            object ppDBText12: TppDBText
              UserName = 'DBText9'
              DataField = 'MeioPag'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 26458
              mmTop = 38894
              mmWidth = 43656
              BandType = 4
            end
            object ppLabel14: TppLabel
              UserName = 'Label15'
              AutoSize = False
              Caption = 'Amount:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 4233
              mmLeft = 24077
              mmTop = 53446
              mmWidth = 15610
              BandType = 4
            end
            object ppDBText13: TppDBText
              UserName = 'DBText15'
              DataField = 'ValorNominal'
              DataPipeline = ppPayments
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              SuppressRepeatedValues = True
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 4233
              mmLeft = 41804
              mmTop = 53446
              mmWidth = 28046
              BandType = 4
            end
            object ppRegion2: TppRegion
              UserName = 'Region14'
              Caption = 'Region14'
              Pen.Style = psClear
              Stretch = True
              mmHeight = 33338
              mmLeft = 6615
              mmTop = 265
              mmWidth = 63500
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              object ppDBText14: TppDBText
                UserName = 'DBText17'
                DataField = 'NumDocumento'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Times New Roman'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3969
                mmLeft = 26458
                mmTop = 22754
                mmWidth = 32808
                BandType = 4
              end
              object ppLabel15: TppLabel
                UserName = 'Label27'
                AutoSize = False
                Caption = 'Invoice:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                TextAlignment = taRightJustified
                Transparent = True
                mmHeight = 3969
                mmLeft = 9525
                mmTop = 22754
                mmWidth = 16140
                BandType = 4
              end
              object ppDBText15: TppDBText
                UserName = 'dbHoldDate1'
                DataField = 'TransactionDate'
                DataPipeline = ppStoreAccInfo
                DisplayFormat = 'mm/dd/yyyy hh:nn AM/PM'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Times New Roman'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3969
                mmLeft = 26458
                mmTop = 27781
                mmWidth = 32808
                BandType = 4
              end
              object ppLabel16: TppLabel
                UserName = 'Label28'
                AutoSize = False
                Caption = 'Date:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                TextAlignment = taRightJustified
                Transparent = True
                mmHeight = 3969
                mmLeft = 9525
                mmTop = 27781
                mmWidth = 16140
                BandType = 4
              end
              object ppDBText16: TppDBText
                UserName = 'DBText1'
                AutoSize = True
                DataField = 'Store'
                DataPipeline = PrintReceipt.ppStore
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 12
                Font.Style = [fsBold]
                ParentDataPipeline = False
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStore'
                mmHeight = 5122
                mmLeft = 32803
                mmTop = 1059
                mmWidth = 11388
                BandType = 4
              end
              object ppDBText4: TppDBText
                UserName = 'DBText4'
                DataField = 'StoreName'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 4233
                mmLeft = 9260
                mmTop = 6350
                mmWidth = 52917
                BandType = 4
              end
              object ppDBText5: TppDBText
                UserName = 'DBText5'
                DataField = 'StoreAddress'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 9260
                mmTop = 10848
                mmWidth = 52652
                BandType = 4
              end
              object ppDBText6: TppDBText
                UserName = 'DBText6'
                DataField = 'StoreCity'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taRightJustified
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 9260
                mmTop = 14817
                mmWidth = 21431
                BandType = 4
              end
              object ppDBText7: TppDBText
                UserName = 'DBText201'
                DataField = 'StoreZip'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 40217
                mmTop = 14817
                mmWidth = 20902
                BandType = 4
              end
              object ppDBText8: TppDBText
                UserName = 'DBText8'
                DataField = 'StorePhone'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 9260
                mmTop = 18785
                mmWidth = 52123
                BandType = 4
              end
              object ppLabel8: TppLabel
                UserName = 'Label8'
                Caption = ','
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                mmHeight = 3440
                mmLeft = 30956
                mmTop = 14817
                mmWidth = 1852
                BandType = 4
              end
              object ppDBText9: TppDBText
                UserName = 'DBText2'
                DataField = 'StoreState'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 33338
                mmTop = 14817
                mmWidth = 6085
                BandType = 4
              end
            end
            object ppLabel18: TppLabel
              UserName = 'Label13'
              AutoSize = False
              Caption = 'Card #:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6085
              mmTop = 43392
              mmWidth = 19579
              BandType = 4
            end
            object ppLabel19: TppLabel
              UserName = 'Label26'
              AutoSize = False
              Caption = 'Authorization:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6085
              mmTop = 47890
              mmWidth = 19579
              BandType = 4
            end
            object ppLabel20: TppLabel
              UserName = 'Label29'
              AutoSize = False
              Caption = 'X'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 14
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              mmHeight = 6085
              mmLeft = 3704
              mmTop = 92869
              mmWidth = 4233
              BandType = 4
            end
            object ppDBText19: TppDBText
              UserName = 'DBText10'
              DataField = 'CardNumber'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 26458
              mmTop = 43392
              mmWidth = 43656
              BandType = 4
            end
            object ppDBText20: TppDBText
              UserName = 'DBText102'
              DataField = 'Authorization'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 26458
              mmTop = 47890
              mmWidth = 43656
              BandType = 4
            end
            object ppLabel21: TppLabel
              UserName = 'Label2'
              AutoSize = False
              Caption = 'Type:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6085
              mmTop = 38894
              mmWidth = 19579
              BandType = 4
            end
            object ppLabel22: TppLabel
              UserName = 'Label3'
              Caption = '.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              mmHeight = 3969
              mmLeft = 4763
              mmTop = 134673
              mmWidth = 1058
              BandType = 4
            end
            object ppLabel23: TppLabel
              UserName = 'Label44'
              AutoSize = False
              Caption = 'Merchant ID:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6879
              mmTop = 34131
              mmWidth = 24342
              BandType = 4
            end
            object ppDBText21: TppDBText
              UserName = 'DBText40'
              DataField = 'MerchantID'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 32015
              mmTop = 34131
              mmWidth = 26988
              BandType = 4
            end
            object ppLabel24: TppLabel
              UserName = 'Label47'
              AutoSize = False
              Caption = 'Total:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 4233
              mmLeft = 24342
              mmTop = 59267
              mmWidth = 15610
              BandType = 4
            end
            object ppDBText22: TppDBText
              UserName = 'DBText43'
              DataField = 'ValorNominal'
              DataPipeline = ppPayments
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              SuppressRepeatedValues = True
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 4233
              mmLeft = 41804
              mmTop = 59267
              mmWidth = 28046
              BandType = 4
            end
            object ppDBText23: TppDBText
              UserName = 'DBText41'
              DataField = 'CustomerDocument'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3440
              mmLeft = 3704
              mmTop = 109802
              mmWidth = 69586
              BandType = 4
            end
            object ppDBMemo3: TppDBMemo
              UserName = 'DBMemo6'
              CharWrap = False
              DataField = 'MessageField1'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              TextAlignment = taFullJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 23548
              mmLeft = 6085
              mmTop = 67204
              mmWidth = 64029
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              mmLeading = 0
            end
            object ppDBMemo4: TppDBMemo
              UserName = 'DBMemo5'
              CharWrap = False
              DataField = 'NumMeioQuitPreVisto'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Stretch = True
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 12435
              mmLeft = 4233
              mmTop = 116417
              mmWidth = 69056
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              mmLeading = 0
            end
          end
          object raCodeModule3: TraCodeModule
            ProgramStream = {
              01060F5472614576656E7448616E646C65720B50726F6772616D4E616D650611
              44657461696C4265666F72655072696E740B50726F6772616D54797065070B74
              7450726F63656475726506536F75726365069570726F63656475726520446574
              61696C4265666F72655072696E743B0D0A626567696E0D0A202044657461696C
              2E56697369626C65203A3D20285061796D656E74735B2750617954797065275D
              203D2032293B207B616E6420285061796D656E74735B274461746156656E6369
              6D656E746F275D203E202843757272656E744461746554696D652D3129293B7D
              0D0A656E643B0D0A0D436F6D706F6E656E744E616D65060644657461696C0945
              76656E744E616D65060B4265666F72655072696E74074576656E744944021800
              00}
          end
        end
      end
    end
    object raCodeModule4: TraCodeModule
      ProgramStream = {
        01060D54726156617250726F6772616D094368696C645479706502110B50726F
        6772616D4E616D6506095661726961626C65730B50726F6772616D5479706507
        0B747450726F63656475726506536F75726365064870726F6365647572652056
        61726961626C65733B0D0A7661720D0A202043617465676F7279526563656970
        74203A20537472696E673B200D0A626567696E0D0A0D0A656E643B0D0A0000}
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDesigner: TppDesigner
    AllowDataSettingsChange = True
    Caption = 'Dynamic Reports'
    DataSettings.DatabaseName = 'ADODBConnect'
    DataSettings.SessionType = 'ADOSession'
    DataSettings.AllowEditSQL = True
    DataSettings.CollationType = ctASCII
    DataSettings.DatabaseType = dtMSSQLServer
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqSQL1
    DataSettings.UseDataDictionary = True
    Icon.Data = {
      0000010002002020000001001800A80C0000260000002020000001002000A810
      0000CE0C00002800000020000000400000000100180000000000800C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009D9D9C8988877275
      7569686A73727175767500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000008485847475738A8B8B9B999BA5A3A4A8A7A7A7A6A6A8A8
      A8A6A6A6DCDCDCDFDEDF78787873757500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006D6D6D717272A5A6A5CAC9C9CECECDC5C6C5BABBBBB2B2B2ABABAAA7A7
      A7A1A1A1CCCCCCFFFFFFF8F8F8A3A2A263636300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000686766
      979696CFCDCEE6E5E5E2E2E1D2D2D2C8C8C7BFBEBEB6B6B6AFAFAFA9A9AAA5A5
      A5A1A1A1D5D6D6FFFFFFF7F7F7FFFFFFCDCCCD61616200000000000000000000
      0000000000000000000000000000000000000000000000000000000000E2E0DF
      FFFFFFF3F3F3E5E4E4D9D7D7D1D0CFCBCBC9CBCACBC8C8C7C4C4C4BEBFBFBDBD
      BDB2B3B2A2A2A2EFEFEFFEFEFEF6F6F6FFFFFFF1F0F086868600000000000000
      0000000000000000000000000000000000000000000000000000000000F1F0F1
      F3F2F2EAE9E9E8E8E8E7E6E6E6E6E6E0DFDFCECECEBEBFBEB5B5B5B0B0B0ACAC
      AC9D9D9D6D6D6E858686DCDBDCFFFEFEF7F7F6FFFEFEFEFFFE8D8E8D00000000
      0000000000000000000000000000000000000000000000000000D3D2D2EDEBEB
      F7F7F6F2F1F1E1E1E0C9C8C8BEBEBFBCBCBDBBBABABBBBBBB8B7B7B1B0B1A6A6
      A6A6A7A7C7C7C7B5B4B5939293BBBBBAF9F9F9FBFBFBFFFEFFF6F5F674737200
      0000000000000000000000000000000000000000000000000000DBDBDAE0E1E0
      D0D0D0BBBBBBBCBBBBCFCECEE5E4E4F0EEEEE9E8E9D8D7D8C6C6C7B9B8B8AEAE
      AEA6A6A5BFC0BFD1D4D1D6D7D79394938F8E8CDEDEDEFFFFFFFFFFFFAEAEAA00
      0000000000000000000000000000000000000000000000000000C5C5C5A1A1A1
      CCCCCDE5E4E4F9F8F8F9F8F8F0EFEFE3E3E2D4D3D4C4C3C4BCBBBCBFBDBDC6C6
      C5A3A3A3919191C5C8C5CDCFCEDFE1E0ACADAB7B7A79B3B3B3FFFFFFD8D8D600
      0000000000000000000000000000000000000000000000000000B9BABAD1D1D0
      FFFDFEEFEEEEDBDBDAD6D6D6D4D4D3BFBFBDC5C5C5C9C7C6D0CDCCEAEAEACECD
      CBE1E0E09C9C9CA9A9A8C6C9C6CCCECDE7E8E7D2D2D18181828C8C8BDCDCDC00
      0000000000000000000000000000000000000000000000000000000000C2C0BE
      D2D2D2B2B1B0CDCDCDCFCECDD3D3D1E4E4E4CDCAC9E9E8E7E3E1DFDFDCDCF1F1
      F0D7D4D2E5E4E49C9C9DB4B6B4C4C6C3CACCCAE4E5E4EBEBEB9E9F9E7D7D7E00
      0000000000000000000000000000000000000000000000000000000000ACA8A5
      CCCBCBE0DFDED0CCC9E3E2E1DBDBDAC8C5C5CECFCECECDCBF0F0F0DBD8D8E1DE
      DEEAEAE9E5E4E3E0E1E1B3B3B3E5E6E5D0D2D0D5D6D5E1E2E1F4F5F4AEAEAE00
      0000000000000000000000000000000000000000000000000000000000000000
      AFA9A4D4D4D3E5E5E5DCDAD9DEDDDDD8D6D6CDCDCAD5D5D4D6D4D2F4F3F2E1DF
      DFEFEFF0E1DFDFECECECE7E6E7DCDBDCD1D1D0BDBFBDDBDDDBEDEEEDC8C9C800
      0000000000000000000000000000000000000000000000000000000000000000
      0000009F9C98E3E4E7E1E0DFCCCAC8FAFBFBF2F1F0F7F8F7DDDFE0E8E9EAE2E2
      E3BEBEBE9D9E9E7676776767684B4A4B605F5F3739397A7978DEDEDEDEDEDE00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3AFAEE1E2E3EAEBECDEDFE1ADB0B485888C7575757373727878
      784241421414141111110C0C0E0404044B4B4B3D3E3D1516154E4D4C9A999900
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000A8A6A75B5D5E545250797166AA977EDCC6A2998B7A5256
      5A4B494A0F0F0F1C1C1C2525242525254C4C4C77777633333235363561606000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B7A48FEFD0AAFFDCB2FFD8AFFFD9B1EDD2B0625F
      5D5A5B5D4B4B4A5555555A5A5A5657564F50503D3C3E5453545B5C5B9B9B9B00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E0CDB7FFDAAEFECAA8FED1B1FCD2B5FFE2C3CDC0
      AC949495ADAEAE3D3D3D222222232222161514454544A4A4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFDFC4FFE3CAFADEC5FBDCC4FBE1CCFFFD
      ECC6C4BF0000000000000000000000002529319FA1A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4E6D8FCEBDAF8E9D8F6EADDF9EF
      E2FEFBF4B6B6B6000000000000000000614E30645C4C756C5C877C6800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAD8D5FAF1E5F5EBE1F3EBE0F8F0
      E5FAF9F6ABAEB4000000C29840D09D2EFCB42AEEAC2FF9B927DAAD587F859000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000EFEDECFAF7F5F7F7F6FAFA
      F9F8F7F69FA5AEC7BAA5FFCE44FFC93AFFC338FFC135FFC529BA934E686D7700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000E8E8EAFFFFFFF9FAFBF1F1
      F1E9E7E7BFC1C6B5B3AFC59A43C29645A1844B9D7E469D7D4559504200000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CCCCCCD1D1D10000000000
      000000000000000000009795928E8E90888A9000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
      0FFFFF8003FFFE0001FFF80000FFF800007FF800003FF000001FF000001FF000
      001FF000001FF800001FF800001FFC00001FFE00001FFF00001FFF80001FFFC0
      001FFFC0007FFFE03CFFFFF01C3FFFF0101FFFF8001FFFF8003FFFF9F1FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000002000000040000000010020000000
      00008010000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FDFDFD02FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F1F112E3E4E322DFDFE024D9D8D929CACAC938BBBB
      BB45E8E8E81CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01EEEE
      EE11D8D8D828BDBCBD51A9A8A97A9D9D9C96898887B3727575D269686AE27372
      71F0757675CFA0A1A17FEFEFEF15FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F708C5C5C53A848584857475
      73B98A8B8BD19B999BEBA5A3A4F7A8A7A7FCA7A6A6FFA8A8A8FFA6A6A6FFDCDC
      DCFFDFDEDFFF787878FF737575B2E1E1E122FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E6199FA0A0656D6D6DAC717272E6A5A6A5FFCAC9
      C9FFCECECDFFC5C6C5FFBABBBBFFB2B2B2FFABABAAFFA7A7A7FFA1A1A1FFCCCC
      CCFDFFFFFFFDF8F8F8FFA3A2A2FF636363CBC4C4C33CFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5E5E530686766C3979696FFCFCDCEFFE6E5E5FFE2E2E1FFD2D2
      D2FFC8C8C7FFBFBEBEFFB6B6B6FFAFAFAFFFA9A9AAFFA5A5A5FFA1A1A1FFD5D6
      D6FEFFFFFFFDF7F7F7FDFFFFFFFDCDCCCDFF616162E9A0A0A05FFFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D8D7D764E2E0DFFFFFFFFFFFF3F3F3FFE5E4E4FFD9D7D7FFD1D0
      CFFFCBCBC9FFCBCACBFFC8C8C7FEC4C4C4FFBEBFBFFFBDBDBDFEB2B3B2FFA2A2
      A2FEEFEFEFFDFEFEFEFDF6F6F6FDFFFFFFFDF1F0F0FF868686F2A3A3A35FFEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D5D4D46AF1F0F1FFF3F2F2FFEAE9E9FFE8E8E8FFE7E6E6FFE6E6
      E6FFE0DFDFFECECECEFEBEBFBEFFB5B5B5FEB0B0B0FFACACACFF9D9D9DFE6D6D
      6EFD858686FEDCDBDCFEFFFEFEFDF7F7F6FDFFFEFEFDFEFFFEFF8D8E8DF2A0A0
      A063FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D3D2D280EDEBEBFFF7F7F6FFF2F1F1FFE1E1E0FFC9C8C8FFBEBE
      BFFFBCBCBDFFBBBABAFFBBBBBBFFB8B7B7FFB1B0B1FFA6A6A6FFA6A7A7FEC7C7
      C7FDB5B4B5FD939293FDBBBBBAFDF9F9F9FDFBFBFBFDFFFEFFFDF6F5F6FF7473
      72DBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DBDBDA93E0E1E0FFD0D0D0FFBBBBBBFEBCBBBBFECFCECEFEE5E4
      E4FFF0EEEEFFE9E8E9FFD8D7D8FFC6C6C7FFB9B8B8FFAEAEAEFFA6A6A5FEBFC0
      BFFED1D4D1FFD6D7D7FF939493FE8F8E8CFEDEDEDEFDFFFFFFFDFFFFFFFFAEAE
      AAFAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C59DA1A1A1FFCCCCCDFEE5E4E4FFF9F8F8FFF9F8F8FFF0EF
      EFFFE3E3E2FFD4D3D4FEC4C3C4FEBCBBBCFFBFBDBDFDC6C6C5FEA3A3A3FE9191
      91FEC5C8C5FFCDCFCEFFDFE1E0FEACADABFE7B7A79FDB3B3B3FEFFFFFFFFD8D8
      D6FAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9BABAA5D1D1D0FFFFFDFEFFEFEEEEFEDBDBDAFED6D6D6FED4D4
      D3FDBFBFBDFDC5C5C5FDC9C7C6FDD0CDCCFEEAEAEAFDCECDCBFEE1E0E0FD9C9C
      9CFDA9A9A8FEC6C9C6FFCCCECDFFE7E8E7FFD2D2D1FF818182FF8C8C8BFFDCDC
      DCF9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CDCDCD6BC2C0BEFFD2D2D2FFB2B1B0FDCDCDCDFECFCECDFDD3D3
      D1FDE4E4E4FDCDCAC9FEE9E8E7FDE3E1DFFEDFDCDCFEF1F1F0FDD7D4D2FDE5E4
      E4FD9C9C9DFDB4B6B4FDC4C6C3FECACCCAFFE4E5E4FFEBEBEBFF9E9F9EFF7D7D
      7EEFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F7F70FACA8A59ACCCBCBFEE0DFDEFFD0CCC9FEE3E2E1FDDBDB
      DAFDC8C5C5FDCECFCEFDCECDCBFEF0F0F0FDDBD8D8FEE1DEDEFDEAEAE9FDE5E4
      E3FDE0E1E1FDB3B3B3FDE5E6E5FED0D2D0FFD5D6D5FFE1E2E1FFF4F5F4FFAEAE
      AEEEFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F6F5F410AFA9A4A4D4D4D3FFE5E5E5FEDCDAD9FEDEDD
      DDFDD8D6D6FDCDCDCAFED5D5D4FED6D4D2FEF4F3F2FDE1DFDFFEEFEFF0FDE1DF
      DFFEECECECFDE7E6E7FDDCDBDCFDD1D1D0FDBDBFBDFEDBDDDBFFEDEEEDFFC8C9
      C8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7E5E7259F9C98DAE3E4E7FFE1E0DFFFCCCA
      C8FDFAFBFBFDF2F1F0FDF7F8F7FDDDDFE0FDE8E9EAFDE2E2E3FDBEBEBEFE9D9E
      9EFE767677FE676768FE4B4A4BFE605F5FFE373939FD7A7978FEDEDEDEFFDEDE
      DEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D0CE49B3AFAEBDE1E2E3FBEAEB
      ECFFDEDFE1FDADB0B4FD85888CFD757575FD737372FD787878FE424142FE1414
      14FE111111FE0C0C0EFE040404FE4B4B4BFD3D3E3DFD151615FF4E4D4CFF9A99
      99FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E5E428A8A6A7A25B5D
      5EFE545250FF797166FFAA977EFEDCC6A2FF998B7AFE52565AFD4B494AFF0F0F
      0FFF1C1C1CFD252524FD252525FD4C4C4CFD777776FD333332FF353635FF6160
      60DCFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D3D23EB7A4
      8FEAEFD0AAFFFFDCB2FFFFD8AFFFFFD9B1FFEDD2B0FF625F5DFD5A5B5DF64B4B
      4AFF555555FF5A5A5AFF565756FF4F5050FD3D3C3EFF545354FF5B5C5BFF9B9B
      9B9AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F5F50FE0CD
      B7C3FFDAAEFFFECAA8FFFED1B1FEFCD2B5FEFFE2C3FECDC0ACFE949495AFADAE
      AE8A3D3D3DEE222222FF232222FF161514FF454544DFA4A4A48EC0BFBF66F1F1
      F116FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E3
      E150FFDFC4F6FFE3CAFFFADEC5FEFBDCC4FEFBE1CCFEFFFDECFFC6C4BFE0D5D5
      D541DFDFDF34B9BAB969ABABAC77252931FF9FA1A38BFDFDFD02F0F0F016FAFA
      FA09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF01EDE8E570F4E6D8FBFCEBDAFFF8E9D8FEF6EADDFEF9EFE2FEFEFBF4FFB6B6
      B699FFFFFF00F0F0F014BBBAB95E614E30FF645C4CDB756C5CC7877C68E8B8B8
      BA7CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF01DAD8D5A9FAF1E5FFF5EBE1FEF3EBE0FEF8F0E5FEFAF9F6FFABAE
      B4AEBCB3A673C29840E3D09D2EFEFCB42AFFEEAC2FFFF9B927FFDAAD58FF7F85
      90BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E4E5E566EFEDECFFFAF7F5FEF7F7F6FEFAFAF9FFF8F7F6FF9FA5
      AEB8C7BAA5A1FFCE44FDFFC93AFFFFC338FFFFC135FFFFC529FFBA934EFF686D
      77C1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DFE0E04AE8E8EAFFFFFFFFFFF9FAFBFFF1F1F1FFE9E7E7FFBFC1
      C694B5B3AF8BC59A43FFC29645FFA1844BFF9D7E46FF9D7D45FF595042ED9FA0
      A16CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0F0F020CCCCCC98D1D1D190DCDDDC72E1E1E15DE3E3E34BF8F8
      F813CCCCCC599795929B8E8E908F888A9083999B9E74B2B4B75DCCCCCD3AF9F9
      F906FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFFFFFFF9FFFFFFF9
      FFFFFFF80FFFFF8003FFFE0001FFF80000FFF000007FF000001FF000001FF000
      001FF000001FF000001FF000001FF000001FF000001FF800001FFC00001FFE00
      001FFF00001FFF80001FFF80001FFFC0001FFFC0101FFFE0001FFFF0001FFFF0
      001FFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Position = poScreenCenter
    Report = ppReport
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    WindowState = wsMaximized
    Left = 148
    Top = 57
  end
  object ppExportPDF: TPsRBExportPDF
    ShowSetupDialog = False
    CompressionMethod = cmNormal
    ExportImageFormat = ifJPG
    EncryptionLevel = el40Bit
    Left = 172
    Top = 16
  end
  object quStoreAccInfo: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDStoreAccount'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '    L.NumDocumento,'
      #9'SA.IDStoreAccount,'
      #9'SA.IDStoreAccountUsed,'
      #9'SA.IDPessoa,'
      #9'SA.IDUser,'
      #9'SA.IDStore,'
      #9'SA.IDLancamento,'
      #9'SA.TransactionDate,'
      #9'SA.Amount,'
      #9'S.Name as StoreName,'
      #9'S.IDEstado as StoreState,'
      #9'S.Address as StoreAddress,'
      #9'S.City as StoreCity,'
      #9'S.Zip as StoreZip,'
      #9'S.Telephone as StorePhone,'
      #9'S.Fax as StoreFax,'
      #9'CR.Name as CashRegisterName,'
      #9'P.Pessoa,'
      #9'P.PessoaFirstName,'
      #9'P.PessoaLastName,'
      #9'P.Endereco,'
      #9'P.IDEstado,'
      #9'P.Cidade,'
      #9'P.CEP'
      'FROM'
      #9'Sal_StoreAccount SA (NOLOCK)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = SA.IDStore)'
      
        #9'JOIN Fin_Lancamento L (NOLOCK) ON (SA.IDLancamento = L.IDLancam' +
        'ento)'
      #9'JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = SA.IDPessoa)'
      
        #9'LEFT JOIN CashRegMov CRM (NOLOCK) ON (CRM.IDCashRegMov = L.IDCa' +
        'shRegMov)'
      
        #9'LEFT JOIN CashRegister CR (NOLOCK) ON (CRM.IDCashRegister = CR.' +
        'IDCashRegister)'
      'WHERE'
      #9'SA.IDStoreAccount = :IDStoreAccount')
    Left = 31
    Top = 80
    object quStoreAccInfoIDStoreAccount: TIntegerField
      FieldName = 'IDStoreAccount'
    end
    object quStoreAccInfoIDStoreAccountUsed: TIntegerField
      FieldName = 'IDStoreAccountUsed'
    end
    object quStoreAccInfoIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object quStoreAccInfoIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quStoreAccInfoIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quStoreAccInfoIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quStoreAccInfoTransactionDate: TDateTimeField
      FieldName = 'TransactionDate'
    end
    object quStoreAccInfoAmount: TBCDField
      FieldName = 'Amount'
      Precision = 19
    end
    object quStoreAccInfoStoreName: TStringField
      FieldName = 'StoreName'
      Size = 30
    end
    object quStoreAccInfoStoreState: TStringField
      FieldName = 'StoreState'
      FixedChar = True
      Size = 3
    end
    object quStoreAccInfoStoreAddress: TStringField
      FieldName = 'StoreAddress'
      Size = 80
    end
    object quStoreAccInfoStoreCity: TStringField
      FieldName = 'StoreCity'
      Size = 40
    end
    object quStoreAccInfoStoreZip: TStringField
      FieldName = 'StoreZip'
      FixedChar = True
      Size = 12
    end
    object quStoreAccInfoStorePhone: TStringField
      FieldName = 'StorePhone'
      Size = 40
    end
    object quStoreAccInfoStoreFax: TStringField
      FieldName = 'StoreFax'
      Size = 40
    end
    object quStoreAccInfoCashRegisterName: TStringField
      FieldName = 'CashRegisterName'
      Size = 15
    end
    object quStoreAccInfoPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quStoreAccInfoPessoaFirstName: TStringField
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quStoreAccInfoPessoaLastName: TStringField
      FieldName = 'PessoaLastName'
      Size = 50
    end
    object quStoreAccInfoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object quStoreAccInfoIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quStoreAccInfoCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object quStoreAccInfoCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object quStoreAccInfoNumDocumento: TStringField
      FieldName = 'NumDocumento'
    end
  end
  object dsStoreAccInfo: TDataSource
    DataSet = quStoreAccInfo
    Left = 75
    Top = 178
  end
  object ppStoreAccInfo: TppDBPipeline
    DataSource = dsStoreAccInfo
    UserName = 'StoreAccInfo'
    Left = 71
    Top = 226
  end
  object quPayments: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quPaymentsAfterOpen
    OnCalcFields = quPaymentsCalcFields
    Parameters = <
      item
        Name = 'IDLancamento'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      '-- ppPayments pipe line'
      'SELECT'
      #9'MP.IDMeioPag,'
      #9'MP.MeioPag,'
      #9'MP.Tipo as PayType,'
      #9'MP.DrawerKickOnPay,'
      #9'L.IDLancamento,'
      #9'round(L.ValorNominal, 2) as ValorNominal,'
      #9'L.IDQuitacaoMeioPrevisto ,'
      #9'L.IDLancamentoTipo,'
      #9'L.IDDocumentoTipo,'
      #9'L.IDPreSale,'
      #9'L.CheckNumber,'
      #9'L.IDBankCheck,'
      #9'L.CustomerDocument,'
      #9'L.CustomerName,'
      #9'L.CustomerPhone,'
      #9'L.Historico,'
      #9'L.PaymentPlace,'
      #9'L.NumMeioQuitPreVisto,'
      #9'L.NumMeioQuitPreVisto as MessageField1,'
      #9'L.NumDesdobramento, '
      #9'L.TotalQuitado,'
      '    su.CodSystemUser'
      'FROM'
      #9'Fin_Lancamento L (NOLOCK) '
      
        #9'JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMe' +
        'ioPag)'
      #9'join SystemUser su on su.IDUser = L.IDUsuarioLancamento'
      #9'join UserType ut on ut.IDUserType = su.UserTypeID'
      'WHERE'
      #9'L.IDLancamento = :IDLancamento'
      'ORDER BY'
      #9'MP.MeioPag')
    Left = 95
    Top = 74
    object quPaymentsIDMeioPag: TIntegerField
      FieldName = 'IDMeioPag'
    end
    object quPaymentsMeioPag: TStringField
      FieldName = 'MeioPag'
      Size = 50
    end
    object quPaymentsPayType: TIntegerField
      FieldName = 'PayType'
    end
    object quPaymentsDrawerKickOnPay: TBooleanField
      FieldName = 'DrawerKickOnPay'
    end
    object quPaymentsIDLancamento: TIntegerField
      FieldName = 'IDLancamento'
    end
    object quPaymentsValorNominal: TBCDField
      FieldName = 'ValorNominal'
      ReadOnly = True
      Precision = 19
    end
    object quPaymentsIDQuitacaoMeioPrevisto: TIntegerField
      FieldName = 'IDQuitacaoMeioPrevisto'
    end
    object quPaymentsIDLancamentoTipo: TIntegerField
      FieldName = 'IDLancamentoTipo'
    end
    object quPaymentsIDDocumentoTipo: TIntegerField
      FieldName = 'IDDocumentoTipo'
    end
    object quPaymentsIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quPaymentsCheckNumber: TStringField
      FieldName = 'CheckNumber'
    end
    object quPaymentsIDBankCheck: TIntegerField
      FieldName = 'IDBankCheck'
    end
    object quPaymentsCustomerDocument: TStringField
      FieldName = 'CustomerDocument'
    end
    object quPaymentsCustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 80
    end
    object quPaymentsCustomerPhone: TStringField
      FieldName = 'CustomerPhone'
    end
    object quPaymentsHistorico: TMemoField
      FieldName = 'Historico'
      BlobType = ftMemo
    end
    object quPaymentsPaymentPlace: TIntegerField
      FieldName = 'PaymentPlace'
    end
    object quPaymentsNumMeioQuitPreVisto: TStringField
      FieldName = 'NumMeioQuitPreVisto'
      Size = 255
    end
    object quPaymentsNumDesdobramento: TStringField
      FieldName = 'NumDesdobramento'
    end
    object quPaymentsTotalQuitado: TBCDField
      FieldName = 'TotalQuitado'
      Precision = 19
    end
    object quPaymentsCodSystemUser: TStringField
      FieldName = 'CodSystemUser'
    end
    object quPaymentsMessageField1: TStringField
      FieldName = 'MessageField1'
      Size = 255
    end
    object quPaymentsPaymentPlaceDesc: TStringField
      FieldKind = fkCalculated
      FieldName = 'PaymentPlaceDesc'
      Calculated = True
    end
    object quPaymentsChange: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Change'
      Calculated = True
    end
    object quPaymentsAuthorization: TStringField
      FieldKind = fkCalculated
      FieldName = 'Authorization'
      Size = 30
      Calculated = True
    end
    object quPaymentsCardNumber: TStringField
      FieldKind = fkCalculated
      FieldName = 'CardNumber'
      Calculated = True
    end
    object quPaymentsRemains: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Remains'
      Calculated = True
    end
    object quPaymentsMerchantID: TStringField
      FieldKind = fkCalculated
      FieldName = 'MerchantID'
      Calculated = True
    end
    object quPaymentsIsChip: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'IsChip'
      Calculated = True
    end
    object quPaymentsAppLabel: TStringField
      FieldKind = fkCalculated
      FieldName = 'AppLabel'
      Calculated = True
    end
    object quPaymentsLabelAID: TStringField
      FieldKind = fkCalculated
      FieldName = 'LabelAID'
      Calculated = True
    end
    object quPaymentsLabelTVR: TStringField
      FieldKind = fkCalculated
      FieldName = 'LabelTVR'
      Calculated = True
    end
    object quPaymentsLabelIAD: TStringField
      FieldKind = fkCalculated
      FieldName = 'LabelIAD'
      Calculated = True
    end
  end
  object ppPayments: TppDBPipeline
    DataSource = dsPayments
    UserName = 'payments'
    Left = 156
    Top = 226
  end
  object dsPayments: TDataSource
    DataSet = quPayments
    Left = 160
    Top = 178
  end
  object ppReportBack: TppReport
    AutoStop = False
    DataPipeline = PrintReceipt.ppPreSaleInfo
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Custom'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 508
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 508001
    PrinterSetup.mmPaperWidth = 88900
    PrinterSetup.PaperSize = 256
    Template.FileName = 
      'C:\Users\OFFICE\Documents\My Dropbox\MainRetail_Reports\V5_Recei' +
      'pts\Receipts\Standard_StoreAcc_Receipt_Footer.rtm'
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'Screen'
    Icon.Data = {
      0000010002002020000001001800A80C0000260000002020000001002000A810
      0000CE0C00002800000020000000400000000100180000000000800C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009D9D9C8988877275
      7569686A73727175767500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000008485847475738A8B8B9B999BA5A3A4A8A7A7A7A6A6A8A8
      A8A6A6A6DCDCDCDFDEDF78787873757500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006D6D6D717272A5A6A5CAC9C9CECECDC5C6C5BABBBBB2B2B2ABABAAA7A7
      A7A1A1A1CCCCCCFFFFFFF8F8F8A3A2A263636300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000686766
      979696CFCDCEE6E5E5E2E2E1D2D2D2C8C8C7BFBEBEB6B6B6AFAFAFA9A9AAA5A5
      A5A1A1A1D5D6D6FFFFFFF7F7F7FFFFFFCDCCCD61616200000000000000000000
      0000000000000000000000000000000000000000000000000000000000E2E0DF
      FFFFFFF3F3F3E5E4E4D9D7D7D1D0CFCBCBC9CBCACBC8C8C7C4C4C4BEBFBFBDBD
      BDB2B3B2A2A2A2EFEFEFFEFEFEF6F6F6FFFFFFF1F0F086868600000000000000
      0000000000000000000000000000000000000000000000000000000000F1F0F1
      F3F2F2EAE9E9E8E8E8E7E6E6E6E6E6E0DFDFCECECEBEBFBEB5B5B5B0B0B0ACAC
      AC9D9D9D6D6D6E858686DCDBDCFFFEFEF7F7F6FFFEFEFEFFFE8D8E8D00000000
      0000000000000000000000000000000000000000000000000000D3D2D2EDEBEB
      F7F7F6F2F1F1E1E1E0C9C8C8BEBEBFBCBCBDBBBABABBBBBBB8B7B7B1B0B1A6A6
      A6A6A7A7C7C7C7B5B4B5939293BBBBBAF9F9F9FBFBFBFFFEFFF6F5F674737200
      0000000000000000000000000000000000000000000000000000DBDBDAE0E1E0
      D0D0D0BBBBBBBCBBBBCFCECEE5E4E4F0EEEEE9E8E9D8D7D8C6C6C7B9B8B8AEAE
      AEA6A6A5BFC0BFD1D4D1D6D7D79394938F8E8CDEDEDEFFFFFFFFFFFFAEAEAA00
      0000000000000000000000000000000000000000000000000000C5C5C5A1A1A1
      CCCCCDE5E4E4F9F8F8F9F8F8F0EFEFE3E3E2D4D3D4C4C3C4BCBBBCBFBDBDC6C6
      C5A3A3A3919191C5C8C5CDCFCEDFE1E0ACADAB7B7A79B3B3B3FFFFFFD8D8D600
      0000000000000000000000000000000000000000000000000000B9BABAD1D1D0
      FFFDFEEFEEEEDBDBDAD6D6D6D4D4D3BFBFBDC5C5C5C9C7C6D0CDCCEAEAEACECD
      CBE1E0E09C9C9CA9A9A8C6C9C6CCCECDE7E8E7D2D2D18181828C8C8BDCDCDC00
      0000000000000000000000000000000000000000000000000000000000C2C0BE
      D2D2D2B2B1B0CDCDCDCFCECDD3D3D1E4E4E4CDCAC9E9E8E7E3E1DFDFDCDCF1F1
      F0D7D4D2E5E4E49C9C9DB4B6B4C4C6C3CACCCAE4E5E4EBEBEB9E9F9E7D7D7E00
      0000000000000000000000000000000000000000000000000000000000ACA8A5
      CCCBCBE0DFDED0CCC9E3E2E1DBDBDAC8C5C5CECFCECECDCBF0F0F0DBD8D8E1DE
      DEEAEAE9E5E4E3E0E1E1B3B3B3E5E6E5D0D2D0D5D6D5E1E2E1F4F5F4AEAEAE00
      0000000000000000000000000000000000000000000000000000000000000000
      AFA9A4D4D4D3E5E5E5DCDAD9DEDDDDD8D6D6CDCDCAD5D5D4D6D4D2F4F3F2E1DF
      DFEFEFF0E1DFDFECECECE7E6E7DCDBDCD1D1D0BDBFBDDBDDDBEDEEEDC8C9C800
      0000000000000000000000000000000000000000000000000000000000000000
      0000009F9C98E3E4E7E1E0DFCCCAC8FAFBFBF2F1F0F7F8F7DDDFE0E8E9EAE2E2
      E3BEBEBE9D9E9E7676776767684B4A4B605F5F3739397A7978DEDEDEDEDEDE00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3AFAEE1E2E3EAEBECDEDFE1ADB0B485888C7575757373727878
      784241421414141111110C0C0E0404044B4B4B3D3E3D1516154E4D4C9A999900
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000A8A6A75B5D5E545250797166AA977EDCC6A2998B7A5256
      5A4B494A0F0F0F1C1C1C2525242525254C4C4C77777633333235363561606000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B7A48FEFD0AAFFDCB2FFD8AFFFD9B1EDD2B0625F
      5D5A5B5D4B4B4A5555555A5A5A5657564F50503D3C3E5453545B5C5B9B9B9B00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E0CDB7FFDAAEFECAA8FED1B1FCD2B5FFE2C3CDC0
      AC949495ADAEAE3D3D3D222222232222161514454544A4A4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFDFC4FFE3CAFADEC5FBDCC4FBE1CCFFFD
      ECC6C4BF0000000000000000000000002529319FA1A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4E6D8FCEBDAF8E9D8F6EADDF9EF
      E2FEFBF4B6B6B6000000000000000000614E30645C4C756C5C877C6800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAD8D5FAF1E5F5EBE1F3EBE0F8F0
      E5FAF9F6ABAEB4000000C29840D09D2EFCB42AEEAC2FF9B927DAAD587F859000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000EFEDECFAF7F5F7F7F6FAFA
      F9F8F7F69FA5AEC7BAA5FFCE44FFC93AFFC338FFC135FFC529BA934E686D7700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000E8E8EAFFFFFFF9FAFBF1F1
      F1E9E7E7BFC1C6B5B3AFC59A43C29645A1844B9D7E469D7D4559504200000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CCCCCCD1D1D10000000000
      000000000000000000009795928E8E90888A9000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
      0FFFFF8003FFFE0001FFF80000FFF800007FF800003FF000001FF000001FF000
      001FF000001FF800001FF800001FFC00001FFE00001FFF00001FFF80001FFFC0
      001FFFC0007FFFE03CFFFFF01C3FFFF0101FFFF8001FFFF8003FFFF9F1FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000002000000040000000010020000000
      00008010000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FDFDFD02FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F1F112E3E4E322DFDFE024D9D8D929CACAC938BBBB
      BB45E8E8E81CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01EEEE
      EE11D8D8D828BDBCBD51A9A8A97A9D9D9C96898887B3727575D269686AE27372
      71F0757675CFA0A1A17FEFEFEF15FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F708C5C5C53A848584857475
      73B98A8B8BD19B999BEBA5A3A4F7A8A7A7FCA7A6A6FFA8A8A8FFA6A6A6FFDCDC
      DCFFDFDEDFFF787878FF737575B2E1E1E122FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E6199FA0A0656D6D6DAC717272E6A5A6A5FFCAC9
      C9FFCECECDFFC5C6C5FFBABBBBFFB2B2B2FFABABAAFFA7A7A7FFA1A1A1FFCCCC
      CCFDFFFFFFFDF8F8F8FFA3A2A2FF636363CBC4C4C33CFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5E5E530686766C3979696FFCFCDCEFFE6E5E5FFE2E2E1FFD2D2
      D2FFC8C8C7FFBFBEBEFFB6B6B6FFAFAFAFFFA9A9AAFFA5A5A5FFA1A1A1FFD5D6
      D6FEFFFFFFFDF7F7F7FDFFFFFFFDCDCCCDFF616162E9A0A0A05FFFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D8D7D764E2E0DFFFFFFFFFFFF3F3F3FFE5E4E4FFD9D7D7FFD1D0
      CFFFCBCBC9FFCBCACBFFC8C8C7FEC4C4C4FFBEBFBFFFBDBDBDFEB2B3B2FFA2A2
      A2FEEFEFEFFDFEFEFEFDF6F6F6FDFFFFFFFDF1F0F0FF868686F2A3A3A35FFEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D5D4D46AF1F0F1FFF3F2F2FFEAE9E9FFE8E8E8FFE7E6E6FFE6E6
      E6FFE0DFDFFECECECEFEBEBFBEFFB5B5B5FEB0B0B0FFACACACFF9D9D9DFE6D6D
      6EFD858686FEDCDBDCFEFFFEFEFDF7F7F6FDFFFEFEFDFEFFFEFF8D8E8DF2A0A0
      A063FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D3D2D280EDEBEBFFF7F7F6FFF2F1F1FFE1E1E0FFC9C8C8FFBEBE
      BFFFBCBCBDFFBBBABAFFBBBBBBFFB8B7B7FFB1B0B1FFA6A6A6FFA6A7A7FEC7C7
      C7FDB5B4B5FD939293FDBBBBBAFDF9F9F9FDFBFBFBFDFFFEFFFDF6F5F6FF7473
      72DBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DBDBDA93E0E1E0FFD0D0D0FFBBBBBBFEBCBBBBFECFCECEFEE5E4
      E4FFF0EEEEFFE9E8E9FFD8D7D8FFC6C6C7FFB9B8B8FFAEAEAEFFA6A6A5FEBFC0
      BFFED1D4D1FFD6D7D7FF939493FE8F8E8CFEDEDEDEFDFFFFFFFDFFFFFFFFAEAE
      AAFAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C59DA1A1A1FFCCCCCDFEE5E4E4FFF9F8F8FFF9F8F8FFF0EF
      EFFFE3E3E2FFD4D3D4FEC4C3C4FEBCBBBCFFBFBDBDFDC6C6C5FEA3A3A3FE9191
      91FEC5C8C5FFCDCFCEFFDFE1E0FEACADABFE7B7A79FDB3B3B3FEFFFFFFFFD8D8
      D6FAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9BABAA5D1D1D0FFFFFDFEFFEFEEEEFEDBDBDAFED6D6D6FED4D4
      D3FDBFBFBDFDC5C5C5FDC9C7C6FDD0CDCCFEEAEAEAFDCECDCBFEE1E0E0FD9C9C
      9CFDA9A9A8FEC6C9C6FFCCCECDFFE7E8E7FFD2D2D1FF818182FF8C8C8BFFDCDC
      DCF9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CDCDCD6BC2C0BEFFD2D2D2FFB2B1B0FDCDCDCDFECFCECDFDD3D3
      D1FDE4E4E4FDCDCAC9FEE9E8E7FDE3E1DFFEDFDCDCFEF1F1F0FDD7D4D2FDE5E4
      E4FD9C9C9DFDB4B6B4FDC4C6C3FECACCCAFFE4E5E4FFEBEBEBFF9E9F9EFF7D7D
      7EEFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F7F70FACA8A59ACCCBCBFEE0DFDEFFD0CCC9FEE3E2E1FDDBDB
      DAFDC8C5C5FDCECFCEFDCECDCBFEF0F0F0FDDBD8D8FEE1DEDEFDEAEAE9FDE5E4
      E3FDE0E1E1FDB3B3B3FDE5E6E5FED0D2D0FFD5D6D5FFE1E2E1FFF4F5F4FFAEAE
      AEEEFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F6F5F410AFA9A4A4D4D4D3FFE5E5E5FEDCDAD9FEDEDD
      DDFDD8D6D6FDCDCDCAFED5D5D4FED6D4D2FEF4F3F2FDE1DFDFFEEFEFF0FDE1DF
      DFFEECECECFDE7E6E7FDDCDBDCFDD1D1D0FDBDBFBDFEDBDDDBFFEDEEEDFFC8C9
      C8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7E5E7259F9C98DAE3E4E7FFE1E0DFFFCCCA
      C8FDFAFBFBFDF2F1F0FDF7F8F7FDDDDFE0FDE8E9EAFDE2E2E3FDBEBEBEFE9D9E
      9EFE767677FE676768FE4B4A4BFE605F5FFE373939FD7A7978FEDEDEDEFFDEDE
      DEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D0CE49B3AFAEBDE1E2E3FBEAEB
      ECFFDEDFE1FDADB0B4FD85888CFD757575FD737372FD787878FE424142FE1414
      14FE111111FE0C0C0EFE040404FE4B4B4BFD3D3E3DFD151615FF4E4D4CFF9A99
      99FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E5E428A8A6A7A25B5D
      5EFE545250FF797166FFAA977EFEDCC6A2FF998B7AFE52565AFD4B494AFF0F0F
      0FFF1C1C1CFD252524FD252525FD4C4C4CFD777776FD333332FF353635FF6160
      60DCFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D3D23EB7A4
      8FEAEFD0AAFFFFDCB2FFFFD8AFFFFFD9B1FFEDD2B0FF625F5DFD5A5B5DF64B4B
      4AFF555555FF5A5A5AFF565756FF4F5050FD3D3C3EFF545354FF5B5C5BFF9B9B
      9B9AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F5F50FE0CD
      B7C3FFDAAEFFFECAA8FFFED1B1FEFCD2B5FEFFE2C3FECDC0ACFE949495AFADAE
      AE8A3D3D3DEE222222FF232222FF161514FF454544DFA4A4A48EC0BFBF66F1F1
      F116FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E3
      E150FFDFC4F6FFE3CAFFFADEC5FEFBDCC4FEFBE1CCFEFFFDECFFC6C4BFE0D5D5
      D541DFDFDF34B9BAB969ABABAC77252931FF9FA1A38BFDFDFD02F0F0F016FAFA
      FA09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF01EDE8E570F4E6D8FBFCEBDAFFF8E9D8FEF6EADDFEF9EFE2FEFEFBF4FFB6B6
      B699FFFFFF00F0F0F014BBBAB95E614E30FF645C4CDB756C5CC7877C68E8B8B8
      BA7CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF01DAD8D5A9FAF1E5FFF5EBE1FEF3EBE0FEF8F0E5FEFAF9F6FFABAE
      B4AEBCB3A673C29840E3D09D2EFEFCB42AFFEEAC2FFFF9B927FFDAAD58FF7F85
      90BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E4E5E566EFEDECFFFAF7F5FEF7F7F6FEFAFAF9FFF8F7F6FF9FA5
      AEB8C7BAA5A1FFCE44FDFFC93AFFFFC338FFFFC135FFFFC529FFBA934EFF686D
      77C1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DFE0E04AE8E8EAFFFFFFFFFFF9FAFBFFF1F1F1FFE9E7E7FFBFC1
      C694B5B3AF8BC59A43FFC29645FFA1844BFF9D7E46FF9D7D45FF595042ED9FA0
      A16CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0F0F020CCCCCC98D1D1D190DCDDDC72E1E1E15DE3E3E34BF8F8
      F813CCCCCC599795929B8E8E908F888A9083999B9E74B2B4B75DCCCCCD3AF9F9
      F906FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFFFFFFF9FFFFFFF9
      FFFFFFF80FFFFF8003FFFE0001FFF80000FFF000007FF000001FF000001FF000
      001FF000001FF000001FF000001FF000001FF000001FF800001FFC00001FFE00
      001FFF00001FFF80001FFF80001FFFC0001FFFC0101FFFE0001FFFF0001FFFF0
      001FFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zs100Percent
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 217
    Top = 127
    Version = '7.02'
    mmColumnWidth = 76200
    DataPipelineName = 'ppPreSaleInfo'
    object ppDetailBand: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppSubReport: TppSubReport
        UserName = 'SubReport3'
        ExpandAll = True
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        ParentPrinterSetup = False
        TraverseAllData = False
        DataPipelineName = 'ppPayments'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 794
        mmWidth = 82042
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport: TppChildReport
          AutoStop = False
          DataPipeline = ppPayments
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Custom'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 508
          PrinterSetup.mmMarginRight = 0
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 76200
          PrinterSetup.PaperSize = 256
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppPayments'
          object ppDetailBandBack: TppDetailBand
            PrintHeight = phDynamic
            mmBottomOffset = 0
            mmHeight = 139436
            mmPrintPosition = 0
            object ppLine1: TppLine
              UserName = 'Line3'
              Pen.Style = psDot
              Weight = 0.750000000000000000
              mmHeight = 2910
              mmLeft = 7938
              mmTop = 99484
              mmWidth = 65617
              BandType = 4
            end
            object ppLabel1: TppLabel
              UserName = 'ppLabel2'
              AutoSize = False
              Caption = 'Customer Signature'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taCentered
              Transparent = True
              mmHeight = 3440
              mmLeft = 3704
              mmTop = 105040
              mmWidth = 69850
              BandType = 4
            end
            object ppDBText1: TppDBText
              UserName = 'DBText9'
              DataField = 'MeioPag'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 26458
              mmTop = 38894
              mmWidth = 43656
              BandType = 4
            end
            object ppLabel2: TppLabel
              UserName = 'Label15'
              AutoSize = False
              Caption = 'Amount:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 4233
              mmLeft = 24077
              mmTop = 53446
              mmWidth = 15610
              BandType = 4
            end
            object ppDBText2: TppDBText
              UserName = 'DBText15'
              DataField = 'ValorNominal'
              DataPipeline = ppPayments
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              SuppressRepeatedValues = True
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 4233
              mmLeft = 41804
              mmTop = 53446
              mmWidth = 28046
              BandType = 4
            end
            object ppRegion1: TppRegion
              UserName = 'Region14'
              Caption = 'Region14'
              Pen.Style = psClear
              Stretch = True
              mmHeight = 33338
              mmLeft = 6615
              mmTop = 265
              mmWidth = 63500
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              object ppDBText3: TppDBText
                UserName = 'DBText17'
                DataField = 'NumDocumento'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Times New Roman'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3969
                mmLeft = 26458
                mmTop = 22754
                mmWidth = 32808
                BandType = 4
              end
              object ppLabel4: TppLabel
                UserName = 'Label27'
                AutoSize = False
                Caption = 'Invoice:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                TextAlignment = taRightJustified
                Transparent = True
                mmHeight = 3969
                mmLeft = 9525
                mmTop = 22754
                mmWidth = 16140
                BandType = 4
              end
              object ppDBText10: TppDBText
                UserName = 'dbHoldDate1'
                DataField = 'TransactionDate'
                DataPipeline = ppStoreAccInfo
                DisplayFormat = 'mm/dd/yyyy hh:nn AM/PM'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Times New Roman'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3969
                mmLeft = 26458
                mmTop = 27781
                mmWidth = 32808
                BandType = 4
              end
              object ppLabel5: TppLabel
                UserName = 'Label28'
                AutoSize = False
                Caption = 'Date:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                TextAlignment = taRightJustified
                Transparent = True
                mmHeight = 3969
                mmLeft = 9525
                mmTop = 27781
                mmWidth = 16140
                BandType = 4
              end
              object ppDBText11: TppDBText
                UserName = 'DBText1'
                AutoSize = True
                DataField = 'Store'
                DataPipeline = PrintReceipt.ppStore
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 12
                Font.Style = [fsBold]
                ParentDataPipeline = False
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStore'
                mmHeight = 5122
                mmLeft = 32803
                mmTop = 1059
                mmWidth = 11388
                BandType = 4
              end
              object ppDBText17: TppDBText
                UserName = 'DBText4'
                DataField = 'StoreName'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 4233
                mmLeft = 9260
                mmTop = 6350
                mmWidth = 52917
                BandType = 4
              end
              object ppDBText18: TppDBText
                UserName = 'DBText5'
                DataField = 'StoreAddress'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 9260
                mmTop = 10848
                mmWidth = 52652
                BandType = 4
              end
              object ppDBText24: TppDBText
                UserName = 'DBText6'
                DataField = 'StoreCity'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taRightJustified
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 9260
                mmTop = 14817
                mmWidth = 21431
                BandType = 4
              end
              object ppDBText25: TppDBText
                UserName = 'DBText201'
                DataField = 'StoreZip'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 40217
                mmTop = 14817
                mmWidth = 20902
                BandType = 4
              end
              object ppDBText26: TppDBText
                UserName = 'DBText8'
                DataField = 'StorePhone'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 9260
                mmTop = 18785
                mmWidth = 52123
                BandType = 4
              end
              object ppLabel6: TppLabel
                UserName = 'Label8'
                Caption = ','
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                mmHeight = 3440
                mmLeft = 30956
                mmTop = 14817
                mmWidth = 1852
                BandType = 4
              end
              object ppDBText27: TppDBText
                UserName = 'DBText2'
                DataField = 'StoreState'
                DataPipeline = ppStoreAccInfo
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                ParentDataPipeline = False
                SuppressRepeatedValues = True
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppStoreAccInfo'
                mmHeight = 3440
                mmLeft = 33338
                mmTop = 14817
                mmWidth = 6085
                BandType = 4
              end
            end
            object ppLabel7: TppLabel
              UserName = 'Label13'
              AutoSize = False
              Caption = 'Card #:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6085
              mmTop = 43392
              mmWidth = 19579
              BandType = 4
            end
            object ppLabel9: TppLabel
              UserName = 'Label26'
              AutoSize = False
              Caption = 'Authorization:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6085
              mmTop = 47890
              mmWidth = 19579
              BandType = 4
            end
            object ppLabel10: TppLabel
              UserName = 'Label29'
              AutoSize = False
              Caption = 'X'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 14
              Font.Style = [fsBold]
              TextAlignment = taCentered
              Transparent = True
              mmHeight = 6085
              mmLeft = 3704
              mmTop = 92869
              mmWidth = 4233
              BandType = 4
            end
            object ppDBText28: TppDBText
              UserName = 'DBText10'
              DataField = 'CardNumber'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 26458
              mmTop = 43392
              mmWidth = 43656
              BandType = 4
            end
            object ppDBText29: TppDBText
              UserName = 'DBText102'
              DataField = 'Authorization'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 26458
              mmTop = 47890
              mmWidth = 43656
              BandType = 4
            end
            object ppLabel11: TppLabel
              UserName = 'Label2'
              AutoSize = False
              Caption = 'Type:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6085
              mmTop = 38894
              mmWidth = 19579
              BandType = 4
            end
            object ppLabel12: TppLabel
              UserName = 'Label3'
              Caption = '.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              mmHeight = 3969
              mmLeft = 4763
              mmTop = 134673
              mmWidth = 1058
              BandType = 4
            end
            object ppLabel17: TppLabel
              UserName = 'Label44'
              AutoSize = False
              Caption = 'Merchant ID:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3969
              mmLeft = 6879
              mmTop = 34131
              mmWidth = 24342
              BandType = 4
            end
            object ppDBText30: TppDBText
              UserName = 'DBText40'
              DataField = 'MerchantID'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3969
              mmLeft = 32015
              mmTop = 34131
              mmWidth = 26988
              BandType = 4
            end
            object ppLabel25: TppLabel
              UserName = 'Label47'
              AutoSize = False
              Caption = 'Total:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 4233
              mmLeft = 24342
              mmTop = 59267
              mmWidth = 15610
              BandType = 4
            end
            object ppDBText31: TppDBText
              UserName = 'DBText43'
              DataField = 'ValorNominal'
              DataPipeline = ppPayments
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 10
              Font.Style = [fsBold]
              SuppressRepeatedValues = True
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 4233
              mmLeft = 41804
              mmTop = 59267
              mmWidth = 28046
              BandType = 4
            end
            object ppDBText32: TppDBText
              UserName = 'DBText41'
              DataField = 'CustomerDocument'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              TextAlignment = taCentered
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 3440
              mmLeft = 3704
              mmTop = 109802
              mmWidth = 69586
              BandType = 4
            end
            object ppDBMemo1: TppDBMemo
              UserName = 'DBMemo6'
              CharWrap = False
              DataField = 'MessageField1'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              SuppressRepeatedValues = True
              TextAlignment = taFullJustified
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 23548
              mmLeft = 6085
              mmTop = 67204
              mmWidth = 64029
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              mmLeading = 0
            end
            object ppDBMemo2: TppDBMemo
              UserName = 'DBMemo5'
              CharWrap = False
              DataField = 'NumMeioQuitPreVisto'
              DataPipeline = ppPayments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 8
              Font.Style = []
              Stretch = True
              SuppressRepeatedValues = True
              Transparent = True
              DataPipelineName = 'ppPayments'
              mmHeight = 12435
              mmLeft = 4233
              mmTop = 116417
              mmWidth = 69056
              BandType = 4
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
              mmLeading = 0
            end
          end
          object raCodeModule1: TraCodeModule
            ProgramStream = {
              01060F5472614576656E7448616E646C65720B50726F6772616D4E616D650611
              44657461696C4265666F72655072696E740B50726F6772616D54797065070B74
              7450726F63656475726506536F75726365069570726F63656475726520446574
              61696C4265666F72655072696E743B0D0A626567696E0D0A202044657461696C
              2E56697369626C65203A3D20285061796D656E74735B2750617954797065275D
              203D2032293B207B616E6420285061796D656E74735B274461746156656E6369
              6D656E746F275D203E202843757272656E744461746554696D652D3129293B7D
              0D0A656E643B0D0A0D436F6D706F6E656E744E616D65060644657461696C0945
              76656E744E616D65060B4265666F72655072696E74074576656E744944021800
              00}
          end
        end
      end
    end
    object raCodeModule2: TraCodeModule
      ProgramStream = {
        01060D54726156617250726F6772616D094368696C645479706502110B50726F
        6772616D4E616D6506095661726961626C65730B50726F6772616D5479706507
        0B747450726F63656475726506536F75726365064870726F6365647572652056
        61726961626C65733B0D0A7661720D0A202043617465676F7279526563656970
        74203A20537472696E673B200D0A626567696E0D0A0D0A656E643B0D0A0000}
    end
    object ppParameterList2: TppParameterList
    end
  end
end
