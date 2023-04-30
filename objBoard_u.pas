unit objBoard_u;

interface

uses
  objPieces_u, SysUtils, ExtCtrls, Forms, JPEG, PNGImage, Graphics, Classes, EventManager_u, frmDebugLog_u;

// Constant holding the default starting position for a standard chess board.
const
  DEFAULT_STARTING_POSITION = 'rWa1;rWh1;nWb1;nWg1;bWf1;bWc1;qWd1;kWe1;pWa2;pWb2;pWc2;pWd2;pWe2;pWf2;pWg2;pWh2;rBa8;rBh8;nBb8;nBg8;bBf8;bBc8;qBd8;kBe8;pBa7;pBb7;pBc7;pBd7;pBe7;pBf7;pBg7;pBh7;';

type
  TChessBoard = Class
    {Chess board class with internal UI handling API. Apart of the board games lib in
     development by CoreLysium. Requires the event manager unit and the assets folder
     with all assets needed in order to work.}
    Private
      fGameBoard: Array['a'..'h',1..8] of TChessPieces; // Holds references to all pieces in their respective positions on the board.
      fUI: Array['a'..'h',1..8] of TImage; // Used to draw the board if DrawBoard is true and hold references to the images.
      fGameState: String; // Stores the current gamestate.
      fValidMoves: String; // Stores all validmoves with the current gamestate.
      fTurn: Boolean; // Keeps track of which player's turn it is.
      fDrawBoard: Boolean; // Determines whether the internal UI is used or not.
      fSelected: Boolean; // Determines whether a square on the board is selected.
      fSelectedPos: String; // The position of the most recently selected square.
      fImgPieces: Array[1..12] of TPicture; // Stores all the assets for the board.
      fActive: Boolean; // Determines whether the board's UI input handling is active.

      Procedure clearGameBoard; // Clear the GameBoard array.
      Procedure populateGameBoard; // Populates the GameBoard array based on the GameState variable.
      Procedure drawBoard; // Updates the UI for the board.
      Procedure boardSquareClick(Sender: TObject); // Event handler for the board classes internal UI squares click event.
      Procedure instantiateUI(const Form: TForm;const iCornerLeft,iCornerTop: Integer); // Instantiates all UI elements and draws the board to the passed form parameter.
      Procedure freeUI; // Free all UI elements from memory.
      Procedure freeImageFiles; // Frees all image assets from memory.
      Procedure getImageFiles; // Loads all images assets from the "Assets folder"
      Function castle(const sMove: String): String; // Handles the logic for castling.
      Function generateValidMoves(const sGameState: String): String; // Generates all valid moves based on the passed in game state.
      Function isInCheck(const sMove: String): Boolean; // Evaluates the current gamestate to determine whether a player is in check. Draws highlight if UI drawing true.
      Function isStaleMate: Boolean; // Determines whether the games is currently stalemate.
      Function turnColour: Char; // Returns the colour of the current player who's turn it is.
      Function notTurnColour: Char; // Returns the colour of the current player who's turn it is not.
    Public
      Constructor Create(const sGameState: String = DEFAULT_STARTING_POSITION;const bTurn: Boolean = True); Overload; // Creates the board class with its own UI handling disabled.
      Constructor Create(const Form: TForm;const iCornerLeft, iCornerTop: Integer; const sGameState: String = DEFAULT_STARTING_POSITION;const bTurn: Boolean = True); Overload; // Creates the board class with its own UI handling enabled.
      Procedure setBoard(const sGameState: String = DEFAULT_STARTING_POSITION;const bTurn: Boolean = True); // Sets the position of the board and who's turn it is.
      Procedure setUI(const Form: TForm; const iCornerLeft,iCornerTop: Integer); // Sets which form and where on that form the UI shoudl draw to. Also enables the UI if not active.
      Procedure disableUI; // Disables the UI if active.
      Procedure pawnPromote(const sPos: String;const cPromotionPiece: Char); // Promotes the pawn at the passed in position to the passed in piece code.
      Procedure setActive(const bActive: Boolean); // Set whether the board is interactable through its UI.
      Procedure toggleTurn; // Toggle the currently active turn.
      Procedure highlightSquare(sSquare: String); // Highlight the square at the passed in position. Only if UI active.
      Function getActive: Boolean; // Get the current state of whether the board is interactable through its UI.
      Function move(const sMove: String): String; // Updates the board and gamestate for the passed in move.
      Function getTurn: Boolean; // Get which players turn it currently is.
      Function placePiece(const sPiece: String; const bHasMoved: Boolean): Boolean; // Place a piece on the board and set whether it has moved or not.
      Function repositionPiece(const sPos,sNewPos: String): Boolean; // Reposition a piece on the board.
      Function removePiece(const sPos: String): Boolean; // Remove a piece from the board.
      Function getPieceImage(const iAssetNum: Integer): TPicture; // Get the image for a number of piece based on which players turn it currently is.
      Function getAsset(const iAssetNum: Integer): TPicture; // Get a specific asset stored in the boards UI.
      Function getGameState: String; // Set the boards current gamestate without updating the gameboard.
      Destructor Destroy; Override; //  Free the board and all used assets from memory
  End;

