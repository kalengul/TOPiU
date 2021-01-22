object Form2: TForm2
  Left = 162
  Top = 156
  Width = 574
  Height = 414
  Caption = #1058#1072#1081#1084#1077#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LaMessage: TLabel
    Left = 8
    Top = 0
    Width = 553
    Height = 37
    Caption = #1042#1085#1080#1084#1072#1085#1080#1077': '#1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1088#1072#1073#1086#1090#1072#1077#1090' '#1076#1086#1083#1075#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LaFunction: TLabel
    Left = 256
    Top = 48
    Width = 53
    Height = 13
    Caption = 'LaFunction'
  end
  object LeB1: TLabeledEdit
    Left = 80
    Top = 112
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'B1'
    TabOrder = 0
    Text = '10'
  end
  object LeA1: TLabeledEdit
    Left = 16
    Top = 112
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'A1'
    TabOrder = 1
    Text = '-10'
  end
  object RgAlgoritm: TRadioGroup
    Tag = 1
    Left = 16
    Top = 176
    Width = 161
    Height = 105
    Caption = #1040#1083#1075#1086#1088#1080#1090#1084' '#1087#1086#1080#1089#1082#1072
    ItemIndex = 0
    Items.Strings = (
      #1052#1077#1090#1086#1076' '#1076#1080#1093#1086#1090#1086#1084#1080#1080
      #1052#1077#1090#1086#1076' '#1079#1086#1083#1086#1090#1086#1075#1086' '#1089#1077#1095#1077#1085#1080#1103
      #1052#1077#1090#1086#1076' '#1060#1080#1073#1086#1085#1072#1095#1095#1080)
    TabOrder = 2
  end
  object LeEps: TLabeledEdit
    Left = 184
    Top = 112
    Width = 57
    Height = 21
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = #1069#1087#1089#1080#1083#1086#1085
    TabOrder = 3
    Text = '0,01'
  end
  object LeL: TLabeledEdit
    Left = 184
    Top = 152
    Width = 57
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'L'
    TabOrder = 4
    Text = '0,1'
  end
  object RgMetod: TRadioGroup
    Left = 8
    Top = 40
    Width = 185
    Height = 49
    Caption = #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103
    ItemIndex = 0
    Items.Strings = (
      #1054#1076#1085#1086#1084#1077#1088#1085#1072#1103
      #1052#1085#1086#1075#1086#1084#1077#1088#1085#1072#1103)
    TabOrder = 5
    OnClick = RgMetodClick
  end
  object LeX1: TLabeledEdit
    Left = 16
    Top = 152
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'X1'
    TabOrder = 6
    Text = '0'
    Visible = False
  end
  object LeX2: TLabeledEdit
    Left = 80
    Top = 152
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'X2'
    TabOrder = 7
    Text = '0'
    Visible = False
  end
  object LeBet: TLabeledEdit
    Left = 184
    Top = 192
    Width = 57
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Betta'
    TabOrder = 8
    Text = '2'
    Visible = False
  end
  object Lealf: TLabeledEdit
    Left = 184
    Top = 232
    Width = 57
    Height = 21
    EditLabel.Width = 18
    EditLabel.Height = 13
    EditLabel.Caption = 'Alfa'
    TabOrder = 9
    Text = '0,5'
    Visible = False
  end
  object BtOk: TButton
    Left = 16
    Top = 352
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 10
    OnClick = BtOkClick
  end
  object MeTime: TMemo
    Left = 256
    Top = 80
    Width = 305
    Height = 297
    ScrollBars = ssBoth
    TabOrder = 11
  end
  object BtExit: TButton
    Left = 175
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 12
    OnClick = BtExitClick
  end
  object RgViborTimer: TRadioGroup
    Left = 16
    Top = 288
    Width = 233
    Height = 57
    Caption = #1048#1079#1084#1077#1085#1103#1090#1100' '#1074#1088#1077#1084#1103':'
    ItemIndex = 0
    Items.Strings = (
      #1042#1088#1077#1084#1103' '#1086#1073#1088#1072#1097#1077#1085#1080#1103' '#1082' '#1092#1091#1085#1082#1094#1080#1080
      #1044#1083#1080#1085#1085#1091' '#1080#1085#1090#1077#1088#1074#1072#1083#1072' '#1085#1077#1086#1087#1088#1077#1076#1077#1083#1077#1085#1085#1086#1089#1090#1080)
    TabOrder = 13
  end
end
