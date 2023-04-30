unit frmMain_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, objPieces_u, objBoard_u, ExtCtrls, JPEG, ComCtrls, StdCtrls, pngimage,
  Grids, frmDebugLog_u, EventManager_u, objUser_u, frmLogin_u, Spin, frmDialogs_u,
  dmChess_u, frmGames_u, frmAdmin_u, HelperFunctions_u;

type
  TfrmMain = class(TForm)
    imgBlack_pfp: TImage;
    imgWhite_pfp: TImage;
    lblWhite_Username: TLabel;
    lblBlack_Username: TLabel;
    lblBlack_Rating: TLabel;
    lblWhite_Rating: TLabel;
    gbxBlack: TGroupBox;
    gbxWhite: TGroupBox;
    stgRecord: TStringGrid;
    pclMain: TPageControl;
    tstPlay: TTabSheet;
    tstAnalyse: TTabSheet;
    tstLessons: TTabSheet;
    stgAnalyses: TStringGrid;
    btnLoadAnalysesFile: TButton;
    btnNewAnalyses: TButton;
    stgLessons: TStringGrid;
    redLessonText: TRichEdit;
    btnNextLessonStep: TButton;
    btnSelectLesson: TButton;
    lblBlack_Clock: TLabel;
    lblWhite_Clock: TLabel;
    tmrBlack_Clock: TTimer;
    tmrWhite_Clock: TTimer;
    lbxPlayers: TListBox;
    lblPlayers: TLabel;
    btnChallenge: TButton;
    sedMinRating: TSpinEdit;
    sedMaxRating: TSpinEdit;
    lblRatingDash: TLabel;
    lblRatingRange: TLabel;
    odgOpen: TOpenDialog;
    lbxLessons: TListBox;
    btnLoadFromDatabase: TButton;
    pnlSetStartPos: TPanel;
    lblSetStartingPosition: TLabel;
    imgKingW: TImage;
    imgQueenW: TImage;
    imgRookW: TImage;
    imgBishopW: TImage;
    imgKnightW: TImage;
    imgPawnW: TImage;
    gbxWhitePieces: TGroupBox;
    gbxBlackPieces: TGroupBox;
    imgBishopB: TImage;
    imgKingB: TImage;
    imgKnightB: TImage;
    imgPawnB: TImage;
    imgQueenB: TImage;
    imgRookB: TImage;
    btnConfirmPosition: TButton;
    btnCancelPosition: TButton;
    btnStartPosDelete: TButton;
    cbxSetStartHasMoved: TCheckBox;
    pnlCreatingLesson: TPanel;
    lblCreateLesson: TLabel;
    btnConfirmLessonCreation: TButton;
    btnNewPosition: TButton;
    cbxQuiz: TCheckBox;
    redCreateLessonText: TRichEdit;
    lblCreateLessonText: TLabel;
    btnAddLessonText: TButton;
    cbxAutoNext: TCheckBox;
    btnHighLight: TButton;
    tstAccount: TTabSheet;
    lblAccount: TLabel;
    ledUsername: TLabeledEdit;
    ledPassword: TLabeledEdit;
    ledConfirmPassword: TLabeledEdit;
    imgPFP: TImage;
    btnUpdateInfo: TButton;
    btnChangePFP: TButton;
    btnOpenAdminPanel: TButton;
    lblUsernameCheck: TLabel;
    lblPasswordCheck: TLabel;
    lblConfirmPasswordCheck: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tmrBlack_ClockTimer(Sender: TObject);
    procedure tmrWhite_ClockTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnChallengeClick(Sender: TObject);
    procedure sedRatingChange(Sender: TObject);
    procedure stgSelectCell(Sender: TObject; ACol, ARow: Integer;var CanSelect: Boolean);
    procedure pclMainChange(Sender: TObject);
    procedure btnLoadAnalysesFileClick(Sender: TObject);
    procedure btnSelectLessonClick(Sender: TObject);
    procedure btnNextLessonStepClick(Sender: TObject);
    procedure btnNewAnalysesClick(Sender: TObject);
    procedure btnConfirmPositionClick(Sender: TObject);
    procedure imgStartPosClick(Sender: TObject);
    procedure btnStartPosDeleteClick(Sender: TObject);
    procedure btnCancelPositionClick(Sender: TObject);
    procedure btnLoadFromDatabaseClick(Sender: TObject);
    procedure btnConfirmLessonCreationClick(Sender: TObject);
    procedure btnNewPositionClick(Sender: TObject);
    procedure cbxAutoNextClick(Sender: TObject);
    procedure btnHighLightClick(Sender: TObject);
    procedure btnAddLessonTextClick(Sender: TObject);
    procedure btnOpenAdminPanelClick(Sender: TObject);
    procedure btnChangePFPClick(Sender: TObject);
    procedure btnUpdateInfoClick(Sender: TObject);
  private
    { Private declarations }
    tLessonFile: TextFile;
    objBlackPlayer, objWhitePlayer: TUser;
    iBlackTime, iWhiteTime, iCol, iRow, iLessonID: Integer;
    bRated, bAnalysisLine, bTurnCache, bQuiz, bNewAnalysis, bCreatingLesson, bLessonFirstLine: Boolean;
    dTempTime: TDateTime;
    sAutoNext, sStartPos, sPosCache, sMoveCache, sPieceCache: String;
    arrRecord: Array[0..1] of TStringList;
    procedure blackWin(const sInfo: String);
    procedure whiteWin(const sInfo: String);
    procedure draw(const sInfo: String);
    procedure move(const sInfo: String);
    procedure promote(const sInfo: String);
    procedure square_click(const sInfo: String);
    procedure setClocks(const iTime: Integer);
    procedure populatePlayers;
    procedure populateLessons;
    procedure displayPlayers;
    procedure saveGameRecord(const sResult: String);
    procedure writeRecordToFile(const sStartPos: String = DEFAULT_STARTING_POSITION);
    procedure endGame;
    procedure clearRecords;
    procedure drawStartPositionPanelImages;
  public
    objUser: TUser;
    objBoard: TChessBoard;

    procedure createLesson;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