implementation

{ TChessBoard }

Procedure TChessBoard.freeImageFiles;
 {Loops through the image array calling their "destroy" method and setting the references
 to "nil". Effectively freeing them from memory and clearing the references.}
var
  I: Integer;
begin
  for I := 1 to 12 do
    begin
      fImgPieces[I].Destroy;
      fImgPieces[I] := nil;
    end;
end;

function TChessBoard.getActive: Boolean;
begin
  Result := fActive;
end;

function TChessBoard.getAsset(const iAssetNum: Integer): TPicture;
begin
  Result := fImgPieces[iAssetNum];
end;

function TChessBoard.getGameState: String;
begin
  Result := fGameState;
end;

Procedure TChessBoard.getImageFiles;
{Loads all the required image files from the assets folder for use in the board internal UI.
Assets folder should be placed in the same folder as this class with the images matching
the used naming convention. Feel free to change out the actual images as long as they are
png and match the naming convention.}
var
  I: Integer;
begin
  if fImgPieces[1] = nil then
    for I := 1 to 12 do
      fImgPieces[I] := TPicture.Create;

  fImgPieces[1].LoadFromFile('Assets\Pieces\W\p.png');
  fImgPieces[2].LoadFromFile('Assets\Pieces\W\r.png');
  fImgPieces[3].LoadFromFile('Assets\Pieces\W\n.png');
  fImgPieces[4].LoadFromFile('Assets\Pieces\W\b.png');
  fImgPieces[5].LoadFromFile('Assets\Pieces\W\q.png');
  fImgPieces[6].LoadFromFile('Assets\Pieces\W\k.png');
  fImgPieces[7].LoadFromFile('Assets\Pieces\B\p.png');
  fImgPieces[8].LoadFromFile('Assets\Pieces\B\r.png');
  fImgPieces[9].LoadFromFile('Assets\Pieces\B\n.png');
  fImgPieces[10].LoadFromFile('Assets\Pieces\B\b.png');
  fImgPieces[11].LoadFromFile('Assets\Pieces\B\q.png');
  fImgPieces[12].LoadFromFile('Assets\Pieces\B\k.png');
end;

function TChessBoard.getPieceImage(const iAssetNum: Integer): TPicture;
{Converts the current turn Boolean to either 0 or 1 and multiplies it with Six in order to
always return the piece asset corresponding with the current turn.}
begin
  Result := fImgPieces[iAssetNum + Ord(fTurn) * 6];
end;

procedure TChessBoard.boardSquareClick(Sender: TObject);
{Event handler for when the internal UI's squares are clicked. Will select sqaures.
Highlight the selected square and make moves on the board. Only works if Active.
Calls the external event handler for the CHESS_SQUARE_CLICK event regardless of whether
active or not.}
var
  imgSquare: TImage;
  sMove, sPos: String;
  iPos: Integer;
begin
  imgSquare := TImage(Sender); // Cast the sender to a TImage as now other type of sender can be assigned.
  sPos := imgSquare.Name; // Derive the position of the square from its name.
  callEventHandler(CHESS_SQUARE_CLICK,sPos);

  if not fActive then
    Exit; // Exit the procedure and avoid all processing if not active.

  if fSelected then
    begin
      // Attempt to make a move on the board if a square is already selected.
      sMove := fSelectedPos + fGameBoard[fSelectedPos[1],StrToInt(fSelectedPos[2])].getType + fGameBoard[fSelectedPos[1],StrToInt(fSelectedPos[2])].getColour + sPos;
      fSelected := False;
      sMove := move(sMove);
    end
  else
    begin
      iPos := Pos(sPos,fGameState); // Find the position in the gamestate of the piece occupying this square.
      if (iPos > 0) and (fGameState[iPos - 1] = turnColour) then
        begin
          // If a piece occupies this square set this square to be the selected square.
          fSelected := True;
          fSelectedPos := sPos;
          // Draws a highlight around the selected square.
          imgSquare.Canvas.Pen.Color := clYellow;
          imgSquare.Canvas.Pen.Width := 4;
          imgSquare.Canvas.Polyline([Point(0,0),Point(0,56),Point(56,56),Point(56,0),Point(0,0)]);
        end;
    end;
end;

function TChessBoard.castle(const sMove: String): String;
{Handles the special rules castling.}
var
  iPos: Integer;
