unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DateUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    PanelTime: TPanel;
    StaticTextWeekday: TStaticText;
    StaticTextArea: TStaticText;
    StaticTextTime: TStaticText;
    StaticTextAMPM: TStaticText;
    StaticTextMonthDayYear: TStaticText;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function GetAreaOfTime(Hour: Integer): String;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
var
  TimeStr: String;
begin
  StaticTextWeekday.Caption:=FormatDateTime('dddd', now).ToUpper();
  StaticTextArea.Caption:=GetAreaOfTime(HourOf(now));
  TimeStr:=FormatDateTime('h:nn a/p', now);
  StaticTextTime.Caption:=TimeStr.Substring(0, TimeStr.Length - 2);
  StaticTextAMPM.Caption:=FormatDateTime('am/pm', now).ToUpper();
  StaticTextMonthDayYear.Caption:=FormatDateTime('mmmm d, yyyy', now).ToUpper();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Timer1Timer(Sender);
end;

function TForm1.GetAreaOfTime(Hour: Integer): String;
begin
  case Hour of
    5..11:
      result:='MORNING';
    12..16:
      result:='AFTERNOON';
    17..20:
      result:='EVENING';
    else
      result:='NIGHT';
  end;
end;

end.

