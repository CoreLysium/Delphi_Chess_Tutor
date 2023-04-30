program Chess_Tutor_p;

uses
  Forms,
  frmMain_u in 'frmMain_u.pas' {frmMain},
  frmLogin_u in 'frmLogin_u.pas' {frmLogin},
  frmSignUp_u in 'frmSignUp_u.pas' {frmSignUp},
  frmDialogs_u in 'frmDialogs_u.pas' {frmDialogs},
  dmChess_u in 'dmChess_u.pas' {dmChess: TDataModule},
  EventManager_u in 'EventManager_u.pas',
  HelperFunctions_u in 'HelperFunctions_u.pas',
  objBoard_u in 'objBoard_u.pas',
  objPieces_u in 'objPieces_u.pas',
  objUser_u in 'objUser_u.pas',
  frmGames_u in 'frmGames_u.pas' {frmGames},
  frmAdmin_u in 'frmAdmin_u.pas' {frmAdmin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
