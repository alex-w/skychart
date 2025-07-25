unit fu_chart;

{$MODE Delphi}{$H+}

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
 Chart child form 
}
//{$define showtime}

interface

uses
  BGRABitmap, BGRABitmapTypes, u_orbits, u_grappavar,
  pu_mount, pu_getdss, pu_imglist, pu_prepoint,
  u_translation, pu_detail, cu_skychart, u_constant, u_util, pu_image,
  gcatunit, pu_obslist, pu_mosaic, synacode,
  u_projection, Printers, Math, downloaddialog, IntfGraphics,
  contnrs, LCLType, UScaleDPI,
  PostscriptCanvas, FileUtil, Clipbrd, LCLIntf, Classes, Graphics, Dialogs, Types,
  Forms, Controls, StdCtrls, ExtCtrls, Menus, ActnList, SysUtils,
  LResources, CheckLst;

const
  maxundo = 10;

type
  Tstr1func = procedure(txt: string) of object;
  Tstr12func = procedure(txt1, txt2: string) of object;
  Tstr2func = procedure(txt: string; Sender: TObject) of object;
  Tint2func = procedure(i1, i2: integer) of object;
  Tbtnfunc = procedure(i1, i2: integer; b1: boolean; Sender: TObject) of object;
  Tshowinfo = procedure(txt: string; origin: string = ''; sendmsg: boolean = False;
    Sender: TObject = nil; txt2: string = ''; txt2000: string = '') of object;
  TSendCoordpointAtsky = procedure(client: string; ra, de: double) of object;
  TSendSelectRow = procedure(tableid, url, row: string) of object;

type
  TChartDrawingControl = class(TCustomControl)
  public
    procedure Paint; override;
    property onMouseDown;
    property onMouseMove;
    property onMouseUp;
  end;

  { Tf_chart }
  Tf_chart = class(TFrame)
    About2: TMenuItem;
    About1: TMenuItem;
    chart_imglist: TAction;
    AddLabel1: TMenuItem;
    DownloadDialog1: TDownloadDialog;
    Cleanupmap1: TMenuItem;
    Identlabel: TImage;
    MenuFinderCircle: TMenuItem;
    AllAtThisPos: TMenuItem;
    ImgList1: TMenuItem;
    EyepieceMask: TMenuItem;
    CopyCoord: TMenuItem;
    CopyCoord1: TMenuItem;
    CopyCoord2: TMenuItem;
    CopyCoord2000: TMenuItem;
    MenuSAMP2: TMenuItem;
    MenuSAMP3: TMenuItem;
    PrePointMeasure: TMenuItem;
    PrePointCreate: TMenuItem;
    PrePointRemove: TMenuItem;
    PrePointing: TMenuItem;
    MenuNewMosaic: TMenuItem;
    nsearch4: TMenuItem;
    SlewCenter: TMenuItem;
    MenuTelescopeToObsList: TMenuItem;
    MenuCursorToObsList: TMenuItem;
    Resetalllabel: TMenuItem;
    RecoverLabel: TMenuItem;
    MenuObslistFirst: TMenuItem;
    MenuObslistNext: TMenuItem;
    MenuObslistPrev: TMenuItem;
    MenuObslistLast: TMenuItem;
    MenuObslist: TMenuItem;
    MenuAddToObsList: TMenuItem;
    MenuViewObsList: TMenuItem;
    MenuSAMP: TMenuItem;
    MenuSAMP1: TMenuItem;
    SelectCircle: TMenuItem;
    SelectRectangle: TMenuItem;
    nsearch1: TMenuItem;
    nsearch2: TMenuItem;
    nsearch3: TMenuItem;
    SearchName1: TMenuItem;
    SearchMenu1: TMenuItem;
    search1: TMenuItem;
    search2: TMenuItem;
    search3: TMenuItem;
    Target1: TMenuItem;
    MenuSaveCircle: TMenuItem;
    MenuLoadCircle: TMenuItem;
    MenuLabel: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SlewCursor: TMenuItem;
    PDSSTimer: TTimer;
    TrackTelescope1: TMenuItem;
    Panel1: TPanel;
    RemoveLastLabel1: TMenuItem;
    RemoveAllLabel1: TMenuItem;
    RefreshTimer: TTimer;
    ActionList1: TActionList;
    BlinkTimer: TTimer;
    VertScrollBar: TScrollBar;
    HorScrollBar: TScrollBar;
    chart_zoomplus: TAction;
    chart_zoomminus: TAction;
    chart_MoveWest: TAction;
    chart_MoveEast: TAction;
    chart_MoveNorth: TAction;
    chart_MoveSouth: TAction;
    chart_MoveNorthWest: TAction;
    chart_MoveNorthEast: TAction;
    chart_MoveSouthWest: TAction;
    chart_MoveSouthEast: TAction;
    chart_Centre: TAction;
    PopupMenuChart: TPopupMenu;
    Zoom1: TMenuItem;
    Zoom2: TMenuItem;
    Centre1: TMenuItem;
    chart_zoomplusmove: TAction;
    chart_zoomminusmove: TAction;
    chart_FlipX: TAction;
    chart_FlipY: TAction;
    chart_Undo: TAction;
    chart_Redo: TAction;
    chart_rot_plus: TAction;
    chart_rot_minus: TAction;
    chart_GridEQ: TAction;
    chart_Grid: TAction;
    chart_switchbackground: TAction;
    chart_switchstar: TAction;
    Telescope1: TMenuItem;
    Connect1: TMenuItem;
    Slew1: TMenuItem;
    Sync1: TMenuItem;
    NewFinderCircle1: TMenuItem;
    N1: TMenuItem;
    RemoveLastCircle1: TMenuItem;
    RemoveAllCircles1: TMenuItem;
    AbortSlew1: TMenuItem;
    TelescopeTimer: TTimer;
    N3: TMenuItem;
    TrackOn1: TMenuItem;
    TrackOff1: TMenuItem;
    procedure About1Click(Sender: TObject);
    procedure AddLabel1Click(Sender: TObject);
    procedure AllAtThisPosClick(Sender: TObject);
    procedure BlinkTimerTimer(Sender: TObject);
    procedure Cleanupmap1Click(Sender: TObject);
    procedure CopyCoord1Click(Sender: TObject);
    procedure ChartResize(Sender: TObject);
    procedure CopyCoord2000Click(Sender: TObject);
    procedure CopyCoord2Click(Sender: TObject);
    procedure EyepieceMaskClick(Sender: TObject);
    procedure HorScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure chart_imglistExecute(Sender: TObject);
    procedure MenuCircleClick(Sender: TObject);
    procedure MenuAddToObsListClick(Sender: TObject);
    procedure MenuCursorToObsListClick(Sender: TObject);
    procedure MenuTelescopeToObsListClick(Sender: TObject);
    procedure MenuNewMosaicClick(Sender: TObject);
    procedure PrePointCreateClick(Sender: TObject);
    procedure PrePointMeasureClick(Sender: TObject);
    procedure PrePointRemoveClick(Sender: TObject);
    procedure ResetalllabelClick(Sender: TObject);
    procedure MenuObslistFirstClick(Sender: TObject);
    procedure MenuObslistLastClick(Sender: TObject);
    procedure MenuObslistNextClick(Sender: TObject);
    procedure MenuObslistPrevClick(Sender: TObject);
    procedure MenuViewObsListClick(Sender: TObject);
    procedure MenuLoadCircleClick(Sender: TObject);
    procedure MenuRectangleClick(Sender: TObject);
    procedure MenuSaveCircleClick(Sender: TObject);
    procedure nsearch1Click(Sender: TObject);
    procedure PDSSTimerTimer(Sender: TObject);
    procedure RecoverLabelClick(Sender: TObject);
    procedure RecoverLabelSelectAll(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure RemoveAllLabel1Click(Sender: TObject);
    procedure RemoveLastLabel1Click(Sender: TObject);
    procedure SAMPsendCursorCoordClick(Sender: TObject);
    procedure SAMPsendObjectCoordClick(Sender: TObject);
    procedure SAMPsendCenterCoordClick(Sender: TObject);
    procedure search1Click(Sender: TObject);
    procedure SlewCenterClick(Sender: TObject);
    procedure SlewCursorClick(Sender: TObject);
    procedure Target1Click(Sender: TObject);
    procedure TrackTelescope1Click(Sender: TObject);
    procedure VertScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: integer);
    procedure chart_zoomplusExecute(Sender: TObject);
    procedure chart_zoomminusExecute(Sender: TObject);
    procedure chart_MoveWestExecute(Sender: TObject);
    procedure chart_MoveEastExecute(Sender: TObject);
    procedure chart_MoveNorthExecute(Sender: TObject);
    procedure chart_MoveSouthExecute(Sender: TObject);
    procedure chart_MoveNorthWestExecute(Sender: TObject);
    procedure chart_MoveNorthEastExecute(Sender: TObject);
    procedure chart_MoveSouthWestExecute(Sender: TObject);
    procedure chart_MoveSouthEastExecute(Sender: TObject);
    procedure chart_CentreExecute(Sender: TObject);
    procedure PopupMenuChartPopup(Sender: TObject);
    procedure chart_zoomminusmoveExecute(Sender: TObject);
    procedure chart_zoomplusmoveExecute(Sender: TObject);
    procedure chart_FlipXExecute(Sender: TObject);
    procedure chart_FlipYExecute(Sender: TObject);
    procedure chart_UndoExecute(Sender: TObject);
    procedure chart_RedoExecute(Sender: TObject);
    procedure chart_rot_plusExecute(Sender: TObject);
    procedure chart_rot_minusExecute(Sender: TObject);
    procedure chart_GridEQExecute(Sender: TObject);
    procedure chart_GridExecute(Sender: TObject);
    procedure identlabelClick(Sender: TObject);
    procedure chart_switchstarExecute(Sender: TObject);
    procedure chart_switchbackgroundExecute(Sender: TObject);
    procedure Connect1Click(Sender: TObject);
    procedure Slew1Click(Sender: TObject);
    procedure Sync1Click(Sender: TObject);
    procedure NewFinderCircle1Click(Sender: TObject);
    procedure RemoveLastCircle1Click(Sender: TObject);
    procedure RemoveAllCircles1Click(Sender: TObject);
    procedure AbortSlew1Click(Sender: TObject);
    procedure TelescopeTimerTimer(Sender: TObject);
    procedure TrackOn1Click(Sender: TObject);
    procedure TrackOff1Click(Sender: TObject);
  private
    { Private declarations }
    FImageSetFocus: TNotifyEvent;
    FSetScriptMenu: TNotifyEvent;
    FSetFocus: TNotifyEvent;
    FShowTopMessage: Tstr2func;
    FShowTitleMessage: Tstr2func;
    FUpdateBtn: Tbtnfunc;
    FShowInfo: Tshowinfo;
    FSendInfo: TSendInfo;
    FShowCoord: Tstr1func;
    FListInfo: Tstr12func;
    FChartMove: TNotifyEvent;
    FImageSetup: TNotifyEvent;
    FPlanetInfo: TNotifyEvent;
    FSendCoordpointAtsky: TSendCoordpointAtsky;
    movefactor, zoomfactor: double;
    xcursor, ycursor, skipmove: integer;
    MovingCircle, FNightVision, StartCircle, lockkey, movecam, moveguide,
    frommovecam, printing: boolean;
    lockblink: boolean;
    KeyPressTime: double;
    SaveColor: Starcolarray;
    SavebgColor: TColor;
    SaveLabelColor: array[1..numlabtype] of Tcolor;
    PrintPreview: Tf_image;
    Fpop_scope: Tpop_scope;
    ScopeSlewing: boolean;
    FSendImageFits: TSendImageFits;
    FSendSelectRow: TSendSelectRow;
    AccelList: array[0..MaxMenulevel] of string;
    // save circle value for mosaic
    ShowCircle: boolean;
    ncircle, nrectangle,NumCircle: integer;
    circle: array of array [1..4] of single; // radius, rotation, offset, mode
    circleok: array of boolean;
    circlelbl: array of string;
    rectangle: array of array [1..5] of single; // width, height, rotation, offset, mode
    rectangleok: array of boolean;
    rectanglelbl: array of string;
    CircleLst: array[0..MaxCircle, 1..2] of double;
    procedure ConnectTelescope(Sender: TObject; autoconnect: boolean = False);
    procedure SlewTelescope(Sender: TObject);
    procedure SyncTelescope(Sender: TObject);
    procedure AbortSlewTelescope(Sender: TObject);
    procedure SetNightVision(Value: boolean);
    procedure Image1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: integer);
    procedure Image1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
    procedure Image1Paint(Sender: TObject);
    procedure SetScrollBar(ShowPosition: boolean=true);
    procedure ShowCoord(x, y: integer);
    procedure UpdObsListTime(Sender: TObject);
    procedure RefreshImage(Sender: TObject);
    function GetTelescopeMove: Tfloat2func;
    procedure SetTelescopeMove(Value: Tfloat2func);
    procedure ObservatoryFromTelescope(Sender: TObject);
    procedure ApplyMosaic(Sender: TObject);
    procedure PrePointCenter(Sender: TObject);
    procedure PrePointCenterNow(Sender: TObject);
    procedure SetSAMPmenu(menu:Tmenuitem; num: integer);
  public
    { Public declarations }
    Image1: TChartDrawingControl;
    ChartCursor: TCursor;
    sc: Tskychart;
    cmain: Tconf_main;
    prtsc: Tskychart;
    prtImage: TChartDrawingControl;
    locked, LockTrackCursor, LockKeyboard, lastquick, lock_refresh,
    lockscrollbar, TrackingCursor, TrackCursorMove, lockmove, TelescopeLock, MeasureOn: boolean;
    undolist: array[1..maxundo] of Tconf_skychart;
    lastundo, curundo, validundo, lastx, lasty, lastyzoom: integer;
    lastl, lastb, MeasureRa, MeasureDe: double;
    MeasureStartName, MeasureEndName: string;
    zoomstep, Xzoom1, Yzoom1, Xzoom2, Yzoom2, DXzoom, DYzoom, XZoomD1, YZoomD1,
    XZoomD2, YZoomD2, ZoomMove: integer;
    XM1, YM1, XMD1, YMD1: integer;
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh(SetFocus, newtime: boolean; showmsg: boolean = true);
    procedure AutoRefresh;
    procedure PrintChart(printlandscape: boolean;
      printcolor, printmethod, printresol: integer; printcmd1, printcmd2, printpath: string;
      cm: Tconf_main; preview: boolean);
    function FormatDesc: string;
    procedure ShowIdentLabel(newjd: boolean = True);
    function IdentXY(X, Y: integer; searchcenter: boolean = True;
      showlabel: boolean = True; ftype: integer = ftAll; radius: integer = 2; planetcenter: boolean = False): boolean;
    procedure IdentSearchResult(num, stype: string; itype: integer;
      ar1, de1: double; sr: string = ''; sn: string = ''; sd: string = '');
    procedure Identdetail(X, Y: integer);
    function ListXY(X, Y: integer; r: integer = 12; allobj:boolean=true; mincount:integer=0): boolean;
    function ListRaDec(ra, de, r: double; allobj:boolean=true; mincount:integer=0; maxcount:integer=100): boolean;
    function ListGrappaVar(ra, de: double): boolean;
    procedure rotation(rot: double);
    procedure GetSunImage;
    procedure CKeyDown(Key: word; Shift: TShiftState);
    function LoadMosaicFrameList: double;
    procedure NewMosaic(ra,de: double; resizechart: boolean);
    procedure EndMosaic(Sender: TObject);
    procedure SendMosaic(Sender: TObject);
    function cmd_SetCursorPosition(x, y: integer): string;
    function cmd_SetGridEQ(onoff: string): string;
    function cmd_SetGrid(onoff: string): string;
    function cmd_SetStarMode(i: integer): string;
    function cmd_SetNebMode(i: integer): string;
    function cmd_SetSkyMode(onoff: string): string;
    function cmd_SetProjection(proj: string): string;
    function cmd_SetFov(fov: string): string;
    function cmd_Resize(w, h: string): string;
    function cmd_GetChartEqsys: string;
    function cmd_SetChartEquinox(equinox: string): string;
    function cmd_SetFieldnumber(field: string): string;
    function cmd_SetRa(param1: string; strict:boolean=false): string;
    function cmd_SetDec(param1: string; strict:boolean=false): string;
    function cmd_SetDate(dt: string): string;
    function cmd_SetObs(obs: string): string;
    function cmd_IdentCursor: string;
    function cmd_IdentCenter: string;
    function cmd_IdentTelescope: string;
    function cmd_SaveImage(format, fn, quality: string): string;
    function cmd_Print(Method, Orient, Col, path: string): string;
    function cmd_getriseset: string;
    function cmd_MoveScope(RA, DE: string): string;
    function cmd_MoveScopeH(H, D: string): string;
    function cmd_TrackTelescope(onoff: string): string;
    function cmd_TrackObject(onoff: string): string;
    function cmd_ObslistLoad(fn: string): string;
    function cmd_ObslistFirst: string;
    function cmd_ObslistLast: string;
    function cmd_ObslistNext: string;
    function cmd_ObslistPrev: string;
    function cmd_ObslistLimit(onoff: string): string;
    function cmd_ObslistAirmassLimit(airmass: string): string;
    function cmd_ObslistTransitLimit(transit: string): string;
    function cmd_ObslistTransitSide(side: string): string;
    function cmd_GetScopeRaDec(format: string): string;
    function cmd_GetScopeRates: string;
    procedure GetScopeRates(rates: TStringList);
    function cmd_ScopeMoveAxis(axis, rate: string): string;
    function cmd_SetScopeRefreshRate(rate: string): string;
    function cmd_ConnectINDI: string;
    function cmd_DisconnectINDI: string;
    function cmd_DisconnectTelescope: string;
    function cmd_ConnectTelescope: string;
    function cmd_Sync(RA2, DE2: string): string;
    function cmd_Slew(RA1, DE1: string): string;
    function cmd_AbortSlew: string;
    function cmd_SlewINDI(RA1, DE1: string): string;
    function cmd_AbortSlewINDI: string;
    function cmd_SyncINDI(RA2, DE2: string): string;
    function cmd_GetScopeSlewing: string;
    function cmd_GetFrames: string;
    function cmd_LoadCircle(fn: string): string;
    function cmd_DefCircle(num, diameter, rotation, offset: string): string;
    function cmd_DefRectangle(num, w, h, rotation, offset: string): string;
    function cmd_ShowCircle(numlist: string): string;
    function cmd_ShowRectangle(numlist: string): string;
    function cmd_MarkCenter(onoff: string): string;
    function cmd_SetPlanisphereTime(onoff: string): string;
    function cmd_SetPlanisphereDate(onoff: string): string;
    function cmd_SetFOVProjection(fnum, proj: string): string;
    function cmd_ShowOnlyMeridian(onoff: string): string;
    function cmd_ShowAlwaysMeridian(onoff: string): string;
    function cmd_Cleanup: string;
    function ExecuteCmd(arg: TStringList): string;
    function SaveChartImage(format, fn: string; quality: integer = 95): boolean;
    procedure ZoomBox(action, x, y: integer);
    procedure MeasureDistance(action, x, y: integer);
    procedure TrackCursor(X, Y: integer; step: integer);
    procedure ZoomCursor(yy: double);
    procedure SetField(field: double; trackAltAz: boolean = True; doRefresh: boolean=true);
    procedure SetZenit(field: double; redraw: boolean = True);
    procedure SetAz(Az: double; redraw: boolean = True);
    procedure SetDateUT(y, m, d, h, n, s: integer);
    procedure SetJD(njd: double);
    procedure SwitchCompass(Sender: TObject);
    procedure CoordJ2000toChart(var ra, de: double);
    procedure CoordCharttoJ2000(var ra, de: double);
    function cmd_GetProjection: string;
    function cmd_GetSkyMode: string;
    function cmd_GetNebMode: string;
    function cmd_GetStarMode: string;
    function cmd_GetGrid: string;
    function cmd_GetGridEQ: string;
    function cmd_GetCursorPosition: string;
    function cmd_GetFov(format: string): string;
    function cmd_GetRA(format: string): string;
    function cmd_GetDEC(format: string): string;
    function cmd_GetDate: string;
    function cmd_GetObs: string;
    function cmd_SetTZ(tz: string): string;
    function cmd_GetTZ: string;
    function cmd_SetBGimage(onoff,setfov: string; loadnew: boolean=true): string;
    function cmd_LoadBGimage(fn,track: string): string;
    procedure ActivateImageCatalog;
    function cmd_SetShowPicture(onoff: string): string;
    function cmd_PDSS(DssDir, ImagePath, ImageName, useexisting: string): string;
    function cmd_GetObjectList: string;
    procedure cmd_GoXY(xx, yy: string);
    function cmd_IdXY(xx, yy: string): string;
    procedure cmd_MoreStar;
    procedure cmd_LessStar;
    procedure cmd_MoreNeb;
    procedure cmd_LessNeb;
    procedure cmd_LockMagn; overload;
    procedure cmd_LockMagn(mstar,mast,mcom,mneb,sneb: double; alldbl,allvar: boolean); overload;
    procedure cmd_UnLockMagn;
    function cmd_SetGridNum(onoff: string): string;
    function cmd_SetConstL(onoff: string): string;
    function cmd_SetConstB(onoff: string): string;
    function cmd_SwitchGridNum: string;
    function cmd_SwitchConstL: string;
    function cmd_SwitchConstB: string;
    procedure SetLang;
    procedure ChartActivate;
    procedure SetCameraRotation(cam: integer);
    procedure MoveCamera(angle: single);
    procedure cmdEq2Hz(ra, de: double; var a, h: double);
    procedure cmdHz2Eq(a, h: double; var ra, de: double);
    procedure cmdEq2Gal(ra, de: double; var l, b: double);
    procedure cmdGal2Eq(l, b: double; var ra, de: double);
    procedure cmdEq2Ecl(ra, de: double; var l, b: double);
    procedure cmdEcl2Eq(l, b: double; var ra, de: double);
    property OnImageSetFocus: TNotifyEvent read FImageSetFocus write FImageSetFocus;
    property OnSetScriptMenu: TNotifyEvent read FSetScriptMenu write FSetScriptMenu;
    property OnSetFocus: TNotifyEvent read FSetFocus write FSetFocus;
    property OnShowTopMessage: Tstr2func read FShowTopMessage write FShowTopMessage;
    property OnShowTitleMessage: Tstr2func read FShowTitleMessage
      write FShowTitleMessage;
    property OnUpdateBtn: Tbtnfunc read FUpdateBtn write FUpdateBtn;
    property OnShowInfo: TShowinfo read FShowInfo write FShowInfo;
    property OnSendInfo: TSendInfo read FSendInfo write FSendInfo;
    property OnShowCoord: Tstr1func read FShowCoord write FShowCoord;
    property OnListInfo: Tstr12func read FListInfo write FListInfo;
    property OnChartMove: TNotifyEvent read FChartMove write FChartMove;
    property OnImageSetup: TNotifyEvent read FImageSetup write FImageSetup;
    property NightVision: boolean read FNightVision write SetNightVision;
    property onSendCoordpointAtsky: TSendCoordpointAtsky
      read FSendCoordpointAtsky write FSendCoordpointAtsky;
    property onSendImageFits: TSendImageFits read FSendImageFits write FSendImageFits;
    property onSendSelectRow: TSendSelectRow read FSendSelectRow write FSendSelectRow;
    property onPlanetInfo: TNotifyEvent read FPlanetInfo write FPlanetInfo;
    property onTelescopeMove: Tfloat2func read GetTelescopeMove write SetTelescopeMove;
  end;

implementation

uses LazUTF8, LazFileUtils;

{$R *.lfm}

procedure Tf_chart.SetLang;
var
  i: integer;
begin
  About1.Caption := rsAbout;
  Centre1.Caption := rsCentre;
  Zoom1.Caption := rsZoomCentre;
  Zoom2.Caption := rsZoomCentre2;
  MenuFinderCircle.Caption := rsFinderCircle2;
  SelectCircle.Caption := rsSelectCircle;
  SelectRectangle.Caption := rsSelectRectan;
  EyepieceMask.Caption := rsEyepieceVisi;
  NewFinderCircle1.Caption := rsNewFinderCir;
  MenuNewMosaic.Caption := rsMosaic;
  RemoveLastCircle1.Caption := rsRemoveLastCi;
  RemoveAllCircles1.Caption := rsRemoveAllCir;
  MenuSaveCircle.Caption := rsSaveToFile;
  MenuLoadCircle.Caption := rsLoadFromFile;
  MenuLabel.Caption := rsLabels;
  AddLabel1.Caption := rsNewLabel;
  RemoveLastLabel1.Caption := rsRemoveLastLa;
  RemoveAllLabel1.Caption := rsRemoveAllLab;
  RecoverLabel.Caption := rsRecoverHidde;
  Resetalllabel.Caption := rsResetAllLabe;
  MenuSAMP.Caption := rsSAMPSendCoor;
  MenuSAMP1.Caption := rsCursorPositi;
  MenuSAMP2.Caption := rsSelectedObje;
  MenuSAMP3.Caption := rsChartCenter;
  MenuObslist.Caption := rsObservingLis;
  MenuViewObsList.Caption := rsViewObservin;
  MenuObslistFirst.Caption := rsFirst;
  MenuObslistLast.Caption := rsLast;
  MenuObslistNext.Caption := rsNext2;
  MenuObslistPrev.Caption := rsPrevious;
  MenuTelescopeToObsList.Caption := rsAddTelescope;
  MenuCursorToObsList.Caption := rsAddCursorPos;
  SearchName1.Caption := rsSearchByName;
  nsearch1.Caption := infoname_url[1, 2];
  nsearch2.Caption := infoname_url[2, 2];
  nsearch3.Caption := infoname_url[3, 2];
  nsearch4.Caption := infoname_url[4, 2];
  SearchMenu1.Caption := rsSearchByPosi;
  search1.Caption := infocoord_url[1, 2];
  search2.Caption := infocoord_url[2, 2];
  search3.Caption := infocoord_url[3, 2];
  Telescope1.Caption := rsTelescope;
  TrackTelescope1.Caption := rsTrackTelesco;
  SlewCursor.Caption := rsSlewToCursor;
  SlewCenter.Caption := rsSlewToChartC;
  Slew1.Caption := rsSlew;
  Sync1.Caption := rsSync;
  PrePointing.Caption:=rsPrePointing;
  CopyCoord.Caption := rsCopyCoordina;
  CopyCoord1.Caption := rsEquatorialCo+', [hms]';
  CopyCoord2000.Caption := rsEquatorialCo+', J2000 [hms]';
  CopyCoord2.Caption := '';
  Cleanupmap1.Caption := rsCleanupMap;
  Connect1.Caption := rsConnectTeles;
  AbortSlew1.Caption := rsAbortSlew;
  TrackOff1.Caption := rsUnlockChart;
  AllAtThisPos.Caption := rsAllObjectsAt;
  chart_imglist.Caption := rsImageList;
  DownloadDialog1.msgDownloadFile := rsDownloadFile;
  DownloadDialog1.msgCopyfrom := rsCopyFrom;
  DownloadDialog1.msgtofile := rsToFile;
  DownloadDialog1.msgDownloadBtn := rsDownload;
  DownloadDialog1.msgCancelBtn := rsCancel;
  if sc <> nil then
    sc.SetLang;
  if Fpop_scope <> nil then
    Fpop_scope.SetLang;
  // Menu accelerator
  for i := 0 to MaxMenulevel do
    AccelList[i] := '';
  SetMenuAccelerator(PopupMenuChart.items, 0, AccelList);
end;

constructor Tf_chart.Create(TheOwner: TComponent);
var
  i: integer;
begin
  if VerboseMsg then
    WriteTrace('Create new chart');
  inherited Create(TheOwner);
  DownloadDialog1.ScaleDpi:=UScaleDPI.scale;
  Width := max(Width, 2 * Application.MainForm.Width div 3);
  Height := max(Height, 2 * Application.MainForm.Height div 3);
  locked := True;
  lockmove := False;
  lockkey := False;
  movecam := False;
  moveguide := False;
  frommovecam := False;
  printing := False;
  MeasureOn := False;
  ScopeSlewing := false;
  KeyPressTime := 0;
  SetLang;
  for i := 1 to maxundo do
    undolist[i] := Tconf_skychart.Create;
  Image1 := TChartDrawingControl.Create(Self);
  Image1.Parent := Panel1;
  IdentLabel.Parent := Image1;
  Image1.Align := alClient;
  Image1.DoubleBuffered := True;
  Image1.OnClick := Image1Click;
  image1.OnDblClick := Image1DblClick;
  Image1.OnMouseDown := Image1MouseDown;
  Image1.OnMouseMove := Image1MouseMove;
  Image1.OnMouseUp := Image1MouseUp;
  Image1.OnMouseWheel := Image1MouseWheel;
  Image1.OnPaint := Image1Paint;
  Image1.PopupMenu := PopupMenuChart;
  Image1.TabStop := True;
  sc := Tskychart.Create(Image1);
  sc.Image := Image1.Canvas;
  sc.onUpdObsListTime := UpdObsListTime;
  sc.onRefreshImage := RefreshImage;
  // set initial value
  sc.cfgsc.racentre := 1.4;
  sc.cfgsc.decentre := 0;
  sc.cfgsc.fov := 1;
  sc.cfgsc.theta := 0;
  sc.cfgsc.projtype := 'A';
  sc.cfgsc.ProjPole := Equat;
  sc.cfgsc.FlipX := 1;
  sc.cfgsc.FlipY := 1;
  sc.onShowDetailXY := IdentDetail;
  sc.InitChart(False);
  skipmove := 0;
  movefactor := 4;
  zoomfactor := 2;
  lastundo := 0;
  validundo := 0;
  LockKeyboard := False;
  LockTrackCursor := False;
  TrackingCursor := False;
  ChartCursor := crRetic;
  Image1.Cursor := ChartCursor;
  lock_refresh := False;
  MovingCircle := False;
  HorScrollBar.onScroll := HorScrollBarScroll;
  VertScrollBar.onScroll := VertScrollBarScroll;
  VertScrollBar.Width := DoScaleX(15);
  HorScrollBar.Height := DoScaleY(15);
  VertScrollBar.Max := 90 * 3600;   // arcsecond position precision
  VertScrollBar.Min := -90 * 3600;
  VertScrollBar.SmallChange := 3600;
  VertScrollBar.LargeChange := 8 * VertScrollBar.SmallChange;
  VertScrollBar.PageSize := VertScrollBar.LargeChange;
  VertScrollBar.Width := HorScrollBar.Height;
  HorScrollBar.Max := 360 * 3600;
  HorScrollBar.Min := 0;
  HorScrollBar.SmallChange := 3600;
  HorScrollBar.LargeChange := 8 * HorScrollBar.SmallChange;
  HorScrollBar.PageSize := HorScrollBar.LargeChange;
end;

destructor Tf_chart.Destroy;
var
  i: integer;
  ok: boolean;
begin
  if VerboseMsg then
    WriteTrace('Destroy chart ' + sc.cfgsc.chartname);
  try
    locked := True;
    while lock_refresh do
    begin
      sleep(10);
      application.ProcessMessages;
    end;
    RefreshTimer.Enabled := False;
    while TelescopeLock do
    begin
      sleep(10);
      application.ProcessMessages;
    end;
    TelescopeTimer.Enabled := False;
    if sc <> nil then
      sc.Free;
    Image1.Free;
    if prtsc <> nil then
      prtsc.Free;
    if prtImage <> nil then
      prtImage.Free;
    if Fpop_scope <> nil then
    begin
      if Connect1.Checked then
        Fpop_scope.ScopeDisconnect(ok);
      Fpop_scope.Free;
    end;
    if f_imglist <> nil then
      f_imglist.Free;
    for i := 1 to maxundo do
      undolist[i].Free;
    inherited Destroy;
    if VerboseMsg then
      WriteTrace('End Destroy chart ');
  except
    writetrace('error destroy ' + Name);
  end;
end;

procedure Tf_chart.Image1Click(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' Image1Click');
  // to restore focus to the chart that as no text control
  if assigned(FSetFocus) then
    FSetFocus(Self);
  if assigned(FImageSetFocus) then
    FImageSetFocus(Sender);
  //setfocus;
end;

procedure Tf_chart.Image1DblClick(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' Image1DblClick');
  if identlabel.Visible then
    identlabelClick(Sender);
end;

procedure Tf_chart.GetSunImage;
var
  fn: string;
begin
  fn := slash(TempDir) + 'sun.jpg';
  if sc.cfgsc.SunOnline and ((not FileExists(fn)) or
    ((now - FileDateToDateTime(FileAge(fn))) > (sc.cfgsc.sunrefreshtime / 24))) then
  begin
    if cmain.HttpProxy then
    begin
      DownloadDialog1.SocksProxy := '';
      DownloadDialog1.SocksType := '';
      DownloadDialog1.HttpProxy := cmain.ProxyHost;
      DownloadDialog1.HttpProxyPort := cmain.ProxyPort;
      DownloadDialog1.HttpProxyUser := cmain.ProxyUser;
      DownloadDialog1.HttpProxyPass := cmain.ProxyPass;
    end
    else if cmain.SocksProxy then
    begin
      DownloadDialog1.HttpProxy := '';
      DownloadDialog1.SocksType := cmain.SocksType;
      DownloadDialog1.SocksProxy := cmain.ProxyHost;
      DownloadDialog1.HttpProxyPort := cmain.ProxyPort;
      DownloadDialog1.HttpProxyUser := cmain.ProxyUser;
      DownloadDialog1.HttpProxyPass := cmain.ProxyPass;
    end
    else
    begin
      DownloadDialog1.SocksProxy := '';
      DownloadDialog1.SocksType := '';
      DownloadDialog1.HttpProxy := '';
      DownloadDialog1.HttpProxyPort := '';
      DownloadDialog1.HttpProxyUser := '';
      DownloadDialog1.HttpProxyPass := '';
    end;
    DownloadDialog1.URL := sc.cfgsc.sunurl;
    DownloadDialog1.SaveToFile := fn;
    DownloadDialog1.ConfirmDownload := False;
    if DownloadDialog1.Execute and FileExists(fn) then
    begin

    end
    else
    begin
      sc.cfgsc.SunOnline := False;
    end;
  end;
end;

procedure Tf_chart.AutoRefresh;
begin
  if locked then
    exit;
  if VerboseMsg then
    WriteTrace(Caption + ' AutoRefresh');
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  Refresh(False, True);  // do not steal focus with autorefresh
end;

