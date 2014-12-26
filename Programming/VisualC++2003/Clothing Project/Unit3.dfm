object storeForm: TstoreForm
  Left = 193
  Top = 116
  BorderStyle = bsNone
  Caption = 'Store'
  ClientHeight = 566
  ClientWidth = 792
  Color = 13543458
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
    Left = 72
    Top = 56
    Width = 641
    Height = 441
    Alignment = taCenter
    AutoSize = False
    Caption = 'Store Section'
    Color = 15522207
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -64
    Font.Name = 'Impact'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object sellBtn: TButton
    Left = 88
    Top = 72
    Width = 113
    Height = 57
    Caption = 'Sell'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = sellBtnClick
  end
  object configBtn: TButton
    Left = 584
    Top = 72
    Width = 113
    Height = 57
    Caption = 'Configuration'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = configBtnClick
  end
  object reportBtn: TButton
    Left = 344
    Top = 424
    Width = 113
    Height = 57
    Caption = 'Reports'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = reportBtnClick
  end
  object backBtn: TButton
    Left = 704
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Back to main'
    TabOrder = 3
    OnClick = backBtnClick
  end
end
