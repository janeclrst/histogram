unit histogramGrayscale;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnLoad: TButton;
    btnDraw: TButton;
    imgMod: TImage;
    imgSrc: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure btnDrawClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
uses
  windows, math;

var
  bitmapR, bitmapG, bitmapB, BitmapGray, BitmapBiner : array[0..1000, 0..1000] of integer;
  bitmapR2, bitmapG2, bitmapB2, BitmapGray2, BitmapBiner2 : array[0..1000, 0..1000] of integer;
  hasilR, hasilG, hasilB, hasilGray, hasilBiner : array[0..1000, 0..1000] of integer;
  histo : array[0..255] of integer;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  i, j, R, G, B, gray : integer;
begin
  if (OpenPictureDialog1.Execute) then
  begin
    imgSrc.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
  for j:=0 to imgSrc.Height-1 do
  begin
    for i:=0 to imgSrc.Width-1 do
    begin
      //mengambil nilai RGB
      R := GetRValue(imgSrc.Canvas.Pixels[i,j]);
      G := GetGValue(imgSrc.Canvas.Pixels[i,j]);
      B := GetBValue(imgSrc.Canvas.Pixels[i,j]);
      gray := (R + G + B) div 3;
      bitmapR2[i,j] := R;
      bitmapG2[i,j] := G;
      bitmapB2[i,j] := B;
      bitmapGray2[i,j] := gray;
      if gray>127 then
        BitmapBiner2[i,j] := 1
      else
        BitmapBiner2[i,j] := 0;
    end;
  end;

  for j:= 0  to imgSrc.Height-1 do
  begin
    for i := 0 to imgSrc.Width-1 do
    begin
      inc(histo[bitmapGray2[i,j]]);
    end;
  end;
end;

procedure TForm1.btnDrawClick(Sender: TObject);
var
  i, j : integer;

begin
  for j:= 0  to imgMod.Height-1 do
  begin
       for i := 0 to imgMod.Width-1 do
       begin
            imgMod.Canvas.Pixels[i,j]:= RGB(255, 255, 255)
       end;
  end;

  imgMod.Canvas.MoveTo(5,5);
  imgMod.Canvas.LineTo(5,280);
  imgMod.Canvas.MoveTo(5,280);
  imgMod.Canvas.LineTo(265,280);

  for j:= 0  to imgSrc.Height-1 do
  begin
    for i := 0 to imgSrc.Width-1 do
    begin
      imgMod.Canvas.MoveTo(10+i, 280);
      imgMod.Canvas.LineTo(10+i, 280-histo[i]);
    end;
  end;

end;

end.

