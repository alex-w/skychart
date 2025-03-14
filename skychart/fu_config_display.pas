unit fu_config_display;

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
  u_help, u_translation, u_constant, u_util, pu_fov, UScaleDPI, cu_radec,
  LCLIntf, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Buttons, StdCtrls, ExtCtrls, ComCtrls, LResources,
  EditBtn, LCLType, enhedits, Spin, LazHelpHTML_fix;

type

  { Tf_config_display }

  Tf_config_display = class(TFrame)
    ButtonComputeRectangle: TButton;
    Button3: TButton;
    BtnDefaultColor: TButton;
    BtnRedColor: TButton;
    BtnWBColor: TButton;
    BtnBWColor: TButton;
    ButtonComputeCircle: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    cbAltAzMark: TCheckBox;
    CenterDecGridNum: TCheckBox;
    MeridianWideLine: TCheckBox;
    MagNoDecimal: TCheckBox;
    DSLsurface: TCheckBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    Panel12: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label237: TLabel;
    Label252: TLabel;
    Label255: TLabel;
    Label260: TLabel;
    labelcolorAst: TShape;
    labelcolorchartinfo: TShape;
    labelcolorCom: TShape;
    labelcolorConst: TShape;
    labelcolorMisc: TShape;
    labelcolorMult: TShape;
    labelcolorNeb: TShape;
    labelcolorobslist: TShape;
    labelcolorSol: TShape;
    labelcolorStar: TShape;
    labelcolorVar: TShape;
    labelmagAst: TMouseUpDown;
    labelmagCom: TMouseUpDown;
    labelmagMult: TMouseUpDown;
    labelmagNeb: TMouseUpDown;
    labelmagSol: TMouseUpDown;
    labelmagStar: TMouseUpDown;
    labelmagVar: TMouseUpDown;
    labelRotAst: TMouseUpDown;
    labelRotChartInfo: TMouseUpDown;
    labelRotCom: TMouseUpDown;
    labelRotConst: TMouseUpDown;
    labelRotMisc: TMouseUpDown;
    labelRotMult: TMouseUpDown;
    labelRotNeb: TMouseUpDown;
    labelRotobslist: TMouseUpDown;
    labelRotSol: TMouseUpDown;
    labelRotStar: TMouseUpDown;
    labelRotVar: TMouseUpDown;
    labelsizeAst: TMouseUpDown;
    labelsizeChartInfo: TMouseUpDown;
    labelsizeCom: TMouseUpDown;
    labelsizeConst: TMouseUpDown;
    labelsizeMisc: TMouseUpDown;
    labelsizeMult: TMouseUpDown;
    labelsizeNeb: TMouseUpDown;
    labelsizeobslist: TMouseUpDown;
    labelsizeSol: TMouseUpDown;
    labelSizeStar: TMouseUpDown;
    labelsizeVar: TMouseUpDown;
    PageGrid: TTabSheet;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PanelRot: TPanel;
    showlabelAst: TCheckBox;
    ShowLabelChartInfo: TCheckBox;
    showlabelCom: TCheckBox;
    showlabelConst: TCheckBox;
    showlabelMisc: TCheckBox;
    showlabelMult: TCheckBox;
    showlabelNeb: TCheckBox;
    showlabelSol: TCheckBox;
    showlabelStar: TCheckBox;
    showlabelVar: TCheckBox;
    Transparency: TLabel;
    SurfaceBlure: TCheckBox;
    LineWidthConstB: TSpinEdit;
    LineWidthConstL: TSpinEdit;
    LineWidthEcliptic: TSpinEdit;
    LineWidthEqGrid: TSpinEdit;
    LineWidthGalEq: TSpinEdit;
    LineWidthGrid: TSpinEdit;
    ShowEquator: TCheckBox;
    DistLabel: TCheckBox;
    CheckBox2: TCheckBox;
    antialias: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    linemodemilkyway: TCheckBox;
    ImageList1: TImageList;
    OptLabels: TCheckBox;
    Label10: TLabel;
    GroupNightColor: TRadioGroup;
    ShowLineShape: TShape;
    ShowLines: TCheckBox;
    OnlyMeridian: TCheckBox;
    LabelLine: TCheckBox;
    FillPanel1: TPanel;
    FillPanel2: TPanel;
    ShowTitle: TCheckBox;
    FileNameEdit1: TFileNameEdit;
    Label9: TLabel;
    lstDSOCScheme: TComboBox;
    DrawAllStarLabel: TCheckBox;
    DrawPmBox: TCheckBox;
    DrawPMy: TLongEdit;
    GridStyle: TComboBox;
    EclipticStyle: TComboBox;
    EqGridStyle: TComboBox;
    GalEqStyle: TComboBox;
    CFStyle: TComboBox;
    CBStyle: TComboBox;
    ConstlFile: TFileNameEdit;
    ConstbFile: TFileNameEdit;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label258: TLabel;
    Label259: TLabel;
    Label5: TLabel;
    Label68: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    red_moveBox: TCheckBox;
    Shape8: TShape;
    StarButton5: TButton;
    StarButton6: TButton;
    StarButton7: TButton;
    StarDynBar1: TTrackBar;
    StarSizeBar1: TTrackBar;
    ThemeList: TComboBox;
    MainPanel: TPanel;
    PageDisplay: TTabSheet;
    PageColour: TTabSheet;
    PageDSOColour: TTabSheet;
    PageSkyColour: TTabSheet;
    PageLines: TTabSheet;
    PageLabel: TTabSheet;
    PageFont: TTabSheet;
    PageCircle: TTabSheet;
    PageRectangle: TTabSheet;
    stardisplay: TRadioGroup;
    nebuladisplay: TRadioGroup;
    Label256: TLabel;
    Label262: TLabel;
    Label263: TLabel;
    Label257: TLabel;
    StarSizeBar: TTrackBar;
    StarContrastBar: TTrackBar;
    SaturationBar: TTrackBar;
    SizeContrastBar: TTrackBar;
    StarButton1: TButton;
    StarButton2: TButton;
    StarButton3: TButton;
    StarButton4: TButton;
    Bevel10: TBevel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Label235: TLabel;
    gridfont: TEdit;
    labelfont: TEdit;
    legendfont: TEdit;
    statusfont: TEdit;
    listfont: TEdit;
    prtfont: TEdit;
    Button1: TButton;
    symbfont: TEdit;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label186: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Label189: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    Label195: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    Label199: TLabel;
    Label196: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label234: TLabel;
    Label269: TLabel;
    bg1: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    bg3: TPanel;
    Shape15: TShape;
    Shape16: TShape;
    Shape14: TShape;
    bg4: TPanel;
    Shape26: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Label202: TLabel;
    Label205: TLabel;
    Label208: TLabel;
    skycolorbox: TRadioGroup;
    Panel6: TPanel;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    EqGrid: TCheckBox;
    CGrid: TCheckBox;
    ecliptic: TCheckBox;
    galactic: TCheckBox;
    GridNum: TCheckBox;
    MagLabel: TRadioGroup;
    constlabel: TRadioGroup;
    Label307: TLabel;
    Circlegrid: TStringGrid;
    CenterMark1: TCheckBox;
    Label308: TLabel;
    RectangleGrid: TStringGrid;
    CenterMark2: TCheckBox;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    Showlabelall: TCheckBox;
    ShowChartInfo: TCheckBox;
    lblDSOCScheme: TLabel;
    gbDSOCOverrides: TGroupBox;
    lblAst: TLabel;
    shpAst: TShape;
    lblSN: TLabel;
    shpSN: TShape;
    lblOCl: TLabel;
    lblGCl: TLabel;
    lblPNe: TLabel;
    lblDN: TLabel;
    lblEN: TLabel;
    lblRN: TLabel;
    shpRN: TShape;
    shpEN: TShape;
    shpDN: TShape;
    shpPNe: TShape;
    shpGCl: TShape;
    shpOCl: TShape;
    lblGxy: TLabel;
    lblGxyCl: TLabel;
    lblQ: TLabel;
    lblGL: TLabel;
    lblNE: TLabel;
    shpNE: TShape;
    shpGL: TShape;
    shpQ: TShape;
    shpGxyCl: TShape;
    shpGxy: TShape;
    lblDSOType: TLabel;
    lblDSOColour: TLabel;
    lblDSOColourFill: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    chkFillAst: TCheckBox;
    chkFillOCl: TCheckBox;
    chkFillGCl: TCheckBox;
    chkFillPNe: TCheckBox;
    chkFillDN: TCheckBox;
    chkFillEN: TCheckBox;
    chkFillRN: TCheckBox;
    chkFillSN: TCheckBox;
    chkFillGxy: TCheckBox;
    chkFillGxyCl: TCheckBox;
    chkFillQ: TCheckBox;
    chkFillGL: TCheckBox;
    chkFillNE: TCheckBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NebBrightBar: TTrackBar;
    NebGrayBar: TTrackBar;
    DefNebColorButton: TButton;
    NebColorPanel: TPanel;
    Shape29: TShape;
    Shape30: TShape;
    GroupBox1: TGroupBox;
    Constl: TCheckBox;
    Label132: TLabel;
    GroupBox3: TGroupBox;
    Constb: TCheckBox;
    Label72: TLabel;
    GroupBox4: TGroupBox;
    milkyway: TCheckBox;
    fillmilkyway: TCheckBox;
    Shape25: TShape;
    Shape13: TShape;
    Shape17: TShape;
    Shape12: TShape;
    Shape11: TShape;
    PageControl1: TPageControl;
    SurfaceAlpha: TTrackBar;
    procedure antialiasClick(Sender: TObject);
    procedure BtnBWColorClick(Sender: TObject);
    procedure BtnDefaultColorClick(Sender: TObject);
    procedure BtnRedColorClick(Sender: TObject);
    procedure BtnWBColorClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ButtonComputeCircleClick(Sender: TObject);
    procedure ButtonComputeRectangleClick(Sender: TObject);
    procedure cbAltAzMarkClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CenterDecGridNumClick(Sender: TObject);
    procedure CFStyleChange(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CirclegridColRowInserted(Sender: TObject; IsColumn: boolean;
      sIndex, tIndex: integer);
    procedure CirclegridColRowMoved(Sender: TObject; IsColumn: boolean;
      sIndex, tIndex: integer);
    procedure CirclegridDblClick(Sender: TObject);
    procedure CirclegridDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure CirclegridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure CirclegridSelectCell(Sender: TObject; aCol, aRow: integer;
      var CanSelect: boolean);
    procedure DistLabelClick(Sender: TObject);
    procedure DSLsurfaceClick(Sender: TObject);
    procedure LineStyleMeasureItem(Control: TWinControl; Index: integer;
      var AHeight: integer);
    procedure labelmagChange(Sender: TObject);
    procedure LabelsizeChange(Sender: TObject);
    procedure LabelRotChange(Sender: TObject);
    procedure linemodemilkywayClick(Sender: TObject);
    procedure LineWidthChange(Sender: TObject);
    procedure MagNoDecimalClick(Sender: TObject);
    procedure MarkNumberClick(Sender: TObject);
    procedure ConstbFileAcceptFileName(Sender: TObject; var Value: string);
    procedure ConstlFileAcceptFileName(Sender: TObject; var Value: string);
    procedure DrawAllStarLabelClick(Sender: TObject);
    procedure DrawPMyChange(Sender: TObject);
    procedure DrawPmBoxClick(Sender: TObject);
    procedure EclipticStyleChange(Sender: TObject);
    procedure EqGridStyleChange(Sender: TObject);
    procedure FileNameEdit1AcceptFileName(Sender: TObject; var Value: string);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure GalEqStyleChange(Sender: TObject);
    procedure GridStyleChange(Sender: TObject);
    procedure LabelLineClick(Sender: TObject);
    procedure lstDSOCSchemeChange(Sender: TObject);
    procedure MeridianWideLineClick(Sender: TObject);
    procedure OnlyMeridianClick(Sender: TObject);
    procedure OptLabelsClick(Sender: TObject);
    procedure PageDSOColourShow(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure GroupNightColorClick(Sender: TObject);
    procedure RectangleGridColRowInserted(Sender: TObject; IsColumn: boolean;
      sIndex, tIndex: integer);
    procedure RectangleGridColRowMoved(Sender: TObject; IsColumn: boolean;
      sIndex, tIndex: integer);
    procedure RectangleGridDblClick(Sender: TObject);
    procedure RectangleGridDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure RectangleGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure RectangleGridSelectCell(Sender: TObject; aCol, aRow: integer;
      var CanSelect: boolean);
    procedure ShowEquatorClick(Sender: TObject);
    procedure ShowLinesClick(Sender: TObject);
    procedure ShowLineShapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShowTitleClick(Sender: TObject);
    procedure StarButton5Click(Sender: TObject);
    procedure StarButton6Click(Sender: TObject);
    procedure StarButton7Click(Sender: TObject);
    procedure StarDynBar1Change(Sender: TObject);
    procedure StarSizeBar1Change(Sender: TObject);
    procedure StyleDrawItem(Control: TWinControl; Index: integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure SurfaceAlphaChange(Sender: TObject);
    procedure SurfaceBlureClick(Sender: TObject);
    procedure ThemeListChange(Sender: TObject);
    procedure nebuladisplayClick(Sender: TObject);
    procedure red_moveBoxClick(Sender: TObject);
    procedure stardisplayClick(Sender: TObject);
    procedure StarSizeBarChange(Sender: TObject);
    procedure SizeContrastBarChange(Sender: TObject);
    procedure StarContrastBarChange(Sender: TObject);
    procedure SaturationBarChange(Sender: TObject);
    procedure StarButton1Click(Sender: TObject);
    procedure StarButton2Click(Sender: TObject);
    procedure StarButton3Click(Sender: TObject);
    procedure StarButton4Click(Sender: TObject);
    procedure SelectFontClick(Sender: TObject);
    procedure DefaultFontClick(Sender: TObject);
    procedure ShapeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure skycolorboxClick(Sender: TObject);
    procedure ShapeSkyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Button3Click(Sender: TObject);
    procedure CGridClick(Sender: TObject);
    procedure EqGridClick(Sender: TObject);
    procedure GridNumClick(Sender: TObject);
    procedure eclipticClick(Sender: TObject);
    procedure galacticClick(Sender: TObject);
    procedure ConstlClick(Sender: TObject);
    procedure ConstlFileChange(Sender: TObject);
    procedure ConstbClick(Sender: TObject);
    procedure ConstbFileChange(Sender: TObject);
    procedure milkywayClick(Sender: TObject);
    procedure fillmilkywayClick(Sender: TObject);
    procedure showlabelClick(Sender: TObject);
    procedure labelcolorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure MagLabelClick(Sender: TObject);
    procedure constlabelClick(Sender: TObject);
    procedure CirclegridSetEditText(Sender: TObject; ACol, ARow: integer;
      const Value: string);
    procedure CenterMark1Click(Sender: TObject);
    procedure RectangleGridSetEditText(Sender: TObject; ACol, ARow: integer;
      const Value: string);
    procedure NebGrayBarChange(Sender: TObject);
    procedure NebBrightBarChange(Sender: TObject);
    procedure DefNebColorButtonClick(Sender: TObject);
    procedure ShowlabelallClick(Sender: TObject);
    procedure ShowChartInfoClick(Sender: TObject);

    //  deep-sky objects colour

    procedure ShapeDSOMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure chkFillAstClick(Sender: TObject);
    procedure chkFillOClClick(Sender: TObject);
    procedure chkFillPNeClick(Sender: TObject);
    procedure chkFillGClClick(Sender: TObject);
    procedure chkFillDNClick(Sender: TObject);
    procedure chkFillENClick(Sender: TObject);
    procedure chkFillRNClick(Sender: TObject);
    procedure chkFillSNClick(Sender: TObject);
    procedure chkFillGxyClick(Sender: TObject);
    procedure chkFillGxyClClick(Sender: TObject);
    procedure chkFillQClick(Sender: TObject);
    procedure chkFillGLClick(Sender: TObject);
    procedure chkFillNEClick(Sender: TObject);
    procedure FillDSOMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);

    //  End of deep-sky objects colour
  private
    { Private declarations }
    FApplyConfig: TNotifyEvent;
    LockChange: boolean;
    CCol, CRow, RCol, RRow: integer;
    f_fov: Tf_fov;
    procedure ShowDisplay;
    procedure ShowFonts;
    procedure ShowColor;
    procedure ShowSkyColor;
    procedure ShowDSOColor;
    procedure ShowNebColor;
    procedure ShowLine;
    procedure ShowLabelColor;
    procedure ShowLabel;
    procedure ShowCircle;
    procedure ShowRectangle;
    procedure SetFonts(ctrl: Tedit; num: integer);
    procedure UpdNebColor;
  public
    { Public declarations }
    mycsc: Tconf_skychart;
    myccat: Tconf_catalog;
    mycshr: Tconf_shared;
    mycplot: Tconf_plot;
    mycmain: Tconf_main;
    csc: Tconf_skychart;
    ccat: Tconf_catalog;
    cshr: Tconf_shared;
    cplot: Tconf_plot;
    cmain: Tconf_main;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init; // old FormShow
    procedure Lock; // old FormClose
    procedure SetLang;
    property onApplyConfig: TNotifyEvent read FApplyConfig write FApplyConfig;
  end;

implementation

{$R *.lfm}

procedure Tf_config_display.SetLang;
begin
  Caption := rsDisplay;
  PageDisplay.Caption := rsDisplay;
  stardisplay.Caption := rsStarDisplay;
  stardisplay.Items[0] := rsLineMode;
  stardisplay.Items[1] := rsPhotographic2;
  stardisplay.Items[2] := rsParametric;
  nebuladisplay.Caption := rsNebulaDispla;
  nebuladisplay.Items[0] := rsLineMode;
  nebuladisplay.Items[1] := rsGraphic;
  Label256.Caption := rsFaintStarsSi;
  Label262.Caption := rsContrast;
  Label263.Caption := rsColorSaturat;
  Label257.Caption := rsIncrementFor;
  StarButton1.Caption := rsDefault;
  StarButton2.Caption := rsNakedEye;
  StarButton3.Caption := rsHighColor;
  StarButton4.Caption := rsBlackWhite;
  StarButton5.Caption := rsDefault;
  StarButton6.Caption := rsSmallStars;
  StarButton7.Caption := rsBigStars;
  Label258.Caption := rsBrightStarsS;
  Label259.Caption := rsContrast;
  label9.Caption := rsStarsBitmapF;
  Button7.Caption := rsDefault;

  PageColour.Caption := rsColor;
  Label189.Caption := rsStarColourBV;
  Label193.Caption := rsCoordGrid;
  Label194.Caption := rsEqGrid;
  Label195.Caption := rsOrbit;
  Label197.Caption := rsConstellatio;
  Label198.Caption := rsBoundary;
  Label199.Caption := rsEyepiece;
  Label196.Caption := rsMiscLines;
  Label11.Caption := rsHorizon;
  Label6.Caption := rsAsteroid;
  Label234.Caption := rsComet;
  Label269.Caption := rsMilkyWay;
  GroupBox7.Caption := rsStandardColo;
  BtnDefaultColor.Caption := rsDefault;
  Button8.Caption := rsPastel;
  BtnRedColor.Caption := rsRed;
  BtnBWColor.Caption := rsWhiteOnBlack;
  BtnWBColor.Caption := rsBlackOnWhite;
  GroupBox6.Caption := rsTheme;
  GroupNightColor.Caption := rsNightVisionC;

  PageDSOColour.Caption := rsDeepSkyColou;
  lblDSOCScheme.Caption := rsUseAPresetCo;
  gbDSOCOverrides.Caption := rsChooseColour;
  lblAst.Caption := rsAsterism;
  lblSN.Caption := rsSupernovaRem;
  lblOCl.Caption := rsOpenCluster;
  lblGCl.Caption := rsGlobularClus;
  lblPNe.Caption := rsPlanetaryNeb;
  lblDN.Caption := rsDarkNebula;
  lblEN.Caption := rsEmissionNebu;
  lblRN.Caption := rsReflectionNe;
  lblGxy.Caption := rsGalaxy;
  lblGxyCl.Caption := rsGalaxyCluste;
  lblQ.Caption := rsQuasar;
  lblGL.Caption := rsGravitationa;
  lblNE.Caption := rsNonExistentU;
  lblDSOType.Caption := rsObjectType;
  lblDSOColour.Caption := rsColor;
  lblDSOColourFill.Caption := rsFill;
  Label7.Caption := rsObjectType;
  Label12.Caption := rsColor;
  Label13.Caption := rsFill;
  GroupBox2.Caption := rsAdjustColour;
  Label1.Caption := rsLowSurfaceBr;
  Label2.Caption := rsHighSurfaceB;
  Label3.Caption := rsFainter;
  Label4.Caption := rsBrighter;
  DefNebColorButton.Caption := rsDefault;
  lstDSOCScheme.items[0] := 'CdC v2 ' + rsDefault;
  lstDSOCScheme.items[1] := 'CdC v3 ' + rsDefault;
  lstDSOCScheme.items[2] := rsPrintedChart;
  lstDSOCScheme.items[3] := rsGreen;

  PageSkyColour.Caption := rsSkyColour;
  skycolorbox.Caption := rsSkyColour;
  skycolorbox.items[0] := rsFixedBlack;
  skycolorbox.items[1] := rsAutomatic;
  Label205.Caption := rsTwilight;
  Label202.Caption := rsDayTime;
  Label208.Caption := rsAstronomical2;
  Label5.Caption := rsFixedSkyColo;
  Button3.Caption := rsDefaultColor;

  PageGrid.Caption := rsGrids;
  PageLines.Caption := rsLines;
  GroupBox10.Caption:=rsCoordinatesG;
  GroupBox11.Caption:=rsNebulaeOutli;
  GroupBox12.Caption:=rsEquator;
  EqGrid.Caption := rsAddEquatoria;
  CGrid.Caption := rsShowCoordina;
  OnlyMeridian.Caption := rsShowOnlyMeri;
  CheckBox8.Caption := rsAlwaysAddMer;
  ShowLines.Caption := rsShowDSOLines;
  Label10.Caption := rsEditDSOLines;
  DSLsurface.Caption := rsFillNebulae;
  SurfaceBlure.Caption:=rsBlurred;
  Transparency.Caption:=rsTransparency;
  ecliptic.Caption := rsShowEcliptic;
  galactic.Caption := rsShowGalactic;
  ShowEquator.Caption := rsShowCelestia;
  GridNum.Caption := rsShowGridLabe;
  CenterDecGridNum.Caption := rsDeclinationL;
  GroupBox1.Caption := rsConstellatio2;
  Label132.Caption := rsConstellatio3;
  Constl.Caption := rsShowConstell3;
  CFStyle.items[0] := rsLine1;
  CFStyle.items[1] := rsDash1;
  CFStyle.items[2] := rsDot1;
  CFStyle.items[3] := rsDashDot1;
  CFStyle.items[4] := rsDashDotDot1;
  GroupBox3.Caption := rsConstellatio4;
  Label72.Caption := rsConstellatio5;
  Constb.Caption := rsShowConstell4;
  CBStyle.items[0] := rsLine1;
  CBStyle.items[1] := rsDash1;
  CBStyle.items[2] := rsDot1;
  CBStyle.items[3] := rsDashDot1;
  CBStyle.items[4] := rsDashDotDot1;
  GroupBox4.Caption := rsMilkyWay;
  milkyway.Caption := rsShowMilkyWay;
  fillmilkyway.Caption := rsFillMilkyWay;
  linemodemilkyway.Caption := rsLineMode;
  GroupBox8.Caption := rsProperMotion3;
  GridStyle.items[0] := rsLine1;
  GridStyle.items[1] := rsDash1;
  GridStyle.items[2] := rsDot1;
  GridStyle.items[3] := rsDashDot1;
  GridStyle.items[4] := rsDashDotDot1;
  EclipticStyle.items[0] := rsLine1;
  EclipticStyle.items[1] := rsDash1;
  EclipticStyle.items[2] := rsDot1;
  EclipticStyle.items[3] := rsDashDot1;
  EclipticStyle.items[4] := rsDashDotDot1;
  EqGridStyle.items[0] := rsLine1;
  EqGridStyle.items[1] := rsDash1;
  EqGridStyle.items[2] := rsDot1;
  EqGridStyle.items[3] := rsDashDot1;
  EqGridStyle.items[4] := rsDashDotDot1;
  GalEqStyle.items[0] := rsLine1;
  GalEqStyle.items[1] := rsDash1;
  GalEqStyle.items[2] := rsDot1;
  GalEqStyle.items[3] := rsDashDot1;
  GalEqStyle.items[4] := rsDashDotDot1;

  PageLabel.Caption := rsLabels;
  DrawAllStarLabel.Caption := rsDisplayLabel;
  LabelLine.Caption := rsShowLineFrom;
  MagNoDecimal.Caption:=rsNoDecimalSep;
  OptLabels.Caption := rsAutomaticall2;
  MagLabel.Caption := rsStarLabel;
  MagLabel.Items[0] := rsName;
  MagLabel.Items[1] := rsCommonName;
  MagLabel.Items[2] := rsMagnitude;
  DistLabel.Caption := rsDistance;
  constlabel.Caption := rsConstellatio6;
  constlabel.Items[0] := rsOfficialName;
  constlabel.Items[1] := rsAbbreviation;
  constlabel.Items[2] := rsLocalizedNam;
  Showlabelall.Caption := rsDisplayTheLa;
  ShowChartInfo.Caption := rsDisplayTheCh;
  ShowTitle.Caption := rsShowPosition;
  label14.Caption := rsLabelObject;
  Label237.Caption := rsMagnitudeDif;
  Label252.Caption := rsColor;
  Label255.Caption := rsSize;
  showlabelStar.Caption := rsStars;
  showlabelVar.Caption := rsVariableStar;
  showlabelMult.Caption := rsMultipleStar;
  showlabelNeb.Caption := rsNebulae;
  showlabelSol.Caption := rsPlanet;
  showlabelAst.Caption := rsAsteroid;
  showlabelCom.Caption := rsComet;
  showlabelConst.Caption := rsConstellatio7;
  showlabelMisc.Caption := rsOtherLabel;
  ShowLabelChartInfo.Caption := rsChartInforma;
  Label15.Caption := rsObservingLis2;
  CheckBox5.Caption := rsChartLegend;
  CheckBox9.Caption := rsOrientToTheP;
  Button9.Caption := rsDefault;

  PageFont.Caption := rsFonts;
  Label121.Caption := rsCoordinatesG;
  Label122.Caption := rsObject;
  Label123.Caption := rsLabels;
  Label124.Caption := rsLegend;
  Label125.Caption := rsInformationD;
  Label126.Caption := rsObjectList;
  Label127.Caption := rsPrinterLegen;
  Label128.Caption := rsFonts;
  Label129.Caption := rsModify;
  Label235.Caption := rsGreekSymbol;
  Button1.Caption := rsDefault;

  PageCircle.Caption := rsFinderCircle;
  Label307.Caption := rsFinderCircle;
  ButtonComputeCircle.Caption := rsCompute;
  CenterMark1.Caption := rsMarkTheChart;
  CheckBox7.Caption := rsChartCenterC;
  CheckBox1.Caption := rsShowLabels;
  CheckBox3.Caption := rsShowMarkInde;

  PageRectangle.Caption := rsFinderRectan;
  Label308.Caption := rsFinderRectan;
  ButtonComputeRectangle.Caption := rsCompute;
  CenterMark2.Caption := rsMarkTheChart;
  CheckBox2.Caption := rsShowLabels;
  CheckBox4.Caption := rsShowMarkInde;
  cbAltAzMark.Caption := rsOrientationF;
  label16.Caption := format(rsDoNotUseRow1,['10']);
  label8.Caption := rsDrawALineTha;
  Label68.Caption := rsYears;
  red_moveBox.Caption := rsReduceDetail;
  antialias.Caption := rsAntiAliasDra;
  CheckBox6.Caption := rsShowOnlyText;
  f_fov.setlang;
  SetHelp(self, hlpCfgDispl);
end;

constructor Tf_config_display.Create(AOwner: TComponent);
begin
  mycsc := Tconf_skychart.Create;
  myccat := Tconf_catalog.Create;
  mycshr := Tconf_shared.Create;
  mycplot := Tconf_plot.Create;
  mycmain := Tconf_main.Create;
  csc := mycsc;
  ccat := myccat;
  cshr := mycshr;
  cplot := mycplot;
  cmain := mycmain;
  inherited Create(AOwner);
  f_fov := Tf_fov.Create(self);
  LockChange := True;
  SetLang;
{$ifndef mswindows}
  label235.Visible := False;      // symbol same as label with utf-8
  symbfont.Visible := False;
  speedbutton7.Visible := False;
{$endif}
{$ifdef lclcocoa}
  { TODO : check cocoa dark theme color}
  if DarkTheme then begin
    Circlegrid.FixedColor := clBackground;
    RectangleGrid.FixedColor := clBackground;
  end;
{$endif}
end;

destructor Tf_config_display.Destroy;
begin
  f_fov.Free;
  mycsc.Free;
  myccat.Free;
  mycshr.Free;
  mycplot.Free;
  mycmain.Free;
  inherited Destroy;
end;


procedure Tf_config_display.Init;
begin
  LockChange := True;
  ShowDisplay;
  ShowFonts;
  ShowColor;
  ShowSkyColor;
  // changes for DSO Colors
  ShowDSOColor;
  ShowNebColor;
  ShowLine;
  Showlabel;
  ShowCircle;
  ShowRectangle;
  FileNameEdit1.InitialDir := slash(appdir) + slash('data') + 'stars';
  ;
  LockChange := False;
end;

procedure Tf_config_display.LineWidthChange(Sender: TObject);
begin
  if sender is TSpinEdit then with Sender as TSpinEdit do begin
    case Tag of
      1: csc.LineWidthGrid:=Value;
      2: csc.LineWidthEqGrid:=Value;
      3: csc.LineWidthConstL:=Value;
      4: csc.LineWidthConstB:=Value;
      5: csc.LineWidthEcliptic:=Value;
      6: csc.LineWidthGalEq:=Value;
    end;
  end;
end;

procedure Tf_config_display.GridStyleChange(Sender: TObject);
var
  i: integer;
begin
  i := GridStyle.ItemIndex;
  if (i >= Ord(Low(TPenStyle))) and (i <= Ord(High(TPenStyle))) then
    csc.StyleGrid := TPenStyle(i);
end;

procedure Tf_config_display.LabelLineClick(Sender: TObject);
begin
  csc.MovedLabelLine := LabelLine.Checked;
end;

procedure Tf_config_display.MagNoDecimalClick(Sender: TObject);
begin
  csc.MagNoDecimal:=MagNoDecimal.Checked;
end;

procedure Tf_config_display.StarButton5Click(Sender: TObject);
begin
  StarSizeBar1.Position := 13;
  StarDynBar1.Position := 75;
  cplot.stardyn := StarDynBar1.Position;
  cplot.starsize := StarSizeBar1.Position;
end;

procedure Tf_config_display.StarButton6Click(Sender: TObject);
begin
  StarSizeBar1.Position := 5;
  StarDynBar1.Position := 50;
  cplot.stardyn := StarDynBar1.Position;
  cplot.starsize := StarSizeBar1.Position;
end;

procedure Tf_config_display.StarButton7Click(Sender: TObject);
begin
  StarSizeBar1.Position := 40;
  StarDynBar1.Position := 78;
  cplot.stardyn := StarDynBar1.Position;
  cplot.starsize := StarSizeBar1.Position;
end;

procedure Tf_config_display.EqGridStyleChange(Sender: TObject);
var
  i: integer;
begin
  i := EqGridStyle.ItemIndex;
  if (i >= Ord(Low(TPenStyle))) and (i <= Ord(High(TPenStyle))) then
    csc.StyleEqGrid := TPenStyle(i);
end;

procedure Tf_config_display.FileNameEdit1AcceptFileName(Sender: TObject;
  var Value: string);
begin
  cmain.starshape_file := Value;
end;

procedure Tf_config_display.FileNameEdit1Change(Sender: TObject);
begin
  cmain.starshape_file := FileNameEdit1.FileName;
end;

procedure Tf_config_display.CFStyleChange(Sender: TObject);
var
  i: integer;
begin
  i := CFStyle.ItemIndex;
  if (i >= Ord(Low(TPenStyle))) and (i <= Ord(High(TPenStyle))) then
    csc.StyleConstL := TPenStyle(i);
end;

procedure Tf_config_display.CheckBox1Click(Sender: TObject);
begin
  csc.CircleLabel := CheckBox1.Checked;
end;

procedure Tf_config_display.CheckBox2Click(Sender: TObject);
begin
  csc.RectangleLabel := CheckBox2.Checked;
end;

procedure Tf_config_display.CheckBox5Click(Sender: TObject);
begin
  csc.ShowLegend := CheckBox5.Checked;
end;

procedure Tf_config_display.CheckBox6Click(Sender: TObject);
begin
  cmain.TextOnlyDetail := CheckBox6.Checked;
end;

procedure Tf_config_display.CirclegridColRowInserted(Sender: TObject;
  IsColumn: boolean; sIndex, tIndex: integer);
var
  i: integer;
begin
  if LockChange then
    exit;
  csc.ncircle := circlegrid.RowCount - 1;
  SetLength(csc.circle, csc.ncircle + 1);
  SetLength(csc.circleok, csc.ncircle + 1);
  SetLength(csc.circlelbl, csc.ncircle + 1);
  i := csc.ncircle;
  csc.circleok[i] := False;
  csc.circle[i, 1] := 0;
  csc.circle[i, 2] := 0;
  csc.circle[i, 3] := 0;
  csc.circlelbl[i] := '';
  circlegrid.Cells[1, i] := '0';
  circlegrid.Cells[2, i] := formatfloat(f2, csc.circle[i, 1]);
  circlegrid.Cells[3, i] := formatfloat(f2, csc.circle[i, 2]);
  circlegrid.Cells[4, i] := formatfloat(f2, csc.circle[i, 3]);
  circlegrid.Cells[5, i] := csc.circlelbl[i];

end;

procedure Tf_config_display.CirclegridColRowMoved(Sender: TObject;
  IsColumn: boolean; sIndex, tIndex: integer);
var
  i, n: integer;
  x: double;
begin
  if LockChange then
    exit;
  for i := 1 to circlegrid.RowCount - 1 do
  begin
    csc.circleok[i] := Circlegrid.Cells[1, i] = '1';
    val(circlegrid.Cells[2, i], x, n);
    if n = 0 then
      csc.circle[i, 1] := x;
    val(circlegrid.Cells[3, i], x, n);
    if n = 0 then
      csc.circle[i, 2] := x;
    val(circlegrid.Cells[4, i], x, n);
    if n = 0 then
      csc.circle[i, 3] := x;
    csc.circlelbl[i] := circlegrid.Cells[5, i];
  end;
end;

procedure Tf_config_display.CirclegridDblClick(Sender: TObject);
begin
  ButtonComputeCircleClick(Sender);
end;

procedure Tf_config_display.ButtonComputeCircleClick(Sender: TObject);
begin
  if (CRow > 0) then
  begin
    f_fov.PageControl1.ActivePageIndex := 0;
    f_fov.Edit9.Text := Circlegrid.Cells[2, CRow];
    FormPos(f_fov, mouse.cursorpos.x, mouse.cursorpos.y);
    f_fov.ShowModal;
    if f_fov.ModalResult = mrOk then
    begin
      Circlegrid.Cells[2, CRow] := f_fov.Edit9.Text;
      csc.circle[CRow, 1] := StrToFloatDef(Circlegrid.Cells[2, CRow], csc.circle[CRow, 1]);
      cshr.ffove_tfl := f_fov.Edit6.Text;
      cshr.ffove_efl := f_fov.Edit7.Text;
      cshr.ffove_efv := f_fov.Edit8.Text;
    end;
  end;
end;

procedure Tf_config_display.CirclegridDrawCell(Sender: TObject;
  aCol, aRow: integer; aRect: TRect; aState: TGridDrawState);
var i: integer;
begin
  with Sender as TStringGrid do
  begin
    if (Acol = 1) and (Arow > 0) then
    begin
      i := (RowHeights[aRow]-ImageList1.Height) div 2;
      Canvas.Brush.style := bssolid;
      if (cells[acol, arow] = '1') then
      begin
        Canvas.Brush.Color := clWindow;
        Canvas.FillRect(aRect);
        ImageList1.Draw(Canvas, aRect.left + 2, aRect.top + i, 3);
      end
      else
      begin
        Canvas.Brush.Color := clWindow;
        Canvas.FillRect(aRect);
        ImageList1.Draw(Canvas, aRect.left + 2, aRect.top + i, 2);
      end;
    end;
  end;
end;

procedure Tf_config_display.CirclegridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  col, row: integer;
begin
  Circlegrid.MouseToCell(X, Y, Col, Row);
  if row = 0 then
    exit;
  case col of
    1:
    begin
      if Circlegrid.Cells[col, row] = '1' then
        Circlegrid.Cells[col, row] := '0'
      else
        Circlegrid.Cells[col, row] := '1';
      csc.circleok[row] := Circlegrid.Cells[col, row] = '1';
    end;
  end;
end;

procedure Tf_config_display.CirclegridSelectCell(Sender: TObject;
  aCol, aRow: integer; var CanSelect: boolean);
begin
  if LockChange then
    exit;
  if (aCol <= 1) then
    canselect := False
  else
    canselect := True;
  CCol := aCol;
  CRow := aRow;
end;

procedure Tf_config_display.labelmagChange(Sender: TObject);
var
  x, n: integer;
  txt: string;
begin
  if LockChange then
    exit;
  txt := TEdit(Sender).Text;
  Val(txt, x, n);
  if n = 0 then
    csc.LabelmagDiff[TEdit(Sender).tag] := x;
end;

procedure Tf_config_display.LabelsizeChange(Sender: TObject);
var
  x, n: integer;
  txt: string;
begin
  if LockChange then
    exit;
  txt := TEdit(Sender).Text;
  Val(txt, x, n);
  if n = 0 then
    cplot.LabelSize[TEdit(Sender).tag] := x;
end;

procedure Tf_config_display.LabelRotChange(Sender: TObject);
var
  x, n: integer;
  txt: string;
begin
  if LockChange then
    exit;
  txt := TEdit(Sender).Text;
  Val(txt, x, n);
  if n = 0 then
    csc.LabelOrient[TEdit(Sender).tag] := x;
end;

procedure Tf_config_display.MarkNumberClick(Sender: TObject);
begin
  csc.marknumlabel := TCheckBox(Sender).Checked;
  CheckBox3.Checked := csc.marknumlabel;
  CheckBox4.Checked := csc.marknumlabel;
end;

procedure Tf_config_display.cbAltAzMarkClick(Sender: TObject);
begin
  csc.AltAzMark:=cbAltAzMark.Checked;
end;

procedure Tf_config_display.ConstbFileAcceptFileName(Sender: TObject;
  var Value: string);
begin
  if LockChange then
    exit;
  cmain.ConstBfile := expandfilename(Value);
end;

procedure Tf_config_display.ConstlFileAcceptFileName(Sender: TObject;
  var Value: string);
begin
  if LockChange then
    exit;
  cmain.ConstLfile := expandfilename(Value);
end;

procedure Tf_config_display.DrawAllStarLabelClick(Sender: TObject);
begin
  csc.DrawAllStarLabel := DrawAllStarLabel.Checked;
end;

procedure Tf_config_display.GalEqStyleChange(Sender: TObject);
var
  i: integer;
begin
  i := GalEqStyle.ItemIndex;
  if (i >= Ord(Low(TPenStyle))) and (i <= Ord(High(TPenStyle))) then
    csc.StyleGalEq := TPenStyle(i);
end;

procedure Tf_config_display.EclipticStyleChange(Sender: TObject);
var
  i: integer;
begin
  i := EclipticStyle.ItemIndex;
  if (i >= Ord(Low(TPenStyle))) and (i <= Ord(High(TPenStyle))) then
    csc.StyleEcliptic := TPenStyle(i);
end;

procedure Tf_config_display.CBStyleChange(Sender: TObject);
var
  i: integer;
begin
  i := CBStyle.ItemIndex;
  if (i >= Ord(Low(TPenStyle))) and (i <= Ord(High(TPenStyle))) then
    csc.StyleConstB := TPenStyle(i);
end;

procedure Tf_config_display.StyleDrawItem(Control: TWinControl;
  Index: integer; ARect: TRect; State: TOwnerDrawState);
var
  tw: integer;
begin
  with  TComboBox(Control).Canvas do
  begin
    Pen.Style := TPenStyle(index);
    if odSelected in State then
    begin
      Brush.Color := clHighlight;
      Pen.Color := clHighlightText;
      Font.Color := clHighlightText;
    end
    else
    begin
      Brush.Color := clWindow;
      Pen.Color := clWindowText;
      Font.Color := clWindowText;
    end;
    tw := TextWidth(TComboBox(Control).Items[index]+blank) + 4;
    FillRect(ARect);
    Textout(ARect.Left, ARect.Top, TComboBox(Control).Items[index]+blank);
    moveto(ARect.Left + tw, (ARect.Top + ARect.Bottom) div 2);
    lineto(ARect.Right, (ARect.Top + ARect.Bottom) div 2);
  end;
end;

procedure Tf_config_display.LineStyleMeasureItem(Control: TWinControl;
  Index: integer; var AHeight: integer);
begin
  AHeight := round(16 * UScaleDPI.scale);
end;


procedure Tf_config_display.DrawPmBoxClick(Sender: TObject);
begin
  csc.DrawPMon := DrawPMBox.Checked;
end;

procedure Tf_config_display.DrawPMyChange(Sender: TObject);
begin
  if LockChange then
    exit;
  csc.DrawPMyear := DrawPMy.Value;
end;

procedure Tf_config_display.ThemeListChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.ThemeName := ThemeList.Text;
end;

procedure Tf_config_display.GroupNightColorClick(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.NightColor := GroupNightColor.ItemIndex;
end;

procedure Tf_config_display.Button7Click(Sender: TObject);
begin
  FileNameEdit1.FileName := '';
  cmain.starshape_file := '';
end;

procedure Tf_config_display.Button8Click(Sender: TObject);
begin
  cplot.Color := DfPastelColor;
  cplot.bgcolor := cplot.color[0];
  ShowColor;
end;

procedure Tf_config_display.BtnDefaultColorClick(Sender: TObject);
begin
  cplot.Color := DfColor;
  cplot.bgcolor := cplot.color[0];
  ShowColor;
end;

procedure Tf_config_display.BtnBWColorClick(Sender: TObject);
begin
  cplot.Color := DfBWColor;
  cplot.bgcolor := cplot.color[0];
  ShowColor;
end;

procedure Tf_config_display.BtnRedColorClick(Sender: TObject);
begin
  cplot.Color := DfRedColor;
  cplot.bgcolor := cplot.color[0];
  ShowColor;
end;

procedure Tf_config_display.BtnWBColorClick(Sender: TObject);
begin
  cplot.Color := DfWBColor;
  cplot.bgcolor := cplot.color[0];
  ShowColor;
end;

procedure Tf_config_display.Lock;
begin
  LockChange := True;
end;

procedure Tf_config_display.ShowDisplay;
begin
  stardisplay.ItemIndex := cplot.starplot;
  nebuladisplay.ItemIndex := cplot.nebplot;
  SurfaceBlure.Checked  := csc.SurfaceBlure;
  SurfaceAlpha.Position := csc.SurfaceAlpha;
  StarSizeBar.position := round(cplot.partsize * 10);
  StarContrastBar.position := cplot.contrast;
  SaturationBar.position := cplot.saturation;
  panel7.Visible := (cplot.starplot = 2);
  panel4.Visible := (cplot.starplot = 0);
  panel5.Visible := (cplot.starplot = 1);
  SizeContrastBar.position := round(cplot.magsize * 10);
  red_moveBox.Checked := cplot.red_move;
  antialias.Checked := cplot.AntiAlias;
  CheckBox6.Checked := cmain.TextOnlyDetail;
  StarSizeBar1.position := cplot.starsize;
  StarDynBar1.position := cplot.stardyn;
  FileNameEdit1.FileName := cmain.starshape_file;
end;

procedure Tf_config_display.ShowFonts;
begin
  SetFonts(gridfont, 1);
  SetFonts(labelfont, 2);
  SetFonts(legendfont, 3);
  SetFonts(statusfont, 4);
  SetFonts(listfont, 5);
  SetFonts(prtfont, 6);
  SetFonts(symbfont, 7);
end;

procedure Tf_config_display.ShowColor;
var
  fs: TSearchRec;
  buf: string;
  i: integer;
begin
  bg1.color := cplot.bgColor;
  bg3.color := cplot.bgColor;
  bg4.color := cplot.bgColor;
  shape1.brush.color := cplot.color[1];
  shape2.brush.color := cplot.color[2];
  shape3.brush.color := cplot.color[3];
  shape4.brush.color := cplot.color[4];
  shape5.brush.color := cplot.color[5];
  shape6.brush.color := cplot.color[6];
  shape7.brush.color := cplot.color[7];
  shape11.pen.color := cplot.color[12];
  shape11.brush.color := cplot.bgColor;
  shape12.pen.color := cplot.color[13];
  shape12.brush.color := cplot.bgColor;
  shape13.pen.color := cplot.color[14];
  shape13.brush.color := cplot.bgColor;
  shape14.pen.color := cplot.color[15];
  shape14.brush.color := cplot.bgColor;
  shape15.pen.color := cplot.color[16];
  shape15.brush.color := cplot.bgColor;
  shape16.pen.color := cplot.color[17];
  shape16.brush.color := cplot.bgColor;
  shape17.pen.color := cplot.color[18];
  shape17.brush.color := cplot.bgColor;
  shape25.brush.color := cplot.color[19];
  shape26.brush.color := cplot.color[20];
  shape27.brush.color := cplot.color[21];
  shape28.brush.color := cplot.color[22];
  GroupNightColor.ItemIndex :=  cmain.NightColor;
  ThemeList.Clear;
  i := findfirst(slash(appdir) + slash('data') + slash('Themes') + '*', faDirectory, fs);
  while i = 0 do
  begin
    if ((fs.attr and faDirectory) <> 0) and (fs.Name <> '.') and (fs.Name <> '..') then
    begin
      buf := extractfilename(fs.Name);
      if DirectoryExists(slash(appdir) + slash('data') + slash('Themes') + slash(buf) + 'daylight' ) then
      begin
        ThemeList.items.Add(buf);
      end;
    end;
    i := findnext(fs);
  end;
  findclose(fs);
  for i:=0 to ThemeList.Items.Count-1 do begin
    if cmain.ThemeName = ThemeList.Items[i] then
      ThemeList.ItemIndex := i;
  end;
end;

procedure Tf_config_display.ShowSkyColor;
begin
  if cplot.autoskycolor then
    skycolorbox.ItemIndex := 1
  else
    skycolorbox.ItemIndex := 0;
  panel2.Visible := cplot.autoskycolor;
  shape8.pen.color := cplot.skycolor[0];
  shape8.brush.color := cplot.skycolor[0];
  shape18.pen.color := cplot.skycolor[1];
  shape18.brush.color := cplot.skycolor[1];
  shape19.pen.color := cplot.skycolor[2];
  shape19.brush.color := cplot.skycolor[2];
  shape20.pen.color := cplot.skycolor[3];
  shape20.brush.color := cplot.skycolor[3];
  shape21.pen.color := cplot.skycolor[4];
  shape21.brush.color := cplot.skycolor[4];
  shape22.pen.color := cplot.skycolor[5];
  shape22.brush.color := cplot.skycolor[5];
  shape23.pen.color := cplot.skycolor[6];
  shape23.brush.color := cplot.skycolor[6];
  shape24.pen.color := cplot.skycolor[7];
  shape24.brush.color := cplot.skycolor[7];
end;

procedure Tf_config_display.ShowNebColor;
begin
  NebGrayBar.position := cplot.NebGray;
  NebBrightBar.position := cplot.NebBright;
  UpdNebColor;
end;

// ---dso color -----------------------
procedure Tf_config_display.ShowDSOColor;
var
  vTCBStateChecked, vTCBStateUnChecked: TCheckBoxState;
begin
{
  Now show those objects for the active base catalogs
  Allow user to change the colours of the objects that are active
}

  //  if f_config_catalog1.pa_catalog.t_cdcneb.sacbox.Checked then   shpAst.Visible = False;


  //  Tf_config_catalog.sacbox.Checked then shpAst.Visible = False;
{
    pa_catalog: TPageControl;
    t_catalog: TTabSheet;


ngcbox.Checked:=ccat.NebCatDef[ngc-BaseNeb];
lbnbox.Checked:=ccat.NebCatDef[lbn-BaseNeb];
rc3box.Checked:=ccat.NebCatDef[rc3-BaseNeb];
pgcbox.Checked:=ccat.NebCatDef[pgc-BaseNeb];
oclbox.Checked:=ccat.NebCatDef[ocl-BaseNeb];
gcmbox.Checked:=ccat.NebCatDef[gcm-BaseNeb];
gpnbox.Checked:=ccat.NebCatDef[gpn-BaseNeb];
}


  shpAst.Brush.Color := cplot.Color[23];
  shpOCl.Brush.Color := cplot.Color[24];
  shpGCl.Brush.Color := cplot.Color[25];
  shpPNe.Brush.Color := cplot.Color[26];
  shpDN.Brush.Color := cplot.Color[27];
  shpEN.Brush.Color := cplot.Color[28];
  shpRN.Brush.Color := cplot.Color[29];
  shpSN.Brush.Color := cplot.Color[30];
  shpGxy.Brush.Color := cplot.Color[31];
  shpGxyCl.Brush.Color := cplot.Color[32];
  shpQ.Brush.Color := cplot.Color[33];
  shpGL.Brush.Color := cplot.Color[34];
  shpNE.Brush.Color := cplot.Color[35];

  vTCBStateChecked := cbChecked;
  vTCBStateUnChecked := cbUnchecked;

  if (cplot.DSOColorFillAst = True) then
    chkFillAst.State := vTCBStateChecked
  else
    chkFillAst.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillOCl = True) then
    chkFillOCl.State := vTCBStateChecked
  else
    chkFillOCl.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillGCl = True) then
    chkFillGCl.State := vTCBStateChecked
  else
    chkFillGCl.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillPNe = True) then
    chkFillPNe.State := vTCBStateChecked
  else
    chkFillPNe.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillDN = True) then
    chkFillDN.State := vTCBStateChecked
  else
    chkFillDN.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillEN = True) then
    chkFillEN.State := vTCBStateChecked
  else
    chkFillEN.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillRN = True) then
    chkFillRN.State := vTCBStateChecked
  else
    chkFillRN.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillSN = True) then
    chkFillSN.State := vTCBStateChecked
  else
    chkFillSN.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillGxy = True) then
    chkFillGxy.State := vTCBStateChecked
  else
    chkFillGxy.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillGxyCl = True) then
    chkFillGxyCl.State := vTCBStateChecked
  else
    chkFillGxyCl.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillQ = True) then
    chkFillQ.State := vTCBStateChecked
  else
    chkFillQ.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillGL = True) then
    chkFillGL.State := vTCBStateChecked
  else
    chkFillGL.State := vTCBStateUnChecked;
  if (cplot.DSOColorFillNE = True) then
    chkFillNE.State := vTCBStateChecked
  else
    chkFillNE.State := vTCBStateUnChecked;
