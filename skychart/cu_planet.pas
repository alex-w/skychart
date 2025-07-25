unit cu_planet;

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
 Planet computation component.
}
{$mode objfpc}{$H+}
interface

uses
  passql, passqlite, uDE, cu_plansat, cu_calceph, calceph, LazFileUtils,
  u_translation, cu_database, u_constant, u_util, u_projection,
  Classes, SysUtils, Forms, Math;

type
  Tastelem = record
    Oaa, Obb, Occ, Oa, Ob, Oc, Ot, Oq, Oe, Oomi: double;     (* parametres de l'orbite   *)
    At, Am, Aa, Ah, Ag, equinox: double;
    AsterName: string;
  end;

type
  Tcomelem = record
    Oaa, Obb, Occ, Oa, Ob, Oc, equinox, Ot, Oq, Oe, Oomi, Oh, Og: double;
    CometName: string;
  end;

type
  bool20 = array[1..20] of boolean;

type
  TPlanet = class(TComponent)
  private
    { Private declarations }
    db1, db2: TSqlDB;
    LockPla, LockDB: boolean;
    SolT0, XSol, YSol, ZSol: double;
    BaryT0, XBary, YBary, ZBary: double;
    AstSol: array of array[0..3] of double;
    jdnew, jdaststart, jdastend, jdaststep, jdchart, com_limitmag: double;
    ast_daypos, com_daypos: string;
    Feph_method: string;
    searchid: string;
    CurrentStep, CurrentPlanet, n_com, n_ast, jdastnstep: integer;
    CurrentAstStep, CurrentAsteroid: integer;
    CurrentComStep, CurrentComet: integer;
    CurrentBodyStep, CurrentBody: integer;
    astelem: Tastelem;
    comelem: Tcomelem;
  protected
    { Protected declarations }
  public
    { Public declarations }
    cdb: TCdcDb;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetDE(folder1,folder2: string);
    function load_de(t: double): boolean;
    function ComputePlanet(cfgsc: Tconf_skychart): boolean;
    procedure FindNumPla(id: integer;
      var ar, de: double; var ok: boolean; cfgsc: Tconf_skychart; MeanPos: boolean = False);
    function FindPlanetName(planetname: string; var ra, de: double;
      cfgsc: Tconf_skychart; MeanPos: boolean = False): boolean;
    function FindPlanet(x1, y1, x2, y2: double; nextobj: boolean;
      cfgsc: Tconf_skychart; var nom, ma, date, desc: string; trunc: boolean = True; searchcenter: boolean = False): boolean;
    procedure FormatPlanet(St, Pl: integer; cfgsc: Tconf_skychart;
      var nom, ma, date, desc: string);
    procedure Plan(ipla: integer; t: double; var p: TPlanData);
    procedure Planet(ipla: integer; t0: double;
      var alpha, delta, distance, illum, phase, diameter, magn, dp, xp, yp, zp, vel, lighttime: double);
    procedure Barycenter(t0: double; var x, y, z: double);
    procedure SunRect(t0: double; var x, y, z: double);
    procedure Sun(t0: double; var alpha, delta, dist, diam: double);
    procedure SunEcl(t0: double; var l, b: double);
    procedure PlanSat(isat: integer; jde: double; c:Tconf_skychart; var alpha, delta, distance: double;
      var supconj: boolean; var eph: string);
    function CalcephSatOne(jdtt: double; isat: integer; out x, y, z: double; out segid: string):integer;
    function CalcephSat(jdtt: double; pla,num: integer; out xt, yt, zt: double20):integer;
    function SpiceSatOne(jdtt: double; isat: integer; out x, y, z: double; out segid: string):integer;
    function SpiceSat(jdtt: double; pla,num: integer; out xt, yt, zt: double20):integer;
    function MarSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart; var xsat, ysat: double20;
      var supconj: bool20): integer;
    function JupSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
      var xsat, ysat: double20; var supconj: bool20): integer;
    function SatSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
      var xsat, ysat: double20; var supconj: array of boolean): integer;
    function UraSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
      var xsat, ysat: double20; var supconj: array of boolean): integer;
    function NepSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
      var xsat, ysat: double20; var supconj: array of boolean): integer;
    function PluSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart; var xsat, ysat: double20;
      var supconj: array of boolean): integer;
    function MarsSolarLongitude(jde: double): double;
    procedure SatRing(jde: double; var P, a, b, be: double);
    function JupGRS(lon, drift, jdref, jdnow: double): double;
    procedure Moon(t0: double; var alpha, delta, dist, dkm, diam, phase, illum: double;c:Tconf_skychart);
    procedure MoonIncl(Lar, Lde, Sar, Sde: double; var incl: double);
    function MoonMag(phase: double): double;
    procedure PlanetOrientation(jde: double; ipla: integer;
      var P, De, Ds, w1, w2, w3: double);
    procedure MoonOrientation(jde, ra, Dec, d: double; var P, llat, lats, llong: double);
    function Body(jdt: double; target: integer; var ra, de, dist, r: double): boolean;
    procedure ComputeBodies(cfgsc: Tconf_skychart);
    procedure FindBodyIndex(bname: string; cfgsc: Tconf_skychart; out idx:integer);
    function FindBody(x1, y1, x2, y2: double; nextobj: boolean;cfgsc: Tconf_skychart; var nom, mag, date, desc: string; trunc: boolean = True): boolean;
    function FindBodyName(bname: string; var ra, de, mag: double;cfgsc: Tconf_skychart; upddb: boolean; MeanPos: boolean = False): boolean;
    procedure ComputeAsteroid(cfgsc: Tconf_skychart);
    procedure ComputeComet(cfgsc: Tconf_skychart);
    procedure OrbRect(jd: double; var xc, yc, zc, rs: double);
    procedure InitComet(tp, q, ec, ap, an, ic, mh, mg, eq: double; nam: string);
    procedure Comet(jd: double; lightcor: boolean;
      var ar, de, dist, r, elong, phase, magn, diam, lc, car, cde, rc, xc, yc, zc: double);
    procedure InitAsteroid(epoch, mh, mg, ma, ap, an, ic, ec, sa, eq: double; nam: string);
    procedure Asteroid(jd: double; highprec: boolean;
      var ar, de, dist, r, elong, phase, magn, xc, yc, zc: double);
    function AsteroidMag(phase,dist,r,h,g: double): double; inline; overload;
    function AsteroidMag(phase,dist,r,h,g1,g2: double): double; overload;
    function ConnectDB(db: string): boolean;
    function NewAstDay(newjd, limitmag: double; cfgsc: Tconf_skychart): boolean;
    function FindAsteroid(x1, y1, x2, y2: double; nextobj: boolean;
      cfgsc: Tconf_skychart; var nom, mag, date, desc: string; trunc: boolean = True): boolean;
    procedure FindAsteroidIndex(astname: string; out idx:integer);
    function FindAsteroidName(astname: string; var ra, de, mag: double; cfgsc: Tconf_skychart; upddb: boolean; MeanPos: boolean = False): boolean;
    function PrepareAsteroid(jd1, jd2, step: double; msg: TStrings): boolean;
    function NewComDay(newjd, limitmag: double; cfgsc: Tconf_skychart): boolean;
    procedure NewComDayCallback(Sender: TObject; Row: TResultRow);
    function FindComet(x1, y1, x2, y2: double; nextobj: boolean;
      cfgsc: Tconf_skychart; var nom, mag, date, desc: string; trunc: boolean = True): boolean;
    procedure FindCometId(comname: string; out id: string);
    function FindCometName(comname: string; var ra, de, mag: double;
      cfgsc: Tconf_skychart; upddb: boolean; MeanPos: boolean = False): boolean;
    procedure PlanetRiseSet(pla: integer; jd0: double; AzNorth: boolean;
      var thr, tht, ths, tazr, tazs: string; var jdr, jdt, jds, rar, der, rat, det, ras, des: double;
      var i: integer; cfgsc: Tconf_skychart);
    procedure PlanetAltitude(pla: integer; jd0, hh: double; cfgsc: Tconf_skychart;
      var har, sina: double);
    procedure Twilight(jd0, obslat, obslon: double;
      out astrom, nautm, civm, cive, naute, astroe: double);
    procedure nutation(j: double; var nutl, nuto: double);
    procedure aberration(j: double; var abv, ehn: coordvector;
      var ab1, abe, abp, gr2e: double; var abm, asl: boolean);
    procedure ObjectMotion(otype,oname: string; ElemEpoch,cjd,cst: double; c:Tconf_skychart; out dist,pa,dx,dy: double);
    property eph_method: string read Feph_method;
  end;

implementation

constructor TPlanet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  lockpla := False;
  lockdb := False;
  Feph_method := '';
  searchid := '';
  de_type := 0;
  de_jdcheck := MaxInt;
  de_jdstart := MaxInt;
  de_jdend := -MaxInt;
  db1 := TLiteDB.Create(self);
  db2 := TLiteDB.Create(self);
end;

destructor TPlanet.Destroy;
begin
  try
    db1.Free;
    db2.Free;
    if de_created then
      close_de_file;
    inherited Destroy;
  except
    writetrace('error destroy ' + Name);
  end;
end;

procedure TPlanet.Plan(ipla: integer; t: double; var p: TPlanData);
var
  v2: Array_5D;
  pl: TPlanetData;
  x, y, z, qr: double;
begin
  if load_de(t) then
  begin    // use jpl DE-
    Calc_Planet_de(t, ipla, v2, True, 12, False);
    p.x := v2[0];
    p.y := v2[1];
    p.z := v2[2];
    // rotate equatorial to ecliptic
    x := p.x;
    y := coseps2k * p.y + sineps2k * p.z;
    z := -sineps2k * p.y + coseps2k * p.z;
    // convert to polar
    p.r := sqrt(x * x + y * y + z * z);
    p.l := arctan2(y, x);
    if (p.l < 0) then
      p.l := p.l + 2 * pi;
    qr := sqrt(x * x + y * y);
    if qr <> 0 then
      p.b := arctan(z / qr);
    Feph_method := 'DE' + IntToStr(de_type);
  end
  else if (Plan404<>nil) and (t > jdmin404) and (t < jdmax404) then
  begin               // use Plan404
    pl.ipla := ipla;
    pl.JD := t;
    Plan404(addr(pl));
    p.x := pl.x;
    p.y := pl.y;
    p.z := pl.z;
    p.l := pl.l;
    p.b := pl.b;
    p.r := pl.r;
    Feph_method := 'plan404';
  end
  else
  begin
    p.x := 0;
    p.y := 0;
    p.z := 0;
    p.l := 0;
    p.b := 0;
    p.r := 0;
    Feph_method := '';
  end;
end;

procedure TPlanet.Planet(ipla: integer; t0: double;
  var alpha, delta, distance, illum, phase, diameter, magn, dp, xp, yp, zp, vel, lighttime: double);
const
  sa: array[1..9] of double =
    (0.38709893, 0.72333199, 1.00000011, 1.52366231, 5.20336301, 9.53707032,
    19.19126393, 30.06896348, 39.48168677);
  s0: array[1..9] of double = (3.34, 8.41, 0, 4.68, 98.47, 83.33, 34.28, 36.56, 1.57);
  V0: array[1..9] of double = (-0.42, -4.40, 0, -1.52, -9.40, -8.88, -7.19, -6.87, -1.0);

var
  v1: double6;
  w: array[1..3] of double;
  t: double;
  pl: TPlanData;
  lt, rt, dt, lp, rp, lsol, pha, qr, xt, yt, zt: double;
begin
  if (ipla < 1) or (ipla = 3) or (ipla > 9) then
    exit;
  // always do this computation for phase sign
  // Earth position
  Plan(3, t0, pl);
  lt := pl.l;
  rt := pl.r;
  v1[1] := -pl.x;
  v1[2] := -pl.y;
  v1[3] := -pl.z;
  dt := rt;
  // planet position
  Plan(ipla, t0, pl);
  lp := pl.l;
  rp := pl.r;
  dp := rp;
  // get distance for light time correction
  xt := pl.x + v1[1];
  yt := pl.y + v1[2];
  zt := pl.z + v1[3];
  distance := sqrt(xt * xt + yt * yt + zt * zt);
  // planet using light correction
  lighttime := distance * tlight;
  t := t0 - lighttime;
  Plan(ipla, t, pl);
  // get light corrected distance
  dp := pl.r;
  xt := pl.x + v1[1];
  yt := pl.y + v1[2];
  zt := pl.z + v1[3];
  distance := sqrt(xt * xt + yt * yt + zt * zt);

  // equatorial coord
  w[1] := pl.x + v1[1];
  w[2] := pl.y + v1[2];
  w[3] := pl.z + v1[3];
  alpha := arctan2(w[2], w[1]);
  if (alpha < 0) then
    alpha := alpha + 2 * pi;
  qr := sqrt(w[1] * w[1] + w[2] * w[2]);
  if qr <> 0 then
    delta := arctan(w[3] / qr);
  // rectangular coord
  xp := pl.x;
  yp := pl.y;
  zp := pl.z;
  // velocity
  vel := 42.1219 * sqrt(1 / dp - 1 / (2 * sa[ipla]));
{
  illuminated fraction
  correct the phase sign with the difference of longitude with the sun.
}
  qr := (2 * dp * distance);
  if qr <> 0 then
    phase := (dp * dp + distance * distance - dt * dt) / qr //=cos(phase)
  else
    phase := 1;
  if abs(phase) > 1 then
    phase := sgn(phase);
  illum := (1 + phase) / 2;
  phase := radtodeg(arccos(phase));
  // lt and lp must be computed!
  lsol := rmod(pi4 + pi + lt, pi2); // be sure to obtain a positive value
  lp := rmod(lp + pi2, pi2);
  lp := rmod(lsol - lp + pi2, pi2);
  if (lp > 0) and (lp <= pi) then
    phase := -phase;
{
  apparent diameter
}
  if distance <> 0 then
    diameter := 2 * s0[ipla] / distance;
{
  magnitude
}
  magn := V0[ipla] + 5 * log10(dp * distance); {meeus91 40. }
  pha := abs(phase);
  case ipla of
    1: magn := magn + pha * (0.0380 + pha * (-0.000273 + pha * 2e-6));
    2: magn := magn + pha * (0.0009 + pha * (0.000239 - pha * 6.5e-7));
    4: magn := magn + 0.016 * pha;
    5: magn := magn + 0.005 * pha;
    6: magn := magn + 0.044 * pha;
  end;
end;

procedure TPlanet.SunRect(t0: double; var x, y, z: double);
var
  p: TPlanetData;
  planet_arr: Array_5D;
  i: integer;
begin
  if (t0 = SolT0) then
  begin
    x := XSol;
    y := YSol;
    z := ZSol;
  end
  else
  begin
    if load_de(t0) then
    begin    // use jpl DE-
      Calc_Planet_de(t0, 11, planet_arr, True, 3, False);
      x := planet_arr[0];
      y := planet_arr[1];
      z := planet_arr[2];
      Feph_method := 'DE' + IntToStr(de_type);
    end
    else if (Plan404<>nil) and (t0 > jdmin404) and (t0 < jdmax404) then
    begin    // use Plan404
      p.ipla := 3;
      p.JD := t0;
      i := Plan404(addr(p));
      if (i <> 0) then
        exit;
      x := -p.x;
      y := -p.y;
      z := -p.z;
      Feph_method := 'plan404';
    end
    else
    begin
      x := 0;
      y := 0;
      z := 0;
      Feph_method := '';
    end;
    // save result for repetitive call
    SolT0 := t0;
    XSol := x;
    YSol := y;
    ZSol := z;
  end;
end;

procedure TPlanet.Barycenter(t0: double; var x, y, z: double);
var
  p: TPlanetData;
  planet_arr: Array_5D;
  i: integer;
begin
  if (t0 = BaryT0) then
  begin
    x := XBary;
    y := YBary;
    z := ZBary;
  end
  else
  begin
    if load_de(t0) then
    begin    // use jpl DE-
      Calc_Planet_de(t0, 12, planet_arr, True, 3, False);
      x := planet_arr[0];
      y := planet_arr[1];
      z := planet_arr[2];
      Feph_method := 'DE' + IntToStr(de_type);
    end
    else if (Plan404<>nil) and (t0 > jdmin404) and (t0 < jdmax404) then
    begin    // use Plan404
      p.ipla := 3;
      p.JD := t0;
      i := Plan404(addr(p));
      if (i <> 0) then
        exit;
      x := -p.x;
      y := -p.y;
      z := -p.z;
      Feph_method := 'plan404';
    end
    else
    begin
      x := 0;
      y := 0;
      z := 0;
      Feph_method := '';
    end;
    // save result for repetitive call
    BaryT0 := t0;
    XBary := x;
    YBary := y;
    ZBary := z;
  end;
end;

procedure TPlanet.Sun(t0: double; var alpha, delta, dist, diam: double);
var
  x, y, z, qr: double;
begin
  SunRect(t0, x, y, z);
  dist := sqrt(x * x + y * y + z * z);
  alpha := arctan2(y, x);
  if (alpha < 0) then
    alpha := alpha + pi2;
  qr := sqrt(x * x + y * y);
  if qr <> 0 then
    delta := arctan(z / qr);
  if dist <> 0 then
    diam := 2 * 959.63 / dist;
end;

procedure TPlanet.SunEcl(t0: double; var l, b: double);
var
  x1, y1, z1, x, y, z, qr: double;
begin
  SunRect(t0, x1, y1, z1);
  // rotate equatorial to ecliptic
  x := x1;
  y := coseps2k * y1 + sineps2k * z1;
  z := -sineps2k * y1 + coseps2k * z1;
  // convert to polar
  l := arctan2(y, x);
  if (l < 0) then
    l := l + 2 * pi;
  qr := sqrt(x * x + y * y);
  if qr <> 0 then
    b := arctan(z / qr);
end;

function to360(x: double): double;
begin
  Result := rmod(x + 3600000000, 360);
end;

procedure TPlanet.PlanSat(isat: integer; jde: double; c:Tconf_skychart; var alpha, delta, distance: double;
  var supconj: boolean; var eph: string);
var
  ipl, ix: integer;
  pra, pdec, dist, illum, phase, diam, magn, rp, xp, yp, zp, vel: double;
  satx, saty, satz, xs, ys, zs, x, y, z, d1, d2, qr, lighttime: double;
begin
  case isat of
    12..15:
    begin
      ipl := 5;
      ix := isat - 11;
    end;
    16..23:
    begin
      ipl := 6;
      ix := isat - 15;
    end;
    24..28:
    begin
      ipl := 7;
      ix := isat - 23;
    end;
    29..30:
    begin
      ipl := 4;
      ix := isat - 28;
    end;
    33:
    begin
      ipl := 6;
      ix := 9;
    end;
    34..35:
    begin
      ipl := 8;
      ix := isat - 33;
    end;
    36:
    begin
      ipl := 9;
      ix := 1;
    end;
    37..40:
    begin
      ipl := 5;
      ix := isat - 36 + 4;
    end;
    41..50:
    begin
      ipl := 6;
      ix := isat - 40 + 9;
    end;
    51..63:
    begin
      ipl := 7;
      ix := isat - 50 + 5;
    end;
    64..69:
    begin
      ipl := 8;
      ix := isat - 63 + 2;
    end;
    70..77:
    begin
      ipl := 6;
      ix := 0;
    end;
    else
    begin
      ipl := 0;
      ix := 0;
    end;
  end;
  if ipl <> 0 then
  begin
    Planet(ipl, jde, pra, pdec, dist, illum, phase, diam, magn, rp, xp, yp, zp, vel, lighttime);
    Barycenter(jde, xs, ys, zs);
    x := xp + xs;
    y := yp + ys;
    z := zp + zs;
    d1 := sqrt(x * x + y * y + z * z);
    if c.CalcephActive then begin
      CalcephSatOne(jde, isat, x, y, z, eph);
    end
    else if c.SpiceActive then begin
      SpiceSatOne(jde, isat, x, y, z, eph);
    end
    else begin
      case ipl of
        4: MarSatOne(jde - lighttime, ix, satx, saty, satz);
        5: JupSatOne(jde - lighttime, ix, satx, saty, satz);
        6: SatSatOne(jde - lighttime, ix, satx, saty, satz);
        7: UraSatOne(jde - lighttime, ix, satx, saty, satz);
        8: NepSatOne(jde - lighttime, ix, satx, saty, satz);
        9: PluSatOne(jde - lighttime, ix, satx, saty, satz);
      end;
      x := x + satx;
      y := y + saty;
      z := z + satz;
      eph := '';
    end;
    d2 := sqrt(x * x + y * y + z * z);
    alpha := arctan2(y, x);
    if (alpha < 0) then
      alpha := alpha + 2 * pi;
    qr := sqrt(x * x + y * y);
    if qr <> 0 then
      delta := arctan(z / qr);
    supconj := (d2 > d1);
    distance := d2;
  end;
end;

function TPlanet.CalcephSatOne(jdtt: double; isat: integer; out x, y, z: double; out segid: string):integer;
var
  pv: TDoubleArray;
  target,obs: integer;
begin
  try
  obs := 399;                // geocentric
  target:=naif[isat];
  if CalcephComputeSat(jdtt,target,obs,pv) then begin
    x := pv[0] / km_au;
    y := pv[1] / km_au;
    z := pv[2] / km_au;
    segid:=trim(spicesegid[isat]);
    result:=0;
  end
  else begin
    WriteTrace(cu_calceph.LastError);
    x := 0;
    y := 0;
    z := 0;
    segid:='';
    result:=1;
  end;
  except
    result:=1;
  end;
end;

function TPlanet.CalcephSat(jdtt: double; pla,num: integer; out xt, yt, zt: double20):integer;
var
  i: integer;
  pv: TDoubleArray;
  target,obs: integer;
begin
  try
  result:=0;
  for i := 1 to num do
  begin
    obs := 399;                // geocentric
    target:=spicebody[pla,i];
    if CalcephComputeSat(jdtt,target,obs,pv) then begin
      xt[i] := pv[0] / km_au;
      yt[i] := pv[1] / km_au;
      zt[i] := pv[2] / km_au;
    end
    else begin
      WriteTrace(cu_calceph.LastError);
      xt[i] := 0;
      yt[i] := 0;
      zt[i] := 0;
      if i<8 then result:=1;
    end;
  end;
  except
    result:=1;
  end;
end;

function TPlanet.SpiceSatOne(jdtt: double; isat: integer; out x, y, z: double; out segid: string):integer;
var
  data: TcdcSpice;
  msg: array[0..1024] of char;
  pmsg: PChar;
begin
  try
  pmsg:=@msg;
  result:=0;
  data.et := (jdtt-jd2000)*86400; // second since J2000
  data.obs := 399;                // geocentric
  data.target:=naif[isat];
  SpiceComputepos(data);
  if data.err<>0 then begin
    SpiceGetlongerror(pmsg);
    WriteTrace(msg);
    x := 0;
    y := 0;
    z := 0;
    segid:='';
    result:=1;
  end;
  x := data.x / km_au;
  y := data.y / km_au;
  z := data.z / km_au;
  segid:=trim(data.segid);
  except
    result:=1;
  end;
end;

function TPlanet.SpiceSat(jdtt: double; pla,num: integer; out xt, yt, zt: double20):integer;
var
  i: integer;
  data: TcdcSpice;
  msg: array[0..1024] of char;
  pmsg: PChar;
begin
  try
  pmsg:=@msg;
  result:=0;
  for i := 1 to num do
  begin
    data.et := (jdtt-jd2000)*86400; // second since J2000
    data.obs := 399;                // geocentric
    data.target:=spicebody[pla,i];
    SpiceComputepos(data);
    if data.err<>0 then begin
      SpiceGetlongerror(pmsg);
      WriteTrace(msg);
      xt[i] := 0;
      yt[i] := 0;
      zt[i] := 0;
      result:=1;
    end;
    xt[i] := data.x / km_au;
    yt[i] := data.y / km_au;
    zt[i] := data.z / km_au;
  end;
  except
    result:=1;
  end;
