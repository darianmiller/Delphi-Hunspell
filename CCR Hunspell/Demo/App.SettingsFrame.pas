unit App.SettingsFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Buttons,
  StdCtrls, ExtCtrls, ComCtrls, CCR.Hunspell;

type
  TSettingsFrame = class(TFrame)
    GroupBox1: TGroupBox;
    edtHunspellDLL: TEdit;
    GroupBox2: TGroupBox;
    edtAffixFile: TLabeledEdit;
    btnChangeDictionary: TSpeedButton;
    edtCodePage: TLabeledEdit;
    edtDicFileSize: TLabeledEdit;
    GroupBox3: TGroupBox;
    btnRemoveCustomWord: TButton;
    btnAddCustomWord: TButton;
    dlgLoadDictionary: TOpenDialog;
    lsvCustomWords: TListView;
    procedure edtAffixFileKeyPress(Sender: TObject; var Key: Char);
    procedure btnChangeDictionaryClick(Sender: TObject);
    procedure btnAddCustomWordClick(Sender: TObject);
    procedure edtNewCustomWordEnter(Sender: TObject);
    procedure edtNewCustomWordExit(Sender: TObject);
    procedure btnRemoveCustomWordClick(Sender: TObject);
    procedure edtAffixFileDblClick(Sender: TObject);
    procedure lsvCustomWordsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FHunspell: THunspell;
  public
    constructor Create(Host: TWinControl; Hunspell: THunspell); reintroduce;
    procedure LoadDictionary(const FileName: string);
  end;

implementation

uses Math;

{$R *.dfm}

type
  TCPInfoEx = record
    MaxCharSize: UINT;
    DefaultChar: array[0..MAX_DEFAULTCHAR - 1] of Byte;
    LeadByte: array[0..MAX_LEADBYTES - 1] of Byte;
    UnicodeDefaultChar: WideChar;
    CodePage: UINT;
    CodePageName: array[0..MAX_PATH - 1] of WideChar;
  end;

function GetCPInfoEx(CodePage: UINT; dwFlags: DWORD; var lpCPInfoEx: TCPInfoEx): BOOL; stdcall;
  external kernel32 name 'GetCPInfoExW';

function GetCodePageDesc(CodePage: Word): string;
var
  Info: TCPInfoEx;
begin
  if GetCPInfoEx(CodePage, 0, Info) then
    Result := UnicodeString(Info.CodePageName)
  else
    Result := IntToStr(CodePage)
end;

constructor TSettingsFrame.Create(Host: TWinControl; Hunspell: THunspell);
begin
  inherited Create(Host);
  Align := alClient;
  Parent := Host;
  btnChangeDictionary.Height := edtAffixFile.Height;
  FHunspell := Hunspell;
  edtHunspellDLL.Text := Hunspell.LibraryName;
end;

procedure TSettingsFrame.LoadDictionary(const FileName: string);
var
  SavedCaption: string;
begin
  SavedCaption := Application.MainForm.Caption;
  Screen.Cursor := crHourGlass;
  try
    Application.MainForm.Caption := 'Loading dictionary...';
    with TFileStream.Create(ChangeFileExt(FileName, '.dic'), fmOpenRead) do
    try
      edtDicFileSize.Text := Format('%d KB', [Ceil(Size / 1024)]);
    finally
      Free;
    end;
    FHunspell.LoadDictionary(FileName);
    lsvCustomWords.Clear;
    edtAffixFile.Text := FileName;
    edtCodePage.Text := GetCodePageDesc(FHunspell.CodePage);
  finally
    Application.MainForm.Caption := SavedCaption;
    Screen.Cursor := crDefault;
    Caption := Application.Title;
  end;
  if not IsValidCodePage(FHunspell.CodePage) then //before Vista, not every valid-in-principle code page is installed by default
    MessageDlg('Dictionary code page is not supported by the system.', mtWarning, [mbOK], 0);
end;

procedure TSettingsFrame.lsvCustomWordsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    Key := 0;
    btnRemoveCustomWord.Click;
  end;
end;

procedure TSettingsFrame.edtAffixFileDblClick(Sender: TObject);
begin
  edtAffixFile.SelectAll;
  btnChangeDictionary.Click;
end;

procedure TSettingsFrame.edtAffixFileKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnChangeDictionary.Click;
  end;
end;

procedure TSettingsFrame.edtNewCustomWordEnter(Sender: TObject);
begin
  btnAddCustomWord.Default := True;
end;

procedure TSettingsFrame.edtNewCustomWordExit(Sender: TObject);
begin
  btnAddCustomWord.Default := False;
end;

procedure TSettingsFrame.btnAddCustomWordClick(Sender: TObject);
const
  SNewCustomWordPrompt = 'Word to add (put any affix model in brackets after it):';
  SWordAlreadyAdded = '%s already added!';
var
  Word, AffixModel: string;
  OpenBracketPos, CloseBracketPos: Integer;
begin
  if not InputQuery(Application.Title, SNewCustomWordPrompt, Word) then Exit;
  Word := Trim(Word);
  if Word = '' then Exit;
  OpenBracketPos := Pos('(', Word);
  CloseBracketPos := Pos(')', Word);
  if (OpenBracketPos <> 0) and (CloseBracketPos > OpenBracketPos) then
  begin
    AffixModel := Copy(Word, OpenBracketPos + 1, CloseBracketPos - OpenBracketPos - 1);
    Word := TrimRight(Copy(Word, 1, OpenBracketPos - 1));
  end;
  if lsvCustomWords.FindCaption(0, Word, False, True, True) <> nil then
  begin
    MessageDlg(Format(SWordAlreadyAdded, [Word]), mtError, [mbOK], 0);
    Exit;
  end;
  FHunspell.AddCustomWord(Word, AffixModel);
  with lsvCustomWords.Items.Add do
  begin
    Caption := Word;
    if AffixModel = '' then AffixModel := '<none>';
    SubItems.Add(AffixModel);
    Selected := True;
  end;
  btnRemoveCustomWord.Enabled := True;
end;

procedure TSettingsFrame.btnChangeDictionaryClick(Sender: TObject);
begin
  btnChangeDictionary.Update;
  if dlgLoadDictionary.Execute then
    LoadDictionary(dlgLoadDictionary.FileName);
end;

procedure TSettingsFrame.btnRemoveCustomWordClick(Sender: TObject);
var
  Item: TListItem;
begin
  Item := lsvCustomWords.Selected;
  if Item = nil then Exit;
  FHunspell.RemoveCustomWord(Item.Caption);
  Item.Delete;
  btnRemoveCustomWord.Enabled := (lsvCustomWords.Items.Count <> 0);
  if not btnRemoveCustomWord.Enabled then
    btnAddCustomWord.SetFocus
  else
  begin
    Item := lsvCustomWords.Items[0];
    Item.Selected := True;
    Item.Focused := True;
  end;
end;

end.
