unit frmDebugLog_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmDebug = class(TForm)
    memOut: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure log(sLine: String);
  end;

var
  frmDebug: TfrmDebug;

implementation

{$R *.dfm}

{ TfrmDebug }

procedure TfrmDebug.log(sLine: String);
begin
  memOut.Lines.Add(sLine);
end;

end.