end;

function TPlanet.MarSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart; var xsat, ysat: double20;
  var supconj: bool20): integer;
var
  i,n: integer;
  xs, ys, zs, x, y, z, alpha, delta, qr, d1, d2: double;
  xst, yst, zst, xt, yt, zt: double20;
begin
  n:=2;
  Barycenter(jde, xs, ys, zs);
  x := xp + xs;
  y := yp + ys;
  z := zp + zs;
  d1 := sqrt(x * x + y * y + z * z);
  if c.CalcephActive then begin
    Result:=CalcephSat(jde,4,n,xt,yt,zt);
  end
  else if c.SpiceActive then
  begin
    Result:=SpiceSat(jde,4,n,xt,yt,zt);
  end
  else
  begin
    Result := MarSatAll(jde - lighttime, xst, yst, zst);
    if Result = 0 then
    begin
      for i := 1 to n do
      begin
        xt[i] := xp + xst[i] + xs;
        yt[i] := yp + yst[i] + ys;
        zt[i] := zp + zst[i] + zs;
      end;
    end;
  end;
  if Result=0 then
  begin
    for i := 1 to n do
    begin
      d2 := sqrt(xt[i] * xt[i] + yt[i] * yt[i] + zt[i] * zt[i]);
      alpha := arctan2(yt[i], xt[i]);
      if (alpha < 0) then
        alpha := alpha + 2 * pi;
      qr := sqrt(xt[i] * xt[i] + yt[i] * yt[i]);
      if qr <> 0 then
        delta := arctan(zt[i] / qr)
      else
        delta := 0;
      xsat[i] := alpha;
      ysat[i] := delta;
      supconj[i] := (d2 > d1);
    end;
  end;
end;

function TPlanet.JupSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
  var xsat, ysat: double20; var supconj: bool20): integer;
var
  i, n: integer;
  xs, ys, zs, x, y, z, alpha, delta, qr, d1, d2: double;
  xst, yst, zst, xt, yt, zt: double20;
begin
  if c.SmallSatActive then begin
    if c.CalcephActive or c.SpiceActive then
      n := 16
    else
      n := 8;
  end
  else
    n := 4;
  Barycenter(jde, xs, ys, zs);
  x := xp + xs;
  y := yp + ys;
  z := zp + zs;
  d1 := sqrt(x * x + y * y + z * z);
  if c.CalcephActive then begin
    Result:=CalcephSat(jde,5,n,xt,yt,zt);
  end
  else if c.SpiceActive then
  begin
    Result:=SpiceSat(jde,5,n,xt,yt,zt);
  end
  else
  begin
    Result := JupSatAll(jde - lighttime, c.SmallSatActive, xst, yst, zst);
    if Result = 0 then
    begin
      for i := 1 to n do
      begin
        xt[i] := xp + xst[i] + xs;
        yt[i] := yp + yst[i] + ys;
        zt[i] := zp + zst[i] + zs;
      end;
    end;
  end;
  if Result=0 then
  begin
    for i := 1 to n do
    begin
      d2 := sqrt(xt[i] * xt[i] + yt[i] * yt[i] + zt[i] * zt[i]);
      alpha := arctan2(yt[i], xt[i]);
      if (alpha < 0) then
        alpha := alpha + 2 * pi;
      qr := sqrt(xt[i] * xt[i] + yt[i] * yt[i]);
      if qr <> 0 then
        delta := arctan(zt[i] / qr)
      else
        delta := 0;
      xsat[i] := alpha;
      ysat[i] := delta;
      supconj[i] := (d2 > d1);
    end;
  end;
end;


function TPlanet.SatSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
  var xsat, ysat: double20; var supconj: array of boolean): integer;
var
  i, n: integer;
  xs, ys, zs, x, y, z, alpha, delta, qr, d1, d2: double;
  xst, yst, zst, xt, yt, zt: double20;
begin
  if c.SmallSatActive then
    n := 19
  else
    n := 9;
  Barycenter(jde, xs, ys, zs);
  x := xp + xs;
  y := yp + ys;
  z := zp + zs;
  d1 := sqrt(x * x + y * y + z * z);
  if c.CalcephActive then begin
    Result:=CalcephSat(jde,6,n,xt,yt,zt);
  end
  else if c.SpiceActive then
  begin
    Result:=SpiceSat(jde,6,n,xt,yt,zt);
  end
  else
  begin
    Result := SatSatAll(jde - lighttime, c.SmallSatActive, xst, yst, zst);
    if Result = 0 then
    begin
      for i := 1 to n do
      begin
        xt[i] := xp + xst[i] + xs;
        yt[i] := yp + yst[i] + ys;
        zt[i] := zp + zst[i] + zs;
      end;
    end;
  end;
  if Result=0 then
  begin
    for i := 1 to n do
    begin
      d2 := sqrt(xt[i] * xt[i] + yt[i] * yt[i] + zt[i] * zt[i]);
      alpha := arctan2(yt[i], xt[i]);
      if (alpha < 0) then
        alpha := alpha + 2 * pi;
      qr := sqrt(xt[i] * xt[i] + yt[i] * yt[i]);
      if qr <> 0 then
        delta := arctan(zt[i] / qr)
      else
        delta := 0;
      xsat[i] := alpha;
      ysat[i] := delta;
      supconj[i] := (d2 > d1);
    end;
  end;
end;

function TPlanet.UraSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
  var xsat, ysat: double20; var supconj: array of boolean): integer;
var
  i, n: integer;
  xs, ys, zs, x, y, z, alpha, delta, qr, d1, d2: double;
  xst, yst, zst, xt, yt, zt: double20;
begin
  if c.SmallSatActive then
    n := 18
  else
    n := 5;
  Barycenter(jde, xs, ys, zs);
  x := xp + xs;
  y := yp + ys;
  z := zp + zs;
  d1 := sqrt(x * x + y * y + z * z);
  if c.CalcephActive then begin
    Result:=CalcephSat(jde,7,n,xt,yt,zt);
  end
  else if c.SpiceActive then
  begin
    Result:=SpiceSat(jde,7,n,xt,yt,zt);
  end
  else
  begin
    Result := UraSatAll(jde - lighttime, c.SmallSatActive, xst, yst, zst);
    if Result = 0 then
    begin
      for i := 1 to n do
      begin
        xt[i] := xp + xst[i] + xs;
        yt[i] := yp + yst[i] + ys;
        zt[i] := zp + zst[i] + zs;
      end;
    end;
  end;
  if Result=0 then
  begin
    for i := 1 to n do
    begin
      d2 := sqrt(xt[i] * xt[i] + yt[i] * yt[i] + zt[i] * zt[i]);
      alpha := arctan2(yt[i], xt[i]);
      if (alpha < 0) then
        alpha := alpha + 2 * pi;
      qr := sqrt(xt[i] * xt[i] + yt[i] * yt[i]);
      if qr <> 0 then
        delta := arctan(zt[i] / qr)
      else
        delta := 0;
      xsat[i] := alpha;
      ysat[i] := delta;
      supconj[i] := (d2 > d1);
    end;
  end;
end;

function TPlanet.NepSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart;
  var xsat, ysat: double20; var supconj: array of boolean): integer;
var
  i, n: integer;
  xs, ys, zs, x, y, z, alpha, delta, qr, d1, d2: double;
  xst, yst, zst, xt, yt, zt: double20;
begin
  if c.SmallSatActive then
    n := 8
  else
    n := 2;
  Barycenter(jde, xs, ys, zs);
  x := xp + xs;
  y := yp + ys;
  z := zp + zs;
  d1 := sqrt(x * x + y * y + z * z);
  if c.CalcephActive then begin
    Result:=CalcephSat(jde,8,n,xt,yt,zt);
  end
  else if c.SpiceActive then
  begin
    Result:=SpiceSat(jde,8,n,xt,yt,zt);
  end
  else
  begin
    Result := NepSatAll(jde - lighttime, c.SmallSatActive, xst, yst, zst);
    if Result = 0 then
    begin
      for i := 1 to n do
      begin
        xt[i] := xp + xst[i] + xs;
        yt[i] := yp + yst[i] + ys;
        zt[i] := zp + zst[i] + zs;
      end;
    end;
  end;
  if Result=0 then
  begin
    for i := 1 to n do
    begin
      d2 := sqrt(xt[i] * xt[i] + yt[i] * yt[i] + zt[i] * zt[i]);
      alpha := arctan2(yt[i], xt[i]);
      if (alpha < 0) then
        alpha := alpha + 2 * pi;
      qr := sqrt(xt[i] * xt[i] + yt[i] * yt[i]);
      if qr <> 0 then
        delta := arctan(zt[i] / qr)
      else
        delta := 0;
      xsat[i] := alpha;
      ysat[i] := delta;
      supconj[i] := (d2 > d1);
    end;
  end;
end;

function TPlanet.PluSat(jde, lighttime, xp, yp, zp: double; c:Tconf_skychart; var xsat, ysat: double20;
  var supconj: array of boolean): integer;
var
  i,n: integer;
  xs, ys, zs, x, y, z, alpha, delta, qr, d1, d2: double;
  xst, yst, zst, xt, yt, zt: double20;
begin
  n:=1;
  Barycenter(jde, xs, ys, zs);
  x := xp + xs;
  y := yp + ys;
  z := zp + zs;
  d1 := sqrt(x * x + y * y + z * z);
  if c.CalcephActive then begin
    Result:=CalcephSat(jde,9,n,xt,yt,zt);
  end
  else if c.SpiceActive then
  begin
    Result:=SpiceSat(jde,9,n,xt,yt,zt);
  end
  else
  begin
    Result := PluSatAll(jde - lighttime, xst, yst, zst);
    if Result = 0 then
    begin
      for i := 1 to n do
      begin
        xt[i] := xp + xst[i] + xs;
        yt[i] := yp + yst[i] + ys;
        zt[i] := zp + zst[i] + zs;
      end;
    end;
  end;
  if Result=0 then
  begin
    for i := 1 to n do
    begin
      d2 := sqrt(xt[i] * xt[i] + yt[i] * yt[i] + zt[i] * zt[i]);
      alpha := arctan2(yt[i], xt[i]);
      if (alpha < 0) then
        alpha := alpha + 2 * pi;
      qr := sqrt(xt[i] * xt[i] + yt[i] * yt[i]);
      if qr <> 0 then
        delta := arctan(zt[i] / qr)
      else
        delta := 0;
      xsat[i] := alpha;
      ysat[i] := delta;
      supconj[i] := (d2 > d1);
    end;
  end;
end;

procedure TPlanet.PlanetOrientation(jde: double; ipla: integer;
  var P, De, Ds, w1, w2, w3: double);
// Report of the IAU Working Group on Cartographic
// Coordinates and Rotational Elements: 2009
// + 2011 Erratum
const
  VP: array[1..15, 1..4] of double = (
    (281.0097, -0.0328, 61.4143, -0.0049), //mercure
    (272.76, 0, 67.16, 0),             //venus
    (0, -0.641, 90, -0.557),           //earth
    (317.68143, -0.1061, 52.88650, -0.0609), //mars
    (268.056595, -0.006499, 64.495303, 0.002413), //jupiter
    (40.589, -0.036, 83.537, -0.004),  //saturn
    (257.311, 0, -15.175, 0),          //uranus
    (299.36, 0.70, 43.46, -0.51),      //neptune !
    (132.993, 0, -6.163, 0),           //pluto
    (286.13, 0, 63.87, 0),             //sun
    (0, 0, 0, 0),                      //moon not computed here
    (268.05, -0.009, 64.50, 0.003),    //Io
    (268.08, -0.009, 64.51, 0.003),    //Europa
    (268.20, -0.009, 64.57, 0.003),    //Ganymede
    (268.72, -0.009, 64.83, 0.003));   //Callisto
  W: array[1..15, 1..2] of double = (
    (329.5469, 6.1385025),
    (160.20, -1.4813688),
    (190.147, 360.9856235),
    (176.630, 350.89198226),
    (67.1, 877.90003539),   //System I
    (227.2037, 844.3),      //System I
    (203.81, -501.1600928),
    (253.18, 536.3128492),
    (302.695, 56.3625225),
    (84.176, 14.1844000),  //sun
    (0, 0),                //moon not computed here
    (200.39, 203.4889538), //Io
    (36.022, 101.3747235), //Europa
    (44.064, 50.3176081),  //Ganymede
    (259.51, 21.5710715)); //Callisto
var
  d, T, N, a0, d0, l0, b0, r0, l1, b1, r1, x, y, z, del, eps, als, des, u, v, al, dl, f, th, k, i: double;
  M1, M2, M3, M4, M5, Ja, Jb, Jc, Jd, Je,{J1,J2,}J3, J4, J5, J6, J7, J8: double;
  pl: TPlanData;
begin
  d := (jde - jd2000);
  T := d / 36525;
  if ipla = 10 then
  begin  // sun
    th := (jde - 2398220) * 360 / 25.38;
    i := deg2rad * 7.25;
    k := deg2rad * (73.6667 + 1.3958333 * (jde - 2396758) / 36525);
    Plan(3, jde, pl);
    PrecessionEcl(jd2000, jde, pl.l, pl.b);
    l0 := pl.l + pi;
    eps := deg2rad * (23.439291111 - 0.0130042 * T - 1.64e-7 * T * T + 5.036e-7 * T * T * T);
    x := arctan(-cos(l0) * tan(eps));
    y := arctan(-cos(l0 - k) * tan(i));
    P := rad2deg * (x + y);
    De := rad2deg * (arcsin(sin(l0 - k) * sin(i)));
    n := arctan2(-sin(l0 - k) * cos(i), -cos(l0 - k));
    w1 := to360(rad2deg * n - th);
  end
  else
  begin
    if ipla = 8 then
      N := cos(deg2rad * (357.85 + 52.316 * T))   // Neptune
    else
      N := T;
    // coordinates of the pole
    d0 := deg2rad * (VP[ipla, 3] + VP[ipla, 4] * N);
    if ipla = 8 then
      N := sin(deg2rad * (357.85 + 52.316 * T))
    else
      N := T;
    a0 := deg2rad * (VP[ipla, 1] + VP[ipla, 2] * N);
    if ipla = 5 then
    begin                        //jupiter
      Ja := deg2rad * (99.360714 + 4850.4046 * T);
      Jb := deg2rad * (175.895369 + 1191.9605 * T);
      Jc := deg2rad * (300.323162 + 262.5475 * T);
      Jd := deg2rad * (114.012305 + 6070.2476 * T);
      Je := deg2rad * (49.511251 + 64.3000 * T);
      a0 := a0 + 0.000117 * sin(Ja) + 0.000938 * sin(Jb) + 0.001432 * sin(Jc) + 0.000030 *
        sin(Jd) + 0.002150 * sin(Je);
      d0 := d0 + 0.000050 * cos(Ja) + 0.000404 * cos(Jb) + 0.000617 * cos(Jc) - 0.000013 *
        cos(Jd) + 0.000926 * cos(Je);
    end;
    if (ipla >= 12) and (ipla <= 15) then
    begin
      // only need for Amalthea and Thebe
{  J1:=deg2rad*(73.32+91472.9*T);
  J2:=deg2rad*(24.62+45137.2*T); }
      J3 := deg2rad * (283.90 + 4850.7 * T);
      J4 := deg2rad * (355.80 + 1191.3 * T);
      J5 := deg2rad * (119.90 + 262.1 * T);
      J6 := deg2rad * (229.80 + 64.3 * T);
      J7 := deg2rad * (352.25 + 2382.6 * T);
      J8 := deg2rad * (113.35 + 6070.0 * T);
    end
    else
    begin
      J3 := 0;
      J4 := 0;
      J5 := 0;
      J6 := 0;
      J7 := 0;
      J8 := 0;
    end;
    if ipla = 12 then
    begin    // Io
      a0 := a0 + 0.094 * sin(J3) + 0.024 * sin(J4);
      d0 := d0 + 0.040 * cos(J3) + 0.011 * cos(J4);
    end;
    if ipla = 13 then
    begin    // Europa
      a0 := a0 + 1.086 * sin(J4) + 0.060 * sin(J5) + 0.015 * sin(J6) + 0.009 * sin(J7);
      d0 := d0 + 0.468 * cos(J4) + 0.026 * cos(J5) + 0.007 * cos(J6) + 0.002 * cos(J7);
    end;
    if ipla = 14 then
    begin    // Ganymede
      a0 := a0 - 0.037 * sin(J4) + 0.431 * sin(J5) + 0.091 * sin(J6);
      d0 := d0 - 0.016 * cos(J4) + 0.186 * cos(J5) + 0.039 * cos(J6);
    end;
    if ipla = 15 then
    begin    // Callisto
      a0 := a0 - 0.068 * sin(J5) + 0.590 * sin(J6) + 0.010 * sin(J8);
      d0 := d0 - 0.029 * cos(J5) + 0.254 * cos(J6) - 0.004 * cos(J8);
    end;
    precession(jd2000, jde, a0, d0);
    // rotation
    w1 := W[ipla, 1] + W[ipla, 2] * d;
    if ipla = 1 then
    begin
      M1 := deg2rad * (174.791086 + 4.092335 * d);
      M2 := deg2rad * (349.582171 + 8.184670 * d);
      M3 := deg2rad * (164.373257 + 12.277005 * d);
      M4 := deg2rad * (339.164343 + 16.369340 * d);
      M5 := deg2rad * (153.955429 + 20.461675 * d);
      w1 := w1 + 0.00993822 * sin(M1) - 0.00104581 * sin(M2) - 0.00010280 * sin(M3) -
        0.00002364 * sin(M4) - 0.00000532 * sin(M5);
    end;
    if ipla = 8 then
      w1 := w1 - 0.48 * N;  // N=sin(..)
    if ipla = 5 then
    begin
      w2 := 43.3 + 870.27003539 * d;
      w3 := 284.95 + 870.5360000 * d;
    end
    else if ipla = 6 then
    begin
      w2 := 105.4857 + 812.0 * d;
      w3 := 38.90 + 810.7939024 * d;
    end
    else
    begin
      w2 := -999;
      w3 := -999;
    end;
    if ipla = 12 then
    begin    // Io
      w1 := w1 - 0.085 * sin(J3) - 0.022 * sin(J4);
    end;
    if ipla = 13 then
    begin    // Europa
      w1 := w1 - 0.980 * sin(J4) - 0.054 * sin(J5) - 0.014 * sin(J6) - 0.008 * sin(J7);
    end;
    if ipla = 14 then
    begin    // Ganymede
      w1 := w1 + 0.033 * sin(J4) - 0.389 * sin(J5) - 0.082 * sin(J6);
    end;
    if ipla = 15 then
    begin    // Callisto
      w1 := w1 + 0.061 * sin(J5) - 0.533 * sin(J6) - 0.009 * sin(J8);
    end;
    // view from Earth
    Plan(3, jde, pl);
    PrecessionEcl(jd2000, jde, pl.l, pl.b);
    l0 := pl.l;
    b0 := pl.b;
    r0 := pl.r;
    Plan(CentralPlanet[ipla], jde, pl);
    PrecessionEcl(jd2000, jde, pl.l, pl.b);
    l1 := pl.l;
    b1 := pl.b;
    r1 := pl.r;
    x := r1 * cos(b1) * cos(l1) - r0 * cos(l0);
    y := r1 * cos(b1) * sin(l1) - r0 * sin(l0);
    z := r1 * sin(b1) - r0 * sin(b0);
    del := sqrt(x * x + y * y + z * z);
    Plan(CentralPlanet[ipla], jde - del * tlight, pl);
    PrecessionEcl(jd2000, jde, pl.l, pl.b);
    l1 := pl.l;
    b1 := pl.b;
    r1 := pl.r;
    x := r1 * cos(b1) * cos(l1) - r0 * cos(l0);
    y := r1 * cos(b1) * sin(l1) - r0 * sin(l0);
    z := r1 * sin(b1) - r0 * sin(b0);
    del := sqrt(x * x + y * y + z * z);
    eps := deg2rad * (23.439291111 - 0.0130042 * T - 1.64e-7 * T * T + 5.036e-7 * T * T * T);
    als := arctan2(cos(eps) * sin(l1) - sin(eps) * tan(b1), cos(l1));
    des := arcsin(cos(eps) * sin(b1) + sin(eps) * cos(b1) * sin(l1));
    Ds := rad2deg * (arcsin(-sin(d0) * sin(des) - cos(d0) * cos(des) * cos(a0 - als)));
    u := y * cos(eps) - z * sin(eps);
    v := y * sin(eps) + z * cos(eps);
    al := arctan2(u, x);
    dl := arctan(v / sqrt(x * x + u * u));
    f := rad2deg * (arctan2(sin(d0) * cos(dl) * cos(a0 - al) - sin(dl) * cos(d0), cos(dl) * sin(a0 - al)));
    De := rad2deg * (arcsin(-sin(d0) * sin(dl) - cos(d0) * cos(dl) * cos(a0 - al)));
    w1 := to360((w1 - f - del * tlight * W[ipla, 2]) * sgn(W[ipla, 2]));
    if ipla = 5 then
    begin
      w2 := to360(w2 - f - del * tlight * 870.27003539);
      w3 := to360(w3 - f - del * tlight * 870.5360000);
    end;
    if ipla = 6 then
    begin
      w2 := to360(w2 - f - del * tlight * 812.0);
      w3 := to360(w3 - f - del * tlight * 810.7939024);
    end;
    P := to360(rad2deg * (arctan2(cos(d0) * sin(a0 - al), sin(d0) * cos(dl) - cos(d0) *
      sin(dl) * cos(a0 - al))));
  end;
end;

procedure TPlanet.MoonOrientation(jde, ra, Dec, d: double; var P, llat, lats, llong: double);
var
  lp, l, b, f, om, w, T, a, i, lh, bh, e, v, x, y, l0 {,cel,sel,asol,dsol}: double;
  pl: TPlanData;
begin
{ P: position angle  (degree)
  llat: libration latitude (degree)
  llong: libration longitude  (degree)
  lats:  sun inclination (degree) }
  T := (jde - 2451545) / 36525;
  e := deg2rad * 23.4392911;
  eq2ecl(ra, Dec, e, lp, b);
  // libration
  F := 93.2720993 + 483202.0175273 * t - 0.0034029 * t * t - t * t * t / 3526000 + t * t * t * t / 863310000;
  om := 125.0445550 - 1934.1361849 * t + 0.0020762 * t * t + t * t * t / 467410 - t * t * t * t / 60616000;
  w := lp - deg2rad * om;
  i := deg2rad * 1.54242;
  l := lp;
  a := rad2deg * (arctan2(sin(w) * cos(b) * cos(i) - sin(b) * sin(i), cos(w) * cos(b)));
  llong := to360(a - F);
  if llong > 180 then
    llong := llong - 360;
  llat := arcsin(-sin(w) * cos(b) * sin(i) - sin(b) * cos(i));
  // position
  Plan(3, jde - tlight, pl);
  PrecessionEcl(jd2000, jde, pl.l, pl.b);
  l0 := rad2deg * (pl.l) - 180;
  lh := l0 + 180 + (d / pl.r) * rad2deg * cos(b) * sin(pl.l - pi - l);
  bh := (d / pl.r) * pl.b;
  w := deg2rad * (lh - om);
  lats := rad2deg * (arcsin(-sin(w) * cos(bh) * sin(i) - sin(bh) * cos(i)));
  v := deg2rad * (om);
  x := sin(i) * sin(v);
  y := sin(i) * cos(v) * cos(e) - cos(i) * sin(e);
  w := arctan2(x, y);
  P := rad2deg * (arcsin(sqrt(x * x + y * y) * cos(ra - w) / cos(llat)));
  llat := rad2deg * (llat);
