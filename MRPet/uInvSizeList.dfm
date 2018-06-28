inherited InvSizeList: TInvSizeList
  Caption = 'InvSizeList'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTop: TPanel
    inherited pnlFilter: TPanel
      object scCategoria: TmrSuperCombo
        Left = 100
        Top = 8
        Width = 145
        Height = 21
        Properties.ListColumns = <>
        Properties.ListOptions.ShowHeader = False
        Properties.ReadOnly = False
        Properties.Buttons = <
          item
            Default = True
          end
          item
            Kind = bkEllipsis
          end>
        TabOrder = 1
        DisableButtons = False
        ConnectionListName = 'LookupInvConn'
        ProviderListName = 'dspLuCategory'
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.BiDiMode = bdRightToLeft
        EditLabel.Caption = 'Category'
        EditLabel.ParentBiDiMode = False
        LabelPosition = lpLeft
        LabelSpacing = 6
        Required = False
        Locked = False
      end
    end
  end
  inherited pnlClient: TPanel
    inherited grdList: TcxGrid
      inherited grdListDBTableView: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
      end
    end
  end
  inherited dsList: TDataSource
    Left = 112
    Top = 192
  end
  inherited tmList: TTimer
    Left = 112
    Top = 248
  end
  inherited ConfigList: TmrConfigList
    AutoOpen = True
    Connection = 'PetCenterConn'
    ProviderName = 'dspInvSize'
    AutCreateGridColumns = True
    FchClassName = 'TInvSizeFch'
    CommandOptions = [tcoInsert, tcoOpen, tcoDelete]
  end
end