procedure Tf_chart.Refresh(SetFocus, newtime: boolean; showmsg: boolean = true);
var
  savebg: Tcolor;
  saveantialias: boolean;
  i: integer;
  sra, sde, mag: double;
  step: string;
{$ifdef showtime}
  starttime: TDateTime;
{$endif}
begin
  if printing then
    exit;
  if VerboseMsg then
    WriteTrace('Chart ' + sc.cfgsc.chartname + ': Refresh');
{$ifdef showtime}
  starttime := now;
{$endif}
  if locked then
    exit;
  if lock_refresh then
    exit;
  try
  try
    step:='init';
    if VerboseMsg then
      WriteTrace('Chart ' + sc.cfgsc.chartname + ': Get refresh lock');
    lock_refresh := True;
    lastquick := sc.cfgsc.quick;
    saveantialias := sc.plot.cfgplot.AntiAlias;
    if lastquick then
      sc.plot.cfgplot.AntiAlias := False;
    zoomstep := 0;
    step:='movecam';
    if (not frommovecam) and (movecam or moveguide) then
    begin
      movecam := False;
      moveguide := False;
      for i := 1 to sc.cfgsc.ncircle do
        sc.cfgsc.circle[i, 4] := 0;
      for i := 1 to sc.cfgsc.nrectangle do
        sc.cfgsc.rectangle[i, 5] := 0;
    end;
    frommovecam := False;
    step:='init plot';
    identlabel.Visible := False;
    MeasureOn:=false;
    Image1.Width := clientwidth;
    Image1.Height := clientheight;
    if VerboseMsg then
      WriteTrace('Chart ' + sc.cfgsc.chartname + ': Init ' + IntToStr(Image1.Width) +
        'x' + IntToStr(Image1.Height));
    sc.plot.init(Image1.Width, Image1.Height);
    savebg := sc.plot.cfgplot.color[0];
    if (sc.plot.cfgplot.color[0] < clWhite) and not
      (sc.plot.cfgplot.AutoSkyColor and (sc.cfgsc.Projpole = AltAz)) then
      sc.plot.cfgplot.bgcolor := sc.plot.cfgplot.skycolor[0];
    if VerboseMsg then
      WriteTrace('Chart ' + sc.cfgsc.chartname + ': Draw map');
    step:='Sun image';
    if sc.plot.cfgplot.plaplot = 2 then
      GetSunImage;
    if sc.cfgsc.ShowBackgroundImage then
      sc.cfgsc.ShowImageList := True;
    step:='Object list';
    if sc.cfgsc.quick then
    begin
      sc.ObjectListLabels := f_obslist.EmptyObjLabels;
      sc.UpdObsList := False;
    end
    else
    begin
      sc.ObjectListLabels := f_obslist.ObjLabels;
      sc.UpdObsList := True;
    end;
    step:='chart';
    sc.Refresh(newtime);
    step:='finalize';
    if VerboseMsg then
      WriteTrace('Chart ' + sc.cfgsc.chartname + ': Draw map end');
    sc.plot.cfgplot.color[0] := savebg;
    Image1.Invalidate;
    if not lastquick then
    begin
      Inc(lastundo);
      Inc(validundo);
      if lastundo > maxundo then
        lastundo := 1;
      undolist[lastundo].Assign(sc.cfgsc);
      curundo := lastundo;
      if sc.cfgsc.FindOk and (not cmain.SimpleDetail) and
        (sc.cfgsc.FindName = sc.cfgsc.TrackName) then
      begin
        step:='Ident label';
        case sc.cfgsc.FindType of
          ftPla:
          begin
            sc.planet.FindPlanetName(sc.cfgsc.FindName, sra, sde, sc.cfgsc, True);
            sc.cfgsc.FindRA2000 := sra;
            sc.cfgsc.FindDec2000 := sde;
            ShowIdentLabel(False);
            Fshowinfo(sc.cfgsc.FindDesc, Caption, False, nil, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
          end;
          ftCom:
          begin
            sc.planet.FindCometName(sc.cfgsc.FindName, sra, sde, mag,
              sc.cfgsc, False, True);
            sc.cfgsc.FindRA2000 := sra;
            sc.cfgsc.FindDec2000 := sde;
            ShowIdentLabel(False);
            Fshowinfo(sc.cfgsc.FindDesc, Caption, False, nil, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
          end;
          ftAst:
          begin
            sc.planet.FindAsteroidName(sc.cfgsc.FindName, sra, sde,
              mag, sc.cfgsc, False, True);
            sc.cfgsc.FindRA2000 := sra;
            sc.cfgsc.FindDec2000 := sde;
            ShowIdentLabel(False);
            Fshowinfo(sc.cfgsc.FindDesc, Caption, False, nil, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
          end;
          ftBody:
          begin
            sc.planet.FindBodyName(sc.cfgsc.FindName, sra, sde, mag, sc.cfgsc, False, True);
            sc.cfgsc.FindRA2000 := sra;
            sc.cfgsc.FindDec2000 := sde;
            ShowIdentLabel(False);
            Fshowinfo(sc.cfgsc.FindDesc, Caption, False, nil, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
          end;
          else
            ShowIdentLabel(False);
        end;
      end;
      if assigned(FShowTopMessage) then
        FShowTopMessage(sc.GetChartInfo, self);
      if assigned(FShowTitleMessage) then
        FShowTitleMessage(sc.GetChartPos, self);
      Image1.Cursor := ChartCursor;
    end;
  finally
    if VerboseMsg then
      WriteTrace('Chart ' + sc.cfgsc.chartname + ': Release refresh lock');
    lock_refresh := False;
    sc.plot.cfgplot.AntiAlias := saveantialias;
    EyepieceMask.Checked := sc.cfgsc.EyepieceMask;
    if (not lastquick) and assigned(FUpdateBtn) then
      FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
    if (not lastquick) and sc.cfgsc.moved and assigned(FChartMove) then
      FChartMove(self);
  end;
  if SetFocus and assigned(FImageSetFocus) then
    FImageSetFocus(Self);
  if assigned(Fshowinfo) then
  begin
  {$ifdef showtime}
    Fshowinfo('Drawing time: ' + formatfloat(f2, (now - starttime) * 86400));
  {$else}
    if sc.cfgsc.TrackOn then
    begin
      if ((sc.cfgsc.TrackType > TTplanet) and (sc.cfgsc.TrackType < TTequat)) or (sc.cfgsc.TrackType = TTbody) then
        IdentXY(Image1.Width div 2, Image1.Height div 2)
      else
      begin
        if (not sc.cfgsc.FindOk) and (sc.cfgsc.FindName = sc.cfgsc.TrackName) then
        begin
          sc.cfgsc.FindOk := True;
          ShowIdentLabel;
        end;
      end;
    end
    else
    begin
      Fshowinfo(sc.cfgsc.msg);
      if showmsg and sc.cfgsc.FindOk and (not cmain.SimpleDetail) and (sc.cfgsc.msg = '') then
        Fshowinfo(sc.cfgsc.FindDesc, Caption, True, self, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
    end;
  {$endif}
  end;
  Panel1.Color := clDefault;
  SetScrollBar(not newtime);
  if VerboseMsg then
    WriteTrace('Chart ' + sc.cfgsc.chartname + ': Refresh end');
  except
    on E: Exception do WriteTrace('Refresh, '+step+' error: ' + E.Message);
  end;
end;

procedure Tf_chart.chart_UndoExecute(Sender: TObject);
var
  i, j: integer;
begin
  if locked then
    exit;
  if VerboseMsg then
    WriteTrace(Caption + ' UndoExecute');
  zoomstep := 0;
  i := curundo - 1;
  j := lastundo + 1;
  if i < 1 then
    i := maxundo;
  if j > maxundo then
    j := 1;
  if (i <= validundo) and (i <> lastundo) and ((i < lastundo) or (i >= j)) then
  begin
    curundo := i;
    identlabel.Visible := False;
    sc.cfgsc.Assign(undolist[curundo]);
    sc.plot.init(Image1.Width, Image1.Height);
    sc.Refresh(True);
    Image1.Invalidate;
    if assigned(FUpdateBtn) then
      FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
    if assigned(fshowtopmessage) then
      fshowtopmessage(sc.GetChartInfo, self);
    if assigned(FChartMove) then
      FChartMove(self);
    SetScrollBar;
  end;
end;

procedure Tf_chart.chart_RedoExecute(Sender: TObject);
var
  i, j: integer;
begin
  if locked then
    exit;
  if VerboseMsg then
    WriteTrace(Caption + ' RedoExecute');
  zoomstep := 0;
  i := curundo + 1;
  j := lastundo + 1;
  if i > maxundo then
    i := 1;
  if j > maxundo then
    j := 1;
  if (i <= validundo) and (i <> j) and ((i <= lastundo) or (i > j)) then
  begin
    curundo := i;
    identlabel.Visible := False;
    sc.cfgsc.Assign(undolist[curundo]);
    sc.plot.init(Image1.Width, Image1.Height);
    sc.Refresh(True);
    Image1.Invalidate;
    if assigned(FUpdateBtn) then
      FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
    if assigned(fshowtopmessage) then
      fshowtopmessage(sc.GetChartInfo, self);
    if assigned(FChartMove) then
      FChartMove(self);
    SetScrollBar;
  end;
end;

procedure Tf_chart.ChartResize(Sender: TObject);
begin
  if locked {or (fsCreating in FormState)} then
    exit;
  if VerboseMsg then
    WriteTrace(Caption + ' ChartResize');
  RefreshTimer.Enabled := False;
  RefreshTimer.Enabled := True;
  if sc <> nil then
  begin
    sc.plot.init(Image1.Width, Image1.Height);
  end;
  Image1.Invalidate;
end;

procedure Tf_chart.EyepieceMaskClick(Sender: TObject);
begin
  sc.cfgsc.EyepieceMask := not sc.cfgsc.EyepieceMask;
  EyepieceMask.Checked := sc.cfgsc.EyepieceMask;
  Refresh(True, False);
end;

procedure Tf_chart.SetScrollBar(ShowPosition: boolean=true);
var
  i: integer;
  x: double;
begin
  lockscrollbar := True;
  try
    if VertScrollBar.Visible then
      with sc do
      begin
        if cfgsc.Projpole = AltAz then
        begin
          if cfgsc.ObsLatitude>=0 then
            x:=pi   // mid range is south
          else
            x:=0;   // mid range is north
          HorScrollBar.Position := round(rmod(cfgsc.acentre + pi2 + x, pi2) * rad2deg * 3600);
          VertScrollBar.Position := -round(cfgsc.hcentre * rad2deg * 3600);
        end
        else if cfgsc.Projpole = Gal then
        begin
          HorScrollBar.Position := round(rmod(pi2 - cfgsc.lcentre + pi2, pi2) * rad2deg * 3600);
          VertScrollBar.Position := -round(cfgsc.bcentre * rad2deg * 3600);
        end
        else if cfgsc.Projpole = Ecl then
        begin
          HorScrollBar.Position := round(rmod(pi2 - cfgsc.lecentre + pi2, pi2) * rad2deg * 3600);
          VertScrollBar.Position := -round(cfgsc.becentre * rad2deg * 3600);
        end
        else
        begin // Equ
          HorScrollBar.Position := round(rmod(pi2 - cfgsc.racentre + pi2, pi2) * rad2deg * 3600);
          VertScrollBar.Position := -round(cfgsc.decentre * rad2deg * 3600);
        end;
        i := round(rad2deg * 3600 * cfgsc.fov / 90);
        if i < 1 then
          i := 1;
        if i > 3600 then
          i := 3600;
        VertScrollBar.SmallChange := i;
        VertScrollBar.LargeChange := 8 * VertScrollBar.SmallChange;
        VertScrollBar.PageSize := VertScrollBar.LargeChange;
        HorScrollBar.SmallChange := i;
        HorScrollBar.LargeChange := 8 * HorScrollBar.SmallChange;
        HorScrollBar.PageSize := HorScrollBar.LargeChange;
        if ShowPosition then ShowCoord(Image1.Width div 2, Image1.Height div 2);
      end;
  finally
    lockscrollbar := False;
  end;
end;

procedure Tf_chart.HorScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: integer);
var x: double;
begin
  if lockscrollbar then
    exit;
  lockscrollbar := True;
  application.ProcessMessages;
  // empty the message queue and process only the last position
  if VerboseMsg then
    WriteTrace(Caption + ' HorScrollBarScroll');
  try
    with sc do
    begin
      cfgsc.TrackOn := False;
      cfgsc.Quick := True;
      if cfgsc.Projpole = AltAz then
      begin
        if cfgsc.ObsLatitude>=0 then
          x:=pi   // mid range is south
        else
          x:=0;   // mid range is north
        cfgsc.acentre := rmod(deg2rad * HorScrollBar.Position / 3600 + pi4 - x, pi2);
        Hz2Eq(cfgsc.acentre, cfgsc.hcentre, cfgsc.racentre, cfgsc.decentre, cfgsc);
        cfgsc.racentre := cfgsc.CurST - cfgsc.racentre;
      end
      else if cfgsc.Projpole = Gal then
      begin
        cfgsc.lcentre := rmod(pi2 - deg2rad * HorScrollBar.Position / 3600 + pi2, pi2);
        Gal2Eq(cfgsc.lcentre, cfgsc.bcentre, cfgsc.racentre, cfgsc.decentre, cfgsc);
      end
      else if cfgsc.Projpole = Ecl then
      begin
        cfgsc.lecentre := rmod(pi2 - deg2rad * HorScrollBar.Position / 3600 + pi2, pi2);
        Ecl2Eq(cfgsc.lecentre, cfgsc.becentre, cfgsc.ecl, cfgsc.racentre, cfgsc.decentre);
      end
      else
      begin // Equ
        cfgsc.racentre := rmod(pi2 - deg2rad * HorScrollBar.Position / 3600 + pi2, pi2);
      end;
    end;
    Refresh(True, False);
    RefreshTimer.Enabled := False;
    RefreshTimer.Enabled := True;
  finally
    lockscrollbar := False;
  end;
end;

procedure Tf_chart.VertScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: integer);
begin
  if lockscrollbar then
    exit;
  lockscrollbar := True;
  application.ProcessMessages;
  // empty the message queue and process only the last position
  if VerboseMsg then
    WriteTrace(Caption + ' VertScrollBarScroll');
  try
    with sc do
    begin
      cfgsc.TrackOn := False;
      cfgsc.Quick := True;
      if cfgsc.Projpole = AltAz then
      begin
        cfgsc.hcentre := -deg2rad * VertScrollBar.Position / 3600;
        if cfgsc.hcentre > pid2 then
          cfgsc.hcentre := pi - cfgsc.hcentre;
        Hz2Eq(cfgsc.acentre, cfgsc.hcentre, cfgsc.racentre, cfgsc.decentre, cfgsc);
        cfgsc.racentre := cfgsc.CurST - cfgsc.racentre;
      end
      else if cfgsc.Projpole = Gal then
      begin
        cfgsc.bcentre := -deg2rad * VertScrollBar.Position / 3600;
        if cfgsc.bcentre > pid2 then
          cfgsc.bcentre := pi - cfgsc.bcentre;
        Gal2Eq(cfgsc.lcentre, cfgsc.bcentre, cfgsc.racentre, cfgsc.decentre, cfgsc);
      end
      else if cfgsc.Projpole = Ecl then
      begin
        cfgsc.becentre := -deg2rad * VertScrollBar.Position / 3600;
        if cfgsc.becentre > pid2 then
          cfgsc.becentre := pi - cfgsc.becentre;
        Ecl2Eq(cfgsc.lecentre, cfgsc.becentre, cfgsc.ecl, cfgsc.racentre, cfgsc.decentre);
      end
      else
      begin // Equ
        cfgsc.decentre := -deg2rad * VertScrollBar.Position / 3600;
        if cfgsc.decentre > pid2 then
          cfgsc.decentre := pi - cfgsc.decentre;
      end;
    end;
    Refresh(True, False);
    RefreshTimer.Enabled := False;
    RefreshTimer.Enabled := True;
  finally
    lockscrollbar := False;
  end;
end;

procedure Tf_chart.Image1Paint(Sender: TObject);
begin
  if locked then
    exit;
  //if VerboseMsg then WriteTrace(caption+' Paint');
  sc.plot.FlushCnv;
  inherited Paint;
  if MovingCircle then
  begin
    sc.DrawFinderMark(sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], True, -1);
  end;
  if Zoomstep > 1 then
  begin
    with Image1.Canvas do
    begin
      Pen.Width := 1;
      pen.Color := clWhite;
      Pen.Mode := pmXor;
      brush.Style := bsclear;
      rectangle(Rect(XZoomD1, YZoomD1, XZoomD2, YZoomD2));
      Pen.Mode := pmCopy;
      brush.Style := bsSolid;
    end;
  end;
  if MeasureOn then
    with Image1.Canvas do
    begin
      Pen.Width := 1;
      pen.Color := clWhite;
      Pen.Mode := pmXor;
      brush.Style := bsclear;
      MoveTo(XM1, YM1);
      LineTo(XMD1, YMD1);
      Pen.Mode := pmCopy;
      brush.Style := bsSolid;
    end;
  if sc.cfgsc.scopemark then
  begin
    sc.DrawFinderMark(sc.cfgsc.ScopeRa, sc.cfgsc.ScopeDec, True, -1);
  end;
  if sc.cfgsc.scope2mark then
  begin
    sc.DrawFinderMark(sc.cfgsc.Scope2Ra, sc.cfgsc.Scope2Dec, True, -1, MarkType);
  end;
  if (((sc.cfgsc.Trackon) and (sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or
    (sc.cfgsc.FindOK)) and (sc.cfgsc.TrackName <> rsTelescope) and (sc.cfgsc.TrackName <> '') then
  begin
    sc.DrawSearchMark(sc.cfgsc.TrackRA, sc.cfgsc.TrackDec, False);
  end;
end;

procedure TChartDrawingControl.Paint;
begin
  inherited Paint;
end;

procedure Tf_chart.RefreshTimerTimer(Sender: TObject);
begin
  RefreshTimer.Enabled := False;
  if locked then
    exit;
  lockscrollbar := False;
  VertScrollBar.Enabled := True;
  HorScrollBar.Enabled := True;
  //if sc<>nil then sc.plot.init(Image1.width,Image1.height);
  if VerboseMsg then
    WriteTrace('Chart ' + sc.cfgsc.chartname + ': RefreshTimer');
  Refresh(False, True); // do not set focus on random timer event
end;

procedure Tf_chart.RemoveAllLabel1Click(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' RemoveAllLabel1Click');
  sc.ResetAllLabel;
end;

procedure Tf_chart.RemoveLastLabel1Click(Sender: TObject);
var
  j: integer;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' RemoveLastLabel1Click');
  if sc.cfgsc.poscustomlabels > 0 then
  begin
    for j := sc.cfgsc.poscustomlabels + 1 to sc.cfgsc.numcustomlabels do
      sc.cfgsc.customlabels[j - 1] := sc.cfgsc.customlabels[j];
    Dec(sc.cfgsc.numcustomlabels);
    sc.cfgsc.poscustomlabels := sc.cfgsc.numcustomlabels;
  end;
  Refresh(True, False);
end;

procedure Tf_chart.SAMPsendCursorCoordClick(Sender: TObject);
var
  cn, client: string;
  i: integer;
  ra, de, a, h, l, b, le, be: double;
begin
  client := '';
  cn := TMenuItem(Sender).Caption;
  for i := 0 to SampClientName.Count - 1 do
  begin
    if SampClientName[i] = cn then
    begin
      client := SampClientId[i];
      break;
    end;
  end;
  sc.GetCoord(xcursor, ycursor, ra, de, a, h, l, b, le, be);
  if sc.cfgsc.ApparentPos then
    mean_equatorial(ra, de, sc.cfgsc, True, True);
  precession(sc.cfgsc.JDChart, jd2000, ra, de);
  if assigned(FSendCoordpointAtsky) then
    FSendCoordpointAtsky(client, ra, de);
end;

procedure Tf_chart.SAMPsendObjectCoordClick(Sender: TObject);
var
  cn, client: string;
  i: integer;
  ra, de: double;
begin
  if sc.cfgsc.FindOK then begin
    client := '';
    cn := TMenuItem(Sender).Caption;
    for i := 0 to SampClientName.Count - 1 do
    begin
      if SampClientName[i] = cn then
      begin
        client := SampClientId[i];
        break;
      end;
    end;
    ra:=sc.cfgsc.FindRA2000;
    de:=sc.cfgsc.FindDec2000;
    if assigned(FSendCoordpointAtsky) then
      FSendCoordpointAtsky(client, ra, de);
  end
  else begin
    Fshowinfo(rsNoTargetObje);
  end;
end;

procedure Tf_chart.SAMPsendCenterCoordClick(Sender: TObject);
var
  cn, client: string;
  i: integer;
  ra, de: double;
begin
  client := '';
  cn := TMenuItem(Sender).Caption;
  for i := 0 to SampClientName.Count - 1 do
  begin
    if SampClientName[i] = cn then
    begin
      client := SampClientId[i];
      break;
    end;
  end;
  ra:=sc.cfgsc.racentre2000;
  de:=sc.cfgsc.decentre2000;
  if assigned(FSendCoordpointAtsky) then
    FSendCoordpointAtsky(client, ra, de);
end;

procedure Tf_chart.search1Click(Sender: TObject);
var
  ra, de, a, h, l, b, le, be: double;
  i: integer;
  sra, sde, dra,dde, url: string;
begin
  i := TMenuItem(Sender).tag;
  if (i > 0) and (i <= infocoord_maxurl) then
  begin
    sc.GetCoord(xcursor, ycursor, ra, de, a, h, l, b, le, be);
    if sc.cfgsc.ApparentPos then
      mean_equatorial(ra, de, sc.cfgsc, True, True);
    precession(sc.cfgsc.JDChart, jd2000, ra, de);
    sra := trim(ARtoStr(rad2deg * ra / 15));
    sde := trim(DEToStr3(rad2deg * de));
    dra := trim(FormatFloat(f6,rad2deg * ra));
    dde := trim(FormatFloat(f6,rad2deg * de));
    if (Copy(sde, 1, 1) <> '-') then
      sde := '%2b' + sde;
    url := infocoord_url[i, 1];
    url := StringReplace(url, '$RA', sra, []);
    url := StringReplace(url, '$DE', sde, []);
    url := StringReplace(url, '$DRA', dra, []);
    url := StringReplace(url, '$DDE', dde, []);
    ExecuteFile(url);
  end;
end;

procedure Tf_chart.nsearch1Click(Sender: TObject);
var
  i: integer;
  url, n: string;
begin
  i := TMenuItem(Sender).tag;
  if (i > 0) and (i <= infoname_maxurl) then
  begin
    n := sc.cfgsc.FindName;
    if pos('BSC', n) = 1 then
      Delete(n, 1, 3);
    if pos('Sky', n) = 1 then
      Delete(n, 1, 3);
    if copy(n,1,6)='UCAC4-' then
      n[6]:=' ';
    n := EncodeURLElement(n);
    url := infoname_url[i, 1];
    url := StringReplace(url, '$ID', n, []);
    ExecuteFile(url);
  end;
end;

procedure Tf_chart.SlewCursorClick(Sender: TObject);
var
  ra, Dec, a, h, l, b, le, be: double;
begin
  sc.GetCoord(xcursor, ycursor, ra, Dec, a, h, l, b, le, be);
  sc.cfgsc.FindRA := ra;
  sc.cfgsc.FindDEC := Dec;
  sc.cfgsc.FindName := 'cursor';
  Slew1Click(Sender);
end;

procedure Tf_chart.SlewCenterClick(Sender: TObject);
begin
  sc.cfgsc.FindRA := sc.cfgsc.racentre;
  sc.cfgsc.FindDEC := sc.cfgsc.decentre;
  sc.cfgsc.FindName := 'center';
  Slew1Click(Sender);
end;

procedure Tf_chart.Target1Click(Sender: TObject);
begin
  if sc.cfgsc.TargetOn then
  begin
    if VerboseMsg then
      WriteTrace('Target click 1');
    sc.cfgsc.TargetOn := False;
    Refresh(True, False);
  end
  else if ((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or (sc.cfgsc.TrackType = TTequat) or (sc.cfgsc.TrackType = TTbody) then
  begin
    if VerboseMsg then
      WriteTrace('Target click 2');
    sc.cfgsc.TargetOn := True;
    sc.cfgsc.TargetName := sc.cfgsc.TrackName;
    sc.cfgsc.TargetRA := sc.cfgsc.TrackRA;
    sc.cfgsc.TargetDec := sc.cfgsc.TrackDec;
    Refresh(True, False);
  end;
end;

procedure Tf_chart.TrackTelescope1Click(Sender: TObject);
begin
  if sc.cfgsc.TrackOn and (sc.cfgsc.TrackName = rsTelescope) then
  begin
    sc.cfgsc.TrackOn := False;
    if VerboseMsg then
      WriteTrace('Track Telescope 1');
    Refresh(True, True);
  end
  else if Connect1.Checked then
  begin
    if VerboseMsg then
      WriteTrace('Track Telescope 2');
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTequat;
    sc.cfgsc.TrackName := rsTelescope;
    sc.cfgsc.TrackRA := sc.cfgsc.ScopeRa;
    sc.cfgsc.TrackDec := sc.cfgsc.ScopeDec;
    sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
    sc.cfgsc.scopemark := True;
    sc.MovetoRaDec(sc.cfgsc.ScopeRa, sc.cfgsc.ScopeDec);
    Refresh(True, True);
  end;
  if Sender = TrackTelescope1 then
    TMenuItem(Sender).Checked := (sc.cfgsc.TrackOn and (sc.cfgsc.TrackName = rsTelescope));
end;

procedure FixPostscript(fn: string; printlandscape: boolean; pw, ph: integer);
var
  buf: TStringList;
  i: integer;
begin
  buf := TStringList.Create;
  buf.LoadFromFile(fn);
  // PageSize required for ps2pdf
  if printlandscape then
  begin
    i := buf.IndexOf('%%Page: 1 1') + 1;
    if i > 1 then
    begin
      buf.Insert(i, '<< /PageSize [' + IntToStr(ph) + ' ' + IntToStr(pw) + '] >> setpagedevice');
    end;
  end
  else
  begin
    i := buf.IndexOf('%%Page: 1 1') + 1;
    if i > 1 then
    begin
      buf.Insert(i, '<< /PageSize [' + IntToStr(pw) + ' ' + IntToStr(ph) + '] >> setpagedevice');
    end;
  end;
  buf.SaveToFile(fn);
  buf.Free;
end;

procedure Tf_chart.PrintChart(printlandscape: boolean;
  printcolor, printmethod, printresol: integer; printcmd1, printcmd2, printpath: string;
  cm: Tconf_main; preview: boolean);
var
  resol, rp: integer;
  rs: single;
  printok: boolean;
  prtname: string;
  fname: string;
  w, h, x, y: integer;
  ts: TSize;
  HeaderHeight, FooterHeight: integer;
  pt: TPoint;
  ps: TPostscriptCanvas;
  png: TPortableNetworkGraphic;
  previewbmp: Tbitmap;
const
  DefHeaderHeight = 10;
  DefFooterHeight = 20;

  procedure InitPrintColor;
  var
    i: integer;
  begin
    if printcolor <> 2 then
    begin
      // force line drawing
      prtsc.plot.cfgplot.starplot := 0;
      prtsc.plot.cfgplot.nebplot := 0;
      if prtsc.plot.cfgplot.plaplot = 2 then
        prtsc.plot.cfgplot.plaplot := 1;
      // ensure white background
      prtsc.plot.cfgplot.autoskycolor := False;
      if printcolor = 0 then
      begin
        prtsc.plot.cfgplot.color[0] := clWhite;
        prtsc.plot.cfgplot.color[11] := clBlack;
      end
      else
      begin
        prtsc.plot.cfgplot.color := DfWBColor;
      end;
      if printcolor < 2 then
        for i := 1 to numlabtype do
          prtsc.plot.cfgplot.LabelColor[i] := clBlack;
      prtsc.plot.cfgplot.bgColor := prtsc.plot.cfgplot.color[0];
    end;
  end;

begin
  if VerboseMsg then
    WriteTrace(Caption + ' PrintChart');
  zoomstep := 0;
  // create chart object for printing the first time we print
  if prtImage = nil then
    prtImage := TChartDrawingControl.Create(Self);
  if prtsc = nil then
  begin
    prtsc := Tskychart.Create(self);
    prtsc.Image := prtImage.Canvas;
    prtsc.catalog := sc.catalog;
    prtsc.Fits := sc.Fits;
    prtsc.planet := sc.planet;
    prtsc.cdb := sc.cdb;
    prtsc.plot.starshape := sc.plot.starshape;
    prtsc.plot.compassrose := sc.plot.compassrose;
    prtsc.plot.compassarrow := sc.plot.compassarrow;
  end;
  try
    prtsc.plot.cfgplot.Assign(sc.plot.cfgplot);
    prtsc.cfgsc.Assign(sc.cfgsc);
    prtsc.ObjectListLabels := sc.ObjectListLabels;
    printing := True;
    prtsc.cfgsc.UseSystemTime := False; // same time as current chart
    prtsc.cfgsc.Editlabels := False;    // force text label
    screen.cursor := crHourGlass;
    if cm.PrintHeader then
    begin
      HeaderHeight := DefHeaderHeight;
    end
    else
    begin
      HeaderHeight := 0;
    end;
    if cm.PrintFooter then
    begin
      FooterHeight := DefFooterHeight;
    end
    else
    begin
      FooterHeight := 0;
    end;
    case PrintMethod of
      0:
      begin    // to printer
        GetPrinterResolution(prtname, resol);
        if PrintLandscape then
          Printer.Orientation := poLandscape
        else
          Printer.Orientation := poPortrait;
        if preview then
        begin
          printok := False;
          PrintPreview := Tf_image.Create(self);
          previewbmp := Tbitmap.Create;
          try
            InitPrintColor;
            PrintPreview.ButtonPrint.Visible := True;
            PrintPreview.Image1.BGcolor := clBtnFace;
            w := Printer.PageWidth;
            h := Printer.PageHeight;
            rp := application.MainForm.PixelsPerInch;
            if (rp <= 0) or (rp > 300) then
              rp := 96;
            rs := rp / resol;
            w := round(w * rs);
            h := round(h * rs);
        {$ifndef mswindows}
            prtsc.cfgsc.PlotImageFirst := True;
        {$endif}
            prtsc.plot.destcnv := previewbmp.Canvas;
            prtsc.plot.cfgplot.UseBMP := False;
            prtsc.plot.cfgchart.onprinter := True;
            prtsc.plot.cfgplot.MinDsoSize := 5;
            prtsc.plot.cfgchart.drawpen := maxintvalue([1, rp div 150]);
            prtsc.plot.cfgchart.drawsize := maxintvalue([1, rp div 100]);
            prtsc.plot.cfgchart.fontscale := 1;
            prtsc.cfgsc.LeftMargin := mm2pi(cm.PrtLeftMargin, rp);
            prtsc.cfgsc.RightMargin := mm2pi(cm.PrtRightMargin, rp);
            prtsc.cfgsc.TopMargin := mm2pi(cm.PrtTopMargin + HeaderHeight, rp);
            prtsc.cfgsc.BottomMargin := mm2pi(cm.PrtBottomMargin + FooterHeight, rp);
            prtsc.cfgsc.HeaderHeight := mm2pi(HeaderHeight, rp);
            prtsc.cfgsc.FooterHeight := mm2pi(FooterHeight, rp);
            prtsc.cfgsc.xshift := prtsc.cfgsc.LeftMargin;
            prtsc.cfgsc.yshift := prtsc.cfgsc.TopMargin;
            previewbmp.Width := w;
            previewbmp.Height := h;
            prtsc.plot.init(w, h);
            prtsc.Refresh(False);
            if HeaderHeight > 0 then
            begin
              x := w div 2;
              y := prtsc.cfgsc.TopMargin - (prtsc.cfgsc.HeaderHeight div 2);
              prtsc.plot.PlotText(x, y, 6, prtsc.plot.cfgplot.LabelColor[8],
                laCenter, laCenter, cm.PrintDesc, prtsc.cfgsc.WhiteBg);
            end;
            previewbmp.SaveToFile(SysToUTF8(slash(TempDir)) + 'preview.bmp');
            PrintPreview.LoadImage(SysToUTF8(slash(TempDir)) + 'preview.bmp');
            h := h + PrintPreview.Panel1.Height + PrintPreview.HScrollBar.Height;
            w := w + PrintPreview.VScrollBar.Width;
            PrintPreview.ClientHeight := min(h, Image1.Height);
            PrintPreview.ClientWidth := min(w, Image1.Width);
            PrintPreview.image1.ZoomMin := 0.5;
            PrintPreview.labeltext := rsPrintPreview;
            PrintPreview.Init;
            pt := Image1.ClientToScreen(point(0, 0));
            FormPos(PrintPreview, pt.x, pt.y);
            screen.cursor := crDefault;
            PrintPreview.ShowModal;
            printok := (PrintPreview.ModalResult = mrYes);
          finally
            Image1.SetFocus;
            PrintPreview.Free;
            previewbmp.Free;
          end;
          if not printok then
            exit;
        end;
        // print
        screen.cursor := crHourGlass;
        InitPrintColor;
        Printer.Title := 'CdC';
        Printer.Copies := cm.PrintCopies;
        Printer.BeginDoc;
    {$ifndef mswindows}
        prtsc.cfgsc.PlotImageFirst := True;
    {$endif}
        prtsc.plot.destcnv := Printer.canvas;
        prtsc.plot.cfgplot.UseBMP := False;
        prtsc.plot.cfgchart.onprinter := True;
        prtsc.plot.cfgchart.drawpen := maxintvalue([1, resol div 150]);
        prtsc.plot.cfgchart.drawsize := maxintvalue([1, resol div 100]);
        prtsc.plot.cfgchart.fontscale := 1;
        prtsc.cfgsc.LeftMargin := mm2pi(cm.PrtLeftMargin, resol);
        prtsc.cfgsc.RightMargin := mm2pi(cm.PrtRightMargin, resol);
        prtsc.cfgsc.TopMargin := mm2pi(cm.PrtTopMargin + HeaderHeight, resol);
        prtsc.cfgsc.BottomMargin := mm2pi(cm.PrtBottomMargin + FooterHeight, resol);
        prtsc.cfgsc.HeaderHeight := mm2pi(HeaderHeight, resol);
        prtsc.cfgsc.FooterHeight := mm2pi(FooterHeight, resol);
        prtsc.cfgsc.xshift := printer.PaperSize.PaperRect.WorkRect.Left + prtsc.cfgsc.LeftMargin;
        prtsc.cfgsc.yshift := printer.PaperSize.PaperRect.WorkRect.Top + prtsc.cfgsc.TopMargin;
        w := Printer.PageWidth;
        h := Printer.PageHeight;
        prtsc.plot.init(w, h);
        prtsc.Refresh(False);
        if HeaderHeight > 0 then
        begin
          x := w div 2;
          y := prtsc.cfgsc.TopMargin - (prtsc.cfgsc.HeaderHeight div 2);
          prtsc.plot.PlotText(x, y, 6, prtsc.plot.cfgplot.LabelColor[8],
            laCenter, laCenter, cm.PrintDesc, prtsc.cfgsc.WhiteBg);
        end;
        Printer.EndDoc;
      end;
      1:
      begin  // to postscript canvas
        InitPrintColor;
        if assigned(Fshowinfo) then
          Fshowinfo(rsCreatePostsc, Caption);
        Application.ProcessMessages;
        if DirectoryIsWritable(printpath) then
        begin
          ps := TPostscriptCanvas.Create;
          ps.XDPI := printresol;
          ps.YDPI := printresol;
          if PrintLandscape then
          begin
            ps.paperwidth := round(PaperHeight[cm.Paper] * printresol);
            ps.paperheight := round(PaperWidth[cm.Paper] * printresol);
          end
          else
          begin
            ps.paperwidth := round(PaperWidth[cm.Paper] * printresol);
            ps.paperheight := round(PaperHeight[cm.Paper] * printresol);
          end;
          // draw the chart
          ps.begindoc;
          prtsc.cfgsc.PlotImageFirst := True;
          prtsc.plot.destcnv := ps;
          prtsc.plot.cfgplot.UseBMP := False;
          prtsc.plot.cfgchart.onprinter := True;
          prtsc.plot.cfgplot.MinDsoSize := 5;
          prtsc.plot.cfgchart.drawpen := maxintvalue([1, printresol div 150]);
          prtsc.plot.cfgchart.drawsize := maxintvalue([1, printresol div 100]);
          prtsc.plot.cfgchart.fontscale := 1;
          prtsc.cfgsc.LeftMargin := mm2pi(cm.PrtLeftMargin, printresol);
          prtsc.cfgsc.RightMargin := mm2pi(cm.PrtRightMargin, printresol);
          prtsc.cfgsc.TopMargin := mm2pi(cm.PrtTopMargin + HeaderHeight, printresol);
          prtsc.cfgsc.BottomMargin := mm2pi(cm.PrtBottomMargin + FooterHeight, printresol);
          prtsc.cfgsc.HeaderHeight := mm2pi(HeaderHeight, printresol);
          prtsc.cfgsc.FooterHeight := mm2pi(FooterHeight, printresol);
          prtsc.cfgsc.xshift := prtsc.cfgsc.LeftMargin;
          prtsc.cfgsc.yshift := prtsc.cfgsc.TopMargin;
          prtsc.plot.init(ps.pagewidth, ps.pageheight);
          prtsc.Refresh(False);
          if HeaderHeight > 0 then
          begin
            x := ps.pagewidth div 2;
            y := prtsc.cfgsc.TopMargin - (prtsc.cfgsc.HeaderHeight div 2);
            prtsc.plot.PlotText(x, y, 6, prtsc.plot.cfgplot.LabelColor[8],
              laCenter, laCenter, cm.PrintDesc, prtsc.cfgsc.WhiteBg);
          end;
          ps.enddoc;
          fname := slash(printpath) + 'cdcprint.ps';
          ps.savetofile(SysToUTF8(fname));
          FixPostscript(fname, PrintLandscape, round(PaperWidth[cm.Paper] * 72),
            round(PaperHeight[cm.Paper] * 72));
          ps.Free;
          chdir(appdir);
          if assigned(Fshowinfo) then
            Fshowinfo(rsSendChartToP, Caption);
          execnowait(printcmd1 + ' "' + fname + '"','',false);
        end
        else if assigned(Fshowinfo) then
          Fshowinfo(rsInvalidPath + printpath, Caption);
      end;
      2:
      begin  // to bitmap
        InitPrintColor;
        if assigned(Fshowinfo) then
          Fshowinfo(Format(rsCreateRasterWH, [cm.PrintBmpWidth, cm.PrintBmpHeight]), Caption);
        Application.ProcessMessages;
        if DirectoryIsWritable(printpath) then
        begin
          if PrintLandscape then
          begin
            w := cm.PrintBmpWidth;
            h := cm.PrintBmpHeight;
          end
          else
          begin
            w := cm.PrintBmpHeight;
            h := cm.PrintBmpWidth;
          end;
          printresol := w div 11;
          // draw the chart to the bitmap
          prtsc.plot.cfgplot.UseBMP := True;
          prtsc.plot.cfgchart.onprinter := (PrintColor < 2);
          prtsc.plot.cfgchart.drawpen := maxintvalue([1, printresol div 150]);
          prtsc.plot.cfgchart.drawsize := maxintvalue([1, printresol div 100]);
          prtsc.plot.cfgchart.fontscale := prtsc.plot.cfgchart.drawsize;
          // because we cannot set a dpi property for the bitmap
          if (HeaderHeight > 0) or (FooterHeight > 0) then
          begin
            prtsc.plot.cbmp.FontHeight :=
              trunc(prtsc.plot.cfgplot.FontSize[6] * prtsc.plot.cfgchart.fontscale * 96 / 72);
            if prtsc.plot.cfgplot.FontBold[6] then
              prtsc.plot.cbmp.FontStyle := [fsBold]
            else
              prtsc.plot.cbmp.FontStyle := [];
            if prtsc.plot.cfgplot.FontItalic[6] then
              prtsc.plot.cbmp.FontStyle := prtsc.plot.cbmp.FontStyle + [fsItalic];
            prtsc.plot.cbmp.FontName := prtsc.plot.cfgplot.FontName[6];
            ts := prtsc.plot.cbmp.TextSize(cm.PrintDesc);
            if HeaderHeight > 0 then
              HeaderHeight := 2 * ts.cy;
            if FooterHeight > 0 then
              FooterHeight := 4 * ts.cy;
          end;
          prtsc.cfgsc.LeftMargin := 0;
          prtsc.cfgsc.RightMargin := 0;
          prtsc.cfgsc.TopMargin := HeaderHeight;
          prtsc.cfgsc.BottomMargin := FooterHeight;
          prtsc.cfgsc.HeaderHeight := HeaderHeight;
          prtsc.cfgsc.FooterHeight := FooterHeight;
          prtsc.cfgsc.xshift := prtsc.cfgsc.LeftMargin;
          prtsc.cfgsc.yshift := prtsc.cfgsc.TopMargin;
          prtsc.plot.init(w, h);
          prtsc.Refresh(False);
          if HeaderHeight > 0 then
          begin
            x := w div 2;
            y := prtsc.cfgsc.TopMargin - (prtsc.cfgsc.HeaderHeight div 2);
            prtsc.plot.PlotText(x, y, 6, prtsc.plot.cfgplot.LabelColor[8],
              laCenter, laCenter, cm.PrintDesc, prtsc.cfgsc.WhiteBg);
          end;
          // save the bitmap
          png := TPortableNetworkGraphic.Create;
          try
            png.Assign(prtsc.plot.cbmp);
            fname := slash(printpath) + 'cdcprint.png';
            png.savetofile(SysToUTF8(fname));
          finally
            png.Free;
          end;
          if printcmd2 <> '' then
          begin
            if assigned(Fshowinfo) then
              Fshowinfo(rsOpenTheBitma, Caption);
            execnowait(printcmd2 + ' "' + fname + '"', '', False);
          end
          else
          if assigned(Fshowinfo) then
            Fshowinfo('');
        end
        else if assigned(Fshowinfo) then
          Fshowinfo(rsInvalidPath + printpath, Caption);
      end;
    end;
  finally
    printing := False;
    chdir(appdir);
    screen.cursor := crDefault;
    Image1.SetFocus;
  end;
end;

procedure Tf_chart.ChartActivate;
begin
  // code to execute when the chart get focus.
  if VerboseMsg then
    WriteTrace(Caption + ' ChartActivate');
  if assigned(FUpdateBtn) then
    FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
  if assigned(fshowtopmessage) then
    fshowtopmessage(sc.GetChartInfo, self);
  if sc.cfgsc.FindOk and assigned(Fshowinfo) then
    Fshowinfo(sc.cfgsc.FindDesc, Caption, False, nil, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
end;

procedure Tf_chart.chart_FlipXExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' FlipxExecute');
  sc.cfgsc.FlipX := -sc.cfgsc.FlipX;
  if (sc.cfgsc.FlipX < 0) and (sc.cfgsc.Flipy < 0) then
  begin // chart_FlipX+y=rotation
    sc.cfgsc.FlipX := 1;
    sc.cfgsc.FlipY := 1;
    rotation(180);
  end;
  if assigned(FUpdateBtn) then
    FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
  Refresh(True, False);
end;

procedure Tf_chart.chart_FlipYExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' FlipyExecute');
  sc.cfgsc.FlipY := -sc.cfgsc.FlipY;
  if (sc.cfgsc.FlipX < 0) and (sc.cfgsc.Flipy < 0) then
  begin // chart_FlipX+y=rotation
    sc.cfgsc.FlipX := 1;
    sc.cfgsc.FlipY := 1;
    rotation(180);
  end;
  if assigned(FUpdateBtn) then
    FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
  Refresh(True, False);
end;

procedure Tf_chart.MoveCamera(angle: single);
var i: integer;
  rot: single;
begin
  rot := 0;
  if movecam then
  begin
    for i := 1 to sc.cfgsc.nrectangle do
      if sc.cfgsc.rectangleok[i] and (sc.cfgsc.rectangle[i, 4] = 0) then
        begin
          rot := rmod(sc.cfgsc.rectangle[i, 3] + angle + 360, 360);
          sc.cfgsc.rectangle[i, 3] := rot;
        end;
  end;
  if moveguide then
  begin
    for i := 1 to sc.cfgsc.ncircle do
      if sc.cfgsc.circleok[i] and (sc.cfgsc.circle[i, 3] > 0) then
      begin
        rot := rmod(sc.cfgsc.circle[i, 2] + angle + 360, 360);
        sc.cfgsc.circle[i, 2] := rot;
      end;
    for i := 1 to sc.cfgsc.nrectangle do
      if sc.cfgsc.rectangleok[i] and (sc.cfgsc.rectangle[i, 4] > 0) then
      begin
        rot := rmod(sc.cfgsc.rectangle[i, 3] + angle + 360, 360);
        sc.cfgsc.rectangle[i, 3] := rot;
      end;
  end;
  frommovecam := True;
  Refresh(True, False);
  if assigned(Fshowinfo) then
    Fshowinfo(rsRotation + ': ' + formatfloat(f1, rot));
end;

procedure Tf_chart.SetCameraRotation(cam: integer);
var
  camerafound: boolean;
  guiderfound: boolean;
  i: integer;
begin
  if movecam or moveguide then
  begin
    movecam := False;
    moveguide := False;
    for i := 1 to sc.cfgsc.ncircle do
      sc.cfgsc.circle[i, 4] := 0;
    for i := 1 to sc.cfgsc.nrectangle do
      sc.cfgsc.rectangle[i, 5] := 0;
  end
  else
  begin
    case cam of
      0:
      begin
        movecam := True;
        moveguide := True;
      end;
      1: movecam := True;
      2: moveguide := True;
    end;
    if movecam then
    begin // is a main camera to move (rectangle with null offset)
      camerafound := false;
      for i := 1 to sc.cfgsc.nrectangle do
        if sc.cfgsc.rectangleok[i] and (sc.cfgsc.rectangle[i, 4] = 0) then
        begin
          camerafound := true;
          sc.cfgsc.rectangle[i, 5] := 1;
        end;
      if not camerafound then
        movecam := False
    end;
    if moveguide then
    begin // is a guider to move (circle or rectangle with offset > 0)
      guiderfound := False;
      for i := 1 to sc.cfgsc.ncircle do
        if sc.cfgsc.circleok[i] and (sc.cfgsc.circle[i, 3] > 0) then
        begin
          guiderfound := True;
          sc.cfgsc.circle[i, 4] := 1;
        end;
      for i := 1 to sc.cfgsc.nrectangle do
        if sc.cfgsc.rectangleok[i] and (sc.cfgsc.rectangle[i, 4] > 0) then
        begin
          guiderfound := True;
          sc.cfgsc.rectangle[i, 5] := 1;
        end;
      if not guiderfound then
        moveguide := False;
    end;
  end;
  frommovecam := True;
  Refresh(True, False);
end;

procedure Tf_chart.rotation(rot: double);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' rotation');
  sc.cfgsc.theta := rmod(sc.cfgsc.theta + deg2rad * rot + pi2, pi2);
  Refresh(True, False);
end;

procedure Tf_chart.chart_rot_plusExecute(Sender: TObject);
begin
  rotation(15);
end;

procedure Tf_chart.chart_rot_minusExecute(Sender: TObject);
begin
  rotation(-15);
end;

procedure Tf_chart.SwitchCompass(Sender: TObject);
begin
  sc.catalog.cfgshr.ShowCRose := not sc.catalog.cfgshr.ShowCRose;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  Refresh(True, False);
end;

procedure Tf_chart.chart_GridEQExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' GridEQExecute');
  sc.cfgsc.ShowEqGrid := not sc.cfgsc.ShowEqGrid;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  Refresh(True, False);
end;

procedure Tf_chart.chart_GridExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' GridExecute');
  sc.cfgsc.ShowGrid := not sc.cfgsc.ShowGrid;
{ if sc.cfgsc.projpole=Equat then
    sc.cfgsc.ShowEqGrid:=sc.cfgsc.ShowGrid;   }
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  Refresh(True, False);
end;

procedure Tf_chart.chart_zoomplusExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' zoomplusExecute');
  sc.zoom(zoomfactor);
  Refresh(True, False);
