unit pu_obslist;

{
Copyright (C) 2013 Patrick Chevalley

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
 Observing list
}

{$mode objfpc}{$H+}

interface

uses
  u_help, u_translation, u_constant, u_util, u_projection, cu_planet,
  pu_tour, UScaleDPI,
  Math, Classes, SysUtils, LazUTF8, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Grids, EditBtn, StdCtrls, Menus, ComCtrls;

type

  TSelectObject = procedure(obj: string; ra, de: double) of object;
  TGetObjectCoord = procedure(obj: string; var lbl: string; var ra, de: double) of object;

  { Tf_obslist }

  Tf_obslist = class(TForm)
    Button1: TButton;
    BtnTour: TButton;
    BtnImportMosaic: TButton;
    BtnLoadCSV: TButton;
    ButtonLoad: TButton;
    AllLabels: TCheckBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RefreshTimer: TTimer;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    UpdAllCoord: TButton;
    HourAngleCombo: TComboBox;
    ButtonSave: TButton;
    ButtonClear: TButton;
    Button5: TButton;
    Button6: TButton;
    AirmassCombo: TComboBox;
    LimitAirmassTonight: TCheckBox;
    LimitAirmassNow: TCheckBox;
    LimitHourangleTonight: TCheckBox;
    LimitHourangleNow: TCheckBox;
    Edit1: TEdit;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MenuDelete: TMenuItem;
    MenuView: TMenuItem;
    MenuUpdcoord: TMenuItem;
    MenuTitle: TMenuItem;
    PageControl1: TPageControl;
    PanelBot: TPanel;
    PanelTop: TPanel;
    PopupMenu1: TPopupMenu;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure AirmassComboChange(Sender: TObject);
    procedure AllLabelsChange(Sender: TObject);
    procedure BtnLoadCSVClick(Sender: TObject);
    procedure BtnImportMosaicClick(Sender: TObject);
    procedure BtnTourClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure LimitAirmassTonightChange(Sender: TObject);
    procedure LimitAirmassNowChange(Sender: TObject);
    procedure LimitHourangleTonightChange(Sender: TObject);
    procedure LimitHourangleNowChange(Sender: TObject);
    procedure HourAngleComboChange(Sender: TObject);
    procedure MenuDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuUpdcoordClick(Sender: TObject);
    procedure MenuViewClick(Sender: TObject);
    procedure NoFilterListChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure StringGrid1ColRowMoved(Sender: TObject; IsColumn: boolean;
      sIndex, tIndex: integer);
    procedure StringGrid1CompareCells(Sender: TObject;
      ACol, ARow, BCol, BRow: integer; var Result: integer);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure StringGrid1ValidateEntry(Sender: TObject; aCol, aRow: integer;
      const OldValue: string; var NewValue: string);
    procedure ToggleBox1Click(Sender: TObject);
    procedure ToggleBox2Click(Sender: TObject);
    procedure UpdAllCoordClick(Sender: TObject);
  private
    { private declarations }
    title, FDefaultList, FObjName: string;
    Faltitude: double;
    FMeridianSide: integer;
    gridchanged, limitairmass, limittransit, locktogglebox, locknewlist: boolean;
    ClickCol, ClickRow: integer;
    FSelectObject, FSlew: TSelectObject;
    FGetObjectCoord: TGetObjectCoord;
    FObjLabelChange: TNotifyEvent;
    FObjLabels, FEmptyObjLabels: TStringList;
    function GetObjcount: integer;
    function GetRowcount: integer;
    procedure SetMeridianSide(Value: integer);
    procedure SetLimitType(Value: integer);
    function GetLimitType: integer;
    procedure TourFirst(Sender: TObject);
    procedure TourLast(Sender: TObject);
    procedure TourPrev(Sender: TObject);
    procedure TourNext(Sender: TObject);
    procedure TourSlew(Sender: TObject);
  public
    { public declarations }
    cfgsc: Tconf_skychart;
    planet: Tplanet;
    tour: Tf_tour;
    procedure SetLang;
    procedure Newlist;
    procedure Add(obj: string; ra, de: double; upd:boolean=true);
    procedure LoadObsList;
    procedure SaveObsList(fn: string);
    procedure ImportMosaic(fn: string);
    procedure LoadCSV(fn: string);
    procedure SelectRow(r: integer);
    function FirstObj: boolean;
    function LastObj: boolean;
    function NextObj: boolean;
    function PrevObj: boolean;
    procedure ComputeLimits;
    procedure ComputeAirmassTime;
    procedure ComputeTransitTime;
    procedure UpdateLabels(Sender: TObject;upd:boolean=true);
    function UpdateCoord(arow: integer): boolean;
    procedure SetVisibleRows;
    procedure Refresh(data:PtrInt=0);
    // total number of object added or loaded from the file
    property ObjCount: integer read GetObjCount;
    // number of object within visibility criterion
    property RowCount: integer read GetRowcount;
    property DefaultList: string read FDefaultList;
    property ObjLabels: TStringList read FObjLabels;
    property EmptyObjLabels: TStringList read FEmptyObjLabels;
    property MeridianSide: integer read FMeridianSide write SetMeridianSide;
    property LimitType: integer read GetLimitType write SetLimitType;
    property onSelectObject: TSelectObject read FSelectObject write FSelectObject;
    property onGetObjectCoord: TGetObjectCoord
      read FGetObjectCoord write FGetObjectCoord;
    property onObjLabelChange: TNotifyEvent read FObjLabelChange write FObjLabelChange;
    property onSlew: TSelectObject read FSlew write FSlew;
  end;

