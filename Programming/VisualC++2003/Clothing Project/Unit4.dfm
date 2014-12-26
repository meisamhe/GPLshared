object sellForm: TsellForm
  Left = 195
  Top = 124
  BorderStyle = bsNone
  Caption = 'Sell'
  ClientHeight = 566
  ClientWidth = 792
  Color = 10337761
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
    Caption = '(( Sell Form ))'
    Color = 16744576
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object backBtn: TButton
    Left = 712
    Top = 536
    Width = 75
    Height = 25
    Caption = 'back'
    TabOrder = 0
    OnClick = backBtnClick
  end
end
