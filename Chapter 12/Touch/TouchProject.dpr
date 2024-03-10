program TouchProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'src\Forms.Main.pas' {MainForm},
  AAW.UpDownDetect in 'Atmarkartworks\TouchSensor\AAW.UpDownDetect.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