var
  f_obslist: Tf_obslist;

implementation

const
  objl = 32;
  radecl = 10;

{$R *.lfm}

{ Tf_obslist }

procedure Tf_obslist.SetLang;
var am: double;
begin
  Caption := rsObservingLis;
  StringGrid1.Columns[0].Title.Caption := rsObject;
  StringGrid1.Columns[1].Title.Caption := rsRA+' J2000';
  StringGrid1.Columns[2].Title.Caption := rsDEC+' J2000';
  StringGrid1.Columns[3].Title.Caption := rsStart;
  StringGrid1.Columns[4].Title.Caption := rsEnd;
  StringGrid1.Columns[5].Title.Caption := rsDescription;
  StringGrid1.Columns[6].Title.Caption := rsLabel2;
  AirmassCombo.Items[6] := rsHorizon;
  BtnTour.Caption := rsTour;
  ButtonSave.Caption := rsSave;
  ButtonClear.Caption := rsClear;
  UpdAllCoord.Caption := rsUpdateCoordi;
  ToggleBox1.Caption := rsAirmass;
  Label1.Caption := rsLimit;
  LimitAirmassTonight.Caption := rsOnlyObjectsW;
  LimitAirmassNow.Caption := rsOnlyObjectsW2;
  ToggleBox2.Caption := rsTransit;
  Label1.Caption := rsLimit;
  Label3.Caption := rsLimit;
  Label4.Caption := rsHours;
  RadioButton1.Caption := rsEastSide;
  RadioButton2.Caption := rsCrossMeridia;
  RadioButton3.Caption := rsWestSide;
  LimitHourangleTonight.Caption := rsOnlyObjectsW3;
  LimitHourangleNow.Caption := rsOnlyObjectsW4;
  MenuView.Caption := rsViewOnChart;
  MenuUpdcoord.Caption := rsUpdateCoordi;
  MenuDelete.Caption := rsDelete;
  button1.Caption := rshelp;
  SetHelp(self, hlpObslist);
  AllLabels.Caption := rsAddLabelForE;
  BtnImportMosaic.Caption:=rsImportMosaic;
  // airmass label
  am := StrToFloatDef(trim(AirmassCombo.Text), -99);
  if am < 0 then
  begin
    Faltitude := -0.5;
    label2.Caption := rsAltitude + ': ' + rsHorizon;
  end
  else
  begin
    if am < 1 then
      am := 1;
    Faltitude := 90 - rad2deg * arccos(1 / am);
    label2.Caption := rsAltitude + ': ' + formatfloat('0', Faltitude) + ldeg;
  end;
end;

procedure Tf_obslist.Newlist;
var
  buf: string;
begin
  StringGrid1.RowCount := 1;
  Edit1.Text := rsTitle;
  buf := ExtractFilePath(FileNameEdit1.FileName);
  if buf <> '' then
    buf := slash(buf);
  gridchanged := False;
  FileNameEdit1.InitialDir := buf;
  FileNameEdit1.FileName := buf + DefaultList;
  UpdateLabels(nil);
end;

procedure Tf_obslist.Add(obj: string; ra, de: double; upd:boolean=true);
var
  buf: string;
begin
  if obj <> '' then
  begin
    gridchanged := True;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid1.Cells[1, StringGrid1.RowCount - 1] := obj;
    StringGrid1.Cells[7, StringGrid1.RowCount - 1] := obj;
    buf := ARptoStr(ra/15,0);
    StringGrid1.Cells[2, StringGrid1.RowCount - 1] := buf;
    buf := DEToStr3(de);
    StringGrid1.Cells[3, StringGrid1.RowCount - 1] := buf;
    StringGrid1.Cells[6, StringGrid1.RowCount - 1] := '';
    UpdateLabels(nil,upd);
    if upd then begin
      Refresh;
    end;
  end;
end;

procedure Tf_obslist.ImportMosaic(fn: string);
var
  f: textfile;
  buf1, buf2: string;
  x,y,eq: double;
begin
  try
    AssignFile(f, fn);
    reset(f);
    eq:=cfgsc.CurJDUT;
    repeat
      ReadLn(f, buf1);
      if copy(buf1,1,8)='EQUINOX='  then begin
         buf2:=copy(buf1,9,99);
         eq:=StrToFloatDef(buf2,eq);
         continue;
      end;
      buf2 := words(buf1, blank, 2, 1);
      x := deg2rad * 15 * Str3ToAR(trim(buf2));
      if x = 0 then
      begin
        continue;
      end;
      buf2 := words(buf1, blank, 3, 1);
      y := deg2rad * Str3ToDE(trim(buf2));
      if y = 0 then
      begin
        continue;
      end;
      Precession(eq,jd2000,x,y);
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      StringGrid1.Cells[1, StringGrid1.RowCount - 1] := words(buf1, blank, 1, 1); ;
      buf2 := ARpToStr(rad2deg*x/15,0);
      StringGrid1.Cells[2, StringGrid1.RowCount - 1] := buf2;
      buf2 := DEToStr3(rad2deg*y);
      StringGrid1.Cells[3, StringGrid1.RowCount - 1] := buf2;
      StringGrid1.Cells[4, StringGrid1.RowCount - 1] := '';
      StringGrid1.Cells[5, StringGrid1.RowCount - 1] := '';
      StringGrid1.Cells[6, StringGrid1.RowCount - 1] := '';
      StringGrid1.Cells[7, StringGrid1.RowCount - 1] := StringGrid1.Cells[1, StringGrid1.RowCount - 1];
    until EOF(f);
    CloseFile(f);
  except
  end;
end;

