unit objPieces_u;

interface

uses
  SysUtils, Dialogs;

type
  TChessPieces = Class
    {Baseclass for all chess pieces in the board games lib for delphi by CoreLysium.
    This class is not designed to be used on its own and should only be inherited from.}
    Private
      fPosition: String; // Tracks the piece's position.
      fColour: Char; // Colour code of the piece.
      fHasMoved: Boolean; // Has this piece moved.
      fType: Char; // The type code of the piece.

      function oppositeColour: Char; // Returns the opposite colour code of this piece.
    Public
      constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Virtual; Abstract; // Abstract constructor to be overridden by subclasses.
      function toString: String; Override; // Returns a string representation of this piece.

      procedure setPosition(const sNewPos: String); // Set this piece's position.
      procedure setHasMoved(const bHasMoved: Boolean); // Set whether this piece has moved or not.
      function getType: Char; // Get this piece's type code.
      function getHasMoved: Boolean; // Get whether this piece as moved or not.
      function getColour: Char; // Get this piece's colour.

      function validMoves(const sGameState: String): String; Virtual; Abstract; // Generates all this pieces valid moves based on the current gamestate. Abstract method to be overridden by subclasses.
  End;

  {Following piece classses inherit from the "TChessPieces" base class and implement its abstract methods.
  See base class for details.}

  TPawn = Class(TChessPieces)
    Public
      Constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Override;
      function validMoves(const sGameState: String): String; Override;
  End;

  TBishop = Class(TChessPieces)
    Public
      Constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Override;
      function validMoves(const sGameState: String): String; Override;
  End;

  TRook = Class(TChessPieces)
    Public
      Constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Override;
      function validMoves(const sGameState: String): String; Override;
  End;

  TQueen = Class(TChessPieces)
    Public
      Constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Override;
      function validMoves(const sGameState: String): String; Override;
  End;

  TKnight = Class(TChessPieces)
    Public
      Constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Override;
      function validMoves(const sGameState: String): String; Override;
  End;

  TKing = Class(TChessPieces)
    Public
      Constructor Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean = False); Override;
      function validMoves(const sGameState: String): String; Override;
  End;

implementation

{ TChessPieces }

function TChessPieces.getColour: Char;
begin
  Result := fColour;
end;

function TChessPieces.getHasMoved: Boolean;
begin
  Result := fHasMoved;
end;

function TChessPieces.getType: Char;
begin
  Result := fType;
end;

function TChessPieces.oppositeColour: Char;
begin
  if fColour = 'W' then
    Result := 'B'
  else
    Result := 'W';
end;

procedure TChessPieces.setHasMoved(const bHasMoved: Boolean);
begin
  fHasMoved := bHasMoved;
end;

procedure TChessPieces.setPosition(const sNewPos: String);
begin
  fPosition := sNewPos;
end;

function TChessPieces.toString: String;
begin
  Result := 'Piece Type: ' + fType + #13
          + 'Colour: ' + fColour + #13
          + 'Position: ' + fPosition + #13
          + 'Has Moved: ' + BoolToStr(fHasMoved);
end;

{ TPawn }

constructor TPawn.Create(const sPosition: String;const cColour: Char;const bHasMoved: Boolean);
begin
  fPosition := sPosition;
  fColour := cColour;
  fHasMoved := bHasMoved;
  fType := 'p'; // Sets the type code to the code for a pawn.
end;

function TPawn.validMoves(const sGameState: String): String;
{Checks the squares in this pieces movement pattern and sees if they are valid moves or not.
Add them to the valid moves list and returns said list.}
var
  sCheckPos, sValidMoves: String;
  iColour: Integer;
begin
  if Pos(fType + fColour + fPosition,sGameState) <= 0 then
    Exit; // If this piece is not in the gamestate then it is impossible for it to have any moves.

  sValidMoves := ''; // Initialize the list of valid moves.

  // Convert the colour code into and integer for direction calculation based on colour as pawns cannot move backwards.
  if fColour = 'W' then
    iColour := 1
  else
    iColour := -1;
  
  sCheckPos := fPosition;
  sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + iColour)[1]; // Sets the checkpos to one in front of the pawn's position.
  if Pos(sCheckPos,sGameState) <= 0 then
    begin
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // Adds moving to the checkpos as a valid move if there is no piece occupying it.

      if not fHasMoved then
        begin
          sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + iColour)[1]; // If the pawn hasn't moved it must also check the second square in front of it.
          if Pos(sCheckPos,sGameState) <= 0 then
            sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // Sets the checkpos to one in front of the pawn's position.
        end;
    end;

  sCheckPos := fPosition;
  sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + iColour)[1]; // Sets the checkpos to one in front of the pawn.

  inc(sCheckPos[1]); // Moves the checkpos to be diagonally in front of the pawn.
  if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
    sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // Adds moving to the checkpos as a valid move if it is occupied by a piece of the opposite colour.

  dec(sCheckPos[1],2); // Moves the checkpos to the other square diagonally in front of the pawn.
  if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
    sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // Adds moving to the checkpos as a valid move if it is occupied by a piece of the opposite colour.

  Result := sValidMoves; // Return the list of valid moves.
