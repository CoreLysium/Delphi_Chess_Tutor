unit frmAdmin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, dmChess_u, StdCtrls, Spin, frmDialogs_u,
  objUser_u;

type
  TfrmAdmin = class(TForm)
    dbgChess: TDBGrid;
    pclAdmin: TPageControl;
    tstUsers: TTabSheet;
    tstLessons: TTabSheet;
    tstGames: TTabSheet;
    btnShowAll: TButton;
    gbxFiltersUsers: TGroupBox;
    sedMinRatingUser: TSpinEdit;
    lblRatingRange: TLabel;
    sedMaxRatingUser: TSpinEdit;
    lblRatingRangeDash: TLabel;
    btnShowAllInRating: TButton;
    lblAgeRange: TLabel;
    sedMinAgeUser: TSpinEdit;
    sedMaxAgeUser: TSpinEdit;
    lblAgeRangeDash: TLabel;
    btnShowAllInAge: TButton;
    btnShowAllAdmins: TButton;
    gbxUpdatingUsers: TGroupBox;
    btnResetUsersRatings: TButton;
    btnDeleteInactiveUsers: TButton;
    gbxFiltersLessons: TGroupBox;
    lblLessonLevel: TLabel;
    sedLessonLevel: TSpinEdit;
    btnShowAllLessonsLevel: TButton;
    gbxUpdatingLessons: TGroupBox;
    btnCreateLesson: TButton;
    btnShowAllLessons: TButton;
    lblAuthorUsername: TLabel;
    btnShowLessonsAuthor: TButton;
    edtAuthorUsername: TEdit;
    gbxSummariesUsers: TGroupBox;
    btnTotalLessonsAuthored: TButton;
    btnUserAllTimeStats: TButton;
    btnDeleteLesson: TButton;
    sedDeleteLessonID: TSpinEdit;
    lblDeleteLesson: TLabel;
    gbxLessonsSummaries: TGroupBox;
    btnNumberOfLessonsLeveel: TButton;
    btnNumberEnrolledLesson: TButton;
    gbxFiltersGames: TGroupBox;
    lblRatingRangeGames: TLabel;
    lblGameRatingRangeDash: TLabel;
    lblUserGames: TLabel;
    sedMinRatingGames: TSpinEdit;
    sedMaxRatingGames: TSpinEdit;
    btnShowAllRatingGames: TButton;
    btnShowGamesUser: TButton;
    btnShowAllRated: TButton;
    gbxUpdatingGames: TGroupBox;
    btnDeleteAllUnrated: TButton;
    gbxSummaries: TGroupBox;
    btnGamesPlayedDaily: TButton;
    btnShowRatedUnratedGames: TButton;
    btnShowAllGames: TButton;
    edtGameUsername: TEdit;
    btnAverageLessonLevel: TButton;
    btnMinAge: TButton;
    btnMaxAge: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnShowAllClick(Sender: TObject);
    procedure btnShowAllInRatingClick(Sender: TObject);
    procedure btnShowAllInAgeClick(Sender: TObject);
    procedure btnShowAllAdminsClick(Sender: TObject);
    procedure btnResetUsersRatingsClick(Sender: TObject);
    procedure btnDeleteInactiveUsersClick(Sender: TObject);
    procedure btnShowAllLessonsLevelClick(Sender: TObject);
    procedure btnShowLessonsAuthorClick(Sender: TObject);
    procedure btnShowAllLessonsClick(Sender: TObject);
    procedure btnCreateLessonClick(Sender: TObject);
    procedure btnTotalLessonsAuthoredClick(Sender: TObject);
    procedure btnUserAllTimeStatsClick(Sender: TObject);
    procedure btnDeleteLessonClick(Sender: TObject);
    procedure btnNumberEnrolledLessonClick(Sender: TObject);
    procedure btnShowAllGamesClick(Sender: TObject);
    procedure btnShowAllRatingGamesClick(Sender: TObject);
    procedure btnShowGamesUserClick(Sender: TObject);
    procedure btnShowAllRatedClick(Sender: TObject);
    procedure btnShowRatedUnratedGamesClick(Sender: TObject);
    procedure btnGamesPlayedDailyClick(Sender: TObject);
    procedure btnDeleteAllUnratedClick(Sender: TObject);
    procedure btnAverageLessonLevelClick(Sender: TObject);
    procedure btnMaxAgeClick(Sender: TObject);
    procedure btnMinAgeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses
  frmMain_u;

