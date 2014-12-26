object anbarForm: TanbarForm
  Left = 192
  Top = 114
  BorderStyle = bsNone
  Caption = 'Anbar'
  ClientHeight = 566
  ClientWidth = 792
  Color = 16736866
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
    Left = 64
    Top = 56
    Width = 649
    Height = 441
    Alignment = taCenter
    AutoSize = False
    Caption = 'Anbar Section'
    Color = 15650220
    Font.Charset = ANSI_CHARSET
    Font.Color = clFuchsia
    Font.Height = -64
    Font.Name = 'Impact'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object addBtn: TButton
    Left = 72
    Top = 64
    Width = 153
    Height = 81
    Caption = 'Add new cloth'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = addBtnClick
  end
  object configureBtn: TButton
    Left = 552
    Top = 64
    Width = 153
    Height = 81
    Caption = 'Change Information'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = configureBtnClick
  end
  object insertBtn: TButton
    Left = 72
    Top = 408
    Width = 153
    Height = 81
    Caption = 'Insert Cloth'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = insertBtnClick
  end
  object reportBtn: TButton
    Left = 552
    Top = 408
    Width = 153
    Height = 81
    Caption = 'Reports'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = reportBtnClick
  end
  object backBtn: TButton
    Left = 712
    Top = 536
    Width = 75
    Height = 25
    Caption = 'Back to main'
    TabOrder = 4
    OnClick = backBtnClick
  end
end
