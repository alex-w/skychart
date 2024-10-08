unit pu_config_display;

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
  u_help, u_translation, u_constant, u_util, fu_config_display, UScaleDPI,
  LCLIntf, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Spin, Buttons, StdCtrls, ExtCtrls, ComCtrls, LResources,
  EditBtn, LCLType, enhedits, LazHelpHTML_fix;

type

  { Tf_configdisplay }

  Tf_configdisplay = class(TForm)
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Panel1: TPanel;
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    f_config_display1: Tf_config_display;
    procedure SetLang;
  end;

implementation

{$R *.lfm}

procedure Tf_configdisplay.SetLang;
begin
  Caption := rsDisplay;
  Button2.Caption := rsOK;
  Button4.Caption := rsApply;
  Button5.Caption := rsCancel;
  Button6.Caption := rsHelp;
  SetHelp(self, hlpCfgDispl);
end;

procedure Tf_configdisplay.FormCreate(Sender: TObject);
begin
  f_config_display1:= Tf_config_display.Create(Self);
  f_config_display1.parent:=Self ;
  f_config_display1.Align:=alClient;
  ScaleDPI(Self);
  SetLang;
end;

procedure Tf_configdisplay.FormShow(Sender: TObject);
begin
  f_config_display1.init;
end;

procedure Tf_configdisplay.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  f_config_display1.lock;
end;

procedure Tf_configdisplay.Button4Click(Sender: TObject);
begin
  if assigned(f_config_display1.onApplyConfig) then
    f_config_display1.onApplyConfig(f_config_display1);
end;

procedure Tf_configdisplay.Button6Click(Sender: TObject);
begin
  ShowHelp;
end;

end.
