unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types ,FMX.Platform.UI.Android,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Gestures,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;
type
  TMainForm = class(TForm)
    Circle1: TCircle;
    Circle2: TCircle;
    Circle3: TCircle;
    Circle4: TCircle;
    Circle5: TCircle;
    Circle6: TCircle;
    Circle7: TCircle;
    Circle8: TCircle;
    Circle9: TCircle;
    Circle10: TCircle;
    ActionLabel: TLabel;
    DownCounterLabel: TLabel;
    GestureManager1: TGestureManager;
    procedure FormTouch(Sender: TObject; const Touches: TTouches;
      const Action: TTouchAction);
    procedure FormCreate(Sender: TObject);
  private
    FCircles: TArray<TCircle>;
    FCirclesSP: TArray<TPointF>;
    FDownCounter: Integer;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses System.Rtti;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FCircles := [
    Circle1, Circle2, Circle3, Circle4, Circle5
  , Circle6, Circle7, Circle8, Circle9, Circle10
  ];

  FCirclesSP := [
    Circle1.Position.Point,
    Circle2.Position.Point,
    Circle3.Position.Point,
    Circle4.Position.Point,
    Circle5.Position.Point,
    Circle6.Position.Point,
    Circle7.Position.Point,
    Circle8.Position.Point,
    Circle9.Position.Point,
    Circle10.Position.Point
   ];

  FDownCounter := 0;
end;

procedure TMainForm.FormTouch(Sender: TObject; const Touches: TTouches;
  const Action: TTouchAction);
var
  LIndex: Integer;
  LTouchLocation: TPointF;
  LCircle: TCircle;

begin
  if Length(Touches) > 10 then
    Exit;


  ActionLabel.Text := TRttiEnumerationType.GetName<TTouchAction>(Action);



  for var cnt := 0 to Length(Touches)-1 do begin
    var TouchId := Touches[cnt].Id;
    var Action1 := Touches[cnt].Action;

    case Action1 of
      TTouchAction.None: ;

      TTouchAction.Up: FCircles[TouchId].Position.Point := FCirclesSP[TouchId];

      TTouchAction.Down: ;

      TTouchAction.Move:
        begin
          LCircle := FCircles[TouchId];
          LTouchLocation := Touches[cnt].Location;

          LTouchLocation.Offset(-LCircle.Width / 2, -LCircle.Height / 2);
          LCircle.Position.Point := LTouchLocation;
        end;
      TTouchAction.Cancel: FDownCounter := 0;

    end;
  end;


  case Action of
    TTouchAction.None: ;
    TTouchAction.Up: Dec(FDownCounter);
    TTouchAction.Down: Inc(FDownCounter);
    TTouchAction.Move: ;
    TTouchAction.Cancel: FDownCounter := 0;

  end;

  DownCounterLabel.Text := 'Down: ' + FDownCounter.ToString;

end;

end.

