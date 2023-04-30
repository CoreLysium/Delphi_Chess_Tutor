unit objUser_u;

interface

uses
  dmChess_u, SysUtils, Math;

Type
  TUser = Class
  {User class which handles loading and working with the user information from the database.}
    Private
      fUsername: String; // User's username.
      fRating: Integer; // User's current rating.
      fCurrentLesson: Integer; // Lesson User is currently busy with.
      fAdmin: Boolean; // Whether the user is and admin or not.
      fLogon: TDateTime; // When the user last logged on.
      fLessonLevel: Integer; // What level of lessons this user may complete.
      fBirthDate: TDateTime; // User's date of birth.
    Public
      constructor Create; Overload; // Instantiates the class with no User loaded.
      constructor Create(const sUsername: String); Overload; // Instantiates the class with a user loaded.
      Function updateRating(const iOppRating: Integer;const rResult: Real): Integer; // Update the users rating based on their opponents rating and the game result.
      Function getRating: Integer;
      Procedure updateDatabase; // Update the user information in the database.
      Function getUsername: String;
      Function getLessonLevel: Integer;
      Function getAdmin: Boolean;
      Function getCurrentLesson: Integer;
      Procedure incrementLessonLevel; // Add one to the lesson level.
      Procedure changeUser(const sUsername: String); // Loads a user from the database into this object
      Procedure setCurrentLesson(const iLesson: Integer);
  End;

implementation

{ TUser }

procedure TUser.changeUser(const sUsername: String);
begin
  with dmChess.tblUsers do
    begin
      Open;
      if Locate('Username',sUsername,[]) then
        begin
          fUsername := FieldValues['Username'];
          fRating := FieldValues['Rating'];
          fCurrentLesson := FieldValues['CurrentLesson'];
          fAdmin := FieldValues['Admin'];
          fLessonLevel := FieldValues['LessonLevel'];
          fBirthDate := FieldValues['BirthDate'];
        end;
      Close;
    end;
end;

constructor TUser.Create;
begin
  fUsername := '#No user loaded';
end;

constructor TUser.Create(const sUsername: String);
begin
  with dmChess.tblUsers do
    begin
      Open;
      if Locate('Username',sUsername,[]) then
        begin
          fUsername := FieldValues['Username'];
          fRating := FieldValues['Rating'];
          fCurrentLesson := FieldValues['CurrentLesson'];
          fAdmin := FieldValues['Admin'];
          fLessonLevel := FieldValues['LessonLevel'];
          fBirthDate := FieldValues['BirthDate'];
          fLogon := now;
        end;
      Close;
    end;
end;

function TUser.getAdmin: Boolean;
begin
  Result := fAdmin
end;

function TUser.getCurrentLesson: Integer;
begin
  Result := fCurrentLesson;
end;

function TUser.getLessonLevel: Integer;
begin
  Result := fLessonLevel;
end;

function TUser.getRating: Integer;
begin
  Result := fRating;
end;

function TUser.getUsername: String;
begin
  Result := fUsername;
end;

procedure TUser.incrementLessonLevel;
begin
  inc(fLessonLevel);
end;

procedure TUser.setCurrentLesson(const iLesson: Integer);
begin
  fCurrentLesson := iLesson;
end;

procedure TUser.updateDatabase;
begin
with dmChess.tblUsers do
    begin
      Open;
      if Locate('Username',fUsername,[]) then
        begin
          Edit;
          FieldValues['Username'] := fUsername;
          FieldValues['Rating'] := fRating;
          FieldValues['CurrentLesson'] := fCurrentLesson;
          FieldValues['Admin'] := fAdmin;
          FieldValues['LessonLevel'] := fLessonLevel;
          FieldValues['BirthDate'] := fBirthDate;
          FieldValues['LastLogon'] := fLogon;
          Post;
        end;
      Close;
    end;
end;

function TUser.updateRating(const iOppRating: Integer; const rResult: Real): Integer;
var
  rOdds: Real;
  iChange: Integer;
begin
  rOdds := 1 / (1 + Power(10,(iOppRating - fRating) / 400));
  iChange := Round(32 * (rResult - rOdds));
  fRating := fRating + iChange;
  Result := fRating;
end;

end.