end;

// ------------------------------------

procedure Tf_config_display.ShowLine;
begin
  EqGrid.Checked := csc.ShowEqGrid;
  CGrid.Checked := csc.ShowGrid;
  OnlyMeridian.Checked := csc.ShowOnlyMeridian;
  CheckBox8.Checked := csc.ShowAlwaysMeridian;
  MeridianWideLine.Checked := csc.MeridianWideLine;
  GridNum.Checked := csc.ShowGridNum;
  CenterDecGridNum.Checked := csc.CenterDecGridNum;
  ShowLines.Checked := csc.showline;
  if csc.DSLforcecolor then
    ShowLineShape.Brush.Color := csc.DSLcolor
  else
    ShowLineShape.Brush.Color := clWhite;
  DSLsurface.Checked := csc.DSLsurface;
  Ecliptic.Checked := csc.ShowEcliptic;
  Galactic.Checked := csc.ShowGalactic;
  ShowEquator.Checked := csc.ShowEquator;
  ConstlFile.Text := cmain.ConstLfile;
  ConstlFile.InitialDir := ExtractFilePath(cmain.ConstLfile);
  ConstbFile.Text := cmain.ConstBfile;
  ConstbFile.InitialDir := ExtractFilePath(cmain.ConstBfile);
  ConstL.Checked := csc.ShowConstl;
  ConstB.Checked := csc.ShowConstb;
  milkyway.Checked := csc.ShowMilkyWay;
  fillmilkyway.Checked := csc.FillMilkyWay;
  linemodemilkyway.Checked := csc.LinemodeMilkyway;
  GridStyle.ItemIndex := Ord(csc.StyleGrid);
  EqGridStyle.ItemIndex := Ord(csc.StyleEqGrid);
  EclipticStyle.ItemIndex := Ord(csc.StyleEcliptic);
  GalEqStyle.ItemIndex := Ord(csc.StyleGalEq);
  CBStyle.ItemIndex := Ord(csc.StyleConstB);
  CFStyle.ItemIndex := Ord(csc.StyleConstL);
  LineWidthGrid.Value:=csc.LineWidthGrid;
  LineWidthEqGrid.Value:=csc.LineWidthEqGrid;
  LineWidthConstL.Value:=csc.LineWidthConstL;
  LineWidthConstB.Value:=csc.LineWidthConstB;
  LineWidthEcliptic.Value:=csc.LineWidthEcliptic;
  LineWidthGalEq.Value:=csc.LineWidthGalEq;
  DrawPMBox.Checked := csc.DrawPMon;
  DrawPMy.Value := csc.DrawPMyear;