end;

function TPlanet.MarsSolarLongitude(jde: double): double;
var t, M, LS: double;
const jdmin=2308004.5; // 1607/1/1
      jdmax=2504138.5; // 2143/12/31
begin
  // Ref: Enumeration of Mars years and seasons since the beginning of telescopic exploration
  // https://doi.org/10.1016/j.icarus.2014.12.014
  // valid from 1607 to 2143.
  // Simplified relation (8) and (9) , +/- 0.05°
  if (jde>=jdmin) and (jde<=jdmax) then begin
    t := jde - jd2000;
    M := deg2rad * (19.38095 + 0.524020769 * t);
    LS := 270.38859 + 0.524038542 * t + 10.67848 * sin(M) + 0.62077 * sin(2*M ) + 0.05031 * sin(3*M);
    LS := rmod(LS,360.0);
    LS := rmod(LS+360.0,360.0);
    result := LS;
  end
  else begin
    result := NullCoord;
  end;
end;

function TPlanet.JupGRS(lon, drift, jdref, jdnow: double): double;
begin
  Result := rmod(360000 + lon + (jdnow - jdref) * drift, 360);
end;

procedure TPlanet.SatRing(jde: double; var P, a, b, be: double);
var
  T, i, om, l0, b0, r0, l1, b1, r1, x, y, z, del, lam, bet, sinB, eps, ceps, seps, lam0,
  bet0, al, de, al0, de0, j: double;
  pl: TPlanData;
begin
  { meeus 44. }
  T := (jde - 2451545) / 36525;
  i := 28.075216 - 0.012998 * T + 0.000004 * T * T;
  om := 169.508470 + 1.394681 * T + 0.000412 * T * T;
  j := jde - 9 * 0.0057755183; // aprox. light time
  Plan(3, j, pl);
  l0 := pl.l;
  b0 := pl.b;
  r0 := pl.r;
  Plan(6, j, pl);
  l1 := pl.l;
  b1 := pl.b;
  r1 := pl.r;
  x := r1 * cos(b1) * cos(l1) - r0 * cos(l0);
  y := r1 * cos(b1) * sin(l1) - r0 * sin(l0);
  z := r1 * sin(b1) - r0 * sin(b0);
  del := sqrt(x * x + y * y + z * z);
  lam := radtodeg(arctan2(y, x));
  bet := radtodeg(arctan(z / sqrt(x * x + y * y)));
  sinB := sin(degtorad(i)) * cos(degtorad(bet)) * sin(degtorad(lam - om)) -
    cos(degtorad(i)) * sin(degtorad(bet));
  be := radtodeg(arcsin(sinB));
  a := 375.35 / del;
  b := a * abs(sinB);
  eps := 23.439291111 - 0.0130042 * T - 1.64e-7 * T * T + 5.036e-7 * T * T * T;
  ceps := cos(degtorad(eps));
  seps := sin(degtorad(eps));
  lam0 := degtorad(om - 90);
  bet0 := degtorad(90 - i);
  lam := degtorad(lam);
  bet := degtorad(bet);
  al := (arctan2(ceps * sin(lam) - seps * tan(bet), cos(lam)));
  de := (arcsin(ceps * sin(bet) + seps * cos(bet) * sin(lam)));
  al0 := (arctan2(ceps * sin(lam0) - seps * tan(bet0), cos(lam0)));
  de0 := (arcsin(ceps * sin(bet0) + seps * cos(bet0) * sin(lam0)));
  P := to360(90 + radtodeg(arctan2(cos(de0) * sin(al0 - al), sin(de0) * cos(de) -
    cos(de0) * sin(de) * cos(al0 - al))));
end;

function TPlanet.MoonMag(phase: double): double;
  // The following table of lunar magnitudes is derived from relative
  // intensities in Table 1 of M. Minnaert (1961),
  // Phase  Frac.            Phase  Frac.            Phase  Frac.
  // angle  ill.   Mag       angle  ill.   Mag       angle  ill.   Mag
  //  0    1.00  -12.7        60   0.75  -11.0       120   0.25  -8.7
  // 10    0.99  -12.4        70   0.67  -10.8       130   0.18  -8.2
  // 20    0.97  -12.1        80   0.59  -10.4       140   0.12  -7.6
  // 30    0.93  -11.8        90   0.50  -10.0       150   0.07  -6.7
  // 40    0.88  -11.5       100   0.41   -9.6       160   0.03  -3.4
  // 50    0.82  -11.2       110   0.33   -9.2
const
  mma: array[0..18] of double = (-12.7, -12.4, -12.1, -11.8, -11.5, -11.2,
    -11.0, -10.8, -10.4, -10.0, -9.6, -9.2,
    -8.7, -8.2, -7.6, -6.7, -3.4, 0, 0);
var
  i, j, k, p: integer;
begin
  p := (round(phase) + 360) mod 360;
  if p > 180 then
    p := 360 - p;
  i := p div 10;
  k := p - 10 * i;
  j := minintvalue([18, i + 1]);
  Result := mma[i] + ((mma[j] - mma[i]) * k / 10);
end;

procedure TPlanet.Moon(t0: double; var alpha, delta, dist, dkm, diam, phase, illum: double;c:Tconf_skychart);
{
  t0      :  julian date DT
  alpha   :  Moon RA J2000
        delta   :  Moon DEC J2000
  dist    :  Earth-Moon distance UA
  dkm     :  Earth-Moon distance Km
  diam    :  Apparent diameter (arcseconds)
  phase   :  Phase angle  (degree)
  illum  :  Illuminated percentage
}
var
  p: TPlanetData;
  q: double;
  t, sm, mm, md: double;
  w: array[1..3] of double;
  planet_arr, sun_arr: Array_5D;
  i: integer;
  pp: double;
begin
  if load_de(t0) then
  begin
    Barycenter(t0, sun_arr[0], sun_arr[1], sun_arr[2]);
    Calc_Planet_de(t0, 10, planet_arr, True, 3, False);
    dist := sqrt(planet_arr[0] * planet_arr[0] + planet_arr[1] * planet_arr[1] + planet_arr[2] * planet_arr[2]);
    t0 := t0 - tlight * dist;
    Calc_Planet_de(t0, 10, planet_arr, True, 12, False);
    for i := 0 to 2 do
      w[i + 1] := planet_arr[i] + sun_arr[i];
    alpha := arctan2(w[2], w[1]);
    if (alpha < 0) then
      alpha := alpha + 2 * pi;
    pp := sqrt(w[1] * w[1] + w[2] * w[2]);
    delta := arctan(w[3] / pp);
    dkm := dist * km_au;
    Feph_method := 'DE' + IntToStr(de_type);
  end
  else if (Plan404<>nil) and (t0 > jdmin404) and (t0 < jdmax404) then
  begin  // use plan404
    t0 := t0 - (1.27 / 3600 / 24); // mean lighttime
    p.JD := t0;
    p.ipla := 11;
    Plan404(addr(p));
    dist := sqrt(p.x * p.x + p.y * p.y + p.z * p.z);
    alpha := arctan2(p.y, p.x);
    if (alpha < 0) then
      alpha := alpha + pi2;
    q := sqrt(p.x * p.x + p.y * p.y);
    delta := arctan(p.z / q);
    // revert aberration to move position to solar system barycenter as with jpl eph
    mean_equatorial(alpha,delta,c,true,false,false);
    // plan404 give equinox of the date for the moon.
    precession(t0, jd2000, alpha, delta);
    dkm := dist * km_au;
    Feph_method := 'plan404';
  end
  else
  begin
    Feph_method := '';
    exit;
  end;
  diam := 2 * 358482800 / dkm;
  t := (t0 - 2415020) / 36525;  { meeus 15.1 }
  sm := degtorad(358.475833 + 35999.0498 * t - 0.000150 * t * t - 0.0000033 * t * t * t);  {meeus 30. }
  mm := degtorad(296.104608 + 477198.8491 * t + 0.009192 * t * t + 0.0000144 * t * t * t);
  md := rmod(350.737486 + 445267.1142 * t - 0.001436 * t * t + 0.0000019 * t * t * t, 360);
  phase := 180 - md;     { meeus 31.4 }
  md := degtorad(md);
  phase := rmod(phase - 6.289 * sin(mm) + 2.100 * sin(sm) - 1.274 * sin(2 * md - mm) -
    0.658 * sin(2 * md) - 0.214 * sin(2 * mm) - 0.112 * sin(md) + 360, 360);
  illum := (1 + cos(degtorad(phase))) / 2;
end;

procedure TPlanet.MoonIncl(Lar, Lde, Sar, Sde: double; var incl: double);
{
  Lar  :  Moon RA
  Lde  :  Moon Dec
  Sar  :  Sun RA
  Sde  :  Sun Dec

  incl :  Position angle of the bright limb.
}
begin
  {meeus 46.5 }
  incl := arctan2(cos(Sde) * sin(Sar - Lar), cos(Lde) * sin(Sde) - sin(Lde) * cos(Sde) * cos(Sar - Lar));
end;

function TPlanet.ComputePlanet(cfgsc: Tconf_skychart): boolean;
var
  ar, de, dist, illum, phase, diam, jdt, magn, st0, dkm, q, P, a, b, be, dp, sb, pha, xp, yp, zp, vel,lightime: double;
  ipla, k, j, i, ierr: integer;
  satx, saty: double20;
  supconj: bool20;
  ars, des: double;
begin
  Result := True;
  try
    while lockpla do
    begin
      sleep(10);
      application.ProcessMessages;
    end;
    lockpla := True;
    cfgsc.CalcephActive:=CalcephBaseOk  and (cfgsc.CurYear >= SpiceFirstYear) and (cfgsc.CurYear <= SpiceLastYear);
    cfgsc.SpiceActive:=(not cfgsc.CalcephActive) and SpiceBaseOk and (cfgsc.CurYear >= SpiceFirstYear) and (cfgsc.CurYear <= SpiceLastYear);
    if cfgsc.CalcephActive
    then
      cfgsc.SmallSatActive := cfgsc.ShowSmallsat and CalcephExtOk
    else if cfgsc.SpiceActive
    then
      cfgsc.SmallSatActive := cfgsc.ShowSmallsat and SpiceExtOk
    else
      cfgsc.SmallSatActive := cfgsc.ShowSmallsat and (cfgsc.CurYear > 1900) and (cfgsc.CurYear < 2050);
    cfgsc.SimNb := min(cfgsc.SimNb, MaxPlSim);
    for j := 0 to cfgsc.SimNb - 1 do
    begin
      jdt := cfgsc.CurJDTT + j * cfgsc.SimD + j * cfgsc.SimH / 24 + j * cfgsc.SimM / 60 / 24 + j * cfgsc.SimS / 3600 / 24;
      st0 := Rmod(cfgsc.CurST + 1.00273790935 *
        (j * cfgsc.SimD * 24 + j * cfgsc.SimH + j * cfgsc.SimM / 60 + j * cfgsc.SimS / 3600) * 15 * deg2rad, pi2);
      // Sun first
      ipla := 10;
      Sun(jdt, ar, de, dist, diam);
      if dist = 0 then
      begin    // problem with the ephemeris, disable planet display
        Result := False;
        exit;
      end;
      cfgsc.PlanetLst[j, ipla, 8] := NormRA(ar); //J2000
      cfgsc.PlanetLst[j, ipla, 9] := de;
      cfgsc.PlanetLst[j, ipla, 10] := dist;
      cfgsc.PlanetLst[j, 32, 8] := rmod(ar + pi, pi2);
      cfgsc.PlanetLst[j, 32, 9] := -de;
      if eph_method = '' then
        exit;
      precession(jd2000, cfgsc.JDChart, ar, de);     // equinox require for the chart
      cfgsc.PlanetLst[j, 32, 1] := rmod(ar + pi, pi2);   // use geocentrique position for earth umbra
      cfgsc.PlanetLst[j, 32, 2] := -de;
      cfgsc.PlanetLst[j, 32, 3] := dist;
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(st0, dist, ar, de, ar, de, q, cfgsc);
        diam := diam / q;
        dist := dist * q;
      end;
      if cfgsc.ApparentPos then
        apparent_equatorial(ar, de, cfgsc, True, False);
      ar := rmod(ar, pi2);
      cfgsc.PlanetLst[j, ipla, 1] := ar;
      cfgsc.PlanetLst[j, ipla, 2] := de;
      cfgsc.PlanetLst[j, ipla, 3] := jdt;
      cfgsc.PlanetLst[j, ipla, 4] := diam;
      cfgsc.PlanetLst[j, ipla, 5] := -26;
      cfgsc.PlanetLst[j, ipla, 6] := dist;
      cfgsc.PlanetLst[j, ipla, 7] := 0;        //phase
      if j = 0 then
      begin
        Eq2HZ(cfgsc.CurST - ar, de, a, cfgsc.curSunH, cfgsc);
      end;
      for ipla := 1 to 9 do
      begin
        if ipla = 3 then
          continue;
        Planet(ipla, jdt, ar, de, dist, illum, phase, diam, magn, dp, xp, yp, zp, vel,lightime);
        cfgsc.PlanetLst[j, ipla, 8] := NormRA(ar); //J2000
        cfgsc.PlanetLst[j, ipla, 9] := de;
        cfgsc.PlanetLst[j, ipla, 10] := dist;
        precession(jd2000, cfgsc.JDChart, ar, de);     // equinox require for the chart
        if cfgsc.PlanetParalaxe then
        begin
          Paralaxe(st0, dist, ar, de, ar, de, q, cfgsc);
          diam := diam / q;
          dist := dist * q;
        end;
        if cfgsc.ApparentPos then
          apparent_equatorial(ar, de, cfgsc, True, False);
        ar := rmod(ar, pi2);
        cfgsc.PlanetLst[j, ipla, 1] := ar;
        cfgsc.PlanetLst[j, ipla, 2] := de;
        cfgsc.PlanetLst[j, ipla, 3] := jdt;
        cfgsc.PlanetLst[j, ipla, 4] := diam;
        cfgsc.PlanetLst[j, ipla, 5] := magn;
        cfgsc.PlanetLst[j, ipla, 6] := dist;
        cfgsc.PlanetLst[j, ipla, 7] := phase;
        pha := abs(phase);
        if ipla = 4 then
        begin
          ierr := Marsat(jdt, dist * tlight, xp, yp, zp, cfgsc, satx, saty, supconj);
          if ierr > 0 then
            for i := 1 to 2 do
              cfgsc.PlanetLst[j, i + 28, 6] := 99
          else
            for i := 1 to 2 do
            begin
              ars := satx[i];
              des := saty[i];
              cfgsc.PlanetLst[j, i + 28, 8] := NormRA(ars); //J2000
              cfgsc.PlanetLst[j, i + 28, 9] := des;
              cfgsc.PlanetLst[j, i + 28, 10] := cfgsc.PlanetLst[j, ipla, 10];
              precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
              if cfgsc.PlanetParalaxe then
              begin
                Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
              end;
              if cfgsc.ApparentPos then
                apparent_equatorial(ars, des, cfgsc, True, False);
              ars := rmod(ars, pi2);
              cfgsc.PlanetLst[j, i + 28, 1] := ars;
              cfgsc.PlanetLst[j, i + 28, 2] := des;
              cfgsc.PlanetLst[j, i + 28, 3] := jdt;
              cfgsc.PlanetLst[j, i + 28, 4] := rad2deg * (2 * D0mar[i] / km_au / dist) * 3600;
              cfgsc.PlanetLst[j, i + 28, 5] := V0mar[i] + 5 * log10(dp * dist) + pha *
                (0.0380 + pha * (-0.000273 + pha * 2e-6));
              if supconj[i] then
                cfgsc.PlanetLst[j, i + 28, 6] := 10
              else
                cfgsc.PlanetLst[j, i + 28, 6] := 0;
            end;
        end;
        if ipla = 5 then
        begin
          ierr := jupsat(jdt, dist * tlight, xp, yp, zp, cfgsc, satx, saty, supconj);
          if ierr > 0 then
          begin
            for i := 1 to 4 do
              cfgsc.PlanetLst[j, i + 11, 6] := 99;
            if cfgsc.SmallSatActive then begin
              for i := 1 to 4 do
                cfgsc.PlanetLst[j, i + 36, 6] := 99;
              for i := 1 to 8 do
                cfgsc.PlanetLst[j, i + 69, 6] := 99;
            end;
          end
          else
          begin
            for i := 1 to 4 do
            begin
              ars := satx[i];
              des := saty[i];
              cfgsc.PlanetLst[j, i + 11, 8] := NormRA(ars); //J2000
              cfgsc.PlanetLst[j, i + 11, 9] := des;
              cfgsc.PlanetLst[j, i + 11, 10] := cfgsc.PlanetLst[j, ipla, 10];
              precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
              if cfgsc.PlanetParalaxe then
              begin
                Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
              end;
              if cfgsc.ApparentPos then
                apparent_equatorial(ars, des, cfgsc, True, False);
              ars := rmod(ars, pi2);
              cfgsc.PlanetLst[j, i + 11, 1] := ars;
              cfgsc.PlanetLst[j, i + 11, 2] := des;
              cfgsc.PlanetLst[j, i + 11, 3] := jdt;
              cfgsc.PlanetLst[j, i + 11, 4] := rad2deg * (2 * D0jup[i] / km_au / dist) * 3600;
              cfgsc.PlanetLst[j, i + 11, 5] := V0jup[i] + 5 * log10(dp * dist) + 0.005 * pha;
              if supconj[i] then
                cfgsc.PlanetLst[j, i + 11, 6] := 10
              else
                cfgsc.PlanetLst[j, i + 11, 6] := 0;
            end;
            if cfgsc.SmallSatActive then begin
              for i := 1 to 4 do
              begin
                ars := satx[4 + i];
                des := saty[4 + i];
                cfgsc.PlanetLst[j, i + 36, 8] := NormRA(ars); //J2000
                cfgsc.PlanetLst[j, i + 36, 9] := des;
                cfgsc.PlanetLst[j, i + 36, 10] := cfgsc.PlanetLst[j, ipla, 10];
                precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
                if cfgsc.PlanetParalaxe then
                begin
                  Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
                end;
                if cfgsc.ApparentPos then
                  apparent_equatorial(ars, des, cfgsc, True, False);
                ars := rmod(ars, pi2);
                cfgsc.PlanetLst[j, i + 36, 1] := ars;
                cfgsc.PlanetLst[j, i + 36, 2] := des;
                cfgsc.PlanetLst[j, i + 36, 3] := jdt;
                cfgsc.PlanetLst[j, i + 36, 4] := rad2deg * (2 * D0jup[i + 4] / km_au / dist) * 3600;
                cfgsc.PlanetLst[j, i + 36, 5] := V0jup[i + 4] + 5 * log10(dp * dist) + 0.005 * pha;
                if supconj[i] then
                  cfgsc.PlanetLst[j, i + 36, 6] := 10
                else
                  cfgsc.PlanetLst[j, i + 36, 6] := 0;
              end;
              if cfgsc.CalcephActive or cfgsc.SpiceActive then begin
                for i := 1 to 8 do
                begin
                  ars := satx[8 + i];
                  des := saty[8 + i];
                  cfgsc.PlanetLst[j, i + 69, 8] := NormRA(ars); //J2000
                  cfgsc.PlanetLst[j, i + 69, 9] := des;
                  cfgsc.PlanetLst[j, i + 69, 10] := cfgsc.PlanetLst[j, ipla, 10];
                  precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
                  if cfgsc.PlanetParalaxe then
                  begin
                    Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
                  end;
                  if cfgsc.ApparentPos then
                    apparent_equatorial(ars, des, cfgsc, True, False);
                  ars := rmod(ars, pi2);
                  cfgsc.PlanetLst[j, i + 69, 1] := ars;
                  cfgsc.PlanetLst[j, i + 69, 2] := des;
                  cfgsc.PlanetLst[j, i + 69, 3] := jdt;
                  cfgsc.PlanetLst[j, i + 69, 4] := rad2deg * (2 * D0jup[i + 8] / km_au / dist) * 3600;
                  cfgsc.PlanetLst[j, i + 69, 5] := V0jup[i + 8] + 5 * log10(dp * dist) + 0.005 * pha;
                  if supconj[i] then
                    cfgsc.PlanetLst[j, i + 69, 6] := 10
                  else
                    cfgsc.PlanetLst[j, i + 69, 6] := 0;
                end;
              end;
            end;
          end;
        end;
        if ipla = 6 then
        begin
          ierr := Satsat(jdt, dist * tlight, xp, yp, zp, cfgsc, satx, saty, supconj);
          if ierr > 0 then
          begin
            for i := 1 to 8 do
              cfgsc.PlanetLst[j, i + 15, 6] := 99;
            cfgsc.PlanetLst[j, 33, 6] := 99;
            if cfgsc.SmallSatActive then
              for i := 1 to 10 do
                cfgsc.PlanetLst[j, i + 40, 6] := 99;
          end
          else
          begin
            for i := 1 to 9 do
            begin
              if i = 9 then
                k := 33
              else
                k := i + 15;
              ars := satx[i];
              des := saty[i];
              cfgsc.PlanetLst[j, k, 8] := NormRA(ars); //J2000
              cfgsc.PlanetLst[j, k, 9] := des;
              cfgsc.PlanetLst[j, k, 10] := cfgsc.PlanetLst[j, ipla, 10];
              precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
              if cfgsc.PlanetParalaxe then
              begin
                Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
              end;
              if cfgsc.ApparentPos then
                apparent_equatorial(ars, des, cfgsc, True, False);
              ars := rmod(ars, pi2);
              cfgsc.PlanetLst[j, k, 1] := ars;
              cfgsc.PlanetLst[j, k, 2] := des;
              cfgsc.PlanetLst[j, k, 3] := jdt;
              cfgsc.PlanetLst[j, k, 4] := rad2deg * (2 * D0sat[i] / km_au / dist) * 3600;
              cfgsc.PlanetLst[j, k, 5] := V0sat[i] + 5 * log10(dp * dist) + 0.044 * pha;
              if supconj[i] then
                cfgsc.PlanetLst[j, k, 6] := 10
              else
                cfgsc.PlanetLst[j, k, 6] := 0;
            end;
            if cfgsc.SmallSatActive then
              for i := 1 to 10 do
              begin
                ars := satx[9 + i];
                des := saty[9 + i];
                cfgsc.PlanetLst[j, i + 40, 8] := NormRA(ars); //J2000
                cfgsc.PlanetLst[j, i + 40, 9] := des;
                cfgsc.PlanetLst[j, i + 40, 10] := cfgsc.PlanetLst[j, ipla, 10];
                precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
                if cfgsc.PlanetParalaxe then
                begin
                  Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
                end;
                if cfgsc.ApparentPos then
                  apparent_equatorial(ars, des, cfgsc, True, False);
                ars := rmod(ars, pi2);
                cfgsc.PlanetLst[j, i + 40, 1] := ars;
                cfgsc.PlanetLst[j, i + 40, 2] := des;
                cfgsc.PlanetLst[j, i + 40, 3] := jdt;
                cfgsc.PlanetLst[j, i + 40, 4] := rad2deg * (2 * D0sat[i + 9] / km_au / dist) * 3600;
                cfgsc.PlanetLst[j, i + 40, 5] := V0sat[i + 9] + 5 * log10(dp * dist) + 0.044 * pha;
                if supconj[i] then
                  cfgsc.PlanetLst[j, i + 40, 6] := 10
                else
                  cfgsc.PlanetLst[j, i + 40, 6] := 0;
              end;
          end;
          SatRing(jdt, P, a, b, be);
          cfgsc.PlanetLst[j, 31, 1] := P;
          cfgsc.PlanetLst[j, 31, 2] := a;
          cfgsc.PlanetLst[j, 31, 3] := b;
          cfgsc.PlanetLst[j, 31, 4] := be;
          // ring magn. correction
          sb := sin(deg2rad * abs(be));
          cfgsc.PlanetLst[j, ipla, 5] := cfgsc.PlanetLst[j, ipla, 5] - 2.6 * sb + 1.25 * sb * sb;
        end;
        if ipla = 7 then
        begin
          ierr := Urasat(jdt, dist * tlight, xp, yp, zp, cfgsc, satx, saty, supconj);
          if ierr > 0 then
          begin
            for i := 1 to 5 do
              cfgsc.PlanetLst[j, i + 23, 6] := 99;
            if cfgsc.SmallSatActive then
              for i := 1 to 13 do
                cfgsc.PlanetLst[j, i + 50, 6] := 99;
          end
          else
          begin
            for i := 1 to 5 do
            begin
              ars := satx[i];
              des := saty[i];
              cfgsc.PlanetLst[j, i + 23, 8] := NormRA(ars); //J2000
              cfgsc.PlanetLst[j, i + 23, 9] := des;
              cfgsc.PlanetLst[j, i + 23, 10] := cfgsc.PlanetLst[j, ipla, 10];
              precession(jd2000, cfgsc.JDChart, ars, des);     // equinox require for the chart
              if cfgsc.PlanetParalaxe then
              begin
                Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
              end;
              if cfgsc.ApparentPos then
                apparent_equatorial(ars, des, cfgsc, True, False);
              ars := rmod(ars, pi2);
              cfgsc.PlanetLst[j, i + 23, 1] := ars;
              cfgsc.PlanetLst[j, i + 23, 2] := des;
              cfgsc.PlanetLst[j, i + 23, 3] := jdt;
              cfgsc.PlanetLst[j, i + 23, 4] := rad2deg * (2 * D0ura[i] / km_au / dist) * 3600;
              cfgsc.PlanetLst[j, i + 23, 5] := V0ura[i] + 5 * log10(dp * dist);
              if supconj[i] then
                cfgsc.PlanetLst[j, i + 23, 6] := 10
              else
                cfgsc.PlanetLst[j, i + 23, 6] := 0;
            end;
            if cfgsc.SmallSatActive then
              for i := 1 to 13 do
              begin
                ars := satx[5 + i];
                des := saty[5 + i];
                cfgsc.PlanetLst[j, i + 50, 8] := NormRA(ars); //J2000
                cfgsc.PlanetLst[j, i + 50, 9] := des;
                cfgsc.PlanetLst[j, i + 50, 10] := cfgsc.PlanetLst[j, ipla, 10];
                precession(jd2000, cfgsc.JDChart, ars, des);
                // equinox require for the chart
                if cfgsc.PlanetParalaxe then
                begin
                  Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
                end;
                if cfgsc.ApparentPos then
                  apparent_equatorial(ars, des, cfgsc, True, False);
                ars := rmod(ars, pi2);
                cfgsc.PlanetLst[j, i + 50, 1] := ars;
                cfgsc.PlanetLst[j, i + 50, 2] := des;
                cfgsc.PlanetLst[j, i + 50, 3] := jdt;
                cfgsc.PlanetLst[j, i + 50, 4] := rad2deg * (2 * D0ura[i + 5] / km_au / dist) * 3600;
                cfgsc.PlanetLst[j, i + 50, 5] := V0ura[i + 5] + 5 * log10(dp * dist);
                if supconj[i] then
                  cfgsc.PlanetLst[j, i + 50, 6] := 10
                else
                  cfgsc.PlanetLst[j, i + 50, 6] := 0;
              end;

          end;
        end;
        if ipla = 8 then
        begin
          ierr := Nepsat(jdt, dist * tlight, xp, yp, zp, cfgsc, satx, saty, supconj);
          if ierr > 0 then
          begin
            for i := 1 to 2 do
              cfgsc.PlanetLst[j, i + 33, 6] := 99;
            if cfgsc.SmallSatActive then
              for i := 1 to 6 do
                cfgsc.PlanetLst[j, i + 63, 6] := 99;
          end
          else
          begin
            for i := 1 to 2 do
            begin
              ars := satx[i];
              des := saty[i];
              cfgsc.PlanetLst[j, i + 33, 8] := NormRA(ars); //J2000
              cfgsc.PlanetLst[j, i + 33, 9] := des;
              cfgsc.PlanetLst[j, i + 33, 10] := cfgsc.PlanetLst[j, ipla, 10];
              precession(jd2000, cfgsc.JDChart, ars, des);
              // equinox require for the chart
              if cfgsc.PlanetParalaxe then
              begin
                Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
              end;
              if cfgsc.ApparentPos then
                apparent_equatorial(ars, des, cfgsc, True, False);
              ars := rmod(ars, pi2);
              cfgsc.PlanetLst[j, i + 33, 1] := ars;
              cfgsc.PlanetLst[j, i + 33, 2] := des;
              cfgsc.PlanetLst[j, i + 33, 3] := jdt;
              cfgsc.PlanetLst[j, i + 33, 4] := rad2deg * (2 * D0nep[i] / km_au / dist) * 3600;
              cfgsc.PlanetLst[j, i + 33, 5] := V0nep[i] + 5 * log10(dp * dist);
              if supconj[i] then
                cfgsc.PlanetLst[j, i + 33, 6] := 10
              else
                cfgsc.PlanetLst[j, i + 33, 6] := 0;
            end;
            if cfgsc.SmallSatActive then
              for i := 1 to 6 do
              begin
                ars := satx[2 + i];
                des := saty[2 + i];
                cfgsc.PlanetLst[j, i + 63, 8] := NormRA(ars); //J2000
                cfgsc.PlanetLst[j, i + 63, 9] := des;
                cfgsc.PlanetLst[j, i + 63, 10] := cfgsc.PlanetLst[j, ipla, 10];
                precession(jd2000, cfgsc.JDChart, ars, des);
                // equinox require for the chart
                if cfgsc.PlanetParalaxe then
                begin
                  Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
                end;
                if cfgsc.ApparentPos then
                  apparent_equatorial(ars, des, cfgsc, True, False);
                ars := rmod(ars, pi2);
                cfgsc.PlanetLst[j, i + 63, 1] := ars;
                cfgsc.PlanetLst[j, i + 63, 2] := des;
                cfgsc.PlanetLst[j, i + 63, 3] := jdt;
                cfgsc.PlanetLst[j, i + 63, 4] := rad2deg * (2 * D0nep[i + 2] / km_au / dist) * 3600;
                cfgsc.PlanetLst[j, i + 63, 5] := V0nep[i + 2] + 5 * log10(dp * dist);
                if supconj[i] then
                  cfgsc.PlanetLst[j, i + 63, 6] := 10
                else
                  cfgsc.PlanetLst[j, i + 63, 6] := 0;
              end;
          end;
        end;
        if ipla = 9 then
        begin
          ierr := Plusat(jdt, dist * tlight, xp, yp, zp, cfgsc, satx, saty, supconj);
          if ierr > 0 then
            for i := 1 to 1 do
              cfgsc.PlanetLst[j, i + 35, 6] := 99
          else
            for i := 1 to 1 do
            begin
              ars := satx[i];
              des := saty[i];
              cfgsc.PlanetLst[j, i + 35, 8] := NormRA(ars); //J2000
              cfgsc.PlanetLst[j, i + 35, 9] := des;
              cfgsc.PlanetLst[j, i + 35, 10] := cfgsc.PlanetLst[j, ipla, 10];
              precession(jd2000, cfgsc.JDChart, ars, des);
              // equinox require for the chart
              if cfgsc.PlanetParalaxe then
              begin
                Paralaxe(st0, dist, ars, des, ars, des, q, cfgsc);
              end;
              if cfgsc.ApparentPos then
                apparent_equatorial(ars, des, cfgsc, True, False);
              ars := rmod(ars, pi2);
              cfgsc.PlanetLst[j, i + 35, 1] := ars;
              cfgsc.PlanetLst[j, i + 35, 2] := des;
              cfgsc.PlanetLst[j, i + 35, 3] := jdt;
              cfgsc.PlanetLst[j, i + 35, 4] := rad2deg * (2 * D0plu[i] / km_au / dist) * 3600;
              cfgsc.PlanetLst[j, i + 35, 5] := V0plu[i] + 5 * log10(dp * dist);
              if supconj[i] then
                cfgsc.PlanetLst[j, i + 35, 6] := 10
              else
                cfgsc.PlanetLst[j, i + 35, 6] := 0;
            end;
        end;
      end;
      ipla := 11;
      Moon(jdt, ar, de, dist, dkm, diam, phase, illum,cfgsc);
      cfgsc.PlanetLst[j, ipla, 8] := NormRA(ar); //J2000
      cfgsc.PlanetLst[j, ipla, 9] := de;
      cfgsc.PlanetLst[j, ipla, 10] := dist;
      precession(jd2000, cfgsc.JDChart, ar, de);     // equinox require for the chart
      cfgsc.PlanetLst[j, 32, 4] := dist;
      cfgsc.PlanetLst[j, 32, 5] := dkm;
      apparent_equatorial(ar, de, cfgsc, True, False);
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(st0, dist, ar, de, ar, de, q, cfgsc);
        diam := diam / q;
        dist := dist * q;
        dkm := dkm * q;
        cfgsc.PlanetLst[j, 32, 5] := dkm;
        Paralaxe(st0, dist, cfgsc.PlanetLst[j, 32, 1], cfgsc.PlanetLst[j, 32, 2],
          cfgsc.PlanetLst[j, 32, 1], cfgsc.PlanetLst[j, 32, 2], q, cfgsc);
      end;
      ar := rmod(ar, pi2);
      cfgsc.PlanetLst[j, ipla, 1] := ar;
      cfgsc.PlanetLst[j, ipla, 2] := de;
      cfgsc.PlanetLst[j, ipla, 3] := jdt;
      cfgsc.PlanetLst[j, ipla, 4] := diam;
      cfgsc.PlanetLst[j, ipla, 5] := illum;
      cfgsc.PlanetLst[j, ipla, 6] := dist;
      cfgsc.PlanetLst[j, ipla, 7] := phase;
      if j = 0 then
      begin
        Eq2HZ(cfgsc.CurST - ar, de, a, cfgsc.curMoonH, cfgsc);
        cfgsc.curMoonIllum := illum;
      end;
    end;
  finally
    lockpla := False;
  end;