{$R *.dfm}

procedure TfrmAdmin.btnShowAllAdminsClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Username, Rating, LastLogon, LessonLevel, BirthDate FROM tblUsers WHERE Admin = True ORDER BY Username';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Username, Rating, LastLogon, LessonLevel, BirthDate FROM tblUsers';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllGamesClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT * FROM tblGames';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllInAgeClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Username, Rating, LastLogon, LessonLevel, BirthDate FROM tblUsers WHERE ((YEAR(#' + DateToStr(Date) + '#) - YEAR(BirthDate)) < ' + sedMaxAgeUser.Text + ') AND ((YEAR(#' + DateToStr(Date) + '#) - YEAR(BirthDate)) > ' + sedMinAgeUser.Text + ') ORDER BY Username';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllInRatingClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Username, Rating, LastLogon, LessonLevel, BirthDate FROM tblUsers WHERE (Rating < ' + sedMaxRatingUser.Text + ') AND (Rating > ' + sedMinRatingUser.Text + ') ORDER BY Username';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllLessonsClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT * FROM tblLessons';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllLessonsLevelClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT * FROM tblLessons WHERE Lesson_Level = ' + sedLessonLevel.Text + ' ORDER BY Lesson_Name';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllRatedClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT * FROM tblGames WHERE Rated = True ORDER BY DateTimePlayed DESC';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowAllRatingGamesClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT GameID, White, Black, Result, DateTimePlayed FROM tblGames G, tblUsers U WHERE (G.White = U.Username) AND ((U.Rating < ' + sedMaxRatingGames.Text + ') AND (U.Rating > ' + sedMinRatingGames.Text + ')) ORDER BY DateTimePlayed DESC';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowGamesUserClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT * FROM tblGames WHERE (White = ' + QuotedStr(edtGameUsername.Text) + ') OR (Black = ' + QuotedStr(edtGameUsername.Text) + ') ORDER BY DateTimePlayed DESC';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowLessonsAuthorClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT * FROM tblLessons WHERE Lesson_Author = ' + QuotedStr(edtAuthorUsername.Text) + ' ORDER BY Lesson_Name';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnShowRatedUnratedGamesClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Rated, COUNT(*) AS Total_Games FROM tblGames GROUP BY Rated';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnTotalLessonsAuthoredClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Lesson_Level, COUNT(*) AS Number_Of_Lessons FROM tblLessons GROUP BY Lesson_Level';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnUserAllTimeStatsClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT Username, COUNT(White) AS Games_White, COUNT(Black) AS Games_Black, (COUNT(White) + Count(Black)) AS Total_Games FROM tblUsers U, tblGames G WHERE (U.Username = G.White) OR (U.Username = G.Black) GROUP BY U.Username ORDER BY U.Username';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnAverageLessonLevelClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'SELECT AVG(LessonLevel) AS Average_Lesson_Level FROM tblUsers';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnCreateLessonClick(Sender: TObject);
begin
  with dmChess do
    with frmDialogs do
      begin
        Create_Lesson;
        Left := (Self.Left + Self.Width div 2) - (Width div 2);
        Top := (Self.Top + Self.Height div 2) - (Height div 2);
        if ShowModal = mrOK then
          begin
            tblLessons.Open;
            tblLessons.Insert;
            tblLessons['Lesson_Name'] := edtLessonName.Text;
            tblLessons['Lesson_Level'] := sedLessonLevel.Value;
            tblLessons['Lesson_Description'] := redLessonDescription.Lines[0];
            tblLessons['Lesson_Author'] := frmMain.objUser.getUsername;
            tblLessons.Post;
            frmMain.createLesson;
            frmAdmin.ModalResult := mrOK;
          end;
      end;
