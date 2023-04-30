unit dmChess_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdmChess = class(TDataModule)
    conChess: TADOConnection;
    tblUsers: TADOTable;
    tblGames: TADOTable;
    tblLessons: TADOTable;
    qryChess: TADOQuery;
    tblGamesGameID: TAutoIncField;
    tblGamesWhite: TWideStringField;
    tblGamesBlack: TWideStringField;
    tblGamesResult: TWideStringField;
    tblGamesRated: TBooleanField;
    tblGamesDateTimePlayed: TDateTimeField;
    dsrGames: TDataSource;
    dsrChess: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmChess: TdmChess;

implementation

{$R *.dfm}

end.