end;

{ TBishop }

constructor TBishop.Create(const sPosition: String; const cColour: Char;
  const bHasMoved: Boolean);
begin
  fPosition := sPosition;
  fColour := cColour;
  fHasMoved := bHasMoved;
  fType := 'b'; // Sets the type code to the code for a bishop.
end;

function TBishop.validMoves(const sGameState: String): String;
{Checks the squares in this pieces movement pattern and sees if they are valid moves or not.
Add them to the valid moves list and returns said list.}
var
  sCheckPos, sValidMoves: String;
  I, J: Integer;
begin
  if Pos(fType + fColour + fPosition,sGameState) <= 0 then
    Exit; // If this piece is not in the gamestate then it is impossible for it to have any moves.

  sValidMoves := ''; // Initialize the list of valid moves.

  // Loops through every diagonal relative to the piece's position.
  I := 3;
  Repeat
    Dec(I,2);
    J := 3;
    Repeat
      Dec(J,2);
      //Loops through every square on the currently being checked diagonal setting the checkpos.
      sCheckPos := fPosition;
      Repeat
        inc(sCheckPos[1],I);
        sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + J)[1];

        if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
          begin
            sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos occupied by a piece of the opposite colour add moving to it to the valid moves.
            Break; // If checkpos is occupied by a piece of the opposite colour then it is impossible for the piece to move any further on this diagonal.
          end
        else if Pos(sCheckPos,sGameState) > 0 then
          Break // If checkpos is occupied by a piece of the same colour then it is impossible for the piece to move any further on this diagonal.
        else
          sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos unoccupied then add moving to it to the valid moves list.

      Until (sCheckPos[1] >= 'h') or (StrToInt(sCheckPos[2]) >= 8) or (sCheckPos[1] <= 'a') or (StrToInt(sCheckPos[2]) <= 1);
    Until J = -1;
  Until I = -1;

  Result := sValidMoves; // Return the list of valid moves.
end;

{ TRook }

constructor TRook.Create(const sPosition: String; const cColour: Char;
const bHasMoved: Boolean);
begin
  fPosition := sPosition;
  fColour := cColour;
  fHasMoved := bHasMoved;
  fType := 'r' // Sets the type code to the code for a bishop.
end;

function TRook.validMoves(const sGameState: String): String;
{Checks the squares in this pieces movement pattern and sees if they are valid moves or not.
Adds them to the valid moves list and returns said list.}
var
  sCheckPos, sValidMoves: String;
  I: Integer;
begin
  if Pos(fType + fColour + fPosition,sGameState) <= 0 then
    Exit; // If this piece is not in the gamestate then it is impossible for it to have any moves.

  sValidMoves := ''; // Initialize the list of valid moves.

  // Loop through the the two directions of the row relative to this piece.
  I := 3;
  repeat
    Dec(I,2);
    // Loops through every square in this direction on the row setting the checkpos.
    sCheckPos := fPosition;
    repeat
      inc(sCheckPos[1],I);

      if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
        begin
          sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos occupied by a piece of the opposite colour add moving to it to the valid moves.
          Break; // If checkpos is occupied by a piece of the opposite colour then it is impossible for the piece to move any further in this direction.
        end
      else if Pos(sCheckPos,sGameState) > 0 then
        Break // If checkpos is occupied by a piece of the same colour then it is impossible for the piece to move any further in this direction.
      else
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos unoccupied then add moving to it to the valid moves list.

    until (sCheckPos[1] >= 'h') or (sCheckPos[1] <= 'a');
  until I = -1;

  // Loop through the the two directions of the column relative to this piece.
  I := 3;
  repeat
    Dec(I,2);
    // Loops through every square in this direction on the column setting the checkpos.
    sCheckPos := fPosition;
    repeat
      sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + I)[1];

      if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
        begin
          sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos occupied by a piece of the opposite colour add moving to it to the valid moves.
          Break; // If checkpos is occupied by a piece of the opposite colour then it is impossible for the piece to move any further in this direction.
        end
      else if Pos(sCheckPos,sGameState) > 0 then
        Break // If checkpos is occupied by a piece of the same colour then it is impossible for the piece to move any further in this direction.
      else
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos unoccupied then add moving to it to the valid moves list.

    until (StrToInt(sCheckPos[2]) >= 8) or (StrToInt(sCheckPos[2]) <= 1);
  until I = -1;

  Result := sValidMoves; // Return the list of valid moves.
