object SettingsFrame: TSettingsFrame
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 260
  Height = 353
  TabOrder = 0
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 254
    Height = 49
    Align = alTop
    Caption = ' Hunspell DLL '
    TabOrder = 0
    DesignSize = (
      254
      49)
    object edtHunspellDLL: TEdit
      Left = 8
      Top = 20
      Width = 237
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      Text = 'edtHunspellDLL'
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 58
    Width = 254
    Height = 115
    Align = alTop
    Caption = ' Main Dictionary '
    TabOrder = 1
    DesignSize = (
      254
      115)
    object btnChangeDictionary: TSpeedButton
      Left = 221
      Top = 36
      Width = 25
      Height = 24
      Anchors = [akTop, akRight]
      Caption = '...'
      OnClick = btnChangeDictionaryClick
    end
    object edtAffixFile: TLabeledEdit
      Left = 8
      Top = 36
      Width = 209
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 30
      EditLabel.Height = 16
      EditLabel.Caption = '&Path:'
      ReadOnly = True
      TabOrder = 0
      Text = '<no dictionary loaded>'
      OnDblClick = edtAffixFileDblClick
      OnKeyPress = edtAffixFileKeyPress
    end
    object edtCodePage: TLabeledEdit
      Left = 8
      Top = 83
      Width = 157
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 66
      EditLabel.Height = 16
      EditLabel.Caption = '&Code page:'
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
    end
    object edtDicFileSize: TLabeledEdit
      Left = 171
      Top = 83
      Width = 75
      Height = 24
      Anchors = [akTop, akRight]
      EditLabel.Width = 72
      EditLabel.Height = 16
      EditLabel.Caption = '&DIC file size:'
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 179
    Width = 254
    Height = 171
    Align = alClient
    Caption = ' C&ustom Words'
    TabOrder = 2
    ExplicitTop = 168
    ExplicitHeight = 161
    DesignSize = (
      254
      171)
    object btnRemoveCustomWord: TButton
      Left = 8
      Top = 134
      Width = 85
      Height = 29
      Anchors = [akLeft, akBottom]
      Caption = '&Remove'
      Enabled = False
      TabOrder = 1
      OnClick = btnRemoveCustomWordClick
      ExplicitTop = 142
    end
    object btnAddCustomWord: TButton
      Left = 160
      Top = 134
      Width = 85
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = '&Add New...'
      TabOrder = 2
      OnClick = btnAddCustomWordClick
      ExplicitTop = 142
    end
    object lsvCustomWords: TListView
      AlignWithMargins = True
      Left = 8
      Top = 19
      Width = 237
      Height = 109
      Margins.Left = 6
      Margins.Top = 4
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Word'
          Width = 115
        end
        item
          Caption = 'Affix Model'
          Width = 115
        end>
      ColumnClick = False
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnKeyDown = lsvCustomWordsKeyDown
    end
  end
  object dlgLoadDictionary: TOpenDialog
    DefaultExt = 'aff'
    Filter = 'Hunspell affix files (*.aff)|*.aff'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Load Hunspell Dictionary'
    Left = 152
    Top = 24
  end
end