end;

procedure Tf_config_display.showlabelcolor;
begin
  labelcolorStar.brush.color := cplot.labelcolor[1];
  labelcolorVar.brush.color := cplot.labelcolor[2];
  labelcolorMult.brush.color := cplot.labelcolor[3];
  labelcolorNeb.brush.color := cplot.labelcolor[4];
  labelcolorSol.brush.color := cplot.labelcolor[5];
  labelcolorAst.brush.color := cplot.labelcolor[10];
  labelcolorCom.brush.color := cplot.labelcolor[11];
  labelcolorConst.brush.color := cplot.labelcolor[6];
  labelcolorMisc.brush.color := cplot.labelcolor[7];
  labelcolorChartInfo.brush.color := cplot.labelcolor[8];
  labelcolorobslist.brush.color := cplot.labelcolor[9];
end;

procedure Tf_config_display.showlabel;
begin
  showlabelStar.Checked := csc.showlabel[1];
  showlabelVar.Checked := csc.showlabel[2];
  showlabelMult.Checked := csc.showlabel[3];
  showlabelNeb.Checked := csc.showlabel[4];
  showlabelSol.Checked := csc.showlabel[5];
  showlabelAst.Checked := csc.showlabel[10];
  showlabelCom.Checked := csc.showlabel[11];
  showlabelConst.Checked := csc.showlabel[6];
  showlabelMisc.Checked := csc.showlabel[7];
  showlabelChartInfo.Checked := csc.showlabel[8];
  labelmagStar.position := round(csc.labelmagdiff[1]);
  labelmagVar.position := round(csc.labelmagdiff[2]);
  labelmagMult.position := round(csc.labelmagdiff[3]);
  labelmagNeb.position := round(csc.labelmagdiff[4]);
  labelmagSol.position := round(csc.labelmagdiff[5]);
  labelmagAst.position := round(csc.labelmagdiff[10]);
  labelmagCom.position := round(csc.labelmagdiff[11]);
  labelsizeStar.position := cplot.labelsize[1];
  labelsizeVar.position := cplot.labelsize[2];
  labelsizeMult.position := cplot.labelsize[3];
  labelsizeNeb.position := cplot.labelsize[4];
  labelsizeSol.position := cplot.labelsize[5];
  labelsizeAst.position := cplot.labelsize[10];
  labelsizeCom.position := cplot.labelsize[11];
  labelsizeConst.position := cplot.labelsize[6];
  labelsizeMisc.position := cplot.labelsize[7];
  labelsizeChartInfo.position := cplot.labelsize[8];
  labelsizeobslist.position := cplot.labelsize[9];
  labelRotStar.position := round(csc.LabelOrient[1]);
  labelRotVar.position := round(csc.LabelOrient[2]);
  labelRotMult.position := round(csc.LabelOrient[3]);
  labelRotNeb.position := round(csc.LabelOrient[4]);
  labelRotSol.position := round(csc.LabelOrient[5]);
  labelRotAst.position := round(csc.LabelOrient[10]);
  labelRotCom.position := round(csc.LabelOrient[11]);
  labelRotConst.position := round(csc.LabelOrient[6]);
  labelRotMisc.position := round(csc.LabelOrient[7]);
  labelRotChartInfo.position := round(csc.LabelOrient[8]);
  labelRotobslist.position := round(csc.LabelOrient[9]);
  showlabelcolor;
  if csc.NameLabel then
    MagLabel.ItemIndex := 1
  else if csc.MagLabel then
    MagLabel.ItemIndex := 2
  else
    MagLabel.ItemIndex := 0;
  DistLabel.Checked := csc.DistLabel;
  if csc.ConstFullLabel then
  begin
    if csc.ConstLatinLabel then
      constlabel.ItemIndex := 0
    else
      constlabel.ItemIndex := 2;
  end
  else
    constlabel.ItemIndex := 1;
  Showlabelall.Checked := csc.Showlabelall;
  ShowChartInfo.Checked := cmain.ShowChartInfo;
  ShowTitle.Checked := cmain.ShowTitlePos;
  DrawAllStarLabel.Checked := csc.DrawAllStarLabel;
  MagNoDecimal.Checked:=csc.MagNoDecimal;
  LabelLine.Checked := csc.MovedLabelLine;
  OptLabels.Checked := csc.OptimizeLabels;
  CheckBox5.Checked := csc.ShowLegend;
  CheckBox9.Checked := csc.RotLabel;
  PanelRot.Visible := not CheckBox9.Checked;