end;

procedure Tf_chart.chart_zoomminusExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' zoomminusExecute');
  sc.zoom(1 / zoomfactor);
  Refresh(True, False);
end;

procedure Tf_chart.chart_zoomplusmoveExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' zoomplusmoveExecute');
  if sc.cfgsc.FindName > '' then
    sc.MovetoRaDec(sc.cfgsc.FindRA, sc.cfgsc.FindDec)
  else
    sc.MovetoXY(xcursor, ycursor);
  sc.zoom(zoomfactor);
  sc.cfgsc.TrackOn := False;
  Refresh(True, False);
end;

procedure Tf_chart.chart_zoomminusmoveExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' zoomminusmoveExecute');
  if sc.cfgsc.FindName > '' then
    sc.MovetoRaDec(sc.cfgsc.FindRA, sc.cfgsc.FindDec)
  else
    sc.MovetoXY(xcursor, ycursor);
  sc.zoom(1 / zoomfactor);
  sc.cfgsc.TrackOn := False;
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveWestExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' MoveWestExecute');
  sc.MoveChart(0, -1, movefactor);
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveEastExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' MoveEastExecute');
  sc.MoveChart(0, 1, movefactor);
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveNorthExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' MoveNorthExecute');
  sc.MoveChart(1, 0, movefactor);
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveSouthExecute(Sender: TObject);
begin
  sc.MoveChart(-1, 0, movefactor);
  if VerboseMsg then
    WriteTrace(Caption + ' MoveSouthExecute');
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveNorthWestExecute(Sender: TObject);
begin
  sc.MoveChart(1, -1, movefactor);
  if VerboseMsg then
    WriteTrace(Caption + ' MoveNorthWestExecute');
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveNorthEastExecute(Sender: TObject);
begin
  sc.MoveChart(1, 1, movefactor);
  if VerboseMsg then
    WriteTrace(Caption + ' MoveNorthEastExecute');
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveSouthWestExecute(Sender: TObject);
begin
  sc.MoveChart(-1, -1, movefactor);
  if VerboseMsg then
    WriteTrace(Caption + ' MoveSouthWestExecute');
  Refresh(True, False);
end;

procedure Tf_chart.chart_MoveSouthEastExecute(Sender: TObject);
begin
  sc.MoveChart(-1, 1, movefactor);
  if VerboseMsg then
    WriteTrace(Caption + ' MoveSouthEastExecute');
  Refresh(True, False);
end;

procedure Tf_chart.CKeyDown(Key: word; Shift: TShiftState);
var
  keyrepeat: boolean;

  procedure disablescroll;
  begin
    lockscrollbar := True;
    VertScrollBar.Enabled := False;
    HorScrollBar.Enabled := False;
  end;

begin
  if LockKeyboard then
    exit;
  try
    LockKeyboard := True;
    // zoom and move acceleration
    movefactor := 6;
    zoomfactor := 2;
    if Shift = [ssShift] then
    begin
      movefactor := 12;
      zoomfactor := 1.5;
    end;
    if Shift = [ssCtrl] then
    begin
      movefactor := 4;
      zoomfactor := 3;
    end;
    keyrepeat := (abs(now - KeyPressTime) * secday < 0.1);
    // numeric pad
    if (key >= VK_NUMPAD0) and (key <= VK_NUMPAD9) then
      key := key - (VK_NUMPAD0 - VK_0);
    // special keys handling
    case key of
      VK_PRIOR:
      begin
        disablescroll;
        sc.cfgsc.Quick := keyrepeat;
        chart_MoveNorthWest.Execute;
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := keyrepeat;
      end;
      VK_NEXT:
      begin
        disablescroll;
        sc.cfgsc.Quick := keyrepeat;
        chart_MoveSouthWest.Execute;
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := keyrepeat;
      end;
      VK_END:
      begin
        disablescroll;
        sc.cfgsc.Quick := keyrepeat;
        chart_MoveSouthEast.Execute;
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := keyrepeat;
      end;
      VK_HOME:
      begin
        disablescroll;
        sc.cfgsc.Quick := keyrepeat;
        chart_MoveNorthEast.Execute;
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := keyrepeat;
      end;
      VK_LEFT: if (movecam or moveguide) then
          MoveCamera(5)
        else
        begin
          disablescroll;
          sc.cfgsc.Quick := keyrepeat;
          chart_MoveEast.Execute;
          RefreshTimer.Enabled := False;
          RefreshTimer.Enabled := keyrepeat;
        end;
      VK_UP:
      begin
        disablescroll;
        sc.cfgsc.Quick := keyrepeat;
        chart_MoveNorth.Execute;
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := keyrepeat;
      end;
      VK_RIGHT: if (movecam or moveguide) then
          MoveCamera(-5)
        else
        begin
          disablescroll;
          sc.cfgsc.Quick := keyrepeat;
          chart_MoveWest.Execute;
          RefreshTimer.Enabled := False;
          RefreshTimer.Enabled := keyrepeat;
        end;
      VK_DOWN:
      begin
        disablescroll;
        sc.cfgsc.Quick := keyrepeat;
        chart_MoveSouth.Execute;
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := keyrepeat;
      end;
      VK_DELETE: Cleanupmap1Click(nil);
      VK_ADD, VK_OEM_PLUS: chart_zoomplus.Execute;
      VK_SUBTRACT, VK_OEM_MINUS: chart_zoomminus.Execute;
      else
      begin
        if (Shift = [ssCtrl]) and (key <> VK_CONTROL) then
        begin
          // Ctrl + key handling
          case key of
            VK_Q: if sc.plot.cfgplot.partsize <= 4.8 then
              begin  // ctrl+q
                sc.plot.cfgplot.partsize := sc.plot.cfgplot.partsize + 0.2;
                Refresh(True, False);
              end;
            VK_A: if sc.plot.cfgplot.partsize >= 0.3 then
              begin  // ctrl+a
                sc.plot.cfgplot.partsize := sc.plot.cfgplot.partsize - 0.2;
                Refresh(True, False);
              end;
            VK_W: if sc.plot.cfgplot.magsize <= 9.5 then
              begin   // ctrl+w
                sc.plot.cfgplot.magsize := sc.plot.cfgplot.magsize + 0.5;
                Refresh(True, False);
              end;
            VK_S: if sc.plot.cfgplot.magsize >= 1.5 then
              begin   // ctrl+s
                sc.plot.cfgplot.magsize := sc.plot.cfgplot.magsize - 0.5;
                Refresh(True, False);
              end;
            VK_E: if sc.plot.cfgplot.contrast <= 980 then
              begin   // ctrl+e
                sc.plot.cfgplot.contrast := sc.plot.cfgplot.contrast + 20;
                Refresh(True, False);
              end;
            VK_D: if sc.plot.cfgplot.contrast >= 120 then
              begin   // ctrl+d
                sc.plot.cfgplot.contrast := sc.plot.cfgplot.contrast - 20;
                Refresh(True, False);
              end;
            VK_R: if sc.plot.cfgplot.saturation <= 250 then
              begin  // ctrl+r
                sc.plot.cfgplot.saturation := sc.plot.cfgplot.saturation + 20;
                Refresh(True, False);
              end;
            VK_F: if sc.plot.cfgplot.saturation >= 5 then
              begin  // ctrl+f
                sc.plot.cfgplot.saturation := sc.plot.cfgplot.saturation - 20;
                Refresh(True, False);
              end;
            VK_L:
            begin                                        // ctrl+l
              sc.cfgsc.ShowLabel[8] := not sc.cfgsc.ShowLabel[8];
              Refresh(True, False);
            end;
            VK_Y:
            begin   // ctrl+y
              xcursor := Image1.ScreenToClient(mouse.cursorpos).x;
              ycursor := Image1.ScreenToClient(mouse.cursorpos).y;
              NewFinderCircle1Click(nil);
            end;
          end;
        end
        else if (Shift = [ssCtrl, ssShift]) and (key <> VK_CONTROL) then
        begin
          // Ctrl + Shift + key handling
          case key of
            VK_L:
            begin                                        // ctrl+shift+l
              sc.cfgsc.ShowLegend := not sc.cfgsc.ShowLegend;
              Refresh(True, False);
            end;
          end;
        end
        else
        begin
          // Numeric keys handling
          if shift = [] then
          begin
            case key of
              VK_1: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[0]);
              VK_2: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[1]);
              VK_3: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[2]);
              VK_4: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[3]);
              VK_5: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[4]);
              VK_6: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[5]);
              VK_7: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[6]);
              VK_8: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[7]);
              VK_9: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[8]);
              VK_0: SetField(deg2rad * sc.catalog.cfgshr.FieldNum[9]);
            end;
          end;
          // Alpha keys handling
          if ssShift in Shift then
          begin
            case key of
              VK_C: SetCameraRotation(1);
              VK_G: SetCameraRotation(2);
              VK_S: SetCameraRotation(0);
            end;
          end
          else
          begin
            case key of
              VK_A: SetZenit(deg2rad * 200);
              VK_E: SetAz(deg2rad * 270);
              VK_N: SetAz(deg2rad * 180);
              VK_S: SetAz(0);
              VK_W: SetAz(deg2rad * 90);
              VK_Z: SetZenit(0);
            end;
          end;
        end;
      end;
    end;
    movefactor := 4;
    zoomfactor := 2;
    application.ProcessMessages;
    // very important to empty the mouse event queue before to unlock
    KeyPressTime := now;
  finally
    LockKeyboard := False;
  end;
end;

procedure Tf_chart.SetSAMPmenu(menu:Tmenuitem; num: integer);
var action: TNotifyEvent;
    MenuItem: TMenuItem;
    i: integer;
begin
  case num of
    1: action:=SAMPsendCursorCoordClick;
    2: action:=SAMPsendObjectCoordClick;
    3: action:=SAMPsendCenterCoordClick;
  end;
  while menu.Count > 0 do
    menu.Delete(0);
  MenuItem := TMenuItem.Create(self);
  MenuItem.Caption := rsAllSAMPClien;
  MenuItem.Tag := 0;
  MenuItem.OnClick := action;
  menu.Add(MenuItem);
  for i := 0 to SampClientName.Count - 1 do
  begin
    if SampClientCoordpointAtsky[i] = '1' then
    begin
      MenuItem := TMenuItem.Create(self);
      MenuItem.Caption := SampClientName[i];
      MenuItem.Tag := i;
      MenuItem.OnClick := action;
      menu.Add(MenuItem);
    end;
  end;
end;

procedure Tf_chart.PopupMenuChartPopup(Sender: TObject);
var
  i, xc, yc: integer;
  m: TMenuItem;
begin
  if assigned(FImageSetFocus) then
    FImageSetFocus(self);
  xc := Image1.ScreenToClient(mouse.cursorpos).x;
  yc := Image1.ScreenToClient(mouse.cursorpos).y;
  if (not(sc.cfgsc.TrackOn and (sc.cfgsc.FindType=ftLock))) and ((not Identlabel.Visible) or (abs(xcursor - xc) > 6) or (abs(ycursor - yc) > 6)) then
  begin
    xcursor := xc;
    ycursor := yc;
    sc.cfgsc.FindName := '';
    IdentXY(xcursor, ycursor);
  end;
  if sc.cfgsc.TrackOn then
  begin
    TrackOff1.Visible := True;
    TrackOn1.Visible := False;
  end
  else
  begin
    TrackOff1.Visible := False;
    if ((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or (sc.cfgsc.TrackType = TTequat) or (sc.cfgsc.TrackType = TTbody) then
    begin
      TrackOn1.Caption := Format(rsLockOn, [sc.cfgsc.TrackName]);
      TrackOn1.Visible := True;
    end
    else
      TrackOn1.Visible := False;
  end;
  if sc.cfgsc.TargetOn then
  begin
    Target1.Caption := rsClearTarget;
  end
  else if ((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or (sc.cfgsc.TrackType = TTequat) or (sc.cfgsc.TrackType = TTbody) then
  begin
    Target1.Caption := Format(rsSetTargetTo, [sc.cfgsc.TrackName]);
  end
  else
  begin
    Target1.Caption := rsNoTargetObje;
  end;
  if f_obslist.RowCount > 0 then
  begin
    MenuObslistFirst.Visible := True;
    MenuObslistLast.Visible := True;
    MenuObslistNext.Visible := True;
    MenuObslistPrev.Visible := True;
  end
  else
  begin
    MenuObslistFirst.Visible := False;
    MenuObslistLast.Visible := False;
    MenuObslistNext.Visible := False;
    MenuObslistPrev.Visible := False;
  end;
  if sc.cfgsc.FindName > '' then
  begin
    About1.Caption := Format(rsAbout2, [sc.cfgsc.FindName]);
    About1.Visible := True;
    About2.Visible := True;
    SearchName1.Visible := True;
    Slew1.Visible := True;
    Sync1.Visible := True;
    MenuAddToObsList.Caption := Format(rsAddToObservi, [sc.cfgsc.FindName]);
    MenuAddToObsList.Visible := True;
    Slew1.Caption := rsSlew + ': ' + sc.cfgsc.FindName;
    Sync1.Caption := rsSync + ': ' + sc.cfgsc.FindName;
    PrePointCreate.Caption:=rsTarget + ': ' + sc.cfgsc.FindName;
    PrePointMeasure.Caption:=rsMeasurement+ ': '+ sc.cfgsc.FindName;
  end
  else
  begin
    About1.Visible := False;
    About2.Visible := False;
    SearchName1.Visible := False;
    MenuAddToObsList.Visible := False;
    Slew1.Visible := False;
    Sync1.Visible := False;
    PrePointMeasure.Caption:=rsMeasurement;
  end;
  CopyCoord1.Caption := rsEquatorialCo+', '+sc.cfgsc.EquinoxName+', [hms]';
  CopyCoord2000.Visible:=(sc.cfgsc.EquinoxName<>'J2000');
  case sc.cfgsc.ProjPole of
    Equat : CopyCoord2.Caption := rsEquatorialCo+', '+rsDecimalHours;
    Altaz : CopyCoord2.Caption := rsAltAzCoordin+', '+rsDecimalDegre;
    Gal   : CopyCoord2.Caption := rsGalacticCoor+', '+rsDecimalDegre;
    Ecl   : CopyCoord2.Caption := rsEclipticCoor+', '+rsDecimalDegre;
  end;
  SlewCursor.Visible := not (sc.cfgsc.TrackOn and (sc.cfgsc.FindType=ftLock));
  if sc.cfgsc.ManualTelescope then
    Telescope1.Visible := False
  else
    Telescope1.Visible := True;
  MenuSAMP.Visible := SampConnected;
  if SampConnected then
  begin
    SetSAMPmenu(MenuSAMP1,1);
    SetSAMPmenu(MenuSAMP2,2);
    SetSAMPmenu(MenuSAMP3,3);
  end;
  if assigned(FSetScriptMenu) then
    FSetScriptMenu(self);

  SelectCircle.Clear;
  for i:=1 to sc.cfgsc.ncircle do begin
    m:=TMenuItem.Create(SelectCircle);
    m.OnClick:=MenuCircleClick;
    m.showalwayscheckable:=true;
    m.tag:=i;
    m.Checked := sc.cfgsc.circleok[i];
    m.Caption := formatfloat(f2, sc.cfgsc.circle[i, 1]) + lmin + blank + sc.cfgsc.circlelbl[i];
    SelectCircle.Add(m);
  end;

  SelectRectangle.Clear;
  for i:=1 to sc.cfgsc.nrectangle do begin
    m:=TMenuItem.Create(SelectRectangle);
    m.OnClick:=MenuRectangleClick;
    m.showalwayscheckable:=true;
    m.tag:=i;
    m.Checked := sc.cfgsc.rectangleok[i];
    m.Caption := formatfloat(f2, sc.cfgsc.rectangle[i, 1]) + lmin +
      'x' + formatfloat(f2, sc.cfgsc.rectangle[i, 2]) + lmin + blank + sc.cfgsc.rectanglelbl[i];
    SelectRectangle.Add(m);
  end;
end;

procedure Tf_chart.TrackOn1Click(Sender: TObject);

begin
  sc.cfgsc.TrackOn := True;
  if VerboseMsg then
    WriteTrace(Caption + ' TrackOn1Click');
  Refresh(True, False);
end;

procedure Tf_chart.TrackOff1Click(Sender: TObject);

begin
  sc.cfgsc.TrackOn := False;
  if VerboseMsg then
    WriteTrace(Caption + ' TrackOff1Click');
  Refresh(True, False);
end;

procedure Tf_chart.chart_CentreExecute(Sender: TObject);
begin
  if sc.cfgsc.FindName > '' then
    sc.MovetoRaDec(sc.cfgsc.FindRA, sc.cfgsc.FindDec)
  else
    sc.MovetoXY(xcursor, ycursor);
  sc.cfgsc.TrackOn := False;
  if VerboseMsg then
    WriteTrace(Caption + ' CentreExecute');
  Refresh(True, False);
end;

procedure Tf_chart.CopyCoord1Click(Sender: TObject);
var
  txt: string;
  ra, Dec, a, h, l, b, le, be: double;
begin
  if sc.cfgsc.FindName > '' then
  begin
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
  end
  else
  begin
    sc.GetCoord(xcursor, ycursor, ra, Dec, a, h, l, b, le, be);
  end;
  txt := ARtoStr(ra * rad2deg / 15) + blank + DEToStr(Dec * rad2deg);
  Clipboard.AsText := txt;
end;

procedure Tf_chart.CopyCoord2000Click(Sender: TObject);
// same as CopyCoord1 but J2000
var
  txt: string;
  ra, Dec, a, h, l, b, le, be: double;
begin
  if sc.cfgsc.FindName > '' then
  begin
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
  end
  else
  begin
    sc.GetCoord(xcursor, ycursor, ra, Dec, a, h, l, b, le, be);
  end;
  if sc.cfgsc.ApparentPos then
    mean_equatorial(ra,dec, sc.cfgsc, true, true);
  Precession(sc.cfgsc.JDChart,jd2000,ra,Dec);
  txt := ARtoStr(ra * rad2deg / 15) + blank + DEToStr(Dec * rad2deg);
  Clipboard.AsText := txt;
end;

procedure Tf_chart.CopyCoord2Click(Sender: TObject);
// same as CopyCoord1 but copy using current chart coordinate system in decimal format
var
  txt: string;
  x,y,ra, Dec, a, h, l, b, le, be: double;
begin
  if sc.cfgsc.FindName > '' then
  begin
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
    Eq2Hz(sc.cfgsc.CurST - ra, Dec, a, h, sc.cfgsc);
    if sc.catalog.cfgshr.AzNorth then
      a := rmod(a + pi, pi2);
    Eq2Gal(ra, Dec, l, b, sc.cfgsc);
    Eq2Ecl(ra, Dec, sc.cfgsc.ecl, le, be);
    ra := rmod(ra + pi2, pi2);
    a := rmod(a + pi2, pi2);
    l := rmod(l + pi2, pi2);
    le := rmod(le + pi2, pi2);
  end
  else
  begin
    sc.GetCoord(xcursor, ycursor, ra, Dec, a, h, l, b, le, be);
  end;
  case sc.cfgsc.ProjPole of
    Equat :begin
             x := ra * rad2deg / 15;
             y := dec * rad2deg;
           end;
    Altaz :begin
             x := a * rad2deg;
             y := h * rad2deg;
           end;
    Gal   :begin
             x := l * rad2deg;
             y := b * rad2deg;
           end;
    Ecl   :begin
             x := le * rad2deg;
             y := be * rad2deg;
           end;
  end;
  txt := FormatFloat(f6,x) + ';' + FormatFloat(f6,y);
  Clipboard.AsText := txt;
end;

procedure Tf_chart.Image1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: integer; MousePos: TPoint; var Handled: boolean);
var
  zf,a,d,x1,y1: double;
  x, y: integer;
begin
  RefreshTimer.Enabled := False;
  try
    if VerboseMsg then
      WriteTrace(Caption + ' Image1MouseWheel');
    handled := True;
    if wheeldelta > 0 then  begin
      if ssCtrl in Shift then
        zf := 1.25
      else
        zf := 1.5;
    end
    else  begin
       if ssCtrl in Shift then
        zf := 0.8
      else
        zf := 0.66667;
    end;
    sc.Zoom(zf);
    if not (ssShift in Shift) then
    begin
      x := MousePos.X;
      y := MousePos.Y;
      XYwindow(x, y, x1, y1, sc.cfgsc);
      x1 := x1 - x1/zf;
      y1 := y1 - y1/zf;
      InvProj(x1, y1, a, d, sc.cfgsc);
      a := rmod(pi4 + a, pi2);
      sc.cfgsc.racentre:=a;
      sc.cfgsc.decentre:=d;
    end;
    sc.cfgsc.Quick := True;
    Refresh(True, False);
    sc.cfgsc.Quick := False;
    RefreshTimer.Enabled := True;
  except
    on E: Exception do WriteTrace('Mousewheel error: ' + E.Message);
  end;
end;

procedure Tf_chart.ShowIdentLabel(newjd: boolean = True);
var
  x, y: integer;
  ts: TSize;
  lis: string;
  lid, i: integer;
  posok: boolean;
begin
  if locked then
    exit;
  if sc.cfgsc.FindOK and (not cmain.SimpleDetail) then
  begin
    identlabel.Visible := False;
    Identlabel.Picture.Bitmap.Canvas.Brush.Color := sc.plot.cfgplot.color[0];
    Identlabel.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    Identlabel.Picture.Bitmap.Canvas.Pen.Color := sc.plot.cfgplot.color[12];
    Identlabel.Picture.Bitmap.Canvas.Pen.Mode := pmCopy;
    Identlabel.Picture.Bitmap.Canvas.font.color := sc.plot.cfgplot.color[11];
    identlabel.Picture.Bitmap.Canvas.font.Name := sc.plot.cfgplot.fontname[2];
    case sc.cfgsc.FindType of
      ftAll: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[1];
      ftStar: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[1];
      ftVar: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[2];
      ftDbl: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[3];
      ftNeb: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[4];
      ftlin: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[4];
      ftInv: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[4];
      ftOnline: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[4];
      ftLock: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[4];
      ftCat: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[4];
      ftPla: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[5];
      ftCom: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[5];
      ftAst: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[5];
      ftBody: identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[5];
      else
        identlabel.Picture.Bitmap.Canvas.font.size := sc.plot.cfgplot.LabelSize[1];
    end;
    identlabel.Caption := trim(sc.cfgsc.FindName);
    ts := identlabel.Picture.Bitmap.Canvas.TextExtent(identlabel.Caption);
    identlabel.Width := ts.cx + 8;
    identlabel.Height := ts.cy + 4;
    Identlabel.Picture.Bitmap.Width := identlabel.Width;
    Identlabel.Picture.Bitmap.Height := identlabel.Height;
    lis := sc.cfgsc.FindId + FormatFloat(f6, sc.cfgsc.FindRA2000) + FormatFloat(
      f6, sc.cfgsc.FindDec2000);
    lid := rshash(lis, $7FFFFFFF);
    posok := False;
    for i := 1 to sc.numlabels do
    begin
      if sc.labels[i].id = lid then
      begin
        if (sc.labels[i].px >= 0) and (sc.labels[i].py >= 0) then
        begin
          x := sc.labels[i].px;
          y := sc.labels[i].py;
          posok := True;
        end;
      end;
    end;
    if not posok then
      sc.GetLabPos(sc.cfgsc.FindRA, sc.cfgsc.FindDec, sc.cfgsc.FindSize / 2,
        identlabel.Width, identlabel.Height, x, y);
    identlabel.left := x;
    identlabel.top := y;
    Identlabel.Picture.Bitmap.Canvas.Rectangle(0, 0, identlabel.Width, identlabel.Height);
    Identlabel.Picture.Bitmap.Canvas.TextOut(2, 2, Identlabel.Caption);
    identlabel.Visible := True;
    identlabel.Cursor := crHandPoint;
    identlabel.bringtofront;
    sc.DrawSearchMark(sc.cfgsc.FindRA, sc.cfgsc.FindDec, False);
    if newjd then
      sc.cfgsc.FindJD := sc.cfgsc.JDChart;
    if sc.cfgsc.trackon and (sc.cfgsc.FindName = sc.cfgsc.TrackName) and
      f_detail.Visible then
      identlabelClick(Identlabel);
  end
  else
    identlabel.Visible := False;
end;

function Tf_chart.IdentXY(X, Y: integer; searchcenter: boolean = True;
  showlabel: boolean = True; ftype: integer = ftAll; radius: integer = 2; planetcenter: boolean = False): boolean;
var
  ra, Dec, a, h, a1, h1, l, b, le, be, dx, dy, lastra, lastdec, lasttrra, lasttrde,
  lastepoch, lastx, lasty, lastz, dist, ds, ax, ay: double;
  pa, lasttype, lastobj: integer;
  txt, lastname, lasttrname, buf: string;
  showdist, solsys, lastsolsys: boolean;
begin
  Result := False;
  if locked then
    exit;
  showdist := sc.cfgsc.FindOk;
  lastra := sc.cfgsc.FindRA;
  lastdec := sc.cfgsc.FindDEC;
  lastepoch := sc.cfgsc.TrackEpoch;
  lastname := sc.cfgsc.FindName;
  lasttrra := sc.cfgsc.TrackRA;
  lasttrde := sc.cfgsc.TrackDEC;
  lasttype := sc.cfgsc.TrackType;
  lastobj := sc.cfgsc.Trackobj;
  lasttrname := sc.cfgsc.TrackName;
  lastX := sc.cfgsc.FindX;
  lastY := sc.cfgsc.FindY;
  lastZ := sc.cfgsc.FindZ;
  sc.cfgsc.TrackName := '';
  sc.cfgsc.TrackType := TTaltaz;
  lastsolsys := ((sc.cfgsc.Findtype = ftAst) or (sc.cfgsc.Findtype = ftCom) or
    (sc.cfgsc.Findtype = ftPla)) and ((sc.cfgsc.FindX + sc.cfgsc.FindY + sc.cfgsc.FindZ) <> 0);
  sc.GetCoord(x, y, ra, Dec, a, h, l, b, le, be);
  ax := rmod(rad2deg * (sc.cfgsc.CurST - ra) + 720, 360);
  ay := rad2deg * Dec;
  if cmain.SimpleDetail and (ax >= 85) and (ax <= 110) and (ay >= 20) and (ay <= 50) then
  begin // astrolabe planet info
    Result := False;
    if Assigned(FPlanetInfo) then
      FPlanetInfo(self);
  end
  else
  begin
    ra := rmod(ra + pi2, pi2);
    dx := abs(radius / sc.cfgsc.BxGlb); // search a 2 pixel radius
    Result := sc.FindatRaDec(ra, Dec, dx, searchcenter, False, ftype, planetcenter);
    if (not Result) then
      Result := sc.FindatRaDec(ra, Dec, 3 * dx, searchcenter, False, ftype, planetcenter);  //else 6 pixel
    if Result and showlabel then
      ShowIdentLabel
    else
      Identlabel.Visible := False;
    if Result and showdist then
    begin
      ra := sc.cfgsc.FindRA;
      Dec := sc.cfgsc.FindDEC;
      solsys := ((sc.cfgsc.FindType = ftAst) or (sc.cfgsc.FindType = ftCom) or
        (sc.cfgsc.FindType = ftPla)) and ((sc.cfgsc.FindX + sc.cfgsc.FindY + sc.cfgsc.FindZ) <> 0);
      dist := rad2deg * angulardistance(ra, Dec, lastra, lastdec);
      if dist > 0 then
      begin
        pa := round(rmod(rad2deg * PositionAngle(lastra, lastdec, ra, Dec) + 360, 360));
        txt := DEptoStr(dist) + ' PA:' + IntToStr(pa) + ldeg;
        dx := rmod((rad2deg * (ra - lastra) / 15) + 24, 24);
        if dx > 12 then
          dx := dx - 24;
        dy := rad2deg * (Dec - lastdec);
        txt := txt + crlf + artostr(dx) + blank + detostr(dy);
        if assigned(Fshowcoord) then
          Fshowcoord(txt);
        buf := rsFrom + ':  "' + lastname + '" ' + rsTo + ' "' + sc.cfgsc.FindName +
          '"' + tab + rsSeparation + ': ' + txt;
        txt := stringreplace(buf, crlf, tab + rsOffset + ':', []);
        if assigned(Fshowinfo) then
          Fshowinfo(txt, Caption, True, self);
        if solsys and lastsolsys then
        begin
          ds := sqrt((lastX - sc.cfgsc.FindX) * (lastX - sc.cfgsc.FindX) +
            (lastY - sc.cfgsc.FindY) * (lastY - sc.cfgsc.FindY) + (lastZ - sc.cfgsc.FindZ) *
            (lastZ - sc.cfgsc.FindZ));
          txt := txt + tab + rsDistance + ': ' + FormatFloat(f5, ds) + 'au';
        end;
        if sc.cfgsc.ManualTelescope then
        begin
          case sc.cfgsc.ManualTelescopeType of
            0:
            begin
              txt := Format(rsRATurns2, [txt + tab]);
              txt := txt + blank + formatfloat(f2, abs(dx * sc.cfgsc.TelescopeTurnsX)) + blank;
              if (dx * sc.cfgsc.TelescopeTurnsX) > 0 then
                txt := Format(rsCW, [txt])
              else
                txt := Format(rsCCW, [txt]);
              txt := Format(rsDECTurns2, [txt + tab]);
              txt := txt + blank + formatfloat(f2, abs(dy * sc.cfgsc.TelescopeTurnsY)) + blank;
              if (dy * sc.cfgsc.TelescopeTurnsY) > 0 then
                txt := Format(rsCW, [txt])
              else
                txt := Format(rsCCW, [txt]);
            end;
            1:
            begin
              Eq2Hz(sc.cfgsc.CurSt - ra, Dec, a, h, sc.cfgsc);
              Eq2Hz(sc.cfgsc.CurSt - lastra, lastdec, a1, h1, sc.cfgsc);
              dx := rmod((rad2deg * (a - a1)) + 360, 360);
              if dx > 180 then
                dx := dx - 360;
              dy := rad2deg * (h - h1);
              txt := Format(rsAzTurns, [txt + tab]);
              txt := txt + blank + formatfloat(f2, abs(dx * sc.cfgsc.TelescopeTurnsX)) + blank;
              if (dx * sc.cfgsc.TelescopeTurnsX) > 0 then
                txt := Format(rsCW, [txt])
              else
                txt := Format(rsCCW, [txt]);
              txt := Format(rsAltTurns, [txt + tab]);
              txt := txt + blank + formatfloat(f2, abs(dy * sc.cfgsc.TelescopeTurnsY)) + blank;
              if (dy * sc.cfgsc.TelescopeTurnsY) > 0 then
                txt := Format(rsCW, [txt])
              else
                txt := Format(rsCCW, [txt]);
            end;
          end;
        end;
        sc.cfgsc.FindNote := txt + tab + sc.cfgsc.FindNote;
        skipmove := 10;
      end;
    end;
  end;
  if sc.cfgsc.TrackOn then
  begin
    sc.cfgsc.TrackRA := lasttrra;
    sc.cfgsc.TrackDEC := lasttrde;
    sc.cfgsc.TrackEpoch := lastepoch;
    sc.cfgsc.TrackType := lasttype;
    sc.cfgsc.Trackobj := lastobj;
    sc.cfgsc.TrackName := lasttrname;
  end;
  if assigned(Fshowinfo) then
  begin
    if Result then
      Fshowinfo(sc.cfgsc.FindDesc, Caption, True, self, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000)
    else
      Fshowinfo('');
  end;
  if Result and SampConnected and (sc.Catalog.cfgcat.SampFindTable > '') then
  begin
    if assigned(FSendSelectRow) then
      FSendSelectRow(sc.Catalog.cfgcat.SampFindTable, sc.Catalog.cfgcat.SampFindUrl,
        IntToStr(sc.Catalog.cfgcat.SampFindRec));
  end;
end;

procedure Tf_chart.IdentSearchResult(num, stype: string; itype: integer;
  ar1, de1: double; sr: string = ''; sn: string = ''; sd: string = '');
var
  fullmotion: boolean;
  dyear, epoch, ra2000, dec2000, x1, y1: double;
  xx, yy: single;
  sx,sy: integer;
  p: coordvector;
  rec: GCatrec;
  distfact: double;
begin
  sc.cfgsc.TrackOn := False;
  IdentLabel.Visible := False;
  // full record returned by catalog search
  if sc.catalog.FindRecOK then
  begin
    rec := sc.catalog.FindRec;
    sc.cfgsc.FindStarPM := False;
    // proper motion
    if sc.cfgsc.PMon and (rec.options.rectype = rtStar) and
      rec.star.valid[vsPmra] and rec.star.valid[vsPmdec] then
    begin
      if rec.star.valid[vsEpoch] then
        epoch := rec.star.epoch
      else
        epoch := rec.options.Epoch;
      dyear := (sc.cfgsc.CurYear + DayofYear(sc.cfgsc.CurYear, sc.cfgsc.CurMonth,
        sc.cfgsc.CurDay) / 365.25) - epoch;
      fullmotion := (rec.star.valid[vsPx] and (rec.star.px>0)and(rec.star.px<0.8) and (uppercase(trim(rec.options.flabel[26])) = 'RV'));
      propermotion(rec.ra, rec.Dec, dyear, rec.star.pmra, rec.star.pmdec,
        fullmotion, rec.star.px, rec.num[1], distfact);
      sc.cfgsc.FindStarPM := True;
      sc.catalog.AdjustStarForDistance(rec,distfact);
    end;
    sc.cfgsc.FindRA2000 := rec.ra;
    sc.cfgsc.FindDec2000 := rec.Dec;
    // precession
    Precession(rec.options.EquinoxJD, jd2000, sc.cfgsc.FindRA2000, sc.cfgsc.FindDec2000);
    sofa_S2C(rec.ra, rec.Dec, p);
    PrecessionV(rec.options.EquinoxJD, sc.cfgsc.JDChart, p);
    if sc.cfgsc.ApparentPos then
      apparent_equatorialV(p, sc.cfgsc, True, True);
    sofa_c2s(p, rec.ra, rec.Dec);
    rec.ra := rmod(rec.ra + pi2, pi2);
    // set the description
    sc.FormatCatRec(rec, sc.cfgsc.FindDesc);
    sc.FindRiseSet(0);
    sc.cfgsc.TrackRA := sc.cfgsc.FindRA;
    sc.cfgsc.TrackDec := sc.cfgsc.FindDec;
    sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
    sc.cfgsc.TrackOn := False;
    sc.cfgsc.TrackType := TTequat;
    sc.cfgsc.TrackName := sc.cfgsc.FindName;
    // center chart
    if not sc.cfgsc.ChartLock then sc.movetoradec(sc.cfgsc.FindRA, sc.cfgsc.FindDec);
    Refresh(True, False, False);
    // show label
    sc.cfgsc.FindOK := True;
    ShowIdentLabel;
    if SampConnected and (sc.Catalog.cfgcat.SampFindTable > '') then
    begin
      if assigned(FSendSelectRow) then
        FSendSelectRow(sc.Catalog.cfgcat.SampFindTable, sc.Catalog.cfgcat.SampFindUrl,
          IntToStr(sc.Catalog.cfgcat.SampFindRec));
    end;
  end
  // only coordinates are available
  else
  begin
    // precession
    ra2000 := ar1;
    dec2000 := de1;
    precession(jd2000, sc.cfgsc.JDchart, ar1, de1);
    if sc.cfgsc.ApparentPos then
      apparent_equatorial(ar1, de1, sc.cfgsc, True, itype < ftPla);
    // center chart
    if not sc.cfgsc.ChartLock then begin
      sc.movetoradec(ar1, de1);
      Refresh(True, False);
      sx := sc.cfgsc.Xcentre;
      sy := sc.cfgsc.Ycentre;
    end
    else begin
      projection(ar1, de1, x1, y1, false, sc.cfgsc);
      WindowXY(x1, y1, xx, yy, sc.cfgsc);
      sx := round(xx);
      sy := round(yy);
      Refresh(False, False);
    end;
    // try to get more information and show the label
    if (itype = ftPla) then
    begin
      ShowIdentLabel;
    end
    else if (itype = ftOnline) or
      (not IdentXY(sx, sy, False, True, itype,10)) then
    begin
      // object not found
      // online search result
      if itype = ftOnline then
      begin
        sc.cfgsc.FindCat := sr;
        sc.cfgsc.FindName := sn;
        if ServerCoordSystem=csJ2000 then begin
           sc.cfgsc.FindDesc2000 := ARpToStr(rmod(rad2deg * ra2000 / 15 + 24, 24)) + tab + DEpToStr(rad2deg * dec2000);
        end
        else
           sc.cfgsc.FindDesc2000 := '';
        sc.cfgsc.FindDesc := ARpToStr(rmod(rad2deg * ar1 / 15 + 24, 24)) + tab + DEpToStr(rad2deg * de1) + tab;
        sc.cfgsc.FindDesc := sc.cfgsc.FindDesc + 'OSR' + tab + sn + tab + sd;
      end
      else
      // set a minimal label
      begin
        sc.cfgsc.FindCat := '';
        sc.cfgsc.FindName := Num;
        if ServerCoordSystem=csJ2000 then begin
           sc.cfgsc.FindDesc2000 := ARpToStr(rmod(rad2deg * ra2000 / 15 + 24, 24)) + tab + DEpToStr(rad2deg * dec2000);
        end
        else
           sc.cfgsc.FindDesc2000 := '';
        sc.cfgsc.FindDesc := ARpToStr(rmod(rad2deg * ar1 / 15 + 24, 24)) + tab + DEpToStr(rad2deg * de1) + tab;
        sc.cfgsc.FindDesc := sc.cfgsc.FindDesc + stype + tab + Num + tab + rsDesc + rsZoomMoreToVi;
      end;
      sc.cfgsc.FindCatname := '';
      sc.cfgsc.FindRA := ar1;
      sc.cfgsc.FindDec := de1;
      sc.cfgsc.FindRA2000 := ra2000;
      sc.cfgsc.FindDec2000 := dec2000;
      sc.cfgsc.FindSize := 0;
      sc.cfgsc.FindPM := False;
      sc.cfgsc.FindStarPM := False;
      sc.cfgsc.FindOK := True;
      sc.cfgsc.FindType := itype;
      sc.cfgsc.TrackOn := False;
      sc.cfgsc.TrackType := TTequat;
      sc.cfgsc.TrackRA := ar1;
      sc.cfgsc.TrackDec := de1;
      sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
      sc.cfgsc.TrackName := Num;
      // show label
      ShowIdentLabel;
    end;
  end;
  // new pos is chart center
  xcursor := Image1.Width div 2;
  ycursor := Image1.Height div 2;
  if assigned(Fshowinfo) then
    Fshowinfo(sc.cfgsc.FindDesc, Caption, True, self, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
end;

function Tf_chart.ListXY(X, Y: integer; r: integer = 12; allobj:boolean=true; mincount:integer=0): boolean;
var
  ra, Dec, a, h, l, b, le, be, dx: double;
  buf, msg: string;
  i,c: integer;
begin
  Result := False;
  if locked then
    exit;
  sc.GetCoord(x, y, ra, Dec, a, h, l, b, le, be);
  ra := rmod(ra + pi2, pi2);
  dx := abs(r / sc.cfgsc.BxGlb)/2; // search a 12 pixel radius by default
  repeat
    dx:=2*dx;
    sc.Findlist(ra, Dec, dx, dx, buf, msg, False, allobj, True, false);
    c:=0;
    if mincount>0 then begin
      for i:=1 to length(buf) do
        if buf[i]=chr(13) then inc(c);
    end;
  until (c>=mincount)or(dx>(sc.cfgsc.fov/4));
  msg := msg + blank + rsSearchRadius + ': ' + DEToStrShort(rad2deg*dx, 0);
  if assigned(FListInfo) then
    FListInfo(buf, msg);
end;

function Tf_chart.ListRaDec(ra, de, r: double; allobj:boolean=true; mincount:integer=0; maxcount:integer=100): boolean;
var
  dx: double;
  buf, msg: string;
  i,c: integer;
begin
  Result := False;
  if locked then
    exit;
  ra := rmod(ra + pi2, pi2);
  dx := abs(r)/2;
  repeat
    dx:=2*dx;
    sc.Findlist(ra, de, dx, dx, buf, msg, False, allobj, True, true,maxcount);
    c:=0;
    if mincount>0 then begin
      for i:=1 to length(buf) do
        if buf[i]=chr(13) then inc(c);
    end;
  until (c>=mincount)or(dx>(r*10))or(dx>(pid2));
  msg := msg + blank + rsSearchRadius + ': ' + DEToStrShort(rad2deg*dx, 0);
  if assigned(FListInfo) then
    FListInfo(buf, msg);
end;

function Tf_chart.ListGrappaVar(ra, de: double): boolean;
var
  list: TGrappaSearchList;
  i,n:integer;
  buf, msg: string;
  cra,cde: double;
begin
  Result := False;
  if locked then
    exit;
  ra := rmod(ra + pi2, pi2);
  SearchGrappavar(ra,de, 6, list); // J2000 ,  fov=1°
  n:=Length(list);
  buf:='';
  for i:=0 to n-1 do begin
    cra:=deg2rad*list[i].ra;
    cde:=deg2rad*list[i].dec;
    CoordJ2000toChart(cra, cde);
    buf:=buf + 'GrappaVar';
    buf:=buf + tab + ARpToStr(rmod(rad2deg * cra / 15 + 24, 24));
    buf:=buf + tab + DEpToStr(rad2deg * cde);
    buf:=buf + tab + '  *';
    buf:=buf + tab + sc.catalog.cfgcat.GaiaVersion+' '+IntToStr(list[i].source_id);
    buf:=buf + tab + 'mG:'+FormatFloat(f3,list[i].g);
    buf:=buf + tab + 'mBP:'+FormatFloat(f3,list[i].b);
    buf:=buf + tab + 'mRP:'+FormatFloat(f3,list[i].r);
    buf:=buf + tab + 'Class:'+list[i].variclass;
    buf:=buf + crlf;
  end;
  msg:='Found '+inttostr(n)+' variable stars';
  if assigned(FListInfo) then
    FListInfo(buf, msg);
end;

procedure Tf_chart.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  try
  if VerboseMsg then
    WriteTrace(Caption + ' MouseUp');
  if MovingCircle then
  begin
    sc.DrawFinderMark(sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], True, -1);
    MovingCircle := False;
    if button = mbLeft then
    begin
      Inc(sc.cfgsc.NumCircle);
      GetAdXy(Xcursor, Ycursor, sc.cfgsc.CircleLst[sc.cfgsc.NumCircle, 1],
        sc.cfgsc.CircleLst[sc.cfgsc.NumCircle, 2], sc.cfgsc);
      Refresh(True, False);
    end;
  end
  else if (button = mbLeft) and sc.cfgsc.ShowScale then
  begin
    MeasureDistance(3, X, Y);
  end
  else if (button = mbLeft) and ((shift = []) or (shift = [ssLeft])) then
  begin
    if zoomstep > 0 then
    begin
      ZoomBox(3, X, Y);
    end
    else
    begin
      Image1.Cursor := ChartCursor;
      IdentXY(x, y);
      xcursor := x;
      ycursor := y;
      if cmain.SimpleDetail and sc.cfgsc.FindOK then
        identlabelClick(self);
    end;
  end
  else if (button = mbLeft) and (ssCtrl in shift) then
  begin
    IdentXY(x, y, False);
    xcursor := x;
    ycursor := y;
  end
  else if (button = mbLeft) and (ssShift in shift) and (not lastquick) then
  begin
    ZoomBox(4, 0, 0);
    ListXY(x, y);
    xcursor := x;
    ycursor := y;
  end;
  if (button = mbMiddle) or ((button = mbLeft) and (ssShift in shift)) or
    ((button = mbLeft) and cmain.SimpleMove) then
  begin
    Image1.Cursor := ChartCursor;
    if TrackCursorMove then
    begin
      TrackCursor(X, Y, 2);
      Refresh(True, False);
    end;
  end;
  except
    on E: Exception do WriteTrace('Mouseup error: ' + E.Message);
  end;
end;


procedure Tf_chart.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  try
  if VerboseMsg then
    WriteTrace(Caption + ' MouseDown');
  lastx := x;
  lasty := y;
  TrackCursorMove := False;
  GetCoordxy(x, y, lastl, lastb, sc.cfgsc);
  lastyzoom := y;
  case Button of
    mbLeft: if sc.cfgsc.ShowScale then
        MeasureDistance(1, X, Y)
      else if cmain.SimpleMove or (ssShift in shift) then
        TrackCursor(X, Y, 0)
      else
        ZoomBox(1, X, Y);
    mbMiddle: TrackCursor(X, Y, 0);
  end;
  if assigned(FSetFocus) then
    FSetFocus(Self);
  if assigned(FImageSetFocus) then
    FImageSetFocus(Sender);
  except
    on E: Exception do WriteTrace('Mousedown error: ' + E.Message);
  end;
end;

procedure Tf_chart.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
var
  c: double;
begin
  try
  if locked then
    exit;
  if lockmove then
    exit;
  if skipmove > 0 then
  begin
    system.Dec(skipmove);
    exit;
  end;
  if MovingCircle then
  begin
    Xcursor := x;
    Ycursor := y;
    sc.DrawFinderMark(sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], True, -1);
    GetAdXy(Xcursor, Ycursor, sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], sc.cfgsc);
    sc.DrawFinderMark(sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], True, -1);
    Image1.Invalidate;
  end
  else
  if (ssLeft in shift) and (not (ssShift in shift)) then
  begin
    if sc.cfgsc.ShowScale then
      MeasureDistance(2, X, Y)
    else if cmain.SimpleMove then
      TrackCursor(X, Y, 1)
    else
      ZoomBox(2, X, Y);
  end
  else if ((ssMiddle in shift) and (not (ssCtrl in Shift))) or
    ((ssLeft in shift) and (ssShift in shift)) or (cmain.SimpleMove and (ssLeft in shift)) then
  begin
    TrackCursor(X, Y, 1);
  end
  else if Shift = [ssAlt] then
  begin
    try
      lockmove := True;
      IdentXY(x, y, True, False);
      Application.ProcessMessages;
    finally
      lockmove := False;
    end;
  end
  else if ((ssMiddle in shift) and (ssCtrl in Shift)) then
  begin
    c := abs(y - lastyzoom) / 200;
    if c > 1 then
      c := 1;
    if (y - lastyzoom) > 0 then
      ZoomCursor(1 + c)
    else
      ZoomCursor(1 - c / 2);
    lastx := x;
    lasty := y;
    lastyzoom := y;
  end
  else
  begin
    if not sc.cfgsc.ShowScale then
      ShowCoord(x, y);
  end;
  except
    on E: Exception do WriteTrace('Mousemove error: ' + E.Message);
  end;
