unit fu_config_system;

{$MODE Delphi}{$H+}

{
Copyright (C) 2005 Patrick Chevalley

http://www.ap-i.net
pch@ap-i.net

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2

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
  u_help, u_translation, u_constant, cu_database,
  Dialogs, Controls, Buttons, enhedits, ComCtrls, Classes,
  LCLIntf, SysUtils, Graphics, Forms, LazUTF8, LazFileUtils, Math,
  ExtCtrls, StdCtrls, LResources, EditBtn, LazHelpHTML_fix, CheckLst, Spin, Types;

type

  { Tf_config_system }

  Tf_config_system = class(TFrame)
    Panel3: TPanel;
    TelLimitDecMax: TFloatSpinEdit;
    TelLimitDecMin: TFloatSpinEdit;
    TelLimitHaW: TFloatSpinEdit;
    TelLimitDecMaxActive: TCheckBox;
    TelLimitHaE: TFloatSpinEdit;
    TelLimitHaEActive: TCheckBox;
    TelLimitDecMinActive: TCheckBox;
    TelescopeLimit: TGroupBox;
    LanguageList: TCheckListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    persdir: TEdit;
    ServerCoordSys: TRadioGroup;
    TelLimitHaWActive: TCheckBox;
    UseScaling: TCheckBox;
    CheckBox1: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    TelescopeLabel: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    TelescopePanel: TPanel;
    PageControl2: TPageControl;
    PageControl3: TPageControl;
    SqliteBoxLabel: TLabel;
    SqliteBox: TPanel;
    TabSheet2: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Page5: TTabSheet;
    TelescopeManualLabel: TLabel;
    Label14: TLabel;
    Language: TTabSheet;
    Page1: TTabSheet;
    TelescopeManual: TPanel;
    Label12: TLabel;
    LinuxCmd: TEdit;
    LinuxDesktopBox: TComboBox;
    GroupBoxLinux: TGroupBox;
    MainPanel: TPanel;
    Page3: TTabSheet;
    Page4: TTabSheet;
    Page2: TTabSheet;
    Label153: TLabel;
    GroupBoxDir: TGroupBox;
    Label157: TLabel;
    GroupBox3: TGroupBox;
    Label54: TLabel;
    Label55: TLabel;
    UseIPserver: TCheckBox;
    ipaddr: TEdit;
    ipport: TEdit;
    Label13: TLabel;
    TelescopeSelect: TRadioGroup;
    GroupBox1: TGroupBox;
    chkdb: TButton;
    Label1: TLabel;
    dbnamesqlite: TEdit;
    Label7: TLabel;
    EquatorialMount: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TurnsRa: TFloatEdit;
    TurnsDec: TFloatEdit;
    RevertTurnsRa: TCheckBox;
    RevertTurnDec: TCheckBox;
    ManualMountType: TRadioGroup;
    AltAzMount: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    TurnsAz: TFloatEdit;
    TurnsAlt: TFloatEdit;
    RevertTurnsAz: TCheckBox;
    RevertTurnsAlt: TCheckBox;
    PageControl1: TPageControl;
    procedure LanguageListItemClick(Sender: TObject; Index: integer);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);
    procedure ServerCoordSysClick(Sender: TObject);
    procedure TelLimitDecMaxActiveChange(Sender: TObject);
    procedure TelLimitDecMaxChange(Sender: TObject);
    procedure TelLimitDecMinActiveChange(Sender: TObject);
    procedure TelLimitDecMinChange(Sender: TObject);
    procedure TelLimitHaEActiveChange(Sender: TObject);
    procedure TelLimitHaEChange(Sender: TObject);
    procedure TelLimitHaWActiveChange(Sender: TObject);
    procedure TelLimitHaWChange(Sender: TObject);
    procedure UseScalingChange(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure CheckBox7Change(Sender: TObject);
    procedure CheckBox8Change(Sender: TObject);
    procedure CheckBox9Change(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure LinuxCmdChange(Sender: TObject);
    procedure LinuxDesktopBoxChange(Sender: TObject);
    procedure chkdbClick(Sender: TObject);
    procedure UseIPserverClick(Sender: TObject);
    procedure ipaddrChange(Sender: TObject);
    procedure ipportChange(Sender: TObject);
    procedure TelescopeSelectClick(Sender: TObject);
    procedure TurnsRaChange(Sender: TObject);
    procedure TurnsDecChange(Sender: TObject);
    procedure ManualMountTypeClick(Sender: TObject);
    procedure TurnsAzChange(Sender: TObject);
    procedure TurnsAltChange(Sender: TObject);
  private
    { Private declarations }
    FSaveAndRestart: TNotifyEvent;
    FApplyConfig: TNotifyEvent;
    LockChange, LockMsg: boolean;
    procedure ShowSYS;
    procedure ShowServer;
    procedure ShowTelescope;
    procedure ShowLanguage;
  public
    { Public declarations }
    cdb: Tcdcdb;
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
    procedure Init; // FormShow
    procedure Lock; // FormClose
    procedure SetLang;
    property onSaveAndRestart: TNotifyEvent read FSaveAndRestart write FSaveAndRestart;
    property onApplyConfig: TNotifyEvent read FApplyConfig write FApplyConfig;
  end;

implementation

uses u_util;

{$R *.lfm}

procedure Tf_config_system.SetLang;
begin
  Caption := rsGeneral;
  Page1.Caption := rsLanguage2;
  Page2.Caption := rsTelescope;
  Page3.Caption := rsGeneral;
  Page4.Caption := rsServer;
  Page5.Caption := 'SAMP';
  Label153.Caption := rsGeneralSetti;
  SqliteBoxLabel.Caption := rsSqliteDataba;
  Label1.Caption := rsDatabaseFile;
  GroupBoxDir.Caption := rsDirectory;
  Label157.Caption := rsPersonalData;
  chkdb.Caption := rsCheck;
  GroupBoxLinux.Caption := rsDesktopEnvir;
  Label12.Caption := rsURLLaunchCom;
  GroupBox2.Caption := rsScreenResolu;
  UseScaling.Caption := rsAdjustTheWin;
  UseScaling.Hint := rsWarning + crlf + rsChangeToThis;
  LinuxDesktopBox.items[1] := rsOther;
  GroupBox3.Caption := rsTCPIPServer;
  Label54.Caption := rsServerIPInte;
  Label55.Caption := rsServerIPPort;
  UseIPserver.Caption := rsUseTCPIPServ;
  ServerCoordSys.Caption:=rsCooordinateS;
  ServerCoordSys.Items[0]:=rsForceJ2000;
  ServerCoordSys.Items[1]:=rsCurrentChart;
  Label13.Caption := rsTelescopeSet;
  TelescopeManualLabel.Caption := rsManualMount;
  Label7.Caption := rsSetHowTheMou;
  Label3.Caption := rsRightAscensi;
  Label4.Caption := rsDeclination;
  Label5.Caption := rsTurnsHour;
  Label6.Caption := rsTurnsDegree;
  RevertTurnsRa.Caption := rsRevertRAKnob;
  RevertTurnDec.Caption := rsRevertDECKno;
  Label8.Caption := rsAzimuth;
  Label9.Caption := rsAltitude;
  Label10.Caption := rsTurnsDegree;
  Label11.Caption := rsTurnsDegree;
  RevertTurnsAz.Caption := rsRevertAzKnob;
  RevertTurnsAlt.Caption := rsRevertAltKno;
  Label14.Caption := rsLanguageSele;
  ManualMountType.Items[0] := rsEquatorialMo;
  ManualMountType.Items[1] := rsAltAzMount;
  TelescopeSelect.Caption := rsSelectTheTel;
  TelescopeSelect.Items[0] := 'ASCOM, Alpaca, INDI';
  TelescopeSelect.Items[1] := rsManualMount;
  TelescopeLimit.Caption:=rsLineForTeles;
  TelLimitDecMaxActive.Caption:=rsMaximumDecli;
  TelLimitDecMinActive.Caption:=rsMinimumDecli;
  TelLimitHaEActive.Caption:=rsEastHourAngl;
  TelLimitHaWActive.Caption:=rsWestHourAngl;
  label15.Caption := rsVOSAMPSettin;
  label16.Caption := Format(rsSAMPIsAMessa, [crlf]);
  label17.Caption := rsForMoreInfor;
  label18.Caption := URL_IVOASAMP;
  CheckBox1.Caption := rsAskForConfir;
  CheckBox2.Caption := rsAskForConfir2;
  CheckBox3.Caption := rsAskForConfir3;
  CheckBox4.Caption := rsReceiveCoord;
  CheckBox5.Caption := rsReceiveFITSI;
  CheckBox6.Caption := rsReceiveVOTab;
  CheckBox7.Caption := rsTryToAutoCon;
  CheckBox8.Caption := rsKeepTablesOn;
  CheckBox9.Caption := rsKeepImagesOn;
  TelescopeLabel.Caption := 'ASCOM, Alpaca, INDI' + crlf + Format(rsUseTheMenuOr, [rsConnectTeles]);
  SetHelp(self, hlpCfgSys);
end;

constructor Tf_config_system.Create(AOwner: TComponent);
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
  LockMsg := False;
end;

destructor Tf_config_system.Destroy;
begin
  mycsc.Free;
  myccat.Free;
  mycshr.Free;
  mycplot.Free;
  mycmain.Free;
  inherited Destroy;
end;

procedure Tf_config_system.Init;
begin
  LockChange := True;
{$if defined(mswindows) or defined(darwin)}
  GroupBoxLinux.Visible := False;
{$endif}
  ShowLanguage;
  ShowSYS;
  ShowServer;
  ShowTelescope;
  LockChange := False;
end;

procedure Tf_config_system.ShowLanguage;
var
  i: integer;
  f: textfile;
  dir, buf, buf1, buf2: string;
begin
  LanguageList.Clear;
  GetDefaultLanguage(buf1, buf2);
  LanguageList.Items.Add(blank + rsDefault + ' (' + buf1 + ')');
  LanguageList.ItemIndex := 0;
  dir := slash(appdir) + slash('data') + slash('language');
  if not fileexists(dir + 'skychart.lang') then
    writetrace('File ' + dir + 'skychart.lang' + ' not found!');
  try
    Filemode := 0;
    AssignFile(f, dir + 'skychart.lang');
    Reset(f);
    repeat
      Readln(f, buf);
      buf1 := words(buf, '', 1, 1);
      buf2 := CondUTF8Decode(words(buf, '', 2, 1));
      if fileexists(dir + 'skychart.' + buf1 + '.po') then
      begin
        LanguageList.items.Add(buf1 + blank + '-' + blank + buf2);
      end
      else
        writetrace('  file not found: ' + dir + 'skychart.' + buf1 + '.po');
    until EOF(f);
    CloseFile(f);
  except
  end;
  for i := 0 to LanguageList.Items.Count - 1 do
  begin
    LanguageList.Checked[i] := (((cmain.language = '') and (i = 0)) or
      (cmain.language = words(LanguageList.Items[i], '', 1, 1)));
    if LanguageList.Checked[i] then
    begin
      LanguageList.Selected[i] := True;
      LanguageList.TopIndex := i;
    end;
  end;
end;

procedure Tf_config_system.ShowSYS;
begin
  dbnamesqlite.Text := SysToUTF8(cmain.db);
  persdir.Text := SysToUTF8(cmain.persdir);
  UseScaling.Checked := cmain.ScreenScaling;
{$if defined(linux) or defined(freebsd)}
  LinuxDesktopBox.ItemIndex := min(1, LinuxDesktop);
  LinuxCmd.Text := OpenFileCMD;
  if LinuxDesktopBox.ItemIndex < 1 then
    LinuxCmd.Enabled := False;
{$endif}
end;

procedure Tf_config_system.ShowServer;
begin
  ipaddr.Text := cmain.ServerIPaddr;
  ipport.Text := cmain.ServerIPport;
  useipserver.Checked := cmain.autostartserver;
  ServerCoordSys.ItemIndex:=cmain.ServerCoordSys;
  CheckBox1.Checked := cmain.SampConfirmCoord;
  CheckBox2.Checked := cmain.SampConfirmImage;
  CheckBox3.Checked := cmain.SampConfirmTable;
  CheckBox4.Checked := cmain.SampSubscribeCoord;
  CheckBox5.Checked := cmain.SampSubscribeImage;
  CheckBox6.Checked := cmain.SampSubscribeTable;
  CheckBox7.Checked := cmain.SampAutoconnect;
  CheckBox8.Checked := cmain.SampKeepTables;
  CheckBox9.Checked := cmain.SampKeepImages;
  CheckBox1.Enabled := cmain.SampSubscribeCoord;
  CheckBox2.Enabled := cmain.SampSubscribeImage;
  CheckBox9.Enabled := cmain.SampSubscribeImage;
  CheckBox3.Enabled := cmain.SampSubscribeTable;
  CheckBox8.Enabled := cmain.SampSubscribeTable;
end;

procedure Tf_config_system.ShowTelescope;
begin

  TelLimitDecMaxActive.Checked:=csc.TelLimitDecMaxActive;
  TelLimitDecMax.Value:=csc.TelLimitDecMax;
  TelLimitDecMinActive.Checked:=csc.TelLimitDecMinActive;
  TelLimitDecMin.Value:=csc.TelLimitDecMin;
  TelLimitHaEActive.Checked:=csc.TelLimitHaEActive;
  TelLimitHaE.Value:=csc.TelLimitHaE;
  TelLimitHaWActive.Checked:=csc.TelLimitHaWActive;
  TelLimitHaW.Value:=csc.TelLimitHaW;
  TurnsRa.Value := abs(csc.TelescopeTurnsX);
  TurnsDec.Value := abs(csc.TelescopeTurnsY);
  RevertTurnsRa.Checked := csc.TelescopeTurnsX < 0;
  RevertTurnDec.Checked := csc.TelescopeTurnsY < 0;
  TurnsAz.Value := abs(csc.TelescopeTurnsX);
  TurnsAlt.Value := abs(csc.TelescopeTurnsY);
  RevertTurnsAz.Checked := csc.TelescopeTurnsX < 0;
  RevertTurnsAlt.Checked := csc.TelescopeTurnsY < 0;
  ManualMountType.ItemIndex := csc.ManualTelescopeType;
  ManualMountTypeClick(nil);
  if csc.ManualTelescope then
    Telescopeselect.ItemIndex := 1
  else
    Telescopeselect.ItemIndex := 0;
  TelescopeselectClick(self);
end;


procedure Tf_config_system.chkdbClick(Sender: TObject);
var
  msg: string;
begin
  msg := cdb.checkdbconfig(cmain);
  ShowMessage(msg);
end;

procedure Tf_config_system.UseScalingChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if messageDlg(rsWarning + crlf + rsChangeToThis, mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    cmain.ScreenScaling := UseScaling.Checked;
    if Assigned(FSaveAndRestart) then
      FSaveAndRestart(self);
  end
  else
  begin
    LockChange := True;
    UseScaling.Checked := not UseScaling.Checked;
    LockChange := False;
  end;
end;

procedure Tf_config_system.PageControl1Changing(Sender: TObject;
  var AllowChange: boolean);
begin
  if parent is TForm then
    TForm(Parent).ActiveControl := PageControl1;
end;

procedure Tf_config_system.LinuxDesktopBoxChange(Sender: TObject);
begin
  if LockChange then
    exit;
  case LinuxDesktopBox.ItemIndex of
    0:
    begin  // FreeDesktop.org
      LinuxCmd.Text := 'xdg-open';
      LinuxCmd.Enabled := False;
    end;
    1:
    begin  // Other
      LinuxCmd.Enabled := True;
    end;
  end;
  LinuxDesktop := LinuxDesktopBox.ItemIndex;
end;

procedure Tf_config_system.LinuxCmdChange(Sender: TObject);
begin
  if LockChange then
    exit;
  OpenFileCMD := LinuxCmd.Text;
end;

procedure Tf_config_system.Label18Click(Sender: TObject);
begin
  ExecuteFile(Label18.Caption);
end;

procedure Tf_config_system.LanguageListItemClick(Sender: TObject; Index: integer);
var
  i: integer;
begin
  if LockChange then
    exit;
  if LeftStr(LanguageList.Items[Index], 1) = blank then
    cmain.language := ''
  else
    cmain.language := words(LanguageList.Items[Index], '', 1, 1);
  for i := 0 to LanguageList.Items.Count - 1 do
  begin
    LanguageList.Checked[i] := (((cmain.language = '') and (i = 0)) or
      (cmain.language = words(LanguageList.Items[i], '', 1, 1)));
    if LanguageList.Checked[i] then
    begin
      LanguageList.Selected[i] := True;
    end;
  end;
end;

procedure Tf_config_system.Lock;
begin
  LockChange := True;
end;

procedure Tf_config_system.CheckBox1Change(Sender: TObject);
begin
  cmain.SampConfirmCoord := CheckBox1.Checked;
end;

procedure Tf_config_system.CheckBox2Change(Sender: TObject);
begin
  cmain.SampConfirmImage := CheckBox1.Checked;
end;

procedure Tf_config_system.CheckBox3Change(Sender: TObject);
begin
  cmain.SampConfirmTable := CheckBox1.Checked;
end;

procedure Tf_config_system.CheckBox4Change(Sender: TObject);
begin
  cmain.SampSubscribeCoord := CheckBox4.Checked;
  CheckBox1.Enabled := cmain.SampSubscribeCoord;
end;

procedure Tf_config_system.CheckBox5Change(Sender: TObject);
begin
  cmain.SampSubscribeImage := CheckBox5.Checked;
  CheckBox2.Enabled := cmain.SampSubscribeImage;
  CheckBox9.Enabled := cmain.SampSubscribeImage;
end;

procedure Tf_config_system.CheckBox6Change(Sender: TObject);
begin
  cmain.SampSubscribeTable := CheckBox6.Checked;
  CheckBox3.Enabled := cmain.SampSubscribeTable;
  CheckBox8.Enabled := cmain.SampSubscribeTable;
end;

procedure Tf_config_system.CheckBox7Change(Sender: TObject);
begin
  cmain.SampAutoconnect := CheckBox7.Checked;
end;

procedure Tf_config_system.CheckBox8Change(Sender: TObject);
begin
  cmain.SampKeepTables := CheckBox8.Checked;
end;

procedure Tf_config_system.CheckBox9Change(Sender: TObject);
begin
  cmain.SampKeepImages := CheckBox9.Checked;
end;

procedure Tf_config_system.UseIPserverClick(Sender: TObject);
begin
  cmain.AutostartServer := UseIPserver.Checked;
end;

procedure Tf_config_system.ipaddrChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.ServerIPaddr := ipaddr.Text;
end;

procedure Tf_config_system.ipportChange(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.ServerIPport := ipport.Text;
end;

procedure Tf_config_system.ServerCoordSysClick(Sender: TObject);
begin
  if LockChange then
    exit;
  cmain.ServerCoordSys := ServerCoordSys.ItemIndex;
end;

procedure Tf_config_system.TelLimitDecMaxActiveChange(Sender: TObject);
begin
   csc.TelLimitDecMaxActive:=TelLimitDecMaxActive.Checked;
end;

procedure Tf_config_system.TelLimitDecMaxChange(Sender: TObject);
begin
  csc.TelLimitDecMax:=TelLimitDecMax.Value;
end;

procedure Tf_config_system.TelLimitDecMinActiveChange(Sender: TObject);
begin
  csc.TelLimitDecMinActive:=TelLimitDecMinActive.Checked;
end;

procedure Tf_config_system.TelLimitDecMinChange(Sender: TObject);
begin
   csc.TelLimitDecMin:=TelLimitDecMin.Value;
end;

procedure Tf_config_system.TelLimitHaEActiveChange(Sender: TObject);
begin
  csc.TelLimitHaEActive:=TelLimitHaEActive.Checked;
end;

procedure Tf_config_system.TelLimitHaEChange(Sender: TObject);
begin
  csc.TelLimitHaE:=TelLimitHaE.Value;
end;

procedure Tf_config_system.TelLimitHaWActiveChange(Sender: TObject);
begin
  csc.TelLimitHaWActive:=TelLimitHaWActive.Checked;
end;

procedure Tf_config_system.TelLimitHaWChange(Sender: TObject);
begin
  csc.TelLimitHaW:=TelLimitHaW.Value;
end;

procedure Tf_config_system.TelescopeSelectClick(Sender: TObject);
begin
  csc.ManualTelescope := Telescopeselect.ItemIndex = 1;
  if csc.ManualTelescope then
    PageControl2.ActivePage := TabSheet2
  else
    PageControl2.ActivePage := TabSheet1;
end;

procedure Tf_config_system.TurnsRaChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if RevertTurnsRa.Checked then
    csc.TelescopeTurnsX := -TurnsRa.Value
  else
    csc.TelescopeTurnsX := TurnsRa.Value;
end;

procedure Tf_config_system.TurnsDecChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if RevertTurnDec.Checked then
    csc.TelescopeTurnsY := -TurnsDec.Value
  else
    csc.TelescopeTurnsY := TurnsDec.Value;
end;

procedure Tf_config_system.TurnsAzChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if RevertTurnsAz.Checked then
    csc.TelescopeTurnsX := -TurnsAz.Value
  else
    csc.TelescopeTurnsX := TurnsAz.Value;
end;

procedure Tf_config_system.TurnsAltChange(Sender: TObject);
begin
  if LockChange then
    exit;
  if RevertTurnsAlt.Checked then
    csc.TelescopeTurnsY := -TurnsAlt.Value
  else
    csc.TelescopeTurnsY := TurnsAlt.Value;
end;

procedure Tf_config_system.ManualMountTypeClick(Sender: TObject);
begin
  csc.ManualTelescopeType := ManualMountType.ItemIndex;
  case csc.ManualTelescopeType of
    0:
    begin
      PageControl3.ActivePage := TabSheet5;
      TurnsDecChange(Sender);
      TurnsRaChange(Sender);
    end;
    1:
    begin
      PageControl3.ActivePage := TabSheet6;
      TurnsAzChange(Sender);
      TurnsAltChange(Sender);
    end;
  end;
end;

end.