end;

procedure TfrmAdmin.btnDeleteAllUnratedClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'DELETE FROM tblGames WHERE Rated = False';
  dmChess.qryChess.ExecSQL;
end;

procedure TfrmAdmin.btnDeleteInactiveUsersClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'DELETE FROM tblUsers WHERE ((YEAR(#' + DateToStr(Date) + '#) - YEAR(LastLogon)) >= 1) OR ((MONTH(#' + DateToStr(Date) + '#) - MONTH(LastLogon)) >= 6)';
  dmChess.qryChess.ExecSQL;
end;

procedure TfrmAdmin.btnDeleteLessonClick(Sender: TObject);
var
  sLessonID: String;
begin
  sLessonID := sedDeleteLessonID.Text;
  if fileexists('Lessons\' + sLessonID + '.txt') then
    begin
      if DeleteFile('Lessons\' + sLessonID + '.txt') then
        begin
          dmChess.qryChess.Close;
          dmChess.qryChess.SQL.Clear;
          dmChess.qryChess.SQL.Text := 'DELETE FROM tblLessons WHERE Lesson_ID = ' + sLessonID;
          dmChess.qryChess.ExecSQL;
        end
      else
        MessageDlg('Delete Failed.',mtError,[mbOK],0);
    end
  else
    MessageDlg('Lesson not found.',mtError,[mbOK],0);
end;

procedure TfrmAdmin.btnGamesPlayedDailyClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dbgChess.DataSource := dmChess.dsrChess;
  dmChess.qryChess.SQL.Text := 'SELECT MONTH(DateTimePlayed) AS Month_Number, COUNT(*) AS Number_Of_Games FROM tblGames GROUP BY MONTH(DateTimePlayed) ORDER BY MONTH(DateTimePlayed)';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnMaxAgeClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dbgChess.DataSource := dmChess.dsrChess;
  dmChess.qryChess.SQL.Text := 'SELECT LessonLevel, MAX(YEAR(#' + DateToStr(Date) + '#) - YEAR(BirthDate)) AS Age FROM tblUsers GROUP BY LessonLevel';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnMinAgeClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dbgChess.DataSource := dmChess.dsrChess;
  dmChess.qryChess.SQL.Text := 'SELECT LessonLevel, MIN(YEAR(#' + DateToStr(Date) + '#) - YEAR(BirthDate)) AS Age FROM tblUsers GROUP BY LessonLevel';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnNumberEnrolledLessonClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dbgChess.DataSource := dmChess.dsrChess;
  dmChess.qryChess.SQL.Text := 'SELECT Lesson_Name, COUNT(CurrentLesson) AS Number_Of_Users FROM tblLessons L, tblUsers U WHERE L.Lesson_ID = U.CurrentLesson GROUP BY L.Lesson_Name ORDER BY L.Lesson_Name';
  dmChess.qryChess.Open;
end;

procedure TfrmAdmin.btnResetUsersRatingsClick(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dmChess.qryChess.SQL.Text := 'UPDATE tblUsers SET Rating = 1000 WHERE Rating <> 1000';
  dmChess.qryChess.ExecSQL;
end;

procedure TfrmAdmin.FormShow(Sender: TObject);
begin
  dmChess.qryChess.Close;
  dmChess.qryChess.SQL.Clear;
  dbgChess.DataSource := dmChess.dsrChess;
  dmChess.qryChess.SQL.Text := 'SELECT Username, Rating, LastLogon, LessonLevel, BirthDate FROM tblUsers';
  dmChess.qryChess.Open;
end;

end.