implementation

{$R *.dfm}

{ TfrmMain }

procedure TfrmMain.blackWin(const sInfo: String);
begin
  if (objWhitePlayer <> nil) and (objBlackPlayer <> nil) then
    begin
      stgRecord.Cells[Ord(not objBoard.getTurn),stgRecord.RowCount - 1] := '0-1';
      saveGameRecord('0-1');
      if bRated then
        begin
          objBlackPlayer.updateRating(objWhitePlayer.getRating,1);
          objWhitePlayer.updateRating(objBlackPlayer.getRating,0);
          objBlackPlayer.updateDatabase;
          objWhitePlayer.updateDatabase;
        end;
      endGame;
      showmessage('Black Wins');
    end
  else if bNewAnalysis then
    begin
      stgAnalyses.Cells[Ord(not objBoard.getTurn),stgAnalyses.RowCount - 1] := '0-1';
      bNewAnalysis := False;
      showmessage('Black Wins');
    end
  else
    showmessage('Black Wins');
end;

procedure TfrmMain.btnAddLessonTextClick(Sender: TObject);
begin
  writeLN(tLessonFile,'T' + redCreateLessonText.Lines[0] + sAutoNext);
end;

procedure TfrmMain.btnCancelPositionClick(Sender: TObject);
begin
  bNewAnalysis := False;
  objBoard.setBoard(sPosCache);
  objBoard.setActive(True);
  pnlSetStartPos.Hide;
end;

procedure TfrmMain.btnChallengeClick(Sender: TObject);
var
  sUsername: String;
  iRating: Integer;