end;

procedure Tf_chart.ShowCoord(x, y: integer);
var
  ra, Dec, a, h, l, b, le, be, lha,am: double;
  txt: string;
begin
  {show the coordinates}
  sc.GetCoord(x, y, ra, Dec, a, h, l, b, le, be);
  case sc.cfgsc.projpole of
    AltAz:
    begin
      lha:=rmod(sc.cfgsc.CurST-ra+pi2,pi2);
      if lha>pi then lha:=lha-pi2;
      if h>0 then am:=AirMass(h);
      txt := rsAz + ':' + detostr(rad2deg * a) + blank + rsAlt + ':' + detostr(rad2deg * h) + blank;
      if h>0 then txt := txt + rsAirmass + ':' + FormatFloat(f1,am);
      txt := txt + crlf + rsRA + ':' + artostr(rad2deg * ra / 15) + blank +
             rsDE + ':' + detostr(rad2deg * Dec) + blank + rsLHA + ':'+ armtostr(rad2deg * lha / 15);
    end;
    Equat:
    begin
      ra := rmod(ra + pi2, pi2);
      txt := rsRA + ':' + arptostr(rad2deg * ra / 15) + blank + rsDE + ':' + deptostr(
        rad2deg * Dec) + crlf + rsAz + ':' + deptostr(rad2deg * a) + blank +
        rsAlt + ':' + deptostr(rad2deg * h);
    end;
    Gal:
    begin
      l := rmod(l + pi2, pi2);
      txt := rsL + ':' + deptostr(rad2deg * l) + blank + rsB + ':' + deptostr(
        rad2deg * b) + crlf + rsRA + ':' + arptostr(rad2deg * ra / 15) + blank +
        rsDE + ':' + deptostr(rad2deg * Dec);
    end;
    Ecl:
    begin
      le := rmod(le + pi2, pi2);
      txt := rsL + ':' + deptostr(rad2deg * le) + blank + rsB + ':' + deptostr(
        rad2deg * be) + crlf + rsRA + ':' + arptostr(rad2deg * ra / 15) + blank +
        rsDE + ':' + deptostr(rad2deg * Dec);
    end;
    else
      txt := '';
  end;
  if assigned(Fshowcoord) then
    Fshowcoord(txt);
end;

procedure Tf_chart.MeasureDistance(action, x, y: integer);
var
  ra, de, dx, dy, dist, x1, y1: double;
  xx, yy: single;
  pa: integer;
  txt: string;
begin
  txt := '';
  case action of
    1:
    begin    // mouse down
      // cleanup last measure
      if MeasureOn then
        MeasureDistance(4, 0, 0);
      // begin measure
      GetADxy(X, Y, MeasureRa, MeasureDe, sc.cfgsc);
      // start on tracked object?
      if sc.cfgsc.TrackOn and (sc.cfgsc.TrackType=TTequat) then
      begin
        MeasureRa := sc.cfgsc.TrackRA;
        MeasureDe := sc.cfgsc.TrackDec;
        Projection(MeasureRa, MeasureDe, x1, y1, False, sc.cfgsc, False);
        WindowXY(x1, y1, xx, yy, sc.cfgsc);
        X := round(xx);
        Y := round(yy);
        MeasureStartName := sc.cfgsc.TrackName;
      end
      else
      // start on object?
      if IdentXY(X, Y, True, True, ftAll, 2, True) then
      begin
        MeasureRa := sc.cfgsc.FindRA;
        MeasureDe := sc.cfgsc.FindDec;
        Projection(MeasureRa, MeasureDe, x1, y1, False, sc.cfgsc, False);
        WindowXY(x1, y1, xx, yy, sc.cfgsc);
        X := round(xx);
        Y := round(yy);
        MeasureStartName := sc.cfgsc.FindName;
      end
      else
        MeasureStartName := '.';
      XM1 := X;
      YM1 := Y;
      XMD1 := X;
      YMD1 := Y;
      MeasureOn := True;
    end;
    2, 3:
    begin    // mouse move, up
      if MeasureOn then
      begin
        // clean
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          pen.Color := clWhite;
          Pen.Mode := pmXor;
          brush.Style := bsclear;
          MoveTo(XM1, YM1);
          LineTo(XMD1, YMD1);
          Pen.Mode := pmCopy;
          brush.Style := bsSolid;
        end;
        GetADxy(X, Y, ra, de, sc.cfgsc);
        // end on object?
        if (action = 3) and IdentXY(X, Y, True, True, ftAll, 2, True) then
        begin
          ra := sc.cfgsc.FindRA;
          de := sc.cfgsc.FindDec;
          Projection(ra, de, x1, y1, False, sc.cfgsc, False);
          WindowXY(x1, y1, xx, yy, sc.cfgsc);
          X := round(xx);
          Y := round(yy);
          MeasureEndName := sc.cfgsc.FindName;
        end
        else
          MeasureEndName := '.';
        dist := rad2deg * AngularDistance(MeasureRa, MeasureDe, ra, de);
        if dist > 0 then
        begin
          pa := round(rmod(rad2deg * PositionAngle(MeasureRa, MeasureDe, ra, de) + 360, 360));
          txt := DEptoStr(dist) + ' PA:' + IntToStr(pa) + ldeg;
          dx := rmod((rad2deg * (ra - MeasureRa) / 15) + 24, 24);
          if dx > 12 then
            dx := dx - 24;
          dy := rad2deg * (de - MeasureDe);
          txt := txt + crlf + artostr(dx) + blank + detostr(dy);
          if assigned(Fshowcoord) then
            Fshowcoord(txt);
        end;
        if action = 3 then
        begin
          txt := rsFrom + ':  "' + MeasureStartName + '" ' + rsTo + ' "' + MeasureEndName +
            '"' + tab + rsSeparation + ': ' + txt;
          txt := stringreplace(txt, crlf, tab + rsOffset + ':', []);
          if assigned(Fshowinfo) then
            Fshowinfo(txt, Caption, True, self);
          Image1.Repaint;
        end;
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          pen.Color := clWhite;
          Pen.Mode := pmXor;
          brush.Style := bsclear;
          XMD1 := X;
          YMD1 := Y;
          MoveTo(XM1, YM1);
          LineTo(XMD1, YMD1);
          Pen.Mode := pmCopy;
          brush.Style := bsSolid;
        end;
      end;
    end;
    4:
    begin    // cleanup
      if MeasureOn then
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          pen.Color := clWhite;
          Pen.Mode := pmXor;
          brush.Style := bsclear;
          MoveTo(XM1, YM1);
          LineTo(XMD1, YMD1);
          Pen.Mode := pmCopy;
          brush.Style := bsSolid;
        end;
      MeasureOn := False;
    end;
  end;
end;

procedure Tf_chart.ZoomBox(action, x, y: integer);
var
  x1, x2, y1, y2, dx, dy, xc, yc, lc, w, h: integer;
  boxratio: double;
begin
  //if VerboseMsg then
  // WriteTrace('zoombox '+inttostr(action));
  case action of
    1:
    begin    // mouse down
      ZoomMove := 0;
      if Zoomstep = 0 then
      begin
        // begin zoom
        XZoom1 := X;
        YZoom1 := Y;
        Zoomstep := 1;
      end;
      if Zoomstep = 4 then
      begin
        // move box or confirm click
        DXzoom := Xzoom1 - X;
        DYzoom := Yzoom1 - Y;
        Zoomstep := 4;
      end;
    end;
    2:
    begin   // mouse move
      if Zoomstep >= 3 then
      begin
        // move box
        Inc(ZoomMove);
        if ZoomMove > 2 then
          zoomstep := 3;
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          pen.Color := clWhite;
          Pen.Mode := pmXor;
          brush.Style := bsclear;
          rectangle(Rect(XZoomD1, YZoomD1, XZoomD2, YZoomD2));
          dx := abs(XzoomD2 - XzoomD1);
          dy := abs(YzoomD2 - YzoomD1);
          XZoom1 := x + DXZoom;
          YZoom1 := y + DYZoom;
          Xzoom2 := Xzoom1 + dx;
          YZoom2 := Yzoom1 + dy;
          x1 := round(MinValue([Xzoom1, Xzoom2]));
          x2 := round(MaxValue([Xzoom1, Xzoom2]));
          y1 := round(MinValue([Yzoom1, Yzoom2]));
          y2 := round(MaxValue([Yzoom1, Yzoom2]));
          XzoomD1 := x1;
          XzoomD2 := x2;
          YzoomD1 := y1;
          YzoomD2 := y2;
          rectangle(Rect(XZoomD1, YZoomD1, XZoomD2, YZoomD2));
          Pen.Mode := pmCopy;
          brush.Style := bsSolid;
        end;
        if assigned(Fshowcoord) then
          Fshowcoord(demtostr(rad2deg * abs(dx / sc.cfgsc.Bxglb)));
      end
      else
      begin
        // draw zoom box
        Inc(ZoomMove);
        if ZoomMove < 2 then
          exit;
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          pen.Color := clWhite;
          Pen.Mode := pmXor;
          brush.Style := bsClear;
          if Zoomstep > 1 then
            rectangle(Rect(XZoomD1, YZoomD1, XZoomD2, YZoomD2));
          Xzoom2 := x;
          Yzoom2 := y;
          x1 := round(MinValue([Xzoom1, Xzoom2]));
          x2 := round(MaxValue([Xzoom1, Xzoom2]));
          y1 := round(MinValue([Yzoom1, Yzoom2]));
          y2 := round(MaxValue([Yzoom1, Yzoom2]));
          XzoomD1 := x1;
          XzoomD2 := x2;
          YzoomD1 := y1;
          YzoomD2 := y2;
          Zoomstep := 2;
          rectangle(Rect(XZoomD1, YZoomD1, XZoomD2, YZoomD2));
          Pen.Mode := pmCopy;
          brush.Style := bsSolid;
        end;
        if assigned(Fshowcoord) then
          Fshowcoord(demtostr(rad2deg * abs((XZoomD2 - XZoomD1) / sc.cfgsc.Bxglb)));
      end;
    end;
    3:
    begin   // mouse up
      if zoomstep >= 4 then
      begin
        // final confirmation
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          Pen.Color := clWhite;
          Pen.Mode := pmXor;
          Brush.Style := bsclear;
          Rectangle(Rect(XZoom1, YZoom1, XZoom2, YZoom2));
          Pen.Mode := pmCopy;
          Brush.Style := bsSolid;
        end;
        Zoomstep := 0;
        x1 := trunc(MinValue([XZoom1, XZoom2]));
        x2 := trunc(MaxValue([XZoom1, XZoom2]));
        y1 := trunc(MinValue([YZoom1, YZoom2]));
        y2 := trunc(MaxValue([YZoom1, YZoom2]));
        if (X >= X1) and (X <= X2) and (Y >= Y1) and (Y <= Y2) and
          (X1 <> X2) and (Y1 <> Y2) and (abs(x2 - x1) > 5) and (abs(y2 - y1) > 5) then
        begin
          // do the zoom
          lc := abs(X2 - X1);
          xc := round(X1 + lc / 2);
          yc := round(Y1 + (Y2 - Y1) / 2);
          sc.setfov(abs(lc / sc.cfgsc.BxGlb));
          sc.MovetoXY(xc, yc);
          Refresh(True, True);
        end
        else; // zoom aborted, nothing to do.
      end
      else if zoomstep >= 2 then
      begin
        zoomstep := 4;  // box size fixed, wait confirmation or move
        x1 := round(MinValue([Xzoom1, Xzoom2]));
        x2 := round(MaxValue([Xzoom1, Xzoom2]));
        y1 := round(MinValue([Yzoom1, Yzoom2]));
        y2 := round(MaxValue([Yzoom1, Yzoom2]));
        Xzoom1 := x1;
        Xzoom2 := x2;
        Yzoom1 := y1;
        Yzoom2 := y2;
        dx := Xzoom2 - Xzoom1;
        dy := Yzoom2 - Yzoom1;
        boxratio := abs(dx / dy);
        // adjust box size to screen ratio
        if boxratio > sc.cfgsc.windowratio then
        begin
          yc := Yzoom1 + (dy div 2);
          h := round(dx / sc.cfgsc.windowratio / 2);
          Yzoom1 := yc - h;
          Yzoom2 := yc + h;
        end
        else
        begin
          xc := Xzoom1 + (dx div 2);
          w := round(dy * sc.cfgsc.windowratio / 2);
          Xzoom1 := xc - w;
          Xzoom2 := xc + w;
        end;
        XzoomD1 := Xzoom1;
        XzoomD2 := Xzoom2;
        YzoomD1 := Yzoom1;
        YzoomD2 := Yzoom2;
      end
      else
      begin
        // zoom aborted or not initialized
        // box cleanup if necessary
        if Zoomstep > 1 then
          with Image1.Canvas do
          begin
            Pen.Width := 1;
            Pen.Color := clWhite;
            Pen.Mode := pmXor;
            Brush.Style := bsclear;
            Rectangle(Rect(XZoom1, YZoom1, XZoom2, YZoom2));
            Pen.Mode := pmCopy;
            Brush.Style := bsSolid;
          end;
        // zoom reset
        Zoomstep := 0;
        // call other mouseup function (identification)
        Image1MouseUp(Self, mbLeft, [], X, Y);
      end;
    end;
    4:
    begin   // abort
      if Zoomstep > 1 then
        with Image1.Canvas do
        begin
          Pen.Width := 1;
          Pen.Color := clWhite;
          Pen.Mode := pmXor;
          Brush.Style := bsclear;
          Rectangle(Rect(XZoom1, YZoom1, XZoom2, YZoom2));
          Pen.Mode := pmCopy;
          Brush.Style := bsSolid;
        end;
      Zoomstep := 0;
    end;
  end;
  Image1.Invalidate;
end;

procedure Tf_chart.TrackCursor(X, Y: integer; step: integer);
var
  newl, newb: double;
begin
  case step of
    0:
    begin
      TrackingCursor := True;
      image1.cursor := crHandPoint;
    end;
    1: if TrackingCursor then
      begin
        TrackCursorMove := True;
        if LockTrackCursor then
          exit;
        try
          if VerboseMsg then
            WriteTrace(Caption + ' TrackCursor');
          LockTrackCursor := True;
          GetCoordxy(x, y, newl, newb, sc.cfgsc);
          sc.MoveCenter(lastl - newl, lastb - newb);
          sc.cfgsc.quick := True;
          lastx := x;
          lasty := y;
          lastyzoom := y;
          Refresh(True, True);
          application.ProcessMessages;
          // very important to empty the mouse event queue before to unlock
        finally
          LockTrackCursor := False;
        end;
      end;
    2:
    begin
      TrackingCursor := False;
      Image1.Cursor := ChartCursor;
    end;
  end;
end;

procedure Tf_chart.ZoomCursor(yy: double);
begin
  if LockTrackCursor then
    exit;
  try
    LockTrackCursor := True;
    yy := sc.cfgsc.fov * abs(yy);
    if yy < FovMin then
      yy := FovMin;
    if yy > FovMax then
      yy := FovMax;
    sc.cfgsc.fov := yy;
    if VerboseMsg then
      WriteTrace(Caption + ' ZoomCursor');
    sc.cfgsc.Quick := True;
    Refresh(True, False);
    sc.cfgsc.Quick := False;
    RefreshTimer.Enabled := True;
  finally
    LockTrackCursor := False;
  end;
end;

procedure Tf_chart.About1Click(Sender: TObject);
begin
  identlabelClick(Sender);
end;

procedure Tf_chart.AddLabel1Click(Sender: TObject);
var
  ra, Dec: double;
begin
  GetAdXy(Xcursor, Ycursor, ra, Dec, sc.cfgsc);
  sc.AddNewLabel(ra, Dec);
end;

procedure Tf_chart.AllAtThisPosClick(Sender: TObject);
begin
  ListXY(xcursor, ycursor);
end;

procedure Tf_chart.BlinkTimerTimer(Sender: TObject);
begin
  if lockblink then
    exit;
  try
    lockblink := True;
    sc.cfgsc.ShowImageList := not sc.cfgsc.ShowImageList;
    sc.cfgsc.ShowBackgroundImage := sc.cfgsc.ShowImageList;
    if VerboseMsg then
      WriteTrace(Caption + ' BlinkTimerTimer');
    Refresh(True, False);
  finally
    lockblink := False;
  end;
end;

procedure Tf_chart.Cleanupmap1Click(Sender: TObject);
begin
  ZoomStep := 0;
  sc.cfgsc.TargetOn := False;
  sc.cfgsc.Trackon := False;
  sc.cfgsc.TrackName := '';
  sc.cfgsc.TrackType := TTNone;
  sc.cfgsc.FindOK := False;
  sc.cfgsc.FindName := '';
  Refresh(True, True);
end;

procedure Tf_chart.identlabelClick(Sender: TObject);
var
  ra2000, de2000: double;
  pt: TPoint;
  sameobj: boolean;
begin
  pt.X := 0;
  pt.Y := 0;
  pt := self.ClientToScreen(pt);
  if cmain.SimpleDetail then
  begin
    f_detail.Height := round(280
{$ifdef mswindows}
      * Screen.PixelsPerInch / 96
{$endif}
      );
    f_detail.Width := round(400
{$ifdef mswindows}
      * Screen.PixelsPerInch / 96
{$endif}
      );
    f_detail.top := pt.Y;
    f_detail.left := pt.X;
    f_detail.BorderStyle := bsNone;
    f_detail.Panel1.Visible := False;
  end
  else if (Sender <> nil) and (not f_detail.Visible) then
    formpos(f_detail, mouse.cursorpos.x, mouse.cursorpos.y);
  f_detail.source_chart := Caption;
  ra2000 := sc.cfgsc.FindRA;
  de2000 := sc.cfgsc.FindDec;
  if sc.cfgsc.ApparentPos then
    mean_equatorial(ra2000, de2000, sc.cfgsc, True, sc.cfgsc.FindType < ftPla);
  precession(sc.cfgsc.JDChart, jd2000, ra2000, de2000);
  f_detail.ra := ra2000;
  f_detail.de := de2000;
  sameobj := (f_detail.objname = sc.cfgsc.FindName);
  f_detail.objname := sc.cfgsc.FindName;
  f_detail.HtmlFontSize := sc.plot.cfgplot.FontSize[4];
  f_detail.IpHtmlPanel1.DefaultTypeFace := sc.plot.cfgplot.FontName[4];
  f_detail.TextOnly := cmain.TextOnlyDetail;
  f_detail.Show;
  f_detail.Sameposition := sameobj;
  f_detail.Text := FormatDesc;
  f_detail.SetFocus;
  f_detail.BringToFront;
end;

function Tf_chart.FormatDesc: string;
var
  desc, buf, buf2, otype, oname, txt, s1, s2, s3: string;
  thr, tht, ths, tazr, tazs, tculmalt: string;
  searchdir, fn, ImgCat: string;
  bmp: TBGRAbitmap;
  ipla, isat: integer;
  i,ii, pii, p, l, y, m, d, precision, idx: integer;
  isStar, isVar, isSolarSystem, isd2k, isvo, isOsr, isArtSat: boolean;
  ApparentValid, supconj: boolean;
  ra, Dec, q, a, h, ag, airm, hg, hr, ht, hs, hrl,hsl, azr, azs, al, j1, j2, j3, rar, der, rat,
  det, ras, des, culmalt, lha: double;
  ra2000, de2000, radate, dedate, raapp, deapp, raobs, deobs, cjd, cjd0, cst, nst, njd, err, gw: double;
  r: TStringList;
  ec, ap, an, ic, g, eq, cra1, cde1, dst1, cra, cdec, dist, pa, dst, dkm, rr, elong, phase, magn,
  diam, rc, xc, yc, zc, ma, sa, dx, dy, illum, vel, lighttime: double;
  nam, ref, gaiaid: string;
  emagn,amagn: double;
  ename, enum,efam,sh,sg,sg1,sg2,ediam,albedo,eperiod,amin,amax,u: string;
  grappavar: TStringList;

  function Bold(s: string): string;
  var
    k: integer;
  begin
    k := pos(':', s);
    if k > 0 then
    begin
      insert(htms_b, s, k + 1);
      Result := html_b + s;
    end
    else
      Result := s;
  end;

  function FilterDetail(det: string): boolean;
  const
    filter = 'DIST:';
  var
    i: integer;
    key: string;
  begin
    Result := True;
    i := pos(':', det);
    if i > 0 then
    begin
      key := uppercase(trim(copy(det, 1, i)));
      if pos(key, filter) > 0 then
        Result := False;
    end;
  end;

  function GetDetailValue(key: string): string;
  var
    i, j: integer;
    val: string;
  begin
    Result := '';
    i := pos(key, desc);
    if i > 0 then
    begin
      val := copy(desc, i + length(key), 99);
      j := pos(tab, val);
      val := copy(val, 1, j - 1);
      Result := val;
    end;
  end;

