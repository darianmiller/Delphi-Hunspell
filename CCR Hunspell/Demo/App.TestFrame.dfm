object TestFrame: TTestFrame
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 259
  Height = 237
  TabOrder = 0
  Visible = False
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 253
    Height = 49
    Align = alTop
    Caption = ' &Word to Find '
    TabOrder = 0
    object edtInput: TMemo
      AlignWithMargins = True
      Left = 8
      Top = 22
      Width = 237
      Height = 21
      Margins.Left = 6
      Margins.Top = 4
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      TabOrder = 0
      WantReturns = False
      WordWrap = False
      OnEnter = edtInputEnter
      OnExit = edtInputExit
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 253
    Height = 55
    Align = alTop
    Caption = ' Actions '
    TabOrder = 1
    DesignSize = (
      253
      55)
    object btnSpellCheck: TButton
      Left = 8
      Top = 18
      Width = 75
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Spell &Check'
      TabOrder = 0
      OnClick = btnSpellCheckClick
    end
    object btnAnalyze: TButton
      Left = 89
      Top = 18
      Width = 75
      Height = 29
      Anchors = [akTop, akRight]
      Caption = '&Analyse'
      TabOrder = 1
      OnClick = btnAnalyzeClick
    end
    object btnStem: TButton
      Left = 170
      Top = 18
      Width = 75
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Ste&m'
      TabOrder = 2
      OnClick = btnStemClick
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 119
    Width = 253
    Height = 115
    Align = alClient
    Caption = 'Output'
    TabOrder = 2
    ExplicitTop = 117
    ExplicitHeight = 117
    object memOutput: TMemo
      AlignWithMargins = True
      Left = 8
      Top = 22
      Width = 237
      Height = 85
      Margins.Left = 6
      Margins.Top = 4
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      WantReturns = False
      ExplicitHeight = 87
    end
  end
end
