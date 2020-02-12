unit App.TestFrame;

interface

{$IFNDEF UNICODE}
  {.$DEFINE HackUnicodeInput} //remove the dot to allow unicode input in D2006 and D2007
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  CCR.Hunspell;

type
{$IFDEF HackUnicodeInput}
  TLinesHack = record
    Memo: TMemo;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Add(const S: WideString);
    procedure Clear;
    function Count: Integer;
  end;

  TMemo = class(StdCtrls.TMemo)
  private
    FLines: TLinesHack;
    function GetText: WideString;
    procedure SetText(const Value: WideString);
  protected
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Lines: TLinesHack read FLines;
    property Text: WideString read GetText write SetText;
  end;
{$ENDIF}

  TTestFrame = class(TFrame)
    GroupBox1: TGroupBox;
    edtInput: TMemo;
    GroupBox2: TGroupBox;
    btnSpellCheck: TButton;
    btnAnalyze: TButton;
    btnStem: TButton;
    GroupBox3: TGroupBox;
    memOutput: TMemo;
    procedure edtInputEnter(Sender: TObject);
    procedure edtInputExit(Sender: TObject);
    procedure btnSpellCheckClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnStemClick(Sender: TObject);
  private
    FHunspell: THunspell;
  public
    constructor Create(Host: TWinControl; Hunspell: THunspell); reintroduce;
  end;

implementation

uses Consts;

{$R *.dfm}

{$IFDEF HackUnicodeInput}
procedure TLinesHack.BeginUpdate;
begin
  Memo.Lines.BeginUpdate;
end;

procedure TLinesHack.EndUpdate;
begin
  Memo.Lines.EndUpdate;
end;

procedure TLinesHack.Add(const S: WideString);
begin
  TMemo(Memo).Text := TMemo(Memo).Text + S + #13#10;
end;

procedure TLinesHack.Clear;
begin
  Memo.Lines.Clear;
end;

function TLinesHack.Count: Integer;
begin
  Result := Memo.Lines.Count;
end;

constructor TMemo.Create(AOwner: TComponent);
begin
  inherited;
  FLines.Memo := Self;
end;

procedure TMemo.CreateWnd;
var
  Params: TCreateParams;
  ClassRegistered: Boolean;
  WideWinClassName: WideString;
  WideWindowClass: TWndClassW;
begin
  CreateParams(Params);
  with Params do
  begin
    if (WndParent = 0) and (Style and WS_CHILD <> 0) then
      if (Owner <> nil) and (csReading in Owner.ComponentState) and
        (Owner is TWinControl) then
        WndParent := TWinControl(Owner).Handle
      else
        raise EInvalidOperation.CreateFmt(SParentRequired, [Name]);
    DefWndProc := WindowClass.lpfnWndProc;
    WideWinClassName := WideString(string(WinClassName));
    ClassRegistered := GetClassInfoW(WindowClass.hInstance, PWideChar(WideWinClassName),
      WideWindowClass);
    if not ClassRegistered or (WideWindowClass.lpfnWndProc <> @InitWndProc) then
    begin
      if ClassRegistered then Windows.UnregisterClass(WinClassName,
        WindowClass.hInstance);
      Move(WindowClass, WideWindowClass, SizeOf(WindowClass));
      WideWindowClass.lpfnWndProc := @InitWndProc;
      WideWindowClass.lpszClassName := PWideChar(WideWinClassName);
      WideWindowClass.lpszMenuName := nil;
      if Windows.RegisterClassW(WideWindowClass) = 0 then RaiseLastOSError;
    end;
    CreationControl := Self;
    CreateWindowHandle(Params);
    if WindowHandle = 0 then
      RaiseLastOSError;
    if (GetWindowLong(WindowHandle, GWL_STYLE) and WS_CHILD <> 0) and
      (GetWindowLong(WindowHandle, GWL_ID) = 0) then
      SetWindowLong(WindowHandle, GWL_ID, WindowHandle);
  end;
  UpdateBounds;
  Perform(WM_SETFONT, Font.Handle, 1);
  if AutoSize then AdjustSize;
end;

function TMemo.GetText: WideString;
var              
  Len: Integer;
begin
  Len := CallWindowProc(DefWndProc, Handle, WM_GETTEXTLENGTH, 0, 0);
  SetLength(Result, Len);
  CallWindowProcW(DefWndProc, Handle, WM_GETTEXT, Len + 1, LPARAM(PWideChar(Result)));
end;

procedure TMemo.SetText(const Value: WideString);
begin
  CallWindowProcW(DefWndProc, Handle, WM_SETTEXT, 0, LPARAM(PWideChar(Value)));
end;
{$ENDIF}

constructor TTestFrame.Create(Host: TWinControl; Hunspell: THunspell);
begin
  inherited Create(Host);
  Align := alClient;
  Parent := Host;
  FHunspell := Hunspell;
  edtInput.Text := 'tessting';
end;

procedure TTestFrame.edtInputEnter(Sender: TObject);
begin
  btnSpellCheck.Default := True;
  edtInput.SelectAll;
end;

procedure TTestFrame.edtInputExit(Sender: TObject);
begin
  btnSpellCheck.Default := False;
end;

procedure TTestFrame.btnSpellCheckClick(Sender: TObject);
var
  {$IFDEF HackUnicodeInput}
  S: UnicodeString;
  {$ELSE}
  S: string;
  {$ENDIF}
begin
  if FHunspell.IsSpeltCorrectly(edtInput.Text) then
    memOutput.Text := 'Correctly spelt'
  else
  begin
    memOutput.Lines.BeginUpdate;
    try
      memOutput.Lines.Clear;
      for S in FHunspell.GetSuggestions(edtInput.Text) do
        memOutput.Lines.Add(S);
      if memOutput.Lines.Count = 0 then memOutput.Text := '(no suggestions)';
    finally
      memOutput.Lines.EndUpdate;
    end;
  end;
end;

procedure TTestFrame.btnAnalyzeClick(Sender: TObject);
var
  S: UnicodeString;
begin
  memOutput.Lines.BeginUpdate;
  try
    memOutput.Lines.Clear;
    for S in FHunspell.Analyze(edtInput.Text) do
      memOutput.Lines.Add(S);
    if memOutput.Lines.Count = 0 then memOutput.Text := '(not in dictionary)';
  finally
    memOutput.Lines.EndUpdate;
  end;
end;

procedure TTestFrame.btnStemClick(Sender: TObject);
var
  S: UnicodeString;
begin
  memOutput.Lines.BeginUpdate;
  try
    memOutput.Lines.Clear;
    for S in FHunspell.Stem(edtInput.Text) do
      memOutput.Lines.Add(S);
    if memOutput.Lines.Count = 0 then memOutput.Text := '(not in dictionary)';
  finally
    memOutput.Lines.EndUpdate;
  end;
end;

end.