begin
  desc := sc.cfgsc.FindDesc;
  isd2k := (trim(sc.cfgsc.FindCat) = 'd2k');
  isvo := (trim(sc.cfgsc.FindCat) = 'VO');
  // header
  if NightVision then
    txt := html_h_nv
  else if DarkTheme then
      txt := html_h_drk
  else if cmain.SimpleDetail then
    txt := html_h_b + html_h1
  else
    txt := html_h;
  // object type
  p := pos(tab, desc);
  p := pos2(tab, desc, p + 1);
  l := pos2(tab, desc, p + 1);
  otype := trim(copy(desc, p + 1, l - p - 1));
  if otype = '*' then
    precision := 2
  else if otype = 'As' then
    precision := 2
  else if otype = 'Spk' then
    precision := 2
  else if otype = 'S*' then
    precision := 2
  else if otype = 'Cm' then
    precision := 2
  else if otype = 'P' then
    precision := 2
  else if otype = 'Ps' then
    precision := 2
  else
    precision := 0;
  isStar := (otype = '*');
  isVar := (otype = 'V*');
  isSolarSystem := ((otype = 'P') or (otype = 'Ps') or (otype = 'S*') or (otype = 'As') or (otype = 'Cm')or (otype = 'Spk'));
  isOsr := (otype = 'OSR');
  isArtSat := (otype = 'Sat');
  if isSolarSystem and (sc.cfgsc.FindSimjd <> 0) then
  begin
    cjd := sc.cfgsc.FindSimjd;
    Djd(cjd + (sc.cfgsc.TimeZone - sc.cfgsc.DT_UT) / 24, y, m, d, h); // return to local from TT
    cjd0 := jd(y, m, d, 0);
    cst := Sidtim(cjd0, h - sc.cfgsc.TimeZone, sc.cfgsc.ObsLongitude, sc.cfgsc.eqeq);
  end
  else
  begin
    cjd := sc.cfgsc.CurJDTT;
    cjd0 := sc.cfgsc.jd0;
    cst := sc.cfgsc.CurST;
  end;
  if cmain.SimpleDetail then
  begin
    i := pos(rsCommonName, desc);
    if i > 0 then
    begin
      buf := copy(desc, i + 1, 9999);
      i := pos(':', buf);
      buf := copy(buf, i + 1, 9999);
      i := pos(tab, buf);
      buf := trim(copy(buf, 1, i - 1));
      if buf > '' then
        txt := txt + buf + html_br;
    end;
  end
  else
  begin
    if isStar and (trim(GetDetailValue('Comp:')) > '') then
      buf := sc.catalog.LongLabelObj('D*')
    else
      buf := sc.catalog.LongLabelObj(otype);
    txt := txt + html_h1 + buf + htms_h1;
  end;
  buf := copy(desc, l + 1, 9999);
  // object name
  i := pos(tab, buf);
  oname := trim(copy(buf, 1, i - 1));
  Delete(buf, 1, i);
  if isStar then
  begin
    s1 := GetDetailValue('Const:');
    s2 := GetDetailValue('Bayer:');
    s3 := GetDetailValue('Fl:');
    if (s1 > '') and (s2 > '') then
    begin
      oname := sc.catalog.LongLabelGreek(s2) + ' ' + sc.catalog.GenitiveConst(s1);
    end
    else if (s1 > '') and (s3 > '') then
    begin
      oname := s3 + ' ' + sc.catalog.GenitiveConst(s1);
    end;
    i:=length(sc.catalog.cfgcat.GaiaVersion);
    if copy(oname,1,i)=sc.catalog.cfgcat.GaiaVersion then
      gaiaid:=trim(copy(oname,i+1,99))
    else begin
      s1 := GetDetailValue('GAIA DR3:'); // Gaia ref in XHIP
      if s1>'' then
        gaiaid:=trim(s1)
      else
        gaiaid:='';
    end;
  end;
  if isVar then
  begin
    if uppercase(copy(oname,1,8))='GAIA DR3' then
      gaiaid:=trim(copy(oname,9,99))
  end;
  txt := txt + html_b + oname + htms_b + html_br;
  // Planet picture
  ipla := 0;
  isat := 0;
  if (otype = 'P') or (otype = 'Ps') or (otype = 'S*') then
  begin
    for i := 1 to 11 do
      if pla[i] = oname then
        ipla := i;
    if ipla = 0 then
      for i := 12 to MaxPla do
        if pla[i] = oname then
          isat := i;
  end;
  if not cmain.SimpleDetail then
  begin
    if (otype = 'P') or ((otype = 'Ps') and (oname = pla[11])) then
    begin
      if ipla > 0 then
      begin
        searchdir := slash(appdir) + slash('data') + 'planet';
        r := TStringList.Create;
        if ipla = 5 then
          gw := sc.planet.JupGRS(sc.cfgsc.GRSlongitude, sc.cfgsc.GRSdrift, sc.cfgsc.GRSjd, cjd)
        else
          gw := 0;
        GetXplanet(Xplanetversion, '', searchdir, '200x200', slash(Tempdir) +
          'info.png', ipla, 0, gw, cjd, i, r);
        r.Free;
        if i = 0 then
          txt := txt + '<img src="' + slash(TempDir) + 'info.png" alt="' + oname +
            '" border="0" width="200" height="200">' + html_br;
      end;
    end
    else if (otype = 'Ps') and (HasPlanetImage(isat)) then
    begin
      searchdir := slash(appdir) + slash('data') + 'planet';
      r := TStringList.Create;
      gw := 0;
      GetXplanet(Xplanetversion, '', searchdir, '200x200', slash(Tempdir) +
        'info.png', isat, 0, gw, cjd, i, r);
      r.Free;
      if i = 0 then
        txt := txt + '<img src="' + slash(TempDir) + 'info.png" alt="' + oname +
          '" border="0" width="200" height="200">' + html_br;
    end;
    // Sun picture
    if (otype = 'S*') and (oname = pla[10]) then
    begin
      fn := slash(systoutf8(Tempdir)) + 'sun.jpg';
      if not FileExistsutf8(fn) then
      begin  // use default image
        fn := slash(systoutf8(appdir)) + slash('data') + slash('planet') + 'sun-0.jpg';
      end;
      if FileExistsutf8(fn) then
        txt := txt + '<img src="' + utf8tosys(fn) + '" alt="' + oname +
          '" border="0" width="200" height="200">' + html_br;
    end;
    // DSO picture
    ImgCat := sc.cfgsc.FindCat;
    if (ImgCat = 'ONGC')and(not sc.cfgsc.ONGCimg) then
       ImgCat := 'SAC';
    if sc.Fits.GetFileName(ImgCat, oname, fn) then
    begin
      if (ExtractFileExt(fn) <> '.nil') then
      begin
        sc.Fits.FileName := fn;
        if sc.Fits.Header.valid then
        begin
          bmp := TBGRABitmap.Create;
          try
            sc.Fits.min_sigma := sc.cfgsc.NEBmin_sigma;
            sc.Fits.max_sigma := sc.cfgsc.NEBmax_sigma;
            sc.Fits.GetBGRABitmap(bmp);
            fn := slash(systoutf8(TempDir)) + 'info.bmp';
            DeleteFileutf8(fn);
            bmp.SaveToFile(fn);
            if FileExistsutf8(fn) then
              txt := txt + '<img src="' + utf8tosys(fn) + '" alt="' + oname +
                '" border="0" width="200" height="200">' + html_br;
          finally
            bmp.Free;
          end;
        end;
      end;
    end;
  end;
  if not cmain.SimpleDetail then
  begin
    // source catalog
    if isd2k then
    begin
      txt := txt + html_b + rsFrom + blank + 'Deepsky software' + ':' + htms_b + html_br;
    end
    else if isvo then
    begin
      txt := txt + html_b + rsFrom + blank + rsVirtualObser + ':' + html_br + sc.cfgsc.FindCatname +
        htms_b + html_br;
    end
    else
    begin
      if (sc.cfgsc.FindCat <> '') or (sc.cfgsc.FindCatname <> '') then
      begin
        if sc.cfgsc.FindCat = 'Star' then
          txt := txt + html_b + rsInformationF + ':' + blank + rsStars
        else
          txt := txt + html_b + rsInformationF + ':' + blank + sc.cfgsc.FindCat;
      end;
      if sc.cfgsc.FindCatname <> '' then
      begin
        txt := txt + html_br + sc.cfgsc.FindCatname;
        txt := txt + htms_b + html_br;
      end;
    end;
  end;

  // other attribute
  amagn:=-999;
  repeat
    i := pos(tab, buf);
    if i = 0 then
      i := length(buf) + 1;
    buf2 := copy(buf, 1, i - 1);
    Delete(buf, 1, i);
    if cmain.SimpleDetail then
    begin
      if FilterDetail(buf2) then
        continue;
    end;
    if (otype <> 'Pl') and (uppercase(copy(buf2,1,6)) = 'CSTAR ') then
      continue;
    if copy(buf2,1,2) = '__' then  // pseudo value to help drawing
      continue;
    if isd2k and (copy(buf2, 1, 4) = 'Dim:') then
      continue;
    if copy(buf2,1,11) = 'MotionArcm:' then
      continue;
    if copy(buf2,1,9) = 'MotionPA:' then
      continue;
    if isd2k and (copy(buf2, 1, 5) = 'desc:') then
      buf2 := copy(buf2, 6, 999);
    if isd2k and (copy(buf2, 1, 2) = 'n:') then
      buf2 := copy(buf2, 3, 999);
    i := pos(':', buf2);
    if i > 0 then
    begin
      buf2 := stringreplace(buf2, ':', ': ', []);
      if copy(buf2, 1, 5) = rsDesc then
        buf2 := stringreplace(buf2, ';', html_br + html_sp + html_sp + html_sp, [rfReplaceAll]);
      if (uppercase(copy(buf2, 1, 5)) = 'DIST:') then
      begin
        buf2 := StringReplace(buf2, '[ly]', rsLightYears, []);
        i := pos('au', buf2);
        if cmain.SimpleDetail and (i > 0) then
        begin
          s1 := trim(copy(buf2, 6, i - 7));
          a := StrToFloatDef(s1, 0);
          if a > 0 then
          begin
            buf2 := 'Dist: ' + FormatFloat(f1, a * km_au / 1E6) + blank + rsMillionKm;
          end;
        end;
      end;
      if (uppercase(copy(buf2, 1, 3)) = 'MV:') then
      begin
         amagn:=StrToFloatDef(trim(copy(buf2,4,99)),-999);
      end;
      if otype = 'V*' then begin
        if (uppercase(copy(buf2, 1, 7)) = 'MEPOCH:') then
        begin
           j1:=StrToFloatDef(trim(copy(buf2,8,99)),0);
           if j1 <> 0 then begin
             if j1<100000 then j1:=j1+2400000;
             djd(j1,y,m,d,h);
             buf2:=buf2+', '+isodate(y, m, d);
             if h<>0 then buf2:=buf2+blank+TimeToStrShort(h);
           end;
        end;
        if (uppercase(copy(buf2, 1, 2)) = 'T:') then
        begin
           buf2 := 'T: '+'<a href="VarType '+trim(copy(buf2,3,99))+'">' + trim(copy(buf2,3,99)) + '</a>' + blank;
        end;
      end;
      if (uppercase(copy(buf2, 1, 5)) = 'LINK:') then
      begin
         buf2 := 'Link: '+'<a href="Link '+trim(copy(buf2,6,999))+'">' + trim(copy(buf2,6,999)) + '</a>' + blank;
      end;
      if isvo or isOsr then
        txt := txt + bold(buf2)
      else
        txt := txt + bold(sc.catalog.LongLabel(buf2));
    end
    else
      txt := txt + buf2;
    txt := txt + html_br;
  until buf = '';

  // object motion
  if cmain.KioskMode then
    dist:=0
  else if (otype='Cm')or(otype='As')or(otype='Spk') then begin
    sc.planet.ObjectMotion(otype,oname,sc.cfgsc.TrackElemEpoch,cjd,cst,sc.cfgsc,dist,pa,dx,dy);
  end
  else begin
    dist := 0;
    nst := Rmod(cst + 1.00273790935 * 15 * deg2rad, pi2); // sidereal + 1 hour
    njd := cjd + 1 / 24; // JD + 1 hour
    if (otype = 'P') then
    begin
      sc.planet.Planet(ipla, cjd, cra1, cde1, dst1, illum, phase, diam, magn, rc, xc, yc, zc, vel, lighttime);
      sc.planet.Planet(ipla, njd, cra, cdec, dst, illum, phase, diam, magn, rc, xc, yc, zc, vel, lighttime);
      Precession(jd2000,sc.cfgsc.JDChart,cra1,cde1);
      Precession(jd2000,sc.cfgsc.JDChart,cra,cdec);
      if sc.cfgsc.ApparentPos then begin
        apparent_equatorial(cra1,cde1,sc.cfgsc,true,true);
        apparent_equatorial(cra,cdec,sc.cfgsc,true,true);
      end;
      if sc.cfgsc.PlanetParalaxe then begin
        Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, sc.cfgsc);
        Paralaxe(nst, dst, cra, cdec, cra, cdec, q, sc.cfgsc);
      end;
      dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
    end;
    if (otype = 'S*') and (ipla = 10) then
    begin
      sc.planet.Sun(cjd, cra1, cde1, dst1, diam);
      sc.planet.Sun(njd, cra, cdec, dst, diam);
      Precession(jd2000,sc.cfgsc.JDChart,cra1,cde1);
      Precession(jd2000,sc.cfgsc.JDChart,cra,cdec);
      if sc.cfgsc.ApparentPos then begin
        apparent_equatorial(cra1,cde1,sc.cfgsc,true,true);
        apparent_equatorial(cra,cdec,sc.cfgsc,true,true);
      end;
      if sc.cfgsc.PlanetParalaxe then begin
        Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, sc.cfgsc);
        Paralaxe(nst, dst, cra, cdec, cra, cdec, q, sc.cfgsc);
      end;
      dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
    end;
    if (otype = 'Ps') and (ipla = 11) then
    begin
      sc.planet.Moon(cjd, cra1, cde1, dst1, dkm, diam, phase, illum,sc.cfgsc);
      sc.planet.Moon(njd, cra, cdec, dst, dkm, diam, phase, illum,sc.cfgsc);
      Precession(jd2000,sc.cfgsc.JDChart,cra1,cde1);
      Precession(jd2000,sc.cfgsc.JDChart,cra,cdec);
      if sc.cfgsc.ApparentPos then begin
        apparent_equatorial(cra1,cde1,sc.cfgsc,true,true);
        apparent_equatorial(cra,cdec,sc.cfgsc,true,true);
      end;
      if sc.cfgsc.PlanetParalaxe then begin
        Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, sc.cfgsc);
        Paralaxe(nst, dst, cra, cdec, cra, cdec, q, sc.cfgsc);
      end;
      dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
    end;
    if (otype = 'Ps') and (isat > 0) then
    begin
      sc.planet.PlanSat(isat, cjd, sc.cfgsc, cra1, cde1, dst1, supconj, buf);
      sc.planet.PlanSat(isat, njd, sc.cfgsc, cra, cdec, dst, supconj, buf);
      Precession(jd2000,sc.cfgsc.JDChart,cra1,cde1);
      Precession(jd2000,sc.cfgsc.JDChart,cra,cdec);
      if sc.cfgsc.ApparentPos then begin
        apparent_equatorial(cra1,cde1,sc.cfgsc,true,true);
        apparent_equatorial(cra,cdec,sc.cfgsc,true,true);
      end;
      if sc.cfgsc.PlanetParalaxe then begin
        Paralaxe(cst, dst1, cra1, cde1, cra1, cde1, q, sc.cfgsc);
        Paralaxe(nst, dst, cra, cdec, cra, cdec, q, sc.cfgsc);
      end;
      dist := rad2deg * angulardistance(cra1, cde1, cra, cdec);
      if buf<>'' then
         txt := txt + html_b + rsEphemeris + ': ' + htms_b + buf + html_br;
    end;
    if dist > (0.05 / 3600) then
    begin
      pa := round(rmod(rad2deg * PositionAngle(cra1, cde1, cra, cdec) + 360, 360));
      dx := rmod((rad2deg * (cra - cra1) / 15) + 24, 24);
      if dx > 12 then
        dx := dx - 24;
      dy := rad2deg * (cdec - cde1);
    end
    else dist:=0;
  end;

  if dist > 0 then
  begin
    txt := txt + html_b + rsHourlyMotion + ': ' + htms_b + DEToStrShort(dist) + ' PA:' + FormatFloat(f1,pa) + ldeg;
    txt := txt + ' dRA:' + ARToStrShort(dx, 2) + ' dDec:' + DEToStrShort(dy);
    txt := txt + ' dx:' + FormatFloat(f1,dx*15*3600) + lsec + ' dy:' + FormatFloat(f1,dy*3600) + lsec + html_br;
  end;

  // Asteroid extension
  if otype = 'As' then
  begin
    nam:='';
    sc.planet.FindAsteroidIndex(oname,idx);
    if idx>=0 then begin
      sc.cdb.GetAstElem(idx, sc.cfgsc.TrackElemEpoch, h, g, ma, ap, an, ic, ec, sa, eq, ref, nam);
      sc.planet.InitAsteroid(sc.cfgsc.TrackElemEpoch, h, g, ma, ap, an, ic, ec, sa, eq, nam);
      sc.planet.Asteroid(cjd, True, cra1, cde1, dst, rr, elong, phase, magn, xc, yc, zc);
    end;
    i:=pos(')',nam);
    if i>0 then begin
      enum:=copy(nam,1,i-1);
      enum:=trim(StringReplace(enum,'(','',[]));
      ename:=nam;
      delete(ename,1,i);
      ename:=trim(ename);
    end
    else begin
      ename:=trim(nam);
      enum:='';
    end;
    if sc.cdb.GetAstExt(ename, enum, efam,sh,sg,sg1,sg2,ediam,albedo,eperiod,amin,amax,u) then begin
      txt:=txt + html_br + html_b + rsInformationF2+ blank +
           '<a href="' + URL_Asteroid_Lightcurve_Database_Info + '">' +
           'Asteroid Lightcurve Database'+ '</a>' + ':' + htms_b + html_br;
      txt:=txt + html_b + rsFamily +': ' + htms_b + efam + html_br;
      txt:=txt + html_b + rsDiameter +': ' + htms_b + ediam + blank + rsKm + html_br;
      txt:=txt + html_b + rsAlbedo +': ' + htms_b + albedo + html_br;
      txt:=txt + html_b + rsPeriod +': ' + htms_b + eperiod + blank + rsHours + html_br;
      if (sh<>'') then begin
        emagn:=-1;
        if (sg1<>'') then
          emagn:=sc.planet.AsteroidMag(phase,dst,rr,StrToFloat(sh),StrToFloat(sg1),StrToFloatDef(sg2,-1))
        else if (sg<>'') then
          emagn:=sc.planet.AsteroidMag(phase,dst,rr,StrToFloat(sh),StrToFloat(sg));
        if emagn>0 then
          txt:=txt + html_b + rsMagnitude +': ' + htms_b + FormatFloat(f2,emagn) + html_br;
      end;
      if amin<>'' then txt:=txt + html_b + rsAmplitudeMin +': ' + htms_b + amin + html_br;
      if amax<>'' then txt:=txt + html_b + rsAmplitudeMax +': ' + htms_b + amax + html_br;
      txt:=txt + html_b + rsQualityFlag +': ' + htms_b + u + html_br;
    end;
  end;

  // Gaia variable information
  if gaiaid>'' then begin
    if ReadGrappavar(gaiaid,grappavar) then begin
      txt:=txt + html_br + html_b + '<a href="' + URL_GRAPPA_Info + '">' +
           rsGAIAVariable+ '</a>' + ':' + htms_b;
      for i:=0 to grappavar.Count-1 do
        txt:=txt+ html_br + grappavar[i];
      txt:=txt+html_br;
      grappavar.Free;
    end;
  end;

  if not cmain.SimpleDetail then
  begin
    // coordinates
    ApparentValid := ((sc.cfgsc.nutl <> 0) or (sc.cfgsc.nuto <> 0)) and
      (sc.cfgsc.abm or (sc.cfgsc.abp <> 0) or (sc.cfgsc.abe <> 0));
    txt := txt + html_br + html_b + rsCoordinates + blank;
    if sc.cfgsc.CoordExpertMode then
    begin
      ;
      if sc.cfgsc.ApparentPos and ApparentValid then
        txt := txt + blank + rsApparent
      else
        txt := txt + blank + rsMean;
      txt := txt + blank + sc.cfgsc.EquinoxName;
    end
    else
      case sc.cfgsc.CoordType of
        0: if ApparentValid then
            txt := txt + blank + rsApparent
          else
            txt := txt + blank + rsMeanOfTheDat;
        1: txt := txt + blank + rsMeanOfTheDat;
        2: txt := txt + blank + rsMeanJ2000;
        3: txt := txt + blank + rsAstrometricJ;
      end;
    if isStar then
    begin
      if sc.cfgsc.PMon and (not sc.cfgsc.FindPM) then
        txt := txt + blank + rsNoProperMo
      else if sc.cfgsc.PMon and (sc.cfgsc.YPmon <> 0) then
        txt := txt + blank + rsEpoch + ': ' + formatfloat(f1, sc.cfgsc.YPmon);
    end;
    if isSolarSystem then
      if sc.cfgsc.PlanetParalaxe then
        txt := txt + blank + rsTopoCentric
      else
        txt := txt + blank + rsGeocentric;
    txt := txt + htms_b + html_br;
    if isArtSat then
    begin
      raapp := sc.cfgsc.FindRA;
      deapp := sc.cfgsc.FindDec;
      txt := txt + html_b + rsApparent + blank + htms_b + rsRA + ': ' + armtostr(
        rad2deg * raapp / 15) + '   ' + rsDE + ':' + demtostr(rad2deg * deapp) + html_br;
    end
    else
    begin
      // return to j2000 coord.
      ra2000 := sc.cfgsc.FindRA2000;
      de2000 := sc.cfgsc.FindDec2000;
      ra2000 := NormRA(ra2000);
      // mean of date, apply only precession
      radate := ra2000;
      dedate := de2000;
      precession(jd2000, sc.cfgsc.JDChart, radate, dedate);
      if isSolarSystem and sc.cfgsc.PlanetParalaxe then
        Paralaxe(cst, sc.cfgsc.Finddist, radate, dedate, radate, dedate, q, sc.cfgsc);
      radate := NormRA(radate);
      // apparent
      if ApparentValid then
      begin
        raapp := ra2000;
        deapp := de2000;
        // apply parallax
        if isStar then
          StarParallax(raapp, deapp, sc.cfgsc.FindPX, sc.cfgsc.EarthB);
        // apply precession
        precession(jd2000, sc.cfgsc.JDChart, raapp, deapp);
        // apply nutation, aberration, light deflection
        apparent_equatorial(raapp, deapp, sc.cfgsc, true, not isSolarSystem);
        if isSolarSystem and sc.cfgsc.PlanetParalaxe then
          Paralaxe(cst, sc.cfgsc.Finddist, raapp, deapp, raapp, deapp, q, sc.cfgsc);
        raapp := NormRA(raapp);
        ApparentToObserved(raapp,deapp, sc.cfgsc, raobs, deobs);
      end;
      if isSolarSystem and sc.cfgsc.PlanetParalaxe then
      begin
        Paralaxe(cst, sc.cfgsc.Finddist, ra2000, de2000, ra2000, de2000, q, sc.cfgsc, jd2000);
        ra2000 := NormRA(ra2000);
      end;
      // print coord.
      if sc.cfgsc.CoordExpertMode then
        txt := txt + rsRA + ': ' + arptostr(rad2deg * sc.cfgsc.FindRA / 15, precision) +
          '   ' + rsDE + ':' + deptostr(rad2deg * sc.cfgsc.FindDec, precision) + html_br;
      if (sc.cfgsc.CoordType <= 1) and ApparentValid then begin
        txt := txt + html_b + rsApparent + blank + htms_b + rsRA + ': ' + arptostr(
          rad2deg * raapp / 15, precision) + '   ' + rsDE + ':' + deptostr(rad2deg * deapp, precision) + html_br;
        txt := txt + html_b + 'Observed' + blank + htms_b + rsRA + ': ' + arptostr(
          rad2deg * raobs / 15, precision) + '   ' + rsDE + ':' + deptostr(rad2deg * deobs, precision) + html_br;
      end;
      if (sc.cfgsc.CoordType <= 1) then
        txt := txt + html_b + rsMeanOfTheDat + blank + htms_b + rsRA + ': ' + arptostr(
          rad2deg * radate / 15, precision) + '   ' + rsDE + ':' + deptostr(rad2deg * dedate, precision) + html_br;
      if isStar and sc.cfgsc.PMon and sc.cfgsc.FindPM and (sc.cfgsc.YPmon = 0) then
        txt := txt + html_b + rsAstrometricJ + htms_b + ' ' + rsRA + ': ' + arptostr(
          rad2deg * ra2000 / 15, 4) + '   ' + rsDE + ':' + deptostr(rad2deg * de2000, 4) + html_br
      else if isStar then
        txt := txt + html_b + rsMeanJ2000 + htms_b + ' ' + rsRA + ': ' + arptostr(
          rad2deg * ra2000 / 15, 4) + '   ' + rsDE + ':' + deptostr(rad2deg * de2000, 4) + html_br
      else
        txt := txt + html_b + rsMeanJ2000 + htms_b + ' ' + rsRA + ': ' + arptostr(
          rad2deg * ra2000 / 15, precision) + '   ' + rsDE + ':' + deptostr(rad2deg * de2000, precision) + html_br;
    end;
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
    Eq2Ecl(ra, Dec, sc.cfgsc.ecl, a, h);
    a := rmod(a + pi2, pi2);
    txt := txt + html_b + rsEcliptic + blank + htms_b + blank + rsL + ': ' + detostr(
      rad2deg * a) + blank + rsB + ':' + detostr(rad2deg * h) + html_br;
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
    if sc.cfgsc.ApparentPos then
      mean_equatorial(ra, Dec, sc.cfgsc, true, not isSolarSystem);
    Eq2Gal(ra, Dec, a, h, sc.cfgsc);
    a := rmod(a + pi2, pi2);
    txt := txt + html_b + rsGalactic + blank + htms_b + blank + rsL + ': ' + detostr(
      rad2deg * a) + blank + rsB + ':' + detostr(rad2deg * h) + html_br;
    txt := txt + html_br;
  end
  else
    txt := txt + html_br;

  // local position
  if not cmain.SimpleDetail then
  begin
    txt := txt + html_b + rsVisibilityFo + ':' + htms_b + html_br;
    djd(cjd + (sc.cfgsc.TimeZone - sc.cfgsc.DT_UT) / 24, y, m, d, h);
    txt := txt + sc.cfgsc.ObsName + blank + Date2Str(y, m, d) + blank + ArToStr3(h) +
      '  ( ' + TzGMT2UTC(sc.cfgsc.tz.ZoneName) + ' )' + html_br;
    djd(cjd - sc.cfgsc.DT_UT / 24, y, m, d, h);
    txt := txt + html_b + rsUniversalTim + ':' + htms_b + blank + date2str(y, m, d) + 'T' + timtostr(h);
    txt := txt + blank + 'JD=' + formatfloat(f5, cjd - sc.cfgsc.DT_UT / 24) + html_br;

    err := DTminusUTError(y, m, d, sc.cfgsc);
    if abs(err) > 0 then
    begin
      txt := txt + html_b + rsDeltaTError + ': ' + htms_b + blank + plusminus + ARtoStr(err / 3600) + html_br;
    end
    else if abs(err) > 10 then
    begin
      txt := txt + html_b + rsDeltaTError + ': ' + htms_b + blank + plusminus + IntToStr(
        round(err)) + blank + rsSec2 + html_br;
    end;

    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
    precession(sc.cfgsc.JDChart, cjd - sc.cfgsc.DT_UT / 24, ra, Dec);
    Eq2Hz(cst - ra, Dec, a, h, sc.cfgsc, 2);
    Eq2Hz(cst - ra, Dec, ag, hg, sc.cfgsc, 0);
    if sc.catalog.cfgshr.AzNorth then
      a := Rmod(a + pi, pi2);
    txt := txt + html_b + rsLocalSideral + ': ' + htms_b + artostr3(
      rmod(rad2deg * cst / 15 + 24, 24)) + html_br;
    lha:=rmod(cst-ra+pi2,pi2);
    if lha>pi then lha:=lha-pi2;
    txt := txt + html_b + rsHourAngle + ': ' + htms_b + ARToStr(rad2deg * lha / 15) + html_br;
    txt := txt + html_b + rsAzimuth + ': ' + htms_b + LONToStr(rad2deg * a) + html_br;
    if h >= sc.cfgsc.ObsHorizonDepression then
      txt := txt + html_b + rsAltitude + ': ' + htms_b + deptostr(rad2deg * h, 1) + html_br;
    // show refracted altitude only if above the horizon
    txt := txt + html_b + rsGeometricAlt + ': ' + htms_b + deptostr(rad2deg * hg, 1) + html_br;
    if h > 0 then
    begin
      airm := AirMass(h);
      txt := txt + html_b + rsAirmass + ': ' + htms_b + FormatFloat(f1, airm) + html_br;
      if amagn>-900 then txt := txt + html_b + 'Absorbed magnitude' + ': '+ htms_b + FormatFloat(f1, amagn + sc.cfgsc.absorption * airm) + html_br;
    end;
  end;
  if (not isArtSat) then
  begin
    // rise/set time
    if (otype = 'P') then
    begin // planet
      sc.planet.PlanetRiseSet(ipla, cjd0, sc.catalog.cfgshr.AzNorth,
        thr, tht, ths, tazr, tazs, j1, j2, j3, rar, der, rat, det, ras, des, i, sc.cfgsc);
    end
    else if (otype = 'S*') and (oname = pla[10]) then
    begin // Sun
      sc.planet.PlanetRiseSet(10, cjd0, sc.catalog.cfgshr.AzNorth, thr,
        tht, ths, tazr, tazs, j1, j2, j3, rar, der, rat, det, ras, des, i, sc.cfgsc);
    end
    else if (otype = 'Ps') and (ipla = 11) then
    begin // Moon
      sc.planet.PlanetRiseSet(ipla, cjd0, sc.catalog.cfgshr.AzNorth,
        thr, tht, ths, tazr, tazs, j1, j2, j3, rar, der, rat, det, ras, des, i, sc.cfgsc);
    end
    else
    begin // fixed object
      ra := sc.cfgsc.FindRA;
      Dec := sc.cfgsc.FindDec;
      precession(sc.cfgsc.JDChart, cjd, ra, Dec);
      rar:=ra;
      der:=dec;
      ras:=ra;
      des:=dec;
      RiseSet(cjd0, ra, Dec, hr, ht, hs, azr, azs, i, sc.cfgsc);
      if sc.catalog.cfgshr.AzNorth then
      begin
        Azr := rmod(Azr + pi, pi2);
        Azs := rmod(Azs + pi, pi2);
      end;
      thr := artostr3(rmod(hr + 24, 24));
      tht := artostr3(rmod(ht + 24, 24));
      ths := artostr3(rmod(hs + 24, 24));
      tazr := LONmToStr(rad2deg * Azr);
      tazs := LONmToStr(rad2deg * Azs);
    end;
    if sc.cfgsc.HorizonRise and (sc.cfgsc.HorizonMax > musec) then begin
      pii:=i;
      if ObjRise(rar,der,sc.cfgsc,hrl,al,ii) then begin
         thr := rsLocalHorizon + blank + artostr3(rmod(hrl + 24, 24));
         tazr:=LONmToStr(rad2deg * al);
         i:=ii;
      end;
      if ObjSet(ras,des,sc.cfgsc,hsl,al,ii) then begin
         ths := rsLocalHorizon + blank + artostr3(rmod(hsl + 24, 24));
         tazs:=LONmToStr(rad2deg * al);
         i:=ii;
      end;
      if (pii=1) and (abs(hsl-hrl)<0.05) then i:=1; // detect circumpolar
    end;
    culmalt := 90 - sc.cfgsc.ObsLatitude + rad2deg * sc.cfgsc.FindDec;
    if culmalt > 90 then
      culmalt := 180 - culmalt;
    if culmalt > -1 then
      culmalt := min(90, culmalt + sc.cfgsc.ObsRefractionCor *
        (1.02 / tan(deg2rad * (culmalt + 10.3 / (culmalt + 5.11)))) / 60)
    else
      culmalt := culmalt + 0.64658062088;
    if (not cmain.SimpleDetail) then
      tculmalt := demtostr(culmalt)
    else
      tculmalt := '';
    case i of
      0:
      begin
        txt := txt + html_b + rsRise + ':' +blank+ htms_b + thr + blank;
        if (not cmain.SimpleDetail) and (trim(tazr) > '') then
          txt := txt + rsAzimuth + ':' +blank+ tAzr + html_br
        else
          txt := txt + html_br;
        txt := txt + html_b + rsTransit + ':' +blank+ htms_b + tht + blank + tculmalt + html_br;
        txt := txt + html_b + rsSet + ':' +blank+ htms_b + ths + blank;
        if (not cmain.SimpleDetail) and (trim(tazs) > '') then
          txt := txt + rsAzimuth + ':' +blank+ tAzs + html_br
        else
          txt := txt + html_br;
      end;
      1:
      begin
        txt := txt + rsCircumpolar + html_br;
        txt := txt + html_b + rsCulmination + ':' +blank+ htms_b + tht + blank + tculmalt + html_br;
      end;
      else
      begin
        txt := txt + rsInvisibleAtT + html_br;
      end;
    end;
  end;

  if not cmain.SimpleDetail then
  begin
    // other notes
    buf := sc.cfgsc.FindNote;
    if buf > '' then
    begin
      txt := txt + html_br;
      repeat
        i := pos(tab, buf);
        if i = 0 then
          i := length(buf) + 1;
        buf2 := copy(buf, 1, i - 1);
        Delete(buf, 1, i);
        i := pos(':', buf2);
        if i > 0 then
        begin
          txt := txt + bold(copy(buf2, 1, i));
          Delete(buf2, 1, i);
        end;
        txt := txt + buf2 + html_br;
      until buf = '';
    end;
  end;

  if not cmain.SimpleDetail then
  begin
    if (not isArtSat) and (not isSolarSystem) then
    begin
      // external links
      txt := txt + html_br + html_b + rsMoreInformat + ':' + htms_b + html_br;
      txt := txt + rsSearchByName + ':' + blank;
      for i := 1 to infoname_maxurl do
      begin
        txt := txt + '<a href="' + IntToStr(i) + '">' + infoname_url[i, 2] + '</a>,' + blank;
      end;
      txt := txt + html_br;
      txt := txt + rsSearchByPosi + ':' + blank;
      for i := 1 to infocoord_maxurl do
      begin
        txt := txt + '<a href="' + IntToStr(i + infoname_maxurl) + '">' + infocoord_url[i, 2] +
          '</a>,' + blank;
      end;
      txt := txt + html_br;
    end;
  end;
  Result := txt + html_br + htms_h;
end;

procedure Tf_chart.chart_switchstarExecute(Sender: TObject);
begin
  if VerboseMsg then
    WriteTrace(Caption + ' switchstarExecute');
  Dec(sc.plot.cfgplot.starplot);
  if sc.plot.cfgplot.starplot < 0 then
    sc.plot.cfgplot.starplot := 2;
  if sc.plot.cfgplot.starplot = 0 then
    sc.plot.cfgplot.nebplot := 0
  else
    sc.plot.cfgplot.nebplot := 1;
  sc.cfgsc.FillMilkyWay := (sc.plot.cfgplot.nebplot = 1);
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  Refresh(True, False);
end;

procedure Tf_chart.chart_switchbackgroundExecute(Sender: TObject);

begin
  if VerboseMsg then
    WriteTrace(Caption + ' switchbackgroundExecute');
  sc.plot.cfgplot.autoskycolor := not sc.plot.cfgplot.autoskycolor;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  Refresh(True, False);
end;


function Tf_Chart.cmd_SetCursorPosition(x, y: integer): string;
begin
  if (x >= 0) and (x <= image1.Width) and (y >= 0) and (y <= image1.Height) then
  begin
    xcursor := x;
    ycursor := y;
    Result := msgOK;
  end
  else
    Result := msgfailed + ' Bad position.';
end;


function Tf_Chart.cmd_GetCursorPosition: string;
begin
  Result := msgOK + blank + IntToStr(xcursor) + blank + IntToStr(ycursor);
end;

function Tf_Chart.cmd_SetBGimage(onoff,setfov: string; loadnew:boolean=true): string;
begin
  Result := msgOK;
  sc.cfgsc.ShowImageList := (uppercase(onoff) = 'ON');
  if (not sc.cfgsc.ShowImageList) or loadnew then
    sc.cfgsc.ShowBackgroundImage := sc.cfgsc.ShowImageList;
  if sc.cfgsc.ShowBackgroundImage and (not sc.Fits.dbconnected) then
  begin
    sc.cfgsc.ShowBackgroundImage := False;
    sc.cfgsc.ShowImageList := False;
    WriteTrace(rsErrorPleaseC);
    Result := msgFailed;
    exit;
  end;
  if loadnew and sc.cfgsc.ShowBackgroundImage and (not sc.Fits.Header.valid) then
  begin
    sc.Fits.Filename := sc.cfgsc.BackgroundImage;
    sc.Fits.InfoWCScoord;
    if sc.Fits.Header.valid then
    begin
      sc.Fits.DeleteDB('OTHER', 'BKG');
      if not sc.Fits.InsertDB(sc.cfgsc.BackgroundImage, 'OTHER', 'BKG',
        sc.Fits.Center_RA, sc.Fits.Center_DE, sc.Fits.Img_Width, sc.Fits.Img_Height,
        sc.Fits.Rotation) then
        sc.Fits.InsertDB(sc.cfgsc.BackgroundImage, 'OTHER', 'BKG',
          sc.Fits.Center_RA + 0.00001, sc.Fits.Center_DE + 0.00001, sc.Fits.Img_Width,
          sc.Fits.Img_Height, sc.Fits.Rotation);
      if (uppercase(setfov) = 'ON') then sc.cfgsc.fov := 1.25 * sc.Fits.Img_Width;
      sc.cfgsc.TrackOn := True;
      sc.cfgsc.TrackType := TTimage;
      Result := msgOK;
    end
    else
    begin
      sc.cfgsc.ShowBackgroundImage := False;
      Result := msgFailed;
    end;
  end
  else
    Result := msgOK;
  Refresh(True, False);
end;

function Tf_Chart.cmd_LoadBGimage(fn,track: string): string;
begin
  sc.cfgsc.BackgroundImage := fn;
  sc.Fits.Filename := sc.cfgsc.BackgroundImage;
  sc.Fits.InfoWCScoord;
  if sc.Fits.Header.valid then
  begin
    sc.Fits.DeleteDB('OTHER', 'BKG');
    if not sc.Fits.InsertDB(sc.cfgsc.BackgroundImage, 'OTHER', 'BKG',
      sc.Fits.Center_RA, sc.Fits.Center_DE, sc.Fits.Img_Width, sc.Fits.Img_Height,
      sc.Fits.Rotation) then
      sc.Fits.InsertDB(sc.cfgsc.BackgroundImage, 'OTHER', 'BKG',
        sc.Fits.Center_RA + 0.00001, sc.Fits.Center_DE + 0.00001, sc.Fits.Img_Width,
        sc.Fits.Img_Height, sc.Fits.Rotation);
    if (uppercase(track) = 'ON') then begin
      sc.cfgsc.fov := 1.25 * sc.Fits.Img_Width;
      sc.cfgsc.TrackOn := True;
      sc.cfgsc.TrackType := TTimage;
    end;
    Result := msgOK;
  end
  else
    Result := msgFailed;
