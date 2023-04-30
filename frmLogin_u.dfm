object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 239
  ClientWidth = 176
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
  object lblLogin: TLabel
    Left = 8
    Top = 8
    Width = 51
    Height = 23
    Caption = 'Login'
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
  object btnLogin: TButton
    Left = 8
    Top = 206
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object btnSignUp: TButton
    Left = 93
    Top = 206
    Width = 75
    Height = 25
    Caption = 'Sign Up'
    TabOrder = 3
    OnClick = btnSignUpClick
  end
end