end;

procedure Tf_config_display.ShowCircle;
var
  i: integer;
begin
  circlegrid.ColWidths[0] := DoScaleX(30);
  circlegrid.ColWidths[1] := DoScaleX(30);
  circlegrid.ColWidths[2] := DoScaleX(60);
  circlegrid.ColWidths[3] := DoScaleX(60);
  circlegrid.ColWidths[4] := DoScaleX(60);
  circlegrid.ColWidths[5] := circlegrid.clientwidth - DoScaleX(30 + 245);
  circlegrid.Cells[0, 0] := 'n';
  circlegrid.Cells[1, 0] := 'x';
  circlegrid.Cells[2, 0] := rsFOV;
  circlegrid.Cells[3, 0] := rsRotation;
  circlegrid.Cells[4, 0] := rsOffset;
  circlegrid.Cells[5, 0] := rsDescription;
  circlegrid.RowCount := csc.ncircle + 2;
  for i := 1 to csc.ncircle do
  begin
    if csc.circleok[i] then
      circlegrid.Cells[1, i] := '1'
    else
      circlegrid.Cells[1, i] := '0';
    circlegrid.Cells[2, i] := formatfloat(f2, csc.circle[i, 1]);
    circlegrid.Cells[3, i] := formatfloat(f2, csc.circle[i, 2]);
    circlegrid.Cells[4, i] := formatfloat(f2, csc.circle[i, 3]);
    circlegrid.Cells[5, i] := csc.circlelbl[i];
  end;
  CRow := 1;
  CenterMark1.Checked := csc.ShowCircle;
  CheckBox7.Checked := csc.ShowCrosshair;
  CheckBox1.Checked := csc.CircleLabel;
  CheckBox3.Checked := csc.marknumlabel;
  CheckBox4.Checked := csc.marknumlabel;
  f_fov.Edit6.Text := cshr.ffove_tfl;
  f_fov.Edit7.Text := cshr.ffove_efl;
  f_fov.Edit8.Text := cshr.ffove_efv;
