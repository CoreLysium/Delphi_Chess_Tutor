object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Chess Tutor 1.0'
  ClientHeight = 594
  ClientWidth = 800
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbxBlack: TGroupBox
    Left = 16
    Top = 8
    Width = 449
    Height = 65
    Color = clInfoBk
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object imgBlack_pfp: TImage
      Left = 16
      Top = 8
      Width = 48
      Height = 48
      Stretch = True
    end
    object lblBlack_Username: TLabel
      Left = 70
      Top = 8
      Width = 38
      Height = 17
      Caption = 'Black'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object lblBlack_Clock: TLabel
      Left = 320
      Top = 11
      Width = 94
      Height = 38
      Caption = '30:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object lblBlack_Rating: TLabel
      Left = 70
      Top = 31
      Width = 28
      Height = 13
      Caption = '1000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object gbxWhite: TGroupBox
    Left = 16
    Top = 526
    Width = 449
    Height = 66
    Color = clInfoBk
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    object imgWhite_pfp: TImage
      Left = 16
      Top = 8
      Width = 48
      Height = 48
      Stretch = True
    end
    object lblWhite_Rating: TLabel
      Left = 70
      Top = 31
      Width = 28
      Height = 13
      Caption = '1000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblWhite_Username: TLabel
      Left = 70
      Top = 8
      Width = 38
      Height = 17
      Caption = 'White'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object lblWhite_Clock: TLabel
      Left = 320
      Top = 12
      Width = 94
      Height = 38
      Caption = '30:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
  end
  object pclMain: TPageControl
    Left = 488
    Top = 8
    Width = 304
    Height = 584
    ActivePage = tstPlay
    MultiLine = True
    TabOrder = 2
    TabPosition = tpLeft
    OnChange = pclMainChange
    object tstPlay: TTabSheet
      Caption = 'Play'
      object lblPlayers: TLabel
        Left = 3
        Top = 3
        Width = 50
        Height = 19
        Caption = 'Players'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblRatingDash: TLabel
        Left = 147
        Top = 551
        Width = 6
        Height = 19
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblRatingRange: TLabel
        Left = 92
        Top = 535
        Width = 81
        Height = 16
        Caption = 'Rating Range:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbxPlayers: TListBox
        Left = 3
        Top = 27
        Width = 270
        Height = 502
        Color = clInfoBk
        ItemHeight = 13
        TabOrder = 0
      end
      object btnChallenge: TButton
        Left = 11
        Top = 535
        Width = 75
        Height = 38
        Caption = 'Challenge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnChallengeClick
      end
      object sedMinRating: TSpinEdit
        Left = 92
        Top = 551
        Width = 49
        Height = 22
        MaxValue = 5000
        MinValue = 1
        TabOrder = 2
        Value = 1000
        OnChange = sedRatingChange
      end
      object sedMaxRating: TSpinEdit
        Left = 157
        Top = 551
        Width = 50
        Height = 22
        MaxValue = 5000
        MinValue = 1
        TabOrder = 3
        Value = 1000
        OnChange = sedRatingChange
      end
      object stgRecord: TStringGrid
        Left = 0
        Top = 3
        Width = 273
        Height = 570
        Color = clInfoBk
        ColCount = 2
        DefaultColWidth = 120
        DrawingStyle = gdsClassic
        FixedColor = clMoneyGreen
        FixedCols = 0
        RowCount = 2
        GradientEndColor = clGreen
        GradientStartColor = clOlive
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
        ScrollBars = ssVertical
        TabOrder = 4
        Visible = False
      end
    end
    object tstAnalyse: TTabSheet
      Caption = 'Analyse'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object stgAnalyses: TStringGrid
        Left = 3
        Top = 3
        Width = 273
        Height = 531
        Color = clInfoBk
        ColCount = 2
        DefaultColWidth = 120
        DrawingStyle = gdsClassic
        FixedColor = clMoneyGreen
        FixedCols = 0
        RowCount = 2
        GradientEndColor = clGreen
        GradientStartColor = clOlive
        ScrollBars = ssVertical
        TabOrder = 0
        OnSelectCell = stgSelectCell
      end
      object btnLoadAnalysesFile: TButton
        Left = 3
        Top = 540
        Width = 75
        Height = 25
        Caption = 'Load'
        TabOrder = 1
        OnClick = btnLoadAnalysesFileClick
      end
      object btnNewAnalyses: TButton
        Left = 181
        Top = 540
        Width = 92
        Height = 25
        Caption = 'New Analyses'
        TabOrder = 2
        OnClick = btnNewAnalysesClick
      end
      object btnLoadFromDatabase: TButton
        Left = 84
        Top = 540
        Width = 92
        Height = 25
        Caption = 'Load from Games'
        TabOrder = 3
        OnClick = btnLoadFromDatabaseClick
      end
    end
    object tstLessons: TTabSheet
      Caption = 'Lessons'
      ImageIndex = 2
      object stgLessons: TStringGrid
        Left = 3
        Top = 3
        Width = 273
        Height = 366
        Color = clInfoBk
        ColCount = 2
        DefaultColWidth = 120
        DrawingStyle = gdsClassic
        FixedColor = clMoneyGreen
        FixedCols = 0
        RowCount = 2
        GradientEndColor = clGreen
        GradientStartColor = clOlive
        ScrollBars = ssVertical
        TabOrder = 0
        OnSelectCell = stgSelectCell
      end
      object redLessonText: TRichEdit
        Left = 3
        Top = 375
        Width = 270
        Height = 164
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object btnNextLessonStep: TButton
        Left = 198
        Top = 545
        Width = 75
        Height = 25
        Caption = 'Next'
        Enabled = False
        TabOrder = 2
        OnClick = btnNextLessonStepClick
      end
      object btnSelectLesson: TButton
        Left = 84
        Top = 545
        Width = 108
        Height = 25
        Caption = 'Select Lesson'
        TabOrder = 3
        OnClick = btnSelectLessonClick
      end
      object lbxLessons: TListBox
        Left = 3
        Top = 3
        Width = 270
        Height = 536
        Color = clInfoBk
        ItemHeight = 13
        TabOrder = 4
      end
    end
    object tstAccount: TTabSheet
      Caption = 'Account'
      ImageIndex = 3
      object lblAccount: TLabel
        Left = 3
        Top = 3
        Width = 57
        Height = 19
        Caption = 'Account'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object imgPFP: TImage
        Left = 16
        Top = 276
        Width = 105
        Height = 105
        Stretch = True
      end
      object lblUsernameCheck: TLabel
        Left = 16
        Top = 79
        Width = 3
        Height = 11
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPasswordCheck: TLabel
        Left = 16
        Top = 141
        Width = 3
        Height = 11
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblConfirmPasswordCheck: TLabel
        Left = 16
        Top = 205
        Width = 3
        Height = 11
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object ledUsername: TLabeledEdit
        Left = 16
        Top = 52
        Width = 121
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Username'
        TabOrder = 0
      end
      object ledPassword: TLabeledEdit
        Left = 16
        Top = 114
        Width = 121
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Password'
        TabOrder = 1
      end
      object ledConfirmPassword: TLabeledEdit
        Left = 16
        Top = 178
        Width = 121
        Height = 21
        EditLabel.Width = 86
        EditLabel.Height = 13
        EditLabel.Caption = 'Confirm Password'
        TabOrder = 2
      end
      object btnUpdateInfo: TButton
        Left = 16
        Top = 224
        Width = 121
        Height = 25
        Caption = 'Update Information'
        TabOrder = 3
        OnClick = btnUpdateInfoClick
      end
      object btnChangePFP: TButton
        Left = 16
        Top = 392
        Width = 121
        Height = 25
        Caption = 'Change Profile Picture'
        TabOrder = 4
        OnClick = btnChangePFPClick
      end
      object btnOpenAdminPanel: TButton
        Left = 16
        Top = 548
        Width = 105
        Height = 25
        Caption = 'Open Admin Panel'
        TabOrder = 5
        OnClick = btnOpenAdminPanelClick
      end
    end
  end
  object pnlSetStartPos: TPanel
    Left = 471
    Top = 8
    Width = 304
    Height = 584
    TabOrder = 3
    Visible = False
    object lblSetStartingPosition: TLabel
      Left = 3
      Top = 3
      Width = 143
      Height = 19
      Caption = 'Set Starting Position'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object gbxWhitePieces: TGroupBox
      Left = 8
      Top = 32
      Width = 297
      Height = 233
      Caption = 'White Pieces'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object imgBishopW: TImage
        Left = 16
        Top = 134
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgKingW: TImage
        Left = 16
        Top = 32
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgKnightW: TImage
        Left = 112
        Top = 134
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgPawnW: TImage
        Left = 208
        Top = 134
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgQueenW: TImage
        Left = 112
        Top = 32
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgRookW: TImage
        Left = 208
        Top = 32
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
    end
    object gbxBlackPieces: TGroupBox
      Left = 7
      Top = 280
      Width = 297
      Height = 233
      Caption = 'Black Pieces'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object imgBishopB: TImage
        Left = 16
        Top = 134
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgKingB: TImage
        Left = 16
        Top = 32
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgKnightB: TImage
        Left = 112
        Top = 134
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgPawnB: TImage
        Left = 208
        Top = 134
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgQueenB: TImage
        Left = 112
        Top = 32
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
      object imgRookB: TImage
        Left = 208
        Top = 32
        Width = 75
        Height = 75
        OnClick = imgStartPosClick
      end
    end
    object btnConfirmPosition: TButton
      Left = 211
      Top = 549
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 2
      OnClick = btnConfirmPositionClick
    end
    object btnCancelPosition: TButton
      Left = 130
      Top = 549
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 3
      OnClick = btnCancelPositionClick
    end
    object btnStartPosDelete: TButton
      Left = 10
      Top = 518
      Width = 75
      Height = 25
      Caption = 'Delete Mode'
      TabOrder = 4
      OnClick = btnStartPosDeleteClick
    end
    object cbxSetStartHasMoved: TCheckBox
      Left = 112
      Top = 518
      Width = 97
      Height = 17
      Caption = 'Has Moved'
      TabOrder = 5
    end
  end
  object pnlCreatingLesson: TPanel
    Left = 471
    Top = 8
    Width = 304
    Height = 584
    TabOrder = 4
    Visible = False
    object lblCreateLesson: TLabel
      Left = 3
      Top = 3
      Width = 98
      Height = 19
      Caption = 'Create Lesson'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCreateLessonText: TLabel
      Left = 3
      Top = 97
      Width = 68
      Height = 16
      Caption = 'Lesson Text'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnConfirmLessonCreation: TButton
      Left = 211
      Top = 549
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 0
      OnClick = btnConfirmLessonCreationClick
    end
    object btnNewPosition: TButton
      Left = 8
      Top = 28
      Width = 75
      Height = 25
      Caption = 'New Position'
      TabOrder = 1
      OnClick = btnNewPositionClick
    end
    object cbxQuiz: TCheckBox
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Is Quiz?'
      TabOrder = 2
    end
    object redCreateLessonText: TRichEdit
      Left = 3
      Top = 119
      Width = 270
      Height = 164
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnAddLessonText: TButton
      Left = 0
      Top = 289
      Width = 97
      Height = 25
      Caption = 'Add Lesson Text'
      TabOrder = 4
      OnClick = btnAddLessonTextClick
    end
    object cbxAutoNext: TCheckBox
      Left = 9
      Top = 519
      Width = 97
      Height = 17
      Caption = 'Auto Next Event'
      TabOrder = 5
      OnClick = cbxAutoNextClick
    end
    object btnHighLight: TButton
      Left = 0
      Top = 336
      Width = 105
      Height = 25
      Caption = 'HighLight a Square'
      TabOrder = 6
      OnClick = btnHighLightClick
    end
  end
  object tmrBlack_Clock: TTimer
    OnTimer = tmrBlack_ClockTimer
    Left = 288
    Top = 32
  end
  object tmrWhite_Clock: TTimer
    OnTimer = tmrWhite_ClockTimer
    Left = 288
    Top = 544
  end
  object odgOpen: TOpenDialog
    Left = 160
    Top = 24
  end
end
