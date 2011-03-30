object FormScreenPaint: TFormScreenPaint
  Left = 711
  Top = 179
  BorderStyle = bsNone
  Caption = 'FormScreenPaint'
  ClientHeight = 466
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PopupMenuJug: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 24
    Top = 8
    object MenuItemPlayA: TMenuItem
      Action = ActionPlay
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #24555#25463#38190
    end
    object N1: TMenuItem
      Caption = #27714#20851#27880
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuItemCloseA: TMenuItem
      Action = ActionClose
    end
  end
  object PopupMenuPaint: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 56
    Top = 8
    object MenuItemShape: TMenuItem
      Caption = #22270#24418
      object MenuItemPen: TMenuItem
        Action = ActionPen
        AutoCheck = True
      end
      object MenuItemLine: TMenuItem
        Action = ActionLine
        AutoCheck = True
      end
      object MenuItemArrow: TMenuItem
        Action = ActionArrow
        AutoCheck = True
      end
      object MenuItemRectangle: TMenuItem
        Action = ActionRectangle
        AutoCheck = True
      end
      object MenuItemText: TMenuItem
        Action = ActionText
        AutoCheck = True
      end
      object MenuItem: TMenuItem
        Action = ActionEllipse
        AutoCheck = True
      end
      object MenuItemMoreShape: TMenuItem
        Action = ActionMoreShape
        AutoCheck = True
      end
    end
    object MenuItemColor: TMenuItem
      Caption = #39068#33394
      object N9: TMenuItem
        Action = ActionBlack
        AutoCheck = True
      end
      object N10: TMenuItem
        Action = ActionRed
        AutoCheck = True
      end
      object N14: TMenuItem
        Action = ActionGreen
        AutoCheck = True
      end
      object N13: TMenuItem
        Action = ActionWhite
        AutoCheck = True
      end
      object MenuItemSky: TMenuItem
        Action = ActionSky
        AutoCheck = True
      end
      object N12: TMenuItem
        Action = ActionMoreColor
        AutoCheck = True
      end
    end
    object MenuItemPenWidth: TMenuItem
      Caption = #31895#32454
      object MenuItem3Pixel: TMenuItem
        Action = Action3Pixel
        AutoCheck = True
      end
      object MenuItem4Pixel: TMenuItem
        Action = Action4Pixel
        AutoCheck = True
      end
      object MenuItem5Pixel: TMenuItem
        Action = Action5Pixel
        AutoCheck = True
      end
      object MenuItem6Pixel: TMenuItem
        Action = Action6Pixel
        AutoCheck = True
      end
    end
    object MenuItemModify: TMenuItem
      Action = ActionModify
    end
    object MenuItemRestore: TMenuItem
      Action = ActionStop
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object MenuItemCloseB: TMenuItem
      Action = ActionClose
    end
  end
  object ActionListOne: TActionList
    Left = 88
    Top = 8
    object ActionPlay: TAction
      Caption = #21551#29992#23631#24149#30011#26495' '#12304'Win+P'#12305
      OnExecute = ActionPlayExecute
    end
    object ActionClose: TAction
      Caption = #20851#38381
      OnExecute = ActionCloseExecute
    end
    object ActionStop: TAction
      Caption = #36824#21407
      ShortCut = 27
      OnExecute = ActionStopExecute
    end
    object ActionPen: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #31508#21047
      Checked = True
      GroupIndex = 3
      ShortCut = 80
      OnExecute = ActionPenExecute
    end
    object ActionLine: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #30452#32447
      GroupIndex = 3
      ShortCut = 76
      OnExecute = ActionLineExecute
    end
    object ActionRectangle: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #30697#24418
      GroupIndex = 3
      ShortCut = 82
      OnExecute = ActionRectangleExecute
    end
    object ActionArrow: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #31661#22836
      GroupIndex = 3
      ShortCut = 65
      OnExecute = ActionArrowExecute
    end
    object ActionText: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #25991#23383
      GroupIndex = 3
      ShortCut = 84
      Visible = False
      OnExecute = ActionTextExecute
    end
    object ActionMoreShape: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #26356#22810#22270#24418
      GroupIndex = 3
      OnExecute = ActionMoreShapeExecute
    end
    object ActionEllipse: TAction
      Category = 'Shape'
      AutoCheck = True
      Caption = #22278#24418
      GroupIndex = 3
      ShortCut = 69
      OnExecute = ActionEllipseExecute
    end
    object ActionBlack: TAction
      Category = 'Color'
      AutoCheck = True
      Caption = #40657#33394
      Checked = True
      GroupIndex = 1
      ShortCut = 16450
      OnExecute = ActionBlackExecute
    end
    object ActionRed: TAction
      Category = 'Color'
      AutoCheck = True
      Caption = #32418#33394
      GroupIndex = 1
      ShortCut = 16466
      OnExecute = ActionRedExecute
    end
    object ActionGreen: TAction
      Category = 'Color'
      AutoCheck = True
      Caption = #32511#33394
      GroupIndex = 1
      ShortCut = 16455
      OnExecute = ActionGreenExecute
    end
    object ActionSky: TAction
      Category = 'Color'
      AutoCheck = True
      Caption = #22825#34013#33394
      GroupIndex = 1
      ShortCut = 16467
      OnExecute = ActionSkyExecute
    end
    object ActionWhite: TAction
      Category = 'Color'
      AutoCheck = True
      Caption = #30333#33394
      GroupIndex = 1
      ShortCut = 16471
      OnExecute = ActionWhiteExecute
    end
    object ActionMoreColor: TAction
      Category = 'Color'
      AutoCheck = True
      Caption = #26356#22810#39068#33394
      GroupIndex = 1
      OnExecute = ActionMoreColorExecute
    end
    object Action3Pixel: TAction
      Category = 'Pixel'
      AutoCheck = True
      Caption = '3'#20687#32032
      Checked = True
      GroupIndex = 2
      ShortCut = 51
      OnExecute = Action3PixelExecute
    end
    object Action4Pixel: TAction
      Category = 'Pixel'
      AutoCheck = True
      Caption = '4'#20687#32032
      GroupIndex = 2
      ShortCut = 52
      OnExecute = Action4PixelExecute
    end
    object Action5Pixel: TAction
      Category = 'Pixel'
      AutoCheck = True
      Caption = '5'#20687#32032
      GroupIndex = 2
      ShortCut = 53
      OnExecute = Action5PixelExecute
    end
    object Action6Pixel: TAction
      Category = 'Pixel'
      AutoCheck = True
      Caption = '6'#20687#32032
      GroupIndex = 2
      ShortCut = 54
      OnExecute = Action6PixelExecute
    end
    object ActionModify: TAction
      Caption = #32534#36753
      ShortCut = 77
      OnExecute = ActionModifyExecute
    end
  end
  object TimerPlay: TTimer
    Interval = 50
    OnTimer = TimerPlayTimer
    Left = 120
    Top = 8
  end
  object ColorDialogOne: TColorDialog
    Ctl3D = True
    Left = 152
    Top = 8
  end
end