end;

procedure Tf_config_display.ShowRectangle;
var
  i: integer;
begin
  rectanglegrid.ColWidths[0] := DoScaleX(30);
  rectanglegrid.ColWidths[1] := DoScaleX(30);
  rectanglegrid.ColWidths[2] := DoScaleX(60);
  rectanglegrid.ColWidths[3] := DoScaleX(60);
  rectanglegrid.ColWidths[4] := DoScaleX(60);
  rectanglegrid.ColWidths[5] := DoScaleX(60);
  rectanglegrid.ColWidths[6] := rectanglegrid.clientwidth - DoScaleX(30 + 305);
  rectanglegrid.Cells[0, 0] := 'n';
  rectanglegrid.Cells[1, 0] := 'x';
  rectanglegrid.Cells[2, 0] := rsWidth;
  rectanglegrid.Cells[3, 0] := rsHeight;
  rectanglegrid.Cells[4, 0] := rsRotation;
  rectanglegrid.Cells[5, 0] := rsOffset;
  rectanglegrid.Cells[6, 0] := rsDescription;
  rectanglegrid.RowCount := csc.nrectangle + 2;
  for i := 1 to csc.nrectangle do
  begin
    if csc.rectangleok[i] then
      rectanglegrid.Cells[1, i] := '1'
    else
      rectanglegrid.Cells[1, i] := '0';
    rectanglegrid.Cells[2, i] := formatfloat(f2, csc.rectangle[i, 1]);
    rectanglegrid.Cells[3, i] := formatfloat(f2, csc.rectangle[i, 2]);
    rectanglegrid.Cells[4, i] := formatfloat(f2, csc.rectangle[i, 3]);
    rectanglegrid.Cells[5, i] := formatfloat(f2, csc.rectangle[i, 4]);
    rectanglegrid.Cells[6, i] := csc.rectanglelbl[i];
  end;
  RRow := 1;
  CenterMark2.Checked := csc.ShowCircle;
  CheckBox2.Checked := csc.RectangleLabel;
  cbAltAzMark.Checked:=csc.AltAzMark;
  f_fov.Edit11.Text := cshr.ffovc_tfl;
  f_fov.Edit12.Text := cshr.ffovc_px;
  f_fov.Edit13.Text := cshr.ffovc_py;
  f_fov.Edit15.Text := cshr.ffovc_cx;
  f_fov.Edit16.Text := cshr.ffovc_cy;
