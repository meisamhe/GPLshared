object addForm: TaddForm
  Left = 194
  Top = 116
  BorderStyle = bsNone
  Caption = 'Add New Cloth'
  ClientHeight = 566
  ClientWidth = 792
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object label1: TLabel
    Left = 8
    Top = 8
    Width = 777
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = '(( Add New Cloth ))'
    Color = 12615935
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object quantityLabel: TLabel
    Left = 276
    Top = 112
    Width = 170
    Height = 20
    AutoSize = False
    Caption = 'Insert Quantity:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object buyLabel: TLabel
    Left = 276
    Top = 184
    Width = 170
    Height = 20
    AutoSize = False
    Caption = 'Insert Buy Price:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sellLabel: TLabel
    Left = 276
    Top = 248
    Width = 170
    Height = 20
    AutoSize = False
    Caption = 'Insert Sell Price:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object discountLabel: TLabel
    Left = 276
    Top = 312
    Width = 170
    Height = 20
    AutoSize = False
    Caption = 'insert Discount (%) :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object seasonDisLabel: TLabel
    Left = 276
    Top = 376
    Width = 170
    Height = 20
    AutoSize = False
    Caption = 'Insert Season Discount  (%) :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 276
    Top = 440
    Width = 170
    Height = 20
    AutoSize = False
    Caption = 'Insert Least Valid Quantity :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Image1: TImage
    Left = 464
    Top = 72
    Width = 313
    Height = 433
  end
  object Label2: TLabel
    Left = 272
    Top = 51
    Width = 89
    Height = 25
    AutoSize = False
    Caption = 'Cloth Code:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 48
    Width = 201
    Height = 497
    Caption = 'Cloth Information'
    TabOrder = 21
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
  object seasonRadio: TRadioGroup
    Left = 40
    Top = 72
    Width = 89
    Height = 73
    Caption = 'Season'
    Items.Strings = (
      'Summer'
      'Winter')
    TabOrder = 1
    OnClick = seasonRadioClick
  end
  object casualRadio: TRadioGroup
    Left = 40
    Top = 160
    Width = 105
    Height = 105
    Caption = 'Casuality'
    Items.Strings = (
      'Man'
      'Child'
      'Woman')
    TabOrder = 2
    OnClick = casualRadioClick
  end
  object colorCombo: TComboBox
    Left = 40
    Top = 280
    Width = 121
    Height = 21
    ItemHeight = 13
    TabOrder = 3
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
    Left = 168
    Top = 280
    Width = 25
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object kindCombo: TComboBox
    Left = 40
    Top = 312
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 5
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
    Left = 40
    Top = 344
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 6
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
    Left = 40
    Top = 376
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object lengthCombo: TComboBox
    Left = 40
    Top = 408
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 8
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object itemCombo00: TComboBox
    Left = 40
    Top = 440
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 9
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
    Left = 40
    Top = 472
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 10
    Text = 'Select Trip'
    Visible = False
    Items.Strings = (
      'Official'
      'Sport')
  end
  object tangiCombo: TComboBox
    Left = 40
    Top = 504
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 11
    Text = 'Select Tangi Degree'
    Visible = False
    Items.Strings = (
      'Low'
      'Medium'
      'High')
  end
  object codeEdit: TEdit
    Left = 272
    Top = 80
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 12
  end
  object itemCombo02: TComboBox
    Left = 40
    Top = 440
    Width = 153
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
    Left = 40
    Top = 440
    Width = 153
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
    Left = 40
    Top = 440
    Width = 153
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
    Left = 40
    Top = 440
    Width = 153
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
    Left = 40
    Top = 440
    Width = 153
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
    Left = 40
    Top = 472
    Width = 153
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
    Left = 40
    Top = 472
    Width = 153
    Height = 21
    ItemHeight = 13
    TabOrder = 19
    Text = 'Have Picture?'
    Visible = False
    Items.Strings = (
      'Yes'
      'No')
  end
  object registerBtn: TButton
    Left = 272
    Top = 504
    Width = 121
    Height = 41
    Caption = 'Register'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
    TabOrder = 20
    OnClick = colorComboSelect
  end
  object MaskEdit1: TMaskEdit
    Left = 272
    Top = 144
    Width = 119
    Height = 21
    EditMask = '000;1;_'
    MaxLength = 3
    TabOrder = 22
    Text = '   '
  end
  object MaskEdit2: TMaskEdit
    Left = 272
    Top = 208
    Width = 116
    Height = 21
    EditMask = '0000000;1;_'
    MaxLength = 7
    TabOrder = 23
    Text = '       '
  end
  object MaskEdit3: TMaskEdit
    Left = 272
    Top = 272
    Width = 116
    Height = 21
    EditMask = '0000000;1;_'
    MaxLength = 7
    TabOrder = 24
    Text = '       '
  end
  object MaskEdit4: TMaskEdit
    Left = 272
    Top = 336
    Width = 118
    Height = 21
    EditMask = '00;1;_'
    MaxLength = 2
    TabOrder = 25
    Text = '  '
  end
  object MaskEdit5: TMaskEdit
    Left = 272
    Top = 400
    Width = 120
    Height = 21
    EditMask = '00;1;_'
    MaxLength = 2
    TabOrder = 26
    Text = '  '
  end
  object MaskEdit6: TMaskEdit
    Left = 272
    Top = 464
    Width = 120
    Height = 21
    EditMask = '000;1;_'
    MaxLength = 3
    TabOrder = 27
    Text = '   '
  end
end
