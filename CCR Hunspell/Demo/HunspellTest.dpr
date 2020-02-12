program HunspellTest;

uses
  Forms,
  CCR.Hunspell in '..\CCR.Hunspell.pas',
  App.Main in 'App.Main.pas' {frmMain},
  App.SettingsFrame in 'App.SettingsFrame.pas' {SettingsFrame: TFrame},
  App.TestFrame in 'App.TestFrame.pas' {TestFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  {$IF CompilerVersion >= 18.5}
  Application.MainFormOnTaskbar := True;
  {$IFEND}
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
