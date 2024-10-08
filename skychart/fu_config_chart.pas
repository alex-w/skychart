unit fu_config_chart;

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
  u_help, u_translation, u_constant, u_projection, u_util,
  LCLIntf, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, enhedits, ComCtrls, LResources,
  Buttons, cu_radec, LazHelpHTML_fix;

type

  { Tf_config_chart }

  Tf_config_chart = class(TFrame)
    ApparentType: TRadioGroup;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel7: TBevel;
    BigNebBox: TCheckBox;
    BigNebUnit: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button7: TButton;
    Button8: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    BrightMagBox: TCheckBox;
    MessierBox: TCheckBox;
    epoch2: TFloatEdit;
    ExpertMode: TCheckBox;
    CheckBox13: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    ComboBox9: TComboBox;
    equinox2: TFloatEdit;
    EquinoxLabel: TLabel;
    fBigNebLimit: TLongEdit;
    fdim0: TFloatEdit;
    fdim1: TFloatEdit;
    fdim2: TFloatEdit;
    fdim3: TFloatEdit;
    fdim4: TFloatEdit;
    fdim5: TFloatEdit;
    fdim6: TFloatEdit;
    fdim7: TFloatEdit;
    fdim8: TFloatEdit;
    fdim9: TFloatEdit;
    fmag0: TFloatEdit;
    fmag1: TFloatEdit;
    fmag2: TFloatEdit;
    fmag3: TFloatEdit;
    fmag4: TFloatEdit;
    fmag5: TFloatEdit;
    fmag6: TFloatEdit;
    fmag7: TFloatEdit;
    fmag8: TFloatEdit;
    fmag9: TFloatEdit;
    fsmag0: TFloatEdit;
    fsmag1: TFloatEdit;
    fsmag2: TFloatEdit;
    fsmag3: TFloatEdit;
    fsmag4: TFloatEdit;
    fsmag5: TFloatEdit;
    fsmag6: TFloatEdit;
    fsmag7: TFloatEdit;
    fsmag8: TFloatEdit;
    fsmag9: TFloatEdit;
    fsmagvis: TFloatEdit;
    ft0: TFloatEdit;
    ft1: TFloatEdit;
    ft10: TFloatEdit;
    ft2: TFloatEdit;
    ft3: TFloatEdit;
    ft4: TFloatEdit;
    ft5: TFloatEdit;
    ft6: TFloatEdit;
    ft7: TFloatEdit;
    ft8: TFloatEdit;
    ft9: TFloatEdit;
    fw0: TFloatEdit;
    fw00: TFloatEdit;
    fw1: TFloatEdit;
    fw2: TFloatEdit;
    fw3: TFloatEdit;
    fw4: TFloatEdit;
    fw5: TFloatEdit;
    fw6: TFloatEdit;
    fw7: TFloatEdit;
    fw8: TFloatEdit;
    fw9: TFloatEdit;
    fv10: TLabel;
    fv9: TLabel;
    fv8: TLabel;
    fv7: TLabel;
    fv6: TLabel;
    fv5: TLabel;
    fv4: TLabel;
    fv3: TLabel;
    fv2: TLabel;
    fv1: TLabel;
    fv0: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label114: TLabel;
    Label158: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label172: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label2: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label57: TLabel;
    Label74: TLabel;
    Label76: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Labelp0: TLabel;
    Labelp1: TLabel;
    Labelp10: TLabel;
    Labelp2: TLabel;
    Labelp3: TLabel;
    Labelp4: TLabel;
    Labelp5: TLabel;
    Labelp6: TLabel;
    Labelp7: TLabel;
    Labelp8: TLabel;
    Labelp9: TLabel;
    listdbl: TCheckBox;
    listneb: TCheckBox;
    listpla: TCheckBox;
    liststar: TCheckBox;
    listvar: TCheckBox;
    MainPanel: TPanel;
    NebBox: TCheckBox;
    Page1: TTabSheet;
    Page2: TTabSheet;
    Page3: TTabSheet;
    Page4: TTabSheet;
    Page5: TTabSheet;
    Page6: TTabSheet;
    Panel1: TPanel;
    PanelExpert: TPanel;
    PanelCoord: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    FOVPanel: TPanel;
    PMBox: TCheckBox;
    projectiontype: TRadioGroup;
    RaDec1: TRaDec;
    RaDec10: TRaDec;
    RaDec11: TRaDec;
    RaDec12: TRaDec;
    RaDec13: TRaDec;
    RaDec14: TRaDec;
    RaDec15: TRaDec;
    RaDec16: TRaDec;
    RaDec17: TRaDec;
    RaDec18: TRaDec;
    RaDec19: TRaDec;
    RaDec2: TRaDec;
    RaDec20: TRaDec;
    RaDec21: TRaDec;
    RaDec22: TRaDec;
    RaDec3: TRaDec;
    RaDec4: TRaDec;
    RaDec5: TRaDec;
    RaDec6: TRaDec;
    RaDec7: TRaDec;
    RaDec8: TRaDec;
    RaDec9: TRaDec;
    CoordType: TRadioGroup;
    AzimutOrigin: TRadioGroup;
    StarAutoBox: TCheckBox;
    StarBox: TCheckBox;
    PageControl1: TPageControl;
    TrackBar1: TTrackBar;
    procedure AzimutOriginClick(Sender: TObject);
    procedure BrightMagBoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ExpertModeClick(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CoordTypeClick(Sender: TObject);
    procedure MessierBoxClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure PageControl1PageChanged(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure PMBoxClick(Sender: TObject);
    procedure ApparentTypeClick(Sender: TObject);
    procedure epoch2Change(Sender: TObject);
    procedure projectiontypeClick(Sender: TObject);
    procedure FWExit(Sender: TObject);
    procedure ProjectionChange(Sender: TObject);
    procedure StarBoxClick(Sender: TObject);
    procedure StarAutoBoxClick(Sender: TObject);
    procedure fsmagvisChange(Sender: TObject);
    procedure fsmagChange(Sender: TObject);
    procedure NebBoxClick(Sender: TObject);
    procedure BigNebBoxClick(Sender: TObject);
    procedure fBigNebLimitChange(Sender: TObject);
    procedure fmagChange(Sender: TObject);
    procedure fdimChange(Sender: TObject);
    procedure DegSpacingChange(Sender: TObject);
    procedure HourSpacingChange(Sender: TObject);
    procedure liststarClick(Sender: TObject);
    procedure listnebClick(Sender: TObject);
    procedure listplaClick(Sender: TObject);
    procedure listvarClick(Sender: TObject);
    procedure listdblClick(Sender: TObject);
    procedure equinox2Change(Sender: TObject);
  private
    { Private declarations }
    LockChange: boolean;
    FApplyConfig: TNotifyEvent;
    procedure ShowChart;
    procedure ShowField;
    procedure ShowFOV;
    procedure ShowProjection;
    procedure ShowFilter;
    procedure ShowGridSpacing;
    procedure ShowObjList;
    procedure SetExpertEquinox;
    procedure SetFieldHint(var lab: Tlabel; n: integer);
    procedure SetDefaultApparent;
    procedure SetValidCoordtype;
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
    procedure SetLang;
    procedure Init; // old FormShow 
    procedure Lock; // old FormClose
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property onApplyConfig: TNotifyEvent read FApplyConfig write FApplyConfig;
  end;

implementation

{$R *.lfm}

procedure Tf_config_chart.SetLang;
begin
  Caption := rsChartCoordin;
  page1.Caption := rsChartCoordin;
  page2.Caption := rsFieldOfVisio;
  page3.Caption := rsProjection;
  page4.Caption := rsObjectFilter;
  page5.Caption := rsGridSpacing;
  page6.Caption := rsObjectList;
  Label31.Caption := rsChartSetting;
  GroupBox3.Caption := rsStarsProperM;
  label1.Caption := rsEpoch;
  ExpertMode.Caption := rsExpertMode;
  PMBox.Caption := rsUseTheProper;
  EquinoxLabel.Caption := rsEquinox;
  projectiontype.Caption := rsChartCoordin2;
  AzimutOrigin.Caption := rsAzimuthOrigi;
  AzimutOrigin.Items[0] := rsNorth;
  AzimutOrigin.Items[1] := rsSouth;
  ApparentType.Caption := rsNutationAber;
  Label30.Caption := rsFieldOfVisio3;
  Label106.Caption := rsFieldNumber;
  Label107.Caption := rsFieldOfVisio;
  Label57.Caption := rsFrom;
  Label5.Caption := rsTo;
  Button1.Caption := rsDefault;
  Label158.Caption := rsProjectionSe;
  Label165.Caption := rsFieldNumber;
  Button7.Caption := rsDefault;
  Button8.Caption := rsDefault;
  Label172.Caption := rsProjection;
  Label29.Caption := rsObjectFilter2;
  GroupBox2.Caption := rsStarsFilter;
  StarBox.Caption := rsFilterStars;
  Label108.Caption := rsFieldOfVisio5;
  Label109.Caption := rsLimitingMagn2;
  Label110.Caption := rsNakedEyeRefe;
  StarAutoBox.Caption := rsAutomatic;
  GroupBox1.Caption := rsNebulaeFilte;
  BigNebUnit.Caption := rsMinutes;
  NebBox.Caption := rsFilterNebula;
  BigNebBox.Caption := rsHideObjectWi;
  MessierBox.Caption := rsDoNotFilterM;
  BrightMagBox.Caption := rsDoNotFilterB;
  Label48.Caption := rsLimitingMagn2;
  Label49.Caption := rsLimitingSize;
  Label112.Caption := rsFieldOfVisio5;
  Label160.Caption := rsFieldNumber;
  Label176.Caption := rsDegreeGridSp;
  Label175.Caption := rsHourGridSpac;
  Label95.Caption := rsObjectListSe;
  GroupBox5.Caption := rsTypeOfObject;
  liststar.Caption := rsStars;
  listneb.Caption := rsNebulae;
  listpla.Caption := rsSolarSystemO;
  listvar.Caption := rsVariableStar;
  listdbl.Caption := rsDoubleStar;
  Label2.Caption := rsFovNumber;
  ApparentType.Items[0] := rsMeanPosition;
  ApparentType.Items[1] := rsTruePosition;
  projectiontype.Items[0] := rsEquatorialCo;
  projectiontype.Items[1] := rsAzimuthalCoo;
  projectiontype.Items[2] := rsGalacticCoor;
  projectiontype.Items[3] := rsEclipticCoor;
  CoordType.Caption := rsTypeOfCoordi;
  Button2.Caption := rsDefault;
  Label4.Caption := rsCompassRoseS;
  CheckBox13.Caption := rsShowCompass;
  CheckBox2.Caption := rsUseASimplePo;
  CheckBox1.Caption := rsRotateCylind + crlf + '(HAI, CAR, MER)';
  SetHelp(self, hlpCfgChart);
  SetValidCoordtype;
end;

constructor Tf_config_chart.Create(AOwner: TComponent);
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
  SetLang;
  LockChange := True;
  fw0.OnExit := FWExit;
  fw1.OnExit := FWExit;
  fw2.OnExit := FWExit;
  fw3.OnExit := FWExit;
  fw4.OnExit := FWExit;
  fw5.OnExit := FWExit;
  fw6.OnExit := FWExit;
  fw7.OnExit := FWExit;
  fw8.OnExit := FWExit;
  fw9.OnExit := FWExit;
end;

procedure Tf_config_chart.Init;
begin
  LockChange := True;
  ShowChart;
  ShowField;
  ShowFilter;
  ShowProjection;
  ShowGridSpacing;
  ShowObjList;
  LockChange := False;
end;

destructor Tf_config_chart.Destroy;
begin
  mycsc.Free;
  myccat.Free;
  mycshr.Free;
  mycplot.Free;
  mycmain.Free;
  inherited Destroy;
end;

procedure Tf_config_chart.ShowChart;
begin
  equinox2.Text := stringreplace(stringreplace(
    stringreplace(csc.EquinoxChart, 'J', '', []), 'B', '', []), rsDate, '2000.0', []);
  epoch2.Value := csc.YPmon;
  PMBox.Checked := csc.PMon;
  if csc.ApparentPos then
    ApparentType.ItemIndex := 1
  else
    Apparenttype.ItemIndex := 0;
  projectiontype.ItemIndex := csc.ProjPole;
  if cshr.AzNorth then
    AzimutOrigin.ItemIndex := 0
  else
    AzimutOrigin.ItemIndex := 1;
  ExpertMode.Enabled := (csc.ProjPole <> 1);
  csc.CoordExpertMode := ExpertMode.Enabled and csc.CoordExpertMode;
  ExpertMode.Checked := csc.CoordExpertMode;
  SetValidCoordtype;
end;

procedure Tf_config_chart.ShowGridSpacing;
begin
  CheckBox13.Checked := cshr.ShowCRose;
  CheckBox2.Checked := cshr.SimplePointer;
  CheckBox2.Enabled := cshr.ShowCRose;
  TrackBar1.Position := cshr.CRoseSz;
  RaDec1.Value := cshr.DegreeGridSpacing[0];
  RaDec2.Value := cshr.DegreeGridSpacing[1];
  RaDec3.Value := cshr.DegreeGridSpacing[2];
  RaDec4.Value := cshr.DegreeGridSpacing[3];
  RaDec5.Value := cshr.DegreeGridSpacing[4];
  RaDec6.Value := cshr.DegreeGridSpacing[5];
  RaDec7.Value := cshr.DegreeGridSpacing[6];
  RaDec8.Value := cshr.DegreeGridSpacing[7];
  RaDec9.Value := cshr.DegreeGridSpacing[8];
  RaDec10.Value := cshr.DegreeGridSpacing[9];
  RaDec11.Value := cshr.DegreeGridSpacing[10];
  RaDec12.Value := cshr.HourGridSpacing[0];
  RaDec13.Value := cshr.HourGridSpacing[1];
  RaDec14.Value := cshr.HourGridSpacing[2];
  RaDec15.Value := cshr.HourGridSpacing[3];
  RaDec16.Value := cshr.HourGridSpacing[4];
  RaDec17.Value := cshr.HourGridSpacing[5];
  RaDec18.Value := cshr.HourGridSpacing[6];
  RaDec19.Value := cshr.HourGridSpacing[7];
  RaDec20.Value := cshr.HourGridSpacing[8];
  RaDec21.Value := cshr.HourGridSpacing[9];
  RaDec22.Value := cshr.HourGridSpacing[10];
end;

procedure Tf_config_chart.ShowField;
begin
  fw0.Value := cshr.fieldnum[0];
  fw1.Value := cshr.fieldnum[1];
  fw2.Value := cshr.fieldnum[2];
  fw3.Value := cshr.fieldnum[3];
  fw4.Value := cshr.fieldnum[4];
  fw5.Value := cshr.fieldnum[5];
  fw6.Value := cshr.fieldnum[6];
  fw7.Value := cshr.fieldnum[7];
  fw8.Value := cshr.fieldnum[8];
  fw9.Value := cshr.fieldnum[9];
  ft0.Value := cshr.fieldnum[0];
  ft1.Value := cshr.fieldnum[1];
  ft2.Value := cshr.fieldnum[2];
  ft3.Value := cshr.fieldnum[3];
  ft4.Value := cshr.fieldnum[4];
  ft5.Value := cshr.fieldnum[5];
  ft6.Value := cshr.fieldnum[6];
  ft7.Value := cshr.fieldnum[7];
  ft8.Value := cshr.fieldnum[8];
  ft9.Value := cshr.fieldnum[9];
  ShowFOV;
end;

procedure Tf_config_chart.ShowFov;
begin
  fv0.Caption := '0: 0 - ' + formatfloat(f2s, cshr.fieldnum[0]);
  fv1.Caption := '1: ' + formatfloat(f2s, cshr.fieldnum[0]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[1]);
  fv2.Caption := '2: ' + formatfloat(f1s, cshr.fieldnum[1]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[2]);
  fv3.Caption := '3: ' + formatfloat(f1s, cshr.fieldnum[2]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[3]);
  fv4.Caption := '4: ' + formatfloat(f1s, cshr.fieldnum[3]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[4]);
  fv5.Caption := '5: ' + formatfloat(f1s, cshr.fieldnum[4]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[5]);
  fv6.Caption := '6: ' + formatfloat(f1s, cshr.fieldnum[5]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[6]);
  fv7.Caption := '7: ' + formatfloat(f1s, cshr.fieldnum[6]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[7]);
  fv8.Caption := '8: ' + formatfloat(f1s, cshr.fieldnum[7]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[8]);
  fv9.Caption := '9: ' + formatfloat(f1s, cshr.fieldnum[8]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[9]);
  fv10.Caption := '10: ' + formatfloat(f1s, cshr.fieldnum[9]) + ' - ' + formatfloat(
    f1s, cshr.fieldnum[10]);
end;


procedure Tf_config_chart.ShowFilter;
begin
  starbox.Checked := cshr.StarFilter;
  StarAutoBox.Checked := cshr.AutoStarFilter;
  fsmagvis.Value := cshr.AutoStarFilterMag;
  fsmag0.Value := cshr.StarMagFilter[1];
  fsmag1.Value := cshr.StarMagFilter[2];
  fsmag2.Value := cshr.StarMagFilter[3];
  fsmag3.Value := cshr.StarMagFilter[4];
  fsmag4.Value := cshr.StarMagFilter[5];
  fsmag5.Value := cshr.StarMagFilter[6];
  fsmag6.Value := cshr.StarMagFilter[7];
  fsmag7.Value := cshr.StarMagFilter[8];
  fsmag8.Value := cshr.StarMagFilter[9];
  fsmag9.Value := cshr.StarMagFilter[10];
  nebbox.Checked := cshr.NebFilter;
  bignebbox.Checked := cshr.BigNebFilter;
  fBigNebLimit.Value := round(cshr.BigNebLimit);
  MessierBox.Checked := cshr.NoFilterMessier;
  BrightMagBox.Checked := cshr.NoFilterMagBright;
  fmag0.Value := cshr.NebMagFilter[1];
  fmag1.Value := cshr.NebMagFilter[2];
  fmag2.Value := cshr.NebMagFilter[3];
  fmag3.Value := cshr.NebMagFilter[4];
  fmag4.Value := cshr.NebMagFilter[5];
  fmag5.Value := cshr.NebMagFilter[6];
  fmag6.Value := cshr.NebMagFilter[7];
  fmag7.Value := cshr.NebMagFilter[8];
  fmag8.Value := cshr.NebMagFilter[9];
  fmag9.Value := cshr.NebMagFilter[10];
  fdim0.Value := cshr.NebSizeFilter[1];
  fdim1.Value := cshr.NebSizeFilter[2];
  fdim2.Value := cshr.NebSizeFilter[3];
  fdim3.Value := cshr.NebSizeFilter[4];
  fdim4.Value := cshr.NebSizeFilter[5];
  fdim5.Value := cshr.NebSizeFilter[6];
  fdim6.Value := cshr.NebSizeFilter[7];
  fdim7.Value := cshr.NebSizeFilter[8];
  fdim8.Value := cshr.NebSizeFilter[9];
  fdim9.Value := cshr.NebSizeFilter[10];
  panel4.Visible := cshr.StarFilter;
  panel3.Visible := cshr.AutoStarFilter;
  panel2.Visible := not cshr.AutoStarFilter;
  Panel5.Visible := cshr.NebFilter;
end;

procedure Tf_config_chart.ShowProjection;

  procedure setprojrange(var cb: Tcombobox; n: integer);
  var
    i: integer;
  begin
    cb.items.Clear;
    cb.items.add('HAI ' + rsHammerAitoff);
    cb.items.add('MER ' + rsMercator);
    cb.items.add('CAR ' + rsCartesian);
    cb.items.add('ARC ' + rsZenitalEquid);
    if cshr.fieldnum[n] <= 180 then
      cb.items.add('TAN ' + rsGnomonic);
    if cshr.fieldnum[n] <= 90 then
      cb.items.add('SIN ' + rsSlantOrthogr);
    i := (pos(csc.projname[n], ProjectionName) - 1) div 4;
    if (i >= 0) and (i < cb.Items.Count) then
      cb.Text := cb.Items[i];
  end;

begin
  setprojrange(combobox1, 0);
  setprojrange(combobox2, 1);
  setprojrange(combobox3, 2);
  setprojrange(combobox4, 3);
  setprojrange(combobox5, 4);
  setprojrange(combobox6, 5);
  setprojrange(combobox7, 6);
  setprojrange(combobox8, 7);
  setprojrange(combobox9, 8);
  setprojrange(combobox10, 9);
  setprojrange(combobox11, 10);
  setfieldhint(labelp0, 0);
  combobox1.hint := labelp0.hint;
  setfieldhint(labelp1, 1);
  combobox2.hint := labelp1.hint;
  setfieldhint(labelp2, 2);
  combobox3.hint := labelp2.hint;
  setfieldhint(labelp3, 3);
  combobox4.hint := labelp3.hint;
  setfieldhint(labelp4, 4);
  combobox5.hint := labelp4.hint;
  setfieldhint(labelp5, 5);
  combobox6.hint := labelp5.hint;
  setfieldhint(labelp6, 6);
  combobox7.hint := labelp6.hint;
  setfieldhint(labelp7, 7);
  combobox8.hint := labelp7.hint;
  setfieldhint(labelp8, 8);
  combobox9.hint := labelp8.hint;
  setfieldhint(labelp9, 9);
  combobox10.hint := labelp9.hint;
  setfieldhint(labelp10, 10);
  combobox11.hint := labelp10.hint;
  CheckBox1.Checked := csc.ProjEquatorCentered;
end;

procedure Tf_config_chart.ShowObjList;
begin
  liststar.Checked := cshr.liststar;
  listneb.Checked := cshr.listneb;
  listvar.Checked := cshr.listvar;
  listdbl.Checked := cshr.listdbl;
  listpla.Checked := cshr.listpla;
end;

procedure Tf_config_chart.SetFieldHint(var lab: Tlabel; n: integer);
const
  ff = '0.0';
begin
  case n of
    0: lab.hint := '0 - ' + formatfloat(ff, cshr.fieldnum[n]);
    1..(MaxField): lab.hint := formatfloat(ff, cshr.fieldnum[n - 1]) + ' - ' +
        formatfloat(ff, cshr.fieldnum[n]);
  end;
  lab.showhint := True;
end;

procedure Tf_config_chart.Button1Click(Sender: TObject);
begin
  cshr.FieldNum[0] := 0.5;
  cshr.FieldNum[1] := 1;
  cshr.FieldNum[2] := 2;
  cshr.FieldNum[3] := 5;
  cshr.FieldNum[4] := 10;
  cshr.FieldNum[5] := 20;
  cshr.FieldNum[6] := 45;
  cshr.FieldNum[7] := 120;
  cshr.FieldNum[8] := 180;
  cshr.FieldNum[9] := 310;
  cshr.FieldNum[10] := 360;
  ShowField;
end;

procedure Tf_config_chart.Lock;
begin
  LockChange := True;
end;

procedure Tf_config_chart.MessierBoxClick(Sender: TObject);
begin
  cshr.NoFilterMessier := MessierBox.Checked;
end;

procedure Tf_config_chart.BrightMagBoxClick(Sender: TObject);
begin
  cshr.NoFilterMagBright := BrightMagBox.Checked;
end;

procedure Tf_config_chart.PageControl1Changing(Sender: TObject;
  var AllowChange: boolean);
begin
  if parent is TForm then
    TForm(Parent).ActiveControl := PageControl1;
end;

procedure Tf_config_chart.PageControl1PageChanged(Sender: TObject);
begin
  if LockChange then
    exit;
  if (PageControl1.ActivePage.Caption = rsProjection) or
    (PageControl1.ActivePage.Caption = rsObjectFilter) or
    (PageControl1.ActivePage.Caption = rsGridSpacing) then
    FOVPanel.Visible := True
  else
    FOVPanel.Visible := False;

end;

procedure Tf_config_chart.TrackBar1Change(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.CRoseSz := TrackBar1.Position;
end;

procedure Tf_config_chart.ExpertModeClick(Sender: TObject);
begin
  csc.CoordExpertMode := ExpertMode.Checked;
  PanelExpert.Visible := ExpertMode.Checked;
  PanelCoord.Visible := not PanelExpert.Visible;
  if ExpertMode.Checked then
    SetExpertEquinox
  else
  begin
    SetDefaultApparent;
    CoordTypeClick(Sender);
  end;
end;

procedure Tf_config_chart.SetExpertEquinox;
begin
  csc.EquinoxType := 1;
  csc.PMon := PMBox.Checked;
  csc.ApparentPos := (ApparentType.ItemIndex = 1);
  equinox2Change(nil);
end;

procedure Tf_config_chart.equinox2Change(Sender: TObject);
begin
  if LockChange then
    exit;
  if (csc.EquinoxType = 1) and (trim(equinox2.Text) > '') then
  begin
    csc.EquinoxChart := equinox2.Text;
    csc.DefaultJDChart := jd(trunc(equinox2.Value), trunc(frac(equinox2.Value) * 12) + 1, 0, 0);
  end;
end;

procedure Tf_config_chart.PMBoxClick(Sender: TObject);
begin
  csc.PMon := PMBox.Checked;
end;

procedure Tf_config_chart.ApparentTypeClick(Sender: TObject);
begin
  csc.ApparentPos := (ApparentType.ItemIndex = 1);
end;

procedure Tf_config_chart.epoch2Change(Sender: TObject);
begin
  if LockChange then
    exit;
  if (csc.EquinoxType = 1) and (trim(epoch2.Text) > '') then
  begin
    csc.YPmon := epoch2.Value;
  end;
end;

procedure Tf_config_chart.SetDefaultApparent;
begin
  ExpertMode.Enabled := (csc.ProjPole <> 1);
  csc.EquinoxType := 2;
  csc.EquinoxChart := rsDate;
  csc.DefaultJDChart := jd2000;
  csc.CoordExpertMode := False;
  csc.ApparentPos := True;
  csc.PMon := True;
  csc.YPmon := 0;
  csc.CoordType := 0;
end;

procedure Tf_config_chart.projectiontypeClick(Sender: TObject);
begin
  if LockChange then
    exit;
  // save current
  csc.ProjOptions[csc.ProjPole].EquinoxType := csc.EquinoxType;
  csc.ProjOptions[csc.ProjPole].ApparentPos := csc.ApparentPos ;
  csc.ProjOptions[csc.ProjPole].PMon := csc.PMon ;
  csc.ProjOptions[csc.ProjPole].YPmon := csc.YPmon ;
  csc.ProjOptions[csc.ProjPole].EquinoxChart := csc.EquinoxChart ;
  csc.ProjOptions[csc.ProjPole].DefaultJDChart := csc.DefaultJDChart ;
  csc.ProjOptions[csc.ProjPole].CoordExpertMode := csc.CoordExpertMode ;
  csc.ProjOptions[csc.ProjPole].CoordType := csc.CoordType ;
  // change projection
  csc.ProjPole := projectiontype.ItemIndex;
  // load setting
  csc.EquinoxType    := csc.ProjOptions[csc.ProjPole].EquinoxType;
  csc.ApparentPos    := csc.ProjOptions[csc.ProjPole].ApparentPos;
  csc.PMon           := csc.ProjOptions[csc.ProjPole].PMon;
  csc.YPmon          := csc.ProjOptions[csc.ProjPole].YPmon;
  csc.EquinoxChart   := csc.ProjOptions[csc.ProjPole].EquinoxChart;
  csc.DefaultJDChart := csc.ProjOptions[csc.ProjPole].DefaultJDChart;
  csc.CoordExpertMode:= csc.ProjOptions[csc.ProjPole].CoordExpertMode;
  csc.CoordType      := csc.ProjOptions[csc.ProjPole].CoordType;

  SetValidCoordtype;
  if csc.ProjPole = 1 then
  begin
    SetDefaultApparent;
    ShowChart;
  end
  else
  begin
    ExpertMode.Enabled := True;
  end;
end;

procedure Tf_config_chart.AzimutOriginClick(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.AzNorth := (AzimutOrigin.ItemIndex = 0);
end;

procedure Tf_config_chart.SetValidCoordtype;
begin
  CoordType.Items.Clear;
  CoordType.Items.Add(rsApparent + blank + '(' + rsTrueEquatorE + ')');
  CoordType.Items.Add(rsMeanOfTheDat + blank + '(' + rsMeanEquatorE + ')');
  if csc.ProjPole <> 1 then
  begin
    CoordType.Items.Add(rsMeanJ2000 + blank + '(' + rsMeanEquinoxA + ')');
    CoordType.Items.Add(rsAstrometricJ + blank + '(' + rsMeanEquinoxJ + ')');
  end
  else
  begin
    if csc.CoordType > 1 then
      csc.CoordType := 0;
  end;
  coordtype.ItemIndex := csc.CoordType;
end;

procedure Tf_config_chart.CoordTypeClick(Sender: TObject);
begin
  if LockChange then
    exit;
  if Sender is TRadioGroup then
  begin
    if csc.EquinoxType = 1 then
      exit;
    csc.CoordType := CoordType.ItemIndex;
    case CoordType.ItemIndex of
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
end;

procedure Tf_config_chart.FWExit(Sender: TObject);
begin
  if LockChange then
    exit;
  if Sender is TFloatEdit then
    with Sender as TFloatEdit do
    begin
      if Value > 0 then
      begin
        cshr.fieldnum[tag] := Value;
        ShowField;
      end;
    end;
end;

procedure Tf_config_chart.ProjectionChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if Sender is TComboBox then
    with Sender as TComboBox do
      csc.projname[tag] := trim(copy(Text, 1, 3));
end;

procedure Tf_config_chart.StarBoxClick(Sender: TObject);
begin
  cshr.StarFilter := StarBox.Checked;
  panel4.Visible := cshr.StarFilter;
end;

procedure Tf_config_chart.StarAutoBoxClick(Sender: TObject);
begin
  cshr.AutoStarFilter := StarAutoBox.Checked;
  panel3.Visible := cshr.AutoStarFilter;
  panel2.Visible := not cshr.AutoStarFilter;
end;

procedure Tf_config_chart.fsmagvisChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.AutoStarFilterMag := fsmagvis.Value;
end;

procedure Tf_config_chart.fsmagChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if Sender is TFloatEdit then
    with Sender as TFloatEdit do
    begin
      cshr.StarMagFilter[tag] := Value;
    end;
end;

procedure Tf_config_chart.NebBoxClick(Sender: TObject);
begin
  cshr.NebFilter := NebBox.Checked;
  Panel5.Visible := cshr.NebFilter;
end;

procedure Tf_config_chart.BigNebBoxClick(Sender: TObject);
begin
  cshr.BigNebFilter := bignebbox.Checked;
end;

procedure Tf_config_chart.fBigNebLimitChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.BigNebLimit := fBigNebLimit.Value;
end;

procedure Tf_config_chart.fmagChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if Sender is TFloatEdit then
    with Sender as TFloatEdit do
    begin
      cshr.NebMagFilter[tag] := Value;
    end;
end;

procedure Tf_config_chart.fdimChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if Sender is TFloatEdit then
    with Sender as TFloatEdit do
    begin
      cshr.NebSizeFilter[tag] := Value;
    end;
end;

procedure Tf_config_chart.Button2Click(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.DegreeGridSpacing[0] := 5 / 60;
  cshr.DegreeGridSpacing[1] := 10 / 60;
  cshr.DegreeGridSpacing[2] := 20 / 60;
  cshr.DegreeGridSpacing[3] := 30 / 60;
  cshr.DegreeGridSpacing[4] := 1;
  cshr.DegreeGridSpacing[5] := 2;
  cshr.DegreeGridSpacing[6] := 5;
  cshr.DegreeGridSpacing[7] := 10;
  cshr.DegreeGridSpacing[8] := 15;
  cshr.DegreeGridSpacing[9] := 20;
  cshr.DegreeGridSpacing[10] := 20;
  cshr.HourGridSpacing[0] := 20 / 3600;
  cshr.HourGridSpacing[1] := 30 / 3600;
  cshr.HourGridSpacing[2] := 1 / 60;
  cshr.HourGridSpacing[3] := 2 / 60;
  cshr.HourGridSpacing[4] := 5 / 60;
  cshr.HourGridSpacing[5] := 15 / 60;
  cshr.HourGridSpacing[6] := 30 / 60;
  cshr.HourGridSpacing[7] := 1;
  cshr.HourGridSpacing[8] := 1;
  cshr.HourGridSpacing[9] := 2;
  cshr.HourGridSpacing[10] := 2;
  cshr.CRoseSz := 80;
  LockChange := True;
  ShowGridSpacing;
  LockChange := False;
end;

procedure Tf_config_chart.Button7Click(Sender: TObject);
begin
  csc.projname[0] := 'TAN';
  csc.projname[1] := 'TAN';
  csc.projname[2] := 'TAN';
  csc.projname[3] := 'TAN';
  csc.projname[4] := 'TAN';
  csc.projname[5] := 'TAN';
  csc.projname[6] := 'TAN';
  csc.projname[7] := 'MER';
  csc.projname[8] := 'MER';
  csc.projname[9] := 'MER';
  csc.projname[10] := 'MER';
  csc.ProjEquatorCentered := True;
  ShowProjection;
end;

procedure Tf_config_chart.Button8Click(Sender: TObject);
begin
  fsmagvis.Value := DefAutoStarFilterMag;
  cshr.StarMagFilter[0] := DefStarMagFilter[0];
  fsmag0.Value := DefStarMagFilter[1];
  fsmag1.Value := DefStarMagFilter[2];
  fsmag2.Value := DefStarMagFilter[3];
  fsmag3.Value := DefStarMagFilter[4];
  fsmag4.Value := DefStarMagFilter[5];
  fsmag5.Value := DefStarMagFilter[6];
  fsmag6.Value := DefStarMagFilter[7];
  fsmag7.Value := DefStarMagFilter[8];
  fsmag8.Value := DefStarMagFilter[9];
  fsmag9.Value := DefStarMagFilter[10];
  fBigNebLimit.Value := 211;
  cshr.NebMagFilter[0] := DefNebMagFilter[0];
  fmag0.Value := DefNebMagFilter[1];
  fmag1.Value := DefNebMagFilter[2];
  fmag2.Value := DefNebMagFilter[3];
  fmag3.Value := DefNebMagFilter[4];
  fmag4.Value := DefNebMagFilter[5];
  fmag5.Value := DefNebMagFilter[6];
  fmag6.Value := DefNebMagFilter[7];
  fmag7.Value := DefNebMagFilter[8];
  fmag8.Value := DefNebMagFilter[9];
  fmag9.Value := DefNebMagFilter[10];
  cshr.NebSizeFilter[0] := DefNebSizeFilter[0];
  fdim0.Value := DefNebSizeFilter[1];
  fdim1.Value := DefNebSizeFilter[2];
  fdim2.Value := DefNebSizeFilter[3];
  fdim3.Value := DefNebSizeFilter[4];
  fdim4.Value := DefNebSizeFilter[5];
  fdim5.Value := DefNebSizeFilter[6];
  fdim6.Value := DefNebSizeFilter[7];
  fdim7.Value := DefNebSizeFilter[8];
  fdim8.Value := DefNebSizeFilter[9];
  fdim9.Value := DefNebSizeFilter[10];
  StarBox.Checked := True;
  StarAutoBox.Checked := True;
  NebBox.Checked := True;
  BigNebBox.Checked := True;
  MessierBox.Checked := True;
  BrightMagBox.Checked := True;
end;

procedure Tf_config_chart.CheckBox1Change(Sender: TObject);
begin
  if LockChange then
    exit;
  csc.ProjEquatorCentered := CheckBox1.Checked;
end;

procedure Tf_config_chart.CheckBox2Click(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.SimplePointer := CheckBox2.Checked;
end;


procedure Tf_config_chart.CheckBox13Click(Sender: TObject);
begin
  if LockChange then
    exit;
  cshr.ShowCRose := CheckBox13.Checked;
  CheckBox2.Enabled := cshr.ShowCRose;
end;


procedure Tf_config_chart.DegSpacingChange(Sender: TObject);
var
  x: double;
begin
  if LockChange then
    exit;
  if Sender is TRaDec then
  begin
    x := TRaDec(Sender).Value;
    if x > 0 then
      cshr.DegreeGridSpacing[TRaDec(Sender).tag] := x;
  end;
end;

procedure Tf_config_chart.HourSpacingChange(Sender: TObject);
var
  x: double;
begin
  if LockChange then
    exit;
  if Sender is TRaDec then
  begin
    x := TRaDec(Sender).Value;
    if x > 0 then
      cshr.HourGridSpacing[TRaDec(Sender).tag] := x;
  end;
end;

procedure Tf_config_chart.liststarClick(Sender: TObject);
begin
  cshr.liststar := liststar.Checked;
end;

procedure Tf_config_chart.listnebClick(Sender: TObject);
begin
  cshr.listneb := listneb.Checked;
end;

procedure Tf_config_chart.listplaClick(Sender: TObject);
begin
  cshr.listpla := listpla.Checked;
end;

procedure Tf_config_chart.listvarClick(Sender: TObject);
begin
  cshr.listvar := listvar.Checked;
end;

procedure Tf_config_chart.listdblClick(Sender: TObject);
begin
  cshr.listdbl := listdbl.Checked;
end;

end.
