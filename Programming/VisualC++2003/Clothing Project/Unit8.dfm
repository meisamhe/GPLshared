object changeForm: TchangeForm
  Left = 199
  Top = 215
  BorderStyle = bsNone
  Caption = 'Change Information'
  ClientHeight = 566
  ClientWidth = 792
  Color = 13346302
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
    Caption = '(( Change Information ))'
    Color = 16744576
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 64
    Top = 232
    Width = 657
    Height = 65
    Alignment = taCenter
    AutoSize = False
    Caption = '" This Page is not available yet! "'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -48
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
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
end