end;

procedure TPlanet.FindNumPla(id: integer;
  var ar, de: double; var ok: boolean; cfgsc: Tconf_skychart; MeanPos: boolean = False);
var
  nom, ma, date, desc: string;
begin
  ok := False;
  if (not cfgsc.ephvalid) or (id < 1) or (id > MaxPla) or (id = 31) or (id = 32) then
    exit;
  if (cfgsc.Planetlst[0, id, 8]=0)and(cfgsc.Planetlst[0, id, 9]=0) then
    exit;
  ok := True;
  cfgsc.FindOK := True;
  if MeanPos then
  begin
    ar := normra(cfgsc.Planetlst[0, id, 8]);
    de := cfgsc.Planetlst[0, id, 9];
    FormatPlanet(0, id, cfgsc, nom, ma, date, desc);
  end
  else
  begin
    ar := cfgsc.Planetlst[0, id, 1];
    de := cfgsc.Planetlst[0, id, 2];
    // back to j2000
    if cfgsc.ApparentPos then
      mean_equatorial(ar, de, cfgsc, id <> 11, False);
    precession(cfgsc.JDchart, jd2000, ar, de);
    FormatPlanet(0, id, cfgsc, nom, ma, date, desc);
  end;
end;

function TPlanet.FindPlanetName(planetname: string; var ra, de: double;
  cfgsc: Tconf_skychart; MeanPos: boolean = False): boolean;
var
  i: integer;
begin
  Result := False;
  if cfgsc.ephvalid then
    for i := 1 to MaxPla do
    begin
      if i = 31 then
        continue;
      if i = 32 then
        continue;
      if (i = 9) and (not cfgsc.ShowPluto) then
        continue;
      if (uppercase(trim(planetname)) = uppercase(trim(pla[i]))) or
        (uppercase(trim(planetname)) = uppercase(trim(epla[i]))) then
      begin
        FindNumPla(i, ra, de, Result, cfgsc, MeanPos);
        break;
      end;
    end;
end;

function TPlanet.FindPlanet(x1, y1, x2, y2: double; nextobj: boolean;
  cfgsc: Tconf_skychart; var nom, ma, date, desc: string; trunc: boolean = True; searchcenter: boolean = False): boolean;
var
  i, j: integer;
  tar, tde, ar, de, rac: double;
  distmin: double;
  directfind: boolean;
  distancetocenter: array[0..MaxPlSim, 1..MaxPla] of double;
begin
  if x2 > pi2 then
    rac := pi2
  else
    rac := 0;
  ar := (x2 + x1) / 2;
  de := (y2 + y1) / 2;
  distancetocenter[0, 1] := maxdouble;
  if not nextobj then
  begin
    CurrentStep := 0;
    CurrentPlanet := 0;
    for j := 0 to cfgsc.SimNb do
      for i := 1 to maxpla do
        distancetocenter[j, i] := maxdouble;
  end;
  Result := False;
  directfind := False;
  desc := '';
  tar := 1;
  tde := 1;
  if cfgsc.ephvalid then
    repeat
      Inc(CurrentPlanet);
      if (CurrentStep > 0) and (CurrentPlanet <= 11) and (not cfgsc.SimObject[CurrentPlanet]) then
        continue;
      if CurrentPlanet = 3 then
        continue;    // skip Earth
      if (CurrentPlanet = 9) and (not cfgsc.ShowPluto) then
        continue; // skip Pluto
      if CurrentPlanet = 31 then
        continue;   // skip Saturn ring
      if (CurrentPlanet = 32) and not cfgsc.ShowEarthShadowValid then
        continue;
      if (CurrentPlanet > MaxPla) or ((not cfgsc.SmallSatActive) and (CurrentPlanet > 36)) then
      begin
        Inc(CurrentStep);
        if nextobj or (CurrentStep >= cfgsc.SimNb) then
        begin
          Dec(CurrentStep);
          break;
        end
        else
        begin
          CurrentPlanet := 0;
          continue;
        end;
      end;
      // not planetary satellites for large field of vision or if hiden by the planet
      if (currentplanet > 11) and (currentplanet <= MaxPla) and
        ((rad2deg * cfgsc.fov > 5) or (cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 6] > 90)) then
        continue;
      tar := NormRa(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 1]);
      tde := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 2];
      cfgsc.FindRA2000 := NormRa(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 8]);
      cfgsc.FindDec2000 := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 9];
      cfgsc.FindDist := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 10];
      // search if this planet center is at the position
      if (trunc) and (((tar+rac) < x1) or ((tar+rac) > x2) or (tde < y1) or
        (tde > y2) or ((CurrentPlanet > 11) and (currentplanet <= MaxPla) and
        (cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 6] > 90)))
      //     ((CurrentPlanet>11)and (currentplanet<=MaxPla)and cfgsc.StarFilter and (cfgsc.PlanetLst[CurrentStep,CurrentPlanet,5]>cfgsc.StarMagMax)) )
      then
      begin
        // no
        // but ok if the cursor is inside the planetary disk
        if (CurrentPlanet <= MaxPla) then
        begin
          distancetocenter[CurrentStep, CurrentPlanet] :=
            3600 * rad2deg * angulardistance(ar, de, tar, tde);
          if (not searchcenter) and (distancetocenter[CurrentStep, CurrentPlanet] <=
            (cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 4] / 2)) then
            Result := True
          else
            distancetocenter[CurrentStep, CurrentPlanet] := maxdouble;
        end;
      end
      else
      begin
        Result := True;
        directfind := True;
      end;
    until directfind;
  cfgsc.FindOK := Result;
  if Result then
  begin
    if not directfind then
    begin // search the planet nearest to position
      distmin := maxdouble;
      for j := 0 to cfgsc.SimNb do
        for i := 1 to MaxPla do
        begin
          if (i <> 31) and (i <> 32) and (distancetocenter[j, i] < distmin) then
          begin
            distmin := distancetocenter[j, i];
            CurrentPlanet := i;
            CurrentStep := j;
          end;
        end;
    end;
    FormatPlanet(CurrentStep, CurrentPlanet, cfgsc, nom, ma, date, desc);
  end;
end;

procedure TPlanet.FormatPlanet(St, Pl: integer; cfgsc: Tconf_skychart;
  var nom, ma, date, desc: string);
var
  yy, mm, dd: integer;
  ar, de: double;
  dist, illum, phase, diam, jdt, magn, dkm, hh, dp, p, pde, pds, w1, w2, w3, jd0,
  st0, q, xp, yp, zp, vel, lighttime, ls: double;
  sar, sde, sdist, skm, sillum, sphase, sdiam, smagn, shh, sdp, sdpkm, datett: string;
  sunv: Array_5D;
const
  d1 = '0.0';
  d2 = '0.00';
begin
  CurrentStep := St;
  CurrentPlanet := Pl;
  cfgsc.FindSize := deg2rad * cfgsc.Planetlst[CurrentStep, CurrentPlanet, 4] / 3600;
  cfgsc.FindRA := NormRa(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 1]);
  cfgsc.FindDec := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 2];
  cfgsc.FindRA2000 := NormRa(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 8]);
  cfgsc.FindDec2000 := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 9];
  cfgsc.FindDist := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 10];
  cfgsc.FindPM := False;
  cfgsc.FindType := ftPla;
  cfgsc.FindX := 0;
  cfgsc.FindY := 0;
  cfgsc.FindZ := 0;
  cfgsc.TrackRA := cfgsc.FindRA;
  cfgsc.TrackDec := cfgsc.FindDec;
  cfgsc.TrackEpoch := cfgsc.JDChart;
  sar := ARpToStr(rad2deg * cfgsc.FindRA / 15);
  sde := DEpToStr(rad2deg * cfgsc.FindDec);
  jdt := cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 3];
  cfgsc.FindSimjd := jdt;
  djd(jdt, yy, mm, dd, hh);
  shh := ARtoStr3(rmod(hh, 24));
  datett := Date2Str(yy, mm, dd) + blank + shh;
  djd(jdt + (cfgsc.TimeZone - cfgsc.DT_UT) / 24, yy, mm, dd, hh);
  shh := ARtoStr3(rmod(hh, 24));
  date := Date2Str(yy, mm, dd) + blank + shh;
  jd0 := jd(yy, mm, dd, 0);
  st0 := SidTim(jd0, hh - cfgsc.TimeZone, cfgsc.ObsLongitude);
  if ServerCoordSystem=csJ2000 then begin
      ar := cfgsc.FindRA2000;
      de := cfgsc.FindDec2000;
      if cfgsc.PlanetParalaxe then
         Paralaxe(st0, cfgsc.FindDist, ar, de, ar, de, q, cfgsc);
      cfgsc.FindDesc2000 := ARpToStr(rmod(24+rad2deg * ar / 15,24)) + tab + DEpToStr(rad2deg * de);
  end
  else
      cfgsc.FindDesc2000 := '';
  cfgsc.TrackType := TTplanet;
  cfgsc.TrackObj := CurrentPlanet;
  cfgsc.TrackName := trim(pla[CurrentPlanet]);
  if (currentplanet < 10) then
  begin
    Planet(CurrentPlanet, jdt, ar, de, dist, illum, phase, diam, magn, dp, xp, yp, zp, vel, lighttime);
    cfgsc.FindX := xp;
    cfgsc.FindY := yp;
    cfgsc.FindZ := zp;
    if load_de(jdt) then
    begin
      // Sun to barycenter
      Calc_Planet_de(jdt-lighttime, 11, sunv, True, 12, False);
      // distance to the Sun
      dp:=sqrt(sqr(xp-sunv[0])+sqr(yp-sunv[1])+sqr(zp-sunv[2]));
    end;
    str(dp: 12: 9, sdp);
    str((dp * km_au): 12: 0, sdpkm);
    str(illum: 5: 3, sillum);
    str(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 6]: 12: 9, sdist);
    str((cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 6] * km_au): 12: 0, skm);
    str(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 7]: 4: 0, sphase);
    str(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 4]: 5: 1, sdiam);
    str(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 5]: 5: 1, smagn);
    nom := pla[CurrentPlanet];
    ma := smagn;
    Desc := sar + tab + sde + tab + '  P' + tab + nom + tab + 'm:' +
      smagn + tab + 'diam:' + sdiam + blank + lsec + tab + 'illum:' +
      sillum + tab + 'phase:' + sphase + blank + ldeg + tab + 'dist:' +
      sdist + ' au' + tab + 'dist:' + skm + ' km' + tab + 'rsol:' +
      sdp + ' au' + tab + 'rsol:' + sdpkm + ' km' + tab;
    if vel <> 0 then
      Desc := Desc + 'vel:' + formatfloat(f1, vel) + 'km/s' + tab;
    PlanetOrientation(jdt, CurrentPlanet, p, pde, pds, w1, w2, w3);
    Desc := Desc + 'pa:' + formatfloat(d1, p) + tab + 'PoleIncl:' + formatfloat(
      d1, pde) + tab + 'SunIncl:' + formatfloat(d1, pds) + tab;
    if Currentplanet = 4 then
    begin
      ls := MarsSolarLongitude(jdt);
      if ls > NullCoord then
        Desc := Desc +'Ls:'+FormatFloat(d1,ls) + tab;
    end
    else if Currentplanet = 5 then
    begin
      Desc := Desc + 'CMI:' + formatfloat(d1, w1) + tab + 'CMII:' +
        formatfloat(d1, w2) + tab + 'CMIII:' + formatfloat(d1, w3) + tab;
      jd0 := jd(yy, mm, dd, 0 - cfgsc.TimeZone + cfgsc.DT_UT);
      PlanetOrientation(jd0, CurrentPlanet, p, pde, pds, w1, w2, w3);
      w1 := (JupGRS(cfgsc.GRSlongitude, cfgsc.GRSdrift, cfgsc.GRSjd, jdt) - w2) * 24 / 870.27003539;
      shh := '';
      if w1 > 0 then
        shh := ARmtoStr(w1);
      repeat
        w1 := w1 + 24 * 360 / 870.27003539;
        if (w1 > 0) and (w1 < 24) then
          shh := shh + blank + ARmtoStr(w1);
      until w1 > 24;
      Desc := Desc + 'GRStr:' + shh + '  ( ' + TzGMT2UTC(cfgsc.tz.ZoneName) + ' )' + tab;
      Desc := Desc + 'GRSLon:' + FormatFloat(
        f1, JupGRS(cfgsc.GRSlongitude, cfgsc.GRSdrift, cfgsc.GRSjd, jdt)) + tab;
    end
    else if Currentplanet = 6 then
    begin
      Desc := Desc + 'CMI:' + formatfloat(d1, w1) + tab + 'CMII:' +
        formatfloat(d1, w2) + tab + 'CMIII:' + formatfloat(d1, w3) + tab;
    end
    else
    begin
      Desc := Desc + 'CM:' + formatfloat(d1, w1) + tab;
    end;
    Desc := Desc + 'ephemeris:' + eph_method + tab;
    Desc := Desc + 'date:' + date + '  ( ' + TzGMT2UTC(cfgsc.tz.ZoneName) + ' )' + tab;
    Desc := Desc + 'TT:' + datett;
  end;
  if (currentplanet = 10) then
  begin
    Sun(jdt, ar, de, dist, diam);
    str(dist: 12: 9, sdist);
    str((dist * km_au): 12: 0, skm);
    sdiam := DEToStrShort(diam / 3600, 1);
    nom := pla[CurrentPlanet];
    ma := '-26';
    Desc := sar + tab + sde + tab + '  S*' + tab + nom + tab +
      'm:-26' + tab + 'diam:' + sdiam + tab + 'dist:' + sdist + ' au' +
      tab + 'dist:' + skm + ' km' + tab;
    PlanetOrientation(jdt, CurrentPlanet, p, pde, pds, w1, w2, w3);
    Desc := Desc + 'pa:' + formatfloat(d1, p) + tab + 'PoleIncl:' + formatfloat(
      d1, pde) + tab + 'CM:' + formatfloat(d1, w1) + tab +
      'ephemeris:' + eph_method + tab + 'date:' + date + '  ( ' + TzGMT2UTC(cfgsc.tz.ZoneName) + ' )' + tab + 'TT:' + datett;
  end;
  if (currentplanet = 11) then
  begin
    Moon(jdt, ar, de, dist, dkm, diam, phase, illum,cfgsc);
    precession(jd2000, cfgsc.JDChart, ar, de);
    if cfgsc.PlanetParalaxe then
    begin   // correct distance for paralaxe
      Paralaxe(st0, dist, ar, de, ar, de, q, cfgsc);
      diam := diam / q;
      dist := dist * q;
      dkm := dkm * q;
    end;
    ar := cfgsc.FindRA;
    de := cfgsc.FindDEC;    // reset original position value
    str(dkm: 8: 1, sdist);
    sdiam := DEToStrShort(diam / 3600, 1);
    str(illum: 5: 3, sillum);
    str(phase: 4: 0, sphase);
    nom := pla[CurrentPlanet];
    magn := MoonMag(phase);
    str(magn: 5: 2, smagn);
    ma := smagn;
    Desc := sar + tab + sde + tab + '  Ps' + tab + nom + tab + 'm:' +
      smagn + tab + 'diam:' + sdiam + tab + 'illum:' + sillum + tab
      + 'phase:' + sphase + blank + ldeg + tab + 'dist:' + sdist + ' km' + tab;
    MoonOrientation(jdt, ar, de, dist, p, pde, pds, w1);
    Desc := Desc + 'pa:' + formatfloat(d1, p) + tab + 'llat:' + formatfloat(
      d2, pde) + tab + 'llon:' + formatfloat(d2, w1) + tab +
      'SunIncl:' + formatfloat(d2, pds) + tab + 'ephemeris:' + eph_method +
      tab + 'date:' + date + '  ( ' + TzGMT2UTC(cfgsc.tz.ZoneName) + ' )' + tab + 'TT:' + datett;
  end;
  if (currentplanet = 32) then
  begin   // Earth umbra
    jdt := cfgsc.PlanetLst[CurrentStep, 10, 3];  // date from the Sun
    cfgsc.FindSimjd := jdt;
    djd(jdt + (cfgsc.TimeZone - cfgsc.DT_UT) / 24, yy, mm, dd, hh);
    shh := ARmtoStr(rmod(hh, 24));
    date := Date2Str(yy, mm, dd) + blank + shh;
    cfgsc.TrackType := TTplanet;
    cfgsc.TrackObj := CurrentPlanet;
    cfgsc.TrackName := rsEarthShadow;
    nom := cfgsc.Trackname;
    ma := '';
    Desc := sar + tab + sde + tab + '  P' + tab + nom + tab + date + '  ( ' + TzGMT2UTC(cfgsc.tz.ZoneName) + ' )' + tab;
  end;
  if ((currentplanet > 11) and (currentplanet <= 30)) or
    ((currentplanet > 32) and (currentplanet <= MaxPla)) then
  begin
    nom := pla[CurrentPlanet];
    str(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 5]: 5: 1, smagn);
    str(cfgsc.PlanetLst[CurrentStep, CurrentPlanet, 4]: 5: 3, sdiam);
    ma := smagn;
    Desc := sar + tab + sde + tab + ' Ps' + tab + nom + tab +
      'm:' + smagn + tab + 'diam:' + sdiam + blank + lsec + tab +
      'date:' + date + '  ( ' + TzGMT2UTC(cfgsc.tz.ZoneName) + ' )' + tab + 'TT:' + datett;
  end;
  cfgsc.FindIpla := CurrentPlanet;
  cfgsc.FindId := nom;
  cfgsc.FindName := nom;
  cfgsc.FindDesc := Desc;
  cfgsc.FindDesc2 := '';
  cfgsc.FindNote := '';
