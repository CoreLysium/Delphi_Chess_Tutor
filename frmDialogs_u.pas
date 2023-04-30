unit frmDialogs_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, pngimage, ComCtrls;

type
  TfrmDialogs = class(TForm)
    pnlChallenge: TPanel;
    btnChallenge: TButton;
    btnCancel: TButton;
    cbxRated: TCheckBox;
    sedMinutes: TSpinEdit;
    sedSeconds: TSpinEdit;
    sedIncrement: TSpinEdit;
    lblIncrement: TLabel;
    lblTimeControl: TLabel;
    lblChallenge: TLabel;
    imgPfp: TImage;
    lblUsername: TLabel;
    lblTimeColon: TLabel;
    lblRating: TLabel;
    cmbColour: TComboBox;
    lblColour: TLabel;
    pnlPromote: TPanel;
    imgQueen: TImage;
    imgRook: TImage;
    imgKnight: TImage;
    imgBishop: TImage;
    lblPromote: TLabel;
    pnlLesson: TPanel;
    lblLesson: TLabel;
    lblLessonName: TLabel;
    lblLessonLevel: TLabel;
    lblLessonDescription: TLabel;
    lblLessonDescriptionText: TLabel;
    btnLessonCancel: TButton;
    btnConfirm: TButton;
    pnlCreateLesson: TPanel;
    lblCreateLesson: TLabel;
    lblCreateLessonName: TLabel;
    lblCreateLessonLevel: TLabel;
    lblCreateLessonDescription: TLabel;
    btnCancelCreateLesson: TButton;
    btnCreateLesson: TButton;
    edtLessonName: TEdit;
    sedLessonLevel: TSpinEdit;
    redLessonDescription: TRichEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnChallengeClick(Sender: TObject);
    procedure imgQueenClick(Sender: TObject);
    procedure imgRookClick(Sender: TObject);
    procedure imgKnightClick(Sender: TObject);
    procedure imgBishopClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnCreateLessonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cPromote: Char;
    procedure Challenge;
    procedure Promote;
    procedure Lesson;
    procedure Create_Lesson;
  end;

var
  frmDialogs: TfrmDialogs;

implementation

uses
  frmMain_u;

{$R *.dfm}

procedure TfrmDialogs.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmDialogs.btnChallengeClick(Sender: TObject);
begin
  if cmbColour.ItemIndex > -1 then
    begin
      ModalResult := mrOK;
      CloseModal;
    end
  else
    MessageDlg('Please select a colour.',mtWarning,[mbOK],0);
end;

procedure TfrmDialogs.btnConfirmClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmDialogs.btnCreateLessonClick(Sender: TObject);
begin
  if edtLessonName.Text <> '' then
    ModalResult := mrOK
  else
    MessageDlg('Please Give Lesson a Name.',mtWarning,[mbOK],0);
end;

procedure TfrmDialogs.Challenge;
begin
  pnlChallenge.Show;
  pnlPromote.Hide;
  pnlLesson.Hide;
  pnlCreateLesson.Hide;
end;

procedure TfrmDialogs.Create_Lesson;
begin
  pnlChallenge.Hide;
  pnlPromote.Hide;
  pnlLesson.Hide;
  pnlCreateLesson.Show;
end;

procedure TfrmDialogs.imgBishopClick(Sender: TObject);
begin
  cPromote := 'b';
  ModalResult := mrOK;
end;

procedure TfrmDialogs.imgKnightClick(Sender: TObject);
begin
  cPromote := 'n';
  ModalResult := mrOK;
end;

procedure TfrmDialogs.imgQueenClick(Sender: TObject);
begin
  cPromote := 'q';
  ModalResult := mrOK;
end;

procedure TfrmDialogs.imgRookClick(Sender: TObject);
begin
  cPromote := 'r';
  ModalResult := mrOK;
end;

procedure TfrmDialogs.Lesson;
begin
  pnlPromote.Hide;
  pnlChallenge.Hide;
  pnlLesson.Show;
  pnlCreateLesson.Hide;
end;

procedure TfrmDialogs.Promote;
begin
  pnlPromote.Show;
  pnlChallenge.Hide;
  pnlLesson.Hide;
  pnlCreateLesson.Hide;
  imgQueen.Canvas.Brush.Color := clMoneyGreen;
  imgQueen.Canvas.FillRect(Rect(0,0,84,84));

  imgQueen.Canvas.Pen.Color := clBlack;
  imgQueen.Canvas.Pen.Width := 6;
  imgQueen.Canvas.Polyline([Point(0,0),Point(0,84),Point(84,84),Point(84,0),Point(0,0)]);;

  imgQueen.Canvas.StretchDraw(Rect(0,0,84,84),frmMain.objBoard.getPieceImage(5).Graphic);

  imgRook.Canvas.Brush.Color := clGreen;
  imgRook.Canvas.FillRect(Rect(0,0,84,84));

  imgRook.Canvas.Pen.Color := clBlack;
  imgRook.Canvas.Pen.Width := 6;
  imgRook.Canvas.Polyline([Point(0,0),Point(0,84),Point(84,84),Point(84,0),Point(0,0)]);;

  imgRook.Canvas.StretchDraw(Rect(0,0,84,84),frmMain.objBoard.getPieceImage(2).Graphic);

  imgBishop.Canvas.Brush.Color := clMoneyGreen;
  imgBishop.Canvas.FillRect(Rect(0,0,84,84));

  imgBishop.Canvas.Pen.Color := clBlack;
  imgBishop.Canvas.Pen.Width := 6;
  imgBishop.Canvas.Polyline([Point(0,0),Point(0,84),Point(84,84),Point(84,0),Point(0,0)]);;

  imgBishop.Canvas.StretchDraw(Rect(0,0,84,84),frmMain.objBoard.getPieceImage(4).Graphic);

  imgKnight.Canvas.Brush.Color := clGreen;
  imgKnight.Canvas.FillRect(Rect(0,0,84,84));

  imgKnight.Canvas.Pen.Color := clBlack;
  imgKnight.Canvas.Pen.Width := 6;
  imgKnight.Canvas.Polyline([Point(0,0),Point(0,84),Point(84,84),Point(84,0),Point(0,0)]);;

  imgKnight.Canvas.StretchDraw(Rect(0,0,84,84),frmMain.objBoard.getPieceImage(3).Graphic);
end;

end.