end;

procedure Tf_Chart.ActivateImageCatalog;
var i,j: integer;
    catlst: TStringList;
    cat: string;
begin
   catlst:=TStringList.Create;
   sc.Fits.GetImagesCatalog(catlst);
   for i:=0 to catlst.Count-1 do begin
     cat:=uppercase(catlst[i]);
     if cat='ONGC' then begin
       sc.catalog.cfgcat.NebCatDef[ngc - BaseNeb]:=True;
     end
     else begin
       for j:=0 to sc.catalog.cfgcat.GCatNum-1 do begin
         if cat=uppercase(sc.catalog.cfgcat.GCatLst[j].shortname) then begin
           sc.catalog.cfgcat.GCatLst[j].Actif:=True;
         end;
       end;
     end;
   end;
   catlst.free;
end;

function Tf_Chart.cmd_SetShowPicture(onoff: string): string;
begin
  Result := msgOK;
  sc.cfgsc.ShowImages := (uppercase(onoff) = 'ON');
  if sc.cfgsc.ShowImages and (not sc.Fits.dbconnected) then
  begin
    sc.cfgsc.ShowImages := False;
    WriteTrace(rsErrorPleaseC3);
    Result := msgFailed;
  end;
  if sc.cfgsc.ShowImages then ActivateImageCatalog;
  Refresh(True, False);
end;

function Tf_Chart.cmd_SetGridEQ(onoff: string): string;
begin
  sc.cfgsc.ShowEqGrid := (uppercase(onoff) = 'ON');
  Result := msgOK;
end;

function Tf_Chart.cmd_GetGridEQ: string;
begin
  if sc.cfgsc.ShowEqGrid then
    Result := msgOK + ' ON'
  else
    Result := msgOK + ' OFF';
end;

function Tf_Chart.cmd_SetGrid(onoff: string): string;
begin
  sc.cfgsc.ShowGrid := (uppercase(onoff) = 'ON');
  Result := msgOK;
end;

function Tf_Chart.cmd_GetGrid: string;
begin
  if sc.cfgsc.ShowGrid then
    Result := msgOK + ' ON'
  else
    Result := msgOK + ' OFF';
end;

function Tf_Chart.cmd_SetGridNum(onoff: string): string;
begin
  sc.cfgsc.ShowGridNum := (uppercase(onoff) = 'ON');
  Result := msgOK;
end;

function Tf_Chart.cmd_SetConstL(onoff: string): string;
begin
  sc.cfgsc.ShowConstl := (uppercase(onoff) = 'ON');
  Result := msgOK;
end;

function Tf_Chart.cmd_SetConstB(onoff: string): string;
begin
  sc.cfgsc.ShowConstB := (uppercase(onoff) = 'ON');
  Result := msgOK;
end;

function Tf_Chart.cmd_SwitchGridNum: string;
begin
  sc.cfgsc.ShowGridNum := not sc.cfgsc.ShowGridNum;
  Result := msgOK;
end;

function Tf_Chart.cmd_SwitchConstL: string;
begin
  sc.cfgsc.ShowConstl := not sc.cfgsc.ShowConstl;
  Result := msgOK;
end;

function Tf_Chart.cmd_SwitchConstB: string;
begin
  sc.cfgsc.ShowConstB := not sc.cfgsc.ShowConstB;
  Result := msgOK;
end;

function Tf_chart.cmd_SetStarMode(i: integer): string;
begin
  if (i >= 0) and (i <= 2) then
  begin
    sc.plot.cfgplot.starplot := i;
    Result := msgOK;
  end
  else
    Result := msgFailed + ' Bad star mode.';
end;

function Tf_chart.cmd_GetStarMode: string;
begin
  Result := msgOK + blank + IntToStr(sc.plot.cfgplot.starplot);
end;

function Tf_chart.cmd_SetNebMode(i: integer): string;
begin
  if (i >= 0) and (i <= 1) then
  begin
    sc.plot.cfgplot.nebplot := i;
    Result := msgOK;
  end
  else
    Result := msgFailed + ' Bad nebula mode.';
end;

function Tf_chart.cmd_GetNebMode: string;
begin
  Result := msgOK + blank + IntToStr(sc.plot.cfgplot.nebplot);
end;

function Tf_chart.cmd_SetSkyMode(onoff: string): string;
begin
  sc.plot.cfgplot.autoskycolor := (uppercase(onoff) = 'ON');
  Result := msgOK;
end;

function Tf_chart.cmd_GetSkyMode: string;
begin
  if sc.plot.cfgplot.autoskycolor then
    Result := msgOK + ' ON'
  else
    Result := msgOK + ' OFF';

end;

function Tf_chart.cmd_SetProjection(proj: string): string;
begin
  Result := msgOK;
  proj := uppercase(proj);
  if proj = 'ALTAZ' then
    sc.cfgsc.projpole := altaz
  else if proj = 'EQUAT' then
    sc.cfgsc.projpole := equat
  else if proj = 'GALACTIC' then
    sc.cfgsc.projpole := gal
  else if proj = 'ECLIPTIC' then
    sc.cfgsc.projpole := ecl
  else
    Result := msgFailed + ' Bad projection name.';
  sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
  sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
  sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
  sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
  sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
  sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
  sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
  sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
  sc.cfgsc.FindOk := False;
  if (sc.cfgsc.projpole = altaz) and (sc.cfgsc.EquinoxType <> 2) then
  begin // ensure equinox of the date for alt/az
    sc.cfgsc.EquinoxType := 2;
    sc.cfgsc.EquinoxChart := rsDate;
    sc.cfgsc.DefaultJDChart := jd2000;
    sc.cfgsc.CoordExpertMode := False;
    sc.cfgsc.ApparentPos := True;
    sc.cfgsc.PMon := True;
    sc.cfgsc.YPmon := 0;
    sc.cfgsc.CoordType := 0;
  end;
end;

function Tf_chart.cmd_GetProjection: string;
begin
  case sc.cfgsc.projpole of
    equat: Result := 'EQUAT';
    altaz: Result := 'ALTAZ';
    gal: Result := 'GALACTIC';
    ecl: Result := 'ECLIPTIC';
    else
      Result := '';
  end;
  Result := msgOK + blank + Result;
end;

function Tf_chart.cmd_SetFov(fov: string): string;
var
  f: double;
  p: integer;
begin
  Result := msgFailed + ' Bad format!';
  try
    fov := StringReplace(fov, 'FOV:', '', [rfIgnoreCase]);
    fov := trim(fov);
    p := pos('d', fov);
    if p = 0 then
      p := pos(#176, fov); // °
    if p > 0 then
    begin
      f := strtofloat(copy(fov, 1, p - 1));
      fov := copy(fov, p + 1, 999);
      p := pos('m', fov);
      if p = 0 then
        p := pos('''', fov);
      f := f + strtofloat(copy(fov, 1, p - 1)) / 60;
      fov := copy(fov, p + 1, 999);
      p := pos('s', fov);
      if p = 0 then
        p := pos('"', fov);
      if p = 0 then
        p := 99;
      f := f + strtofloat(copy(fov, 1, p - 1)) / 3600;
    end
    else
    begin
      f := strtofloat(fov);
    end;
    Result := msgOK;
    if (f > 0.0006) and (f <= 360) then
      sc.setfov(deg2rad * f)
    else
      Result := msgFailed + ' FOV out of range';
  except
    exit;
  end;
end;

function Tf_chart.cmd_GetFov(format: string): string;
begin
  if format = 'F' then
  begin
    Result := msgOK + blank + formatfloat(f5, rad2deg * sc.cfgsc.fov);
  end
  else
  begin
    Result := msgOK + blank + detostr3(rad2deg * sc.cfgsc.fov);
  end;
end;

function Tf_chart.cmd_Resize(w, h: string): string;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' cmd_Resize');
  Width := StrToIntDef(w, Width);
  Height := StrToIntDef(h, Height);
  refresh(True, False);
  Result := msgOK;
end;

function Tf_chart.cmd_GetChartEqsys: string;
begin
  if ServerCoordSystem=csJ2000 then
     result:='2000'
  else if sc.cfgsc.EquinoxChart=rsDate then
     result:='Date'
  else
     result:=stringreplace(stringreplace(sc.cfgsc.EquinoxChart, 'J', '', []), 'B', '', []);
end;

function Tf_chart.cmd_SetChartEquinox(equinox: string): string;
begin
  equinox:=UpperCase(trim(equinox));
  if equinox='DATE' then
    sc.cfgsc.EquinoxChart:=rsDate
  else begin
    if sc.cfgsc.ProjPole=Equat then begin //Equat
      if equinox='J2000' then begin
        sc.cfgsc.CoordType := 2;
        sc.cfgsc.EquinoxType := 0;
        sc.cfgsc.ApparentPos := False;
        sc.cfgsc.PMon := True;
        sc.cfgsc.YPmon := 2000;
        sc.cfgsc.EquinoxChart := 'J2000';
        sc.cfgsc.DefaultJDChart := jd2000;
        result:=msgOK;
      end
      else
        result:=msgFailed+' parameter must be DATE or 2000.0';
    end
    else
      result:=msgFailed+' cannot change equinox for this projection';
  end;
end;

function Tf_chart.cmd_SetFieldnumber(field: string): string;
var f:integer;
begin
  f:=StrToIntDef(field,999)-1;
  if (f>=0)and(f<=MaxField) then begin
    SetField(deg2rad * sc.catalog.cfgshr.FieldNum[f], (f > 1), false);
    result:=msgOK;
  end
  else
    result:=msgFailed+' wrong parameter';
end;

function Tf_chart.cmd_SetRa(param1: string; strict:boolean=false): string;
var
  buf: string;
  p: integer;
  ar,de: double;
begin
  Result := msgFailed + ' Bad coordinates format!';
  try
    p := pos('RA:', param1);
    if p > 0 then
      buf := copy(param1, p + 3, 999)
    else
      if strict then
        exit
      else
        buf := trim(param1);
    p := pos('h', buf);
    if p > 0 then
    begin
      ar := strtofloat(copy(buf, 1, p - 1));
      buf := copy(buf, p + 1, 999);
      p := pos('m', buf);
      ar := ar + strtofloat(copy(buf, 1, p - 1)) / 60;
      buf := copy(buf, p + 1, 999);
      p := pos('s', buf);
      ar := ar + strtofloat(copy(buf, 1, p - 1)) / 3600;
    end
    else
    begin
      ar := strtofloat(buf);
    end;
    Result := msgOK;
    sc.cfgsc.TrackOn := False;
    if (ar >= 0) and (ar < 24) then begin
      if ServerCoordSystem=csJ2000 then begin
        de:=sc.cfgsc.decentre2000;
        ar:=deg2rad*ar*15;
        sc.cfgsc.racentre2000:=ar;
        Precession(jd2000,sc.cfgsc.JDChart,ar,de);
        sc.cfgsc.racentre := rmod(ar + pi2, pi2);
        sc.cfgsc.decentre := de;
      end
      else
        sc.cfgsc.racentre := rmod(deg2rad * ar * 15 + pi2, pi2)
    end
    else
      Result := msgFailed + ' RA out of range';
  except
    exit;
  end;
end;

function Tf_chart.cmd_SetDec(param1: string; strict:boolean=false): string;
var
  buf: string;
  p: integer;
  s, ar, de: double;
begin
  Result := msgFailed + ' Bad coordinates format!';
  try
    p := pos('DEC:', param1);
    if p > 0 then
      buf := trim(copy(param1, p + 4, 999))
    else
      if strict then
        exit
      else
        buf := trim(param1);
    p := pos('d', buf);
    if p = 0 then
      p := pos(#176, buf); // °
    if p > 0 then
    begin
      if buf[1] = '-' then
        s := -1
      else
        s := 1;
      de := strtofloat(copy(buf, 1, p - 1));
      buf := copy(buf, p + 1, 999);
      p := pos('m', buf);
      if p = 0 then
        p := pos('''', buf);
      de := de + s * strtofloat(copy(buf, 1, p - 1)) / 60;
      buf := copy(buf, p + 1, 999);
      p := pos('s', buf);
      if p = 0 then
        p := pos('"', buf);
      if p = 0 then
        p := 99;
      de := de + s * strtofloat(copy(buf, 1, p - 1)) / 3600;
    end
    else
    begin
      de := strtofloat(buf);
    end;
    Result := msgOK;
    sc.cfgsc.TrackOn := False;
    if (de >= -90) and (de <= 90) then begin
      if ServerCoordSystem=csJ2000 then begin
        ar:=sc.cfgsc.racentre2000;
        de:=deg2rad*de;
        sc.cfgsc.decentre2000:=de;
        Precession(jd2000,sc.cfgsc.JDChart,ar,de);
        sc.cfgsc.decentre := de;
        sc.cfgsc.racentre := rmod(ar + pi2, pi2);
      end
      else
        sc.cfgsc.decentre := deg2rad * de
    end
    else
      Result := msgFailed + ' DEC out of range';
  except
    exit;
  end;
end;

function Tf_chart.cmd_GetRA(format: string): string;
var ra: double;
begin
  if ServerCoordSystem=csJ2000 then
     ra:=sc.cfgsc.racentre2000
  else
     ra:=sc.cfgsc.racentre;
  if format = 'F' then
  begin
    Result := msgOK + blank + formatfloat(f5, rad2deg * ra / 15);
  end
  else
  begin
    Result := msgOK + blank + artostr3(rad2deg * ra / 15);
  end;
end;

function Tf_chart.cmd_GetDEC(format: string): string;
var de: double;
begin
  if ServerCoordSystem=csJ2000 then
     de:=sc.cfgsc.decentre2000
  else
     de:=sc.cfgsc.decentre;
  if format = 'F' then
  begin
    Result := msgOK + blank + formatfloat(f5, rad2deg * de);
  end
  else
  begin
    Result := msgOK + blank + detostr3(rad2deg * de);
  end;
end;

function Tf_chart.cmd_SetDate(dt: string): string;
var
  p, sy, y, m, d, h, n, s: integer;
begin
  Result := msgFailed + ' Bad date format!';
  try
    sy := 1;
    dt := trim(dt);
    if length(dt) > 2 then
    begin
      if dt[1] = '-' then
      begin
        sy := -1;
        Delete(dt, 1, 1);
      end;
      if dt[1] = '+' then
      begin
        sy := 1;
        Delete(dt, 1, 1);
      end;
    end;
    p := pos('-', dt);
    if p = 0 then
      exit;
    y := sy * StrToInt(trim(copy(dt, 1, p - 1)));
    dt := copy(dt, p + 1, 999);
    p := pos('-', dt);
    if p = 0 then
      exit;
    m := StrToInt(trim(copy(dt, 1, p - 1)));
    dt := copy(dt, p + 1, 999);
    p := pos('T', dt);
    if p = 0 then
      p := pos(' ', dt);
    if p = 0 then
      exit;
    d := StrToInt(trim(copy(dt, 1, p - 1)));
    dt := copy(dt, p + 1, 999);
    p := pos(':', dt);
    if p = 0 then
      exit;
    h := StrToInt(trim(copy(dt, 1, p - 1)));
    dt := copy(dt, p + 1, 999);
    p := pos(':', dt);
    if p = 0 then
      exit;
    n := StrToInt(trim(copy(dt, 1, p - 1)));
    dt := copy(dt, p + 1, 999);
    s := StrToInt(trim(dt));
    sc.cfgsc.UseSystemTime := False;
    Result := msgOK;
    if (y >= -200000) and (y <= 200000) then
      sc.cfgsc.CurYear := y
    else
      Result := msgFailed + ' Year out of range';
    if (m >= 1) and (m <= 12) then
      sc.cfgsc.CurMonth := m
    else
      Result := msgFailed + ' Month out of range';
    if (d >= 1) and (d <= 31) then
      sc.cfgsc.CurDay := d
    else
      Result := msgFailed + ' Day out of range';
    if (h >= 0) and (h <= 23) and (n >= 0) and (n <= 59) and (s >= 0) and (s <= 59) then
      sc.cfgsc.CurTime := h + n / 60 + s / 3600
    else
      Result := msgFailed + ' Time out of range';
    sc.cfgsc.tz.JD := jd(sc.cfgsc.CurYear, sc.cfgsc.CurMonth, sc.cfgsc.CurDay, sc.cfgsc.CurTime);
    sc.cfgsc.TimeZone := sc.cfgsc.tz.SecondsOffset / 3600;
    if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
    begin
      sc.cfgsc.TrackOn := True;
      sc.cfgsc.TrackType := TTaltaz;
    end;
  except
    exit;
  end;
end;

function Tf_chart.cmd_GetDate: string;
begin
  Result := msgOK + blank + Date2Str(sc.cfgsc.CurYear, sc.cfgsc.curmonth, sc.cfgsc.curday, False) +
    'T' + TimToStr(sc.cfgsc.Curtime);
end;

function Tf_chart.cmd_MoveScope(RA, DE: string): string;
var
  r, d: double;
begin
  r := StrToFloatDef(RA, 9999) * 15;
  d := StrToFloatDef(DE, 9999);
  if (abs(r) <= 360) and (abs(d) <= 90) then
  begin
    d := deg2rad * d;
    r := deg2rad * r;
    sc.cfgsc.scopelock := False;
    if sc.Telescope2Move(r, d) then
      Refresh(True, True);
    Result := msgOK;
  end
  else
    Result := msgFailed + ' out of range';
end;

function Tf_chart.cmd_MoveScopeH(H, D: string): string;
var
  hh, dd, ra, de: double;
begin
  hh := StrToFloatDef(H, 9999) * 15;
  dd := StrToFloatDef(D, 9999);
  if (abs(hh) <= 180) and (abs(dd) <= 90) then
  begin
    de := deg2rad * dd;
    ra := sc.cfgsc.CurST - deg2rad * hh;
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTequat;
    sc.cfgsc.TrackName := rsTelescope + '-2';
    sc.cfgsc.scopelock := False;
    if sc.Telescope2Move(ra, de) then
      Refresh(True, True);
    Result := msgOK;
  end
  else
    Result := msgFailed + ' out of range';
end;

function Tf_chart.cmd_TrackTelescope(onoff: string): string;
begin
  if onoff = 'ON' then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTequat;
    if Connect1.Checked then
    begin
      sc.cfgsc.TrackName := rsTelescope;
      sc.cfgsc.TrackRA := sc.cfgsc.ScopeRa;
      sc.cfgsc.TrackDec := sc.cfgsc.ScopeDec;
      sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
      sc.cfgsc.scopemark := True;
      sc.MovetoRaDec(sc.cfgsc.ScopeRa, sc.cfgsc.ScopeDec);
    end
    else
    begin
      sc.cfgsc.TrackName := rsTelescope + '-2';
      sc.cfgsc.TrackRA := sc.cfgsc.Scope2Ra;
      sc.cfgsc.TrackDec := sc.cfgsc.Scope2Dec;
      sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
      sc.cfgsc.scope2mark := True;
      sc.MovetoRaDec(sc.cfgsc.Scope2Ra, sc.cfgsc.Scope2Dec);
    end;
    Refresh(True, True);
  end
  else
  begin
    sc.cfgsc.TrackOn := False;
    Refresh(True, True);
  end;
  Result := msgOK;
end;

function Tf_chart.cmd_GetScopeRaDec(format: string): string;

var
  ra, Dec: double;
  ok: boolean;
begin
  ok := False;
  Connect1.Checked := Fpop_scope.ScopeConnected;
  if Connect1.Checked then
  begin
    Fpop_scope.ScopeGetEqSys(sc.cfgsc.TelescopeJD);
    if sc.cfgsc.TelescopeJD <> 0 then
      sc.cfgsc.TelescopeJD := jd(trunc(sc.cfgsc.TelescopeJD), 0, 0, 0);
    Fpop_scope.ScopeGetRaDec(ra, Dec, ok);
  end;
  if ok then begin
    if format = 'F' then
      Result := msgOK + blank + formatfloat(f5, ra) + blank + formatfloat(f5, Dec)
    else
      Result := msgOK + blank + artostr3(ra) + blank + detostr3(Dec);
  end
  else
    Result := msgFailed;
end;

procedure Tf_chart.GetScopeRates(rates: TStringList);
var n0: integer;
begin
  rates.Clear;
  if Connect1.Checked then
  begin
    Fpop_scope.GetScopeRates(n0, rates);
  end;
end;

function Tf_chart.cmd_GetScopeRates: string;
var
  i, n0, n1: integer;
  ax0r, ax1r: array of double;
  srate: TStringList;
begin
  Result := msgFailed;
  if Connect1.Checked then
  begin
    n0 := 0;
    srate := TStringList.Create;
    Fpop_scope.GetScopeRates(n0, srate);
    if n0 > 0 then
    begin
      Result := msgOK + tab + IntToStr(n0) + tab;
      Result := Result + '0' + tab;
      for i := 0 to n0 - 1 do
        Result := Result + srate[i] + tab;
    end
    else
      Result := msgFailed;
  end;
end;

function Tf_chart.cmd_ScopeMoveAxis(axis, rate: string): string;
var
  ax, n: integer;
  rt: double;
begin
  Result := msgFailed;
  if Connect1.Checked then
  begin
    val(axis, ax, n);
    if n <> 0 then
      exit;
    Fpop_scope.ScopeMoveAxis(ax, rate);
    Result := msgOK;
  end;
end;

function Tf_chart.cmd_SetScopeRefreshRate(rate: string): string;
var
  rt, n: integer;
begin
  Result := msgFailed;
  if Connect1.Checked then
  begin
    val(rate, rt, n);
    if n <> 0 then
      exit;
    Fpop_scope.SetRefreshRate(rt);
    Result := msgOK;
  end;
end;

function Tf_chart.cmd_ConnectINDI: string;
begin
  Result := cmd_ConnectTelescope;
end;

function Tf_chart.cmd_ConnectTelescope: string;
begin
  Result := msgFailed;
  Fshowinfo(rsConnectTeles);
  ConnectTelescope(self, True);
  Result := msgOK
end;

function Tf_chart.cmd_DisconnectINDI: string;
begin
  Result := cmd_DisconnectTelescope;
end;

function Tf_chart.cmd_DisconnectTelescope: string;
var
  ok: boolean;
begin
  Result := msgFailed;
  if (not Connect1.Checked) or (Fpop_scope = nil) then
    exit;
  Fpop_scope.ScopeDisconnect(ok);
  Connect1.Checked := False;
  if ok then
    Result := msgOK;
end;

function Tf_chart.cmd_SyncINDI(RA2, DE2: string): string;
begin
  Result := cmd_Sync(RA2, DE2);
end;

function Tf_chart.cmd_Sync(RA2, DE2: string): string;
var
  ra, Dec: double;
begin
  Result := msgFailed;
  ra := StrToFloatDef(RA2, 9999);
  Dec := StrToFloatDef(DE2, 9999);
  if (ra >= 0) and (ra <= 24) and (abs(Dec) <= 90) then
  begin
    ra := ra * 15 * deg2rad;
    Dec := Dec * deg2rad;
    if sc.cfgsc.TelescopeJD = 0 then
    begin
      precession(sc.cfgsc.JDChart, sc.cfgsc.CurJDUT, ra, Dec);
    end
    else
    begin
      if sc.cfgsc.ApparentPos then
        mean_equatorial(ra, Dec, sc.cfgsc, True, sc.cfgsc.FindType < ftPla);
      precession(sc.cfgsc.JDChart, sc.cfgsc.TelescopeJD, ra, Dec);
    end;
    ra := rmod(ra + pi2, pi2);
    if Connect1.Checked then
    begin
      Fpop_scope.ScopeAlign('sync', ra * rad2deg / 15, Dec * rad2deg);
      Result := msgOK;
    end;
  end;
end;

function Tf_chart.cmd_SlewINDI(RA1, DE1: string): string;
begin
  Result := cmd_Slew(RA1, DE1);
end;

function Tf_chart.cmd_Slew(RA1, DE1: string): string;
var
  ra, Dec: double;
  ok: boolean;
begin
  Result := msgFailed;
  if Connect1.Checked then
  begin
    if (RA1 = '') and (DE1 = '') then
    begin
      SlewTelescope(self);
      Result := msgOK;
    end
    else
    begin
      ra := StrToFloatDef(RA1, 9999);
      Dec := StrToFloatDef(DE1, 9999);
      if (ra >= 0) and (ra <= 24) and (abs(Dec) <= 90) then
      begin
        ra := ra * 15 * deg2rad;
        Dec := Dec * deg2rad;
        if sc.cfgsc.TelescopeJD = 0 then
        begin
          precession(sc.cfgsc.JDChart, sc.cfgsc.CurJDUT, ra, Dec);
        end
        else
        begin
          if sc.cfgsc.ApparentPos then
            mean_equatorial(ra, Dec, sc.cfgsc, True, sc.cfgsc.FindType < ftPla);
          precession(sc.cfgsc.JDChart, sc.cfgsc.TelescopeJD, ra, Dec);
        end;
        ra := rmod(ra + pi2, pi2);
        Fpop_scope.ScopeGoto(ra * rad2deg / 15, Dec * rad2deg, ok);
        Result := msgOK;
      end
      else
        Result := msgFailed + ' out of range';
    end;
  end;
end;


function Tf_chart.cmd_AbortSlewINDI: string;
begin
  Result := cmd_AbortSlew;
end;

function Tf_chart.cmd_AbortSlew: string;
begin
  Result := msgFailed;
  if Connect1.Checked then
  begin
    AbortSlewTelescope(self);
    Result := msgOK;
  end;
end;

function Tf_chart.cmd_GetScopeSlewing: string;
begin
  Result := msgFailed;
  if Connect1.Checked then
  begin
    result:=BoolToStr(Fpop_scope.Slewing,msgTrue,msgFalse);
  end;
end;

function Tf_chart.cmd_SetObs(obs: string): string;
var
  n, buf: string;
  p, tz: integer;
  s, la, lo, al: double;
begin
  Result := msgFailed + ' Bad observatory format!';
  try
    p := pos('LAT:', obs);
    if p = 0 then
      exit;
    buf := copy(obs, p + 4, 999);
    p := pos('d', buf);
    la := strtofloat(copy(buf, 1, p - 1));
    s := sgn(la);
    buf := copy(buf, p + 1, 999);
    p := pos('m', buf);
    la := la + s * strtofloat(copy(buf, 1, p - 1)) / 60;
    buf := copy(buf, p + 1, 999);
    p := pos('s', buf);
    la := la + s * strtofloat(copy(buf, 1, p - 1)) / 3600;
    p := pos('LON:', obs);
    if p = 0 then
      exit;
    buf := copy(obs, p + 4, 999);
    p := pos('d', buf);
    lo := strtofloat(copy(buf, 1, p - 1));
    s := sgn(lo);
    buf := copy(buf, p + 1, 999);
    p := pos('m', buf);
    lo := lo + s * strtofloat(copy(buf, 1, p - 1)) / 60;
    buf := copy(buf, p + 1, 999);
    p := pos('s', buf);
    lo := lo + s * strtofloat(copy(buf, 1, p - 1)) / 3600;
    p := pos('ALT:', obs);
    if p = 0 then
      exit;
    buf := copy(obs, p + 4, 999);
    p := pos('m', buf);
    al := strtofloat(copy(buf, 1, p - 1));
    p := pos('TZ:', obs);
    if p > 0 then
    begin
      buf := copy(obs, p + 3, 999);
      p := pos('h', buf);
      buf := copy(buf, 1, p - 1);
      tz := -StrToInt(buf);
      buf := trim(IntToStr(tz));
      if tz > 0 then
        buf := '+' + buf;
      cmd_SetTZ('Etc/GMT' + buf);
      sc.cfgsc.countrytz := False;
    end;
    p := pos('OBS:', obs);
    if p = 0 then
      n := 'obs?'
    else
      n := trim(copy(obs, p + 4, 999));
    Result := msgOK;
    if (la >= -90) and (la <= 90) then
      sc.cfgsc.ObsLatitude := la
    else
      Result := msgFailed + ' Latitude out of range';
    if (lo >= -180) and (lo <= 180) then
      sc.cfgsc.ObsLongitude := lo
    else
      Result := msgFailed + ' Longitude out of range';
    if (al >= -500) and (al <= 15000) then
      sc.cfgsc.ObsAltitude := al
    else
      Result := msgFailed + ' Altitude out of range';
    p := pos('/', n);
    if p > 0 then
    begin
      sc.cfgsc.Obscountry := trim(copy(n, 1, p - 1));
      Delete(n, 1, p);
    end
    else
      sc.cfgsc.Obscountry := '';
    sc.cfgsc.ObsName := n;
    sc.cfgsc.tz.Longitude:=sc.cfgsc.ObsLongitude;
  except
    exit;
  end;
end;

function Tf_chart.cmd_GetObs: string;
begin
  Result := msgOK + blank + 'LAT:' + detostr3(sc.cfgsc.ObsLatitude) + 'LON:' +
    detostr3(sc.cfgsc.ObsLongitude) + 'ALT:' + formatfloat(f0, sc.cfgsc.ObsAltitude);
  if trim(sc.cfgsc.Obscountry) = '' then
    Result := Result + 'mOBS:' + sc.cfgsc.ObsName
  else
    Result := Result + 'mOBS:' + sc.cfgsc.Obscountry + '/' + sc.cfgsc.ObsName;
end;

function Tf_chart.cmd_SetTZ(tz: string): string;
var
  buf: string;
begin
  try
    if copy(tz, 1, 3) = 'UTC' then
    begin
      tz := TzUTC2GMT(tz);
      sc.cfgsc.countrytz := False;
    end
    else
    begin
      if copy(tz, 1, 7) <> 'Etc/GMT' then
        sc.cfgsc.countrytz := True;
    end;
    buf := ZoneDir + StringReplace(tz, '/', PathDelim, [rfReplaceAll]);
    if FileExists(buf) then
    begin
      sc.cfgsc.ObsTZ := tz;
      sc.cfgsc.tz.TimeZoneFile := buf;
      sc.cfgsc.TimeZone := sc.cfgsc.tz.SecondsOffset / 3600;
      Result := msgOK;
    end
    else
      Result := msgFailed + ' invalid timezone: ' + tz;
  except
    Result := msgFailed;
  end;
end;

function Tf_chart.cmd_GetTZ: string;
begin
  Result := msgOK + blank + TzGMT2UTC(sc.cfgsc.ObsTZ);
end;

function Tf_chart.cmd_ObslistLoad(fn: string): string;
begin
  if (fn <> '') and (FileExists(fn)) then
  begin
    f_obslist.FileNameEdit1.FileName := SysToUTF8(fn);
    f_obslist.LoadObsList;
    Result := msgOK;
  end
  else
    Result := msgFailed;
end;

function Tf_chart.cmd_ObslistFirst: string;
begin
  Result := msgFailed;
  if f_obslist.ObjLabels.Count > 0 then
  begin
    if f_obslist.FirstObj then
      Result := msgOK + blank + f_obslist.StringGrid1.Cells[1, f_obslist.StringGrid1.Row];
  end;
end;

function Tf_chart.cmd_ObslistLast: string;
begin
  Result := msgFailed;
  if f_obslist.ObjLabels.Count > 0 then
  begin
    if f_obslist.LastObj then
      Result := msgOK + blank + f_obslist.StringGrid1.Cells[1, f_obslist.StringGrid1.Row];
  end;
end;

function Tf_chart.cmd_ObslistNext: string;
begin
  Result := msgFailed;
  if f_obslist.ObjLabels.Count > 0 then
  begin
    if f_obslist.NextObj then
      Result := msgOK + blank + f_obslist.StringGrid1.Cells[1, f_obslist.StringGrid1.Row];
  end;
end;

function Tf_chart.cmd_ObslistPrev: string;
begin
  Result := msgFailed;
  if f_obslist.ObjLabels.Count > 0 then
  begin
    if f_obslist.PrevObj then
      Result := msgOK + blank + f_obslist.StringGrid1.Cells[1, f_obslist.StringGrid1.Row];
  end;
end;

function Tf_chart.cmd_ObslistLimit(onoff: string): string;
var
  ok: boolean;
begin
  ok := (onoff = 'ON');
  if f_obslist.LimitType = 0 then
  begin
    f_obslist.LimitAirmassTonight.Checked := False;
    f_obslist.LimitAirmassNow.Checked := ok;
  end
  else
  begin
    f_obslist.LimitHourangleTonight.Checked := False;
    f_obslist.LimitHourangleNow.Checked := ok;
  end;
  f_obslist.Refresh;
  Result := msgOK;
end;

function Tf_chart.cmd_ObslistAirmassLimit(airmass: string): string;
begin
  f_obslist.AirmassCombo.Text := airmass;
  f_obslist.LimitType := 0;
  Result := msgOK;
end;

function Tf_chart.cmd_ObslistTransitLimit(transit: string): string;
begin
  f_obslist.HourAngleCombo.Text := transit;
  f_obslist.LimitType := 1;
  Result := msgOK;
end;

function Tf_chart.cmd_ObslistTransitSide(side: string): string;
var
  i: integer;
begin
  if side = 'EAST' then
    i := 0
  else if side = 'BOTH' then
    i := 1
  else if side = 'WEST' then
    i := 2
  else
    i := -1;
  if i > 0 then
  begin
    f_obslist.MeridianSide := i;
    Result := msgOK;
  end
  else
    Result := msgFailed;
end;

procedure Tf_chart.chart_imglistExecute(Sender: TObject);
var
  i: integer;
begin
  if f_imglist = nil then
  begin
    f_imglist := Tf_imglist.Create(self);
    f_imglist.Fits := sc.Fits;
    f_imglist.onSendImageFits := FSendImageFits;
  end;
  f_imglist.CheckListBox1.Clear;
  for i := 0 to sc.Fits.fitslist.Count - 1 do
  begin
    f_imglist.CheckListBox1.Items.Add(systoutf8(sc.Fits.fitslist[i]));
    f_imglist.CheckListBox1.Checked[i] := sc.Fits.fitslistactive[i];
  end;
  f_imglist.ShowModal;
  if f_imglist.ModalResult = mrOk then
  begin
    sc.bgsettingchange := True;
    for i := 0 to sc.Fits.fitslist.Count - 1 do
    begin
      sc.Fits.fitslistactive[i] := f_imglist.CheckListBox1.Checked[i];
    end;
    sc.Fits.fitslistmodified := True;
    Refresh(True, True);
  end
  else if f_imglist.ModalResult = mrYes then
  begin
    if assigned(FImageSetup) then
      FImageSetup(self);
  end;
end;

procedure Tf_chart.MenuCircleClick(Sender: TObject);
begin
  with Sender as TMenuItem do
  begin
    Checked := not Checked;
    sc.cfgsc.circleok[tag] := Checked;
  end;
  Refresh(True, False);
end;

procedure Tf_chart.MenuAddToObsListClick(Sender: TObject);
begin
  f_obslist.Add(sc.cfgsc.FindName, rad2deg * sc.cfgsc.FindRA2000, rad2deg *
    sc.cfgsc.FindDec2000);
end;

procedure Tf_chart.MenuCursorToObsListClick(Sender: TObject);
var
  a, d: double;
begin
  GetAdXy(Xcursor, Ycursor, a, d, sc.cfgsc);
  CoordCharttoJ2000(a, d);
  f_obslist.Add(rsCursor, rad2deg * a, rad2deg * d);
end;

procedure Tf_chart.MenuTelescopeToObsListClick(Sender: TObject);
var
  a, d: double;
begin
  a := sc.cfgsc.ScopeRa;
  d := sc.cfgsc.ScopeDec;
  CoordCharttoJ2000(a, d);
  f_obslist.Add(rsTelescope, rad2deg * a, rad2deg * d);
end;

procedure Tf_chart.ResetalllabelClick(Sender: TObject);
begin
  sc.ResetAllLabel;
end;

procedure Tf_chart.MenuObslistFirstClick(Sender: TObject);
begin
  f_obslist.FirstObj;
end;

procedure Tf_chart.MenuObslistLastClick(Sender: TObject);
begin
  f_obslist.LastObj;
end;

procedure Tf_chart.MenuObslistNextClick(Sender: TObject);
begin
  f_obslist.NextObj;
end;

procedure Tf_chart.MenuObslistPrevClick(Sender: TObject);
begin
  f_obslist.PrevObj;
end;

procedure Tf_chart.MenuViewObsListClick(Sender: TObject);
begin
  f_obslist.cfgsc := sc.cfgsc;
  formpos(f_obslist, mouse.CursorPos.X, mouse.CursorPos.Y);
  f_obslist.Show;
end;

procedure Tf_chart.MenuRectangleClick(Sender: TObject);
begin
  with Sender as TMenuItem do
  begin
    Checked := not Checked;
    sc.cfgsc.rectangleok[tag] := Checked;
  end;
  Refresh(True, False);
end;

function Tf_chart.cmd_PDSS(DssDir, ImagePath, ImageName, useexisting: string): string;
var
  ra2000, de2000: double;
  archivefile, buf, fn: string;
  archiveit: boolean;
  i: integer;
  f1: TForm;
  e1: Tedit;
  l1, l2: TLabel;
  b1, b2: TButton;
begin
  f_getdss.cmain := cmain;
  ra2000 := sc.cfgsc.racentre;
  de2000 := sc.cfgsc.decentre;
  if sc.cfgsc.ApparentPos then
    mean_equatorial(ra2000, de2000, sc.cfgsc, True, True);
  precession(sc.cfgsc.JDchart, jd2000, ra2000, de2000);
  if f_getdss.GetDss(ra2000, de2000, sc.cfgsc.fov, sc.cfgsc.windowratio, image1.Width) then
  begin
    fn := expandfilename(f_getdss.cfgdss.dssfile);
    sc.Fits.Filename := fn;
    sc.Fits.InfoWCScoord;
    if sc.Fits.Header.valid and sc.Fits.WCSvalid then
    begin
      sc.Fits.DeleteDB('OTHER', 'BKG');
      if not sc.Fits.InsertDB(sc.Fits.Filename, 'OTHER', 'BKG',
        sc.Fits.Center_RA, sc.Fits.Center_DE, sc.Fits.Img_Width, sc.Fits.Img_Height,
        sc.Fits.Rotation) then
        sc.Fits.InsertDB(sc.Fits.Filename, 'OTHER', 'BKG',
          sc.Fits.Center_RA + 0.00001, sc.Fits.Center_DE + 0.00001, sc.Fits.Img_Width,
          sc.Fits.Img_Height, sc.Fits.Rotation);
      sc.cfgsc.fov := 1.25 * sc.Fits.Img_Width;
      sc.cfgsc.TrackOn := True;
      sc.cfgsc.TrackType := TTimage;
      sc.cfgsc.BackgroundImage := sc.Fits.Filename;
      sc.cfgsc.ShowBackgroundImage := True;
      if f_getdss.cfgdss.dssarchive then
      begin
        if f_getdss.cfgdss.OnlineDSS then
        begin
          buf := trim(f_getdss.cfgdss.DSSurl[f_getdss.cfgdss.OnlineDSSid, 0]);
          buf := StringReplace(buf, ' ', '_', [rfReplaceAll]);
          buf := StringReplace(buf, '/', '_', [rfReplaceAll]);
          buf := StringReplace(buf, '\', '_', [rfReplaceAll]);
          buf := StringReplace(buf, ';', '_', [rfReplaceAll]);
          buf := StringReplace(buf, ':', '_', [rfReplaceAll]);
          buf := StringReplace(buf, ',', '_', [rfReplaceAll]);
          buf := StringReplace(buf, '.', '_', [rfReplaceAll]);
          buf := StringReplace(buf, '(', '_', [rfReplaceAll]);
          buf := StringReplace(buf, ')', '_', [rfReplaceAll]);
          archivefile := buf;
        end
        else
          archivefile := archivefile + 'realsky';
        archivefile := archivefile + '_' + ARToStr3(rad2deg * ra2000 / 15) + DEToStr3(rad2deg * de2000);
        archiveit := True;
        if f_getdss.cfgdss.dssarchiveprompt then
        begin
          f1 := TForm.Create(self);
          e1 := Tedit.Create(f1);
          l1 := Tlabel.Create(f1);
          l2 := Tlabel.Create(f1);
          b1 := TButton.Create(f1);
          b2 := TButton.Create(f1);
          try
            l1.Parent := f1;
            l2.Parent := f1;
            e1.Parent := f1;
            b1.Parent := f1;
            b2.Parent := f1;
            l1.Top := 8;
            l1.Left := 8;
            l1.Caption := rsFilenameWith;
            e1.Top := l1.Top + l1.Height + 4;
            e1.Left := 8;
            e1.Width := 350;
            e1.Text := archivefile;
            l2.Top := e1.Top + e1.Height + 8;
            l2.Left := 8;
            l2.Caption := rsArchiveThisI;
            b1.Width := 65;
            b2.Width := 65;
            b1.Top := l2.Top + l2.Height + 8;
            b1.Left := 8;
            b2.Top := b1.Top;
            b2.Left := b1.Left + b2.Width + 8;
            b1.Caption := rsOK;
            b1.ModalResult := mrOk;
            b1.Default := True;
            b2.Caption := rsCancel;
            b2.ModalResult := mrCancel;
            b2.Cancel := True;
            f1.ClientWidth := max(e1.Width, l1.Width) + 16;
            f1.ClientHeight := b1.top + b1.Height + 8;
            f1.BorderStyle := bsDialog;
            f1.Caption := rsImageArchive;
            ScaleDPI(f1);
            formpos(f1, mouse.CursorPos.X, mouse.CursorPos.Y);
            if f1.ShowModal = mrOk then
            begin
              archiveit := True;
              archivefile := trim(e1.Text);
            end
            else
              archiveit := False;
          finally
            l1.Free;
            e1.Free;
            b1.Free;
            b2.Free;
            f1.Free;
          end;
        end;
        if archiveit then
        begin
          archivefile := slash(f_getdss.cfgdss.dssarchivedir) +
            ExtractFileNameOnly(archivefile);
          i := 0;
          buf := archivefile + '.fits';
          while FileExists(buf) do
          begin
            Inc(i);
            buf := archivefile + '_' + IntToStr(i) + '.fits';
          end;
          archivefile := buf;
          try
            CopyFile(systoutf8(fn), systoutf8(archivefile), False);
            sc.cdb.AddFitsArchiveFile(f_getdss.cfgdss.dssarchivedir,
              ExtractFileName(archivefile));
          except
            on E: Exception do
            begin
              WriteTrace('CopyFile error: ' + E.Message);
              if f_getdss.cfgdss.dssarchiveprompt then
                MessageDlg('CopyFile error: ' + E.Message, mtError, [mbClose], 0);
            end;
          end;
        end;
      end;
      Result := msgOK;
      sc.bgsettingchange := True;
      Refresh(True, False);
    end;
  end;
end;

function Tf_chart.cmd_GetObjectList: string;
var
  buf, msg: string;
begin
  sc.FindListWin(buf, msg, False, False);
  Result := buf;
end;

function Tf_chart.cmd_IdentCursor: string;
begin
  if identxy(xcursor, ycursor) then
    Result := msgOK
  else
    Result := msgFailed + ' No object found!';
end;

function Tf_chart.cmd_IdXY(xx, yy: string): string;
var
  x, y, p: integer;
  buf: string;
begin
  p := pos('X:', xx);
  if p = 0 then
    buf := xx
  else
    buf := copy(xx, p + 2, 999);
  x := StrToInt(trim(buf));
  p := pos('Y:', yy);
  if p = 0 then
    buf := yy
  else
    buf := copy(yy, p + 2, 999);
  y := StrToInt(trim(buf));
  if identxy(x, y) then
    Result := msgOK
  else
    Result := msgFailed + ' No object found!';
end;

function Tf_chart.cmd_IdentCenter: string;
begin
  if identxy(sc.cfgsc.Xcentre, sc.cfgsc.Ycentre, True, True) then
  begin
    if sc.cfgsc.FindOK then
      identlabelClick(self);
    Result := msgOK;
  end
  else
    Result := msgFailed + ' No object found!';
end;

function Tf_chart.cmd_IdentTelescope: string;
const
  limitmag = 4.5;
var
  x, y: integer;
  x1, y1, savemagmax: double;
  xx, yy: single;
  ok: boolean;
begin
  try
    if Connect1.Checked then
      projection(sc.cfgsc.ScopeRa, sc.cfgsc.ScopeDec, x1, y1, False, sc.cfgsc)
    else
      projection(sc.cfgsc.Scope2Ra, sc.cfgsc.Scope2Dec, x1, y1, False, sc.cfgsc);
    WindowXY(x1, y1, xx, yy, sc.cfgsc);
    x := round(xx);
    y := round(yy);
    if cmain.SimpleDetail then
    begin
      ok := identxy(x, y, True, False, ftPla, 10);
      if not ok then
        ok := identxy(x, y, True, False, ftNeb, 10);
      if not ok then
      begin
        savemagmax := sc.catalog.cfgshr.AutoStarFilterMag;
        try
          sc.catalog.cfgshr.AutoStarFilterMag := limitmag;
          ok := identxy(x, y, True, False, ftStar, 10);
        finally
          sc.catalog.cfgshr.AutoStarFilterMag := savemagmax;
        end;
        ok := ok and (sc.cfgsc.FindMag <= limitmag);
      end;
    end
    else
    begin
      ok := identxy(x, y, True, False, ftAll, 4);
    end;
    if ok then
    begin
      if sc.cfgsc.FindOK then
        identlabelClick(self);
      Result := msgOK;
    end
    else
    begin
      f_detail.Hide;
      Result := msgFailed + ' No object found!';
    end;
  except
    Result := msgFailed + ' Search failed!';
  end;
end;

procedure Tf_chart.cmd_GoXY(xx, yy: string);
var
  x, y, p: integer;
  buf: string;
begin
  p := pos('X:', xx);
  if p = 0 then
    buf := xx
  else
    buf := copy(xx, p + 2, 999);
  x := StrToInt(trim(buf));
  p := pos('Y:', yy);
  if p = 0 then
    buf := yy
  else
    buf := copy(yy, p + 2, 999);
  y := StrToInt(trim(buf));
  sc.MovetoXY(x, y);
end;

function Tf_chart.cmd_Print(Method, Orient, Col, path: string): string;
var
  PrintMethod, printcolor: integer;
  ok, printlandscape: boolean;
  PrintTmpPath: string;
begin
  ok := True;
  PrintMethod := 0;
  printlandscape := False;
  printcolor := 0;
  Method := UpperCase(Trim(Method));
  if Method = '' then
    PrintMethod := cmain.PrintMethod
  else if Method = 'PRT' then
    PrintMethod := 0
  else if Method = 'PS' then
    PrintMethod := 1
  else if Method = 'BMP' then
    PrintMethod := 2
  else
    ok := False;
  Orient := UpperCase(Trim(Orient));
  if Orient = '' then
    printlandscape := cmain.printlandscape
  else if Orient = 'PORTRAIT' then
    printlandscape := False
  else if Orient = 'LANDSCAPE' then
    printlandscape := True
  else
    ok := False;
  Col := UpperCase(Trim(Col));
  if Col = '' then
    printcolor := cmain.printcolor
  else if Col = 'COLOR' then
    printcolor := 0
  else if Col = 'BW' then
    printcolor := 1
  else
    ok := False;
  if path = '' then
    PrintTmpPath := cmain.PrintTmpPath
  else
    PrintTmpPath := path;
  if ok then
    PrintChart(printlandscape, printcolor, PrintMethod, cmain.PrinterResolution,
      cmain.PrintCmd1, cmain.PrintCmd2, PrintTmpPath, cmain, False);
  if ok then
    Result := msgOK
  else
    Result := msgFailed;
end;

function Tf_chart.cmd_getriseset: string;
begin
  if sc.cfgsc.FindName <> '' then
    Result := msgOK + blank + sc.cfgsc.FindName + blank + sc.cfgsc.FindDesc2
  else
    Result := msgFailed;
end;

function Tf_chart.cmd_SaveImage(format, fn, quality: string): string;
var
  i: integer;
begin
  i := strtointdef(quality, 95);
  if SaveChartImage(format, fn, i) then
    Result := msgOK
  else
    Result := msgFailed;
end;

procedure Tf_chart.cmd_MoreStar;
var i: integer;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' cmd_MoreStar');
  if sc.catalog.cfgshr.AutoStarFilter then
    sc.catalog.cfgshr.AutoStarFilterMag := min(16, sc.catalog.cfgshr.AutoStarFilterMag + 0.5)
  else
  begin
    if sc.catalog.cfgshr.StarMagFilter[10]<8 then
    for i:=1 to MaxField do begin
      sc.catalog.cfgshr.StarMagFilter[i] := sc.catalog.cfgshr.StarMagFilter[i] + 0.5;
    end;
  end;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  refresh(True, False);
end;

procedure Tf_chart.cmd_LessStar;
var i: integer;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' cmd_LessStar');
  if sc.catalog.cfgshr.AutoStarFilter then
    sc.catalog.cfgshr.AutoStarFilterMag := max(MagnitudeMin, sc.catalog.cfgshr.AutoStarFilterMag - 0.5)
  else
  begin
    if sc.catalog.cfgshr.StarMagFilter[10]>1 then
    for i:=1 to MaxField do begin
      sc.catalog.cfgshr.StarMagFilter[i] := sc.catalog.cfgshr.StarMagFilter[i] - 0.5;
    end;
  end;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  refresh(True, False);
end;

procedure Tf_chart.cmd_MoreNeb;
var i: integer;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' cmd_MoreNeb');
  if sc.catalog.cfgshr.NebMagFilter[10]<10 then
  for i:=1 to MaxField do begin
    sc.catalog.cfgshr.NebMagFilter[i] := sc.catalog.cfgshr.NebMagFilter[i] + 0.5;
    if (i<=3)and(sc.catalog.cfgshr.NebMagFilter[i] >= 20) then
      sc.catalog.cfgshr.NebMagFilter[i] := 99;
    sc.catalog.cfgshr.NebSizeFilter[i] := sc.catalog.cfgshr.NebSizeFilter[i] / 1.5;
    if i>3 then
      sc.catalog.cfgshr.NebSizeFilter[i]:=max(0.1,sc.catalog.cfgshr.NebSizeFilter[i])
    else if (sc.catalog.cfgshr.NebSizeFilter[i] < 0.1) then
      sc.catalog.cfgshr.NebSizeFilter[i] := 0;
  end;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  refresh(True, False);