procedure Tf_obslist.LoadCSV(fn: string);
var
  f: textfile;
  obj, sra, sde, lbl, desc, buf: string;
  ra, de: double;
  r:Tstringlist;
begin
if FileExists(fn) then
begin
  try
    StringGrid1.RowCount := 1;
    gridchanged := False;
    r:=Tstringlist.Create;
    AssignFile(f, fn);
    reset(f);
    readln(f, title);
    title:=StringReplace(title,';','',[rfReplaceAll]);
    while not EOF(f) do
    begin
      ReadLn(f, buf);
      SplitRec2(buf,';',r);
      if r.count<1 then continue;
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      obj := trim(copy(r[0], 1, objl));
      sra:='';sde:='';lbl:='';desc:='';
      if r.count>1 then sra := trim(r[1]);
      if r.count>2 then sde := trim(r[2]);
      if r.count>3 then lbl := trim(copy(r[3], 1, objl));
      if r.count>4 then desc:=trim(r[4]);
      StringGrid1.Cells[1, StringGrid1.RowCount - 1] := obj;
      ra := strtofloatdef(sra, -999);
      if ra < -900 then begin
        ra := Str3ToAR(sra);
        if ra > -900 then ra:= 15*ra;
      end;
      de := strtofloatdef(sde, -999);
      if de < -900 then begin
        de := Str3ToDE(sde);
      end;
      if ((ra < -900) or (de < -900)) and assigned(FGetObjectCoord) then
      begin
        FGetObjectCoord(obj, buf, ra, de);
        if ra < 0 then
        begin
          FGetObjectCoord(lbl, buf, ra, de);
          if ra < 0 then
          begin
            ra := -999;
            de := -999;
          end;
        end;
        if lbl='' then lbl:=buf;
      end;
      StringGrid1.Cells[7, StringGrid1.RowCount - 1] := lbl;
      if ra > -900 then
      begin
        buf := ARpToStr(ra/15,0);
        StringGrid1.Cells[2, StringGrid1.RowCount - 1] := buf;
        buf := DEToStr3(de);
        StringGrid1.Cells[3, StringGrid1.RowCount - 1] := buf;
      end
      else
      begin
        StringGrid1.Cells[2, StringGrid1.RowCount - 1] := '';
        StringGrid1.Cells[3, StringGrid1.RowCount - 1] := '';
      end;
      StringGrid1.Cells[4, StringGrid1.RowCount - 1] := '';
      StringGrid1.Cells[5, StringGrid1.RowCount - 1] := '';
      StringGrid1.Cells[6, StringGrid1.RowCount - 1] := desc;
    end;
    CloseFile(f);
    r.free;
    StringGrid1.Invalidate;
    edit1.Text := title;
    buf:=ChangeFileExt(fn,'.txt');
    SaveObsList(buf);
    FileNameEdit1.FileName:=buf;
    Refresh;
    Application.ProcessMessages;
    gridchanged := False;
  except
    on E: Exception do
    begin
      if Visible then
        ShowMessage('Error: ' + E.Message);
    end;
  end;
end;
end;

procedure Tf_obslist.LoadObsList;
var
  f: textfile;
  obj, sra, sde, lbl, desc, buf, buf1: string;
  ra, de: double;
begin
  if FileExistsUTF8(FileNameEdit1.FileName) then
  begin
    StringGrid1.RowCount := 1;
    gridchanged := False;
    try
      AssignFile(f, UTF8ToSys(FileNameEdit1.FileName));
      reset(f);
      readln(f, title);
      while not EOF(f) do
      begin
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
        readln(f, buf);
        obj := trim(copy(buf, 1, objl));
        Delete(buf, 1, objl);
        sra := trim(copy(buf, 1, radecl));
        Delete(buf, 1, radecl);
        sde := trim(copy(buf, 1, radecl));
        Delete(buf, 1, radecl);
        lbl := trim(copy(buf, 1, objl));
        Delete(buf, 1, objl);
        desc:=trim(buf);
        StringGrid1.Cells[1, StringGrid1.RowCount - 1] := obj;
        ra := strtofloatdef(sra, -999);
        de := strtofloatdef(sde, -999);
        if ((ra < -900) or (de < -900)) and assigned(FGetObjectCoord) then
        begin
          desc:=sra+sde+lbl+desc; // for observing list from other software that use this format
          FGetObjectCoord(obj, lbl, ra, de);
          if ra < 0 then
          begin
            ra := -999;
            de := -999;
          end;
        end;
        StringGrid1.Cells[7, StringGrid1.RowCount - 1] := lbl;
        if ra > -900 then
        begin
          buf1 := ARpToStr(ra/15,0);
          StringGrid1.Cells[2, StringGrid1.RowCount - 1] := buf1;
          buf1 := DEToStr3(de);
          StringGrid1.Cells[3, StringGrid1.RowCount - 1] := buf1;
        end
        else
        begin
          StringGrid1.Cells[2, StringGrid1.RowCount - 1] := '';
          StringGrid1.Cells[3, StringGrid1.RowCount - 1] := '';
        end;
        StringGrid1.Cells[4, StringGrid1.RowCount - 1] := '';
        StringGrid1.Cells[5, StringGrid1.RowCount - 1] := '';
        StringGrid1.Cells[6, StringGrid1.RowCount - 1] := desc;
      end;
      CloseFile(f);
      StringGrid1.Invalidate;
      edit1.Text := title;
      Refresh;
      Application.ProcessMessages;
      gridchanged := False;
    except
      on E: Exception do
      begin
        if Visible then
          ShowMessage('Error: ' + E.Message);
      end;
    end;
  end;
