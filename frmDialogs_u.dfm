object frmDialogs: TfrmDialogs
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmDialogs'
  ClientHeight = 307
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlChallenge: TPanel
    Left = 0
    Top = 0
    Width = 219
    Height = 307
    Align = alClient
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 0
    Visible = False
    object lblTimeColon: TLabel
      Left = 79
      Top = 169
      Width = 6
      Height = 19
      Caption = ':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblIncrement: TLabel
      Left = 24
      Top = 199
      Width = 58
      Height = 16
      Caption = 'Increment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTimeControl: TLabel
      Left = 24
      Top = 147
      Width = 74
      Height = 16
      Caption = 'Time Control'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblChallenge: TLabel
      Left = 24
      Top = 0
      Width = 92
      Height = 21
      Caption = 'Challenge: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object imgPfp: TImage
      Left = 24
      Top = 27
      Width = 56
      Height = 56
      Stretch = True
    end
    object lblUsername: TLabel
      Left = 91
      Top = 27
      Width = 72
      Height = 15
      Caption = 'lblUsername'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object lblRating: TLabel
      Left = 91
      Top = 48
      Width = 34
      Height = 13
      Caption = ' Rating'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblColour: TLabel
      Left = 24
      Top = 98
      Width = 37
      Height = 16
      Caption = 'Colour'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnChallenge: TButton
      Left = 120
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Challenge'
      TabOrder = 0
      OnClick = btnChallengeClick
    end
    object btnCancel: TButton
      Left = 14
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object cbxRated: TCheckBox
      Left = 24
      Top = 249
      Width = 65
      Height = 17
      Caption = 'Rated'
      TabOrder = 2
    end
    object sedMinutes: TSpinEdit
      Left = 24
      Top = 171
      Width = 49
      Height = 22
      MaxValue = 600
      MinValue = 1
      TabOrder = 3
      Value = 1
    end
    object sedSeconds: TSpinEdit
      Left = 91
      Top = 171
      Width = 49
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object sedIncrement: TSpinEdit
      Left = 24
      Top = 221
      Width = 49
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
    object cmbColour: TComboBox
      Left = 24
      Top = 120
      Width = 145
      Height = 21
      ItemIndex = 2
      TabOrder = 6
      Text = 'Random'
      Items.Strings = (
        'White'
        'Black'
        'Random')
    end
  end
  object pnlPromote: TPanel
    Left = 0
    Top = 0
    Width = 219
    Height = 307
    Align = alClient
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 1
    Visible = False
    object imgQueen: TImage
      Left = 14
      Top = 57
      Width = 84
      Height = 84
      Stretch = True
      OnClick = imgQueenClick
    end
    object imgRook: TImage
      Left = 111
      Top = 57
      Width = 84
      Height = 84
      Stretch = True
      OnClick = imgRookClick
    end
    object imgKnight: TImage
      Left = 14
      Top = 182
      Width = 84
      Height = 84
      Stretch = True
      OnClick = imgKnightClick
    end
    object imgBishop: TImage
      Left = 111
      Top = 182
      Width = 84
      Height = 84
      Stretch = True
      OnClick = imgBishopClick
    end
    object lblPromote: TLabel
      Left = 14
      Top = 16
      Width = 75
      Height = 21
      Caption = 'Promote:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlLesson: TPanel
    Left = 0
    Top = 0
    Width = 219
    Height = 307
    Align = alClient
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 2
    Visible = False
    object lblLesson: TLabel
      Left = 14
      Top = 16
      Width = 147
      Height = 21
      Caption = 'Confirm Selection'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object lblLessonName: TLabel
      Left = 14
      Top = 57
      Width = 42
      Height = 16
      Caption = 'Name: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLessonLevel: TLabel
      Left = 14
      Top = 79
      Width = 38
      Height = 16
      Caption = 'Level: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLessonDescription: TLabel
      Left = 14
      Top = 111
      Width = 68
      Height = 16
      Caption = 'Description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLessonDescriptionText: TLabel
      Left = 14
      Top = 133
      Width = 187
      Height = 133
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object btnLessonCancel: TButton
      Left = 14
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnConfirm: TButton
      Left = 120
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Confirm'
      TabOrder = 1
      OnClick = btnConfirmClick
    end
  end
  object pnlCreateLesson: TPanel
    Left = 0
    Top = 0
    Width = 219
    Height = 307
    Align = alClient
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 3
    Visible = False
    object lblCreateLesson: TLabel
      Left = 14
      Top = 16
      Width = 117
      Height = 21
      Caption = 'Create Lesson'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object lblCreateLessonName: TLabel
      Left = 14
      Top = 57
      Width = 42
      Height = 16
      Caption = 'Name: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCreateLessonLevel: TLabel
      Left = 14
      Top = 79
      Width = 38
      Height = 16
      Caption = 'Level: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCreateLessonDescription: TLabel
      Left = 14
      Top = 111
      Width = 68
      Height = 16
      Caption = 'Description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnCancelCreateLesson: TButton
      Left = 14
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnCreateLesson: TButton
      Left = 120
      Top = 272
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 1
      OnClick = btnCreateLessonClick
    end
    object edtLessonName: TEdit
      Left = 62
      Top = 56
      Width = 133
      Height = 21
      TabOrder = 2
    end
    object sedLessonLevel: TSpinEdit
      Left = 62
      Top = 79
      Width = 133
      Height = 22
      MaxValue = 5
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object redLessonDescription: TRichEdit
      Left = 14
      Top = 133
      Width = 185
      Height = 133
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
end