end;

procedure Kepler(var E1: double; e, m: double; precision: double = 1.0E-11);
var
  a, b, c, qr, s0, s, z: double;
  n: integer;
begin
  { meeus91  29.8 }
  if (e > 0.97) and (abs(m) < 0.55) then
  begin
    a := (1 - e) / (4 * e + 0.5);
    b := m / (8 * e + 1);
    qr := b + sign(b) * sqrt(b * b + a * a * a);
    if qr > 0 then
    begin
      z := power(qr, 1 / 3);
      s0 := z - a / 2;
      s := s0 - (0.078 * intpower(s0, 5)) / (1 + e);
      E1 := m + e * (3 * s - 4 * s * s * s);
    end
    else
      E1 := m;
  end
  else
    E1 := m;
  { meeus91  29.7 }
  n := 0;
  repeat
    c := (m + e * sin(E1) - E1) / (1.0 - e * cos(E1));
    E1 := E1 + c;
    Inc(n);
    if n > 10000 then
      raise Exception.Create('Kepler equation not solved after 10000 loop. e=' +
        floattostr(e) + ' M=' + floattostr(m));
  until ABS(c) < precision;
end;

procedure RectToPol(x, y: double; var r, alpha: double);
begin
  r := sqrt(x * x + y * y);
  alpha := arctan2(y, x);
end;

procedure PrecessElem(annee: double; var i, oomi, oma: double);
var
  t, tau0, tau, eta, theta, theta0, i0, oma0, x, y, r, alpha, cosi: double;
const
  final = 2000.0;
begin
  tau0 := (annee - 1900) / 1000;    { meeus 17. }
  tau := (final - 1900) / 1000;
  t := tau - tau0;
  eta := ((471.07 - 6.75 * tau0 + 0.57 * tau0 * tau0) * t + (-3.37 + 0.57 * tau0) * t * t + 0.05 * t * t * t) / 3600;
  theta0 := 173.950833 + (32869 * tau0 + 56 * tau0 * tau0 - (8694 + 55 * tau0) * t + 3 * t * t) / 3600;
  theta := theta0 + ((50256.41 + 222.29 * tau0 + 0.26 * tau0 * tau0) * t +
    (111.15 + 0.26 * tau0) * t * t + 0.1 * t * t * t) / 3600;
  i0 := i;
  oma0 := oma;
  eta := deg2rad * eta;
  theta := deg2rad * theta;
  theta0 := deg2rad * theta0;
  cosi := cos(i0) * cos(eta) + sin(i0) * sin(eta) * cos(oma0 - theta0);
  y := sin(i0) * sin(oma0 - theta0);        { meeus 17.2 }
  x := -sin(eta) * cos(i0) + cos(eta) * sin(i0) * cos(oma0 - theta0);
  RectToPol(x, y, r, alpha);
  i := arcsin(r);
  if cosi < 0 then
    i := pi - i;
  oma := alpha + theta;
  y := -sin(eta) * sin(oma0 - theta0);      { meeus 17.3 }
  x := sin(i0) * cos(eta) - cos(i0) * sin(eta) * cos(oma0 - theta0);
  RectToPol(x, y, r, alpha);
  oomi := oomi + alpha;
end;

procedure TPlanet.InitComet(tp, q, ec, ap, an, ic, mh, mg, eq: double; nam: string);
var
  i, Oma, ff, g, h, p, qq, r, ooe: double;
  sOma, cOma, soe, coe, si, ci: extended;
begin
  comelem.CometName := nam;
  comelem.equinox := eq;
  comelem.Ot := tp;
  comelem.Oq := q;
  comelem.Oe := ec;
  comelem.Oomi := deg2rad * ap;
  Oma := deg2rad * an;
  i := deg2rad * ic;
  comelem.Oh := mh;
  comelem.Og := mg;
  if comelem.equinox <> 2000 then
    PrecessElem(comelem.equinox, i, comelem.oomi, oma);
  ooe := deg2rad * 23.43929111; {J2000}
  sincos(Oma, sOma, cOma);
  sincos(ooe, soe, coe);
  sincos(i, si, ci);
  ff := cOma;  { meus 25.13 }
  g := sOma * coe;
  h := sOma * soe;
  p := -sOma * ci;
  qq := cOma * ci * coe - si * soe;
  r := cOma * ci * soe + si * coe;
  comelem.Oaa := arctan2(ff, p);
  comelem.Obb := arctan2(g, qq);
  comelem.Occ := arctan2(h, r);
  comelem.Oa := sqrt(ff * ff + p * p);
  comelem.Ob := sqrt(g * g + qq * qq);
  comelem.Oc := sqrt(h * h + r * r);
end;

procedure TPlanet.OrbRect(jd: double; var xc, yc, zc, rs: double);
var
  nu: double;

  procedure eliptique;
  var
    da, n0, m, ex, num, den: double;
  begin
    da := comelem.Oq / (1.0 - comelem.Oe);                     { meeus 25.12 }
    n0 := 0.01720209895 / (da * sqrt(da));
    m := n0 * (jd - comelem.Ot);
    Kepler(ex, comelem.Oe, m);
    num := sqrt(1.0 + comelem.Oe) * tan(ex / 2.0);  { meeus 25.1 }
    den := sqrt(1.0 - comelem.Oe);
    nu := 2.0 * arctan2(num, den);
    rs := da * (1.0 - comelem.Oe * cos(ex));   { meeus 25.2 }
  end;

  procedure parabolique;
  var
    w, s1, s: double;
  begin
    w := 3.649116245E-2 * (jd - comelem.Ot) / (comelem.Oq * sqrt(comelem.Oq));  { meeus 26.1 }
    s1 := 0.0;
    repeat                                    { meeus 26.4 }
      s := s1;
      s1 := (2.0 * s * s * s + w) / (3.0 * (s * s + 1.0));
    until ABS(s1 - s) < 1.0E-9;
    s := s1;
    nu := 2.0 * arctan(s);       { meeus 26.2 }
    rs := comelem.Oq * (1.0 + s * s);
  end;

  procedure hyperbolique;
  var
    da, m, u, u0, cnu: double;
  begin
    // The calculation of comet ephemerides,  Tatum, J, 1982JRASC..76..157T
    da := comelem.Oq / (comelem.Oe - 1);
    m := (pi2*(jd - comelem.Ot)/365.256363004)/ power(abs(da),3/2);
    u:=1.0;
    repeat
      u0 := u;
      u := 2*u0*abs(comelem.Oe - u*(1-abs(m)-ln(u0))) / (u0*(comelem.Oe*u0-2)+comelem.Oe);
    until abs(u - u0) < 1E-9;
    cnu := - (u*(u-2*comelem.Oe)+1) / (u*(comelem.Oe*u-2)+comelem.Oe);
    nu := arccos(cnu);
    nu := sgn(m)*abs(nu);
    rs := da*(comelem.Oe**2-1) / (1+(comelem.Oe*cnu));
  end;

begin
  nu := 0;
  if comelem.oe < 1 then
    eliptique;
  if comelem.oe = 1 then
    parabolique;
  if comelem.oe > 1 then
    hyperbolique;
  xc := rs * comelem.Oa * sin(comelem.Oaa + comelem.Oomi + nu); { meeus 25.14 }
  yc := rs * comelem.Ob * sin(comelem.Obb + comelem.Oomi + nu);
  zc := rs * comelem.Oc * sin(comelem.Occ + comelem.Oomi + nu);
end;

procedure TPlanet.Comet(jd: double; lightcor: boolean;
  var ar, de, dist, r, elong, phase, magn, diam, lc, car, cde, rc, xc, yc, zc: double);
var
  xs, ys, zs, rr, cxc, cyc, czc, n1, ll: double;
  n: integer;
begin
  SunRect(jd, xs, ys, zs);
  OrbRect(jd, xc, yc, zc, r);
  dist := sqrt((xc + xs) * (xc + xs) + (yc + ys) * (yc + ys) + (zc + zs) * (zc + zs));
  if lightcor then
  begin
    jd := jd - dist * tlight;
    OrbRect(jd, xc, yc, zc, r);
    dist := sqrt((xc + xs) * (xc + xs) + (yc + ys) * (yc + ys) + (zc + zs) * (zc + zs));
  end;
  ar := arctan2((yc + ys), (xc + xs));   { meeus 25.15 }
  ar := Rmod(ar + pi2, pi2);
  de := arcsin((zc + zs) / dist);
  rr := sqrt(xs * xs + ys * ys + zs * zs);
  n1 := (rr * rr + dist * dist - r * r) / (2.0 * rr * dist);
  if abs(n1) <= 1 then
    elong := arccos(n1)
  else
    elong := 0;
  n1 := (r * r + dist * dist - rr * rr) / (2.0 * r * dist);
  if abs(n1) <= 1 then
    phase := arccos(n1)
  else
    phase := 0;
  magn := comelem.Oh + 5.0 * log10(dist) + 2.5 * comelem.Og * log10(r);  { meeus 25.16 }
  { estimated coma diameter arcmin, personal empirical formula }
  diam := (max(0, 1 - ln(r)) / max(1, comelem.Oh - 2)) * 30 / dist;
  { estimated tail length UA, personal empirical formula }
  Lc := max(0, 1 - ln(r)) / power(max(1, comelem.Oh), 1.5);
  { apparent position of tail end}
  ll := lc;
  n := 0;
  repeat
    cxc := xc + ll * xc / r;
    cyc := yc + ll * yc / r;
    czc := zc + ll * zc / r;
    car := arctan2((ys + cyc), (xs + cxc));
    car := Rmod(car + pi2, pi2);
    rc := sqrt((cxc + xs) * (cxc + xs) + (cyc + ys) * (ys + cyc) + (czc + zs) * (czc + zs));
    cde := arcsin((czc + zs) / rc);
    ll := ll / 2;
    Inc(n);
  until (AngularDistance(ar, de, car, cde) < pid2) or (n > 5);
end;

procedure TPlanet.InitAsteroid(epoch, mh, mg, ma, ap, an, ic, ec, sa, eq: double; nam: string);
var
  i, Oma, ff, g, h, p, qq, r, ooe: double;
  sOma, cOma, soe, coe, si, ci: extended;
begin
  astelem.AsterName := nam;
  astelem.equinox := eq;
  astelem.At := epoch;
  astelem.Am := deg2rad * ma;
  astelem.Oomi := deg2rad * ap;
  Oma := deg2rad * an;
  i := deg2rad * ic;
  astelem.Oe := ec;
  astelem.Aa := sa;
  astelem.Ah := mh;
  astelem.Ag := mg;
  if astelem.equinox <> 2000 then
    PrecessElem(astelem.equinox, i, astelem.oomi, oma);
  ooe := deg2rad * 23.43929111; {j2000 meeus91 32.7}
  sincos(Oma, sOma, cOma);
  sincos(ooe, soe, coe);
  sincos(i, si, ci);
  ff := cOma;              { meus 25.13 }
  g := sOma * coe;
  h := sOma * soe;
  p := -sOma * ci;
  qq := cOma * ci * coe - si * soe;
  r := cOma * ci * soe + si * coe;
  astelem.Oaa := arctan2(ff, p);
  astelem.Obb := arctan2(g, qq);
  astelem.Occ := arctan2(h, r);
  astelem.Oa := sqrt(ff * ff + p * p);
  astelem.Ob := sqrt(g * g + qq * qq);
  astelem.Oc := sqrt(h * h + r * r);
end;

function TPlanet.AsteroidMag(phase,dist,r,h,g: double): double; inline; overload;
var phi1, phi2: double;
begin
  phi1 := exp(-3.33 * power(tan(phase / 2), 0.63));  { meeus91 32.14 }
  phi2 := exp(-1.87 * power(tan(phase / 2), 1.22));
  result := h + 5.0 * log10(dist * r) - 2.5 * log10((1 - g) * phi1 + g * phi2);
end;

function TPlanet.AsteroidMag(phase,dist,r,h,g1,g2: double): double; overload;
var phi1, phi2, phi3, g12: double;
begin
  // A Three-Parameter Magnitude Phase Function for Asteroids
  // Muinonen , 2010
  phi1:=1-6*phase/pi;
  phi2:=1-9*phase/(5*pi);
  phi3:=Exp(-4*pi*Power(tan(phase/2),2/3));
  if g2<0 then begin
    g12:=g1;
    if g12<0.2 then begin
      g1 := 0.7527*g12 + 0.06164;
      g2 := -0.9612*g12 + 0.6270;
    end
    else begin
      g1 := 0.9529*g12 + 0.02162;
      g2 := -0.6125*g12 + 0.5572;
    end;
  end;
  result := h + 5.0 * log10(dist * r) - 2.5 * log10( g1*phi1 + g2*phi2 + (1-g1-g2)*phi3 );
end;

procedure TPlanet.Asteroid(jd: double; highprec: boolean;
  var ar, de, dist, r, elong, phase, magn, xc, yc, zc: double);
var
  xs, ys, zs, rr: double;
  nu, da, n0, m, ex, num, den: double;

  procedure AstGeom;
  begin
    m := rmod(astelem.am + n0 * (jd - astelem.At), pi2);
    if highprec then
      Kepler(ex, astelem.Oe, m)
    else
      Kepler(ex, astelem.Oe, m, 1e-5);
    num := sqrt(1.0 + astelem.Oe) * tan(ex / 2.0);  { meeus 25.1 }
    den := sqrt(1.0 - astelem.Oe);
    nu := 2.0 * arctan2(num, den);
    r := da * (1.0 - astelem.Oe * cos(ex));   { meeus 25.2 }
    xc := r * astelem.Oa * sin((astelem.Oaa + astelem.Oomi + nu)); { meeus 25.14 }
    yc := r * astelem.Ob * sin((astelem.Obb + astelem.Oomi + nu));
    zc := r * astelem.Oc * sin((astelem.Occ + astelem.Oomi + nu));
    dist := sqrt((xc + xs) * (xc + xs) + (yc + ys) * (ys + yc) + (zc + zs) * (zc + zs));
  end;

begin
  da := astelem.Aa;                     { meeus 25.12 }
  n0 := 0.01720209895 / (da * sqrt(da));
  SunRect(jd, xs, ys, zs);
  AstGeom;
  if highprec then
  begin
    jd := jd - dist * tlight;
    AstGeom;
  end;
  ar := arctan2((ys + yc), (xs + xc));   { meeus 25.15 }
  ar := Rmod(ar + pi2, pi2);
  de := arcsin((zc + zs) / dist);
  rr := sqrt(xs * xs + ys * ys + zs * zs);
  elong := arccos((rr * rr + dist * dist - r * r) / (2.0 * rr * dist));
  phase := arccos((r * r + dist * dist - rr * rr) / (2.0 * r * dist));
  magn:=AsteroidMag(phase,dist,r,astelem.Ah,astelem.Ag);
end;

function TPlanet.ConnectDB(db: string): boolean;
begin
  try
    db := UTF8Encode(db);
    if db1.database <> db then
      db1.Use(db);
    if db2.database <> db then
      db2.Use(db);
    Result := db1.Active and db2.Active;
    DB1.Query('PRAGMA journal_mode = MEMORY');
    DB1.Query('PRAGMA synchronous = OFF');
    DB1.Query('PRAGMA case_sensitive_like = 1');
    DB1.Query('PRAGMA cache_size = -102400');
    DB1.Query('PRAGMA temp_store = MEMORY');
    DB2.Query('PRAGMA journal_mode = MEMORY');
    DB2.Query('PRAGMA synchronous = OFF');
    DB2.Query('PRAGMA case_sensitive_like = 1');
    DB2.Query('PRAGMA cache_size = -102400');
    DB2.Query('PRAGMA temp_store = MEMORY');
  except
    Result := False;
  end;
end;

function TPlanet.NewAstDay(newjd, limitmag: double; cfgsc: Tconf_skychart): boolean;
var qry: string;
  currentjd, jd1, dt, t: double;
  njd, currentmag, lmag: integer;
  i,idx: integer;
  id: string;
  imag, ira, idec, nea: integer;
  dist, r, elong, phase, h, g, ma, ap, an, ic, ec, sa, eq, epoch, ra, Dec, mag, xc, yc, zc: double;
  nam,ref: string;
begin
  try
    lmag := round(limitmag * 10);
    qry := 'SELECT jd,limit_mag from ' + cfgsc.ast_day;
    db1.Query(qry);
    if db1.Rowcount > 0 then
    begin
      currentjd := StrToInt(db1.Results[0][0]);
      currentmag := StrToInt(db1.Results[0][1]);
    end
    else
    begin
      currentjd := -99999999;
      currentmag := -999;
    end;
    if (currentjd = trunc(newjd)) and (currentmag = lmag) then
      Result := True
    else
    begin
      if cfgsc.ast_day <> db1.QueryOne(showtable + ' "' + cfgsc.ast_day + '"') then
        db1.Query('CREATE TABLE ' + cfgsc.ast_day + create_table_ast_day);
      if cfgsc.ast_daypos <> db1.QueryOne(showtable + ' "' + cfgsc.ast_daypos + '"') then
      begin
        db1.Query('CREATE TABLE ' + cfgsc.ast_daypos + create_table_ast_day_pos);
        db1.Query('CREATE UNIQUE INDEX IDX_' + cfgsc.ast_daypos + ' ON ' +
          cfgsc.ast_daypos + ' (id,epoch)');
        db1.Query('CREATE INDEX IDX2_' + cfgsc.ast_daypos + ' ON ' +
          cfgsc.ast_daypos + ' (near_earth)');
      end;
      if cdb.NumAsteroidMagnitudesJD > 0 then
      begin
        njd:=0;
        jd1 := cdb.AsteroidMagnitudesJD[0];
        dt := abs(newjd - jd1);
        i := 1;
        while i < cdb.NumAsteroidMagnitudesJD do
        begin
          t := cdb.AsteroidMagnitudesJD[1];
          if abs(newjd - t) < dt then
          begin
            njd:=i;
            jd1 := t;
            dt := abs(newjd - t);
          end;
          Inc(i);
        end;
        if dt > 16 then
        begin
          Result := False;
          exit;
        end;
        jdnew := newjd;
        jdchart := cfgsc.JDChart;
        ast_daypos := cfgsc.ast_daypos;
        db2.UnLockTables;
        db2.StartTransaction;
        db2.TruncateTable(cfgsc.ast_day);
        db2.TruncateTable(cfgsc.ast_daypos);
        db2.LockTables(cfgsc.ast_day + ' WRITE, ' + cfgsc.ast_daypos + ' WRITE');
        ////////////////////////////

        for i:=0 to cdb.NumAsteroidMagnitude-1 do begin
          if cdb.AsteroidMagnitudes[njd,i].magnitude<=lmag then begin
            idx := cdb.AsteroidMagnitudes[njd,i].elementidx;
            id := cdb.AsteroidElement[idx].id;
            cdb.GetAstElem(idx,epoch,h,g,ma,ap,an,ic,ec,sa,eq,ref,nam);
            InitAsteroid(epoch, h, g, ma, ap, an, ic, ec, sa, eq, nam);
            Asteroid(jdnew, False, ra, Dec, dist, r, elong, phase, mag, xc, yc, zc);
            precession(jd2000, jdchart, ra, Dec);
            ira := round(ra * 1000);
            idec := round(Dec * 1000);
            imag := round(mag * 10);
            if dist < NEO_dist then
              nea := 1
            else
              nea := 0;
            qry := 'INSERT INTO ' + ast_daypos + ' (id,epoch,ra,de,mag,near_earth,idx) VALUES ('
              + '"' + id + '"' + ',' + strim(formatfloat(f6s, epoch)) +
              ',' + IntToStr(ira) + ',' +
              IntToStr(idec) +  ',' + IntToStr(imag) +
              ',' + IntToStr(nea) +',' + IntToStr(idx) + ')';
            db2.Query(qry);
          end;
        end;

        ////////////////////////////

        qry := 'INSERT INTO ' + cfgsc.ast_day + ' (jd,limit_mag)' +
          ' VALUES (' + IntToStr(trunc(newjd)) + ',' + IntToStr(lmag) + ')';
        db2.Query(qry);
        db2.UnLockTables;
        db2.Commit;
        db2.flush('tables');
        Result := True;
      end
      else
      begin
        Result := False;
        exit;
      end;
    end;
  except
    Result := False;
  end;
