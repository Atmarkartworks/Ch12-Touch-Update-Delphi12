(*******************************************************************************
*
* @Unit TTouches Up Down Event Emulation
*
* @Create: 2024-March-9
* @Autor: Atmarkartworks t.m
*
*******************************************************************************)
unit AAW.UpDownDetect;

interface

  function SumUpEmitterSlot : Byte;
  //
  // @define getter/setter
  //
  function DownSlot(Aidx : Integer) : Byte;
  procedure DownSlot0(Aidx : Integer);
  procedure DownSlot1(Aidx : Integer);

  function UpEmitterSlot(Aidx : Integer) : Byte;
  procedure UpEmitterSlot0(Aidx : Integer);
  procedure UpEmitterSlot1(Aidx : Integer);

  function UpSlot(Aidx : Integer) : Byte;
  procedure UpSlot0(Aidx : Integer);
  procedure UpSlot1(Aidx : Integer);

  function MoveSlot(Aidx : Integer) : Byte;
  procedure MoveSlot0(Aidx : Integer);
  procedure MoveSlot1(Aidx : Integer);

  //
  // @Initializer
  //
  procedure DownSlotInit;
  procedure UpEmitterSlotInit;
  procedure UpSlotInit;
  procedure MoveSlotInit;


var
  FDownSlot : TArray<Byte>;
  FUpEmitterSlot : TArray<Byte>;
  FUpSlot : TArray<Byte>;
  FMoveSlot : TArray<Byte>;

implementation

  function SumUpEmitterSlot : Byte;
  begin
    Result := FUpEmitterSlot[0] + FUpEmitterSlot[1] + FUpEmitterSlot[2] + FUpEmitterSlot[3] + FUpEmitterSlot[4] + FUpEmitterSlot[5] + FUpEmitterSlot[6] + FUpEmitterSlot[7] + FUpEmitterSlot[8] + FUpEmitterSlot[9];
  end;

  //
  // @define getter/setter
  //
  function DownSlot(Aidx : Integer) : Byte; begin Result := FDownSlot[Aidx]; end;
  procedure DownSlot0(Aidx : Integer); begin FDownSlot[Aidx] := 0; end;
  procedure DownSlot1(Aidx : Integer); begin FDownSlot[Aidx] := 1; end;

  function UpEmitterSlot(Aidx : Integer) : Byte; begin Result := FUpEmitterSlot[Aidx]; end;
  procedure UpEmitterSlot0(Aidx : Integer); begin FUpEmitterSlot[Aidx] := 0; end;
  procedure UpEmitterSlot1(Aidx : Integer); begin FUpEmitterSlot[Aidx] := 1; end;

  function UpSlot(Aidx : Integer) : Byte; begin Result := FUpSlot[Aidx]; end;
  procedure UpSlot0(Aidx : Integer); begin FUpSlot[Aidx] := 0; end;
  procedure UpSlot1(Aidx : Integer); begin FUpSlot[Aidx] := 1; end;

  function MoveSlot(Aidx : Integer) : Byte; begin Result := FMoveSlot[Aidx]; end;
  procedure MoveSlot0(Aidx : Integer); begin FMoveSlot[Aidx] := 0; end;
  procedure MoveSlot1(Aidx : Integer); begin FMoveSlot[Aidx] := 1; end;

  //
  // @Initializer
  //
  procedure DownSlotInit; begin FDownSlot := [0,0,0,0,0,0,0,0,0,0]; end;
  procedure UpEmitterSlotInit; begin FUpEmitterSlot :=  [0,0,0,0,0,0,0,0,0,0]; end;
  procedure UpSlotInit; begin FUpSlot :=  [1,1,1,1,1,1,1,1,1,1]; end;
  procedure MoveSlotInit; begin FMoveSlot :=  [0,0,0,0,0,0,0,0,0,0]; end;

end.
