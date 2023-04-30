object frmGames: TfrmGames
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Games'
  ClientHeight = 424
  ClientWidth = 559
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblGames: TLabel
    Left = 8
    Top = 8
    Width = 61
    Height = 23
    Caption = 'Games'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object lblFilterBy: TLabel
    Left = 8
    Top = 295
    Width = 57
    Height = 16
    Caption = 'Filter By:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object lblDateFilter: TLabel
    Left = 8
    Top = 351
    Width = 26
    Height = 15
    Caption = 'Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object lblSortBy: TLabel
    Left = 408
    Top = 295
    Width = 51
    Height = 16
    Caption = 'Sort By:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object btnSelect: TButton
    Left = 470
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 0
    OnClick = btnSelectClick
  end
  object dbgGames: TDBGrid
    Left = 8
    Top = 37
    Width = 543
    Height = 252
    DataSource = dmChess.dsrGames
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'GameID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'White'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Black'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Result'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tournament'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Round'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Rated'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DateTimePlayed'
        Visible = True
      end>
  end
  object cmbFilterBy: TComboBox
    Left = 8
    Top = 317
    Width = 145
    Height = 21
    ItemIndex = 0
    TabOrder = 2
    Text = 'Player'
    OnChange = cmbFilterByChange
    Items.Strings = (
      'Player'
      'Rated'
      'Date')
  end
  object ledPlayerFilter: TLabeledEdit
    Left = 8
    Top = 368
    Width = 145
    Height = 21
    EditLabel.Width = 37
    EditLabel.Height = 15
    EditLabel.Caption = 'Player'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -13
    EditLabel.Font.Name = 'Britannic Bold'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    TabOrder = 3
    OnChange = ledPlayerFilterChange
  end
  object cbxRatedFilter: TCheckBox
    Left = 8
    Top = 370
    Width = 97
    Height = 17
    Caption = 'Rated'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Visible = False
    OnClick = cbxRatedFilterClick
  end
  object dtpDateFilter: TDateTimePicker
    Left = 8
    Top = 370
    Width = 145
    Height = 21
    Date = 44785.075741006940000000
    Time = 44785.075741006940000000
    TabOrder = 5
    Visible = False
    OnChange = dtpDateFilterChange
  end
  object btnToggleFilter: TButton
    Left = 159
    Top = 366
    Width = 75
    Height = 25
    Caption = 'Toggle Filter'
    TabOrder = 6
    OnClick = btnToggleFilterClick
  end
  object cmbSortBy: TComboBox
    Left = 408
    Top = 317
    Width = 145
    Height = 21
    TabOrder = 7
    Text = 'Player'
    OnChange = cmbSortByChange
    Items.Strings = (
      'White Player'
      'Black Player'
      'Rated'
      'Date')
  end
end