end;

procedure Tf_obslist.SaveObsList(fn: string);
var
  f: textfile;
  buf, bl: string;
  i: integer;
begin
  try
    bl := blank15 + blank15 + blank15;
    AssignFile(f, fn);
    Rewrite(f);
    writeln(f, edit1.Text);
    for i := 1 to StringGrid1.RowCount - 1 do
    begin
      buf := copy(StringGrid1.Cells[1, i] + bl, 1, objl);
      buf := buf + copy(FormatFloat(f5,Str3ToAR(trim(StringGrid1.Cells[2, i]))*15) + bl, 1, radecl);
      buf := buf + copy(FormatFloat(f5,Str3ToDE(trim(StringGrid1.Cells[3, i]))) + bl, 1, radecl);
      buf := buf + copy(StringGrid1.Cells[7, i] + bl, 1, objl);
      buf := buf + StringGrid1.Cells[6, i];
      writeln(f, buf);
    end;
    CloseFile(f);
    gridchanged := False;
  except
    on E: Exception do
    begin
      if Visible then
        ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

function Tf_obslist.GetObjcount: integer;
begin
  Result := StringGrid1.RowCount - 1;
end;

function Tf_obslist.GetRowcount: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 1 to StringGrid1.RowCount - 1 do
    if StringGrid1.RowHeights[i] > 0 then
      Inc(Result);
end;

procedure Tf_obslist.SelectRow(r: integer);
var
  ra, de: double;
begin
  StringGrid1.Row := r;
  FObjName := trim(StringGrid1.Cells[1, r]);
  ra := Str3ToAR(trim(StringGrid1.Cells[2, r]))*15;
  de := Str3ToDE(trim(StringGrid1.Cells[3, r]));
  if (ra >= 0) and assigned(FSelectObject) then
    FSelectObject(FObjName, ra, de);
  if (FObjName = rsTelescope) or (FObjName = rsCursor) then
    FObjName := trim(StringGrid1.Cells[7, r]);
end;

function Tf_obslist.FirstObj: boolean;
var
  i: integer;
  ok, ko: boolean;
begin
  i := 0;
  repeat
    Inc(i);
    ko := (i >= (StringGrid1.RowCount - 1));
    ok := StringGrid1.RowHeights[i] > 0;
  until ok or ko;
  if ok then
  begin
    StringGrid1.Row := i;
    SelectRow(StringGrid1.Row);
  end;
  Result := ok;
end;

function Tf_obslist.LastObj: boolean;
var
  i: integer;
  ok, ko: boolean;
begin
  i := StringGrid1.RowCount;
  repeat
    Dec(i);
    ko := (i <= 1);
    ok := StringGrid1.RowHeights[i] > 0;
  until ok or ko;
  if ok then
  begin
    StringGrid1.Row := i;
    SelectRow(StringGrid1.Row);
  end;
  Result := ok;
end;

function Tf_obslist.NextObj: boolean;
var
  ok, ko: boolean;
  oldpos, i: integer;
begin
  Result := False;
  ok := False;
  ko := False;
  i := StringGrid1.Row;
  oldpos := i;
  repeat
    Inc(i);
    ko := (i >= (StringGrid1.RowCount - 1));
    ok := StringGrid1.RowHeights[i] > 0;
  until ok or ko;
  if ok then
  begin
    StringGrid1.Row := i;
    SelectRow(StringGrid1.Row);
  end;
  Result := (oldpos <> StringGrid1.Row);
end;

function Tf_obslist.PrevObj: boolean;
var
  ok, ko: boolean;
  oldpos, i: integer;
begin
  Result := False;
  ok := False;
  ko := False;
  i := StringGrid1.Row;
  oldpos := i;
  repeat
    Dec(i);
    ko := (i <= 1);
    ok := StringGrid1.RowHeights[i] > 0;
  until ok or ko;
  if ok then
  begin
    StringGrid1.Row := i;
    SelectRow(StringGrid1.Row);
  end;
  Result := (oldpos <> StringGrid1.Row);
end;

procedure Tf_obslist.SetVisibleRows;
var
  ok: boolean;
  i: integer;
  cr1, cr2, t1, t2: double;
  astrom, nautm, civm, cive, naute, astroe: double;
begin
  cr1 := 0;
  cr2 := 0;
  if (limitairmass and LimitAirmassTonight.Checked) or
    (limittransit and LimitHourangleTonight.Checked) then
  begin
    planet.Twilight(cfgsc.jd0, cfgsc.ObsLatitude, cfgsc.ObsLongitude,
      astrom, nautm, civm, cive, naute, astroe);
    if abs(astrom) < 90 then
    begin
      cr1 := rmod(astroe + cfgsc.TimeZone + 24, 24);
      cr2 := rmod(astrom + cfgsc.TimeZone + 24, 24);
    end
    else if astrom > 0 then
    begin
      cr1 := -99;            // summer polar day, no "tonight"
      cr2 := -99;
    end
    else
    begin
      cr1 := 0;             // winter polar night, always "tonight"
      cr2 := 24;
    end;
  end;
  if (limitairmass and LimitAirmassNow.Checked) or (limittransit and
    LimitHourangleNow.Checked) then
  begin
    cr1 := cfgsc.CurTime;
    cr2 := cr1;
  end;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if (limitairmass and (LimitAirmassTonight.Checked or LimitAirmassNow.Checked)) or
      (limittransit and (LimitHourangleTonight.Checked or LimitHourangleNow.Checked)) then
    begin
      if cr1 < 0 then
        ok := False
      else
      begin
        ok := ((StringGrid1.Cells[4, i] <> rsNever) and (StringGrid1.Cells[4, i] <> 'N/A'));
        if ok and (StringGrid1.Cells[4, i] <> rsAlways) then
        begin
          t1 := StrToTim(StringGrid1.Cells[4, i], ':');
          t2 := StrToTim(StringGrid1.Cells[5, i], ':');
          if cr1 <= cr2 then
          begin
            if (t1 < t2) then
              ok := ((t1 >= cr1) and (t2 <= cr2)) or
                ((t1 <= cr1) and (t2 >= cr1)) or ((t1 <= cr2) and (t2 >= cr2))
            else
              ok := (t2 >= cr1) or (t1 <= cr2);
          end
          else
          begin
            if (t1 < t2) then
              ok := (t1 < cr2) or (t2 > cr1)
            else
              ok := True;
          end;
        end;
      end;
    end
    else
      ok := True;
    if ok then
      StringGrid1.RowHeights[i] := StringGrid1.DefaultRowHeight
    else
      StringGrid1.RowHeights[i] := 0;
  end;
  UpdateLabels(nil);
