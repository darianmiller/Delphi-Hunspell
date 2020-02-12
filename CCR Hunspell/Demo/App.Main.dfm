object frmMain: TfrmMain
  Left = 246
  Top = 92
  Caption = 'Hunspell Test'
  ClientHeight = 356
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TabSet: TTabSet
    Left = 0
    Top = 335
    Width = 267
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    SoftTop = True
    Style = tsSoftTabs
    Tabs.Strings = (
      '  &Settings'
      '  &Test')
    TabIndex = 0
    OnChange = TabSetChange
  end
  object panHost: TPanel
    Left = 0
    Top = 0
    Width = 267
    Height = 335
    Align = alClient
    BevelEdges = [beLeft, beTop, beRight]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
  end
  object dlgLocateDLL: TOpenDialog
    DefaultExt = 'dll'
    FileName = 'hunspell.dll'
    Filter = 'Dynamic Link Libraries (*.dll)|*.dll|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Locate Hunspell DLL'
    Left = 12
    Top = 300
  end
  object ActionList1: TActionList
    Left = 56
    Top = 300
    object actPrevTab: TAction
      Caption = 'actPrevTab'
      ShortCut = 24585
      OnExecute = actPrevTabExecute
    end
    object actNextTab: TAction
      Caption = 'actNextTab'
      ShortCut = 16393
      OnExecute = actNextTabExecute
    end
  end
end