end;

procedure Tf_chart.cmd_LessNeb;
var i: integer;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' cmd_LessNeb');
  if sc.catalog.cfgshr.NebMagFilter[10]>2 then
  for i:=1 to MaxField do begin
    if sc.catalog.cfgshr.NebMagFilter[i] >= 99 then
      sc.catalog.cfgshr.NebMagFilter[i] := min(20,DefNebMagFilter[i]+4)
    else
      sc.catalog.cfgshr.NebMagFilter[i] := sc.catalog.cfgshr.NebMagFilter[i] - 0.5;
    if sc.catalog.cfgshr.NebSizeFilter[i] <= 0 then
      sc.catalog.cfgshr.NebSizeFilter[i] := DefNebSizeFilter[i]+0.1
    else
      sc.catalog.cfgshr.NebSizeFilter[i] := sc.catalog.cfgshr.NebSizeFilter[i] * 1.5;
    if sc.catalog.cfgshr.NebSizeFilter[i] > 200 then
      sc.catalog.cfgshr.NebSizeFilter[i] := 200;
  end;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  refresh(True, False);
end;

procedure Tf_chart.cmd_LockMagn;
begin
  sc.cfgsc.lockMagn:=not sc.cfgsc.lockMagn;
  if sc.cfgsc.lockMagn then begin
    sc.cfgsc.lockStarMag := sc.catalog.cfgcat.StarMagMax;
    sc.cfgsc.lockNebMag  := sc.catalog.cfgcat.NebMagMax;
    sc.cfgsc.lockNebSize := sc.catalog.cfgcat.NebSizeMin;
  end;
  sc.cfgsc.AstMagDiff := DefAstMagDiff;
  sc.cfgsc.ComMagDiff := DefComMagDiff;
  refresh(True, False);
end;

procedure Tf_chart.cmd_LockMagn(mstar,mast,mcom,mneb,sneb: double; alldbl,allvar: boolean);
begin
  sc.cfgsc.lockMagn:=true;
  sc.cfgsc.lockStarMag := mstar;
  sc.cfgsc.lockNebMag  := mneb;
  sc.cfgsc.lockNebSize := sneb;
  sc.cfgsc.AstMagDiff := max(0,mast - mstar);
  sc.cfgsc.ComMagDiff := max(0,mcom - mstar);
  sc.catalog.cfgcat.ShowAllDouble:=alldbl;
  sc.catalog.cfgcat.ShowAllVariable:=allvar;
  refresh(True, False);
end;

procedure Tf_chart.cmd_UnLockMagn;
begin
  sc.cfgsc.AstMagDiff := DefAstMagDiff;
  sc.cfgsc.ComMagDiff := DefComMagDiff;
  sc.cfgsc.lockMagn:=false;
  sc.catalog.cfgcat.ShowAllDouble:=false;
  sc.catalog.cfgcat.ShowAllVariable:=false;
  refresh(True, False);
end;

function Tf_chart.ExecuteCmd(arg: TStringList): string;
var
  i, n: integer;
  cmd: string;
begin
  cmd := trim(uppercase(arg[0]));
  if VerboseMsg then
    WriteTrace(Caption + ' ExecuteCmd ' + cmd);
  n := -1;
  for i := 1 to numcmd do
    if cmd = cmdlist[i, 1] then
    begin
      n := strtointdef(cmdlist[i, 2], -1);
      break;
    end;
  Result := msgOK;
  case n of
    1: sc.zoom(zoomfactor);
    2: sc.zoom(1 / zoomfactor);
    3: sc.MoveChart(0, 1, movefactor);
    4: sc.MoveChart(0, -1, movefactor);
    5: sc.MoveChart(1, 0, movefactor);
    6: sc.MoveChart(-1, 0, movefactor);
    7: sc.MoveChart(1, 1, movefactor);
    8: sc.MoveChart(1, -1, movefactor);
    9: sc.MoveChart(-1, 1, movefactor);
    10: sc.MoveChart(-1, -1, movefactor);
    11:
    begin
      sc.cfgsc.FlipX := -sc.cfgsc.FlipX;
      if sc.cfgsc.FlipX < 0 then
        sc.cfgsc.FlipY := 1;
      if assigned(FUpdateBtn) then
        FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
    end;
    12:
    begin
      sc.cfgsc.FlipY := -sc.cfgsc.FlipY;
      if sc.cfgsc.FlipY < 0 then
        sc.cfgsc.FlipX := 1;
      if assigned(FUpdateBtn) then
        FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
    end;
    13: Result := cmd_SetCursorPosition(strtointdef(arg[1], -1), strtointdef(arg[2], -1));
    14: sc.MovetoXY(xcursor, ycursor);
    15:
    begin
      sc.zoom(zoomfactor);
      sc.MovetoXY(xcursor, ycursor);
    end;
    16:
    begin
      sc.zoom(1 / zoomfactor);
      sc.MovetoXY(xcursor, ycursor);
    end;
    17: sc.cfgsc.theta := sc.cfgsc.theta + deg2rad * 15;
    18: sc.cfgsc.theta := sc.cfgsc.theta - deg2rad * 15;
    19: Result := cmd_SetGridEQ(arg[1]);
    20: Result := cmd_SetGrid(arg[1]);
    21: Result := cmd_SetStarMode(strtointdef(arg[1], -1));
    22: Result := cmd_SetNebMode(strtointdef(arg[1], -1));
    23: Result := cmd_SetSkyMode(arg[1]);
    24: chart_UndoExecute(self);
    25: chart_RedoExecute(self);
    26: Result := cmd_SetProjection(arg[1]);
    27: Result := cmd_SetFov(arg[1]);
    28: Result := cmd_SetRa(arg[1]);
    29: Result := cmd_SetDec(arg[1]);
    30: Result := cmd_SetObs(arg[1] + arg[2] + arg[3] + arg[4] + arg[5] + arg[6] + arg[7] + arg[8]);
    31: Result := cmd_IdentCursor;
    32: Result := cmd_SaveImage(arg[1], arg[2], arg[3]);
    33: SetAz(deg2rad * 180, False);
    34: SetAz(0, False);
    35: SetAz(deg2rad * 270, False);
    36: SetAz(deg2rad * 90, False);
    37: SetZenit(0, False);
    38: SetZenit(deg2rad * 200, False);
    39: Refresh(True, True);
    40: Result := cmd_GetCursorPosition;
    41: Result := cmd_GetGridEQ;
    42: Result := cmd_GetGrid;
    43: Result := cmd_GetStarMode;
    44: Result := cmd_GetNebMode;
    45: Result := cmd_GetSkyMode;
    46: Result := cmd_GetProjection;
    47: Result := cmd_GetFov(arg[1]);
    48: Result := cmd_GetRA(arg[1]);
    49: Result := cmd_GetDEC(arg[1]);
    50: Result := cmd_GetDate;
    51: Result := cmd_GetObs;
    52:
    begin
      Result := cmd_SetDate(arg[1]);
      Refresh(True, True);
    end;
    53:
    begin
      Result := cmd_SetTZ(arg[1]);
      Refresh(True, True);
    end;
    54: Result := cmd_GetTZ;
    55:
    begin
      cmd_SetRa(arg[1],true);
      cmd_SetDec(arg[2],true);
      cmd_SetFov(arg[3]);
      Refresh(True, True);
    end;
    56:
    begin
      PDSSTimer.Enabled := True;
      Result := msgOK;
    end;// result:=cmd_PDSS(arg[1],arg[2],arg[3],arg[4]);
    57: Result := cmd_SaveImage('BMP', arg[1], '');
    58: Result := cmd_SaveImage('GIF', arg[1], '');
    59: Result := cmd_SaveImage('JPEG', arg[1], arg[2]);
    60: Result := cmd_IdXY(arg[1], arg[2]);
    61: cmd_GoXY(arg[1], arg[2]);
    62: cmd_MoreStar;
    63: cmd_LessStar;
    64: cmd_MoreNeb;
    65: cmd_LessNeb;
    66: chart_GridEQExecute(Self);
    67: chart_GridExecute(Self);
    68:
    begin
      Result := cmd_SwitchGridNum;
      Refresh(True, False);
    end;
    69:
    begin
      Result := cmd_SwitchConstL;
      Refresh(True, False);
    end;
    70:
    begin
      Result := cmd_SwitchConstB;
      Refresh(True, False);
    end;
    71:
    begin
      if sc.cfgsc.projpole <> equat then
        sc.cfgsc.projpole := equat
      else
        sc.cfgsc.projpole := altaz;
      sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
      sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
      sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
      sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
      sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
      sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
      sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
      sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
      refresh(True, False);
    end;
    77: Result := cmd_SetGridNum(arg[1]);
    78: Result := cmd_SetConstL(arg[1]);
    79: Result := cmd_SetConstB(arg[1]);
    80: Result := cmd_resize(arg[1], arg[2]);
    81: Result := cmd_print(arg[1], arg[2], arg[3], arg[4]);
    82: Result := cmd_getriseset;
    83: Result := cmd_MoveScope(arg[1], arg[2]);
    84: Result := cmd_MoveScopeH(arg[1], arg[2]);
    85: Result := cmd_IdentCenter;
    86: Result := cmd_IdentTelescope;
    87: Result := cmd_SetShowPicture(arg[1]);
    88: begin
        if arg.Count>2 then
          Result := cmd_SetBGimage(arg[1],arg[2])
        else
          Result := cmd_SetBGimage(arg[1],'ON');
        end;
    89:  begin
        if arg.Count>2 then
          Result := cmd_LoadBGimage(arg[1],arg[2])
        else
          Result := cmd_LoadBGimage(arg[1],'ON');
        end;
    90: Result := cmd_GetObjectList;
    91: Result := cmd_LoadCircle(arg[1]);
    92: Result := cmd_DefCircle(arg[1], arg[2], arg[3], arg[4]);
    93: Result := cmd_DefRectangle(arg[1], arg[2], arg[3], arg[4], arg[5]);
    94: Result := cmd_ShowCircle(arg[1]);
    95: Result := cmd_ShowRectangle(arg[1]);
    96: Result := cmd_MarkCenter(arg[1]);
    97: Result := cmd_GetScopeRaDec(arg[1]);
    98: Result := cmd_ConnectINDI;
    99: Result := cmd_DisconnectINDI;
    100: Result := cmd_SlewINDI(arg[1], arg[2]);
    101: Result := cmd_AbortSlewINDI;
    102: Result := cmd_SyncINDI(arg[1], arg[2]);
    103: Result := cmd_TrackTelescope(arg[1]);
    104: Result := cmd_ConnectTelescope;
    105: Result := cmd_DisconnectTelescope;
    106: Result := cmd_Sync(arg[1], arg[2]);
    107: Result := cmd_Slew(arg[1], arg[2]);
    108: Result := cmd_AbortSlew;
    109: Result := cmd_ObslistLoad(arg[1]);
    110: Result := cmd_ObslistFirst;
    111: Result := cmd_ObslistLast;
    112: Result := cmd_ObslistNext;
    113: Result := cmd_ObslistPrev;
    114: Result := cmd_ObslistLimit(arg[1]);
    115: Result := cmd_ObslistAirmassLimit(arg[1]);
    116: Result := cmd_ObslistTransitLimit(arg[1]);
    117: Result := cmd_ObslistTransitSide(arg[1]);
    118: Result := cmd_GetScopeRates;
    119: Result := cmd_ScopeMoveAxis(arg[1], arg[2]);
    120: Result := cmd_SetScopeRefreshRate(arg[1]);
    121: Result := cmd_SetPlanisphereDate(arg[1]);
    122: Result := cmd_SetPlanisphereTime(arg[1]);
    123: Result := cmd_SetFOVProjection(arg[1], arg[2]);
    124: Result := cmd_ShowOnlyMeridian(arg[1]);
    125: Result := cmd_ShowAlwaysMeridian(arg[1]);
    126: Result := cmd_Cleanup;
    127: Result := cmd_GetChartEqsys;
    128: Result := cmd_GetScopeSlewing;
    129: Result := cmd_GetFrames;
    130: Result := cmd_SetChartEquinox(arg[1]);
    131: Result := cmd_SetFieldnumber(arg[1]);
    132: Result := cmd_TrackObject(arg[1]);
    else
      Result := msgFailed + ' Bad command name';
  end;
end;

procedure Tf_chart.SetField(field: double; trackAltAz: boolean = True; doRefresh: boolean=true);
begin
  sc.setfov(field);
  if VerboseMsg then
    WriteTrace(Caption + ' SetField');
  if trackAltAz and (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  if doRefresh then Refresh(True, False);
end;

procedure Tf_chart.SetZenit(field: double; redraw: boolean = True);
var
  a, d, az: double;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' SetZenit');
  az := sc.cfgsc.acentre;
  if field > 0 then
  begin
    if sc.cfgsc.windowratio > 1 then
      sc.cfgsc.fov := field * sc.cfgsc.windowratio
    else
      sc.cfgsc.fov := field;
  end;
  sc.cfgsc.ProjPole := Altaz;
  sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
  sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
  sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
  sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
  sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
  sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
  sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
  sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
  if (sc.cfgsc.EquinoxType <> 2) then
  begin // ensure equinox of the date for alt/az
    sc.cfgsc.EquinoxType := 2;
    sc.cfgsc.EquinoxChart := rsDate;
    sc.cfgsc.DefaultJDChart := jd2000;
    sc.cfgsc.CoordExpertMode := False;
    sc.cfgsc.ApparentPos := True;
    sc.cfgsc.PMon := True;
    sc.cfgsc.YPmon := 0;
    sc.cfgsc.CoordType := 0;
  end;
  sc.cfgsc.Acentre := 0;
  sc.cfgsc.hcentre := pid2;
  Hz2Eq(sc.cfgsc.acentre, sc.cfgsc.hcentre, a, d, sc.cfgsc);
  sc.cfgsc.racentre := sc.cfgsc.CurST - a;
  sc.cfgsc.decentre := d;
  sc.cfgsc.TrackOn := False;
  if field > 0 then
  begin
    setaz(az, redraw);
  end
  else if redraw then
    Refresh(True, True);
end;

procedure Tf_chart.SetAz(Az: double; redraw: boolean = True);
var
  a, d: double;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' SetAz');
  a := MinValue([sc.cfgsc.Fov, sc.cfgsc.Fov / sc.cfgsc.windowratio]);
  if sc.cfgsc.Fov < pi then
    Hz2Eq(Az, a / 2.3, a, d, sc.cfgsc)
  else
    Hz2Eq(Az, sc.cfgsc.hcentre, a, d, sc.cfgsc);
  sc.cfgsc.acentre := Az;
  sc.cfgsc.racentre := sc.cfgsc.CurST - a;
  sc.cfgsc.decentre := d;
  sc.cfgsc.ProjPole := Altaz;
  sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
  sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
  sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
  sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
  sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
  sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
  sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
  sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
  sc.cfgsc.TrackOn := False;
  if (sc.cfgsc.EquinoxType <> 2) then
  begin // ensure equinox of the date for alt/az
    sc.cfgsc.EquinoxType := 2;
    sc.cfgsc.EquinoxChart := rsDate;
    sc.cfgsc.DefaultJDChart := jd2000;
    sc.cfgsc.CoordExpertMode := False;
    sc.cfgsc.ApparentPos := True;
    sc.cfgsc.PMon := True;
    sc.cfgsc.YPmon := 0;
    sc.cfgsc.CoordType := 0;
  end;
  if redraw then
    Refresh(True, True);
end;

procedure Tf_chart.SetDateUT(y, m, d, h, n, s: integer);
var
  jj, hh, sn: double;
begin
  sn := sign(h);
  hh := h + sn * n / 60 + sn * s / 3600;
  jj := jd(y, m, d, hh);
  SetJD(jj);
end;

procedure Tf_chart.SetJD(njd: double);  // UT
var
  y, m, d: integer;
  h: double;
begin
  if (njd > maxjd) or (njd < minjd) then
    exit;
  sc.cfgsc.tz.JD := njd;
  sc.cfgsc.TimeZone := sc.cfgsc.tz.SecondsOffset / 3600;
  djd(njd + sc.cfgsc.TimeZone / 24, y, m, d, h);  // local time
  if ((24-h)*3600)<0.001 then begin  //next day if rounding error < 1 millisecond
    njd:=njd+0.001/3600/24;
    sc.cfgsc.tz.JD := njd;
    sc.cfgsc.TimeZone := sc.cfgsc.tz.SecondsOffset / 3600;
    djd(njd + sc.cfgsc.TimeZone / 24, y, m, d, h);  // local time
  end;
  sc.cfgsc.UseSystemTime := False;
  sc.cfgsc.CurYear := y;
  sc.cfgsc.CurMonth := m;
  sc.cfgsc.CurDay := d;
  sc.cfgsc.CurTime := h;
  if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
  begin
    sc.cfgsc.TrackOn := True;
    sc.cfgsc.TrackType := TTaltaz;
  end;
  if VerboseMsg then
    WriteTrace(Caption + ' SetJD');
  Refresh(True, True);
end;

procedure Tf_chart.IdentDetail(X, Y: integer);
var
  ra, Dec, a, h, l, b, le, be, dx: double;
begin
  if locked then
    exit;
  sc.GetCoord(x, y, ra, Dec, a, h, l, b, le, be);
  ra := rmod(ra + pi2, pi2);
  dx := 1 / sc.cfgsc.BxGlb; // search a 1 pixel radius
  sc.FindatRaDec(ra, Dec, dx, True);
  if sc.cfgsc.FindDesc > '' then
  begin
    if assigned(Fshowinfo) then
      Fshowinfo(sc.cfgsc.FindDesc, Caption, True, self, sc.cfgsc.FindDesc2, sc.cfgsc.FindDesc2000);
    identlabelClick(Self);
  end;
end;


procedure Tf_chart.Connect1Click(Sender: TObject);
// Connect Telescope
begin
  if VerboseMsg then
    WriteTrace(Caption + ' Connect Telescope');
  if sc.cfgsc.ManualTelescope then
  begin
    sc.cfgsc.TelescopeJD := 0;
  end
  else
  begin
    ConnectTelescope(Sender);
  end;
  if (not sc.cfgsc.TrackOn) then
    sc.cfgsc.TrackName := rsTelescope;
end;

procedure Tf_chart.Slew1Click(Sender: TObject);
begin
  if Connect1.Checked then
  begin
    SlewTelescope(Sender);
  end
  else if assigned(Fshowinfo) then
    Fshowinfo(rsTelescopeNot);
end;

procedure Tf_chart.AbortSlew1Click(Sender: TObject);
begin
  if Connect1.Checked then
  begin
    AbortSlewTelescope(Sender);
  end;
end;

procedure Tf_chart.Sync1Click(Sender: TObject);
begin
  if sc.cfgsc.FindName <> '' then
  begin
    if Connect1.Checked and (mrYes = MessageDlg(Format(rsPleaseConfir, [sc.cfgsc.FindName]),
      mtConfirmation, [mbYes, mbNo], 0)) then
    begin
      SyncTelescope(Sender);
    end
    else if assigned(Fshowinfo) then
      Fshowinfo(rsTelescopeNot);
  end
  else
    Fshowinfo(rsNoTargetObje);
end;

procedure Tf_chart.MenuNewMosaicClick(Sender: TObject);
var ra,de: double;
begin
  GetAdXy(Xcursor, Ycursor, ra, de, sc.cfgsc);
  NewMosaic(ra,de,false);
end;

procedure Tf_chart.PrePointCreateClick(Sender: TObject);
var ra,de: double;
begin
  if sc.cfgsc.FindName > '' then begin
    ra:=sc.cfgsc.FindRA;
    de:=sc.cfgsc.FindDec;
    f_prepoint.ObjLabel.Caption:=sc.cfgsc.FindName;
  end
  else begin
    Fshowinfo(rsNoTargetObje);
    exit;
  end;
  FormPos(f_prepoint,mouse.CursorPos.X, mouse.CursorPos.Y);
  f_prepoint.PageControl1.ActivePageIndex:=0;
  f_prepoint.ShowModal;
  if f_prepoint.ModalResult=mrOK then begin
    sc.cfgsc.PrePointTime:=f_prepoint.TimeObsH.Value+f_prepoint.TimeObsM.Value/60+f_prepoint.TimeObsS.Value/3600;
    f_prepoint.ObjLabel.Caption:=f_prepoint.ObjLabel.Caption+blank+ARtoStr3(sc.cfgsc.PrePointTime);
    sc.cfgsc.PrePointLength:=f_prepoint.TimeLength.Value;
    sc.cfgsc.PrePointRA:=ra;
    sc.cfgsc.PrePointDEC:=de;
    sc.cfgsc.PrePointMarkRA:=100;
    sc.cfgsc.PrePointMarkDEC:=100;
    sc.cfgsc.DrawPrePoint:=true;
    Refresh(true,true);
    PrePointMeasure.Visible:=true;
    PrePointRemove.Visible:=true;
    PrePointCreate.Visible:=false;
  end;
end;

procedure Tf_chart.PrePointMeasureClick(Sender: TObject);
var t,ra,de: double;
    msg: string;
begin
  if sc.cfgsc.FindName > '' then begin
    ra:=sc.cfgsc.FindRA;
    de:=sc.cfgsc.PrePointDEC;
    msg:=rsReference+blank+sc.cfgsc.FindName+crlf+rsAt;
  end
  else begin
    GetAdXy(Xcursor, Ycursor, ra, de, sc.cfgsc);
    de:=sc.cfgsc.PrePointDEC;
    msg:=rsReference+blank+rsTime+':';
  end;
  t:=sc.cfgsc.PrePointTime-rad2deg*(sc.cfgsc.PrePointRA-ra)/15;
  if t<0 then t:=t+24;
  if t>=24 then t:=t-24;
  msg:=msg+blank+ARtoStr3(t);
  msg:=msg+crlf+crlf+rsCenter;
  msg:=msg+crlf+rsRA+blank+ARtoStr3(rad2deg*ra/15);
  msg:=msg+crlf+rsDEC+blank+DEToStr3(rad2deg*de);
  f_prepoint.onRecenter:=PrePointCenter;
  f_prepoint.onRecenterNow:=PrePointCenterNow;
  f_prepoint.PageControl1.ActivePageIndex:=1;
  f_prepoint.msg.Caption:=msg;
  sc.cfgsc.PrePointMarkRA:=ra;
  sc.cfgsc.PrePointMarkDEC:=de;
  f_prepoint.Show;
  Refresh(true,true);
end;

procedure Tf_chart.PrePointCenter(Sender: TObject);
begin
  if (sc.cfgsc.PrePointMarkRA<99)and(sc.cfgsc.PrePointMarkDEC<99) then begin
    sc.cfgsc.ShowCircle:=true;
    sc.cfgsc.racentre := sc.cfgsc.PrePointMarkRA;
    sc.cfgsc.decentre := sc.cfgsc.PrePointMarkDEC;
    sc.cfgsc.TrackOn := False;
    Refresh(true,true);
  end;
end;

procedure Tf_chart.PrePointCenterNow(Sender: TObject);
var t,ra,de: double;
    msg: string;
begin
  t:=frac(now)*24;
  ra:=sc.cfgsc.PrePointRA-15*(sc.cfgsc.PrePointTime-t)*deg2rad;
  de:=sc.cfgsc.PrePointDEC;
  if ra<0 then ra:=ra+pi2;
  if ra>=pi2 then ra:=ra-pi2;
  msg:=rsReference+blank+rsTime+':'+blank+ARtoStr3(t);
  msg:=msg+crlf+crlf+rsCenter;
  msg:=msg+crlf+rsRA+blank+ARtoStr3(rad2deg*ra/15);
  msg:=msg+crlf+rsDEC+blank+DEToStr3(rad2deg*de);
  f_prepoint.PageControl1.ActivePageIndex:=1;
  f_prepoint.msg.Caption:=msg;
  sc.cfgsc.PrePointMarkRA:=ra;
  sc.cfgsc.PrePointMarkDEC:=de;
  f_prepoint.Show;
  sc.cfgsc.ShowCircle:=true;
  sc.cfgsc.racentre := sc.cfgsc.PrePointMarkRA;
  sc.cfgsc.decentre := sc.cfgsc.PrePointMarkDEC;
  sc.cfgsc.TrackOn := False;
  Refresh(true,true);
end;

procedure Tf_chart.PrePointRemoveClick(Sender: TObject);
begin
  f_prepoint.Hide;
  PrePointCreate.Visible:=true;
  PrePointMeasure.Visible:=false;
  PrePointRemove.Visible:=false;
  sc.cfgsc.DrawPrePoint:=false;
  Refresh(true,true);
end;

procedure Tf_chart.NewMosaic(ra,de: double; resizechart: boolean);
var i:integer;
    w: double;