end;

function TPlanet.NewComDay(newjd, limitmag: double; cfgsc: Tconf_skychart): boolean;
var
  qry: string;
  currentjd: double;
  currentmag, lmag: integer;
begin
  try
    lmag := round(limitmag * 10);
    qry := 'SELECT jd,limit_mag from ' + cfgsc.com_day;
    db1.Query(qry);
    if db1.Rowcount > 0 then
    begin
      currentjd := StrToInt(db1.Results[0][0]);
      currentmag := StrToInt(db1.Results[0][1]);
    end
    else
    begin
      currentjd := -99999999;
      currentmag := -999;
    end;
    if (currentjd = trunc(newjd)) and (currentmag = lmag) then
    begin
      Result := True;
      cdb.ComMinDT := 0;
    end
    else
    begin
      if cfgsc.com_day <> db1.QueryOne(showtable + ' "' + cfgsc.com_day + '"') then
        db1.Query('CREATE TABLE ' + cfgsc.com_day + create_table_com_day);
      if cfgsc.com_daypos <> db1.QueryOne(showtable + ' "' + cfgsc.com_daypos + '"') then
      begin
        db1.Query('CREATE TABLE ' + cfgsc.com_daypos + create_table_com_day_pos);
        db1.Query('CREATE UNIQUE INDEX IDX_' + cfgsc.com_daypos + ' ON ' +
          cfgsc.com_daypos + ' (id,epoch)');
        db1.Query('CREATE INDEX IDX2_' + cfgsc.com_daypos + ' ON ' +
          cfgsc.com_daypos + ' (near_earth)');
      end;
      db1.UnLockTables;
      db1.StartTransaction;
      db1.TruncateTable(cfgsc.com_day);
      db1.TruncateTable(cfgsc.com_daypos);
      db1.LockTables(cfgsc.com_day + ' WRITE, ' + cfgsc.com_daypos +
        ' WRITE, cdc_com_elem READ');
      qry := 'SELECT distinct(id) from cdc_com_elem';
      db2.CallBackOnly := True;
      db2.OnFetchRow := @NewComDayCallback;
      jdnew := newjd;
      jdchart := cfgsc.JDChart;
      com_daypos := cfgsc.com_daypos;
      com_limitmag := limitmag;
      n_com := 0;
      db2.Query(qry);
      db2.CallBackOnly := False;
      db2.OnFetchRow := nil;
      if n_com > 0 then
      begin
        Result := True;
        qry := 'INSERT INTO ' + cfgsc.com_day + ' (jd,limit_mag)' +
          ' VALUES ("' + IntToStr(trunc(newjd)) + '","' + IntToStr(lmag) + '")';
        db1.Query(qry);
        db1.UnLockTables;
        db1.Commit;
        db1.flush('tables');
      end
      else
      begin
        Result := False;
        db1.UnLockTables;
        db1.Commit;
        db1.flush('tables');
      end;
    end;
  except
    Result := False;
    db2.CallBackOnly := False;
    db2.OnFetchRow := nil;
  end;
end;

procedure TPlanet.NewComDayCallback(Sender: TObject; Row: TResultRow);
var
  qry, id, elem_id: string;
  imag, ira, idec, neo: integer;
  dist, r, elong, phase, h, g, ap, an, ic, ec, eq, epoch, ra, Dec, mag, tp, q, diam,
  lc, car, cde, rc, xc, yc, zc: double;
  nam: string;
begin
  id := row[0];
  if cdb.GetComElemEpoch(id, jdnew, epoch, tp, q, ec, ap, an, ic, h, g, eq, nam, elem_id) then
  begin
    Inc(n_com);
    InitComet(tp, q, ec, ap, an, ic, h, g, eq, nam);
    Comet(jdnew, False, ra, Dec, dist, r, elong, phase, mag, diam, lc, car, cde, rc, xc, yc, zc);
    if mag < com_limitmag then
    begin
      precession(jd2000, jdchart, ra, Dec);
      ira := round(ra * 1000);
      idec := round(Dec * 1000);
      imag := round(mag * 10);
      if dist < NEO_dist then
        neo := 1
      else
        neo := 0;
      qry := 'INSERT INTO ' + com_daypos + ' (id,epoch,ra,de,mag,near_earth) VALUES ('
        + '"' + id + '"' + ',"' + formatfloat(f1, epoch) +
        '"' + ',"' + IntToStr(ira) + '"' + ',"' +
        IntToStr(idec) + '"' + ',"' + IntToStr(imag) + '"' +
        ',"' + IntToStr(neo) + '")';
      db1.Query(qry);
    end;
  end;
end;

function TPlanet.Body(jdt: double; target: integer; var ra, de, dist, r: double): boolean;
var pv: TDoubleArray;
    xs, ys, zs, x, y, z, lt, jdlt,qr: double;
begin
  Barycenter(jdt, xs, ys, zs);
  if CalcephComputeBody(jdt, target, 0, pv) then begin
     r:=pv[0]*pv[0]+pv[1]*pv[1]+pv[2]*pv[2];
     x := xs + pv[0];
     y := ys + pv[1];
     z := zs + pv[2];
     dist := sqrt(x*x+y*y+z*z);
     lt := dist * km_au / clight;
     jdlt := jdt-(lt/secday);
     if CalcephComputeBody(jdlt, target, 0, pv) then begin
       x := xs + pv[0];
       y := ys + pv[1];
       z := zs + pv[2];
       dist := sqrt(x*x+y*y+z*z);
     end;
     ra := arctan2(y, x);
     if (ra < 0) then
       ra := ra + 2 * pi;
     qr := sqrt(x*x + y*y);
     if qr <> 0 then
       de := arctan(z / qr)
     else
       de := 0;
     result:=true;

  end
  else
    result:=false;
end;


procedure TPlanet.ComputeBodies(cfgsc: Tconf_skychart);
  var
    ra, de, dist, r, jdt, jdlt, st0, q, qr: double;
    j, i, SimNb, target: integer;
    pv: TDoubleArray;
    xs, ys, zs, x, y, z, lt: double;
begin
  try
    while lockdb do
    begin
      sleep(10);
      application.ProcessMessages;
    end;
    lockdb := True;
    cfgsc.BodiesNb := 0;
      if cfgsc.SimObject[14] then
        SimNb := min(cfgsc.Simnb, MaxAstSim)
      else
        SimNb := 1;
      if SimNb > Length(cfgsc.BodiesLst) then
      begin
        SetLength(cfgsc.BodiesLst, SimNb);
        SetLength(cfgsc.BodiesName, SimNb);
      end;
      for j := 0 to SimNb - 1 do
      begin
        jdt := cfgsc.CurJDTT + j * cfgsc.SimD + j * cfgsc.SimH / 24 + j * cfgsc.SimM / 60 /
          24 + j * cfgsc.SimS / 3600 / 24;
        st0 := Rmod(cfgsc.CurST + 1.00273790935 *
          (j * cfgsc.SimD * 24 + j * cfgsc.SimH + j * cfgsc.SimM / 60 + j * cfgsc.SimS / 3600) * 15 * deg2rad, pi2);
        Barycenter(jdt, xs, ys, zs);
        cfgsc.BodiesNb := Length(cfgsc.SPKBodies);
        for i := 0 to cfgsc.BodiesNb - 1 do
        begin
         target := cfgsc.SPKBodies[i];
         if (cfgsc.SimBody<0)or(cfgsc.SimBody=target) then begin
           cfgsc.BodiesName[j, i + 1, 2] := cfgsc.SPKNames[i];
           cfgsc.BodiesLst[j, i + 1, 5] := -1;
           if CalcephComputeBody(jdt, target, 0, pv) then begin
             x := xs + pv[0];
             y := ys + pv[1];
             z := zs + pv[2];
             dist := sqrt(x*x+y*y+z*z);
             lt := dist * km_au / clight;
             jdlt := jdt-(lt/secday);
             if CalcephComputeBody(jdlt, target, 0, pv) then begin
               r:=sqrt(pv[0]*pv[0]+pv[1]*pv[1]+pv[2]*pv[2]);
               x := xs + pv[0];
               y := ys + pv[1];
               z := zs + pv[2];
               dist := sqrt(x*x+y*y+z*z);
             end;
             ra := arctan2(y, x);
             if (ra < 0) then
               ra := ra + 2 * pi;
             qr := sqrt(x*x + y*y);
             if qr <> 0 then
               de := arctan(z / qr)
             else
               de := 0;
             cfgsc.BodiesLst[j, i + 1, 6] := ra;
             cfgsc.BodiesLst[j, i + 1, 7] := de;
             precession(jd2000, cfgsc.jdchart, ra, de);
             if cfgsc.PlanetParalaxe then
                Paralaxe(st0, dist, ra, de, ra, de, q, cfgsc);
              if cfgsc.ApparentPos then
                apparent_equatorial(ra, de, cfgsc, True, False);
              cfgsc.BodiesName[j, i + 1, 1] := inttostr(target);
              cfgsc.BodiesLst[j, i + 1, 1] := ra;
              cfgsc.BodiesLst[j, i + 1, 2] := de;
              cfgsc.BodiesLst[j, i + 1, 3] := r;
              cfgsc.BodiesLst[j, i + 1, 4] := jdt;
              cfgsc.BodiesLst[j, i + 1, 5] := dist;
           end
           else begin
             cfgsc.BodiesName[j, i + 1, 2] := '';
             cfgsc.msg := cu_calceph.LastError;
           end;
          end;
        end;
      end;
  finally
    lockdb := False;
  end;
end;

procedure TPlanet.ComputeAsteroid(cfgsc: Tconf_skychart);
var
  ra, Dec, dist, r, elong, phase, magn, jdt, st0, q: double;
  epoch, h, g, ma, ap, an, ic, ec, sa, eq, d, da, xc, yc, zc: double;
  qry, ref, nam: string;
  j, i, SimNb, idx: integer;
begin
  try
    while lockdb do
    begin
      sleep(10);
      application.ProcessMessages;
    end;
    lockdb := True;
    cdb.AstMsg := '';
    cfgsc.ast_day := 'cdc_ast_day_' + cfgsc.chartname;
    cfgsc.ast_daypos := 'cdc_ast_day_pos_' + cfgsc.chartname;
    cfgsc.AsteroidNb := 0;
    if not db1.Active then
      cfgsc.ShowAsteroid := False;
    if not cfgsc.ShowAsteroidValid then
      exit;
    if not NewAstDay(cfgsc.CurJDTT, cfgsc.AstmagMax, cfgsc) then
    begin
      cfgsc.ShowAsteroid := False;
      exit;
    end;
    d := MaxValue([0.6 * cfgsc.fov, 0.09]);
    da := d / cos(cfgsc.decentre);
    qry := 'SELECT id,epoch,idx from ' + cfgsc.ast_daypos + ' where';
    qry := qry + ' (mag<=' + IntToStr(round((cfgsc.StarMagMax + cfgsc.AstMagDiff) * 10)) + ' and';
    if cfgsc.NP or cfgsc.SP then
      qry := qry + ' (ra>0 and ra<' + IntToStr(round(1000 * (pi2))) + ')'
    else if (cfgsc.racentre + da) > pi2 then
      qry := qry + ' (ra>' + IntToStr(round(1000 * (cfgsc.racentre - da))) +
        ' or ra<' + IntToStr(round(1000 * (cfgsc.racentre + da - pi2))) + ')'
    else if (cfgsc.racentre - da) < 0 then
      qry := qry + ' (ra>' + IntToStr(round(1000 * (cfgsc.racentre - da + pi2))) +
        ' or ra<' + IntToStr(round(1000 * (cfgsc.racentre + da))) + ')'
    else
      qry := qry + ' (ra>' + IntToStr(round(1000 * (cfgsc.racentre - da))) +
        ' and ra<' + IntToStr(round(1000 * (cfgsc.racentre + da))) + ')';

    qry := qry + ' and (de>' + IntToStr(round(1000 * (cfgsc.decentre - d))) +
      ' and de<' + IntToStr(round(1000 * (cfgsc.decentre + d))) + '))';
    if cfgsc.AstNEO then
      qry := qry + ' or (near_earth=1)';
    if searchid <> '' then
      qry := qry + ' or (id="' + searchid + '")';
    if cfgsc.SimAsteroid >=0  then
      qry := qry + ' or (idx=' + inttostr(cfgsc.SimAsteroid) + ')';
    qry := qry + ' limit ' + IntToStr(MaxAsteroid);
    db2.Query(qry);
    if db2.Rowcount > 0 then
    begin
      if db2.Rowcount = MaxAsteroid then
        cfgsc.msg := cfgsc.msg + 'More than ' + IntToStr(MaxAsteroid) + ' asteroids, result truncated!';
      if cfgsc.SimObject[12] then
        SimNb := min(cfgsc.Simnb, MaxAstSim)
      else
        SimNb := 1;
      if SimNb > cfgsc.AsteroidLstSize then
      begin
        SetLength(cfgsc.AsteroidLst, SimNb);
        SetLength(cfgsc.AsteroidName, SimNb);
        cfgsc.AsteroidLstSize := SimNb;
      end;
      for j := 0 to SimNb - 1 do
      begin
        jdt := cfgsc.CurJDTT + j * cfgsc.SimD + j * cfgsc.SimH / 24 + j * cfgsc.SimM / 60 /
          24 + j * cfgsc.SimS / 3600 / 24;
        st0 := Rmod(cfgsc.CurST + 1.00273790935 *
          (j * cfgsc.SimD * 24 + j * cfgsc.SimH + j * cfgsc.SimM / 60 + j * cfgsc.SimS / 3600) * 15 * deg2rad, pi2);
        for i := 0 to db2.Rowcount - 1 do
        begin
         idx := strtoint(strim(db2.Results[i][2]));
         if (cfgsc.SimAsteroid<0)or(cfgsc.SimAsteroid=idx) then begin
          epoch := strtofloat(strim(db2.Results[i][1]));
          if (idx>=0)and(idx<cdb.NumAsteroidElement) then
          begin
            cdb.GetAstElem(idx,epoch,h,g,ma,ap,an,ic,ec,sa,eq,ref,nam);
            InitAsteroid(epoch, h, g, ma, ap, an, ic, ec, sa, eq, nam);
            Asteroid(jdt, True, ra, Dec, dist, r, elong, phase, magn, xc, yc, zc);
            cfgsc.AsteroidLst[j, i + 1, 6] := ra;
            cfgsc.AsteroidLst[j, i + 1, 7] := Dec;
            precession(jd2000, cfgsc.jdchart, ra, Dec);
            if cfgsc.PlanetParalaxe then
              Paralaxe(st0, dist, ra, Dec, ra, Dec, q, cfgsc);
            if cfgsc.ApparentPos then
              apparent_equatorial(ra, Dec, cfgsc, True, False);
            cfgsc.AsteroidName[j, i + 1, 1] := inttostr(idx);
            cfgsc.AsteroidName[j, i + 1, 2] := nam;
            cfgsc.AsteroidLst[j, i + 1, 1] := ra;
            cfgsc.AsteroidLst[j, i + 1, 2] := Dec;
            cfgsc.AsteroidLst[j, i + 1, 3] := magn;
            cfgsc.AsteroidLst[j, i + 1, 4] := jdt;
            cfgsc.AsteroidLst[j, i + 1, 5] := epoch;
          end;
         end
         else begin
           cfgsc.AsteroidName[j, i + 1, 1] := inttostr(idx);
           cfgsc.AsteroidLst[j, i + 1, 5] := -1;
         end;
        end;
      end;
    end;
    cfgsc.AsteroidNb := db2.Rowcount;
    cfgsc.msg := cfgsc.msg + blank + cdb.AstMsg;
  finally
    lockdb := False;
  end;
end;

procedure TPlanet.ComputeComet(cfgsc: Tconf_skychart);
var
  ra, Dec, dist, r, elong, phase, magn, jdt, st0, q: double;
  epoch, h, g, ap, an, ic, ec, eq, d, da, tp, diam, lc, car, cde, rc, xc, yc, zc: double;
  qry, id, nam, elem_id: string;
  j, i, SimNb: integer;
begin
  try
    while lockdb do
    begin
      sleep(10);
      application.ProcessMessages;
    end;
    lockdb := True;
    cdb.ComMinDT := MaxInt;
    cfgsc.com_day := 'cdc_com_day_' + cfgsc.chartname;
    cfgsc.com_daypos := 'cdc_com_day_pos_' + cfgsc.chartname;
    cfgsc.CometNb := 0;
    if not db1.Active then
      cfgsc.ShowComet := False;
    if not cfgsc.ShowCometValid then
      exit;
    if not NewComDay(cfgsc.CurJDTT, cfgsc.CommagMax, cfgsc) then
    begin
      cfgsc.ShowComet := False;
      exit;
    end;
    d := MaxValue([0.6 * cfgsc.fov, 0.09]);
    da := d / cos(cfgsc.decentre);
    qry := 'SELECT id,epoch from ' + cfgsc.com_daypos + ' where';
    if cfgsc.StarFilter then
      qry := qry + ' (mag<=' + IntToStr(round((cfgsc.StarMagMax + cfgsc.ComMagDiff) * 10)) + ' and';
    if cfgsc.NP or cfgsc.SP then
      qry := qry + ' (ra>0 and ra<' + IntToStr(round(1000 * (pi2))) + ')'
    else if (cfgsc.racentre + da) > pi2 then
      qry := qry + ' (ra>' + IntToStr(round(1000 * (cfgsc.racentre - da))) +
        ' or ra<' + IntToStr(round(1000 * (cfgsc.racentre + da - pi2))) + ')'
    else if (cfgsc.racentre - da) < 0 then
      qry := qry + ' (ra>' + IntToStr(round(1000 * (cfgsc.racentre - da + pi2))) +
        ' or ra<' + IntToStr(round(1000 * (cfgsc.racentre + da))) + ')'
    else
      qry := qry + ' (ra>' + IntToStr(round(1000 * (cfgsc.racentre - da))) +
        ' and ra<' + IntToStr(round(1000 * (cfgsc.racentre + da))) + ')';

    qry := qry + ' and (de>' + IntToStr(round(1000 * (cfgsc.decentre - d))) +
      ' and de<' + IntToStr(round(1000 * (cfgsc.decentre + d))) + '))' + ' or (near_earth=1)';
    if searchid <> '' then
      qry := qry + ' or (id="' + searchid + '")';
    if cfgsc.SimComet <> '' then
      qry := qry + ' or (id="' + cfgsc.SimComet + '")';
    qry := qry + ' limit ' + IntToStr(MaxComet);
    db2.Query(qry);
    if db2.Rowcount > 0 then
    begin
      if cfgsc.SimObject[13] then
        SimNb := min(cfgsc.Simnb, MaxAstSim)
      else
        SimNb := 1;
      if SimNb > cfgsc.CometLstSize then
      begin
        SetLength(cfgsc.CometLst, SimNb);
        SetLength(cfgsc.CometName, SimNb);
        cfgsc.CometLstSize := SimNb;
      end;
      for j := 0 to SimNb - 1 do
      begin
        jdt := cfgsc.CurJDTT + j * cfgsc.SimD + j * cfgsc.SimH / 24 + j * cfgsc.SimM / 60 /
          24 + j * cfgsc.SimS / 3600 / 24;
        st0 := Rmod(cfgsc.CurST + 1.00273790935 *
          (j * cfgsc.SimD * 24 + j * cfgsc.SimH + j * cfgsc.SimM / 60 + j * cfgsc.SimS / 3600) * 15 * deg2rad, pi2);
        for i := 0 to db2.Rowcount - 1 do
        begin
         id := db2.Results[i][0];
         if (cfgsc.SimComet='')or(cfgsc.SimComet=id) then begin
          epoch := strtofloat(strim(db2.Results[i][1]));
          if cdb.GetComElem(id, epoch, tp, q, ec, ap, an, ic, h, g, eq, nam, elem_id) then
          begin
            InitComet(tp, q, ec, ap, an, ic, h, g, eq, nam);
            Comet(jdt, True, ra, Dec, dist, r, elong, phase, magn, diam, lc, car, cde, rc, xc, yc, zc);
            cfgsc.CometLst[j, i + 1, 9] := ra;
            cfgsc.CometLst[j, i + 1, 10] := Dec;
            precession(jd2000, cfgsc.jdchart, ra, Dec);
            precession(jd2000, cfgsc.jdchart, car, cde);
            if cfgsc.PlanetParalaxe then
            begin
              Paralaxe(st0, dist, ra, Dec, ra, Dec, q, cfgsc);
              Paralaxe(st0, rc, car, cde, car, cde, q, cfgsc);
            end;
            if cfgsc.ApparentPos then
            begin
              apparent_equatorial(ra, Dec, cfgsc, True, False);
              apparent_equatorial(car, cde, cfgsc, True, False);
            end;
            cfgsc.CometName[j, i + 1, 1] := id;
            cfgsc.CometName[j, i + 1, 2] := nam;
            cfgsc.CometLst[j, i + 1, 1] := ra;
            cfgsc.CometLst[j, i + 1, 2] := Dec;
            cfgsc.CometLst[j, i + 1, 3] := magn;
            cfgsc.CometLst[j, i + 1, 4] := diam;
            cfgsc.CometLst[j, i + 1, 5] := car;
            cfgsc.CometLst[j, i + 1, 6] := cde;
            cfgsc.CometLst[j, i + 1, 7] := jdt;
            cfgsc.CometLst[j, i + 1, 8] := epoch;
          end;
         end
         else begin
           cfgsc.CometName[j, i + 1, 1] := id;
           cfgsc.CometLst[j, i + 1, 8] := -1;
         end;
        end;
      end;
    end;
    cfgsc.CometNb := db2.Rowcount;
    if cdb.ComMinDT > 180 then
      cfgsc.msg := cfgsc.msg + blank + rsWarningSomeC;
  finally
    lockdb := False;
  end;
end;

procedure TPlanet.FindAsteroidIndex(astname: string; out idx:integer);
var i: integer;
   s1: string;
begin
  idx:=-1;
  // load search name cache on first search
  if cdb.NumAsteroidSearchNames<>cdb.NumAsteroidElement then
    cdb.LoadAsteroidSearchNames;

  // case insensitive and without blank space
  s1 := UpperCase(StringReplace(astname,' ','',[rfReplaceAll]));
  if s1 = '' then
    exit;

  // exact search
  for i:=0 to cdb.NumAsteroidElement-1 do begin
    if s1=cdb.AsteroidSearchNames[i].searchname then begin
      idx:=cdb.AsteroidSearchNames[i].elementidx;
      break;
    end;
  end;
  if idx<0 then begin
    // search
    for i:=0 to cdb.NumAsteroidElement-1 do begin
      if pos(s1,cdb.AsteroidSearchNames[i].searchname)>0 then begin
        idx:=cdb.AsteroidSearchNames[i].elementidx;
        break;
      end;
    end;
  end;
end;

function TPlanet.FindAsteroidName(astname: string; var ra, de, mag: double; cfgsc: Tconf_skychart; upddb: boolean; MeanPos: boolean = False): boolean;
var
  dist, r, elong, phase, rad, ded: double;
  epoch, h, g, ma, ap, an, ic, ec, sa, eq, xc, yc, zc: double;
  qry, id, ref, nam: string;
  idx, ira, idec, imag: integer;
