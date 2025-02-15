unit UnitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  IniPropStorage, DateUtils;

type

  { TFormMain }

  TFormMain = class(TForm)
    PropStorage: TIniPropStorage;
    PanelTime: TPanel;
    StaticTextWeekday: TStaticText;
    StaticTextArea: TStaticText;
    StaticTextTime: TStaticText;
    StaticTextAMPM: TStaticText;
    StaticTextMonthDayYear: TStaticText;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StaticTextTimeDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    IsTick: boolean;
    function GetAreaOfTime(Hour: Integer): String;
  public

  end;

const
  kSmallMultiplier = 20;
  kMedMultiplier = 15;
  kLargeMultiplier = 10;
  kHugeMultiplier = 5;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.Timer1Timer(Sender: TObject);
var
  TimeStr: String;
begin
  StaticTextWeekday.Caption:=FormatDateTime('dddd', now).ToUpper();
  StaticTextArea.Caption:=GetAreaOfTime(HourOf(now));
  TimeStr:=FormatDateTime('h:nn a/p', now);
  if IsTick then
  begin
    TimeStr:=TimeStr.Replace(':',' ');
  end;
  StaticTextTime.Caption:=TimeStr.Substring(0, TimeStr.Length - 2);
  StaticTextAMPM.Caption:=FormatDateTime('am/pm', now).ToUpper();
  StaticTextMonthDayYear.Caption:=FormatDateTime('mmmm d, yyyy', now).ToUpper();
  IsTick:=not IsTick;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Timer1Timer(Sender);
end;

procedure TFormMain.FormResize(Sender: TObject);
var
  NewSize, NewTimeSize: Integer;
begin
  NewSize:=Round(Self.Width / kLargeMultiplier);
  StaticTextWeekday.Font.Size:=NewSize;
  StaticTextArea.Font.Size:=Round(NewSize / 2);
  NewTimeSize:=Round(Self.Width / kHugeMultiplier);
  StaticTextTime.Font.Size:=NewTimeSize;
  StaticTextAMPM.Font.Size:=Round(NewTimeSize * 0.333333);
  StaticTextMonthDayYear.Font.Size:=Round(Self.Width / kMedMultiplier);
end;

procedure TFormMain.StaticTextTimeDblClick(Sender: TObject);
begin
  ShowMessage('Hello');
end;

function TFormMain.GetAreaOfTime(Hour: Integer): String;
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

