inherited frmAddTagModel: TfrmAddTagModel
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited lblMenu: TLabel
      Caption = 'Inventory'
    end
    inherited lblSubMenu: TLabelEffect
      Caption = 'Tag Maintenace'
    end
  end
  inherited grdPromoPrizeItem: TcxGrid
    inherited grdPromoPrizeItemDB: TcxGridDBTableView
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
    end
  end
end
