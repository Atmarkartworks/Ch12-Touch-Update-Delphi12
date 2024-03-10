unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types ,FMX.Platform.UI.Android,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Gestures,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, AAW.UpDownDetect;
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


  DownSlotInit;
  UpEmitterSlotInit;
  UpSlotInit;
  MoveSlotInit;
end;

procedure TMainForm.FormTouch(Sender: TObject; const Touches: TTouches; const Action: TTouchAction);
var
  LIndex: Integer;
  LTouchLocation: TPointF;
  LCircle: TCircle;

begin
  if Length(Touches) > 10 then
    Exit;

  MoveSlotInit;

  ActionLabel.Text := TRttiEnumerationType.GetName<TTouchAction>(Action);


  for var cnt := 0 to Length(Touches)-1 do begin
    var TouchId := Touches[cnt].Id;
    var Action1 := Touches[cnt].Action;

  //
  // > adb logcat -c
  // > adb logcat -s info
  //
  Log.d('########## cnt : %d Id : %d Action : %s ###########',[cnt, TouchId, TRttiEnumerationType.GetName<TTouchAction>(Action1)]);



    case Action1 of
      TTouchAction.None: ;

      TTouchAction.Up: UpEmitterSlot1(TouchId);

      TTouchAction.Down: DownSlot1(TouchId);

      TTouchAction.Move:
        begin
          LCircle := FCircles[TouchId];
          LTouchLocation := Touches[cnt].Location;

          LTouchLocation.Offset(-LCircle.Width / 2, -LCircle.Height / 2);
          LCircle.Position.Point := LTouchLocation;

          MoveSlot1(TouchId);
        end;
      TTouchAction.Cancel:

        begin
          FDownCounter := 0;
          FCircles[TouchId].Position.Point := FCirclesSP[TouchId];
        end;

    end;
  end;

  case Action of
    TTouchAction.None: ;
    TTouchAction.Up:
      begin

        //if SumUpEmitterSlot = 1 then begin
        //  var id := Touches[0].Id;
        //  FCircles[id].Position.Point := FCirclesSP[id];
        //end;

        Dec(FDownCounter);

        if FDownCounter = 0 then begin
          //for var cnt := 0 to Length(Touches)-1 do begin
          //  var TouchId := Touches[cnt].Id;
          //  FCircles[TouchId].Position.Point := FCirclesSP[TouchId];
          //end;

          for var finger1 := 0 to 10 - 1 do begin
            var eval1 := UpEmitterSlot(finger1);
            if eval1 = 1 then begin
              UpEmitterSlot0(finger1);
              DownSlot0(finger1);
              FCircles[finger1].Position.Point := FCirclesSP[finger1];
            end;
          end;
        end;
      end;
    TTouchAction.Down: Inc(FDownCounter);
    TTouchAction.Move:
      begin

        if SumUpEmitterSlot > 1 then begin

          for var finger := 0 to 10 - 1 do begin
            var eval := 10 * UpEmitterSlot(finger) + MoveSlot(finger);
            if eval = 11 then
              UpEmitterSlot0(finger)
            else if eval = 10 then begin
              UpEmitterSlot0(finger);
              DownSlot0(finger);
              FCircles[finger].Position.Point := FCirclesSP[finger];
            end;
          end;
        end;
      end;
    TTouchAction.Cancel: FDownCounter := 0;
  end;


  DownCounterLabel.Text := 'Down: ' + FDownCounter.ToString;
end;

end.