begin
  if sMove[5] > 'e' then // Determine whether to castle king side or queen side.
    begin
      if not fGameBoard['e',StrToInt(sMove[2])].getHasMoved and (fGameBoard['h',StrToInt(sMove[2])] <> nil) then
        if not fGameBoard['h',StrToInt(sMove[2])].getHasMoved and (fGameBoard['h',StrToInt(sMove[2])].getType = 'r') then
          begin
            if isInCheck('') or isInCheck(Copy(sMove,1,4) + 'f' + sMove[2]) or isInCheck(Copy(sMove,1,4) + 'g' + sMove[2]) then
              begin
                // If castling is not allowed under cause the king is or will move through check exit the procedure and return and empty result.
                Result := '';
                Exit;
              end;

            // Find the king side rook and king in the gamestate and update the gamestate.
            iPos := Pos('r' + turnColour + 'h' + sMove[2],fGameState);
            fGameState[iPos + 2] := 'f';
            iPos := Pos('k' + turnColour + 'e' + sMove[2],fGameState);
            fGameState[iPos + 2] := 'g';

            // Move the references to the pieces on the GameBoard.
            fGameBoard['g',StrToInt(sMove[2])] := fGameBoard['e',StrToInt(sMove[2])];
            fGameBoard['e',StrToInt(sMove[2])] := nil;
            fGameBoard['f',StrToInt(sMove[2])] := fGameBoard['h',StrToInt(sMove[2])];
            fGameBoard['h',StrToInt(sMove[2])] := nil;

            // Set the pieces internal position tracking variable.
            fGameBoard['f',StrToInt(sMove[2])].setPosition('f' + sMove[2]);
            fGameBoard['g',StrToInt(sMove[2])].setPosition('g' + sMove[2]);

            // Set that the pieces have moved as we know castling would be impossible were these variables already false.
            fGameBoard['f',StrToInt(sMove[2])].setHasMoved(True);
            fGameBoard['g',StrToInt(sMove[2])].setHasMoved(True);

            Result := 'O-O'; // Set the result to the notation code for king side castling.
          end
      // If there are pieces in between the Rook and King or either has move return an empty result and do not castle.
        else
          Result := ''
      else
        Result := '';
    end
  else
    begin
      if not fGameBoard['e',StrToInt(sMove[2])].getHasMoved and (fGameBoard['a',StrToInt(sMove[2])] <> nil) then
        if not fGameBoard['a',StrToInt(sMove[2])].getHasMoved and (fGameBoard['a',StrToInt(sMove[2])].getType = 'r') then
          begin
            if isInCheck('') or isInCheck(Copy(sMove,1,4) + 'd' + sMove[2]) or isInCheck(Copy(sMove,1,4) + 'c' + sMove[2]) then
              begin
                // If castling is not allowed under cause the king is or will move through check exit the procedure and return and empty result.
                Result := '';
                Exit;
              end;

            // Find the queen side rook and king in the gamestate and update the gamestate.
            iPos := Pos('r' + turnColour + 'a' + sMove[2],fGameState);
            fGameState[iPos + 2] := 'd';
            iPos := Pos('k' + turnColour + 'e' + sMove[2],fGameState);
            fGameState[iPos + 2] := 'c';

            // Move the references to the pieces on the GameBoard.
            fGameBoard['c',StrToInt(sMove[2])] := fGameBoard['e',StrToInt(sMove[2])];
            fGameBoard['e',StrToInt(sMove[2])] := nil;
            fGameBoard['d',StrToInt(sMove[2])] := fGameBoard['a',StrToInt(sMove[2])];
            fGameBoard['a',StrToInt(sMove[2])] := nil;

            // Set the pieces internal position tracking variable.
            fGameBoard['c',StrToInt(sMove[2])].setPosition('c' + sMove[2]);
            fGameBoard['d',StrToInt(sMove[2])].setPosition('d' + sMove[2]);

            // Set that the pieces have moved as we know castling would be impossible were these variables already false.
            fGameBoard['c',StrToInt(sMove[2])].setHasMoved(True);
            fGameBoard['d',StrToInt(sMove[2])].setHasMoved(True);

            Result := 'O-O-O'; // Set the result to the notation code for queen side castling.
          end
      // If there are pieces in between the Rook and King or either has move return an empty result and do not castle.
        else
          Result := ''
      else
        Result := '';
    end;
end;

procedure TChessBoard.clearGameBoard;
 {Loops through the Gameboard array calling their "destroy" method and setting the references
 to "nil". Effectively freeing them from memory and clearing the references.}
var
  I: Integer;
  C: Char;
begin
  for C := 'a' to 'h' do
    for I := 1 to 8 do
      if fGameBoard[C,I] <> nil then
        begin
          fGameBoard[C,I].Destroy;
          fGameBoard[C,I] := nil;
        end;
end;