end;

procedure Tf_config_display.nebuladisplayClick(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.nebplot := nebuladisplay.ItemIndex;
end;

procedure Tf_config_display.SurfaceAlphaChange(Sender: TObject);
begin
  if LockChange then
    exit;
  csc.SurfaceAlpha := SurfaceAlpha.Position;
end;

procedure Tf_config_display.SurfaceBlureClick(Sender: TObject);
begin
  if LockChange then
    exit;
  csc.SurfaceBlure := SurfaceBlure.Checked;
end;

procedure Tf_config_display.red_moveBoxClick(Sender: TObject);
begin
  cplot.red_move := red_moveBox.Checked;
end;

procedure Tf_config_display.antialiasClick(Sender: TObject);
begin
  cplot.AntiAlias := antialias.Checked;
end;

procedure Tf_config_display.stardisplayClick(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.starplot := stardisplay.ItemIndex;
  panel7.Visible := (cplot.starplot = 2);
  panel4.Visible := (cplot.starplot = 0);
  panel5.Visible := (cplot.starplot = 1);
end;

procedure Tf_config_display.StarSizeBar1Change(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.starsize := StarSizeBar1.position;
end;

procedure Tf_config_display.StarDynBar1Change(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.stardyn := StarDynBar1.position;
end;

procedure Tf_config_display.StarSizeBarChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.partsize := StarSizeBar.position / 10;
end;

procedure Tf_config_display.SizeContrastBarChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.magsize := SizeContrastBar.position / 10;
end;

procedure Tf_config_display.StarContrastBarChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.contrast := StarContrastBar.position;
end;

procedure Tf_config_display.SaturationBarChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cplot.saturation := SaturationBar.position;
end;

procedure Tf_config_display.StarButton1Click(Sender: TObject);
begin
  StarSizeBar.Position := 12;
  SizeContrastBar.Position := 40;
  StarContrastBar.Position := 450;
  SaturationBar.Position := 255;
  cplot.partsize := StarSizeBar.position / 10;
  cplot.magsize := SizeContrastBar.position / 10;
  cplot.contrast := StarContrastBar.position;
  cplot.saturation := SaturationBar.position;
end;

procedure Tf_config_display.StarButton2Click(Sender: TObject);
begin
  StarSizeBar.Position := 12;
  SizeContrastBar.Position := 10;
  StarContrastBar.Position := 400;
  SaturationBar.Position := 192;
  cplot.partsize := StarSizeBar.position / 10;
  cplot.magsize := SizeContrastBar.position / 10;
  cplot.contrast := StarContrastBar.position;
  cplot.saturation := SaturationBar.position;
end;

procedure Tf_config_display.StarButton3Click(Sender: TObject);
begin
  StarSizeBar.Position := 25;
  SizeContrastBar.Position := 40;
  StarContrastBar.Position := 300;
  SaturationBar.Position := 255;
  cplot.partsize := StarSizeBar.position / 10;
  cplot.magsize := SizeContrastBar.position / 10;
  cplot.contrast := StarContrastBar.position;
  cplot.saturation := SaturationBar.position;
end;

procedure Tf_config_display.StarButton4Click(Sender: TObject);
begin
  StarSizeBar.Position := 12;
  SizeContrastBar.Position := 40;
  StarContrastBar.Position := 500;
  SaturationBar.Position := 0;
  cplot.partsize := StarSizeBar.position / 10;
  cplot.magsize := SizeContrastBar.position / 10;
  cplot.contrast := StarContrastBar.position;
  cplot.saturation := SaturationBar.position;
end;

procedure Tf_config_display.SetFonts(ctrl: Tedit; num: integer);
begin
  ctrl.Text := cplot.FontName[num];
{$ifdef mswindows}
  ctrl.Font.Name := cplot.FontName[num];
  ctrl.Font.Size := cplot.FontSize[num];
  if cplot.FontBold[num] then
    ctrl.Font.Style := [fsBold]
  else
    ctrl.Font.Style := [];
  if cplot.FontItalic[num] then
    ctrl.Font.Style := ctrl.Font.Style + [fsItalic];
{$endif}
end;

procedure Tf_config_display.SelectFontClick(Sender: TObject);
var
  i, p: integer;
  fontn: string;
begin
  if Sender is Tspeedbutton then
    with Sender as Tspeedbutton do
      i := tag
  else
    exit;
  Fontdialog1.Font.Name := cplot.FontName[i];
  Fontdialog1.Font.Size := cplot.FontSize[i];
  if cplot.FontBold[i] then
    Fontdialog1.Font.Style := [fsBold]
  else
    Fontdialog1.Font.Style := [];
  if cplot.FontItalic[i] then
    Fontdialog1.Font.Style := Fontdialog1.Font.Style + [fsItalic];
  if Fontdialog1.Execute then
  begin
    fontn := Fontdialog1.Font.Name;
    // keep only the name from the selected font
    //  '-bitstream-bitstream vera sans-medium-r-normal-*-*-140-*-*-p-*-iso8859-1'
    p := pos('-', fontn);
    if p > 0 then
    begin
      Delete(fontn, 1, p);
      p := pos('-', fontn);
      if p > 0 then
        Delete(fontn, 1, p);
      p := pos('-', fontn);
      if p > 0 then
        fontn := Copy(fontn, 1, p - 1);
    end;
    if fontn <> '' then
    begin
      cplot.FontName[i] := fontn;
      // assign other font properties
      cplot.FontSize[i] := Fontdialog1.Font.Size;
      cplot.FontBold[i] := fsBold in Fontdialog1.Font.Style;
      cplot.FontItalic[i] := fsItalic in Fontdialog1.Font.Style;
    end;
  end;
  ShowFonts;
end;

procedure Tf_config_display.DefaultFontClick(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to numfont do
  begin
    cplot.FontName[i] := DefaultFontName;
    cplot.FontSize[i] := DoScaleX(DefaultFontSize);
    cplot.FontBold[i] := False;
    cplot.FontItalic[i] := False;
  end;
  cplot.FontName[5] := DefaultFontFixed;
  cplot.FontName[7] := 'Symbol';
  ShowFonts;
end;

procedure Tf_config_display.ShapeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Sender is TShape then
    with Sender as TShape do
    begin
      ColorDialog1.color := cplot.Color[tag];
      if ColorDialog1.Execute then
      begin
        cplot.Color[tag] := ColorDialog1.Color;
        ShowColor;
      end;
    end;
end;

procedure Tf_config_display.skycolorboxClick(Sender: TObject);
begin
  cplot.autoskycolor := (skycolorbox.ItemIndex = 1);
  panel2.Visible := cplot.autoskycolor;
end;

procedure Tf_config_display.ShapeSkyMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  L: integer;
begin
  if Sender is TShape then
    with Sender as TShape do
    begin
      ColorDialog1.color := cplot.SkyColor[tag];
      if ColorDialog1.Execute then
      begin
        cplot.SkyColor[tag] := ColorDialog1.Color;
        if tag = 0 then
        begin
          L := ((ColorDialog1.Color and $ff) + ((ColorDialog1.Color shr 8) and $ff) +
            ((ColorDialog1.Color shr 16) and $ff)) div 3;
          cplot.bgcolor := ColorDialog1.Color;
          cplot.color[0] := cplot.bgcolor;
          if L < 128 then
            cplot.color[11] := clWhite
          else
            cplot.color[11] := clBlack;
          ShowColor;
        end;
        ShowSkyColor;
      end;
    end;
end;

procedure Tf_config_display.Button3Click(Sender: TObject);
begin
  cplot.SkyColor := dfSkyColor;
  cplot.bgcolor := cplot.SkyColor[0];
  cplot.color[0] := cplot.bgcolor;
  cplot.color[11] := clWhite;
  ShowColor;
  ShowSkyColor;
end;

procedure Tf_config_display.ShapeDSOMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Sender is TShape then
    with Sender as TShape do
    begin
      ColorDialog1.color := cplot.Color[tag];
      if ColorDialog1.Execute then
      begin
        cplot.Color[tag] := ColorDialog1.Color;
        Brush.Color := cplot.Color[tag];
        if tag = 31 then
          UpdNebColor;
      end;
    end;
end;

procedure Tf_config_display.FillDSOMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Sender is TCheckBox then
    with Sender as TCheckBox do
    begin
      cplot.DSOColorFillOCl := False;
      if Sender = chkFillGCl then
        cplot.DSOColorFillOCl := True;
    end;
end;

procedure Tf_config_display.UpdNebColor;

  function SetColor(i, col: integer): Tcolor;
  var
    r, g, b: byte;
  begin
    r := cplot.Color[i] and $FF;
    g := (cplot.Color[i] shr 8) and $FF;
    b := (cplot.Color[i] shr 16) and $FF;
    Result := (r * col div 255) + 256 * (g * col div 255) + 65536 * (b * col div 255);
  end;

begin
  NebColorPanel.color := cplot.Color[0];
  shape29.brush.color := SetColor(31, cplot.NebGray);
  shape30.brush.color := SetColor(31, cplot.NebBright);
end;

procedure Tf_config_display.NebGrayBarChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if NebGrayBar.position < cplot.NebBright then
  begin
    cplot.NebGray := NebGrayBar.position;
    UpdNebColor;
  end
  else
  begin
    NebGrayBar.position := cplot.NebBright - 1;
  end;
end;

procedure Tf_config_display.NebBrightBarChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if NebBrightBar.position > cplot.NebGray then
  begin
    cplot.NebBright := NebBrightBar.position;
    UpdNebColor;
  end
  else
  begin
    NebBrightBar.position := cplot.NebGray + 1;
  end;
end;

procedure Tf_config_display.DefNebColorButtonClick(Sender: TObject);
begin
  cplot.Nebgray := 55;
  cplot.NebBright := 180;
  ShowNebColor;
end;

procedure Tf_config_display.CGridClick(Sender: TObject);
begin
  csc.ShowGrid := CGrid.Checked;
end;

procedure Tf_config_display.OnlyMeridianClick(Sender: TObject);
begin
  csc.ShowOnlyMeridian := OnlyMeridian.Checked;
end;

procedure Tf_config_display.OptLabelsClick(Sender: TObject);
begin
  csc.OptimizeLabels := OptLabels.Checked;
end;

procedure Tf_config_display.EqGridClick(Sender: TObject);
begin
  csc.ShowEqGrid := EqGrid.Checked;
end;

procedure Tf_config_display.GridNumClick(Sender: TObject);
begin
  csc.ShowGridNum := GridNum.Checked;
end;

procedure Tf_config_display.CenterDecGridNumClick(Sender: TObject);
begin
  csc.CenterDecGridNum:=CenterDecGridNum.Checked;
end;

procedure Tf_config_display.eclipticClick(Sender: TObject);
begin
  csc.Showecliptic := ecliptic.Checked;
end;

procedure Tf_config_display.galacticClick(Sender: TObject);
begin
  csc.Showgalactic := galactic.Checked;
end;

procedure Tf_config_display.ShowEquatorClick(Sender: TObject);
begin
 csc.ShowEquator := ShowEquator.Checked;
end;

procedure Tf_config_display.ConstlClick(Sender: TObject);
begin
  csc.ShowConstl := ConstL.Checked;
end;

procedure Tf_config_display.ConstlFileChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.ConstLfile := expandfilename(ConstlFile.Text);
end;

procedure Tf_config_display.ConstbClick(Sender: TObject);
begin
  csc.ShowConstb := ConstB.Checked;
end;

procedure Tf_config_display.ConstbFileChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.ConstBfile := expandfilename(ConstbFile.Text);
end;

procedure Tf_config_display.milkywayClick(Sender: TObject);
begin
  csc.showmilkyway := milkyway.Checked;
end;

procedure Tf_config_display.linemodemilkywayClick(Sender: TObject);
begin
  csc.LinemodeMilkyway := linemodemilkyway.Checked;
end;

procedure Tf_config_display.fillmilkywayClick(Sender: TObject);
begin
  csc.fillmilkyway := fillmilkyway.Checked;
end;

procedure Tf_config_display.showlabelClick(Sender: TObject);
begin
  with Sender as TCheckBox do
    csc.ShowLabel[tag] := Checked;
end;

procedure Tf_config_display.showlabelallClick(Sender: TObject);
begin
  csc.Showlabelall := Showlabelall.Checked;
end;

procedure Tf_config_display.ShowChartInfoClick(Sender: TObject);
begin
  cmain.ShowChartInfo := ShowChartInfo.Checked;
end;

procedure Tf_config_display.ShowTitleClick(Sender: TObject);
begin
  cmain.ShowTitlePos := ShowTitle.Checked;
end;

procedure Tf_config_display.labelcolorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if Sender is TShape then
    with Sender as TShape do
    begin
      ColorDialog1.color := cplot.LabelColor[tag];
      if ColorDialog1.Execute then
      begin
        cplot.LabelColor[tag] := ColorDialog1.Color;
        ShowLabelColor;
      end;
    end;
end;

procedure Tf_config_display.Button9Click(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to numlabtype do
  begin
    cplot.LabelColor[i] := clWhite;
    cplot.LabelSize[i] := DoScaleX(DefaultFontSize);
    csc.LabelMagDiff[i] := 4;
    csc.ShowLabel[i] := True;
    csc.LabelOrient[i] := 0;
  end;
  csc.LabelMagDiff[1] := 3;
  csc.LabelMagDiff[5] := 0;
  csc.LabelMagDiff[10] := 2;
  csc.LabelMagDiff[11] := 0;
  cplot.LabelColor[6] := clYellow;
  cplot.LabelColor[7] := clSilver;
  cplot.LabelSize[6] := cplot.LabelSize[6] + 2;
  cplot.LabelColor[9] := clLime;
  cplot.LabelSize[9] := DoScaleX(DefaultFontSize + 1);
  csc.LabelMagDiff[9] := 0;
  csc.ShowLabel[9] := True;
  csc.Showlabelall := True;
  cmain.ShowChartInfo := False;
  cmain.ShowTitlePos := False;
  csc.DrawAllStarLabel := False;
  csc.MovedLabelLine := True;
  csc.NameLabel := False;
  csc.MagLabel := False;
  csc.ConstFullLabel := True;
  csc.ConstLatinLabel := False;
  ShowLabel;
  ShowLabelColor;
end;

procedure Tf_config_display.MagLabelClick(Sender: TObject);
begin
  csc.MagLabel := (MagLabel.ItemIndex = 2);
  csc.NameLabel := (MagLabel.ItemIndex = 1);
end;

procedure Tf_config_display.DistLabelClick(Sender: TObject);
begin
  csc.DistLabel := DistLabel.Checked;
end;

procedure Tf_config_display.constlabelClick(Sender: TObject);
begin
  csc.ConstFullLabel := (constlabel.ItemIndex <> 1);
  csc.ConstLatinLabel := (constlabel.ItemIndex = 0);
end;

procedure Tf_config_display.CirclegridSetEditText(Sender: TObject;
  ACol, ARow: integer; const Value: string);
var
  x: single;
  n: integer;
begin
  if ARow>csc.ncircle then begin
    csc.ncircle:=ARow;
    SetLength(csc.circle, csc.ncircle + 1);
    SetLength(csc.circleok, csc.ncircle + 1);
    SetLength(csc.circlelbl, csc.ncircle + 1);
  end;
  case ACol of
    2:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.circle[Arow, 1] := x
      else
        beep;
    end;
    3:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.circle[Arow, 2] := x
      else
        beep;
    end;
    4:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.circle[Arow, 3] := abs(x)
      else
        beep;
    end;
    5:
    begin
      csc.circlelbl[ARow] := Value;
    end;
  end;
end;

procedure Tf_config_display.CenterMark1Click(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    csc.ShowCircle := Checked;
    CenterMark1.Checked := Checked;
    CenterMark2.Checked := Checked;
  end;
end;

procedure Tf_config_display.CheckBox7Click(Sender: TObject);
begin
  csc.ShowCrosshair := CheckBox7.Checked;
end;

procedure Tf_config_display.CheckBox8Click(Sender: TObject);
begin
  csc.ShowAlwaysMeridian := CheckBox8.Checked;
end;

procedure Tf_config_display.MeridianWideLineClick(Sender: TObject);
begin
  csc.MeridianWideLine:=MeridianWideLine.Checked;
end;

procedure Tf_config_display.CheckBox9Click(Sender: TObject);
begin
  csc.RotLabel := CheckBox9.Checked;
  PanelRot.Visible := not CheckBox9.Checked;
end;

procedure Tf_config_display.RectangleGridSetEditText(Sender: TObject;
  ACol, ARow: integer; const Value: string);
var
  x: single;
  n: integer;
begin
  if ARow>csc.nrectangle then begin
    csc.nrectangle:=ARow;
    SetLength(csc.rectangle, csc.nrectangle + 1);
    SetLength(csc.rectangleok, csc.nrectangle + 1);
    SetLength(csc.rectanglelbl, csc.nrectangle + 1);
  end;
  case ACol of
    2:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.rectangle[Arow, 1] := x
      else
        beep;
    end;
    3:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.rectangle[Arow, 2] := x
      else
        beep;
    end;
    4:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.rectangle[Arow, 3] := rmod(x+360,360)
      else
        beep;
    end;
    5:
    begin
      val(Value, x, n);
      if n = 0 then
        csc.rectangle[Arow, 4] := abs(x)
      else
        beep;
    end;
    6:
    begin
      csc.rectanglelbl[ARow] := Value;
    end;
  end;
end;

procedure Tf_config_display.chkFillAstClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillAst.Checked then
      cplot.DSOColorFillAst := True
    else
      cplot.DSOColorFillAst := False;
  end;
end;

procedure Tf_config_display.chkFillOClClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillOCl.Checked then
      cplot.DSOColorFillOCl := True
    else
      cplot.DSOColorFillOCl := False;
  end;
end;

procedure Tf_config_display.chkFillPNeClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillPNe.Checked then
      cplot.DSOColorFillPNe := True
    else
      cplot.DSOColorFillPNe := False;
  end;
end;

procedure Tf_config_display.chkFillGClClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillGCl.Checked then
      cplot.DSOColorFillGCl := True
    else
      cplot.DSOColorFillGCl := False;
  end;
end;

procedure Tf_config_display.chkFillDNClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillDN.Checked then
      cplot.DSOColorFillDN := True
    else
      cplot.DSOColorFillDN := False;
  end;
end;

procedure Tf_config_display.chkFillENClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillEN.Checked then
      cplot.DSOColorFillEN := True
    else
      cplot.DSOColorFillEN := False;
  end;
end;

procedure Tf_config_display.chkFillRNClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillRN.Checked then
      cplot.DSOColorFillRN := True
    else
      cplot.DSOColorFillRN := False;
  end;
end;

procedure Tf_config_display.chkFillSNClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillSN.Checked then
      cplot.DSOColorFillSN := True
    else
      cplot.DSOColorFillSN := False;
  end;
end;

procedure Tf_config_display.chkFillGxyClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillGxy.Checked then
      cplot.DSOColorFillGxy := True
    else
      cplot.DSOColorFillGxy := False;
  end;
end;

procedure Tf_config_display.chkFillGxyClClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillGxyCl.Checked then
      cplot.DSOColorFillGxyCl := True
    else
      cplot.DSOColorFillGxyCl := False;
  end;
end;

procedure Tf_config_display.chkFillQClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillQ.Checked then
      cplot.DSOColorFillQ := True
    else
      cplot.DSOColorFillQ := False;
  end;
end;

procedure Tf_config_display.chkFillGLClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillGL.Checked then
      cplot.DSOColorFillGL := True
    else
      cplot.DSOColorFillGL := False;
  end;
end;

procedure Tf_config_display.chkFillNEClick(Sender: TObject);
begin
  with Sender as TCheckbox do
  begin
    if chkFillNE.Checked then
      cplot.DSOColorFillNE := True
    else
      cplot.DSOColorFillNE := False;
  end;
end;

procedure Tf_config_display.lstDSOCSchemeChange(Sender: TObject);
var
  i: integer;
begin
  i := lstDSOCScheme.ItemIndex;
  case i of
    //        CdC v2.nn
    0:
    begin //CdC v2.nn
      shpAst.Brush.Color := 16776960;
      shpOCl.Brush.Color := 16776960;
      shpGCl.Brush.Color := 16776960;
      shpPNe.Brush.Color := 8454016;
      shpDN.Brush.Color := 16777215;
      shpEN.Brush.Color := 8454016;
      shpRN.Brush.Color := 8454016;
      shpSN.Brush.Color := 255;
      shpGxy.Brush.Color := 255;
      shpGxyCl.Brush.Color := 255;
      shpQ.Brush.Color := 255;
      shpGL.Brush.Color := 255;
      shpNE.Brush.Color := 16777215;
    end;
    1:
    begin //CdC v3.nn
      shpAst.Brush.Color := 45311;
      shpOCl.Brush.Color := 45311;
      shpGCl.Brush.Color := 16777088;
      shpPNe.Brush.Color := 8453888;
      shpDN.Brush.Color := 16777215;
      shpEN.Brush.Color := 255;
      shpRN.Brush.Color := 16744448;
      shpSN.Brush.Color := 255;
      shpGxy.Brush.Color := 255;
      shpGxyCl.Brush.Color := 255;
      shpQ.Brush.Color := 8421631;
      shpGL.Brush.Color := 16711808;
      shpNE.Brush.Color := 16777215;
    end;
    2:
    begin //Tirion Sky Atlas 2000
      shpAst.Brush.Color := 45311;
      shpOCl.Brush.Color := 45311;
      shpGCl.Brush.Color := 32696;
      shpPNe.Brush.Color := 4259584;
      shpDN.Brush.Color := 8421504;
      shpEN.Brush.Color := 16711935;
      shpRN.Brush.Color := 16711935;
      shpSN.Brush.Color := 4227327;
      shpGxy.Brush.Color := 255;
      shpGxyCl.Brush.Color := 255;
      shpQ.Brush.Color := 255;
      shpGL.Brush.Color := 16776960;
      shpNE.Brush.Color := 12632256;
    end;
    3:
    begin //Megastar
      shpAst.Brush.Color := 4259584;
      shpOCl.Brush.Color := 4259584;
      shpGCl.Brush.Color := 4259584;
      shpPNe.Brush.Color := 4259584;
      shpDN.Brush.Color := 4259584;
      shpEN.Brush.Color := 4259584;
      shpRN.Brush.Color := 4259584;
      shpSN.Brush.Color := 4259584;
      shpGxy.Brush.Color := 4259584;
      shpGxyCl.Brush.Color := 4259584;
      shpQ.Brush.Color := 4259584;
      shpGL.Brush.Color := 4259584;
      shpNE.Brush.Color := 4259584;
    end;
  end;
  cplot.Color[23] := shpAst.Brush.Color;
  cplot.Color[24] := shpOCl.Brush.Color;
  cplot.Color[25] := shpGCl.Brush.Color;
  cplot.Color[26] := shpPNe.Brush.Color;
  cplot.Color[27] := shpDN.Brush.Color;
  cplot.Color[28] := shpEN.Brush.Color;
  cplot.Color[29] := shpRN.Brush.Color;
  cplot.Color[30] := shpSN.Brush.Color;
  cplot.Color[31] := shpGxy.Brush.Color;
  cplot.Color[32] := shpGxyCl.Brush.Color;
  cplot.Color[33] := shpQ.Brush.Color;
  cplot.Color[34] := shpGL.Brush.Color;
  cplot.Color[35] := shpNE.Brush.Color;
end;

procedure Tf_config_display.PageDSOColourShow(Sender: TObject);
begin
  if cplot.nebplot = 0 then
  begin
    FillPanel1.Visible := False;
    FillPanel2.Visible := False;
  end
  else
  begin
    FillPanel1.Visible := True;
    FillPanel2.Visible := True;
  end;
end;

procedure Tf_config_display.PageControl1Changing(Sender: TObject;
  var AllowChange: boolean);
begin
  if parent is TForm then
    TForm(Parent).ActiveControl := PageControl1;
end;

procedure Tf_config_display.RectangleGridColRowInserted(Sender: TObject;
  IsColumn: boolean; sIndex, tIndex: integer);
var
  i: integer;
begin
  if LockChange then
    exit;
  csc.nrectangle := Rectanglegrid.RowCount - 1;
  SetLength(csc.rectangle, csc.nrectangle + 1);
  SetLength(csc.rectangleok, csc.nrectangle + 1);
  SetLength(csc.rectanglelbl, csc.nrectangle + 1);
  i := csc.nrectangle;
  csc.rectangleok[i] := False;
  csc.rectangle[i, 1] := 0;
  csc.rectangle[i, 2] := 0;
  csc.rectangle[i, 3] := 0;
  csc.rectangle[i, 4] := 0;
  csc.rectanglelbl[i] := '';
  Rectanglegrid.Cells[1, i] := '0';
  Rectanglegrid.Cells[2, i] := formatfloat(f2, csc.rectangle[i, 1]);
  Rectanglegrid.Cells[3, i] := formatfloat(f2, csc.rectangle[i, 2]);
  Rectanglegrid.Cells[4, i] := formatfloat(f2, csc.rectangle[i, 3]);
  Rectanglegrid.Cells[5, i] := formatfloat(f2, csc.rectangle[i, 4]);
  Rectanglegrid.Cells[6, i] := csc.rectanglelbl[i];
end;

procedure Tf_config_display.RectangleGridColRowMoved(Sender: TObject;
  IsColumn: boolean; sIndex, tIndex: integer);
var
  i, n: integer;
  x: double;
begin
  if LockChange then
    exit;
  for i := 1 to RectangleGrid.RowCount - 1 do
  begin
    csc.rectangleok[i] := RectangleGrid.Cells[1, i] = '1';
    val(RectangleGrid.Cells[2, i], x, n);
    if n = 0 then
      csc.rectangle[i, 1] := x;
    val(RectangleGrid.Cells[3, i], x, n);
    if n = 0 then
      csc.rectangle[i, 2] := x;
    val(RectangleGrid.Cells[4, i], x, n);
    if n = 0 then
      csc.rectangle[i, 3] := x;
    val(RectangleGrid.Cells[5, i], x, n);
    if n = 0 then
      csc.rectangle[i, 4] := x;
    csc.rectanglelbl[i] := RectangleGrid.Cells[6, i];
  end;
end;

procedure Tf_config_display.RectangleGridDblClick(Sender: TObject);
begin
  ButtonComputeRectangleClick(Sender);
end;

procedure Tf_config_display.ButtonComputeRectangleClick(Sender: TObject);
begin
  if (RRow > 0) then
  begin
    if f_fov = nil then
      f_fov := Tf_fov.Create(self);
    f_fov.PageControl1.ActivePageIndex := 1;
    f_fov.Edit14.Text := RectangleGrid.Cells[2, RRow];
    f_fov.Edit17.Text := RectangleGrid.Cells[3, RRow];
    FormPos(f_fov, mouse.cursorpos.x, mouse.cursorpos.y);
    f_fov.ShowModal;
    if f_fov.ModalResult = mrOk then
    begin
      RectangleGrid.Cells[2, RRow] := f_fov.Edit14.Text;
      RectangleGrid.Cells[3, RRow] := f_fov.Edit17.Text;
      csc.rectangle[RRow, 1] := StrToFloatDef(RectangleGrid.Cells[2, RRow],
        csc.rectangle[RRow, 1]);
      csc.rectangle[RRow, 2] := StrToFloatDef(RectangleGrid.Cells[3, RRow],
        csc.rectangle[RRow, 2]);
      cshr.ffovc_tfl := f_fov.Edit11.Text;
      cshr.ffovc_px := f_fov.Edit12.Text;
      cshr.ffovc_py := f_fov.Edit13.Text;
      cshr.ffovc_cx := f_fov.Edit15.Text;
      cshr.ffovc_cy := f_fov.Edit16.Text;
    end;
  end;
end;

procedure Tf_config_display.RectangleGridDrawCell(Sender: TObject;
  aCol, aRow: integer; aRect: TRect; aState: TGridDrawState);
var i: integer;
begin
  with Sender as TStringGrid do
  begin
    if (Acol = 1) and (Arow > 0) then
    begin
      i := (RowHeights[aRow]-ImageList1.Height) div 2;
      Canvas.Brush.style := bssolid;
      if (cells[acol, arow] = '1') then
      begin
        Canvas.Brush.Color := clWindow;
        Canvas.FillRect(aRect);
        ImageList1.Draw(Canvas, aRect.left + 2, aRect.top + i, 3);
      end
      else
      begin
        Canvas.Brush.Color := clWindow;
        Canvas.FillRect(aRect);
        ImageList1.Draw(Canvas, aRect.left + 2, aRect.top + i, 2);
      end;
    end;
  end;
end;

procedure Tf_config_display.RectangleGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  col, row: integer;
begin
  RectangleGrid.MouseToCell(X, Y, Col, Row);
  if row = 0 then
    exit;
  case col of
    1:
    begin
      if RectangleGrid.Cells[col, row] = '1' then
        RectangleGrid.Cells[col, row] := '0'
      else
        RectangleGrid.Cells[col, row] := '1';
      csc.rectangleok[row] := RectangleGrid.Cells[col, row] = '1';
    end;
  end;
end;

procedure Tf_config_display.RectangleGridSelectCell(Sender: TObject;
  aCol, aRow: integer; var CanSelect: boolean);
begin
  if LockChange then
    exit;
  if (Acol = 1) then
    canselect := False
  else
    canselect := True;
  RCol := aCol;
  RRow := aRow;
end;

procedure Tf_config_display.ShowLinesClick(Sender: TObject);
begin
  csc.showline := ShowLines.Checked;
end;

procedure Tf_config_display.ShowLineShapeMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  buf: string;
begin
  buf := ColorDialog1.Title;
  ColorDialog1.Title := rsSelectColorB;
  ColorDialog1.Color := csc.DSLcolor;
  if ColorDialog1.Execute then
  begin
    csc.DSLforcecolor := (ColorDialog1.Color <> clBlack)and(ColorDialog1.Color <> clWhite);
    csc.DSLcolor := ColorDialog1.Color;
    if csc.DSLforcecolor then
      ShowLineShape.Brush.Color := csc.DSLcolor
    else
      ShowLineShape.Brush.Color := clWhite;
  end;
  ColorDialog1.Title := buf;
end;

procedure Tf_config_display.DSLsurfaceClick(Sender: TObject);
begin
  csc.DSLsurface := DSLsurface.Checked;
end;


end.