begin
  Result := False;
  searchid := '';

  if (cdb.NumAsteroidElement=0) or (not cfgsc.ephvalid) then
    exit;

  FindAsteroidIndex(astname,idx);

  // not found
  if idx < 0 then
    exit;

  // compute position
  id := cdb.AsteroidElement[idx].id;
  cdb.GetAstElem(idx,epoch,h,g,ma,ap,an,ic,ec,sa,eq,ref,nam);
  InitAsteroid(epoch, h, g, ma, ap, an, ic, ec, sa, eq, nam);
  Asteroid(cfgsc.CurJDTT, True, ra, de, dist, r, elong, phase, mag, xc, yc, zc);
  Result := True;
  if MeanPos then
    exit;
  if cfgsc.PlanetParalaxe then
    Paralaxe(cfgsc.CurST, dist, ra, de, ra, de, r, cfgsc);

  // store to show on the chart
  if upddb then
  begin
    rad := ra;
    ded := de;
    precession(jd2000, cfgsc.jdchart, rad, ded);
    ira := round(rad * 1000);
    idec := round(ded * 1000);
    imag := round(mag * 10);
    qry := 'INSERT INTO ' + cfgsc.ast_daypos + ' (id,epoch,ra,de,mag,idx) VALUES ('
      + '"' + id + '"' + ',' + strim(formatfloat(f6s, epoch)) +
      ',' + IntToStr(ira) + ',' + IntToStr(
      idec) + ',' + IntToStr(imag) + ',' + IntToStr(idx) + ')';
    db1.Query(qry);
    db1.flush('tables');
    searchid := id;
  end;
end;