end;

procedure Tf_obslist.UpdateLabels(Sender: TObject;upd:boolean=true);
var
  i: integer;
  lbl: string;
  crd: TObsLabel;
begin
  for i := 0 to FObjLabels.Count - 1 do
    FObjLabels.Objects[i].Free;
  FObjLabels.Clear;
  FObjLabels.Sorted := False;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    if StringGrid1.RowHeights[i] > 0 then
    begin
      lbl := trim(wordspace(StringGrid1.Cells[7, i]));
      if (lbl <> '') then
      begin
        crd := TObsLabel.Create;
        crd.altlabel:=trim(StringGrid1.Cells[1, i]);
        crd.ra := Str3ToAR(trim(StringGrid1.Cells[2, i]))*15;
        crd.Dec := Str3ToDE(trim(StringGrid1.Cells[3, i]));
        FObjLabels.AddObject(lbl, crd);
      end;
    end;
  end;
  FObjLabels.Sorted := True;
  if upd and Assigned(FObjLabelChange) then
    FObjLabelChange(self);
end;

procedure Tf_obslist.ComputeLimits;
var
  i: integer;
begin
  case PageControl1.ActivePageIndex of
    0: ComputeAirmassTime;
    1: ComputeTransitTime;
    else
    begin
      for i := 1 to StringGrid1.RowCount - 1 do
      begin
        StringGrid1.Cells[4, i] := '';
        StringGrid1.Cells[5, i] := '';
      end;
    end;
  end;
end;

function Tf_obslist.UpdateCoord(arow: integer): boolean;
var
  buf, buf1, lbl: string;
  ra, de: double;
begin
  Result := False;
  buf := trim(StringGrid1.Cells[1, arow]);
  FGetObjectCoord(buf, lbl, ra, de);
  if ra >= 0 then
  begin
    buf1 := ARpToStr(ra/15,0);
    StringGrid1.Cells[2, arow] := buf1;
    buf1 := DEToStr3(de);
    StringGrid1.Cells[3, arow] := buf1;
    StringGrid1.Cells[7, arow] := lbl;
    Result := True;
  end;
end;

procedure Tf_obslist.Refresh(data:PtrInt=0);
begin
  ComputeLimits;
  SetVisibleRows;
end;

procedure Tf_obslist.ComputeAirmassTime;
var
  i: integer;
  ra, de, am: double;
  t1, t2: double;
begin
  limitairmass := True;
  limittransit := False;
  am := StrToFloatDef(trim(AirmassCombo.Text), -99);
  if am < 0 then
  begin
    Faltitude := -0.5;
    label2.Caption := rsAltitude + ': ' + rsHorizon;
  end
  else
  begin
    if am < 1 then
      am := 1;
    Faltitude := 90 - rad2deg * arccos(1 / am);
    label2.Caption := rsAltitude + ': ' + formatfloat('0', Faltitude) + ldeg;
  end;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    ra := Str3ToAR(trim(StringGrid1.Cells[2, i]))*15;
    de := Str3ToDE(trim(StringGrid1.Cells[3, i]));
    if ra >= 0 then
    begin
      ra := deg2rad * ra;
      de := deg2rad * de;
      Precession(jd2000, cfgsc.JDChart, ra, de);
      Time_Alt(cfgsc.jd0, ra, de, Faltitude, t1, t2, cfgsc.ObsLatitude, cfgsc.ObsLongitude);
      if abs(t1) < 90 then
        StringGrid1.Cells[4, i] := TimToStr(rmod(t1 + cfgsc.TimeZone + 24, 24), ':', False)
      else
      begin
        if t1 > 0 then
          StringGrid1.Cells[4, i] := rsAlways
        else
          StringGrid1.Cells[4, i] := rsNever;
      end;
      if abs(t2) < 90 then
        StringGrid1.Cells[5, i] := TimToStr(rmod(t2 + cfgsc.TimeZone + 24, 24), ':', False)
      else
      begin
        if t2 > 0 then
          StringGrid1.Cells[5, i] := rsAlways
        else
          StringGrid1.Cells[5, i] := rsNever;
      end;
    end
    else
    begin
      StringGrid1.Cells[4, i] := 'N/A';
      StringGrid1.Cells[5, i] := 'N/A';
    end;
  end;
end;

procedure Tf_obslist.ComputeTransitTime;
var
  i, irc: integer;
  ha, ra, de: double;
  hr, ht, hs, azr, azs: double;
