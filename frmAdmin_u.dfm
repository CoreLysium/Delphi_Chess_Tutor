object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'Admin'
  ClientHeight = 540
  ClientWidth = 761
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
  object dbgChess: TDBGrid
    Left = 8
    Top = 8
    Width = 745
    Height = 225
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pclAdmin: TPageControl
    Left = 8
    Top = 239
    Width = 745
    Height = 293
    ActivePage = tstUsers
    TabOrder = 1
    object tstUsers: TTabSheet
      Caption = 'Users'
      object btnShowAll: TButton
        Left = 659
        Top = 237
        Width = 75
        Height = 25
        ParentCustomHint = False
        Caption = 'Show All'
        TabOrder = 0
        OnClick = btnShowAllClick
      end
      object gbxFiltersUsers: TGroupBox
        Left = 0
        Top = 3
        Width = 185
        Height = 259
        Caption = 'Filtering'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        object lblRatingRange: TLabel
          Left = 3
          Top = 26
          Width = 80
          Height = 15
          Caption = 'Rating Range:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object lblRatingRangeDash: TLabel
          Left = 87
          Top = 48
          Width = 4
          Height = 16
          Caption = '-'
        end
        object lblAgeRange: TLabel
          Left = 3
          Top = 107
          Width = 63
          Height = 15
          Caption = 'Age Range:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object lblAgeRangeDash: TLabel
          Left = 87
          Top = 129
          Width = 4
          Height = 16
          Caption = '-'
        end
        object sedMinRatingUser: TSpinEdit
          Left = 3
          Top = 48
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 5000
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
        end
        object sedMaxRatingUser: TSpinEdit
          Left = 97
          Top = 48
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 5000
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 0
        end
        object btnShowAllInRating: TButton
          Left = 3
          Top = 76
          Width = 142
          Height = 25
          Caption = 'Show All in Rating Range'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnShowAllInRatingClick
        end
        object sedMinAgeUser: TSpinEdit
          Left = 3
          Top = 128
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 100
          MinValue = 13
          ParentFont = False
          TabOrder = 3
          Value = 13
        end
        object sedMaxAgeUser: TSpinEdit
          Left = 97
          Top = 129
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 100
          MinValue = 13
          ParentFont = False
          TabOrder = 4
          Value = 13
        end
        object btnShowAllInAge: TButton
          Left = 3
          Top = 157
          Width = 142
          Height = 25
          Caption = 'Show All in Age Range'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = btnShowAllInAgeClick
        end
        object btnShowAllAdmins: TButton
          Left = 3
          Top = 221
          Width = 142
          Height = 25
          Caption = 'Show all Admins'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = btnShowAllAdminsClick
        end
      end
      object gbxUpdatingUsers: TGroupBox
        Left = 200
        Top = 3
        Width = 153
        Height = 259
        Caption = 'Updating'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        object btnResetUsersRatings: TButton
          Left = 3
          Top = 21
          Width = 142
          Height = 25
          Caption = 'Reset All Users Rating'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnResetUsersRatingsClick
        end
        object btnDeleteInactiveUsers: TButton
          Left = 3
          Top = 52
          Width = 142
          Height = 25
          Caption = 'Delete Inactive Users'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnDeleteInactiveUsersClick
        end
      end
      object gbxSummariesUsers: TGroupBox
        Left = 368
        Top = 3
        Width = 217
        Height = 259
        Caption = 'Summaries'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 3
        object btnTotalLessonsAuthored: TButton
          Left = 3
          Top = 52
          Width = 206
          Height = 25
          Caption = 'Show Number of Lessons Users Authored'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnTotalLessonsAuthoredClick
        end
        object btnUserAllTimeStats: TButton
          Left = 3
          Top = 21
          Width = 206
          Height = 25
          Caption = 'Show Total Games Played by User'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnUserAllTimeStatsClick
        end
        object btnAverageLessonLevel: TButton
          Left = 3
          Top = 83
          Width = 206
          Height = 25
          Caption = 'Average Lesson Level'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnAverageLessonLevelClick
        end
        object btnMinAge: TButton
          Left = 3
          Top = 145
          Width = 206
          Height = 25
          Caption = 'Youngest Player Per Lesson Level'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnMinAgeClick
        end
        object btnMaxAge: TButton
          Left = 3
          Top = 114
          Width = 206
          Height = 25
          Caption = 'Oldest Player Per Lesson Level'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = btnMaxAgeClick
        end
      end
    end
    object tstLessons: TTabSheet
      Caption = 'Lessons'
      ImageIndex = 1
      object gbxFiltersLessons: TGroupBox
        Left = 0
        Top = 3
        Width = 185
        Height = 259
        Caption = 'Filtering'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object lblLessonLevel: TLabel
          Left = 3
          Top = 26
          Width = 76
          Height = 15
          Caption = 'Lesson Level:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object lblAuthorUsername: TLabel
          Left = 3
          Top = 123
          Width = 103
          Height = 15
          Caption = 'Author Username:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object sedLessonLevel: TSpinEdit
          Left = 3
          Top = 48
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 5
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
        end
        object btnShowAllLessonsLevel: TButton
          Left = 3
          Top = 76
          Width = 166
          Height = 25
          Caption = 'Show All Lessons of This Level'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnShowAllLessonsLevelClick
        end
        object btnShowLessonsAuthor: TButton
          Left = 3
          Top = 171
          Width = 166
          Height = 25
          Caption = 'Show All Lessons by This Author'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnShowLessonsAuthorClick
        end
        object edtAuthorUsername: TEdit
          Left = 3
          Top = 144
          Width = 121
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
      object gbxUpdatingLessons: TGroupBox
        Left = 200
        Top = 3
        Width = 153
        Height = 259
        Caption = 'Updating'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        object lblDeleteLesson: TLabel
          Left = 3
          Top = 67
          Width = 99
          Height = 15
          Caption = 'Delete Lesson ID:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object btnCreateLesson: TButton
          Left = 3
          Top = 36
          Width = 142
          Height = 25
          Caption = 'Create New Lesson'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnCreateLessonClick
        end
        object btnDeleteLesson: TButton
          Left = 3
          Top = 123
          Width = 142
          Height = 25
          Caption = 'Delete Lesson'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnDeleteLessonClick
        end
        object sedDeleteLessonID: TSpinEdit
          Left = 3
          Top = 91
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 5
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 0
        end
      end
      object btnShowAllLessons: TButton
        Left = 659
        Top = 237
        Width = 75
        Height = 25
        ParentCustomHint = False
        Caption = 'Show All'
        TabOrder = 2
        OnClick = btnShowAllLessonsClick
      end
      object gbxLessonsSummaries: TGroupBox
        Left = 368
        Top = 3
        Width = 217
        Height = 259
        Caption = 'Summaries'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 3
        object btnNumberOfLessonsLeveel: TButton
          Left = 3
          Top = 52
          Width = 206
          Height = 25
          Caption = 'Show Number of Lessons at each Level'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnTotalLessonsAuthoredClick
        end
        object btnNumberEnrolledLesson: TButton
          Left = 3
          Top = 21
          Width = 206
          Height = 25
          Caption = 'Show Number of Users for Each Lesson'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnNumberEnrolledLessonClick
        end
      end
    end
    object tstGames: TTabSheet
      Caption = 'Games'
      ImageIndex = 2
      object gbxFiltersGames: TGroupBox
        Left = 0
        Top = 3
        Width = 185
        Height = 259
        Caption = 'Filtering'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object lblRatingRangeGames: TLabel
          Left = 3
          Top = 26
          Width = 80
          Height = 15
          Caption = 'Rating Range:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object lblGameRatingRangeDash: TLabel
          Left = 87
          Top = 48
          Width = 4
          Height = 16
          Caption = '-'
        end
        object lblUserGames: TLabel
          Left = 3
          Top = 107
          Width = 83
          Height = 15
          Caption = 'Game by User:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Britannic Bold'
          Font.Style = []
          ParentFont = False
        end
        object sedMinRatingGames: TSpinEdit
          Left = 3
          Top = 48
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 5000
          MinValue = 0
          ParentFont = False
          TabOrder = 0
          Value = 0
        end
        object sedMaxRatingGames: TSpinEdit
          Left = 97
          Top = 48
          Width = 78
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 5000
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 0
        end
        object btnShowAllRatingGames: TButton
          Left = 3
          Top = 76
          Width = 142
          Height = 25
          Caption = 'Show All in Rating Range'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnShowAllRatingGamesClick
        end
        object btnShowGamesUser: TButton
          Left = 3
          Top = 157
          Width = 142
          Height = 25
          Caption = 'Show all Games by User'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnShowGamesUserClick
        end
        object btnShowAllRated: TButton
          Left = 3
          Top = 221
          Width = 142
          Height = 25
          Caption = 'Show all Rated Games'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = btnShowAllRatedClick
        end
        object edtGameUsername: TEdit
          Left = 3
          Top = 128
          Width = 121
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
      object gbxUpdatingGames: TGroupBox
        Left = 200
        Top = 3
        Width = 153
        Height = 259
        Caption = 'Updating'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        object btnDeleteAllUnrated: TButton
          Left = 3
          Top = 21
          Width = 142
          Height = 25
          Caption = 'Delete All Unrated Games'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnDeleteAllUnratedClick
        end
      end
      object gbxSummaries: TGroupBox
        Left = 359
        Top = 3
        Width = 225
        Height = 259
        Caption = 'Summaries'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Britannic Bold'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 2
        object btnGamesPlayedDaily: TButton
          Left = 3
          Top = 52
          Width = 219
          Height = 25
          Caption = 'Show Number of Games Played Each Month'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btnGamesPlayedDailyClick
        end
        object btnShowRatedUnratedGames: TButton
          Left = 3
          Top = 21
          Width = 219
          Height = 25
          Caption = 'Show total rated and unrated games'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnShowRatedUnratedGamesClick
        end
      end
      object btnShowAllGames: TButton
        Left = 659
        Top = 237
        Width = 75
        Height = 25
        ParentCustomHint = False
        Caption = 'Show All'
        TabOrder = 3
        OnClick = btnShowAllGamesClick
      end
    end
  end
end
