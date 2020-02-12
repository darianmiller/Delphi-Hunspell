unit App.Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ActnList,
  Buttons, StdCtrls, ExtCtrls, Tabs, CCR.Hunspell, App.SettingsFrame, App.TestFrame;

type
  TfrmMain = class(TForm)
    dlgLocateDLL: TOpenDialog;
    TabSet: TTabSet;
    panHost: TPanel;
    ActionList1: TActionList;
    actPrevTab: TAction;
    actNextTab: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure TabSetChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure actPrevTabExecute(Sender: TObject);
    procedure actNextTabExecute(Sender: TObject);
  private
    FHunspell: THunspell;
    FLastActiveControls: array of TWinControl;
    FSettingsFrame: TSettingsFrame;
    FTestFrame: TTestFrame;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

const
  SQueryDLLLocation = 'Hunspell DLL not found. Locate it manually?';
  SInvalidDLL = '"%s" is not a valid Hunspell DLL.';

procedure TfrmMain.FormCreate(Sender: TObject);
var
  S: string;
begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := Caption;
  Constraints.MinHeight := Height;
  Constraints.MinWidth := Width;
  if not THunspell.IsLibraryInstalled and not THunspell.TryLoadLibrary('..\hunspell.dll') then
  begin
    Application.ShowMainForm := False;
    if MessageDlg(SQueryDLLLocation, mtWarning, mbOKCancel, 0) = mrOk then
      if dlgLocateDLL.Execute and THunspell.TryLoadLibrary(dlgLocateDLL.FileName) then
        Application.ShowMainForm := True
      else
        MessageDlg(Format(SInvalidDLL, [dlgLocateDLL.FileName]), mtError, [mbOK], 0);
    if not Application.ShowMainForm then
    begin
      Application.Terminate;
      Exit;
    end;
  end;
  FHunspell := THunspell.Create;
  FSettingsFrame := TSettingsFrame.Create(Self, FHunspell);
  TabSet.Tabs.Objects[0] := FSettingsFrame;
  FTestFrame := TTestFrame.Create(Self, FHunspell);
  TabSet.Tabs.Objects[1] := FTestFrame;
  SetLength(FLastActiveControls, TabSet.Tabs.Count);
  S := ExtractFilePath(Application.ExeName) + 'Dictionaries\en_GB.aff';
  if FileExists(S) then FSettingsFrame.LoadDictionary(S);  
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FHunspell.Free;
end;

procedure TfrmMain.TabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  FLastActiveControls[TabSet.TabIndex] := ActiveControl;
  (TabSet.Tabs.Objects[TabSet.TabIndex] as TControl).Hide;
  (TabSet.Tabs.Objects[NewTab] as TControl).Show;
  if FLastActiveControls[NewTab] <> nil then
    ActiveControl := FLastActiveControls[NewTab]
  else
    SelectFirst;
end;

procedure TfrmMain.actNextTabExecute(Sender: TObject);
begin
  TabSet.SelectNext(True)
end;

procedure TfrmMain.actPrevTabExecute(Sender: TObject);
begin
  TabSet.SelectNext(False)
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
