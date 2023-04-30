unit frmSignUp_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, dmChess_u, HelperFunctions_u;

type
  TfrmSignUp = class(TForm)
    lblUserName: TLabel;
    lblUsernameCheck: TLabel;
    lblPassword: TLabel;
    lblPasswordCheck: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblConfirmPassword: TLabel;
    lblConfirmPasswordCheck: TLabel;
    edtConfirmPassword: TEdit;
    dtpBirthDate: TDateTimePicker;
    lblBirthDate: TLabel;
    lblBirthDateCheck: TLabel;
    btnCreate: TButton;
    btnLogin: TButton;
    lblSignUp: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sUsername: String;
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

procedure TfrmSignUp.btnCreateClick(Sender: TObject);
var
  bChecksPassed: Boolean;
begin
  bChecksPassed := True;

  dmChess.tblUsers.Open;

  if edtUsername.Text = '' then
    begin
      lblUsernameCheck.Caption := '*This field is required.';
      bChecksPassed := False;
    end
  else if dmChess.tblUsers.Locate('Username',edtUsername.Text,[]) then
    begin
      lblUsernameCheck.Caption := '*Username is taken.';
      bChecksPassed := False;
    end
  else
    lblUsernameCheck.Caption := '';

  if edtPassword.Text = '' then
    begin
      lblPasswordCheck.Caption := '*This field is required.';
      bChecksPassed := False;
    end
  else if Length(edtPassword.text) < 8 then
    begin
      lblPasswordCheck.Caption := '*Password must be at' + #13 + 'least 8 characters long.';
      bChecksPassed := False;
    end
  else
    lblPasswordCheck.Caption := '';

  if edtConfirmPassword.Text = '' then
    begin
      lblConfirmPasswordCheck.Caption := '*This field is required.';
      bChecksPassed := False;
    end
  else if edtConfirmPassword.Text <> edtPassword.Text then
    begin
      lblConfirmPasswordCheck.Caption := '*Passwords must match';
      bChecksPassed := False;
    end
  else
    lblConfirmPasswordCheck.Caption := '';

  if date < dtpBirthDate.Date then
    begin
      lblBirthDateCheck.Caption := '*Date cannot be in the future.';
      bChecksPassed := False;
    end
  else if Trunc((date - dtpBirthDate.Date) / 365.25) < 13 then
    begin
      lblBirthDateCheck.Caption := '*Users must be at' + #13 + 'least 13 years old.';
      bChecksPassed := False;
    end
  else
    lblBirthDateCheck.Caption := '';

  with dmChess.tblUsers do
    if bChecksPassed then
      begin
        sUsername := edtUsername.Text;
        Insert;
        FieldValues['Username'] := edtUsername.Text;
        FieldValues['Password'] := HashPassword(edtPassword.Text);
        FieldValues['BirthDate'] := dtpBirthDate.DateTime;
        FieldValues['Rating'] := 1000;
        FieldValues['Admin'] := False;
        FieldValues['LessonLevel'] := 1;
        FieldValues['CurrentLesson'] := -1;
        Post;
        ModalResult := mrOK;
      end;
  dmChess.tblUsers.Close;
end;

procedure TfrmSignUp.btnLoginClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