begin
  if lbxPlayers.ItemIndex > -1 then
    begin
      with dmChess.tblUsers do
        begin
          Open;
          Locate('Username',lbxPlayers.Items[lbxPlayers.ItemIndex],[]);
          sUsername := FieldValues['Username'];
          iRating := FieldValues['Rating'];
          Close;
        end;

      with frmDialogs do
        begin
          Challenge;
          if FileExists('Data\pfps\' + sUsername + '.png') then
            imgPfp.Picture.LoadFromFile('Data\pfps\' + sUsername + '.png')
          else
            imgPfp.Picture.LoadFromFile('Assets\default_pfp.png');
          lblUsername.Caption := sUsername;
          lblRating.Caption := IntToStr(iRating);
          Left := (Self.Left + Self.Width div 2) - (Width div 2);
          Top := (Self.Top + Self.Height div 2) - (Height div 2);
          if ShowModal = mrOK then
            begin
              objBoard.setBoard();
              case cmbColour.ItemIndex of
                0: begin
                    objWhitePlayer := objUser;
                    objBlackPlayer := TUser.Create(sUsername);
                   end;
                1: begin
                    objWhitePlayer := TUser.Create(sUsername);
                    objBlackPlayer := objUser;
                   end;
                2: begin
                    if Random(2) = 1 then
                      begin
                        objWhitePlayer := objUser;
                        objBlackPlayer := TUser.Create(sUsername);
                      end
                    else
                      begin
                        objWhitePlayer := TUser.Create(sUsername);
                        objBlackPlayer := objUser;
                      end;
                   end;
              end;

              setClocks(sedMinutes.Value * 60 + sedSeconds.Value);
              bRated := cbxRated.Checked;
              objBoard.setActive(True);

              displayPlayers;
              clearRecords;
              stgRecord.Visible := True;
              dTempTime := now;
            end;
        end;
    end
      else
        MessageDlg('Please select a user to challenge.',mtWarning,[mbOK],0);
end;

procedure TfrmMain.btnChangePFPClick(Sender: TObject);
begin
  if odgOpen.Execute then
    begin
      if fileexists(odgOpen.FileName) then
        begin
          if Copy(odgOpen.FileName,Length(odgOpen.FileName) - 2,3) = 'jpg' then
            begin
              imgPFP.Picture.LoadFromFile(odgOpen.FileName);
              CopyFile(PWideChar(odgOpen.FileName),PWideChar('Data\pfps\' + objUser.getUsername + '.jpg'),False);
            end
          else
            MessageDLG('Operation cancelled or file not a ".jpg" file.',mtError,[mbOK],0);
        end;
    end;
end;

procedure TfrmMain.btnConfirmLessonCreationClick(Sender: TObject);
begin
  WriteLN(tLessonFile,'END');
  bCreatingLesson := False;
  pnlCreatingLesson.Hide;
  CloseFile(tLessonFile);
  populateLessons;
  frmAdmin.Enabled := True;
end;

procedure TfrmMain.btnConfirmPositionClick(Sender: TObject);
var
  I, iBlackKingCount, iWhiteKingCount: Integer;
  sGameState: String;
begin
  sGameState := objBoard.getGameState;

  iWhiteKingCount := 0;
  iBlackKingCount := 0;
  for I := 1 to Length(sGameState) do
    begin
      if sGameState[I] = 'k' then
        if sGameState[I + 1] = 'W' then
          inc(iWhiteKingCount)
        else
          inc(iBlackKingCount);
    end;

  if (iWhiteKingCount = 1) and (iBlackKingCount = 1) then
    begin
      clearRecords;
      pnlSetStartPos.Hide;
      sStartPos := sGameState;
      sPieceCache := '';
      objBoard.setActive(True);
      if bCreatingLesson then
        begin
          if bLessonFirstLine then
            begin
              writeLN(tLessonFile,sStartPos);
              bLessonFirstLine := False;
            end
          else
            writeLN(tLessonFile,'P' + sStartPos + sAutoNext);

          pnlCreatingLesson.Show
        end;
    end
  else
    begin
      MessageDlg('Each side must have 1 king!',mtError,[mbOK],0);
    end;
end;

procedure TfrmMain.btnHighLightClick(Sender: TObject);
begin
  objBoard.setActive(False);
  btnHighlight.Enabled := false;
end;

procedure TfrmMain.btnLoadAnalysesFileClick(Sender: TObject);
var
  tFile: TextFile;
  iPos: Integer;
  sTemp, sTemp2, sRecord: String;
begin
  if odgOpen.Execute then
    begin
      assignfile(tFile,odgOpen.FileName);
      reset(tFile);
    end
  else
    Exit;

  clearRecords;

  ReadLN(tFile,sStartPos);
  while not Eof(tFile) do
    begin
      ReadLN(tFile,sTemp);

      iPos := Pos(';',sTemp);
      sTemp2 := Copy(sTemp,1,iPos - 1);
      Delete(sTemp,1,iPos);
      Delete(sTemp,Length(sTemp),1);

      arrRecord[0].Add(sTemp2);
      arrRecord[1].Add(sTemp);

      if sTemp2[1] = 'O'  then
        sRecord := sTemp2
      else if sTemp2[7] = '$' then
        sRecord := UpperCase(sTemp2[3]) + Copy(sTemp2,1,2) + 'x' + Copy(sTemp2,5,2)
      else
        sRecord := UpperCase(sTemp2[3]) + Copy(sTemp2,1,2) + '-' + Copy(sTemp2,5,2);

      stgAnalyses.Cells[0,stgAnalyses.RowCount - 1] := sRecord;

      if sTemp <> '' then
        begin
          if sTemp[1] = 'O'  then
            sRecord := sTemp
          else if sTemp[7] = '$' then
            sRecord := UpperCase(sTemp[3]) + Copy(sTemp,1,2) + 'x' + Copy(sTemp,5,2)
          else
            sRecord := UpperCase(sTemp[3]) + Copy(sTemp,1,2) + '-' + Copy(sTemp,5,2);

          stgAnalyses.Cells[1,stgAnalyses.RowCount - 1] := sRecord;
        end
      else
        stgAnalyses.Cells[1,stgAnalyses.RowCount - 1] := '';

      stgAnalyses.RowCount := stgAnalyses.RowCount + 1;
    end;
    stgAnalyses.RowCount := stgAnalyses.RowCount - 1;

    objBoard.setBoard(sStartPos);
end;

procedure TfrmMain.btnLoadFromDatabaseClick(Sender: TObject);
var
  tFile: TextFile;
  iPos: Integer;
  sTemp, sTemp2, sRecord, sFile: String;
begin
  if frmGames.ShowModal = mrOK then
    begin
      sFile := 'Games\' + IntToStr(frmGames.iGameID) + '.txt';

      if FileExists(sFile) then
        assignfile(tFile,sFile)
      else
        begin
          MessageDlg('Game file not found.',mtError,[mbOK],0);
          Exit;
        end;

      Reset(tFile);

      clearRecords;

      ReadLN(tFile,sStartPos);
      while not Eof(tFile) do
        begin
          ReadLN(tFile,sTemp);

          iPos := Pos(';',sTemp);
          sTemp2 := Copy(sTemp,1,iPos - 1);
          Delete(sTemp,1,iPos);
          Delete(sTemp,Length(sTemp),1);

          arrRecord[0].Add(sTemp2);
          arrRecord[1].Add(sTemp);

          if sTemp2[1] = 'O'  then
            sRecord := sTemp2
          else if sTemp2[7] = '$' then
            sRecord := UpperCase(sTemp2[3]) + Copy(sTemp2,1,2) + 'x' + Copy(sTemp2,5,2)
          else
            sRecord := UpperCase(sTemp2[3]) + Copy(sTemp2,1,2) + '-' + Copy(sTemp2,5,2);

          stgAnalyses.Cells[0,stgAnalyses.RowCount - 1] := sRecord;

          if sTemp <> '' then
            begin
              if sTemp[1] = 'O'  then
                sRecord := sTemp
              else if sTemp[7] = '$' then
                sRecord := UpperCase(sTemp[3]) + Copy(sTemp,1,2) + 'x' + Copy(sTemp,5,2)
              else
                sRecord := UpperCase(sTemp[3]) + Copy(sTemp,1,2) + '-' + Copy(sTemp,5,2);

              stgAnalyses.Cells[1,stgAnalyses.RowCount - 1] := sRecord;
            end
          else
            stgAnalyses.Cells[1,stgAnalyses.RowCount - 1] := '';

          stgAnalyses.RowCount := stgAnalyses.RowCount + 1;
        end;
        stgAnalyses.RowCount := stgAnalyses.RowCount - 1;

        objBoard.setBoard(sStartPos);
    end;
end;

procedure TfrmMain.btnNewAnalysesClick(Sender: TObject);
begin
  bNewAnalysis := True;
  objBoard.setActive(False);
  sPosCache := objBoard.getGameState;
  objBoard.setBoard();
  pnlSetStartPos.Show;
end;

procedure TfrmMain.btnNewPositionClick(Sender: TObject);
begin
  pnlCreatingLesson.Hide;
  pnlSetStartPos.Show;
end;

procedure TfrmMain.btnNextLessonStepClick(Sender: TObject);
var
  sLine, sTemp: String;
  cCode: Char;
  bAutoNext: Boolean;
begin
  ReadLN(tLessonFile,sLine);
  if sLine = 'END' then
    begin
      lbxLessons.Show;
      btnSelectLesson.Enabled := True;
      btnNextLessonStep.Enabled := False;
      MessageDlg('Lesson Completed.',mtInformation,[mbOK],0);
      dmChess.tblLessons.Open;
      if dmChess.tblLessons.Locate('Lesson_ID',iLessonID,[]) then
        if dmChess.tblLessons['Lesson_Level'] = objUser.getLessonLevel then
          objUser.incrementLessonLevel;

      objUser.setCurrentLesson(-1);
      dmChess.tblLessons.Close;
      CloseFile(tLessonFile);
      iLessonID := -1;
      Exit;
    end;

  cCode := sLine[1];
  Delete(sLine,1,1);

  bAutoNext := Pos('*',sLine) = Length(sLine);
  if bAutoNext then
    Delete(sLine,Length(sLine),1);

  case cCode of
    'T':
        begin
          redLessonText.Clear;
          redLessonText.Lines.Add(sLine);
        end;
    'M':
        begin
          objBoard.move(sLine);
        end;
    'P':
        begin
          clearRecords;
          sTemp := sLine[1];
          Delete(sLine,1,1);
          objBoard.setBoard(sLine, sTemp = 'W');
        end;
    'H':
        begin
          objBoard.highlightSquare(sLine);
        end;
    'Q':
        begin
          objBoard.setActive(True);
          bTurnCache := objBoard.getTurn;
          sPosCache := objBoard.getGameState;
          sMoveCache := sLine;
          btnNextLessonStep.Enabled := False;
          bQuiz := True;
        end;
  end;

  if bAutoNext then
    btnNextLessonStepClick(btnNextLessonStep);

end;

procedure TfrmMain.btnOpenAdminPanelClick(Sender: TObject);
begin
  if objUser.getAdmin then
    frmAdmin.ShowModal;
end;

procedure TfrmMain.btnSelectLessonClick(Sender: TObject);
var
  sLine: String;
  iID: Integer;
begin
  sLine := lbxLessons.Items[lbxLessons.ItemIndex];
  iID := StrToInt(Copy(sLine,1,Pos(':',sLine) - 1));

  with dmChess.tblLessons do
    begin
      Open;
      if Locate('Lesson_ID',iID,[]) then
        begin
          with frmDialogs do
            begin
              Lesson;
              lblLessonName.Caption := 'Name: ' + FieldValues['Lesson_Name'];
              lblLessonLevel.Caption := 'Level: ' + IntToStr(FieldValues['Lesson_Level']);
              lblLessonDescriptionText.Caption := FieldValues['Lesson_Description'];
              Left := (Self.Left + Self.Width div 2) - (Width div 2);
              Top := (Self.Top + Self.Height div 2) - (Height div 2);

              if ShowModal = mrOK then
                begin
                  if fileexists('Lessons\' + IntToStr(iID) + '.txt') then
                    begin
                      assignfile(tLessonFile,'Lessons\' + IntToStr(iID) + '.txt');
                      Reset(tLessonFile);
                      ReadLN(tLessonFile,sStartPos);
                      objBoard.setBoard(sStartPos);
                      iLessonID := iID;
                      lbxLessons.Hide;
                      btnNextLessonStep.Enabled := True;
                      btnSelectLesson.Enabled := False;
                      objUser.setCurrentLesson(iID);
                      clearRecords;
                    end
                  else
                    begin
                      MessageDlg('Lesson File not found',mtError,[mbOK],0);
                      Exit;
                    end;
                end
              else
                Exit;
            end;
        end;
      Close;
    end;
end;

procedure TfrmMain.btnStartPosDeleteClick(Sender: TObject);
begin
  sPieceCache := '';
  drawStartPositionPanelImages;
end;

procedure TfrmMain.btnUpdateInfoClick(Sender: TObject);
var
  bChecksPassed: Boolean;
begin
  bChecksPassed := True;
  if ledUsername.Text = '' then
    begin
      lblUsernameCheck.Caption := '*This field is required.';
      bChecksPassed := False;
    end
  else if dmChess.tblUsers.Locate('Username',ledUsername.Text,[]) then
    begin
      lblUsernameCheck.Caption := '*Username is taken.';
      bChecksPassed := False;
    end
  else
    lblUsernameCheck.Caption := '';

  if ledPassword.Text = '' then
    begin
      lblPasswordCheck.Caption := '*This field is required.';
      bChecksPassed := False;
    end
  else if Length(ledPassword.text) < 8 then
    begin
      lblPasswordCheck.Caption := '*Password must be at' + #13 + 'least 8 characters long.';
      bChecksPassed := False;
    end
  else
    lblPasswordCheck.Caption := '';

  if ledConfirmPassword.Text = '' then
    begin
      lblConfirmPasswordCheck.Caption := '*This field is required.';
      bChecksPassed := False;
    end
  else if ledConfirmPassword.Text <> ledPassword.Text then
    begin
      lblConfirmPasswordCheck.Caption := '*Passwords must match';
      bChecksPassed := False;
    end
  else
    lblConfirmPasswordCheck.Caption := '';

  if bChecksPassed then
    begin
      with dmChess.tblUsers do
        begin
          Open;
          if Locate('Username',objUser.getUsername,[]) then
            begin
              Edit;
              FieldValues['Username'] := ledUsername.Text;
              FieldValues['Password'] := HashPassword(ledPassword.text);
              Post;
              objUser.changeUser(ledUsername.Text);
            end;
        end;
    end;
end;

procedure TfrmMain.cbxAutoNextClick(Sender: TObject);
begin
  if cbxAutoNext.Checked then
    sAutoNext := '*'
  else
    sAutoNext := '';
end;

procedure TfrmMain.clearRecords;
begin
  arrRecord[0].Clear;
  arrRecord[1].Clear;
  stgRecord.Cols[0].Clear;
  stgRecord.Cols[1].Clear;
  stgAnalyses.Cols[0].Clear;
  stgAnalyses.Cols[1].Clear;
  stgLessons.Cols[0].Clear;
  stgLessons.Cols[1].Clear;
  stgRecord.RowCount := 2;
  stgAnalyses.RowCount := 2;
  stgLessons.RowCount := 2;
  stgRecord.Cells[0,0] := 'White';
  stgRecord.Cells[1,0] := 'Black';
  stgAnalyses.Cells[0,0] := 'White';
  stgAnalyses.Cells[1,0] := 'Black';
  stgLessons.Cells[0,0] := 'White';
  stgLessons.Cells[1,0] := 'Black';
end;

procedure TfrmMain.createLesson;
begin
  assignFile(tLessonFile,'Lessons\' + IntToStr(dmChess.tblLessons['Lesson_ID']) + '.txt');
  rewrite(tLessonFile);

  bCreatingLesson := True;
  bLessonFirstLine := True;
  pnlSetStartPos.Show;
end;

procedure TfrmMain.displayPlayers;
begin
  lblWhite_Username.Caption := objWhitePlayer.getUsername;
  lblWhite_Rating.Caption := IntToStr(objWhitePlayer.getRating);
  if FileExists('Data\pfps\' + objWhitePlayer.getUsername + '.jpg') then
    imgWhite_pfp.Picture.LoadFromFile('Data\pfps\' + objWhitePlayer.getUsername + '.jpg')
  else
    imgWhite_pfp.Picture.LoadFromFile('Assets\default_pfp.png');

  lblBlack_Username.Caption := objBlackPlayer.getUsername;
  lblBlack_Rating.Caption := IntToStr(objBlackPlayer.getRating);
  if FileExists('Data\pfps\' + objBlackPlayer.getUsername + '.jpg') then
    imgBlack_pfp.Picture.LoadFromFile('Data\pfps\' + objBlackPlayer.getUsername + '.jpg')
  else
    imgBlack_pfp.Picture.LoadFromFile('Assets\default_pfp.png');
end;

procedure TfrmMain.draw(const sInfo: String);
begin
  if (objWhitePlayer <> nil) and (objBlackPlayer <> nil) then
    begin
      stgRecord.Cells[Ord(not objBoard.getTurn),stgRecord.RowCount - 1] := '1/2';
      saveGameRecord('1/2');
      if bRated then
        begin
          objBlackPlayer.updateRating(objWhitePlayer.getRating,0.5);
          objWhitePlayer.updateRating(objBlackPlayer.getRating,0.5);
          objBlackPlayer.updateDatabase;
          objWhitePlayer.updateDatabase;
        end;
      endGame;
      showmessage('Draw');
    end
 else if bNewAnalysis then
    begin
      stgAnalyses.Cells[Ord(not objBoard.getTurn),stgAnalyses.RowCount - 1] := '1/2';
      bNewAnalysis := False;
      showmessage('Draw');
    end
  else
    showmessage('Draw');
end;

procedure TfrmMain.drawStartPositionPanelImages;
begin
  //Drawing White Pieces

  imgKingW.Canvas.Brush.Color := clGreen;
  imgKingW.Canvas.FillRect(Rect(0,0,75,75));

  imgKingW.Canvas.Pen.Color := clBlack;
  imgKingW.Canvas.Pen.Width := 6;
  imgKingW.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgKingW.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(6).Graphic);

  imgQueenW.Canvas.Brush.Color := clMoneyGreen;
  imgQueenW.Canvas.FillRect(Rect(0,0,75,75));

  imgQueenW.Canvas.Pen.Color := clBlack;
  imgQueenW.Canvas.Pen.Width := 6;
  imgQueenW.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgQueenW.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(5).Graphic);

  imgRookW.Canvas.Brush.Color := clGreen;
  imgRookW.Canvas.FillRect(Rect(0,0,75,75));

  imgRookW.Canvas.Pen.Color := clBlack;
  imgRookW.Canvas.Pen.Width := 6;
  imgRookW.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgRookW.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(2).Graphic);

  imgBishopW.Canvas.Brush.Color := clMoneyGreen;
  imgBishopW.Canvas.FillRect(Rect(0,0,75,75));

  imgBishopW.Canvas.Pen.Color := clBlack;
  imgBishopW.Canvas.Pen.Width := 6;
  imgBishopW.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgBishopW.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(4).Graphic);

  imgKnightW.Canvas.Brush.Color := clGreen;
  imgKnightW.Canvas.FillRect(Rect(0,0,75,75));

  imgKnightW.Canvas.Pen.Color := clBlack;
  imgKnightW.Canvas.Pen.Width := 6;
  imgKnightW.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgKnightW.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(3).Graphic);

  imgPawnW.Canvas.Brush.Color := clMoneyGreen;
  imgPawnW.Canvas.FillRect(Rect(0,0,75,75));

  imgPawnW.Canvas.Pen.Color := clBlack;
  imgPawnW.Canvas.Pen.Width := 6;
  imgPawnW.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgPawnW.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(1).Graphic);

  //Drawing Black Pieces

  imgKingB.Canvas.Brush.Color := clGreen;
  imgKingB.Canvas.FillRect(Rect(0,0,75,75));

  imgKingB.Canvas.Pen.Color := clBlack;
  imgKingB.Canvas.Pen.Width := 6;
  imgKingB.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgKingB.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(12).Graphic);

  imgQueenB.Canvas.Brush.Color := clMoneyGreen;
  imgQueenB.Canvas.FillRect(Rect(0,0,75,75));

  imgQueenB.Canvas.Pen.Color := clBlack;
  imgQueenB.Canvas.Pen.Width := 6;
  imgQueenB.Canvas.Polyline([Point(0,0),Point(0,84),Point(84,84),Point(84,0),Point(0,0)]);;

  imgQueenB.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(11).Graphic);

  imgRookB.Canvas.Brush.Color := clGreen;
  imgRookB.Canvas.FillRect(Rect(0,0,75,75));

  imgRookB.Canvas.Pen.Color := clBlack;
  imgRookB.Canvas.Pen.Width := 6;
  imgRookB.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgRookB.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(8).Graphic);

  imgBishopB.Canvas.Brush.Color := clMoneyGreen;
  imgBishopB.Canvas.FillRect(Rect(0,0,75,75));

  imgBishopB.Canvas.Pen.Color := clBlack;
  imgBishopB.Canvas.Pen.Width := 6;
  imgBishopB.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgBishopB.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(10).Graphic);

  imgKnightB.Canvas.Brush.Color := clGreen;
  imgKnightB.Canvas.FillRect(Rect(0,0,75,75));

  imgKnightB.Canvas.Pen.Color := clBlack;
  imgKnightB.Canvas.Pen.Width := 6;
  imgKnightB.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgKnightB.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(9).Graphic);

  imgPawnB.Canvas.Brush.Color := clMoneyGreen;
  imgPawnB.Canvas.FillRect(Rect(0,0,75,75));

  imgPawnB.Canvas.Pen.Color := clBlack;
  imgPawnB.Canvas.Pen.Width := 6;
  imgPawnB.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);;

  imgPawnB.Canvas.StretchDraw(Rect(0,0,75,75),frmMain.objBoard.getAsset(7).Graphic);
