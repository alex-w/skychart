unit pu_image;

{$MODE Delphi}{$H+}

{
Copyright (C) 2005 Patrick Chevalley

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
interface

uses
  Math, u_util, u_translation, UScaleDPI, Printers,
  LCLIntf, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, cu_zoomimage,
  LResources;

type

  { Tf_image }

  Tf_image = class(TForm)
    ButtonPrint: TButton;
    Image1: TZoomImage;
    Panel1: TPanel;
    VScrollBar: TScrollBar;
    HScrollBar: TScrollBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HScrollBarChange(Sender: TObject);
    procedure VScrollBarChange(Sender: TObject);
  private
    { Private declarations }
    scrollw, scrollh: integer;
    ScrollLock: boolean;
    procedure SetScrollBar;
  public
    { Public declarations }
    titre, labeltext: string;
    imagewidth, imageheight: integer;
    procedure SetLang;
    procedure LoadImage(f: string);
    procedure ZoomN(n: double);
    procedure Zoomplus;
    procedure Zoommoins;
    procedure Init;
  end;

var
  f_image: Tf_image;

implementation

{$R *.lfm}

procedure Tf_image.SetLang;
begin
  Button1.Caption := rsClose;
  Button2.Caption := rsZoom;
  Button3.Caption := rsZoom2;
  ButtonPrint.Caption := rsPrint;
end;

procedure Tf_image.LoadImage(f: string);
begin
  image1.Zoom := 1;
  image1.picture.LoadFromFile(f);
  imagewidth := image1.picture.Width;
  imageheight := image1.picture.Height;
end;

procedure Tf_image.ZoomN(n: double);
begin
  Image1.Zoom := n;
  Image1.Draw;
  SetScrollBar;
  Caption := titre + ' x' + formatfloat('0.#', Image1.Zoom);
end;

procedure Tf_image.Zoomplus;
begin
  Image1.Zoom := sqrt(2) * Image1.Zoom;
  Image1.Draw;
  SetScrollBar;
  Caption := titre + ' x' + formatfloat('0.#', Image1.Zoom);
end;

procedure Tf_image.Zoommoins;
begin
  Image1.Zoom := Image1.Zoom / sqrt(2);
  if abs(Image1.Zoom - 1) < 0.2 then
    Image1.Zoom := 1;
  Image1.Draw;
  SetScrollBar;
  Caption := titre + ' x' + formatfloat('0.#', Image1.Zoom);
end;

procedure Tf_image.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key = chr(27) then
    Close;
  if (key = '+') then
    Zoomplus;
  if (key = '-') then
    Zoommoins;
end;

procedure Tf_image.Init;
begin
  Image1.Draw;
  Hscrollbar.Position := Image1.SizeX div 2;
  Vscrollbar.Position := Image1.SizeY div 2;
  Caption := titre + ' x' + formatfloat('0.#', Image1.Zoom);
  label1.Caption := labeltext;
end;

procedure Tf_image.Button2Click(Sender: TObject);
begin
  Zoomplus;
end;

procedure Tf_image.Button3Click(Sender: TObject);
begin
  Zoommoins;
end;

procedure Tf_image.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure Tf_image.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
begin
  if wheeldelta > 0 then
    Zoomplus
  else
    Zoommoins;
end;

procedure Tf_image.FormCreate(Sender: TObject);
begin
  ScaleDPI(Self);
  SetLang;
  Image1.Align := alClient;
  titre := '';
  labeltext := '';
  VScrollBar.Width := 15;
end;

procedure Tf_image.FormResize(Sender: TObject);
begin
  if Visible then
  begin
    Image1.Draw;
    SetScrollBar;
  end;
end;

procedure Tf_image.FormShow(Sender: TObject);
begin
  if GetPrinterIndex < 0 then
    ButtonPrint.Visible := False;
end;

procedure Tf_image.SetScrollBar;
begin
  try
    ScrollLock := True;
    scrollw := min(Image1.SizeX - 1, round(Image1.Width / Image1.zoom)) div 2;
    Hscrollbar.SetParams(Hscrollbar.Position, scrollw, Image1.SizeX - scrollw, 1);
    Hscrollbar.LargeChange := scrollw;
    Hscrollbar.SmallChange := scrollw div 10;
    scrollh := min(Image1.SizeY - 1, round(Image1.Height / Image1.zoom)) div 2;
    Vscrollbar.SetParams(Vscrollbar.Position, scrollh, Image1.SizeY - scrollh, 1);
    Vscrollbar.LargeChange := scrollh;
    Vscrollbar.SmallChange := scrollh div 10;
  finally
    ScrollLock := False;
  end;
end;

procedure Tf_image.HScrollBarChange(Sender: TObject);
begin
  if scrolllock then
    exit;
  Image1.Xcentre := HScrollBar.Position;
  Image1.Draw;
end;

procedure Tf_image.VScrollBarChange(Sender: TObject);
begin
  if scrolllock then
    exit;
  Image1.Ycentre := VScrollBar.Position;
  Image1.Draw;
end;

end.