procedure TPlanet.FindCometId(comname: string; out id: string);
var s1,qry: string;
begin
  id:='';
  if (not db1.Active) then
    exit;

  s1 := UpperCase(StringReplace(comname,' ','',[rfReplaceAll]));
  if s1 = '' then
    exit;

  qry := 'SELECT id FROM cdc_com_name' + ' where UPPER(REPLACE(name,'' '','''')) = "' + s1 + '"';
  db1.Query(qry);
  if db1.Rowcount > 0 then
    id := db1.Results[0][0];
end;

function TPlanet.FindCometName(comname: string; var ra, de, mag: double;
  cfgsc: Tconf_skychart; upddb: boolean; MeanPos: boolean = False): boolean;
var
  dist, r, elong, phase, rad, ded: double;
  epoch, h, g, ap, an, ic, ec, eq, tp, q, diam, lc, car, cde, rc, xc, yc, zc: double;
  qry, id, nam, elem_id, s1: string;
  ira, idec, imag: integer;
begin
  Result := False;
  searchid := '';
  if (not db1.Active) or (not cfgsc.ephvalid) then
    exit;

  s1 := UpperCase(StringReplace(comname,' ','',[rfReplaceAll]));
  if s1 = '' then
    exit;

  if IsNumber(trim(comname)) then
    exit;

  id := '';

  qry := 'SELECT id FROM cdc_com_name' + ' where UPPER(name) = "' + s1 + '"';
  db1.Query(qry);
  if db1.Rowcount > 0 then
    id := db1.Results[0][0];

  if id = '' then
  begin
    qry := 'SELECT id FROM cdc_com_name' + ' where UPPER(name) like "%' + s1 + '%"' + ' limit 1';
    db1.Query(qry);
    if db1.RowCount > 0 then
      id := db1.Results[0][0];
  end;

  if id = '' then
  begin
    qry := 'SELECT id FROM cdc_com_name' + ' where UPPER(REPLACE(name,'' '','''')) = "' + s1 + '"';
    db1.Query(qry);
    if db1.Rowcount > 0 then
      id := db1.Results[0][0];
  end;

  if id = '' then
  begin
    qry := 'SELECT id FROM cdc_com_name' + ' where UPPER(REPLACE(name,'' '','''')) like "%' + s1 + '%"' + ' limit 1';
    db1.Query(qry);
    if db1.RowCount > 0 then
      id := db1.Results[0][0];
  end;

  if id = '' then
    exit;

  if cdb.GetComElemEpoch(id, cfgsc.CurJDTT, epoch, tp, q, ec, ap, an, ic, h, g, eq, nam, elem_id) then
  begin
    InitComet(tp, q, ec, ap, an, ic, h, g, eq, nam);
    Comet(cfgsc.CurJDTT, True, ra, de, dist, r, elong, phase, mag, diam, lc, car, cde, rc, xc, yc, zc);
    Result := True;
    if MeanPos then
      exit;
    if cfgsc.PlanetParalaxe then
      Paralaxe(cfgsc.CurST, dist, ra, de, ra, de, r, cfgsc);
    if upddb then
    begin
      rad := ra;
      ded := de;
      precession(jd2000, cfgsc.jdchart, rad, ded);
      ira := round(rad * 1000);
      idec := round(ded * 1000);
      imag := round(mag * 10);
      qry := 'INSERT INTO ' + cfgsc.com_daypos + ' (id,epoch,ra,de,mag) VALUES ('
        + '"' + id + '"' + ',"' + formatfloat(f1, epoch) + '"'
        + ',"' + IntToStr(ira) + '"' + ',"' + IntToStr(idec) +
        '"' + ',"' + IntToStr(imag) + '")';
      db1.Query(qry);
      qry := db1.ErrorMessage;
      db1.flush('tables');
      searchid := id;
    end;
  end
  else
    Result := False;
end;

function TPlanet.FindBody(x1, y1, x2, y2: double; nextobj: boolean;cfgsc: Tconf_skychart; var nom, mag, date, desc: string; trunc: boolean = True): boolean;
var
  yy, mm, dd: integer;
  tar, tde: double;
  dist, r: double;
  target: string;
  jdt, hh, jd0, st0, ar, de, q, dm,pa,dx,dy: double;
  sar, sde, shh, sdp, sdist, sdpkm, sdistkm: string;
const
  d1 = '0.0';
  d2 = '0.00';
begin
  if not nextobj then
  begin
    CurrentBodyStep := 0;
    CurrentBody := 0;
  end;
  Result := False;
  desc := '';
  tar := 1;
  tde := 1;
  if cfgsc.ShowBodiesValid and (cfgsc.BodiesNb > 0) then
    repeat
      Inc(CurrentBody);
      if CurrentBody > cfgsc.BodiesNb then
      begin
        Inc(CurrentBodyStep);
        if (not cfgsc.SimObject[14]) or nextobj or (CurrentBodyStep >= cfgsc.SimNb) then
          break
        else
        begin
          CurrentBody := 0;
          continue;
        end;
      end;
      if cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 5]<0 then continue;
      tar := NormRa(cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 1]);
      tde := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 2];
      // search if at the position
      if trunc then
      begin
        if (tar < x1) or (tar > x2) or (tde < y1) or (tde > y2) then
        begin
          // no
          Result := False;
        end
        else
          Result := True;
      end
      else
        Result := True;
    until Result;
  cfgsc.FindOK := Result;
  if Result then
  begin
    cfgsc.FindSize := 0;
    cfgsc.FindRA := tar;
    cfgsc.FindDec := tde;
    cfgsc.FindPM := False;
    cfgsc.FindType := ftBody;
    cfgsc.TrackRA := cfgsc.FindRA;
    cfgsc.TrackDec := cfgsc.FindDec;
    cfgsc.TrackEpoch := cfgsc.JDChart;
    sar := ARpToStr(rad2deg * tar / 15);
    sde := DEpToStr(rad2deg * tde);
    jdt := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 4];
    cfgsc.FindSimjd := jdt;
    djd(jdt + (cfgsc.TimeZone - cfgsc.DT_UT) / 24, yy, mm, dd, hh);
    jd0 := jd(yy, mm, dd, 0);
    st0 := SidTim(jd0, hh - cfgsc.TimeZone, cfgsc.ObsLongitude);
    shh := ARtoStr3(rmod(hh, 24));
    date := Date2Str(yy, mm, dd) + blank + shh;
    cfgsc.FindRA2000 := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 6];
    cfgsc.FindDec2000 := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 7];
    cfgsc.FindDist := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 5];
    if ServerCoordSystem=csJ2000 then begin
       ar := cfgsc.FindRA2000;
       de := cfgsc.FindDec2000;
       if cfgsc.PlanetParalaxe then
          Paralaxe(st0, cfgsc.FindDist, ar, de, ar, de, q, cfgsc);
       cfgsc.FindDesc2000 := ARpToStr(rmod(24+rad2deg * ar / 15,24)) + tab + DEpToStr(rad2deg * de);
    end
    else
       cfgsc.FindDesc2000 := '';
    target := cfgsc.BodiesName[CurrentBodyStep, CurrentBody,1];
    nom := cfgsc.BodiesName[CurrentBodyStep, CurrentBody,2];
    r := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 3];
    dist := cfgsc.BodiesLst[CurrentBodyStep, CurrentBody, 5];
    str(r: 7: 4, sdp);
    str(dist: 7: 4, sdist);
    str(r*km_au: 7: 0, sdpkm);
    str(dist*km_au: 7: 0, sdistkm);
    ObjectMotion('Spk',nom,0,jdt,st0,cfgsc,dm,pa,dx,dy);
    Desc := sar + tab + sde + tab + ' Spk' + tab + nom + tab + 'SPK id:'+ target + tab +
            'dist:' + sdist + ' au' + tab + 'dist:' + sdistkm + ' km' + tab + 'rsol:' +
             sdp + ' au' + tab + 'rsol:' + sdpkm + ' km' + tab + 'date:' + date + tab;
    if dm>0 then
      Desc:=Desc+'MotionArcm:'+formatfloat(f3, dm*60)+tab+'MotionPA:'+formatfloat(f1, pa)+tab;
    cfgsc.TrackType := TTbody;
    cfgsc.TrackId := target;
    cfgsc.TrackName := nom;
    cfgsc.FindId := target;
  end;
  cfgsc.FindName := nom;
  cfgsc.FindDesc := Desc;
  cfgsc.FindDesc2 := '';
  cfgsc.FindNote := '';
end;

procedure TPlanet.FindBodyIndex(bname: string; cfgsc: Tconf_skychart; out idx:integer);
var s1: string;
    i,n: integer;
begin

  idx:=-1;

  if (not cfgsc.ShowBodiesValid) or (cfgsc.BodiesNb = 0) then
    exit;

  s1 := UpperCase(StringReplace(bname,' ','',[rfReplaceAll]));
  if s1 = '' then
    exit;

  if copy(s1,1,3)='SPK' then begin
    n:=1;
    delete(s1,1,3);
  end
  else
    n:=2;

  for i:=1 to cfgsc.BodiesNb do begin
    if uppercase(StringReplace(cfgsc.BodiesName[0, i, n],' ','',[rfReplaceAll]))=s1 then begin
      idx:=i;
      break;
    end;
  end;

end;

function TPlanet.FindBodyName(bname: string; var ra, de, mag: double;cfgsc: Tconf_skychart; upddb: boolean; MeanPos: boolean = False): boolean;
var
  dist, r: double;
  idx: integer;
begin
  Result := False;
  searchid := '';

  if (not cfgsc.ShowBodiesValid) or (cfgsc.BodiesNb = 0) then
    exit;

  FindBodyIndex(bname,cfgsc, idx);

  if idx < 0 then
    exit;

  ra := cfgsc.BodiesLst[0, idx, 6];
  de := cfgsc.BodiesLst[0, idx, 7];
  r := cfgsc.BodiesLst[0, idx, 3];
  dist := cfgsc.BodiesLst[0, idx, 5];
  mag:=0;
  Result := True;

  if MeanPos then
    exit;

  if cfgsc.PlanetParalaxe then
    Paralaxe(cfgsc.CurST, dist, ra, de, ra, de, r, cfgsc);

 end;

function TPlanet.FindAsteroid(x1, y1, x2, y2: double; nextobj: boolean;
  cfgsc: Tconf_skychart; var nom, mag, date, desc: string; trunc: boolean = True): boolean;
var
  yy, mm, dd: integer;
  tar, tde: double;
  h, g, ma, ap, an, ic, ec, sa, eq, ra, Dec, dist, r, elong, phase, magn, xc, yc, zc: double;
  ref, nam: string;
  jdt, hh, jd0, st0, ar, de, q,dm,pa,dx,dy: double;
  sar, sde, shh, sdp, sdist, sphase: string;
const
  d1 = '0.0';
  d2 = '0.00';
begin
  if not nextobj then
  begin
    CurrentAstStep := 0;
    CurrentAsteroid := 0;
  end;
  Result := False;
  desc := '';
  tar := 1;
  tde := 1;
  if cfgsc.ephvalid and (cfgsc.AsteroidNb > 0) then
    repeat
      Inc(CurrentAsteroid);
      if CurrentAsteroid > cfgsc.AsteroidNb then
      begin
        Inc(CurrentAstStep);
        if (not cfgsc.SimObject[12]) or nextobj or (CurrentAstStep >= cfgsc.SimNb) then
          break
        else
        begin
          CurrentAsteroid := 0;
          continue;
        end;
      end;
      if cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5]<0 then continue;
      tar := NormRa(cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 1]);
      tde := cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 2];
      // search if this asteroid is at the position
      if trunc then
      begin
        if (tar < x1) or (tar > x2) or (tde < y1) or (tde > y2) then
        begin
          // no
          Result := False;
        end
        else
          Result := True;
      end
      else
        Result := True;
    until Result;
  cfgsc.FindOK := Result;
  if Result then
  begin
    cfgsc.FindSize := 0;
    cfgsc.FindRA := tar;
    cfgsc.FindDec := tde;
    cfgsc.FindPM := False;
    cfgsc.FindType := ftAst;
    cfgsc.TrackRA := cfgsc.FindRA;
    cfgsc.TrackDec := cfgsc.FindDec;
    cfgsc.TrackEpoch := cfgsc.JDChart;
    sar := ARpToStr(rad2deg * tar / 15);
    sde := DEpToStr(rad2deg * tde);
    jdt := cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 4];
    cfgsc.FindSimjd := jdt;
    //  str(jdt:12:4,sjd);
    djd(jdt + (cfgsc.TimeZone - cfgsc.DT_UT) / 24, yy, mm, dd, hh);
    jd0 := jd(yy, mm, dd, 0);
    st0 := SidTim(jd0, hh - cfgsc.TimeZone, cfgsc.ObsLongitude);
    shh := ARtoStr3(rmod(hh, 24));
    date := Date2Str(yy, mm, dd) + blank + shh;
    cdb.GetAstElem(strtoint(cfgsc.AsteroidName[CurrentAstStep, CurrentAsteroid, 1]), cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5], h, g, ma, ap, an, ic,
      ec, sa, eq, ref, nam);
    InitAsteroid(cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5],
      h, g, ma, ap, an, ic, ec, sa, eq, nam);
    Asteroid(jdt, True, ra, Dec, dist, r, elong, phase, magn, xc, yc, zc);
    cfgsc.FindRA2000 := cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 6];
    cfgsc.FindDec2000 := cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 7];
    cfgsc.FindDist := dist;
    if ServerCoordSystem=csJ2000 then begin
       ar := cfgsc.FindRA2000;
       de := cfgsc.FindDec2000;
       if cfgsc.PlanetParalaxe then
          Paralaxe(st0, cfgsc.FindDist, ar, de, ar, de, q, cfgsc);
       cfgsc.FindDesc2000 := ARpToStr(rmod(24+rad2deg * ar / 15,24)) + tab + DEpToStr(rad2deg * de);
    end
    else
       cfgsc.FindDesc2000 := '';
    nom := nam;
    str(cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 3]: 5: 1, mag);
    str(r: 7: 4, sdp);
    str(dist: 7: 4, sdist);
    str((rad2deg * phase): 4: 0, sphase);
    ObjectMotion('As',nom,cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5],jdt,st0,cfgsc,dm,pa,dx,dy);
    Desc := sar + tab + sde + tab + ' As' + tab + nom + tab + 'm:' +
      mag + tab + 'phase:' + sphase + blank + ldeg + tab + 'dist:' +
      sdist + 'au' + tab + 'rsol:' + sdp + 'au' + tab + 'vel:' +
      formatfloat(f1, 42.1219 * sqrt(1 / r - 1 / (2 * sa))) + 'km/s' + tab +
      'date:' + date + tab + 'ref:' + ref;
    djd(cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5], yy, mm, dd, hh);
    Desc := Desc + '/' + Date2Str(yy, mm, dd) + tab; // ephemeris date
    if dm>0 then
      Desc:=Desc+'MotionArcm:'+formatfloat(f3, dm*60)+tab+'MotionPA:'+formatfloat(f1, pa)+tab;
    if abs(cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5] - cfgsc.CurJDUT) > 365 then
      desc := desc + rsWarningSomeA + tab;
    cfgsc.TrackType := TTasteroid;
    cfgsc.TrackId := cfgsc.AsteroidName[CurrentAstStep, CurrentAsteroid, 1];
    cfgsc.TrackElemEpoch := cfgsc.AsteroidLst[CurrentAstStep, CurrentAsteroid, 5];
    cfgsc.TrackName := nom;
    cfgsc.FindId := cfgsc.AsteroidName[CurrentAstStep, CurrentAsteroid, 1];
    cfgsc.FindX := xc;
    cfgsc.FindY := yc;
    cfgsc.FindZ := zc;
  end;
  cfgsc.FindName := nom;
  cfgsc.FindDesc := Desc;
  cfgsc.FindDesc2 := '';
  cfgsc.FindNote := '';
end;

function TPlanet.FindComet(x1, y1, x2, y2: double; nextobj: boolean;
  cfgsc: Tconf_skychart; var nom, mag, date, desc: string; trunc: boolean = True): boolean;
var
  yy, mm, dd: integer;
  tar, tde: double;
  h, g, ap, an, ic, ec, eq, ra, Dec, dist, r, elong, phase, magn, q, tp, diam, lc,
  car, cde, rc, xc, yc, zc: double;
  nam, elem_id: string;
  jdt, hh, jd0, st0, ar, de, q1,dm,pa,dx,dy: double;
  sar, sde, shh, sdp, sdist, sphase, svel: string;
const
  d1 = '0.0';
  d2 = '0.00';
begin
  if not nextobj then
  begin
    CurrentComStep := 0;
    CurrentComet := 0;
  end;
  Result := False;
  desc := '';
  tar := 1;
  tde := 1;
  if cfgsc.ephvalid and (cfgsc.CometNb > 0) then
    repeat
      Inc(CurrentComet);
      if CurrentComet > cfgsc.CometNb then
      begin
        Inc(CurrentComStep);
        if (not cfgsc.SimObject[13]) or nextobj or (CurrentComStep >= cfgsc.SimNb) then
          break
        else
        begin
          CurrentComet := 0;
          continue;
        end;
      end;
      if cfgsc.CometLst[CurrentComStep, CurrentComet, 8]<0 then continue;
      tar := NormRa(cfgsc.CometLst[CurrentComStep, CurrentComet, 1]);
      tde := cfgsc.CometLst[CurrentComStep, CurrentComet, 2];
      // search if this comet is at the position
      if trunc then
      begin
        if (tar < x1) or (tar > x2) or (tde < y1) or (tde > y2) then
        begin
          // no
          Result := False;
        end
        else
          Result := True;
      end
      else
        Result := True;
    until Result;
  cfgsc.FindOK := Result;
  if Result then
  begin
    cfgsc.FindSize := 0;
    cfgsc.FindRA := tar;
    cfgsc.FindDec := tde;
    cfgsc.FindPM := False;
    cfgsc.FindType := ftCom;
    cfgsc.TrackRA := cfgsc.FindRA;
    cfgsc.TrackDec := cfgsc.FindDec;
    cfgsc.TrackEpoch := cfgsc.JDChart;
    sar := ARpToStr(rad2deg * tar / 15);
    sde := DEpToStr(rad2deg * tde);
    jdt := cfgsc.CometLst[CurrentComStep, CurrentComet, 7];
    cfgsc.FindSimjd := jdt;
    djd(jdt + (cfgsc.TimeZone - cfgsc.DT_UT) / 24, yy, mm, dd, hh);
    jd0 := jd(yy, mm, dd, 0);
    st0 := SidTim(jd0, hh - cfgsc.TimeZone, cfgsc.ObsLongitude);
    shh := ARtoStr3(rmod(hh, 24));
    date := Date2Str(yy, mm, dd) + blank + shh;
    cdb.GetComElem(cfgsc.CometName[CurrentComStep, CurrentComet, 1],
      cfgsc.CometLst[CurrentComStep, CurrentComet, 8], tp, q, ec, ap, an, ic, h, g, eq, nam, elem_id);
    InitComet(tp, q, ec, ap, an, ic, h, g, eq, nam);
    Comet(jdt, True, ra, Dec, dist, r, elong, phase, magn, diam, lc, car, cde, rc, xc, yc, zc);
    cfgsc.FindRA2000 := ra;
    cfgsc.FindDec2000 := Dec;
    cfgsc.FindDist := dist;
    if ServerCoordSystem=csJ2000 then begin
       ar := cfgsc.FindRA2000;
       de := cfgsc.FindDec2000;
       if cfgsc.PlanetParalaxe then
          Paralaxe(st0, cfgsc.FindDist, ar, de, ar, de, q1, cfgsc);
       cfgsc.FindDesc2000 := ARpToStr(rmod(24+rad2deg * ar / 15,24)) + tab + DEpToStr(rad2deg * de);
    end
    else
       cfgsc.FindDesc2000 := '';
    nom := nam;
    str(cfgsc.CometLst[CurrentComStep, CurrentComet, 3]: 5: 1, mag);
    str(r: 7: 4, sdp);
    str(dist: 7: 4, sdist);
    str((rad2deg * phase): 4: 0, sphase);
    if ec < 1 then
      svel := formatfloat(f1, 42.1219 * sqrt(1 / r - 1 / (2 * q / (1 - ec)))) + 'km/s'
    else
      svel := 'n/a';  { TODO : velocity for parabolic and hyperbolic orbits }
    ObjectMotion('Cm',nom,cfgsc.CometLst[CurrentComStep, CurrentComet,8],jdt,st0,cfgsc,dm,pa,dx,dy);
    Desc := sar + tab + sde + tab + ' Cm' + tab + nom + tab + 'm:' +
      mag + tab + 'phase:' + sphase + blank + ldeg + tab + 'dist:' +
      sdist + 'au' + tab + 'rsol:' + sdp + 'au' + tab + 'vel:' + svel +
      tab + 'tl:' + formatfloat(f2, lc) + 'au' + tab + 'date:' +
      date + tab + 'ref:' + elem_id;
    djd(cfgsc.CometLst[CurrentComStep, CurrentComet, 8], yy, mm, dd, hh);
    Desc := Desc + '/' + Date2Str(yy, mm, dd) + tab;
    if dm>0 then
      Desc:=Desc+'MotionArcm:'+formatfloat(f3, dm*60)+tab+'MotionPA:'+formatfloat(f1, pa)+tab;
    if abs(cfgsc.CometLst[CurrentComStep, CurrentComet, 8] - cfgsc.CurJDUT) > 180 then
      desc := desc + rsWarningSomeC + tab;
    cfgsc.TrackType := TTcomet;
    cfgsc.TrackId := cfgsc.CometName[CurrentComStep, CurrentComet, 1];
    cfgsc.TrackElemEpoch := cfgsc.CometLst[CurrentComStep, CurrentComet, 8];
    cfgsc.TrackName := nom;
    cfgsc.FindId := cfgsc.CometName[CurrentComStep, CurrentComet, 1];
    cfgsc.FindX := xc;
    cfgsc.FindY := yc;
    cfgsc.FindZ := zc;
  end;
  cfgsc.FindName := nom;
  cfgsc.FindDesc := Desc;
  cfgsc.FindDesc2 := '';
  cfgsc.FindNote := '';
end;

function TPlanet.PrepareAsteroid(jd1, jd2, step: double; msg: TStrings): boolean;
var
  jds, jde: string;
  i,j: integer;
  x, y, z: double;
  nam,ref: string;
  epoch, h, g, ma, ap, an, ic, ec, sa, eq: double;
  ra, Dec, dist, r, elong, phase, magn, xc, yc, zc: double;
begin
  try
    jds := formatfloat(f1, jd1);
    jde := formatfloat(f1, jd2);
    step := max(1.0, step);
    msg.Add(Format(rsBeginProcess, [jds, jddate(jd1)]) + ' - ' + Format('%s / %s',[jde, jddate(jd2)]));
    msg.Add(rsGetAsteroidL);
    application.ProcessMessages;
    n_ast := 0;
    jdaststart := jd1;
    jdastend := jd2;
    jdaststep := step;
    jdastnstep := round((jd2 - jd1) / step) + 1;
    SetLength(AstSol, jdastnstep);
    cdb.NumAsteroidMagnitudesJD:=jdastnstep;
    SetLength(cdb.AsteroidMagnitudesJD, cdb.NumAsteroidMagnitudesJD);
    for i := 0 to jdastnstep - 1 do
    begin
      SunRect(jd1 + i * step, x, y, z);
      AstSol[i, 0] := jd1 + i * step;
      AstSol[i, 1] := x;
      AstSol[i, 2] := y;
      AstSol[i, 3] := z;
      cdb.AsteroidMagnitudesJD[i]:=AstSol[i, 0];
    end;
    SetLength(cdb.AsteroidMagnitudes,cdb.NumAsteroidMagnitudesJD,cdb.NumAsteroidElement);
    ///////
    for j:=0 to cdb.NumAsteroidElement-1 do begin
      cdb.GetAstElem(j,epoch,h,g,ma,ap,an,ic,ec,sa,eq,ref,nam);
      if abs(jdaststart - epoch) < 3650 then
      begin // 10 years max limit
        Inc(n_ast);
        InitAsteroid(epoch, h, g, ma, ap, an, ic, ec, sa, eq, nam);
        for i := 0 to jdastnstep - 1 do
        begin
          XSol := AstSol[i, 1];
          YSol := AstSol[i, 2];
          ZSol := AstSol[i, 3];
          SolT0 := AstSol[i, 0];
          jdnew := AstSol[i, 0];
          Asteroid(jdnew, False, ra, Dec, dist, r, elong, phase, magn, xc, yc, zc);
          if dist < NEO_dist then
            magn := 0;
          cdb.AsteroidMagnitudes[i,n_ast-1].elementidx:=j;
          cdb.AsteroidMagnitudes[i,n_ast-1].magnitude:=round(magn * 10);
        end;
      end;
      if (n_ast > 0) and ((n_ast mod 100000) = 0) then
      begin
        msg.Add(Format(rsProcessing, [IntToStr(n_ast)]));
        application.ProcessMessages;
      end;
    end;
    cdb.NumAsteroidMagnitude:=n_ast;
    SetLength(cdb.AsteroidMagnitudes,cdb.NumAsteroidMagnitudesJD,cdb.NumAsteroidMagnitude);
    ///////
    cdb.SaveAsteroidMagnitude;
    cdb.TruncateDailyAsteroid;
    msg.Add(Format(rsEndProcessin, [IntToStr(n_ast)]));
    Result := (n_ast > 0);
    if not Result then
    begin
      msg.Add(rsWarningSomeA);
      application.ProcessMessages;
      sleep(3000);
    end;
  except
    Result := False;
    msg.Add(rsErrorPleaseC);
    application.ProcessMessages;
    sleep(3000);
  end;
end;

procedure TPlanet.PlanetAltitude(pla: integer; jd0, hh: double;
  cfgsc: Tconf_skychart; var har, sina: double);
var
  jdt, ra, de, dm4, dm5, dm6, dm7, dm8, dm9, dm10, dm11, dm12, dm13, dm14: double;
begin
  jdt := jd0 + (hh - cfgsc.TimeZone + cfgsc.DT_UT) / 24;   // local time -> TT
  case pla of
    1..9: Planet(pla, jdt, ra, de, dm4, dm5, dm6, dm7, dm8, dm9, dm10, dm11, dm12, dm13, dm14);
    10: Sun(jdt, ra, de, dm4, dm5);
    11: Moon(jdt, ra, de, dm4, dm5, dm6, dm7, dm8,cfgsc);
  end;
  precession(jd2000, jd0, ra, de);
  har := rmod(sidtim(jd0, hh - cfgsc.TimeZone, cfgsc.Obslongitude) - ra + pi2, pi2);
  sina := (sin(deg2rad * cfgsc.Obslatitude) * sin(de) + cos(deg2rad * cfgsc.Obslatitude) *
    cos(de) * cos(har));
end;

procedure TPlanet.PlanetRiseSet(pla: integer; jd0: double; AzNorth: boolean;
  var thr, tht, ths, tazr, tazs: string; var jdr, jdt, jds, rar, der, rat, det, ras, des: double;
  var i: integer; cfgsc: Tconf_skychart);
var
  hr, ht, hs, h1, h2, azr, azs, dist, q, diam, dh, hmin, hhmax,st: double;
  ho, sinho, dt, hh, y1, y2, y3, x1, x2, x3, xmax, ymax, xmax2, ymax2, ymax0, ra,
  de, dm5, dm6, dm7, dm8, dm9, dm10, dm11, dm12, dm13, dm14: double;
  frise, fset, ftransit: boolean;
  n: integer;
const
  na = '      ';
begin
  jdr := 0;
  jdt := 0;
  jds := 0;
  ymax0 := 0;
  hr := 0;
  ht := 0;
  hs := 0;
  frise := False;
  fset := False;
  ftransit := False;
  case pla of
    12..15: pla := 5; //jup sat
    16..23: pla := 6; //sat sat ;
    24..28: pla := 7; //ura sat ;
    29..30: pla := 4; //mar sat ;
    31: pla := 6;     //sat ring ;
    33: pla := 6;
    34..35: pla := 8; // nep sat
    36: pla := 9;     // pluto sat
  end;
  if cfgsc.ShowHorizonDepression then
    dh := rad2deg * cfgsc.ObsHorizonDepression
  else
  begin
    dh := 0;
    Refraction(dh, False, cfgsc, 1);
    dh := rad2deg * dh;
  end;
  case pla of
    1..9: ho := dh;
    10:
    begin
      Sun(jd0 + (cfgsc.DT_UT / 24), ra, de, dist, diam);
      ho := dh - diam / 2 / 3600;
      if dh > -1 then
        ho := ho - 0.016;
    end;
    11:
    begin
      Moon(jd0 + (cfgsc.DT_UT / 24), ra, de, dist, dm5, diam, dm7, dm8,cfgsc);
      ho := (8.794 / dist / 3600) + dh - diam / 2 / 3600;  // horizontal parallax
      if dh > -1 then
        ho := ho - 0.016;
    end;
    else
      ho := dh;
  end;
  sinho := sin(deg2rad * ho);
  dt := jd0;
  hh := 0;
  PlanetAltitude(pla, dt, hh - 1.0, cfgsc, x1, y1);
  if x1 > pi then
    x1 := x1 - pi2;
  y1 := y1 - sinho;
  // loop for event by hour
  while ((hh < 25) and ((fset = False) or (frise = False) or (ftransit = False))) do
  begin
    PlanetAltitude(pla, dt, hh, cfgsc, x2, y2);
    if x2 > pi then
      x2 := x2 - pi2;
    y2 := y2 - sinho;
    PlanetAltitude(pla, dt, hh + 1.0, cfgsc, x3, y3);
    if x3 > pi then
      x3 := x3 - pi2;
    y3 := y3 - sinho;
    int4(y1, y2, y3, n, h1, h2, xmax, ymax);
    // one rise/set
    if (n = 1) then
    begin
      if (y1 < 0.0) then
      begin
        hr := hh + h1;
        if (hr>=0)and(hr<=24) then frise := True;
      end
      else
      begin
        hs := hh + h1;
        if (hs>=0)and(hs<=24) then fset := True;
      end;
    end;
    // two rise/set
    if (n = 2) then
    begin
      if (ymax < 0.0) then
      begin
        hr := hh + h2;
        hs := hh + h1;
      end
      else
      begin
        hr := hh + h1;
        hs := hh + h2;
      end;
    end;
    // transit
    if ((abs(xmax) < 1) and (ymax > ymax0)) or ((hh < 23) and (hh > 1) and
      (abs(xmax) < 1.5) and (ymax > ymax0))
    //this one to correct for some imprecision in the extrema when very near to a time boundary
    then
    begin
      int4(x1, x2, x3, n, h1, h2, xmax2, ymax2);
      if (n = 1) then
      begin
        ht := hh + h1;
        if (ht>0)and(ht<24) then begin
          ymax0 := ymax;
          ftransit := True;
        end;
      end;
    end;
    y1 := y3;
    x1 := x3;
    hh := hh + 2;
  end;
  // 1 minute loop for better rise/set precision
  hmin := 1 / 60;
  if frise then
  begin
    hh := hr - 2 * hmin;
    hhmax := hr + 2 * hmin;
    PlanetAltitude(pla, dt, hh - hmin, cfgsc, x1, y1);
    if x1 > pi then
      x1 := x1 - pi2;
    y1 := y1 - sinho;
    frise := False;
    while ((hh < hhmax) and (frise = False)) do
    begin
      PlanetAltitude(pla, dt, hh, cfgsc, x2, y2);
      if x2 > pi then
        x2 := x2 - pi2;
      y2 := y2 - sinho;
      PlanetAltitude(pla, dt, hh + hmin, cfgsc, x3, y3);
      if x3 > pi then
        x3 := x3 - pi2;
      y3 := y3 - sinho;
      int4(y1, y2, y3, n, h1, h2, xmax, ymax);
      if (n = 1) then
      begin
        if (y1 < 0.0) then
        begin
          hr := hh + h1 * hmin;
          frise := True;
        end;
      end;
      y1 := y3;
      x1 := x3;
      hh := hh + 2 * hmin;
    end;
    frise := True;
  end;
  if fset then
  begin
    hh := hs - 2 * hmin;
    hhmax := hs + 2 * hmin;
    PlanetAltitude(pla, dt, hh - hmin, cfgsc, x1, y1);
    if x1 > pi then
      x1 := x1 - pi2;
    y1 := y1 - sinho;
    fset := False;
    while ((hh < hhmax) and (fset = False)) do
    begin
      PlanetAltitude(pla, dt, hh, cfgsc, x2, y2);
      if x2 > pi then
        x2 := x2 - pi2;
      y2 := y2 - sinho;
      PlanetAltitude(pla, dt, hh + hmin, cfgsc, x3, y3);
      if x3 > pi then
        x3 := x3 - pi2;
      y3 := y3 - sinho;
      int4(y1, y2, y3, n, h1, h2, xmax, ymax);
      if (n = 1) then
      begin
        if (y1 >= 0.0) then
        begin
          hs := hh + h1 * hmin;
          fset := True;
        end;
      end;
      y1 := y3;
      x1 := x3;
      hh := hh + 2 * hmin;
    end;
    fset := True;
  end;
  // format result
  if (frise or fset) then
  begin    // rise (and/or) set and transit
    i := 0;
    if (frise) then
    begin       // rise
      thr := artostr3(hr);
      jdr := jd0 + (hr - cfgsc.TimeZone) / 24;
      case pla of
        1..9: Planet(pla, jdr + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7,
            dm8, dm9, dm10, dm11, dm12, dm13, dm14);
        10: Sun(jdr + cfgsc.DT_UT / 24, ra, de, dist, dm5);
        11: Moon(jdr + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7, dm8,cfgsc);
      end;
      precession(jd2000, jd0, ra, de);
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(SidTim(jd0, hr - cfgsc.TimeZone, cfgsc.ObsLongitude),
          dist, ra, de, rar, der, q, cfgsc);
      end
      else
      begin
        rar := ra;
        der := de;
      end;
      Eq2Hz(sidtim(jd0, hr - cfgsc.TimeZone, cfgsc.ObsLongitude) - ra, de, azr, dist, cfgsc);
      if AzNorth then
        Azr := rmod(Azr + pi, pi2);
      tazr := LONmToStr(rad2deg * Azr);
    end
    else
    begin
      thr := na;
      tazr := na;
    end;
    if (fset) then
    begin       // set
      ths := artostr3(hs);
      jds := jd0 + (hs - cfgsc.TimeZone) / 24;
      case pla of
        1..9: Planet(pla, jds + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7,
            dm8, dm9, dm10, dm11, dm12, dm13, dm14);
        10: Sun(jds + cfgsc.DT_UT / 24, ra, de, dist, dm5);
        11: Moon(jds + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7, dm8,cfgsc);
      end;
      precession(jd2000, jd0, ra, de);
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(SidTim(jd0, hs - cfgsc.TimeZone, cfgsc.ObsLongitude),
          dist, ra, de, ras, des, q, cfgsc);
      end
      else
      begin
        ras := ra;
        des := de;
      end;
      Eq2Hz(sidtim(jd0, hs - cfgsc.TimeZone, cfgsc.ObsLongitude) - ra, de, azs, dist, cfgsc);
      if AzNorth then
        Azs := rmod(Azs + pi, pi2);
      tazs := LONmToStr(rad2deg * Azs);
    end
    else
    begin
      ths := na;
      tazs := na;
    end;
    if frise and fset and (hs>hr) then begin
      // better transit precision
      ht:=(hs+hr)/2;
      jdt := jd0 + (ht - cfgsc.TimeZone) / 24;
      st:=SidTim(jd0, ht - cfgsc.TimeZone, cfgsc.ObsLongitude);
      case pla of
        1..9: Planet(pla, jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7,
            dm8, dm9, dm10, dm11, dm12, dm13, dm14);
        10: Sun(jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5);
        11: Moon(jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7, dm8,cfgsc);
      end;
      precession(jd2000, jd0, ra, de);
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(st, dist, ra, de, rat, det, q, cfgsc);
      end
      else
      begin
        rat := ra;
        det := de;
      end;
      ra:=rmod(pi2+ra,pi2);
      st:=rmod(pi2+st,pi2);
      ht:=rmod(24+ht-(st-ra)*1.00273790935*rad2deg/15,24);
      ftransit:=true;
    end;
    if (ftransit) then
    begin      // transit
      tht := artostr3(ht);
      jdt := jd0 + (ht - cfgsc.TimeZone) / 24;
      case pla of
        1..9: Planet(pla, jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7,
            dm8, dm9, dm10, dm11, dm12, dm13, dm14);
        10: Sun(jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5);
        11: Moon(jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7, dm8,cfgsc);
      end;
      precession(jd2000, jd0, ra, de);
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(SidTim(jd0, ht - cfgsc.TimeZone, cfgsc.ObsLongitude),
          dist, ra, de, rat, det, q, cfgsc);
      end
      else
      begin
        rat := ra;
        det := de;
      end;
    end
    else
    begin
      tht := na;
    end;
  end
  else
  begin
    if (ftransit) then
    begin   // circumpolar
      i := 1;
      thr := na;
      ths := na;
      tazr := na;
      tazs := na;
      tht := armtostr(ht);
      jdt := jd0 + (ht - cfgsc.TimeZone) / 24;
      case pla of
        1..9: Planet(pla, jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7,
            dm8, dm9, dm10, dm11, dm12, dm13, dm14);
        10: Sun(jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5);
        11: Moon(jdt + cfgsc.DT_UT / 24, ra, de, dist, dm5, dm6, dm7, dm8,cfgsc);
      end;
      precession(jd2000, jd0, ra, de);
      if cfgsc.PlanetParalaxe then
      begin
        Paralaxe(SidTim(jd0, ht - cfgsc.TimeZone, cfgsc.ObsLongitude),
          dist, ra, de, rat, det, q, cfgsc);
      end
      else
      begin
        rat := ra;
        det := de;
      end;
    end
    else
    begin  // not visible
      i := 2;
      thr := na;
      ths := na;
      tht := na;
      tazr := na;
      tazs := na;
    end;
  end;
end;

procedure TPlanet.Twilight(jd0, obslat, obslon: double;
  out astrom, nautm, civm, cive, naute, astroe: double);
var
  ars, des, dist, diam: double;
begin
  Sun(jd0 + 0.5, ars, des, dist, diam);
  precession(jd2000, jd0, ars, des);
  if (ars < 0) then
    ars := ars + pi2;
  Time_Alt(jd0, ars, des, -18, astrom, astroe, obslat, obslon);
  Time_Alt(jd0, ars, des, -12, nautm, naute, obslat, obslon);
  Time_Alt(jd0, ars, des, -6, civm, cive, obslat, obslon);
end;

procedure TPlanet.SetDE(folder1,folder2: string);
begin
  de_folder1 := folder1;
  de_folder2 := folder2;
end;

function TPlanet.load_de(t: double): boolean;
var
  i: integer;
begin
  if (t > de_jdstart) and (t < de_jdend) then
  begin
    // a file is already loaded for this date
    Result := (de_type <> 0);
  end
  else if trunc(t) = de_jdcheck then
  begin
    // we know that no file match this date
    Result := (de_type <> 0);
  end
  else
  begin
    // search a file for the date
    Result := False;
    de_type := 0;
    de_jdcheck := trunc(t);
    de_jdstart := MaxInt;
    de_jdend := -MaxInt;
    for i := 1 to nJPL_DE do
    begin
      if load_de_file(t, de_folder1, JPL_DE[i], de_filename, de_jdstart, de_jdend) or
         load_de_file(t, de_folder2, JPL_DE[i], de_filename, de_jdstart, de_jdend)
      then
      begin
        Result := True;
        de_type := JPL_DE[i];
        break;
      end;
    end;
  end;
end;

procedure TPlanet.nutation(j: double; var nutl, nuto: double);
var
  planet_arr: Array_5D;
  ok: boolean;
begin
  ok := False;
  if load_de(j) then
  begin
    ok := Calc_Planet_de(j, 14, planet_arr, False, 0, False);
    if ok then
    begin
      nutl := planet_arr[0];
      nuto := planet_arr[1];
    end;
  end;
  if not ok then
    nutationMe(j, nutl, nuto);
end;

procedure TPlanet.aberration(j: double; var abv, ehn: coordvector;
  var ab1, abe, abp, gr2e: double; var abm, asl: boolean);
var
  planet_arr: Array_5D;
  v, sx, sy, sz: double;
  ps: coordvector;
  ok: boolean;
begin
  ok := False;
  // annual aberration
  if load_de(j) then
  begin
    ok := Calc_Planet_de(j, 3, planet_arr, False, 12, True);
    if ok then
    begin
      // Earth velocity vector divided by c
      abv[1] := planet_arr[3] / secday / clight;
      abv[2] := planet_arr[4] / secday / clight;
      abv[3] := planet_arr[5] / secday / clight;
      sofa_PM(abv, v);
      ab1 := sqrt(1 - v * v);
      abm := True;
    end;
  end;
  if not ok then
  begin
    aberrationMe(j, abe, abp);
    abm := False;
  end;
  // Sun light deflection
  SunRect(j, sx, sy, sz);
  if Feph_method <> '' then
  begin
    // twice the gravitational radius of the Sun divided by the Sun-Earth distance
    gr2e := grsun / (sqr(sx * sx + sy * sy + sz * sz));
    ps[1] := -sx;
    ps[2] := -sy;
    ps[3] := -sz;
    // unit vector from the Sun to the Earth
    sofa_PN(ps, v, ehn);
    asl := True;
  end
  else
  begin
    asl := False;
  end;
end;

procedure TPlanet.ObjectMotion(otype,oname: string; ElemEpoch,cjd,cst: double; c:Tconf_skychart; out dist,pa,dx,dy: double);
var id: string;
    idx: integer;
    q, h: double;
    nst, njd: double;
    tp, ec, ap, an, ic, g, eq, cra1, cde1, dst1, cra, cdec, dst, rr, elong, phase, magn,
    diam, lc, ctar, ctde, rc, xc, yc, zc, ma, sa: double;
    nam, elem_id, ref: string;
begin
    dist := 0;
    nst := Rmod(cst + 1.00273790935 * 15 * deg2rad, pi2); // sidereal + 1 hour
    njd := cjd + 1 / 24; // JD + 1 hour
    if otype = 'Cm' then
    begin
      FindCometId(oname,id);
      if id<>'' then begin
        if cdb.GetComElem(id, ElemEpoch, tp, q, ec, ap, an, ic, h, g, eq, nam, elem_id) then begin
          InitComet(tp, q, ec, ap, an, ic, h, g, eq, nam);
          Comet(cjd, True, cra1, cde1, dst1, rr, elong, phase, magn, diam, lc, ctar, ctde, rc, xc, yc, zc);
          Comet(njd, True, cra, cdec, dst, rr, elong, phase, magn, diam, lc, ctar, ctde, rc, xc, yc, zc);
          Precession(jd2000,c.JDChart,cra1,cde1);
          Precession(jd2000,c.JDChart,cra,cdec);
          if c.ApparentPos then begin
            apparent_equatorial(cra1,cde1,c,true,true);
            apparent_equatorial(cra,cdec,c,true,true);
          end;
          if c.PlanetParalaxe then begin
            Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, c);
            Paralaxe(nst, dst, cra, cdec, cra, cdec, q, c);
          end;
          dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
        end;
      end;
    end;
    if otype = 'As' then
    begin
      FindAsteroidIndex(oname,idx);
      if idx>=0 then begin
        if cdb.GetAstElem(idx, ElemEpoch, h, g, ma, ap, an, ic, ec, sa, eq, ref, nam) then begin
          InitAsteroid(ElemEpoch, h, g, ma, ap, an, ic, ec, sa, eq, nam);
          Asteroid(cjd, True, cra1, cde1, dst1, rr, elong, phase, magn, xc, yc, zc);
          Asteroid(njd, True, cra, cdec, dst, rr, elong, phase, magn, xc, yc, zc);
          Precession(jd2000,c.JDChart,cra1,cde1);
          Precession(jd2000,c.JDChart,cra,cdec);
          if c.ApparentPos then begin
            apparent_equatorial(cra1,cde1,c,true,true);
            apparent_equatorial(cra,cdec,c,true,true);
          end;
          if c.PlanetParalaxe then begin
            Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, c);
            Paralaxe(nst, dst, cra, cdec, cra, cdec, q, c);
          end;
          dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
        end;
      end;
    end;
    if otype = 'Spk' then
    begin
      FindBodyIndex(oname,c,idx);
      if idx>=0 then begin
        id:=c.BodiesName[0, idx, 1];
        if Body(cjd,strtoint(id),cra1,cde1,dst1,rr) and Body(njd,strtoint(id),cra,cdec,dst,rr) then begin
          Precession(jd2000,c.JDChart,cra1,cde1);
          Precession(jd2000,c.JDChart,cra,cdec);
          if c.ApparentPos then begin
            apparent_equatorial(cra1,cde1,c,true,true);
            apparent_equatorial(cra,cdec,c,true,true);
          end;
          if c.PlanetParalaxe then begin
            Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, c);
            Paralaxe(nst, dst, cra, cdec, cra, cdec, q, c);
          end;
          dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
        end;
      end;
    end;
    if dist > (0.05 / 3600) then
    begin
      pa := rmod(rad2deg * PositionAngle(cra1, cde1, cra, cdec) + 360, 360);
      dx := rmod((rad2deg * (cra - cra1) / 15) + 24, 24);
      if dx > 12 then
        dx := dx - 24;
      dy := rad2deg * (cdec - cde1);
    end
    else dist:=0;
end;

end.
