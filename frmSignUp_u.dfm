object frmSignUp: TfrmSignUp
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sign Up'
  ClientHeight = 252
  ClientWidth = 315
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblUserName: TLabel
    Left = 24
    Top = 51
    Width = 64
    Height = 16
    Caption = 'Username'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object lblUsernameCheck: TLabel
    Left = 24
    Top = 97
    Width = 3
    Height = 11
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblPassword: TLabel
    Left = 24
    Top = 130
    Width = 63
    Height = 16
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object lblPasswordCheck: TLabel
    Left = 24
    Top = 176
    Width = 3
    Height = 11
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblConfirmPassword: TLabel
    Left = 168
    Top = 130
    Width = 119
    Height = 16
    Caption = 'Confirm Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object lblConfirmPasswordCheck: TLabel
    Left = 168
    Top = 176
    Width = 3
    Height = 11
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblBirthDate: TLabel
    Left = 168
    Top = 48
    Width = 83
    Height = 16
    Caption = 'Date of Birth'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object lblBirthDateCheck: TLabel
    Left = 168
    Top = 97
    Width = 3
    Height = 11
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblSignUp: TLabel
    Left = 24
    Top = 8
    Width = 71
    Height = 23
    Caption = 'Sign Up'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Britannic Bold'
    Font.Style = []
    ParentFont = False
  end
  object edtUsername: TEdit
    Left = 24
    Top = 70
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 24
    Top = 149
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtConfirmPassword: TEdit
    Left = 177
    Top = 149
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object dtpBirthDate: TDateTimePicker
    Left = 168
    Top = 70
    Width = 121
    Height = 21
    Date = 44694.293110613430000000
    Time = 44694.293110613430000000
    TabOrder = 3
  end
  object btnCreate: TButton
    Left = 200
    Top = 214
    Width = 89
    Height = 25
    Caption = 'Create Account'
    TabOrder = 4
    OnClick = btnCreateClick
  end
  object btnLogin: TButton
    Left = 96
    Top = 214
    Width = 89
    Height = 25
    Caption = 'Login'
    TabOrder = 5
    OnClick = btnLoginClick
  end
end