begin
  limitairmass := False;
  limittransit := True;
  ha := StrToFloatDef(trim(HourAngleCombo.Text), -99);
  if ha < 0 then
    ha := 1;
  if ha > 12 then
    ha := 12;
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    ra := Str3ToAR(trim(StringGrid1.Cells[2, i]))*15;
    de := Str3ToDE(trim(StringGrid1.Cells[3, i]));
    if ra >= 0 then
    begin
      ra := deg2rad * ra;
      de := deg2rad * de;
      Precession(jd2000, cfgsc.JDChart, ra, de);
      RiseSet(cfgsc.jd0, ra, de, hr, ht, hs, azr, azs, irc, cfgsc);
      if irc = 2 then
      begin
        StringGrid1.Cells[4, i] := rsNever;
        StringGrid1.Cells[5, i] := rsNever;
      end
      else
      begin
        case MeridianSide of
          0:
          begin
            StringGrid1.Cells[4, i] := TimToStr(rmod(ht - ha + 24, 24), ':', False);
            StringGrid1.Cells[5, i] := TimToStr(rmod(ht + 24, 24), ':', False);
          end;
          1:
          begin
            StringGrid1.Cells[4, i] := TimToStr(rmod(ht - ha + 24, 24), ':', False);
            StringGrid1.Cells[5, i] := TimToStr(rmod(ht + ha + 24, 24), ':', False);
          end;
          2:
          begin
            StringGrid1.Cells[4, i] := TimToStr(rmod(ht + 24, 24), ':', False);
            StringGrid1.Cells[5, i] := TimToStr(rmod(ht + ha + 24, 24), ':', False);
          end;
        end;
      end;
    end
    else
    begin
      StringGrid1.Cells[4, i] := 'N/A';
      StringGrid1.Cells[5, i] := 'N/A';
    end;
  end;
end;

procedure Tf_obslist.FormCreate(Sender: TObject);
begin
  ScaleDPI(Self);
  FObjLabels := TStringList.Create;
  FEmptyObjLabels := TStringList.Create;
  FDefaultList := 'NewObsList.txt';
  locknewlist := False;
  locktogglebox := False;
  StringGrid1.AllowOutboundEvents := True;
  Newlist;
  gridchanged := False;
  {$ifdef lclcocoa}
    { TODO : check cocoa dark theme color}
    if DarkTheme then begin
      StringGrid1.FixedColor := clBackground;
    end;
  {$endif}
end;