constructor TChessBoard.Create(const Form: TForm;const iCornerLeft, iCornerTop: Integer; const sGameState: String; const bTurn: Boolean);
{Creates the board with the UI active.}
begin
  // Initializes the boards attributes and starting gamestate..
  fGameState := sGameState;
  fValidMoves := '';
  fTurn := bTurn;
  fDrawBoard := True;
  fActive := False;

  // Ensure the gameboard is cleared and then populates it based on the starting gamestate.
  clearGameBoard;
  populateGameBoard;
  // Generates all initially valid moves based on the starting gamestate.
  fValidMoves := generateValidMoves(fGameState);

  // Instantiates the UI and draws it initially to the Form.
  instantiateUI(Form,iCornerLeft,iCornerTop);
end;

destructor TChessBoard.Destroy;
{Frees the boards used assets from memory before the board is freed.}
begin
  clearGameBoard; // Clears the Gameboard.
  if fDrawBoard then
    freeUI; // Free the UI from memory if the UI is drawn.
end;

procedure TChessBoard.disableUI;
begin
  if fDrawBoard then
    freeUI; // Free the UI from memory if the UI is drawn.
  fDrawBoard := False; // Set the board to not redraw the UI.
end;

procedure TChessBoard.drawBoard;
{Redraws the initialized board UI.}
var
  C: Char;
  I, iColour: Integer;
begin
  // Loop through both the Gameboard and UI arrays.
  for C := 'a' to 'h' do
    for I := 1 to 8 do
      begin
        // Draw the background colour for each square.
        if ((Ord(C) - 96) + I) mod 2 = 0 then
          begin
            fUI[C,I].Canvas.Brush.Color := clGreen;
            fUI[C,I].Canvas.FillRect(Rect(0,0,56,56));
          end
        else
          begin
            fUI[C,I].Canvas.Brush.Color := clMoneyGreen;
            fUI[C,I].Canvas.FillRect(Rect(0,0,56,56));
          end;

        // If a piece is present on that square in the Gameboard array draw it.
        if fGameBoard[C,I] <> nil then
          begin
            // Determine which colour piece to draw.
            if fGameBoard[C,I].getColour = 'W' then
              iColour := 0
            else
              iColour := 1;

            //Draw the piece from the loaded assets in memory.
            case fGameBoard[C,I].getType of
              'p': fUI[C,I].Canvas.StretchDraw(Rect(0,0,56,56),fImgPieces[1 + 6 * iColour].Graphic);
              'r': fUI[C,I].Canvas.StretchDraw(Rect(0,0,56,56),fImgPieces[2 + 6 * iColour].Graphic);
              'b': fUI[C,I].Canvas.StretchDraw(Rect(0,0,56,56),fImgPieces[4 + 6 * iColour].Graphic);
              'n': fUI[C,I].Canvas.StretchDraw(Rect(0,0,56,56),fImgPieces[3 + 6 * iColour].Graphic);
              'q': fUI[C,I].Canvas.StretchDraw(Rect(0,0,56,56),fImgPieces[5 + 6 * iColour].Graphic);
              'k': fUI[C,I].Canvas.StretchDraw(Rect(0,0,56,56),fImgPieces[6 + 6 * iColour].Graphic);
            end;
          end;
      end;
end;

procedure TChessBoard.freeUI;
{Loops through the UI array calling their "destroy" method and setting the references
 to "nil". Effectively freeing them from memory and clearing the references. Also frees the
 UI assets from memory.}
var
  C: Char;
  I: Integer;
begin
  for C := 'a' to 'h' do
    for I := 1 to 8 do
      begin
        fUI[C,I].Destroy;
        fUI[C,I] := nil;
      end;

  freeImageFiles;
end;

constructor TChessBoard.Create(const sGameState: String = DEFAULT_STARTING_POSITION;const bTurn: Boolean = True);
{Creates the board without the UI active.}
begin
  // Initializes the boards attributes and starting gamestate..
  fGameState := sGameState;
  fValidMoves := '';
  fTurn := bTurn;
  fDrawBoard := False;
  fActive := False;

  // Ensure the gameboard is cleared and then populates it based on the starting gamestate.
  clearGameBoard;
  populateGameBoard;
  // Generates all initially valid moves based on the starting gamestate.
  fValidMoves := generateValidMoves(fGameState);
end;

function TChessBoard.generateValidMoves(const sGameState: String): String;
{Queries all the pieces in the Gameboard with the passed in gamestate getting
their valid moves and compiling them.}
var
  C: Char;
  I: Integer;
  sValidMoves: String;
begin
  sValidMoves := ''; // Initialize the validmoves variable.
  // Loop through the gameboard.
  for C := 'a' to 'h' do
    for I := 1 to 8 do
      if fGameBoard[C,I] <> nil then
        sValidMoves := sValidMoves + fGameBoard[C,I].validMoves(sGameState); //  Get the individual piece's valid moves and add them to the boards valid move list.

  Result := sValidMoves; // Return all the valid moves.
end;

