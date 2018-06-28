inherited frmListOpenPO: TfrmListOpenPO
  Left = 307
  Top = 161
  Caption = 'List Open PO'#180's'
  ClientHeight = 462
  ClientWidth = 739
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 739
    inherited Image1: TImage
      Width = 465
    end
    inherited lblMenu: TLabel
      Left = 478
    end
    inherited EspacamentoSuperior: TPanel
      Width = 739
      inherited EEE: TPanel
        Width = 739
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 692
    end
  end
  inherited Panel1: TPanel
    Top = 421
    Width = 739
    inherited EspacamentoInferior: TPanel
      Width = 739
      inherited Panel3: TPanel
        Width = 739
      end
    end
    inherited hhh: TPanel
      Left = 518
    end
  end
  inherited pnlKey: TPanel
    Width = 739
    inherited Panel4: TPanel
      Width = 739
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 739
      Height = 36
      Align = alTop
      TabOrder = 1
      object chkUpdate: TcxCheckBox
        Left = 7
        Top = 8
        Width = 121
        Height = 21
        ParentBackground = True
        Properties.Caption = 'Update All'
        Properties.DisplayUnchecked = 'False'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        TabOrder = 0
        OnClick = chkUpdateClick
      end
    end
  end
  inherited pnlDetail: TPanel
    Width = 733
    Height = 341
    object cxGridOpenPOs: TcxGrid
      Left = 0
      Top = 0
      Width = 733
      Height = 341
      Align = alClient
      TabOrder = 0
      object cxGridOpenPOsDBTableView: TcxGridDBTableView
        DataController.DataSource = dsOpenPO
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object cxGridOpenPOsDBTableViewDBColumn1: TcxGridDBColumn
          Caption = 'Update'
          DataBinding.FieldName = 'Upd'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Width = 69
        end
        object cxGridOpenPOsDBTableViewDBColumn2: TcxGridDBColumn
          Caption = 'PO'
          DataBinding.FieldName = 'IdPO'
          Width = 60
        end
        object cxGridOpenPOsDBTableViewDBColumn3: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 99
        end
        object cxGridOpenPOsDBTableViewDBColumn4: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 210
        end
        object cxGridOpenPOsDBTableViewDBColumn5: TcxGridDBColumn
          Caption = 'Cost'
          DataBinding.FieldName = 'CostPrice'
          Width = 87
        end
        object cxGridOpenPOsDBTableViewDBColumn6: TcxGridDBColumn
          Caption = 'Old Price'
          DataBinding.FieldName = 'OldPrice'
          Width = 95
        end
        object cxGridOpenPOsDBTableViewDBColumn7: TcxGridDBColumn
          Caption = 'New Price'
          DataBinding.FieldName = 'NewPrice'
          Width = 91
        end
      end
      object cxGridOpenPOsLevel: TcxGridLevel
        GridView = cxGridOpenPOsDBTableView
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 341
  end
  inherited EspacamentoDireito: TPanel
    Left = 736
    Height = 341
  end
  object dsOpenPO: TDataSource
    Left = 658
    Top = 215
  end
end