procedure Tf_obslist.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  if gridchanged then
  begin
    if MessageDlg(Format(rsTheObserving, [FileNameEdit1.FileName]) + crlf + rsDoYouWantToS2,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      SaveObsList(FileNameEdit1.FileName);
  end;
  for i := 0 to FObjLabels.Count - 1 do
    FObjLabels.Objects[i].Free;
  FObjLabels.Free;
  FEmptyObjLabels.Free;
end;

procedure Tf_obslist.FormShow(Sender: TObject);
begin
  SetLang;
  Application.QueueAsyncCall(@Refresh,0);
end;

procedure Tf_obslist.UpdAllCoordClick(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to StringGrid1.RowCount - 1 do
  begin
    UpdateCoord(i);
  end;
  UpdateLabels(Sender);
  gridchanged := True;
  Refresh;
end;

procedure Tf_obslist.MenuUpdcoordClick(Sender: TObject);
begin
  if UpdateCoord(ClickRow) then
  begin
    UpdateLabels(Sender);
    gridchanged := True;
    Refresh;
  end;
end;

procedure Tf_obslist.MenuViewClick(Sender: TObject);
begin
  SelectRow(ClickRow);
end;

procedure Tf_obslist.MenuDeleteClick(Sender: TObject);
begin
  StringGrid1.DeleteRow(ClickRow);
  UpdateLabels(Sender);
  gridchanged := True;
end;

procedure Tf_obslist.PopupMenu1Popup(Sender: TObject);
begin
  MenuTitle.Caption := StringGrid1.Cells[1, ClickRow];
end;

procedure Tf_obslist.RadioGroup1Click(Sender: TObject);
begin
  if RadioButton1.Checked then
    FMeridianSide := 0
  else if RadioButton2.Checked then
    FMeridianSide := 1
  else if RadioButton3.Checked then
    FMeridianSide := 2;
  Refresh;
end;

procedure Tf_obslist.RefreshTimerTimer(Sender: TObject);
begin
  Refresh;
end;

procedure Tf_obslist.StringGrid1ColRowMoved(Sender: TObject;
  IsColumn: boolean; sIndex, tIndex: integer);
begin
  gridchanged := True;
end;

procedure Tf_obslist.StringGrid1CompareCells(Sender: TObject;
  ACol, ARow, BCol, BRow: integer; var Result: integer);
var
  b1, b2, p1, p2, buf, c: string;
  n1, n2: double;
  p, i1, i2: integer;

  procedure GetPrefix(str: string; var pref: string; var n: double; var i: integer);
  var
    j: integer;
  begin
    i := 1;
    n := 0;
    pref := '';
    buf := trim(str);
    p := pos(' ', buf);   // prefix separated by space
    if p = 0 then
    begin  // try to separate the numeric part
      for j := 1 to Length(buf) do
      begin
        c := copy(buf, j, 1);
        if (c >= '0') and (c <= '9') then
        begin
          p := j - 1;
          break;
        end;
      end;
    end;
    if p > 0 then
    begin  // first prefix
      pref := uppercase(trim(copy(buf, 1, p)));
      Delete(buf, 1, p);
      Val(trim(buf), n, i);
    end;
  end;

begin
  with Sender as TStringGrid do
  begin
    // cells content
    b1 := Cells[ACol, ARow];
    b2 := Cells[BCol, BRow];
    // Time value
    if (ACol = BCol) and ((ACol = 4) or (ACol = 5)) then
    begin
      i1 := pos(':', b1);
      i2 := pos(':', b2);
      if (i1 = 3) and (i2 = 3) and (length(b1) = 5) and (length(b2) = 5) then
      begin
        p1 := b1;
        Delete(p1, i1, 1);
        Val(trim(p1), n1, i1);
        p2 := b2;
        Delete(p2, i2, 1);
        Val(trim(p2), n2, i2);
        if (i1 = 0) and (i2 = 0) then
        begin
          if n1 < 1200 then
            n1 := n1 + 2400;
          if n2 < 1200 then
            n2 := n2 + 2400;
          if n1 > n2 then
            Result := 1
          else if n1 < n2 then
            Result := -1
          else
            Result := 0;
          if SortOrder = soDescending then
            Result := -Result;
          exit;
        end;
      end;
    end;
    // try numeric values
    Val(trim(b1), n1, i1);
    Val(trim(b2), n2, i2);
    if (i1 = 0) and (i2 = 0) then
    begin
      // numeric compare
      if n1 > n2 then
        Result := 1
      else if n1 < n2 then
        Result := -1
      else
        Result := 0;
    end
    else
    begin
      // try prefix + numeric
      GetPrefix(b1, p1, n1, i1);
      GetPrefix(b2, p2, n2, i2);
      if (i1 = 0) and (i2 = 0) and (p1 = p2) then
      begin
        // same prefix, numeric compare
        if n1 > n2 then
          Result := 1
        else if n1 < n2 then
          Result := -1
        else
          Result := 0;
      end
      else
      begin
        // case insensitive string compare
        Result := CompareText(b1, b2);
      end;
    end;
    if SortOrder = soDescending then
      Result := -Result;
  end;
end;

procedure Tf_obslist.SetMeridianSide(Value: integer);
begin
  FMeridianSide := Value;
  case FMeridianSide of
    0: RadioButton1.Checked := True;
    1: RadioButton2.Checked := True;
    2: RadioButton3.Checked := True;
    else
      RadioButton2.Checked := True;
  end;
end;

procedure Tf_obslist.SetLimitType(Value: integer);
begin
  PageControl1.ActivePageIndex := Value;
  locktogglebox := True;
  ToggleBox1.Checked := (PageControl1.ActivePageIndex = 0);
  ToggleBox2.Checked := not ToggleBox1.Checked;
  locktogglebox := False;
  Refresh;
end;

function Tf_obslist.GetLimitType: integer;
begin
  Result := PageControl1.ActivePageIndex;
end;

procedure Tf_obslist.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  StringGrid1.MouseToCell(X, Y, ClickCol, ClickRow);
end;

procedure Tf_obslist.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  aCol, aRow: integer;
begin
  StringGrid1.MouseToCell(X, Y, aCol, aRow);
  if (ClickCol = 0) and (aCol = ClickCol) and (aRow = ClickRow) then
    SelectRow(ClickRow);
end;

procedure Tf_obslist.StringGrid1ValidateEntry(Sender: TObject;
  aCol, aRow: integer; const OldValue: string; var NewValue: string);
var x: double;
begin
  if aCol=2 then begin
    x:=Str3ToAR(NewValue);
    if x=-9999 then
      NewValue:=OldValue
    else
      NewValue:=ARpToStr(x);
  end;
  if aCol=3 then begin
    x:=Str3ToDE(NewValue);
    if x=-9999 then
      NewValue:=OldValue
    else
      NewValue:=DEToStr3(x);
  end;
  if aCol in [0, 4, 5] then
    NewValue := OldValue
  else if OldValue <> NewValue then
  begin
    gridchanged := True;
    if (aCol = 1) and ((OldValue = rsTelescope) or (OldValue = rsCursor)) then
    begin
      StringGrid1.Cells[7, aRow] := NewValue;
      aCol := 7;
    end;
    if (aCol = 1) or (aCol = 7) then
      UpdateLabels(nil);
  end;
end;

procedure Tf_obslist.PageControl1Change(Sender: TObject);
begin
  locktogglebox := True;
  ToggleBox1.Checked := (PageControl1.ActivePageIndex = 0);
  ToggleBox2.Checked := not ToggleBox1.Checked;
  locktogglebox := False;
  Refresh;
end;

procedure Tf_obslist.ToggleBox1Click(Sender: TObject);
begin
  if locktogglebox then
    exit;
  locktogglebox := True;
  ToggleBox1.Checked := True;
  ToggleBox2.Checked := False;
  PageControl1.ActivePageIndex := 0;
  locktogglebox := False;
end;

procedure Tf_obslist.ToggleBox2Click(Sender: TObject);
begin
  if locktogglebox then
    exit;
  locktogglebox := True;
  ToggleBox1.Checked := False;
  ToggleBox2.Checked := True;
  PageControl1.ActivePageIndex := 1;
  locktogglebox := False;
end;

procedure Tf_obslist.ButtonLoadClick(Sender: TObject);
begin
  if locknewlist then
    exit;
  FileNameEdit1.InitialDir := ExtractFilePath(FileNameEdit1.FileName);
  if assigned(cfgsc) then
    LoadObsList;
end;

procedure Tf_obslist.ButtonSaveClick(Sender: TObject);
begin
  SaveObsList(FileNameEdit1.FileName);
end;

procedure Tf_obslist.AirmassComboChange(Sender: TObject);
var
  h: double;
  buf: string;
begin
  buf := trim(AirmassCombo.Text);
  if (buf = '') or (buf = '.') then
    exit;
  if buf <> rsHorizon then
  begin
    h := StrToFloatDef(buf, -99);
    if h = -99 then
    begin
      AirmassCombo.ItemIndex := -1;
      AirmassCombo.ItemIndex := 2;  // default 1.5
    end
    else if h > 15 then
    begin
      AirmassCombo.ItemIndex := -1;
      AirmassCombo.ItemIndex := 6; // horizon
    end;
  end;
  Refresh;
end;

procedure Tf_obslist.AllLabelsChange(Sender: TObject);
begin
  cfgsc.ObslistAlLabels := AllLabels.Checked;
  if Assigned(FObjLabelChange) then
    FObjLabelChange(self);
end;

procedure Tf_obslist.BtnLoadCSVClick(Sender: TObject);
var fn: string;
begin
  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := HomeDir;
  OpenDialog1.Filter:='csv file|*.csv|all|*.*';
  if OpenDialog1.Execute then begin
    fn:=OpenDialog1.FileName;
    LoadCSV(fn);
  end;
end;

procedure Tf_obslist.BtnImportMosaicClick(Sender: TObject);
var fn: string;
begin
  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := HomeDir;
  OpenDialog1.Filter:='mosaic file|*.cdcc|all|*.*';
  if OpenDialog1.Execute then begin
    fn:=OpenDialog1.FileName;
    ImportMosaic(fn);
  end;
end;

procedure Tf_obslist.BtnTourClick(Sender: TObject);
begin
  tour := Tf_tour.Create(self);
  tour.onFirst := @TourFirst;
  tour.onLast := @TourLast;
  tour.onPrev := @TourPrev;
  tour.onNext := @TourNext;
  tour.onSlew := @TourSlew;
  tour.TourName.Caption := Edit1.Text;
  tour.ObjectName.Caption := FObjName;
  Visible := False;
  tour.Show;
  while tour.Visible do
  begin
    sleep(100);
    Application.ProcessMessages;
  end;
  tour.Free;
  Visible := True;
end;

procedure Tf_obslist.Button1Click(Sender: TObject);
begin
  ShowHelp;
end;

procedure Tf_obslist.HourAngleComboChange(Sender: TObject);
var
  ha: double;
  buf: string;
begin
  buf := trim(HourAngleCombo.Text);
  if (buf = '') or (buf = '.') then
    exit;
  ha := StrToFloatDef(buf, -99);
  if ha < 0 then
  begin
    HourAngleCombo.ItemIndex := -1;
    HourAngleCombo.ItemIndex := 1;  // default 2.0
  end
  else if ha > 12 then
  begin
    HourAngleCombo.Text := '12.0';
  end;
  Refresh;
end;

procedure Tf_obslist.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tf_obslist.ButtonClearClick(Sender: TObject);
begin
  locknewlist := True;
  try
    Newlist;
  finally
    locknewlist := False;
  end;
end;

procedure Tf_obslist.Button5Click(Sender: TObject);
begin
  PrevObj;
end;

procedure Tf_obslist.Button6Click(Sender: TObject);
begin
  NextObj;
end;

procedure Tf_obslist.LimitAirmassTonightChange(Sender: TObject);
begin
  if LimitAirmassTonight.Checked then
    LimitAirmassNow.Checked := False;
  SetVisibleRows;
end;

procedure Tf_obslist.LimitAirmassNowChange(Sender: TObject);
begin
  if LimitAirmassNow.Checked then
    LimitAirmassTonight.Checked := False;
  RefreshTimer.Enabled := (LimitAirmassNow.Checked or LimitHourangleNow.Checked);
  SetVisibleRows;
end;

procedure Tf_obslist.NoFilterListChange(Sender: TObject);
begin
  UpdateLabels(Sender);
end;

procedure Tf_obslist.LimitHourangleTonightChange(Sender: TObject);
begin
  if LimitHourangleTonight.Checked then
    LimitHourangleNow.Checked := False;
  SetVisibleRows;
end;

procedure Tf_obslist.LimitHourangleNowChange(Sender: TObject);
begin
  if LimitHourangleNow.Checked then
    LimitHourangleTonight.Checked := False;
  RefreshTimer.Enabled := (LimitAirmassNow.Checked or LimitHourangleNow.Checked);
  SetVisibleRows;
end;

procedure Tf_obslist.TourFirst(Sender: TObject);
begin
  FirstObj;
  tour.ObjectName.Caption := FObjName;
end;

procedure Tf_obslist.TourLast(Sender: TObject);
begin
  LastObj;
  tour.ObjectName.Caption := FObjName;
end;

procedure Tf_obslist.TourPrev(Sender: TObject);
begin
  PrevObj;
  tour.ObjectName.Caption := FObjName;
end;

procedure Tf_obslist.TourNext(Sender: TObject);
begin
  NextObj;
  tour.ObjectName.Caption := FObjName;
end;

procedure Tf_obslist.TourSlew(Sender: TObject);
var
  ra, de: double;
  r: integer;
begin
  r := StringGrid1.Row;
  FObjName := trim(StringGrid1.Cells[1, r]);
  if (FObjName = rsTelescope) or (FObjName = rsCursor) then
    FObjName := trim(StringGrid1.Cells[7, r]);
  ra := Str3ToAR(trim(StringGrid1.Cells[2, r]))*15;
  de := Str3ToDE(trim(StringGrid1.Cells[3, r]));
  if (ra >= 0) and assigned(FSlew) then
    FSlew(FObjName, ra, de);
end;


end.
