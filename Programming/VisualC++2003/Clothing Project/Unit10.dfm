object anbarReportForm: TanbarReportForm
  Left = 194
  Top = 115
  BorderStyle = bsNone
  Caption = 'Report'
  ClientHeight = 566
  ClientWidth = 792
  Color = 13871359
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 777
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = '(( Anbar Report ))'
    Color = 16744576
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object dayLabel: TLabel
    Left = 16
    Top = 192
    Width = 185
    Height = 33
    AutoSize = False
    Caption = 'Select Day :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object monthLabel: TLabel
    Left = 16
    Top = 192
    Width = 185
    Height = 33
    AutoSize = False
    Caption = 'Insert Month:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object yearLabel: TLabel
    Left = 16
    Top = 192
    Width = 185
    Height = 33
    AutoSize = False
    Caption = 'Insert Year:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
  end
  object label2: TLabel
    Left = 16
    Top = 320
    Width = 153
    Height = 25
    AutoSize = False
    Caption = 'Input Count of Selected Cloth:'
    Layout = tlCenter
    Visible = False
  end
  object Label3: TLabel
    Left = 16
    Top = 320
    Width = 161
    Height = 25
    AutoSize = False
    Caption = 'Invalid Code'
    Layout = tlCenter
    Visible = False
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 344
    Width = 185
    Height = 201
    TabOrder = 27
  end
  object backBtn: TButton
    Left = 712
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 0
    OnClick = backBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 216
    Top = 48
    Width = 195
    Height = 497
    Caption = 'Cloth Information'
    TabOrder = 1
  end
  object seasonRadio: TRadioGroup
    Left = 240
    Top = 72
    Width = 83
    Height = 73
    Caption = 'Season'
    Items.Strings = (
      'Summer'
      'Winter')
    TabOrder = 2
    OnClick = seasonRadioClick
  end
  object casualRadio: TRadioGroup
    Left = 240
    Top = 160
    Width = 99
    Height = 105
    Caption = 'Casuality'
    Items.Strings = (
      'Man'
      'Child'
      'Woman')
    TabOrder = 3
    OnClick = casualRadioClick
  end
  object colorCombo: TComboBox
    Left = 240
    Top = 280
    Width = 115
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = 'Select Color'
    OnSelect = colorComboSelect
    Items.Strings = (
      'Red'
      'Blue'
      'White'
      'Black'
      'Green'
      'Yellow'
      'Purple'
      'Cream'
      'Gray')
  end
  object colorEdit: TEdit
    Left = 368
    Top = 280
    Width = 19
    Height = 21
    TabOrder = 5
  end
  object kindCombo: TComboBox
    Left = 240
    Top = 312
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = 'Select Kind'
    Items.Strings = (
      'Silk'
      'Panbeh'
      'Cotton'
      'Nakh'
      'Makhmal'
      'Pashm'
      'Leather')
  end
  object sizeCombo: TComboBox
    Left = 240
    Top = 344
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Text = 'Select Size'
    Items.Strings = (
      'Small'
      'Medium'
      'Large'
      'Xlarge'
      'XXlarge'
      'XXXlarge')
  end
  object coolwarmCombo: TComboBox
    Left = 240
    Top = 376
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 8
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object lengthCombo: TComboBox
    Left = 240
    Top = 408
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 9
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object itemCombo00: TComboBox
    Left = 240
    Top = 440
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 10
    Text = 'Select Item'
    Visible = False
    Items.Strings = (
      'Shalvar'
      'Shalvarak'
      'Pirahan'
      'Tshirt'
      'Kolah'
      'Kot')
  end
  object tripCombo: TComboBox
    Left = 240
    Top = 472
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 11
    Text = 'Select Trip'
    Visible = False
    Items.Strings = (
      'Official'
      'Sport')
  end
  object tangiCombo: TComboBox
    Left = 240
    Top = 504
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 12
    Text = 'Select Tangi Degree'
    Visible = False
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object itemCombo02: TComboBox
    Left = 240
    Top = 440
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 13
    Text = 'Select Item'
    Visible = False
    Items.Strings = (
      'Shalvar'
      'Shalvarak'
      'Pirahan'
      'Tshirt'
      'Kolah'
      'Kot'
      'Daman'
      'Mantow'
      'Top')
  end
  object itemCombo01: TComboBox
    Left = 240
    Top = 440
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 14
    Text = 'Select Item'
    Visible = False
    Items.Strings = (
      'Shalvar'
      'Shalvarak'
      'Pirahan'
      'Tshirt'
      'Kolah')
  end
  object itemCombo10: TComboBox
    Left = 240
    Top = 440
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 15
    Text = 'Select Item'
    Visible = False
    Items.Strings = (
      'Shalvar'
      'Kapshan'
      'Pirahan'
      'Blouse'
      'Kolah'
      'Kot'
      'Palto')
  end
  object itemCombo12: TComboBox
    Left = 240
    Top = 440
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 16
    Text = 'Select Item'
    Visible = False
    Items.Strings = (
      'Shalvar'
      'Kapshan'
      'Pirahan'
      'Kolah'
      'Kot'
      'Daman'
      'Manto'
      'Shaal'
      'Palto'
      'Blouse')
  end
  object itemCombo11: TComboBox
    Left = 240
    Top = 440
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 17
    Text = 'Select Item'
    Visible = False
    Items.Strings = (
      'Shalvar'
      'Kapshan'
      'Pirahan'
      'Blouse'
      'Kolah'
      'Shaal')
  end
  object zerafatCombo: TComboBox
    Left = 240
    Top = 472
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 18
    Text = 'Select Zerafat Degree'
    Visible = False
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object pictureCombo: TComboBox
    Left = 240
    Top = 472
    Width = 147
    Height = 21
    ItemHeight = 13
    TabOrder = 19
    Text = 'Have Picture?'
    Visible = False
    Items.Strings = (
      'Yes'
      'No')
  end
  object reportRadio: TRadioGroup
    Left = 16
    Top = 48
    Width = 185
    Height = 137
    Caption = 'Report Mode'
    Items.Strings = (
      'Daily'
      'Monthly'
      'Annually')
    TabOrder = 20
    OnClick = reportRadioClick
  end
  object monthEdit: TMaskEdit
    Left = 16
    Top = 240
    Width = 152
    Height = 21
    EditMask = '!9999/99;1;_'
    MaxLength = 7
    TabOrder = 21
    Text = '0000/00'
    Visible = False
  end
  object yearEdit: TMaskEdit
    Left = 16
    Top = 240
    Width = 152
    Height = 21
    EditMask = '!9999;1;_'
    MaxLength = 4
    TabOrder = 22
    Text = '0000'
    Visible = False
  end
  object reportBtn: TButton
    Left = 16
    Top = 280
    Width = 153
    Height = 33
    Caption = 'Creat Report'
    TabOrder = 23
    Visible = False
    OnClick = reportBtnClick
  end
  object dayCountEdit: TEdit
    Left = 32
    Top = 360
    Width = 153
    Height = 21
    TabOrder = 24
    Visible = False
  end
  object monthCountList: TListBox
    Left = 32
    Top = 360
    Width = 153
    Height = 177
    ItemHeight = 13
    TabOrder = 25
    Visible = False
  end
  object yearCountList: TListBox
    Left = 32
    Top = 360
    Width = 153
    Height = 177
    ItemHeight = 13
    TabOrder = 26
    Visible = False
  end
  object date: TMaskEdit
    Left = 16
    Top = 240
    Width = 151
    Height = 21
    EditMask = '!9999/99/00;1;_'
    MaxLength = 10
    TabOrder = 28
    Text = '0000/00/00'
  end
end