begin
  // check incompatible option
  if MovingCircle or (sc.cfgsc.NumCircle >= MaxCircle) then
    exit;
  if movecam or moveguide then
    SetCameraRotation(0);
  // save current values
  ShowCircle := sc.cfgsc.ShowCircle;
  ncircle := sc.cfgsc.ncircle;
  SetLength(circle, ncircle + 1);
  SetLength(circleok, ncircle + 1);
  SetLength(circlelbl, ncircle + 1);
  for i:=1 to ncircle do begin
    circle[i,1] := sc.cfgsc.circle[i,1];
    circle[i,2] := sc.cfgsc.circle[i,2];
    circle[i,3] := sc.cfgsc.circle[i,3];
    circle[i,4] := sc.cfgsc.circle[i,4];
    circleok[i] := sc.cfgsc.circleok[i];
    circlelbl[i]:= sc.cfgsc.circlelbl[i];
  end;
  nrectangle := sc.cfgsc.nrectangle;
  SetLength(rectangle, nrectangle + 1);
  SetLength(rectangleok, nrectangle + 1);
  SetLength(rectanglelbl, nrectangle + 1);
  for i:=1 to nrectangle do begin
    rectangle[i,1] := sc.cfgsc.rectangle[i,1];
    rectangle[i,2] := sc.cfgsc.rectangle[i,2];
    rectangle[i,3] := sc.cfgsc.rectangle[i,3];
    rectangle[i,4] := sc.cfgsc.rectangle[i,4];
    rectangle[i,5] := sc.cfgsc.rectangle[i,5];
    rectangleok[i] := sc.cfgsc.rectangleok[i];
    rectanglelbl[i]:= sc.cfgsc.rectanglelbl[i];
  end;
  NumCircle := sc.cfgsc.NumCircle;
  for i := 1 to NumCircle do begin
    CircleLst[i, 1] := sc.cfgsc.CircleLst[i, 1];
    CircleLst[i, 2] := sc.cfgsc.CircleLst[i, 2];
  end;
  // initialize mosaic form
  f_mosaic.onClearMosaic:=RemoveAllCircles1Click;
  f_mosaic.onApplyMosaic:=ApplyMosaic;
  f_mosaic.onSaveMosaic:=MenuSaveCircleClick;
  f_mosaic.onEndMosaic:=EndMosaic;
  f_mosaic.onSendMosaic:=SendMosaic;
  f_mosaic.Ra.Value:=rad2deg*ra/15;
  f_mosaic.De.Value:=rad2deg*de;
  f_mosaic.jdchart:=sc.cfgsc.JDChart;
  w := LoadMosaicFrameList;
  FormPos(f_mosaic,mouse.CursorPos.X, mouse.CursorPos.Y);
  f_mosaic.Show;
  if resizechart and (w>0) then begin
     sc.setfov(deg2rad * 2*f_mosaic.SizeX.Value*w/60)
  end;
end;

function Tf_chart.LoadMosaicFrameList;
var i,n:integer;
begin
  f_mosaic.FrameList.Clear;
  n:=1; // use first rectangle if none are selected
  result:=0;
  for i:=1 to sc.cfgsc.nrectangle do begin
    if sc.cfgsc.rectangleok[i] and (sc.cfgsc.rectangle[i,4]=0) then begin
       n:=i;
    end;
    f_mosaic.FrameList.Items.Add(formatfloat(f2, sc.cfgsc.rectangle[i, 1]) + lmin + 'x' + formatfloat(f2, sc.cfgsc.rectangle[i, 2]) + lmin + '_PA' + formatfloat(f2, sc.cfgsc.rectangle[i, 3]) + ldeg + blank + sc.cfgsc.rectanglelbl[i]);
  end;
  f_mosaic.FrameList.ItemIndex := n-1;
  result := sc.cfgsc.rectangle[n, 1];
  f_mosaic.Rotation.Value := sc.cfgsc.rectangle[n, 3];
end;

procedure Tf_chart.SendMosaic(Sender: TObject);
var txt,id,rot,w,h: string;
  i,n: integer;
begin
  if (sc.cfgsc.NumCircle > 0) and assigned(FSendInfo) then
  begin
    rot := FormatFloat(f2, Tf_mosaic(Sender).Rotation.Value);
    id := nospace(Tf_mosaic(Sender).MosaicName.Text);
    if id='' then id := 'mosaic';
    id := validfilename(id);
    id := id+'_';
    n:=f_mosaic.FrameList.ItemIndex+1;
    w := formatfloat(f2, sc.cfgsc.rectangle[n, 1]);
    h := formatfloat(f2, sc.cfgsc.rectangle[n, 2]);
    for i := 1 to sc.cfgsc.NumCircle do
    begin
      txt := ARToStr3(rad2deg * sc.cfgsc.CircleLst[i, 1] / 15) + tab +
             DEToStr3(rad2deg * sc.cfgsc.CircleLst[i, 2]) + tab +
             'Frm' + tab +
             id + FormatFloat('00', i) + tab +
             'Dim: ' + w + ' x ' +h +' '''+ tab +
             'pa: '+ rot +tab;
      FSendInfo(nil, Caption, txt);
    end;
  end;
end;

function Tf_chart.cmd_GetFrames: string;
begin
  if (f_mosaic<>nil)and(f_mosaic.Visible) then begin
    SendMosaic(f_mosaic);
    result:=msgOK;
  end else begin
    result:=msgFailed;
  end;
end;

procedure Tf_chart.EndMosaic(Sender: TObject);
var i: integer;
begin
  // restore values
  sc.cfgsc.ShowCircle := ShowCircle;
  sc.cfgsc.ncircle := ncircle;
  SetLength(sc.cfgsc.circle, sc.cfgsc.ncircle + 1);
  SetLength(sc.cfgsc.circleok, sc.cfgsc.ncircle + 1);
  SetLength(sc.cfgsc.circlelbl, sc.cfgsc.ncircle + 1);
  for i:=1 to sc.cfgsc.ncircle do begin
    sc.cfgsc.circle[i,1]  := circle[i,1];
    sc.cfgsc.circle[i,2]  := circle[i,2];
    sc.cfgsc.circle[i,3]  := circle[i,3];
    sc.cfgsc.circle[i,4]  := circle[i,4];
    sc.cfgsc.circleok[i]  := circleok[i];
    sc.cfgsc.circlelbl[i] := circlelbl[i];
  end;
  sc.cfgsc.nrectangle := nrectangle;
  SetLength(sc.cfgsc.rectangle, sc.cfgsc.nrectangle + 1);
  SetLength(sc.cfgsc.rectangleok, sc.cfgsc.nrectangle + 1);
  SetLength(sc.cfgsc.rectanglelbl, sc.cfgsc.nrectangle + 1);
  for i:=1 to sc.cfgsc.nrectangle do begin
    if i=10 then continue;
    sc.cfgsc.rectangle[i,1]  := rectangle[i,1];
    sc.cfgsc.rectangle[i,2]  := rectangle[i,2];
    sc.cfgsc.rectangle[i,3]  := rectangle[i,3];
    sc.cfgsc.rectangle[i,4]  := rectangle[i,4];
    sc.cfgsc.rectangle[i,5]  := rectangle[i,5];
    sc.cfgsc.rectangleok[i]  := rectangleok[i];
    sc.cfgsc.rectanglelbl[i] := rectanglelbl[i];
  end;
  sc.cfgsc.NumCircle := NumCircle;
  for i := 1 to sc.cfgsc.NumCircle do begin
    sc.cfgsc.CircleLst[i, 1] := CircleLst[i, 1];
    sc.cfgsc.CircleLst[i, 2] := CircleLst[i, 2];
  end;
  Refresh(True, False);
end;

procedure Tf_chart.ApplyMosaic(Sender: TObject);
var cra,cde,sra,sde,ra,de,dx,dy,crot,srot,cosde: double;
    dyra,dyde,dxra,dxde: double;
    i,j,n,nx,ny: integer;
begin
  n:=f_mosaic.FrameList.ItemIndex+1;
  if sc.cfgsc.rectangle[n, 4] <> 0 then begin
    ShowMessage('Cannot create a mosaic for a frame with offset.');
    exit;
  end;
  // set rotation
  sc.cfgsc.rectangle[n, 3] := f_mosaic.Rotation.Value;
  // select only one frame and no circle
  for i:=1 to sc.cfgsc.nrectangle do
     sc.cfgsc.rectangleok[i] := (n=i);
  for i:=1 to sc.cfgsc.ncircle do
     sc.cfgsc.circleok[i] := false;
  sc.cfgsc.ShowCircle := false;
  // Center position
  cra := deg2rad * f_mosaic.Ra.Value * 15;
  cde := deg2rad * f_mosaic.De.Value;
  // number of steps
  nx := f_mosaic.SizeX.Value;
  ny := f_mosaic.SizeY.Value;
  // compute steps
  dx := (100-(f_mosaic.Hoverlap.Value)) / 100 * deg2rad * sc.cfgsc.rectangle[n,1] / 60;
  dy := (100-(f_mosaic.Voverlap.Value)) / 100 * deg2rad * sc.cfgsc.rectangle[n,2] / 60;
  if (dx=0) or (dy=0) then exit;
  sincos(deg2rad * sc.cfgsc.rectangle[n, 3],srot,crot);
  // declination step
  dxde := dx * srot ;
  dyde := dy * crot;
  // start declination
  sde := cde - dxde*(nx-1)/2 + dyde*(ny-1)/2;
  // assign rectangles
  n:=0;
  for i := 0 to nx-1 do begin
    // new dec
    de := sde + dxde * i;
    for j := 0 to ny-1 do begin
        // new ra step, compute overlap on the smaller end
        if de>0 then
          cosde := cos(minvalue([de+dxde,de-dxde,de+dyde,de-dyde]))
        else
          cosde := cos(maxvalue([de+dxde,de-dxde,de+dyde,de-dyde]));
        if cosde=0 then exit;
        dxra := dx * crot / cosde;
        dyra := dy * srot / cosde;
        // new ra start for declination
        sra := cra + dxra*(nx-1)/2 + dyra*(ny-1)/2;
        // new ra
        ra := sra - dxra*i - dyra*j;
        // add point
        inc(n);
        sc.cfgsc.CircleLst[n, 1] := ra;
        sc.cfgsc.CircleLst[n, 2] := de;
        // new dec
        de := de - dyde;
    end;
  end;
  if AngularDistance(sc.cfgsc.racentre,sc.cfgsc.decentre,cra,cde)>dx then begin
    sc.cfgsc.racentre:=cra;
    sc.cfgsc.decentre:=cde;
  end;
  sc.cfgsc.NumCircle := n;
  // draw
  Refresh(True, False);
end;

procedure Tf_chart.NewFinderCircle1Click(Sender: TObject);
begin
  if MovingCircle or (sc.cfgsc.NumCircle >= MaxCircle) then
    exit;
  mouse.CursorPos := point(xcursor + Image1.ClientOrigin.x, ycursor + Image1.ClientOrigin.y);
  GetAdXy(Xcursor, Ycursor, sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], sc.cfgsc);
  sc.DrawFinderMark(sc.cfgsc.CircleLst[0, 1], sc.cfgsc.CircleLst[0, 2], True, -1);
  MovingCircle := True;
  StartCircle := True;
end;

procedure Tf_chart.RemoveLastCircle1Click(Sender: TObject);
begin
  if sc.cfgsc.NumCircle > 0 then
    Dec(sc.cfgsc.NumCircle);
  if VerboseMsg then
    WriteTrace(Caption + ' RemoveLastCircle1Click');
  Refresh(True, False);
end;

procedure Tf_chart.RemoveAllCircles1Click(Sender: TObject);
begin
  sc.cfgsc.NumCircle := 0;
  if VerboseMsg then
    WriteTrace(Caption + ' RemoveAllCircles1Click');
  Refresh(True, False);
end;

procedure Tf_chart.MenuSaveCircleClick(Sender: TObject);
var
  txt,rot,w,h: string;
  f: textfile;
  i,n: integer;
begin
  if SaveDialog1.InitialDir = '' then
    SaveDialog1.InitialDir := HomeDir;
  if Sender is Tf_mosaic then begin
    rot := FormatFloat(f2, Tf_mosaic(Sender).Rotation.Value);
    txt := nospace(Tf_mosaic(Sender).MosaicName.Text);
    if txt='' then txt := 'mosaic';
    txt := validfilename(txt);
    SaveDialog1.FileName := txt;
    SaveDialog1.Filter := 'Mosaic file|*.cdcc|All|*';
    txt := txt+'_';
    n:=f_mosaic.FrameList.ItemIndex+1;
    w := formatfloat(f2, sc.cfgsc.rectangle[n, 1]);
    h := formatfloat(f2, sc.cfgsc.rectangle[n, 2]);
  end
  else begin
    SaveDialog1.FileName := 'circle';
    SaveDialog1.Filter := 'Circle file|*.cdcc|All|*';
    txt := 'Circle_';
    rot := '-';
    w := '-';
    h := '-';
  end;
  if (sc.cfgsc.NumCircle > 0) and SaveDialog1.Execute then
  begin
    if VerboseMsg then
      WriteTrace(Caption + ' Save Circles to ' + UTF8ToSys(SaveDialog1.FileName));
    AssignFile(f, UTF8ToSys(SaveDialog1.FileName));
    Rewrite(f);
    WriteLn(f,'EQUINOX='+FormatFloat(f1,sc.cfgsc.JDChart));
    for i := 1 to sc.cfgsc.NumCircle do
    begin
      WriteLn(f, txt + FormatFloat('00', i) + blank + ARToStr3(rad2deg * sc.cfgsc.CircleLst[i, 1] / 15)
                 + blank + DEToStr3(rad2deg * sc.cfgsc.CircleLst[i, 2]) + blank + rot + blank + w + blank +h);
    end;
    CloseFile(f);
    if Sender is Tf_mosaic then begin
       AssignFile(f, ChangeFileExt(SaveDialog1.FileName,'.cdcm'));
       Rewrite(f);
       WriteLn(f,'NAME='+Tf_mosaic(Sender).MosaicName.Text);
       WriteLn(f,'EQUINOX='+FormatFloat(f1,sc.cfgsc.JDChart));
       WriteLn(f,'RA='+FormatFloat(f5,Tf_mosaic(Sender).Ra.Value));
       WriteLn(f,'DEC='+FormatFloat(f5,Tf_mosaic(Sender).De.Value));
       WriteLn(f,'ROT='+FormatFloat(f2,Tf_mosaic(Sender).Rotation.Value));
       WriteLn(f,'FRAME='+Tf_mosaic(Sender).FrameList.Text);
       WriteLn(f,'SIZEX='+inttostr(Tf_mosaic(Sender).SizeX.Value));
       WriteLn(f,'SIZEY='+inttostr(Tf_mosaic(Sender).SizeY.Value));
       WriteLn(f,'HOROVERLAP='+inttostr(Tf_mosaic(Sender).Hoverlap.Value));
       WriteLn(f,'VEROVERLAP='+inttostr(Tf_mosaic(Sender).Voverlap.Value));
       CloseFile(f);
    end;
  end;
end;

procedure Tf_chart.PDSSTimerTimer(Sender: TObject);
begin
  PDSSTimer.Enabled := False;
  cmd_PDSS('', '', '', '');
end;

procedure Tf_chart.RecoverLabelSelectAll(Sender: TObject);
var
  f: TForm;
  i: integer;
begin
  if Sender = nil then
    exit;
  try
    f := TForm(TButton(Sender).Parent);
    for i := 0 to f.ControlCount - 1 do
    begin
      if f.Controls[i] is TCheckListBox then
        with f.Controls[i] as TCheckListBox do
        begin
          if Items.Count > 0 then
            if Checked[0] then
              CheckAll(cbUnchecked)
            else
              CheckAll(cbChecked);
        end;
    end;
  except
  end;
end;

procedure Tf_chart.RecoverLabelClick(Sender: TObject);
var
  i, j: integer;
  f: TForm;
  l: TCheckListBox;
  b1, b2: TButton;
  lid: array of integer;
begin
  if sc.cfgsc.nummodlabels <= 0 then
    exit;
  f := TForm.Create(self);
  b1 := TButton.Create(self);
  b2 := TButton.Create(self);
  l := TCheckListBox.Create(self);
  try
    f.Caption := rsSelectLabels;
    f.Width := 300;
    f.Height := 300;
    b1.Parent := f;
    b1.Align := alBottom;
    b1.ModalResult := mrOk;
    b1.Caption := rsOK;
    b2.Parent := f;
    b2.Align := alTop;
    b2.Caption := rsSelectAll;
    b2.OnClick := RecoverLabelSelectAll;
    l.Parent := f;
    l.Align := alClient;
    SetLength(lid, sc.cfgsc.nummodlabels + 1);
    for i := 1 to sc.cfgsc.nummodlabels do
    begin
      if sc.cfgsc.modlabels[i].hiden then
      begin
        j := l.Items.Add(sc.cfgsc.modlabels[i].txt);
        lid[j] := sc.cfgsc.modlabels[i].id;
      end;
    end;
    ScaleDPI(f);
    if l.Items.Count > 0 then
    begin
      FormPos(f, mouse.CursorPos.X, mouse.CursorPos.Y);
      f.ShowModal;
      if f.ModalResult = mrOk then
      begin
        for i := 0 to l.Items.Count - 1 do
        begin
          if l.Checked[i] then
          begin
            for j := 1 to sc.cfgsc.nummodlabels do
              if sc.cfgsc.modlabels[j].id = lid[i] then
              begin
                sc.cfgsc.modlabels[j].hiden := False;
              end;
          end;
        end;
      end;
      Refresh(True, False);
    end;
  finally
    b1.Free;
    b2.Free;
    l.Free;
    f.Free;
  end;
end;

function Tf_chart.cmd_DefCircle(num, diameter, rotation, offset: string): string;
var
  i: integer;
begin
  i := StrToIntDef(num, -1);
  if (i >= 1) and (i <= sc.cfgsc.ncircle) then
  begin
    sc.cfgsc.circle[i, 1] := StrToFloatDef(diameter, 60);
    sc.cfgsc.circle[i, 2] := StrToFloatDef(rotation, 0);
    sc.cfgsc.circle[i, 3] := StrToFloatDef(offset, 0);
    sc.cfgsc.circle[i, 4] := 0;
    sc.cfgsc.circlelbl[i] := 'C' + diameter;
    Result := msgOK;
  end
  else
    Result := msgFailed;
end;

function Tf_chart.cmd_DefRectangle(num, w, h, rotation, offset: string): string;
var
  i: integer;
begin
  i := StrToIntDef(num, -1);
  if (i >= 1) and (i <= sc.cfgsc.nrectangle) then
  begin
    sc.cfgsc.rectangle[i, 1] := StrToFloatDef(w, 60);
    sc.cfgsc.rectangle[i, 2] := StrToFloatDef(h, 60);
    sc.cfgsc.rectangle[i, 3] := rmod(StrToFloatDef(rotation, 0)+360,360);
    sc.cfgsc.rectangle[i, 4] := StrToFloatDef(offset, 0);
    sc.cfgsc.rectangle[i, 5] := 0;
    sc.cfgsc.rectanglelbl[i] := 'R' + w + 'x' + h +'_PA'+rotation+ldeg;
    Result := msgOK;
    LoadMosaicFrameList;
  end
  else
    Result := msgFailed;
end;

function Tf_chart.cmd_ShowCircle(numlist: string): string;
var
  buf: string;
var
  i, p: integer;
begin
  for i := 1 to sc.cfgsc.ncircle do
    sc.cfgsc.circleok[i] := False;
  repeat
    i := -1;
    p := pos(',', numlist);
    if p > 0 then
    begin
      buf := copy(numlist, 1, p - 1);
      Delete(numlist, 1, p);
      i := strtointdef(buf, -1);
    end
    else
    begin
      i := strtointdef(numlist, -1);
    end;
    if (i >= 1) and (i <= sc.cfgsc.ncircle) then
      sc.cfgsc.circleok[i] := True;
  until p = 0;
  Result := msgOK;
end;

function Tf_chart.cmd_ShowRectangle(numlist: string): string;
var
  buf: string;
var
  i, p: integer;
begin
  for i := 1 to sc.cfgsc.nrectangle do
    sc.cfgsc.rectangleok[i] := False;
  repeat
    i := -1;
    p := pos(',', numlist);
    if p > 0 then
    begin
      buf := copy(numlist, 1, p - 1);
      Delete(numlist, 1, p);
      i := strtointdef(buf, -1);
    end
    else
    begin
      i := strtointdef(numlist, -1);
    end;
    if (i >= 1) and (i <= sc.cfgsc.nrectangle) then
      sc.cfgsc.rectangleok[i] := True;
  until p = 0;
  Result := msgOK;
end;

function Tf_chart.cmd_MarkCenter(onoff: string): string;
begin
  sc.cfgsc.ShowCircle := (onoff = 'ON');
  Result := msgOK;
end;

function Tf_chart.cmd_SetPlanisphereTime(onoff: string): string;
begin
  sc.cfgsc.PlanisphereTime := (onoff = 'ON');
  Result := msgOK;
end;

function Tf_chart.cmd_SetPlanisphereDate(onoff: string): string;
begin
  sc.cfgsc.PlanisphereDate := (onoff = 'ON');
  Result := msgOK;
end;

function Tf_chart.cmd_SetFOVProjection(fnum, proj: string): string;
var
  i, n: integer;
begin
  Result := msgFailed;
  i := StrToIntDef(fnum, -1);
  n := pos(proj, ProjectionName);
  if (i >= 0) and (i <= MaxField) and (n >= 0) and (length(proj) = 3) then
  begin
    sc.cfgsc.projname[i] := proj;
    Result := msgOK;
  end;
end;

function Tf_chart.cmd_ShowOnlyMeridian(onoff: string): string;
begin
  sc.cfgsc.ShowOnlyMeridian := (onoff = 'ON');
  Result := msgOK;
end;

function Tf_chart.cmd_ShowAlwaysMeridian(onoff: string): string;
begin
  sc.cfgsc.ShowAlwaysMeridian := (onoff = 'ON');
  Result := msgOK;
end;

function Tf_chart.cmd_Cleanup: string;
begin
  Cleanupmap1Click(nil);
  Result := msgOK;
end;

function Tf_chart.cmd_LoadCircle(fn: string): string;
var
  f: textfile;
  buf1, buf2: string;
  x,y,eq,rot,w,h: double;
begin
  if VerboseMsg then
    WriteTrace(Caption + ' Load Circles from ' + fn);
  try
    AssignFile(f, fn);
    reset(f);
    sc.cfgsc.NumCircle := 0;
    eq:=sc.cfgsc.CurJDUT;
    repeat
      ReadLn(f, buf1);
      if copy(buf1,1,8)='EQUINOX='  then begin
         buf2:=copy(buf1,9,99);
         eq:=StrToFloatDef(buf2,eq);
         continue;
      end;
      Inc(sc.cfgsc.NumCircle);
      if sc.cfgsc.NumCircle = 1 then begin
        rot := StrToFloatDef(words(buf1, blank, 4, 1),NullCoord);
        w := StrToFloatDef(words(buf1, blank, 5, 1),NullCoord);
        h := StrToFloatDef(words(buf1, blank, 6, 1),NullCoord);
        if (rot>NullCoord)and(w>NullCoord)and(h>NullCoord) then begin
           cmd_DefRectangle('10', FormatFloat(f2,w), FormatFloat(f2,h), FormatFloat(f2,rot), '0');
           cmd_ShowCircle('');
           cmd_ShowRectangle('10');
        end;
      end;
      if sc.cfgsc.NumCircle >= MaxCircle then
        break;
      buf2 := words(buf1, blank, 2, 1);
      x := deg2rad * 15 * Str3ToAR(trim(buf2));
      if x = 0 then
      begin
        Dec(sc.cfgsc.NumCircle);
        continue;
      end;
      buf2 := words(buf1, blank, 3, 1);
      y := deg2rad * Str3ToDE(trim(buf2));
      if y = 0 then
      begin
        Dec(sc.cfgsc.NumCircle);
        continue;
      end;
      Precession(eq,sc.cfgsc.JDChart,x,y);
      sc.cfgsc.CircleLst[sc.cfgsc.NumCircle, 1] := x;
      sc.cfgsc.CircleLst[sc.cfgsc.NumCircle, 2] := y;
    until EOF(f);
    CloseFile(f);
    Result := msgOK;
  except
    Result := msgFailed;
  end;
end;

procedure Tf_chart.MenuLoadCircleClick(Sender: TObject);
begin
  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := HomeDir;
  if OpenDialog1.Execute then
  begin
    cmd_LoadCircle(UTF8ToSys(OpenDialog1.FileName));
    Refresh(True, False);
  end;
end;

procedure Tf_chart.SetNightVision(Value: boolean);
var
  i: integer;
  NVColor: Starcolarray;
  NightLabelColor: TColor;
begin
  if Value = FNightVision then
    exit;
  FNightVision := Value;
  case cmain.NightColor of
    0: begin
          NVColor := DfRedColor;
          NightLabelColor := $000000A0;
       end;
    1: begin
          NVColor := DfOrangeColor;
          NightLabelColor := $000080FF;
       end;
  end;
  if FNightVision then
  begin
    SaveColor := sc.plot.cfgplot.color;
    SavebgColor := sc.plot.cfgplot.bgColor;
    for i := 1 to numlabtype do
      SaveLabelColor[i] := sc.plot.cfgplot.labelcolor[i];
    sc.plot.cfgplot.color := NVColor;
    for i := 1 to numlabtype do
      sc.plot.cfgplot.labelcolor[i] := NightLabelColor;
  end
  else
  begin
    if (Savecolor[2] = NVColor[2]) and (Savecolor[11] = NVColor[11]) then
    begin // started with night vision, return to default color as save is also red.
      sc.plot.cfgplot.color := DfColor;
      sc.plot.cfgplot.bgColor := DfColor[0];
      for i := 1 to numlabtype do
        sc.plot.cfgplot.labelcolor[i] := clWhite;
      sc.plot.cfgplot.labelcolor[6] := clYellow;
    end
    else
    begin
      sc.plot.cfgplot.color := SaveColor;
      sc.plot.cfgplot.bgColor := SavebgColor;
      for i := 1 to numlabtype do
        sc.plot.cfgplot.labelcolor[i] := SaveLabelColor[i];
    end;
  end;
  Refresh(True, True);
end;


function Tf_chart.SaveChartImage(format, fn: string; quality: integer = 95): boolean;
var
  JPG: TJpegImage;
  PNG: TPortableNetworkGraphic;
  savelabel, needrefresh: boolean;
  curdir: string;
begin
  Result := False;
  try
    needrefresh := False;
    savelabel := sc.cfgsc.Editlabels;
    format := uppercase(format);
    if VerboseMsg then
      WriteTrace(Caption + ' SaveChartImage');
    try
      if savelabel then
      begin
        sc.cfgsc.Editlabels := False;
        sc.Refresh(False);
        needrefresh := True;
      end;
      if fn = '' then
        fn := 'cdc.bmp';
      if format = '' then
        format := 'BMP';
      curdir := getcurrentdir;
      chdir(TempDir);
      fn := ExpandFileName(fn);
      chdir(curdir);
      if format = 'PNG' then
      begin
        fn := changefileext(fn, '.png');
        PNG := TPortableNetworkGraphic.Create;
        try
          // Convert the bitmap to PNG
          PNG.Assign(sc.plot.cbmp);
          // Save the PNG
          PNG.SaveToFile(fn);
          Result := True;
        finally
          PNG.Free;
        end;
      end
      else if format = 'JPEG' then
      begin
        fn := changefileext(fn, '.jpg');
        JPG := TJpegImage.Create;
        try
          // Convert the bitmap to a Jpeg
          JPG.Assign(sc.plot.cbmp);
          JPG.CompressionQuality := quality;
          // Save the Jpeg
          JPG.SaveToFile(fn);
          Result := True;
        finally
          JPG.Free;
        end;
      end
      else if format = 'BMP' then
      begin
        fn := changefileext(fn, '.bmp');
        sc.plot.cbmp.savetofile(fn);
        Result := True;
      end
      else
        Result := False;
    finally
      if savelabel then
      begin
        sc.cfgsc.Editlabels := True;
      end;
      if needrefresh then
      begin
        sc.Refresh(False);
        SetScrollBar;
      end;
    end;
  except
    on E: Exception do
    begin
      WriteTrace('Saveimg error: ' + E.Message);
      Result := False;
    end;
  end;
end;

// ASCOM and INDI interface

procedure Tf_chart.ConnectTelescope(Sender: TObject; autoconnect: boolean = False);
var
  ok: boolean;
begin
  if Fpop_scope = nil then
  begin
    Fpop_scope := Tpop_scope.Create(self);
    Fpop_scope.SetLang;
    Fpop_scope.csc:=sc.cfgsc;
    Fpop_scope.onObservatoryCoord:=ObservatoryFromTelescope;
  end;
  sc.cfgsc.autorefresh:=true;
  sc.cfgsc.UseSystemTime:=true;
  if Connect1.Checked then
  begin
    Fpop_scope.ScopeShow;
  end
  else
  begin
    Fpop_scope.ScopeLoadConfig;
    Fpop_scope.ScopeSetObs(sc.cfgsc.ObsLatitude, -sc.cfgsc.ObsLongitude, sc.cfgsc.ObsAltitude);
    if autoconnect then
    begin
      Fpop_scope.ScopeConnect(ok);
      Connect1.Checked := True;
    end
    else
    begin
      Fpop_scope.ScopeShow;
    end;
    Fpop_scope.Enabled := True;
    TelescopeTimer.Interval := 2000;
    TelescopeTimer.Enabled := True;
  end;
end;

procedure Tf_chart.SlewTelescope(Sender: TObject);
var
  ra, Dec: double;
  ok: boolean;
begin
  if sc.cfgsc.FindName <> '' then
  begin
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
    if sc.cfgsc.TelescopeJD = 0 then
    begin
      precession(sc.cfgsc.JDChart, sc.cfgsc.CurJDUT, ra, Dec);
    end
    else
    begin
      if sc.cfgsc.ApparentPos then
        mean_equatorial(ra, Dec, sc.cfgsc, True, sc.cfgsc.FindType < ftPla);
      precession(sc.cfgsc.JDChart, sc.cfgsc.TelescopeJD, ra, Dec);
    end;
    ra := rmod(ra + pi2, pi2);
    Fpop_scope.ScopeGoto(ra * rad2deg / 15, Dec * rad2deg, ok);
    Fshowinfo(Format(rsSlewingTo, [ARtoStr(ra * rad2deg / 15), DEToStr(dec * rad2deg)]));
  end
  else
    Fshowinfo(rsNoTargetObje);
end;

procedure Tf_chart.AbortSlewTelescope(Sender: TObject);
begin
  Fpop_scope.ScopeAbortSlew;
  Fshowinfo(rsAbortSlew);
end;

procedure Tf_chart.SyncTelescope(Sender: TObject);
var
  ra, Dec: double;
begin
  if sc.cfgsc.FindName <> '' then
  begin
    ra := sc.cfgsc.FindRA;
    Dec := sc.cfgsc.FindDec;
    if sc.cfgsc.TelescopeJD = 0 then
    begin
      precession(sc.cfgsc.JDChart, sc.cfgsc.CurJDUT, ra, Dec);
    end
    else
    begin
      if sc.cfgsc.ApparentPos then
        mean_equatorial(ra, Dec, sc.cfgsc, True, sc.cfgsc.FindType < ftPla);
      precession(sc.cfgsc.JDChart, sc.cfgsc.TelescopeJD, ra, Dec);
    end;
    ra := rmod(ra + pi2, pi2);
    Fpop_scope.ScopeAlign(sc.cfgsc.FindName, ra * rad2deg / 15, Dec * rad2deg);
    Fshowinfo(Format(rsSyncedTo, [ARtoStr(ra * rad2deg / 15), DEToStr(dec * rad2deg)]));
  end
  else
    Fshowinfo(rsNoTargetObje);
end;

procedure Tf_chart.TelescopeTimerTimer(Sender: TObject);
var
  ra, Dec: double;
  ok, newconnection, slewing: boolean;
begin
  if locked then
    exit;
  TelescopeTimer.Enabled := False;
  try
    TelescopeLock := True;
    try
      ok := False;
      //if VerboseMsg then WriteTrace(caption+' TelescopeTimerTimer');
      newconnection := Connect1.Checked;
      if (Fpop_scope <> nil) then
      begin
        Connect1.Checked := Fpop_scope.ScopeConnected;
        if Connect1.Checked then
        begin
          Fpop_scope.ScopeGetEqSys(sc.cfgsc.TelescopeJD);
          if sc.cfgsc.TelescopeJD <> 0 then
            sc.cfgsc.TelescopeJD := jd(trunc(sc.cfgsc.TelescopeJD), 0, 0, 0);
          Fpop_scope.ScopeGetRaDec(ra, Dec, ok);
          slewing:=Fpop_scope.Slewing;
        end;
      end;
      newconnection := (not newconnection) and Connect1.Checked;
      if newconnection then begin
        if (not sc.cfgsc.TrackOn) then sc.cfgsc.TrackName := rsTelescope;
        Image1.Invalidate;
      end;
      if Connect1.Checked then
      begin
        if ok then
        begin
          if ScopeSlewing and (not slewing) then
             Fshowinfo(rsSlewComplete);
          ScopeSlewing := slewing;
          ra := ra * 15 * deg2rad;
          Dec := Dec * deg2rad;
          if sc.cfgsc.TelescopeJD = 0 then
            precession(sc.cfgsc.CurJDUT, sc.cfgsc.JDChart, ra, Dec)
          else
            precession(sc.cfgsc.TelescopeJD, sc.cfgsc.JDChart, ra, Dec);
          if sc.TelescopeMove(ra, Dec) then
            identlabel.Visible := False;
          if sc.cfgsc.moved then
          begin
            if assigned(FChartMove) then
              FChartMove(self);
          end;
          if (sc.cfgsc.TrackName = rsTelescope) and (not sc.cfgsc.TrackOn) then
          begin
            sc.cfgsc.TrackType := TTequat;
            sc.cfgsc.TrackName := rsTelescope;
            sc.cfgsc.TrackRA := sc.cfgsc.ScopeRa;
            sc.cfgsc.TrackDec := sc.cfgsc.ScopeDec;
            sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
          end;
          sc.cfgsc.scopemark := True;
        end;
        TelescopeTimer.Interval := 500;
        TelescopeTimer.Enabled := True;
        Image1.Invalidate;
      end
      else
      begin
        TelescopeTimer.Interval := 2000;
        TelescopeTimer.Enabled := True;
        if sc.cfgsc.ScopeMark then
        begin
          sc.cfgsc.ScopeMark := False;
          if sc.cfgsc.TrackName = rsTelescope then
            sc.cfgsc.TrackOn := False;
          Refresh(True, True);
        end;
      end;
      if assigned(FUpdateBtn) then
        FUpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, self);
    except
      TelescopeLock := False;
      TelescopeTimer.Enabled := False;
      Connect1.Checked := False;
    end;
  finally
    TelescopeLock := False;
  end;
end;

procedure Tf_chart.CoordJ2000toChart(var ra, de: double);
begin
  precession(jd2000, sc.cfgsc.JDchart, ra, de);
  if sc.cfgsc.ApparentPos then
    apparent_equatorial(ra, de, sc.cfgsc, True, True);
end;

procedure Tf_chart.CoordCharttoJ2000(var ra, de: double);
begin
  if sc.cfgsc.ApparentPos then
    mean_equatorial(ra, de, sc.cfgsc, True, True);
  precession(sc.cfgsc.JDChart, jd2000, ra, de);
end;

procedure Tf_chart.RefreshImage(Sender: TObject);
begin
  Image1.Invalidate;
end;

procedure Tf_chart.UpdObsListTime(Sender: TObject);
begin
  if f_obslist.ObjCount > 0 then
    f_obslist.Refresh;
end;

function Tf_chart.GetTelescopeMove: Tfloat2func;
begin
  Result := sc.onTelescopeMove;
end;

procedure Tf_chart.SetTelescopeMove(Value: Tfloat2func);
begin
  sc.onTelescopeMove := Value;
end;

procedure Tf_chart.cmdEq2Hz(ra, de: double; var a, h: double);
begin
  Eq2Hz(sc.cfgsc.CurSt - ra, de, a, h, sc.cfgsc);
  a := rmod(a + pi, pi2);
end;

procedure Tf_chart.cmdHz2Eq(a, h: double; var ra, de: double);
begin
  a := rmod(a - pi, pi2);
  Hz2Eq(a, h, ra, de, sc.cfgsc);
  ra := Rmod(sc.cfgsc.CurST - ra + pi2, pi2);
end;

procedure Tf_chart.cmdEq2Gal(ra, de: double; var l, b: double);
begin
  Eq2Gal(ra, de, l, b, sc.cfgsc);
end;

procedure Tf_chart.cmdGal2Eq(l, b: double; var ra, de: double);
begin
  Gal2Eq(l, b, ra, de, sc.cfgsc);
end;

procedure Tf_chart.cmdEq2Ecl(ra, de: double; var l, b: double);
begin
  Eq2Ecl(ra, de, sc.cfgsc.ecl, l, b);
end;

procedure Tf_chart.cmdEcl2Eq(l, b: double; var ra, de: double);
begin
  Ecl2Eq(l, b, sc.cfgsc.ecl, ra, de);
end;

procedure Tf_chart.ObservatoryFromTelescope(Sender: TObject);
begin
  if Sender = Fpop_scope then
  begin
     sc.cfgsc.ObsLatitude:=Fpop_scope.Latitude;
     sc.cfgsc.ObsLongitude:=-Fpop_scope.Longitude;
     sc.cfgsc.ObsAltitude:=Fpop_scope.Elevation;
     sc.cfgsc.ObsName:='Telescope';
  end;
  AutoRefresh;
end;

function Tf_chart.cmd_TrackObject(onoff: string): string;
begin
  if onoff = 'ON' then
  begin
    if (((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or
          (sc.cfgsc.TrackType = TTequat) or (sc.cfgsc.TrackType = TTbody)) and (sc.cfgsc.TrackName <> '') then
        begin
          sc.cfgsc.TrackOn := True;
          Refresh(True, False);
          result:=msgOK;
        end
        else
        begin
          sc.cfgsc.TrackOn := False;
          result:=msgFailed;
        end;
  end
  else if onoff = 'OFF' then
  begin
    sc.cfgsc.TrackOn := False;
    result:=msgOK;
  end
  else begin
    result:=msgFailed;
  end;
end;

end.
