program ScreenPaintApp;

uses
  Forms,
  ScreenPaintUnit in 'ScreenPaintUnit.pas' {FormScreenPaint},
  CommonFunctions51 in 'CommonFunctions51.pas',
  CursorResource21 in 'CursorResource21.pas',
  GraphicFunctions51 in 'GraphicFunctions51.pas',
  LovelyPaint21 in 'LovelyPaint21.pas',
  ShapeUtils21 in 'ShapeUtils21.pas',
  CRCUtils21 in 'CRCUtils21.pas',
  StringFunctions51 in 'StringFunctions51.pas',
  DibGraphic21 in 'DibGraphic21.pas',
  LovelyPanels21 in 'LovelyPanels21.pas',
  VectorSelectBoxUnit in 'VectorSelectBoxUnit.pas' {FormVectorSelectBox},
  VertexButton21 in 'VertexButton21.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ÆÁÄ»»­°å';
  Application.CreateForm(TFormScreenPaint, FormScreenPaint);
  Application.Run;
end.
