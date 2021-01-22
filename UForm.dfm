object Form1: TForm1
  Left = 0
  Top = 0
  Width = 1280
  Height = 994
  Caption = #1058#1054#1055#1080#1059
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 960
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 200
      Top = 8
      Width = 46
      Height = 13
      Caption = #1060#1091#1085#1082#1094#1080#1103
    end
    object LeOgran: TLabel
      Left = 272
      Top = 48
      Width = 66
      Height = 13
      Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
      Visible = False
    end
    object LaGrad: TLabel
      Left = 272
      Top = 48
      Width = 47
      Height = 13
      Caption = #1043#1088#1072#1076#1080#1077#1085#1090
      Visible = False
    end
    object LaConstLamd: TLabel
      Left = 400
      Top = 360
      Width = 49
      Height = 13
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083
      Visible = False
    end
    object RadioGroup1: TRadioGroup
      Tag = 1
      Left = 8
      Top = 200
      Width = 177
      Height = 113
      Caption = #1040#1083#1075#1086#1088#1080#1090#1084' '#1087#1086#1080#1089#1082#1072
      ItemIndex = 0
      Items.Strings = (
        #1052#1077#1090#1086#1076' '#1076#1080#1093#1086#1090#1086#1084#1080#1080
        #1052#1077#1090#1086#1076' '#1079#1086#1083#1086#1090#1086#1075#1086' '#1089#1077#1095#1077#1085#1080#1103
        #1052#1077#1090#1086#1076' '#1060#1080#1073#1086#1085#1072#1095#1095#1080)
      TabOrder = 0
    end
    object LabeledEdit3: TLabeledEdit
      Left = 8
      Top = 96
      Width = 57
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'A1'
      TabOrder = 1
      Text = '-10'
    end
    object LabeledEdit2: TLabeledEdit
      Left = 200
      Top = 176
      Width = 57
      Height = 21
      EditLabel.Width = 6
      EditLabel.Height = 13
      EditLabel.Caption = 'L'
      TabOrder = 2
      Text = '10'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 136
      Top = 96
      Width = 57
      Height = 21
      EditLabel.Width = 43
      EditLabel.Height = 13
      EditLabel.Caption = #1069#1087#1089#1080#1083#1086#1085
      TabOrder = 3
      Text = '0,001'
    end
    object CbFunctiono: TComboBox
      Left = 200
      Top = 24
      Width = 217
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Text = 'F(X)=(X+2)^3-Exp(X)'
      Items.Strings = (
        'F(X)=(X+2)^3-Exp(X)'
        'F(X)=X^4-2*X^2+5')
    end
    object LEB: TLabeledEdit
      Left = 8
      Top = 136
      Width = 57
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'Bottom'
      TabOrder = 5
      Text = '-10'
    end
    object LeT: TLabeledEdit
      Left = 72
      Top = 136
      Width = 57
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'Top'
      TabOrder = 6
      Text = '10'
    end
    object CbMu: TColorBox
      Left = 392
      Top = 56
      Width = 81
      Height = 22
      DefaultColorColor = clRed
      NoneColorColor = clRed
      Selected = clRed
      ItemHeight = 16
      TabOrder = 7
    end
    object CbLa: TColorBox
      Left = 392
      Top = 80
      Width = 81
      Height = 22
      DefaultColorColor = clBlue
      NoneColorColor = clBlue
      Selected = clBlue
      ItemHeight = 16
      TabOrder = 8
    end
    object RgMetod: TRadioGroup
      Left = 8
      Top = 8
      Width = 177
      Height = 73
      Caption = #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103
      ItemIndex = 0
      Items.Strings = (
        #1054#1076#1085#1086#1084#1077#1088#1085#1072#1103
        #1052#1085#1086#1075#1086#1084#1077#1088#1085#1072#1103
        #1064#1090#1088#1072#1092#1085#1072#1103'/'#1041#1072#1088#1100#1077#1088#1085#1072#1103)
      TabOrder = 9
      OnClick = RgMetodClick
    end
    object CbFunctionN: TComboBox
      Left = 200
      Top = 24
      Width = 217
      Height = 21
      ItemHeight = 13
      TabOrder = 10
      Text = 'F(X)=X1^2+X2^2'
      Visible = False
      Items.Strings = (
        'F(X)=X1^2+X2^2'
        'F(X)=-X1^2-X2^2+X1*X2-X1+2*X2'
        'F(X)=(X1-X2)^2+7*(X2^2-X1)^2'
        'F(X)=100*(X2-X1^2)^2+(1-X1)^2'
        'F(X)=80*X1^2+0.4*X2^2+X1+2*X2'
        'F(X)=-6*X1-32*X2+X1^2+4*X2^2')
    end
    object LeX: TLabeledEdit
      Left = 8
      Top = 176
      Width = 121
      Height = 21
      EditLabel.Width = 7
      EditLabel.Height = 13
      EditLabel.Caption = 'X'
      TabOrder = 11
      Text = '(8;10)'
      Visible = False
    end
    object LeGam: TLabeledEdit
      Left = 136
      Top = 136
      Width = 57
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Gam'
      TabOrder = 12
      Text = '1'
      Visible = False
    end
    object LeBet: TLabeledEdit
      Left = 136
      Top = 176
      Width = 57
      Height = 21
      EditLabel.Width = 16
      EditLabel.Height = 13
      EditLabel.Caption = 'Bet'
      TabOrder = 13
      Text = '1'
      Visible = False
    end
    object LePaint: TLabeledEdit
      Left = 392
      Top = 120
      Width = 73
      Height = 21
      EditLabel.Width = 86
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1089#1077#1081
      TabOrder = 14
      Text = '5'
    end
    object LePole: TLabeledEdit
      Left = 392
      Top = 160
      Width = 73
      Height = 21
      EditLabel.Width = 92
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1083#1077#1081
      TabOrder = 15
      Text = '5'
      Visible = False
      OnChange = LePoleChange
    end
    object ClbParam: TCheckListBox
      Left = 192
      Top = 336
      Width = 225
      Height = 97
      ItemHeight = 13
      Items.Strings = (
        #1042#1088#1072#1097#1077#1085#1080#1077' '#1089#1080#1084#1087#1083#1077#1082#1089#1072
        #1042#1088#1072#1097#1077#1085#1080#1077' '#1089#1080#1084#1087#1083#1077#1082#1089#1072' '#1056#1077#1076#1091#1082#1094#1080#1080
        #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103' '#1056#1072#1089#1090#1103#1078#1077#1085#1080#1103
        #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103' '#1057#1078#1072#1090#1080#1103)
      TabOrder = 16
      Visible = False
      OnClick = ClbParamClick
    end
    object RgMetodN: TRadioGroup
      Left = 8
      Top = 200
      Width = 177
      Height = 113
      Caption = #1040#1083#1075#1086#1088#1080#1090#1084
      ItemIndex = 0
      Items.Strings = (
        #1053#1077#1076#1083#1077#1088#1072'-'#1052#1080#1076#1072
        #1061#1091#1082#1072'-'#1044#1078#1080#1074#1089#1072
        #1054#1074#1088#1072#1078#1085#1099#1081
        #1053#1072#1080#1089#1082#1086#1088#1077#1081#1096#1080#1081' '#1089#1087#1091#1089#1082
        #1043#1088#1072#1076#1080#1077#1085#1090#1085#1099#1081
        #1057#1086#1087#1088#1103#1078#1077#1085#1085#1099#1093' '#1075#1088#1072#1076#1080#1077#1085#1090#1086#1074)
      TabOrder = 17
      Visible = False
      OnClick = RgMetodNClick
    end
    object BtTabeled: TButton
      Left = 200
      Top = 480
      Width = 75
      Height = 25
      Caption = #1058#1072#1073#1083#1080#1094#1072
      TabOrder = 18
      OnClick = BtTabeledClick
    end
    object RgMetodS: TRadioGroup
      Left = 8
      Top = 200
      Width = 177
      Height = 113
      Caption = #1040#1083#1075#1086#1088#1080#1090#1084
      ItemIndex = 0
      Items.Strings = (
        #1064#1090#1088#1072#1092#1085#1072#1103' '#1092#1091#1085#1082#1094#1080#1103
        #1041#1072#1088#1100#1077#1088#1085#1072#1103' '#1092#1091#1085#1082#1094#1080#1103
        #1050#1091#1088#1089#1086#1074#1072#1103' '#1088#1072#1073#1086#1090#1072)
      TabOrder = 19
      Visible = False
      OnClick = RgMetodSClick
    end
    object CbFunctionS: TComboBox
      Left = 200
      Top = 24
      Width = 273
      Height = 21
      ItemHeight = 13
      TabOrder = 20
      Text = 'F(X)=50-5*X1^2-10*X2^2'
      Visible = False
      Items.Strings = (
        'F(X)=-X1^2-X2^2+10*X1+16*X2'
        'F(X)=X1^2+X2^2'
        'F(X)=(X1-X2)^2+7*(X2^2-X1)^2'
        'F(X)=50-5*X1^2-10*X2^2')
    end
    object MeOgran: TMemo
      Left = 272
      Top = 64
      Width = 113
      Height = 201
      Lines.Strings = (
        'F(X)<=X1+X2-2'
        'F(X)<=0.5-X1'
        'F(X)=X2')
      ScrollBars = ssBoth
      TabOrder = 21
      Visible = False
    end
    object ClbParamS: TCheckListBox
      Left = 192
      Top = 328
      Width = 193
      Height = 145
      ItemHeight = 13
      Items.Strings = (
        #1055#1086#1080#1089#1082' '#1084#1080#1085#1080#1084#1091#1084#1072' '#1074#1085#1091#1090#1088#1080
        #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103' '#1061#1091#1082#1072'-'#1044#1078#1080#1074#1089#1072
        #1051#1080#1085#1077#1081#1085#1086#1077' '#1052#1102' '#1087#1088#1080' '#1054#1075#1088'<1'
        #1057#1084#1077#1097#1077#1085#1080#1077' '#1096#1090#1088#1072#1092#1085#1086#1081' '#1092#1091#1085#1082#1094#1080#1080
        #1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' '#1048#1085#1090' '#1091#1085#1080#1084#1086#1076#1072#1083#1100#1085#1086#1089#1090#1080
        #1059#1089#1090#1088#1072#1085#1077#1085#1080#1077' '#1074#1099#1093#1086#1076#1072' '#1079#1072' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
        #1056#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1074#1090#1086#1088#1086#1075#1086' '#1101#1090#1072#1087#1072
        #1042#1086#1079#1074#1077#1076#1077#1085#1080#1077' '#1073#1072#1088#1100#1077#1088#1072' '#1074' '#1089#1090#1077#1087#1077#1085#1100' P')
      TabOrder = 22
      Visible = False
    end
    object LeKolEpsilon: TLabeledEdit
      Left = 192
      Top = 408
      Width = 113
      Height = 21
      EditLabel.Width = 125
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1091#1084#1077#1085#1100#1096#1077#1085#1080#1081
      TabOrder = 23
      Text = '5'
      Visible = False
    end
    object LeShagEpsilon: TLabeledEdit
      Left = 312
      Top = 408
      Width = 105
      Height = 21
      EditLabel.Width = 113
      EditLabel.Height = 13
      EditLabel.Caption = #1059#1084#1077#1085#1100#1096#1077#1085#1080#1077' eps ('#1088#1072#1079')'
      TabOrder = 24
      Text = '10'
      Visible = False
    end
    object LabeledEdit4: TLabeledEdit
      Left = 72
      Top = 96
      Width = 57
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'B1'
      TabOrder = 25
      Text = '10'
    end
    object Panel3: TPanel
      Left = 1
      Top = 512
      Width = 671
      Height = 447
      Align = alBottom
      TabOrder = 26
      object StringGrid1: TStringGrid
        Left = 1
        Top = 1
        Width = 669
        Height = 445
        Align = alClient
        ColCount = 7
        Enabled = False
        RowCount = 2
        TabOrder = 0
        ColWidths = (
          64
          80
          85
          64
          64
          64
          64)
        RowHeights = (
          24
          24)
      end
      object StringGrid2: TStringGrid
        Left = 1
        Top = 1
        Width = 669
        Height = 445
        Align = alClient
        ColCount = 10
        RowCount = 2
        TabOrder = 1
        Visible = False
      end
      object StringGrid3: TStringGrid
        Left = 1
        Top = 1
        Width = 669
        Height = 445
        Align = alClient
        RowCount = 2
        TabOrder = 2
        Visible = False
      end
      object StringGrid4: TStringGrid
        Left = 1
        Top = 1
        Width = 669
        Height = 445
        Align = alClient
        RowCount = 2
        TabOrder = 3
        Visible = False
      end
      object StringGrid5: TStringGrid
        Left = 1
        Top = 1
        Width = 669
        Height = 445
        Align = alClient
        ColCount = 7
        RowCount = 2
        TabOrder = 4
        Visible = False
        RowHeights = (
          24
          24)
      end
      object StringGrid6: TStringGrid
        Left = 1
        Top = 1
        Width = 669
        Height = 445
        Align = alClient
        RowCount = 2
        TabOrder = 5
        Visible = False
      end
    end
    object LeEpsGraph: TLabeledEdit
      Left = 392
      Top = 200
      Width = 73
      Height = 21
      EditLabel.Width = 72
      EditLabel.Height = 13
      EditLabel.Caption = #1064#1080#1088#1080#1085#1072' '#1083#1080#1085#1080#1081
      TabOrder = 27
      Text = '1'
      Visible = False
    end
    object LeX1: TLabeledEdit
      Left = 136
      Top = 176
      Width = 121
      Height = 21
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'X1'
      TabOrder = 28
      Text = '(-5;-3)'
      Visible = False
    end
    object MeGrad: TMemo
      Left = 272
      Top = 64
      Width = 113
      Height = 201
      Lines.Strings = (
        'F(X)=-6+2*X1'
        'F(X)=-32+8*X2')
      TabOrder = 29
      Visible = False
    end
    object Panel4: TPanel
      Left = 480
      Top = 1
      Width = 192
      Height = 511
      Align = alRight
      TabOrder = 30
      object Label2: TLabel
        Left = 9
        Top = 256
        Width = 95
        Height = 13
        Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1099' '#1087#1086#1083#1077#1081
      end
      object LaMashtab: TLabel
        Left = 9
        Top = 432
        Width = 39
        Height = 14
        Caption = #1052#1072#1096#1090#1072#1073
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
      end
      object ClbPaint: TCheckListBox
        Left = 7
        Top = 16
        Width = 177
        Height = 233
        ItemHeight = 13
        TabOrder = 0
      end
      object MeKoordPole: TMemo
        Left = 7
        Top = 272
        Width = 177
        Height = 153
        Lines.Strings = (
          '1'
          '5'
          '10'
          '15'
          '20')
        ScrollBars = ssBoth
        TabOrder = 1
        Visible = False
      end
      object BtPaint: TButton
        Left = 5
        Top = 448
        Width = 75
        Height = 25
        Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
        TabOrder = 2
        OnClick = BtPaintClick
      end
      object BitBtn1: TBitBtn
        Left = 5
        Top = 480
        Width = 75
        Height = 25
        TabOrder = 3
        Kind = bkClose
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 312
      Width = 193
      Height = 201
      TabOrder = 31
      object LabeledEdit5: TLabeledEdit
        Left = 8
        Top = 60
        Width = 177
        Height = 21
        EditLabel.Width = 175
        EditLabel.Height = 13
        EditLabel.Caption = #1054#1087#1090#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1072#1088#1075#1091#1084#1077#1085#1090#1072
        TabOrder = 0
      end
      object LabeledEdit6: TLabeledEdit
        Left = 8
        Top = 20
        Width = 177
        Height = 21
        EditLabel.Width = 165
        EditLabel.Height = 13
        EditLabel.Caption = #1054#1087#1090#1080#1084#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1092#1091#1085#1082#1094#1080#1080
        TabOrder = 1
      end
      object LeKolFunct: TLabeledEdit
        Left = 8
        Top = 100
        Width = 177
        Height = 21
        EditLabel.Width = 174
        EditLabel.Height = 13
        EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1073#1088#1072#1097#1077#1085#1080#1081' '#1082' '#1092#1091#1085#1082#1094#1080#1080
        TabOrder = 2
      end
      object LeKolIter: TLabeledEdit
        Left = 8
        Top = 140
        Width = 177
        Height = 21
        EditLabel.Width = 109
        EditLabel.Height = 13
        EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1080#1090#1077#1088#1072#1094#1080#1081
        TabOrder = 3
      end
      object Button2: TButton
        Left = 8
        Top = 168
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
    object BtTimer: TButton
      Left = 278
      Top = 480
      Width = 75
      Height = 25
      Caption = #1042#1088#1077#1084#1103
      TabOrder = 32
      OnClick = BtTimerClick
    end
    object RgParamO: TRadioGroup
      Left = 192
      Top = 328
      Width = 233
      Height = 73
      Caption = #1042#1072#1088#1080#1072#1085#1090' '#1087#1086#1080#1089#1082#1072
      ItemIndex = 0
      Items.Strings = (
        #1054#1076#1080#1085#1086#1095#1085#1072#1103' '#1080#1090#1077#1088#1072#1094#1080#1103
        #1055#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1099#1081' '#1089#1087#1091#1089#1082)
      TabOrder = 33
      OnClick = RgParamOClick
    end
    object RgXyDg: TRadioGroup
      Left = 192
      Top = 328
      Width = 233
      Height = 73
      Caption = #1057#1087#1091#1089#1082
      ItemIndex = 0
      Items.Strings = (
        #1055#1083#1072#1085#1086#1084#1077#1088#1085#1099#1081' '#1089#1087#1091#1089#1082
        #1054#1076#1085#1086#1084#1077#1088#1085#1072#1103' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103)
      TabOrder = 34
      Visible = False
    end
    object LeDop: TLabeledEdit
      Left = 200
      Top = 136
      Width = 57
      Height = 21
      EditLabel.Width = 12
      EditLabel.Height = 13
      EditLabel.Caption = 'Alf'
      TabOrder = 35
      Text = '1000'
      Visible = False
    end
    object LeLineOgr: TLabeledEdit
      Left = 392
      Top = 240
      Width = 73
      Height = 21
      EditLabel.Width = 72
      EditLabel.Height = 13
      EditLabel.Caption = #1064#1080#1088#1080#1085#1072' '#1083#1080#1085#1080#1081
      TabOrder = 36
      Text = '0,005'
    end
    object LeIterSrez: TLabeledEdit
      Left = 392
      Top = 280
      Width = 73
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = #1048#1090#1077#1088#1072#1094#1080#1103
      TabOrder = 37
      Text = '1'
      Visible = False
    end
    object CbSrez: TCheckBox
      Left = 392
      Top = 304
      Width = 81
      Height = 17
      Caption = #1057#1088#1077#1079
      TabOrder = 38
      Visible = False
    end
    object LePar: TLabeledEdit
      Left = 312
      Top = 280
      Width = 73
      Height = 21
      EditLabel.Width = 51
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1072#1084#1077#1090#1088
      TabOrder = 39
      Text = '1'
      Visible = False
    end
    object LeP: TLabeledEdit
      Left = 200
      Top = 96
      Width = 57
      Height = 21
      EditLabel.Width = 7
      EditLabel.Height = 13
      EditLabel.Caption = 'P'
      TabOrder = 40
      Text = '6'
      Visible = False
    end
    object SgConstLamd: TStringGrid
      Left = 392
      Top = 376
      Width = 89
      Height = 97
      ColCount = 1
      FixedCols = 0
      RowCount = 3
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 41
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 673
    Top = 0
    Width = 599
    Height = 960
    Align = alClient
    TabOrder = 1
    object PBGrap: TPaintBox
      Left = 1
      Top = 1
      Width = 597
      Height = 958
      Cursor = crHandPoint
      Align = alClient
      OnMouseDown = PBGrapMouseDown
    end
  end
end