function TChessBoard.getTurn: Boolean;
begin
  Result := fTurn;
end;

procedure TChessBoard.highlightSquare(sSquare: String);
{Highlight a square on the board UI if the UI is drawn.}
var
  imgSquare: TImage;
begin
  if fDrawBoard then
    begin
      // Get a reference the specific UI square.
      imgSquare := fUI[sSquare[1],StrToInt(sSquare[2])];
      // Draw a blue highlight around the square.
      imgSquare.Canvas.Pen.Color := clBlue;
      imgSquare.Canvas.Pen.Width := 4;
      imgSquare.Canvas.Polyline([Point(0,0),Point(0,56),Point(56,56),Point(56,0),Point(0,0)]);
    end;
end;

procedure TChessBoard.instantiateUI(const Form: TForm;const iCornerLeft,iCornerTop: Integer);
{Loads the assets from disk into memory and populates the UI array. Draws the board to the Form}
var
  I: Integer;
  C: Char;
begin
  getImageFiles; // Loads assets from disk into memory.
  //Loop through the UI array initializing its elements.
  for C := 'a' to 'h' do
    for I := 1 to 8 do
      begin
        // Parent the components to the form.
        fUI[C,I] := TImage.Create(Form);
        fUI[C,I].Parent := Form;
        // Position the square currently being initialized.
        fUI[C,I].Left := iCornerLeft + (Ord(C) - 97) * 56;
        fUI[C,I].Top :=  iCornerTop + (7 * 56 - ((I - 1) * 56));
        fUI[C,I].Width := 56;
        fUI[C,I].Height := 56;

        fUI[C,I].Stretch := True;

        fUI[C,I].Name := C + IntToStr(I); // Names it based on its board position
        fUI[C,I].OnClick := boardSquareClick; // Set the square's onclick event handler.
      end;
  drawBoard; // Draw the board for the first time.
end;