end;

procedure TfrmMain.endGame;
var
  I: Integer;
begin
  sStartPos := DEFAULT_STARTING_POSITION;
  tmrBlack_Clock.Enabled := False;
  tmrWhite_Clock.Enabled := False;
  if objWhitePlayer <> objUser then
    objWhitePlayer.Destroy;
  if objBlackPlayer <> objUser then
    objBlackPlayer.Destroy;
  objWhitePlayer := nil;
  objBlackPlayer := nil;
  objBoard.setBoard();
  objBoard.setActive(False);
  stgRecord.Visible := False;
  stgAnalyses.RowCount := stgRecord.RowCount;
  for I := 0 to stgAnalyses.rowcount - 1 do
    stgAnalyses.Rows[I] := stgRecord.Rows[I];
  stgRecord.RowCount := 2;
  stgRecord.Cells[0,1] := '';
  stgRecord.Cells[1,1] := '';
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  arrRecord[0].Destroy;
  arrRecord[1].Destroy;
  frmDialogs.Destroy;
  objBoard.Destroy;
  objUser.updateDatabase;
  if (objWhitePlayer <> nil) and (objBlackPlayer <> nil) then
    begin
      objWhitePlayer.Destroy;
      objBlackPlayer.Destroy;
    end
  else if objUser <> nil then
    objUser.Destroy;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  sAutoNext := '';
  arrRecord[0] := TStringList.Create;
  arrRecord[1] := TStringList.Create;
  dmChess := TDmChess.Create(Self);
  frmAdmin := TFrmAdmin.Create(Self);
  frmGames := TFrmGames.Create(Self);
  frmLogin := TFrmLogin.Create(nil);
  frmDialogs := TFrmDialogs.Create(nil);
  iCol := 0;
  iRow := 1;
  bAnalysisLine := True;
  objBoard := TChessBoard.Create(Self,16,75);
  stgRecord.Cells[0,0] := 'White';
  stgRecord.Cells[1,0] := 'Black';
  iBlackTime := 30 * 60;
  iWhiteTime := 30 * 60;
  setEventHandler(CHESS_BLACK_WIN,blackWin);
  setEventHandler(CHESS_WHITE_WIN,whiteWin);
  setEventHandler(CHESS_DRAW,draw);
  setEventHandler(CHESS_MOVE,move);
  setEventHandler(CHESS_PROMOTE,promote);
  setEventHandler(CHESS_SQUARE_CLICK,square_click);
  tmrBlack_Clock.Enabled := False;
  tmrWhite_Clock.Enabled := False;
  if frmLogin.ShowModal = mrOK then
    begin
      objUser := TUser.Create;
      objUser.changeUser(frmLogin.sUsername);
      populatePlayers;
      populateLessons;
      drawStartPositionPanelImages;
      if FileExists('Data\pfps\' + objUser.getUsername + '.jpg') then
        imgPfp.Picture.LoadFromFile('Data\pfps\' + objUser.getUsername + '.jpg')
      else
        imgPfp.Picture.LoadFromFile('Assets\default_pfp.png');
    end
  else
    Application.Terminate;
  frmLogin.Destroy;
end;

procedure TfrmMain.imgStartPosClick(Sender: TObject);
var
  cColour, cPiece: Char;
  imgPiece: TImage;
begin
  imgPiece := TImage(Sender);
  drawStartPositionPanelImages;
  imgPiece.Canvas.Pen.Color := clBlue;
  imgPiece.Canvas.Pen.Width := 8;
  imgPiece.Canvas.Polyline([Point(0,0),Point(0,75),Point(75,75),Point(75,0),Point(0,0)]);
  cColour := imgPiece.Name[Length(imgPiece.Name)];

  if imgPiece.Name[4] = 'K' then
    begin
      if imgPiece.Name[5] = 'n' then
        cPiece := 'n'
      else
        cPiece := 'k';
    end
  else
    cPiece := lowercase(imgPiece.Name[4])[1];

  sPieceCache := cPiece + cColour;
end;

procedure TfrmMain.move(const sInfo: String);
var
  sRecord: String;
begin
  if (objWhitePlayer <> nil) and (objBlackPlayer <> nil) then
    begin
      if sInfo[1] = 'O'  then
        sRecord := sInfo
      else if sInfo[7] = '$' then
        sRecord := UpperCase(sInfo[3]) + Copy(sInfo,1,2) + 'x' + Copy(sInfo,5,2)
      else
        sRecord := UpperCase(sInfo[3]) + Copy(sInfo,1,2) + '-' + Copy(sInfo,5,2);

      stgRecord.Cells[Ord(objBoard.getTurn),stgRecord.RowCount - 1] := sRecord;
      arrRecord[Ord(objBoard.getTurn)].Add(sInfo);

      if objBoard.getTurn then
        begin
          tmrWhite_Clock.Enabled := True;
          tmrBlack_Clock.Enabled := False;
          stgRecord.RowCount := stgRecord.RowCount + 1;
        end
      else
        begin
          tmrWhite_Clock.Enabled := False;
          tmrBlack_Clock.Enabled := True;
        end;
    end
  else if bCreatingLesson then
    begin
      if cbxQuiz.Checked then
        writeLN(tLessonFile,'Q' + sInfo + sAutoNext)
      else
        writeLN(tLessonFile,'M' + sInfo + sAutoNext);
    end
  else if pclMain.ActivePage = tstAnalyse then
    begin
      if bNewAnalysis then
        begin
          if sInfo[1] = 'O'  then
            sRecord := sInfo
          else if sInfo[7] = '$' then
            sRecord := UpperCase(sInfo[3]) + Copy(sInfo,1,2) + 'x' + Copy(sInfo,5,2)
          else
            sRecord := UpperCase(sInfo[3]) + Copy(sInfo,1,2) + '-' + Copy(sInfo,5,2);

          stgAnalyses.Cells[Ord(objBoard.getTurn),stgAnalyses.RowCount - 1] := sRecord;
          arrRecord[Ord(objBoard.getTurn)].Add(sInfo);

          if objBoard.getTurn then
            stgAnalyses.RowCount := stgAnalyses.RowCount + 1;
        end
      else
        begin
          bAnalysisLine := False;
          iRow := 1;
          iCol := 0;
        end;
    end
  else if pclMain.ActivePage = tstLessons then
    begin
      if bQuiz then
        begin
          if sMoveCache = sInfo then
            begin
              objBoard.setActive(False);
              bQuiz := False;
              btnNextLessonStep.Enabled := True;
              btnNextLessonStepClick(btnNextLessonStep);
            end
          else
            begin
              objBoard.setBoard(sPosCache, bTurnCache);
              MessageDlg('Incorrect, Please try again.',mtInformation,[mbOK],0);
              Exit;
            end;
        end;
      if sInfo[1] = 'O'  then
        sRecord := sInfo
      else if sInfo[7] = '$' then
        sRecord := UpperCase(sInfo[3]) + Copy(sInfo,1,2) + 'x' + Copy(sInfo,5,2)
      else
        sRecord := UpperCase(sInfo[3]) + Copy(sInfo,1,2) + '-' + Copy(sInfo,5,2);

      stgLessons.Cells[Ord(objBoard.getTurn),stgLessons.RowCount - 1] := sRecord;
      arrRecord[Ord(objBoard.getTurn)].Add(sInfo);

      if objBoard.getTurn then
        stgLessons.RowCount := stgLessons.RowCount + 1;
    end;
end;

procedure TfrmMain.pclMainChange(Sender: TObject);
begin
  if (objWhitePlayer <> nil) and (objBlackPlayer <> nil) then
    pclMain.ActivePage := tstPlay
  else if pclMain.ActivePage = tstAnalyse then
    objBoard.setActive(True)
  else
    objBoard.setActive(False);
end;

procedure TfrmMain.populateLessons;
begin
  lbxLessons.Clear;
  with dmChess.tblLessons do
    begin
      Open;
      First;
      while not EOF do
        begin
          if FieldValues['Lesson_Level'] <= objUser.getLessonLevel then
            lbxLessons.Items.Add(IntToStr(FieldValues['Lesson_ID']) + ':' + FieldValues['Lesson_Name']);
          Next;
        end;
      Close;
    end;
end;

procedure TfrmMain.populatePlayers;
begin
  lbxPlayers.Clear;
  with dmChess.tblUsers do
    begin
      Open;
      First;
      while not EOF do
        begin
          if FieldValues['Username'] <> objUser.getUsername then
            lbxPlayers.Items.Add(FieldValues['Username']);
          Next;
        end;
      Close;
    end;
end;

procedure TfrmMain.promote(const sInfo: String);
var
  cPiece: Char;
begin
  if objBoard.getTurn then
    tmrWhite_Clock.Enabled := False
  else
    tmrBlack_Clock.Enabled := False;

  with frmDialogs do
    begin
      Promote;
      Left := Mouse.CursorPos.X;
      Top := Mouse.CursorPos.Y;
      if ShowModal = mrOK then
        cPiece := cPromote;
    end;

  if objBoard.getTurn then
    tmrWhite_Clock.Enabled := True
  else
    tmrBlack_Clock.Enabled := True;

  objBoard.pawnPromote(sInfo,cPiece);
end;

procedure TfrmMain.saveGameRecord(const sResult: String);
begin
  with dmChess.tblGames do
    begin
      Open;
      Last;
      Insert;
      FieldValues['White'] := objWhitePLayer.getUsername;
      FieldValues['Black'] := objBlackPlayer.getUsername;
      FieldValues['Result'] := sResult;
      FieldValues['Rated'] := bRated;
      FieldValues['DateTimePlayed'] := dTempTime;
      Post;
      writeRecordToFile;
      Close;
    end;
end;

procedure TfrmMain.sedRatingChange(Sender: TObject);
begin
  with dmChess.tblUsers do
    begin
      if sedMaxRating.Text = '' then
        sedMaxRating.Text := '0'
      else if sedMinRating.Text = '' then
        sedMinRating.Text := '0'
      else
        begin
          filter := '(Rating > ' + sedMinRating.Text + ') AND (Rating < ' + sedMaxRating.Text + ')';
          populatePlayers;
        end;
    end;
end;

procedure TfrmMain.setClocks(const iTime: Integer);
begin
  iBlackTime := iTime;
  iWhiteTime := iTime;
  lblWhite_Clock.Caption := IntToStr(iWhiteTime div 60) + ':' + IntToStr(iWhiteTime mod 60);
  lblBlack_Clock.Caption := IntToStr(iBlackTime div 60) + ':' + IntToStr(iBlackTime mod 60);
end;

procedure TfrmMain.square_click(const sInfo: String);
begin
  if pnlSetStartPos.Visible then
    begin
      if sPieceCache <> '' then
        begin
          if (not pos(sInfo,objBoard.getGameState) > 0) then
            objBoard.placePiece(sPieceCache + sInfo,False)
          else
            begin
              objBoard.removePiece(sInfo);
              objBoard.placePiece(sPieceCache + sInfo,cbxSetStartHasMoved.Checked);
            end;
        end
      else if pos(sInfo, objBoard.getGameState) > 0 then
        objBoard.removePiece(sInfo);
    end
  else if (not objBoard.getActive) and bCreatingLesson then
    begin
      objBoard.setActive(True);
      btnHighlight.Enabled := True;
      writeLN(tLessonFile,'H' + sInfo + sAutoNext);
      objBoard.highlightSquare(sInfo);
    end;
end;

procedure TfrmMain.stgSelectCell(Sender: TObject; ACol, ARow: Integer;var CanSelect: Boolean);
var
  I, J, iTemp: Integer;
  cColour: Char;
begin
  bNewAnalysis := False;
  if not bAnalysisLine then
    begin
      objBoard.setBoard(sStartPos);
      bAnalysisLine := True;
    end;

  if (objWhitePlayer = nil) and (objBlackPlayer = nil) then
    begin
      if ((iRow * 2) + iCol) < ((ARow * 2) + ACol) then
        begin
          for I := iRow - 1 to ARow - 1 do
            for J := 0 to 1 do
              begin
                if ((I <> ARow - 1) or (J <> ACol + 1) or ((I = iRow - 1) and (J = iCol)) or ((I <> iRow - 1) and (J <> iCol))) and (I <= arrRecord[J].Count - 1) then
                  if (arrRecord[J][I] <> '') then
                    if arrRecord[J][I] = 'O-O' then
                      begin
                        iTemp := 1 + J * 7;
                        objBoard.repositionPiece('h' + IntToStr(iTemp),'f' + IntToStr(iTemp));
                        objBoard.repositionPiece('e' + IntToStr(iTemp),'g' + IntToStr(iTemp));
                      end
                    else if arrRecord[J][I] = 'O-O-O' then
                      begin
                        iTemp := 1 + J * 7;
                        objBoard.repositionPiece('a' + IntToStr(iTemp),'d' + IntToStr(iTemp));
                        objBoard.repositionPiece('e' + IntToStr(iTemp),'c' + IntToStr(iTemp));
                      end
                    else if arrRecord[J][I][7] = '$' then
                      begin
                        objBoard.removePiece(Copy(arrRecord[J][I],5,2));
                        objBoard.repositionPiece(Copy(arrRecord[J][I],1,2),Copy(arrRecord[J][I],5,2));
                      end
                    else if length(arrRecord[J][I]) > 3 then
                      begin
                        objBoard.repositionPiece(Copy(arrRecord[J][I],1,2),Copy(arrRecord[J][I],5,2));
                      end;
              end;
        end
      else
        begin
          for I := iRow - 1 downto (ARow - 1 + ACol) do
            for J := 1 downto 0 do
              begin
                if J = 0 then
                  cColour := 'B'
                else
                  cColour := 'W';

                if ((I <> ARow - 1) or (J <> ACol) or ((I = iRow - 1) and (J = iCol))) and (I <= arrRecord[J].Count - 1) then
                  if (arrRecord[J][I] <> '') then
                    if arrRecord[J][I] = 'O-O' then
                      begin
                        iTemp := 1 + J * 7;
                        objBoard.repositionPiece('f' + IntToStr(iTemp),'h' + IntToStr(iTemp));
                        objBoard.repositionPiece('g' + IntToStr(iTemp),'e' + IntToStr(iTemp));
                      end
                    else if arrRecord[J][I] = 'O-O-O' then
                      begin
                        iTemp := 1 + J * 7;
                        objBoard.repositionPiece('d' + IntToStr(iTemp),'a' + IntToStr(iTemp));
                        objBoard.repositionPiece('c' + IntToStr(iTemp),'e' + IntToStr(iTemp));
                      end
                    else if arrRecord[J][I][7] = '$' then
                      begin
                        objBoard.repositionPiece(Copy(arrRecord[J][I],5,2),Copy(arrRecord[J][I],1,2));
                        objBoard.placePiece(arrRecord[J][I][8] + cColour + Copy(arrRecord[J][I],5,2),True);
                      end
                    else if length(arrRecord[J][I]) > 3 then
                      begin
                        objBoard.repositionPiece(Copy(arrRecord[J][I],5,2),Copy(arrRecord[J][I],1,2));
                      end;
              end;
        end;


      iCol := ACol;
      iRow := ARow;
    end;
end;

procedure TfrmMain.tmrBlack_ClockTimer(Sender: TObject);
begin
  dec(iBlackTime);

  lblBlack_Clock.Caption := IntToStr(iBlackTime div 60) + ':' + IntToStr(iBlackTime mod 60);
  if iBlackTime <= 0 then
    whiteWin('WIN W')
end;

procedure TfrmMain.tmrWhite_ClockTimer(Sender: TObject);
begin
  dec(iWhiteTime);

  lblWhite_Clock.Caption := IntToStr(iWhiteTime div 60) + ':' + IntToStr(iWhiteTime mod 60);
  if iWhiteTime <= 0 then
    blackWin('WIN B')
end;

procedure TfrmMain.whiteWin(const sInfo: String);
begin
  if (objWhitePlayer <> nil) and (objBlackPlayer <> nil) then
    begin
      stgRecord.Cells[Ord(not objBoard.getTurn),stgRecord.RowCount - 1] := '1-0';
      saveGameRecord('1-0');
      if bRated then
        begin
          objBlackPlayer.updateRating(objWhitePlayer.getRating,0);
          objWhitePlayer.updateRating(objBlackPlayer.getRating,1);
          objBlackPlayer.updateDatabase;
          objWhitePlayer.updateDatabase;
        end;
      endGame;
      showmessage('White Wins');
    end
  else if bNewAnalysis then
    begin
      stgAnalyses.Cells[Ord(not objBoard.getTurn),stgAnalyses.RowCount - 1] := '1-0';
      bNewAnalysis := False;
      showmessage('White Wins');
    end
  else
    showmessage('White Wins');
end;

procedure TfrmMain.writeRecordToFile(const sStartPos: String);
var
  tFile: TextFile;
  I,J: Integer;
  sLine: String;
begin
  AssignFile(tFile,'Games\' + IntToStr(dmChess.tblGames['GameID']) + '.txt');
  Rewrite(tFile);

  WriteLN(tFile,sStartPos);
  for I := 0 to arrRecord[0].Count - 1 do
    begin
    sLine := '';
      for J := 0 to 1 do
        begin
          if I <= arrRecord[J].Count - 1 then
            sLine := sLine + arrRecord[J][I] + ';';
        end;
      WriteLN(tFile,sLine);
    end;

  Closefile(tFile);

end;

end.
