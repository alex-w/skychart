unit pu_mosaic;

{$mode objfpc}{$H+}
{
Copyright (C) 2019 Patrick Chevalley

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

uses  u_constant, u_translation, UScaleDPI, u_util, u_projection,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Arrow, Spin, cu_radec;

type

  { Tf_mosaic }

  Tf_mosaic = class(TForm)
    ButtonLoad: TButton;
    ButtonSend: TButton;
    ButtonClear: TButton;
    ButtonSave: TButton;
    DEdown: TButton;
    DEup: TButton;
    GroupBox3: TGroupBox;
    Hoverlap: TSpinEdit;
    Label9: TLabel;
    MosaicName: TEdit;
    Label8: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Rotation: TFloatSpinEdit;
    Rotdown: TButton;
    RAright: TButton;
    ButtonClose: TButton;
    FrameList: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RAleft: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Ra: TRaDec;
    De: TRaDec;
    Rotup: TButton;
    SizeX: TSpinEdit;
    ApplyTimer: TTimer;
    SizeY: TSpinEdit;
    Voverlap: TSpinEdit;
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonSendClick(Sender: TObject);
    procedure DeChange(Sender: TObject);
    procedure DEdownClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure MosaicChange(Sender: TObject);
    procedure RaChange(Sender: TObject);
    procedure RAleftClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameListChange(Sender: TObject);
    procedure DEupClick(Sender: TObject);
    procedure RArightClick(Sender: TObject);
    procedure ApplyTimerTimer(Sender: TObject);
    procedure RotationChange(Sender: TObject);
    procedure RotdownClick(Sender: TObject);
    procedure RotupClick(Sender: TObject);
  private
    FClearMosaic,FApplyMosaic,FSaveMosaic,FonEndMosaic,FSendMosaic: TNotifyEvent;
    dra,dde,Fjdchart: double;
    procedure Apply;
  public
    procedure SetLang;
    property jdchart: double read Fjdchart write Fjdchart;
    property onClearMosaic: TNotifyEvent read FClearMosaic write FClearMosaic;
    property onApplyMosaic: TNotifyEvent read FApplyMosaic write FApplyMosaic;
    property onSaveMosaic: TNotifyEvent read FSaveMosaic write FSaveMosaic;
    property onSendMosaic: TNotifyEvent read FSendMosaic write FSendMosaic;
    property onEndMosaic: TNotifyEvent read FonEndMosaic write FonEndMosaic;
  end;

var
  f_mosaic: Tf_mosaic;

implementation

{$R *.lfm}

{ Tf_mosaic }

procedure Tf_mosaic.SetLang;
begin
  Caption := rsMosaic;
  GroupBox1.Caption := rsMosaicCenter;
  Label1.Caption := rsRA;
  Label2.Caption := rsDEC;
  GroupBox2.Caption := rsMosaic;
  Label8.Caption := rsName;
  Label5.Caption := rsFinderRectan;
  Label3.Caption := rsMosaicSize;
  Label6.Caption := rsHorizontalOv;
  Label7.Caption := rsVerticalOver;
  ButtonSend.Caption := rsSendViaServe;
  ButtonClear.Caption := rsClear;
  ButtonSave.Caption := rsSave;
  ButtonClose.Caption := rsClose;
end;

procedure Tf_mosaic.FormCreate(Sender: TObject);
begin
  dde := 30 / 60;
  dra := dde / 15;
  ScaleDPI(Self);
  SetLang;
end;

procedure Tf_mosaic.FormShow(Sender: TObject);
begin
  ButtonSend.Visible := Assigned(FSendMosaic);
  FrameListChange(Sender);
  Apply;
end;

procedure Tf_mosaic.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if Assigned(FonEndMosaic) then FonEndMosaic(Self);
end;

procedure Tf_mosaic.ButtonCloseClick(Sender: TObject);

begin
  ApplyTimer.Enabled := false;
  Close;
end;

procedure Tf_mosaic.ButtonLoadClick(Sender: TObject);
var
  buf,rot,w,h: string;
  f: textfile;
  row: TStringList;
  meq,mra,mde: double;
  i,n: integer;
begin
  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := HomeDir;
  if OpenDialog1.Execute then begin
    meq:=NullCoord;
    mra:=NullCoord;
    mde:=NullCoord;
    row:=TStringList.Create;
    AssignFile(f, OpenDialog1.FileName);
    Reset(f);
    repeat
      ReadLn(f,buf);
      SplitRec2(buf,'=',row);
      if row.Count<>2 then continue;
      if row[0]='NAME' then
         MosaicName.Text:=trim(row[1])
      else if row[0]='EQUINOX' then
         meq:=StrToFloatDef(row[1],NullCoord)
      else if row[0]='RA' then
         mra:=StrToFloatDef(row[1],NullCoord)
      else if row[0]='DEC' then
         mde:=StrToFloatDef(row[1],NullCoord)
      else if row[0]='ROT' then
         Rotation.Value:=StrToFloatDef(row[1],0)
      else if row[0]='FRAME' then begin
         i:=FrameList.Items.IndexOf(trim(row[1]));
         if i>=0 then FrameList.ItemIndex:=i;
      end
      else if row[0]='SIZEX' then
         SizeX.Value:=StrToIntDef(row[1],3)
      else if row[0]='SIZEY' then
         SizeY.Value:=StrToIntDef(row[1],3)
      else if row[0]='HOROVERLAP' then
         Hoverlap.Value:=StrToIntDef(row[1],10)
      else if row[0]='VEROVERLAP' then
         Voverlap.Value:=StrToIntDef(row[1],10);
    until eof(f);
    CloseFile(f);
    row.Free;
    if (meq<>NullCoord)and(mra<>NullCoord)and(mde<>NullCoord) then begin
      mra:=deg2rad*mra*15;
      mde:=deg2rad*mde;
      Precession(meq,jdchart,mra,mde);
      Ra.Value:=rad2deg*mra/15;
      De.Value:=rad2deg*mde;
    end;
    Apply;
  end;
end;

procedure Tf_mosaic.ButtonClearClick(Sender: TObject);
begin
  if Assigned(FClearMosaic) then FClearMosaic(Self);
end;

procedure Tf_mosaic.ButtonSaveClick(Sender: TObject);
begin
  if Assigned(FSaveMosaic) then FSaveMosaic(Self);
end;

procedure Tf_mosaic.ButtonSendClick(Sender: TObject);
begin
  if Assigned(FSendMosaic) then FSendMosaic(Self);
end;

procedure Tf_mosaic.Apply;
begin
  ApplyTimer.Enabled := false;
  ApplyTimer.Enabled := true;
end;

procedure Tf_mosaic.ApplyTimerTimer(Sender: TObject);
begin
  ApplyTimer.Enabled := false;
  if Assigned(FApplyMosaic) then FApplyMosaic(Self);
end;

procedure Tf_mosaic.DeChange(Sender: TObject);
begin
  Apply;
end;

procedure Tf_mosaic.RaChange(Sender: TObject);
begin
  Apply;
end;

procedure Tf_mosaic.RotationChange(Sender: TObject);
begin
  Apply;
end;

procedure Tf_mosaic.MosaicChange(Sender: TObject);
begin
  Apply
end;

procedure Tf_mosaic.DEupClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then
     De.Value := De.Value + dde*5
  else if ssShift in GetKeyShiftState then
     De.Value := De.Value + dde/5
  else
     De.Value := De.Value + dde;
  Apply;
end;

procedure Tf_mosaic.DEdownClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then
     De.Value := De.Value - dde*5
  else if ssShift in GetKeyShiftState then
     De.Value := De.Value - dde/5
  else
     De.Value := De.Value - dde;
  Apply;
end;

procedure Tf_mosaic.RArightClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then
     Ra.Value := Ra.Value - dra*5
  else if ssShift in GetKeyShiftState then
     Ra.Value := Ra.Value - dra/5
  else
     Ra.Value := Ra.Value - dra;
  Apply;
end;

procedure Tf_mosaic.RAleftClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then
     Ra.Value := Ra.Value + dra*5
  else if ssShift in GetKeyShiftState then
     Ra.Value := Ra.Value + dra/5
  else
     Ra.Value := Ra.Value + dra;
  Apply;
end;

procedure Tf_mosaic.RotdownClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then
     Rotation.Value := rmod(Rotation.Value + 45 + 360, 360)
  else if ssShift in GetKeyShiftState then
     Rotation.Value := rmod(Rotation.Value + 1 + 360, 360)
  else
     Rotation.Value := rmod(Rotation.Value + 10 + 360, 360);
  Apply;
end;

procedure Tf_mosaic.RotupClick(Sender: TObject);
begin
  if ssCtrl in GetKeyShiftState then
     Rotation.Value := rmod(Rotation.Value - 45 + 360, 360)
  else if ssShift in GetKeyShiftState then
     Rotation.Value := rmod(Rotation.Value - 1 + 360, 360)
  else
     Rotation.Value := rmod(Rotation.Value - 10 + 360, 360);
  Apply;
end;

procedure Tf_mosaic.FrameListChange(Sender: TObject);
var buf,s: string;
    p: integer;
    x,c,r: double;
begin
  // size is first part of text
  buf := FrameList.Text;
  p := pos(lmin,buf);
  if p<=0 then exit;
  s := copy(buf,1,p-1);
  x := StrToFloatDef(s,-1);
  if x<0 then exit;
  // dec offset in degree
  dde := x / 60 / 6;
  c := cos(deg2rad * De.Value);
  if c=0 then c:=0.00001;
  // ra offset in hour
  dra := dde / c / 15;
  // rotation
  p := pos('PA',buf);
  if p<=0 then exit;
  delete(buf,1,p+1);
  p := pos(ldeg,buf);
  if p<=0 then exit;
  s := copy(buf,1,p-1);
  r := StrToFloatDef(s,-1);
  if r<0 then exit;
  Rotation.Value:=r;
  // apply change
  Apply;
end;


end.