function TChessBoard.isInCheck(const sMove: String): Boolean;
{Determine whether the current player who's turn it is, is in check.}
var
  sGameState, sValidMoves, sKingPos: String;
  iPos: Integer;
begin
  sGameState := fGameState; // Create a temporary copy of the Gamestate.
  
  if sMove <> '' then
    Begin
      // If move is off the board assume check to be true and exit the function.
       if not charInSet(sMove[5],['a'..'h']) or not charInSet(sMove[6],['1'..'8']) then
          begin
            Result := True;
            Exit;
          end;

      // Determine whether this move is a capture and if so remove the captured piece from the temporary gamestate.
      iPos := Pos(Copy(sMove,5,2),sGameState);
      if iPos > 0 then
        Delete(sGameState,iPos - 2,5);

      // Update the temporary gamestate to reflect the piece moved's new position.
      iPos := Pos(Copy(sMove,1,2),sGameState);
      sGameState[iPos] := sMove[5];
      sGameState[iPos + 1] := sMove[6];
    End;

  // Determine the position of the king in the temporary gamestate.
  iPos := Pos('k' + turnColour,sGameState);
  sKingPos := Copy(sGameState,iPos + 2,2);

  // Generate all valid moves based on the temporary gamestate.
  sValidMoves := generateValidMoves(sGameState);

  // Check if any of the opponents valid moves include taking the king. If so the king is in check.
  iPos := Pos(notTurnColour + sKingPos,sValidMoves);
  if iPos > 0 then
    begin
      Result := True;
      if fDrawBoard and (sMove = '') then
        begin
          // Draw a red highlight around the square of the king that is in check if the UI is drawn.
          fUI[sKingPos[1],StrToInt(sKingPos[2])].Canvas.Pen.Color := clRed;
          fUI[sKingPos[1],StrToInt(sKingPos[2])].Canvas.Pen.Width := 4;
          fUI[sKingPos[1],StrToInt(sKingPos[2])].Canvas.Polyline([Point(0,0),Point(0,56),Point(56,56),Point(56,0),Point(0,0)]);
        end;
    end
  else
    Result := False;

end;

function TChessBoard.isStaleMate: Boolean;
{Determines if the current player has any valid moves that do not result in check.}
var
  sValidMoves: String;
  iPos: Integer;
begin
  sValidMoves := fValidMoves; // Get all the current valid moves.
  //Loop through every valid move the current player who's turn it is has in the list.
  iPos := Pos(turnColour,sValidMoves);
  while iPos > 0 do
    begin
      // If any of the moves result in a position where the player is not in check it isn't stalemate.
      if not isInCheck(Copy(sValidMoves,iPos - 3,6)) then
        begin
          // Return false and exit the procedure entirely with no need to loop any further.
          Result := False;
          Exit;
        end;
      Delete(sValidMoves,iPos - 3,7);
      iPos := Pos(turnColour,sValidMoves);
    end;

  Result := True; //  If the procedure runs to completion all moves result in check therefor this function should return true.
end;

function TChessBoard.move(const sMove: String): String;
{Handles all logic for making any move on the board.}
var
  iPos: Integer;
  sCastled: String;
begin
  // If the player tried to move the piece onto the square it is already on invalidate the move and perform necessary checks.
  if Copy(sMove,1,2) = Copy(sMove,5,2) then
    begin
      Result := ''; // Invalidates this move.
      if fDrawBoard then
        begin
          drawBoard; // Redraw the board.
          isInCheck(''); // Recheck whether this position is in check or not.
        end;
      Exit;
    end;

  // If move will result in check invalidate the move and perform necessary checks.
  if isInCheck(sMove) then
    begin
      Result := ''; // Invalidate this move.
      if fDrawBoard then
        begin
          drawBoard; // Redraw the board.
          isInCheck(''); // Recheck whether this position is in check or not.
        end;
      Exit;
    end;

  // Check whether the move is within the valid moves list and if so perform the movement logic.
  iPos := Pos(sMove,fValidMoves);
  if iPos > 0 then
    begin
      Result := sMove; // Move is valid therefore should be returned.

      // Determine if the move is a capture and if so alter the result accordingly and delete the captured piece.
      if fGameBoard[sMove[5],StrToInt(sMove[6])] <> nil then
        begin
          Result := Result + '$' + fGameBoard[sMove[5],StrToInt(sMove[6])].getType; // Altering the result to indicate a capture.
          iPos := Pos(Copy(sMove,5,2),fGameState); // Finding the captured piece in the gamestate.
          Delete(fGameState,iPos - 2,5); // Removing the captured piece from the gamestate.
          fGameBoard[sMove[5],StrToInt(sMove[6])].Destroy; // Freeing the captured piece from memory on the gameboard. Reference will be overwritten therefore does not need to be cleared.
        end;

      // Find the moved piece in the gamestate and updates its position.
      iPos := Pos(Copy(sMove,1,2),fGameState);
      fGameState[iPos] := sMove[5];
      fGameState[iPos + 1] := sMove[6];

      fGameBoard[sMove[5],StrToInt(sMove[6])] := fGameBoard[sMove[1],StrToInt(sMove[2])]; //  Move the reference of the moved piece to its new position on the Gameboard.
      fGameBoard[sMove[1],StrToInt(sMove[2])] := nil; // Clear the moved piece's reference from its old position.

      fGameBoard[sMove[5],StrToInt(sMove[6])].setPosition(sMove[5] + sMove[6]); // Set the moved pieces internal position variable to its new position.
      fGameBoard[sMove[5],StrToInt(sMove[6])].setHasMoved(True); //  Set that the piece has now moved to true.

      fTurn := not fTurn; //  Toggle the players turn.
      callEventHandler(CHESS_MOVE,Result); // Call the external event handler for a moves completion if it is set.
      fValidMoves := generateValidMoves(fGameState); // Generate all the valid moves using the new gamestate.
    end
  // If move not in valid moves list check if this move is an attempt at castling and handle the logic accordingly.
  else if (sMove = 'e1kWg1') or (sMove = 'e1kWc1') or (sMove = 'e8kBg8') or (sMove = 'e8kBc8') then
    begin
      sCastled := castle(sMove); //  Call the castle function to determine the result of attempting to castle and to handle the logic.
      // If the castling wasn't invalidated set the result to the result of castling and end the turn.
      if sCastled <> '' then
        begin
          Result := sCastled;
          fTurn := not fTurn; // Toggle the players turn.
          callEventHandler(CHESS_MOVE,Result); // Call the external event handler for a moves completion if it is set.
          fValidMoves := generateValidMoves(fGameState); // Generate all the valid moves using the new gamestate.
        end
      else
        Result := '' // Invalidate the move if this attempt at castling is not possible.
    end
  // If move is neither an attempt at castling or a valid move invalidate the move.
  else
    Result := '';

  // If this move would result in a promotion call the external event handler for promotion if set.
  if (sMove[3] = 'p') and (((sMove[4] = 'W') and (sMove[6] = '8')) or ((sMove[4] = 'B') and (sMove[6] = '1'))) then
    callEventHandler(CHESS_PROMOTE,Copy(sMove,5,2)); // Promotion can only be performed by callling the board promote method. This signal should be used to determine when to do so and when to retrieve parameters for the procedure.

  if fDrawBoard then
    drawBoard; // If the UI is drawn. Redraw the board.

  // Check if this move resulted in check and modify the result to indicate this.
  if isInCheck('') then
    begin
      Result := Result + '+';
      // If a player is in check and the stalemate check returns true then it is checkmate and this move ends the game.
      if isStaleMate then
        begin
          Result := 'WIN ' + notTurnColour; // Set the result to indicate which colour won.
          // Call the winning colours external win event handler if set.
          if notTurnColour = 'B' then
            callEventHandler(CHESS_BLACK_WIN,Result)
          else
            callEventHandler(CHESS_WHITE_WIN,Result);
        end;
    end
  // else if the stalemate check passes alone it is stalemate and the game is a draw.
  else if isStaleMate then
    begin
      Result := 'DRAW'; // Set the result to indicate it is a draw.
      callEventHandler(CHESS_DRAW,Result); // Call the draw external even handler if set.
    end;
end;

function TChessBoard.notTurnColour: Char;
{Return the colour code if the player who's turn it is not.}
begin
  if fTurn then
    Result := 'B'
  else
    Result := 'W'
end;

procedure TChessBoard.pawnPromote(const sPos: String;const cPromotionPiece: Char);
{Promote the pawn at a certain position based on a piece code}
var
  cColour: Char;
  iPos: Integer;
begin
  cColour := fGameBoard[sPos[1],StrToInt(sPos[2])].getColour; // Retrieve the pawns colour.
  fGameBoard[sPos[1],StrToInt(sPos[2])].Destroy; // Free the pawn from memory.
  fGameBoard[sPos[1],StrToInt(sPos[2])] := nil; // Clear the pawn's reference from the Gameboard.
  // Instantiate the piece the pawn has promoted to based on the piece code and set its reference in the pawns position on the Gameboard.
  case cPromotionPiece of
    'p': fGameBoard[sPos[1],StrToInt(sPos[2])] := TPawn.Create(sPos,cColour,True);
    'r': fGameBoard[sPos[1],StrToInt(sPos[2])] := TRook.Create(sPos,cColour,True);
    'b': fGameBoard[sPos[1],StrToInt(sPos[2])] := TBishop.Create(sPos,cColour,True);
    'n': fGameBoard[sPos[1],StrToInt(sPos[2])] := TKnight.Create(sPos,cColour,True);
    'q': fGameBoard[sPos[1],StrToInt(sPos[2])] := TQueen.Create(sPos,cColour,True);
  end;
  iPos := Pos(sPos,fGameState); // Find the pawns position in the gamestate.
  fGameState[iPos - 2] := cPromotionPiece; // Change the pawns piece code in the gamestate to its new piece code.
  fValidMoves := generateValidMoves(fGameState); // Generate all valid move based on the new gamestate.
end;

function TChessBoard.placePiece(const sPiece: String; const bHasMoved: Boolean): Boolean;
{Places a piece somewhere on the board and sets whether it has moved or not.}
begin
  // If this square is not already occupied on the gameboard place the piece.
  if fGameBoard[sPiece[3],StrToInt(sPiece[4])] = nil then
    begin
      fGameState := fGameState + sPiece + ';'; // Add piece to the gamestate

      // Instantiate the piece corresponding to the piece code and place its reference in the correct square of the game board.
      case sPiece[1] of
        'p': fGameBoard[sPiece[3],StrToInt(sPiece[4])] := TPawn.Create(Copy(sPiece,3,2),sPiece[2],bHasMoved);
        'r': fGameBoard[sPiece[3],StrToInt(sPiece[4])] := TRook.Create(Copy(sPiece,3,2),sPiece[2],bHasMoved);
        'b': fGameBoard[sPiece[3],StrToInt(sPiece[4])] := TBishop.Create(Copy(sPiece,3,2),sPiece[2],bHasMoved);
        'n': fGameBoard[sPiece[3],StrToInt(sPiece[4])] := TKnight.Create(Copy(sPiece,3,2),sPiece[2],bHasMoved);
        'q': fGameBoard[sPiece[3],StrToInt(sPiece[4])] := TQueen.Create(Copy(sPiece,3,2),sPiece[2],bHasMoved);
        'k': fGameBoard[sPiece[3],StrToInt(sPiece[4])] := TKing.Create(Copy(sPiece,3,2),sPiece[2],bHasMoved);    
      end;
      fValidMoves := generateValidMoves(fGameState); // Generate all valid moves based on the new gamestate.
      Result := True; // Return true to indicate that the piece was successfully placed.
    end
  else
    Result := False; // Return false to indicate that the piece was not successfully placed.

  if fDrawBoard then
    drawBoard; // If the UI is drawn. Redraw the board.
end;

procedure TChessBoard.populateGameBoard;
{Instantiate and stores the references in the Gameboard for the current gamestate.}
var
  sInitQueue, sInit: String;
  iPos: Integer;
begin
  sInitQueue := fGameState; // Place the gamestate into a temporary variable which will act as the intialization queue.

  // Loops through each piece in the queue.
  iPos := Pos(';',sInitQueue);
  while iPos > 0 do
    begin
      sInit := Copy(sInitQueue,1,iPos - 1);
      Delete(sInitQueue,1,iPos);

      // Instantiate the piece corresponding to the piece code and place its reference in the correct square of the game board.
      case sInit[1] of
        'p': fGameBoard[sInit[3],StrToInt(sInit[4])] := TPawn.Create(Copy(sInit,3,2),sInit[2]);
        'r': fGameBoard[sInit[3],StrToInt(sInit[4])] := TRook.Create(Copy(sInit,3,2),sInit[2]);
        'b': fGameBoard[sInit[3],StrToInt(sInit[4])] := TBishop.Create(Copy(sInit,3,2),sInit[2]);
        'n': fGameBoard[sInit[3],StrToInt(sInit[4])] := TKnight.Create(Copy(sInit,3,2),sInit[2]);
        'q': fGameBoard[sInit[3],StrToInt(sInit[4])] := TQueen.Create(Copy(sInit,3,2),sInit[2]);
        'k': fGameBoard[sInit[3],StrToInt(sInit[4])] := TKing.Create(Copy(sInit,3,2),sInit[2]);
      end;

      iPos := Pos(';',sInitQueue);
    end;
end;

function TChessBoard.removePiece(const sPos: String): Boolean;
{Removes a piece from somewhere on the board.}
begin
  // If there is a piece occupying this square of the gameboard the remove it.
  if fGameBoard[sPos[1],StrToInt(sPos[2])] <> nil then
    begin
      Delete(fGameState,Pos(sPos,fGameState) - 2,5); // Delete the piece from the gamestate.

      fGameBoard[sPos[1],StrToInt(sPos[2])].Destroy; // Free the piece from memory.
      fGameBoard[sPos[1],StrToInt(sPos[2])] := nil; // Clear the pieces reference from the gameboard.

      fValidMoves := generateValidMoves(fGameState); // Generate all valid moves based on the new Gamestate.

      Result := True; // Return true in order to indicate that the piece was successfully removed.
    end
  else
    Result := False; // Return false to indicate there was no piece on that square to remove.

  if fDrawBoard then
    drawBoard; // If the UI is drawn. Redraw the board.
end;

function TChessBoard.repositionPiece(const sPos, sNewPos: String): Boolean;
{Reposition a piece on the board.}
var
  iPos: Integer;
begin
  // If there is a piece at the position and no piecde occupies the square it is being moved to move it.
  if (fGameBoard[sPos[1],StrToInt(sPos[2])] <> nil) and (fGameBoard[sNewPos[1],StrToInt(sNewPos[2])] = nil) then
    begin
      iPos := Pos(sPos,fGameState); // Find the piece in the gamestate.
      // Update the piece's position in the gamestate.
      fGameState[iPos] := sNewPos[1];
      fGameState[iPos + 1] := sNewPos[2];  
      
      fGameBoard[sNewPos[1],StrToInt(sNewPos[2])] := fGameBoard[sPos[1],StrToInt(sPos[2])]; // Move the reference to the piece on the Gameboard.
      fGameBoard[sNewPos[1],StrToInt(sNewPos[2])].setPosition(sNewPos); // Set the piece's internal position variable to the new position.

      fGameBoard[sPos[1],StrToInt(sPos[2])] := nil; // Clear the piece's reference from its old position.

      fValidMoves := generateValidMoves(fGameState); // Generate all valid moves based on the new gamestate.

      Result := True; // Return true if the piece was successfully repositioned.
    end
  else
    Result := False; // Return false if there was no piece on the position to reposition or if the square to reposition to was already occupied.

  if fDrawBoard then
    drawBoard; // If the UI is drawing. Redraw the board.
end;

procedure TChessBoard.setActive(const bActive: Boolean);
begin
  fActive := bActive;
end;

procedure TChessBoard.setBoard(const sGameState: String;const bTurn: Boolean);
{Set the board based on a passed in gamestate. Also set which players turn it is.}
begin
  fGameState := sGameState;
  fTurn := bTurn;

  clearGameBoard;
  populateGameBoard; // Clear the Gameboard and reset it based on the new gamestate.
  
  fValidMoves := generateValidMoves(fGameState); // Generate all valid moves based on the new gamestate.
  
  if fDrawBoard then
    drawBoard; // If the UI is drawing. Redraw the board.
end;

procedure TChessBoard.setUI(const Form: TForm; const iCornerLeft,iCornerTop: Integer);
{Set the internal UI to draw and set which form and where on that form to draw to.}
begin
  if fDrawBoard then
    freeUI; // If already drawing clear the previous UI.
  instantiateUI(Form,iCornerLeft,iCornerTop); // Instantiate the new UI.
  fDrawBoard := True; // Set that the UI is drawing.
end;

procedure TChessBoard.toggleTurn;
begin
  fTurn := not fTurn;
end;

function TChessBoard.turnColour: Char;
{Return the current colour's, which turn it is, code.}
begin
  if fTurn then
    Result := 'W'
  else
    Result := 'B';
end;

end.
