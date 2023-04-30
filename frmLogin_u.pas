unit frmLogin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dmChess_u, HelperFunctions_u, frmSignUp_u;

type
  TfrmLogin = class(TForm)
    edtUsername: TEdit;
    lblUserName: TLabel;
    lblUsernameCheck: TLabel;
    edtPassword: TEdit;
    lblPassword: TLabel;
    lblPasswordCheck: TLabel;
    btnLogin: TButton;
    btnSignUp: TButton;
    lblLogin: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
  private
    { Private declarations }
  public
    sUsername: String;
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  with dmChess.tblUsers do
    begin
      Open;
      if not Locate('Username',edtUsername.Text,[]) then
        begin
          lblUsernameCheck.Caption := '*Username does not exist.';
          lblPasswordCheck.Caption := '';
        end
      else if HashPassword(edtPassword.Text) <> FieldValues['Password'] then
        begin
          lblPasswordCheck.Caption := '*Password is incorrect';
          lblUsernameCheck.Caption := '';
        end
      else
        begin
          sUsername := FieldValues['Username'];
          Edit;
          FieldValues['LastLogon'] := Now;
          Post;
          modalResult := mrOK;
        end;
      Close;
    end;

  if edtUsername.Text = '' then
    lblUsernameCheck.Caption := '*This field is required.';

  if edtPassword.Text = '' then
    lblPasswordCheck.Caption := '*This field is required.';

end;

procedure TfrmLogin.btnSignUpClick(Sender: TObject);
begin
  frmSignUp := TFrmSignUp.Create(nil);
  Hide;
  if frmSignUp.ShowModal = mrOK then
    begin
      sUsername := frmSignUp.sUsername;
      ModalResult := mrOK;
    end
  else
    Show;
  frmSignUp.Destroy;
end;

end.
