object storeReportForm: TstoreReportForm
  Left = 192
  Top = 114
  BorderStyle = bsNone
  Caption = 'Report'
  ClientHeight = 566
  ClientWidth = 792
  Color = 11649276
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
    Width = 769
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = '(( Reports ))'
    Color = 11860910
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object backBtn: TButton
    Left = 704
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 0
    OnClick = backBtnClick
  end
end
