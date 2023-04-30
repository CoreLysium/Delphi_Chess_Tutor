unit frmGames_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, dmChess_u, ExtCtrls, ComCtrls;

type
  TfrmGames = class(TForm)
    lblGames: TLabel;
    btnSelect: TButton;
    dbgGames: TDBGrid;
    lblFilterBy: TLabel;
    cmbFilterBy: TComboBox;
    ledPlayerFilter: TLabeledEdit;
    cbxRatedFilter: TCheckBox;
    dtpDateFilter: TDateTimePicker;
    lblDateFilter: TLabel;
    btnToggleFilter: TButton;
    lblSortBy: TLabel;
    cmbSortBy: TComboBox;
    procedure btnSelectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbFilterByChange(Sender: TObject);
    procedure btnToggleFilterClick(Sender: TObject);
    procedure cbxRatedFilterClick(Sender: TObject);
    procedure dtpDateFilterChange(Sender: TObject);
    procedure ledPlayerFilterChange(Sender: TObject);
    procedure cmbSortByChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iGameID: Integer;
  end;

var
  frmGames: TfrmGames;

implementation

{$R *.dfm}

procedure TfrmGames.btnSelectClick(Sender: TObject);
begin
  iGameID := dmChess.tblGames['GameID'];
  ModalResult := mrOK;
end;
procedure TfrmGames.btnToggleFilterClick(Sender: TObject);
begin
  dmChess.tblGames.Filtered := not dmChess.tblGames.Filtered;
end;

procedure TfrmGames.cbxRatedFilterClick(Sender: TObject);
begin
  dmChess.tblGames.Filter := 'Rated = ' + BoolToStr(cbxRatedFilter.Checked,True);
end;

procedure TfrmGames.cmbFilterByChange(Sender: TObject);
begin
  case cmbFilterBy.ItemIndex of
    0:
      begin
        ledPlayerFilter.Show;
        dtpDateFilter.Hide;
        lblDateFilter.Hide;
        cbxRatedFilter.Hide;
      end;
    1:
      begin
        ledPlayerFilter.Hide;
        dtpDateFilter.Hide;
        lblDateFilter.Hide;
        cbxRatedFilter.Show;
      end;
    2:
      begin
        ledPlayerFilter.Hide;
        dtpDateFilter.Show;
        lblDateFilter.Show;
        cbxRatedFilter.Show;
      end;
  end;
end;

procedure TfrmGames.cmbSortByChange(Sender: TObject);
begin
  case cmbSortBy.ItemIndex of
    0: dmChess.tblGames.Sort := 'White ASC';
    1: dmChess.tblGames.Sort := 'Black ASC';
    2: dmChess.tblGames.Sort := 'Rated ASC';
    3: dmChess.tblGames.Sort := 'DateTimePlayed ASC';
  end;
end;

procedure TfrmGames.dtpDateFilterChange(Sender: TObject);
begin
  dmChess.tblGames.Filter := 'CONVERT(DATE,DateTimePlayed) = ' + DateToStr(dtpDateFilter.Date);
end;

procedure TfrmGames.FormShow(Sender: TObject);
begin
  dbgGames.DataSource := dmChess.dsrGames;
end;

procedure TfrmGames.ledPlayerFilterChange(Sender: TObject);
begin
  dmChess.tblGames.Filter := '(White = ' + QuotedStr(ledPlayerFilter.Text) + ') OR (Black = ' + QuotedStr(ledPlayerFilter.Text) + ')';
end;

end.
