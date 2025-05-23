unit cu_zoomimage;

{
Copyright (C) 2002 Patrick Chevalley

http://www.ap-i.net
pch@ap-i.net

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
}
{
 Very simple, not polished component to zoom an image.
}

{$mode objfpc}{$H+}

interface

uses
  u_bitmap,
  SysUtils, Classes, LResources, Controls, ExtCtrls, Graphics;

type
  TZoomImage = class(TCustomControl)
  private
    { Private declarations }
    FBitmap, TmpBmp: TBitmap;
    FPicture: TPicture;
    lockPicture: boolean;
    Fzoom, FZoomMin, FZoomMax: double;
    FXcentre, FYcentre, FSizeX, FSizeY, FXo, FYo, FXc, FYc, Fw, Fh: integer;
    FOnPaint: TNotifyEvent;
    FOnPosChange: TNotifyEvent;
    FBGcolor: Tcolor;
    procedure SetPicture(Value: TPicture);
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    procedure PictureChange(Sender: TObject);
  published
    { Published declarations }
    procedure Draw;
    function Wrld2ScrX(X: integer): integer;
    function Wrld2ScrY(Y: integer): integer;
    function Scr2WrldX(X: integer): integer;
    function Scr2WrldY(Y: integer): integer;
    property Canvas;
    property Picture: TPicture read FPicture write SetPicture;
    property Zoom: double read Fzoom write Fzoom;
    property ZoomMin: double read FZoomMin write FZoomMin;
    property ZoomMax: double read FZoomMax write FZoomMax;
    property Xcentre: integer read FXcentre write FXcentre;
    property Ycentre: integer read FYcentre write FYcentre;
    property BGcolor: TColor read FBGcolor write FBGcolor;
    property Xc: integer read FXc;
    property Yc: integer read FYc;
    property SizeX: integer read FSizeX;
    property SizeY: integer read FSizeY;
    property Align;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnPosChange: TNotifyEvent read FOnPosChange write FOnPosChange;
    property OnResize;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('CDC', [TZoomImage]);
end;

constructor TZoomImage.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  LockPicture := False;
  Height := 105;
  Width := 105;
  FZoom := 1;
  FZoomMin := 1;
  FZoomMax := 4;
  FBGcolor := clblack;
  FBitmap := TBitmap.Create;
  TmpBmp := TBitmap.Create;
  FPicture := TPicture.Create;
  FPicture.OnChange := @PictureChange;
end;

destructor TZoomImage.Destroy;
begin
  FBitmap.Free;
  TmpBmp.Free;
  FPicture.Free;
  inherited Destroy;
end;

procedure TZoomImage.SetPicture(Value: TPicture);
begin
  if Value.Width = 0 then
    raise Exception.Create('Invalid image!');
  FSizeX := Value.Width;
  FSizeY := Value.Height;
  FPicture.Assign(Value);
  FZoomMin := Width / FSizeX;
  if FZoomMax <= FZoomMin then
    FZoomMax := FZoomMin + 1;
end;

procedure TZoomImage.PictureChange(Sender: TObject);
begin
  if lockPicture then
  begin
    // do not loop when replacing the picture by a bitmap (windows only)
    exit;
  end;
  if FPicture.Width = 0 then
    exit;
  FSizeX := FPicture.Width;
  FSizeY := FPicture.Height;
  FZoomMin := Width / FSizeX;
  if FZoomMax <= FZoomMin then
    FZoomMax := FZoomMin + 1;
  //FZoom:=ZoomMin;
  Draw;
end;

procedure TZoomImage.Draw;
var
  x0, y0, dx, dy: integer;
begin
  if assigned(FPicture.Graphic) then
  begin
    if FZoom < FZoomMin then
      FZoom := FZoomMin;
    if FZoom > FZoomMax then
      FZoom := FZoomMax;
    if FZoom = 0 then
      exit;
    Fw := trunc(Width / FZoom);
    Fh := trunc(Height / FZoom);
    dx := round(Fw / 2);
    x0 := FSizeX - dx - dx;
    FXo := FXcentre - dx;
    if FXo < 0 then
      FXo := 0;
    if FXo > x0 then
      FXo := x0;
    dy := round(Fh / 2);
    y0 := FSizeY - dy - dy;
    FYo := FYcentre - dy;
    if FYo < 0 then
      FYo := 0;
    if FYo > y0 then
      FYo := y0;
    FXc := FXo + dx;
    FYc := FYo + dy;
    // Copy the partial image
    FBitmap.Width := Fw;
    FBitmap.Height := Fh;
    with FBitmap.Canvas do
    begin
      brush.Color := FBGcolor;
      pen.Color := FBGcolor;
      brush.Style := bsSolid;
      FillRect(0, 0, fw, fh);
    end;
    try
      FBitmap.Canvas.CopyRect(Rect(0, 0, Fw, Fh), FPicture.Bitmap.Canvas, Rect(FXo,
        FYo, FXo + Fw, FYo + Fh));
      // Resize
      BitmapResize(FBitmap, TmpBmp, Width / FBitmap.Width);
      // refresh the image
      Invalidate;
      if Assigned(FOnPosChange) then
        FOnPosChange(Self);
    except

    end;
  end;
end;

procedure TZoomImage.Paint;
begin
  if assigned(FPicture.Graphic) then
  begin
    Canvas.Draw(0, 0, TmpBmp);
    if Assigned(FOnPaint) then
      FOnPaint(Self);
  end
  else
  begin
    Canvas.Brush.Color := FBGcolor;
    Canvas.Rectangle(Rect(0, 0, Width, Height));
  end;
  inherited Paint;
end;

function TZoomImage.Wrld2ScrX(X: integer): integer;
begin
  if assigned(FPicture.Graphic) then
  begin
    Result := round(FZoom * (X - FXo));
  end
  else
    Result := 0;
end;

function TZoomImage.Wrld2ScrY(Y: integer): integer;
begin
  if assigned(FPicture.Graphic) then
  begin
    Result := round(FZoom * (Y - FYo));
  end
  else
    Result := 0;
end;

function TZoomImage.Scr2WrldX(X: integer): integer;
begin
  if (not assigned(FPicture.Graphic)) or (FZoom = 0) then
    Result := 0
  else
    Result := FXo + round(X / FZoom);
end;

function TZoomImage.Scr2WrldY(Y: integer): integer;
begin
  if (not assigned(FPicture.Graphic)) or (FZoom = 0) then
    Result := 0
  else
    Result := FYo + round(Y / FZoom);
end;

initialization
  {$I zoomimage.lrs}
end.
