inherited frmLanguageMR: TfrmLanguageMR
  Top = 179
  ClientHeight = 186
  Color = clMenu
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label3: TLabel
    Left = 218
  end
  inherited Label5: TLabel
    Caption = 
      'MainRetail supports multi-language. You can customize your appli' +
      'cation with the language you wish. '
  end
  inherited btnClose: TButton
    Left = 272
    Top = 152
    Width = 72
  end
  inherited btnPath: TButton
    Left = 195
    Top = 152
    Width = 72
  end
  inherited btnDownload: TButton
    Left = 118
    Top = 152
    Width = 72
  end
  object btnSetup: TButton [7]
    Left = 41
    Top = 152
    Width = 72
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Set language'
    TabOrder = 3
    OnClick = btnSetupClick
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_frmLanguageMR.sil'
  end
end