end;

{ TQueen }

constructor TQueen.Create(const sPosition: String; const cColour: Char;
  const bHasMoved: Boolean);
begin
  fPosition := sPosition;
  fColour := cColour;
  fHasMoved := bHasMoved;
  fType := 'q'; // Sets the type code to the code for a queen.
end;

function TQueen.validMoves(const sGameState: String): String;
{Checks the squares in this pieces movement pattern and sees if they are valid moves or not.
Adds them to the valid moves list and returns said list.}
var
  sCheckPos, sValidMoves: String;
  I, J: Integer;
begin
  if Pos(fType + fColour + fPosition,sGameState) <= 0 then
    Exit; // If this piece is not in the gamestate then it is impossible for it to have any moves.

  sValidMoves := ''; // Initialize the list of valid moves.

  // Loops through every diagonal relative to the piece's position.
  I := 3;
  Repeat
    Dec(I,2);
    J := 3;
    Repeat
      Dec(J,2);
      //Loops through every square on the currently being checked diagonal setting the checkpos.
      sCheckPos := fPosition;
      Repeat
        inc(sCheckPos[1],I);
        sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + J)[1];

        if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
          begin
            sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos occupied by a piece of the opposite colour add moving to it to the valid moves.
            Break; // If checkpos is occupied by a piece of the opposite colour then it is impossible for the piece to move any further on this diagonal.
          end
        else if Pos(sCheckPos,sGameState) > 0 then
          Break // If checkpos is occupied by a piece of the same colour then it is impossible for the piece to move any further on this diagonal.
        else
          sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos unoccupied then add moving to it to the valid moves list.

      Until (sCheckPos[1] >= 'h') or (StrToInt(sCheckPos[2]) >= 8) or (sCheckPos[1] <= 'a') or (StrToInt(sCheckPos[2]) <= 1);
    Until J = -1;
  Until I = -1;

  // Loop through the the two directions of the row relative to this piece.
  I := 3;
  repeat
    Dec(I,2);
    // Loops through every square in this direction on the row setting the checkpos.
    sCheckPos := fPosition;
    repeat
      inc(sCheckPos[1],I);

      if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
        begin
          sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos occupied by a piece of the opposite colour add moving to it to the valid moves.
          Break; // If checkpos is occupied by a piece of the opposite colour then it is impossible for the piece to move any further in this direction.
        end
      else if Pos(sCheckPos,sGameState) > 0 then
        Break // If checkpos is occupied by a piece of the same colour then it is impossible for the piece to move any further in this direction.
      else
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos unoccupied then add moving to it to the valid moves list.

    until (sCheckPos[1] >= 'h') or (sCheckPos[1] <= 'a');
  until I = -1;

  // Loop through the the two directions of the column relative to this piece.
  I := 3;
  repeat
    Dec(I,2);
    // Loops through every square in this direction on the column setting the checkpos.
    sCheckPos := fPosition;
    repeat
      sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + I)[1];

      if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
        begin
          sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos occupied by a piece of the opposite colour add moving to it to the valid moves.
          Break; // If checkpos is occupied by a piece of the opposite colour then it is impossible for the piece to move any further in this direction.
        end
      else if Pos(sCheckPos,sGameState) > 0 then
        Break // If checkpos is occupied by a piece of the same colour then it is impossible for the piece to move any further in this direction.
      else
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If checkpos unoccupied then add moving to it to the valid moves list.

    until (StrToInt(sCheckPos[2]) >= 8) or (StrToInt(sCheckPos[2]) <= 1);
  until I = -1;

  Result := sValidMoves; // Return the list of valid moves.
end;

{ TKnight }

constructor TKnight.Create(const sPosition: String; const cColour: Char;
  const bHasMoved: Boolean);
begin
  fPosition := sPosition;
  fColour := cColour;
  fHasMoved := bHasMoved;
  fType := 'n'; // Sets the type code to the code for a knight.
end;

function TKnight.validMoves(const sGameState: String): String;
{Checks the squares in this pieces movement pattern and sees if they are valid moves or not.
Adds them to the valid moves list and returns said list.}
var
  sCheckPos, sValidMoves: String;
  I, J, iPos: Integer;
