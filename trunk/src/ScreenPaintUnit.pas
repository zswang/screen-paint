(*//
标题：屏幕画板
说明：切屏绘制
设计：ZswangY37
日期：2011-03-30
支持：wjhu111#21cn.com
//*)

unit ScreenPaintUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, LovelyPaint21, ActnList, StdActns, AppEvnts;

const
  WM_ICONEVENT = WM_USER + 10; //托盘图标消息
  MY_PLAY = WM_USER + $1001; //启动

const cIconIdent = 4587;
const cHotKeyWinP = 1007;
const cHotKeyWinZ = 1008;

var
  WM_TASKBARCREATED: DWORD; //任务拦重建消息

type
  TFormScreenPaint = class(TForm)
    PopupMenuJug: TPopupMenu;
    MenuItemCloseA: TMenuItem;
    PopupMenuPaint: TPopupMenu;
    ActionListOne: TActionList;
    MenuItemShape: TMenuItem;
    MenuItemColor: TMenuItem;
    MenuItemPenWidth: TMenuItem;
    MenuItemPen: TMenuItem;
    MenuItemLine: TMenuItem;
    MenuItemArrow: TMenuItem;
    MenuItemRectangle: TMenuItem;
    MenuItem: TMenuItem;
    MenuItemMoreShape: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N12: TMenuItem;
    MenuItem3Pixel: TMenuItem;
    MenuItem4Pixel: TMenuItem;
    MenuItem5Pixel: TMenuItem;
    MenuItemText: TMenuItem;
    MenuItemRestore: TMenuItem;
    MenuItemPlayA: TMenuItem;
    ActionPlay: TAction;
    ActionClose: TAction;
    MenuItem6Pixel: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ActionStop: TAction;
    TimerPlay: TTimer;
    ActionPen: TAction;
    ActionLine: TAction;
    ActionRectangle: TAction;
    ActionArrow: TAction;
    ActionText: TAction;
    ActionMoreShape: TAction;
    N5: TMenuItem;
    MenuItemCloseB: TMenuItem;
    ActionEllipse: TAction;
    ActionBlack: TAction;
    ActionRed: TAction;
    ActionGreen: TAction;
    ActionWhite: TAction;
    ActionMoreColor: TAction;
    Action3Pixel: TAction;
    Action4Pixel: TAction;
    Action6Pixel: TAction;
    Action5Pixel: TAction;
    ActionSky: TAction;
    MenuItemSky: TMenuItem;
    MenuItemModify: TMenuItem;
    ActionModify: TAction;
    ColorDialogOne: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActionPlayExecute(Sender: TObject);
    procedure ActionCloseExecute(Sender: TObject);
    procedure ActionStopExecute(Sender: TObject);
    procedure TimerPlayTimer(Sender: TObject);
    procedure ActionPenExecute(Sender: TObject);
    procedure ActionLineExecute(Sender: TObject);
    procedure ActionRectangleExecute(Sender: TObject);
    procedure ActionArrowExecute(Sender: TObject);
    procedure ActionTextExecute(Sender: TObject);
    procedure ActionMoreShapeExecute(Sender: TObject);
    procedure ActionEllipseExecute(Sender: TObject);
    procedure ActionBlackExecute(Sender: TObject);
    procedure ActionRedExecute(Sender: TObject);
    procedure ActionGreenExecute(Sender: TObject);
    procedure ActionSkyExecute(Sender: TObject);
    procedure ActionWhiteExecute(Sender: TObject);
    procedure ActionMoreColorExecute(Sender: TObject);
    procedure Action3PixelExecute(Sender: TObject);
    procedure Action4PixelExecute(Sender: TObject);
    procedure Action5PixelExecute(Sender: TObject);
    procedure Action6PixelExecute(Sender: TObject);
    procedure ActionModifyExecute(Sender: TObject);
  private
    { Private declarations }
    FLovelyPaint: TLovelyPaint21;
    FPenWidth: Integer;
    FPenColor: TColor;
    FShapeTool: TShapeTools;
    FShapeType: Byte;
    FSelectModel: string;
    procedure AddNotifyIcon; //添加托盘图标
    procedure WMICONEVENT(var Msg: TMessage); message WM_ICONEVENT;
    procedure WMSYSCOMMAND(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMHOTKEY(var Msg: TWMHOTKEY); message WM_HOTKEY;
    procedure MYPLAY(var Msg: TMessage); message MY_PLAY; // 让右键菜单消逝
  public
    { Public declarations }
    procedure ReloadScreen;
    procedure Play;
    procedure Stop;
  end;

var
  FormScreenPaint: TFormScreenPaint;

implementation

{$R *.dfm}

uses CommonFunctions51, GraphicFunctions51, ShapeUtils21, ShellAPI;

procedure TFormScreenPaint.AddNotifyIcon;
var
  vNotifyIconData: TNotifyIconData;
begin
  vNotifyIconData.cbSize := SizeOf(vNotifyIconData);
  vNotifyIconData.Wnd := Handle;
  vNotifyIconData.uID := cIconIdent;
  vNotifyIconData.uFlags:= NIF_ICON or NIF_MESSAGE or NIF_TIP;
  vNotifyIconData.uCallbackMessage := WM_ICONEVENT;
  vNotifyIconData.hIcon := Application.Icon.Handle;
  StrLCopy(vNotifyIconData.szTip, PChar(Application.Title), 64);
  Shell_NotifyIcon(NIM_ADD, @vNotifyIconData);
end;

procedure TFormScreenPaint.FormCreate(Sender: TObject);
begin
  FPenWidth := 3;
  FPenColor := clBlack;
  FShapeTool := pstPaint;
  FShapeType := stPen;
  Stop;
  AddNotifyIcon;
  RegisterHotKey(Handle, cHotKeyWinP, MOD_WIN, VK_P);
  RegisterHotKey(Handle, cHotKeyWinZ, MOD_WIN, VK_Z);
end;

procedure TFormScreenPaint.ReloadScreen;
var
  vBitmap: TBitmap;
begin
  vBitmap := TBitmap.Create;
  TakeDesktop(vBitmap, Screen.DesktopRect);

  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height;
  if Assigned(FLovelyPaint) then FLovelyPaint.Free;
  FLovelyPaint := TLovelyPaint21.Create(nil);
  FLovelyPaint.Parent := Self;
  FLovelyPaint.Align := alClient;
  FLovelyPaint.Width := Width;
  FLovelyPaint.Height := Height;
  FLovelyPaint.Clear;
  FLovelyPaint.VectorShapePath := CommonFunctions51.ExePath + 'vector';
  FLovelyPaint.SetBackGraphic(vBitmap);
  FLovelyPaint.SelectShape := FShapeType;
  FLovelyPaint.SelectPenColor := FPenColor;
  FLovelyPaint.SelectTools := FShapeTool;
  FLovelyPaint.SelectPenWidth := FPenWidth;
  FLovelyPaint.SelectModel := FSelectModel;
  FLovelyPaint.IsScreenPaint := True;
  FLovelyPaint.PopupMenu := PopupMenuPaint;
  vBitmap.Free;
end;

procedure TFormScreenPaint.WMICONEVENT(var Msg: TMessage);
begin
  case Msg.LParam of
    WM_LBUTTONDBLCLK: ;
    WM_RBUTTONDOWN:
    begin
      SetForegroundWindow(Handle);
      Application.ProcessMessages;
      PopupMenuJug.PopupComponent := Self;
      PopupMenuJug.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      PostMessage(Handle, WM_NULL, 0, 0);
    end;
  end;
end;

procedure TFormScreenPaint.WMSYSCOMMAND(var Msg: TWMSysCommand);
begin
  inherited;
  case Msg.CmdType of
    SC_MINIMIZE: Stop;
  end;
end;

procedure TFormScreenPaint.FormDestroy(Sender: TObject);
var
  vNotifyIconData: TNotifyIconData;
begin
  vNotifyIconData.cbSize := SizeOf(vNotifyIconData);
  vNotifyIconData.Wnd := Handle;
  vNotifyIconData.uID := cIconIdent;
  Shell_NotifyIcon(NIM_DELETE, @vNotifyIconData);
  UnregisterHotKey(Handle, cHotKeyWinP);
  UnregisterHotKey(Handle, cHotKeyWinZ);
end;

procedure TFormScreenPaint.WMHOTKEY(var Msg: TWMHOTKEY);
begin
  case Msg.HotKey of
    cHotKeyWinP, cHotKeyWinZ: if Assigned(FLovelyPaint) then Stop else Play;
  end;
end;

procedure TFormScreenPaint.Play;
begin
  if Assigned(FLovelyPaint) then Exit;
  ReloadScreen;
  Application.ShowMainForm := True;
  Show;
  ForceForegroundWindow(Handle);
end;

procedure TFormScreenPaint.Stop;
begin
  Application.ShowMainForm := False;
  Hide;
  if Assigned(FLovelyPaint) then FLovelyPaint.Free;
  FLovelyPaint := nil;
end;

procedure TFormScreenPaint.ActionPlayExecute(Sender: TObject);
begin
  TimerPlay.Enabled := True;
//  PostMessage(Handle, MY_PLAY, 0, 0);
end;

procedure TFormScreenPaint.ActionCloseExecute(Sender: TObject);
begin
  Stop;
  Close;
end;

procedure TFormScreenPaint.MYPLAY(var Msg: TMessage);
begin
  Play;
end;

procedure TFormScreenPaint.ActionStopExecute(Sender: TObject);
begin
  Stop;
end;

procedure TFormScreenPaint.TimerPlayTimer(Sender: TObject);
begin
  TimerPlay.Enabled := False;
  Play;
end;

procedure TFormScreenPaint.ActionPenExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  FLovelyPaint.SelectShape := stPen;
  FShapeTool := FLovelyPaint.SelectTools;
  FShapeType := FLovelyPaint.SelectShape;
end;

procedure TFormScreenPaint.ActionLineExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  FLovelyPaint.SelectShape := stLine;
  FShapeTool := FLovelyPaint.SelectTools;
  FShapeType := FLovelyPaint.SelectShape;
end;

procedure TFormScreenPaint.ActionRectangleExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  FLovelyPaint.SelectShape := stHollowRectangle;
  FShapeTool := FLovelyPaint.SelectTools;
  FShapeType := FLovelyPaint.SelectShape;
end;

procedure TFormScreenPaint.ActionArrowExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  FLovelyPaint.SelectShape := stSingleArrow;
  FShapeTool := FLovelyPaint.SelectTools;
  FShapeType := FLovelyPaint.SelectShape;
end;

procedure TFormScreenPaint.ActionTextExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  FLovelyPaint.SelectShape := stEdit;
  FShapeTool := FLovelyPaint.SelectTools;
  FShapeType := FLovelyPaint.SelectShape;
end;

procedure TFormScreenPaint.ActionMoreShapeExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  if not FLovelyPaint.SelectVectorShape then Exit;
  FShapeTool := FLovelyPaint.SelectTools;
  FShapeType := FLovelyPaint.SelectShape;
  FSelectModel := FLovelyPaint.SelectModel;
end;

procedure TFormScreenPaint.ActionEllipseExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstPaint;
  FLovelyPaint.SelectShape := stHollowEllipse;
end;

procedure TFormScreenPaint.ActionBlackExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenColor := clBlack;
  FPenColor := FLovelyPaint.SelectPenColor;
end;

procedure TFormScreenPaint.ActionRedExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenColor := clRed;
  FPenColor := FLovelyPaint.SelectPenColor;
end;

procedure TFormScreenPaint.ActionGreenExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenColor := clGreen;
  FPenColor := FLovelyPaint.SelectPenColor;
end;

procedure TFormScreenPaint.ActionSkyExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenColor := clSkyBlue;
  FPenColor := FLovelyPaint.SelectPenColor;
end;

procedure TFormScreenPaint.ActionWhiteExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenColor := clWhite;
  FPenColor := FLovelyPaint.SelectPenColor;
end;

procedure TFormScreenPaint.ActionMoreColorExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  ColorDialogOne.Color := FLovelyPaint.SelectPenColor;
  if not ColorDialogOne.Execute then Exit;
  FLovelyPaint.SelectPenColor := ColorDialogOne.Color;
  FPenColor := FLovelyPaint.SelectPenColor;
end;

procedure TFormScreenPaint.Action3PixelExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenWidth := 3;
  FPenWidth := FLovelyPaint.SelectPenWidth;
end;

procedure TFormScreenPaint.Action4PixelExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenWidth := 4;
  FPenWidth := FLovelyPaint.SelectPenWidth;
end;

procedure TFormScreenPaint.Action5PixelExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenWidth := 5;
  FPenWidth := FLovelyPaint.SelectPenWidth;
end;

procedure TFormScreenPaint.Action6PixelExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectPenWidth := 6;
  FPenWidth := FLovelyPaint.SelectPenWidth;
end;

procedure TFormScreenPaint.ActionModifyExecute(Sender: TObject);
begin
  if not Assigned(FLovelyPaint) then Exit;
  FLovelyPaint.SelectTools := pstModify;
  FShapeTool := FLovelyPaint.SelectTools;
end;

end.
