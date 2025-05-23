unit pu_main;

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
 Main form for CDC/Skychart application
}

interface

uses
  {$ifdef mswindows}
  Windows, ShlObj, Registry,
  {$endif}
  {$ifdef unix}
  BaseUnix,
  {$endif}
  lclstrconsts, XMLConf, u_help, u_translation, cu_catalog, cu_planet, cu_fits, cu_calceph,
  cu_database, fu_chart, cu_tcpserver, pu_config_time, pu_config_observatory, pu_precession,
  pu_config_display, pu_config_pictures, pu_indigui, pu_config_catalog, pu_prepoint, u_grappavar,
  pu_config_solsys, pu_config_chart, pu_config_system, pu_config_internet, pu_updcatalog,
  cu_radec, pu_config_calendar, pu_planetinfo, cu_sampclient, cu_vodata, pu_catgen,
  pu_obslist, fu_script, pu_scriptengine, u_constant, u_util, UScaleDPI, pu_configdirect,
  u_ccdconfig, blcksock, synsock, dynlibs, FileUtil, ExtendedNotebook, LCLVersion, LCLType,
  InterfaceBase, LCLIntf, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  Math, StdCtrls, Dialogs, Buttons, ExtCtrls, ComCtrls, StdActns, types, cu_httpdownload,
  Printers, ActnList, IniFiles, Spin, Clipbrd, MultiFrame, ChildFrame, pu_selectlayout,
  BGRABitmap, BGRABitmapTypes, LResources, enhedits, cu_healpix, downloaddialog,
  LazHelpHTML_fix, UniqueInstance, ButtonPanel, ExtDlgs;

type

  { Tf_main }

  Tf_main = class(TForm)
    MenuToolbox9: TMenuItem;
    MenuUpdCatalog: TMenuItem;
    PolePrecession: TAction;
    FileRenameChart: TAction;
    LockMagnitude: TAction;
    MenuEditToolbar2: TMenuItem;
    MenuItem2: TMenuItem;
    FileRenameChart1: TMenuItem;
    MenuPrecession: TMenuItem;
    MenuItemFileNew: TMenuItem;
    MenuItemCloseChart: TMenuItem;
    MenuItemRenameTab: TMenuItem;
    MenuLockMagnitude: TMenuItem;
    PopupTab: TPopupMenu;
    StatusCopy: TMenuItem;
    MenuShowVO: TMenuItem;
    MenuShowUserObject: TMenuItem;
    MenuLockChart: TMenuItem;
    MenuUpdGrs: TMenuItem;
    MenuMosaic: TMenuItem;
    Mosaic: TAction;
    MenuUpdDeltaT: TMenuItem;
    StatusPopup: TPopupMenu;
    SavePictureDialog1: TSavePictureDialog;
    TabControl1: TExtendedNotebook;
    UniqueInstance1: TUniqueInstance;
    ViewAllTollbar: TAction;
    MenuItem1: TMenuItem;
    ViewMainMenu: TAction;
    AnimBackward: TAction;
    Img16Night: TImageList;
    Img16Day: TImageList;
    Img32Night: TImageList;
    Img32Day: TImageList;
    Img22Night: TImageList;
    Img22Day: TImageList;
    PanelToolBarMain: TPanel;
    PopupToolbar1: TMenuItem;
    PopupToolbar2: TMenuItem;
    PopupToolbar: TPopupMenu;
    Trajectories: TAction;
    ContainerPanel: TPanel;
    MenuTrajectory: TMenuItem;
    N6: TMenuItem;
    MenuUpdSatellite: TMenuItem;
    MenuUpdSoft: TMenuItem;
    MenuUpdComet: TMenuItem;
    MenuUpdAsteroid: TMenuItem;
    SubUpdate: TMenuItem;
    MenuMousemode: TMenuItem;
    MenuScaleMode: TMenuItem;
    N20: TMenuItem;
    MenuToolboxConfig: TMenuItem;
    SubAnimation: TMenuItem;
    MenuTimeDec: TMenuItem;
    MenuTimeInc: TMenuItem;
    MenuTimeReset: TMenuItem;
    MenuToolbox8: TMenuItem;
    MenuToolbox1: TMenuItem;
    MenuToolbox2: TMenuItem;
    MenuToolbox3: TMenuItem;
    MenuToolbox4: TMenuItem;
    MenuToolbox5: TMenuItem;
    MenuToolbox6: TMenuItem;
    MenuToolbox7: TMenuItem;
    SubToolbox: TMenuItem;
    ScriptPanel: TPanel;
    Splitter1: TSplitter;
    ToolBarFOV: TPanel;
    tbFOV1: TSpeedButton;
    tbFOV10: TSpeedButton;
    tbFOV2: TSpeedButton;
    tbFOV3: TSpeedButton;
    tbFOV4: TSpeedButton;
    tbFOV5: TSpeedButton;
    tbFOV6: TSpeedButton;
    tbFOV7: TSpeedButton;
    tbFOV8: TSpeedButton;
    tbFOV9: TSpeedButton;
    TimeValPanel: TPanel;
    ResetRotation: TAction;
    Divider_ToolBarMain_end: TToolButton;
    ViewChartInfo: TAction;
    ViewChartLegend: TAction;
    Animation: TAction;
    ActionListWindow: TActionList;
    ActionListTelescope: TActionList;
    ActionListChart: TActionList;
    ActionListView: TActionList;
    ActionListSetup: TActionList;
    ActionListEdit: TActionList;
    ActionListFile: TActionList;
    SetupPictures: TAction;
    ScaleMode: TAction;
    MouseMode: TAction;
    ShowUobj: TAction;
    ShowVO: TAction;
    TrackTelescope: TAction;
    TelescopeSetup: TAction;
    ShowCompass: TAction;
    SetFOV02: TAction;
    SetFOV03: TAction;
    SetFOV04: TAction;
    SetFOV05: TAction;
    SetFOV06: TAction;
    SetFOV07: TAction;
    SetFOV08: TAction;
    SetFOV09: TAction;
    SetFOV10: TAction;
    SetFOV01: TAction;
    rotate180: TAction;
    ListImg: TAction;
    PlanetInfo: TAction;
    ViewNightVision: TAction;
    ConfigPopup: TAction;
    Obslist: TAction;
    MenuHelpPDF: TMenuItem;
    N34: TMenuItem;
    MenuEditToolbar: TMenuItem;
    MenuObslist: TMenuItem;
    SampDownload: TDownloadDialog;
    MenuSAMPConnect: TMenuItem;
    MenuSAMPDisconnect: TMenuItem;
    MenuSAMPStatus: TMenuItem;
    MenuSAMPSetup: TMenuItem;
    SubSAMP: TMenuItem;
    MenuTelescopeAbortSlew: TMenuItem;
    TelescopeAbortSlew: TAction;
    MenuListImg: TMenuItem;
    MenuViewPlanetInfo: TMenuItem;
    SetupCalendar: TAction;
    EditTimeVal: TEdit;
    MenuResetChart: TMenuItem;
    CloseTimer: TTimer;
    SubLabels: TMenuItem;
    MenuChartInfo: TMenuItem;
    MenuChartLegend: TMenuItem;
    MenuShowCompass: TMenuItem;
    MenuCalendarConfig: TMenuItem;
    MenuResetRot: TMenuItem;
    MenuRot180: TMenuItem;
    MultiFrame1: TMultiFrame;
    MenuShowLabels: TMenuItem;
    MenuResetLanguage: TMenuItem;
    InitTimer: TTimer;
    MenuTrackTelescope: TMenuItem;
    MenuPrintPreview: TMenuItem;
    MenuTelescopeSetup: TMenuItem;
    MenuNextChild: TMenuItem;
    EditCopy1: TAction;
    MenuViewClock: TMenuItem;
    MenuHelpFaq: TMenuItem;
    MenuHelpQuickStart: TMenuItem;
    AnimationTimer: TTimer;
    TimeVal: TMouseUpDown;
    ViewClock: TAction;
    HTMLBrowserHelpViewer1: THTMLBrowserHelpViewer;
    HTMLHelpDatabase1: THTMLHelpDatabase;
    N26: TMenuItem;
    MenuEditLabels: TMenuItem;
    MenuDSS: TMenuItem;
    MenuBlinkImage: TMenuItem;
    MenuTrack: TMenuItem;
    MenuSyncChart: TMenuItem;
    N28: TMenuItem;
    Menuswitchbackground: TMenuItem;
    MenuPosition: TMenuItem;
    MenuViewListObj: TMenuItem;
    MenuSearch: TMenuItem;
    MenuZoom: TMenuItem;
    SubStarNum: TMenuItem;
    SubNebNum: TMenuItem;
    MenuMoreStar: TMenuItem;
    MenuLessStar: TMenuItem;
    MenuMoreNeb: TMenuItem;
    MenuLessNeb: TMenuItem;
    MenuConfig: TMenuItem;
    SetupConfig: TAction;
    MenuChartConfig: TMenuItem;
    MenuSolsysConfig: TMenuItem;
    MenuGeneralConfig: TMenuItem;
    MenuInternetConfig: TMenuItem;
    MenuVariableStar: TMenuItem;
    SetupInternet: TAction;
    SetupSystem: TAction;
    SetupSolSys: TAction;
    SetupChart: TAction;
    BlinkImage: TAction;
    P1L1: TLabel;
    P0L1: TLabel;
    MenuReleaseNotes: TMenuItem;
    MenuViewScrollBar: TMenuItem;
    SetupCatalog: TAction;
    MenuHomePage: TMenuItem;
    MenuMaillist: TMenuItem;
    MenuBugReport: TMenuItem;
    N12: TMenuItem;
    N11: TMenuItem;
    MenuPictureConfig: TMenuItem;
    MenuShowBackgroundImage: TMenuItem;
    LPanels0: TPanel;
    LPanels1: TPanel;
    MenuCatalogConfig: TMenuItem;
    SetPictures: TAction;
    MenuDisplayConfig: TMenuItem;
    SetupDisplay: TAction;
    MenuObsConfig: TMenuItem;
    SetupObservatory: TAction;
    MenuDateConfig: TMenuItem;
    SetupTime: TAction;
    ButtonMoreStar: TImage;
    ButtonLessStar: TImage;
    ButtonMoreNeb: TImage;
    ButtonLessNeb: TImage;
    Shape1: TShape;
    topmessage: TMenuItem;
    MainMenu1: TMainMenu;
    SubFile: TMenuItem;
    MenuFileNew: TMenuItem;
    MenuFileOpen: TMenuItem;
    MenuFileClose: TMenuItem;
    SubWindow: TMenuItem;
    SubHelp: TMenuItem;
    N1: TMenuItem;
    MenuExit: TMenuItem;
    MenuWindowCascade: TMenuItem;
    MenuWindowTileHor: TMenuItem;
    MenuHelpAbout: TMenuItem;
    OpenDialog: TOpenDialog;
    MenuFileSave: TMenuItem;
    SubEdit: TMenuItem;
    MenuCopy: TMenuItem;
    FileNew1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    MenuWindowTileVert: TMenuItem;
    Print1: TAction;
    MenuPrint: TMenuItem;
    starshape: TImage;
    MenuPrintSetup: TMenuItem;
    N2: TMenuItem;
    SubSetup: TMenuItem;
    Search1: TAction;
    PanelLeft: TPanel;
    ToolBarLeft: TToolBar;
    PanelRight: TPanel;
    ToolBarRight: TToolBar;
    PanelBottom: TPanel;
    PPanels0: TPanel;
    PPanels1: TPanel;
    PanelTop: TPanel;
    ToolBarMain: TToolBar;
    MagPanel: TPanel;
    zoomplus: TAction;
    zoomminus: TAction;
    quicksearch: TComboBox;
    FlipX: TAction;
    FlipY: TAction;
    MenuViewToolsBar: TMenuItem;
    SaveDialog: TSaveDialog;
    MenuViewStatusBar: TMenuItem;
    SubView: TMenuItem;
    SaveConfiguration: TAction;
    MenuSaveConfigurationNow: TMenuItem;
    SaveConfigOnExit: TAction;
    MenuSaveConfigurationOnExit: TMenuItem;
    Undo: TAction;
    Redo: TAction;
    Autorefresh: TTimer;
    rot_plus: TAction;
    rot_minus: TAction;
    GridEQ: TAction;
    Grid: TAction;
    switchstars: TAction;
    switchbackground: TAction;
    SaveImage: TAction;
    MenuSaveImage: TMenuItem;
    ViewServerInfo: TAction;
    MenuServerInformation: TMenuItem;
    toN: TAction;
    toE: TAction;
    toS: TAction;
    toW: TAction;
    toZenith: TAction;
    allSky: TAction;
    TimeInc: TAction;
    TimeDec: TAction;
    TimeReset: TAction;
    TimeU: TComboBox;
    listobj: TAction;
    FilePrintSetup1: TAction;
    TelescopeConnect: TAction;
    TelescopeSlew: TAction;
    TelescopeSync: TAction;
    MoreStar: TAction;
    LessStar: TAction;
    MoreNeb: TAction;
    LessNeb: TAction;
    ToolBarObj: TToolBar;
    ShowStars: TAction;
    ShowNebulae: TAction;
    ShowPictures: TAction;
    ShowLines: TAction;
    ShowPlanets: TAction;
    ShowAsteroids: TAction;
    ShowComets: TAction;
    ShowMilkyWay: TAction;
    ShowLabels: TAction;
    ShowConstellationLine: TAction;
    ShowConstellationLimit: TAction;
    ShowGalacticEquator: TAction;
    ShowEcliptic: TAction;
    ShowMark: TAction;
    ShowObjectbelowHorizon: TAction;
    EquatorialProjection: TAction;
    AltAzProjection: TAction;
    EclipticProjection: TAction;
    GalacticProjection: TAction;
    SubToolBar: TMenuItem;
    MenuViewMainBar: TMenuItem;
    MenuViewLeftBar: TMenuItem;
    MenuViewRightBar: TMenuItem;
    MenuViewObjectBar: TMenuItem;
    N5: TMenuItem;
    Calendar: TAction;
    MenuHelpContents: TMenuItem;
    MenuUndo: TMenuItem;
    MenuRedo: TMenuItem;
    MenuZoomPlus: TMenuItem;
    MenuZoomMinus: TMenuItem;
    SubTelescope: TMenuItem;
    MenuTelescopeConnect: TMenuItem;
    MenuTelescopeSlew: TMenuItem;
    MenuTelescopeSync: TMenuItem;
    SubChart: TMenuItem;
    SubProjection: TMenuItem;
    MenuEquatorialProjection: TMenuItem;
    MenuAltAzProjection: TMenuItem;
    MenuEclipticProjection: TMenuItem;
    MenuGalacticProjection: TMenuItem;
    SubTransformation: TMenuItem;
    MenuFlipX: TMenuItem;
    MenuFlipY: TMenuItem;
    MenuRotPlus: TMenuItem;
    MenuRotMinus: TMenuItem;
    SubFieldofVision: TMenuItem;
    MenuSetFov1: TMenuItem;
    MenuSetFov2: TMenuItem;
    MenuSetFov3: TMenuItem;
    MenuSetFov4: TMenuItem;
    MenuSetFov5: TMenuItem;
    MenuSetFov6: TMenuItem;
    MenuSetFov7: TMenuItem;
    MenuSetFov8: TMenuItem;
    MenuSetFov9: TMenuItem;
    MenuSetFov10: TMenuItem;
    MenuAllSky: TMenuItem;
    SubShowHorizon: TMenuItem;
    MenutoN: TMenuItem;
    MenutoS: TMenuItem;
    MenutoE: TMenuItem;
    MenutoW: TMenuItem;
    SubShowObjects: TMenuItem;
    MenuShowStars: TMenuItem;
    MenuShowNebulae: TMenuItem;
    MenuShowPictures: TMenuItem;
    MenuShowLines: TMenuItem;
    MenuShowPlanets: TMenuItem;
    MenuShowAsteroids: TMenuItem;
    MenuShowComets: TMenuItem;
    MenuShowMilkyWay: TMenuItem;
    SubShowGrid: TMenuItem;
    MenuShowGrid: TMenuItem;
    MenuShowGridEQ: TMenuItem;
    MenuShowConstellationLine: TMenuItem;
    MenuShowConstellationLimit: TMenuItem;
    MenuShowGalacticEquator: TMenuItem;
    MenuShowEcliptic: TMenuItem;
    MenuShowMark: TMenuItem;
    MenuShowObjectbelowthehorizon: TMenuItem;
    MenuCalendar: TMenuItem;
    ShowBackgroundImage: TAction;
    Position: TAction;
    SyncChart: TAction;
    Track: TAction;
    ZoomBar: TAction;
    DSSImage: TAction;
    MenuNightVision: TMenuItem;
    EditLabels: TAction;
    N7: TMenuItem;
    MenuFullScreen: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    ChildControl: TPanel;
    N10: TMenuItem;
    Cascade1: TAction;
    TileHorizontal1: TAction;
    TileVertical1: TAction;
    BtnRestoreChild: TSpeedButton;
    BtnCloseChild: TSpeedButton;
    MenuMaximize: TMenuItem;
    Maximize: TAction;
    TelescopePanel: TAction;
    MenuTelescopeControlPanel: TMenuItem;
    ViewFullScreen: TAction;
    procedure AnimationExecute(Sender: TObject);
    procedure AnimationTimerTimer(Sender: TObject);
    procedure BlinkImageExecute(Sender: TObject);
    procedure FileRenameChartExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LockMagnitudeExecute(Sender: TObject);
    procedure MenuLockChartClick(Sender: TObject);
    procedure MDEditToolBar(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MenuBugReportClick(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure ConfigPopupExecute(Sender: TObject);
    procedure EditTimeValChange(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpFaq1Execute(Sender: TObject);
    procedure MenuHelpPDFClick(Sender: TObject);
    procedure HelpQS1Execute(Sender: TObject);
    procedure MenuHomePageClick(Sender: TObject);
    procedure InitTimerTimer(Sender: TObject);
    procedure ListImgExecute(Sender: TObject);
    procedure MagPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MenuMaillistClick(Sender: TObject);
    procedure MenuSAMPConnectClick(Sender: TObject);
    procedure MenuSAMPDisconnectClick(Sender: TObject);
    procedure MenuSAMPStatusClick(Sender: TObject);
    procedure MenuSAMPSetupClick(Sender: TObject);
    procedure MenuEditToolbarClick(Sender: TObject);
    procedure MenuToolboxConfigClick(Sender: TObject);
    procedure MenuToolboxClick(Sender: TObject);
    procedure MenuUpdAsteroidClick(Sender: TObject);
    procedure MenuUpdCatalogClick(Sender: TObject);
    procedure MenuUpdCometClick(Sender: TObject);
    procedure MenuUpdDeltaTClick(Sender: TObject);
    procedure MenuUpdGrsClick(Sender: TObject);
    procedure MenuUpdSatelliteClick(Sender: TObject);
    procedure MenuUpdSoftClick(Sender: TObject);
    procedure MosaicExecute(Sender: TObject);
    procedure MouseModeExecute(Sender: TObject);
    procedure MultiFrame1CreateChild(Sender: TObject);
    procedure MultiFrame1DeleteChild(Sender: TObject);
    procedure PlanetInfoExecute(Sender: TObject);
    procedure PopupTabPopup(Sender: TObject);
    procedure PopupToolbar2Click(Sender: TObject);
    procedure PolePrecessionExecute(Sender: TObject);
    procedure ResetRotationExecute(Sender: TObject);
    procedure rotate180Execute(Sender: TObject);
    procedure SavePictureDialog1CanClose(Sender: TObject; var CanClose: boolean
      );
    procedure SavePictureDialog1TypeChange(Sender: TObject);
    procedure ScaleModeExecute(Sender: TObject);
    procedure SetupPicturesExecute(Sender: TObject);
    procedure ShowCompassExecute(Sender: TObject);
    procedure ShowUobjExecute(Sender: TObject);
    procedure ShowVOExecute(Sender: TObject);
    procedure StatusCopyClick(Sender: TObject);
    procedure tbFOVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure TelescopeSetupExecute(Sender: TObject);
    procedure TimeUChange(Sender: TObject);
    procedure ToolBarFOVResize(Sender: TObject);
    procedure TrackTelescopeExecute(Sender: TObject);
    procedure TrajectoriesExecute(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; const Parameters: array of String);
    procedure ViewChartInfoExecute(Sender: TObject);
    procedure ViewChartLegendExecute(Sender: TObject);
    procedure ViewMainMenuExecute(Sender: TObject);
    procedure ViewNightVisionExecute(Sender: TObject);
    procedure ObslistExecute(Sender: TObject);
    procedure MenuPrintPreviewClick(Sender: TObject);
    procedure MenuResetLanguageClick(Sender: TObject);
    procedure SetupCalendarExecute(Sender: TObject);
    procedure TelescopeAbortSlewExecute(Sender: TObject);
    procedure MenuNextChildClick(Sender: TObject);
    procedure Print1Execute(Sender: TObject);
    procedure MenuReleaseNotesClick(Sender: TObject);
    procedure ResetAllLabels1Click(Sender: TObject);
    procedure ResetDefaultChartExecute(Sender: TObject);
    procedure SetupCatalogExecute(Sender: TObject);
    procedure SetupChartExecute(Sender: TObject);
    procedure SetupConfigExecute(Sender: TObject);
    procedure SetupDisplayExecute(Sender: TObject);
    procedure SetupInternetExecute(Sender: TObject);
    procedure SetupObservatoryExecute(Sender: TObject);
    procedure SetPicturesExecute(Sender: TObject);
    procedure SetupSolSysExecute(Sender: TObject);
    procedure SetupSystemExecute(Sender: TObject);
    procedure SetupTimeExecute(Sender: TObject);
    procedure TimeValChangingEx(Sender: TObject; var AllowChange: boolean;
      NewValue: smallint; Direction: TUpDownDirection);
    procedure MenuVariableStarClick(Sender: TObject);
    procedure SubViewClick(Sender: TObject);
    procedure MenuViewToolsBarClick(Sender: TObject);
    procedure ViewClockExecute(Sender: TObject);
    procedure MenuViewScrollBarClick(Sender: TObject);
    procedure zoomplusExecute(Sender: TObject);
    procedure zoomminusExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quicksearchKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure quicksearchClick(Sender: TObject);
    procedure FlipXExecute(Sender: TObject);
    procedure FlipYExecute(Sender: TObject);
    procedure SetFOVClick(Sender: TObject);
    procedure FileSaveAs1Execute(Sender: TObject);
    procedure ViewStatusBarClick(Sender: TObject);
    procedure SaveConfigurationExecute(Sender: TObject);
    procedure SaveConfigOnExitExecute(Sender: TObject);
    procedure UndoExecute(Sender: TObject);
    procedure RedoExecute(Sender: TObject);
    procedure AutorefreshTimer(Sender: TObject);
    procedure rot_plusExecute(Sender: TObject);
    procedure rot_minusExecute(Sender: TObject);
    procedure GridEQExecute(Sender: TObject);
    procedure GridExecute(Sender: TObject);
    procedure switchstarsExecute(Sender: TObject);
    procedure switchbackgroundExecute(Sender: TObject);
    procedure SaveImageExecute(Sender: TObject);
    procedure ViewServerInfoExecute(Sender: TObject);
    procedure toNExecute(Sender: TObject);
    procedure toEExecute(Sender: TObject);
    procedure toSExecute(Sender: TObject);
    procedure toWExecute(Sender: TObject);
    procedure toZenithExecute(Sender: TObject);
    procedure allSkyExecute(Sender: TObject);
    procedure TimeResetExecute(Sender: TObject);
    procedure TimeIncExecute(Sender: TObject);
    procedure listobjExecute(Sender: TObject);
    procedure FilePrintSetup1Execute(Sender: TObject);
    procedure TelescopeConnectExecute(Sender: TObject);
    procedure TelescopeSlewExecute(Sender: TObject);
    procedure TelescopeSyncExecute(Sender: TObject);
    procedure LessNebExecute(Sender: TObject);
    procedure LessStarExecute(Sender: TObject);
    procedure MoreNebExecute(Sender: TObject);
    procedure MoreStarExecute(Sender: TObject);
    procedure ShowStarsExecute(Sender: TObject);
    procedure ShowNebulaeExecute(Sender: TObject);
    procedure ShowPicturesExecute(Sender: TObject);
    procedure ShowLinesExecute(Sender: TObject);
    procedure ShowPlanetsExecute(Sender: TObject);
    procedure ShowAsteroidsExecute(Sender: TObject);
    procedure ShowCometsExecute(Sender: TObject);
    procedure ShowMilkyWayExecute(Sender: TObject);
    procedure ShowLabelsExecute(Sender: TObject);
    procedure ShowConstellationLineExecute(Sender: TObject);
    procedure ShowConstellationLimitExecute(Sender: TObject);
    procedure ShowGalacticEquatorExecute(Sender: TObject);
    procedure ShowEclipticExecute(Sender: TObject);
    procedure ShowMarkExecute(Sender: TObject);
    procedure ShowObjectbelowHorizonExecute(Sender: TObject);
    procedure EquatorialProjectionExecute(Sender: TObject);
    procedure AltAzProjectionExecute(Sender: TObject);
    procedure EclipticProjectionExecute(Sender: TObject);
    procedure GalacticProjectionExecute(Sender: TObject);
    procedure ViewMainBarClick(Sender: TObject);
    procedure ViewObjectBarClick(Sender: TObject);
    procedure ViewLeftBarClick(Sender: TObject);
    procedure ViewRightBarClick(Sender: TObject);
    procedure CalendarExecute(Sender: TObject);
    procedure HelpContents1Execute(Sender: TObject);
    procedure EditCopy1Execute(Sender: TObject);
    procedure SetFovExecute(Sender: TObject);
    procedure ShowBackgroundImageExecute(Sender: TObject);
    procedure PositionExecute(Sender: TObject);
    procedure Search1Execute(Sender: TObject);
    procedure SyncChartExecute(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure TrackExecute(Sender: TObject);
    procedure ZoomBarExecute(Sender: TObject);
    procedure DSSImageExecute(Sender: TObject);
    procedure EditLabelsExecute(Sender: TObject);
    procedure MultiFrame1ActiveChildChange(Sender: TObject);
    procedure MultiFrame1Maximize(Sender: TObject);
    procedure BtnRestoreChildClick(Sender: TObject);
    procedure BtnCloseChildClick(Sender: TObject);
    procedure WindowCascade1Execute(Sender: TObject);
    procedure WindowTileHorizontal1Execute(Sender: TObject);
    procedure WindowTileVertical1Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure MaximizeExecute(Sender: TObject);
    procedure TelescopePanelExecute(Sender: TObject);
    procedure ViewFullScreenExecute(Sender: TObject);
    procedure LoadTheme(ThemeName:string);
    procedure SetTheme;
    procedure SetStarShape;
    procedure ToolButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ToolButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
  private
    { Private declarations }
    ConfigTime: Tf_configtime;
    ConfigObservatory: Tf_configobservatory;
    ConfigChart: Tf_configchart;
    ConfigSolsys: Tf_configsolsys;
    ConfigSystem: Tf_configsystem;
    ConfigInternet: Tf_configinternet;
    ConfigDisplay: Tf_configdisplay;
    ConfigPictures: Tf_configpictures;
    ConfigCatalog: Tf_configcatalog;
    ConfigCalendar: Tf_configcalendar;
    basecaption, kioskpwd: string;
    rotspeed: double;
    NeedRestart, NeedToInitializeDB, ConfirmSaveConfig, InitOK, RestoreState,
    ForceClose, SaveBlinkBG, InitMaximized: boolean;
    InitialChartNum, Animcount: integer;
    AutoRefreshLock: boolean;
    AnimationEnabled: boolean;
    AnimationDirection: integer;
    Compass, arrow: TBGRABitmap;
    CursorImage1: TCursorImage;
    SaveState: TWindowState;
    samp: TSampClient;
    numscript, SaveScriptPanelWidth: integer;
    Fscript: array of Tf_script;
    ActiveScript: integer;
    FTelescopeConnected: boolean;
    NoMenu: boolean;
    AccelList: array[0..MaxMenulevel] of string;
    httpdownload: THTTPBigDownload;
    procedure ProcessParams1;
    procedure ProcessParams2;
    procedure ProcessParamsQuit;
    procedure ShowError(msg: string);
    procedure SetButtonImage(bsize,msize:integer);
    function CreateChild(const CName: string; copyactive: boolean;
      cfg1: Tconf_skychart; cfgp: Tconf_plot; locked: boolean = False): boolean;
    procedure RefreshAllChild(applydef: boolean);
    procedure SyncChild;
    procedure GetLanguage;
    procedure GetAppDir;
    procedure ScaleMainForm;
    procedure ResizeBtn;
    procedure ViewTopPanel;
    procedure RefreshActiveChart(Sender: TObject);
    procedure ActivatePictures(Sender: TObject);
    procedure ApplyConfig(Sender: TObject);
    procedure ApplyConfigTime(Sender: TObject);
    procedure ApplyConfigObservatory(Sender: TObject);
    procedure ApplyConfigDisplay(Sender: TObject);
    procedure ApplyConfigPictures(Sender: TObject);
    procedure ApplyConfigCatalog(Sender: TObject);
    procedure SetChildFocus(Sender: TObject);
    procedure SetNightVision(night: boolean);
    procedure SetupObservatoryPage(page: integer; posx: integer = 0; posy: integer = 0);
    procedure SetupCalendarPage(page: integer);
    procedure ApplyConfigCalendar(Sender: TObject);
    procedure SetupTimePage(page: integer);
    procedure SetupDisplayPage(pagegroup: integer);
    procedure SetupPicturesPage(page: integer; action: integer = 0);
    procedure SetupCatalogPage(page: integer);
    procedure SetupChartPage(page: integer);
    procedure ApplyConfigChart(Sender: TObject);
    procedure SetupSolsysPage(page: integer; directdownload: boolean = False);
    procedure ApplyConfigSolsys(Sender: TObject);
    procedure SetupSystemPage(page: integer);
    procedure ApplyConfigSystem(Sender: TObject);
    procedure SetupInternetPage(page: integer);
    procedure ApplyConfigInternet(Sender: TObject);
    procedure FirstSetup;
    procedure SelectLayout(allowcancel: boolean=false);
    procedure ShowReleaseNotes(shownext: boolean);
    function Find(kind: integer; num: string; def_ra: double = 0; def_de: double = 0): string;
    procedure FindInfo(Sender: TObject);
    function SaveChart(fn: string): string;
    function OpenChart(fn: string): string;
    function LoadDefaultChart(fn: string): string;
    function ShowPlanetInfo(pg: string): string;
    procedure PlanetInfoPage(pg: integer; cursorpos: boolean = False);
    function SetGCat(path, shortname, active, min, max: string): string;
    procedure UpdateSAMPmenu;
    procedure SAMPStart(auto: boolean = False);
    procedure SAMPStop;
    procedure SAMPurlToFile(url, nam, typ: string; var fn: string);
    procedure SAMPClientChange(Sender: TObject);
    procedure SAMPDisconnect(Sender: TObject);
    procedure SAMPcoordpointAtsky(ra, Dec: double);
    procedure SAMPImageLoadFits(image_name, image_id, url: string);
    procedure SAMPTableLoadVotable(table_name, table_id, url: string);
    procedure SAMPTableHighlightRow(table_id, url, row: string);
    procedure SAMPTableSelectRowlist(table_id, url: string; rowlist: TStringList);
    procedure TelescopeMove(origin: string; ra, de: double);
    procedure TelescopeChange(origin: string; tc: boolean);
    procedure ApplyScript(Sender: TObject);
    procedure IndiGUIdestroy(Sender: TObject);
    procedure PositionApply(Sender: TObject);
    procedure ZoomBarApply(Sender: TObject);
    function QuickDownload(url, fn: string): boolean;
    function LoadMPCORB(fn:string): string;
    procedure EditToolBar(barnum: integer);
    procedure EnableAsteroid(Sender: TObject);
    procedure DisableAsteroid(Sender: TObject);
    procedure UpdateAstExt;
    procedure PolePrecessionChange(Sender: TObject);
    procedure SaveCatalogConfig(Sender: TObject);
    procedure OpenUpdCatalog(Sender: TObject);
    procedure OpenUpdCatalogAsync(Data: PtrInt);
    procedure OpenCatalogSetup(Sender: TObject);
    procedure OpenCatalogSetupAsync(Data: PtrInt);
    procedure RunCatgen(Sender: TObject);
    procedure RunCatgenAsync(Data: PtrInt);
    procedure quicksearchTop(data: PtrInt);

  public
    { Public declarations }
    cfgm: Tconf_main;
    def_cfgsc, cfgs: Tconf_skychart;
    def_cfgplot, cfgp: Tconf_plot;
    catalog: Tcatalog;
    fits: TFits;
    planet: Tplanet;
    cdcdb: TCDCdb;
    serverinfo, topmsg: string;
    TCPDaemon: TTCPDaemon;
    CanShowScrollbar: boolean;
    Config_Version: string;
    showsplash: boolean;
    Closing: boolean;
    procedure ReadChartConfig(filename: string; usecatalog, resizemain: boolean;
      var cplot: Tconf_plot; var csc: Tconf_skychart);
    procedure ReadPrivateConfig(filename: string);
    procedure ReadDefault;
    procedure UpdateConfig;
    procedure SavePrivateConfig(filename: string);
    procedure SaveQuickSearch(filename: string);
    procedure SaveChartConfig(filename: string; child: TChildFrame;
      overwrite: boolean = False);
    procedure SaveVersion;
    procedure SaveDefault;
    procedure SetDefault;
    procedure SetLang;
    procedure ChangeLanguage(newlang: string);
    procedure InitFonts;
    procedure activateconfig(cmain: Tconf_main; csc: Tconf_skychart;
      ccat: Tconf_catalog; cshr: Tconf_shared; cplot: Tconf_plot; cdss: Tconf_dss;
      applyall: boolean);
    procedure SetLPanel1(txt1: string; origin: string = ''; sendmsg: boolean = False;
      Sender: TObject = nil; txt2: string = ''; txt2000: string = '');
    procedure SetLPanel0(txt: string);
    procedure SetTopMessage(txt: string; Sender: TObject);
    procedure SetTitleMessage(txt: string; Sender: TObject);
    procedure updatebtn(fx, fy: integer; tc: boolean; Sender: TObject);
    function NewChart(cname: string): string;
    function CloseChart(cname: string): string;
    function ListChart: string;
    function SelectChart(cname: string): string;
    function RenameChart(newname: string): string;
    function HelpCmd(cname: string): string;
    function GetSelectedObject: string;
    function ExecuteCmd(cname: string; arg: TStringList): string;
    function CometMark(cname: string; arg: TStringList): string;
    function AsteroidMark(cname: string; arg: TStringList): string;
    function GetScopeRates(cname: string; arg: TStringList): string;
    procedure SendInfo(Sender: TObject; origin, str: string);
    function GenericSearch(cname, Num: string; var ar1, de1: double;
      idresult: boolean = True; track: boolean = False; gtype: string = ''): boolean;
    procedure ObsListSearch(obj: string; ra, de: double);
    procedure ObsListSlew(obj: string; ra, de: double);
    procedure GetObjectCoord(obj: string; var lbl: string; var ra, de: double);
    procedure ObsListChange(Sender: TObject);
    procedure StartServer;
    procedure StopServer;
    function GetUniqueName(cname: string; forcenumeric: boolean): string;
    procedure showdetailinfo(chart: string; ra, Dec: double; cat, nm, desc: string);
    procedure DetailToObslist(chart: string; ra, Dec: double; cat, nm, desc: string);
    procedure CenterFindObj(chart: string);
    procedure NeighborObj(chart: string);
    procedure GrappaVarNeighborObj(chart: string);
    procedure ConnectDB(updversion: string = '');
    procedure ImageSetFocus(Sender: TObject);
    procedure SetScriptMenu(Sender: TObject);
    procedure ListInfo(buf, msg: string);
    function TCPClientConnected: boolean;
    procedure GetTCPInfo(i: integer; var buf: string);
    procedure KillTCPClient(i: integer);
    procedure PrintSetup(Sender: TObject);
    procedure GetChartConfig(csc: Tconf_skychart);
    procedure DrawChart(csc: Tconf_skychart);
    procedure SaveAndRestart(Sender: TObject);
    procedure ClearAndRestart;
    procedure SetPerformanceOptions;
    procedure InitializeDB(Sender: TObject);
    procedure FinishAsteroidUpgrade(Sender: TObject);
    procedure Init;
    procedure InitToolBar;
    procedure InitScriptPanel;
    procedure SetScriptMenuCaption;
    procedure ShowScriptPanel(n: integer); overload;
    procedure ShowScriptPanel(n: integer; showonly: boolean); overload;
    procedure ShowConfigPanel(show: boolean);
    procedure HideConfigDirectAsync(Data: PtrInt);
    procedure ViewToolsBar(ForceVisible: boolean);
    procedure InitDS2000;
    function PrepareAsteroid(jd1, jd2, step: double; msg: TStrings): boolean;
    procedure RecomputeAsteroid;
    procedure ChartMove(Sender: TObject);
    procedure ImageSetup(Sender: TObject);
    procedure GetActiveChart(var active_chart: string);
    procedure TCPShowError(var msg: string);
    procedure TCPShowSocket(var msg: string);
    procedure GetTwilight(jd0: double; out ht: double);
    procedure SendCoordpointAtsky(client: string; ra, de: double);
    procedure SendVoTable(client, tname, tid, url: string);
    procedure SendImageFits(client, imgname, imgid, url: string);
    procedure SendSelectRow(tableid, url, row: string);
    procedure LoadDeltaT;
    procedure LoadLeapseconds(CanUpdate: boolean=true);
    procedure LoadIERS;
    procedure DownloadLeapSeconds;
    procedure DownloadLeapSecondsComplete;
    procedure DownloadIERSComplete;
    procedure LoadVartype;
    procedure LoadVarsubtype;
  end;

var
  f_main: Tf_main;

implementation

{$R *.lfm}

uses
  LazFileUtils, LazUTF8,
    {$ifdef LCLgtk2}
  gtk2proc,
    {$endif}
    {$ifdef lclqt5}
  qtint,
    {$endif}
    {$ifdef lclqt6}
  qtint,
    {$endif}
    {$if (lcl_fullversion >= 1070000)}
  lclplatformdef,
    {$endif}
  LCLProc, pu_detail, pu_about, pu_info, pu_getdss, u_projection, pu_config,
  pu_printsetup, pu_calendar, pu_position, pu_search, pu_zoom, pu_edittoolbar,
  pu_scriptconfig, pu_splash, pu_manualtelescope, pu_print, pu_clock, pu_mosaic;

procedure Tf_main.ShowError(msg: string);
begin
  WriteTrace(msg);
  ShowMessage(msg);
end;

function Tf_main.CreateChild(const CName: string; copyactive: boolean;
  cfg1: Tconf_skychart; cfgp: Tconf_plot; locked: boolean = False): boolean;
var
  Child: Tf_chart;
  cp: TChildFrame;
  maxi: boolean;
  w, h, t, l: integer;
begin
  // allow for a reasonable number of chart
  if (MultiFrame1.ChildCount >= MaxWindow) then
  begin
    SetLpanel1(rsTooManyOpenW);
    Result := False;
    exit;
  end;
  // copy active child config
  if copyactive and (MultiFrame1.Activeobject is Tf_chart) then
  begin
    cfg1.Assign((MultiFrame1.Activeobject as Tf_chart).sc.cfgsc);
    cfgp.Assign((MultiFrame1.Activeobject as Tf_chart).sc.plot.cfgplot);
    cfg1.scopemark := False;
    cfg1.scope2mark := False;
    cfg1.horizonpicturevalid := False;
    maxi := MultiFrame1.maximized;
    w := MultiFrame1.ActiveChild.Width;
    h := MultiFrame1.ActiveChild.Height;
    t := -1;
    l := -1;
  end
  else
  begin
    maxi := cfgm.maximized;
    w := cfg1.winx;
    h := cfg1.winy;
    t := cfg1.wintop;
    l := cfg1.winleft;
  end;
  // create a new child window
  cp := MultiFrame1.NewChild(CName);
  Child := Tf_chart.Create(cp);
  cp.DockedObject := child;
  if locked then
    Child.lock_refresh := True;
  Inc(cfgm.MaxChildID);
  Child.tag := cfgm.MaxChildID;
  Child.VertScrollBar.Visible := MenuViewScrollBar.Checked;
  Child.HorScrollBar.Visible := MenuViewScrollBar.Checked;
  if cfgm.KioskMode then
    Child.Image1.PopupMenu := nil;
  cp.Caption := CName;
  Child.Caption := CName;
  Child.sc.catalog := catalog;
  Child.sc.Fits := Fits;
  Child.sc.planet := planet;
  Child.sc.cdb := cdcdb;
  Child.cmain := cfgm;
  Child.sc.plot.cfgplot.Assign(cfgp);
  Child.sc.plot.cfgplot.starshapesize := starshape.Picture.bitmap.Width div 11;
  Child.sc.plot.cfgplot.starshapew := Child.sc.plot.cfgplot.starshapesize div 2;
  Child.sc.plot.starshape := starshape.Picture.Bitmap;
  Child.sc.plot.compassrose := Compass;
  Child.sc.plot.compassarrow := arrow;
  Child.sc.cfgsc.Assign(cfg1);
  Child.sc.cfgsc.chartname := CName;
  Child.onImageSetFocus := ImageSetFocus;
  Child.OnSetScriptMenu := SetScriptMenu;
  Child.onSetFocus := SetChildFocus;
  Child.onShowTopMessage := SetTopMessage;
  Child.onShowTitleMessage := SetTitleMessage;
  Child.OnUpdateBtn := UpdateBtn;
  Child.OnChartMove := ChartMove;
  Child.OnImageSetup := ImageSetup;
  Child.onShowInfo := SetLpanel1;
  Child.OnSendInfo := SendInfo;
  Child.onShowCoord := SetLpanel0;
  Child.onListInfo := ListInfo;
  Child.onSendCoordpointAtsky := SendCoordpointAtsky;
  Child.onSendImageFits := SendImageFits;
  Child.onSendSelectRow := SendSelectRow;
  Child.onPlanetInfo := PlanetInfoExecute;
  Child.onTelescopeMove := TelescopeMove;
  if (not Child.sc.cfgsc.TrackOn) and (Child.sc.cfgsc.Projpole = Altaz) then
  begin
    Child.sc.cfgsc.TrackOn := True;
    Child.sc.cfgsc.TrackType := TTaltaz;
  end;
  if not maxi then
  begin
    cp.Width := w;
    cp.Height := h;
    if t >= 0 then
      cp.top := t;
    if l >= 0 then
      cp.left := l;
  end;
  MultiFrame1.maximized := maxi;
  Result := True;
  Child.locked := False;
  Child.lock_refresh := False;
  Child.RefreshTimer.Enabled := True;
end;

procedure Tf_main.RefreshAllChild(applydef: boolean);
var
  i: integer;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      with MultiFrame1.Childs[i].DockedObject as Tf_chart do
      begin
        sc.Fits := Fits;
        sc.planet := planet;
        sc.cdb := cdcdb;
        if applydef then
        begin
          sc.cfgsc.Assign(def_cfgsc);
          sc.cfgsc.FindOk := False;
          sc.plot.cfgplot.Assign(def_cfgplot);
        end;
        if VerboseMsg then
          WriteTrace('RefreshAllChild');
        AutoRefresh;
      end;
end;

procedure Tf_main.SyncChild;
var
  i, y, m, d: integer;
  ra, de, jda, t, tz: double;
  st: boolean;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    ra := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.racentre;
    de := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.decentre;
    jda := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.jdchart;
    y := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.curyear;
    m := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.curmonth;
    d := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.curday;
    t := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.curtime;
    tz := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.Timezone;
    st := (MultiFrame1.ActiveObject as Tf_chart).sc.cfgsc.UseSystemTime;
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if (MultiFrame1.Childs[i].DockedObject is Tf_chart) and
        (MultiFrame1.Childs[i].DockedObject <> MultiFrame1.ActiveObject) then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          precession(jda, sc.cfgsc.jdchart, ra, de);
          sc.cfgsc.UseSystemTime := st;
          sc.cfgsc.curyear := y;
          sc.cfgsc.curmonth := m;
          sc.cfgsc.curday := d;
          sc.cfgsc.curtime := t;
          sc.cfgsc.Timezone := tz;
          sc.cfgsc.TrackOn := False;
          sc.cfgsc.racentre := ra;
          sc.cfgsc.decentre := de;
          if VerboseMsg then
            WriteTrace('SyncChild');
          Refresh(True, False);
        end;
  end;
end;

procedure Tf_main.AutorefreshTimer(Sender: TObject);
var
  i: integer;
begin
  if AutoRefreshLock then
    exit;
  try
    if VerboseMsg then
      WriteTrace('AutorefreshTimer');
    AutoRefreshLock := True;
    Autorefresh.Enabled := False;
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          if sc.cfgsc.autorefresh and sc.cfgsc.UseSystemTime and
            (not sc.cfgsc.ShowScale) then
            AutoRefresh;
        end;
  finally
    AutoRefreshLock := False;
    Autorefresh.Enabled := True;
  end;
end;

function Tf_main.GetUniqueName(cname: string; forcenumeric: boolean): string;
var
  xname: array of string;
  i, n: integer;
  ok: boolean;
  sep: string;
begin
  cname:=validsqlname(cname);
  cname:=validfilename(cname);
  if copy(cname, length(cname), 1) = '_' then
    sep := ''
  else
    sep := '_';
  setlength(xname, MultiFrame1.ChildCount);
  for i := 0 to MultiFrame1.ChildCount - 1 do
    xname[i] := MultiFrame1.Childs[i].Caption;
  if forcenumeric then
    n := 1
  else
    n := 0;
  repeat
    ok := True;
    if n = 0 then
      Result := cname
    else
      Result := cname + sep + IntToStr(n);
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if xname[i] = Result then
        ok := False;
    Inc(n);
  until ok;
end;

procedure Tf_main.FileNew1Execute(Sender: TObject);
var
  cname: string;
begin
  cname:='';
  if InputQuery(rsNewChart,rsChartName+':',cname) then begin
    if cname='' then
      cname := GetUniqueName(rsChart_, True)
    else
      cname := GetUniqueName(cname, false);
    CreateChild(cname, True, def_cfgsc, def_cfgplot);
    SelectChart(cname);
  end;
end;

function Tf_main.SaveChart(fn: string): string;
begin
  if (fn <> '') and (MultiFrame1.ActiveObject is Tf_chart) then
  begin
    SaveChartConfig(SafeUTF8ToSys(fn), MultiFrame1.ActiveChild, True);
    Result := msgOK;
  end
  else
    Result := msgFailed;
end;

procedure Tf_main.FileSaveAs1Execute(Sender: TObject);
begin
  Savedialog.DefaultExt := 'cdc3';
  if Savedialog.InitialDir = '' then
    Savedialog.InitialDir := HomeDir;
  if (MultiFrame1.ActiveObject is Tf_chart) then
    savedialog.FileName := trim(Tf_chart(MultiFrame1.ActiveObject).Caption) + '.cdc3';
  savedialog.Filter := 'Cartes du Ciel 3 File|*.cdc3|All Files|*.*';
  savedialog.Title := rsSaveTheCurre;
  if SaveDialog.Execute then
    SaveChart(SaveDialog.Filename);
end;

function Tf_main.OpenChart(fn: string): string;
var
  nam: string;
  p: integer;
begin
  if FileExistsUTF8(fn) then
  begin
    cfgp.Assign(def_cfgplot);
    cfgs.Assign(def_cfgsc);
    ReadChartConfig(SafeUTF8ToSys(fn), True, MultiFrame1.Maximized, cfgp, cfgs);
    nam := stringreplace(extractfilename(fn), blank, '_', [rfReplaceAll]);
    p := pos('.', nam);
    if p > 0 then
      nam := copy(nam, 1, p - 1);
    MultiFrame1.Maximized := cfgm.maximized;
    CreateChild(GetUniqueName(nam, False), False, cfgs, cfgp);
    Result := msgOK;
  end
  else
    Result := msgNotFound + ' ' + fn;
end;

function Tf_main.LoadDefaultChart(fn: string): string;
begin
  if VerboseMsg then
    WriteTrace('LoadDefaultChart ' + fn);
  if FileExistsUTF8(fn) then
  begin
    cfgp.Assign(def_cfgplot);
    cfgs.Assign(def_cfgsc);
    ReadChartConfig(SafeUTF8ToSys(fn), True, True, def_cfgplot, def_cfgsc);
    Tf_chart(MultiFrame1.Childs[0].DockedObject).sc.cfgsc.Assign(def_cfgsc);
    Tf_chart(MultiFrame1.Childs[0].DockedObject).sc.plot.cfgplot.Assign(def_cfgplot);
    Result := msgOK;
  end
  else if FileExists(fn) then
  begin
    cfgp.Assign(def_cfgplot);
    cfgs.Assign(def_cfgsc);
    ReadChartConfig(fn, True, True, def_cfgplot, def_cfgsc);
    Tf_chart(MultiFrame1.Childs[0].DockedObject).sc.cfgsc.Assign(def_cfgsc);
    Tf_chart(MultiFrame1.Childs[0].DockedObject).sc.plot.cfgplot.Assign(def_cfgplot);
    Result := msgOK;
  end
  else
    Result := msgNotFound + ' ' + fn;
end;

function Tf_main.SetGCat(path, shortname, active, min, max: string): string;
var
  i, j, x, v: integer;
begin
  if VerboseMsg then
    WriteTrace('SetGCat ' + path + blank + shortname + blank + active +
      blank + min + blank + max);
  Result := msgFailed;
  val(min, x, v);
  if v <> 0 then
    exit;
  val(max, x, v);
  if v <> 0 then
    exit;
  if not fileexists(slash(path) + shortname + '.hdr') then
    exit;
  path := ExtractSubPath(Appdir, path);
  i := -1;
  for j := 0 to catalog.cfgcat.GCatNum - 1 do
    if catalog.cfgcat.GCatLst[j].shortname = trim(shortname) then
      i := j;
  if i < 0 then
  begin
    catalog.cfgcat.GCatNum := catalog.cfgcat.GCatNum + 1;
    SetLength(catalog.cfgcat.GCatLst, catalog.cfgcat.GCatNum);
    i := catalog.cfgcat.GCatNum - 1;
  end;
  catalog.cfgcat.GCatLst[i].shortname := trim(shortname);
  catalog.cfgcat.GCatLst[i].path := trim(path);
  val(min, x, v);
  if v = 0 then
    catalog.cfgcat.GCatLst[i].min := x
  else
    catalog.cfgcat.GCatLst[i].min := 0;
  val(max, x, v);
  if v = 0 then
    catalog.cfgcat.GCatLst[i].max := x
  else
    catalog.cfgcat.GCatLst[i].max := 0;
  catalog.cfgcat.GCatLst[i].Actif := (active = '1');
  catalog.cfgcat.GCatLst[i].magmax := 0;
  catalog.cfgcat.GCatLst[i].Name := '';
  catalog.cfgcat.GCatLst[i].cattype := 0;
  catalog.cfgcat.GCatLst[i].ForceColor := False;
  catalog.cfgcat.GCatLst[i].ForceLabel := False;
  catalog.cfgcat.GCatLst[i].Search := False;
  catalog.cfgcat.GCatLst[i].col := 0;
  catalog.cfgcat.GCatLst[i].startype := 0;
  catalog.cfgcat.GCatLst[i].starsize := 0;
  if catalog.cfgcat.GCatLst[i].Actif then
  begin
    if not catalog.GetInfo(catalog.cfgcat.GCatLst[i].path,
      catalog.cfgcat.GCatLst[i].shortname, catalog.cfgcat.GCatLst[i].magmax,
      catalog.cfgcat.GCatLst[i].cattype, catalog.cfgcat.GCatLst[i].startype,
      catalog.cfgcat.GCatLst[i].starsize, catalog.cfgcat.GCatLst[i].version,
      catalog.cfgcat.GCatLst[i].Name) then
      catalog.cfgcat.GCatLst[i].Actif := False;
  end;
  if (active = '1') and (not catalog.cfgcat.GCatLst[i].Actif) then
  begin
    catalog.removeGcat(trim(shortname));
    exit;
  end;
  Result := msgOK;
end;

procedure Tf_main.FileOpen1Execute(Sender: TObject);
begin
  if OpenDialog.InitialDir = '' then
    OpenDialog.InitialDir := HomeDir;
  OpenDialog.Filter := 'Cartes du Ciel 3 File|*.cdc3|All Files|*.*';
  OpenDialog.Title := rsOpenAChart;
  if OpenDialog.Execute then
  begin
    Savedialog.InitialDir := ExtractFilePath(OpenDialog.FileName);
    OpenChart(OpenDialog.FileName);
  end;
end;

procedure Tf_main.FormActivate(Sender: TObject);
begin
  ImageSetFocus(Sender);
end;

procedure Tf_main.FormShow(Sender: TObject);
begin
  try
    if VerboseMsg then
      WriteTrace('Enter Tf_main.FormShow');
    InitFonts;
    SetLpanel1('');
  except
    on E: Exception do begin
      WriteTrace('FormShow InitFonts error: ' + E.Message);
      MessageDlg('FormShow InitFonts error: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;
  // Init tool bar
  if NightVision then
  begin
    if VerboseMsg then
      WriteTrace('Night vision');
    ViewNightVision.Checked := NightVision;
  end;
  try
  SetTheme;
  except
    on E: Exception do begin
      WriteTrace('FormShow SetTheme error: ' + E.Message);
      MessageDlg('FormShow SetTheme error: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;
  try
  InitToolBar;
  except
    on E: Exception do begin
      WriteTrace('FormShow InitToolBar error: ' + E.Message);
      MessageDlg('FormShow InitToolBar error: ' + E.Message, mtError, [mbOK], 0);
    end;
  end;
  if InitMaximized then begin
    WindowState := wsMaximized;
  end;
  InitTimer.Enabled := True;
  InitOK := True;
  if VerboseMsg then
    WriteTrace('Exit Tf_main.FormShow');
end;

procedure Tf_main.InitTimerTimer(Sender: TObject);
var
  i: integer;
begin
  InitTimer.Enabled := False;
  if VerboseMsg then
    WriteTrace('Enter Tf_main.InitTimerTimer');
  MultiFrame1.setActiveChild(0);
  // ensure a first chart is draw, even if it usually result in a double refresh on launch
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      with MultiFrame1.Childs[i].DockedObject as Tf_chart do
      begin
        RefreshTimer.Enabled := False;
        RefreshTimer.Enabled := True;
        f_main.ActiveControl := Image1;
        if sc.cfgsc.TelescopeAutoconnect then cmd_ConnectTelescope;
      end;
  if ScriptPanel.Visible then
    Fscript[ActiveScript].ActivateEvent;
  if NoMenu then
    menu:=nil;
  if VerboseMsg then
    WriteTrace('Exit Tf_main.InitTimerTimer');
end;

{$ifdef unix}
procedure RecvSignal(sig: longint); cdecl;
begin
  WriteTrace('Receiving signal ' + IntToStr(sig));
  case sig of
    1: f_main.ResetDefaultChartExecute(nil);
    15: f_main.Close;
  end;
end;

{$endif}

procedure Tf_main.InitDS2000;
var
  srcdir, dsdir: string;
  i: integer;
const
  numfn = 4;
  fn: array [1..numfn] of string = ('ds2000.cdc3', 'd2k.hdr', 'd2k.info2', 'd2k.prj');
begin
  try
    srcdir := systoutf8(slash(SampleDir));
    dsdir := systoutf8(slash(PrivateDir) + slash('ds2000'));
    if not DirectoryExistsutf8(dsdir) then
      ForceDirectoriesutf8(dsdir);
    // Upgrade
    for i := 1 to numfn do
    begin
      if fileexists(dsdir + fn[i]) and (FileAge(srcdir + fn[i]) >
        FileAge(dsdir + fn[i])) then
      begin
        DeleteFile(dsdir + fn[i]);
        CopyFile(srcdir + fn[i], dsdir + fn[i], True);
      end;
    end;
    // Initial copy
    for i := 1 to numfn do
    begin
      if not fileexists(dsdir + fn[i]) then
        CopyFile(srcdir + fn[i], dsdir + fn[i], True);
    end;
  except
  end;
end;

procedure Tf_main.Init;
var
  i,p,i1,i2: integer;
  firstuse,cnum,usecursor: boolean;
  cname,buf: string;
begin
  firstuse := False;
  try
    if VerboseMsg then
      WriteTrace('Enter Tf_main.Init');
    // some initialisation that need to be done after all the forms are created.
    if VerboseMsg then
      WriteTrace('SetDefault');
    SetDefault;
    if VerboseMsg then
      WriteTrace('ReadDefault');
    ReadDefault;
    if (def_cfgsc.ObsTZ = '') and FileExists(slash(appdir) +
      'skychart_valdereuil.ini') then
    begin
      CopyFile(SysToUTF8(slash(appdir) + 'skychart_valdereuil.ini'),
        SysToUTF8(Configfile));
      ReadDefault;
    end;
    if VerboseMsg then
      WriteTrace('Create forms');
    planet := Tplanet.Create(self);
    Fits := TFits.Create(self);
    f_info.onGetTCPinfo := GetTCPInfo;
    f_info.onKillTCP := KillTCPClient;
    f_info.onPrintSetup := PrintSetup;
    f_info.OnShowDetail := showdetailinfo;
    f_info.OnAddToObsList:=DetailToObslist;
    f_detail.OnCenterObj := CenterFindObj;
    f_detail.OnNeighborObj := NeighborObj;
    f_detail.OnVarNeighborObj := GrappaVarNeighborObj;
    f_detail.OnKeydown := FormKeyDown;
    f_obslist.planet := planet;
    f_obslist.FileNameEdit1.FileName := slash(HomeDir) + f_obslist.DefaultList;
    if VerboseMsg then
      WriteTrace('InitDS2000');
    InitDS2000;
    if VerboseMsg then
      WriteTrace('Load deltat');
    LoadDeltaT;
    LoadIERS;
    LoadLeapseconds(true);
    jdtoday:=DateTimetoJD(now);
    if VerboseMsg then
      WriteTrace('Load VarType');
    LoadVartype;
    LoadVarsubtype;
    // must read db configuration before to create this one!
    if VerboseMsg then
      WriteTrace('Create DB');
    cdcdb := TCDCdb.Create(self);
    cdcdb.onInitializeDB := InitializeDB;
    cdcdb.onFinishAsteroidUpgrade := FinishAsteroidUpgrade;
    planet.cdb := cdcdb;
    f_search.cdb := cdcdb;
    planet.SetDE(slash(PrivateCatalogDir) + 'jpleph', slash(Appdir) + slash('data') + 'jpleph');
    if libcalceph<>0 then InitCalcephBody(def_cfgsc);
    if VerboseMsg then
      WriteTrace('Background Image');
    if def_cfgsc.BackgroundImage = '' then
    begin
      def_cfgsc.BackgroundImage := slash(PictureDir);
      if not DirectoryExists(def_cfgsc.BackgroundImage) then
        forcedirectories(def_cfgsc.BackgroundImage);
    end;
    if VerboseMsg then
      WriteTrace('Constellation');
    catalog.LoadVariableAlias(slash(Appdir) + slash('data') + 'alias');
    if VerboseMsg then
      WriteTrace('Constellation');
    if def_cfgsc.ConstLatinLabel then
      catalog.LoadConstellation(cfgm.Constellationpath, 'Latin')
    else
      catalog.LoadConstellation(cfgm.Constellationpath, Lang);
    catalog.LoadConstL(cfgm.ConstLfile);
    catalog.LoadConstB(cfgm.ConstBfile);
    catalog.LoadMilkywaydot(slash(appdir) + slash('data') + slash('milkyway') + 'milkyway.dat');
    catalog.LoadStarName(slash(appdir) + slash('data') + slash('common_names'), Lang);
    catalog.GetGaiaVersion;
    // open gaia grappavar
    if DirectoryExists(slash(PrivateCatalogDir)+'grappavar') then
      OpenGrappavar(slash(PrivateCatalogDir)+'grappavar');
    f_search.cfgshr := catalog.cfgshr;
    f_search.showpluto := def_cfgsc.ShowPluto;
    f_search.SesameUrlNum := cfgm.SesameUrlNum;
    f_search.SesameCatNum := cfgm.SesameCatNum;
    f_search.onFindInfo := FindInfo;
    f_search.Init;
    if VerboseMsg then
      WriteTrace('Connect DB');
    ConnectDB(Config_Version);
    if VerboseMsg then
      WriteTrace('Cursor');

    {$ifdef lclqt5}
      buf:=GetQtVersion;
      WriteTrace('Running on Qt version: '+buf);
      i:=pos('.',buf);               // do not use QtVersionMinor because of bug in qtint
      if not TryStrToInt(copy(buf,1,i-1),i1) then i1:=5;
      Delete(buf,1,i);
      i:=pos('.',buf);
      if not TryStrToInt(copy(buf,1,i-1),i2) then i2:=0;
      usecursor:=(i1>=5)and(i2>=12); // cursor crash with old version, work with version in focal
    {$else}
      {$ifdef lclqt6}
        buf:=GetQtVersion;
        WriteTrace('Running on Qt version: '+buf);
        usecursor:=true;
      {$else}
        usecursor:=true;
      {$endif}
    {$endif}

    if usecursor and fileexists(slash(appdir) + slash('data') + slash('Themes') + slash('default') + 'retic.cur') then
    begin
      try
        CursorImage1.LoadFromFile(SysToUTF8(slash(appdir) + slash('data') +
          slash('Themes') + slash('default') + 'retic.cur'));
        Screen.Cursors[crRetic] := CursorImage1.Handle;
      except
        crRetic := crCross;
      end;
    end
    else
      crRetic := crCross;
    if VerboseMsg then
      WriteTrace('Compass');
    if fileexists(slash(appdir) + slash('data') + slash('Themes') +
      slash('default') + 'compass.bmp') then
      Compass.LoadFromFile(SysToUTF8(slash(appdir) + slash('data') +
        slash('Themes') + slash('default') + 'compass.bmp'));
    if fileexists(slash(appdir) + slash('data') + slash('Themes') +
      slash('default') + 'arrow.bmp') then
      arrow.LoadFromFile(SysToUTF8(slash(appdir) + slash('data') +
        slash('Themes') + slash('default') + 'arrow.bmp'));
    if VerboseMsg then
      WriteTrace('Starshape file');
    if (cfgm.starshape_file <> '') and (FileExists(utf8tosys(cfgm.starshape_file))) then
    begin
      starshape.Picture.LoadFromFile(cfgm.starshape_file);
    end;
    if VerboseMsg then
      WriteTrace('Timezone');
    def_cfgsc.tz.TimeZoneFile :=
      ZoneDir + StringReplace(def_cfgsc.ObsTZ, '/', PathDelim, [rfReplaceAll]);
    if def_cfgsc.tz.TimeZoneFile = '' then
      firstuse := True;
    if firstuse and Application.ShowMainForm then
    begin // no setup forms if --daemon
      if VerboseMsg then
        WriteTrace('First setup');
      FirstSetup;
    end;
    application.ProcessMessages; // apply any resizing
    if VerboseMsg then
      WriteTrace('Init calendar');
    f_calendar.planet := planet;
    f_calendar.cdb := cdcdb;
    f_calendar.cmain := cfgm;
    f_calendar.tle1.Text := cfgm.tlelst;
    f_calendar.OnGetChartConfig := GetChartConfig;
    f_calendar.OnUpdateChart := DrawChart;
    f_calendar.eclipsepath := slash(appdir) + slash('data') + slash('eclipses');
    if cfgm.KioskMode then
    begin
      if VerboseMsg then
        WriteTrace('Initialize kiosk mode');
      if not cfgm.KioskDebug then
        ViewFullScreenExecute(nil);
      MenuViewScrollBarClick(nil);
      SubFile.Visible := False;
      SubEdit.Visible := False;
      SubSetup.Visible := False;
      SubView.Visible := False;
      SubChart.Visible := False;
      SubTelescope.Visible := False;
      SubWindow.Visible := False;
      SubUpdate.Visible := False;
      SubHelp.Visible := False;
      topmessage.Visible := False;
      PanelToolBarMain.Visible := False;
      PanelLeft.Visible := PanelToolBarMain.Visible;
      PanelRight.Visible := PanelToolBarMain.Visible;
      ToolBarObj.Visible := PanelToolBarMain.Visible;
      PanelBottom.Visible := PanelToolBarMain.Visible;
      MenuViewToolsBar.Checked := PanelToolBarMain.Visible;
      MenuViewMainBar.Checked := PanelToolBarMain.Visible;
      MenuViewObjectBar.Checked := PanelToolBarMain.Visible;
      MenuViewLeftBar.Checked := PanelToolBarMain.Visible;
      MenuViewRightBar.Checked := PanelToolBarMain.Visible;
      MenuViewStatusBar.Checked := PanelToolBarMain.Visible;
      ViewTopPanel;
      FormResize(nil);
    end;
    if VerboseMsg then
      WriteTrace('Create default chart');
    if FirstChart<>'' then begin
      ReadChartConfig(SafeUTF8ToSys(ExpandFileNameUTF8(FirstChart)), True, false, def_cfgplot, def_cfgsc);
      cname := def_cfgsc.chartname;
      if cname='' then
        cname := stringreplace(extractfilename(FirstChart), blank, '_', [rfReplaceAll]);
      p := pos('.', cname);
      if p > 0 then
        cname := copy(cname, 1, p - 1);
      cname:=GetUniqueName(cname, false);
    end
    else begin
      cname := def_cfgsc.chartname;
      if cname='' then
         cname:=GetUniqueName(rsChart_, True)
      else
         cname:=GetUniqueName(cname, false);
    end;
    CreateChild(cname, True, def_cfgsc, def_cfgplot, True);
    if InitialChartNum > 1 then
    begin
      if VerboseMsg then
        WriteTrace('Load ' + IntToStr(InitialChartNum - 1) + ' supplementary charts');
      for i := 1 to InitialChartNum - 1 do
      begin
        try
          cfgp.Assign(def_cfgplot);
          cfgs.Assign(def_cfgsc);
          ReadChartConfig(configfile + IntToStr(i), True, False, cfgp, cfgs);
          if cfgs.chartname='' then begin
            cname:=rsChart_;
            cnum:=true;
          end
          else begin
            cname:=cfgs.chartname;
            cnum:=false;
          end;
          CreateChild(GetUniqueName(cname, cnum), False, cfgs, cfgp);
        except
        end;
      end;
    end;
    MultiFrame1.SetActiveChild(0);
    for i := 0 to MultiFrame1.ChildCount - 1 do
       if MultiFrame1.Childs[i].DockedObject is Tf_chart then
         Tf_chart(MultiFrame1.Childs[i].DockedObject).locked:=true;
    if VerboseMsg then
      WriteTrace('Read params');
    ProcessParams2;
    if cfgm.AutostartServer then
    begin
      if VerboseMsg then
        WriteTrace('Start server');
      StartServer;
    end;
{$ifdef unix}
    if VerboseMsg then
      WriteTrace('Add signal handler');
    CdcSigAction(@RecvSignal);
{$endif}
    if Application.ShowMainForm and (
      (DirectoryExists(cfgm.ImagePath + 'ongc') and (cdcdb.CountImages('ONGC') = 0)) or
      (DirectoryExists(cfgm.ImagePath + 'sac') and (cdcdb.CountImages('SAC') = 0))
      ) then
    begin
      if VerboseMsg then
        WriteTrace('Init picture DB');
      SetupPicturesPage(0, 1);
    end;
    if (not firstuse) and (config_version < cdcver) and Application.ShowMainForm then
      ShowReleaseNotes(False);
    if cfgm.SampAutoconnect then
    begin
      SAMPStart(True);
    end;
    f_print.cm := cfgm;
    f_obslist.onSelectObject := ObsListSearch;
    f_obslist.onGetObjectCoord := GetObjectCoord;
    f_obslist.onObjLabelChange := ObsListChange;
    f_obslist.onSlew := ObsListSlew;
    if (cfgm.InitObsList <> '') and (FileExists(cfgm.InitObsList)) then
    begin
      f_obslist.FileNameEdit1.FileName := SysToUTF8(cfgm.InitObsList);
    end;
    f_obslist.cfgsc := Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc;
    f_obslist.AllLabels.Checked := f_obslist.cfgsc.ObslistAlLabels;
    f_obslist.LimitType := cfgm.ObsListLimitType;
    f_obslist.AirmassCombo.Text := cfgm.ObslistAirmass;
    f_obslist.LimitAirmassTonight.Checked := cfgm.ObslistAirmassLimit1;
    f_obslist.LimitAirmassNow.Checked := cfgm.ObslistAirmassLimit2;
    f_obslist.MeridianSide := cfgm.ObsListMeridianSide;
    f_obslist.HourAngleCombo.Text := cfgm.ObslistHourAngle;
    f_obslist.LimitHourangleTonight.Checked := cfgm.ObslistHourAngleLimit1;
    f_obslist.LimitHourangleNow.Checked := cfgm.ObslistHourAngleLimit2;
    f_obslist.LoadObsList;
    Autorefresh.Interval := max(10, min(60,cfgm.autorefreshdelay)) * 1000;
    AutoRefreshLock := False;
    Autorefresh.Enabled := True;
    AnimationEnabled := False;
    for i := 0 to MultiFrame1.ChildCount - 1 do
       if MultiFrame1.Childs[i].DockedObject is Tf_chart then
         Tf_chart(MultiFrame1.Childs[i].DockedObject).locked:=false;
    InitScriptPanel;
    f_updcatalog.onSaveConfig := SaveCatalogConfig;
    f_updcatalog.onOpenSetup := OpenCatalogSetup;
    f_updcatalog.onChartRefresh := RefreshActiveChart;
    f_updcatalog.onActivatePictures := ActivatePictures;
    f_updcatalog.catalog:=catalog;
    f_updcatalog.cmain:=cfgm;
    f_updcatalog.cdb := cdcdb;
    f_updcatalog.ConsistencyCheck;
    if firstuse then
      Application.QueueAsyncCall(OpenUpdCatalogAsync,0)
    else if Config_Version< '4.3a' then begin
       // new in 4.3
       SelectLayout(true);
       Application.QueueAsyncCall(OpenUpdCatalogAsync,0);
    end;
    if not Application.ShowMainForm then
      InitOK := True;  // no formshow if --daemon
  except
    on E: Exception do
    begin
      WriteTrace('Initialization error: ' + E.Message);
      MessageDlg('Initialization error: ' + E.Message, mtError, [mbClose], 0);
    end;
  end;
  if VerboseMsg then
    WriteTrace('Exit Tf_main.Init');
end;

procedure Tf_main.ShowReleaseNotes(shownext: boolean);
var
  buf: string;
begin
  if f_splash <> nil then
    f_splash.Close;
  application.ProcessMessages;
  buf := slash(HelpDir) + 'releasenotes_' + lang + '.txt';
  if not fileexists(buf) then
    buf := slash(HelpDir) + 'releasenotes.txt';
  if fileexists(buf) then
  begin
    f_info.setpage(3);
    f_info.TitlePanel.Caption :=f_info.TitlePanel.Caption + ', ' + rsVersion + blank + cdcversion + blank;
    if cdcbeta then f_info.TitlePanel.Caption := f_info.TitlePanel.Caption + 'beta-';
    f_info.TitlePanel.Caption := f_info.TitlePanel.Caption + RevisionStr;
    if shownext then
      f_info.Button1.Caption := rsNext
    else
      f_info.Button1.Caption := rsClose;
    f_info.InfoMemo.Lines.LoadFromFile(buf);
    f_info.InfoMemo.Text := CondUTF8Decode(f_info.InfoMemo.Text);
    f_info.showmodal;
  end;
end;

procedure Tf_main.FirstSetup;
begin
  ShowReleaseNotes(True);
  SetupObservatoryPage(0, -1);
  def_cfgsc.tz.Longitude:=def_cfgsc.ObsLongitude;
  def_cfgsc.tz.TimeZoneFile :=
    ZoneDir + StringReplace(def_cfgsc.ObsTZ, '/', PathDelim, [rfReplaceAll]);
  if def_cfgsc.tz.TimeZoneFile = '' then
  begin
    def_cfgsc.ObsTZ := 'Etc/GMT';
    def_cfgsc.tz.TimeZoneFile :=
      ZoneDir + StringReplace(def_cfgsc.ObsTZ, '/', PathDelim, [rfReplaceAll]);
  end;
  SelectLayout;
  SavePrivateConfig(configfile);
  SaveChartConfig(configfile, nil, False);
end;

procedure Tf_main.SelectLayout(allowcancel: boolean=false);
var i: integer;
begin
  Application.CreateForm(Tf_selectlayout, f_selectlayout);
  f_selectlayout.ShowCancel(allowcancel);
  f_selectlayout.ShowModal;
  if f_selectlayout.ModalResult=mrYes then begin
    nummainbar := numstandardmainbar;
    numobjectbar := numstandardobjectbar;
    numleftbar := numstandardleftbar;
    numrightbar := numstandardrightbar;
    configmainbar.Clear;
    configobjectbar.Clear;
    configleftbar.Clear;
    configrightbar.Clear;
    for i := 1 to nummainbar do
      configmainbar.Add(standardmainbar[i]);
    for i := 1 to numobjectbar do
      configobjectbar.Add(standardobjectbar[i]);
    for i := 1 to numleftbar do
      configleftbar.Add(standardleftbar[i]);
    for i := 1 to numrightbar do
      configrightbar.Add(standardrightbar[i]);
    MenuViewMainBar.Checked := True;
    MenuViewObjectBar.Checked := True;
    MenuViewLeftBar.Checked := True;
    MenuViewRightBar.Checked := True;
  end
  else if f_selectlayout.ModalResult=mrNo then begin
    nummainbar := numdefaultmainbar;
    numobjectbar := numdefaultobjectbar;
    numleftbar := numdefaultleftbar;
    numrightbar := numdefaultrightbar;
    configmainbar.Clear;
    configobjectbar.Clear;
    configleftbar.Clear;
    configrightbar.Clear;
    for i := 1 to nummainbar do
      configmainbar.Add(defaultmainbar[i]);
    for i := 1 to numobjectbar do
      configobjectbar.Add(defaultobjectbar[i]);
    for i := 1 to numleftbar do
      configleftbar.Add(defaultleftbar[i]);
    for i := 1 to numrightbar do
      configrightbar.Add(defaultrightbar[i]);
    MenuViewMainBar.Checked := True;
    MenuViewObjectBar.Checked := False;
    MenuViewLeftBar.Checked := False;
    MenuViewRightBar.Checked := False;
  end;
end;

procedure Tf_main.SaveImageExecute(Sender: TObject);
var
  ext, format, fn: string;
begin
  SavePictureDialog1.Filter := 'PNG|*.png|JPEG|*.jpg|BMP|*.bmp';
  SavePictureDialog1.DefaultExt := 'png';
  if SavePictureDialog1.InitialDir = '' then
    SavePictureDialog1.InitialDir := HomeDir;
  if (MultiFrame1.ActiveObject is Tf_chart) then
    SavePictureDialog1.FileName := trim(Tf_chart(MultiFrame1.ActiveObject).Caption);
  SavePictureDialog1.Title := rsSaveImage;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      if SavePictureDialog1.Execute then
      begin
        fn := SavePictureDialog1.Filename;
        ext := LowerCase(Trim(ExtractFileExt(SavePictureDialog1.FileName)));
        if (ext = '.jpg') then
          format := 'JPEG'
        else if (ext = '.bmp') then
          format := 'BMP'
        else
          format := 'PNG';
        SaveChartImage(format, fn, 95);
      end;
end;

procedure Tf_main.SavePictureDialog1CanClose(Sender: TObject;
  var CanClose: boolean);
var
  ext : string;
begin

  CanClose := false;

  ext := LowerCase(Trim(ExtractFileExt(SavePictureDialog1.FileName)));

  if (ext = '') or
     (ext = '.png') or
     (ext = '.jpg') or
     (ext = '.bmp')
  then
    CanClose := true;

  if not CanClose then
    ShowMessage(Format(rsUnsupportedF, [ext+crlf]));

end;

procedure Tf_main.SavePictureDialog1TypeChange(Sender: TObject);
begin
  case SavePictureDialog1.FilterIndex of
      0 : SavePictureDialog1.DefaultExt := 'png';
      1 : SavePictureDialog1.DefaultExt := 'jpg';
      2 : SavePictureDialog1.DefaultExt := 'bmp';
  end;
end;

procedure Tf_main.HelpAbout1Execute(Sender: TObject);
begin
  if f_about = nil then
    f_about := Tf_about.Create(application);
  f_about.ShowModal;
end;

procedure Tf_main.HelpContents1Execute(Sender: TObject);
begin
  sethelp(self, hlpIndex);
  ShowHelp;
end;

procedure Tf_main.HelpFaq1Execute(Sender: TObject);
begin
  sethelp(self, hlpFaq);
  ShowHelp;
  sethelp(self, hlpIndex);
end;

procedure Tf_main.MenuHelpPDFClick(Sender: TObject);
const
  pdflang = 'ca en es fr it nl uk ';
var
  lg, dlg, buf, lsturl, pdfurl, pdfname, lstfn, pdffn: string;
  i: integer;
  beta: boolean;
  f: textfile;
  fs: TSearchRec;
  // function to download the list of available pdf
  function GetPdfList: boolean;
  var
    a: integer;
    fdate: TDateTime;
  begin
    // replace the list only once a day
    if FileExistsUTF8(lstfn) then
    begin
      a := FileAgeUTF8(lstfn);
      fdate := FileDateToDateTime(a);
      if (now - fdate) < 1 then
      begin
        Result := True;
        exit;
      end;
    end;
    // get the list according to the program version
    if beta then
      lsturl := URL_DocPDF + 'beta_pdflist.txt'
    else
      lsturl := URL_DocPDF + 'pdflist.txt';
    // download
    Result := QuickDownload(lsturl, lstfn);
  end;

begin
  // default pdf name
  pdfname := 'doc_' + cdcversion + '_en.pdf';
  // get pdf doc language
  lg := trim(Lang);
  if pos(lg + blank, pdflang) = 0 then
    lg := 'en';
  dlg := lg;
  // check program version
  beta := Pos('-svn', cdcversion) > 0;
  lstfn := slash(TempDir) + 'pdflist.txt';
  // get the list
  if GetPdfList or FileExistsUTF8(lstfn) then
  begin
    // list is available
    AssignFile(f, lstfn);
    reset(f);
    // loop every file in list and get the one for our language
    while not EOF(f) do
    begin
      readln(f, buf);
      if pos(lg + '.pdf', buf) > 0 then
      begin
        pdfname := trim(buf);
        dlg := lg;
        break;
      end;
      if pos('en.pdf', buf) > 0 then
      begin  // english by default in case of problem
        pdfname := trim(buf);
        dlg := 'en';
      end;
    end;
    Closefile(f);
  end
  else
  begin
    // list is not available (no internet connection)
    // try to find an existing pdf
    i := FindFirstUTF8(slash(TempDir) + 'doc_*.pdf', 0, fs);
    if i = 0 then
      // pdf doc found
      pdfname := fs.Name
    else
    begin
      // we cannot go further for now
      ShowMessage(rsCannotDownlo);
      exit;
    end;
    FindCloseUTF8(fs);
  end;
  // pdf file full path
  pdffn := slash(TempDir) + pdfname;
  // check if file already there
  if not FileExistsUTF8(pdffn) then
  begin
    // download pdf
    pdfurl := URL_DocPDF + pdfname;
    if QuickDownload(pdfurl, pdffn) then
    begin
      // delete old pdf files
      i := FindFirstUTF8(slash(TempDir) + 'doc_*_' + dlg + '.pdf', 0, fs);
      while i = 0 do
      begin
        if fs.Name <> pdfname then
        begin
          DeleteFileUTF8(slash(TempDir) + fs.Name);
        end;
        i := FindNextUTF8(fs);
      end;
      FindCloseUTF8(fs);
    end
    else
    begin
      // download failed
      ShowMessage(rsCannotDownlo);
      exit;
    end;
  end;
  // open pdf in default application
  ExecuteFile(pdffn);
end;

procedure Tf_main.HelpQS1Execute(Sender: TObject);
begin
  sethelp(self, hlpQSguide);
  ShowHelp;
  sethelp(self, hlpIndex);
end;

procedure Tf_main.MenuHomePageClick(Sender: TObject);
begin
  ExecuteFile(URL_WebHome);
end;

procedure Tf_main.MenuMaillistClick(Sender: TObject);
begin
  ExecuteFile(URL_Maillist);
end;

procedure Tf_main.ViewChartInfoExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowLabel[8] := not sc.cfgsc.ShowLabel[8];
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ViewChartLegendExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowLegend := not sc.cfgsc.ShowLegend;
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ViewMainMenuExecute(Sender: TObject);
begin
try
  if Menu=nil then
    menu:=MainMenu1
  else
    menu:=nil;
except
  // not sure this is supported on every system
end;
end;

procedure Tf_main.SetupPicturesExecute(Sender: TObject);
begin
  SetupPicturesPage(-1);
end;

procedure Tf_main.ListImgExecute(Sender: TObject);
begin
  with MultiFrame1.ActiveObject as Tf_chart do
    chart_imglist.Execute;
end;

procedure Tf_main.ObslistExecute(Sender: TObject);
begin
  with MultiFrame1.ActiveObject as Tf_chart do
    MenuViewObsListClick(self);
end;

procedure Tf_main.MosaicExecute(Sender: TObject);
begin
  with MultiFrame1.ActiveObject as Tf_chart do
    NewMosaic(sc.cfgsc.racentre,sc.cfgsc.decentre,true);
end;

procedure Tf_main.MultiFrame1CreateChild(Sender: TObject);
var ntab: TTabSheet;
begin
  ntab:=TabControl1.AddTabSheet;
  ntab.Caption:=TChildFrame(Sender).Caption;
  if TabControl1.Visible <> (MultiFrame1.Maximized) and (MultiFrame1.ChildCount > 1) then
  begin
    TabControl1.Visible := (MultiFrame1.Maximized) and (MultiFrame1.ChildCount > 1);
    ViewTopPanel;
  end;
end;

procedure Tf_main.MultiFrame1DeleteChild(Sender: TObject);
var
  i: integer;
begin
  if (f_planetinfo <> nil) and (f_planetinfo.LinkedChartData = Tf_chart(
    TChildFrame(Sender).DockedObject).sc.cfgsc) then
  begin
    f_planetinfo.LinkedChartData := nil;
    f_planetinfo.Close;
  end;
  for i := 0 to TabControl1.PageCount - 1 do
  begin
    if TabControl1.Pages[i].Caption = TChildFrame(Sender).Caption then
    begin
      TabControl1.Pages[i].Destroy;
      break;
    end;
  end;
  // test for two childs because the currently deleting child is still counted
  if TabControl1.Visible <> (MultiFrame1.Maximized) and (MultiFrame1.ChildCount > 2) then
  begin
    TabControl1.Visible := (MultiFrame1.Maximized) and (MultiFrame1.ChildCount > 2);
    ViewTopPanel;
  end;
end;

procedure Tf_main.FileRenameChartExecute(Sender: TObject);
var
  cname,oldname: string;
  i: integer;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      oldname:=sc.cfgsc.chartname;
      cname:=oldname;
      if InputQuery(rsRenameChart,rsChartName+':',cname) then begin
         if (cname<>'')and(cname<>oldname) then begin
           RenameChart(cname);
         end;
      end;
    end;
end;

procedure Tf_main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if (f_updcatalog<>nil) and f_updcatalog.Running then begin
     if MessageDlg('Catalog installation is in progress.'+crlf+'Do you want to interrupt the download?',mtConfirmation,mbYesNo,0)=mrYes then begin
       CanClose:=true;
       f_updcatalog.Abort;
     end
     else
       CanClose:=false
   end
   else
     CanClose:=true;
end;

procedure Tf_main.PlanetInfoExecute(Sender: TObject);
begin
  PlanetInfoPage(-1, True);
end;

procedure Tf_main.PopupTabPopup(Sender: TObject);
var p:TPoint;
    i: integer;
begin
  // Select the chart for that tab we right click
  p.X:=Mouse.CursorPos.X;
  p.Y:=Mouse.CursorPos.Y;
  p:=TabControl1.ScreenToClient(p);
  i:=TabControl1.IndexOfTabAt(p);
  if (i>=0)and(i<TabControl1.PageCount) then
    SelectChart(TabControl1.Pages[i].Caption);
end;

procedure Tf_main.PlanetInfoPage(pg: integer; cursorpos: boolean = False);
var
  pt: TPoint;
begin
  if f_planetinfo = nil then
  begin
    f_planetinfo := Tf_planetinfo.Create(self);
    f_planetinfo.planet := planet;

    f_planetinfo.CenterAtNoon := cfgm.CenterAtNoon;
  end;

  if MultiFrame1.ActiveObject is Tf_chart then
    f_planetinfo.config.Assign(Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc)
  else
    f_planetinfo.config.Assign(def_cfgsc);

  if cfgm.KioskMode then
  begin
    pt.X := 0;
    pt.Y := 0;
    pt := self.ClientToScreen(pt);
    f_planetinfo.BorderStyle := bsSingle;
    f_planetinfo.FormStyle := fsStayOnTop;
    f_planetinfo.tbPlanets.Visible := False;
    f_planetinfo.PanelTop.Visible := False;
    f_planetinfo.PanelLeft.Visible := False;
    f_planetinfo.ShowCurrentObject := False;
    f_planetinfo.cbLabels.Checked:=false;
    f_planetinfo.KioskMode:=true;
    f_planetinfo.Show;
    f_planetinfo.Width := Width;
    f_planetinfo.Height := Height;
    f_planetinfo.top := pt.Y;
    f_planetinfo.left := pt.X;
    Application.ProcessMessages;
    f_planetinfo.View_Index := pg;
    f_planetinfo.SetView(pg,0);
  end
  else
  begin
    if cursorpos and (not f_planetinfo.Visible) then
      formpos(f_planetinfo, mouse.cursorpos.x, mouse.cursorpos.y);
    f_planetinfo.ActivePage := -1;
    if pg >= 0 then
      f_planetinfo.View_Index := pg;

    f_planetinfo.LinkedChartData := Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc;
    f_planetinfo.Show;

    f_planetinfo.SetRadioButtons;
    f_planetinfo.RefreshInfo;
  end;

end;

function Tf_main.ShowPlanetInfo(pg: string): string;
var
  i: integer;
begin
  Result := msgOK;
  if pg = 'OFF' then
  begin
    if f_planetinfo <> nil then
      f_planetinfo.Hide;
  end
  else if (pg >= '0') and (pg <= '8') then
  begin
    i := StrToIntDef(pg, 0);
    PlanetInfoPage(i);
  end
  else
    Result := msgFailed;
end;

procedure Tf_main.TabControl1Change(Sender: TObject);
var
  cname: string;
begin
  if (TabControl1.TabIndex >= 0) and (TabControl1.TabIndex < TabControl1.PageCount) then
  begin
    cname := TabControl1.Pages[TabControl1.TabIndex].Caption;
    SelectChart(cname);
  end;
end;

procedure Tf_main.MenuNextChildClick(Sender: TObject);
begin
  MultiFrame1.NexChild;
end;

procedure Tf_main.MenuBugReportClick(Sender: TObject);
begin
  ExecuteFile(URL_BugTracker);
end;

procedure Tf_main.CloseTimerTimer(Sender: TObject);
begin
  CloseTimer.Enabled := False;
  Close;
end;

procedure Tf_main.EditTimeValChange(Sender: TObject);
var
  i, n: integer;
begin
  val(EditTimeVal.Text, i, n);
  if (n = 0) and (i = 0) then
    EditTimeVal.Text := '1';
  TimeVal.Position := strtointdef(EditTimeVal.Text, 1);
  for i := 0 to numscript - 1 do
  begin
    Fscript[i].EditTimeVal.Text := EditTimeVal.Text;
  end;
end;

procedure Tf_main.TimeValChangingEx(Sender: TObject; var AllowChange: boolean;
  NewValue: smallint; Direction: TUpDownDirection);
var
  i: integer;
begin
  if NewValue = 0 then
  begin
    if TimeVal.Position > 0 then
      TimeVal.Position := -1
    else
      TimeVal.Position := 1;
    AllowChange := False;
  end;
  for i := 0 to numscript - 1 do
  begin
    Fscript[i].TimeVal.Position := TimeVal.Position;
  end;
end;

procedure Tf_main.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure Tf_main.GetLanguage;
var
  inif: TMemIniFile;
begin
  if fileexists(configfile) then
  begin
    inif := TMeminifile.Create(configfile);
    try
      cfgm.language := inif.ReadString('main', 'language', '');
      if cfgm.language = 'UK' then
        cfgm.language := ''; // migration pre-beta 2
    finally
      inif.Free;
    end;
  end;
end;

procedure Tf_main.GetAppDir;
var
  inif: TMemIniFile;
  buf, testfn: string;
  testfile: TextFile;
{$ifdef darwin}
  i: integer;
{$endif}
{$ifdef mswindows}
  PIDL: LPITEMIDLIST;
  Folder: array[0..MAX_PATH] of char;
{$endif}
begin
{$ifdef darwin}
  //  try current path
  appdir := getcurrentdir;
  if not DirectoryExists(slash(appdir) + slash('data') + slash('planet')) then
  begin
    // try under app bundle
    appdir := ExtractFilePath(ParamStr(0));
    i := pos('.app/', appdir);
    if i > 0 then
    begin
      appdir := ExtractFilePath(copy(appdir, 1, i));
    end;
    if not DirectoryExists(slash(appdir) + slash('data') + slash('planet')) then
    begin
       // try default location
      appdir := '/Applications/Cartes du Ciel';
    end;
  end;
{$else}
  appdir := getcurrentdir;
  if not DirectoryExists(slash(appdir) + slash('data') + slash('planet')) then
  begin
    appdir := ExtractFilePath(ParamStr(0));
  end;
  if VerboseMsg then
    debugln('appdir=' + appdir);
{$endif}
  PrivateDir := DefaultPrivateDir;
  HomeDir := DefaultHomeDir;
{$ifdef unix}
  Appdir := expandfilename(appdir);
  PrivateDir := expandfilename(PrivateDir);
  HomeDir := expandfilename(HomeDir);
{$endif}
{$ifdef mswindows}
  buf := systoutf8(appdir);
  buf := trim(buf);
  appdir := SafeUTF8ToSys(buf);
  buf := '';
  SHGetSpecialFolderLocation(0, CSIDL_LOCAL_APPDATA, PIDL);
  SHGetPathFromIDList(PIDL, Folder);
  buf := WinCPToUTF8(Folder);
  buf := trim(buf);
  buf := SafeUTF8ToSys(buf);
  if buf = '' then
  begin  // old windows version
    SHGetSpecialFolderLocation(0, CSIDL_APPDATA, PIDL);
    SHGetPathFromIDList(PIDL, Folder);
    buf := trim(WinCPToUTF8(Folder));
  end;
  if buf = '' then
  begin
    buf := 'C:\skychart';
  end;
  privatedir := slash(buf) + privatedir;
  configfile := slash(privatedir) + configfile;
  SHGetSpecialFolderLocation(0, CSIDL_PERSONAL, PIDL);
  SHGetPathFromIDList(PIDL, Folder);
  homedir := trim(WinCPToUTF8(Folder));
{$endif}

  if ForceConfig <> '' then
    Configfile := ForceConfig;
  if ConfigAppdir <> '' then
    Appdir := ConfigAppdir;

  if fileexists(configfile) then
  begin
    inif := TMeminifile.Create(configfile);
    try
      buf := inif.ReadString('main', 'PrivateDir', privatedir);
      if Directoryexists(buf) then
        privatedir := noslash(buf);
      if buf <> '' then
        ConfigPrivateDir := noslash(buf);
    finally
      inif.Free;
    end;
  end;

  if ForceUserDir <> '' then
    PrivateDir := noslash(ForceUserDir);

  if not directoryexists(privatedir) then
    CreateDir(privatedir);
  if not directoryexists(privatedir) then
    forcedirectories(privatedir);
  if not directoryexists(privatedir) then
  begin
    MessageDlg(rsUnableToCrea + privatedir + crlf + rsPleaseTryToC,
      mtError, [mbAbort], 0);
    Halt;
  end;

  // Test write access
  try
    testfn := tracefile;
    if testfn = '' then
      testfn := 'testfile.txt';
    assignfile(testfile, slash(PrivateDir) + testfn);
    rewrite(testfile);
    writeln(testfile, 'testfile');
    CloseFile(testfile);
    DeleteFile(slash(PrivateDir) + testfn);
  except
    MessageDlg('No write access on directory ' + privatedir + crlf +
      'This is probably because you previously run Skychart with administrator right.' +
      crlf + 'You must never run Skychart with administrator right.' +
      crlf + 'Please change the access right on this directory, or delete it.',
      mtError, [mbAbort], 0);
    Halt;
  end;
  MPCDir := slash(privatedir) + 'MPC';
  if not directoryexists(MPCDir) then
    CreateDir(MPCDir);
  if not directoryexists(MPCDir) then
    forcedirectories(MPCDir);
  SPKDir := slash(privatedir) + 'spk';
  if not directoryexists(SPKDir) then
    CreateDir(SPKDir);
  if not directoryexists(SPKDir) then
    forcedirectories(SPKDir);
  DBDir := slash(privatedir) + 'database';
  if not directoryexists(DBDir) then
    CreateDir(DBDir);
  if not directoryexists(DBDir) then
    forcedirectories(DBDir);
  PictureDir := slash(privatedir) + 'pictures';
  if not directoryexists(PictureDir) then
    CreateDir(slash(privatedir) + 'pictures');
  if not directoryexists(slash(privatedir) + 'pictures') then
    forcedirectories(slash(privatedir) + 'pictures');
  VODir := slash(privatedir) + 'vo';
  if not directoryexists(VODir) then
    CreateDir(VODir);
  if not directoryexists(VODir) then
    forcedirectories(VODir);
  Tempdir := slash(privatedir) + DefaultTmpDir;
  if not directoryexists(TempDir) then
    CreateDir(TempDir);
  if not directoryexists(TempDir) then
    forcedirectories(TempDir);
  isANSItmpdir := isANSIstr(TempDir);
  SatDir := slash(privatedir) + 'satellites';
  if not directoryexists(SatDir) then
    CreateDir(SatDir);
  if not directoryexists(SatDir) then
    forcedirectories(SatDir);
  SatArchiveDir := slash(SatDir) + 'Archive';
  if not directoryexists(SatArchiveDir) then
    CreateDir(SatArchiveDir);
  if not directoryexists(SatArchiveDir) then
    forcedirectories(SatArchiveDir);
  ArchiveDir := slash(PrivateDir) + 'Archive';
  if not directoryexists(ArchiveDir) then
    CreateDir(ArchiveDir);
  if not directoryexists(ArchiveDir) then
    forcedirectories(ArchiveDir);
  PrivateScriptDir := slash(PrivateDir) + 'script';
  if not directoryexists(PrivateScriptDir) then
    CreateDir(PrivateScriptDir);
  if not directoryexists(PrivateScriptDir) then
    forcedirectories(PrivateScriptDir);
  PrivateCatalogDir := slash(PrivateDir) + 'catalog';
  if not directoryexists(PrivateCatalogDir) then
    CreateDir(PrivateCatalogDir);
  if not directoryexists(PrivateCatalogDir) then
    forcedirectories(PrivateCatalogDir);
  if VerboseMsg then
    debugln('appdir=' + appdir);
  // Be sur the data directory exists
  if (not directoryexists(slash(appdir) + slash('data') + 'constellation')) then
  begin
    // try under the current directory
    buf := GetCurrentDir;
    if VerboseMsg then
      debugln('Try ' + buf);
    if (directoryexists(slash(buf) + slash('data') + 'constellation')) then
      appdir := buf
    else
    begin
      // try under the program directory
      buf := ExtractFilePath(ParamStr(0));
      if VerboseMsg then
        debugln('Try ' + buf);
      if (directoryexists(slash(buf) + slash('data') + 'constellation')) then
        appdir := buf
      else
      begin
        // try share directory under current location
        buf := ExpandFileName(slash(GetCurrentDir) + SharedDir);
        if VerboseMsg then
          debugln('Try ' + buf);
        if (directoryexists(slash(buf) + slash('data') + 'constellation')) then
          appdir := buf
        else
        begin
          // try share directory at the same location as the program
          buf := ExpandFileName(slash(ExtractFilePath(ParamStr(0))) + SharedDir);
          if VerboseMsg then
            debugln('Try ' + buf);
          if (directoryexists(slash(buf) + slash('data') + 'constellation')) then
            appdir := buf
          else
          begin
            // try in /usr
            buf := ExpandFileName(slash('/usr/bin') + SharedDir);
            if VerboseMsg then
              debugln('Try ' + buf);
            if (directoryexists(slash(buf) + slash('data') + 'constellation')) then
              appdir := buf
            else
            begin
              // try /usr/local
              buf := ExpandFileName(slash('/usr/local/bin') + SharedDir);
              if VerboseMsg then
                debugln('Try ' + buf);
              if (directoryexists(slash(buf) + slash('data') + 'constellation')) then
                appdir := buf

              else
              begin
                MessageDlg('Could not found the application data directory.' +
                  crlf + 'Please reinstall the program at a standard location' +
                  crlf +
                  'or use the option --datadir= to indicate where you install the data.',
                  mtError, [mbAbort], 0);
                Halt;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  if ConfigAppdir = '' then
    ConfigAppdir := Appdir;
  if VerboseMsg then
  begin
    debugln('appdir=' + appdir);
    debugln('privatedir=' + privatedir);
  end;
{$ifdef mswindows}
  tracefile := slash(privatedir) + tracefile;
{$endif}
{$ifdef darwin}
  tracefile := slash(privatedir) + tracefile;
{$endif}
  VarObs := slash(appdir) + DefaultVarObs;
  // varobs normally at same location as skychart
  if not FileExists(VarObs) then
    VarObs := DefaultVarObs; // if not try in $PATH
  helpdir := slash(appdir) + slash('doc');
  SampleDir := slash(appdir) + slash('data') + 'sample';
  ScriptDir := slash(appdir) + slash('data') + 'script';
  // Be sure zoneinfo exists in standard location or in skychart directory
  ZoneDir := slash(appdir) + slash('data') + slash('zoneinfo');
  if VerboseMsg then
    debugln('ZoneDir=' + ZoneDir);
  buf := slash('') + slash('usr') + slash('share') + slash('zoneinfo');
  if VerboseMsg then
    debugln('Try ' + buf);
  if (FileExists(slash(buf) + 'zone.tab')) then
    ZoneDir := slash(buf)
  else
  begin
    buf := slash('') + slash('usr') + slash('lib') + slash('zoneinfo');
    if VerboseMsg then
      debugln('Try ' + buf);
    if (FileExists(slash(buf) + 'zone.tab')) then
      ZoneDir := slash(buf)
    else
    begin
      if (not FileExists(slash(ZoneDir) + 'zone.tab')) then
      begin
        MessageDlg('zoneinfo directory not found!' + crlf +
          'Please install the tzdata package.' + crlf +
          'If it is not installed at a standard location create a logical link zoneinfo in skychart data directory.',
          mtError, [mbAbort], 0);
        Halt;
      end;
    end;
  end;
  if VerboseMsg then
    debugln('ZoneDir=' + ZoneDir);
end;

procedure Tf_main.ScaleMainForm;
var
  inif: TMemIniFile;
begin
  cfgm.ScreenScaling := True;
  if fileexists(configfile) then
  begin
    inif := TMeminifile.Create(configfile);
    try
      cfgm.ScreenScaling := inif.ReadBool('main', 'ScreenScaling', cfgm.ScreenScaling);
    finally
      inif.Free;
    end;
  end;
  UScaleDPI.UseScaling := cfgm.ScreenScaling;
  UScaleDPI.SetScale(Canvas);
  WriteTrace('Screen scaling : ' + BoolToStr(cfgm.ScreenScaling, True));
  WriteTrace('Screen scale : ' + FormatFloat(f0, 100 * UScaleDPI.RunDPI /
    UScaleDPI.DesignDPI) + '%');
  ScaleDPI(Self);
  SampDownload.ScaleDpi:=UScaleDPI.scale;
end;

procedure Tf_main.FormCreate(Sender: TObject);
var
  step, buf: string;
  i: integer;
  c: TBGRAPixel;
  {$ifdef mswindows}
  Registry: TRegistry;
  {$endif}
begin
  try

    // Set by uniqueinstance
    if Application.Terminated then begin
       OnDestroy:=nil;
       exit;
    end;

    lclver := lcl_version;
    buf := LCLPlatformDirNames[WidgetSet.LCLPlatform];

    if buf = 'win32' then
      buf := 'mswindows';

    compile_time := {$I %DATE%}+' '+{$I %TIME%};
    compile_version := 'Lazarus '+lcl_version+' Free Pascal '+{$I %FPCVERSION%}+' '+{$I %FPCTARGETOS%}+'-'+{$I %FPCTARGETCPU%}+'-'+buf;
    compile_system := {$I %FPCTARGETOS%};
    compile_cpu := {$I %FPCTARGETCPU%};
    cpydate := {$I %DATE%};
    cpydate := copy(cpydate,1,4);
    DefaultFormatSettings.DecimalSeparator := '.';
    DefaultFormatSettings.ThousandSeparator := ',';
    DefaultFormatSettings.DateSeparator := '/';
    DefaultFormatSettings.TimeSeparator := ':';
    NoMenu:=False;
    NeedRestart := False;
    showsplash := True;
    ConfirmSaveConfig := True;
    InitOK := False;
    ForceClose := False;
    Closing := False;
    RestoreState := False;
    SaveState := wsNormal;
    ForceConfig := '';
    ForceUserDir := '';
    ConfigAppdir := '';
    ConfigPrivateDir := '';
    CurrentTheme := 'default';
    FirstChart := '';
    ProcessParams1;
    step := 'Init';
    if VerboseMsg then
      debugln(step);
    {$ifdef mswindows}
    Application.UpdateFormatSettings := False;
    {$endif}
    ImageListCount := Img16Day.Count;
    MaxThreadCount := GetThreadCount;
    DisplayIs32bpp := True;
    isWOW64 := False;
    isAdmin := False;
    UacEnabled := True;
    {$ifdef mswindows}
    step := 'Windows spefic';
    isWOW64 := FindWOW64;
    if Win32MajorVersion>=6 then
      isAdmin := IsUserAnAdmin    // Vista to ...
    else
      isAdmin := false;           // 2000, XP
    DisplayIs32bpp := (ScreenBPP = 32);
    configfile := Defaultconfigfile;
    SaveDialog.Options := SaveDialog.Options - [ofNoReadOnlyReturn];
    try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    if Registry.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Policies\System\') then begin
      UacEnabled := (Registry.ReadInteger('EnableLUA')=1);
      Registry.CloseKey;
    end;
    Registry.Free;
    except
    end;
    { TODO : check readonly test on Windows }
    {$endif}
    CanShowScrollbar := True;
    {$ifdef unix}
    step := 'Unix specific';
    isAdmin := (FpGetuid=0);
    configfile := expandfilename(Defaultconfigfile);
    if DirectoryExists('/usr/share/doc/overlay-scrollbar') then
    begin
      buf := GetEnvironmentVariable('LIBOVERLAY_SCROLLBAR');
      if buf <> '0' then
        CanShowScrollbar := False;
    end;
    {$endif}
    {$ifdef darwin}
    step := 'Darwin specific';
    PanelTop.height:=PanelTop.height+10;
    TabControl1.height:=TabControl1.height+10;
    TabControl1.DragMode:=dmManual;
    {$endif}
    {$ifdef WithUpdateMenu}
    MenuUpdSoft.Visible := True;
    {$else}
    MenuUpdSoft.Visible := False;
    {$endif}
    if isAdmin then begin
       if UacEnabled then begin
          MessageDlg('Error, running as administrator!','Carte du Ciel, like any other astronomy software, should never be run as an administrator, '+
             'this is unnecessary, dangerous and a source of many unwanted problems.'+crlf+
             'The program will close now.'+crlf+crlf+
             'Please fix the start icon or command before trying again.',
             mtError,[mbClose],0,mbClose);
          halt;
       end
       else begin
          MessageDlg('Error, running as administrator!','Carte du Ciel, like any other astronomy software, should never be run as an administrator, '+
             'this is unnecessary, dangerous and a source of many unwanted problems.'+crlf+
             'The program will close now.'+crlf+crlf+
             'UAC is disabled in the system, this is a very dangerous choice.'+crlf+
             'Please enable UAC, or run the program from a standard, non-administrative user',
             mtError,[mbClose],0,mbClose);
          halt;
       end;
    end;
    basecaption := Caption;
    basecaption:=basecaption+blank+cdcversion + blank + RevisionStr;
    step := 'Create config';
    if VerboseMsg then
      debugln(step);
    def_cfgsc := Tconf_skychart.Create;
    cfgs := Tconf_skychart.Create;
    cfgm := Tconf_main.Create;
    def_cfgplot := Tconf_plot.Create;
    cfgp := Tconf_plot.Create;
    step := 'Create cursor';
    if VerboseMsg then
      debugln(step);
    CursorImage1 := TCursorImage.Create;
    step := 'Application directory';
    if VerboseMsg then
      debugln(step);
    GetAppDir;
    chdir(appdir);
    step := 'Trace';
    if VerboseMsg then
      debugln(step);
    InitTrace;
    if isAdmin then WriteTrace(basecaption);
    WriteTrace('Program version : ' + cdcversion + '-' + RevisionStr);
    WriteTrace('Program compiled: ' + compile_time);
    WriteTrace('Compiler version: ' + compile_version);
    if VerboseMsg then
    begin
      WriteTrace('Privatedir: ' + PrivateDir);
      WriteTrace('Appdir: ' + AppDir);
    end;
    step := 'Scaling';
    if VerboseMsg then
      WriteTrace(step);
    ScaleMainForm;
    step := 'Language';
    if VerboseMsg then
      WriteTrace(step);
    GetLanguage;
    lang := u_translation.translate(cfgm.language);
    catalog := Tcatalog.Create(self);
    step := 'Multiframe';
    if VerboseMsg then
      WriteTrace(step);
    TabControl1.Visible := False;
    MultiFrame1.WindowList := SubWindow;
    MultiFrame1.KeepLastChild := True;
    ChildControl.Visible := False;
    step := 'Size control';
    if VerboseMsg then
      WriteTrace(step);
    MultiFrame1.Align := alClient;
    starshape.Picture.Bitmap.Transparent := False;
    quicksearch.Width := round(75
{$ifdef mswindows}
      * Screen.PixelsPerInch / 96
{$endif}
      );
    TimeU.Width := round(95
{$ifdef mswindows}
      * Screen.PixelsPerInch / 96
{$endif}
      );
    // detect if theme color is dark
    {$ifdef lclcocoa}
    c:=ColorToBGRA(ColorToRGB(clBackground));
    {$else}
    c:=ColorToBGRA(ColorToRGB(clBtnFace));
    {$endif}
    i:=round((c.red+c.green+c.blue)/3);
    DarkTheme:=(i<128);
    step := 'Load plan404';
    if VerboseMsg then
      WriteTrace(step);
    Plan404 := nil;
    {$ifdef linux}
    {$ifdef CPUAARCH64}
      {$define NoPlan404}
    {$endif}
    {$endif}
    {$ifndef NoPlan404}
    Plan404lib := LoadLibrary(lib404);
    if Plan404lib <> 0 then
    begin
      Plan404 := TPlan404(GetProcedureAddress(Plan404lib, 'Plan404'));
    end;
    {$endif}
    step := 'Load cdcwcs';
    if VerboseMsg then
      WriteTrace(step);
    cdcwcs_initfitsfile := nil;
    cdcwcs_release := nil;
    cdcwcs_sky2xy := nil;
    cdcwcslib := LoadLibrary(libcdcwcs);
    if cdcwcslib <> 0 then
    begin
      cdcwcs_initfitsfile := Tcdcwcs_initfitsfile(
        GetProcedureAddress(cdcwcslib, 'cdcwcs_initfitsfile'));
      cdcwcs_release := Tcdcwcs_release(GetProcedureAddress(cdcwcslib,
        'cdcwcs_release'));
      cdcwcs_sky2xy := Tcdcwcs_sky2xy(GetProcedureAddress(cdcwcslib, 'cdcwcs_sky2xy'));
      cdcwcs_getinfo := Tcdcwcs_getinfo(GetProcedureAddress(cdcwcslib,
        'cdcwcs_getinfo'));
    end;

    if (@cdcwcs_initfitsfile = nil) or (@cdcwcs_release = nil) or
      (@cdcwcs_sky2xy = nil) or (@cdcwcs_getinfo = nil) then
    begin
      MessageDlg(rsCouldNotLoad + libcdcwcs + crlf + rsPleaseTryToR,
        mtError, [mbAbort], 0);
      Halt;
    end;

    step := 'Try Calceph';
    if VerboseMsg then
      WriteTrace(step);
    SpiceBaseOk:=false;
    SpiceExtOk:=false;
    CalcephBaseOk:=false;
    CalcephExtOk:=false;
    Load_LibCalceph;
    if libcalceph<>0 then begin
      Load_Calceph_Files;
    end
    else begin
      step := 'Try libpasspice';
      if VerboseMsg then
        WriteTrace(step);
      SpiceLib := LoadLibrary(libspice);
      if SpiceLib <> 0 then  begin
        SpiceIniterr:=Tiniterr(GetProcAddress(SpiceLib, 'initerr'));
        SpiceLoadspk := Tloadspk(GetProcAddress(SpiceLib, 'loadspk'));
        SpiceComputepos := Tcomputepos(GetProcAddress(SpiceLib, 'computepos'));
        SpiceGetlongerror := Tgetlongerror(GetProcAddress(SpiceLib, 'getlongerror'));
        SpiceGetshorterror := Tgetshorterror(GetProcAddress(SpiceLib, 'getshorterror'));
        if (@SpiceIniterr=nil)or(@SpiceLoadspk=nil)or(@SpiceComputepos=nil)or(@SpiceGetlongerror=nil)or(@SpiceGetshorterror=nil) then
          SpiceLib:=0;
      end;
      if SpiceLib<>0 then begin
        SpiceIniterr;
        SpiceFolder:=slash(Appdir) + slash('data') + 'spice_eph';
        i:=SpiceLoadspk(pchar(slash(SpiceFolder)+'cdcbase.bsp'));
        SpiceBaseOk:=(i=0);
        i:=i+SpiceLoadspk(pchar(slash(SpiceFolder)+'cdcext.bsp'));
        SpiceExtOk:=(i=0);
        WriteTrace('libspice loaded (deprecated)');
      end;
    end;

    step := 'Multiframe border';
    if VerboseMsg then
      WriteTrace(step);
    MultiFrame1.InactiveBorderColor := $404040;
    MultiFrame1.TitleColor := clWhite;
    MultiFrame1.BorderColor := $808080;
    step := 'Bitmap';
    if VerboseMsg then
      WriteTrace(step);
    compass := TBGRABitmap.Create;
    i:=compass.Bitmap.RawImage.Description.Depth;
    if i<24 then begin
      buf:='Screen color depth of '+inttostr(i)+' is not supported.'+crlf+'Please change the screen color depth to 24 or 32';
      WriteTrace(buf);
      MessageDlg(buf,mtError, [mbAbort], 0);
      Halt;
    end;
    arrow := TBGRABitmap.Create;
    step := 'Load timezone';
    // check computer clock
    buf := FormatDateTime('YYYY', now);
    if buf < '2000' then
    begin
      MessageDlg('Your computer clock is back in year ' + buf +
        crlf + 'Please set your computer clock and restart skychart',
        mtError, [mbAbort], 0);
      Halt;
    end;
    if VerboseMsg then
      WriteTrace(step);
    def_cfgsc.tz.LoadZoneTab(ZoneDir + 'zone.tab');
    step := 'SAMP';
    if VerboseMsg then
      WriteTrace(step);
    SampConnected := False;
    SampClientId := TStringList.Create;
    SampClientName := TStringList.Create;
    SampClientDesc := TStringList.Create;
    SampClientCoordpointAtsky := TStringList.Create;
    SampClientImageLoadFits := TStringList.Create;
    SampClientTableLoadVotable := TStringList.Create;
    step := 'Toolbar';
    if VerboseMsg then
      WriteTrace(step);
    configmainbar := TStringList.Create;
    configobjectbar := TStringList.Create;
    configleftbar := TStringList.Create;
    configrightbar := TStringList.Create;
    rotspeed := -1;
    step := 'Script panel';
    if VerboseMsg then
      WriteTrace(step);
    FTelescopeConnected := False;
    numscript := 8;
    ActiveScript := -1;
    SetLength(Fscript, numscript);
    for i := 0 to numscript - 1 do
    begin
      Fscript[i] := Tf_script.Create(self);
      Fscript[i].Parent := ScriptPanel;
      Fscript[i].Name := 'fscript' + IntToStr(i);
      Fscript[i].PanelTitle.Caption := 'Toolbox ' + IntToStr(i + 1);
      Fscript[i].Tag := i;
      Fscript[i].Align := alClient;
      Fscript[i].Visible := False;
      Fscript[i].ExecuteCmd := ExecuteCmd;
      Fscript[i].CometMark := CometMark;
      Fscript[i].AsteroidMark := AsteroidMark;
      Fscript[i].GetScopeRates := GetScopeRates;
      Fscript[i].SendInfo := SendInfo;
      Fscript[i].onApply := ApplyScript;
      Fscript[i].onToolboxConfig := MenuToolboxConfigClick;
      if MultiFrame1.ActiveObject is Tf_chart then
        Fscript[i].Activechart := Tf_chart(MultiFrame1.ActiveObject);
    end;
    Splitter1.ResizeControl := ScriptPanel;
    ScriptPanel.Constraints.MinWidth :=
      Fscript[0].ButtonConfig.Width + 4 + GetSystemMetrics(SM_SWSCROLLBARSPACING) +
      GetSystemMetrics(SM_CXVSCROLL);

    step := 'Load Healpix library';
    if VerboseMsg then
      WriteTrace(step);
    LoadHealpixLibrary;
    if @pix2ang_nest64=nil then
       WriteTrace(step+' failed');

    step := 'SetLang';
    if VerboseMsg then
      WriteTrace(step);
    SetLang;
    step := 'End';

  except
    on E: Exception do
    begin
      WriteTrace(step + ': ' + E.Message);
      MessageDlg(step + ': ' + E.Message + crlf + rsSomethingGoW +
        crlf + rsPleaseTryToR,
        mtError, [mbAbort], 0);
      Halt;
    end;
  end;

  if VerboseMsg then
    WriteTrace('Exit Tf_main.FormCreate');
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  try
    if VerboseMsg then
      WriteTrace('Destroy Tf_main');
    catalog.Free;
    Fits.Free;
    planet.Free;
    cdcdb.Free;
    def_cfgsc.Free;
    cfgs.Free;
    if cfgm<>nil then cfgm.ObsNameList.OwnsObjects := True;  // destroy objects only on exit
    cfgm.Free;
    def_cfgplot.Free;
    cfgp.Free;
    Compass.Free;
    arrow.Free;
    samp.Free;
    SampClientId.Free;
    SampClientName.Free;
    SampClientDesc.Free;
    SampClientCoordpointAtsky.Free;
    SampClientImageLoadFits.Free;
    SampClientTableLoadVotable.Free;
    configmainbar.Free;
    configobjectbar.Free;
    configleftbar.Free;
    configrightbar.Free;
    CloseCalcephSat;
    CloseCalcephBody;
    CloseGrappavar;
    if NeedRestart then
      ExecNoWait(ParamStr(0));
    if VerboseMsg then
      WriteTrace('Destroy Cursor');
    if CursorImage1 <> nil then
    begin
      CursorImage1.ReleaseHandle;
      CursorImage1.Free;
    end;
    ///////////////////////////////////////////////
    // removed as this crash on Windows and memleak is very small
    // if TCPDaemon<>nil then TCPDaemon.Free;
    ///////////////////////////////////////////////
    if VerboseMsg then
      WriteTrace('Destroy end');
  except
    writetrace('error destroy ' + Name);
  end;
end;

procedure Tf_main.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i, h, w, mresult: integer;
  buf: string;
  f1: TForm;
  l1: TLabel;
  c1: Tcheckbox;
  p1: TPanel;
  b1, b2, b3: TButton;
begin
  if (not ForceClose) and TCPClientConnected then
  begin  // do not close if client are connected
    Action := caMinimize;
    SaveState := WindowState;
    RestoreState := True;
    buf:='Client application is still connected, minimize instead of closing.';
    SetLPanel1(buf+crlf+'If it is no longer used, you can close the session from the menu View / Server information.');
    writetrace(buf);
  end
  else
  begin
    try
      if SaveConfigOnExit.Checked and Application.ShowMainForm and (FirstChart='') then
      begin
        if ConfirmSaveConfig then
        begin
          try
            f1 := TForm.Create(self);
            f1.AutoSize := False;
            f1.Position := poScreenCenter;
            f1.Caption := rsSaveConfigur;
            l1 := TLabel.Create(f1);
            l1.Caption := rsDoYouWantToS;
            l1.ParentFont := True;
            p1 := TPanel.Create(f1);
            p1.Caption := '';
            b1 := TButton.Create(f1);
            b1.Caption := rsMbYes;
            b1.ModalResult := mrYes;
            b1.Anchors := [akTop, akRight];
            b2 := TButton.Create(f1);
            b2.Caption := rsMbNo;
            b2.ModalResult := mrNo;
            b2.Anchors := [akTop, akRight];
            b3 := TButton.Create(f1);
            b3.Caption := rsAbort;
            b3.ModalResult := mrAbort;
            b3.Anchors := [akTop, akRight];
            c1 := Tcheckbox.Create(f1);
            c1.AutoSize := True;
            c1.Caption := rsAlwaysSaveWi;
            c1.Checked := False;
            l1.Parent := f1;
            c1.Parent := f1;
            b1.Parent := p1;
            b2.Parent := p1;
            b3.Parent := p1;
            p1.Parent := f1;
            l1.AdjustSize;
            c1.AdjustSize;
            b1.AdjustSize;
            b2.AdjustSize;
            b3.AdjustSize;
            p1.Height := b1.Height + 16;
            p1.Width := b1.Width + b2.Width + b3.Width + 32;
            p1.AdjustSize;
            b1.Top := 8;
            b2.Top := 8;
            b3.Top := 8;
            b3.Left := 8;
            b2.Left := b3.Left + b3.Width + 8;
            b1.Left := b2.Left + b2.Width + 8;
            l1.top := 8;
            l1.Left := 8;
            c1.Left := 8;
            c1.Top := 8 + l1.Height + 8;
            p1.Align := alBottom;
            h := l1.Height + c1.Height + p1.Height + 20;
            w := max(f1.Canvas.TextWidth(l1.Caption), p1.Width) + 16;
            f1.Width := w;
            f1.Height := h;
            ScaleDPI(f1);
            mresult := f1.ShowModal;
            ConfirmSaveConfig := not c1.Checked;
            if (mresult = mrAbort) or (mresult = mrCancel) then
              Action := caNone;
            if mresult = mrYes then
              SaveDefault;
            if mresult = mrNo then
              SaveQuickSearch(configfile);
          finally
            b1.Free;
            b2.Free;
            b3.Free;
            p1.Free;
            l1.Free;
            c1.Free;
            f1.Free;
          end;
        end
        else
          SaveDefault;
      end
      else
      begin
        if (not NeedRestart) and (not cfgm.KioskMode) then
          SaveQuickSearch(configfile);
      end;
      if Action <> caNone then
      begin
        SAMPstop;
        StopServer;
        writetrace(rsExiting);
        Autorefresh.Enabled := False;
        for i := 0 to MultiFrame1.ChildCount - 1 do
          if MultiFrame1.Childs[i].DockedObject is Tf_chart then
            with (MultiFrame1.Childs[i].DockedObject as Tf_chart) do
            begin
              locked := True;
              cmd_DisconnectTelescope;
              TelescopeTimer.Enabled := False;
              RefreshTimer.Enabled := False;
              BlinkTimer.Enabled := False;
              PDSSTimer.Enabled := False;
            end;
        Closing := True;
      end;
    except
    end;
  end;
end;

procedure Tf_main.SaveConfigurationExecute(Sender: TObject);
begin
  SaveDefault;
end;

procedure Tf_main.EditCopy1Execute(Sender: TObject);
var
  savelabel: boolean;
  bmp: TBitmap;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with Tf_chart(MultiFrame1.ActiveObject) do
    begin
      savelabel := sc.cfgsc.Editlabels;
      if VerboseMsg then
        WriteTrace('EditCopy1Execute');
      bmp := TBitmap.Create;
      try
        if savelabel then
        begin
          sc.cfgsc.Editlabels := False;
          sc.Refresh(False);
        end;
        bmp.Assign(sc.plot.cbmp);
        Clipboard.Assign(bmp);
      finally
        bmp.Free;
        if savelabel then
        begin
          sc.cfgsc.Editlabels := True;
          sc.Refresh(False);
        end;
      end;
    end;
end;

procedure Tf_main.Print1Execute(Sender: TObject);
var
  buf: string;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    if (cfgm.PrintMethod = 0) and (GetPrinterIndex < 0) then
      cfgm.PrintMethod := 2;
    buf := rsSkyCharts + ', ' + rsObservatory + blank + Tf_chart(
      MultiFrame1.ActiveObject).sc.cfgsc.ObsName + ', ' + rsCenter +
      blank + rsRA + ':' + ARmtoStr(rad2deg * Tf_chart(
      MultiFrame1.ActiveObject).sc.cfgsc.racentre / 15) + blank +
      rsDEC + ':' + DEmtoStr(rad2deg * Tf_chart(
      MultiFrame1.ActiveObject).sc.cfgsc.decentre);
    if Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.FindName > '' then
      buf := buf + ', ' + Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.FindName;
    cfgm.PrintDesc := buf;
    f_print.CheckBox1.Checked := cfgm.PrintHeader;
    f_print.CheckBox2.Checked := cfgm.PrintFooter;
    formpos(f_print, mouse.cursorpos.x, mouse.cursorpos.y);
    f_print.showmodal;
    if (f_print.ModalResult = mrOk) or (f_print.ModalResult = mrYes) then
    begin
      cfgm.PrintHeader := f_print.CheckBox1.Checked;
      cfgm.PrintFooter := f_print.CheckBox2.Checked;
      Tf_chart(MultiFrame1.ActiveObject).PrintChart(
        cfgm.printlandscape, cfgm.printcolor, cfgm.PrintMethod, cfgm.PrinterResolution,
        cfgm.PrintCmd1, cfgm.PrintCmd2, cfgm.PrintTmpPath, cfgm,
        (f_print.ModalResult = mrYes));
    end;
    MenuPrintPreview.Visible := (cfgm.PrintMethod = 0);
  end;
end;

procedure Tf_main.MenuPrintPreviewClick(Sender: TObject);
var
  buf: string;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    if (cfgm.PrintMethod = 0) and (GetPrinterIndex < 0) then
      cfgm.PrintMethod := 2;
    buf := rsSkyCharts + ', ' + rsObservatory + blank + Tf_chart(
      MultiFrame1.ActiveObject).sc.cfgsc.ObsName + ', ' + rsCenter +
      blank + rsRA + ':' + ARmtoStr(rad2deg * Tf_chart(
      MultiFrame1.ActiveObject).sc.cfgsc.racentre / 15) + blank +
      rsDEC + ':' + DEmtoStr(rad2deg * Tf_chart(
      MultiFrame1.ActiveObject).sc.cfgsc.decentre);
    if Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.FindName > '' then
      buf := buf + ', ' + Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.FindName;
    cfgm.PrintDesc := buf;
    Tf_chart(MultiFrame1.ActiveObject).PrintChart(
      cfgm.printlandscape, cfgm.printcolor, cfgm.PrintMethod, cfgm.PrinterResolution,
      cfgm.PrintCmd1, cfgm.PrintCmd2, cfgm.PrintTmpPath, cfgm, True);
  end;
end;

procedure Tf_main.UndoExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_UndoExecute(Sender);
end;

procedure Tf_main.RedoExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_RedoExecute(Sender);
end;

procedure Tf_main.zoomplusExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_zoomplusExecute(Sender);
end;

procedure Tf_main.zoomminusExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_zoomminusExecute(Sender);
end;


procedure Tf_main.ZoomBarExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      formpos(f_zoom, mouse.cursorpos.x, mouse.cursorpos.y);
      f_zoom.onApply := ZoomBarApply;
      f_zoom.fov := rad2deg * sc.cfgsc.fov;
      f_zoom.showmodal;
      if f_zoom.modalresult = mrOk then
      begin
        ZoomBarApply(Sender);
      end;
    end;
end;

procedure Tf_main.ZoomBarApply(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.setfov(deg2rad * f_zoom.fov);
      if VerboseMsg then
        WriteTrace('ZoomBarExecute');
      Refresh(True, False);
    end;
end;

procedure Tf_main.FlipxExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_FlipxExecute(Sender);
end;

procedure Tf_main.FlipyExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_FlipyExecute(Sender);
end;

procedure Tf_main.MenuVariableStarClick(Sender: TObject);
begin
  ExecNoWait(varobs,'',false);
end;

procedure Tf_main.SubViewClick(Sender: TObject);
begin
  ViewClock.Checked := (f_clock <> nil) and (f_clock.Visible);
end;

procedure Tf_main.rot_plusExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if rotspeed > 0 then
        rotation(rotspeed)
      else
        chart_rot_plusExecute(Sender);
    end;
  rotspeed := -1;
end;

procedure Tf_main.rot_minusExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if rotspeed > 0 then
        rotation(-rotspeed)
      else
        chart_rot_minusExecute(Sender);
    end;
  rotspeed := -1;
end;

procedure Tf_main.ResetRotationExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.theta := 0;
      Refresh(True, False);
    end;
end;

procedure Tf_main.rotate180Execute(Sender: TObject);
var
  rot: double;
begin
  rot := 180;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      rotation(rot);
end;


procedure Tf_main.TelescopeConnectExecute(Sender: TObject);
var
  P: Tpoint;
begin
  if ScriptPanel.Visible then
    P := point(ScriptPanel.Left + ScriptPanel.Width, PanelTop.Top + PanelTop.Height)
  else
    P := point(PanelLeft.Width, PanelTop.Top + PanelTop.Height);
  P := ClientToScreen(P);
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      Connect1Click(Sender);
      if sc.cfgsc.ManualTelescope then
      begin
        if f_manualtelescope.Visible then
          f_manualtelescope.hide
        else
        begin
          formpos(f_manualtelescope, P.x, P.y);
          f_manualtelescope.SetTurn(sc.cfgsc.FindNote);
          f_manualtelescope.Show;
          f_main.SetFocus;
        end;
      end;
    end;
end;

procedure Tf_main.TelescopeSlewExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      Slew1Click(Sender);
end;

procedure Tf_main.TelescopeAbortSlewExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      AbortSlew1Click(Sender);
end;

procedure Tf_main.TelescopeSyncExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      Sync1Click(Sender);
end;

procedure Tf_main.TelescopePanelExecute(Sender: TObject);
begin
  if not IndiGUIready then
  begin
    f_indigui := Tf_indigui.Create(self);
    ScaleDPI(f_indigui);
    f_indigui.onDestroy := IndiGUIdestroy;
    f_indigui.IndiServer := def_cfgsc.IndiServerHost;
    f_indigui.IndiPort := def_cfgsc.IndiServerPort;
    f_indigui.IndiDevice := '';
    IndiGUIready := True;
  end;
  f_indigui.Show;
end;

procedure Tf_main.IndiGUIdestroy(Sender: TObject);
begin
  IndiGUIready := False;
end;

procedure Tf_main.ListObjExecute(Sender: TObject);
var
  buf, msg: string;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if sc.cfgsc.windowratio = 0 then
        sc.cfgsc.windowratio := 1;
      sc.FindListWin(buf, msg, False, False);
      ListInfo(buf, msg);
    end;
end;

procedure Tf_main.ListInfo(buf, msg: string);
begin
  f_info.source_chart := MultiFrame1.ActiveChild.Caption;
  f_info.setpage(1);
  f_info.TitlePanel.Caption := f_info.TitlePanel.Caption + ':   ' + msg;
  f_info.StringGrid2.Font.Name := def_cfgplot.FontName[5];
  f_info.StringGrid2.Font.Size := def_cfgplot.FontSize[5];
  f_info.setgrid(blank + wordspace(buf));
  f_info.Show;
  f_info.BringToFront;
end;

procedure Tf_main.GridEQExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_GridEQExecute(Sender);
end;

procedure Tf_main.GridExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_GridExecute(Sender);
end;

procedure Tf_main.ShowCompassExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SwitchCompass(Sender);
end;

procedure Tf_main.switchstarsExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_switchstarExecute(Sender);
end;

procedure Tf_main.switchbackgroundExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      chart_switchbackgroundExecute(Sender);
end;

procedure Tf_main.SetFOVClick(Sender: TObject);
var
  f: integer;
begin
  with Sender as TSpeedButton do
    f := tag;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      SetField(deg2rad * sc.catalog.cfgshr.FieldNum[f], (f > 1));
    end;
end;

procedure Tf_main.SetFovExecute(Sender: TObject);
var
  f: integer;
begin
  with Sender as TAction do
    f := tag;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      SetField(deg2rad * sc.catalog.cfgshr.FieldNum[f], (f > 1));
    end;
end;

procedure Tf_main.toNExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SetAz(deg2rad * 180);
end;

procedure Tf_main.toEExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SetAz(deg2rad * 270);
end;

procedure Tf_main.toSExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SetAz(0);
end;

procedure Tf_main.toWExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SetAz(deg2rad * 90);
end;

procedure Tf_main.toZenithExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SetZenit(0);
end;

procedure Tf_main.allSkyExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      SetZenit(deg2rad * 200);
end;


procedure Tf_main.MoreStarExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      cmd_MoreStar;
end;

procedure Tf_main.LessStarExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      cmd_LessStar;
end;

procedure Tf_main.MoreNebExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      cmd_MoreNeb;
end;

procedure Tf_main.LessNebExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      cmd_LessNeb;
end;

procedure Tf_main.LockMagnitudeExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      cmd_LockMagn;
end;

procedure Tf_main.AnimationExecute(Sender: TObject);
var
  fs: TSearchRec;
  i, rc: integer;
  r: TStringList;
  fn, cmd, logfile: string;
begin
  AnimationEnabled := not AnimationEnabled;
  AnimationDirection := TAction(Sender).tag;
  Animation.Checked := AnimationEnabled and (AnimationDirection >= 0);
  AnimBackward.Checked := AnimationEnabled and (AnimationDirection < 0);
  if AnimationEnabled then
  begin  // start animation
    if (cfgm.AnimSx > 0) and (cfgm.AnimSy > 0) then
    begin
      r := TStringList.Create;
      cmd := 'RESIZE ' + IntToStr(cfgm.AnimSx) + ' ' + IntToStr(cfgm.AnimSy);
      splitarg(cmd, blank, r);
      for i := r.Count to MaxCmdArg do
        r.add('');
      ExecuteCmd('', r);
      r.Free;
    end;
    Animcount := 0;
    if cfgm.AnimRec then
    begin
      i := findfirst(slash(TempDir) + '*.jpg', 0, fs);
      while i = 0 do
      begin
        DeleteFile(slash(TempDir) + fs.Name);
        i := findnext(fs);
      end;
      findclose(fs);
    end;
    AnimationTimer.Enabled := True;
  end
  else
  begin                   // end animation
    AnimationTimer.Enabled := False;
    if cfgm.AnimRec then
    begin
      r := TStringList.Create;
      i := 0;
      repeat
        Inc(i);
        fn := slash(cfgm.AnimRecDir) + cfgm.AnimRecPrefix + IntToStr(i) +
          cfgm.AnimRecExt;
      until (not FileExistsutf8(fn)) or (i > 1000);
      cmd := cfgm.Animffmpeg + ' -r ' + formatfloat(f1, cfgm.AnimFps) +
        ' -i "' + slash(TempDir) + '%06d.jpg" ' + cfgm.AnimOpt +
        ' "' + utf8tosys(fn) + '"';
      rc := ExecProcess(cmd, r, True);
      logfile := slash(TempDir) + 'ffmpeg.log';
      r.SaveToFile(logfile);
      r.Free;
      if (rc <> 0) and (fileexists(logfile)) then
      begin
        f_info.setpage(3);
        f_info.TitlePanel.Caption := 'ffmpeg command failed';
        f_info.Button1.Caption := rsClose;
        f_info.InfoMemo.Lines.LoadFromFile(logfile);
        f_info.InfoMemo.Text := CondUTF8Decode(f_info.InfoMemo.Text);
        f_info.showmodal;
      end;
    end;
  end;
end;

procedure Tf_main.MouseModeExecute(Sender: TObject);
begin
  cfgm.SimpleMove := not cfgm.SimpleMove;
  if cfgm.SimpleMove then
    MouseMode.ImageIndex := 97
  else
    MouseMode.ImageIndex := 96;
end;

procedure Tf_main.ScaleModeExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowScale := not sc.cfgsc.ShowScale;
      if MeasureOn then
        MeasureDistance(4, 0, 0);
      Refresh(True, False);
    end;
end;

procedure Tf_main.AnimationTimerTimer(Sender: TObject);
var
  fn: string;
begin
  AnimationTimer.Enabled := False;
  if AnimationDirection >= 0 then
    TimeInc.Execute
  else
    TimeDec.Execute;
  if cfgm.AnimRec then
  begin
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        Inc(Animcount);
        fn := Slash(systoutf8(TempDir)) + FormatFloat('000000', Animcount) + '.jpg';
        SaveChartImage('JPEG', fn, 80);
      end;
  end;
  Application.ProcessMessages;
  AnimationTimer.Enabled := AnimationEnabled;
end;

procedure Tf_main.TimeIncExecute(Sender: TObject);
var
  hh: double;
  y, m, d, h, n, s, mult: integer;
  showast: boolean;
begin
  // tag is used for the sign
  mult := TAction(Sender).tag * TimeVal.Position;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      showast := sc.cfgsc.ShowAsteroid;
      djd(sc.cfgsc.CurJDUT, y, m, d, hh);
      DtoS(hh, h, n, s);

      case TimeU.ItemIndex of
        0: SetJD(sc.cfgsc.CurJDUT + mult / 24);
        1: SetJD(sc.cfgsc.CurJDUT + mult / 1440);
        2: SetJD(sc.cfgsc.CurJDUT + mult / 86400);
        3: SetJD(sc.cfgsc.CurJDUT + mult);

        4:
        begin
          Inc(m, mult);
          SetDateUT(y, m, d, h, n, s);
        end;

        5:
        begin
          Inc(y, mult);
          SetDateUT(y, m, d, h, n, s);
        end;

        6: SetJD(sc.cfgsc.CurJDUT + mult * 365.25);      // julian year
        7: SetJD(sc.cfgsc.CurJDUT + mult * 365.2421988); // tropical year
        8: SetJD(sc.cfgsc.CurJDUT + mult * 0.99726956633); // sideral day
        9: SetJD(sc.cfgsc.CurJDUT + mult * 29.530589);   // synodic month
        10: SetJD(sc.cfgsc.CurJDUT + mult * 6585.321);    // saros
      end;

      if showast and (showast <> sc.cfgsc.ShowAsteroid) and (not AnimationEnabled) then
        RecomputeAsteroid;

    end;
end;


procedure Tf_main.TimeResetExecute(Sender: TObject);
var
  showast: boolean;
begin
  if AnimationEnabled then
  begin
    AnimationExecute(Sender);
  end
  else
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      showast := sc.cfgsc.ShowAsteroid;
      sc.cfgsc.UseSystemTime := True;
      if Connect1.Checked then
         sc.cfgsc.autorefresh:=true;
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      if VerboseMsg then
        WriteTrace('TimeResetExecute');
      Refresh(True, True);
      if showast and (showast <> sc.cfgsc.ShowAsteroid) then
      begin
        RecomputeAsteroid;
      end;
    end;
end;


procedure Tf_main.ShowStarsExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.showstars := not sc.cfgsc.showstars;
      if VerboseMsg then
        WriteTrace('ShowStarsExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowNebulaeExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.shownebulae := not sc.cfgsc.shownebulae;
      if VerboseMsg then
        WriteTrace('ShowNebulaeExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowPicturesExecute(Sender: TObject);
var
  nimg: integer;
  dirok: boolean;
begin
  dirok := DirectoryExists(cfgm.ImagePath);
  nimg := cdcdb.CountImages('');
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if sc.cfgsc.ShowImages or (nimg = 0) or (not dirok) then
        cmd_SetShowPicture('OFF')
      else
        cmd_SetShowPicture('ON');
      if VerboseMsg then
        WriteTrace('ShowPicturesExecute');
    end;
end;

procedure Tf_main.ShowBackgroundImageExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if sc.cfgsc.ShowImageList then
        cmd_SetBGimage('OFF','ON')
      else
        cmd_SetBGimage('ON','ON', False);
      if VerboseMsg then
        WriteTrace('ShowBackgroundImageExecute');
    end;
end;

procedure Tf_main.DSSImageExecute(Sender: TObject);
begin
  if (MultiFrame1.ActiveObject is Tf_chart) and (Fits.dbconnected) then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if VerboseMsg then
        WriteTrace('DSSImageExecute');
      cmd_PDSS('', '', '', '');
    end;
end;

procedure Tf_main.BlinkImageExecute(Sender: TObject);
begin
  if (MultiFrame1.ActiveObject is Tf_chart) then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if BlinkTimer.Enabled then
      begin
        BlinkTimer.Enabled := False;
        sc.cfgsc.ShowImageList := True;
        sc.cfgsc.ShowBackgroundImage := SaveBlinkBG;
        if VerboseMsg then
          WriteTrace('BlinkImageExecute');
        Refresh(True, False);
      end
      else
      begin
        if sc.cfgsc.ShowImageList then
        begin
          SaveBlinkBG := sc.cfgsc.ShowBackgroundImage;
          BlinkTimer.Enabled := True;
        end
        else
        begin
          BlinkTimer.Enabled := False;
          BlinkImage.Checked := True;
        end;
      end;
    end;
end;

procedure Tf_main.SyncChartExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    cfgm.SyncChart := not cfgm.SyncChart;
    if cfgm.SyncChart then
      SyncChild;
  end;
end;

procedure Tf_main.ShowLinesExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowLine := not sc.cfgsc.ShowLine;
      if VerboseMsg then
        WriteTrace('ShowLinesExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowPlanetsExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowPlanet := not sc.cfgsc.ShowPlanet;
      if VerboseMsg then
        WriteTrace('ShowPlanetsExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.RecomputeAsteroid;
var
  cjd,jd1, jd2, step, h: double;
  y, m, d: integer;
  dy, dm, dd: word;
begin
  cjd:=0;
  if MultiFrame1.ActiveObject is Tf_chart then
    cjd:=Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.CurJDUT;
  if cjd<1 then begin
    DecodeDate(now, dy, dm, dd);
    cjd:=jd(dy,dm,dd,0);
  end;
  f_info.setpage(2);
  f_info.Show;
  f_info.ProgressMemo.Lines.add(rsComputeAster);
  djd(cjd, y, m, d, h);
  jd1 := jd(y, m, 1, 0);
  jd2 := jd(y, m + 1, 1, 0);
  step := max(1.0, (jd2 - jd1));
  if Planet.PrepareAsteroid(jd1, jd2, step, f_info.ProgressMemo.Lines) then
  begin
    if MultiFrame1.ActiveObject is Tf_chart then begin
      Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.ShowAsteroid := True;
      Tf_chart(MultiFrame1.ActiveObject).Refresh(True, True);
    end;
  end;
  f_info.hide;
end;

procedure Tf_main.ShowAsteroidsExecute(Sender: TObject);
var
  showast: boolean;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowAsteroid := not sc.cfgsc.ShowAsteroid;
      showast := sc.cfgsc.ShowAsteroid;
      if VerboseMsg then
        WriteTrace('ShowAsteroidsExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, True);
      if showast and (showast <> sc.cfgsc.ShowAsteroid) then
      begin
        RecomputeAsteroid;
      end;
    end;
end;

procedure Tf_main.ShowCometsExecute(Sender: TObject);
var
  showcom: boolean;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowComet := not sc.cfgsc.ShowComet;
      showcom := sc.cfgsc.ShowComet;
      if VerboseMsg then
        WriteTrace('ShowCometsExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, True);
      if showcom <> sc.cfgsc.ShowComet then
        ShowError(rsWarningSomeC+crlf+rsDate+': '+jddate(sc.cfgsc.CurJDUT)+crlf+rsErrorPleaseC2);
    end;
end;

procedure Tf_main.ShowMilkyWayExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowMilkyWay := not sc.cfgsc.ShowMilkyWay;
      if VerboseMsg then
        WriteTrace('ShowMilkyWayExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowLabelsExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.Showlabelall := not sc.cfgsc.Showlabelall;
      if VerboseMsg then
        WriteTrace('ShowLabelsExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ResetAllLabels1Click(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    Tf_chart(MultiFrame1.ActiveObject).sc.ResetAllLabel;
end;

procedure Tf_main.ResetDefaultChartExecute(Sender: TObject);
var
  i, w, h: integer;
  f1: TForm;
  r1: TRadioGroup;
  btn: TButtonPanel;
begin
  if VerboseMsg then
    WriteTrace('ResetDefaultChartExecute');
  if Sender <> nil then
  begin
    f1 := TForm.Create(self);
    f1.AutoSize := False;
    f1.Caption := rsResetChartAn;
    r1 := TRadioGroup.Create(f1);
    r1.AutoSize := True;
    r1.top := 8;
    r1.Left := 8;
    btn := TButtonPanel.Create(f1);
    btn.ButtonOrder := boCloseOKCancel;
    btn.ShowButtons := [pbOK, pbCancel];
    btn.OKButton.Caption := rsOK;
    btn.CancelButton.Caption := rsCancel;
    btn.ShowGlyphs := [];
    btn.AutoSize := True;
    btn.Align := alBottom;
    r1.Items.Add(rsResetInitial);
    r1.Items.Add(rsResetToLastT);
    r1.Items.Add(rsSetOptionsFo);
    r1.ItemIndex := 2;
    r1.Parent := f1;
    btn.Parent := f1;
    r1.AdjustSize;
    btn.AdjustSize;
    h := r1.Height + btn.Height + 16;
    w := max(f1.Canvas.TextWidth(rsResetInitial),
      f1.Canvas.TextWidth(rsResetToLastT)) + 80;
    f1.Height := h;
    f1.Width := w;
    ScaleDPI(f1);
    try
      FormPos(f1, mouse.cursorpos.x, mouse.cursorpos.y);
      if f1.ShowModal = mrOk then
      begin
        case r1.ItemIndex of
          0:
          begin
            WriteTrace('Reload default configuration');
            ClearAndRestart;
          end;
          1:
          begin
            WriteTrace('Reload last configuration');
            for i := 1 to MultiFrame1.ChildCount - 1 do
              if MultiFrame1.Childs[i].DockedObject is Tf_chart then
                MultiFrame1.Childs[i].Close;
            MultiFrame1.Maximized := True;
            with MultiFrame1.ActiveObject as Tf_chart do
            begin
              ReadChartConfig(configfile, True, True, sc.plot.cfgplot, sc.cfgsc);
              Refresh(True, True);
            end;
          end;
          2:
          begin
            WriteTrace('Set options for best performance');
            SetPerformanceOptions;
          end;
        end;
      end;
    finally
      btn.Free;
      r1.Free;
      f1.Free;
    end;
  end
  else
  begin
    WriteTrace('Reload last configuration');
    for i := 1 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
        MultiFrame1.Childs[i].Close;
    MultiFrame1.Maximized := True;
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      ReadChartConfig(configfile, True, True, sc.plot.cfgplot, sc.cfgsc);
      Refresh(True, True);
    end;
  end;
end;

procedure Tf_main.EditLabelsExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.Editlabels := not sc.cfgsc.Editlabels;
      if VerboseMsg then
        WriteTrace('EditLabelsExecute');
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowConstellationLineExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowConstl := not sc.cfgsc.ShowConstl;
      sc.cfgsc.CurrentConstel := '';
      if VerboseMsg then
        WriteTrace('ShowConstellationLineExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowConstellationLimitExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowConstB := not sc.cfgsc.ShowConstB;
      if VerboseMsg then
        WriteTrace('ShowConstellationLimitExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowGalacticEquatorExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowGalactic := not sc.cfgsc.ShowGalactic;
      if VerboseMsg then
        WriteTrace('ShowGalacticEquatorExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowEclipticExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowEcliptic := not sc.cfgsc.ShowEcliptic;
      if VerboseMsg then
        WriteTrace('ShowEclipticExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowMarkExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.ShowCircle := not sc.cfgsc.ShowCircle;
      if VerboseMsg then
        WriteTrace('ShowMarkExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowObjectbelowHorizonExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.horizonopaque := not sc.cfgsc.horizonopaque;
      if VerboseMsg then
        WriteTrace('ShowObjectbelowHorizonExecute');
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, True);
    end;
end;

procedure Tf_main.EquatorialProjectionExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.projpole := Equat;
      sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
      sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
      sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
      sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
      sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
      sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
      sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
      sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
      sc.cfgsc.FindOk := False; // invalidate the search result
      sc.cfgsc.theta := 0; // rotation = 0
      if VerboseMsg then
        WriteTrace('EquatorialProjectionExecute');
      Refresh(True, False);
    end;
end;

procedure Tf_main.AltAzProjectionExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.projpole := AltAz;
      sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
      sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
      sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
      sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
      sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
      sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
      sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
      sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
      sc.cfgsc.FindOk := False; // invalidate the search result
      sc.cfgsc.theta := 0; // rotation = 0
      if sc.cfgsc.EquinoxType <> 2 then
      begin // ensure equinox of the date
        sc.cfgsc.EquinoxType := 2;
        sc.cfgsc.EquinoxChart := rsDate;
        sc.cfgsc.DefaultJDChart := jd2000;
        sc.cfgsc.CoordExpertMode := False;
        sc.cfgsc.ApparentPos := True;
        sc.cfgsc.PMon := True;
        sc.cfgsc.YPmon := 0;
        sc.cfgsc.CoordType := 0;
      end;
      if VerboseMsg then
        WriteTrace('AltAzProjectionExecute');
      Refresh(True, False);
    end;
end;

procedure Tf_main.EclipticProjectionExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.projpole := Ecl;
      sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
      sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
      sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
      sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
      sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
      sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
      sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
      sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
      sc.cfgsc.FindOk := False; // invalidate the search result
      sc.cfgsc.theta := 0; // rotation = 0
      if VerboseMsg then
        WriteTrace('EclipticProjectionExecute');
      Refresh(True, False);
    end;
end;

procedure Tf_main.GalacticProjectionExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.projpole := Gal;
      sc.cfgsc.EquinoxType    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxType;
      sc.cfgsc.ApparentPos    := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].ApparentPos;
      sc.cfgsc.PMon           := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].PMon;
      sc.cfgsc.YPmon          := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].YPmon;
      sc.cfgsc.EquinoxChart   := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].EquinoxChart;
      sc.cfgsc.DefaultJDChart := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].DefaultJDChart;
      sc.cfgsc.CoordExpertMode:= sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordExpertMode;
      sc.cfgsc.CoordType      := sc.cfgsc.ProjOptions[sc.cfgsc.ProjPole].CoordType;
      sc.cfgsc.FindOk := False; // invalidate the search result
      sc.cfgsc.theta := 0; // rotation = 0
      if VerboseMsg then
        WriteTrace('GalacticProjectionExecute');
      Refresh(True, False);
    end;
end;

procedure Tf_main.CalendarExecute(Sender: TObject);
begin
  if not f_calendar.Visible then
  begin
    if MultiFrame1.ActiveObject is Tf_chart then
      f_calendar.config.Assign(Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc)
    else
      f_calendar.config.Assign(def_cfgsc);
  end;
  f_calendar.AzNorth := catalog.cfgshr.AzNorth;
  formpos(f_calendar, mouse.cursorpos.x, mouse.cursorpos.y);
  f_calendar.Show;
  f_calendar.bringtofront;
end;

procedure Tf_main.MenuLockChartClick(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with (MultiFrame1.ActiveObject as Tf_chart) do
    begin
      sc.cfgsc.ChartLock := not sc.cfgsc.ChartLock;
    end;
end;

procedure Tf_main.TrackExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with (MultiFrame1.ActiveObject as Tf_chart) do
    begin
      if sc.cfgsc.TrackOn then
      begin
        if VerboseMsg then
          WriteTrace('TrackExecute 1');
        sc.cfgsc.TrackOn := False;
        Refresh(True, False);
      end
      else if (((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or
        (sc.cfgsc.TrackType = TTequat) or (sc.cfgsc.TrackType = TTbody)) and (sc.cfgsc.TrackName <> '') then
      begin
        if VerboseMsg then
          WriteTrace('TrackExecute 2');
        sc.cfgsc.TrackOn := True;
        Refresh(True, False);
      end
      else
      begin
        sc.cfgsc.TrackOn := False;
        UpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked,
          MultiFrame1.ActiveObject);
      end;
    end;
end;

procedure Tf_main.TrackTelescopeExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with (MultiFrame1.ActiveObject as Tf_chart) do
    begin
      TrackTelescope1Click(Sender);
    end;
end;

procedure Tf_main.TrajectoriesExecute(Sender: TObject);
begin
  SetupTimePage(1);
end;

procedure Tf_main.PositionExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      f_position.onApply := PositionApply;
      f_position.cfgsc := sc.cfgsc;
      f_position.catalog := sc.catalog;
      f_position.AzNorth := sc.catalog.cfgshr.AzNorth;
      formpos(f_position, mouse.cursorpos.x, mouse.cursorpos.y);
      f_position.showmodal;
      if f_position.modalresult = mrOk then
      begin
        PositionApply(Sender);
      end;
    end;
end;

procedure Tf_main.PositionApply(Sender: TObject);
var r,d: double;
begin
  f_position.GetRaDec(r,d);
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if VerboseMsg then
        WriteTrace('PositionExecute');
      if f_position.LockPosition.Checked then
      begin
        sc.cfgsc.TrackName:=f_position.ra.Text+' '+f_position.de.Text;
        sc.cfgsc.TrackRA := 15 * deg2rad * r;
        sc.cfgsc.TrackDec := deg2rad * d;
        sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
        sc.cfgsc.FindOK := True;
        sc.cfgsc.FindSize := 0;
        sc.cfgsc.FindPM := False;
        sc.cfgsc.FindType := ftLock;
        sc.cfgsc.FindName:=sc.cfgsc.TrackName;
        sc.cfgsc.FindId := sc.cfgsc.FindName;
        sc.cfgsc.FindDesc := '';
        sc.cfgsc.FindNote := '';
        sc.cfgsc.FindRA:=sc.cfgsc.TrackRA;
        sc.cfgsc.FindDec:=sc.cfgsc.TrackDec;
        sc.cfgsc.FindRA2000 := sc.cfgsc.TrackRA;
        sc.cfgsc.FindDec2000 := sc.cfgsc.TrackDec;
        Precession(sc.cfgsc.JDChart, jd2000, sc.cfgsc.FindRA2000, sc.cfgsc.FindDec2000);
        sc.cfgsc.fov := deg2rad * f_position.fov.Value;
        sc.cfgsc.theta := deg2rad * f_position.rot.Value;
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTequat;
        cmd_SetCursorPosition(Image1.Width div 2, Image1.Height div 2);
      end
      else
      begin
        if sc.cfgsc.Projpole = Altaz then
        begin
          sc.cfgsc.TrackOn := True;
          sc.cfgsc.TrackType := TTaltaz;
          sc.cfgsc.acentre := deg2rad * f_position.long.Value;
          if sc.catalog.cfgshr.AzNorth then
            sc.cfgsc.acentre := rmod(sc.cfgsc.acentre + pi, pi2);
          sc.cfgsc.hcentre := deg2rad * f_position.lat.Value;
        end
        else
          sc.cfgsc.TrackOn := False;
        sc.cfgsc.racentre := 15 * deg2rad * r;
        sc.cfgsc.decentre := deg2rad * d;
        sc.cfgsc.fov := deg2rad * f_position.fov.Value;
        sc.cfgsc.theta := deg2rad * f_position.rot.Value;
      end;
      if f_position.LockMag.Checked then begin
        cmd_LockMagn(f_position.StarMag.Value,f_position.AstMag.Value,f_position.ComMag.Value,
                     f_position.DSOmag.Value,f_position.DSOsize.Value,
                     f_position.ShowAllDouble.Checked,f_position.ShowAllVariable.Checked);
      end
      else begin
        cmd_UnLockMagn;
      end;
    end;
end;

procedure Tf_main.Search1Execute(Sender: TObject);
var
  ok: string;
  i: integer;
  chart: Tf_chart;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    chart := Tf_chart(MultiFrame1.ActiveObject)
  else
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      begin
        chart := Tf_chart(MultiFrame1.Childs[i].DockedObject);
        break;
      end;

  if cfgm.HttpProxy then
  begin
    f_search.SocksProxy := '';
    f_search.SocksType := '';
    f_search.HttpProxy := cfgm.ProxyHost;
    f_search.HttpProxyPort := cfgm.ProxyPort;
    f_search.HttpProxyUser := cfgm.ProxyUser;
    f_search.HttpProxyPass := cfgm.ProxyPass;
  end
  else if cfgm.SocksProxy then
  begin
    f_search.HttpProxy := '';
    f_search.SocksType := cfgm.SocksType;
    f_search.SocksProxy := cfgm.ProxyHost;
    f_search.HttpProxyPort := cfgm.ProxyPort;
    f_search.HttpProxyUser := cfgm.ProxyUser;
    f_search.HttpProxyPass := cfgm.ProxyPass;
  end
  else
  begin
    f_search.SocksProxy := '';
    f_search.SocksType := '';
    f_search.HttpProxy := '';
    f_search.HttpProxyPort := '';
    f_search.HttpProxyUser := '';
    f_search.HttpProxyPass := '';
  end;
  formpos(f_search, mouse.cursorpos.x, mouse.cursorpos.y);
  ok := '';
  f_search.csc:=chart.sc.cfgsc;
  f_search.InitBody;
  repeat
    f_search.showmodal;
    if f_search.modalresult = mrOk then
    begin
      ok := Find(f_search.SearchKind, f_search.Num, f_search.ra, f_search.de);
      if ok <> msgOK then
        ShowError(Format(rsNotFoundMayb, [f_search.Num, crlf]));
    end;
  until (ok = msgOK) or (f_search.ModalResult <> mrOk);
end;

procedure Tf_main.FindInfo(Sender: TObject);
var savechartlock: boolean;
    p: Tpoint;
    ok: string;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with (MultiFrame1.ActiveObject as Tf_chart) do
    begin
      savechartlock:=sc.cfgsc.ChartLock;
      sc.cfgsc.ChartLock := true;
      sc.cfgsc.FindDesc:='';
      sc.cfgsc.FindDesc2:='';
      sc.cfgsc.FindDesc2000:='';
      ok := Find(f_search.SearchKind, f_search.Num, f_search.ra, f_search.de);
      if ok = msgOK then begin
        if (not f_detail.Visible) then begin
          p.x:=f_search.Left+f_search.Width;
          p.y:=f_search.Top;
          formpos(f_detail, p.x, p.y);
        end;
        f_detail.Hide;
        identlabelClick(nil);
      end
      else begin
        ShowError(Format(rsNotFoundMayb, [f_search.Num, crlf]));
      end;
      sc.cfgsc.ChartLock := savechartlock;
    end;
end;

function Tf_main.Find(kind: integer; num: string; def_ra: double = 0;
  def_de: double = 0): string;
var
  ok: boolean;
  ar1, de1, mag: double;
  i, itype: integer;
  chart: TFrame;
  stype, buf: string;
begin
  if VerboseMsg then
    WriteTrace('Search1Execute');
  Result := msgFailed;
  chart := nil;
  ok := False;
  if MultiFrame1.ActiveObject is Tf_chart then
    chart := MultiFrame1.ActiveObject
  else
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      begin
        chart := MultiFrame1.Childs[i].DockedObject;
        break;
      end;
  itype := ftInv;
  if chart is Tf_chart then
    with chart as Tf_chart do
    begin
      catalog.ClearSearch;
      sc.cfgsc.CurrentConstel:='';
      case kind of
        0:
        begin
          sc.cfgsc.shownebulae:=true;
          ok := catalog.SearchNebulae(num, ar1, de1);
          itype := ftNeb;
          stype := 'N';
        end;
        1:
        begin
          sc.cfgsc.shownebulae:=true;
          ar1 := def_ra;
          de1 := def_de;
          itype := ftNeb;
          stype := 'N';
          ok := True;
        end;
        2:
        begin
          sc.cfgsc.showstars:=true;
          ok := catalog.SearchStar(num, ar1, de1);
          itype := ftStar;
          stype := '*';
        end;
        3:
        begin
          sc.cfgsc.showstars:=true;
          ok := catalog.SearchStar(num, ar1, de1);
          itype := ftStar;
          stype := '*';
        end;
        4:
        begin
          sc.cfgsc.showstars:=true;
          ok := catalog.SearchVarStar(num, ar1, de1);
          if not ok then begin
            ok := catalog.SearchVarAlias(num, buf);
            if ok then begin
              num:=buf;
              ok := catalog.SearchVarStar(num, ar1, de1);
            end;
          end;
          itype := ftVar;
          stype := 'V*';
        end;
        5:
        begin
          sc.cfgsc.showstars:=true;
          ok := catalog.SearchDblStar(num, ar1, de1);
          itype := ftDbl;
          stype := 'D*';
        end;
        6:
        begin
          sc.cfgsc.ShowComet:=true;
          ok := planet.FindCometName(trim(num), ar1, de1, mag, sc.cfgsc, True);
          itype := ftCom;
          stype := 'Cm';
        end;
        7:
        begin
          sc.cfgsc.ShowAsteroid:=true;
          ok := planet.FindAsteroidName(trim(num), ar1, de1, mag, sc.cfgsc, True);
          itype := ftAst;
          stype := 'As';
        end;
        8:
        begin
          sc.cfgsc.ShowPlanet:=true;
          ok := planet.FindPlanetName(trim(num), ar1, de1, sc.cfgsc);
          itype := ftPla;
          stype := 'P';
        end;
        9:
        begin
          ok := catalog.SearchConstellation(num, ar1, de1,buf);
          sc.cfgsc.CurrentConstel := uppercase(copy(trim(buf),1,3));
          itype := ftlin;
          stype := '';
        end;
        10:
        begin
          ar1 := def_ra;
          de1 := def_de;
          itype := ftOnline;
          stype := 'OSR';
          ok := True;
        end;
        11:
        begin
          ok := planet.FindBodyName(trim(num), ar1, de1, mag, sc.cfgsc, false);
          itype := ftBody;
          stype := 'Spk';
        end;
        else
        begin
          ok := False;
          stype := '';
        end;
      end;
      if ok then
      begin
        IdentSearchResult(num, stype, itype, ar1, de1, f_search.sesame_resolver,
          f_search.sesame_name, f_search.sesame_desc);
        if kind in [0, 2, 3, 4, 5, 6, 7, 8] then
        begin
          i := quicksearch.Items.IndexOf(num);
          if (i < 0) and (quicksearch.Items.Count >= MaxQuickSearch) then
            i := MaxQuickSearch - 1;
          if i >= 0 then
            quicksearch.Items.Delete(i);
          quicksearch.Items.Insert(0, num);
          quicksearch.ItemIndex:=quicksearch.Items.Count-1;
          quicksearch.ItemIndex := 0;
        end;
        Result := msgOK;
      end
      else
      begin
        Result := msgNotFound;
      end;
    end;
end;

procedure Tf_main.GetChartConfig(csc: Tconf_skychart);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
      csc.Assign(sc.cfgsc)
  else
    csc.Assign(def_cfgsc);
end;

procedure Tf_main.DrawChart(csc: Tconf_skychart);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.cfgsc.Assign(csc);
      if VerboseMsg then
        WriteTrace('DrawChart');
      Refresh(True, True);
    end;
end;

procedure Tf_main.MenuReleaseNotesClick(Sender: TObject);
begin
  ShowReleaseNotes(False);
end;

procedure Tf_main.SetupTimeExecute(Sender: TObject);
begin
  SetupTimePage(-1);
end;

procedure Tf_main.SetupCalendarExecute(Sender: TObject);
begin
  SetupCalendarPage(-1);
end;

procedure Tf_main.ConfigPopupExecute(Sender: TObject);
begin
  ShowScriptPanel(8, False);
end;

procedure Tf_main.SetupCalendarPage(page: integer);
begin
  if not SetupCalendar.Enabled then exit;
  if ConfigCalendar = nil then begin
    ConfigCalendar := Tf_configcalendar.Create(self);
    ConfigCalendar.f_config_calendar1.PageControl1.ShowTabs := True;
    ConfigCalendar.f_config_calendar1.PageControl1.PageIndex := 0;
    ConfigCalendar.f_config_calendar1.onApplyConfig := ApplyConfigCalendar;
  end;
  try
    ConfigCalendar.f_config_calendar1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigCalendar.f_config_calendar1.csc.Assign(sc.cfgsc);
      end;
    formpos(ConfigCalendar, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigCalendar.f_config_calendar1.PageControl1.PageIndex := page;
    ConfigCalendar.showmodal;
    if ConfigCalendar.ModalResult = mrOk then
    begin
      activateconfig(nil, ConfigCalendar.f_config_calendar1.csc, nil,
        nil, nil, nil, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigCalendar(Sender: TObject);
begin
  activateconfig(nil, ConfigCalendar.f_config_calendar1.csc, nil, nil, nil, nil, False);
end;

procedure Tf_main.SetupTimePage(page: integer);
begin
  if not SetupTime.Enabled then exit;
  if ConfigTime = nil then begin
    ConfigTime := Tf_configtime.Create(self);
    ConfigTime.f_config_time1.PageControl1.ShowTabs := True;
    ConfigTime.f_config_time1.PageControl1.PageIndex := 0;
    ConfigTime.f_config_time1.onApplyConfig := ApplyConfigTime;
    ConfigTime.f_config_time1.onGetTwilight := GetTwilight;
  end;
  try
    ConfigTime.f_config_time1.ccat.Assign(catalog.cfgcat);
    ConfigTime.f_config_time1.cshr.Assign(catalog.cfgshr);
    ConfigTime.f_config_time1.cplot.Assign(def_cfgplot);
    ConfigTime.f_config_time1.csc.Assign(def_cfgsc);
    ConfigTime.f_config_time1.cdb:=cdcdb;
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigTime.f_config_time1.csc.Assign(sc.cfgsc);
        ConfigTime.f_config_time1.cplot.Assign(sc.plot.cfgplot);
      end;
    cfgm.persdir := privatedir;
    ConfigTime.f_config_time1.cmain.Assign(cfgm);
    formpos(ConfigTime, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigTime.f_config_time1.PageControl1.PageIndex := page;
    ConfigTime.showmodal;
    if ConfigTime.ModalResult = mrOk then
    begin
      activateconfig(ConfigTime.f_config_time1.cmain, ConfigTime.f_config_time1.csc,
        ConfigTime.f_config_time1.ccat, ConfigTime.f_config_time1.cshr,
        ConfigTime.f_config_time1.cplot, nil, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigTime(Sender: TObject);
begin
  activateconfig(ConfigTime.f_config_time1.cmain, ConfigTime.f_config_time1.csc,
    ConfigTime.f_config_time1.ccat, ConfigTime.f_config_time1.cshr,
    ConfigTime.f_config_time1.cplot, nil, False);
end;

procedure Tf_main.SetPicturesExecute(Sender: TObject);
begin
  ShowBackgroundImageExecute(Sender);
end;

procedure Tf_main.SetupChartExecute(Sender: TObject);
begin
  SetupChartPage(-1);
end;

procedure Tf_main.SetupConfigExecute(Sender: TObject);
begin
  if f_config = nil then
  begin
    f_config := Tf_config.Create(application);
    f_config.onApplyConfig := ApplyConfig;
    f_config.onSaveAndRestart := SaveAndRestart;
    f_config.onPrepareAsteroid := PrepareAsteroid;
    f_config.onEnableAsteroid:=EnableAsteroid;
    f_config.onDisableAsteroid:=DisableAsteroid;
    f_config.onGetTwilight := GetTwilight;
    f_config.Fits := fits;
    f_config.catalog := catalog;
    f_config.db := cdcdb;
    f_config.f_config_catalog1.onInstallCatalog := OpenUpdCatalog;
    f_config.f_config_catalog1.onRunCatgen := RunCatgen;
  end;
  try
    f_config.ccat := catalog.cfgcat;
    f_config.cshr := catalog.cfgshr;
    f_config.cplot := def_cfgplot;
    f_config.csc := def_cfgsc;
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        f_config.csc := sc.cfgsc;
        f_config.cplot := sc.plot.cfgplot;
      end;
    cfgm.persdir := privatedir;
    f_config.cmain := cfgm;
    f_config.cdss := f_getdss.cfgdss;
    f_config.applyall.Checked := cfgm.updall;
    formpos(f_config, mouse.cursorpos.x, mouse.cursorpos.y);
    f_config.TreeView1.Enabled := True;
    f_config.previous.Enabled := True;
    f_config.Next.Enabled := True;
    ShowModalForm(f_config);
    if f_config.ModalResult = mrOk then
    begin
      activateconfig(f_config.cmain, f_config.csc, f_config.ccat, f_config.cshr,
        f_config.cplot, f_config.cdss, f_config.Applyall.Checked);
    end;

  finally
    screen.cursor := crDefault;
  end;
end;

procedure Tf_main.ShowConfigPanel(show: boolean);
begin
  if (not show) then
  begin   // hide panel
    if (f_configdirect <> nil) then begin
      try
      Application.QueueAsyncCall(HideConfigDirectAsync(),0);
      except
      end;
    end;
    Splitter1.Visible := False;
    ScriptPanel.Visible := False;
    ScriptPanel.Width := SaveScriptPanelWidth;
    // enable config menu
    SetupTime.Enabled:=true;
    SetupObservatory.Enabled:=true;
    SetupDisplay.Enabled:=true;
    SetupCatalog.Enabled:=true;
    SetupChart.Enabled:=true;
    SetupSolSys.Enabled:=true;
    SetupSystem.Enabled:=true;
    SetupInternet.Enabled:=true;
    SetupConfig.Enabled:=true;
    SetupCalendar.Enabled:=true;
    SetupPictures.Enabled:=true;
  end
  else begin  // show panel
  // same as SetupConfigExecute
  if f_configdirect = nil then
  begin
    f_configdirect := Tf_configdirect.Create(application);
    f_configdirect.onApplyConfig := RefreshActiveChart;
    f_configdirect.onPrepareAsteroid := PrepareAsteroid;
    f_configdirect.onEnableAsteroid:=EnableAsteroid;
    f_configdirect.onDisableAsteroid:=DisableAsteroid;
    f_configdirect.onGetTwilight := GetTwilight;
    f_configdirect.Fits := fits;
    f_configdirect.catalog := catalog;
    f_configdirect.db := cdcdb;
    f_configdirect.f_config_catalog1.onInstallCatalog := OpenUpdCatalog;
    f_configdirect.f_config_catalog1.onRunCatgen := RunCatgen;
    f_configdirect.PageControl1.ActivePageIndex:=1;
  end;
  f_configdirect.ccat := catalog.cfgcat;
  f_configdirect.cshr := catalog.cfgshr;
  f_configdirect.cplot := def_cfgplot;
  f_configdirect.csc := def_cfgsc;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      f_configdirect.csc := sc.cfgsc;
      f_configdirect.cplot := sc.plot.cfgplot;
    end;
  cfgm.persdir := privatedir;
  f_configdirect.cmain := cfgm;
  f_configdirect.cdss := f_getdss.cfgdss;
  // disable config menu
  SetupTime.Enabled:=false;
  SetupObservatory.Enabled:=false;
  SetupDisplay.Enabled:=false;
  SetupCatalog.Enabled:=false;
  SetupChart.Enabled:=false;
  SetupSolSys.Enabled:=false;
  SetupSystem.Enabled:=false;
  SetupInternet.Enabled:=false;
  SetupConfig.Enabled:=false;
  SetupCalendar.Enabled:=false;
  SetupPictures.Enabled:=false;
  // panel specific
  SaveScriptPanelWidth:=ScriptPanel.Width;
  ScriptPanel.Width:=DoScaleX(520); // config panel width
  Splitter1.Visible := True;
  ScriptPanel.Visible := True;
  Splitter1.ResizeControl := ScriptPanel;
  f_configdirect.Parent:=ScriptPanel;
  f_configdirect.Align:=alClient;
  f_configdirect.Show;
  end;
end;

procedure Tf_main.HideConfigDirectAsync(Data: PtrInt);
begin
  if (f_configdirect <> nil) then f_configdirect.Close;
end;

procedure Tf_main.RefreshActiveChart(Sender: TObject);
begin
 if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      Refresh(false,false);
    end;
end;

procedure Tf_main.ActivatePictures(Sender: TObject);
begin
 if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      cmd_SetShowPicture('ON');
    end;
end;

procedure Tf_main.ApplyConfig(Sender: TObject);
begin
  activateconfig(f_config.cmain, f_config.csc, f_config.ccat, f_config.cshr,
    f_config.cplot, f_config.cdss, f_config.Applyall.Checked);
end;

procedure Tf_main.SetupChartPage(page: integer);
begin
  if not SetupChart.Enabled then exit;
  if ConfigChart = nil then begin
    ConfigChart := Tf_configchart.Create(self);
    ConfigChart.f_config_chart1.PageControl1.ShowTabs := True;
    ConfigChart.f_config_chart1.PageControl1.PageIndex := 0;
    ConfigChart.f_config_chart1.onApplyConfig := ApplyConfigChart;
  end;
  try
    ConfigChart.f_config_chart1.ccat.Assign(catalog.cfgcat);
    ConfigChart.f_config_chart1.cshr.Assign(catalog.cfgshr);
    ConfigChart.f_config_chart1.cplot.Assign(def_cfgplot);
    ConfigChart.f_config_chart1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigChart.f_config_chart1.csc.Assign(sc.cfgsc);
        ConfigChart.f_config_chart1.cplot.Assign(sc.plot.cfgplot);
      end;
    cfgm.persdir := privatedir;
    ConfigChart.f_config_chart1.cmain.Assign(cfgm);
    formpos(ConfigChart, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigChart.f_config_chart1.PageControl1.PageIndex := page;
    ConfigChart.showmodal;
    if ConfigChart.ModalResult = mrOk then
    begin
      activateconfig(ConfigChart.f_config_chart1.cmain, ConfigChart.f_config_chart1.csc,
        ConfigChart.f_config_chart1.ccat, ConfigChart.f_config_chart1.cshr,
        ConfigChart.f_config_chart1.cplot, nil, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigChart(Sender: TObject);
begin
  activateconfig(ConfigChart.f_config_chart1.cmain, ConfigChart.f_config_chart1.csc,
    ConfigChart.f_config_chart1.ccat, ConfigChart.f_config_chart1.cshr,
    ConfigChart.f_config_chart1.cplot, nil, False);
end;

procedure Tf_main.SetupSolSysExecute(Sender: TObject);
begin
  SetupSolsysPage(-1);
end;

procedure Tf_main.SetupSolsysPage(page: integer; directdownload: boolean = False);
var inif: TMemIniFile;
    section: string;
begin
  if not SetupSolSys.Enabled then exit;
  if ConfigSolsys = nil then begin
    ConfigSolsys := Tf_configsolsys.Create(self);
    ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := True;
    ConfigSolsys.f_config_solsys1.PageControl1.PageIndex := 0;
    ConfigSolsys.f_config_solsys1.onApplyConfig := ApplyConfigSolsys;
    ConfigSolsys.f_config_solsys1.onPrepareAsteroid := PrepareAsteroid;
    ConfigSolsys.f_config_solsys1.onDisableAsteroid := DisableAsteroid;
    ConfigSolsys.f_config_solsys1.onEnableAsteroid := EnableAsteroid;
  end;
  try
    ConfigSolsys.f_config_solsys1.cdb := cdcdb;
    ConfigSolsys.f_config_solsys1.ccat.Assign(catalog.cfgcat);
    ConfigSolsys.f_config_solsys1.cshr.Assign(catalog.cfgshr);
    ConfigSolsys.f_config_solsys1.cplot.Assign(def_cfgplot);
    ConfigSolsys.f_config_solsys1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigSolsys.f_config_solsys1.csc.Assign(sc.cfgsc);
        ConfigSolsys.f_config_solsys1.cplot.Assign(sc.plot.cfgplot);
      end;
    cfgm.persdir := privatedir;
    ConfigSolsys.f_config_solsys1.cmain.Assign(cfgm);
    formpos(ConfigSolsys, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigSolsys.f_config_solsys1.PageControl1.PageIndex := page;
    if directdownload then
    begin
      case page of
        1:
        begin
          ConfigSolsys.Panel1.Visible := False;
          ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := False;
          ConfigSolsys.Show;
          ConfigSolsys.f_config_solsys1.BtnDownloadGRS.Click;
          activateconfig(ConfigSolsys.f_config_solsys1.cmain,
            ConfigSolsys.f_config_solsys1.csc, ConfigSolsys.f_config_solsys1.ccat,
            ConfigSolsys.f_config_solsys1.cshr, ConfigSolsys.f_config_solsys1.cplot,
            nil, False);
          inif := TMeminifile.Create(Configfile);
          section := 'default_chart';
          inif.WriteFloat(section, 'GRSlongitude', ConfigSolsys.f_config_solsys1.csc.GRSlongitude);
          inif.WriteFloat(section, 'GRSjd', ConfigSolsys.f_config_solsys1.csc.GRSjd);
          inif.WriteFloat(section, 'GRSdrift', ConfigSolsys.f_config_solsys1.csc.GRSdrift);
          inif.Updatefile;
          inif.Free;
          ConfigSolsys.Panel1.Visible := True;
          ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := True;
          ConfigSolsys.Close;
        end;
        2:
        begin
          if (MultiFrame1.ActiveObject is Tf_chart) then
            Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.ShowComet:=false;
          ConfigSolsys.Panel1.Visible := False;
          ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := False;
          ConfigSolsys.f_config_solsys1.ComPageControl.ShowTabs := False;
          ConfigSolsys.f_config_solsys1.ComPageControl1.ShowTabs := False;
          ConfigSolsys.f_config_solsys1.DownloadComet.Visible := False;
          ConfigSolsys.f_config_solsys1.ConfirmDownload := False;
          ConfigSolsys.Show;
          ConfigSolsys.f_config_solsys1.ComPageControl.ActivePageIndex := 2;
          ConfigSolsys.f_config_solsys1.DelComAll.Click;
          ConfigSolsys.f_config_solsys1.ComPageControl.ActivePageIndex := 1;
          ConfigSolsys.f_config_solsys1.DownloadComet.Click;
          if ConfigSolsys.f_config_solsys1.autoOK then
          begin
            if (MultiFrame1.ActiveObject is Tf_chart) then
              Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.ShowComet:=true;
            RefreshAllChild(False);
            ShowMessage(rsCometUpdateS);
          end;
          ConfigSolsys.Panel1.Visible := True;
          ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := True;
          ConfigSolsys.f_config_solsys1.ComPageControl.ShowTabs := True;
          ConfigSolsys.f_config_solsys1.ComPageControl1.ShowTabs := True;
          ConfigSolsys.f_config_solsys1.DownloadComet.Visible := True;
          ConfigSolsys.f_config_solsys1.ConfirmDownload := True;
          ConfigSolsys.Close;
        end;
        3:
        begin
          DisableAsteroid(nil);
          ConfigSolsys.Panel1.Visible := False;
          ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := False;
          ConfigSolsys.f_config_solsys1.AstPageControl.ShowTabs := False;
          ConfigSolsys.f_config_solsys1.AstPageControl2.ShowTabs := False;
          ConfigSolsys.f_config_solsys1.DownloadAsteroid.Visible := False;
          ConfigSolsys.f_config_solsys1.ConfirmDownload := False;
          ConfigSolsys.f_config_solsys1.autoprocess := True;
          ConfigSolsys.Show;
          ConfigSolsys.f_config_solsys1.AstCompute.Visible:=false;
          ConfigSolsys.f_config_solsys1.AstPageControl.ActivePageIndex := 3;
          ConfigSolsys.f_config_solsys1.AstPageControl.ActivePageIndex := 1;
          ConfigSolsys.f_config_solsys1.DownloadAsteroid.Click;
          if ConfigSolsys.f_config_solsys1.autoOK then
          begin
            EnableAsteroid(nil);
            RefreshAllChild(False);
            ShowMessage(rsAsteroidUpda);
          end;
          ConfigSolsys.Panel1.Visible := True;
          ConfigSolsys.f_config_solsys1.PageControl1.ShowTabs := True;
          ConfigSolsys.f_config_solsys1.AstPageControl.ShowTabs := True;
          ConfigSolsys.f_config_solsys1.AstPageControl2.ShowTabs := True;
          ConfigSolsys.f_config_solsys1.DownloadAsteroid.Visible := True;
          ConfigSolsys.f_config_solsys1.ConfirmDownload := True;
          ConfigSolsys.f_config_solsys1.autoprocess := False;
          ConfigSolsys.Close;
        end;
      end;
    end
    else
    begin
      ConfigSolsys.showmodal;
      if ConfigSolsys.ModalResult = mrOk then
      begin
        activateconfig(ConfigSolsys.f_config_solsys1.cmain,
          ConfigSolsys.f_config_solsys1.csc, ConfigSolsys.f_config_solsys1.ccat,
          ConfigSolsys.f_config_solsys1.cshr, ConfigSolsys.f_config_solsys1.cplot,
          nil, False);
      end;
    end;
  finally
  end;
end;

procedure Tf_main.EnableAsteroid(Sender: TObject);
var i: integer;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      with MultiFrame1.Childs[i].DockedObject as Tf_chart do
      begin
        sc.cfgsc.ShowAsteroid:=true;
      end;
end;

procedure Tf_main.DisableAsteroid(Sender: TObject);
var i: integer;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      with MultiFrame1.Childs[i].DockedObject as Tf_chart do
      begin
        sc.cfgsc.ShowAsteroid:=false;
      end;
end;

procedure Tf_main.ApplyConfigSolsys(Sender: TObject);
begin
  activateconfig(ConfigSolsys.f_config_solsys1.cmain, ConfigSolsys.f_config_solsys1.csc,
    ConfigSolsys.f_config_solsys1.ccat, ConfigSolsys.f_config_solsys1.cshr,
    ConfigSolsys.f_config_solsys1.cplot, nil, False);
end;

function Tf_main.LoadMPCORB(fn:string): string;
var memo:Tmemo;
begin
  Result := msgFailed;
  memo:=Tmemo.Create(nil);
  try
    if cdcdb.LoadAsteroidFile(fn, False,false,false,false,0,memo) then begin
      RecomputeAsteroid;
      Result := msgOK;
    end;
  finally
    memo.Free;
  end;
end;

procedure Tf_main.TelescopeSetupExecute(Sender: TObject);
begin
  SetupSystemPage(1);
end;

procedure Tf_main.SetupSystemExecute(Sender: TObject);
begin
  SetupSystemPage(-1);
end;

procedure Tf_main.SetupSystemPage(page: integer);
begin
  if not SetupSystem.Enabled then exit;
  if ConfigSystem = nil then begin
    ConfigSystem := Tf_configsystem.Create(self);
    ConfigSystem.f_config_system1.PageControl1.ShowTabs := True;
    ConfigSystem.f_config_system1.PageControl1.PageIndex := 0;
    ConfigSystem.f_config_system1.onApplyConfig := ApplyConfigSystem;
    ConfigSystem.f_config_system1.onSaveAndRestart := SaveAndRestart;
  end;
  try
    ConfigSystem.f_config_system1.cdb := cdcdb;
    ConfigSystem.f_config_system1.ccat.Assign(catalog.cfgcat);
    ConfigSystem.f_config_system1.cshr.Assign(catalog.cfgshr);
    ConfigSystem.f_config_system1.cplot.Assign(def_cfgplot);
    ConfigSystem.f_config_system1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigSystem.f_config_system1.csc.Assign(sc.cfgsc);
        ConfigSystem.f_config_system1.cplot.Assign(sc.plot.cfgplot);
      end;
    cfgm.persdir := privatedir;
    ConfigSystem.f_config_system1.cmain.Assign(cfgm);
    formpos(ConfigSystem, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigSystem.f_config_system1.PageControl1.PageIndex := page;
    ConfigSystem.showmodal;
    if ConfigSystem.ModalResult = mrOk then
    begin
      activateconfig(ConfigSystem.f_config_system1.cmain,
        ConfigSystem.f_config_system1.csc,
        ConfigSystem.f_config_system1.ccat, ConfigSystem.f_config_system1.cshr,
        ConfigSystem.f_config_system1.cplot, nil, False);
    end;
  finally
  end;
end;

procedure Tf_main.MenuResetLanguageClick(Sender: TObject);
begin
  // Reset language to default using the same procedure as SetupSystemPage
  if ConfigSystem = nil then
  begin
    ConfigSystem := Tf_configsystem.Create(self);
    ConfigSystem.f_config_system1.PageControl1.ShowTabs := True;
    ConfigSystem.f_config_system1.PageControl1.PageIndex := 0;
    ConfigSystem.f_config_system1.onApplyConfig := ApplyConfigSystem;
    ConfigSystem.f_config_system1.onSaveAndRestart := SaveAndRestart;
  end;
  ConfigSystem.f_config_system1.cdb := cdcdb;
  ConfigSystem.f_config_system1.ccat.Assign(catalog.cfgcat);
  ConfigSystem.f_config_system1.cshr.Assign(catalog.cfgshr);
  ConfigSystem.f_config_system1.cplot.Assign(def_cfgplot);
  ConfigSystem.f_config_system1.csc.Assign(def_cfgsc);
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      ConfigSystem.f_config_system1.csc.Assign(sc.cfgsc);
      ConfigSystem.f_config_system1.cplot.Assign(sc.plot.cfgplot);
    end;
  cfgm.persdir := privatedir;
  ConfigSystem.f_config_system1.cmain.Assign(cfgm);
  ConfigSystem.f_config_system1.cmain.language := '';
  activateconfig(ConfigSystem.f_config_system1.cmain, ConfigSystem.f_config_system1.csc,
    ConfigSystem.f_config_system1.ccat, ConfigSystem.f_config_system1.cshr,
    ConfigSystem.f_config_system1.cplot, nil, False);
end;

procedure Tf_main.ApplyConfigSystem(Sender: TObject);
begin
  activateconfig(ConfigSystem.f_config_system1.cmain, ConfigSystem.f_config_system1.csc,
    ConfigSystem.f_config_system1.ccat, ConfigSystem.f_config_system1.cshr,
    ConfigSystem.f_config_system1.cplot, nil, False);
end;

procedure Tf_main.SetupInternetExecute(Sender: TObject);
begin
  SetupInternetPage(-1);
end;

procedure Tf_main.SetupInternetPage(page: integer);
begin
  if not SetupInternet.Enabled then exit;
  if ConfigInternet = nil then begin
    ConfigInternet := Tf_configinternet.Create(self);
    ConfigInternet.f_config_internet1.PageControl1.ShowTabs := True;
    ConfigInternet.f_config_internet1.PageControl1.PageIndex := 0;
    ConfigInternet.f_config_internet1.onApplyConfig := ApplyConfigInternet;
  end;
  try
    cfgm.persdir := privatedir;
    ConfigInternet.f_config_internet1.cmain.Assign(cfgm);
    ConfigInternet.f_config_internet1.cdss.Assign(f_getdss.cfgdss);
    formpos(ConfigInternet, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigInternet.f_config_internet1.PageControl1.PageIndex := page;
    ConfigInternet.showmodal;
    if ConfigInternet.ModalResult = mrOk then
    begin
      activateconfig(ConfigInternet.f_config_internet1.cmain, nil, nil, nil,
        nil, ConfigInternet.f_config_internet1.cdss, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigInternet(Sender: TObject);
begin
  activateconfig(ConfigInternet.f_config_internet1.cmain, nil, nil, nil,
    nil, ConfigInternet.f_config_internet1.cdss, False);
end;

procedure Tf_main.SetupPicturesPage(page: integer; action: integer = 0);
begin
  if not SetupPictures.Enabled then exit;
  if ConfigPictures = nil then begin
    ConfigPictures := Tf_configpictures.Create(self);
    ConfigPictures.f_config_pictures1.PageControl1.ShowTabs := True;
    ConfigPictures.f_config_pictures1.PageControl1.PageIndex := 0;
    ConfigPictures.f_config_pictures1.onApplyConfig := ApplyConfigPictures;
  end;
  try
    ConfigPictures.f_config_pictures1.cdb := cdcdb;
    ConfigPictures.f_config_pictures1.cdss.Assign(f_getdss.cfgdss);
    ConfigPictures.f_config_pictures1.Fits := Fits;
    ConfigPictures.f_config_pictures1.ccat.Assign(catalog.cfgcat);
    ConfigPictures.f_config_pictures1.cshr.Assign(catalog.cfgshr);
    ConfigPictures.f_config_pictures1.cplot.Assign(def_cfgplot);
    ConfigPictures.f_config_pictures1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigPictures.f_config_pictures1.csc.Assign(sc.cfgsc);
        ConfigPictures.f_config_pictures1.cplot.Assign(sc.plot.cfgplot);
        sc.bgsettingchange := True;
      end;
    cfgm.persdir := privatedir;
    ConfigPictures.f_config_pictures1.cmain.Assign(cfgm);
    formpos(ConfigPictures, mouse.cursorpos.x, mouse.cursorpos.y);
    if page>=0 then ConfigPictures.f_config_pictures1.PageControl1.PageIndex := page;
    //ConfigPictures.show;
    ConfigPictures.f_config_pictures1.backimgChange(self);
    //ConfigPictures.hide;
    case action of
      0: ConfigPictures.showmodal;
      1:
      begin
        ConfigPictures.Show;
        ConfigPictures.f_config_pictures1.ScanImagesClick(nil);
        ConfigPictures.Close;
      end;
    end;
    if ConfigPictures.ModalResult = mrOk then
    begin
      activateconfig(ConfigPictures.f_config_pictures1.cmain,
        ConfigPictures.f_config_pictures1.csc, ConfigPictures.f_config_pictures1.ccat,
        ConfigPictures.f_config_pictures1.cshr, ConfigPictures.f_config_pictures1.cplot,
        ConfigPictures.f_config_pictures1.cdss, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigPictures(Sender: TObject);
begin
  activateconfig(ConfigPictures.f_config_pictures1.cmain,
    ConfigPictures.f_config_pictures1.csc, ConfigPictures.f_config_pictures1.ccat,
    ConfigPictures.f_config_pictures1.cshr, ConfigPictures.f_config_pictures1.cplot,
    ConfigPictures.f_config_pictures1.cdss, False);
end;


procedure Tf_main.SetupObservatoryExecute(Sender: TObject);
begin
  SetupObservatoryPage(-1);
end;

procedure Tf_main.SetupObservatoryPage(page: integer; posx: integer = 0;
  posy: integer = 0);
begin
  if not SetupObservatory.Enabled then exit;
  if ConfigObservatory = nil then begin
    ConfigObservatory := Tf_configobservatory.Create(self);
    ConfigObservatory.f_config_observatory1.PageControl1.ShowTabs := True;
    ConfigObservatory.f_config_observatory1.PageControl1.PageIndex := 0;
    ConfigObservatory.f_config_observatory1.onApplyConfig := ApplyConfigObservatory;
  end;
  try
    ConfigObservatory.f_config_observatory1.cdb := cdcdb;
    ConfigObservatory.f_config_observatory1.ccat.Assign(catalog.cfgcat);
    ConfigObservatory.f_config_observatory1.cshr.Assign(catalog.cfgshr);
    ConfigObservatory.f_config_observatory1.cplot.Assign(def_cfgplot);
    ConfigObservatory.f_config_observatory1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigObservatory.f_config_observatory1.csc.Assign(sc.cfgsc);
        ConfigObservatory.f_config_observatory1.cplot.Assign(sc.plot.cfgplot);
      end;
    cfgm.persdir := privatedir;
    ConfigObservatory.f_config_observatory1.cmain.Assign(cfgm);
    if (posx = 0) and (posy = 0) then
      formpos(ConfigObservatory, mouse.cursorpos.x, mouse.cursorpos.y)
    else
    if (posx > 0) and (posy > 0) then
      formpos(ConfigObservatory, posx, posy)
    else
    begin
      posx := Screen.Width div 2 - ConfigObservatory.Width div 2;  // first setup
      posy := Screen.Height div 2 - ConfigObservatory.Height div 2;
      formpos(ConfigObservatory, posx, posy);
    end;
    if page>=0 then ConfigObservatory.f_config_observatory1.PageControl1.PageIndex := page;
    ShowModalForm(ConfigObservatory);
    if ConfigObservatory.ModalResult = mrOk then
    begin
      activateconfig(ConfigObservatory.f_config_observatory1.cmain,
        ConfigObservatory.f_config_observatory1.csc,
        ConfigObservatory.f_config_observatory1.ccat,
        ConfigObservatory.f_config_observatory1.cshr,
        ConfigObservatory.f_config_observatory1.cplot, nil, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigObservatory(Sender: TObject);
begin
  activateconfig(ConfigObservatory.f_config_observatory1.cmain,
    ConfigObservatory.f_config_observatory1.csc,
    ConfigObservatory.f_config_observatory1.ccat,
    ConfigObservatory.f_config_observatory1.cshr,
    ConfigObservatory.f_config_observatory1.cplot, nil, False);
end;

procedure Tf_main.SetupCatalogExecute(Sender: TObject);
begin
  SetupCatalogPage(-1);
end;

procedure Tf_main.SetupCatalogPage(page: integer);
begin
  if not SetupCatalog.Enabled then exit;
  if ConfigCatalog = nil then begin
    ConfigCatalog := Tf_configcatalog.Create(self);
    ConfigCatalog.f_config_catalog1.PageControl1.ShowTabs := True;
    ConfigCatalog.f_config_catalog1.PageControl1.PageIndex := 0;
    ConfigCatalog.f_config_catalog1.onApplyConfig := ApplyConfigCatalog;
    ConfigCatalog.f_config_catalog1.onSendVoTable := SendVoTable;
    ConfigCatalog.f_config_catalog1.onInstallCatalog := OpenUpdCatalog;
    ConfigCatalog.f_config_catalog1.onRunCatgen := RunCatgen;
  end;
  try
    ConfigCatalog.f_config_catalog1.catalog := catalog;
    ConfigCatalog.f_config_catalog1.ccat.Assign(catalog.cfgcat);
    ConfigCatalog.f_config_catalog1.cshr.Assign(catalog.cfgshr);
    ConfigCatalog.f_config_catalog1.cplot.Assign(def_cfgplot);
    ConfigCatalog.f_config_catalog1.csc.Assign(def_cfgsc);
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        ConfigCatalog.f_config_catalog1.csc.Assign(sc.cfgsc);
        ConfigCatalog.f_config_catalog1.cplot.Assign(sc.plot.cfgplot);
        ConfigCatalog.f_config_catalog1.ra := sc.cfgsc.racentre;
        ConfigCatalog.f_config_catalog1.Dec := sc.cfgsc.decentre;
        ConfigCatalog.f_config_catalog1.fov := sc.cfgsc.fov * 0.75;
        Precession(sc.cfgsc.JDChart, jd2000, ConfigCatalog.f_config_catalog1.ra,
          ConfigCatalog.f_config_catalog1.Dec);
      end;
    cfgm.persdir := privatedir;
    ConfigCatalog.f_config_catalog1.cmain.Assign(cfgm);
    formpos(ConfigCatalog, mouse.cursorpos.x, mouse.cursorpos.y);
    case page of
      0: ConfigCatalog.f_config_catalog1.PageControl1.PageIndex := 0;  // default, star
      1: begin
           ConfigCatalog.f_config_catalog1.PageControl1.PageIndex := 0;
           ConfigCatalog.f_config_catalog1.PageControlGCat.PageIndex := 3; // dso
         end;
      2: ConfigCatalog.f_config_catalog1.PageControl1.PageIndex := 0;  // ?
      3: ConfigCatalog.f_config_catalog1.PageControl1.PageIndex := 1;  // vo
      4: ConfigCatalog.f_config_catalog1.PageControl1.PageIndex := 2;  // user object
    end;

    ShowModalForm(ConfigCatalog);
    if ConfigCatalog.ModalResult = mrOk then
    begin
      ConfigCatalog.f_config_catalog1.ActivateGCat;
      ConfigCatalog.f_config_catalog1.ActivateUserObjects;
      activateconfig(ConfigCatalog.f_config_catalog1.cmain,
        ConfigCatalog.f_config_catalog1.csc, ConfigCatalog.f_config_catalog1.ccat,
        ConfigCatalog.f_config_catalog1.cshr, ConfigCatalog.f_config_catalog1.cplot,
        nil, False);
    end;
  finally
  end;
end;

procedure Tf_main.ApplyConfigCatalog(Sender: TObject);
begin
  ConfigCatalog.f_config_catalog1.ActivateGCat;
  ConfigCatalog.f_config_catalog1.ActivateUserObjects;
  activateconfig(ConfigCatalog.f_config_catalog1.cmain,
    ConfigCatalog.f_config_catalog1.csc, ConfigCatalog.f_config_catalog1.ccat,
    ConfigCatalog.f_config_catalog1.cshr, ConfigCatalog.f_config_catalog1.cplot,
    nil, False);
end;

procedure Tf_main.ShowUobjExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      ShowUobj.Checked := not ShowUobj.Checked;
      sc.catalog.cfgcat.nebcatdef[uneb - BaseNeb] := ShowUobj.Checked;
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.ShowVOExecute(Sender: TObject);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      ShowVO.Checked := not ShowVO.Checked;
      sc.catalog.cfgcat.starcatdef[vostar - BaseStar] := ShowVO.Checked;
      sc.catalog.cfgcat.nebcatdef[voneb - BaseNeb] := ShowVO.Checked;
      if (not sc.cfgsc.TrackOn) and (sc.cfgsc.Projpole = Altaz) then
      begin
        sc.cfgsc.TrackOn := True;
        sc.cfgsc.TrackType := TTaltaz;
      end;
      Refresh(True, False);
    end;
end;

procedure Tf_main.SetupDisplayExecute(Sender: TObject);
begin
  SetupDisplayPage(-1);
end;

procedure Tf_main.SetupDisplayPage(pagegroup: integer);
begin
  if not SetupDisplay.Enabled then exit;
  if ConfigDisplay = nil then
  begin
    ConfigDisplay := Tf_configdisplay.Create(self);
    ConfigDisplay.f_config_display1.PageControl1.ShowTabs := True;
    ConfigDisplay.f_config_display1.PageControl1.PageIndex := 0;
    ConfigDisplay.f_config_display1.onApplyConfig := ApplyConfigDisplay;
  end;
  ConfigDisplay.f_config_display1.ccat.Assign(catalog.cfgcat);
  ConfigDisplay.f_config_display1.cshr.Assign(catalog.cfgshr);
  ConfigDisplay.f_config_display1.cplot.Assign(def_cfgplot);
  ConfigDisplay.f_config_display1.csc.Assign(def_cfgsc);
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      ConfigDisplay.f_config_display1.csc.Assign(sc.cfgsc);
      ConfigDisplay.f_config_display1.cplot.Assign(sc.plot.cfgplot);
    end;
  cfgm.persdir := privatedir;
  ConfigDisplay.f_config_display1.cmain.Assign(cfgm);
  formpos(ConfigDisplay, mouse.cursorpos.x, mouse.cursorpos.y);
{$ifdef mswindows}
  // TODO: Problem with initialization
  ConfigDisplay.Show;
  ConfigDisplay.hide;
  ConfigDisplay.f_config_display1.ccat.Assign(catalog.cfgcat);
  ConfigDisplay.f_config_display1.cshr.Assign(catalog.cfgshr);
  ConfigDisplay.f_config_display1.cplot.Assign(def_cfgplot);
  ConfigDisplay.f_config_display1.csc.Assign(def_cfgsc);
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      ConfigDisplay.f_config_display1.csc.Assign(sc.cfgsc);
      ConfigDisplay.f_config_display1.cplot.Assign(sc.plot.cfgplot);
    end;
  cfgm.persdir := privatedir;
  ConfigDisplay.f_config_display1.cmain.Assign(cfgm);
  ///////////////////////////////
{$endif}
  if pagegroup>=0 then ConfigDisplay.f_config_display1.PageControl1.PageIndex := pagegroup;
  ShowModalForm(ConfigDisplay);
  if ConfigDisplay.ModalResult = mrOk then
  begin
    activateconfig(ConfigDisplay.f_config_display1.cmain,
      ConfigDisplay.f_config_display1.csc, ConfigDisplay.f_config_display1.ccat,
      ConfigDisplay.f_config_display1.cshr, ConfigDisplay.f_config_display1.cplot,
      nil, False);
  end;
end;

procedure Tf_main.ApplyConfigDisplay(Sender: TObject);
begin
  activateconfig(ConfigDisplay.f_config_display1.cmain,
    ConfigDisplay.f_config_display1.csc, ConfigDisplay.f_config_display1.ccat,
    ConfigDisplay.f_config_display1.cshr, ConfigDisplay.f_config_display1.cplot,
    nil, False);
end;

function Tf_main.PrepareAsteroid(jd1, jd2, step: double; msg: TStrings): boolean;
begin
  Result := planet.PrepareAsteroid(jd1, jd2, step, msg);
end;

procedure Tf_main.SaveAndRestart(Sender: TObject);
begin
  if ConfigSystem <> nil then
  begin
    cfgm.Assign(ConfigSystem.f_config_system1.cmain);
    privatedir := cfgm.persdir;
    def_cfgsc.Assign(ConfigSystem.f_config_system1.csc);
    catalog.cfgcat.Assign(ConfigSystem.f_config_system1.ccat);
    catalog.cfgshr.Assign(ConfigSystem.f_config_system1.cshr);
    SavePrivateConfig(configfile);
    NeedRestart := True;
    Close;
  end;
end;

procedure Tf_main.ClearAndRestart;
begin
  SaveConfigOnExit.Checked := False;
  DeleteFile(configfile);
  NeedRestart := True;
  Close;
end;

procedure Tf_main.SetPerformanceOptions;
var
  cmain: Tconf_main;
  csc: Tconf_skychart;
  ccat: Tconf_catalog;
  cshr: Tconf_shared;
  cplot: Tconf_plot;
  cdss: Tconf_dss;
  i: integer;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    cmain := Tconf_main.Create;
    csc := Tconf_skychart.Create;
    ccat := Tconf_catalog.Create;
    cshr := Tconf_shared.Create;
    cplot := Tconf_plot.Create;
    cdss := Tconf_dss.Create;
    try
      // Close extra charts
      for i := MultiFrame1.ChildCount - 1 downto 0 do
        if MultiFrame1.Childs[i].DockedObject <> MultiFrame1.ActiveObject then
          MultiFrame1.Childs[i].Close;
      MultiFrame1.Maximized := True;
      // Get current config
      cmain.Assign(cfgm);
      csc.Assign(Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc);
      ccat.Assign(catalog.cfgcat);
      cshr.Assign(catalog.cfgshr);
      cplot.Assign(def_cfgplot);
      cdss.Assign(f_getdss.cfgdss);
      // Perf options
      cmain.AutoRefreshDelay := 60;
      cmain.SyncChart := False;
      csc.MaxArchiveImg := 1;
      for i := 1 to MaxArchiveDir do
        csc.ArchiveDirActive[i] := False;
      csc.ShowHorizonPicture := False;
      csc.HorizonPictureLowQuality := True;
      csc.DrawPMon := False;
      csc.LinemodeMilkyway := True;
      csc.Editlabels := False;
      csc.Simnb := 1;
      for i := 1 to NumSimObject do
        def_cfgsc.SimObject[i] := False;
      csc.SunOnline := False;
      csc.ShowImages := False;
      csc.ShowImageList := False;
      csc.ShowImageLabel := False;
      csc.ShowBackgroundImage := False;
      csc.BackgroundImage := '';
      csc.SPKlist.Clear;
      csc.AstmagMax := 18;
      csc.AstmagDiff := 6;
      csc.ShowArtSat := False;
      csc.CommagMax := 18;
      csc.CommagDiff := 4;
      csc.DrawAllStarLabel := False;
      csc.ShowEarthShadow := False;
      csc.EarthShadowForceLine := True;
      csc.StarFilter := True;
      cshr.AutoStarFilter := True;
      cshr.AutoStarFilterMag := DefAutoStarFilterMag;
      cshr.NebFilter := True;
      cplot.AntiAlias := False;
      cplot.red_move := True;
      cplot.plaplot := 1;
      // Set new options
      activateconfig(cmain, csc, ccat, cshr, cplot, cdss, False);
      if ShowVO.Checked then
        ShowVOExecute(nil);
      if ShowUobj.Checked then
        ShowUobjExecute(nil);
    finally
      cmain.Free;
      csc.Free;
      ccat.Free;
      cshr.Free;
      cplot.Free;
      cdss.Free;
    end;
  end;
end;

procedure Tf_main.activateconfig(cmain: Tconf_main; csc: Tconf_skychart;
  ccat: Tconf_catalog; cshr: Tconf_shared; cplot: Tconf_plot;
  cdss: Tconf_dss; applyall: boolean);
var
  i,v1,v2: integer;
  dbchange, themechange, nightchange, langchange, starchange, showast: boolean;
begin
  dbchange := False;
  themechange := False;
  nightchange := False;
  langchange := False;
  starchange := False;
  showast := False;
  if cmain <> nil then
  begin
    if (cfgm.language <> cmain.language) then
      langchange := True;
  end;
  if langchange then
    ChangeLanguage(cmain.language);
  if cmain <> nil then
  begin
    if cfgm.ThemeName <> cmain.ThemeName then
      themechange := True;
    if cfgm.starshape_file <> cmain.starshape_file then
      starchange := True;
    if (cfgm.db <> cmain.db) then
      dbchange := True;
    nightchange := nightvision and (cfgm.NightColor<>cmain.NightColor);
    cfgm.Assign(cmain);
    AnimationTimer.Interval := max(100, cfgm.AnimDelay);
    ServerCoordSystem:=TServerCoordSys(cfgm.ServerCoordSys);
  end;
  if themechange then
    SetTheme;
  if starchange then
    SetStarShape;
  cfgm.updall := applyall;
  privatedir := cfgm.persdir;
  if (cmain <> nil) and (ccat <> nil) then
  begin
    if cmain.VOforceactive then
    begin
      ShowVO.Checked := True;
      ccat.starcatdef[vostar - BaseStar] := ShowVO.Checked;
      ccat.nebcatdef[voneb - BaseNeb] := ShowVO.Checked;
    end;
    if cmain.UOforceactive then
    begin
      ShowUobj.Checked := True;
      ccat.nebcatdef[uneb - BaseNeb] := ShowUobj.Checked;
    end;
  end;
  if ccat <> nil then
  begin
    for i := 0 to ccat.GCatNum - 1 do
    begin
      if ccat.GCatLst[i].Actif or ccat.GCatLst[i].Search then
      begin
        if not catalog.GetInfo(ccat.GCatLst[i].path, ccat.GCatLst[i].shortname,
          ccat.GCatLst[i].magmax, ccat.GCatLst[i].cattype,
          v1,v2,
          ccat.GCatLst[i].version, ccat.GCatLst[i].Name) then
          ccat.GCatLst[i].Actif := False;
      end;
    end;
    catalog.cfgcat.Assign(ccat);
  end;
  if cdss <> nil then
    f_getdss.cfgdss.Assign(cdss);
  if cshr <> nil then
    catalog.cfgshr.Assign(cshr);
  if csc <> nil then
  begin
    csc.ShowAsteroid := csc.ShowAsteroid or (csc.SimObject[12] and (csc.SimNb>1));
    csc.ShowComet := csc.ShowComet or (csc.SimObject[13] and (csc.SimNb>1));
    showast := csc.ShowAsteroid;
    if (not csc.SunOnline) or (csc.sunurlname <> def_cfgsc.sunurlname) then
      DeleteFile(slash(Tempdir) + 'sun.jpg');
    csc.ProjOptions[csc.ProjPole].EquinoxType := csc.EquinoxType;
    csc.ProjOptions[csc.ProjPole].ApparentPos := csc.ApparentPos ;
    csc.ProjOptions[csc.ProjPole].PMon := csc.PMon ;
    csc.ProjOptions[csc.ProjPole].YPmon := csc.YPmon ;
    csc.ProjOptions[csc.ProjPole].EquinoxChart := csc.EquinoxChart ;
    csc.ProjOptions[csc.ProjPole].DefaultJDChart := csc.DefaultJDChart ;
    csc.ProjOptions[csc.ProjPole].CoordExpertMode := csc.CoordExpertMode ;
    csc.ProjOptions[csc.ProjPole].CoordType := csc.CoordType ;
    if libcalceph<>0 then InitCalcephBody(csc);
    def_cfgsc.Assign(csc);
  end;
  if cplot <> nil then
  begin
    def_cfgplot.Assign(cplot);
    def_cfgplot.starshapesize := starshape.Picture.bitmap.Width div 11;
    def_cfgplot.starshapew := def_cfgplot.starshapesize div 2;
  end;
  InitFonts;
  if def_cfgsc.ConstLatinLabel then
    catalog.LoadConstellation(cfgm.Constellationpath, 'Latin')
  else
    catalog.LoadConstellation(cfgm.Constellationpath, lang);
  catalog.LoadStarName(slash(appdir) + slash('data') + slash('common_names'), Lang);
  catalog.LoadConstL(cfgm.ConstLfile);
  catalog.LoadConstB(cfgm.ConstBfile);
  f_search.init;
  if dbchange then
    ConnectDB;
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if csc <> nil then
        sc.cfgsc.Assign(def_cfgsc);
      sc.Fits := Fits;
      sc.planet := planet;
      sc.cdb := cdcdb;
      sc.cfgsc.FindOk := False;
      sc.plot.cfgplot.Assign(def_cfgplot);
      if cfgm.NewBackgroundImage then
      begin
        sc.Fits.Filename := sc.cfgsc.BackgroundImage;
        sc.Fits.InfoWCScoord;
        if sc.Fits.Header.valid then
        begin
          sc.Fits.DeleteDB('OTHER', 'BKG');
          if not sc.Fits.InsertDB(sc.cfgsc.BackgroundImage, 'OTHER',
            'BKG', sc.Fits.Center_RA, sc.Fits.Center_DE, sc.Fits.Img_Width,
            sc.Fits.Img_Height, sc.Fits.Rotation) then
            sc.Fits.InsertDB(sc.cfgsc.BackgroundImage, 'OTHER',
              'BKG', sc.Fits.Center_RA + 0.00001, sc.Fits.Center_DE +
              0.00001, sc.Fits.Img_Width,
              sc.Fits.Img_Height, sc.Fits.Rotation);
          sc.cfgsc.fov := 1.25 * sc.Fits.Img_Width;
          sc.cfgsc.TrackOn := True;
          sc.cfgsc.TrackType := TTimage;
        end;
        cfgm.NewBackgroundImage := False;
      end;
    end;
  cfgm.NewBackgroundImage := False;
  RefreshAllChild(cfgm.updall);
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if showast and (showast <> sc.cfgsc.ShowAsteroid) then
      begin
        RecomputeAsteroid;
      end;
      if f_calendar.Visible then
      begin
        f_calendar.config.Assign(sc.cfgsc);
        f_calendar.BtnRefreshClick(nil);
      end;
    end;
  if nightchange then begin
     ViewNightVision.Execute;
     ViewNightVision.Execute;
  end;
  Autorefresh.Enabled := False;
  Autorefresh.Interval := max(10, min(60,cfgm.autorefreshdelay)) * 1000;
  AutoRefreshLock := False;
  Autorefresh.Enabled := True;
end;

procedure Tf_main.ResizeBtn;
var
  showcapt: boolean;
  sz,msz: integer;
begin
  showcapt := cfgm.btncaption and (cfgm.btnsize > 32);
  sz := DoScaleX(cfgm.btnsize);
  msz :=  DoScaleX(16);
  if (ToolBarMain.ButtonHeight <> sz) or (ToolBarMain.ShowCaptions <> showcapt) then
  begin
    SetButtonImage(sz,msz);
    PanelToolBarMain.Height:=sz+4;
    ToolBarMain.ButtonHeight := sz;
    ToolBarMain.ButtonWidth := sz;
    ToolBarMain.Height := sz + 4;
    ToolBarMain.ShowCaptions := showcapt;
    ToolBarMain.Invalidate;
    ToolBarObj.ButtonHeight := sz;
    ToolBarObj.ButtonWidth := sz;
    ToolBarObj.Height := sz + 4;
    ToolBarObj.ShowCaptions := showcapt;
    ToolBarObj.Invalidate;
    PanelLeft.Width := sz + 4;
    ToolBarLeft.ButtonHeight := sz;
    ToolBarLeft.ButtonWidth := sz;
    ToolBarLeft.Width := sz + 4;
    ToolBarLeft.Invalidate;
    PanelRight.Width := sz + 4;
    ToolBarRight.ButtonHeight := sz;
    ToolBarRight.ButtonWidth := sz;
    ToolBarRight.Width := sz + 4;
    ToolBarRight.Invalidate;
    BtnRestoreChild.Height:=sz;
    BtnRestoreChild.Width:=sz;
    BtnCloseChild.Height:=sz;
    BtnCloseChild.Width:=sz;
    BtnCloseChild.Left:=sz;
    ViewTopPanel;
  end;
end;

procedure Tf_main.ViewTopPanel;
var
  i: integer;
begin
  i := 0;
  if PanelToolBarMain.Visible then
    i := i + PanelToolBarMain.Height;
  if ToolBarObj.Visible then
    i := i + ToolBarObj.Height;
  if TabControl1.Visible then
    i := i + TabControl1.Height;
  if i = 0 then
    PanelTop.Visible := False
  else
  begin
    PanelTop.Visible := True;
    PanelTop.Height := i + 2;
  end;
  FormResize(nil);
end;

procedure Tf_main.ViewToolsBar(ForceVisible: boolean);
begin
  MenuViewMainBar.Checked := (VisibleControlCount(ToolBarMain) > 0) and
    (ForceVisible or MenuViewMainBar.Checked);
  MenuViewObjectBar.Checked :=
    (VisibleControlCount(ToolBarObj) > 0) and (ForceVisible or
    MenuViewObjectBar.Checked);
  MenuViewLeftBar.Checked := (VisibleControlCount(ToolBarLeft) > 0) and
    (ForceVisible or MenuViewLeftBar.Checked);
  MenuViewRightBar.Checked := (VisibleControlCount(ToolBarRight) > 0) and
    (ForceVisible or MenuViewRightBar.Checked);
  MenuViewToolsBar.Checked := MenuViewMainBar.Checked and
    MenuViewObjectBar.Checked and MenuViewLeftBar.Checked and
    MenuViewRightBar.Checked and MenuViewStatusBar.Checked;
  PanelToolBarMain.Visible := MenuViewMainBar.Checked;
  ToolBarObj.Visible := MenuViewObjectBar.Checked;
  PanelLeft.Visible := MenuViewLeftBar.Checked;
  PanelRight.Visible := MenuViewRightBar.Checked;
  ViewTopPanel;
  FormResize(nil);
end;

procedure Tf_main.MenuViewToolsBarClick(Sender: TObject);
begin
  MenuViewToolsBar.Checked := not MenuViewToolsBar.Checked;
  MenuViewMainBar.Checked := MenuViewToolsBar.Checked and
    (VisibleControlCount(ToolBarMain) > 0);
  MenuViewObjectBar.Checked :=
    MenuViewToolsBar.Checked and (VisibleControlCount(ToolBarObj) > 0);
  MenuViewLeftBar.Checked := MenuViewToolsBar.Checked and
    (VisibleControlCount(ToolBarLeft) > 0);
  MenuViewRightBar.Checked := MenuViewToolsBar.Checked and
    (VisibleControlCount(ToolBarRight) > 0);
  MenuViewStatusBar.Checked := MenuViewToolsBar.Checked;

  PanelToolBarMain.Visible := MenuViewMainBar.Checked;
  ToolBarObj.Visible := MenuViewObjectBar.Checked;
  PanelLeft.Visible := MenuViewLeftBar.Checked;
  PanelRight.Visible := MenuViewRightBar.Checked;
  PanelBottom.Visible := MenuViewStatusBar.Checked;

  ViewTopPanel;
  if PanelBottom.Visible then
    InitFonts;
  FormResize(Sender);
end;


procedure Tf_main.MenuViewScrollBarClick(Sender: TObject);
var
  i: integer;
begin
  if VerboseMsg then
    WriteTrace('ViewScrollBar1Click');
  if cfgm.KioskMode then
    MenuViewScrollBar.Checked := False
  else
    MenuViewScrollBar.Checked := (not MenuViewScrollBar.Checked) and CanShowScrollbar;
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
    begin
      (MultiFrame1.Childs[i].DockedObject as Tf_chart).VertScrollBar.Visible :=
        MenuViewScrollBar.Checked;
      (MultiFrame1.Childs[i].DockedObject as Tf_chart).HorScrollBar.Visible :=
        MenuViewScrollBar.Checked;
      (MultiFrame1.Childs[i].DockedObject as Tf_chart).Refresh(True, False);
    end;
end;

procedure Tf_main.ViewMainBarClick(Sender: TObject);
var
  c: integer;
begin
  c := VisibleControlCount(ToolBarMain);
  MenuViewMainBar.Checked := (not MenuViewMainBar.Checked) and (c > 0);
  PanelToolBarMain.Visible := MenuViewMainBar.Checked;
  if not MenuViewMainBar.Checked then
    MenuViewToolsBar.Checked := False;
  if MenuViewMainBar.Checked and MenuViewObjectBar.Checked and
    MenuViewLeftBar.Checked and MenuViewRightBar.Checked and
    MenuViewStatusBar.Checked then
    MenuViewToolsBar.Checked := True;
  ViewTopPanel;
  FormResize(Sender);
  if c = 0 then begin
    SetLPanel1(format(rsIsEmpty, [rsMainBar]));
    EditToolBar(0);
  end;
end;

procedure Tf_main.ViewObjectBarClick(Sender: TObject);
var
  c: integer;
begin
  c := VisibleControlCount(ToolBarObj);
  MenuViewObjectBar.Checked := (not MenuViewObjectBar.Checked) and (c > 0);
  ToolBarObj.Visible := MenuViewObjectBar.Checked;
  if not MenuViewObjectBar.Checked then
    MenuViewToolsBar.Checked := False;
  if MenuViewMainBar.Checked and MenuViewObjectBar.Checked and
    MenuViewLeftBar.Checked and MenuViewRightBar.Checked and
    MenuViewStatusBar.Checked then
    MenuViewToolsBar.Checked := True;
  ViewTopPanel;
  FormResize(Sender);
  if c = 0 then begin
    SetLPanel1(format(rsIsEmpty, [rsObjectBar]));
    EditToolBar(1);
  end;
end;

procedure Tf_main.ViewLeftBarClick(Sender: TObject);
var
  c: integer;
begin
  c := VisibleControlCount(ToolBarLeft);
  MenuViewLeftBar.Checked := (not MenuViewLeftBar.Checked) and (c > 0);
  PanelLeft.Visible := MenuViewLeftBar.Checked;
  if not MenuViewLeftBar.Checked then
    MenuViewToolsBar.Checked := False;
  if MenuViewMainBar.Checked and MenuViewObjectBar.Checked and
    MenuViewLeftBar.Checked and MenuViewRightBar.Checked and
    MenuViewStatusBar.Checked then
    MenuViewToolsBar.Checked := True;
  FormResize(Sender);
  if c = 0 then begin
    SetLPanel1(format(rsIsEmpty, [rsLeftBar]));
    EditToolBar(2);
  end;
end;

procedure Tf_main.ViewRightBarClick(Sender: TObject);
var
  c: integer;
begin
  c := VisibleControlCount(ToolBarRight);
  MenuViewRightBar.Checked := (not MenuViewRightBar.Checked) and (c > 0);
  PanelRight.Visible := MenuViewRightBar.Checked;
  if not MenuViewRightBar.Checked then
    MenuViewToolsBar.Checked := False;
  if MenuViewMainBar.Checked and MenuViewObjectBar.Checked and
    MenuViewLeftBar.Checked and MenuViewRightBar.Checked and
    MenuViewStatusBar.Checked then
    MenuViewToolsBar.Checked := True;
  FormResize(Sender);
  if c = 0 then begin
    SetLPanel1(format(rsIsEmpty, [rsRightBar]));
    EditToolBar(3);
  end;
end;

procedure Tf_main.ViewStatusBarClick(Sender: TObject);
begin
  PanelBottom.Visible := not PanelBottom.Visible;
  MenuViewStatusBar.Checked := PanelBottom.Visible;
  if not MenuViewStatusBar.Checked then
    MenuViewToolsBar.Checked := False;
  if MenuViewMainBar.Checked and MenuViewObjectBar.Checked and
    MenuViewLeftBar.Checked and MenuViewRightBar.Checked and
    MenuViewStatusBar.Checked then
    MenuViewToolsBar.Checked := True;
  if PanelBottom.Visible then
    InitFonts;
  FormResize(Sender);
end;

procedure Tf_main.ViewClockExecute(Sender: TObject);
var
  P: Tpoint;
begin
  if ScriptPanel.Visible then
    P := point(ScriptPanel.Left + ScriptPanel.Width, PanelTop.Top + PanelTop.Height)
  else
    P := point(PanelLeft.Width, PanelTop.Top + PanelTop.Height);
  P := ClientToScreen(P);
  if f_clock = nil then
  begin
    f_clock := Tf_clock.Create(self);
    f_clock.cfgsc := def_cfgsc;
    f_clock.planet := planet;
    f_clock.SetLang;
  end;
  if f_clock.Visible then
  begin
    f_clock.hide;
    ViewClock.Checked := False;
  end
  else
  begin
    formpos(f_clock, P.x, P.y);
    f_clock.Font.Color := cfgm.ClockColor;
    f_clock.Show;
    f_main.SetFocus;
    ViewClock.Checked := True;
  end;
end;

procedure Tf_main.InitFonts;
var
  ts, ts1, ts2: Tsize;
begin
  P0L1.Caption := '';
  ts1 := P0L1.Canvas.TextExtent(rsRA + ':222h22m22.2s ' + rsDE + '+22d22m22s' + rsLHA +  '+22d22m');
  ts2 := P0L1.Canvas.TextExtent(rsAz + ':+222h22m22s ' + rsAlt + '+22d22m22s' + rsAirmass + '22.2');
  if ts1.cx > ts2.cx then
    ts := ts1
  else
    ts := ts2;
  PanelBottom.Height := 2 * ts.cy + 4;
  PPanels0.Width := ts.cx + 4;
  P0L1.Align := alClient;
end;

procedure Tf_main.SetLPanel1(txt1: string; origin: string = '';
  sendmsg: boolean = False; Sender: TObject = nil; txt2: string = ''; txt2000: string = '');
var
  txt, buf, buf1, buf2, k: string;
  p: integer;
begin
  if (trim(txt1) > '') then
    writetrace(txt1);
  if txt2 = '' then
  begin
    txt := StringReplace(txt1, tab, blank, [rfReplaceAll]);
  end
  else
  begin
    buf := txt1 + tab;
    p := pos(tab, buf);
    txt := rsRA + ':' + copy(buf, 1, p - 1) + blank;                     // RA
    Delete(buf, 1, p);
    p := pos(tab, buf);
    txt := txt + rsDE + ':' + copy(buf, 1, p - 1) + blank + blank;           // DEC
    Delete(buf, 1, p);
    p := pos(tab, buf);
    buf1 := trim(copy(buf, 1, p - 1));
    txt := txt + catalog.LongLabelObj(buf1) + ':' + blank;           // Object type
    Delete(buf, 1, p);
    p := pos(tab, buf);
    txt := txt + wordspace(copy(buf, 1, p - 1)) + blank + blank;         // Object name
    Delete(buf, 1, p);
    p := pos(tab, buf);
    buf1 := trim(copy(buf, 1, p - 1));
    txt := txt + catalog.LongLabel(buf1) + blank + blank;            // Magnitude
    Delete(buf, 1, p);
    p := pos(tab, buf);
    buf2 := trim(copy(buf, 1, p - 1));
    // save Alt name for the end
    Delete(buf, 1, p);
    while buf > '' do
    begin                                    // Search for size
      p := pos(tab, buf);
      buf1 := trim(copy(buf, 1, p - 1));
      Delete(buf, 1, p);
      p := pos(':', buf1);
      k := uppercase(trim(copy(buf1, 1, p - 1)));
      if (k = 'DIM') or (k = uppercase(rsCommonName)) then
      begin
        txt := txt + catalog.LongLabel(buf1) + blank + blank;       // Size / common name
      end;
    end;
    txt := txt + catalog.LongLabel(buf2);                        // Alt name
  end;
  P1L1.Caption := txt + crlf + txt2;
  if sendmsg then begin
    buf := txt1;
    if (ServerCoordSystem=csJ2000) and (txt2000<>'') then begin
      p := pos(tab, buf);
      if p>0 then begin
        Delete(buf, 1, p);   // delete RA
        p := pos(tab, buf);
        if p>0 then begin
          Delete(buf, 1, p); // delete Dec
        end;
      end;
      if copy(buf, length(buf), 1) <> tab then // ensure last tab
         buf := buf + tab;
      buf:=txt2000+tab+buf+'Equinox:J2000';  // add J2000 RA Dec
    end;
    SendInfo(Sender, origin, buf);
  end;
  // refresh tracking object
  if MultiFrame1.ActiveObject is Tf_chart then
    with (MultiFrame1.ActiveObject as Tf_chart) do
    begin
      if sc.cfgsc.TrackOn then
      begin
        Track.Hint := rsUnlockChart;
        Track.Caption := rsUnlockChart;
      end
      else if ((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or
        (sc.cfgsc.TrackType = TTequat)or (sc.cfgsc.TrackType = TTbody) then
      begin
        if (sc.cfgsc.Trackname = '') and TelescopeConnect.Checked then
          sc.cfgsc.Trackname := rsTelescope;
        Track.Hint := Format(rsLockOn, [sc.cfgsc.Trackname]);
        Track.Caption := Format(rsLockOn, [sc.cfgsc.Trackname]);
      end
      else
      begin
        Track.Hint := rsNoObjectToLo;
        Track.Caption := rsNoObjectToLo;
      end;
      if f_manualtelescope.Visible then
        f_manualtelescope.SetTurn(sc.cfgsc.FindNote);
    end;
end;

procedure Tf_main.StatusCopyClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PChar(P1L1.Caption));
end;

procedure Tf_main.SetLPanel0(txt: string);
begin
  P0L1.Caption := txt;
  if PPanels0.Width < P0L1.Width then
    PPanels0.Width := P0L1.Width + 8;
end;

procedure Tf_main.SetTopMessage(txt: string; Sender: TObject);
var
  status: string;
begin
  status := '';
  if SampConnected then
  begin
    status := '* ';
  end;
  // set the message that appear in the Menu bar
  if MultiFrame1.ActiveObject = Sender then
  begin
    topmsg := txt;
    if cfgm.ShowChartInfo then
      topmessage.Caption := status + topmsg
    else
      topmessage.Caption := status + ' ';
  end;
end;

procedure Tf_main.SetTitleMessage(txt: string; Sender: TObject);
var
  i: integer;
begin
  // set the message that appear in the title bar
  if MultiFrame1.ActiveObject = Sender then
  begin
    if cfgm.ShowTitlePos then
      Caption := basecaption + ' - ' + MultiFrame1.ActiveChild.Caption +
        blank + blank + txt
    else
      Caption := basecaption + ' - ' + MultiFrame1.ActiveChild.Caption;
    for i := 0 to numscript - 1 do
      Fscript[i].ChartRefreshEvent(MultiFrame1.ActiveChild.Caption, txt);
  end;
end;

procedure Tf_main.FormResize(Sender: TObject);
begin
  SaveState := WindowState;
  if Divider_ToolBarMain_end <> nil then
    quicksearch.Width := min(300, max(90, (quicksearch.Width +
      ToolBarMain.Width - Divider_ToolBarMain_end.Left -
      Divider_ToolBarMain_end.Width)));
end;

procedure Tf_main.SetDefault;
var
  i: integer;
begin
  NightVision := False;
  cfgm.MaxChildID := 0;
  cfgm.prtname := '';
  cfgm.SesameUrlNum := 0;
  cfgm.SesameCatNum := 3;
  cfgm.btnsize := 28;
  cfgm.btncaption := False;
  cfgm.configpage := 0;
  cfgm.configpage_i := 0;
  cfgm.configpage_j := 0;
  cfgm.ClockColor := clRed;
  cfgm.Paper := 2;
  cfgm.PrinterResolution := 300;
  cfgm.PrintColor := 0;
  cfgm.PrintBmpWidth := 1920;
  cfgm.PrintBmpHeight := 1080;
  cfgm.PrintLandscape := True;
  cfgm.PrintMethod := 2;
  cfgm.PrintCmd1 := DefaultPrintCmd1;
  cfgm.PrintCmd2 := DefaultPrintCmd2;
  cfgm.PrintTmpPath := expandfilename(HomeDir);
  cfgm.PrintDesc := '';
  cfgm.PrintCopies := 1;
  cfgm.PrtLeftMargin := 15;
  cfgm.PrtRightMargin := 15;
  cfgm.PrtTopMargin := 10;
  cfgm.PrtBottomMargin := 5;
  cfgm.PrintHeader := True;
  cfgm.PrintFooter := True;
  cfgm.maximized := True;
  cfgm.KioskMode := False;
  cfgm.KioskDebug := False;
  cfgm.KioskPass := '';
  cfgm.CenterAtNoon := True;
  cfgm.SimpleMove := True;
  cfgm.updall := True;
  cfgm.AutoRefreshDelay := 30;
  cfgm.ServerIPaddr := '127.0.0.1';
  cfgm.ServerIPport := '3292'; // x'CDC' :o)
  cfgm.TextOnlyDetail := False;
  cfgm.AutostartServer := True;
  cfgm.ServerCoordSys:=1;
  ServerCoordSystem:=TServerCoordSys(cfgm.ServerCoordSys);
  cfgm.db := slash(dbdir) + (defaultSqliteDB);
  cfgm.ImagePath := slash('data') + slash('pictures');
  cfgm.ShowChartInfo := False;
  cfgm.ShowTitlePos := False;
  cfgm.SyncChart := False;
  cfgm.ThemeName := 'default';
  cfgm.NightColor := 0;
  cfgm.VOurl := 0;
  cfgm.VOmaxrecord := 10000;
  cfgm.AnimDelay := 500;
  cfgm.AnimFps := 10.0;
  cfgm.AnimRec := False;
  cfgm.AnimRecDir := HomeDir;
  cfgm.AnimRecPrefix := 'skychart';
  cfgm.AnimRecExt := '.mp4';
  cfgm.Animffmpeg := Defaultffmpeg;
  cfgm.AnimSx := -1;
  cfgm.AnimSy := -1;
  cfgm.AnimSize := 0;
  cfgm.AnimOpt := DefaultffmpegOptions;
  cfgm.HttpProxy := False;
  cfgm.SocksProxy := False;
  cfgm.SocksType := 'Socks5';
  cfgm.FtpPassive := True;
  cfgm.ConfirmDownload := True;
  cfgm.ProxyHost := '';
  cfgm.ProxyPort := '';
  cfgm.ProxyUser := '';
  cfgm.ProxyPass := '';
  cfgm.AnonPass := 'skychart@';
  cfgm.ObsNameList.Sorted := True;
  cfgm.CometUrlList.Add(URL_HTTPCometElements1);
  cfgm.AsteroidUrlList.Add(URL_CDCAsteroidElements);
  cfgm.TleUrlList.add(URL_CELESTRAK1);
  cfgm.TleUrlList.add(URL_QSMAG);
  cfgm.starshape_file := '';
  cfgm.tlelst := '';
  cfgm.HorizonNumDay:=15;
  cfgm.SampAutoconnect := False;
  cfgm.SampKeepTables := False;
  cfgm.SampKeepImages := False;
  cfgm.SampConfirmCoord := True;
  cfgm.SampConfirmImage := True;
  cfgm.SampConfirmTable := True;
  cfgm.SampSubscribeCoord := True;
  cfgm.SampSubscribeImage := True;
  cfgm.SampSubscribeTable := True;
  for i := 1 to MaxDSSurl do
  begin
    f_getdss.cfgdss.DSSurl[i, 0] := '';
    f_getdss.cfgdss.DSSurl[i, 1] := '';
  end;
  f_getdss.cfgdss.DSSurl[1, 0] := URL_DSS_NAME1;
  f_getdss.cfgdss.DSSurl[1, 1] := URL_DSS1;
  f_getdss.cfgdss.DSSurl[2, 0] := URL_DSS_NAME2;
  f_getdss.cfgdss.DSSurl[2, 1] := URL_DSS2;
  f_getdss.cfgdss.DSSurl[3, 0] := URL_DSS_NAME3;
  f_getdss.cfgdss.DSSurl[3, 1] := URL_DSS3;
  f_getdss.cfgdss.DSSurl[4, 0] := URL_DSS_NAME4;
  f_getdss.cfgdss.DSSurl[4, 1] := URL_DSS4;
  f_getdss.cfgdss.DSSurl[5, 0] := URL_DSS_NAME5;
  f_getdss.cfgdss.DSSurl[5, 1] := URL_DSS5;
  f_getdss.cfgdss.DSSurl[6, 0] := URL_DSS_NAME6;
  f_getdss.cfgdss.DSSurl[6, 1] := URL_DSS6;
  f_getdss.cfgdss.DSSurl[7, 0] := URL_DSS_NAME7;
  f_getdss.cfgdss.DSSurl[7, 1] := URL_DSS7;
  f_getdss.cfgdss.DSSurl[8, 0] := URL_DSS_NAME8;
  f_getdss.cfgdss.DSSurl[8, 1] := URL_DSS8;
  f_getdss.cfgdss.DSSurl[9, 0] := URL_DSS_NAME9;
  f_getdss.cfgdss.DSSurl[9, 1] := URL_DSS9;
  f_getdss.cfgdss.DSSurl[10, 0] := URL_DSS_NAME10;
  f_getdss.cfgdss.DSSurl[10, 1] := URL_DSS10;
  f_getdss.cfgdss.DSSurl[11, 0] := URL_DSS_NAME11;
  f_getdss.cfgdss.DSSurl[11, 1] := URL_DSS11;
  f_getdss.cfgdss.DSSurl[12, 0] := URL_DSS_NAME12;
  f_getdss.cfgdss.DSSurl[12, 1] := URL_DSS12;
  f_getdss.cfgdss.DSSurl[13, 0] := URL_DSS_NAME13;
  f_getdss.cfgdss.DSSurl[13, 1] := URL_DSS13;
  f_getdss.cfgdss.DSSurl[14, 0] := URL_DSS_NAME14;
  f_getdss.cfgdss.DSSurl[14, 1] := URL_DSS14;
  f_getdss.cfgdss.DSSurl[15, 0] := URL_DSS_NAME15;
  f_getdss.cfgdss.DSSurl[15, 1] := URL_DSS15;
  f_getdss.cfgdss.DSSurl[16, 0] := URL_DSS_NAME16;
  f_getdss.cfgdss.DSSurl[16, 1] := URL_DSS16;
  f_getdss.cfgdss.DSSurl[17, 0] := URL_DSS_NAME17;
  f_getdss.cfgdss.DSSurl[17, 1] := URL_DSS17;
  f_getdss.cfgdss.DSSurl[18, 0] := URL_DSS_NAME18;
  f_getdss.cfgdss.DSSurl[18, 1] := URL_DSS18;
  f_getdss.cfgdss.DSSurl[19, 0] := URL_DSS_NAME19;
  f_getdss.cfgdss.DSSurl[19, 1] := URL_DSS19;
  f_getdss.cfgdss.OnlineDSS := True;
  f_getdss.cfgdss.OnlineDSSid := 5;
  for i := 1 to numfont do
  begin
    def_cfgplot.FontName[i] := DefaultFontName;
    def_cfgplot.FontSize[i] := DoScaleX(DefaultFontSize);
    def_cfgplot.FontBold[i] := False;
    def_cfgplot.FontItalic[i] := False;
  end;
  def_cfgplot.FontName[5] := DefaultFontFixed;
  def_cfgplot.FontName[7] := DefaultFontSymbol;
  for i := 1 to numlabtype do
  begin
    def_cfgplot.LabelColor[i] := clWhite;
    def_cfgplot.LabelSize[i] := DoScaleX(DefaultFontSize);
    def_cfgsc.LabelMagDiff[i] := 4;
    def_cfgsc.ShowLabel[i] := True;
    def_cfgsc.LabelOrient[i] := 0;
  end;
  def_cfgsc.ObslistAlLabels := True;
  def_cfgsc.LabelMagDiff[1] := 3;
  def_cfgsc.LabelMagDiff[5] := 0;
  def_cfgsc.LabelMagDiff[10] := 2;
  def_cfgsc.LabelMagDiff[11] := 0;
  def_cfgsc.lockMagn := false;
  def_cfgsc.horizonfile := '';
  def_cfgsc.HorizonPictureFile := '';
  def_cfgplot.LabelColor[6] := clYellow;
  def_cfgplot.LabelColor[7] := clSilver;
  def_cfgplot.LabelSize[6] := def_cfgplot.LabelSize[6] + 2;
  def_cfgplot.LabelColor[9] := clLime;
  def_cfgplot.LabelSize[9] := DoScaleX(DefaultFontSize + 1);
  def_cfgsc.LabelMagDiff[9] := 0;
  def_cfgsc.ShowLabel[9] := True;
  def_cfgplot.contrast := 450;
  def_cfgplot.partsize := 1.2;
  def_cfgplot.red_move := True;
  def_cfgplot.magsize := 4;
  def_cfgplot.saturation := 255;
  cfgm.Constellationpath := 'data' + Pathdelim + 'constellation';
  cfgm.ConstLfile := 'data' + Pathdelim + 'constellation' + Pathdelim + 'IAU_ConstL.cln';
  cfgm.ConstBfile := 'data' + Pathdelim + 'constellation' + Pathdelim + 'constb.cby';
  cfgm.EarthMapFile := 'data' + Pathdelim + 'earthmap' + Pathdelim + 'earthmap1k.jpg';
  cfgm.PlanetDir := 'data' + Pathdelim + 'planet';
  def_cfgplot.UseBMP := True;
  def_cfgplot.AntiAlias := True;
  def_cfgplot.invisible := False;
  def_cfgplot.color := dfColor;
  def_cfgplot.skycolor := dfSkyColor;
  def_cfgplot.bgColor := dfColor[0];
  def_cfgplot.backgroundcolor := def_cfgplot.color[0];
  def_cfgplot.Nebgray := 55;
  def_cfgplot.NebBright := 180;
  def_cfgplot.stardyn := 75;
  def_cfgplot.starsize := 13;
  def_cfgplot.starplot := 2;
  def_cfgplot.nebplot := 1;
  def_cfgplot.plaplot := 2;
  def_cfgplot.TransparentPlanet := False;
  def_cfgplot.AutoSkycolor := False;
  def_cfgplot.DSOColorFillAst := True;
  def_cfgplot.DSOColorFillOCl := True;
  def_cfgplot.DSOColorFillGCl := True;
  def_cfgplot.DSOColorFillPNe := True;
  def_cfgplot.DSOColorFillDN := True;
  def_cfgplot.DSOColorFillEN := True;
  def_cfgplot.DSOColorFillRN := True;
  def_cfgplot.DSOColorFillSN := True;
  def_cfgplot.DSOColorFillGxy := True;
  def_cfgplot.DSOColorFillGxyCl := True;
  def_cfgplot.DSOColorFillQ := True;
  def_cfgplot.DSOColorFillGL := True;
  def_cfgplot.DSOColorFillNE := True;
  def_cfgplot.MinDsoSize := 3;
  def_cfgsc.BGalpha := 200;
  def_cfgsc.BGitt := ittramp;
  def_cfgsc.BGmin_sigma := 0;
  def_cfgsc.BGmax_sigma := 0;
  def_cfgsc.NEBmin_sigma := 0;
  def_cfgsc.NEBmax_sigma := 0;
  def_cfgsc.MaxArchiveImg := 1;
  for i := 1 to MaxArchiveDir do
    def_cfgsc.ArchiveDir[i] := '';
  for i := 1 to MaxArchiveDir do
    def_cfgsc.ArchiveDirActive[i] := False;
  def_cfgsc.ArchiveDir[1] := ArchiveDir;
  def_cfgsc.winx := clientwidth;
  def_cfgsc.winy := clientheight;
  def_cfgsc.UseSystemTime := True;
  def_cfgsc.AutoRefresh := True;
  def_cfgsc.JDchart := jd2000;
  def_cfgsc.LastJDchart := -1E25;
  def_cfgsc.racentre := 1.4;
  def_cfgsc.decentre := 0;
  def_cfgsc.fov := deg2rad * 120;
  def_cfgsc.theta := 0;
  def_cfgsc.projtype := 'A';
  def_cfgsc.ProjPole := AltAz;
  def_cfgsc.ProjEquatorCentered := True;
  if screen.Height > 0 then
    def_cfgsc.WindowRatio := screen.Width / screen.Height
  else
    def_cfgsc.WindowRatio := 1;
  def_cfgsc.acentre := 0;
  def_cfgsc.hcentre := MinValue([def_cfgsc.fov, def_cfgsc.fov /
    def_cfgsc.windowratio]) / 2;
  def_cfgsc.FlipX := 1;
  def_cfgsc.FlipY := 1;
  def_cfgsc.BxGlb := 1;
  def_cfgsc.ByGlb := 1;
  def_cfgsc.AxGlb := 0;
  def_cfgsc.AyGlb := 0;
  def_cfgsc.xmin := 0;
  def_cfgsc.xmax := 100;
  def_cfgsc.ymin := 0;
  def_cfgsc.ymax := 100;
  def_cfgsc.ObsLatitude := 46.2;
  def_cfgsc.ObsLongitude := -6.1;
  def_cfgsc.ObsAltitude := 0;
  def_cfgsc.ObsXP := 0;
  def_cfgsc.ObsYP := 0;
  def_cfgsc.ObsTZ := '';
  def_cfgsc.ObsTemperature := 10;
  def_cfgsc.ObsPressure := 1013;
  def_cfgsc.ObsRH := 0.5;
  def_cfgsc.ObsTlr := 0.0065;
  def_cfgsc.ObsName := 'Geneva';
  def_cfgsc.countrytz := True;
  def_cfgsc.ObsCountry := 'Switzerland';
  def_cfgsc.horizonopaque := True;
  def_cfgsc.ShowScale := False;
  def_cfgsc.FillHorizon := True;
  def_cfgsc.ShowHorizon := False;
  def_cfgsc.ShowHorizonPicture := True;
  def_cfgsc.HorizonPictureLowQuality := True;
  def_cfgsc.HorizonPictureRotate := 0;
  def_cfgsc.HorizonPictureElevation := 0;
  def_cfgsc.DarkenHorizonPicture := True;
  def_cfgsc.ShowHorizonDepression := False;
  def_cfgsc.ShowHorizon0 := True;
  def_cfgsc.MeridianWideLine := True;
  def_cfgsc.HorizonMax := 0;
  def_cfgsc.CoordExpertMode := False;
  def_cfgsc.CoordType := 0;
  def_cfgsc.PMon := True;
  def_cfgsc.DrawPMon := False;
  def_cfgsc.DrawPMyear := 5000;
  def_cfgsc.ApparentPos := True;
  def_cfgsc.ShowEqGrid := False;
  def_cfgsc.ShowGrid := True;
  def_cfgsc.ShowGridNum := True;
  def_cfgsc.CenterDecGridNum := False;
  def_cfgsc.ShowOnlyMeridian := False;
  def_cfgsc.ShowAlwaysMeridian := True;
  def_cfgsc.ShowConstL := True;
  def_cfgsc.CurrentConstel := '';
  def_cfgsc.ShowConstB := False;
  def_cfgsc.ShowEcliptic := False;
  def_cfgsc.ShowGalactic := False;
  def_cfgsc.ShowEquator := False;
  def_cfgsc.ShowMilkyWay := True;
  def_cfgsc.FillMilkyWay := True;
  def_cfgsc.LinemodeMilkyway := True;
  def_cfgsc.showstars := True;
  def_cfgsc.shownebulae := True;
  def_cfgsc.showline := True;
  def_cfgsc.showlabelall := True;
  def_cfgsc.Editlabels := False;
  def_cfgsc.OptimizeLabels := True;
  def_cfgsc.RotLabel := False;
  def_cfgsc.AltAzMark:=false;
  def_cfgsc.HorizonRise := True;
  def_cfgsc.AirmassMagnitude:=False;
  def_cfgsc.StyleGrid := psSolid;
  def_cfgsc.StyleEqGrid := psSolid;
  def_cfgsc.StyleConstL := psSolid;
  def_cfgsc.StyleConstB := psSolid;
  def_cfgsc.StyleEcliptic := psSolid;
  def_cfgsc.StyleGalEq := psSolid;
  def_cfgsc.LineWidthGrid := 0;
  def_cfgsc.LineWidthEqGrid := 0;
  def_cfgsc.LineWidthConstL := 1;
  def_cfgsc.LineWidthConstB := 1;
  def_cfgsc.LineWidthEcliptic := 1;
  def_cfgsc.LineWidthGalEq := 1;
  def_cfgsc.Simnb := 1;
  def_cfgsc.SimLabel := 3;
  def_cfgsc.SimNameLabel := True;
  def_cfgsc.SimDateLabel := True;
  def_cfgsc.SimDateYear := True;
  def_cfgsc.SimDateMonth := True;
  def_cfgsc.SimDateDay := True;
  def_cfgsc.SimDateHour := True;
  def_cfgsc.SimDateMinute := True;
  def_cfgsc.SimDateSecond := False;
  def_cfgsc.SimMagLabel := False;
  def_cfgsc.ShowLegend := False;
  def_cfgsc.SimD := 1;
  def_cfgsc.SimH := 0;
  def_cfgsc.SimM := 0;
  def_cfgsc.SimS := 0;
  def_cfgsc.SimAsteroid := -1;
  def_cfgsc.SimAsteroidName := '';
  def_cfgsc.SimBody := -1;
  def_cfgsc.SimComet := '';
  def_cfgsc.SimCometName := '';
  def_cfgsc.SimLine := True;
  def_cfgsc.SimMark := True;
  for i := 1 to NumSimObject do
    def_cfgsc.SimObject[i] := (i<>14);
  def_cfgsc.sunurlname := URL_SUN_NAME[1];
  def_cfgsc.sunurl := URL_SUN[1];
  def_cfgsc.sunurlsize := URL_SUN_SIZE[1];
  def_cfgsc.sunurlmargin := URL_SUN_MARGIN[1];
  def_cfgsc.sunrefreshtime := 24;
  def_cfgsc.SunOnline := False;
  def_cfgsc.ShowPlanet := True;
  def_cfgsc.ShowPluto := True;
  def_cfgsc.ShowAsteroid := True;
  def_cfgsc.ShowSmallsat := True;
  def_cfgsc.SPKlist.Clear;
  def_cfgsc.DSLforcecolor := False;
  def_cfgsc.DSLsurface := True;
  def_cfgsc.DSLcolor := 0;
  def_cfgsc.SurfaceAlpha := 128;
  def_cfgsc.SurfaceBlure := True;
  def_cfgsc.ShowImages := False;
  def_cfgsc.ShowImageList := False;
  def_cfgsc.ShowImageLabel := False;
  def_cfgsc.ShowBackgroundImage := False;
  def_cfgsc.BackgroundImage := '';
  def_cfgsc.AstSymbol := 0;
  def_cfgsc.AstmagMax := 18;
  def_cfgsc.AstmagDiff := 6;
  def_cfgsc.AstNEO := True;
  def_cfgsc.ShowComet := True;
  def_cfgsc.ShowArtSat := False;
  def_cfgsc.NewArtSat := False;
  def_cfgsc.ComSymbol := 1;
  def_cfgsc.CommagMax := 18;
  def_cfgsc.CommagDiff := 4;
  def_cfgsc.MagLabel := False;
  def_cfgsc.NameLabel := False;
  def_cfgsc.DistLabel := False;
  def_cfgsc.ConstFullLabel := True;
  def_cfgsc.DrawAllStarLabel := False;
  def_cfgsc.MagNoDecimal := False;
  def_cfgsc.MovedLabelLine := True;
  def_cfgsc.ConstLatinLabel := False;
  def_cfgsc.PlanetParalaxe := True;
  def_cfgsc.ShowEarthShadow := False;
  def_cfgsc.EarthShadowForceLine := False;
  def_cfgsc.GRSlongitude := 314.5;
  def_cfgsc.GRSjd := jd(2019, 8, 12, 0);
  def_cfgsc.GRSdrift := 18.3 / 365.25;
  def_cfgsc.FindOk := False;
  def_cfgsc.nummodlabels := 0;
  def_cfgsc.posmodlabels := 0;
  def_cfgsc.numcustomlabels := 0;
  def_cfgsc.poscustomlabels := 0;
  for i := 1 to def_cfgsc.ncircle do
  begin
    def_cfgsc.circle[i, 1] := 0;
    def_cfgsc.circle[i, 2] := 0;
    def_cfgsc.circle[i, 3] := 0;
    def_cfgsc.circle[i, 4] := 0;
    def_cfgsc.circleok[i] := False;
    def_cfgsc.circlelbl[i] := '';
  end;
  for i := 1 to def_cfgsc.nrectangle do
  begin
    def_cfgsc.rectangle[i, 1] := 0;
    def_cfgsc.rectangle[i, 2] := 0;
    def_cfgsc.rectangle[i, 3] := 0;
    def_cfgsc.rectangle[i, 4] := 0;
    def_cfgsc.rectangle[i, 5] := 0;
    def_cfgsc.rectangleok[i] := False;
    def_cfgsc.rectanglelbl[i] := '';
  end;
  def_cfgsc.CalGraphHeight := 100;
  def_cfgsc.PlanisphereTime := False;
  def_cfgsc.PlanisphereDate := False;
  def_cfgsc.CircleLabel := True;
  def_cfgsc.RectangleLabel := True;
  def_cfgsc.marknumlabel := True;
  def_cfgsc.circle[1, 1] := 240;
  def_cfgsc.circle[2, 1] := 120;
  def_cfgsc.circle[3, 1] := 30;
  def_cfgsc.circleok[1] := True;
  def_cfgsc.circleok[2] := True;
  def_cfgsc.circleok[3] := True;
  def_cfgsc.circlelbl[1] := 'Telrad';
  def_cfgsc.circle[4, 1] := 18;
  def_cfgsc.circle[4, 2] := 45;
  def_cfgsc.circle[4, 3] := 30;
  def_cfgsc.circlelbl[4] := 'Off-Axis guider';
  def_cfgsc.circle[5, 1] := 26.5;
  def_cfgsc.circle[6, 1] := 17.5;
  def_cfgsc.circlelbl[5] := 'ST7 autoguider area';
  def_cfgsc.circlelbl[6] := 'ST7 autoguider area';
  def_cfgsc.rectangle[1, 1] := 11.8;
  def_cfgsc.rectangle[1, 2] := 7.9;
  def_cfgsc.rectangleok[1] := True;
  def_cfgsc.rectanglelbl[1] := 'KAF400 prime focus';
  def_cfgsc.rectangle[2, 1] := 4.5;
  def_cfgsc.rectangle[2, 2] := 4.5;
  def_cfgsc.rectangle[2, 4] := 11;
  def_cfgsc.rectangleok[2] := True;
  def_cfgsc.rectanglelbl[2] := 'ST7 autoguider';
  def_cfgsc.rectanglelbl[10] := 'Reserved for CCDciel use';
  def_cfgsc.NumCircle := 0;
  def_cfgsc.ShowCircle := False;
  def_cfgsc.ShowCrosshair := False;
  def_cfgsc.EyepieceMask := False;
  def_cfgsc.AscomDevice := '';
  def_cfgsc.TelescopeAltAz := False;
  def_cfgsc.TelescopeAutoconnect := False;
  def_cfgsc.TelescopeInterval := 1000;
  {$ifdef mswindows}
   def_cfgsc.TelescopeInterface:=0;
  {$else}
   def_cfgsc.TelescopeInterface:=2;
  {$endif}
  def_cfgsc.AlpacaProtocol := 0;
  def_cfgsc.AlpacaHost := '127.0.0.1';
  def_cfgsc.AlpacaPort := 32323;
  def_cfgsc.AlpacaId := '';
  def_cfgsc.AlpacaUser := '';
  def_cfgsc.AlpacaPass := '';
  def_cfgsc.AlpacaDevice := 0;
  def_cfgsc.TelescopeLeft := 0;
  def_cfgsc.TelescopeTop := 0;
  def_cfgsc.IndiServerHost := 'localhost';
  def_cfgsc.IndiServerPort := '7624';
  def_cfgsc.IndiDevice := 'Telescope Simulator';
  def_cfgsc.ManualTelescope := False;
  def_cfgsc.ManualTelescopeType := 0;
  def_cfgsc.TelescopeTurnsX := 6;    // Vixen GP
  def_cfgsc.TelescopeTurnsY := 0.4;
  def_cfgsc.TelescopeJD := 0;
  def_cfgsc.TelLimitDecMaxActive := false;
  def_cfgsc.TelLimitDecMax := 90;
  def_cfgsc.TelLimitDecMinActive := false;
  def_cfgsc.TelLimitDecMin := -90;
  def_cfgsc.TelLimitHaEActive := false;
  def_cfgsc.TelLimitHaE := 12;
  def_cfgsc.TelLimitHaWActive := false;
  def_cfgsc.TelLimitHaW := 12;
  catalog.cfgshr.ListStar := False;
  catalog.cfgshr.ListNeb := True;
  catalog.cfgshr.ListVar := True;
  catalog.cfgshr.ListDbl := True;
  catalog.cfgshr.ListPla := True;
  catalog.cfgshr.AzNorth := True;
  def_cfgsc.EquinoxType := 2;
  def_cfgsc.EquinoxChart := rsDate;
  def_cfgsc.DefaultJDchart := jd2000;
  def_cfgsc.ChartLock := false;
  catalog.cfgshr.StarFilter := True;
  catalog.cfgshr.AutoStarFilter := True;
  catalog.cfgshr.AutoStarFilterMag := DefAutoStarFilterMag;
  catalog.cfgcat.StarmagMax := 12;
  catalog.cfgcat.ShowAllVariable := False;
  catalog.cfgcat.ShowAllDouble := False;
  catalog.cfgshr.NebFilter := True;
  catalog.cfgshr.BigNebFilter := True;
  catalog.cfgshr.BigNebLimit := 211;
  catalog.cfgshr.NoFilterMessier := True;
  catalog.cfgshr.NoFilterMagBright := True;
  catalog.cfgshr.ffove_tfl := '2000';
  catalog.cfgshr.ffove_efl := '30';
  catalog.cfgshr.ffove_efv := '60';
  catalog.cfgshr.ffovc_tfl := '600';
  catalog.cfgshr.ffovc_px := '6';
  catalog.cfgshr.ffovc_py := '6';
  catalog.cfgshr.ffovc_cx := '1024';
  catalog.cfgshr.ffovc_cy := '768';
  catalog.cfgcat.NebmagMax := 12;
  catalog.cfgcat.NebSizeMin := 1;
  catalog.cfgcat.UseUSNOBrightStars := False;
  catalog.cfgcat.UseGSVSIr := False;
  SetLength(catalog.cfgcat.UserObjects, 1);
  catalog.cfgcat.UserObjects[0].active := False;
  catalog.cfgcat.UserObjects[0].oname := 'NGP';
  catalog.cfgcat.UserObjects[0].otype := 14;
  catalog.cfgcat.UserObjects[0].ra := 3.36601290658;
  catalog.cfgcat.UserObjects[0].Dec := 0.473478737245;
  catalog.cfgcat.UserObjects[0].mag := 0;
  catalog.cfgcat.UserObjects[0].size := 30;
  catalog.cfgcat.UserObjects[0].color := 0;
  catalog.cfgcat.UserObjects[0].comment := rsExampleOfUse;
  catalog.cfgcat.GCatNum := 0;
  SetLength(catalog.cfgcat.GCatLst, catalog.cfgcat.GCatNum);
  for i := 1 to maxstarcatalog do
  begin
    catalog.cfgcat.starcatpath[i] := 'cat';
    catalog.cfgcat.starcatdef[i] := False;
    catalog.cfgcat.starcaton[i] := False;
    catalog.cfgcat.starcatfield[i, 1] := 0;
    catalog.cfgcat.starcatfield[i, 2] := 0;
  end;
  catalog.cfgcat.starcatpath[DefStar - BaseStar] :=
    catalog.cfgcat.starcatpath[DefStar - BaseStar] + PathDelim + 'xhip';
  catalog.cfgcat.starcatdef[DefStar - BaseStar] := True;
  catalog.cfgcat.starcatfield[DefStar - BaseStar, 2] := 10;
  catalog.cfgcat.starcatdef[vostar - BaseStar] := False;
  catalog.cfgcat.starcatfield[vostar - BaseStar, 2] := 10;
  catalog.cfgcat.starcatpath[sky2000 - BaseStar] :=
    catalog.cfgcat.starcatpath[sky2000 - BaseStar] + PathDelim + 'sky2000';
  catalog.cfgcat.starcatfield[sky2000 - BaseStar, 1] := 6;
  catalog.cfgcat.starcatfield[sky2000 - BaseStar, 2] := 7;
  catalog.cfgcat.starcatpath[tyc2 - BaseStar] :=
    catalog.cfgcat.starcatpath[tyc2 - BaseStar] + PathDelim + 'tycho2';
  catalog.cfgcat.starcatfield[tyc2 - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[tyc2 - BaseStar, 2] := 5;
  catalog.cfgcat.starcatpath[gscf - BaseStar] :=
    catalog.cfgcat.starcatpath[gscf - BaseStar] + PathDelim + 'gsc';
  catalog.cfgcat.starcatfield[gscf - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[gscf - BaseStar, 2] := 3;
  catalog.cfgcat.starcatpath[gscc - BaseStar] :=
    catalog.cfgcat.starcatpath[gscc - BaseStar] + PathDelim + 'gsc';
  catalog.cfgcat.starcatfield[gscc - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[gscc - BaseStar, 2] := 3;
  catalog.cfgcat.starcatpath[usnoa - BaseStar] :=
    catalog.cfgcat.starcatpath[usnoa - BaseStar] + PathDelim + 'usnoa';
  catalog.cfgcat.starcatfield[usnoa - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[usnoa - BaseStar, 2] := 1;
  catalog.cfgcat.starcatpath[usnob - BaseStar] :=
    catalog.cfgcat.starcatpath[usnob - BaseStar] + PathDelim + 'usnob';
  catalog.cfgcat.starcatfield[usnob - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[usnob - BaseStar, 2] := 1;
  catalog.cfgcat.starcatpath[dsbase - BaseStar] :=
    'C:\Program Files\Deepsky Astronomy Software';
  catalog.cfgcat.starcatfield[dsbase - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[dsbase - BaseStar, 2] := 10;
  catalog.cfgcat.starcatpath[dstyc - BaseStar] :=
    'C:\Program Files\Deepsky Astronomy Software\SuperTycho';
  catalog.cfgcat.starcatfield[dstyc - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[dstyc - BaseStar, 2] := 5;
  catalog.cfgcat.starcatpath[dsgsc - BaseStar] :=
    'C:\Program Files\Deepsky Astronomy Software\HGC';
  catalog.cfgcat.starcatfield[dsgsc - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[dsgsc - BaseStar, 2] := 3;
  catalog.cfgcat.starcatpath[hn290 - BaseStar] := DefaultHnskyPath;
  catalog.cfgcat.starcatdef[hn290 - BaseStar] := false;
  catalog.cfgcat.starcatfield[hn290 - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[hn290 - BaseStar, 2] := 5;
  catalog.cfgcat.Name290:='tyc';
  catalog.cfgcat.starcatpath[gaia - BaseStar] :=
    catalog.cfgcat.starcatpath[gaia - BaseStar] + PathDelim + 'gaia';
  catalog.cfgcat.starcatdef[gaia - BaseStar] := false;
  catalog.cfgcat.starcatfield[gaia - BaseStar, 1] := 0;
  catalog.cfgcat.starcatfield[gaia - BaseStar, 2] := 6;
  catalog.cfgcat.GaiaLevel:=1;
  catalog.cfgcat.LimitGaiaCount:=false;

  for i := 1 to maxvarstarcatalog do
  begin
    catalog.cfgcat.varstarcatpath[i] := 'cat';
    catalog.cfgcat.varstarcatdef[i] := False;
    catalog.cfgcat.varstarcaton[i] := False;
    catalog.cfgcat.varstarcatfield[i, 1] := 0;
    catalog.cfgcat.varstarcatfield[i, 2] := 0;
  end;
   for i := 1 to maxdblstarcatalog do
  begin
    catalog.cfgcat.dblstarcatpath[i] := 'cat';
    catalog.cfgcat.dblstarcatdef[i] := False;
    catalog.cfgcat.dblstarcaton[i] := False;
    catalog.cfgcat.dblstarcatfield[i, 1] := 0;
    catalog.cfgcat.dblstarcatfield[i, 2] := 0;
  end;
  for i := 1 to maxnebcatalog do
  begin
    catalog.cfgcat.nebcatpath[i] := 'cat';
    catalog.cfgcat.nebcatdef[i] := False;
    catalog.cfgcat.nebcaton[i] := False;
    catalog.cfgcat.nebcatfield[i, 1] := 0;
    catalog.cfgcat.nebcatfield[i, 2] := 0;
  end;
  catalog.cfgcat.nebcatdef[uneb - BaseNeb] := False;
  catalog.cfgcat.nebcatfield[uneb - BaseNeb, 2] := 10;
  catalog.cfgcat.nebcatdef[voneb - BaseNeb] := False;
  catalog.cfgcat.nebcatfield[voneb - BaseNeb, 2] := 10;
  catalog.cfgcat.nebcatpath[ngc - BaseNeb] := 'cat' + PathDelim + 'openngc';
  catalog.cfgcat.nebcatfield[ngc - BaseNeb, 2] := 10;
  catalog.cfgcat.nebcatdef[ngc - BaseNeb] := True;

  catalog.cfgshr.FieldNum[0] := 0.5;
  catalog.cfgshr.FieldNum[1] := 1;
  catalog.cfgshr.FieldNum[2] := 2;
  catalog.cfgshr.FieldNum[3] := 5;
  catalog.cfgshr.FieldNum[4] := 10;
  catalog.cfgshr.FieldNum[5] := 20;
  catalog.cfgshr.FieldNum[6] := 45;
  catalog.cfgshr.FieldNum[7] := 120;
  catalog.cfgshr.FieldNum[8] := 180;
  catalog.cfgshr.FieldNum[9] := 310;
  catalog.cfgshr.FieldNum[10] := 360;
  catalog.cfgshr.ShowCRose := False;
  catalog.cfgshr.SimplePointer := False;
  catalog.cfgshr.CRoseSz := 80;
  catalog.cfgshr.DegreeGridSpacing[0] := 5 / 60;
  catalog.cfgshr.DegreeGridSpacing[1] := 10 / 60;
  catalog.cfgshr.DegreeGridSpacing[2] := 20 / 60;
  catalog.cfgshr.DegreeGridSpacing[3] := 30 / 60;
  catalog.cfgshr.DegreeGridSpacing[4] := 1;
  catalog.cfgshr.DegreeGridSpacing[5] := 2;
  catalog.cfgshr.DegreeGridSpacing[6] := 5;
  catalog.cfgshr.DegreeGridSpacing[7] := 10;
  catalog.cfgshr.DegreeGridSpacing[8] := 15;
  catalog.cfgshr.DegreeGridSpacing[9] := 20;
  catalog.cfgshr.DegreeGridSpacing[10] := 20;
  catalog.cfgshr.HourGridSpacing[0] := 20 / 3600;
  catalog.cfgshr.HourGridSpacing[1] := 30 / 3600;
  catalog.cfgshr.HourGridSpacing[2] := 1 / 60;
  catalog.cfgshr.HourGridSpacing[3] := 2 / 60;
  catalog.cfgshr.HourGridSpacing[4] := 5 / 60;
  catalog.cfgshr.HourGridSpacing[5] := 15 / 60;
  catalog.cfgshr.HourGridSpacing[6] := 30 / 60;
  catalog.cfgshr.HourGridSpacing[7] := 1;
  catalog.cfgshr.HourGridSpacing[8] := 1;
  catalog.cfgshr.HourGridSpacing[9] := 2;
  catalog.cfgshr.HourGridSpacing[10] := 2;
  def_cfgsc.projname[0] := 'TAN';
  def_cfgsc.projname[1] := 'TAN';
  def_cfgsc.projname[2] := 'TAN';
  def_cfgsc.projname[3] := 'TAN';
  def_cfgsc.projname[4] := 'TAN';
  def_cfgsc.projname[5] := 'TAN';
  def_cfgsc.projname[6] := 'TAN';
  def_cfgsc.projname[7] := 'MER';
  def_cfgsc.projname[8] := 'MER';
  def_cfgsc.projname[9] := 'MER';
  def_cfgsc.projname[10] := 'MER';
  catalog.cfgshr.StarMagFilter[0] := DefStarMagFilter[0];
  catalog.cfgshr.StarMagFilter[1] := DefStarMagFilter[1];
  catalog.cfgshr.StarMagFilter[2] := DefStarMagFilter[2];
  catalog.cfgshr.StarMagFilter[3] := DefStarMagFilter[3];
  catalog.cfgshr.StarMagFilter[4] := DefStarMagFilter[4];
  catalog.cfgshr.StarMagFilter[5] := DefStarMagFilter[5];
  catalog.cfgshr.StarMagFilter[6] := DefStarMagFilter[6];
  catalog.cfgshr.StarMagFilter[7] := DefStarMagFilter[7];
  catalog.cfgshr.StarMagFilter[8] := DefStarMagFilter[8];
  catalog.cfgshr.StarMagFilter[9] := DefStarMagFilter[9];
  catalog.cfgshr.StarMagFilter[10] := DefStarMagFilter[10];
  catalog.cfgshr.NebMagFilter[0] := DefNebMagFilter[0];
  catalog.cfgshr.NebMagFilter[1] := DefNebMagFilter[1];
  catalog.cfgshr.NebMagFilter[2] := DefNebMagFilter[2];
  catalog.cfgshr.NebMagFilter[3] := DefNebMagFilter[3];
  catalog.cfgshr.NebMagFilter[4] := DefNebMagFilter[4];
  catalog.cfgshr.NebMagFilter[5] := DefNebMagFilter[5];
  catalog.cfgshr.NebMagFilter[6] := DefNebMagFilter[6];
  catalog.cfgshr.NebMagFilter[7] := DefNebMagFilter[7];
  catalog.cfgshr.NebMagFilter[8] := DefNebMagFilter[8];
  catalog.cfgshr.NebMagFilter[9] := DefNebMagFilter[9];
  catalog.cfgshr.NebMagFilter[10] := DefNebMagFilter[10];
  catalog.cfgshr.NebSizeFilter[0] := DefNebSizeFilter[0];
  catalog.cfgshr.NebSizeFilter[1] := DefNebSizeFilter[1];
  catalog.cfgshr.NebSizeFilter[2] := DefNebSizeFilter[2];
  catalog.cfgshr.NebSizeFilter[3] := DefNebSizeFilter[3];
  catalog.cfgshr.NebSizeFilter[4] := DefNebSizeFilter[4];
  catalog.cfgshr.NebSizeFilter[5] := DefNebSizeFilter[5];
  catalog.cfgshr.NebSizeFilter[6] := DefNebSizeFilter[6];
  catalog.cfgshr.NebSizeFilter[7] := DefNebSizeFilter[7];
  catalog.cfgshr.NebSizeFilter[8] := DefNebSizeFilter[8];
  catalog.cfgshr.NebSizeFilter[9] := DefNebSizeFilter[9];
  catalog.cfgshr.NebSizeFilter[10] := DefNebSizeFilter[10];
  nummainbar := numdefaultmainbar;
  numobjectbar := numdefaultobjectbar;
  numleftbar := numdefaultleftbar;
  numrightbar := numdefaultrightbar;
  configmainbar.Clear;
  configobjectbar.Clear;
  configleftbar.Clear;
  configrightbar.Clear;
  for i := 1 to nummainbar do
    configmainbar.Add(defaultmainbar[i]);
  for i := 1 to numobjectbar do
    configobjectbar.Add(defaultobjectbar[i]);
  for i := 1 to numleftbar do
    configleftbar.Add(defaultleftbar[i]);
  for i := 1 to numrightbar do
    configrightbar.Add(defaultrightbar[i]);
  Fscript[0].ScriptFilename := slash(ScriptDir) + 'ObserverTool.cdcps';
  GregorianStart := DefaultGregorianStart;
  GregorianStartJD := DefaultGregorianStartJD;
end;

procedure Tf_main.ReadDefault;
begin
  ReadPrivateConfig(configfile);
  ReadChartConfig(configfile, True, True, def_cfgplot, def_cfgsc);
  if config_version > cdcver then begin
    if MessageDlg('Wrong version','You are trying to run Skychart version '+cdcver+
               ' but the configuration file '+Configfile+' is for a more recent version '+Config_Version+crlf+
               'Please use the program options --config= and --userdir= to select another configuration '+
               'if you really want to do that.'+crlf+
               'Ignoring this error can break your setup!'
               ,mtError,[mbAbort,mbIgnore],0)
       = mrAbort
       then halt;
  end;
  if config_version < cdcver then
    UpdateConfig;
end;

procedure Tf_main.ReadChartConfig(filename: string; usecatalog, resizemain: boolean;
  var cplot: Tconf_plot; var csc: Tconf_skychart);
var
  i, j, t, l, w, h, n, v1, v2: integer;
  dt: TRect;
  inif: TMemIniFile;
  section, buf,buf0,buf1,buf2,buf3: string;
begin
  inif := TMeminifile.Create(filename);
  try
    with inif do
    begin
      section := 'main';
      try
        csc.chartname:=ReadString(section,'ChartName','');
        if resizemain then
        begin
          dt := screen.DesktopRect;
          t := ReadInteger(section, 'WinTop', 40);
          l := ReadInteger(section, 'WinLeft', 40);
          w := ReadInteger(section, 'WinWidth', -999999);
          h := ReadInteger(section, 'WinHeight', -999999);
          if t<dt.Top then t:=dt.Top;
          if l<dt.Left then l:=dt.Left;
          if (w < -999990) or (h < -999990) then
          begin
            if dt.Width > dt.Height then
            begin
              h := round(dt.Height - 100);
              w := round(h * 4 / 3);
            end
            else
            begin
              w := round(dt.Width - 100);
              h := w;
            end;
          end;
          if w > dt.Width then
          begin
            l := dt.Left;
            w := dt.Width - 80;
          end;
          if h > dt.Height then
          begin
            t := dt.Top;
            h := dt.Height - 80;
          end;
          if (t+h)>dt.Height then t:=dt.Top;
          if (l+w)>dt.Width then l:=dt.Left;
          f_main.SetBounds(l, t, w, h);
        end;
        for i := 0 to MaxField do
          catalog.cfgshr.FieldNum[i] :=
            ReadFloat(section, 'FieldNum' + IntToStr(i), catalog.cfgshr.FieldNum[i]);
        tbFOV1.Caption := DEToStrmin(catalog.cfgshr.FieldNum[0]) + blank;
        tbFOV2.Caption := DEToStrmin(catalog.cfgshr.FieldNum[1]) + blank;
        tbFOV3.Caption := DEToStrmin(catalog.cfgshr.FieldNum[2]) + blank;
        tbFOV4.Caption := DEToStrmin(catalog.cfgshr.FieldNum[3]) + blank;
        tbFOV5.Caption := DEToStrmin(catalog.cfgshr.FieldNum[4]) + blank;
        tbFOV6.Caption := DEToStrmin(catalog.cfgshr.FieldNum[5]) + blank;
        tbFOV7.Caption := DEToStrmin(catalog.cfgshr.FieldNum[6]) + blank;
        tbFOV8.Caption := DEToStrmin(catalog.cfgshr.FieldNum[7]) + blank;
        tbFOV9.Caption := DEToStrmin(catalog.cfgshr.FieldNum[8]) + blank;
        tbFOV10.Caption := DEToStrmin(catalog.cfgshr.FieldNum[9]) + blank;
      except
        ShowError('Error reading ' + filename + ' chart main');
      end;
      try
        section := 'font';
        for i := 1 to numfont do
        begin
          cplot.FontName[i] :=
            ReadString(section, 'FontName' + IntToStr(i), cplot.FontName[i]);
          cplot.FontSize[i] :=
            ReadInteger(section, 'FontSize' + IntToStr(i), cplot.FontSize[i]);
          cplot.FontBold[i] :=
            ReadBool(section, 'FontBold' + IntToStr(i), cplot.FontBold[i]);
          cplot.FontItalic[i] :=
            ReadBool(section, 'FontItalic' + IntToStr(i), cplot.FontItalic[i]);
        end;
        for i := 1 to numlabtype do
        begin
          cplot.LabelColor[i] :=
            ReadInteger(section, 'LabelColor' + IntToStr(i), cplot.LabelColor[i]);
          cplot.LabelSize[i] :=
            ReadInteger(section, 'LabelSize' + IntToStr(i), cplot.LabelSize[i]);
        end;
      except
        ShowError('Error reading ' + filename + ' font');
      end;
      try
        section := 'filter';
        catalog.cfgshr.StarFilter :=
          ReadBool(section, 'StarFilter', catalog.cfgshr.StarFilter);
        catalog.cfgshr.AutoStarFilter :=
          ReadBool(section, 'AutoStarFilter', catalog.cfgshr.AutoStarFilter);
        catalog.cfgshr.AutoStarFilterMag :=
          ReadFloat(section, 'AutoStarFilterMag', catalog.cfgshr.AutoStarFilterMag);
        catalog.cfgshr.NebFilter :=
          ReadBool(section, 'NebFilter', catalog.cfgshr.NebFilter);
        catalog.cfgshr.BigNebFilter :=
          ReadBool(section, 'BigNebFilter', catalog.cfgshr.BigNebFilter);
        catalog.cfgshr.BigNebLimit :=
          ReadFloat(section, 'BigNebLimit', catalog.cfgshr.BigNebLimit);
        catalog.cfgshr.NoFilterMessier :=
          ReadBool(section, 'NoFilterMessier', catalog.cfgshr.NoFilterMessier);
        catalog.cfgshr.NoFilterMagBright :=
          ReadBool(section, 'NoFilterMagBright', catalog.cfgshr.NoFilterMagBright);
        for i := 1 to maxfield do
        begin
          catalog.cfgshr.StarMagFilter[i] :=
            ReadFloat(section, 'StarMagFilter' + IntToStr(i),
            catalog.cfgshr.StarMagFilter[i]);
          catalog.cfgshr.NebMagFilter[i] :=
            ReadFloat(section, 'NebMagFilter' + IntToStr(i),
            catalog.cfgshr.NebMagFilter[i]);
          catalog.cfgshr.NebSizeFilter[i] :=
            ReadFloat(section, 'NebSizeFilter' + IntToStr(i),
            catalog.cfgshr.NebSizeFilter[i]);
        end;
      except
        ShowError('Error reading ' + filename + ' filter');
      end;
      if usecatalog then
      begin
        try
          section := 'catalog';
          catalog.cfgcat.GCatNum := Readinteger(section, 'GCatNum', 0);
          SetLength(catalog.cfgcat.GCatLst, catalog.cfgcat.GCatNum);
          j := -1;
          for i := 0 to catalog.cfgcat.GCatNum - 1 do
          begin
            Inc(j);
            catalog.cfgcat.GCatLst[j].shortname := Readstring(section, 'CatName' + IntToStr(i), catalog.cfgcat.GCatLst[i].shortname);
            catalog.cfgcat.GCatLst[j].Name := Readstring(section, 'CatLongName' + IntToStr(i), catalog.cfgcat.GCatLst[i].Name);
            catalog.cfgcat.GCatLst[j].path := ExtractSubPath(ConfigAppdir, Readstring(section, 'CatPath' + IntToStr(i), catalog.cfgcat.GCatLst[i].path));
            catalog.cfgcat.GCatLst[j].min := ReadFloat(section, 'CatMin' + IntToStr(i), catalog.cfgcat.GCatLst[i].min);
            catalog.cfgcat.GCatLst[j].max := ReadFloat(section, 'CatMax' + IntToStr(i), catalog.cfgcat.GCatLst[i].max);
            catalog.cfgcat.GCatLst[j].Actif := ReadBool(section, 'CatActif' + IntToStr(i), catalog.cfgcat.GCatLst[i].Actif);
            catalog.cfgcat.GCatLst[j].Search := ReadBool(section, 'CatSearch' + IntToStr(i), catalog.cfgcat.GCatLst[i].Search);
            catalog.cfgcat.GCatLst[j].ForceColor := ReadBool(section, 'CatForceColor' + IntToStr(i), False);
            catalog.cfgcat.GCatLst[j].ForceLabel := ReadBool(section, 'CatForceLabel' + IntToStr(i), False);
            catalog.cfgcat.GCatLst[j].Col := ReadInteger(section, 'CatColor' + IntToStr(i), 0);
            catalog.cfgcat.GCatLst[j].startype := ReadInteger(section, 'CatStarType' + IntToStr(i), 0);
            catalog.cfgcat.GCatLst[j].starsize := ReadInteger(section, 'CatStarSize' + IntToStr(i), 0);
            catalog.cfgcat.GCatLst[j].magmax := 0;
            catalog.cfgcat.GCatLst[j].cattype := 0;
            if catalog.cfgcat.GCatLst[j].Actif or catalog.cfgcat.GCatLst[j].Search then
            begin
              if not catalog.GetInfo(catalog.cfgcat.GCatLst[j].path,
                catalog.cfgcat.GCatLst[j].shortname,
                catalog.cfgcat.GCatLst[j].magmax,
                catalog.cfgcat.GCatLst[j].cattype,
                v1,
                v2,
                catalog.cfgcat.GCatLst[j].version,
                catalog.cfgcat.GCatLst[j].Name)
                then
                  catalog.cfgcat.GCatLst[j].Actif := False;
                if catalog.cfgcat.GCatLst[j].startype = 0 then
                  catalog.cfgcat.GCatLst[j].startype := v1;
                if catalog.cfgcat.GCatLst[j].starsize = 0 then
                  catalog.cfgcat.GCatLst[j].starsize := v2;
            end;
          end;
          catalog.cfgcat.GCatNum := j + 1;
          SetLength(catalog.cfgcat.GCatLst, catalog.cfgcat.GCatNum);
          n := Length(catalog.cfgcat.UserObjects);
          n := Readinteger(section, 'UserObjectsNum', n);
          SetLength(catalog.cfgcat.UserObjects, n);
          for i := 0 to n - 1 do
          begin
            catalog.cfgcat.UserObjects[i].active :=
              ReadBool(section, 'UObjActive' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].active);
            catalog.cfgcat.UserObjects[i].otype :=
              ReadInteger(section, 'UObjType' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].otype);
            catalog.cfgcat.UserObjects[i].oname :=
              ReadString(section, 'UObjName' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].oname);
            catalog.cfgcat.UserObjects[i].ra :=
              ReadFloat(section, 'UObjRA' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].ra);
            catalog.cfgcat.UserObjects[i].Dec :=
              ReadFloat(section, 'UObjDEC' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].Dec);
            catalog.cfgcat.UserObjects[i].mag :=
              ReadFloat(section, 'UObjMag' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].mag);
            catalog.cfgcat.UserObjects[i].size :=
              ReadFloat(section, 'UObjSize' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].size);
            catalog.cfgcat.UserObjects[i].color :=
              ReadInteger(section, 'UObjColor' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].color);
            catalog.cfgcat.UserObjects[i].comment :=
              ReadString(section, 'UObjComment' + IntToStr(i),
              catalog.cfgcat.UserObjects[i].comment);
          end;
          catalog.cfgcat.StarmagMax :=
            ReadFloat(section, 'StarmagMax', catalog.cfgcat.StarmagMax);
          catalog.cfgcat.NebmagMax :=
            ReadFloat(section, 'NebmagMax', catalog.cfgcat.NebmagMax);
          catalog.cfgcat.NebSizeMin :=
            ReadFloat(section, 'NebSizeMin', catalog.cfgcat.NebSizeMin);
          catalog.cfgcat.UseUSNOBrightStars :=
            ReadBool(section, 'UseUSNOBrightStars', catalog.cfgcat.UseUSNOBrightStars);
          catalog.cfgcat.UseGSVSIr :=
            ReadBool(section, 'UseGSVSIr', catalog.cfgcat.UseGSVSIr);
          catalog.cfgcat.Name290 :=
            ReadString(section, 'Name290', catalog.cfgcat.Name290);
          catalog.cfgcat.LimitGaiaCount :=
            ReadBool(section, 'LimitGaiaCount', catalog.cfgcat.LimitGaiaCount);
          for i := 1 to maxstarcatalog do
          begin
            catalog.cfgcat.starcatdef[i] :=
              ReadBool(section, 'starcatdef' + IntToStr(i),
              catalog.cfgcat.starcatdef[i]);
            catalog.cfgcat.starcaton[i] :=
              ReadBool(section, 'starcaton' + IntToStr(i), catalog.cfgcat.starcaton[i]);
            catalog.cfgcat.starcatfield[i, 1] :=
              ReadInteger(section, 'starcatfield1' + IntToStr(i),
              catalog.cfgcat.starcatfield[i, 1]);
            catalog.cfgcat.starcatfield[i, 2] :=
              ReadInteger(section, 'starcatfield2' + IntToStr(i),
              catalog.cfgcat.starcatfield[i, 2]);
          end;
          if pos('bsc5', catalog.cfgcat.starcatpath[DefStar - BaseStar]) > 0 then
          begin    // Upgrade to new default catalog
            catalog.cfgcat.starcatpath[DefStar - BaseStar] := slash('cat') + 'xhip';
          end;

          for i := 1 to maxnebcatalog do
          begin
            catalog.cfgcat.nebcatdef[i] :=
              ReadBool(section, 'nebcatdef' + IntToStr(i), catalog.cfgcat.nebcatdef[i]);
            catalog.cfgcat.nebcaton[i] :=
              ReadBool(section, 'nebcaton' + IntToStr(i), catalog.cfgcat.nebcaton[i]);
            catalog.cfgcat.nebcatfield[i, 1] :=
              ReadInteger(section, 'nebcatfield1' + IntToStr(i),
              catalog.cfgcat.nebcatfield[i, 1]);
            catalog.cfgcat.nebcatfield[i, 2] :=
              ReadInteger(section, 'nebcatfield2' + IntToStr(i),
              catalog.cfgcat.nebcatfield[i, 2]);
          end;
        except
          ShowError('Error reading ' + filename + ' chart catalog');
        end;
      end;
      try
        section := 'display';
        cplot.AntiAlias := ReadBool(section, 'AntiAlias', cplot.AntiAlias);
        cplot.starplot := ReadInteger(section, 'starplot', cplot.starplot);
        cplot.nebplot := ReadInteger(section, 'nebplot', cplot.nebplot);
        cplot.TransparentPlanet :=
          ReadBool(section, 'TransparentPlanet', cplot.TransparentPlanet);
        cplot.plaplot := ReadInteger(section, 'plaplot', cplot.plaplot);
        cplot.Nebgray := ReadInteger(section, 'Nebgray', cplot.Nebgray);
        cplot.NebBright := ReadInteger(section, 'NebBright', cplot.NebBright);
        cplot.stardyn := ReadInteger(section, 'StarDyn', cplot.stardyn);
        cplot.starsize := ReadInteger(section, 'StarSize', cplot.starsize);
        cplot.contrast := ReadInteger(section, 'contrast', cplot.contrast);
        cplot.saturation := ReadInteger(section, 'saturation', cplot.saturation);
        cplot.red_move := ReadBool(section, 'redmove', cplot.red_move);
        cplot.partsize := ReadFloat(section, 'partsize', cplot.partsize);
        cplot.partsize := max(cplot.partsize, 0.1);
        cplot.partsize := min(cplot.partsize, 5.0);
        cplot.magsize := ReadFloat(section, 'magsize', cplot.magsize);
        cplot.magsize := max(cplot.magsize, 1.0);
        cplot.magsize := min(cplot.magsize, 10.0);
        cplot.AutoSkycolor := ReadBool(section, 'AutoSkycolor', cplot.AutoSkycolor);
        cplot.DSOColorFillAst :=
          ReadBool(section, 'DSOColorFillAst', cplot.DSOColorFillAst);
        cplot.DSOColorFillOCl :=
          ReadBool(section, 'DSOColorFillOCl', cplot.DSOColorFillOCl);
        cplot.DSOColorFillGCl :=
          ReadBool(section, 'DSOColorFillGCl', cplot.DSOColorFillGCl);
        cplot.DSOColorFillPNe :=
          ReadBool(section, 'DSOColorFillPNe', cplot.DSOColorFillPNe);
        cplot.DSOColorFillDN :=
          ReadBool(section, 'DSOColorFillDN', cplot.DSOColorFillDN);
        cplot.DSOColorFillEN :=
          ReadBool(section, 'DSOColorFillEN', cplot.DSOColorFillEN);
        cplot.DSOColorFillRN :=
          ReadBool(section, 'DSOColorFillRN', cplot.DSOColorFillRN);
        cplot.DSOColorFillSN :=
          ReadBool(section, 'DSOColorFillSN', cplot.DSOColorFillSN);
        cplot.DSOColorFillGxy :=
          ReadBool(section, 'DSOColorFillGxy', cplot.DSOColorFillGxy);
        cplot.DSOColorFillGxyCl :=
          ReadBool(section, 'DSOColorFillGxyCl', cplot.DSOColorFillGxyCl);
        cplot.DSOColorFillQ := ReadBool(section, 'DSOColorFillQ', cplot.DSOColorFillQ);
        cplot.DSOColorFillGL :=
          ReadBool(section, 'DSOColorFillGL', cplot.DSOColorFillGL);
        cplot.DSOColorFillNE :=
          ReadBool(section, 'DSOColorFillNE', cplot.DSOColorFillNE);
        for i := 0 to maxcolor do
          cplot.color[i] := ReadInteger(section, 'color' + IntToStr(i), cplot.color[i]);
        for i := 0 to 7 do
          cplot.skycolor[i] :=
            ReadInteger(section, 'skycolor' + IntToStr(i), cplot.skycolor[i]);
        cplot.bgColor := ReadInteger(section, 'bgColor', cplot.bgColor);
      except
        ShowError('Error reading ' + filename + ' display');
      end;
      try
        section := 'grid';
        catalog.cfgshr.ShowCRose :=
          ReadBool(section, 'ShowCRose', catalog.cfgshr.ShowCRose);
        catalog.cfgshr.SimplePointer :=
          ReadBool(section, 'SimplePointer', catalog.cfgshr.SimplePointer);
        catalog.cfgshr.CRoseSz :=
          ReadInteger(section, 'CRoseSz', catalog.cfgshr.CRoseSz);
        for i := 0 to maxfield do
          catalog.cfgshr.HourGridSpacing[i] :=
            ReadFloat(section, 'HourGridSpacing' + IntToStr(i),
            catalog.cfgshr.HourGridSpacing[i]);
        for i := 0 to maxfield do
        begin
          catalog.cfgshr.DegreeGridSpacing[i] :=
            ReadFloat(section, 'DegreeGridSpacing' + IntToStr(i),
            catalog.cfgshr.DegreeGridSpacing[i]);
          if catalog.cfgshr.DegreeGridSpacing[i] > 1000 then
            catalog.cfgshr.DegreeGridSpacing[i] :=
              catalog.cfgshr.DegreeGridSpacing[i] - 1000;
        end;
      except
        ShowError('Error reading ' + filename + ' grid');
      end;
      try

        section := 'Calendar';
        csc.CalGraphHeight := ReadInteger(section, 'CalGraphHeight', csc.CalGraphHeight);
        ;

        section := 'Finder';
        csc.ShowCircle := ReadBool(section, 'ShowCircle', csc.ShowCircle);
        csc.ShowCrosshair := ReadBool(section, 'ShowCrosshair', csc.ShowCrosshair);
        csc.EyepieceMask := ReadBool(section, 'EyepieceMask', csc.EyepieceMask);
        csc.CircleLabel := ReadBool(section, 'CircleLabel', csc.CircleLabel);
        csc.RectangleLabel := ReadBool(section, 'RectangleLabel', csc.RectangleLabel);
        csc.marknumlabel := ReadBool(section, 'marknumlabel', csc.marknumlabel);
        csc.ncircle := ReadInteger(section, 'ncircle', csc.ncircle);
        SetLength(csc.circle, csc.ncircle + 1);
        SetLength(csc.circleok, csc.ncircle + 1);
        SetLength(csc.circlelbl, csc.ncircle + 1);
        for i := 1 to csc.ncircle do
          csc.circle[i, 1] := ReadFloat(section, 'Circle' + IntToStr(i),
            csc.circle[i, 1]);
        for i := 1 to csc.ncircle do
          csc.circle[i, 2] := ReadFloat(section, 'CircleR' + IntToStr(i),
            csc.circle[i, 2]);
        for i := 1 to csc.ncircle do
          csc.circle[i, 3] := ReadFloat(section, 'CircleOffset' +
            IntToStr(i), csc.circle[i, 3]);
        for i := 1 to csc.ncircle do
          csc.circleok[i] := ReadBool(section, 'ShowCircle' +
            IntToStr(i), csc.circleok[i]);
        for i := 1 to csc.ncircle do
          csc.circlelbl[i] := ReadString(section, 'CircleLbl' +
            IntToStr(i), csc.circlelbl[i]);
        csc.nrectangle := ReadInteger(section, 'nrectangle', csc.nrectangle);
        SetLength(csc.rectangle, csc.nrectangle + 1);
        SetLength(csc.rectangleok, csc.nrectangle + 1);
        SetLength(csc.rectanglelbl, csc.nrectangle + 1);
        for i := 1 to csc.nrectangle do
          csc.rectangle[i, 1] :=
            ReadFloat(section, 'RectangleW' + IntToStr(i), csc.rectangle[i, 1]);
        for i := 1 to csc.nrectangle do
          csc.rectangle[i, 2] :=
            ReadFloat(section, 'RectangleH' + IntToStr(i), csc.rectangle[i, 2]);
        for i := 1 to csc.nrectangle do
          csc.rectangle[i, 3] :=
            rmod(ReadFloat(section, 'RectangleR' + IntToStr(i), csc.rectangle[i, 3])+360,360);
        for i := 1 to csc.nrectangle do
          csc.rectangle[i, 4] :=
            ReadFloat(section, 'RectangleOffset' + IntToStr(i), csc.rectangle[i, 4]);
        for i := 1 to csc.nrectangle do
          csc.rectangleok[i] :=
            ReadBool(section, 'ShowRectangle' + IntToStr(i), csc.rectangleok[i]);
        for i := 1 to csc.nrectangle do
          csc.rectanglelbl[i] :=
            ReadString(section, 'RectangleLbl' + IntToStr(i), csc.rectanglelbl[i]);
      except
        ShowError('Error reading ' + filename + ' Finder');
      end;
      try
        section := 'chart';
        buf := ReadString(section, 'EquinoxChart', csc.EquinoxChart);
        buf0 := ReadString(section, 'ProjOptionsEquinoxChart0',csc.ProjOptions[0].EquinoxChart);
        buf1 := ReadString(section, 'ProjOptionsEquinoxChart1',csc.ProjOptions[1].EquinoxChart);
        buf2 := ReadString(section, 'ProjOptionsEquinoxChart2',csc.ProjOptions[2].EquinoxChart);
        buf3 := ReadString(section, 'ProjOptionsEquinoxChart3',csc.ProjOptions[3].EquinoxChart);
        if (buf<>'')and(buf0<>'')and(buf1<>'')and(buf2<>'')and(buf3<>'') then begin
          csc.EquinoxChart := ReadString(section, 'EquinoxChart', csc.EquinoxChart);
          csc.EquinoxType := ReadInteger(section, 'EquinoxType', csc.EquinoxType);
          csc.DefaultJDchart := ReadFloat(section, 'DefaultJDchart', csc.DefaultJDchart);
          for i:=0 to 3 do
          begin
           csc.ProjOptions[i].EquinoxType := ReadInteger(section, 'ProjOptionsEquinoxType' + IntToStr(i), csc.ProjOptions[i].EquinoxType);
           csc.ProjOptions[i].ApparentPos := ReadBool(section, 'ProjOptionsApparentPos' + IntToStr(i), csc.ProjOptions[i].ApparentPos);
           csc.ProjOptions[i].PMon := ReadBool(section, 'ProjOptionsPMon' + IntToStr(i), csc.ProjOptions[i].PMon);
           csc.ProjOptions[i].YPmon := ReadFloat(section, 'ProjOptionsYPmon' + IntToStr(i), csc.ProjOptions[i].YPmon);
           csc.ProjOptions[i].EquinoxChart := ReadString(section, 'ProjOptionsEquinoxChart' + IntToStr(i), csc.ProjOptions[i].EquinoxChart);
           csc.ProjOptions[i].DefaultJDChart := ReadFloat(section, 'ProjOptionsDefaultJDChart' + IntToStr(i), csc.ProjOptions[i].DefaultJDChart);
           csc.ProjOptions[i].CoordExpertMode := ReadBool(section, 'ProjOptionsCoordExpertMode' + IntToStr(i), csc.ProjOptions[i].CoordExpertMode);
           csc.ProjOptions[i].CoordType := ReadInteger(section, 'ProjOptionsCoordType' + IntToStr(i), csc.ProjOptions[i].CoordType);
          end;
        end
        else begin
          // in case of wrong expert mode setting
          for i:=0 to 3 do
          if i=1 then begin
            csc.ProjOptions[i].EquinoxType := 2;
            csc.ProjOptions[i].ApparentPos := True;
            csc.ProjOptions[i].PMon := True;
            csc.ProjOptions[i].YPmon := 0;
            csc.ProjOptions[i].EquinoxChart := rsDate;
            csc.ProjOptions[i].DefaultJDChart := jd2000;
            csc.ProjOptions[i].CoordExpertMode := False;
            csc.ProjOptions[i].CoordType := 0;
          end
          else begin
            csc.ProjOptions[i].EquinoxType := def_cfgsc.EquinoxType;
            csc.ProjOptions[i].ApparentPos := def_cfgsc.ApparentPos ;
            csc.ProjOptions[i].PMon := def_cfgsc.PMon ;
            csc.ProjOptions[i].YPmon := def_cfgsc.YPmon ;
            csc.ProjOptions[i].EquinoxChart := def_cfgsc.EquinoxChart ;
            csc.ProjOptions[i].DefaultJDChart := def_cfgsc.DefaultJDChart ;
            csc.ProjOptions[i].CoordExpertMode := def_cfgsc.CoordExpertMode ;
            csc.ProjOptions[i].CoordType := def_cfgsc.CoordType ;
          end;
        end;
      except
        ShowError('Error reading ' + filename + ' chart');
      end;
      try
        section := 'default_chart';
        csc.winx := ReadInteger(section, 'ChartWidth', csc.xmax);
        csc.winy := ReadInteger(section, 'ChartHeight', csc.ymax);
        csc.wintop := ReadInteger(section, 'ChartTop', 0);
        csc.winleft := ReadInteger(section, 'Chartleft', 0);
        cfgm.maximized := ReadBool(section, 'ChartMaximized', True);
        csc.racentre := ReadFloat(section, 'racentre', csc.racentre);
        csc.decentre := ReadFloat(section, 'decentre', csc.decentre);
        csc.acentre := ReadFloat(section, 'acentre', csc.acentre);
        csc.hcentre := ReadFloat(section, 'hcentre', csc.hcentre);
        csc.fov := round(ReadFloat(section, 'fov', csc.fov) / secarc) * secarc;
        // round to 1 arcsec
        csc.fov := max(csc.fov, secarc);
        csc.fov := min(csc.fov, pi2);
        csc.theta := ReadFloat(section, 'theta', csc.theta);
        buf := trim(ReadString(section, 'projtype', csc.projtype)) + 'A';
        csc.projtype := buf[1];
        csc.ProjPole := ReadInteger(section, 'ProjPole', csc.ProjPole);
        csc.ProjEquatorCentered :=
          ReadBool(section, 'ProjEquatorCentered', csc.ProjEquatorCentered);
        csc.FlipX := ReadInteger(section, 'FlipX', csc.FlipX);
        csc.FlipY := ReadInteger(section, 'FlipY', csc.FlipY);
        if csc.FlipY < 0 then
          csc.FlipX := 1;
        csc.CoordExpertMode := ReadBool(section, 'CoordExpertMode', csc.CoordExpertMode);
        csc.PMon := ReadBool(section, 'PMon', csc.PMon);
        csc.YPMon := ReadFloat(section, 'YPMon', csc.YPMon);
        csc.DrawPMon := ReadBool(section, 'DrawPMon', csc.DrawPMon);
        csc.ApparentPos := ReadBool(section, 'ApparentPos', csc.ApparentPos);
        csc.CoordType := ReadInteger(section, 'CoordType', csc.CoordType);
        csc.DrawPMyear := ReadInteger(section, 'DrawPMyear', csc.DrawPMyear);
        csc.horizonopaque := ReadBool(section, 'horizonopaque', csc.horizonopaque);
        csc.MeridianWideLine := ReadBool(section, 'MeridianWideLine', csc.MeridianWideLine);
        csc.ShowHorizon := ReadBool(section, 'ShowHorizon', csc.ShowHorizon);
        csc.ShowHorizonPicture :=
          ReadBool(section, 'ShowHorizonPicture', csc.ShowHorizonPicture);
        csc.HorizonPictureLowQuality :=
          ReadBool(section, 'HorizonPictureLowQuality', csc.HorizonPictureLowQuality);
        csc.HorizonPictureRotate := ReadFloat(section, 'HorizonPictureRotate', csc.HorizonPictureRotate);
        csc.HorizonPictureElevation := ReadFloat(section, 'HorizonPictureElevation', csc.HorizonPictureElevation);
        csc.DarkenHorizonPicture := ReadBool(section, 'DarkenHorizonPicture', csc.DarkenHorizonPicture);
        csc.FillHorizon := ReadBool(section, 'FillHorizon', csc.FillHorizon);
        csc.ShowHorizonDepression :=
          ReadBool(section, 'ShowHorizonDepression', csc.ShowHorizonDepression);
        csc.ShowHorizon0 := ReadBool(section, 'ShowHorizon0', csc.ShowHorizon0);
        csc.horizonfile := ReadString(section, 'horizonfile', csc.horizonfile);
        csc.HorizonPictureFile := ReadString(section, 'HorizonPictureFile', csc.HorizonPictureFile);
        csc.ShowEqGrid := ReadBool(section, 'ShowEqGrid', csc.ShowEqGrid);
        csc.ShowLabelAll := ReadBool(section, 'ShowLabelAll', csc.ShowLabelAll);
        csc.EditLabels := ReadBool(section, 'EditLabels', csc.EditLabels);
        csc.OptimizeLabels := ReadBool(section, 'OptimizeLabels', csc.OptimizeLabels);
        csc.RotLabel := ReadBool(section, 'RotLabel', csc.RotLabel);
        csc.AltAzMark := ReadBool(section, 'AltAzMark', csc.AltAzMark);
        csc.HorizonRise:=ReadBool(section, 'HorizonRise', csc.HorizonRise);
        csc.AirmassMagnitude:=ReadBool(section, 'AirmassMagnitude', csc.AirmassMagnitude);
        csc.ShowGrid := ReadBool(section, 'ShowGrid', csc.ShowGrid);
        csc.ShowGridNum := ReadBool(section, 'ShowGridNum', csc.ShowGridNum);
        csc.CenterDecGridNum := ReadBool(section, 'CenterDecGridNum', csc.CenterDecGridNum);
        csc.ShowOnlyMeridian :=
          ReadBool(section, 'ShowOnlyMeridian', csc.ShowOnlyMeridian);
        csc.ShowAlwaysMeridian :=
          ReadBool(section, 'ShowAlwaysMeridian', csc.ShowAlwaysMeridian);
        csc.ShowConstL := ReadBool(section, 'ShowConstL', csc.ShowConstL);
        csc.ShowConstB := ReadBool(section, 'ShowConstB', csc.ShowConstB);
        csc.ShowEcliptic := ReadBool(section, 'ShowEcliptic', csc.ShowEcliptic);
        csc.ShowGalactic := ReadBool(section, 'ShowGalactic', csc.ShowGalactic);
        csc.ShowEquator  := ReadBool(section, 'ShowEquator', csc.ShowEquator);
        csc.ShowMilkyWay := ReadBool(section, 'ShowMilkyWay', csc.ShowMilkyWay);
        csc.FillMilkyWay := ReadBool(section, 'FillMilkyWay', csc.FillMilkyWay);
        csc.LinemodeMilkyway :=
          ReadBool(section, 'LinemodeMilkyway', csc.LinemodeMilkyway);
        csc.sunurlname := ReadString(section, 'URL_SUN_NAME', csc.sunurlname);
        csc.sunurl := ReadString(section, 'URL_SUN', csc.sunurl);
        csc.sunurlsize := ReadInteger(section, 'URL_SUN_SIZE', csc.sunurlsize);
        csc.sunurlmargin := ReadInteger(section, 'URL_SUN_MARGIN', csc.sunurlmargin);
        csc.sunrefreshtime := ReadInteger(section, 'SunRefreshTime', csc.sunrefreshtime);
        csc.SunOnline := ReadBool(section, 'SunOnline', csc.SunOnline);
        csc.ShowPluto := ReadBool(section, 'ShowPluto', csc.ShowPluto);
        csc.ShowPlanet := ReadBool(section, 'ShowPlanet', csc.ShowPlanet);
        csc.ShowSmallsat := ReadBool(section, 'ShowSmallsat', csc.ShowSmallsat);
        csc.ShowAsteroid := ReadBool(section, 'ShowAsteroid', csc.ShowAsteroid);
        csc.ShowComet := ReadBool(section, 'ShowComet', csc.ShowComet);
        csc.SPKlist.Clear;
        n := ReadInteger(section, 'SPKCount', 0);
        for i:=1 to n do
           csc.SPKlist.Add(ReadString(section, 'SPK'+inttostr(i), ''));
        csc.DSLsurface := ReadBool(section, 'DSLsurface', csc.DSLsurface);
        csc.DSLforcecolor := ReadBool(section, 'DSLforcecolor', csc.DSLforcecolor);
        csc.DSLcolor := ReadInteger(section, 'DSLcolor', csc.DSLcolor);
        csc.SurfaceBlure := ReadBool(section, 'SurfaceBlure', csc.SurfaceBlure);
        csc.SurfaceAlpha := ReadInteger(section, 'SurfaceAlpha', csc.SurfaceAlpha);
        csc.ShowImages := ReadBool(section, 'ShowImages', csc.ShowImages);
        csc.showstars := ReadBool(section, 'ShowStars', csc.showstars);
        csc.shownebulae := ReadBool(section, 'ShowNebulae', csc.shownebulae);
        csc.showline := ReadBool(section, 'ShowLine', csc.showline);
        csc.ShowImageList := ReadBool(section, 'ShowImageList', csc.ShowImageList);
        csc.ShowImageLabel := ReadBool(section, 'ShowImageLabel', csc.ShowImageLabel);
        csc.ShowBackgroundImage :=
          ReadBool(section, 'ShowBackgroundImage', csc.ShowBackgroundImage);
        buf := ReadString(section, 'BackgroundImage', csc.BackgroundImage);
        if (ConfigPrivateDir = '') or (ConfigPrivateDir = PrivateDir) or
          (pos(ConfigPrivateDir, buf) = 0) then
          csc.BackgroundImage := buf
        else
        begin
          buf := ExtractSubPath(slash(ConfigPrivateDir), buf);
          csc.BackgroundImage := slash(PrivateDir) + buf;
        end;
        csc.AstSymbol := ReadInteger(section, 'AstSymbol', csc.AstSymbol);
        csc.AstmagMax := ReadFloat(section, 'AstmagMax', csc.AstmagMax);
        csc.AstmagDiff := ReadFloat(section, 'AstmagDiff', csc.AstmagDiff);
        DefAstMagDiff := csc.AstmagDiff;
        csc.AstNEO := ReadBool(section, 'AstNEO', csc.AstNEO);
        csc.ComSymbol := ReadInteger(section, 'ComSymbol', csc.ComSymbol);
        csc.CommagMax := ReadFloat(section, 'CommagMax', csc.CommagMax);
        csc.CommagDiff := ReadFloat(section, 'CommagDiff', csc.CommagDiff);
        DefComMagDiff := csc.Commagdiff;
        csc.MagLabel := ReadBool(section, 'MagLabel', csc.MagLabel);
        csc.NameLabel := ReadBool(section, 'NameLabel', csc.NameLabel);
        csc.DistLabel := ReadBool(section, 'DistLabel', csc.DistLabel);
        csc.DrawAllStarLabel := ReadBool(section, 'DrawAllStarLabel', csc.DrawAllStarLabel);
        csc.MagNoDecimal := ReadBool(section, 'MagNoDecimal', csc.MagNoDecimal);
        csc.MovedLabelLine := ReadBool(section, 'MovedLabelLine', csc.MovedLabelLine);
        csc.ConstFullLabel := ReadBool(section, 'ConstFullLabel', csc.ConstFullLabel);
        csc.ConstLatinLabel := ReadBool(section, 'ConstLatinLabel', csc.ConstLatinLabel);
        csc.PlanetParalaxe := ReadBool(section, 'PlanetParalaxe', csc.PlanetParalaxe);
        csc.ShowEarthShadow := ReadBool(section, 'ShowEarthShadow', csc.ShowEarthShadow);
        csc.EarthShadowForceLine := ReadBool(section, 'EarthShadowForceLine', csc.EarthShadowForceLine);
        csc.GRSlongitude := ReadFloat(section, 'GRSlongitude', csc.GRSlongitude);
        csc.GRSjd := ReadFloat(section, 'GRSjd', csc.GRSjd);
        csc.GRSdrift := ReadFloat(section, 'GRSdrift', csc.GRSdrift);
        csc.StyleGrid := TPenStyle(ReadInteger(section, 'StyleGrid', Ord(csc.StyleGrid)));
        csc.StyleEqGrid := TPenStyle(ReadInteger(section, 'StyleEqGrid', Ord(csc.StyleEqGrid)));
        csc.StyleConstL := TPenStyle(ReadInteger(section, 'StyleConstL', Ord(csc.StyleConstL)));
        csc.StyleConstB := TPenStyle(ReadInteger(section, 'StyleConstB', Ord(csc.StyleConstB)));
        csc.StyleEcliptic := TPenStyle(ReadInteger(section, 'StyleEcliptic', Ord(csc.StyleEcliptic)));
        csc.StyleGalEq := TPenStyle(ReadInteger(section, 'StyleGalEq', Ord(csc.StyleGalEq)));
        csc.LineWidthGrid := ReadInteger(section, 'LineWidthGrid', 0);
        csc.LineWidthEqGrid := ReadInteger(section, 'LineWidthEqGrid', 0);
        csc.LineWidthConstL := ReadInteger(section, 'LineWidthConstL', 1);
        csc.LineWidthConstB := ReadInteger(section, 'LineWidthConstB', 1);
        csc.LineWidthEcliptic := ReadInteger(section, 'LineWidthEcliptic', 1);
        csc.LineWidthGalEq := ReadInteger(section, 'LineWidthGalEq', 1);
        csc.BGalpha := ReadInteger(section, 'BGalpha', csc.BGalpha);
        csc.BGitt := Titt(ReadInteger(section, 'BGitt', Ord(csc.BGitt)));
        csc.BGmin_sigma := ReadFloat(section, 'BGmin_sigma', csc.BGmin_sigma);
        csc.BGmax_sigma := ReadFloat(section, 'BGmax_sigma', csc.BGmax_sigma);
        csc.NEBmin_sigma := ReadFloat(section, 'NEBmin_sigma', csc.NEBmin_sigma);
        csc.NEBmax_sigma := ReadFloat(section, 'NEBmax_sigma', csc.NEBmax_sigma);
        csc.MaxArchiveImg := ReadInteger(section, 'MaxArchiveImg', csc.MaxArchiveImg);
        for i := 1 to MaxArchiveDir do
          csc.ArchiveDir[i] :=
            ReadString(section, 'ArchiveDir' + IntToStr(i), csc.ArchiveDir[i]);
        for i := 1 to MaxArchiveDir do
          csc.ArchiveDirActive[i] :=
            ReadBool(section, 'ArchiveDirActive' + IntToStr(i),
            csc.ArchiveDirActive[i]);
        csc.Simnb := ReadInteger(section, 'Simnb', csc.Simnb);
        csc.SimLabel := ReadInteger(section, 'SimLabel', csc.SimLabel);
        if csc.SimLabel > 3 then
          csc.SimLabel := 3;
        csc.SimNameLabel := ReadBool(section, 'SimNameLabel', csc.SimNameLabel);
        csc.SimDateLabel := ReadBool(section, 'SimDateLabel', csc.SimDateLabel);
        csc.SimDateYear := ReadBool(section, 'SimDateYear', csc.SimDateYear);
        csc.SimDateMonth := ReadBool(section, 'SimDateMonth', csc.SimDateMonth);
        csc.SimDateDay := ReadBool(section, 'SimDateDay', csc.SimDateDay);
        csc.SimDateHour := ReadBool(section, 'SimDateHour', csc.SimDateHour);
        csc.SimDateMinute := ReadBool(section, 'SimDateMinute', csc.SimDateMinute);
        csc.SimDateSecond := ReadBool(section, 'SimDateSecond', csc.SimDateSecond);
        csc.SimMagLabel := ReadBool(section, 'SimMagLabel', csc.SimMagLabel);
        csc.ShowLegend := ReadBool(section, 'ShowLegend', csc.ShowLegend);
        csc.SimD := ReadInteger(section, 'SimD', csc.SimD);
        csc.SimH := ReadInteger(section, 'SimH', csc.SimH);
        csc.SimM := ReadInteger(section, 'SimM', csc.SimM);
        csc.SimS := ReadInteger(section, 'SimS', csc.SimS);
        csc.SimLine := ReadBool(section, 'SimLine', csc.SimLine);
        csc.SimMark := ReadBool(section, 'SimMark', csc.SimMark);
        csc.SimAsteroid := ReadInteger(section, 'SimAsteroid', csc.SimAsteroid);
        csc.SimBody := ReadInteger(section, 'SimBody', csc.SimBody);
        csc.SimComet := ReadString(section, 'SimComet', csc.SimComet);
        csc.SimAsteroidName := ReadString(section, 'SimAsteroidName', csc.SimAsteroidName);
        csc.SimCometName := ReadString(section, 'SimCometName', csc.SimCometName);
        for i := 1 to NumSimObject do
          csc.SimObject[i] := ReadBool(section, 'SimObject' +
            IntToStr(i), csc.SimObject[i]);
        for i := 1 to numlabtype do
        begin
          csc.ShowLabel[i] := readBool(section, 'ShowLabel' +
            IntToStr(i), csc.ShowLabel[i]);
          csc.LabelMagDiff[i] :=
            readFloat(section, 'LabelMag' + IntToStr(i), csc.LabelMagDiff[i]);
          csc.LabelOrient[i] :=
            readFloat(section, 'LabelOrient' + IntToStr(i), csc.LabelOrient[i]);
        end;
        csc.ObslistAlLabels := ReadBool(section, 'ObslistAlLabels', csc.ObslistAlLabels);
        csc.TrackOn := ReadBool(section, 'TrackOn', csc.TrackOn);
        csc.TrackType := ReadInteger(section, 'TrackType', csc.TrackType);
        csc.TrackObj := ReadInteger(section, 'TrackObj', csc.TrackObj);
        csc.TrackDec := ReadFloat(section, 'TrackDec', csc.TrackDec);
        csc.TrackRA := ReadFloat(section, 'TrackRA', csc.TrackRA);
        csc.TrackEpoch := ReadFloat(section, 'TrackEpoch', csc.TrackEpoch);
        csc.TrackName := ReadString(section, 'TrackName', csc.TrackName);
        if (csc.TrackName = rsTelescope) then csc.TrackOn:=false;
      except
        ShowError('Error reading ' + filename + ' default chart');
      end;
      try
        section := 'observatory';
        csc.ObsLatitude := ReadFloat(section, 'ObsLatitude', csc.ObsLatitude);
        csc.ObsLongitude := ReadFloat(section, 'ObsLongitude', csc.ObsLongitude);
        csc.ObsAltitude := ReadFloat(section, 'ObsAltitude', csc.ObsAltitude);
        csc.ObsRH := ReadFloat(section, 'ObsRH', csc.ObsRH);
        csc.ObsTlr := ReadFloat(section, 'ObsTlr', csc.ObsTlr);
        csc.ObsTemperature := ReadFloat(section, 'ObsTemperature', csc.ObsTemperature);
        csc.ObsPressure := ReadFloat(section, 'ObsPressure', csc.ObsPressure);
        csc.ObsName := Condutf8decode(ReadString(section, 'ObsName', csc.ObsName));
        csc.ObsCountry := ReadString(section, 'ObsCountry', csc.ObsCountry);
        csc.ObsTZ := ReadString(section, 'ObsTZ', csc.ObsTZ);
        csc.countrytz := ReadBool(section, 'countrytz', csc.countrytz);
        csc.tz.Longitude:=csc.ObsLongitude;
      except
        ShowError('Error reading ' + filename + ' observatory');
      end;
      try
        section := 'date';
        csc.UseSystemTime := ReadBool(section, 'UseSystemTime', csc.UseSystemTime);
        csc.CurYear := ReadInteger(section, 'CurYear', csc.CurYear);
        csc.CurMonth := ReadInteger(section, 'CurMonth', csc.CurMonth);
        csc.CurDay := ReadInteger(section, 'CurDay', csc.CurDay);
        csc.CurTime := ReadFloat(section, 'CurTime', csc.CurTime);
        csc.autorefresh := ReadBool(section, 'autorefresh', csc.autorefresh);
        csc.Force_DT_UT := ReadBool(section, 'Force_DT_UT', csc.Force_DT_UT);
        csc.DT_UT_val := ReadFloat(section, 'DT_UT_val', csc.DT_UT_val);
      except
        ShowError('Error reading ' + filename + ' date');
      end;
      try
        section := 'projection';
        for i := 1 to maxfield do
          csc.projname[i] := ReadString(section, 'ProjName' +
            IntToStr(i), csc.projname[i]);
      except
        ShowError('Error reading ' + filename + ' projection');
      end;
      try
        section := 'labels';
        csc.posmodlabels := ReadInteger(section, 'poslabels', 0);
        csc.nummodlabels := ReadInteger(section, 'numlabels', 0);
        for i := 1 to csc.nummodlabels do
        begin
          csc.modlabels[i].id := ReadInteger(section, 'labelid' + IntToStr(i), 0);
          csc.modlabels[i].dx := ReadInteger(section, 'labeldx' + IntToStr(i), 0);
          csc.modlabels[i].dy := ReadInteger(section, 'labeldy' + IntToStr(i), 0);
          csc.modlabels[i].orientation :=
            ReadFloat(section, 'orientation' + IntToStr(i), 0);
          csc.modlabels[i].ra := ReadFloat(section, 'labelra' + IntToStr(i), 0);
          csc.modlabels[i].Dec := ReadFloat(section, 'labeldec' + IntToStr(i), 0);
          csc.modlabels[i].labelnum := ReadInteger(section, 'labelnum' + IntToStr(i), 1);
          csc.modlabels[i].fontnum := ReadInteger(section, 'labelfont' + IntToStr(i), 2);
          csc.modlabels[i].txt := ReadString(section, 'labeltxt' + IntToStr(i), '');
          csc.modlabels[i].align :=
            TLabelAlign(ReadInteger(section, 'labelalign' + IntToStr(i), Ord(laLeft)));
          csc.modlabels[i].useradec :=
            ReadBool(section, 'labeluseradec' + IntToStr(i), False);
          csc.modlabels[i].hiden := ReadBool(section, 'labelhiden' + IntToStr(i), False);
        end;
      except
        ShowError('Error reading ' + filename + ' labels');
      end;
      try
        section := 'custom_labels';
        csc.poscustomlabels := ReadInteger(section, 'poslabels', 0);
        csc.numcustomlabels := ReadInteger(section, 'numlabels', 0);
        for i := 1 to csc.numcustomlabels do
        begin
          csc.customlabels[i].ra := ReadFloat(section, 'labelra' + IntToStr(i), 0);
          csc.customlabels[i].Dec := ReadFloat(section, 'labeldec' + IntToStr(i), 0);
          csc.customlabels[i].labelnum :=
            ReadInteger(section, 'labelnum' + IntToStr(i), 7);
          csc.customlabels[i].txt := ReadString(section, 'labeltxt' + IntToStr(i), '');
          csc.customlabels[i].align :=
            TLabelAlign(ReadInteger(section, 'labelalign' + IntToStr(i), Ord(laLeft)));
        end;
      except
        ShowError('Error reading ' + filename + ' custom_labels');
      end;
    end;
    try
      csc.tz.TimeZoneFile := ZoneDir + StringReplace(csc.ObsTZ,
        '/', PathDelim, [rfReplaceAll]);
      csc.tz.JD := jd(csc.CurYear, csc.CurMonth, csc.CurDay, csc.CurTime);
      csc.TimeZone := csc.tz.SecondsOffset / 3600;
      if not csc.CoordExpertMode then
      begin
        case csc.CoordType of
          0:
          begin
            csc.EquinoxType := 2;
            csc.ApparentPos := True;
            csc.PMon := True;
            csc.YPmon := 0;
            csc.EquinoxChart := rsDate;
            csc.DefaultJDChart := jd2000;
          end;
          1:
          begin
            csc.EquinoxType := 2;
            csc.ApparentPos := False;
            csc.PMon := True;
            csc.YPmon := 0;
            csc.EquinoxChart := rsDate;
            csc.DefaultJDChart := jd2000;
          end;
          2:
          begin
            csc.EquinoxType := 0;
            csc.ApparentPos := False;
            csc.PMon := True;
            csc.YPmon := 2000;
            csc.EquinoxChart := 'J2000';
            csc.DefaultJDChart := jd2000;
          end;
          3:
          begin
            csc.EquinoxType := 0;
            csc.ApparentPos := False;
            csc.PMon := True;
            csc.YPmon := 0;
            csc.EquinoxChart := 'J2000';
            csc.DefaultJDChart := jd2000;
          end;
        end;
      end;
    except
      ShowError('Error reading ' + filename + ' coordinates initialization');
    end;
  finally
    inif.Free;
  end;
end;

procedure Tf_main.ReadPrivateConfig(filename: string);
var
  i, j: integer;
  inif: TMemIniFile;
  section, buf: string;
  obsdetail: TObsDetail;
  ok: boolean;
begin
  inif := TMeminifile.Create(filename);
  try
    with inif do
    begin
      section := 'main';
      try
        Config_Version := ReadString(section, 'version', cdcver);
        SaveConfigOnExit.Checked :=
          ReadBool(section, 'SaveConfigOnExit', SaveConfigOnExit.Checked);
        ConfirmSaveConfig := ReadBool(section, 'ConfirmSaveConfig', ConfirmSaveConfig);
{$if defined(linux) or defined(freebsd)}
        LinuxDesktop := ReadInteger(section, 'LinuxDesktop', LinuxDesktop);
        if LinuxDesktop > 1 then
          LinuxDesktop := 1;
        OpenFileCMD := ReadString(section, 'OpenFileCMD', OpenFileCMD);
{$endif}
        NoMenu := ReadBool(section, 'NoMenu', false);
        cfgm.btnsize := ReadInteger(section, 'BtnSize', cfgm.btnsize);
        cfgm.btncaption := ReadBool(section, 'BtnCaption', cfgm.btncaption);
        NightVision := ReadBool(section, 'NightVision', NightVision);
        cfgm.ClockColor := ReadInteger(section, 'ClockColor', cfgm.ClockColor);
        cfgm.SesameUrlNum := ReadInteger(section, 'SesameUrlNum', cfgm.SesameUrlNum);
        cfgm.SesameCatNum := ReadInteger(section, 'SesameCatNum', cfgm.SesameCatNum);
        cfgm.prtname := ReadString(section, 'prtname', cfgm.prtname);
        cfgm.Paper := ReadInteger(section, 'Paper', cfgm.Paper);
        cfgm.PrinterResolution :=
          ReadInteger(section, 'PrinterResolution', cfgm.PrinterResolution);
        cfgm.PrintColor := ReadInteger(section, 'PrintColor', cfgm.PrintColor);
        cfgm.PrintBmpWidth := ReadInteger(section, 'PrintBmpWidth', cfgm.PrintBmpWidth);
        cfgm.PrintBmpHeight :=
          ReadInteger(section, 'PrintBmpHeight', cfgm.PrintBmpHeight);
        cfgm.PrintLandscape := ReadBool(section, 'PrintLandscape', cfgm.PrintLandscape);
        cfgm.PrintMethod := ReadInteger(section, 'PrintMethod', cfgm.PrintMethod);
        cfgm.PrintCmd1 := ReadString(section, 'PrintCmd1', cfgm.PrintCmd1);
        cfgm.PrintCmd2 := ReadString(section, 'PrintCmd2', cfgm.PrintCmd2);
        cfgm.PrintTmpPath := ReadString(section, 'PrintTmpPath', cfgm.PrintTmpPath);
        ;
        cfgm.PrtLeftMargin := ReadInteger(section, 'PrtLeftMargin', cfgm.PrtLeftMargin);
        cfgm.PrtRightMargin :=
          ReadInteger(section, 'PrtRightMargin', cfgm.PrtRightMargin);
        cfgm.PrtTopMargin := ReadInteger(section, 'PrtTopMargin', cfgm.PrtTopMargin);
        cfgm.PrtBottomMargin :=
          ReadInteger(section, 'PrtBottomMargin', cfgm.PrtBottomMargin);
        cfgm.PrintHeader := ReadBool(section, 'PrintHeader', cfgm.PrintHeader);
        cfgm.PrintFooter := ReadBool(section, 'PrintFooter', cfgm.PrintFooter);
        cfgm.ThemeName := ReadString(section, 'Theme', cfgm.ThemeName);
        cfgm.NightColor := ReadInteger(section, 'NightColor', cfgm.NightColor);
        cfgm.KioskPass := ReadString(section, 'KioskPass', '');
        cfgm.KioskDebug := ReadBool(section, 'KioskDebug', False);
        cfgm.KioskMode := (cfgm.KioskPass > '');
        cfgm.SimpleDetail := cfgm.KioskMode;
        cfgm.SimpleDetail := ReadBool(section, 'SimpleDetail', cfgm.SimpleDetail);
        cfgm.SimpleMove := cfgm.SimpleDetail or ReadBool(section,
          'SimpleMove', cfgm.SimpleMove);
        cfgm.CenterAtNoon := ReadBool(section, 'CenterAtNoon', cfgm.CenterAtNoon);
        InitMaximized:=ReadBool(section, 'WinMaximize', False);
        cfgm.autorefreshdelay := ReadInteger(section, 'autorefreshdelay', cfgm.autorefreshdelay);
        buf := ReadString(section, 'ConstLfile', cfgm.ConstLfile);
        buf := ExtractSubPath(ConfigAppdir, buf);
        buf := StringReplace(buf,'Tirion-Constellations.cln','TirionConstL.cln',[]);
        if FileExists(buf) then
          cfgm.ConstLfile := buf;
        buf := ReadString(section, 'ConstBfile', cfgm.ConstBfile);
        buf := ExtractSubPath(ConfigAppdir, buf);
        if FileExists(buf) then
          cfgm.ConstBfile := buf;
        buf := ReadString(section, 'EarthMapFile', cfgm.EarthMapFile);
        buf := ExtractSubPath(ConfigAppdir, buf);
        if FileExists(buf) then
          cfgm.EarthMapFile := buf;
        buf := ReadString(section, 'PlanetDir', cfgm.PlanetDir);
        buf := ExtractSubPath(ConfigAppdir, buf);
        if DirectoryExists(buf) then
          cfgm.PlanetDir := buf;
        cfgm.ServerIPaddr := ReadString(section, 'ServerIPaddr', cfgm.ServerIPaddr);
        cfgm.ServerIPport := ReadString(section, 'ServerIPport', cfgm.ServerIPport);
        cfgm.TextOnlyDetail := ReadBool(section, 'TextOnlyDetail', cfgm.TextOnlyDetail);
        cfgm.AutostartServer :=
          ReadBool(section, 'AutostartServer', cfgm.AutostartServer);
        cfgm.ServerCoordSys :=
          ReadInteger(section, 'ServerCoordSys', cfgm.ServerCoordSys);
        ServerCoordSystem:=TServerCoordSys(cfgm.ServerCoordSys);
        buf := ReadString(section, 'db', cfgm.db);
        if (ConfigPrivateDir = '') or (ConfigPrivateDir = PrivateDir) or
          (pos(ConfigPrivateDir, buf) = 0) then
          cfgm.db := buf
        else
        begin
          buf := ExtractSubPath(slash(ConfigPrivateDir), buf);
          cfgm.db := slash(PrivateDir) + buf;
        end;
        buf := ReadString(section, 'ImagePath', cfgm.ImagePath);
        buf := ExtractSubPath(ConfigAppdir, buf);
        if DirectoryExists(buf) then
          cfgm.ImagePath := buf;
        cfgm.ShowChartInfo := ReadBool(section, 'ShowChartInfo', cfgm.ShowChartInfo);
        cfgm.ShowTitlePos := ReadBool(section, 'ShowTitlePos', cfgm.ShowTitlePos);
        cfgm.SyncChart := ReadBool(section, 'SyncChart', cfgm.SyncChart);
        cfgm.VOurl := ReadInteger(section, 'VOurl', cfgm.VOurl);
        cfgm.VOmaxrecord := ReadInteger(section, 'VOmaxrecord', cfgm.VOmaxrecord);
        cfgm.SampAutoconnect :=
          ReadBool(section, 'SampAutoconnect', cfgm.SampAutoconnect);
        cfgm.SampKeepTables := ReadBool(section, 'SampKeepTables', cfgm.SampKeepTables);
        cfgm.SampKeepImages := ReadBool(section, 'SampKeepImages', cfgm.SampKeepImages);
        cfgm.SampConfirmCoord :=
          ReadBool(section, 'SampConfirmCoord', cfgm.SampConfirmCoord);
        cfgm.SampConfirmImage :=
          ReadBool(section, 'SampConfirmImage', cfgm.SampConfirmImage);
        cfgm.SampConfirmTable :=
          ReadBool(section, 'SampConfirmTable', cfgm.SampConfirmTable);
        cfgm.SampSubscribeCoord :=
          ReadBool(section, 'SampSubscribeCoord', cfgm.SampSubscribeCoord);
        cfgm.SampSubscribeImage :=
          ReadBool(section, 'SampSubscribeImage', cfgm.SampSubscribeImage);
        cfgm.SampSubscribeTable :=
          ReadBool(section, 'SampSubscribeTable', cfgm.SampSubscribeTable);
        cfgm.AnimDelay := ReadInteger(section, 'AnimDelay', cfgm.AnimDelay);
        AnimationTimer.Interval := max(100, cfgm.AnimDelay);
        cfgm.AnimFps := ReadFloat(section, 'AnimFps', cfgm.AnimFps);
        //cfgm.AnimRec:=ReadBool(section,'AnimRec',cfgm.AnimRec);
        cfgm.AnimRecDir := ReadString(section, 'AnimRecDir', cfgm.AnimRecDir);
        cfgm.AnimRecPrefix := ReadString(section, 'AnimRecPrefix', cfgm.AnimRecPrefix);
        cfgm.AnimRecExt := ReadString(section, 'AnimRecExt', cfgm.AnimRecExt);
        cfgm.Animffmpeg := ReadString(section, 'Animffmpeg', cfgm.Animffmpeg);
        cfgm.AnimSx := ReadInteger(section, 'AnimSx', cfgm.AnimSx);
        cfgm.AnimSy := ReadInteger(section, 'AnimSy', cfgm.AnimSy);
        cfgm.AnimSize := ReadInteger(section, 'AnimSize', cfgm.AnimSize);
        cfgm.AnimOpt := ReadString(section, 'AnimOpt', cfgm.AnimOpt);
        cfgm.HttpProxy := ReadBool(section, 'HttpProxy', cfgm.HttpProxy);
        cfgm.SocksProxy := ReadBool(section, 'SocksProxy', cfgm.SocksProxy);
        cfgm.SocksType := ReadString(section, 'SocksType', cfgm.SocksType);
        cfgm.FtpPassive := ReadBool(section, 'FtpPassive', cfgm.FtpPassive);
        cfgm.ConfirmDownload :=
          ReadBool(section, 'ConfirmDownload', cfgm.ConfirmDownload);
        cfgm.ProxyHost := ReadString(section, 'ProxyHost', cfgm.ProxyHost);
        cfgm.ProxyPort := ReadString(section, 'ProxyPort', cfgm.ProxyPort);
        cfgm.ProxyUser := ReadString(section, 'ProxyUser', cfgm.ProxyUser);
        cfgm.ProxyPass := ReadString(section, 'ProxyPass', cfgm.ProxyPass);
        cfgm.AnonPass := ReadString(section, 'AnonPass', cfgm.AnonPass);
        cfgm.starshape_file :=
          ReadString(section, 'starshape_file', cfgm.starshape_file);
        cfgm.tlelst := ReadString(section, 'tlelst', cfgm.tlelst);
        cfgm.HorizonNumDay := ReadInteger(section, 'HorizonNumDay', cfgm.HorizonNumDay);
        j := ReadInteger(section, 'CometUrlCount', 0);
        if (j > 0) then
        begin
          cfgm.CometUrlList.Clear;
          for i := 1 to j do
          begin
            buf:=ReadString(section, 'CometUrl' + IntToStr(i), '');
            if pos('minorplanetcenter',buf)>0 then
               buf:=StringReplace(buf,'http:','https:',[]);
            cfgm.CometUrlList.Add(buf);
          end;
        end;
        j := ReadInteger(section, 'AsteroidUrlCount', 0);
        if j > 0 then
        begin
          cfgm.AsteroidUrlList.Clear;
          for i := 1 to j do
          begin
            buf := ReadString(section, 'AsteroidUrl' + IntToStr(i), '');
            if pos('minorplanetcenter',buf)>0 then
               buf:=StringReplace(buf,'http:','https:',[]);
            cfgm.AsteroidUrlList.Add(buf);
          end;
        end;
        j := ReadInteger(section, 'TleUrlCount', 0);
        if (j > 0) then
        begin
          cfgm.TleUrlList.Clear;
          for i := 1 to j do
            buf:=ReadString(section, 'TleUrl' + IntToStr(i), '');
            if pos('qsmag.zip',buf)>0 then
              buf:=URL_QSMAG;
            cfgm.TleUrlList.Add(buf);
        end;
        j := ReadInteger(section, 'ObsNameListCount', 0);
        cfgm.ObsNameList.Clear;
        if j > 0 then
          for i := 0 to j - 1 do
          begin
            obsdetail := TObsDetail.Create;
            obsdetail.country := ReadString(section, 'ObsCountry' + IntToStr(i), '');
            obsdetail.countrytz := ReadBool(section, 'ObsCountryTZ' + IntToStr(i), True);
            obsdetail.tz := ReadString(section, 'ObsTZ' + IntToStr(i), '');
            obsdetail.lat := ReadFloat(section, 'ObsLat' + IntToStr(i), 0);
            obsdetail.lon := ReadFloat(section, 'ObsLon' + IntToStr(i), 0);
            obsdetail.alt := ReadFloat(section, 'ObsAlt' + IntToStr(i), 0);
            obsdetail.horizonfn := ReadString(section, 'Obshorizonfn' + IntToStr(i), '');
            obsdetail.horizonpictfn :=
              ReadString(section, 'Obshorizonpictfn' + IntToStr(i), '');
            obsdetail.pictureangleoffset :=
              ReadFloat(section, 'Obspictureangleoffset' + IntToStr(i), 0);
            obsdetail.showhorizonline :=
              ReadBool(section, 'Obsshowhorizonline' + IntToStr(i), False);
            obsdetail.showhorizonpicture :=
              ReadBool(section, 'Obsshowhorizonpicture' + IntToStr(i), False);
            cfgm.ObsNameList.AddObject(ReadString(section, 'ObsName' + IntToStr(i), ''),
              obsdetail);
          end;
        catalog.cfgshr.AzNorth := ReadBool(section, 'AzNorth', catalog.cfgshr.AzNorth);
        catalog.cfgshr.ListStar :=
          ReadBool(section, 'ListStar', catalog.cfgshr.ListStar);
        catalog.cfgshr.ListNeb := ReadBool(section, 'ListNeb', catalog.cfgshr.ListNeb);
        catalog.cfgshr.ListVar := ReadBool(section, 'ListVar', catalog.cfgshr.ListVar);
        catalog.cfgshr.ListDbl := ReadBool(section, 'ListDbl', catalog.cfgshr.ListDbl);
        catalog.cfgshr.ListPla := ReadBool(section, 'ListPla', catalog.cfgshr.ListPla);
        catalog.cfgshr.ffove_tfl :=
          ReadString(section, 'ffove_tfl', catalog.cfgshr.ffove_tfl);
        catalog.cfgshr.ffove_efl :=
          ReadString(section, 'ffove_efl', catalog.cfgshr.ffove_efl);
        catalog.cfgshr.ffove_efv :=
          ReadString(section, 'ffove_efv', catalog.cfgshr.ffove_efv);
        catalog.cfgshr.ffovc_tfl :=
          ReadString(section, 'ffovc_tfl', catalog.cfgshr.ffovc_tfl);
        catalog.cfgshr.ffovc_px :=
          ReadString(section, 'ffovc_px', catalog.cfgshr.ffovc_px);
        catalog.cfgshr.ffovc_py :=
          ReadString(section, 'ffovc_py', catalog.cfgshr.ffovc_py);
        catalog.cfgshr.ffovc_cx :=
          ReadString(section, 'ffovc_cx', catalog.cfgshr.ffovc_cx);
        catalog.cfgshr.ffovc_cy :=
          ReadString(section, 'ffovc_cy', catalog.cfgshr.ffovc_cy);
        def_cfgsc.AscomDevice := ReadString(section, 'AscomDevice', def_cfgsc.AscomDevice);
        def_cfgsc.TelescopeAltAz := ReadBool(section, 'TelescopeAltAz', def_cfgsc.TelescopeAltAz);
        def_cfgsc.TelescopeAutoconnect := ReadBool(section, 'TelescopeAutoconnect', def_cfgsc.TelescopeAutoconnect);
        def_cfgsc.TelescopeInterval := ReadInteger(section, 'TelescopeInterval', def_cfgsc.TelescopeInterval);
        def_cfgsc.TelescopeInterface := ReadInteger(section, 'TelescopeInterface', def_cfgsc.TelescopeInterface);
        def_cfgsc.AlpacaProtocol := ReadInteger(section, 'AlpacaProtocol', def_cfgsc.AlpacaProtocol);
        def_cfgsc.AlpacaId := ReadString(section, 'AlpacaId', def_cfgsc.AlpacaId);
        def_cfgsc.AlpacaHost := ReadString(section, 'AlpacaHost', def_cfgsc.AlpacaHost);
        def_cfgsc.AlpacaPort := ReadInteger(section, 'AlpacaPort', def_cfgsc.AlpacaPort);
        def_cfgsc.AlpacaUser := DecryptStr(hextostr(ReadString(section, 'AlpacaUser', '')), encryptpwd);
        def_cfgsc.AlpacaPass := DecryptStr(hextostr(ReadString(section, 'AlpacaPass', '')), encryptpwd);
        def_cfgsc.AlpacaDevice := ReadInteger(section, 'AlpacaDevice', def_cfgsc.AlpacaDevice);
        def_cfgsc.TelescopeLeft := ReadInteger(section, 'TelescopeLeft', def_cfgsc.TelescopeLeft);
        def_cfgsc.TelescopeTop := ReadInteger(section, 'TelescopeTop', def_cfgsc.TelescopeTop);
        def_cfgsc.IndiServerHost :=
          ReadString(section, 'IndiServerHost', def_cfgsc.IndiServerHost);
        def_cfgsc.IndiServerPort :=
          ReadString(section, 'IndiServerPort', def_cfgsc.IndiServerPort);
        def_cfgsc.IndiDevice := ReadString(section, 'IndiDevice', def_cfgsc.IndiDevice);
        def_cfgsc.ManualTelescope :=
          ReadBool(section, 'ManualTelescope', def_cfgsc.ManualTelescope);
        def_cfgsc.ManualTelescopeType :=
          ReadInteger(section, 'ManualTelescopeType', def_cfgsc.ManualTelescopeType);
        def_cfgsc.TelescopeTurnsX :=
          ReadFloat(section, 'TelescopeTurnsX', def_cfgsc.TelescopeTurnsX);
        def_cfgsc.TelescopeTurnsY :=
          ReadFloat(section, 'TelescopeTurnsY', def_cfgsc.TelescopeTurnsY);
        def_cfgsc.TelLimitDecMax := ReadFloat(section, 'TelLimitDecMax', def_cfgsc.TelLimitDecMax);
        def_cfgsc.TelLimitDecMin := ReadFloat(section, 'TelLimitDecMin', def_cfgsc.TelLimitDecMin);
        def_cfgsc.TelLimitHaE := ReadFloat(section, 'TelLimitHaE', def_cfgsc.TelLimitHaE);
        def_cfgsc.TelLimitHaW := ReadFloat(section, 'TelLimitHaW', def_cfgsc.TelLimitHaW);
        def_cfgsc.TelLimitDecMaxActive := ReadBool(section, 'TelLimitDecMaxActive', def_cfgsc.TelLimitDecMaxActive);
        def_cfgsc.TelLimitDecMinActive := ReadBool(section, 'TelLimitDecMinActive', def_cfgsc.TelLimitDecMinActive);
        def_cfgsc.TelLimitHaEActive := ReadBool(section, 'TelLimitHaEActive', def_cfgsc.TelLimitHaEActive);
        def_cfgsc.TelLimitHaWActive := ReadBool(section, 'TelLimitHaWActive', def_cfgsc.TelLimitHaWActive);
        PanelToolBarMain.Visible := ReadBool(section, 'ViewMainBar', True);
        PanelLeft.Visible := ReadBool(section, 'ViewLeftBar', True);
        PanelRight.Visible := ReadBool(section, 'ViewRightBar', True);
        ToolBarObj.Visible := ReadBool(section, 'ViewObjectBar', True);
        MenuViewScrollBar.Checked :=
          ReadBool(section, 'ViewScrollBar', True) and CanShowScrollbar;
        PanelBottom.Visible := ReadBool(section, 'ViewStatusBar', True);
        MenuViewStatusBar.Checked := PanelBottom.Visible;
        MenuViewMainBar.Checked := PanelToolBarMain.Visible;
        MenuViewObjectBar.Checked := ToolBarObj.Visible;
        MenuViewLeftBar.Checked := PanelLeft.Visible;
        MenuViewRightBar.Checked := PanelRight.Visible;
        MenuViewToolsBar.Checked :=
          (MenuViewMainBar.Checked and MenuViewObjectBar.Checked and
          MenuViewLeftBar.Checked and MenuViewRightBar.Checked);
        InitialChartNum := ReadInteger(section, 'NumChart', 0);
        f_detail.Width := ReadInteger(section, 'Detail_Width', f_detail.Width);
        f_detail.Height := ReadInteger(section, 'Detail_Height', f_detail.Height);
        ScriptPanel.Width := ReadInteger(section, 'ScriptWidth', ScriptPanel.Width);
        SaveScriptPanelWidth := ScriptPanel.Width;
        GregorianStart := ReadInteger(section, 'GregorianStart', GregorianStart);
        GregorianStartJD := ReadInteger(section, 'GregorianStartJD', GregorianStartJD);
      except
        ShowError('Error reading ' + filename + ' main');
      end;
      try
        section := 'catalog';
        for i := 1 to maxstarcatalog do
        begin
          buf := ReadString(section, 'starcatpath' + IntToStr(i),
            catalog.cfgcat.starcatpath[i]);
          buf := ExtractSubPath(slash(ConfigAppdir), buf);
          if DirectoryExists(buf) then
            catalog.cfgcat.starcatpath[i] := buf;
        end;
        for i := 1 to maxvarstarcatalog do
        begin
          buf := ReadString(section, 'varstarcatpath' + IntToStr(i),
            catalog.cfgcat.varstarcatpath[i]);
          buf := ExtractSubPath(slash(ConfigAppdir), buf);
          if DirectoryExists(buf) then
            catalog.cfgcat.varstarcatpath[i] := buf;
        end;
        for i := 1 to maxdblstarcatalog do
        begin
          buf := ReadString(section, 'dblstarcatpath' + IntToStr(i),
            catalog.cfgcat.dblstarcatpath[i]);
          buf := ExtractSubPath(slash(ConfigAppdir), buf);
          if DirectoryExists(buf) then
            catalog.cfgcat.dblstarcatpath[i] := buf;
        end;
        for i := 1 to maxnebcatalog do
        begin
          buf := ReadString(section, 'nebcatpath' + IntToStr(i),
            catalog.cfgcat.nebcatpath[i]);
          buf := ExtractSubPath(slash(ConfigAppdir), buf);
          if DirectoryExists(buf) then
            catalog.cfgcat.nebcatpath[i] := buf;
        end;
        // New leda catalog replace pgc
        if pos('leda', catalog.cfgcat.nebcatpath[pgc - BaseNeb]) <= 0 then
        begin
          buf := StringReplace(catalog.cfgcat.nebcatpath[pgc - BaseNeb],
            'pgc', 'leda', []);
          if FileExists(slash(buf) + 'pgc.hdr') then
            catalog.cfgcat.nebcatpath[pgc - BaseNeb] := buf;
        end;
      except
        ShowError('Error reading ' + filename + ' catalog');
      end;
      try
        section := 'dss';
        f_getdss.cfgdss.dssnorth := ReadBool(section, 'dssnorth', False);
        f_getdss.cfgdss.dsssouth := ReadBool(section, 'dsssouth', False);
        f_getdss.cfgdss.dss102 := ReadBool(section, 'dss102', False);
        f_getdss.cfgdss.dsssampling := ReadBool(section, 'dsssampling', True);
        f_getdss.cfgdss.dssplateprompt := ReadBool(section, 'dssplateprompt', True);
        f_getdss.cfgdss.dssarchive := ReadBool(section, 'dssarchive', False);
        f_getdss.cfgdss.dssarchiveprompt := ReadBool(section, 'dssarchiveprompt', True);
        f_getdss.cfgdss.dssarchivedir :=
          ReadString(section, 'dssarchivedir', ArchiveDir);
        f_getdss.cfgdss.dssmaxsize := ReadInteger(section, 'dssmaxsize', 2048);
        f_getdss.cfgdss.dssdir :=
          ReadString(section, 'dssdir', slash('cat') + 'RealSky');
        f_getdss.cfgdss.dssdrive := ReadString(section, 'dssdrive', default_dssdrive);
        f_getdss.cfgdss.dssfile := slash(PictureDir) + '$temp.fit';
        for i := 1 to MaxDSSurl do
        begin
          f_getdss.cfgdss.DSSurl[i, 0] :=
            ReadString(section, 'DSSurlName' + IntToStr(i),
            f_getdss.cfgdss.DSSurl[i, 0]);
          f_getdss.cfgdss.DSSurl[i, 1] :=
            ReadString(section, 'DSSurl' + IntToStr(i), f_getdss.cfgdss.DSSurl[i, 1]);
        end;
        f_getdss.cfgdss.OnlineDSS :=
          ReadBool(section, 'OnlineDSS', f_getdss.cfgdss.OnlineDSS);
        f_getdss.cfgdss.OnlineDSSid :=
          ReadInteger(section, 'OnlineDSSid', f_getdss.cfgdss.OnlineDSSid);
        section := 'jpleph';
        nJPL_DE := ReadInteger(section, 'num', 0);
        if nJPL_DE > 0 then
        begin
          SetLength(JPL_DE, nJPL_DE + 1);
          for i := 1 to nJPL_DE do
            JPL_DE[i] := ReadInteger(section, 'JPL_DE' + IntToStr(i), 0);
        end
        else
        begin
          nJPL_DE := DefaultnJPL_DE;
          SetLength(JPL_DE, nJPL_DE + 1);
          for i := 1 to nJPL_DE do
            JPL_DE[i] := DefaultJPL_DE[i];
        end;
        section := 'obslist';
        cfgm.InitObsList := ReadString(section, 'listname', '');
        cfgm.ObslistAirmass :=
          ReadString(section, 'airmass', f_obslist.AirmassCombo.Text);
        cfgm.ObslistAirmassLimit1 :=
          ReadBool(section, 'airmasslimit1', f_obslist.LimitAirmassTonight.Checked);
        cfgm.ObslistAirmassLimit2 :=
          ReadBool(section, 'airmasslimit2', f_obslist.LimitAirmassNow.Checked);
        cfgm.ObslistHourAngle :=
          ReadString(section, 'hourangle', f_obslist.HourAngleCombo.Text);
        cfgm.ObslistHourAngleLimit1 :=
          ReadBool(section, 'houranglelimit1', f_obslist.LimitHourangleTonight.Checked);
        cfgm.ObslistHourAngleLimit2 :=
          ReadBool(section, 'houranglelimit2', f_obslist.LimitHourangleNow.Checked);
        cfgm.ObsListLimitType := ReadInteger(section, 'limittype', f_obslist.LimitType);
        cfgm.ObsListMeridianSide :=
          ReadInteger(section, 'meridianside', f_obslist.MeridianSide);
      except
        ShowError('Error reading ' + filename + ' dss');
      end;
      try
        section := 'quicksearch';
        j := min(MaxQuickSearch, ReadInteger(section, 'count', 0));
        for i := 1 to j do
          quicksearch.Items.Add(ReadString(section, 'item' + IntToStr(i), ''));
      except
        ShowError('Error reading ' + filename + ' quicksearch');
      end;
      try
        section := 'toolbar';
        if SectionExists(section) then
        begin
          configmainbar.Clear;
          nummainbar := ReadInteger(section, 'nummainbar', nummainbar);
          for i := 0 to nummainbar - 1 do
            configmainbar.Add(ReadString(section, 'mainbar' + IntToStr(i), ''));
          configobjectbar.Clear;
          numobjectbar := ReadInteger(section, 'numobjectbar', numobjectbar);
          for i := 0 to numobjectbar - 1 do
            configobjectbar.Add(ReadString(section, 'objectbar' + IntToStr(i), ''));
          configleftbar.Clear;
          numleftbar := ReadInteger(section, 'numleftbar', numleftbar);
          for i := 0 to numleftbar - 1 do
            configleftbar.Add(ReadString(section, 'leftbar' + IntToStr(i), ''));
          configrightbar.Clear;
          numrightbar := ReadInteger(section, 'numrightbar', numrightbar);
          for i := 0 to numrightbar - 1 do
            configrightbar.Add(ReadString(section, 'rightbar' + IntToStr(i), ''));
        end;
        // Script panel
        for i := 0 to numscript - 1 do
        begin
          section := 'ScriptPanel' + IntToStr(i);
          ok := ReadBool(section, 'visible', False);
          Fscript[i].ScriptFilename :=
            ReadString(section, 'ScriptFile', Fscript[i].ScriptFilename);
          if ok then
          begin
            ActiveScript := i;
          end;
        end;

      except
        ShowError('Error reading ' + filename + ' quicksearch');
      end;
    end;
  finally
    inif.Free;
  end;
end;

procedure Tf_main.UpdateConfig;
var
  i,n: integer;
  b1, b2: boolean;
  inif,ini: TMemIniFile;
  ConfigPath,ScopeConfig: string;
begin
  if Config_Version < '3.0.1.3d' then
  begin
    f_getdss.cfgdss.DSSurl[1, 0] := URL_DSS_NAME1;
    f_getdss.cfgdss.DSSurl[1, 1] := URL_DSS1;
    f_getdss.cfgdss.DSSurl[2, 0] := URL_DSS_NAME2;
    f_getdss.cfgdss.DSSurl[2, 1] := URL_DSS2;
    f_getdss.cfgdss.DSSurl[3, 0] := URL_DSS_NAME3;
    f_getdss.cfgdss.DSSurl[3, 1] := URL_DSS3;
    f_getdss.cfgdss.DSSurl[4, 0] := URL_DSS_NAME4;
    f_getdss.cfgdss.DSSurl[4, 1] := URL_DSS4;
    f_getdss.cfgdss.DSSurl[5, 0] := URL_DSS_NAME5;
    f_getdss.cfgdss.DSSurl[5, 1] := URL_DSS5;
    f_getdss.cfgdss.DSSurl[6, 0] := URL_DSS_NAME6;
    f_getdss.cfgdss.DSSurl[6, 1] := URL_DSS6;
    f_getdss.cfgdss.DSSurl[7, 0] := URL_DSS_NAME7;
    f_getdss.cfgdss.DSSurl[7, 1] := URL_DSS7;
    f_getdss.cfgdss.DSSurl[8, 0] := URL_DSS_NAME8;
    f_getdss.cfgdss.DSSurl[8, 1] := URL_DSS8;
    f_getdss.cfgdss.DSSurl[9, 0] := URL_DSS_NAME9;
    f_getdss.cfgdss.DSSurl[9, 1] := URL_DSS9;
  end;
  if Config_Version < '3.0.1.5f' then
  begin
{$ifdef unix}
    cfgm.PrintCmd1 := DefaultPrintCmd1;
    cfgm.PrintCmd2 := DefaultPrintCmd2;
{$endif}
{$ifndef darwin}
    LinuxDesktop := 0;
    OpenFileCMD := 'xdg-open';
{$endif}
  end;
  if Config_Version < '3.1a' then
  begin
    if cfgm.PrinterResolution < 300 then
      cfgm.PrinterResolution := 300;
  end;
  if Config_Version < '3.3i' then
  begin
    // update Jupiter GRS default values
    def_cfgsc.GRSlongitude := 168.0;
    def_cfgsc.GRSjd := jd(2011, 7, 15, 0);
    def_cfgsc.GRSdrift := 15.2 / 365.25;
    // incoherent object filter
    catalog.cfgshr.NebMagFilter[0] := 99;
    catalog.cfgshr.NebMagFilter[1] := 99;
    catalog.cfgshr.NebMagFilter[2] := 99;
    catalog.cfgshr.NebMagFilter[3] := 99;
  end;
  if Config_Version < '3.3j' then
  begin
    catalog.cfgcat.starcatpath[dsbase - BaseStar] :=
      'C:\Program Files\Deepsky Astronomy Software';
    catalog.cfgcat.starcatpath[dstyc - BaseStar] :=
      'C:\Program Files\Deepsky Astronomy Software\SuperTycho';
    catalog.cfgcat.starcatpath[dsgsc - BaseStar] :=
      'C:\Program Files\Deepsky Astronomy Software\HGC';
  end;
  if Config_Version < '3.5e' then
  begin
    i := def_cfgsc.SimLabel;
    case i of
      0: def_cfgsc.SimLabel := 3;
      1: def_cfgsc.SimLabel := -2;
      2: def_cfgsc.SimLabel := -3;
      3: def_cfgsc.SimLabel := 1;
      4: def_cfgsc.SimLabel := 2;
      else
        def_cfgsc.SimLabel := 0;
    end;
  end;
{$ifdef mswindows}
  if Config_Version < '3.5f' then
  begin
    for i := 1 to numfont do
    begin
      if def_cfgplot.FontSize[i] = 8 then
        def_cfgplot.FontSize[i] := DefaultFontSize;
    end;
    for i := 1 to numlabtype do
    begin
      if (i = 6) and (def_cfgplot.LabelSize[6] = 10) then
        def_cfgplot.LabelSize[6] := 12;
      if def_cfgplot.LabelSize[i] = 8 then
        def_cfgplot.LabelSize[i] := DefaultFontSize;
    end;
  end;
{$endif}
{$ifdef darwin}
  if Config_Version < '3.5f' then
  begin
    for i := 1 to numfont do
    begin
      if def_cfgplot.FontSize[i] = 12 then
        def_cfgplot.FontSize[i] := DefaultFontSize;
    end;
    for i := 1 to numlabtype do
    begin
      if def_cfgplot.LabelSize[i] = 12 then
        def_cfgplot.LabelSize[i] := DefaultFontSize;
      if (i = 6) and (def_cfgplot.LabelSize[6] = 14) then
        def_cfgplot.LabelSize[6] := 12;
    end;
  end;
{$endif}
  if Config_Version < '3.5i' then
  begin
    def_cfgsc.projname[0] := 'TAN';
    def_cfgsc.projname[1] := 'TAN';
    def_cfgsc.projname[2] := 'TAN';
    def_cfgsc.projname[3] := 'TAN';
    def_cfgsc.projname[4] := 'TAN';
    def_cfgsc.projname[5] := 'TAN';
    def_cfgsc.projname[6] := 'TAN';
    def_cfgsc.projname[7] := 'TAN';
    def_cfgsc.projname[8] := 'MER';
    def_cfgsc.projname[9] := 'MER';
    def_cfgsc.projname[10] := 'MER';
  end;
  if Config_Version < '3.7f' then
  begin
    if def_cfgplot.stardyn = 65 then
      def_cfgplot.stardyn := 78;
  end;
  if Config_Version < '3.9g' then
  begin
    // update Jupiter GRS default values
    def_cfgsc.GRSlongitude := 208.0;
    def_cfgsc.GRSjd := jd(2014, 1, 31, 0);
    def_cfgsc.GRSdrift := 16.5 / 365.25;
  end;
  if Config_Version < '3.11g' then
  begin
    CopyFile(SysToUTF8(Configfile), SysToUTF8(Configfile + '.oldscripts'));
  end;
  if Config_Version < '3.11j' then
  begin
    for i := 0 to cfgm.CometUrlList.Count - 1 do
    begin
      if pos('Soft00Cmt', cfgm.CometUrlList[i]) > 0 then
        cfgm.CometUrlList[i] := URL_HTTPCometElements1;
    end;
    b1 := False;
    b2 := False;
    for i := 0 to cfgm.AsteroidUrlList.Count - 1 do
      if pos('ap-i.net', cfgm.AsteroidUrlList[i]) > 0 then
        b2 := True;
    if b2 then
    begin
      for i := 0 to cfgm.AsteroidUrlList.Count - 1 do
        if (pos('Soft00Bright', cfgm.AsteroidUrlList[i]) > 0) then
        begin
          cfgm.AsteroidUrlList.Delete(i);
          break;
        end;
    end;
    for i := 0 to cfgm.AsteroidUrlList.Count - 1 do
    begin
      if pos('Soft00Unusual', cfgm.AsteroidUrlList[i]) > 0 then
      begin
        b1 := True;
        cfgm.AsteroidUrlList[i] := URL_HTTPAsteroidElements1;
      end;
      if pos('Soft00Distant', cfgm.AsteroidUrlList[i]) > 0 then
        cfgm.AsteroidUrlList[i] := URL_HTTPAsteroidElements3;
      if (pos('Soft00Bright', cfgm.AsteroidUrlList[i]) > 0) then
        cfgm.AsteroidUrlList[i] := URL_CDCAsteroidElements;
    end;
    if b1 then
      cfgm.AsteroidUrlList.Add(URL_HTTPAsteroidElements2);
  end;
  if Config_Version < '3.11q' then
  begin
    catalog.cfgcat.nebcatpath[ngc - BaseNeb] := 'cat' + PathDelim + 'openngc';
    catalog.cfgcat.nebcatfield[ngc - BaseNeb, 2] := 10;
  end;
  if Config_Version < '3.11x' then
  begin
    if (cfgm.btnsize = 24) then
      cfgm.btnsize := 28;
  end;
  if Config_Version < '3.11y' then
  begin
    // update Jupiter GRS default values
    def_cfgsc.GRSlongitude := 262.5;
    def_cfgsc.GRSjd := jd(2017, 2, 1, 0);
    def_cfgsc.GRSdrift := 18.2 / 365.25;
    // cleanup xplanet tmp directories
    DeleteFilesInDir(slash(TempDir) + '32');
    DeleteFilesInDir(slash(TempDir) + '64');
    DeleteFilesInDir(slash(TempDir) + '120');
    DeleteFilesInDir(slash(TempDir) + '240');
    DeleteFilesInDir(slash(TempDir) + '320');
    DeleteFilesInDir(slash(TempDir) + '480');
    DeleteFilesInDir(slash(TempDir) + '512');
    DeleteFilesInDir(slash(TempDir) + '1024');
  end;
  if Config_Version < '4.1d' then
  begin
    for i:=0 to 3 do
    if i=1 then begin
      def_cfgsc.ProjOptions[i].EquinoxType := 2;
      def_cfgsc.ProjOptions[i].ApparentPos := True;
      def_cfgsc.ProjOptions[i].PMon := True;
      def_cfgsc.ProjOptions[i].YPmon := 0;
      def_cfgsc.ProjOptions[i].EquinoxChart := rsDate;
      def_cfgsc.ProjOptions[i].DefaultJDChart := jd2000;
      def_cfgsc.ProjOptions[i].CoordExpertMode := False;
      def_cfgsc.ProjOptions[i].CoordType := 0;
    end
    else begin
      def_cfgsc.ProjOptions[i].EquinoxType := def_cfgsc.EquinoxType;
      def_cfgsc.ProjOptions[i].ApparentPos := def_cfgsc.ApparentPos ;
      def_cfgsc.ProjOptions[i].PMon := def_cfgsc.PMon ;
      def_cfgsc.ProjOptions[i].YPmon := def_cfgsc.YPmon ;
      def_cfgsc.ProjOptions[i].EquinoxChart := def_cfgsc.EquinoxChart ;
      def_cfgsc.ProjOptions[i].DefaultJDChart := def_cfgsc.DefaultJDChart ;
      def_cfgsc.ProjOptions[i].CoordExpertMode := def_cfgsc.CoordExpertMode ;
      def_cfgsc.ProjOptions[i].CoordType := def_cfgsc.CoordType ;
    end;
  end;
  if Config_Version < '4.1m' then
  begin
    for i:=10 to 11 do begin
       def_cfgsc.LabelMagDiff[i]:=def_cfgsc.LabelMagDiff[5];
       def_cfgsc.LabelOrient[i]:=def_cfgsc.LabelOrient[5];
       def_cfgsc.ShowLabel[i]:=def_cfgsc.ShowLabel[5];
       def_cfgplot.LabelColor[i]:=def_cfgplot.LabelColor[5];
       def_cfgplot.LabelSize[i]:=def_cfgplot.LabelSize[5];
    end;
  end;
  if Config_Version < '4.1n' then
  begin
    inif := TMeminifile.Create(Configfile);
    def_cfgsc.horizonfile := inif.ReadString('main', 'horizonfile', '');
    def_cfgsc.HorizonPictureFile := inif.ReadString('main', 'HorizonPictureFile', '');
    inif.DeleteKey('main', 'horizonfile');
    inif.DeleteKey('main', 'HorizonPictureFile');
    inif.WriteString('default_chart', 'horizonfile', def_cfgsc.horizonfile);
    inif.WriteString('default_chart', 'HorizonPictureFile', def_cfgsc.HorizonPictureFile);
    inif.UpdateFile;
    inif.Free;
  end;
  if Config_Version < '4.1q' then
  begin
    if pos('minorplanetcenter',cfgm.CometUrlList[0])>0 then begin
       cfgm.CometUrlList.Clear;
       cfgm.CometUrlList.Add(URL_HTTPCometElements1);
    end;
    // update Jupiter GRS default values
    def_cfgsc.GRSlongitude := 314.5;
    def_cfgsc.GRSjd := jd(2019, 8, 12, 0);
    def_cfgsc.GRSdrift := 18.3 / 365.25;
  end;
  if Config_Version < '4.3b' then begin
    DeleteFileUTF8(slash(SatDir) + 'F77L.EER');
    DeleteFileUTF8(slash(SatDir) + 'IRIDFLAR.EXE');
    DeleteFileUTF8(slash(SatDir) + 'SORT.COM');
    DeleteFileUTF8(slash(SatDir) + 'dosbox.conf');
    DeleteFileUTF8(slash(SatDir) + 'IRIDFLAR.CFG');
    DeleteFileUTF8(slash(SatDir) + 'IRIDFLAR.OUT');
    {$ifdef mswindows}
    DeleteFileUTF8(slash(SatDir) + 'DOSBox.exe');
    DeleteFileUTF8(slash(SatDir) + 'SDL.dll');
    DeleteFileUTF8(slash(SatDir) + 'SDL_net.dll');
    {$endif}
  end;
  if Config_Version < '4.3c' then begin
    if catalog.cfgcat.nebcatdef[sac - BaseNeb] then begin
      catalog.cfgcat.nebcatdef[sac - BaseNeb] := False;
      catalog.cfgcat.nebcatdef[ngc - BaseNeb] := True;
    end;
  end;
  if Config_Version < '4.3g' then begin
    // Add DE440 and DE441 on top if not present
    n:=1;
    for i:=1 to nJPL_DE do
      if (JPL_DE[i]=441) then dec(n);
    if n>0 then begin
      inc(nJPL_DE);
      SetLength(JPL_DE, nJPL_DE+1);
      for i:=nJPL_DE-1 downto 1 do
         JPL_DE[i+1] := JPL_DE[i];
      JPL_DE[1] := 441;
    end;
    n:=1;
    for i:=1 to nJPL_DE do
      if (JPL_DE[i]=440) then dec(n);
    if n>0 then begin
      inc(nJPL_DE);
      SetLength(JPL_DE, nJPL_DE+1);
      for i:=nJPL_DE-1 downto 1 do
         JPL_DE[i+1] := JPL_DE[i];
      JPL_DE[1] := 440;
    end;
  end;
  if Config_Version < '4.3q' then begin
    // replaced by new version using Catgen
    catalog.cfgcat.varstarcatpath[gcvs - BaseVar] := 'cat';
    catalog.cfgcat.VarStarCatDef[gcvs - BaseVar] := false;
    catalog.cfgcat.VarStarCatOn[gcvs - BaseVar] := false;
    catalog.cfgcat.varstarcatfield[gcvs - BaseVar, 1] := 0;
    catalog.cfgcat.varstarcatfield[gcvs - BaseVar, 2] := 0;
    catalog.cfgcat.dblstarcatpath[wds - BaseDbl] := 'cat';
    catalog.cfgcat.dblStarCatDef[gcvs - BaseVar] := false;
    catalog.cfgcat.dblStarCatOn[gcvs - BaseVar] := false;
    catalog.cfgcat.dblstarcatfield[wds - BaseDbl, 1] := 0;
    catalog.cfgcat.dblstarcatfield[wds - BaseDbl, 2] := 10;
  end;
  if Config_Version < '4.3s' then begin
    // neb catalog replaced with catgen, def can be upgraded for barnard, gpn, leda, sh2 that already use catgen
    if catalog.cfgcat.NebCatDef[drk-BaseNeb] then begin
       SetGCat(catalog.cfgcat.NebCatPath[drk-BaseNeb], 'b', '1', inttostr(catalog.cfgcat.NebCatField[drk-BaseNeb, 1]), inttostr(catalog.cfgcat.NebCatField[drk-BaseNeb, 2]));
    end;
    if catalog.cfgcat.NebCatDef[gpn-BaseNeb] then begin
       SetGCat(catalog.cfgcat.NebCatPath[gpn-BaseNeb], 'gpn', '1', inttostr(catalog.cfgcat.NebCatField[gpn-BaseNeb, 1]), inttostr(catalog.cfgcat.NebCatField[gpn-BaseNeb, 2]));
    end;
    if catalog.cfgcat.NebCatDef[pgc-BaseNeb] then begin
       SetGCat(catalog.cfgcat.NebCatPath[pgc-BaseNeb], 'pgc', '1', inttostr(catalog.cfgcat.NebCatField[pgc-BaseNeb, 1]), inttostr(catalog.cfgcat.NebCatField[pgc-BaseNeb, 2]));
    end;
    if catalog.cfgcat.NebCatDef[sh2-BaseNeb] then begin
       SetGCat(catalog.cfgcat.NebCatPath[sh2-BaseNeb], 'sh 2', '1', inttostr(catalog.cfgcat.NebCatField[sh2-BaseNeb, 1]), inttostr(catalog.cfgcat.NebCatField[sh2-BaseNeb, 2]));
    end;
    catalog.cfgcat.NebCatDef[drk-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[drk-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[drk-BaseNeb]:='';
    catalog.cfgcat.NebCatDef[gpn-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[gpn-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[gpn-BaseNeb]:='';
    catalog.cfgcat.NebCatDef[pgc-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[pgc-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[pgc-BaseNeb]:='';
    catalog.cfgcat.NebCatDef[sh2-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[sh2-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[sh2-BaseNeb]:='';
    // other old catalog lbn,ocl,gcm are disabled and need to reinstall a new catgen version
    catalog.cfgcat.NebCatDef[lbn-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[lbn-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[lbn-BaseNeb]:='';
    catalog.cfgcat.NebCatDef[ocl-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[ocl-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[ocl-BaseNeb]:='';
    catalog.cfgcat.NebCatDef[gcm-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[gcm-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[gcm-BaseNeb]:='';
    // sac and rc3 are removed
    catalog.cfgcat.NebCatDef[sac-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[sac-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[sac-BaseNeb]:='';
    catalog.cfgcat.NebCatDef[rc3-BaseNeb]:=false;
    catalog.cfgcat.NebCatOn[rc3-BaseNeb]:=false;
    catalog.cfgcat.NebCatPath[rc3-BaseNeb]:='';
  end;
  if Config_Version < '4.3t' then begin
    // merge telescope config file
    ConfigPath:=ExtractFilePath(Configfile);
    if DirectoryExists(ConfigPath) then
      ScopeConfig := slash(ConfigPath) + 'scope.ini'
    else
      ScopeConfig := slash(extractfilepath(ParamStr(0))) + 'scope.ini';
    if FileExists(ScopeConfig) then begin
      ini := TMeminifile.Create(ScopeConfig);
      def_cfgsc.AscomDevice := ini.readstring('Ascom', 'name', '');
      def_cfgsc.TelescopeAltAz := ini.ReadBool('Ascom', 'AltAz', False);
      def_cfgsc.TelescopeInterval := ini.ReadInteger('Ascom', 'read_interval', 1000);
      i := ini.ReadInteger('AscomRemote', 'remote', 0);
      {$ifdef mswindows}
       def_cfgsc.TelescopeInterface:=i;
      {$else}
       def_cfgsc.TelescopeInterface:=2;
      {$endif}
      def_cfgsc.AlpacaProtocol := ini.ReadInteger('AscomRemote', 'protocol', 0);
      def_cfgsc.AlpacaHost := ini.readstring('AscomRemote', 'host', '127.0.0.1');
      def_cfgsc.AlpacaPort := ini.ReadInteger('AscomRemote', 'port', 32323);
      def_cfgsc.AlpacaUser := DecryptStr(hextostr(ini.readstring('AscomRemote', 'u', '')), encryptpwd);
      def_cfgsc.AlpacaPass := DecryptStr(hextostr(ini.readstring('AscomRemote', 'p', '')), encryptpwd);
      def_cfgsc.AlpacaDevice := ini.ReadInteger('AscomRemote', 'device', 0);
      def_cfgsc.TelescopeLeft := ini.ReadInteger('Position', 'left', 0);
      def_cfgsc.TelescopeTop := ini.ReadInteger('Position', 'top', 0);
      ini.Free;
    end;
  end;

  SaveDefault;
end;

procedure Tf_main.SaveVersion;
var
  inif: TMemIniFile;
  section: string;
begin
  try
    inif := TMeminifile.Create(configfile);
    try
      with inif do
      begin
        section := 'main';
        WriteString(section, 'version', cdcver);
        Updatefile;
      end;
    finally
      inif.Free;
    end;
  except
  end;
end;

procedure Tf_main.SaveDefault;
var
  i, j: integer;
  cname: string;
begin
  try
    SavePrivateConfig(configfile);
    SaveQuickSearch(configfile);
    for i:=0 to TabControl1.PageCount-1 do begin
      cname:=TabControl1.Pages[i].Caption;
      for j:=0 to MultiFrame1.ChildCount - 1 do begin
        if (MultiFrame1.Childs[j].DockedObject is Tf_chart) and (MultiFrame1.Childs[j].DockedObject.Caption=cname) then begin
          if i=0 then
            SaveChartConfig(configfile, MultiFrame1.Childs[j], False)
          else
            SaveChartConfig(configfile + IntToStr(i), MultiFrame1.Childs[j], False);
        end;
      end;
    end;
  except
  end;
end;

procedure Tf_main.SaveChartConfig(filename: string; child: TChildFrame;
  overwrite: boolean = False);
var
  i, n: integer;
  inif: TMemIniFile;
  section: string;
  cplot: Tconf_plot;
  csc: Tconf_skychart;
begin
  try
    cplot := Tconf_plot.Create;
    csc := Tconf_skychart.Create;
    if (child <> nil) and (child.DockedObject is Tf_chart) then
      with child.DockedObject as Tf_chart do
      begin
        cplot.Assign(sc.plot.cfgplot);
        csc.Assign(sc.cfgsc);
      end
    else
    begin
      cplot.Assign(def_cfgplot);
      csc.Assign(def_cfgsc);
    end;
    inif := TMeminifile.Create(filename);
    try
      with inif do
      begin
        if overwrite then
          Clear;
        section := 'main';
        WriteString(section,'ChartName',csc.chartname);
        WriteInteger(section, 'WinTop', f_main.Top);
        WriteInteger(section, 'WinLeft', f_main.Left);
        WriteInteger(section, 'WinWidth', f_main.Width);
        WriteInteger(section, 'WinHeight', f_main.Height);
        for i := 0 to MaxField do
          WriteFloat(section, 'FieldNum' + IntToStr(i), catalog.cfgshr.FieldNum[i]);
        section := 'filter';
        WriteBool(section, 'StarFilter', catalog.cfgshr.StarFilter);
        WriteBool(section, 'AutoStarFilter', catalog.cfgshr.AutoStarFilter);
        WriteFloat(section, 'AutoStarFilterMag', catalog.cfgshr.AutoStarFilterMag);
        WriteBool(section, 'NebFilter', catalog.cfgshr.NebFilter);
        WriteBool(section, 'BigNebFilter', catalog.cfgshr.BigNebFilter);
        WriteFloat(section, 'BigNebLimit', catalog.cfgshr.BigNebLimit);
        WriteBool(section, 'NoFilterMessier', catalog.cfgshr.NoFilterMessier);
        WriteBool(section, 'NoFilterMagBright', catalog.cfgshr.NoFilterMagBright);
        for i := 1 to maxfield do
        begin
          WriteFloat(section, 'StarMagFilter' + IntToStr(i),
            catalog.cfgshr.StarMagFilter[i]);
          WriteFloat(section, 'NebMagFilter' + IntToStr(i),
            catalog.cfgshr.NebMagFilter[i]);
          WriteFloat(section, 'NebSizeFilter' + IntToStr(i),
            catalog.cfgshr.NebSizeFilter[i]);
        end;
        section := 'catalog';
        Writeinteger(section, 'GCatNum', catalog.cfgcat.GCatNum);
        for i := 0 to catalog.cfgcat.GCatNum - 1 do
        begin
          Writestring(section, 'CatName' + IntToStr(i),
            catalog.cfgcat.GCatLst[i].shortname);
          Writestring(section, 'CatLongName' + IntToStr(i),
            catalog.cfgcat.GCatLst[i].Name);
          Writestring(section, 'CatPath' + IntToStr(i), catalog.cfgcat.GCatLst[i].path);
          WriteFloat(section, 'CatMin' + IntToStr(i), catalog.cfgcat.GCatLst[i].min);
          WriteFloat(section, 'CatMax' + IntToStr(i), catalog.cfgcat.GCatLst[i].max);
          WriteBool(section, 'CatActif' + IntToStr(i), catalog.cfgcat.GCatLst[i].Actif);
          WriteBool(section, 'CatSearch' + IntToStr(i), catalog.cfgcat.GCatLst[i].Search);
          WriteBool(section, 'CatForceColor' + IntToStr(i),catalog.cfgcat.GCatLst[i].ForceColor);
          WriteBool(section, 'CatForceLabel' + IntToStr(i),catalog.cfgcat.GCatLst[i].ForceLabel);
          WriteInteger(section, 'CatColor' + IntToStr(i), catalog.cfgcat.GCatLst[i].Col);
          WriteInteger(section, 'CatStarType' + IntToStr(i), catalog.cfgcat.GCatLst[i].startype);
          WriteInteger(section, 'CatStarSize' + IntToStr(i), catalog.cfgcat.GCatLst[i].starsize);

        end;
        n := Length(catalog.cfgcat.UserObjects);
        WriteInteger(section, 'UserObjectsNum', n);
        for i := 0 to n - 1 do
        begin
          WriteBool(section, 'UObjActive' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].active);
          WriteInteger(section, 'UObjType' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].otype);
          WriteString(section, 'UObjName' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].oname);
          WriteFloat(section, 'UObjRA' + IntToStr(i), catalog.cfgcat.UserObjects[i].ra);
          WriteFloat(section, 'UObjDEC' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].Dec);
          WriteFloat(section, 'UObjMag' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].mag);
          WriteFloat(section, 'UObjSize' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].size);
          WriteInteger(section, 'UObjColor' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].color);
          WriteString(section, 'UObjComment' + IntToStr(i),
            catalog.cfgcat.UserObjects[i].comment);
        end;
        WriteFloat(section, 'StarmagMax', catalog.cfgcat.StarmagMax);
        WriteFloat(section, 'NebmagMax', catalog.cfgcat.NebmagMax);
        WriteFloat(section, 'NebSizeMin', catalog.cfgcat.NebSizeMin);
        WriteBool(section, 'UseUSNOBrightStars', catalog.cfgcat.UseUSNOBrightStars);
        WriteBool(section, 'UseGSVSIr', catalog.cfgcat.UseGSVSIr);
        WriteString(section, 'Name290', catalog.cfgcat.Name290);
        WriteBool(section, 'LimitGaiaCount', catalog.cfgcat.LimitGaiaCount);

       for i := 1 to maxstarcatalog do
        begin
          WriteBool(section, 'starcatdef' + IntToStr(i), catalog.cfgcat.starcatdef[i]);
          WriteBool(section, 'starcaton' + IntToStr(i), catalog.cfgcat.starcaton[i]);
          WriteInteger(section, 'starcatfield1' + IntToStr(i),
            catalog.cfgcat.starcatfield[i, 1]);
          WriteInteger(section, 'starcatfield2' + IntToStr(i),
            catalog.cfgcat.starcatfield[i, 2]);
        end;
        for i := 1 to maxvarstarcatalog do
        begin
          WriteBool(section, 'varstarcatdef' + IntToStr(i),
            catalog.cfgcat.varstarcatdef[i]);
          WriteBool(section, 'varstarcaton' + IntToStr(i),
            catalog.cfgcat.varstarcaton[i]);
          WriteInteger(section, 'varstarcatfield1' + IntToStr(i),
            catalog.cfgcat.varstarcatfield[i, 1]);
          WriteInteger(section, 'varstarcatfield2' + IntToStr(i),
            catalog.cfgcat.varstarcatfield[i, 2]);
        end;
        for i := 1 to maxdblstarcatalog do
        begin
          WriteBool(section, 'dblstarcatdef' + IntToStr(i),
            catalog.cfgcat.dblstarcatdef[i]);
          WriteBool(section, 'dblstarcaton' + IntToStr(i),
            catalog.cfgcat.dblstarcaton[i]);
          WriteInteger(section, 'dblstarcatfield1' + IntToStr(i),
            catalog.cfgcat.dblstarcatfield[i, 1]);
          WriteInteger(section, 'dblstarcatfield2' + IntToStr(i),
            catalog.cfgcat.dblstarcatfield[i, 2]);
        end;
        for i := 1 to maxnebcatalog do
        begin
          WriteBool(section, 'nebcatdef' + IntToStr(i), catalog.cfgcat.nebcatdef[i]);
          WriteBool(section, 'nebcaton' + IntToStr(i), catalog.cfgcat.nebcaton[i]);
          WriteInteger(section, 'nebcatfield1' + IntToStr(i),
            catalog.cfgcat.nebcatfield[i, 1]);
          WriteInteger(section, 'nebcatfield2' + IntToStr(i),
            catalog.cfgcat.nebcatfield[i, 2]);
        end;
        section := 'display';
        WriteBool(section, 'AntiAlias', cplot.AntiAlias);
        WriteInteger(section, 'starplot', cplot.starplot);
        WriteInteger(section, 'nebplot', cplot.nebplot);
        WriteInteger(section, 'plaplot', cplot.plaplot);
        WriteBool(section, 'TransparentPlanet', cplot.TransparentPlanet);
        WriteInteger(section, 'Nebgray', cplot.Nebgray);
        WriteInteger(section, 'NebBright', cplot.NebBright);
        WriteInteger(section, 'StarDyn', cplot.stardyn);
        WriteInteger(section, 'StarSize', cplot.starsize);
        WriteInteger(section, 'contrast', cplot.contrast);
        WriteInteger(section, 'saturation', cplot.saturation);
        WriteBool(section, 'redmove', cplot.red_move);
        WriteFloat(section, 'partsize', cplot.partsize);
        WriteFloat(section, 'magsize', cplot.magsize);
        WriteBool(section, 'AutoSkycolor', cplot.AutoSkycolor);
        WriteBool(section, 'DSOColorFillAst', cplot.DSOColorFillAst);
        WriteBool(section, 'DSOColorFillOCl', cplot.DSOColorFillOCl);
        WriteBool(section, 'DSOColorFillGCl', cplot.DSOColorFillGCl);
        WriteBool(section, 'DSOColorFillPNe', cplot.DSOColorFillPNe);
        WriteBool(section, 'DSOColorFillDN', cplot.DSOColorFillDN);
        WriteBool(section, 'DSOColorFillEN', cplot.DSOColorFillEN);
        WriteBool(section, 'DSOColorFillRN', cplot.DSOColorFillRN);
        WriteBool(section, 'DSOColorFillSN', cplot.DSOColorFillSN);
        WriteBool(section, 'DSOColorFillGxy', cplot.DSOColorFillGxy);
        WriteBool(section, 'DSOColorFillGxyCl', cplot.DSOColorFillGxyCl);
        WriteBool(section, 'DSOColorFillQ', cplot.DSOColorFillQ);
        WriteBool(section, 'DSOColorFillGL', cplot.DSOColorFillGL);
        WriteBool(section, 'DSOColorFillNE', cplot.DSOColorFillNE);
        for i := 0 to maxcolor do
          WriteInteger(section, 'color' + IntToStr(i), cplot.color[i]);
        for i := 0 to 7 do
          WriteInteger(section, 'skycolor' + IntToStr(i), cplot.skycolor[i]);
        WriteInteger(section, 'bgColor', cplot.bgColor);
        section := 'font';
        for i := 1 to numfont do
        begin
          WriteString(section, 'FontName' + IntToStr(i), cplot.FontName[i]);
          WriteInteger(section, 'FontSize' + IntToStr(i), cplot.FontSize[i]);
          WriteBool(section, 'FontBold' + IntToStr(i), cplot.FontBold[i]);
          WriteBool(section, 'FontItalic' + IntToStr(i), cplot.FontItalic[i]);
        end;
        for i := 1 to numlabtype do
        begin
          WriteInteger(section, 'LabelColor' + IntToStr(i), cplot.LabelColor[i]);
          WriteInteger(section, 'LabelSize' + IntToStr(i), cplot.LabelSize[i]);
        end;
        section := 'grid';
        WriteBool(section, 'ShowCRose', catalog.cfgshr.ShowCRose);
        WriteBool(section, 'SimplePointer', catalog.cfgshr.SimplePointer);
        WriteInteger(section, 'CRoseSz', catalog.cfgshr.CRoseSz);
        for i := 0 to maxfield do
          WriteFloat(section, 'HourGridSpacing' + IntToStr(i),
            catalog.cfgshr.HourGridSpacing[i]);
        for i := 0 to maxfield do
          WriteFloat(section, 'DegreeGridSpacing' + IntToStr(i),
            catalog.cfgshr.DegreeGridSpacing[i]);

        section := 'Calendar';
        WriteInteger(section, 'CalGraphHeight', csc.CalGraphHeight);

        section := 'Finder';
        WriteBool(section, 'ShowCircle', csc.ShowCircle);
        WriteBool(section, 'ShowCrosshair', csc.ShowCrosshair);
        WriteBool(section, 'EyepieceMask', csc.EyepieceMask);
        WriteBool(section, 'CircleLabel', csc.CircleLabel);
        WriteBool(section, 'RectangleLabel', csc.RectangleLabel);
        WriteBool(section, 'marknumlabel', csc.marknumlabel);
        WriteInteger(section, 'ncircle', csc.ncircle);
        for i := 1 to csc.ncircle do
          WriteFloat(section, 'Circle' + IntToStr(i), csc.circle[i, 1]);
        for i := 1 to csc.ncircle do
          WriteFloat(section, 'CircleR' + IntToStr(i), csc.circle[i, 2]);
        for i := 1 to csc.ncircle do
          WriteFloat(section, 'CircleOffset' + IntToStr(i), csc.circle[i, 3]);
        for i := 1 to csc.ncircle do
          WriteBool(section, 'ShowCircle' + IntToStr(i), csc.circleok[i]);
        for i := 1 to csc.ncircle do
          WriteString(section, 'CircleLbl' + IntToStr(i), csc.circlelbl[i] + ' ');
        WriteInteger(section, 'nrectangle', csc.nrectangle);
        for i := 1 to csc.nrectangle do
          WriteFloat(section, 'RectangleW' + IntToStr(i), csc.rectangle[i, 1]);
        for i := 1 to csc.nrectangle do
          WriteFloat(section, 'RectangleH' + IntToStr(i), csc.rectangle[i, 2]);
        for i := 1 to csc.nrectangle do
          WriteFloat(section, 'RectangleR' + IntToStr(i), csc.rectangle[i, 3]);
        for i := 1 to csc.nrectangle do
          WriteFloat(section, 'RectangleOffset' + IntToStr(i), csc.rectangle[i, 4]);
        for i := 1 to csc.nrectangle do
          WriteBool(section, 'ShowRectangle' + IntToStr(i), csc.rectangleok[i]);
        for i := 1 to csc.nrectangle do
          WriteString(section, 'RectangleLbl' + IntToStr(i), csc.rectanglelbl[i] + ' ');
        section := 'chart';
        WriteInteger(section, 'EquinoxType', csc.EquinoxType);
        WriteString(section, 'EquinoxChart', csc.EquinoxChart);
        WriteFloat(section, 'DefaultJDchart', csc.DefaultJDchart);
        for i:=0 to 3 do
        begin
          WriteInteger(section, 'ProjOptionsEquinoxType' + IntToStr(i), csc.ProjOptions[i].EquinoxType);
          WriteBool(section, 'ProjOptionsApparentPos' + IntToStr(i), csc.ProjOptions[i].ApparentPos);
          WriteBool(section, 'ProjOptionsPMon' + IntToStr(i), csc.ProjOptions[i].PMon);
          WriteFloat(section, 'ProjOptionsYPmon' + IntToStr(i), csc.ProjOptions[i].YPmon);
          WriteString(section, 'ProjOptionsEquinoxChart' + IntToStr(i), csc.ProjOptions[i].EquinoxChart);
          WriteFloat(section, 'ProjOptionsDefaultJDChart' + IntToStr(i), csc.ProjOptions[i].DefaultJDChart);
          WriteBool(section, 'ProjOptionsCoordExpertMode' + IntToStr(i), csc.ProjOptions[i].CoordExpertMode);
          WriteInteger(section, 'ProjOptionsCoordType' + IntToStr(i), csc.ProjOptions[i].CoordType);
        end;
        section := 'default_chart';
        if (child <> nil) then
        begin
          WriteInteger(section, 'ChartWidth', child.Width);
          WriteInteger(section, 'ChartHeight', child.Height);
          WriteInteger(section, 'ChartTop', child.Top);
          WriteInteger(section, 'Chartleft', child.Left);
          WriteBool(section, 'ChartMaximized', child.Maximized);
        end;
        WriteFloat(section, 'racentre', csc.racentre);
        WriteFloat(section, 'decentre', csc.decentre);
        WriteFloat(section, 'acentre', csc.acentre);
        WriteFloat(section, 'hcentre', csc.hcentre);
        WriteFloat(section, 'fov', csc.fov);
        WriteFloat(section, 'theta', csc.theta);
        WriteString(section, 'projtype', csc.projtype);
        WriteInteger(section, 'ProjPole', csc.ProjPole);
        WriteBool(section, 'ProjEquatorCentered', csc.ProjEquatorCentered);
        WriteInteger(section, 'FlipX', csc.FlipX);
        WriteInteger(section, 'FlipY', csc.FlipY);
        WriteBool(section, 'CoordExpertMode', csc.CoordExpertMode);
        WriteBool(section, 'PMon', csc.PMon);
        WriteFloat(section, 'YPMon', csc.YPMon);
        WriteBool(section, 'DrawPMon', csc.DrawPMon);
        WriteBool(section, 'ApparentPos', csc.ApparentPos);
        WriteInteger(section, 'CoordType', csc.CoordType);
        WriteInteger(section, 'DrawPMyear', csc.DrawPMyear);
        WriteBool(section, 'horizonopaque', csc.horizonopaque);
        WriteBool(section, 'ShowHorizon', csc.ShowHorizon);
        WriteBool(section, 'ShowHorizonPicture', csc.ShowHorizonPicture);
        WriteBool(section, 'HorizonPictureLowQuality', csc.HorizonPictureLowQuality);
        WriteFloat(section, 'HorizonPictureRotate', csc.HorizonPictureRotate);
        WriteFloat(section, 'HorizonPictureElevation', csc.HorizonPictureElevation);
        WriteBool(section, 'DarkenHorizonPicture', csc.DarkenHorizonPicture);
        WriteBool(section, 'FillHorizon', csc.FillHorizon);
        WriteBool(section, 'ShowHorizonDepression', csc.ShowHorizonDepression);
        WriteBool(section, 'ShowHorizon0', csc.ShowHorizon0);
        WriteBool(section, 'MeridianWideLine', csc.MeridianWideLine);
        WriteString(section, 'horizonfile', csc.horizonfile);
        WriteString(section, 'HorizonPictureFile', csc.HorizonPictureFile);
        WriteBool(section, 'ShowEqGrid', csc.ShowEqGrid);
        WriteBool(section, 'ShowLabelAll', csc.ShowLabelAll);
        WriteBool(section, 'EditLabels', csc.EditLabels);
        WriteBool(section, 'OptimizeLabels', csc.OptimizeLabels);
        WriteBool(section, 'RotLabel', csc.RotLabel);
        WriteBool(section, 'AltAzMark', csc.AltAzMark);
        WriteBool(section, 'HorizonRise', csc.HorizonRise);
        WriteBool(section, 'AirmassMagnitude', csc.AirmassMagnitude);
        WriteBool(section, 'ShowGrid', csc.ShowGrid);
        WriteBool(section, 'ShowGridNum', csc.ShowGridNum);
        WriteBool(section, 'CenterDecGridNum', csc.CenterDecGridNum);
        WriteBool(section, 'ShowOnlyMeridian', csc.ShowOnlyMeridian);
        WriteBool(section, 'ShowAlwaysMeridian', csc.ShowAlwaysMeridian);
        WriteBool(section, 'ShowConstL', csc.ShowConstL);
        WriteBool(section, 'ShowConstB', csc.ShowConstB);
        WriteBool(section, 'ShowEcliptic', csc.ShowEcliptic);
        WriteBool(section, 'ShowGalactic', csc.ShowGalactic);
        WriteBool(section, 'ShowEquator', csc.ShowEquator);
        WriteBool(section, 'ShowMilkyWay', csc.ShowMilkyWay);
        WriteBool(section, 'FillMilkyWay', csc.FillMilkyWay);
        WriteBool(section, 'LinemodeMilkyway', csc.LinemodeMilkyway);
        WriteString(section, 'URL_SUN_NAME', csc.sunurlname);
        WriteString(section, 'URL_SUN', csc.sunurl);
        WriteInteger(section, 'URL_SUN_SIZE', csc.sunurlsize);
        WriteInteger(section, 'URL_SUN_MARGIN', csc.sunurlmargin);
        WriteInteger(section, 'SunRefreshTime', csc.sunrefreshtime);
        WriteBool(section, 'SunOnline', csc.SunOnline);
        WriteBool(section, 'ShowPluto', csc.ShowPluto);
        WriteBool(section, 'ShowPlanet', csc.ShowPlanet);
        WriteBool(section, 'ShowSmallsat', csc.ShowSmallsat);
        WriteBool(section, 'ShowAsteroid', csc.ShowAsteroid);
        WriteBool(section, 'ShowComet', csc.ShowComet);
        WriteInteger(section, 'SPKCount', csc.SPKlist.Count);
        for i:=1 to csc.SPKlist.Count do
          WriteString(section, 'SPK'+inttostr(i), csc.SPKlist[i-1]);
        WriteBool(section, 'DSLsurface', csc.DSLsurface);
        WriteBool(section, 'DSLforcecolor', csc.DSLforcecolor);
        WriteInteger(section, 'DSLcolor', csc.DSLcolor);
        WriteBool(section, 'SurfaceBlure', csc.SurfaceBlure);
        WriteInteger(section, 'SurfaceAlpha', csc.SurfaceAlpha);
        WriteBool(section, 'ShowImages', csc.ShowImages);
        WriteBool(section, 'ShowStars', csc.showstars);
        WriteBool(section, 'ShowNebulae', csc.shownebulae);
        WriteBool(section, 'ShowLine', csc.showline);
        WriteBool(section, 'ShowImageList', csc.ShowImageList);
        WriteBool(section, 'ShowImageLabel', csc.ShowImageLabel);
        WriteBool(section, 'ShowBackgroundImage', csc.ShowBackgroundImage);
        WriteString(section, 'BackgroundImage', csc.BackgroundImage);
        WriteInteger(section, 'AstSymbol', csc.AstSymbol);
        WriteFloat(section, 'AstmagMax', csc.AstmagMax);
        WriteFloat(section, 'AstmagDiff', csc.AstmagDiff);
        WriteBool(section, 'AstNEO', csc.AstNEO);
        WriteInteger(section, 'ComSymbol', csc.ComSymbol);
        WriteFloat(section, 'CommagMax', csc.CommagMax);
        WriteFloat(section, 'CommagDiff', csc.CommagDiff);
        WriteBool(section, 'MagLabel', csc.MagLabel);
        WriteBool(section, 'NameLabel', csc.NameLabel);
        WriteBool(section, 'DistLabel', csc.DistLabel);
        WriteBool(section, 'DrawAllStarLabel', csc.DrawAllStarLabel);
        WriteBool(section, 'MagNoDecimal', csc.MagNoDecimal);
        WriteBool(section, 'MovedLabelLine', csc.MovedLabelLine);
        WriteBool(section, 'ConstFullLabel', csc.ConstFullLabel);
        WriteBool(section, 'ConstLatinLabel', csc.ConstLatinLabel);
        WriteBool(section, 'PlanetParalaxe', csc.PlanetParalaxe);
        WriteBool(section, 'ShowEarthShadow', csc.ShowEarthShadow);
        WriteBool(section, 'EarthShadowForceLine', csc.EarthShadowForceLine);
        WriteFloat(section, 'GRSlongitude', csc.GRSlongitude);
        WriteFloat(section, 'GRSjd', csc.GRSjd);
        WriteFloat(section, 'GRSdrift', csc.GRSdrift);
        WriteInteger(section, 'StyleGrid', Ord(csc.StyleGrid));
        WriteInteger(section, 'StyleEqGrid', Ord(csc.StyleEqGrid));
        WriteInteger(section, 'StyleConstL', Ord(csc.StyleConstL));
        WriteInteger(section, 'StyleConstB', Ord(csc.StyleConstB));
        WriteInteger(section, 'StyleEcliptic', Ord(csc.StyleEcliptic));
        WriteInteger(section, 'StyleGalEq', Ord(csc.StyleGalEq));
        WriteInteger(section, 'LineWidthGrid', csc.LineWidthGrid);
        WriteInteger(section, 'LineWidthEqGrid', csc.LineWidthEqGrid);
        WriteInteger(section, 'LineWidthConstL', csc.LineWidthConstL);
        WriteInteger(section, 'LineWidthConstB', csc.LineWidthConstB);
        WriteInteger(section, 'LineWidthEcliptic', csc.LineWidthEcliptic);
        WriteInteger(section, 'LineWidthGalEq', csc.LineWidthGalEq);
        WriteInteger(section, 'BGalpha', csc.BGalpha);
        WriteInteger(section, 'BGitt', Ord(csc.BGitt));
        WriteFloat(section, 'BGmin_sigma', csc.BGmin_sigma);
        WriteFloat(section, 'BGmax_sigma', csc.BGmax_sigma);
        WriteFloat(section, 'NEBmin_sigma', csc.NEBmin_sigma);
        WriteFloat(section, 'NEBmax_sigma', csc.NEBmax_sigma);
        WriteInteger(section, 'MaxArchiveImg', csc.MaxArchiveImg);
        for i := 1 to MaxArchiveDir do
          WriteString(section, 'ArchiveDir' + IntToStr(i), csc.ArchiveDir[i]);
        for i := 1 to MaxArchiveDir do
          WriteBool(section, 'ArchiveDirActive' + IntToStr(i), csc.ArchiveDirActive[i]);
        WriteInteger(section, 'Simnb', csc.Simnb);
        WriteInteger(section, 'SimLabel', csc.SimLabel);
        WriteBool(section, 'SimNameLabel', csc.SimNameLabel);
        WriteBool(section, 'SimDateLabel', csc.SimDateLabel);
        WriteBool(section, 'SimDateYear', csc.SimDateYear);
        WriteBool(section, 'SimDateMonth', csc.SimDateMonth);
        WriteBool(section, 'SimDateDay', csc.SimDateDay);
        WriteBool(section, 'SimDateHour', csc.SimDateHour);
        WriteBool(section, 'SimDateMinute', csc.SimDateMinute);
        WriteBool(section, 'SimDateSecond', csc.SimDateSecond);
        WriteBool(section, 'SimMagLabel', csc.SimMagLabel);
        WriteBool(section, 'ShowLegend', csc.ShowLegend);
        WriteInteger(section, 'SimD', csc.SimD);
        WriteInteger(section, 'SimH', csc.SimH);
        WriteInteger(section, 'SimM', csc.SimM);
        WriteInteger(section, 'SimS', csc.SimS);
        WriteBool(section, 'SimLine', csc.SimLine);
        WriteBool(section, 'SimMark', csc.SimMark);
        WriteInteger(section, 'SimAsteroid', csc.SimAsteroid);
        WriteString(section, 'SimComet', csc.SimComet);
        WriteString(section, 'SimAsteroidName', csc.SimAsteroidName);
        WriteString(section, 'SimCometName', csc.SimCometName);
        WriteInteger(section, 'SimBody', csc.SimBody);
        for i := 1 to NumSimObject do
          WriteBool(section, 'SimObject' + IntToStr(i), csc.SimObject[i]);
        for i := 1 to numlabtype do
        begin
          WriteBool(section, 'ShowLabel' + IntToStr(i), csc.ShowLabel[i]);
          WriteFloat(section, 'LabelMag' + IntToStr(i), csc.LabelMagDiff[i]);
          WriteFloat(section, 'LabelOrient' + IntToStr(i), csc.LabelOrient[i]);
        end;
        WriteBool(section, 'ObslistAlLabels', csc.ObslistAlLabels);
        WriteBool(section, 'TrackOn', csc.TrackOn);
        WriteInteger(section, 'TrackType', csc.TrackType);
        WriteInteger(section, 'TrackObj', csc.TrackObj);
        WriteFloat(section, 'TrackDec', csc.TrackDec);
        WriteFloat(section, 'TrackRA', csc.TrackRA);
        WriteFloat(section, 'TrackEpoch', csc.TrackEpoch);
        WriteString(section, 'TrackName', csc.TrackName);
        section := 'observatory';
        WriteFloat(section, 'ObsLatitude', csc.ObsLatitude);
        WriteFloat(section, 'ObsLongitude', csc.ObsLongitude);
        WriteFloat(section, 'ObsAltitude', csc.ObsAltitude);
        WriteFloat(section, 'ObsRH', csc.ObsRH);
        WriteFloat(section, 'ObsTlr', csc.ObsTlr);
        WriteFloat(section, 'ObsTemperature', csc.ObsTemperature);
        WriteFloat(section, 'ObsPressure', csc.ObsPressure);
        WriteString(section, 'ObsName', Condutf8encode(csc.ObsName));
        WriteString(section, 'ObsCountry', csc.ObsCountry);
        WriteString(section, 'ObsTZ', csc.ObsTZ);
        WriteBool(section, 'countrytz', csc.countrytz);
        section := 'date';
        WriteBool(section, 'UseSystemTime', csc.UseSystemTime);
        WriteInteger(section, 'CurYear', csc.CurYear);
        WriteInteger(section, 'CurMonth', csc.CurMonth);
        WriteInteger(section, 'CurDay', csc.CurDay);
        WriteFloat(section, 'CurTime', csc.CurTime);
        WriteBool(section, 'autorefresh', csc.autorefresh);
        WriteBool(section, 'Force_DT_UT', csc.Force_DT_UT);
        WriteFloat(section, 'DT_UT_val', csc.DT_UT_val);
        section := 'projection';
        for i := 1 to maxfield do
          WriteString(section, 'ProjName' + IntToStr(i), csc.projname[i]);
        section := 'labels';
        EraseSection(section);
        WriteInteger(section, 'poslabels', csc.posmodlabels);
        WriteInteger(section, 'numlabels', csc.nummodlabels);
        for i := 1 to csc.nummodlabels do
        begin
          WriteInteger(section, 'labelid' + IntToStr(i), csc.modlabels[i].id);
          WriteInteger(section, 'labeldx' + IntToStr(i), csc.modlabels[i].dx);
          WriteInteger(section, 'labeldy' + IntToStr(i), csc.modlabels[i].dy);
          WriteFloat(section, 'orientation' + IntToStr(i), csc.modlabels[i].orientation);
          WriteFloat(section, 'labelra' + IntToStr(i), csc.modlabels[i].ra);
          WriteFloat(section, 'labeldec' + IntToStr(i), csc.modlabels[i].Dec);
          WriteInteger(section, 'labelnum' + IntToStr(i), csc.modlabels[i].labelnum);
          WriteInteger(section, 'labelfont' + IntToStr(i), csc.modlabels[i].fontnum);
          WriteString(section, 'labeltxt' + IntToStr(i), csc.modlabels[i].txt);
          WriteInteger(section, 'labelalign' + IntToStr(i), Ord(csc.modlabels[i].align));
          WriteBool(section, 'labeluseradec' + IntToStr(i), csc.modlabels[i].useradec);
          WriteBool(section, 'labelhiden' + IntToStr(i), csc.modlabels[i].hiden);
        end;
        section := 'custom_labels';
        WriteInteger(section, 'poslabels', csc.poscustomlabels);
        WriteInteger(section, 'numlabels', csc.numcustomlabels);
        for i := 1 to csc.numcustomlabels do
        begin
          WriteFloat(section, 'labelra' + IntToStr(i), csc.customlabels[i].ra);
          WriteFloat(section, 'labeldec' + IntToStr(i), csc.customlabels[i].Dec);
          WriteInteger(section, 'labelnum' + IntToStr(i), csc.customlabels[i].labelnum);
          WriteString(section, 'labeltxt' + IntToStr(i), csc.customlabels[i].txt);
          WriteInteger(section, 'labelalign' + IntToStr(i),
            Ord(csc.customlabels[i].align));
        end;
        Updatefile;
      end;
    finally
      inif.Free;
      csc.Free;
      cplot.Free;
    end;
  except
  end;
end;

procedure Tf_main.SavePrivateConfig(filename: string);
var
  i, j: integer;
  inif: TMemIniFile;
  section, buf: string;
begin
  try
    inif := TMeminifile.Create(filename);
    try
      with inif do
      begin
        section := 'main';
        WriteString(section, 'AppDir', Appdir);
        WriteString(section, 'version', cdcver);
        WriteString(section, 'PrivateDir', privatedir);
{$if defined(linux) or defined(freebsd)}
        WriteInteger(section, 'LinuxDesktop', LinuxDesktop);
        WriteString(section, 'OpenFileCMD', OpenFileCMD);
{$endif}
        WriteBool(section, 'SaveConfigOnExit', SaveConfigOnExit.Checked);
        WriteBool(section, 'ConfirmSaveConfig', ConfirmSaveConfig);
        WriteBool(section, 'NightVision', NightVision);
        WriteString(section, 'language', cfgm.language);
        WriteInteger(section, 'BtnSize', cfgm.btnsize);
        WriteBool(section, 'BtnCaption', cfgm.btncaption);
        WriteBool(section, 'ScreenScaling', cfgm.ScreenScaling);
        if f_clock <> nil then
          WriteInteger(section, 'ClockColor', f_clock.Font.Color);
        if f_planetinfo <> nil then
          WriteBool(section, 'CenterAtNoon', f_planetinfo.CenterAtNoon);
        WriteInteger(section, 'SesameUrlNum', f_search.SesameUrlNum);
        WriteInteger(section, 'SesameCatNum', f_search.SesameCatNum);
        WriteString(section, 'prtname', cfgm.prtname);
        WriteInteger(section, 'Paper', cfgm.Paper);
        WriteInteger(section, 'PrinterResolution', cfgm.PrinterResolution);
        WriteInteger(section, 'PrintColor', cfgm.PrintColor);
        WriteInteger(section, 'PrintBmpWidth', cfgm.PrintBmpWidth);
        WriteInteger(section, 'PrintBmpHeight', cfgm.PrintBmpHeight);
        WriteBool(section, 'PrintLandscape', cfgm.PrintLandscape);
        WriteInteger(section, 'PrintMethod', cfgm.PrintMethod);
        WriteString(section, 'PrintCmd1', cfgm.PrintCmd1);
        WriteString(section, 'PrintCmd2', cfgm.PrintCmd2);
        WriteString(section, 'PrintTmpPath', cfgm.PrintTmpPath);
        WriteInteger(section, 'PrtLeftMargin', cfgm.PrtLeftMargin);
        WriteInteger(section, 'PrtRightMargin', cfgm.PrtRightMargin);
        WriteInteger(section, 'PrtTopMargin', cfgm.PrtTopMargin);
        WriteInteger(section, 'PrtBottomMargin', cfgm.PrtBottomMargin);
        WriteBool(section, 'PrintHeader', cfgm.PrintHeader);
        WriteBool(section, 'PrintFooter', cfgm.PrintFooter);
        WriteString(section, 'Theme', cfgm.ThemeName);
        WriteInteger(section, 'NightColor', cfgm.NightColor);
        WriteBool(section, 'SimpleMove', cfgm.SimpleMove);
        WriteBool(section, 'WinMaximize', (f_main.WindowState = wsMaximized));
        WriteBool(section, 'AzNorth', catalog.cfgshr.AzNorth);
        WriteBool(section, 'ListStar', catalog.cfgshr.ListStar);
        WriteBool(section, 'ListNeb', catalog.cfgshr.ListNeb);
        WriteBool(section, 'ListVar', catalog.cfgshr.ListVar);
        WriteBool(section, 'ListDbl', catalog.cfgshr.ListDbl);
        WriteBool(section, 'ListPla', catalog.cfgshr.ListPla);
        WriteString(section, 'ffove_tfl', catalog.cfgshr.ffove_tfl);
        WriteString(section, 'ffove_efl', catalog.cfgshr.ffove_efl);
        WriteString(section, 'ffove_efv', catalog.cfgshr.ffove_efv);
        WriteString(section, 'ffovc_tfl', catalog.cfgshr.ffovc_tfl);
        WriteString(section, 'ffovc_px', catalog.cfgshr.ffovc_px);
        WriteString(section, 'ffovc_py', catalog.cfgshr.ffovc_py);
        WriteString(section, 'ffovc_cx', catalog.cfgshr.ffovc_cx);
        WriteString(section, 'ffovc_cy', catalog.cfgshr.ffovc_cy);
        WriteInteger(section, 'autorefreshdelay', cfgm.autorefreshdelay);
        WriteString(section, 'ConstLfile', cfgm.ConstLfile);
        WriteString(section, 'ConstBfile', cfgm.ConstBfile);
        WriteString(section, 'EarthMapFile', cfgm.EarthMapFile);
        WriteString(section, 'PlanetDir', cfgm.PlanetDir);
        WriteString(section, 'ServerIPaddr', cfgm.ServerIPaddr);
        WriteString(section, 'ServerIPport', cfgm.ServerIPport);
        WriteBool(section, 'TextOnlyDetail', cfgm.TextOnlyDetail);
        WriteBool(section, 'AutostartServer', cfgm.AutostartServer);
        WriteInteger(section, 'ServerCoordSys', cfgm.ServerCoordSys);
        WriteString(section, 'db', cfgm.db);
        WriteString(section, 'ImagePath', cfgm.ImagePath);
        WriteBool(section, 'ShowChartInfo', cfgm.ShowChartInfo);
        WriteBool(section, 'ShowTitlePos', cfgm.ShowTitlePos);
        WriteBool(section, 'SyncChart', cfgm.SyncChart);
        WriteInteger(section, 'VOurl', cfgm.VOurl);
        WriteInteger(section, 'VOmaxrecord', cfgm.VOmaxrecord);
        WriteBool(section, 'SampAutoconnect', cfgm.SampAutoconnect);
        WriteBool(section, 'SampKeepTables', cfgm.SampKeepTables);
        WriteBool(section, 'SampKeepImages', cfgm.SampKeepImages);
        WriteBool(section, 'SampConfirmCoord', cfgm.SampConfirmCoord);
        WriteBool(section, 'SampConfirmImage', cfgm.SampConfirmImage);
        WriteBool(section, 'SampConfirmTable', cfgm.SampConfirmTable);
        WriteBool(section, 'SampSubscribeCoord', cfgm.SampSubscribeCoord);
        WriteBool(section, 'SampSubscribeImage', cfgm.SampSubscribeImage);
        WriteBool(section, 'SampSubscribeTable', cfgm.SampSubscribeTable);
        WriteInteger(section, 'AnimDelay', cfgm.AnimDelay);
        WriteFloat(section, 'AnimFps', cfgm.AnimFps);
        //WriteBool(section,'AnimRec',cfgm.AnimRec);
        WriteString(section, 'AnimRecDir', cfgm.AnimRecDir);
        WriteString(section, 'AnimRecPrefix', cfgm.AnimRecPrefix);
        WriteString(section, 'AnimRecExt', cfgm.AnimRecExt);
        WriteString(section, 'Animffmpeg', cfgm.Animffmpeg);
        WriteInteger(section, 'AnimSx', cfgm.AnimSx);
        WriteInteger(section, 'AnimSy', cfgm.AnimSy);
        WriteInteger(section, 'AnimSize', cfgm.AnimSize);
        WriteString(section, 'AnimOpt', cfgm.AnimOpt);
        WriteBool(section, 'HttpProxy', cfgm.HttpProxy);
        WriteBool(section, 'SocksProxy', cfgm.SocksProxy);
        WriteString(section, 'SocksType', cfgm.SocksType);
        WriteBool(section, 'FtpPassive', cfgm.FtpPassive);
        WriteBool(section, 'ConfirmDownload', cfgm.ConfirmDownload);
        WriteString(section, 'ProxyHost', cfgm.ProxyHost);
        WriteString(section, 'ProxyPort', cfgm.ProxyPort);
        WriteString(section, 'ProxyUser', cfgm.ProxyUser);
        WriteString(section, 'ProxyPass', cfgm.ProxyPass);
        WriteString(section, 'AnonPass', cfgm.AnonPass);
        WriteString(section, 'starshape_file', cfgm.starshape_file);
        WriteString(section, 'tlelst', f_calendar.tle1.Text);
        WriteInteger(section, 'HorizonNumDay', cfgm.HorizonNumDay);
        j := cfgm.CometUrlList.Count;
        WriteInteger(section, 'CometUrlCount', j);
        if j > 0 then
        begin
          for i := 1 to j do
            WriteString(section, 'CometUrl' + IntToStr(i), cfgm.CometUrlList[i - 1]);
        end;
        j := cfgm.AsteroidUrlList.Count;
        WriteInteger(section, 'AsteroidUrlCount', j);
        if j > 0 then
        begin
          for i := 1 to j do
            WriteString(section, 'AsteroidUrl' + IntToStr(i),
              cfgm.AsteroidUrlList[i - 1]);
        end;
        j := cfgm.TleUrlList.Count;
        WriteInteger(section, 'TleUrlCount', j);
        if (j > 0) then
        begin
          for i := 1 to j do
            WriteString(section, 'TleUrl' + IntToStr(i), cfgm.TleUrlList[i - 1]);
        end;
        j := cfgm.ObsNameList.Count;
        WriteInteger(section, 'ObsNameListCount', j);
        if j > 0 then
          for i := 0 to j - 1 do
          begin
            if cfgm.ObsNameList.Objects[i] <> nil then
            begin
              WriteString(section, 'ObsCountry' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).country);
              WriteBool(section, 'ObsCountryTZ' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).countrytz);
              WriteString(section, 'ObsTZ' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).tz);
              WriteFloat(section, 'ObsLat' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).lat);
              WriteFloat(section, 'ObsLon' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).lon);
              WriteFloat(section, 'ObsAlt' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).alt);
              WriteString(section, 'Obshorizonfn' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).horizonfn);
              WriteString(section, 'Obshorizonpictfn' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).horizonpictfn);
              WriteFloat(section, 'Obspictureangleoffset' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).pictureangleoffset);
              WriteBool(section, 'Obsshowhorizonline' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).showhorizonline);
              WriteBool(section, 'Obsshowhorizonpicture' + IntToStr(i),
                TObsDetail(cfgm.ObsNameList.Objects[i]).showhorizonpicture);
              WriteString(section, 'ObsName' + IntToStr(i), cfgm.ObsNameList[i]);
            end;
          end;
        WriteBool(section, 'ManualTelescope', def_cfgsc.ManualTelescope);
        WriteInteger(section, 'ManualTelescopeType', def_cfgsc.ManualTelescopeType);
        WriteFloat(section, 'TelescopeTurnsX', def_cfgsc.TelescopeTurnsX);
        WriteFloat(section, 'TelescopeTurnsY', def_cfgsc.TelescopeTurnsY);
        if MultiFrame1.ActiveObject is Tf_chart then
        with (MultiFrame1.ActiveObject as Tf_chart).sc do begin
          WriteString(section, 'AscomDevice', cfgsc.AscomDevice);
          WriteBool(section, 'TelescopeAltAz', cfgsc.TelescopeAltAz);
          WriteBool(section, 'TelescopeAutoconnect', cfgsc.TelescopeAutoconnect);
          WriteInteger(section, 'TelescopeInterval', cfgsc.TelescopeInterval);
          WriteInteger(section, 'TelescopeInterface', cfgsc.TelescopeInterface);
          WriteInteger(section, 'AlpacaProtocol', cfgsc.AlpacaProtocol);
          WriteString(section, 'AlpacaId', cfgsc.AlpacaId);
          WriteString(section, 'AlpacaHost', cfgsc.AlpacaHost);
          WriteInteger(section, 'AlpacaPort', cfgsc.AlpacaPort);
          WriteString(section, 'AlpacaUser', strtohex(encryptStr(cfgsc.AlpacaUser, encryptpwd)));
          WriteString(section, 'AlpacaPass', strtohex(encryptStr(cfgsc.AlpacaPass, encryptpwd)));
          WriteInteger(section, 'AlpacaDevice', cfgsc.AlpacaDevice);
          WriteInteger(section, 'TelescopeLeft', cfgsc.TelescopeLeft);
          WriteInteger(section, 'TelescopeTop', cfgsc.TelescopeTop);
          WriteString(section, 'IndiServerHost', cfgsc.IndiServerHost);
          WriteString(section, 'IndiServerPort', cfgsc.IndiServerPort);
          WriteString(section, 'IndiDevice', cfgsc.IndiDevice);
          WriteString(section, 'IndiServerHost', cfgsc.IndiServerHost);
          WriteString(section, 'IndiServerPort', cfgsc.IndiServerPort);
          WriteString(section, 'IndiDevice', cfgsc.IndiDevice);
        end
        else begin
          WriteString(section, 'AscomDevice', def_cfgsc.AscomDevice);
          WriteBool(section, 'TelescopeAltAz', def_cfgsc.TelescopeAltAz);
          WriteBool(section, 'TelescopeAutoconnect', def_cfgsc.TelescopeAutoconnect);
          WriteInteger(section, 'TelescopeInterval', def_cfgsc.TelescopeInterval);
          WriteInteger(section, 'TelescopeInterface', def_cfgsc.TelescopeInterface);
          WriteInteger(section, 'AlpacaProtocol', def_cfgsc.AlpacaProtocol);
          WriteString(section, 'AlpacaId', def_cfgsc.AlpacaId);
          WriteString(section, 'AlpacaHost', def_cfgsc.AlpacaHost);
          WriteInteger(section, 'AlpacaPort', def_cfgsc.AlpacaPort);
          WriteString(section, 'AlpacaUser', strtohex(encryptStr(def_cfgsc.AlpacaUser, encryptpwd)));
          WriteString(section, 'AlpacaPass', strtohex(encryptStr(def_cfgsc.AlpacaPass, encryptpwd)));
          WriteInteger(section, 'AlpacaDevice', def_cfgsc.AlpacaDevice);
          WriteInteger(section, 'TelescopeLeft', def_cfgsc.TelescopeLeft);
          WriteInteger(section, 'TelescopeTop', def_cfgsc.TelescopeTop);
          WriteString(section, 'IndiServerHost', def_cfgsc.IndiServerHost);
          WriteString(section, 'IndiServerPort', def_cfgsc.IndiServerPort);
          WriteString(section, 'IndiDevice', def_cfgsc.IndiDevice);
        end;
        WriteFloat(section, 'TelLimitDecMax', def_cfgsc.TelLimitDecMax);
        WriteFloat(section, 'TelLimitDecMin', def_cfgsc.TelLimitDecMin);
        WriteFloat(section, 'TelLimitHaE', def_cfgsc.TelLimitHaE);
        WriteFloat(section, 'TelLimitHaW', def_cfgsc.TelLimitHaW);
        WriteBool(section, 'TelLimitDecMaxActive', def_cfgsc.TelLimitDecMaxActive);
        WriteBool(section, 'TelLimitDecMinActive', def_cfgsc.TelLimitDecMinActive);
        WriteBool(section, 'TelLimitHaEActive', def_cfgsc.TelLimitHaEActive);
        WriteBool(section, 'TelLimitHaWActive', def_cfgsc.TelLimitHaWActive);
        WriteBool(section, 'ViewMainBar', PanelToolBarMain.Visible);
        WriteBool(section, 'ViewLeftBar', PanelLeft.Visible);
        WriteBool(section, 'ViewRightBar', PanelRight.Visible);
        WriteBool(section, 'ViewObjectBar', ToolBarObj.Visible);
        WriteBool(section, 'ViewScrollBar', MenuViewScrollBar.Checked);
        WriteBool(section, 'ViewStatusBar', MenuViewStatusBar.Checked);
        WriteInteger(section, 'NumChart', MultiFrame1.ChildCount);
        WriteInteger(section, 'Detail_Width', f_detail.Width);
        WriteInteger(section, 'Detail_Height', f_detail.Height);
        WriteInteger(section, 'ScriptWidth', ScriptPanel.Width);
        WriteInteger(section, 'GregorianStart', GregorianStart);
        WriteInteger(section, 'GregorianStartJD', GregorianStartJD);

        section := 'catalog';
        for i := 1 to maxstarcatalog do
        begin
          WriteString(section, 'starcatpath' + IntToStr(i),
            catalog.cfgcat.starcatpath[i]);
        end;
        for i := 1 to maxvarstarcatalog do
        begin
          WriteString(section, 'varstarcatpath' + IntToStr(i),
            catalog.cfgcat.varstarcatpath[i]);
        end;
        for i := 1 to maxdblstarcatalog do
        begin
          WriteString(section, 'dblstarcatpath' + IntToStr(i),
            catalog.cfgcat.dblstarcatpath[i]);
        end;
        for i := 1 to maxnebcatalog do
        begin
          WriteString(section, 'nebcatpath' + IntToStr(i), catalog.cfgcat.nebcatpath[i]);
        end;
        section := 'dss';
        WriteBool(section, 'dssnorth', f_getdss.cfgdss.dssnorth);
        WriteBool(section, 'dsssouth', f_getdss.cfgdss.dsssouth);
        WriteBool(section, 'dss102', f_getdss.cfgdss.dss102);
        WriteBool(section, 'dsssampling', f_getdss.cfgdss.dsssampling);
        WriteBool(section, 'dssplateprompt', f_getdss.cfgdss.dssplateprompt);
        WriteBool(section, 'dssarchive', f_getdss.cfgdss.dssarchive);
        WriteBool(section, 'dssarchiveprompt', f_getdss.cfgdss.dssarchiveprompt);
        WriteString(section, 'dssarchivedir', f_getdss.cfgdss.dssarchivedir);
        WriteInteger(section, 'dssmaxsize', f_getdss.cfgdss.dssmaxsize);
        WriteString(section, 'dssdir', f_getdss.cfgdss.dssdir);
        WriteString(section, 'dssdrive', f_getdss.cfgdss.dssdrive);
        for i := 1 to MaxDSSurl do
        begin
          WriteString(section, 'DSSurlName' + IntToStr(i), f_getdss.cfgdss.DSSurl[i, 0]);
          WriteString(section, 'DSSurl' + IntToStr(i), f_getdss.cfgdss.DSSurl[i, 1]);
        end;
        WriteBool(section, 'OnlineDSS', f_getdss.cfgdss.OnlineDSS);
        WriteInteger(section, 'OnlineDSSid', f_getdss.cfgdss.OnlineDSSid);
        section := 'jpleph';
        WriteInteger(section, 'num', nJPL_DE);
        for i := 1 to nJPL_DE do
          WriteInteger(section, 'JPL_DE' + IntToStr(i), JPL_DE[i]);
        section := 'obslist';
        buf := UTF8ToSys(f_obslist.FileNameEdit1.FileName);
        if buf <> '' then
        begin
          WriteString(section, 'listname', buf);
        end;
        WriteString(section, 'airmass', f_obslist.AirmassCombo.Text);
        WriteBool(section, 'airmasslimit1', f_obslist.LimitAirmassTonight.Checked);
        WriteBool(section, 'airmasslimit2', f_obslist.LimitAirmassNow.Checked);
        WriteString(section, 'hourangle', f_obslist.HourAngleCombo.Text);
        WriteBool(section, 'houranglelimit1', f_obslist.LimitHourangleTonight.Checked);
        WriteBool(section, 'houranglelimit2', f_obslist.LimitHourangleNow.Checked);
        WriteInteger(section, 'limittype', f_obslist.LimitType);
        WriteInteger(section, 'meridianside', f_obslist.MeridianSide);
        section := 'toolbar';
        EraseSection(section);
        WriteInteger(section, 'nummainbar', nummainbar);
        for i := 0 to nummainbar - 1 do
          WriteString(section, 'mainbar' + IntToStr(i), configmainbar[i]);
        WriteInteger(section, 'numobjectbar', numobjectbar);
        for i := 0 to numobjectbar - 1 do
          WriteString(section, 'objectbar' + IntToStr(i), configobjectbar[i]);
        WriteInteger(section, 'numleftbar', numleftbar);
        for i := 0 to numleftbar - 1 do
          WriteString(section, 'leftbar' + IntToStr(i), configleftbar[i]);
        WriteInteger(section, 'numrightbar', numrightbar);
        for i := 0 to numrightbar - 1 do
          WriteString(section, 'rightbar' + IntToStr(i), configrightbar[i]);
        // Script panel
        for i := 0 to numscript - 1 do
        begin
          section := 'ScriptPanel' + IntToStr(i);
          EraseSection(section);
          WriteBool(section, 'visible', Fscript[i].Visible);
          WriteString(section, 'ScriptFile', Fscript[i].ScriptFilename);
        end;
        Updatefile;
      end;
    finally
      inif.Free;
    end;
  except
  end;
end;

procedure Tf_main.SaveQuickSearch(filename: string);
var
  i, j: integer;
  inif: TMemIniFile;
  section: string;
begin
  try
    inif := TMeminifile.Create(filename);
    try
      with inif do
      begin
        section := 'quicksearch';
        j := min(MaxQuickSearch, quicksearch.Items.Count);
        WriteInteger(section, 'count', j);
        for i := 1 to j do
          WriteString(section, 'item' + IntToStr(i), quicksearch.Items[i - 1]);
        Updatefile;
      end;
    finally
      inif.Free;
    end;
  except
  end;
end;

procedure Tf_main.SaveConfigOnExitExecute(Sender: TObject);
var
  inif: TMemIniFile;
  section: string;
begin
  try
    SaveConfigOnExit.Checked := not SaveConfigOnExit.Checked;
    ConfirmSaveConfig := True;
    inif := TMeminifile.Create(configfile);
    try
      with inif do
      begin
        section := 'main';
        WriteBool(section, 'SaveConfigOnExit', SaveConfigOnExit.Checked);
        WriteBool(section, 'ConfirmSaveConfig', ConfirmSaveConfig);
        Updatefile;
      end;
    finally
      inif.Free;
    end;
  except
  end;
end;

procedure Tf_main.ChangeLanguage(newlang: string);
var
  inif: TMemIniFile;
  i: integer;
begin
  try
    cfgm.language := newlang;
    inif := TMeminifile.Create(configfile);
    try
      with inif do
      begin
        WriteString('main', 'language', cfgm.language);
        Updatefile;
      end;
    finally
      inif.Free;
    end;
    lang := u_translation.translate(cfgm.language);
    SetLang;
    InitFonts;
    f_position.SetLang;
    f_search.SetLang;
    f_zoom.SetLang;
    f_getdss.SetLang;
    f_manualtelescope.SetLang;
    f_detail.SetLang;
    f_info.SetLang;
    f_calendar.SetLang;
    f_printsetup.SetLang;
    f_print.SetLang;
    f_edittoolbar.SetLang;
    f_mosaic.SetLang;
    f_prepoint.SetLang;
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
        Tf_chart(MultiFrame1.Childs[i].DockedObject).SetLang;
    if f_planetinfo <> nil then
      f_planetinfo.SetLang;
    if f_config <> nil then
      f_config.SetLang;
    if f_about <> nil then
      f_about.SetLang;
    if ConfigSystem <> nil then
      ConfigSystem.SetLang;
    if ConfigInternet <> nil then
      ConfigInternet.SetLang;
    if ConfigSolsys <> nil then
      ConfigSolsys.SetLang;
    if ConfigChart <> nil then
      ConfigChart.SetLang;
    if ConfigTime <> nil then
      ConfigTime.SetLang;
    if ConfigObservatory <> nil then
      ConfigObservatory.SetLang;
    if ConfigDisplay <> nil then
      ConfigDisplay.SetLang;
    if ConfigPictures <> nil then
      ConfigPictures.SetLang;
    if ConfigCatalog <> nil then
      ConfigCatalog.SetLang;
    if samp <> nil then
    begin
      samp.hubprofileerror := rsUnsupportedS;
      samp.hubmissingvalue := rsSAMPHubProfi;
      samp.nohuberror := rsNoSAMPHubPro;
    end;
    if f_clock <> nil then
      f_clock.SetLang;
    if f_updcatalog <> nil then
      f_updcatalog.SetLang;
    InitToolBar;
  except
  end;
end;

procedure Tf_main.SetLang;
var
  i: integer;
  accel: string;
begin
  ldeg := #$C2#$B0;
  lmin := '''';
  lsec := '"';
  {$ifdef lclqt5}
  accel := '';          // make repeated Alt key press to crash
  {$else}
    {$ifdef lclcocoa}
    accel := '';
    {$else}
      {$ifdef lclqt6}
        accel := '';
      {$else}
        accel := '&';
      {$endif}
    {$endif}
  {$endif}
  // Tool bar
  ToolBarMain.Caption := rsMainBar;
  ToolBarObj.Caption := rsObjectBar;
  ToolBarLeft.Caption := rsLeftBar;
  ToolBarRight.Caption := rsRightBar;
  // Action category
  CatAnimation := rsAnimation;
  CatDirection := rsDirection2;
  CatDrawing := rsDrawing;
  CatEdit := rsEdit;
  CatFile := rsFile;
  CatFilter := rsFilter2;
  CatFOV := rsFOV;
  CatGrid := rsCoordGrid;
  CatInformation := rsInfo;
  CatLabel := rsLabel2;
  CatLines := rsLines;
  CatLock := rsLock;
  CatObject := rsObject;
  CatOrientation := rsOrientation;
  CatPictures := rsPictures;
  CatPrint := rsPrint;
  CatProjection := rsProjection;
  CatSearch := rsSearch;
  CatSetup := rsSetup;
  CatSetupOption := rsSetupOption;
  CatTelescope := rsTelescope;
  CatTools := rsTools;
  CatUndo := rsUndo;
  CatView := rsView;
  CatWindow := rsWindow;
  CatZoom := rsZoom3;
  // Actions
  // Menu File
  FileNew1.Caption := accel + rsNewChart;
  FileNew1.hint := rsCreateANewCh;
  FileNew1.Category := CatFile;
  FileOpen1.Caption := accel + rsOpen + Ellipsis;
  FileOpen1.hint := rsOpenAChart;
  FileOpen1.Category := CatFile;
  FileSaveAs1.Caption := accel + rsSaveAs;
  FileSaveAs1.hint := rsSaveTheCurre;
  FileSaveAs1.Category := CatFile;
  FileRenameChart.Caption:=accel + rsRenameChart;
  FileRenameChart.Hint:=rsRenameTheCur;
  FileRenameChart.Category := CatFile;
  Calendar.Caption := accel + rsCalendar + Ellipsis;
  Calendar.hint := rsEphemerisCal;
  Calendar.Category := CatTools;
  Obslist.Caption := accel + rsObservingLis + Ellipsis;
  ObsList.Hint := rsObservingLis;
  ObsList.Category := CatTools;
  Mosaic.Caption := accel + rsMosaic;
  Mosaic.Hint := rsMosaic;
  Mosaic.Category := CatTools;
  PolePrecession.Caption := accel + rsPolePrecessi;
  PolePrecession.Hint := rsPolePrecessi;
  PolePrecession.Category := CatTools;
  SaveImage.Caption := accel + rsSaveImage;
  SaveImage.Hint := rsSaveImage;
  SaveImage.Category := CatFile;
  Print1.Caption := accel + rsPrint + Ellipsis;
  Print1.hint := rsPrintTheChar;
  Print1.Category := CatPrint;
  FilePrintSetup1.Caption := accel + rsPrinterSetup + Ellipsis;
  FilePrintSetup1.Hint := rsPrinterSetup;
  FilePrintSetup1.Category := CatPrint;
  FileExit1.Caption := accel + rsExit;
  FileExit1.Hint := rsExit;
  FileExit1.Category := CatFile;
  // Menu Edit
  Search1.Caption := accel + rsAdvancedSear + Ellipsis;
  Search1.hint := rsAdvancedSear;
  Search1.Category := CatSearch;
  Editlabels.Caption := accel + rsEditLabel;
  Editlabels.hint := rsEditLabel;
  Editlabels.Category := CatEdit;
  EditCopy1.Caption := accel + rsCopy;
  EditCopy1.Hint := rsCopy;
  EditCopy1.Category := CatEdit;
  Undo.Caption := accel + rsUndo;
  Undo.hint := rsUndoLastChan;
  Undo.Category := CatUndo;
  Redo.Caption := accel + rsRedo;
  Redo.hint := rsRedoLastChan;
  Redo.Category := CatUndo;
  // Menu Setup
  SetupTime.Caption := accel + rsDateTime + Ellipsis;
  SetupTime.hint := rsSetDateAndTi;
  SetupTime.Category := CatSetupOption;
  SetupObservatory.Caption := accel + rsObservatory + Ellipsis;
  SetupObservatory.hint := rsSetObservato;
  SetupObservatory.Category := CatSetupOption;
  SetupDisplay.Caption := accel + rsDisplay + Ellipsis;
  SetupDisplay.Hint := rsDisplay;
  SetupDisplay.Category := CatSetupOption;
  SetupChart.Caption := accel + rsChartCoordin + Ellipsis;
  SetupChart.Hint := rsChartCoordin;
  SetupChart.Category := CatSetupOption;
  SetupCatalog.Caption := accel + rsCatalog + Ellipsis;
  SetupCatalog.Hint := rsCatalog;
  SetupCatalog.Category := CatSetupOption;
  SetupSolSys.Caption := accel + rsSolarSystem + Ellipsis;
  SetupSolSys.Hint := rsSolarSystem;
  SetupSolSys.Category := CatSetupOption;
  SetupSystem.Caption := accel + rsGeneral + Ellipsis;
  SetupSystem.Hint := rsGeneral;
  SetupSystem.Category := CatSetupOption;
  SetupInternet.Caption := accel + rsUpdate1 + Ellipsis;
  SetupInternet.Hint := rsUpdate1;
  SetupInternet.Category := CatSetupOption;
  SetupPictures.Caption := accel + rsPictures + Ellipsis;
  SetupPictures.Hint := rsPictures;
  SetupPictures.Category := CatSetupOption;
  SetupCalendar.Caption := accel + rsCalendar + Ellipsis;
  SetupCalendar.Hint := rsCalendar;
  SetupCalendar.Category := CatSetupOption;
  SetupConfig.Caption := accel + rsAllConfigura + Ellipsis;
  SetupConfig.Hint := rsAllConfigura;
  SetupConfig.Category := CatSetup;
  ConfigPopup.Caption := rsConfigureThe;
  ConfigPopup.hint := rsConfigureThe;
  ConfigPopup.Category := CatSetup;
  SaveConfiguration.Caption := accel + rsSaveConfigur;
  SaveConfiguration.Hint := rsSaveConfigur;
  SaveConfiguration.Category := CatSetup;
  SaveConfigOnExit.Caption := accel + rsSaveConfigur2;
  SaveConfigOnExit.Category := CatSetup;
  // Menu View
  ViewFullScreen.Caption := accel + rsFullScreen;
  ViewFullScreen.Hint := rsFullScreen;
  ViewFullScreen.Category := CatView;
  ViewNightVision.Caption := accel + rsNightVision;
  ViewNightVision.hint := rsNightVisionC;
  ViewNightVision.Category := CatView;
  ViewAllTollbar.Caption := accel + rsAllToolsBar;
  ViewMainMenu.Caption := accel + rsMainMenu +' (Ctrl+Shift+M)';
  ViewServerInfo.Caption := accel + rsServerInform + Ellipsis;
  ViewServerInfo.Hint := rsServerInform;
  ViewServerInfo.Category := CatInformation;
  ViewClock.Caption := accel + rsClock + Ellipsis;
  ViewClock.Hint := rsClock;
  ViewClock.Category := CatInformation;
  PlanetInfo.Caption := accel + rsSolarSystemI + Ellipsis;
  PlanetInfo.Hint := rsSolarSystemI;
  PlanetInfo.Category := CatInformation;
  ZoomBar.Caption := accel + rsSetFOV + Ellipsis;
  ZoomBar.hint := rsSetFOV;
  ZoomBar.Category := CatZoom;
  zoomplus.Caption := accel + rsZoomIn;
  zoomplus.hint := rsZoomIn;
  zoomplus.Category := CatZoom;
  zoomminus.Caption := accel + rsZoomOut;
  zoomminus.hint := rsZoomOut;
  zoomminus.Category := CatZoom;
  Position.Caption := accel + rsPosition + Ellipsis;
  Position.hint := rsPosition;
  Position.Category := CatView;
  listobj.Caption := accel + rsObjectList + Ellipsis;
  listobj.hint := rsObjectList;
  listobj.Category := CatInformation;
  ListImg.Caption := accel + rsImageList;
  ListImg.Hint := rsImageList;
  ListImg.Category := CatPictures;
  BlinkImage.Caption := accel + rsBlinkingPict;
  BlinkImage.hint := rsBlinkingPict;
  BlinkImage.Category := CatPictures;
  switchbackground.Caption := accel + rsSkyBackgroun;
  switchbackground.hint := rsSkyBackgroun;
  switchbackground.Category := CatView;
  MouseMode.Caption := rsChangeMouseM;
  MouseMode.Hint := rsChangeMouseM;
  MouseMode.Category := CatView;
  ScaleMode.Caption := rsDistanceMeas;
  ScaleMode.Hint := rsDistanceMeas;
  ScaleMode.Category := CatView;
  Trajectories.Caption := rsTrajectories + Ellipsis;
  Trajectories.Hint := rsTrajectories;
  Trajectories.Category := CatView;
  // Menu Chart
  EquatorialProjection.Caption := accel + rsEquatorialCo;
  EquatorialProjection.hint := rsEquatorialCo;
  EquatorialProjection.Category := CatProjection;
  AltAzProjection.Caption := accel + rsAltAzCoordin;
  AltAzProjection.hint := rsAltAzCoordin;
  AltAzProjection.Category := CatProjection;
  EclipticProjection.Caption := accel + rsEclipticCoor;
  EclipticProjection.hint := rsEclipticCoor;
  EclipticProjection.Category := CatProjection;
  GalacticProjection.Caption := accel + rsGalacticCoor;
  GalacticProjection.hint := rsGalacticCoor;
  GalacticProjection.Category := CatProjection;
  FlipX.Caption := accel + rsMirrorHorizo;
  FlipX.hint := rsMirrorHorizo;
  FlipX.Category := CatOrientation;
  FlipY.Caption := accel + rsMirrorVertic;
  FlipY.hint := rsMirrorVertic;
  FlipY.Category := CatOrientation;
  rot_plus.Caption := accel + rsRotateRight;
  rot_plus.hint := rsRotateRight;
  rot_plus.Category := CatOrientation;
  rot_minus.Caption := accel + rsRotateLeft;
  rot_minus.hint := rsRotateLeft;
  rot_minus.Category := CatOrientation;
  rotate180.Caption := accel + rsRotateBy180D;
  rotate180.Hint := rsRotateBy180D;
  rotate180.Category := CatOrientation;
  allSky.Caption := accel + rsShowAllSky;
  AllSky.hint := rsShowAllSky;
  AllSky.Category := CatDirection;
  toN.Caption := accel + rsNorth;
  toN.hint := rsNorth;
  toN.Category := CatDirection;
  toS.Caption := accel + rsSouth;
  toS.hint := rsSouth;
  toS.Category := CatDirection;
  toE.Caption := accel + rsEast;
  toE.hint := rsEast;
  toE.Category := CatDirection;
  toW.Caption := accel + rsWest;
  toW.hint := rsWest;
  toW.Category := CatDirection;
  toZenith.Caption := accel + rsZenith;
  toZenith.hint := rsZenith;
  toZenith.Category := CatDirection;
  switchstars.Caption := rsChangeDrawin;
  switchstars.hint := rsChangeDrawin;
  switchstars.Category := CatDrawing;
  ShowStars.Caption := accel + rsShowStars;
  ShowStars.hint := rsShowStars;
  ShowStars.Category := CatObject;
  ShowNebulae.Caption := accel + rsShowNebulae;
  ShowNebulae.hint := rsShowNebulae;
  ShowNebulae.Category := CatObject;
  ShowPictures.Caption := accel + rsShowPictures;
  ShowPictures.hint := rsShowPictures;
  ShowPictures.Category := CatObject;
  ShowLines.Caption := accel + rsShowDSOLines;
  ShowLines.hint := rsShowDSOLines;
  ShowLines.Category := CatObject;
  ShowPlanets.Caption := accel + rsShowPlanets;
  ShowPlanets.hint := rsShowPlanets;
  ShowPlanets.Category := CatObject;
  ShowAsteroids.Caption := accel + rsShowAsteroid;
  ShowAsteroids.hint := rsShowAsteroid;
  ShowAsteroids.Category := CatObject;
  ShowComets.Caption := accel + rsShowComets;
  ShowComets.hint := rsShowComets;
  ShowComets.Category := CatObject;
  ShowMilkyWay.Caption := accel + rsShowMilkyWay;
  ShowMilkyWay.hint := rsShowMilkyWay;
  ShowMilkyWay.Category := CatObject;
  Grid.Caption := accel + rsShowCoordina;
  Grid.hint := rsShowCoordina;
  Grid.Category := CatGrid;
  MenuShowGridEQ.Caption := accel + rsAddEquatoria;
  GridEq.hint := rsAddEquatoria;
  GridEq.Category := CatGrid;
  ShowCompass.Caption := rsShowCompass;
  ShowCompass.Hint := rsShowCompass;
  ShowCompass.Category := CatGrid;
  ShowConstellationLine.Caption := accel + rsShowConstell;
  ShowConstellationLine.hint := rsShowConstell;
  ShowConstellationLine.Category := CatLines;
  ShowConstellationLimit.Caption := accel + rsShowConstell2;
  ShowConstellationLimit.hint := rsShowConstell2;
  ShowConstellationLimit.Category := CatLines;
  ShowGalacticEquator.Caption := accel + rsShowGalactic;
  ShowGalacticEquator.hint := rsShowGalactic;
  ShowGalacticEquator.Category := CatLines;
  ShowEcliptic.Caption := accel + rsShowEcliptic;
  ShowEcliptic.hint := rsShowEcliptic;
  ShowEcliptic.Category := CatLines;
  ShowMark.Caption := accel + rsShowMark;
  ShowMark.hint := rsShowMark;
  ShowMark.Category := CatLines;
  ShowLabels.Caption := accel + rsShowLabels;
  ShowLabels.hint := rsShowLabels;
  ShowLabels.Category := CatLabel;
  ViewChartInfo.Caption := rsChartInforma;
  ViewChartInfo.Hint := rsChartInforma;
  ViewChartInfo.Category := CatLabel;
  ViewChartLegend.Caption := rsChartLegend;
  ViewChartLegend.Hint := rsChartLegend;
  ViewChartLegend.Category := CatLabel;
  ResetRotation.Caption := rsResetRotatio;
  ResetRotation.Hint := rsResetRotatio;
  ResetRotation.Category := CatOrientation;
  ShowObjectbelowHorizon.Caption := accel + rsShowObjectBe;
  ShowObjectbelowHorizon.hint := rsShowObjectBe;
  ShowObjectbelowHorizon.Category := CatDrawing;
  ShowBackgroundImage.Caption := accel + rsShowHideDSSI;
  ShowBackgroundImage.Hint := rsShowHideDSSI;
  ShowBackgroundImage.Category := CatDrawing;
  SetPictures.Caption := accel + rsShowTheImage;
  SetPictures.hint := rsShowTheImage;
  SetPictures.Category := CatPictures;
  MoreStar.Caption := accel + rsMoreStars;
  MoreStar.Hint := rsMoreStars;
  MoreStar.Category := CatFilter;
  LessStar.Caption := accel + rsLessStars;
  LessStar.Hint := rsLessStars;
  LessStar.Category := CatFilter;
  MoreNeb.Caption := accel + rsMoreNebulae;
  MoreNeb.Hint := rsMoreNebulae;
  MoreNeb.Category := CatFilter;
  LessNeb.Caption := accel + rsLessNebulae;
  LessNeb.Hint := rsLessNebulae;
  LessNeb.Category := CatFilter;
  LockMagnitude.Caption := accel + rsLockMagnitud;
  LockMagnitude.Hint := rsLockMagnitud;
  LockMagnitude.Category := CatFilter;
  DSSImage.Caption := accel + rsGetDSSImage + Ellipsis;
  DSSImage.hint := rsGetDSSImage;
  DSSImage.Category := CatDrawing;
  ShowVO.Caption := rsShowVirtualO;
  ShowVO.Hint := rsShowVirtualO;
  ShowVO.Category := CatObject;
  ShowUObj.Caption := rsShowUserDefi;
  ShowUObj.Hint := rsShowUserDefi;
  ShowUObj.Category := CatObject;

  // Menu Telescope
  TelescopeSetup.Caption := accel + rsTelescopeSet + Ellipsis;
  TelescopeSetup.Hint := rsTelescopeSet;
  TelescopeSetup.Category := CatSetup;
  telescopeConnect.Caption := accel + rsConnectTeles + Ellipsis;
  telescopeConnect.hint := rsConnectTeles;
  telescopeConnect.Category := CatTelescope;
  TelescopePanel.Caption := '&INDI ' + rsControlPanel + Ellipsis;
  TelescopePanel.Hint := 'INDI ' + rsControlPanel;
  TelescopePanel.Category := CatSetup;
  TelescopeSlew.Caption := accel + rsSlew;
  TelescopeSlew.hint := rsSlew;
  TelescopeSlew.Category := CatTelescope;
  TelescopeAbortSlew.Caption := rsAbortSlew;
  TelescopeAbortSlew.Hint := rsAbortSlew;
  TelescopeAbortSlew.Category := CatTelescope;
  TelescopeSync.Caption := accel + rsSync;
  TelescopeSync.hint := rsSync;
  TelescopeSync.Category := CatTelescope;
  TrackTelescope.Caption := rsTrackTelesco;
  TrackTelescope.Hint := rsTrackTelesco;
  TrackTelescope.Category := CatTelescope;
  //Menu Window
  SyncChart.Caption := accel + rsLinkAllChart;
  SyncChart.hint := rsLinkAllChart;
  SyncChart.Category := CatLock;
  Track.Caption := rsNoObjectToLo;
  Track.hint := rsNoObjectToLo;
  Track.Category := CatLock;
  MenuLockChart.Caption := rsLockChartPos;
  Cascade1.Caption := accel + rsCascade;
  Cascade1.hint := rsCascade;
  Cascade1.Category := CatWindow;
  TileHorizontal1.Caption := accel + rsTileHorizont;
  TileHorizontal1.Hint := rsTileHorizont;
  TileHorizontal1.Category := CatWindow;
  TileVertical1.Caption := accel + rsTileVertical;
  TileVertical1.hint := rsTileVertical;
  TileVertical1.Category := CatWindow;
  Maximize.Caption := accel + rsMaximize;
  Maximize.Hint := rsMaximize;
  Maximize.Category := CatWindow;
  //Menu Help

  // No Menu
  TimeDec.Caption := rsDecrementTim;
  TimeDec.hint := rsDecrementTim;
  TimeDec.Category := CatAnimation;
  TimeReset.Caption := rsNow;
  TimeReset.hint := rsNow;
  TimeReset.Category := CatAnimation;
  TimeInc.Caption := rsIncrementTim;
  TimeInc.hint := rsIncrementTim;
  TimeInc.Category := CatAnimation;
  Animation.Caption := rsStartForward;
  Animation.Hint := rsStartForward;
  Animation.Category := CatAnimation;
  AnimBackward.Caption := rsStartBackwar;
  AnimBackward.Hint := rsStartBackwar;
  AnimBackward.Category := CatAnimation;

  // Menu without action
  // tab popup
  MenuItemCloseChart.Caption := accel + rsCloseChart;
  // Menu File
  SubFile.Caption := accel + rsFile;
  MenuFileClose.Caption := accel + rsCloseChart;
  MenuResetChart.Caption := accel + rsResetChartAn + Ellipsis;
  // MenuResetLanguage is not translated
  MenuVariableStar.Caption := accel + rsVariableStar2 + Ellipsis;
  MenuSAMPConnect.Caption := rsConnectToSAM;
  MenuSAMPDisconnect.Caption := rsDisconnectFr;
  MenuSAMPStatus.Caption := rsSAMPStatus;
  MenuSAMPSetup.Caption := rsSAMPSetup;
  MenuPrintPreview.Caption := accel + rsPrintPreview;
  // Menu Edit
  SubEdit.Caption := accel + rsEdit;
  // Menu Setup
  SubSetup.Caption := accel + rsSetup;
  MenuEditToolbar.Caption := accel + rsToolBarEdito + Ellipsis;
  MenuToolboxConfig.Caption := accel + rsManageToolbo + Ellipsis;
  // Menu View
  SubView.Caption := accel + rsView;
  SubToolBar.Caption := accel + rsToolBar;
  MenuViewMainBar.Caption := accel + rsMainBar;
  MenuViewObjectBar.Caption := accel + rsObjectBar;
  MenuViewLeftBar.Caption := accel + rsLeftBar;
  MenuViewRightBar.Caption := accel + rsRightBar;
  MenuViewStatusBar.Caption := accel + rsStatusBar;
  MenuViewScrollBar.Caption := accel + rsScrollBar;
  // Menu Chart
  SubChart.Caption := accel + rsChart;
  SubProjection.Caption := accel + rsChartCoordin2;
  SubTransformation.Caption := accel + rsTransformati;
  SubFieldofVision.Caption := accel + rsFieldOfVisio;
  SubShowHorizon.Caption := accel + rsViewHorizon;
  SubAnimation.Caption := accel + rsAnimation;
  SubShowObjects.Caption := accel + rsShowObjects;
  SubShowGrid.Caption := accel + rsLinesGrid;
  SubLabels.Caption := rsLabels;
  SubStarNum.Caption := accel + rsStarsFilter;
  SubNebNum.Caption := accel + rsNebulaeFilte;
  // Menu Telescope
  SubTelescope.Caption := accel + rsTelescope;
  //Menu Window
  SubWindow.Caption := accel + rsWindow;
  MenuNextChild.Caption := accel + rsNextChart;
  //Menu Help
  SubHelp.Caption := accel + rsHelp;
  MenuHelpContents.Caption := accel + rsHelpContents + Ellipsis;
  MenuHelpPDF.Caption := '&PDF ' + rsHelpContents + Ellipsis;
  ;
  MenuHelpFaq.Caption := accel + rsFAQ + Ellipsis;
  MenuHelpQuickStart.Caption := accel + rsQuickStartGu + Ellipsis;
  MenuHomePage.Caption := accel + rsSkychartHome + Ellipsis;
  MenuMaillist.Caption := accel + rsMailList + Ellipsis;
  MenuBugReport.Caption := accel + rsReportAProbl + Ellipsis;
  MenuHelpAbout.Caption := accel + rsAbout + Ellipsis;
  MenuReleaseNotes.Caption := accel + rsReleaseNotes + Ellipsis;
  //Menu Update
  SubUpdate.Caption := rsUpdate1;
  MenuUpdCatalog.Caption := rsInstallObjec;
  MenuUpdSoft.Caption := rsSearchSoftwa;
  MenuUpdDeltaT.Caption:= rsDeltatRecent;
  MenuUpdGrs.Caption := rsJupiterGRSLo;
  MenuUpdComet.Caption := rsCometElement2;
  MenuUpdAsteroid.Caption := rsAsteroidElem2;
  MenuUpdSatellite.Caption := rsArtificialSa;
  //Menu toolbar
  PopupToolbar1.Caption := rsToolBarEdito + Ellipsis;

  // Other control
  // Mag panel
  ButtonMoreStar.Hint := rsMoreStars;
  ButtonLessStar.Hint := rsLessStars;
  ButtonMoreNeb.Hint := rsMoreNebulae;
  ButtonLessNeb.Hint := rsLessNebulae;
  BtnRestoreChild.Hint := rsCascade;
  BtnCloseChild.Hint:= rsCloseChart;
  // time control bar
  TimeU.Items.Clear;
  TimeU.Items.Add(rsHour);
  TimeU.Items.Add(rsMinute);
  TimeU.Items.Add(rsSecond);
  TimeU.Items.Add(rsDay);
  TimeU.Items.Add(rsMonth);
  TimeU.Items.Add(rsYear);
  TimeU.Items.Add(rsJulianYear);
  TimeU.Items.Add(rsTropicalYear);
  TimeU.Items.Add(rsSiderealDay);
  TimeU.Items.Add(rsSynodicMonth);
  TimeU.Items.Add(rsSaros);
  TimeU.ItemIndex := 0;
  TimeU.Hint := rsTimeUnits;
  TimeVal.Hint := rsTime;
  // quicksearch
  quicksearch.Hint := rsSearch;
  // FOV toolbar
  tbFOV1.Hint := rsSetFOVTo;
  tbFOV2.Hint := rsSetFOVTo;
  tbFOV3.Hint := rsSetFOVTo;
  tbFOV4.Hint := rsSetFOVTo;
  tbFOV5.Hint := rsSetFOVTo;
  tbFOV6.Hint := rsSetFOVTo;
  tbFOV7.Hint := rsSetFOVTo;
  tbFOV8.Hint := rsSetFOVTo;
  tbFOV9.Hint := rsSetFOVTo;
  tbFOV10.Hint := rsSetFOVTo;
  SetFOV01.Category := CatFOV;
  SetFOV02.Category := CatFOV;
  SetFOV03.Category := CatFOV;
  SetFOV04.Category := CatFOV;
  SetFOV05.Category := CatFOV;
  SetFOV06.Category := CatFOV;
  SetFOV07.Category := CatFOV;
  SetFOV08.Category := CatFOV;
  SetFOV09.Category := CatFOV;
  SetFOV10.Category := CatFOV;
  // status bar
  StatusCopy.Caption := rsCopy;

  //ToolBox
  for i := 0 to numscript - 1 do
    Fscript[i].setlang;
  SubToolbox.Caption := rsToolBox;
  SetScriptMenuCaption;

  // planet names
  pla[1] := rsMercury;
  pla[2] := rsVenus;
  pla[4] := rsMars;
  pla[5] := rsJupiter;
  pla[6] := rsSaturn;
  pla[7] := rsUranus;
  pla[8] := rsNeptune;
  pla[9] := rsPluto;
  pla[10] := rsSun;
  pla[11] := rsMoon;
  pla[31] := rsSatRing;
  pla[32] := rsEarthShadow;
  for i := 1 to MaxPla do
    pla[i] := trim(pla[i]);

  // Month
  MonthName[1] := rsJanuary;
  MonthName[2] := rsFebruary;
  MonthName[3] := rsMarch;
  MonthName[4] := rsApril;
  MonthName[5] := rsMay;
  MonthName[6] := rsJune;
  MonthName[7] := rsJuly;
  MonthName[8] := rsAugust;
  MonthName[9] := rsSeptember;
  MonthName[10] := rsOctober;
  MonthName[11] := rsNovember;
  MonthName[12] := rsDecember;

  // Menu accelerator
  for i := 0 to MaxMenulevel do
    AccelList[i] := '';
  SetMenuAccelerator(MainMenu1.items, 0, AccelList);

  // Help
  u_help.SetLang;
  SetHelpDB(HTMLHelpDatabase1);
  //SetHelp(self,hlpIndex);
end;

procedure Tf_main.quicksearchClick(Sender: TObject);
var
  key: word;
begin
  key := VK_RETURN;
  quicksearchKeyDown(Sender, key, []);
end;

procedure Tf_main.quicksearchKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  ok: boolean;
  num: string;
var
  ra, de: double;
  i: integer;
begin
  if key <> VK_RETURN then
    exit;  // wait press Enter
  Num := trim(quicksearch.Text);
  ok := GenericSearch('', num, ra, de);
  if ok then
  begin
    i := quicksearch.Items.IndexOf(Num);
    if (i < 0) and (quicksearch.Items.Count >= MaxQuickSearch) then
      i := MaxQuickSearch - 1;
    if i > 0 then begin
      quicksearch.Items.Delete(i);
      quicksearch.Items.Insert(0, Num);
    end
    else if i < 0 then begin
      quicksearch.Items.Insert(0, Num);
    end;
    Application.QueueAsyncCall(quicksearchTop,0);
  end
  else
  begin
    SetLPanel1(Format(rsNotFoundInAn, [Num]));
  end;
end;

procedure Tf_main.quicksearchTop(data: PtrInt);
begin
  quicksearch.ItemIndex := 0;
end;

procedure Tf_main.GetObjectCoord(obj: string; var lbl: string; var ra, de: double);
var
  ok: boolean;
begin
  ok := GenericSearch('', obj, ra, de, False);
  if ok then
  begin
    ra := rmod(rad2deg * ra + 360, 360);
    de := rad2deg * de;
    if catalog.FindId > '' then
      lbl := catalog.FindId
    else
      lbl := obj;
  end
  else
  begin
    ra := -1;
    lbl := '';
  end;
end;

procedure Tf_main.ObsListChange(Sender: TObject);
begin
  Tf_chart(MultiFrame1.ActiveObject).Refresh(True, True);
end;

procedure Tf_main.ObsListSearch(obj: string; ra, de: double);
var
  ok: boolean;
  ar1, de1: double;
begin
  ok := GenericSearch('', obj, ar1, de1);
  if (not ok) and (ra >= 0) then
  begin
    ra := deg2rad * ra;
    de := deg2rad * de;
    Tf_chart(MultiFrame1.ActiveObject).CoordJ2000toChart(ra, de);
    Tf_chart(MultiFrame1.ActiveObject).sc.movetoradec(ra, de);
    Tf_chart(MultiFrame1.ActiveObject).Refresh(False, False);
  end;
end;

procedure Tf_main.ObsListSlew(obj: string; ra, de: double);
var
  cname: string;
  arg: TStringList;
begin
  cname := MultiFrame1.ActiveChild.Caption;
  ra := deg2rad * ra;
  de := deg2rad * de;
  Tf_chart(MultiFrame1.ActiveObject).CoordJ2000toChart(ra, de);
  arg := TStringList.Create;
  arg.Add('SLEW');
  arg.Add(FormatFloat(f5, rad2deg * ra / 15));
  arg.Add(FormatFloat(f5, rad2deg * de));
  ExecuteCmd(cname, arg);
  arg.Free;
end;

function Tf_main.GenericSearch(cname, Num: string; var ar1, de1: double;
  idresult: boolean = True; track: boolean = False; gtype: string = ''): boolean;
var
  ok: boolean;
  i: integer;
  chart: TFrame;
  mag: double;
  stype,buf, sr, sn, sd: string;
  itype: integer;
begin
  try
  screen.Cursor:=crHourGlass;
  if VerboseMsg then
    WriteTrace('GenericSearch');
  Result := False;
  if trim(num) = '' then
    exit;
  chart := nil;
  stype := '';
  if cname = '' then
  begin
    if MultiFrame1.ActiveObject is Tf_chart then
      chart := MultiFrame1.ActiveObject;
  end
  else
  begin
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
        if MultiFrame1.Childs[i].Caption = cname then
          chart := MultiFrame1.Childs[i].DockedObject;
  end;
  if chart is Tf_chart then
    with chart as Tf_chart do
    begin
      ok := False;
      itype := ftAll;
      sr:=''; sn:=''; sd:='';
      catalog.ClearSearch;
      sc.cfgsc.CurrentConstel:='';
      // nebula
      stype := 'N';
      itype := ftNeb;
      ok := catalog.SearchNebulae(Num, ar1, de1);
      if (not ok) and ((gtype='') or (gtype='V*')) then begin
        // variable star
        stype := 'V*';
        itype := ftVar;
        ok := catalog.SearchVarStar(Num, ar1, de1);
      end;
      if (not ok) and ((gtype='') or (gtype='D*')) then begin
        // double star
        stype := 'D*';
        itype := ftDbl;
        ok := catalog.SearchDblStar(Num, ar1, de1);
      end;
      if (not ok) then begin
        // star
        stype := '*';
        itype := ftStar;
        ok := catalog.SearchStar(Num, ar1, de1);
      end;
      if (not ok) then begin
        // star common name exact
        stype := '*';
        itype := ftStar;
        ok := catalog.SearchStarNameExact(Num, ar1, de1);
      end;
      // planet
      if (not ok) and sc.cfgsc.ShowPlanet then
      begin
        stype := 'P';
        itype := ftPla;
        ok := planet.FindPlanetName(trim(Num), ar1, de1, sc.cfgsc);
      end;
      if (not ok) then begin
        // nebula common name exact
        stype := 'N';
        itype := ftNeb;
        ok := f_search.SearchNebNameExact(Num, ar1, de1);
      end;
      // spk bodies, before comet and asteroid
      if (not ok) and sc.cfgsc.ShowBodiesValid then
      begin
        stype := 'Spk';
        itype := ftBody;
        ok := planet.FindBodyName(trim(Num), ar1, de1, mag, sc.cfgsc, True);
      end;
      // comet
      if (not ok) and sc.cfgsc.ShowComet then
      begin
        stype := 'Cm';
        itype := ftCom;
        ok := planet.FindCometName(trim(Num), ar1, de1, mag, sc.cfgsc, True);
      end;
      if (not ok) then begin
        // star common name generic
        stype := '*';
        itype := ftStar;
        ok := catalog.SearchStarNameGeneric(Num, ar1, de1);
      end;
      if (not ok) then begin
        // nebula common name generic
        stype := 'N';
        itype := ftNeb;
        ok := f_search.SearchNebNameGeneric(Num, ar1, de1);
      end;
      // asteroid
      if (not ok) and sc.cfgsc.ShowAsteroid then
      begin
        stype := 'As';
        itype := ftAst;
        ok := planet.FindAsteroidName(trim(Num), ar1, de1, mag, sc.cfgsc, True);
      end;
      if (not ok) then begin
        // variable star alias
        stype := 'V*';
        itype := ftVar;
        ok := catalog.SearchVarAlias(Num, buf);
        if ok then begin
          num:=buf;
          ok := catalog.SearchVarStar(Num, ar1, de1);
        end;
      end;
      if (not ok) then begin
        // online search
        f_search.Num:=Num;
        f_search.SesameCatNum:=3;
        ok:=f_search.SearchOnline;
        if ok then begin
          num:=f_search.sesame_name;
          ar1:=f_search.ra;
          de1:=f_search.de;
          itype := ftOnline;
          stype := 'OSR';
          sr := f_search.sesame_resolver;
          sn := f_search.sesame_name;
          sd := f_search.sesame_desc;
        end;
      end;

      Result := ok;
      if ok and idresult then
      begin
        IdentSearchResult(num, stype, itype, ar1, de1, sr, sn, sd);
        if track then begin
          sc.cfgsc.TrackOn := True;
          UpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked, MultiFrame1.ActiveObject);
        end;
      end;
    end;
  finally
    screen.Cursor:=crDefault;
  end;
end;

procedure Tf_main.UpdateBtn(fx, fy: integer; tc: boolean; Sender: TObject);
var
  cname: string;
  i: integer;
begin
  UpdateSAMPmenu;
  BtnCloseChild.Visible := (MultiFrame1.ChildCount > 1);
  if (Sender <> nil) and (MultiFrame1.ActiveObject = Sender) then
  begin
    if fx > 0 then
    begin
      FlipX.ImageIndex := 15;
      Flipx.Checked := False;
    end
    else
    begin
      FlipX.ImageIndex := 16;
      Flipx.Checked := True;
    end;
    if fy > 0 then
    begin
      FlipY.ImageIndex := 17;
      Flipy.Checked := False;
    end
    else
    begin
      FlipY.ImageIndex := 18;
      Flipy.Checked := True;
    end;
    if tc then
    begin
      TelescopeConnect.ImageIndex := 49;
      TelescopeConnect.Hint := rsConnectTeles;
      telescopeConnect.Checked := True;
    end
    else
    begin
      TelescopeConnect.ImageIndex := 48;
      TelescopeConnect.Hint := rsConnectTeles;
      telescopeConnect.Checked := False;
    end;
    ViewClock.Checked := (f_clock <> nil) and (f_clock.Visible);
    MenuPrintPreview.Visible := (cfgm.PrintMethod = 0);
    cname := MultiFrame1.ActiveChild.Caption;
    for i := 0 to TabControl1.PageCount - 1 do
    begin
      if TabControl1.Pages[i].Caption = cname then
      begin
        TabControl1.TabIndex := i;
        break;
      end;
    end;
    if cfgm.SimpleMove then
      MouseMode.ImageIndex := 97
    else
      MouseMode.ImageIndex := 96;
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      if sc.cfgsc.ManualTelescope then
      begin
        MenuTelescopeControlPanel.Visible := False;
        MenuTelescopeSlew.Visible := False;
        MenuTelescopeSync.Visible := False;
        TelescopeSlew.Enabled := False;
        TelescopeSync.Enabled := False;
      end
      else
      begin
        MenuTelescopeControlPanel.Visible := True;
        MenuTelescopeSlew.Visible := True;
        MenuTelescopeSync.Visible := True;
        TelescopeSlew.Enabled := True;
        TelescopeSync.Enabled := True;
      end;
      if (abs(sc.cfgsc.theta) > (pi - secarc)) and
        (abs(sc.cfgsc.theta) < (pi + secarc)) then
        rotate180.ImageIndex := 93
      else
        rotate180.ImageIndex := 92;
      Animation.Checked := AnimationEnabled and (AnimationDirection >= 0);
      AnimBackward.Checked := AnimationEnabled and (AnimationDirection < 0);
      TrackTelescope.Checked :=
        (sc.cfgsc.TrackOn and (sc.cfgsc.TrackName = rsTelescope));
      Tf_chart(Sender).TrackTelescope1.Checked := MenuTrackTelescope.Checked;
      ShowStars.Checked := sc.cfgsc.showstars;
      ShowNebulae.Checked := sc.cfgsc.shownebulae;
      ShowVO.Checked := (catalog.cfgcat.starcatdef[vostar - BaseStar] or
        catalog.cfgcat.nebcatdef[voneb - BaseNeb]);
      ShowUobj.Checked := catalog.cfgcat.nebcatdef[uneb - BaseNeb];
      ShowPictures.Checked := sc.cfgsc.ShowImages;
      SetPictures.Checked := sc.cfgsc.ShowImageList;
      chart_imglist.Enabled := sc.cfgsc.ShowImageList;
      ListImg.Enabled := sc.cfgsc.ShowImageList;
      ShowLines.Checked := sc.cfgsc.ShowLine;
      ShowAsteroids.Checked := sc.cfgsc.ShowAsteroid;
      ShowComets.Checked := sc.cfgsc.ShowComet;
      ShowPlanets.Checked := sc.cfgsc.ShowPlanet;
      ShowMilkyWay.Checked := sc.cfgsc.ShowMilkyWay;
      ShowLabels.Checked := sc.cfgsc.Showlabelall;
      Editlabels.Checked := sc.cfgsc.Editlabels;
      ScaleMode.Checked := sc.cfgsc.ShowScale;
      ViewChartInfo.Checked := sc.cfgsc.ShowLabel[8];
      ViewChartLegend.Checked := sc.cfgsc.ShowLegend;
      Grid.Checked := sc.cfgsc.ShowGrid;
      GridEq.Checked := sc.cfgsc.ShowEqGrid;
      ShowCompass.Checked := sc.catalog.cfgshr.ShowCRose;
      ShowConstellationLine.Checked := sc.cfgsc.ShowConstl;
      ShowConstellationLimit.Checked := sc.cfgsc.ShowConstB;
      ShowGalacticEquator.Checked := sc.cfgsc.ShowGalactic;
      ShowEcliptic.Checked := sc.cfgsc.ShowEcliptic;
      ShowMark.Checked := sc.cfgsc.ShowCircle;
      ShowObjectbelowHorizon.Checked := not sc.cfgsc.horizonopaque;
      switchbackground.Checked := sc.plot.cfgplot.autoskycolor;
      if sc.cfgsc.ProjPole = AltAz then
      begin
        ShowObjectbelowHorizon.Enabled := True;
        switchbackground.Enabled := True;
      end
      else
      begin
        ShowObjectbelowHorizon.Enabled := False;
        switchbackground.Enabled := False;
      end;
      BlinkImage.Checked := BlinkTimer.Enabled;
      SyncChart.Checked := cfgm.SyncChart;
      Track.Checked := sc.cfgsc.TrackOn;
      if sc.cfgsc.TrackOn then
      begin
        Track.Hint := rsUnlockChart;
        Track.Caption := rsUnlockChart;
      end
      else if ((sc.cfgsc.TrackType >= TTplanet) and (sc.cfgsc.TrackType <= TTasteroid)) or
        (sc.cfgsc.TrackType = TTequat) or (sc.cfgsc.TrackType = TTbody) then
      begin
        Track.Hint := Format(rsLockOn, [sc.cfgsc.Trackname]);
        Track.Caption := Format(rsLockOn, [sc.cfgsc.Trackname]);
      end
      else
      begin
        Track.Hint := rsNoObjectToLo;
        Track.Caption := rsNoObjectToLo;
      end;
      MenuLockChart.Checked:=sc.cfgsc.ChartLock;
      LockMagnitude.Checked:=sc.cfgsc.lockMagn;
      switchstars.ImageIndex := 117 + sc.plot.cfgplot.starplot;
      EquatorialProjection.Checked := (sc.cfgsc.projpole = Equat);
      AltAzProjection.Checked := (sc.cfgsc.projpole = AltAz);
      EclipticProjection.Checked := (sc.cfgsc.projpole = Ecl);
      GalacticProjection.Checked := (sc.cfgsc.projpole = Gal);
      tbFOV1.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[0]) + blank;
      tbFOV2.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[1]) + blank;
      tbFOV3.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[2]) + blank;
      tbFOV4.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[3]) + blank;
      tbFOV5.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[4]) + blank;
      tbFOV6.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[5]) + blank;
      tbFOV7.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[6]) + blank;
      tbFOV8.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[7]) + blank;
      tbFOV9.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[8]) + blank;
      tbFOV10.Caption := DEToStrmin(sc.catalog.cfgshr.FieldNum[9]) + blank;
      tbFOV1.Hint := '(1) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[0]);
      tbFOV2.Hint := '(2) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[1]);
      tbFOV3.Hint := '(3) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[2]);
      tbFOV4.Hint := '(4) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[3]);
      tbFOV5.Hint := '(5) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[4]);
      tbFOV6.Hint := '(6) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[5]);
      tbFOV7.Hint := '(7) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[6]);
      tbFOV8.Hint := '(8) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[7]);
      tbFOV9.Hint := '(9) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[8]);
      tbFOV10.Hint := '(0) ' + rsSetFOVTo + blank +
        DEmToStr(sc.catalog.cfgshr.FieldNum[9]);
      SetFov01.Caption := tbFOV1.hint;
      SetFov02.Caption := tbFOV2.hint;
      SetFov03.Caption := tbFOV3.hint;
      SetFov04.Caption := tbFOV4.hint;
      SetFov05.Caption := tbFOV5.hint;
      SetFov06.Caption := tbFOV6.hint;
      SetFov07.Caption := tbFOV7.hint;
      SetFov08.Caption := tbFOV8.hint;
      SetFov09.Caption := tbFOV9.hint;
      SetFov10.Caption := tbFOV10.hint;
      if (f_configdirect<>nil) and (f_configdirect.Visible)
      then begin
        f_configdirect.csc := sc.cfgsc;
        f_configdirect.cplot := sc.plot.cfgplot;
        f_configdirect.UpdateBtn;
      end;
    end;
    if tc <> FTelescopeConnected then
      TelescopeChange(MultiFrame1.ActiveChild.Caption, tc);
  end;
end;

procedure Tf_main.ChartMove(Sender: TObject);
begin
  if MultiFrame1.ActiveObject = Sender then
  begin   // active chart refresh
    if cfgm.SyncChart then
      SyncChild;
  end;
end;

procedure Tf_main.ImageSetup(Sender: TObject);
begin
  SetupPicturesPage(3);
end;

function Tf_main.NewChart(cname: string): string;
begin
  if cname = '' then
    cname := rsChart_ + IntToStr(MultiFrame1.ChildCount + 1);
  cname := GetUniqueName(cname, False);
  if CreateChild(cname, True, def_cfgsc, def_cfgplot) then
    Result := msgOK + blank + cname
  else
    Result := msgFailed;
end;

function Tf_main.CloseChart(cname: string): string;
var
  i: integer;
begin
  Result := msgNotFound;
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      with MultiFrame1.Childs[i] do
        if Caption = cname then
        begin
          Close;
          Result := msgOK;
        end;
end;

function Tf_main.ListChart: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      Result := Result + ';' + MultiFrame1.Childs[i].Caption;

  if Result > '' then
    Result := msgOK + blank + Result + ';'
  else
    Result := msgFailed + blank + 'No Chart!';
end;

function Tf_main.SelectChart(cname: string): string;
var
  i: integer;
begin
  Result := msgNotFound;
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      with MultiFrame1.Childs[i] do
        if InitOK and (Caption = cname) then
        begin
          MultiFrame1.SetActiveChild(i);
          SetFocus;
          Result := msgOK;
        end;
end;

function Tf_main.RenameChart(newname: string): string;
var
  oldname: string;
  i: integer;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      oldname:=sc.cfgsc.chartname;
      if (newname<>'')and(newname<>oldname) then begin
        newname := GetUniqueName(newname, false);
        Caption:=newname;
        sc.cfgsc.chartname:=newname;
        MultiFrame1.ActiveObject.Caption:=newname;
        MultiFrame1.ActiveChild.Caption:=newname;
        for i := 0 to TabControl1.PageCount - 1 do
        begin
          if TabControl1.Pages[i].Caption = oldname then
          begin
            TabControl1.Pages[i].Caption:=newname;
            break;
          end;
        end;
        MultiFrame1ActiveChildChange(nil);
      end;
      result:=sc.cfgsc.chartname;
    end;
end;

function Tf_main.HelpCmd(cname: string): string;
var
  i: integer;
begin
  Result := '';
  if cname = '' then
  begin
    for i := 1 to numcmdmain do
      Result := Result + maincmdlist[i, 1] + blank + maincmdlist[i, 3] + crlf;
    for i := 1 to numcmd do
      Result := Result + cmdlist[i, 1] + blank + cmdlist[i, 3] + crlf;
    Result := Result + crlf + msgOK;
  end
  else
  begin
    for i := 1 to numcmdmain do
      if maincmdlist[i, 1] = cname then
        Result := Result + maincmdlist[i, 1] + blank + maincmdlist[i, 3] + crlf;
    for i := 1 to numcmd do
      if cmdlist[i, 1] = cname then
        Result := Result + cmdlist[i, 1] + blank + cmdlist[i, 3] + crlf;
    if Result > '' then
      Result := Result + crlf + msgOK
    else
      Result := msgNotFound;
  end;
end;

function Tf_main.GetSelectedObject: string;
var
  y, m, d: integer;
  h, eq: double;
begin
  Result := msgFailed;
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    if Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.FindOK then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        Result := msgOK + blank + sc.cfgsc.FindDesc;
        if sc.cfgsc.FindJD = sc.cfgsc.CurJDUT then
          Result := Result + tab + 'Equinox:now'
        else
        begin
          djd(sc.cfgsc.FindJD, y, m, d, h);
          eq := y + DayofYear(y, m, d) / 365.25;
          Result := Result + tab + 'Equinox:J' + FormatFloat(f1, eq);
        end;
      end;
  end;
end;

function Tf_main.ExecuteCmd(cname: string; arg: TStringList): string;
var
  i, n, w, h: integer;
  cmd: string;
  ar1, de1: double;
  chart: TFrame;
  child: TChildFrame;
  ok: Boolean;
begin
  Result := msgFailed;
  if VerboseMsg then
  begin
    cmd := cname + ' Receive command:';
    for i := 0 to arg.Count - 1 do
      cmd := cmd + blank + arg[i];
    WriteTrace(cmd);
  end;
  cmd := trim(uppercase(arg[0]));
  for i := 1 to arg.Count - 1 do
    arg[i] := StringReplace(arg[i], '"', '', [rfReplaceAll]);
  n := -1;
  for i := 1 to numcmdmain do
    if cmd = maincmdlist[i, 1] then
    begin
      n := strtointdef(maincmdlist[i, 2], -1);
      break;
    end;
  case n of
    1: Result := NewChart(arg[1]);
    2: Result := CloseChart(arg[1]);
    3: Result := SelectChart(arg[1]);
    4: Result := ListChart;
    5: begin
       ok := uppercase(arg[2])='LOCK';
       if Genericsearch(cname, arg[1], ar1, de1, True, ok) then
         Result := msgOK
       else
         Result := msgNotFound;
      end;
    6: Result := msgOK + blank + P1L1.Caption;
    7: Result := msgOK + blank + P0L1.Caption;
    8: Result := msgOK + blank + topmsg;
    9: Result := Find(StrToIntDef(arg[1], 99), arg[2]);
    10: Result := SaveChart(arg[1]);
    11: Result := OpenChart(arg[1]);
    12: Result := HelpCmd(trim(uppercase(arg[1])));
    13:
    begin
      result := msgOK;
      ForceClose := True;
      Close;
    end;
    14:
    begin
      ResetDefaultChartExecute(nil);
      Result := msgOK;
    end;
    15: Result := LoadDefaultChart(arg[1]);
    16: Result := SetGCat(arg[1], arg[2], arg[3], arg[4], arg[5]);
    17: Result := ShowPlanetInfo(arg[1]);
    18: Result := GetSelectedObject;
    19: Result := LoadMPCORB(arg[1]);
    20: Result := RenameChart(arg[1]);
    else
    begin
      Result := 'Bad chart name ' + cname;
      chart := nil;
      child := nil;
      if cname = '' then
      begin
        if MultiFrame1.ActiveObject is Tf_chart then
        begin
          chart := MultiFrame1.ActiveObject;
          child := MultiFrame1.ActiveChild;
        end;
      end
      else
      begin
        for i := 0 to MultiFrame1.ChildCount - 1 do
          if MultiFrame1.Childs[i].DockedObject is Tf_chart then
            if MultiFrame1.Childs[i].Caption = cname then
            begin
              chart := MultiFrame1.Childs[i].DockedObject;
              child := MultiFrame1.Childs[i];
            end;
      end;
      if chart is Tf_chart then
        with chart as Tf_chart do
        begin
          if cmd = 'RESIZE' then
          begin // special case with action on main and on the chart
            w := StrToIntDef(arg[1], child.Width);
            h := StrToIntDef(arg[2], child.Height);
            if (w > 10) and (h > 10) then
            begin
              MultiFrame1.Maximized := False;
              if InitOK and f_main.visible then
              begin // only if form is show
                if VertScrollBar.Visible then
                  w := w + VertScrollBar.Width;
                if HorScrollBar.Visible then
                  h := h + HorScrollBar.Height;
                h := h + child.TopBar.Height + child.BotBar.Height +
                  child.MenuBar.Height;
                w := w + child.LeftBar.Width + child.RightBar.Width;
              end;
              child.Width := w;
              child.Height := h;
              arg[1] := IntToStr(w);
              arg[2] := IntToStr(h);
            end
            else
            begin
              Result := msgFailed + ' invalid window size';
              exit;
            end;
          end;
          if RestoreState and (cmd = 'REDRAW') then
          begin
            WindowState := SaveState;
            RestoreState := False;
       {$ifdef mswindows}
            ShowWindow(f_main.Handle, SW_RESTORE);
       {$else}
            f_main.Show;
       {$endif}
          end;
          Result := (chart as Tf_chart).ExecuteCmd(arg);
        end;
    end;
  end;
end;

procedure Tf_main.SendInfo(Sender: TObject; origin, str: string);
var
  i: integer;
  lstr: string;
begin
  if (origin = '') and (str = '') then
    exit;
  for i := 1 to Maxwindow do
  begin
    if (TCPDaemon <> nil) and (not TCPDaemon.Terminated) and (TCPDaemon.ThrdActive[i]) and
      (TCPDaemon.TCPThrd[i] <> nil) and (TCPDaemon.TCPThrd[i].sock <> nil) and
      (not TCPDaemon.TCPThrd[i].terminated) then
      TCPDaemon.TCPThrd[i].SendData('>' + tab + origin + ' :' + tab + str);
  end;
  if (Sender <> nil)and(not (Sender is Tf_scriptengine)) then
  begin
    i := length(rsFrom);
    if copy(str, 1, i) = rsFrom then
      for i := 0 to numscript - 1 do
        Fscript[i].DistanceMeasurementEvent(origin, str)
    else
    begin
      lstr := striphtml(Tf_chart(MultiFrame1.ActiveObject).formatdesc);
      for i := 0 to numscript - 1 do
        Fscript[i].ObjectSelectionEvent(origin, str, lstr);
    end;
  end;
end;

procedure Tf_main.StartServer;
begin
  try
    TCPDaemon := TTCPDaemon.Create;
    TCPDaemon.onGetACtiveChart := GetACtiveChart;
    TCPDaemon.onErrorMsg := TCPShowError;
    TCPDaemon.onShowSocket := TCPShowSocket;
    TCPDaemon.onExecuteCmd := ExecuteCmd;
    TCPDaemon.IPaddr := cfgm.ServerIPaddr;
    TCPDaemon.IPport := cfgm.ServerIPport;
    TCPDaemon.Start;
  except
    SetLpanel1(rsTCPIPService);
  end;
end;

procedure Tf_main.StopServer;
var
  i: integer;
    {$ifdef mswindows}
  Registry1: TRegistry;
    {$else}
  f: textfile;
    {$endif}
begin
  if TCPDaemon = nil then
    exit;
{$ifdef mswindows}
  Registry1 := TRegistry.Create;
  with Registry1 do
  begin
    Openkey('Software\Astro_PC\Ciel\Status', True);
    WriteString('TcpPort', '0');
    CloseKey;
  end;
  Registry1.Free;
{$else}
  AssignFile(f, slash(TempDir) + 'tcpport');
  Rewrite(f);
  Write(f, '0');
  CloseFile(f);
{$endif}
  SetLpanel1(rsStopTCPIPSer);
  try
    screen.cursor := crHourglass;
    TCPDaemon.stoping := True;
    for i := 1 to Maxwindow do
      if (TCPDaemon.TCPThrd[i] <> nil) then
      begin
        TCPDaemon.TCPThrd[i].stoping := True;
      end;
    ISleep(800);
    screen.cursor := crDefault;
  except
    screen.cursor := crDefault;
  end;
end;


procedure Tf_main.UniqueInstance1OtherInstance(Sender: TObject;
  ParamCount: Integer; const Parameters: array of String);
var
  i: integer;
  buf: string;
begin
  // process param from new instance
  if not InitOK then
    exit;  // ignore if not initialized
  buf := '';
  Params.Clear;
  for i := 0 to Paramcount - 1 do
  begin
    Params.Add(Parameters[i]);
  end;
  buf := '';
  for i := 0 to Params.Count - 1 do
    buf := buf + blank + params[i];
  WriteTrace('Receive from new instance: ' + buf);
  ProcessParamsQuit;
  ProcessParams2;
end;

// Parameters that need to be set before program initialisation
procedure Tf_main.ProcessParams1;
var
  i, p: integer;
  cmd, parms, parm: string;
begin
  for i := 0 to Params.Count - 1 do
  begin
    parms := Params[i];
    p := pos('=', parms);
    if p > 0 then
    begin
      cmd := trim(copy(parms, 1, p - 1));
      parm := trim(copy(parms, p + 1, 999));
    end
    else
    begin
      cmd := trim(parms);
      parm := '';
    end;
    if (ExtractFileExt(cmd) = '.cdc3') and (parm = '') and (FirstChart = '') then begin
      FirstChart:=cmd;
    end
    else if cmd = '--config' then
    begin  // specify .ini file
      if parm <> '' then
      begin
        ForceConfig := SafeUTF8ToSys(trim(parm));
      end;
    end
    else if cmd = '--userdir' then
    begin
      ForceUserDir := SafeUTF8ToSys(trim(parm));
    end
    else if cmd = '--datadir' then
    begin
      ConfigAppdir := SafeUTF8ToSys(trim(parm));
    end
    else if cmd = '--daemon' then
    begin
      showsplash := False;
      Application.ShowMainForm := False;
    end
    else if cmd = '--nosplash' then
    begin
      showsplash := False;
    end
    else if cmd = '--verbose' then
    begin
      VerboseMsg := True;
    end
    else if cmd = '--test' then
    begin
    end;
  end;
end;

// Parameters that need to be set after a chart is available
procedure Tf_main.ProcessParams2;
var
  i, p: integer;
  cmd, parm, parms, resp: string;
  pp: TStringList;
  chartchanged: boolean;
begin
  if MultiFrame1.ChildCount = 0 then
    exit;
  chartchanged := False;
  pp := TStringList.Create;
  try
    // parameters that need to be processed very first
    for i := 0 to Params.Count - 1 do
    begin
      pp.Clear;
      parms := Params[i];
      p := pos('=', parms);
      if p > 0 then
      begin
        cmd := trim(copy(parms, 1, p - 1));
        parm := trim(copy(parms, p + 1, 999));
      end
      else
      begin
        cmd := trim(parms);
        parm := '';
      end;
      if (ExtractFileExt(cmd) = '.cdc3') and (parm = '') then
      begin
        if cmd = FirstChart then Continue;
        parm := cmd;
        cmd := '--load';
      end;
      if cmd = '--loaddef' then
      begin
        pp.Add('LOADDEFAULT');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end;
      if cmd = '--load' then
      begin
        pp.Add('LOAD');
        pp.Add(ExpandFileNameUTF8(parm));
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end;
      if cmd = '--nosave' then
      begin
        SaveConfigOnExit.Checked := False;
      end;
      if cmd = '--obslist' then
      begin
        cfgm.InitObsList := parm;
      end;
    end;
    if chartchanged then
    begin
      pp.Clear;
      pp.Add('REDRAW');
      ExecuteCmd('', pp);
    end;
    // parameters that need to be processed first
    for i := 0 to Params.Count - 1 do
    begin
      pp.Clear;
      parms := Params[i];
      p := pos('=', parms);
      if p > 0 then
      begin
        cmd := trim(copy(parms, 1, p - 1));
        parm := trim(copy(parms, p + 1, 999));
      end
      else
      begin
        cmd := trim(parms);
        parm := '';
      end;
      if cmd = '--setobs' then
      begin
        pp.Add('SETOBS');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--settz' then
      begin
        pp.Add('SETTZ');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--setdate' then
      begin
        pp.Add('SETDATE');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--setcat' then
      begin
        parm := 'SETCAT ' + parm;
        splitarg(parm, blank, pp);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--loadmpcorb' then
      begin
        parm := 'LOADMPCORB ' + parm;
        splitarg(parm, blank, pp);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
      end;
    end;
    // parameters that need to be processed afterward
    for i := 0 to Params.Count - 1 do
    begin
      pp.Clear;
      parms := Params[i];
      p := pos('=', parms);
      if p > 0 then
      begin
        cmd := trim(copy(parms, 1, p - 1));
        parm := trim(copy(parms, p + 1, 999));
      end
      else
      begin
        cmd := trim(parms);
        parm := '';
      end;
      if cmd = '--search' then
      begin
        pp.Add('SEARCH');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--setproj' then
      begin
        pp.Add('SETPROJ');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--setfov' then
      begin
        pp.Add('SETFOV');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--setra' then
      begin
        pp.Add('SETRA');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--setdec' then
      begin
        pp.Add('SETDEC');
        pp.Add(parm);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
        chartchanged := True;
      end
      else if cmd = '--resize' then
      begin
        parm := 'RESIZE ' + parm;
        splitarg(parm, blank, pp);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
      end;
    end;
    if chartchanged then
    begin
      pp.Clear;
      pp.Add('REDRAW');
      ExecuteCmd('', pp);
    end;
    // parameters that need to be processed after the position is set
    for i := 0 to Params.Count - 1 do
    begin
      pp.Clear;
      parms := Params[i];
      p := pos('=', parms);
      if p > 0 then
      begin
        cmd := trim(copy(parms, 1, p - 1));
        parm := trim(copy(parms, p + 1, 999));
      end
      else
      begin
        cmd := trim(parms);
        parm := '';
      end;
      if cmd = '--dss' then
      begin
        parm := 'PDSS ' + parm;
        splitarg(parm, blank, pp);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
      end;
    end;
    // parameters that need to be processed after the chart is draw
    for i := 0 to Params.Count - 1 do
    begin
      pp.Clear;
      parms := Params[i];
      p := pos('=', parms);
      if p > 0 then
      begin
        cmd := trim(copy(parms, 1, p - 1));
        parm := trim(copy(parms, p + 1, 999));
      end
      else
      begin
        cmd := trim(parms);
        parm := '';
      end;
      if cmd = '--saveimg' then
      begin
        parm := 'SAVEIMG ' + parm;
        splitarg(parm, blank, pp);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
      end
      else if cmd = '--print' then
      begin
        parm := 'PRINT ' + parm;
        splitarg(parm, blank, pp);
        for p := pp.Count to MaxCmdArg do
          pp.add('');
        resp := ExecuteCmd('', pp);
        if (resp <> msgOK) and (resp <> '') then
          WriteTrace(resp);
      end;
    end;
  finally
    pp.Free;
  end;
  // --quit parameter
  for i := 0 to Params.Count - 1 do
  begin
    parms := Params[i];
    cmd := words(parms, '', 1, 1);
    if cmd = '--quit' then
    begin
      CloseTimer.Enabled := True;
    end;
  end;
end;

procedure Tf_main.ProcessParamsQuit;
var
  i: integer;
  cmd, parms: string;
begin
  for i := 0 to Params.Count - 1 do
  begin
    parms := Params[i];
    cmd := words(parms, '', 1, 1);
    if cmd = '--quit' then
    begin
      Close;
    end;
  end;
end;

procedure Tf_main.ConnectDB(updversion: string = '');
var
  dbpath: string;
begin
  try
    NeedToInitializeDB := False;
    if not Fileexists(cfgm.db) then
    begin
      dbpath := extractfilepath(cfgm.db);
      if VerboseMsg then
        WriteTrace('Create sqlite ' + dbpath);
      if not directoryexists(dbpath) then
        CreateDir(dbpath);
      if not directoryexists(dbpath) then
        forcedirectories(dbpath);
    end;
    cdcdb.ConnectDB(cfgm.db);
    if cdcdb.CheckDB then
    begin
      if VerboseMsg then
        WriteTrace('DB connected');
      planet.ConnectDB(cfgm.db);
      if not NeedToInitializeDB then
        cdcdb.CheckForUpgrade(f_info.ProgressMemo, updversion);
      Fits.ConnectDB(cfgm.db);
      cdcdb.OpenAsteroid;
      cdcdb.OpenAsteroidMagnitude;
      SetLpanel1(Format(rsConnectedToS, [cfgm.db]));
    end
    else
    begin
      ShowError(rsSQLDatabaseN + crlf + rsSQLDatabaseS);
      def_cfgsc.ShowAsteroid := False;
      def_cfgsc.ShowComet := False;
      def_cfgsc.ShowImages := False;
    end;
    if NeedToInitializeDB then
    begin
      if VerboseMsg then
        WriteTrace('Initialize DB');
      f_info.setpage(2);
      f_info.Show;
      f_info.ProgressMemo.Lines.add(rsInitializeDa);
      cdcdb.LoadSampleData(f_info.ProgressMemo, cfgm);
      Planet.PrepareAsteroid(DateTimetoJD(now), DateTimetoJD(now), 1,
        f_info.ProgressMemo.Lines);
      def_cfgsc.ShowAsteroid := True;
      f_info.hide;
    end;
  except
    SetLpanel1(rsSQLDatabaseN);
  end;
end;

procedure Tf_main.FinishAsteroidUpgrade(Sender: TObject);
begin
  RecomputeAsteroid;
end;

procedure Tf_main.InitializeDB(Sender: TObject);
begin
  NeedToInitializeDB := True;
end;

procedure Tf_main.ViewServerInfoExecute(Sender: TObject);
begin
  f_info.setpage(0);
  f_info.serverinfo.Caption := f_main.serverinfo;
  f_info.Show;
  f_info.bringtofront;
end;

procedure Tf_main.showdetailinfo(chart: string; ra, Dec: double; cat, nm, desc: string);
var
  i: integer;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      if MultiFrame1.Childs[i].Caption = chart then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          GenericSearch(chart,nm,ra,dec,true,false,cat);
          f_detail.Hide;
          identlabelClick(nil);
          UpdateBtn(sc.cfgsc.flipx, sc.cfgsc.flipy, Connect1.Checked,
            MultiFrame1.Childs[i].DockedObject);
          break;
        end;
end;

procedure Tf_main.DetailToObslist(chart: string; ra, Dec: double; cat, nm, desc: string);
var
  i: integer;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      if MultiFrame1.Childs[i].Caption = chart then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          CoordCharttoJ2000(ra, dec);
          f_obslist.Add(nm, rad2deg * ra, rad2deg * dec,false);
          break;
        end;
end;

procedure Tf_main.CenterFindObj(chart: string);
var
  i: integer;
  ra, de: double;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      if MultiFrame1.Childs[i].Caption = chart then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          ra:=f_detail.ra;
          de:=f_detail.de;
          Precession(jd2000,sc.cfgsc.JDChart,ra,de);
          sc.cfgsc.racentre := ra;
          sc.cfgsc.decentre := de;
          sc.cfgsc.TrackOn := False;
          if VerboseMsg then
            WriteTrace('CenterFindObj');
          Refresh(True, True);
          break;
        end;
end;

procedure Tf_main.NeighborObj(chart: string);
var
  i: integer;
  ra, de: double;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      if MultiFrame1.Childs[i].Caption = chart then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          ra:=f_detail.ra;
          de:=f_detail.de;
          Precession(jd2000,sc.cfgsc.JDChart,ra,de);
          ListRaDec(ra, de, 0.5*deg2rad, false, 10,100);
          f_info.SortRadius(ra,de);
          break;
        end;
end;

procedure Tf_main.GrappaVarNeighborObj(chart: string);
var
  i: integer;
  ra, de: double;
begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      if MultiFrame1.Childs[i].Caption = chart then
        with MultiFrame1.Childs[i].DockedObject as Tf_chart do
        begin
          ra:=f_detail.ra;
          de:=f_detail.de;
          ListGrappaVar(ra, de);
          Precession(jd2000,sc.cfgsc.JDChart,ra,de);
          f_info.SortRadius(ra,de);
          break;
        end;
end;

procedure Tf_main.GetActiveChart(var active_chart: string);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    active_chart := MultiFrame1.ActiveChild.Caption
  else
    active_chart := newchart('');
end;

procedure Tf_main.TCPShowError(var msg: string);
begin
  SetLpanel1(Format(rsSocketError, [msg, '']));
end;

procedure Tf_main.TCPShowSocket(var msg: string);
var
  tcpport: string;
{$ifdef mswindows}
  Registry1: TRegistry;
{$else}
  f: textfile;
{$endif}
begin
  tcpport := msg;
  if msg <> cfgm.ServerIPport then
    msg := Format(rsDifferentTha, [msg]);
  serverinfo := Format(rsListenOnPort, [msg]);
  SetLpanel1(serverinfo);
{$ifdef mswindows}
  Registry1 := TRegistry.Create;
  with Registry1 do
  begin
    Openkey('Software\Astro_PC\Ciel\Status', True);
    WriteString('TcpPort', tcpport);
    CloseKey;
  end;
  Registry1.Free;
{$else}
  AssignFile(f, slash(TempDir) + 'tcpport');
  Rewrite(f);
  Write(f, tcpport);
  CloseFile(f);
{$endif}
end;

procedure Tf_main.ImageSetFocus(Sender: TObject);
begin
  if (ActiveControl<>quicksearch) and ((f_obslist.tour=nil)or(not f_obslist.tour.Visible)) then
  begin // do not steal focus when typing in the quicksearch
    if VerboseMsg then
      WriteTrace('ImageSetFocus');
    // to restore focus to the chart that as no text control
    ActiveControl := nil;
    quicksearch.Enabled := False;   // add all main form focusable control here
    EditTimeVal.Enabled := False;
    TimeVal.Enabled := False;
    TimeU.Enabled := False;
    quicksearch.Enabled := True;
    EditTimeVal.Enabled := True;
    TimeVal.Enabled := True;
    TimeU.Enabled := True;
  end;
end;

procedure Tf_main.GetTCPInfo(i: integer; var buf: string);
begin
buf := '';
try
  if (TCPDaemon <> nil) then
    with TCPDaemon do
    begin
      if (not TCPDaemon.ThrdActive[i]) or (TCPThrd[i] = nil) or
        (TCPThrd[i].sock = nil) or (TCPThrd[i].terminated) then
      begin
        buf := Format(rsNotConnected, [IntToStr(i)]);
      end
      else
      begin
        buf := Format(rsConnectedFro, [IntToStr(i), TCPThrd[i].RemoteIP +
          blank + TCPThrd[i].RemotePort, TCPThrd[i].active_chart,
          datetimetostr(TCPThrd[i].connecttime)]);
      end;
    end
  else
    buf := '';
except
end;
end;

function Tf_main.TCPClientConnected: boolean;
var
  i: integer;
begin
  Result := False;
  try
  if (TCPDaemon <> nil) then
    with TCPDaemon do
    begin
      for i := 1 to MaxWindow do
      begin
        if (TCPDaemon.ThrdActive[i]) and (TCPThrd[i] <> nil) and
          (TCPThrd[i].sock <> nil) and (not TCPThrd[i].terminated) then
        begin
          Result := True;
        end;
      end;
    end;
  except
  end;
end;

procedure Tf_main.KillTCPClient(i: integer);
begin
  if (i > 0) and (TCPDaemon.ThrdActive[i]) and (TCPDaemon <> nil) and
    (TCPDaemon.TCPThrd[i] <> nil) then
    TCPDaemon.TCPThrd[i].Terminate;
end;

procedure Tf_main.PrintSetup(Sender: TObject);
begin
  FilePrintSetup1.Execute;
end;

procedure Tf_main.FilePrintSetup1Execute(Sender: TObject);
var
  savecfgm: Tconf_main;
begin
  savecfgm := Tconf_main.Create;
  try
    savecfgm.Assign(cfgm);
    f_printsetup.cm := cfgm;
    formpos(f_printsetup, mouse.cursorpos.x, mouse.cursorpos.y);
    if f_printsetup.showmodal = mrOk then
    begin
      cfgm := f_printsetup.cm;
    end
    else
    begin
      cfgm.Assign(savecfgm);
    end;
    MenuPrintPreview.Visible := (cfgm.PrintMethod = 0);
  finally
    savecfgm.Free;
  end;
end;

procedure Tf_main.LoadTheme(ThemeName:string);
var ok: boolean;
  procedure Load1Theme(dir: string; img:TImageList);
  var i: integer;
      bmp: TBGRABitmap;
      err: boolean;
  begin
    err:=false;
    if DirectoryExistsUTF8(dir) then begin
      img.Clear;
      bmp := TBGRABitmap.Create;
      for i := 0 to ImageListCount - 1 do
      begin
        try
          bmp.LoadFromFile(dir + 'i' + IntToStr(i) + '.png');
          img.Add(bmp.Bitmap, nil);
        except
          err:=true;
          ok:=false;
        end;
      end;
      bmp.Free;
      if err then begin
        SetLPanel1('Error loading icons from '+dir);
        Application.ProcessMessages;
        sleep(500);
      end;
    end;
  end;
var tdir:string;
begin
  ok:=true;
  CurrentTheme:=ThemeName;
  tdir := slash(appdir) + slash('data') + slash('Themes') + slash(CurrentTheme);
  if not DirectoryExists(tdir) then begin
    CurrentTheme:='default';
    cfgm.ThemeName:=CurrentTheme;
    tdir := slash(appdir) + slash('data') + slash('Themes') + slash(CurrentTheme);
  end;
  Load1Theme(slash(tdir)+slash('daylight')+slash('16x16'),Img16Day);
  Load1Theme(slash(tdir)+slash('daylight')+slash('22x22'),Img22Day);
  Load1Theme(slash(tdir)+slash('daylight')+slash('32x32'),Img32Day);
  Load1Theme(slash(tdir)+slash('night-vision')+slash('16x16'),Img16Night);
  Load1Theme(slash(tdir)+slash('night-vision')+slash('22x22'),Img22Night);
  Load1Theme(slash(tdir)+slash('night-vision')+slash('32x32'),Img32Night);
  if not ok then SetLPanel1('Error loading theme '+tdir+'Button can be mixed up');
end;

procedure Tf_main.SetTheme;
var
  i: integer;
begin
  if NightVision then
    SetNightVision(True);

  if cfgm.ThemeName<>CurrentTheme then
    LoadTheme(cfgm.ThemeName);

  SetButtonImage(ToolBarMain.ButtonHeight,MainMenu1.Images.Height);

  if fileexists(slash(appdir) + slash('data') + slash('Themes') +
    slash(cfgm.ThemeName) + 'compass.bmp') then
  begin
    Compass.LoadFromFile(SysToUTF8(slash(appdir) + slash('data') +
      slash('Themes') + slash(cfgm.ThemeName) + 'compass.bmp'));
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
        Tf_chart(MultiFrame1.Childs[i].DockedObject).sc.plot.compassrose := Compass;
  end;
  if fileexists(slash(appdir) + slash('data') + slash('Themes') +
    slash(cfgm.ThemeName) + 'arrow.bmp') then
  begin
    arrow.LoadFromFile(SysToUTF8(slash(appdir) + slash('data') +
      slash('Themes') + slash(cfgm.ThemeName) + 'arrow.bmp'));
    for i := 0 to MultiFrame1.ChildCount - 1 do
      if MultiFrame1.Childs[i].DockedObject is Tf_chart then
        Tf_chart(MultiFrame1.Childs[i].DockedObject).sc.plot.compassarrow := arrow;
  end;
  SetStarShape;
end;

procedure Tf_main.SetStarShape;
var
  i: integer;
  defaultfile: string;
begin
  if (cfgm.starshape_file <> '') and (FileExists(utf8tosys(cfgm.starshape_file))) then
  begin
    starshape.Picture.LoadFromFile(cfgm.starshape_file);
  end;
  if (cfgm.starshape_file = '') then
  begin
    defaultfile := slash(appdir) + slash('data') + slash('Themes') +
      slash(cfgm.ThemeName) + 'starshape.bmp';
    if not FileExists(defaultfile) then
      defaultfile := slash(appdir) + slash('data') + slash('Themes') +
        slash('default') + 'starshape.bmp';
    starshape.Picture.LoadFromFile(systoutf8(defaultfile));
  end;
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      Tf_chart(MultiFrame1.Childs[i].DockedObject).sc.plot.Starshape :=
        starshape.Picture.Bitmap;
end;

procedure Tf_main.SetButtonImage(bsize,msize:integer);
var
  btn: TPortableNetworkGraphic;
  Ilist,MenuIlist: Timagelist;
begin
  try
    if DarkTheme then begin
      // dark theme, use night-vision
      if cfgm.btncaption then
         Ilist:=Img22Night
      else if bsize<=24 then
         Ilist:=Img16Night
      else if bsize<=32 then
         Ilist:=Img22Night
      else
         Ilist:=Img32Night;
      if msize<=24 then
         MenuIlist:=Img16Night
      else if msize<=32 then
         MenuIlist:=Img22Night
      else
         MenuIlist:=Img32Night;
         ToolBarFOV.Font.Color:=clSilver;
         tbFOV1.Font.Color:=clSilver;
         tbFOV2.Font.Color:=clSilver;
         tbFOV3.Font.Color:=clSilver;
         tbFOV4.Font.Color:=clSilver;
         tbFOV5.Font.Color:=clSilver;
         tbFOV6.Font.Color:=clSilver;
         tbFOV7.Font.Color:=clSilver;
         tbFOV8.Font.Color:=clSilver;
         tbFOV9.Font.Color:=clSilver;
         tbFOV10.Font.Color:=clSilver;
         {$ifdef lclcocoa}
         tbFOV1.Color:=clBackground;
         tbFOV2.Color:=clBackground;
         tbFOV3.Color:=clBackground;
         tbFOV4.Color:=clBackground;
         tbFOV5.Color:=clBackground;
         tbFOV6.Color:=clBackground;
         tbFOV7.Color:=clBackground;
         tbFOV8.Color:=clBackground;
         tbFOV9.Color:=clBackground;
         tbFOV10.Color:=clBackground;
         {$endif}
    end
    else begin
      // light theme, use daylight
      if cfgm.btncaption then
         Ilist:=Img22Day
      else if bsize<=24 then
         Ilist:=Img16Day
      else if bsize<=32 then
         Ilist:=Img22Day
      else
         Ilist:=Img32Day;
      if msize<=24 then
         MenuIlist:=Img16Day
      else if msize<=32 then
         MenuIlist:=Img22Day
      else
         MenuIlist:=Img32Day;
      ToolBarFOV.Font.Color:=clGray;
    end;
    //replace image list
    ActionListFile.Images := Ilist;
    ActionListEdit.Images := Ilist;
    ActionListSetup.Images := Ilist;
    ActionListView.Images := Ilist;
    ActionListChart.Images := Ilist;
    ActionListTelescope.Images := Ilist;
    ActionListWindow.Images := Ilist;
    ToolBarMain.Images := Ilist;
    ToolBarLeft.Images := Ilist;
    ToolBarRight.Images := Ilist;
    ToolBarObj.Images := Ilist;
    MainMenu1.Images := MenuIlist;
    f_edittoolbar.Images := Ilist;
    // replace individual button
    btn := TPortableNetworkGraphic.Create;
    Ilist.GetBitmap(121, btn);
    BtnCloseChild.Glyph.Assign(btn);
    Ilist.GetBitmap(122, btn);
    BtnRestoreChild.Glyph.Assign(btn);
    Ilist.GetBitmap(52, btn);
    ButtonMoreStar.Picture.Assign(btn);
    Ilist.GetBitmap(53, btn);
    ButtonLessStar.Picture.Assign(btn);
    Ilist.GetBitmap(54, btn);
    ButtonMoreNeb.Picture.Assign(btn);
    Ilist.GetBitmap(55, btn);
    ButtonLessNeb.Picture.Assign(btn);
    btn.Free;
    //ChildControl.Left := ToolBarMain.Width - ChildControl.Width;
  except
  end;
end;

{ code to save the image list to individual files
   for i:=0 to ImageNormal.Count-1 do begin
     ImageNormal.GetBitmap(i,btn);
     btn.SavetoFile('/home/cdc/src/skychart/bitmaps/icon_color/i'+inttostr(i)+'.bmp');
   end;
}


procedure Tf_main.MultiFrame1ActiveChildChange(Sender: TObject);
var
  i: integer;
begin
  if MultiFrame1.ActiveObject <> nil then
  begin
    if cfgm.ShowTitlePos then
      Caption := basecaption + ' - ' + MultiFrame1.ActiveChild.Caption +
        blank + blank + Tf_chart(MultiFrame1.ActiveObject).sc.GetChartPos
    else
      Caption := basecaption + ' - ' + MultiFrame1.ActiveChild.Caption;
    Tf_chart(MultiFrame1.ActiveObject).ChartActivate;
    for i := 0 to numscript - 1 do
      Fscript[i].Activechart := Tf_chart(MultiFrame1.ActiveObject);
  end
  else
    Caption := basecaption;
end;

procedure Tf_main.MultiFrame1Maximize(Sender: TObject);

begin
  ChildControl.Visible := MultiFrame1.Maximized;
  if TabControl1.Visible <> (MultiFrame1.Maximized) and (MultiFrame1.ChildCount > 1) then
  begin
    TabControl1.Visible := (MultiFrame1.Maximized) and (MultiFrame1.ChildCount > 1);
    ViewTopPanel;
  end;
end;

procedure Tf_main.BtnRestoreChildClick(Sender: TObject);
begin
  MultiFrame1.Maximized := not MultiFrame1.Maximized;
end;

procedure Tf_main.BtnCloseChildClick(Sender: TObject);
begin
  if (MultiFrame1.ActiveObject is Tf_chart) and (MultiFrame1.ChildCount > 1) then
    MultiFrame1.ActiveChild.Close;
end;

procedure Tf_main.WindowCascade1Execute(Sender: TObject);
begin
  MultiFrame1.Cascade;
end;

procedure Tf_main.WindowTileHorizontal1Execute(Sender: TObject);
begin
  MultiFrame1.TileHorizontal;
end;

procedure Tf_main.WindowTileVertical1Execute(Sender: TObject);
begin
  MultiFrame1.TileVertical;
end;

procedure Tf_main.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key=VK_MENU then exit;
  if cfgm.KioskMode then
  begin
    if (key = VK_RETURN) or (Length(kioskpwd) > 50) then
      kioskpwd := '';
    if (key >= VK_A) and (key <= VK_Z) then
      kioskpwd := kioskpwd + chr(key);
    if uppercase(kioskpwd) = uppercase(cfgm.KioskPass) then
    begin
      ForceClose := True;
      Close;
      Exit;
    end;
  end;
  if not cfgm.KioskMode then begin
    if (ssCtrl in Shift) and (ssShift in Shift) then
    begin
      // Ctrl + Shift + key handling
      case key of
        VK_M: ViewMainMenu.Execute;
      end;
    end;
  end;
  if cfgm.KioskMode or ((Activecontrol <> nil) and ((Activecontrol.Name <> '') and
    (Activecontrol.Name <> 'MultiFrame1') and (Activecontrol.Name <> 'PanelTop') and
    (Activecontrol.Name <> 'PanelLeft') and (Activecontrol.Name <> 'PanelRight')))
  then
    exit
  else
    (MultiFrame1.ActiveObject as Tf_chart).CKeyDown(Key, Shift);
end;

procedure Tf_main.SetChildFocus(Sender: TObject);
var
  i: integer;
begin
if ((f_obslist.tour=nil)or(not f_obslist.tour.Visible)) then begin
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject = Sender then
    begin
      if VerboseMsg then
        WriteTrace('SetChildFocus ' +
          tf_chart(MultiFrame1.Childs[i].DockedObject).Caption);
      MultiFrame1.setActiveChild(i);
      ActiveControl := MultiFrame1;
      ImageSetFocus(Sender);
    end;
end;
end;

procedure Tf_main.MaximizeExecute(Sender: TObject);
begin
  MultiFrame1.Maximized := True;
end;

procedure Tf_main.ViewNightVisionExecute(Sender: TObject);
var
  i: integer;
begin
try
  NightVision := not NightVision;
  SetNightVision(NightVision);
  ViewNightVision.Checked := NightVision;
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i].DockedObject is Tf_chart then
      (MultiFrame1.Childs[i].DockedObject as Tf_chart).NightVision := NightVision;
except
end;
end;

{$ifdef mswindows}

// View fullscreen without border
procedure Tf_main.ViewFullScreenExecute(Sender: TObject);
var
  lPrevStyle: longint;
  m: TMonitor;
begin
  MenuFullScreen.Checked := not MenuFullScreen.Checked;
  if MenuFullScreen.Checked then
  begin
    cfgm.savetop := top;
    cfgm.saveleft := left;
    cfgm.savewidth := Width;
    cfgm.saveheight := Height;
    m := screen.MonitorFromWindow(f_main.handle);
    lPrevStyle := GetWindowLong(f_main.handle, GWL_STYLE);
    SetWindowLong(f_main.handle, GWL_STYLE,
      (lPrevStyle and (not WS_THICKFRAME) and (not WS_BORDER) and
      (not WS_CAPTION) and (not WS_MINIMIZEBOX) and (not WS_MAXIMIZEBOX)));
    SetWindowPos(f_main.handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    top := m.Top;
    left := m.Left;
    Width := m.Width;
    Height := m.Height;
  end
  else
  begin
    lPrevStyle := GetWindowLong(f_main.handle, GWL_STYLE);
    SetWindowLong(f_main.handle, GWL_STYLE, (lPrevStyle or WS_THICKFRAME or
      WS_BORDER or WS_CAPTION or WS_MINIMIZEBOX or WS_MAXIMIZEBOX));
    SetWindowPos(f_main.handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    top := cfgm.savetop;
    left := cfgm.saveleft;
    Width := cfgm.savewidth;
    Height := cfgm.saveheight;
  end;
end;
// end of windows specific code:
{$endif}

procedure Tf_main.SetNightVision(night: boolean);
var
  i: integer;
begin
  if night then
  begin
    MultiFrame1.InactiveBorderColor := $00000000;
    MultiFrame1.TitleColor := $003030c0;
    MultiFrame1.BorderColor := $00000040;
  end
  else
  begin
    MultiFrame1.InactiveBorderColor := $404040;
    MultiFrame1.TitleColor := clBlack;
    MultiFrame1.BorderColor := $808080;
  end;
  for i := 0 to MultiFrame1.ChildCount - 1 do
    if MultiFrame1.Childs[i] = MultiFrame1.ActiveChild then
      MultiFrame1.Childs[i].SetBorderColor(MultiFrame1.BorderColor)
    else
      MultiFrame1.Childs[i].SetBorderColor(MultiFrame1.InactiveBorderColor);
end;

{$ifdef unix}
procedure Tf_main.ViewFullScreenExecute(Sender: TObject);
begin
  if cfgm.KioskMode then
    MenuFullScreen.Checked := True
  else
    MenuFullScreen.Checked := not MenuFullScreen.Checked;
{$IF DEFINED(LCLgtk2)}
  { TODO : fullscreen showmodal do not work with Gnome/Unity }
  SetWindowFullScreen(f_main, MenuFullScreen.Checked);
  if MenuFullScreen.Checked then
    WindowState := wsMaximized
  else
    WindowState := wsNormal;
{$else}
  if MenuFullScreen.Checked then
    WindowState := wsMaximized
  else
    WindowState := wsNormal;
{$endif}
end;

{$endif}

procedure Tf_main.GetTwilight(jd0: double; out ht: double);
var
  astrom, nautm, civm, cive, naute, astroe: double;
begin
  planet.Twilight(jd0, def_cfgsc.ObsLatitude, def_cfgsc.ObsLongitude,
    astrom, nautm, civm, cive, naute, astroe);
  def_cfgsc.tz.JD := jd0;
  ht := rmod(astroe + def_cfgsc.tz.SecondsOffset / 3600 + 24, 24);
end;

procedure Tf_main.MenuSAMPConnectClick(Sender: TObject);
begin
  if (samp = nil) or (not samp.Connected) then
    SAMPStart;
  UpdateSAMPmenu;
end;

procedure Tf_main.MenuSAMPDisconnectClick(Sender: TObject);
begin
  SAMPStop;
  UpdateSAMPmenu;
end;

procedure Tf_main.MenuSAMPStatusClick(Sender: TObject);
var
  buf: string;
  i: integer;
begin
  buf := rsSAMPStatus + ':' + blank;
  if SampConnected then
  begin
    buf := buf + rsConnected3 + crlf;
    buf := buf + rsClientList + ':' + crlf;
    for i := 0 to samp.Clients.Count - 1 do
    begin
      buf := buf + ' - ' + samp.ClientNames[i] + ', ' + samp.ClientDesc[i] + crlf;
    end;
  end
  else
  begin
    buf := buf + rsDiconnected + crlf;
  end;
  ShowMessage(buf);
end;

procedure Tf_main.MenuSAMPSetupClick(Sender: TObject);
var
  b1, b2, b3: boolean;
begin
  b1 := cfgm.SampSubscribeCoord;
  b2 := cfgm.SampSubscribeImage;
  b3 := cfgm.SampSubscribeTable;
  SetupSystemPage(4);
  if SampConnected and ((b1 <> cfgm.SampSubscribeCoord) or
    (b2 <> cfgm.SampSubscribeImage) or (b3 <> cfgm.SampSubscribeTable)) then
    samp.SampSubscribe(cfgm.SampSubscribeCoord, cfgm.SampSubscribeImage,
      cfgm.SampSubscribeTable);
end;

procedure Tf_main.InitToolBar;
begin
  ResizeBtn;
  f_edittoolbar.DisabledContainer := ContainerPanel;
  f_edittoolbar.TBOnMouseUp := ToolButtonMouseUp;
  f_edittoolbar.TBOnMouseDown := ToolButtonMouseDown;
  f_edittoolbar.ClearAction;
  f_edittoolbar.DefaultAction := rsFile;
  f_edittoolbar.AddAction(ActionListFile, rsFile);
  f_edittoolbar.AddAction(ActionListEdit, rsEdit);
  f_edittoolbar.AddAction(ActionListSetup, rsSetup);
  f_edittoolbar.AddAction(ActionListView, rsView);
  f_edittoolbar.AddAction(ActionListChart, rsChart);
  f_edittoolbar.AddAction(ActionListTelescope, rsTelescope);
  f_edittoolbar.AddAction(ActionListWindow, rsWindow);
  f_edittoolbar.ClearControl;
  f_edittoolbar.AddOtherControl(MagPanel, rsStarAndNebul, CatFilter, rsChart, 99);
  f_edittoolbar.AddOtherControl(quicksearch, rsSearchBox, CatSearch, rsEdit, 102);
  f_edittoolbar.AddOtherControl(TimeValPanel, rsEditTimeIncr, CatAnimation,
    rsChart, 103);
  f_edittoolbar.AddOtherControl(TimeU, rsSelectTimeUn, CatAnimation, rsChart, 104);
  f_edittoolbar.AddOtherControl(ToolBarFOV, rsFOVBar, CatFOV, rsChart, 32);
  f_edittoolbar.ClearToolbar;
  f_edittoolbar.DefaultToolbar := ToolBarMain.Caption;
  f_edittoolbar.AddToolbar(ToolBarMain);
  f_edittoolbar.AddToolbar(ToolBarObj);
  f_edittoolbar.AddToolbar(ToolBarLeft);
  f_edittoolbar.AddToolbar(ToolBarRight);
  f_edittoolbar.ProcessActions;
  // Set configured bar
  f_edittoolbar.LoadToolbar(0, configmainbar);
  f_edittoolbar.LoadToolbar(1, configobjectbar);
  f_edittoolbar.LoadToolbar(2, configleftbar);
  f_edittoolbar.LoadToolbar(3, configrightbar);
  f_edittoolbar.ActivateToolbar;
  // show all the configured bar
  ViewToolsBar(False);
end;

procedure Tf_main.EditToolBar(barnum: integer);
var
  i: integer;
  buf: string;
begin
  // load current config
  f_edittoolbar.LoadToolbar(0, configmainbar);
  f_edittoolbar.LoadToolbar(1, configobjectbar);
  f_edittoolbar.LoadToolbar(2, configleftbar);
  f_edittoolbar.LoadToolbar(3, configrightbar);
  buf := IntToStr(cfgm.btnsize);
  for i := 0 to f_edittoolbar.BtnSize.Items.Count - 1 do
    if f_edittoolbar.BtnSize.Items[i] = buf then
      f_edittoolbar.BtnSize.ItemIndex := i;
  f_edittoolbar.BtnText.Checked :=
    cfgm.btncaption and (f_edittoolbar.BtnSize.ItemIndex >= 3);
  f_edittoolbar.BtnText.Enabled := (f_edittoolbar.BtnSize.ItemIndex >= 3);
  if (barnum>=0)and(barnum<=3) then begin
    f_edittoolbar.ComboBox1.ItemIndex:=barnum;
    f_edittoolbar.ComboBox1Change(nil);
  end;
  FormPos(f_edittoolbar, mouse.cursorpos.x, mouse.cursorpos.y);
  f_edittoolbar.ShowModal;
  if f_edittoolbar.ModalResult = mrOk then
  begin
    // save the configuration
    i := StrToIntDef(f_edittoolbar.BtnSize.Text, 28);
    if (i <> cfgm.btnsize) or (f_edittoolbar.BtnText.Checked <> cfgm.btncaption) then
    begin
      cfgm.btnsize := StrToIntDef(f_edittoolbar.BtnSize.Text, 28);
      cfgm.btncaption := f_edittoolbar.BtnText.Checked;
      ResizeBtn;
      f_edittoolbar.ActivateToolbar;
    end;
    f_edittoolbar.SaveToolbar(0, configmainbar);
    f_edittoolbar.SaveToolbar(1, configobjectbar);
    f_edittoolbar.SaveToolbar(2, configleftbar);
    f_edittoolbar.SaveToolbar(3, configrightbar);
    nummainbar := configmainbar.Count;
    numobjectbar := configobjectbar.Count;
    numleftbar := configleftbar.Count;
    numrightbar := configrightbar.Count;
    // show all the configured bar
    ViewToolsBar(True);
  end;
end;

procedure Tf_main.MenuEditToolbarClick(Sender: TObject);
begin
  EditToolBar(-1);
end;

procedure Tf_main.MenuToolboxConfigClick(Sender: TObject);
var
  i: integer;
begin
  f_scriptconfig := Tf_scriptconfig.Create(self);
  SetLength(f_scriptconfig.Fscript, numscript);
  f_scriptconfig.onScriptSelect := ShowScriptPanel;
  for i := 0 to numscript - 1 do
  begin
    f_scriptconfig.Fscript[i] := Fscript[i];
  end;
  f_scriptconfig.ShowModal;
  f_scriptconfig.Free;
end;

procedure Tf_main.MenuToolboxClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    ShowScriptPanel(TMenuItem(Sender).tag, False);
end;

procedure Tf_main.MenuUpdAsteroidClick(Sender: TObject);
begin
  UpdateAstExt;
  SetupSolsysPage(3, True);
end;

procedure Tf_main.MenuUpdCatalogClick(Sender: TObject);
begin
  if f_updcatalog.Running then exit;
  f_updcatalog.Show;
end;

procedure Tf_main.OpenUpdCatalog(Sender: TObject);
begin
  if (ConfigCatalog<>nil)and(sender=ConfigCatalog.f_config_catalog1) then begin
    ConfigCatalog.ModalResult:=mrOK;
    ConfigCatalog.Close;
    Application.QueueAsyncCall(OpenUpdCatalogAsync,0);
  end;
  if (f_config<>nil)and(sender=f_config.f_config_catalog1) then begin
    f_config.ModalResult:=mrOK;
    f_config.Close;
    Application.QueueAsyncCall(OpenUpdCatalogAsync,0);
  end;
end;

procedure Tf_main.OpenUpdCatalogAsync(Data: PtrInt);
begin
  MenuUpdCatalogClick(nil);
end;

procedure Tf_main.RunCatgen(Sender: TObject);
begin
  if (ConfigCatalog<>nil)and(sender=ConfigCatalog.f_config_catalog1) then begin
    ConfigCatalog.ModalResult:=mrOK;
    ConfigCatalog.Close;
    Application.QueueAsyncCall(RunCatgenAsync,0);
  end;
  if (f_config<>nil)and(sender=f_config.f_config_catalog1) then begin
    f_config.ModalResult:=mrOK;
    f_config.Close;
    Application.QueueAsyncCall(RunCatgenAsync,0);
  end;
end;

procedure Tf_main.RunCatgenAsync(Data: PtrInt);
begin
  if f_catgen=nil then begin
     Application.CreateForm(Tf_catgen, f_catgen);
  end;
  FormPos(f_catgen, mouse.CursorPos.x, mouse.CursorPos.y);
 f_catgen.show;
end;

procedure Tf_main.OpenCatalogSetup(Sender: TObject);
begin
  if (f_updcatalog<>nil)and(sender=f_updcatalog)and(not f_updcatalog.Running) then begin
    f_updcatalog.Close;
    Application.QueueAsyncCall(OpenCatalogSetupAsync,0);
  end;
end;

procedure Tf_main.OpenCatalogSetupAsync(Data: PtrInt);
begin
  SetupCatalogPage(-1);
end;

procedure Tf_main.SaveCatalogConfig(Sender: TObject);
begin
  SaveDefault;
end;

procedure Tf_main.UpdateAstExt;
var
  fn,dt1,dt2: string;
  f: textfile;
begin
try
  fn :=slash(tempdir)+'lc_summary.DATE';
  if FileExists(fn) then begin
    AssignFile(f,fn);
    reset(f);
    readln(f,dt1);
    closefile(f);
  end
  else begin
    dt1:='0000-00-00';
  end;
  if QuickDownload(URL_Asteroid_Lightcurve_Date, fn) then begin
    AssignFile(f,fn);
    reset(f);
    readln(f,dt2);
    closefile(f);
    if dt1<>dt2 then begin
      fn :=slash(tempdir)+'lc_summary.txt';
      if QuickDownload(URL_Asteroid_Lightcurve_Database, fn) then begin
        cdcdb.LoadAstExt(fn);
      end;
      fn :=slash(tempdir)+'lc_familylookup.txt';
      if QuickDownload(URL_Asteroid_Lightcurve_Family, fn) then begin
        cdcdb.LoadAstFam(fn);
      end;
    end;
  end;
except
end;
end;

procedure Tf_main.MenuUpdCometClick(Sender: TObject);
begin
  SetupSolsysPage(2, True);
end;

procedure Tf_main.MenuUpdDeltaTClick(Sender: TObject);
var
  fn: string;
begin
    fn :=slash(privatedir)+'leap-seconds.list';
    if QuickDownload(URL_LEAPSECOND, fn) then begin
      LoadLeapseconds(false);
    end
    else begin
      ShowMessage('Cannot update the Delta T file now, please check your Internet connection');
      exit;
    end;
    fn:=slash(privatedir)+'finals.data';
    if QuickDownload(URL_IERS, fn) then begin
      LoadIERS;
    end;
    fn :=slash(privatedir)+'deltat.txt';
    if QuickDownload(URL_DELTAT, fn) then begin
      LoadDeltaT;
      ShowMessage(rsUpdatedSucce);
    end;
end;

procedure Tf_main.MenuUpdGrsClick(Sender: TObject);
begin
  SetupSolsysPage(1, True);
end;

procedure Tf_main.MenuUpdSatelliteClick(Sender: TObject);
var
  calvisible: boolean;
begin
  calvisible := f_calendar.Visible;
  if not calvisible then
  begin
    if MultiFrame1.ActiveObject is Tf_chart then
      f_calendar.config.Assign(Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc)
    else
      f_calendar.config.Assign(def_cfgsc);
  end;
  f_calendar.AzNorth := catalog.cfgshr.AzNorth;
  formpos(f_calendar, mouse.cursorpos.x, mouse.cursorpos.y);
  f_calendar.Show;
  f_calendar.bringtofront;
  f_calendar.PageControl1.PageIndex := 6;
  f_calendar.BtnTleDownload.Click;
  if not calvisible then
    f_calendar.Close;
end;

function Tf_main.QuickDownload(url, fn: string): boolean;
var
  dl: TDownloadDialog;
begin
  Result := False;
  dl := TDownloadDialog.Create(self);
  dl.ScaleDpi:=UScaleDPI.scale;
  dl.UserAgent:='Skychart/'+cdcversion + '-' + RevisionStr;
  try
    if cfgm.HttpProxy then
    begin
      dl.SocksProxy := '';
      dl.SocksType := '';
      dl.HttpProxy := cfgm.ProxyHost;
      dl.HttpProxyPort := cfgm.ProxyPort;
      dl.HttpProxyUser := cfgm.ProxyUser;
      dl.HttpProxyPass := cfgm.ProxyPass;
    end
    else if cfgm.SocksProxy then
    begin
      dl.HttpProxy := '';
      dl.SocksType := cfgm.SocksType;
      dl.SocksProxy := cfgm.ProxyHost;
      dl.HttpProxyPort := cfgm.ProxyPort;
      dl.HttpProxyUser := cfgm.ProxyUser;
      dl.HttpProxyPass := cfgm.ProxyPass;
    end
    else
    begin
      dl.SocksProxy := '';
      dl.SocksType := '';
      dl.HttpProxy := '';
      dl.HttpProxyPort := '';
      dl.HttpProxyUser := '';
      dl.HttpProxyPass := '';
    end;
    dl.ConfirmDownload := False;
    dl.URL := url;
    dl.SaveToFile := fn;
    Result := dl.Execute and FileExists(fn);
  finally
    dl.Free;
  end;
end;

procedure Tf_main.MenuUpdSoftClick(Sender: TObject);
var
  ver, newver, newbeta, fn, url: string;
  f: textfile;
begin
  ver := cdcversion + '-' + RevisionStr;
  if cdcbeta then
  {%H-}begin
    url := 'https://www.ap-i.net/pub/skychart/beta.txt';
    fn := slash(TempDir) + 'beta.txt';
    if QuickDownload(url, fn) then
    begin
      AssignFile(f, fn);
      reset(f);
      readln(f, newbeta);
      Closefile(f);
      if (CompareVersion(ver, newbeta) > 0) then
      begin
        if MessageDlg(rsNewBetaVersi, Format(rsANewVersionO, [newbeta, crlf]),
          mtInformation, mbYesNo, 0) = mrYes then
        begin
          ExecuteFile('https://sourceforge.net/projects/skychart/files/0-beta/');
        end;
      end
      else
        ShowMessage(rsYouAlreadyHa);
    end
    else
      ShowMessage('Cannot check version now, please check your Internet connection');
  end
  else
  {%H-}begin
    url := 'https://www.ap-i.net/pub/skychart/version.txt';
    fn := slash(TempDir) + 'version.txt';
    if QuickDownload(url, fn) then
    begin
      AssignFile(f, fn);
      reset(f);
      readln(f, newver);
      Closefile(f);
      if CompareVersion(ver, newver) > 0 then
      begin
        if MessageDlg(rsNewVersionAv, Format(rsANewVersionO, [newver, crlf]),
          mtInformation, mbYesNo, 0) = mrYes then
        begin
          ExecuteFile('https://www.ap-i.net/skychart/en/download');
        end;
      end
      else
        ShowMessage(rsYouAlreadyHa);
    end
    else
      ShowMessage('Cannot check version now, please check your Internet connection');
  end;
end;

procedure Tf_main.ToolBarFOVResize(Sender: TObject);
var
  i, w, h, sp: integer;
begin
  w := TPanel(Sender).Width;
  h := TPanel(Sender).Height;
  if w > h then
  begin
    i := 0;
    sp := w div 10;
    with tbFOV1 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV2 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV3 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV4 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV5 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV6 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV7 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV8 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV9 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
    with tbFOV10 do
    begin
      Left := i * sp;
      Top := 0;
    end;
    Inc(i);
  end
  else
  begin
    i := 0;
    sp := h div 10;
    with tbFOV1 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV2 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV3 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV4 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV5 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV6 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV7 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV8 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV9 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
    with tbFOV10 do
    begin
      Top := i * sp;
      Left := 0;
    end;
    Inc(i);
  end;
end;


procedure Tf_main.MDEditToolBar(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  sp: TPoint;
begin
  if Button = mbRight then
  begin
    if (Sender is TToolBar) then
    begin
      PopupToolbar1.Caption := rsToolBarEdito + Ellipsis;
      PopupToolbar1.Visible := True;
      PopupToolbar2.Visible := False;
      sp := TToolButton(Sender).ClientToScreen(point(x, y));
      PopupToolbar.PopUp(sp.x, sp.y);
    end;
  end;
end;

procedure Tf_main.MagPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  sp: TPoint;
begin
  if Button = mbRight then
  begin
    PopupToolbar1.Caption := rsToolBarEdito + Ellipsis;
    PopupToolbar1.Visible := True;
    PopupToolbar2.Caption := rsSetup + ' / ' + rsChartCoordin + ' / ' +
      rsObjectFilter + Ellipsis;
    PopupToolbar2.Tag := 0;
    PopupToolbar2.Visible := True;
    sp := TControl(Sender).ClientToScreen(point(x, y));
    PopupToolbar.PopUp(sp.x, sp.y);
  end;
end;

procedure Tf_main.ToolButtonMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  act: string;
  sp: TPoint;

  procedure SetMenu2(txt: string; n: integer);
  begin
    PopupToolbar2.Caption := txt;
    PopupToolbar2.Tag := n;
    PopupToolbar2.Visible := True;
  end;

begin
  if (Sender is TToolButton) and (TToolButton(Sender).Action <> nil) then
  begin
    act := TToolButton(Sender).Action.Name;
    if Button = mbRight then
    begin
      PopupToolbar1.Caption := rsToolBarEdito + Ellipsis;
      PopupToolbar1.Visible := True;
      PopupToolbar2.Visible := False;
      if act = 'ShowStars' then
        SetMenu2(rsSetup + ' / ' + rsCatalog + ' / ' + rsCdCStars + Ellipsis, 1)
      else if act = 'ShowNebulae' then
        SetMenu2(rsSetup + ' / ' + rsCatalog + ' / ' + rsCdCNebulae + Ellipsis, 2)
      else if act = 'ShowLines' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsLines + Ellipsis, 3)
      else if act = 'ShowPictures' then
        SetMenu2(rsSetup + ' / ' + rsPictures + ' / ' + rsDSOCatalogPi + Ellipsis, 4)
      else if act = 'ShowVO' then
        SetMenu2(rsSetup + ' / ' + rsCatalog + ' / ' + rsVOCatalog + Ellipsis, 5)
      else if act = 'ShowUobj' then
        SetMenu2(rsSetup + ' / ' + rsCatalog + ' / ' + rsUserDefinedO + Ellipsis, 6)
      else if act = 'DSSImage' then
        SetMenu2(rsSetup + ' / ' + rsPictures + ' / ' + rsDSSRealSky + Ellipsis, 7)
      else if act = 'SetPictures' then
        SetMenu2(rsSetup + ' / ' + rsPictures + ' / ' + rsBackgroundPi + Ellipsis, 8)
      else if act = 'ShowPlanets' then
        SetMenu2(rsSetup + ' / ' + rsSolarSystem + ' / ' + rsPlanet + Ellipsis, 9)
      else if act = 'ShowAsteroids' then
        SetMenu2(rsSetup + ' / ' + rsSolarSystem + ' / ' + rsAsteroid + Ellipsis, 10)
      else if act = 'ShowComets' then
        SetMenu2(rsSetup + ' / ' + rsSolarSystem + ' / ' + rsComet + Ellipsis, 11)
      else if act = 'ShowLine' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsLines + Ellipsis, 12)
      else if act = 'ShowMilkyWay' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsLines + Ellipsis, 13)
      else if act = 'Grid' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsGrids + Ellipsis, 14)
      else if act = 'GridEQ' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsGrids + Ellipsis, 15)
      else if act = 'ShowConstellationLine' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsGrids + Ellipsis, 16)
      else if act = 'ShowConstellationLimit' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsGrids + Ellipsis, 17)
      else if act = 'ShowGalacticEquator' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsLines + Ellipsis, 18)
      else if act = 'ShowEcliptic' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsLines + Ellipsis, 19)
      else if act = 'ShowCompass' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + ' / ' + rsGridSpacing + Ellipsis, 20)
      else if act = 'ShowMark' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsFinderRectan + Ellipsis, 21)
      else if act = 'ShowLabels' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsLabel2 + Ellipsis, 22)
      else if act = 'EditLabels' then
        SetMenu2(rsResetAllLabe, 23)
      else if act = 'ShowObjectbelowHorizon' then
        SetMenu2(rsSetup + ' / ' + rsObservatory + ' / ' + rsHorizon + Ellipsis, 24)
      else if act = 'switchbackground' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsSkyColour + Ellipsis, 25)
      else if act = 'switchstars' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + Ellipsis, 26)
      else if act = 'ZoomBar' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + ' / ' + rsFieldOfVisio +
          Ellipsis, 27)
      else if act = 'listobj' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + ' / ' + rsObjectList + Ellipsis, 28)
      else if act = 'Animation' then
        SetMenu2(rsSetup + ' / ' + rsDateTime + ' / ' + rsAnimation + Ellipsis, 29)
      else if act = 'TelescopeConnect' then
        SetMenu2(rsSetup + ' / ' + rsGeneral + ' / ' + rsTelescope + Ellipsis, 30)
      else if act = 'TelescopeSync' then
        SetMenu2(rsSetup + ' / ' + rsGeneral + ' / ' + rsTelescope + Ellipsis, 31)
      else if act = 'TelescopeSlew' then
        SetMenu2(rsSetup + ' / ' + rsGeneral + ' / ' + rsTelescope + Ellipsis, 32)
      else if act = 'TelescopeAbortSlew' then
        SetMenu2(rsSetup + ' / ' + rsGeneral + ' / ' + rsTelescope + Ellipsis, 33)
      else if act = 'EquatorialProjection' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + Ellipsis, 34)
      else if act = 'AltAzProjection' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + Ellipsis, 35)
      else if act = 'EclipticProjection' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + Ellipsis, 36)
      else if act = 'GalacticProjection' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + Ellipsis, 37)
      else if act = 'rot_plus' then
        SetMenu2(rsResetRotatio, 38)
      else if act = 'rot_minus' then
        SetMenu2(rsResetRotatio, 39)
      else if act = 'rotate180' then
        SetMenu2(rsResetRotatio, 40)
      else if act = 'zoomplus' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + ' / ' + rsFieldOfVisio +
          Ellipsis, 41)
      else if act = 'zoomminus' then
        SetMenu2(rsSetup + ' / ' + rsChartCoordin + ' / ' + rsFieldOfVisio +
          Ellipsis, 42)
      else if act = 'ViewNightVision' then
        SetMenu2(rsSetup + ' / ' + rsDisplay + ' / ' + rsColor + Ellipsis, 43)
      else if act = 'Print1' then
        SetMenu2(rsFile + ' / ' + rsPrinterSetup + Ellipsis, 44);
      sp := TToolButton(Sender).ClientToScreen(point(x, y));
      PopupToolbar.PopUp(sp.x, sp.y);
    end;
  end;
end;

procedure Tf_main.tbFOVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  sp: TPoint;
begin
  if Button = mbRight then
  begin
    PopupToolbar1.Caption := rsToolBarEdito + Ellipsis;
    PopupToolbar1.Visible := True;
    PopupToolbar2.Caption := rsSetup + ' / ' + rsChartCoordin + ' / ' +
      rsFieldOfVisio + Ellipsis;
    PopupToolbar2.Tag := 45;
    PopupToolbar2.Visible := True;
    sp := TControl(Sender).ClientToScreen(point(x, y));
    PopupToolbar.PopUp(sp.x, sp.y);
  end;
end;

procedure Tf_main.PopupToolbar2Click(Sender: TObject);
begin
  case TMenuItem(Sender).tag of
    0: SetupChartPage(3);
    1: SetupCatalogPage(0);
    2: SetupCatalogPage(1);
    3: SetupDisplayPage(5);
    4: SetupPicturesPage(0);
    5: SetupCatalogPage(3);
    6: SetupCatalogPage(4);
    7: SetupPicturesPage(2);
    8: SetupPicturesPage(1);
    9: SetupSolsysPage(1);
    10: SetupSolsysPage(3);
    11: SetupSolsysPage(2);
    12: SetupDisplayPage(5);
    13: SetupDisplayPage(5);
    14: SetupDisplayPage(4);
    15: SetupDisplayPage(4);
    16: SetupDisplayPage(4);
    17: SetupDisplayPage(4);
    18: SetupDisplayPage(5);
    19: SetupDisplayPage(5);
    20: SetupChartPage(4);
    21: SetupDisplayPage(9);
    22: SetupDisplayPage(6);
    23: ResetAllLabels1Click(Sender);
    24: SetupObservatoryPage(1);
    25: SetupDisplayPage(3);
    26: SetupDisplayPage(0);
    27: SetupChartPage(1);
    28: SetupChartPage(5);
    29: SetupTimePage(2);
    30: SetupSystemPage(1);
    31: SetupSystemPage(1);
    32: SetupSystemPage(1);
    33: SetupSystemPage(1);
    34: SetupChartPage(0);
    35: SetupChartPage(0);
    36: SetupChartPage(0);
    37: SetupChartPage(0);
    38: ResetRotationExecute(Sender);
    39: ResetRotationExecute(Sender);
    40: ResetRotationExecute(Sender);
    41: SetupChartPage(1);
    42: SetupChartPage(1);
    43: SetupDisplayPage(1);
    44: PrintSetup(Sender);
    45: SetupChartPage(1);
  end;
end;

procedure Tf_main.PolePrecessionExecute(Sender: TObject);
begin
 if f_precession=nil then begin
   f_precession:=Tf_precession.Create(self);
   f_precession.onChange:=PolePrecessionChange;
 end;
 f_precession.SetLang;
 f_precession.Show;
end;

procedure Tf_main.PolePrecessionChange(Sender: TObject);
begin
 if f_precession=nil then exit;
 if MultiFrame1.ActiveObject is Tf_chart then begin
   with MultiFrame1.ActiveObject as Tf_chart do begin
     sc.cfgsc.PPyearstart:=f_precession.yearstart.Value;
     sc.cfgsc.PPyearend:=f_precession.yearend.Value;
     sc.cfgsc.PPyearlabelstep:=f_precession.labelstep.Value;
     sc.cfgsc.PPdrawlabel:=f_precession.DrawLabel.Checked;
     sc.cfgsc.PPdraw:=f_precession.Draw;
     Refresh(True,True);
   end;
 end;
end;

procedure Tf_main.ToolButtonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  act: string;
begin
  if (Sender is TToolButton) and (TToolButton(Sender).Action <> nil) then
  begin
    act := TToolButton(Sender).Action.Name;
    if Button = mbLeft then
    begin
      if (act = 'rot_plus') or (act = 'rot_minus') then
      begin
        if ssCtrl in Shift then
          rotspeed := 45
        else if ssShift in Shift then
          rotspeed := 1
        else if ssMeta in Shift then
          rotspeed := 180
        else
          rotspeed := 15;
      end;
    end;
  end;
end;

procedure Tf_main.UpdateSAMPmenu;
begin
  if samp = nil then
  begin
    SampConnected := False;
    MenuSAMPConnect.Enabled := True;
    MenuSAMPDisconnect.Enabled := False;
    MenuSAMPStatus.Enabled := True;
    MenuSAMPSetup.Enabled := True;
  end
  else
  begin
    SampConnected := samp.Connected;
    MenuSAMPConnect.Enabled := not samp.Connected;
    MenuSAMPDisconnect.Enabled := samp.Connected;
    MenuSAMPStatus.Enabled := True;
    MenuSAMPSetup.Enabled := True;
  end;
end;

procedure Tf_main.SAMPStart(auto: boolean = False);
begin
  WriteTrace('start SAMP client');
  if samp = nil then
    samp := TSampClient.Create;
  samp.hubprofileerror := rsUnsupportedS;
  samp.hubmissingvalue := rsSAMPHubProfi;
  samp.nohuberror := rsNoSAMPHubPro;
  samp.onClientChange := SAMPClientChange;
  samp.onDisconnect := SAMPDisconnect;
  samp.oncoordpointAtsky := SAMPcoordpointAtsky;
  samp.onImageLoadFits := SAMPImageLoadFits;
  samp.onTableLoadVotable := SAMPTableLoadVotable;
  samp.onTableHighlightRow := SAMPTableHighlightRow;
  samp.onTableSelectRowlist := SAMPTableSelectRowlist;
  if samp.SampReadProfile then
  begin
    if not samp.SampHubConnect then
      WriteTrace(samp.LastError);
    if samp.Connected then
    begin
      WriteTrace('Connected to ' + samp.HubUrl);
      if not samp.SampHubSendMetadata then
        WriteTrace(samp.LastError);
      if not samp.SampSubscribe(cfgm.SampSubscribeCoord, cfgm.SampSubscribeImage,
        cfgm.SampSubscribeTable) then
        WriteTrace(samp.LastError);
      WriteTrace('Listen on port ' + IntToStr(samp.ListenPort));
    end;
  end
  else
  begin
    WriteTrace(samp.LastError);
    if auto then
      SetLPanel1('SAMP: ' + samp.LastError)
    else
      ShowMessage('SAMP: ' + samp.LastError);
  end;
  SampConnected := samp.Connected;
  SetTopMessage(topmsg, MultiFrame1.ActiveObject);
end;

procedure Tf_main.SAMPStop;
var
  fs: TSearchRec;
  i: integer;
begin
  if (samp <> nil) then
  begin
    if samp.Connected then
    begin
      WriteTrace('stop SAMP client');
      samp.SampHubDisconnect;
      SampConnected := samp.Connected;
      if not cfgm.SampKeepTables then
      begin
        i := findfirst(slash(VODir) + 'vo_samp*', 0, fs);
        while i = 0 do
        begin
          DeleteFile(slash(VODir) + fs.Name);
          i := findnext(fs);
        end;
        findclose(fs);
      end;
      if not cfgm.SampKeepImages then
      begin
        i := findfirst(slash(PictureDir) + 'samp_*', 0, fs);
        while i = 0 do
        begin
          DeleteFile(slash(PictureDir) + fs.Name);
          i := findnext(fs);
        end;
        findclose(fs);
      end;
    end
    else
    begin
      samp.StopHTTPServer;
    end;
  end;
end;

procedure Tf_main.SAMPDisconnect(Sender: TObject);
begin
  UpdateSAMPmenu;
  SetTopMessage(topmsg, MultiFrame1.ActiveObject);
end;

procedure Tf_main.SAMPClientChange(Sender: TObject);
var
  i: integer;
begin
  if samp.SampHubGetClientList then
  begin
    SampClientId.Clear;
    SampClientName.Clear;
    SampClientDesc.Clear;
    SampClientCoordpointAtsky.Clear;
    SampClientImageLoadFits.Clear;
    SampClientTableLoadVotable.Clear;
    for i := 0 to samp.Clients.Count - 1 do
    begin
      SampClientId.Add(samp.Clients[i]);
      if i < samp.ClientNames.Count then
        SampClientName.Add(samp.ClientNames[i])
      else
        SampClientName.Add(samp.Clients[i]);
      if i < samp.ClientDesc.Count then
        SampClientDesc.Add(samp.ClientDesc[i])
      else
        SampClientDesc.Add('');
      if coord_pointAt_sky in samp.ClientSubscriptions[i] then
        SampClientCoordpointAtsky.Add('1')
      else
        SampClientCoordpointAtsky.Add('');
      if image_load_fits in samp.ClientSubscriptions[i] then
        SampClientImageLoadFits.Add('1')
      else
        SampClientImageLoadFits.Add('');
      if table_load_votable in samp.ClientSubscriptions[i] then
        SampClientTableLoadVotable.Add('1')
      else
        SampClientTableLoadVotable.Add('');
    end;
  end;
end;

procedure Tf_main.SAMPurlToFile(url, nam, typ: string; var fn: string);
var
  i: integer;
  sfn: string;

  function cleanname(s: string): string;
  var
    p, k: integer;
    buf, n: string;
  begin
    Result := '';
    p := 1;
    while p <= length(s) do
    begin
      buf := copy(s, p, 1);
      if buf = '%' then
      begin
        n := copy(s, p + 1, 2);
        k := strtointdef('$' + n, -1);
        if k > 0 then
        begin
          Result := Result + char(k);
          Inc(p, 2);
        end
        else
          Result := Result + buf;
      end
      else
        Result := Result + buf;
      Inc(p);
    end;
  end;

begin
  if typ = 'xml' then
    fn := slash(VODir) + 'vo_samp_' + TrimFilename(nam) + '.' + typ;
  if typ = 'fits' then
    fn := slash(PictureDir) + 'samp_' + TrimFilename(nam) + '.' + typ;
  fn := TrimFilename(cleanname(fn));
  // file:
  i := pos('file://', url);
  if i > 0 then
  begin
    Delete(url, i, i + 6);
    i := pos('localhost', url);
    if i >= 0 then
    begin
      Delete(url, i, i + 8);
    {$ifdef mswindows}
      if copy(url, 1, 1) = '/' then
        Delete(url, 1, 1);
    {$endif}
    end;
    sfn := TrimFilename(cleanname(url));
    CopyFile(sfn, fn);
  end
  else
  begin
    // http:
    i := pos('http://', url);
    if i > 0 then
    begin
      SampDownload.URL := url;
      SampDownload.SaveToFile := fn;
      SampDownload.ConfirmDownload := False;
      if not (SampDownload.Execute and FileExists(fn)) then
      begin
        fn := '';
      end;
    end;
  end;
end;

procedure Tf_main.SAMPcoordpointAtsky(ra, Dec: double);
begin
  if cfgm.SampConfirmCoord then
  begin
    if MessageDlgCenter(rsSAMPConfirma, rsASAMPApplica3 + ':' + crlf +
      rsRA + ':' + ARToStr(ra / 15) + blank + rsDEC + ':' + DEToStr(Dec) +
      crlf + rsDoYouWantToM, mtConfirmation, [mbYes, mbNo]) = mrNo then
      exit;
  end;
  if not (MultiFrame1.ActiveObject is Tf_chart) then exit;
  with MultiFrame1.ActiveObject as Tf_chart do begin
    Identlabel.Visible:=false;
    ra := deg2rad * ra;
    Dec := deg2rad * Dec;
    CoordJ2000toChart(ra, Dec);
    cmd_MoveScope(formatfloat(f5, rad2deg * ra / 15),formatfloat(f5, rad2deg * Dec));
    cmd_TrackTelescope('OFF');
    sc.cfgsc.racentre := ra;
    sc.cfgsc.decentre := Dec;
    Refresh(True, True);
    identxy(sc.cfgsc.Xcentre, sc.cfgsc.Ycentre, True, True);
    if not Identlabel.Visible then begin
      sc.cfgsc.TrackName:='SAMP_point';
      sc.cfgsc.TrackRA := ra;
      sc.cfgsc.TrackDec := dec;
      sc.cfgsc.TrackEpoch := sc.cfgsc.JDChart;
      sc.cfgsc.FindOK := True;
      sc.cfgsc.FindSize := 0;
      sc.cfgsc.FindPM := False;
      sc.cfgsc.FindType := ftInv;
      sc.cfgsc.FindName:=sc.cfgsc.TrackName;
      sc.cfgsc.FindId := sc.cfgsc.FindName;
      sc.cfgsc.FindDesc := '';
      sc.cfgsc.FindNote := '';
      sc.cfgsc.FindRA:=sc.cfgsc.TrackRA;
      sc.cfgsc.FindDec:=sc.cfgsc.TrackDec;
      sc.cfgsc.FindRA2000 := sc.cfgsc.TrackRA;
      sc.cfgsc.FindDec2000 := sc.cfgsc.TrackDec;
      Precession(sc.cfgsc.JDChart, jd2000, sc.cfgsc.FindRA2000, sc.cfgsc.FindDec2000);
      cmd_SetCursorPosition(Image1.Width div 2, Image1.Height div 2);
      ShowIdentLabel;
    end;
  end;
end;

procedure Tf_main.SAMPImageLoadFits(image_name, image_id, url: string);
var
  cname, fn: string;
  arg: TStringList;
begin
  if cfgm.SampConfirmImage then
  begin
    if MessageDlgCenter(rsSAMPConfirma, rsASAMPApplica2 + ':' + crlf +
      image_name + crlf + rsDoYouWantToL, mtConfirmation, [mbYes, mbNo]) = mrNo then
      exit;
  end;
  SAMPurlToFile(url, image_name, 'fits', fn);
  if FileExists(fn) then
  begin
    cname := MultiFrame1.ActiveChild.Caption;
    arg := TStringList.Create;
    arg.Add('LOADBGIMAGE');
    arg.Add(fn);
    ExecuteCmd(cname, arg);
    arg.Clear;
    arg.Add('SHOWBGIMAGE');
    arg.Add('ON');
    ExecuteCmd(cname, arg);
    arg.Free;
  end;
end;

procedure Tf_main.SAMPTableLoadVotable(table_name, table_id, url: string);
var
  fn, cfn, buf: string;
  i: integer;
  VO_TableData: TVO_TableData;
  config: TCCDconfig;
begin
  if cfgm.SampConfirmTable then
  begin
    if MessageDlgCenter(rsSAMPConfirma, rsASAMPApplica + ':' + crlf +
      table_name + crlf + rsDoYouWantToL, mtConfirmation, [mbYes, mbNo]) = mrNo then
      exit;
  end;
  SAMPurlToFile(url, table_name, 'xml', fn);
  if FileExists(fn) then
  begin
    VO_TableData := TVO_TableData.Create(self);
    VO_TableData.CachePath := ExtractFilePath(fn);
    VO_TableData.Datafile := ExtractFileName(fn);
    VO_TableData.LoadMeta;
    cfn := ChangeFileExt(fn, '.config');
    config := TCCDconfig.Create(self);
    config.Filename := cfn;
    config.SetValue('VOcat/catalog/name', table_id);
    config.SetValue('VOcat/catalog/table', table_name);
    buf := table_id;
    config.SetValue('VOcat/catalog/sampid', buf);
    config.SetValue('VOcat/catalog/sampurl', url);
    config.SetValue('VOcat/catalog/objtype', 'dso');
    config.SetValue('VOcat/update/fullcat', True);
    config.SetValue('VOcat/update/baseurl', '');
    config.SetValue('VOcat/update/votype', 0);
    config.SetValue('VOcat/plot/active', True);
    config.SetValue('VOcat/plot/maxmag', -99);
    config.SetValue('VOcat/plot/drawtype', 15);
    config.SetValue('VOcat/plot/drawcolor', clRed);
    config.SetValue('VOcat/plot/forcecolor', 1);
    config.SetValue('VOcat/default/defsize', 0);
    config.SetValue('VOcat/default/defmag', 99);
    config.SetValue('VOcat/fields/fieldcount', length(VO_TableData.Columns));
    for i := 0 to length(VO_TableData.Columns) - 1 do
      config.SetValue('VOcat/fields/field_' + IntToStr(i), VO_TableData.Columns[i]);
    config.Flush;
    config.Free;
    VO_TableData.Free;
    if MultiFrame1.ActiveObject is Tf_chart then
      with MultiFrame1.ActiveObject as Tf_chart do
      begin
        sc.catalog.cfgcat.starcatdef[vostar - BaseStar] := True;
        sc.catalog.cfgcat.nebcatdef[voneb - BaseNeb] := True;
        Refresh(True, True);
      end;
  end;
end;

procedure Tf_main.SAMPTableHighlightRow(table_id, url, row: string);
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.catalog.cfgcat.starcatdef[vostar - BaseStar] := True;
      sc.catalog.cfgcat.nebcatdef[voneb - BaseNeb] := True;
      sc.catalog.cfgcat.SampSelectedTable := table_id;
      sc.catalog.cfgcat.SampSelectFirst := False;
      sc.catalog.cfgcat.SampSelectedNum := 1;
      SetLength(sc.catalog.cfgcat.SampSelectedRec,
        sc.catalog.cfgcat.SampSelectedNum + 1);
      sc.catalog.cfgcat.SampSelectedRec[0] := StrToIntDef(row, 0);
      samp.LockTableSelectRow := True;
      sc.cfgsc.FindOK := False;
      Refresh(True, True);
      samp.LockTableSelectRow := False;
    end;
end;

procedure Tf_main.SAMPTableSelectRowlist(table_id, url: string; rowlist: TStringList);
var
  i: integer;
begin
  if MultiFrame1.ActiveObject is Tf_chart then
    with MultiFrame1.ActiveObject as Tf_chart do
    begin
      sc.catalog.cfgcat.starcatdef[vostar - BaseStar] := True;
      sc.catalog.cfgcat.nebcatdef[voneb - BaseNeb] := True;
      sc.catalog.cfgcat.SampSelectedTable := table_id;
      sc.catalog.cfgcat.SampSelectedNum := rowlist.Count;
      if sc.catalog.cfgcat.SampSelectedNum = 1 then
        sc.catalog.cfgcat.SampSelectFirst := True
      else
        sc.catalog.cfgcat.SampSelectFirst := False;
      SetLength(sc.catalog.cfgcat.SampSelectedRec,
        sc.catalog.cfgcat.SampSelectedNum + 1);
      for i := 0 to rowlist.Count - 1 do
        sc.catalog.cfgcat.SampSelectedRec[i] := StrToIntDef(rowlist[i], 0);
      sc.cfgsc.FindOK := False;
      Refresh(True, True);
      samp.LockTableSelectRow := True;
      if sc.catalog.cfgcat.SampSelectFirst then
        IdentXY(sc.catalog.cfgcat.SampSelectX, sc.catalog.cfgcat.SampSelectY);
      samp.LockTableSelectRow := False;
    end;
end;

procedure Tf_main.SendCoordpointAtsky(client: string; ra, de: double);
begin
  ra := rad2deg * ra;
  de := rad2deg * de;
  if not samp.SampSendCoord(client, ra, de) then
  begin
    SetLPanel1(samp.LastError);
  end;
end;

procedure Tf_main.SendVoTable(client, tname, tid, url: string);
begin
  if not samp.SampSendVoTable(client, tname, tid, url) then
  begin
    SetLPanel1(samp.LastError);
  end;
end;

procedure Tf_main.SendSelectRow(tableid, url, row: string);
begin
  if not samp.LockTableSelectRow then
  begin
    if not samp.SampSelectRow('', tableid, url, row) then
    begin
      SetLPanel1(samp.LastError);
    end;
  end;
end;

procedure Tf_main.SendImageFits(client, imgname, imgid, url: string);
begin
  if not samp.SampSendImageFits(client, imgname, imgid, url) then
  begin
    SetLPanel1(samp.LastError);
  end;
end;

procedure Tf_main.InitScriptPanel;
var
  i: integer;
begin
  if VerboseMsg then
    WriteTrace('InitScript');
  for i := 0 to numscript - 1 do
  begin
    if DarkTheme then
      Fscript[i].ImageNormal:=Img16Night
    else
      Fscript[i].ImageNormal:=Img16Day;
    Fscript[i].ContainerPanel := ContainerPanel;
    Fscript[i].ToolButtonMouseUp := ToolButtonMouseUp;
    Fscript[i].ToolButtonMouseDown := ToolButtonMouseDown;
    Fscript[i].ActionListFile := ActionListFile;
    Fscript[i].ActionListEdit := ActionListEdit;
    Fscript[i].ActionListSetup := ActionListSetup;
    Fscript[i].ActionListView := ActionListView;
    Fscript[i].ActionListChart := ActionListChart;
    Fscript[i].ActionListTelescope := ActionListTelescope;
    Fscript[i].ActionListWindow := ActionListWindow;
    Fscript[i].TimeValPanel := TimeValPanel; // keep in sequence! 1 //
    Fscript[i].EditTimeVal := EditTimeVal;   // keep in sequence! 2 //
    Fscript[i].TimeVal := TimeVal;           // keep in sequence! 3 //
    Fscript[i].TimeU := TimeU;
    Fscript[i].Mainmenu := MainMenu1;
    Fscript[i].MultiFrame := MultiFrame1;
    Fscript[i].cdb := cdcdb;
    Fscript[i].catalog := catalog;
    Fscript[i].Fits := Fits;
    Fscript[i].planet := planet;
    Fscript[i].cmain := cfgm;
    if MultiFrame1.ActiveObject is Tf_chart then
      Fscript[i].Activechart := Tf_chart(MultiFrame1.ActiveObject);
    Fscript[i].Init;
    if i = ActiveScript then
    begin
      ScriptPanel.Visible := True;
      Splitter1.Visible := True;
      Splitter1.ResizeControl := ScriptPanel;
      Fscript[i].ShowScript(True);
    end;
  end;
  Splitter1.ResizeControl := ScriptPanel;
  SetScriptMenuCaption;
  if VerboseMsg then
    WriteTrace('InitScript end');
end;

procedure Tf_main.SetScriptMenuCaption;
begin
  MenuToolbox1.Caption := Fscript[0].PanelTitle.Caption;
  MenuToolbox2.Caption := Fscript[1].PanelTitle.Caption;
  MenuToolbox3.Caption := Fscript[2].PanelTitle.Caption;
  MenuToolbox4.Caption := Fscript[3].PanelTitle.Caption;
  MenuToolbox5.Caption := Fscript[4].PanelTitle.Caption;
  MenuToolbox6.Caption := Fscript[5].PanelTitle.Caption;
  MenuToolbox7.Caption := Fscript[6].PanelTitle.Caption;
  MenuToolbox8.Caption := Fscript[7].PanelTitle.Caption;
  MenuToolbox9.Caption := rsAllConfigura;
end;

procedure Tf_main.ShowScriptPanel(n: integer);
begin
  ShowScriptPanel(n, True);
end;

procedure Tf_main.ShowScriptPanel(n: integer; showonly: boolean);
var
  i: integer;
begin
  if n < numscript then   // standard script
  begin
    if (f_configdirect<>nil) and (f_configdirect.Visible) then begin
      // hide config panel before to open the script
      ShowConfigPanel(false);
    end;
    for i := 0 to numscript - 1 do
    begin
      if i = n then
      begin
        if Fscript[i].Visible and (not showonly) then
        begin
          Fscript[i].ShowScript(False);
          Splitter1.Visible := False;
          ScriptPanel.Visible := False;
        end
        else
        begin
          if MultiFrame1.ActiveObject is Tf_chart then
            Fscript[i].Activechart := Tf_chart(MultiFrame1.ActiveObject);
          Splitter1.Visible := True;
          ScriptPanel.Visible := True;
          Splitter1.ResizeControl := ScriptPanel;
          Fscript[i].ShowScript(True);
        end;
      end
      else
        Fscript[i].ShowScript(False);
    end;
    ActiveScript := n;
  end
  // other function that use the script panel
  else if n = 8 then begin  // config panel
    if (f_configdirect<>nil) and (f_configdirect.Visible) then begin
      // hide config panel
      ShowConfigPanel(false);
    end
    else begin
      // show panel
      // close previous script if any
      for i := 0 to numscript - 1 do begin
        if Fscript[i].Visible then
        begin
          Fscript[i].ShowScript(False);
          Splitter1.Visible := False;
          ScriptPanel.Visible := False;
        end
      end;
      ShowConfigPanel(true);
    end;
  end;
end;

procedure Tf_main.ApplyScript(Sender: TObject);
begin
  SetScriptMenuCaption;
end;

procedure Tf_main.SetScriptMenu(Sender: TObject);
var
  i, j: integer;
begin
  with Sender as Tf_chart do
  begin
    // delete old entries
    for i := PopupMenuChart.Items.Count - 1 downto 0 do
      if PopupMenuChart.Items[i].Tag = 100 then
      begin
        for j := PopupMenuChart.Items[i].Count - 1 downto 0 do
          PopupMenuChart.Items[i].Delete(j);
        PopupMenuChart.Items.Delete(i);
      end;
    // add entries
    for i := 0 to numscript - 1 do
      Fscript[i].SetMenu(N1);
  end;
end;

procedure Tf_main.TelescopeMove(origin: string; ra, de: double);
var
  i: integer;
begin
  for i := 0 to numscript - 1 do
    Fscript[i].TelescopeMoveEvent(origin, ra, de);
end;

procedure Tf_main.TelescopeChange(origin: string; tc: boolean);
var
  i: integer;
begin
  FTelescopeConnected := tc;
  for i := 0 to numscript - 1 do
    Fscript[i].TelescopeConnectEvent(origin, FTelescopeConnected);
end;

procedure Tf_main.TimeUChange(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to numscript - 1 do
  begin
    Fscript[i].TimeU.ItemIndex := TimeU.ItemIndex;
  end;
end;

function Tf_main.CometMark(cname: string; arg: TStringList): string;
var
  i, mx: integer;
begin
  Result := msgFailed;
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.CometMark.Clear;
    mx := min(arg.Count - 1, 1000);
    for i := 0 to mx do
      Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.CometMark.Add(arg[i]);
    Tf_chart(MultiFrame1.ActiveObject).Refresh(True, True);
    Result := msgOK;
  end;
end;

function Tf_main.AsteroidMark(cname: string; arg: TStringList): string;
var
  i, mx: integer;
begin
  Result := msgFailed;
  if MultiFrame1.ActiveObject is Tf_chart then
  begin
    Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.AsteroidMark.Clear;
    mx := min(arg.Count - 1, 1000);
    for i := 0 to mx do
      Tf_chart(MultiFrame1.ActiveObject).sc.cfgsc.AsteroidMark.Add(arg[i]);
    Tf_chart(MultiFrame1.ActiveObject).Refresh(True, True);
    Result := msgOK;
  end;
end;

function Tf_main.GetScopeRates(cname: string; arg: TStringList): string;
var
  j: integer;
begin
  Result := msgFailed;
  arg.Clear;
  for j := 0 to MultiFrame1.ChildCount - 1 do
  begin
    if MultiFrame1.Childs[j].Caption = cname then
    begin
      Tf_chart(MultiFrame1.Childs[j].DockedObject).GetScopeRates(arg);
      if arg.Count > 0 then
        Result := msgOK;
    end;
  end;
end;

procedure Tf_main.LoadDeltaT;
var
  f: textfile;
  i, n: integer;
  fname,dfn,buf: string;
  dat, del, err: single;
begin
  fname:=slash(privatedir)+'deltat.txt';
  if not FileExistsUTF8(fname) then begin
    // try to copy distribution file
    dfn :=slash(appdir)+ slash('data')+ slash('deltat')+'deltat.txt';
    if FileExistsUTF8(dfn) then
        CopyFile( dfn , fname);
  end;
  if not FileExists(fname) then
  begin
    numdeltat := 0;
    setlength(deltat, 0, 0);
    exit;
  end;
  Filemode := 0;
  assignfile(f, fname);
  try
    reset(f);
    n := 0;
    // first loop to get the size
    repeat
      readln(f, buf);
      Inc(n);
    until EOF(f);
    setlength(deltat, n, 3);
    // read the file now
    reset(f);
    for i := 0 to n - 1 do
    begin
      readln(f, dat, del, err);
      deltat[i,0]:=dat;
      deltat[i,1]:=del;
      deltat[i,2]:=err;
    end;
    numdeltat:=n;
  finally
    closefile(f);
  end;
end;

procedure Tf_main.LoadLeapseconds(CanUpdate: boolean=true);
var
  f: textfile;
  i, n: integer;
  fname,dfn,buf: string;
  line: Tstringlist;
  dat, sec: double;
function toJD(ts:double):double;
begin
  result:=2400000.5+15020+(ts/secday);
end;
begin
  numleapseconds := 0;
  leapsecondexpires:=0;
  setlength(leapseconds, 0, 0);
  fname:=slash(privatedir)+'leap-seconds.list';
  if not FileExistsUTF8(fname) then begin
    // try to copy distribution file
    dfn :=slash(appdir)+ slash('data')+ slash('deltat')+'leap-seconds.list';
    if FileExistsUTF8(dfn) then
        CopyFile( dfn , fname);
  end;
  if not FileExists(fname) then
  begin
    exit;
  end;
  line:=Tstringlist.Create;
  Filemode := 0;
  assignfile(f, fname);
  try
    reset(f);
    n:=0;
    // first loop to get the size
    repeat
      readln(f, buf);
      Splitrec(buf,tab,line);
      if (line.Count>=2)and(StrToFloatDef(trim(line[0]),-1)>0) then
        Inc(n);
    until EOF(f);
    setlength(leapseconds, n, 2);
    // read the file now
    reset(f);
    i := 0;
    repeat
      readln(f, buf);
      Splitarg(buf,tab,line);
      if line.Count>=2 then begin
        if line[0]='#' then begin
          continue;
        end
        else if line[0]='#@' then begin
          dat:=StrToFloatDef(trim(line[1]),-1);
          if dat>0 then leapsecondexpires:=toJD(dat);
        end
        else begin
          dat:=StrToFloatDef(trim(line[0]),-1);
          sec:=StrToFloatDef(trim(line[1]),-1);
          if (i<n) and (dat>0) and (sec>0) then begin
            leapseconds[i,0]:=toJD(dat);
            leapseconds[i,1]:=sec;
            inc(i);
          end;
        end;
      end;
    until EOF(f);
    closefile(f);
    numleapseconds:=n;
    if CanUpdate and (leapsecondexpires>0) and ((leapsecondexpires-DateTimetoJD(now))<30) then begin
      // expire in less than one month, refresh now
      DownloadLeapSeconds;
    end;
  finally
    line.free;
  end;
end;

procedure Tf_main.DownloadLeapSeconds;
begin
  httpdownload:=THTTPBigDownload.Create(true);
  if cfgm.HttpProxy then
  begin
    httpdownload.SocksProxy := '';
    httpdownload.SocksType := '';
    httpdownload.HttpProxy := cfgm.ProxyHost;
    httpdownload.HttpProxyPort := cfgm.ProxyPort;
    httpdownload.HttpProxyUser := cfgm.ProxyUser;
    httpdownload.HttpProxyPass := cfgm.ProxyPass;
  end
  else if cfgm.SocksProxy then
  begin
    httpdownload.HttpProxy := '';
    httpdownload.SocksType := cfgm.SocksType;
    httpdownload.SocksProxy := cfgm.ProxyHost;
    httpdownload.HttpProxyPort := cfgm.ProxyPort;
    httpdownload.HttpProxyUser := cfgm.ProxyUser;
    httpdownload.HttpProxyPass := cfgm.ProxyPass;
  end
  else
  begin
    httpdownload.SocksProxy := '';
    httpdownload.SocksType := '';
    httpdownload.HttpProxy := '';
    httpdownload.HttpProxyPort := '';
    httpdownload.HttpProxyUser := '';
    httpdownload.HttpProxyPass := '';
  end;
  httpdownload.url:=URL_LEAPSECOND;
  httpdownload.filename:=slash(privatedir)+'leap-seconds.new';
  httpdownload.onDownloadComplete:=DownloadLeapSecondsComplete;
  httpdownload.Start;
end;

procedure Tf_main.DownloadLeapSecondsComplete;
var fn: string;
begin
  fn:=slash(privatedir)+'leap-seconds.list';
  if FileExists(httpdownload.filename) and (FileSize(httpdownload.filename)>0) then begin
    DeleteFile(fn);
    RenameFile(httpdownload.filename,fn);
  end
  else begin
    exit;
  end;
  LoadLeapseconds(false);
  httpdownload:=THTTPBigDownload.Create(true);
  if cfgm.HttpProxy then
  begin
    httpdownload.SocksProxy := '';
    httpdownload.SocksType := '';
    httpdownload.HttpProxy := cfgm.ProxyHost;
    httpdownload.HttpProxyPort := cfgm.ProxyPort;
    httpdownload.HttpProxyUser := cfgm.ProxyUser;
    httpdownload.HttpProxyPass := cfgm.ProxyPass;
  end
  else if cfgm.SocksProxy then
  begin
    httpdownload.HttpProxy := '';
    httpdownload.SocksType := cfgm.SocksType;
    httpdownload.SocksProxy := cfgm.ProxyHost;
    httpdownload.HttpProxyPort := cfgm.ProxyPort;
    httpdownload.HttpProxyUser := cfgm.ProxyUser;
    httpdownload.HttpProxyPass := cfgm.ProxyPass;
  end
  else
  begin
    httpdownload.SocksProxy := '';
    httpdownload.SocksType := '';
    httpdownload.HttpProxy := '';
    httpdownload.HttpProxyPort := '';
    httpdownload.HttpProxyUser := '';
    httpdownload.HttpProxyPass := '';
  end;
  httpdownload.url:=URL_IERS;
  httpdownload.filename:=slash(privatedir)+'finals.new';
  httpdownload.onDownloadComplete:=DownloadIERSComplete;
  httpdownload.Start;
end;

procedure Tf_main.DownloadIERSComplete;
var fn: string;
begin
  fn:=slash(privatedir)+'finals.data';
  if FileExists(httpdownload.filename) and (FileSize(httpdownload.filename)>0) then begin
    DeleteFile(fn);
    RenameFile(httpdownload.filename,fn);
    LoadIERS;
  end
end;

procedure Tf_main.LoadIERS;
var
  f: textfile;
  i, n: integer;
  fname,dfn,buf: string;
begin
  fname:=slash(privatedir)+'finals.data';
  if not FileExists(fname) then begin
    // try to copy distribution file
    dfn :=slash(appdir)+ slash('data')+ slash('deltat')+'finals.data';
    if FileExists(dfn) then
        CopyFile( dfn , fname);
  end;
  if not FileExists(fname) then
  begin
    numiers := 0;
    setlength(iers, 0, 0);
    exit;
  end;
  Filemode := 0;
  assignfile(f, fname);
  try
    reset(f);
    n := 0;
    // first loop to get the size
    repeat
      readln(f, buf);
      if trim(copy(buf,19,4))='' then break;
      Inc(n);
    until EOF(f);
    setlength(iers, n, 4);
    // read the file now
    reset(f);
    try
    for i := 0 to n - 1 do
    begin
      readln(f, buf);
      iers[i,0]:=round(2400000+strtofloat(copy(buf,8,8))); // jd
      iers[i,1]:=strtofloat(trim(copy(buf,59,10))); // ut1-utc
      iers[i,2]:=strtofloat(trim(copy(buf,19,9)));  // pole x
      iers[i,3]:=strtofloat(trim(copy(buf,38,9)));  // pole y
    end;
    numiers:=n;
    except
      numiers := 0;
      setlength(iers, 0, 0);
    end;
  finally
    closefile(f);
  end;
end;

procedure Tf_main.LoadVartype;
var i: integer;
    nexttype: boolean;
    buf: string;
    f: TextFile;
begin
try
  SetLength(vartype,1000);
  AssignFile(f,slash(Appdir) + slash('data') + slash('sample') + 'vsxtype.txt');   // https://www.aavso.org/vsx/index.php?view=about.vartypes
  Reset(f);
  i:=0;
  nexttype:=true;
  repeat
    readln(f,buf);
    if trim(buf)='' then begin // next type
      inc(i);
      nexttype:=true;
      Continue;
    end;
    if nexttype then begin
      vartype[i].code:=trim(buf);
      vartype[i].desc:='';
      nexttype:=false;
    end
    else begin
      vartype[i].desc:=trim(vartype[i].desc+crlf+trim(buf));
    end;
  until eof(f);
  CloseFile(f);
  SetLength(vartype,i+1);
except
  SetLength(vartype,0);
end;
end;

procedure Tf_main.LoadVarsubtype;
var i: integer;
    nexttype: boolean;
    buf: string;
    f: TextFile;
begin
try
  SetLength(varsubtype,1000);
  AssignFile(f,slash(Appdir) + slash('data') + slash('sample') + 'vsxsubtype.txt');   // https://www.aavso.org/vsx/index.php?view=about.vartypes
  Reset(f);
  i:=0;
  nexttype:=true;
  repeat
    readln(f,buf);
    if trim(buf)='' then begin // next type
      inc(i);
      nexttype:=true;
      Continue;
    end;
    if nexttype then begin
      varsubtype[i].code:=trim(buf);
      varsubtype[i].desc:='';
      nexttype:=false;
    end
    else begin
      varsubtype[i].desc:=trim(varsubtype[i].desc+crlf+trim(buf));
    end;
  until eof(f);
  CloseFile(f);
  SetLength(varsubtype,i+1);
except
  SetLength(varsubtype,0);
end;
end;

///////////////////////////////////////////////////////////////////////////////////

end.