begin
  if Pos(fPosition,sGameState) <= 0 then
    Exit; // If this piece is not in the gamestate then it is impossible for it to have any moves.

  sValidMoves := ''; // Initialize the valid moves list.

  // Loop through the top and bottom directions relative to the pieces position setting the check pos to 2 squares onwards in that direction.
  I := 6;
  repeat
    sCheckPos := fPosition;
    dec(I,4);
    sCheckPos := sCheckPos[1] + IntToStr(StrToInt(sCheckPos[2]) + I);
    // Loop through the left and right directions moving the checkpos 1 to either side.
    J := 4;
    repeat
      dec(J,3);
      inc(sCheckPos[1],J);

      if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';' // If the checkpos is occupied by a piece of the opposite colour add moving to it to the valid moves list.
      else if not (Pos(sCheckPos,sGameState) > 0) then
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If the check isn't occupied add moving to it to the valid moves list.

    until J = -2;
  until I = -2;

  // Loop through the left and right directions relative to the pieces position setting the check pos to 2 squares onwards in that direction.
  I := 6;
  repeat
    sCheckPos := fPosition;
    dec(I,4);
    inc(sCheckPos[1],I);
    // Loop through the bottom and top directions moving the checkpos 1 to either side.
    J := 4;
    repeat
      dec(J,3);
      sCheckPos := sCheckPos[1] + IntToStr(StrToInt(sCheckPos[2]) + J);

      if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';' // If the checkpos is occupied by a piece of the opposite colour add moving to it to the valid moves list.
      else if not (Pos(sCheckPos,sGameState) > 0) then
        sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If the check isn't occupied add moving to it to the valid moves list.

    until J = -2;
  until I = -2;

  // Filter out any moves that extend off the board and can cause unpredicted behaviour from the valid moves list.
  iPos := Pos('10',sValidMoves);
  while iPos > 0 do
    begin
      Delete(sValidMoves,iPos-5,8);
      iPos := Pos('10',sValidMoves);
    end;

  Result := sValidMoves; // Return the list of valid moves.
end;

{ TKing }

constructor TKing.Create(const sPosition: String; const cColour: Char;
  const bHasMoved: Boolean);
begin
  fPosition := sPosition;
  fColour := cColour;
  fHasMoved := bHasMoved;
  fType := 'k'; // Sets the type code to the code for a king.
end;

function TKing.validMoves(const sGameState: String): String;
{Checks the squares in this pieces movement pattern and sees if they are valid moves or not.
Adds them to the valid moves list and returns said list.}
var
  sCheckPos, sValidMoves: String;
  I, J: Integer;
begin
  if Pos(fType + fColour + fPosition,sGameState) <= 0 then
    Exit; // If this piece is not in the gamestate then it is impossible for it to have any moves.

  sValidMoves := ''; // Initialize the valid moves list.

  I := 3;
  Repeat
    Dec(I,2);
    J := 3;
    Repeat
      Dec(J,2);
      sCheckPos := fPosition;
      inc(sCheckPos[1],I);
      sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + J)[1];

    if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';' // If the checkpos is occupied by a piece of the opposite colour add moving to it to the valid moves list.
    else if not ((sCheckPos[2] = '0') or (sCheckPos[2] = '9') or (sCheckPos[1] = '`') or (sCheckPos[1] = 'i') or (Pos(fColour + sCheckPos,sGameState) > 0)) then
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If the check isn't occupied add moving to it to the valid moves list.

    Until J = -1;
  Until I = -1;

  I := 3;
  repeat
    sCheckPos := fPosition;
    Dec(I,2);
    inc(sCheckPos[1],I);

    if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';' // If the checkpos is occupied by a piece of the opposite colour add moving to it to the valid moves list.
    else if (sCheckPos[1] = '`') or (sCheckPos[1] = 'i') or (Pos(fColour + sCheckPos,sGameState) > 0) then
      sValidMoves := sValidMoves
    else
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If the check isn't occupied add moving to it to the valid moves list.

  until I = -1;

  I := 3;
  repeat
    sCheckPos := fPosition;

    Dec(I,2);
    sCheckPos[2] := IntToStr(StrToInt(sCheckPos[2]) + I)[1];

    if Pos(oppositeColour + sCheckPos,sGameState) > 0 then
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';' // If the checkpos is occupied by a piece of the opposite colour add moving to it to the valid moves list.
    else if not ((sCheckPos[2] = '0') or (sCheckPos[2] = '9') or (Pos(fColour + sCheckPos,sGameState) > 0)) then
      sValidMoves := sValidMoves + fPosition + fType + fColour + sCheckPos + ';'; // If the check isn't occupied add moving to it to the valid moves list.

  until I = -1;

  Result := sValidMoves; // Returns the list of valid moves.
end;

end.
