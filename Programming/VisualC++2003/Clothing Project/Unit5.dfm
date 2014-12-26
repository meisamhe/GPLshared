object configForm: TconfigForm
  Left = 199
  Top = 117
  BorderStyle = bsNone
  Caption = 'Configuration'
  ClientHeight = 566
  ClientWidth = 792
  Color = 13609869
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
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = '(( Configuration ))'
    Color = clNavy
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object backBtn: TButton
    Left = 704
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 0
    OnClick = backBtnClick
  end
end
