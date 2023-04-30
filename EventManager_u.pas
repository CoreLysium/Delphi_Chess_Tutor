unit EventManager_u;

interface

type
  TEventList = (CHESS_BLACK_WIN,CHESS_WHITE_WIN,CHESS_MOVE,CHESS_SQUARE_CLICK,CHESS_PROMOTE,CHESS_DRAW);
  TEvent = procedure(const sInfo: String) of object;

  procedure setEventHandler(const event: TEventList;const handler: TEvent);
  procedure callEventHandler(const event: TEventList;const sInfo: String);

  var
    fEventHandlers: Array[CHESS_BLACK_WIN..CHESS_DRAW] of TEvent;

implementation

{ TEventManager }

procedure callEventHandler(const event: TEventList;const sInfo: String);
begin
  if Assigned(fEventHandlers[event]) then
    fEventHandlers[event](sInfo);
end;

procedure setEventHandler(const event: TEventList;
  const handler: TEvent);
begin
  fEventHandlers[event] := handler;
end;

end.
