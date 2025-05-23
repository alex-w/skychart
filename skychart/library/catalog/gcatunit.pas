unit gcatunit;
{
Copyright (C) 2000 Patrick Chevalley

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
{$mode objfpc}{$H+}

interface

uses
  skylibcat, sysutils, Classes;

const
 rtStar = 1;  rtVar  = 2; rtDbl  = 3; rtNeb  = 4; rtlin   = 5;
 ctBin = 1; ctText = 2; ctTab =3;
 vsId=1; vsMagv=2; vsB_v=3; vsMagb=4; vsMagr=5; vsSp=6; vsPmra=7; vsPmdec=8; vsEpoch=9; vsPx=10; vsComment=11; vsGreekSymbol=12;
 vvId=1; vvMagmax=2; vvMagmin=3; vvPeriod=4; vvVartype=5; vvMaxepoch=6; vvRisetime=7;  vvSp=8; vvMagcode=9; vvComment=10;
 vdId=1; vdMag1=2; vdMag2=3; vdSep=4; vdPa=5; vdEpoch=6; vdCompname=7; vdSp1=8; vdSp2=9; vdComment=10;
 vnId=1; vnNebtype=2; vnMag=3; vnSbr=4; vnDim1=5; vnDim2=6; vnNebunit=7; vnPa=8; vnRv=9; vnMorph=10; vnComment=11;vnColor=12;
 vlId=1; vlLinecolor=2; vlLineoperation=3; vlLinewidth=4; vlLinetype=5; vlComment=6;
 lOffset=2;
 lOffsetStr=15;
 lOffsetNum=25;

{ deepsky2000 object type }
const TypeDS : array[1..30] of integer = (1,2,3,5,4,114,8,-1,115,-1,101,102,-1,104,105,106,107,108,109,110,111,112,113,-1,-1,-1,-1,-1,-1,-1);
// -1..8=drawneb ; 100+ipla = planet ; 112=ast ; 113=com; 114=var; 115=star

Type
TVstar = array[1..12] of boolean;
TVvar  = array[1..10] of boolean;
TVdbl  = array[1..10] of boolean;
TVneb  = array[1..12] of boolean;
TVlin  = array[1..6] of boolean;
TValid = array[1..10] of boolean;
Tlabellst = array[1..35] of shortstring;
TSname = array[0..3] of char;
Tstar =   packed record
          magv,b_v,magb,magr,pmra,pmdec,epoch,px : double;
          id,sp,greeksymbol : string;
          comment: string;
          valid : TVstar;
          end;
Tvariable=packed record
          magmax,magmin,period,maxepoch,risetime : double;
          id,vartype,sp,magcode,comment : string;
          valid : TVvar;
          end;
Tdouble = packed record
          mag1,mag2,sep,pa,epoch : double;
          id,compname,sp1,sp2,comment : string;
          valid : TVdbl;
          end;
Tneb    = packed record
          mag,sbr,dim1,dim2,pa,rv : double;
          nebunit : Smallint;
          nebtype : ShortInt;
          id,morph : string;
          comment : string;
          messierobject : boolean;
          color: integer;
          valid : TVneb;
          end;
Toutlines = packed record
          linecolor : LongWord;
          lineoperation,linewidth,linetype : byte;
          id,comment : string;
          valid : TVlin;
          end;
TCatOption = packed record
          ShortName: TSname;
          LongName : ShortString;
          rectype  : integer;
          Equinox  : double;
          EquinoxJD: double;
          Epoch    : double;
          MagMax   : double;
          Size     : Integer;
          Units    : Integer;
          ObjType  : Integer;
          LogSize  : Integer;
          UsePrefix: byte;
          UseColor : byte;
          altname  : Tvalid;
          altprefix: Tvalid;
          flabel   : Tlabellst;
          Amplitudeflag: Integer;
          StarColor: integer;
          end;
GCatrec = packed record
          ra,dec   : double ;
          star     : Tstar;
          variable : Tvariable;
          double   : Tdouble;
          neb      : Tneb;
          outlines : Toutlines;
          str      : array[1..10] of string;
          num      : array[1..10] of double;
          vstr,vnum: Tvalid;
          options  : TCatoption;
          end;
TCatHeader = packed record
         hdrl     : Longint;
         version  : array[0..7] of char;
         ShortName: TSname;
         LongName : array[0..49] of char;
         reclen   : Longint;
         FileNum  : Longint;
         Equinox  : double;
         Epoch    : double;
         MagMax   : double;
         Size     : Longint;
         Units    : Longint;
         ObjType  : Longint;
         LogSize  : Longint;
         UsePrefix: byte;
         IxKeylen : byte;
         AltName  : array[1..10] of byte;
         AltPrefix: array[1..10] of Longint;
         IdFormat : Longint;
         HighPrecPM:LongBool;
         IdPrefix : LongBool;
         StarType : LongInt;
         Spare1   : array[1..6] of Longint;
         fpos     : array[1..40] of Longint;
         Spare2   : array[1..15] of Longint;
         flen     : array[1..40] of Longint;
         Spare3   : array[1..15] of Longint;
         flabel   : Tlabellst;
         TxtFileName: array[0..39] of char;
         RAmode   : byte;
         DECmode  : byte;
         Spare41  : array[0..6] of char;
         Spare4   : array[1..19,0..8] of char;
         end;
TFileHeader = packed record
         hdrl     : Longint;
         version  : array[0..7] of char;
         ShortName: TSname;
         LongName : array[0..49] of char;
         reclen   : Longint;
         FileNum  : Longint;
         Equinox  : double;
         Epoch    : double;
         MagMax   : double;
         Size     : Longint;
         Units    : Longint;
         ObjType  : Longint;
         LogSize  : Longint;
         UsePrefix: byte;
         IxKeylen : byte;
         AltName  : array[1..10] of byte;
         AltPrefix: array[1..10] of Longint;
         IdFormat : Longint;
         HighPrecPM:LongBool;
         IdPrefix : LongBool;
         StarType : LongInt;
         Spare1   : array[1..6] of Longint;
         fpos     : array[1..40] of Longint;
         Spare2   : array[1..15] of Longint;
         flen     : array[1..40] of Longint;
         Spare3   : array[1..15] of Longint;
         flabel   : array[1..35,0..10] of char;
         TxtFileName: array[0..39] of char;
         RAmode   : byte;
         DECmode  : byte;
         Spare41  : array[0..6] of char;
         Spare4   : array[1..19,0..8] of char;
         end;
TCatHdrInfo = record
         neblst: array[1..15] of shortstring;   // !! keep shortstring here !!
         nebtype: array[1..15] of Longint;
         nebunit: array[1..3] of shortstring;
         nebunits: array[1..3] of Longint;
         Linelst: array[1..4] of shortstring;
         LineOp: array[1..4] of Longint;
         Colorlst: array[1..10] of shortstring;
         Color: array[1..10] of Cardinal;
         calc : array[0..40,1..2] of double;
         caturl : shortstring;
         end;

type Tstarcache = packed record
         star: Tstar;
         str      : array[1..10] of string;
         num      : array[1..10] of double;
         ra,de: double;
end;
type Tlinecache = record
         outlines : Toutlines;
         ra,de: double;
end;
type TcacheOption = record
     baserec: gcatrec;
     header: Tcatheader;
end;
const CacheInc=1000;
      MaxZone=50;
      MaxCache=10;

procedure SetGCatpath(path,catshortname : string);
procedure GetGCatInfo(var h : TCatHeader; var info:TCatHdrInfo; var version : integer; var filter,ok : boolean);
Procedure OpenGCat(ar1,ar2,de1,de2: double ; var ok : boolean);
Procedure OpenGCatwin(var ok : boolean);
Procedure ReadGCat(var lin : GCatrec; var ok : boolean; MultiRegion: boolean=true);
Procedure NextGCat( var ok : boolean);
procedure CloseGCat ;
procedure CleanCache;
procedure GetEmptyRec(var lin : GCatrec);
// for use by catgen and search index only:
Function ReadGCatHeader : boolean;
Procedure OpenGCatfile(nomfich : string; var ok : boolean);
procedure OpenGCatFileNum(fnum:integer; var ok:boolean);
Procedure ReadGCatRec(recnum:integer; var lin : GCatrec; var ok : boolean);

var gcatquick: boolean = false;

implementation

var
   GCatpath : string ='';
   catheader : Tcatheader;
   catinfo : TCatHdrInfo;
   emptyrec : gcatrec;
   datarec : array [0..4096] of byte;
   dataline : string;
   mem: TMemoryStream;
   ft: textfile;
   hemis : char;
   zone,Sm,nSM,catversion,cattype : integer;
   curSM : integer;
   SMname,NomFich,Catname : string;
   hemislst : array[1..9537] of char;
   zonelst,SMlst : array[1..9537] of integer;
   FileBIsOpen : Boolean = false;
   FileTIsOpen : Boolean = false;
   onCache : boolean;
   CurCache, CurCacheRec: integer;
   CacheIndex: array[0..maxcache] of string;
   CacheOption: array[0..maxcache] of TcacheOption;
   CacheZone: array[0..maxcache,0..maxzone] of integer;
   CacheStar: array[0..maxcache,0..maxzone] of array of Tstarcache;
   CacheLine: array[0..maxcache,0..maxzone] of array of Tlinecache;

Procedure InitRec;
var n : integer;
begin
  emptyrec.options.rectype:=catversion;
  emptyrec.options.Equinox:=catheader.Equinox;
  if catheader.Equinox=2000 then emptyrec.options.EquinoxJD:=jd2000
  else if catheader.Equinox=1950 then emptyrec.options.EquinoxJD:=jd1950
  else emptyrec.options.EquinoxJD:=jd(trunc(catheader.Equinox),1,0,0);
  JDCatalog:=emptyrec.options.EquinoxJD;
  emptyrec.options.Epoch:=catheader.Epoch;
  emptyrec.options.MagMax:=catheader.MagMax;
  emptyrec.options.Size:=catheader.Size;
  emptyrec.options.Units:=catheader.Units;
  emptyrec.options.ObjType:=catheader.ObjType;
  emptyrec.options.LogSize:=catheader.LogSize;
  emptyrec.options.UsePrefix:=catheader.UsePrefix;
  emptyrec.options.Amplitudeflag:=-1;
  emptyrec.options.StarColor:=-1;
  for n:=1 to 10 do emptyrec.options.altname[n]:=(catheader.altname[n]=1);
  for n:=1 to 10 do emptyrec.options.altprefix[n]:=(catheader.AltPrefix[n]=1);
  emptyrec.options.flabel:=catheader.flabel;
  emptyrec.options.ShortName:=catheader.shortname;
  emptyrec.options.LongName:=catheader.LongName;
  case catversion of
  rtstar : begin  // Star 1
      if catheader.flen[3]>0 then emptyrec.star.valid[vsId]:=true;
      if catheader.flen[4]>0 then emptyrec.star.valid[vsMagV]:=true;
      if catheader.flen[5]>0 then emptyrec.star.valid[vsB_V]:=true;
      if catheader.flen[6]>0 then emptyrec.star.valid[vsMagB]:=true;
      if catheader.flen[7]>0 then emptyrec.star.valid[vsMagR]:=true;
      if catheader.flen[8]>0 then emptyrec.star.valid[vsSp]:=true;
      if catheader.flen[9]>0 then emptyrec.star.valid[vsPmra]:=true;
      if catheader.flen[10]>0 then emptyrec.star.valid[vsPmdec]:=true;
      if catheader.flen[11]>0 then emptyrec.star.valid[vsEpoch]:=true;
      if catheader.flen[12]>0 then emptyrec.star.valid[vsPx]:=true;
      if catheader.flen[13]>0 then emptyrec.star.valid[vsComment]:=true;
      end;
  rtvar : begin  // variables stars 1
      if catheader.flen[3]>0 then emptyrec.variable.valid[vvId]:=true;
      if catheader.flen[4]>0 then emptyrec.variable.valid[vvMagmax]:=true;
      if catheader.flen[5]>0 then emptyrec.variable.valid[vvMagmin]:=true;
      if catheader.flen[6]>0 then emptyrec.variable.valid[vvPeriod]:=true;
      if catheader.flen[7]>0 then emptyrec.variable.valid[vvVartype]:=true;
      if catheader.flen[8]>0 then emptyrec.variable.valid[vvMaxepoch]:=true;
      if catheader.flen[9]>0 then emptyrec.variable.valid[vvRisetime]:=true;
      if catheader.flen[10]>0 then emptyrec.variable.valid[vvSp]:=true;
      if catheader.flen[11]>0 then emptyrec.variable.valid[vvMagcode]:=true;
      if catheader.flen[12]>0 then emptyrec.variable.valid[vvComment]:=true;
      for n:=1 to 10 do if trim(catheader.flabel[lOffsetStr+n])='f_min' then emptyrec.options.Amplitudeflag:=n;
      end;
  rtdbl : begin  // doubles stars 1
      if catheader.flen[3]>0 then emptyrec.double.valid[vdId]:=true;
      if catheader.flen[4]>0 then emptyrec.double.valid[vdMag1]:=true;
      if catheader.flen[5]>0 then emptyrec.double.valid[vdMag2]:=true;
      if catheader.flen[6]>0 then emptyrec.double.valid[vdSep]:=true;
      if catheader.flen[7]>0 then emptyrec.double.valid[vdPa]:=true;
      if catheader.flen[8]>0 then emptyrec.double.valid[vdEpoch]:=true;
      if catheader.flen[9]>0 then emptyrec.double.valid[vdCompname]:=true;
      if catheader.flen[10]>0 then emptyrec.double.valid[vdSp1]:=true;
      if catheader.flen[11]>0 then emptyrec.double.valid[vdSp2]:=true;
      if catheader.flen[12]>0 then emptyrec.double.valid[vdComment]:=true;
      end;
  rtneb : begin  // nebulae 1
      if catheader.flen[3]>0 then emptyrec.neb.valid[vnId]:=true;
      if catheader.flen[4]>0 then emptyrec.neb.valid[vnNebtype]:=true;
      if catheader.flen[5]>0 then emptyrec.neb.valid[vnMag]:=true;
      if catheader.flen[6]>0 then emptyrec.neb.valid[vnSbr]:=true;
      if catheader.flen[7]>0 then emptyrec.neb.valid[vnDim1]:=true;
      if catheader.flen[8]>0 then emptyrec.neb.valid[vnDim2]:=true;
      if catheader.flen[9]>0 then emptyrec.neb.valid[vnNebunit]:=true;
      if catheader.flen[10]>0 then emptyrec.neb.valid[vnPa]:=true;
      if catheader.flen[11]>0 then emptyrec.neb.valid[vnRv]:=true;
      if catheader.flen[12]>0 then emptyrec.neb.valid[vnMorph]:=true;
      if catheader.flen[13]>0 then emptyrec.neb.valid[vnComment]:=true;
      if catheader.flen[14]>0 then emptyrec.neb.valid[vnColor]:=true;
      end;
  rtlin : begin  // outlines
      if catheader.flen[3]>0 then emptyrec.outlines.valid[vlId]:=true;
      if catheader.flen[4]>0 then emptyrec.outlines.valid[vlLineoperation]:=true;
      if catheader.flen[5]>0 then emptyrec.outlines.valid[vlLinewidth]:=true;
      if catheader.flen[6]>0 then emptyrec.outlines.valid[vlLinecolor]:=true;
      if catheader.flen[7]>0 then emptyrec.outlines.valid[vlLinetype]:=true;
      if catheader.flen[8]>0 then emptyrec.outlines.valid[vlComment]:=true;
      end;
  end;
  if catheader.flen[16]>0 then emptyrec.vstr[1]:=true;
  if catheader.flen[17]>0 then emptyrec.vstr[2]:=true;
  if catheader.flen[18]>0 then emptyrec.vstr[3]:=true;
  if catheader.flen[19]>0 then emptyrec.vstr[4]:=true;
  if catheader.flen[20]>0 then emptyrec.vstr[5]:=true;
  if catheader.flen[21]>0 then emptyrec.vstr[6]:=true;
  if catheader.flen[22]>0 then emptyrec.vstr[7]:=true;
  if catheader.flen[23]>0 then emptyrec.vstr[8]:=true;
  if catheader.flen[24]>0 then emptyrec.vstr[9]:=true;
  if catheader.flen[25]>0 then emptyrec.vstr[10]:=true;
  if catheader.flen[26]>0 then emptyrec.vnum[1]:=true;
  if catheader.flen[27]>0 then emptyrec.vnum[2]:=true;
  if catheader.flen[28]>0 then emptyrec.vnum[3]:=true;
  if catheader.flen[29]>0 then emptyrec.vnum[4]:=true;
  if catheader.flen[30]>0 then emptyrec.vnum[5]:=true;
  if catheader.flen[31]>0 then emptyrec.vnum[6]:=true;
  if catheader.flen[32]>0 then emptyrec.vnum[7]:=true;
  if catheader.flen[33]>0 then emptyrec.vnum[8]:=true;
  if catheader.flen[34]>0 then emptyrec.vnum[9]:=true;
  if catheader.flen[35]>0 then emptyrec.vnum[10]:=true;
end;

procedure SetGCatpath(path,catshortname : string);
begin
GCatpath:=noslash(path);
CatName:=trim(catshortname);
end;

function GetCache:boolean;
var i: integer;
begin
result:=false;
CurCache:=-1;
for i:=0 to MaxCache-1 do begin
  if CacheIndex[i]=slash(GCatpath)+Catname then begin
     CurCache:=i;
     result:=true;
     break;
  end;
end;
end;

function NewCache:boolean;
var i,n: integer;
begin
result:=false;
if (cattype=ctBin)and((catversion=rtStar)or(catversion=rtLin))and(catheader.filenum<=50) //  binary, star or line, 50 zones
then begin
    n:=-1;
    for i:=0 to MaxCache-1 do begin
      if CacheIndex[i]='' then begin
        n:=i;
        break;
      end;
    end;
    if n>=0 then begin
      CacheIndex[n]:=slash(GCatpath)+Catname;
      for i:=0 to MaxZone-1 do CacheZone[n,i]:=0;
      CurCache:=n;
      result:=true;
    end;
end;
end;

Procedure DeleteCache;
var i,j: integer;
begin
onCache:=false;
case catversion of
rtStar: begin
          for i:=0 to MaxCache-1 do begin
            if CacheIndex[i]=slash(GCatpath)+Catname then begin
               CacheIndex[i]:='';
               for j:=0 to MaxZone-1 do begin
                  CacheZone[i,j]:=0;
                  SetLength(CacheStar[i,j],0);
               end;
               break;
            end;
          end;
        end;
rtlin: begin
          for i:=0 to MaxCache-1 do begin
            if CacheIndex[i]=slash(GCatpath)+Catname then begin
               CacheIndex[i]:='';
               for j:=0 to MaxZone-1 do begin
                  CacheZone[i,j]:=0;
                  SetLength(CacheLine[i,j],0);
               end;
               break;
            end;
          end;
        end;
end;
end;

procedure CleanCache;
var i,j:integer;
begin
for i:=0 to MaxCache-1 do begin
   CacheIndex[i]:='';
   for j:=0 to MaxZone-1 do begin
      CacheZone[i,j]:=0;
      SetLength(CacheStar[i,j],0);
      SetLength(CacheLine[i,j],0);
   end;
end;
end;

Function ReadHeaderFile: boolean;
var n : integer;
    buf: string;
    fh : file;
    hdr: TFileHeader;
begin
try
fillchar(EmptyRec,sizeof(GcatRec),0);
if fileexists(Gcatpath+slashchar+catname+'.hdr') then begin
  filemode:=0;
  assignfile(fh,Gcatpath+slashchar+catname+'.hdr');
  reset(fh,1);
  blockread(fh,hdr,sizeof(hdr),n);
  result:=(n=sizeof(hdr))and(n=hdr.hdrl);
  closefile(fh);
  catheader.hdrl:=hdr.hdrl;
  catheader.version:=hdr.version;
  catheader.ShortName:=hdr.ShortName;
  catheader.LongName:=hdr.LongName;
  catheader.reclen:=hdr.reclen;
  catheader.FileNum:=hdr.FileNum;
  catheader.Equinox:=hdr.Equinox;
  catheader.Epoch:=hdr.Epoch;
  catheader.MagMax:=hdr.MagMax;
  catheader.Size:=hdr.Size;
  catheader.Units:=hdr.Units;
  catheader.ObjType:=hdr.ObjType;
  catheader.StarType:=hdr.StarType;
  catheader.LogSize:=hdr.LogSize;
  catheader.UsePrefix:=hdr.UsePrefix;
  catheader.IxKeylen:=hdr.IxKeylen;
  catheader.AltName:=hdr.AltName;
  catheader.AltPrefix:=hdr.AltPrefix;
  catheader.IdFormat:=hdr.IdFormat;
  catheader.HighPrecPM:=hdr.HighPrecPM;
  catheader.IdPrefix:=hdr.IdPrefix;
  catheader.Spare1:=hdr.Spare1;
  catheader.fpos:=hdr.fpos;
  catheader.Spare2:=hdr.Spare2;
  catheader.flen:=hdr.flen;
  catheader.Spare3:=hdr.Spare3;
  for n:=1 to 35 do
      catheader.flabel[n]:=hdr.flabel[n]+'     ';
  catheader.TxtFileName:=hdr.TxtFileName;
  catheader.RAmode:=hdr.RAmode;
  catheader.DECmode:=hdr.DECmode;
  catheader.Spare41:=hdr.Spare41;
  catheader.Spare4:=hdr.Spare4;
  buf:=copy(catheader.version,1,7);
  if buf='CDCSTAR' then catversion:=rtStar;
  if buf='CDCVAR ' then catversion:=rtVar;
  if buf='CDCDBL ' then catversion:=rtDbl;
  if buf='CDCNEB ' then catversion:=rtNeb;
  if buf='CDCLINE' then catversion:=rtLin;
  buf:=copy(catheader.version,8,1);
  cattype:=strtointdef(buf,0);
end
else result:=false;
except
  result:=false;
end;
end;

Function ReadCatHeader : boolean;
var buf: string;
    n : integer;
    fh : file;
begin
 result:=false;
 onCache:=GetCache;
 if onCache then begin
    catheader:=CacheOption[CurCache].header;
    emptyrec:=CacheOption[CurCache].baserec;
    result:=true;
 end else begin
    result:=ReadHeaderFile;
    if result then begin
      InitRec;
      onCache:=NewCache;
      if onCache then begin
         CacheOption[CurCache].header:=catheader;
         CacheOption[CurCache].baserec:=emptyrec;
      end;
    end
    else begin
      raise exception.Create('Wrong '+catname+' header file, or cannot read the file.');
      exit;
    end;
  end;
 buf:=copy(catheader.version,1,7);
 if buf='CDCSTAR' then catversion:=rtStar;
 if buf='CDCVAR ' then catversion:=rtVar;
 if buf='CDCDBL ' then catversion:=rtDbl;
 if buf='CDCNEB ' then catversion:=rtNeb;
 if buf='CDCLINE' then catversion:=rtLin;
 buf:=copy(catheader.version,8,1);
 cattype:=strtointdef(buf,0);
 fillchar(catinfo,sizeof(catinfo),0);
 if cattype=ctText then begin
    if fileexists(Gcatpath+slashchar+catname+'.info2') then begin
       filemode:=0;
       assignfile(fh,Gcatpath+slashchar+catname+'.info2');
       reset(fh,1);
       blockread(fh,catinfo,sizeof(catinfo),n);
       result:=result and (n>0);
       closefile(fh);
    end;
 end;
end;

procedure GetGCatInfo(var h : TCatHeader; var info:TCatHdrInfo; var version : integer; var filter,ok : boolean);
begin
try
ok:=ReadCatheader;
h:=catheader;
version:=catversion;
info:=catinfo;
//?? some star catalog not sorted by mag or missing mag ??
// filter mean open next catalog file if the read mag if fainter than limit
// otherwise it finish to read the file.
// the change 1365 that add this restriction: http://skychart.sourceforge.net/websvn/comp.php?repname=Skychart&compare[]=%2Ftrunk@1364&compare[]=%2Ftrunk@1365
// rollback for now :
//filter:=(cattype=1)and(catversion<>rtstar);
filter:=(cattype=ctBin);
except
  ok:=false;
end;
end;

Function GetRecCard(p: integer):cardinal ;
begin
  move(datarec[catheader.fpos[p]-1],result,catheader.flen[p]);
end;

Function GetRecQWord(p: integer):QWord ;
begin
  move(datarec[catheader.fpos[p]-1],result,catheader.flen[p]);
end;

Function GetRecString(p: integer):string ;
begin
  setlength(result,catheader.flen[p]);
  move(datarec[catheader.fpos[p]-1],result[1],catheader.flen[p]);
end;

Function GetRecSmallInt(p: integer):smallint ;
begin
  move(datarec[catheader.fpos[p]-1],result,catheader.flen[p]);
end;

Function GetRecByte(p: integer):byte ;
begin
  move(datarec[catheader.fpos[p]-1],result,catheader.flen[p]);
end;

Function GetRecSingle(p: integer):single ;
begin
  move(datarec[catheader.fpos[p]-1],result,catheader.flen[p]);
end;

Function GetFloat2(p : integer; default :double) : double ;
var code : integer;
begin
val(trim(copy(dataline,catheader.fpos[p],catheader.flen[p])),result,code);
if code<>0 then result:=default
           else result:=catinfo.calc[p,1]*result+catinfo.calc[p,2];
end;

Function GetInt2(p : integer) : Integer;
var code : integer;
begin
val(trim(copy(dataline,catheader.fpos[p],catheader.flen[p])),result,code);
if code<>0 then result:=0;
end;

Function GetString2(p : integer) : string;
begin
result:=copy(dataline,catheader.fpos[p],catheader.flen[p]);
end;

Function GetNebType2(p : integer) : integer;
var i : integer;
    buf1,buf:string;
begin
buf1:=trim(copy(dataline,catheader.fpos[p],catheader.flen[p]));
if buf1='' then result:=0
else begin
  result:=-99;
  buf:=buf1+',';
  for i:=1 to 15 do begin
    if pos(buf,catinfo.neblst[i])>0 then begin
       result:=catinfo.nebtype[i];
       break;
    end;
  end;
  if result=-99 then begin
    result:=StrToIntDef(buf1,0);
  end;
end;
end;

Function GetNebUnit2(p : integer) : integer;
var i : integer;
    buf:string;
begin
buf:=trim(copy(dataline,catheader.fpos[p],catheader.flen[p]));
if buf='' then result:=60
else begin
result:=60;
buf:=buf+',';
for i:=1 to 3 do begin
  if pos(buf,catinfo.nebunit[i])>0 then begin
     result:=catinfo.nebunits[i];
     break;
  end;
end;
end;
end;

Function GetLineOp2(p : integer) : Smallint;
var i : integer;
    buf:string;
begin
buf:=trim(copy(dataline,catheader.fpos[p],catheader.flen[p]));
if buf='' then buf:=' ';
result:=-1;
buf:=buf+',';
for i:=1 to 4 do begin
  if pos(buf,catinfo.Linelst[i])>0 then begin
     result:=catinfo.LineOp[i];
     break;
  end;
end;
end;

Function Getcolor2(p : integer) : Cardinal;
var i : integer;
    buf:string;
begin
buf:=trim(copy(dataline,catheader.fpos[p],catheader.flen[p]));
if buf='' then buf:=' ';
result:=$FFFFFF;
buf:=buf+',';
for i:=1 to 10 do begin
  if pos(buf,catinfo.Colorlst[i])>0 then begin
     result:=catinfo.Color[i];
     break;
  end;
end;
end;

Procedure CloseRegion;
begin
{$I-}
try
if FileBIsOpen then begin
  FileBIsOpen:=false;
  mem.free;
end;
if FileTIsOpen then begin
  FileTIsOpen:=false;
  closefile(ft);
end;
except
end;
{$I+}
end;

Procedure Openfile(nomfich : string; var ok : boolean);
begin
ok:=false;
if not FileExists(nomfich) then begin ; ok:=false ; exit; end;
FileMode:=0;
if cattype=ctBin then begin
   try
   mem:=TMemoryStream.Create;
   mem.LoadFromFile(nomfich);
   mem.Position:=0;
   FileBIsOpen:=true;
   ok:=true;
   if mem.Size=0 then NextGCat(ok);
   except
     ok:=false;            // catgen running?
     FileBIsOpen:=false;
   end;
end else if cattype=ctText then begin
   try
   AssignFile(ft,nomfich);
   FileTIsOpen:=true;
   reset(ft);
   ok:=true;
   except
     ok:=false;            // file locked by external application?
     FileTIsOpen:=false;
   end;
end;
end;

Procedure Fillcache;
var lin : GCatrec;
    ok : boolean;
    n: integer;
begin
if onCache and (CacheZone[CurCache,sm]=0) then begin
 n:=-1; ok:=false;
 repeat
   ReadGCat(lin,ok,false);
   if ok then case catversion of
   rtStar: begin
           inc(n);
           if n>=Length(CacheStar[CurCache,SM]) then begin
             SetLength(CacheStar[CurCache,SM],n+CacheInc);
           end;
           CacheStar[CurCache,SM,n].star:=lin.star;
           CacheStar[CurCache,SM,n].str:=lin.str;
           CacheStar[CurCache,SM,n].num:=lin.num;
           CacheStar[CurCache,SM,n].ra:=lin.ra;
           CacheStar[CurCache,SM,n].de:=lin.dec;
           end;
   rtlin: begin
           inc(n);
           if n>=Length(CacheLine[CurCache,SM]) then begin
             SetLength(CacheLine[CurCache,SM],n+CacheInc);
           end;
           CacheLine[CurCache,SM,n].outlines:=lin.outlines;
           CacheLine[CurCache,SM,n].ra:=lin.ra;
           CacheLine[CurCache,SM,n].de:=lin.dec;
           end;
   end;
 until not ok;
 case catversion of
   rtStar: SetLength(CacheStar[CurCache,SM],n+1);
   rtlin:  SetLength(CacheLine[CurCache,SM],n+1);
 end;
 CacheZone[CurCache,sm]:=n;
 mem.Position:=0;
end;
end;

Procedure OpenRegion(hemis : char ;zone,S : integer ; var ok:boolean);
var nomreg,nomzone :string;
begin
str(S:4,nomreg);
str(abs(zone):4,nomzone);
if cattype=ctBin then begin
    case catheader.filenum of
      1      : nomfich:=GCatpath+slashchar+catname+'.dat';
      50     : nomfich:=GCatpath+slashchar+catname+padzeros(nomreg,2)+'.dat';
      184    : nomfich:=GCatpath+slashchar+catname+padzeros(nomreg,3)+'.dat';
      732    : nomfich:=GCatpath+slashchar+hemis+padzeros(nomzone,4)+slashchar+catname+padzeros(nomreg,3)+'.dat';
      9537   : nomfich:=GCatpath+slashchar+hemis+padzeros(nomzone,4)+slashchar+catname+padzeros(nomreg,4)+'.dat';
      63002  : nomfich:=GCatpath+slashchar+padzeros(nomzone,3)+slashchar+catname+padzeros(nomreg,3)+'.dat';
    end;
    SMname:=nomreg;
    if FileBIsOpen then CloseRegion;
end else if cattype=ctText then begin
    nomfich:=GCatpath+slashchar+catheader.TxtFileName;
    SMname:=nomreg;
    if FileTIsOpen then CloseRegion;
end;
OpenFile(nomfich,ok);
if ok and onCache and (not gcatquick) and (CacheZone[CurCache,s]=0) then FillCache;
CurCacheRec:=-1;
end;


Procedure OpenGCat(ar1,ar2,de1,de2: double ; var ok : boolean);
var i:integer;
begin
try
curSM:=1;
ar1:=ar1*15; ar2:=ar2*15;
ok:=ReadCatHeader;
if ok then begin
    if (catversion=rtStar)and(catheader.filenum=50)and(emptyrec.star.valid[vsPmra])and((abs(JDChart-jd2000)/3652500)>1) then begin
       // if more than 10000 years from j2000 and proper motion, then use all the files
       nSM:=50;
       for i:=1 to nSM do SMlst[i]:=i;
    end else begin
case catheader.filenum of
    1      : begin nSM:=1; SMlst[1]:=1; end;
    50     : FindRegionList30(ar1,ar2,de1,de2,nSM,SMlst);
    184    : FindRegionAll15(ar1,ar2,de1,de2,nSM,SMlst);
    732    : FindRegionAll7(ar1,ar2,de1,de2,nSM,zonelst,SMlst,hemislst);
    9537   : FindRegionAll(ar1,ar2,de1,de2,nSM,zonelst,SMlst,hemislst);
    63002  : FindRegionAll1(ar1,ar2,de1,de2,nSM,zonelst,SMlst,hemislst);
end;
end;
hemis:= hemislst[curSM];
zone := zonelst[curSM];
Sm := Smlst[curSM];
OpenRegion(hemis,zone,Sm,ok);
end;
except
  ok:=false;
end;
end;

Procedure ReadGCat(var lin : GCatrec; var ok : boolean; MultiRegion: boolean=true);
var n : integer;
    s: double;
begin
ok:=true;
lin:=emptyrec;
case cattype of
ctBin : begin  // binary catalog
    if onCache and (CacheZone[CurCache,SM]>0) then begin
    // read form cache
    inc(CurCacheRec);
    case catversion of
      rtStar: if CurCacheRec<=CacheZone[CurCache,SM] then begin
                 lin.star:=CacheStar[CurCache,SM,CurCacheRec].star;
                 lin.str:= CacheStar[CurCache,SM,CurCacheRec].str;
                 lin.num:= CacheStar[CurCache,SM,CurCacheRec].num;
                 lin.ra:=CacheStar[CurCache,SM,CurCacheRec].ra;
                 lin.dec:=CacheStar[CurCache,SM,CurCacheRec].de;
                 ok:=true;
              end
              else begin
                 if MultiRegion then NextGCat(ok)
                    else ok:=false;
                 if ok then ReadGCat(lin,ok,MultiRegion);
              end;
      rtlin: if CurCacheRec<=CacheZone[CurCache,SM] then begin
                 lin.outlines:=CacheLine[CurCache,SM,CurCacheRec].outlines;
                 lin.ra:=CacheLine[CurCache,SM,CurCacheRec].ra;
                 lin.dec:=CacheLine[CurCache,SM,CurCacheRec].de;
                 ok:=true;
              end
              else begin
                 if MultiRegion then NextGCat(ok)
                    else ok:=false;
                 if ok then ReadGCat(lin,ok,MultiRegion);
              end;
      end;
  end else
  begin
  if not FileBIsOpen then begin
    ok:=false;
    exit;
  end;
  if mem.Position>=mem.Size then begin
     if MultiRegion then NextGCat(ok)
        else ok:=false;
  end;
  if ok then begin
   n:=mem.Read(datarec,catheader.reclen);
   if n=catheader.reclen then begin
    lin.ra:=GetRecCard(1)/3600000;
    lin.dec:=GetRecCard(2)/3600000-90;
    case catversion of
    rtstar : begin  // Star 1
        if catheader.flen[3]>0 then begin
         if catheader.IdFormat=0 then
           lin.star.id:=GetRecString(3)
         else
           lin.star.id:=IntToStr(GetRecQWord(3));
         if catheader.IdPrefix then lin.star.id:=lin.options.flabel[lOffset+vsId]+' '+lin.star.id;
        end;
        if catheader.flen[4]>0 then begin lin.star.magv:=GetRecSmallint(4)/1000; if lin.star.magv>32 then lin.star.magv:=99;end else lin.star.magv:=99;
        if catheader.flen[5]>0 then begin lin.star.b_v:=GetRecSmallint(5)/1000;  if lin.star.b_v>32  then lin.star.b_v:=99.9;end else lin.star.b_v:=99.9;
        if catheader.flen[6]>0 then begin lin.star.magb:=GetRecSmallint(6)/1000; if lin.star.magb>32 then lin.star.magb:=99;end else lin.star.magb:=99;
        if catheader.flen[7]>0 then begin lin.star.magr:=GetRecSmallint(7)/1000; if lin.star.magr>32 then lin.star.magr:=99;end else lin.star.magr:=99;
        if catheader.flen[8]>0 then lin.star.sp:=GetRecString(8);
        if catheader.HighPrecPM then begin
          if catheader.flen[9]>0 then lin.star.pmra:=GetRecSingle(9);
          if catheader.flen[10]>0 then lin.star.pmdec:=GetRecSingle(10);
          if catheader.flen[12]>0 then lin.star.px:=GetRecSingle(12);
        end
        else begin
          if catheader.flen[9]>0 then lin.star.pmra:=GetRecSmallint(9)/1000;
          if catheader.flen[10]>0 then lin.star.pmdec:=GetRecSmallint(10)/1000;
          if catheader.flen[12]>0 then lin.star.px:=GetRecSmallint(12)/10000;
        end;
        if catheader.flen[11]>0 then lin.star.epoch:=GetRecSingle(11);
        if catheader.flen[13]>0 then lin.star.comment:=GetRecString(13);
        if lin.star.magv>90 then begin lin.star.magv:=lin.star.magb; lin.options.flabel[lOffset+vsMagv]:=lin.options.flabel[lOffset+vsMagb]; end;
        if lin.star.magv>90 then begin lin.star.magv:=lin.star.magr; lin.options.flabel[lOffset+vsMagv]:=lin.options.flabel[lOffset+vsMagr]; end;
        if lin.star.magv>90 then begin lin.options.flabel[lOffset+vsMagv]:=catheader.flabel[lOffset+vsMagv]; end;
        end;
    rtvar : begin  // variables stars 1
        if catheader.flen[3]>0 then lin.variable.id:=GetRecString(3);
        if catheader.IdPrefix then lin.variable.id:=lin.options.flabel[lOffset+vsId]+' '+lin.variable.id;
        if catheader.flen[4]>0 then begin lin.variable.magmax:=GetRecSmallint(4)/1000; if lin.variable.magmax>32 then lin.variable.magmax:=99;end;
        if catheader.flen[5]>0 then begin lin.variable.magmin:=GetRecSmallint(5)/1000; if lin.variable.magmin>32 then lin.variable.magmin:=99;end;
        if catheader.flen[6]>0 then lin.variable.period:=GetRecSingle(6);
        if catheader.flen[7]>0 then lin.variable.vartype:=GetRecString(7);
        if catheader.flen[8]>0 then lin.variable.maxepoch:=GetRecSingle(8);
        if catheader.flen[9]>0 then lin.variable.risetime:=GetRecSmallint(9)/100;
        if catheader.flen[10]>0 then lin.variable.sp:=GetRecString(10);
        if catheader.flen[11]>0 then lin.variable.magcode:=GetRecString(11);
        if catheader.flen[12]>0 then lin.variable.comment:=GetRecString(12);
        end;
    rtdbl : begin  // doubles stars 1
        if catheader.flen[3]>0 then lin.double.id:=GetRecString(3);
        if catheader.IdPrefix then lin.double.id:=lin.options.flabel[lOffset+vsId]+' '+lin.double.id;
        if catheader.flen[4]>0 then begin lin.double.mag1:=GetRecSmallint(4)/1000; if lin.double.mag1>32 then lin.double.mag1:=99;end;
        if catheader.flen[5]>0 then begin lin.double.mag2:=GetRecSmallint(5)/1000; if lin.double.mag2>32 then lin.double.mag2:=99;end;
        if catheader.flen[6]>0 then lin.double.sep:=GetRecSmallint(6)/10;
        if catheader.flen[7]>0 then lin.double.pa:=GetRecSmallint(7);
        if catheader.flen[8]>0 then lin.double.epoch:=GetRecSingle(8);
        if catheader.flen[9]>0 then lin.double.compname:=GetRecString(9);
        if catheader.flen[10]>0 then lin.double.sp1:=GetRecString(10);
        if catheader.flen[11]>0 then lin.double.sp2:=GetRecString(11);
        if catheader.flen[12]>0 then lin.double.comment:=GetRecString(12);
        end;
    rtneb : begin  // nebulae 1
        if catheader.flen[3]>0 then lin.neb.id:=GetRecString(3);
        if catheader.IdPrefix then lin.neb.id:=lin.options.flabel[lOffset+vsId]+' '+lin.neb.id;
        if catheader.flen[4]>0 then lin.neb.nebtype:=GetRecByte(4);
        if catheader.flen[5]>0 then begin lin.neb.mag:=GetRecSmallint(5)/1000; if lin.neb.mag>32 then lin.neb.mag:=99;end;
        if catheader.flen[6]>0 then begin lin.neb.sbr:=GetRecSmallint(6)/1000; if lin.neb.sbr>32 then lin.neb.sbr:=99.9;end;
        if catheader.flen[7]>0 then lin.neb.dim1:=GetRecSingle(7);
        if catheader.flen[8]>0 then lin.neb.dim2:=GetRecSingle(8);
        if catheader.flen[9]>0 then lin.neb.nebunit:=GetRecSmallint(9);
        if catheader.flen[10]>0 then begin lin.neb.pa:=GetRecSmallint(10); if lin.neb.pa=32767 then lin.neb.pa:=-999;end;
        if catheader.flen[11]>0 then lin.neb.rv:=GetRecSingle(11);
        if catheader.flen[12]>0 then lin.neb.morph:=GetRecString(12);
        if catheader.flen[13]>0 then lin.neb.comment:=GetRecString(13);
        if catheader.flen[14]>0 then lin.neb.color:=GetRecCard(14);
        if lin.neb.mag>90 then lin.neb.valid[vnMag]:=false;
        if lin.neb.sbr>90 then lin.neb.valid[vnSbr]:=false;
        if lin.neb.pa<-900 then lin.neb.valid[vnPa]:=false;
        end;
    rtlin : begin  // outlines 1
        if catheader.flen[3]>0 then lin.outlines.id:=GetRecString(3);
        if catheader.flen[4]>0 then lin.outlines.lineoperation:=GetRecByte(4);
        if catheader.flen[5]>0 then lin.outlines.linewidth:=GetRecByte(5);
        if catheader.flen[6]>0 then lin.outlines.linecolor:=GetRecCard(6);
        if catheader.flen[7]>0 then lin.outlines.linetype:=GetRecByte(7);
        if catheader.flen[8]>0 then lin.outlines.comment:=GetRecString(8);
        end;
    end;
    if catheader.flen[16]>0 then lin.str[1]:=GetRecString(16);
    if catheader.flen[17]>0 then lin.str[2]:=GetRecString(17);
    if catheader.flen[18]>0 then lin.str[3]:=GetRecString(18);
    if catheader.flen[19]>0 then lin.str[4]:=GetRecString(19);
    if catheader.flen[20]>0 then lin.str[5]:=GetRecString(20);
    if catheader.flen[21]>0 then lin.str[6]:=GetRecString(21);
    if catheader.flen[22]>0 then lin.str[7]:=GetRecString(22);
    if catheader.flen[23]>0 then lin.str[8]:=GetRecString(23);
    if catheader.flen[24]>0 then lin.str[9]:=GetRecString(24);
    if catheader.flen[25]>0 then lin.str[10]:=GetRecString(25);
    if catheader.flen[26]>0 then lin.num[1]:=GetRecSingle(26);
    if catheader.flen[27]>0 then lin.num[2]:=GetRecSingle(27);
    if catheader.flen[28]>0 then lin.num[3]:=GetRecSingle(28);
    if catheader.flen[29]>0 then lin.num[4]:=GetRecSingle(29);
    if catheader.flen[30]>0 then lin.num[5]:=GetRecSingle(30);
    if catheader.flen[31]>0 then lin.num[6]:=GetRecSingle(31);
    if catheader.flen[32]>0 then lin.num[7]:=GetRecSingle(32);
    if catheader.flen[33]>0 then lin.num[8]:=GetRecSingle(33);
    if catheader.flen[34]>0 then lin.num[9]:=GetRecSingle(34);
    if catheader.flen[35]>0 then lin.num[10]:=GetRecSingle(35);
  end else ok:=false;
  end;
  end;
  end;
ctText: begin // text file, positional
   if not FileTIsOpen then begin
     ok:=false;
     exit;
   end;
  if eof(ft) then NextGCat(ok);
  if ok then begin
    readln(ft,dataline);
    dataline:=StringReplace(dataline,'°','d',[rfReplaceAll]);
    case catheader.RAmode of
    0 : begin
          lin.ra:=15*(Getfloat2(1,0)+Getfloat2(36,0)/60+Getfloat2(37,0)/3600);
        end;
    1 : begin
          lin.ra:=15*(Getfloat2(1,0));
        end;
    2 : begin
          lin.ra:=Getfloat2(1,0)+Getfloat2(36,0)/60+Getfloat2(37,0)/3600;
        end;
    3 : begin
          lin.ra:=Getfloat2(1,0);
        end;
    end;
    case catheader.DECmode of
    0 : begin
          if GetString2(40)='-' then s:=-1 else s:=1;
          lin.dec:=s*Getfloat2(2,0)+s*Getfloat2(38,0)/60+s*Getfloat2(39,0)/3600;
        end;
    1 : begin
          lin.dec:=Getfloat2(2,0);
        end;
    2 : begin
          lin.dec:=Getfloat2(2,0)-90;
        end;
    end;
    case catversion of
    rtstar : begin  // Star 2
        if catheader.flen[3]>0 then lin.star.id:=GetString2(3);
        if catheader.flen[4]>0 then begin lin.star.magv:=Getfloat2(4,99); if lin.star.magv>32 then lin.star.magv:=99.9;end;
        if catheader.flen[5]>0 then begin lin.star.b_v:=Getfloat2(5,99);  if lin.star.b_v>32  then lin.star.b_v:=99.9;end;
        if catheader.flen[6]>0 then begin lin.star.magb:=Getfloat2(6,99); if lin.star.magb>32 then lin.star.magb:=99.9;end;
        if catheader.flen[7]>0 then begin lin.star.magr:=Getfloat2(7,99); if lin.star.magr>32 then lin.star.magr:=99.9;end;
        if catheader.flen[8]>0 then lin.star.sp:=GetString2(8);
        if catheader.flen[9]>0 then lin.star.pmra:=Getfloat2(9,0);
        if catheader.flen[10]>0 then lin.star.pmdec:=Getfloat2(10,0);
        if catheader.flen[11]>0 then lin.star.epoch:=Getfloat2(11,0);
        if catheader.flen[12]>0 then lin.star.px:=Getfloat2(12,0);
        if catheader.flen[13]>0 then lin.star.comment:=GetString2(13);
        end;
    rtvar : begin  // variables stars 2
        if catheader.flen[3]>0 then lin.variable.id:=GetString2(3);
        if catheader.flen[4]>0 then begin lin.variable.magmax:=Getfloat2(4,99); if lin.variable.magmax>32 then lin.variable.magmax:=99.9;end;
        if catheader.flen[5]>0 then begin lin.variable.magmin:=Getfloat2(5,99); if lin.variable.magmin>32 then lin.variable.magmin:=99.9;end;
        if catheader.flen[6]>0 then lin.variable.period:=Getfloat2(6,0);
        if catheader.flen[7]>0 then lin.variable.vartype:=GetString2(7);
        if catheader.flen[8]>0 then lin.variable.maxepoch:=Getfloat2(8,0);
        if catheader.flen[9]>0 then lin.variable.risetime:=Getfloat2(9,0);
        if catheader.flen[10]>0 then lin.variable.sp:=GetString2(10);
        if catheader.flen[11]>0 then lin.variable.magcode:=GetString2(11);
        if catheader.flen[12]>0 then lin.variable.comment:=GetString2(12);
        end;
    rtdbl : begin  // doubles stars 2
        if catheader.flen[3]>0 then lin.double.id:=GetString2(3);
        if catheader.flen[4]>0 then begin lin.double.mag1:=Getfloat2(4,99); if lin.double.mag1>32 then lin.double.mag1:=99.9;end;
        if catheader.flen[5]>0 then begin lin.double.mag2:=Getfloat2(5,99); if lin.double.mag2>32 then lin.double.mag2:=99.9;end;
        if catheader.flen[6]>0 then lin.double.sep:=Getfloat2(6,0);
        if catheader.flen[7]>0 then lin.double.pa:=Getfloat2(7,0);
        if catheader.flen[8]>0 then lin.double.epoch:=Getfloat2(8,0);
        if catheader.flen[9]>0 then lin.double.compname:=GetString2(9);
        if catheader.flen[10]>0 then lin.double.sp1:=GetString2(10);
        if catheader.flen[11]>0 then lin.double.sp2:=GetString2(11);
        if catheader.flen[12]>0 then lin.double.comment:=GetString2(12);
        end;
    rtneb : begin  // nebulae 2
        if catheader.flen[3]>0 then lin.neb.id:=GetString2(3);
        if catheader.flen[4]>0 then lin.neb.nebtype:=GetNebType2(4);
        if trim(catheader.ShortName)='d2k' then begin
           lin.neb.nebtype:=TypeDS[lin.neb.nebtype];
        end;
        if catheader.flen[5]>0 then begin lin.neb.mag:=Getfloat2(5,99); if lin.neb.mag>32 then lin.neb.mag:=99.9;end;
        if catheader.flen[6]>0 then begin lin.neb.sbr:=Getfloat2(6,99); if lin.neb.sbr>32 then lin.neb.sbr:=99.9;end;
        if catheader.flen[7]>0 then lin.neb.dim1:=Getfloat2(7,0);
        if catheader.flen[8]>0 then lin.neb.dim2:=Getfloat2(8,0);
        if catheader.flen[9]>0 then lin.neb.nebunit:=GetNebUnit2(9);
        if catheader.flen[10]>0 then lin.neb.pa:=Getfloat2(10,-999);
        if catheader.flen[11]>0 then lin.neb.rv:=Getfloat2(11,0);
        if catheader.flen[12]>0 then lin.neb.morph:=GetString2(12);
        if catheader.flen[13]>0 then lin.neb.comment:=GetString2(13);
        if catheader.flen[14]>0 then lin.neb.color:=GetColor2(14);
        end;
    rtlin : begin  // outlines 2
        if catheader.flen[3]>0 then lin.outlines.id:=GetString2(3);
        if catheader.flen[4]>0 then lin.outlines.lineoperation:=GetLineOp2(4);
        if catheader.flen[5]>0 then lin.outlines.linewidth:=GetInt2(5);
        if catheader.flen[6]>0 then lin.outlines.linecolor:=GetColor2(6);
        if catheader.flen[7]>0 then lin.outlines.linetype:=GetInt2(7);
        if catheader.flen[8]>0 then lin.outlines.comment:=GetString2(8);
        end;
    end;
    if catheader.flen[16]>0 then lin.str[1]:=GetString2(16);
    if catheader.flen[17]>0 then lin.str[2]:=GetString2(17);
    if catheader.flen[18]>0 then lin.str[3]:=GetString2(18);
    if catheader.flen[19]>0 then lin.str[4]:=GetString2(19);
    if catheader.flen[20]>0 then lin.str[5]:=GetString2(20);
    if catheader.flen[21]>0 then lin.str[6]:=GetString2(21);
    if catheader.flen[22]>0 then lin.str[7]:=GetString2(22);
    if catheader.flen[23]>0 then lin.str[8]:=GetString2(23);
    if catheader.flen[24]>0 then lin.str[9]:=GetString2(24);
    if catheader.flen[25]>0 then lin.str[10]:=GetString2(25);
    if catheader.flen[26]>0 then lin.num[1]:=Getfloat2(26,0);
    if catheader.flen[27]>0 then lin.num[2]:=Getfloat2(27,0);
    if catheader.flen[28]>0 then lin.num[3]:=Getfloat2(28,0);
    if catheader.flen[29]>0 then lin.num[4]:=Getfloat2(29,0);
    if catheader.flen[30]>0 then lin.num[5]:=Getfloat2(30,0);
    if catheader.flen[31]>0 then lin.num[6]:=Getfloat2(31,0);
    if catheader.flen[32]>0 then lin.num[7]:=Getfloat2(32,0);
    if catheader.flen[33]>0 then lin.num[8]:=Getfloat2(33,0);
    if catheader.flen[34]>0 then lin.num[9]:=Getfloat2(34,0);
    if catheader.flen[35]>0 then lin.num[10]:=Getfloat2(35,0);
   end else ok:=false;
  end;
ctTab: begin // text file, tab separated
  end;
end;
end;

Procedure NextGCat( var ok : boolean);
begin
  CloseRegion;
  inc(curSM);
  if curSM>nSM then ok:=false
  else begin
    hemis:= hemislst[curSM];
    zone := zonelst[curSM];
    Sm := Smlst[curSM];
    OpenRegion(hemis,zone,Sm,ok);
  end;
end;

procedure CloseGCat ;
begin
curSM:=nSM;
CloseRegion;
end;

Procedure OpenGCatwin(var ok : boolean);
var i: integer;
begin
try
curSM:=1;
ok:=ReadCatHeader;
if ok then begin
if (catversion=rtStar)and(catheader.filenum=50)and(emptyrec.star.valid[vsPmra])and((abs(JDChart-jd2000)/3652500)>1) then begin
   // if more than 10000 years from j2000 and proper motion, then use all the files
   nSM:=50;
   for i:=1 to nSM do SMlst[i]:=i;
end else begin
case catheader.filenum of
    1      : begin nSM:=1; SMlst[1]:=1; end;
    50     : FindRegionListWin30(nSM,SMlst);
    184    : FindRegionAllWin15(nSM,SMlst);
    732    : FindRegionAllWin7(nSM,zonelst,SMlst,hemislst);
    9537   : FindRegionAllWin(nSM,zonelst,SMlst,hemislst);
    63002  : FindRegionAllWin1(nSM,zonelst,SMlst,hemislst);
end;
end;
hemis:= hemislst[curSM];
zone := zonelst[curSM];
Sm := Smlst[curSM];
OpenRegion(hemis,zone,Sm,ok);
end;
except
  ok:=false;
end;
end;

Function ReadGCatHeader : boolean;
begin
 result:=ReadCatHeader;
end;

Procedure OpenGCatfile(nomfich : string; var ok : boolean);
begin
Openfile(nomfich,ok);
end;

procedure OpenGCatFileNum(fnum:integer; var ok:boolean);
var fn: string;
    n,m: integer;
// open a single file
const
  zone_lst : array [0..23] of integer = (   593 ,  1177 ,  1728 , 2258  ,  2780 ,  3245 ,  3651 , 4013  , 4293  ,  4491 ,  4614 , 4662  ,  5259 ,  5837 ,  6411 ,  6988 ,  7522 ,  8021 ,  8463 ,  8839 ,  9133 ,  9345 ,  9489 ,  9537 );
  zone_lst7: array [0..23] of integer = (    48 ,    95 ,   140 ,  183  ,   223 ,   259 ,   291 ,  318  ,  339  ,   354 ,   363 ,  366  ,   414 ,   461 ,   506 ,   549 ,   589 ,   625 ,   657 ,   684 ,   705 ,   720 ,   729 ,   732 );
  zone_nam : array [0..23] of string  = ('n0000','n0730','n1500','n2230','n3000','n3730','n4500','n5230','n6000','n6730','n7500','n8230','s0000','s0730','s1500','s2230','s3000','s3730','s4500','s5230','s6000','s6730','s7500','s8230');
begin
m:=0;
case catheader.FileNum of
  1      : fn:=lowercase(trim(catheader.ShortName))+'.dat';
  50     : fn:=lowercase(trim(catheader.ShortName))+padzeros(inttostr(fnum),2)+'.dat';
  184    : fn:=lowercase(trim(catheader.ShortName))+padzeros(inttostr(fnum),3)+'.dat';
  732    : begin
             for n:=0 to 23 do if fnum <= zone_lst7[n] then begin; m:=n; break; end;
             fn:=slash(zone_nam[m])+lowercase(trim(catheader.ShortName))+padzeros(inttostr(fnum),3)+'.dat';
           end;
  9537   : begin
             for n:=0 to 23 do if fnum <= zone_lst[n] then begin; m:=n; break; end;
             fn:=slash(zone_nam[m])+lowercase(trim(catheader.ShortName))+padzeros(inttostr(fnum),4)+'.dat';
           end;
  63002  : raise Exception.Create('Not implemented 63002') // no index for this large files
  else fn:='';
end;
OpenFile(GCatpath+slashchar+fn,ok);
end;

Procedure ReadGCatRec(recnum:integer; var lin : GCatrec; var ok : boolean);
var n : integer;
// read a single record from current file (bypass cache)
begin
ok:=true;
lin:=emptyrec;
if not FileBIsOpen then begin
  ok:=false;
  exit;
end;
mem.Position:=recnum*catheader.reclen;
ok:=not (mem.Position>=mem.Size);
if ok then begin
   n:=mem.Read(datarec,catheader.reclen);
   if n=catheader.reclen then begin
    lin.ra:=GetRecCard(1)/3600000;
    lin.dec:=GetRecCard(2)/3600000-90;
    case catversion of
    rtstar : begin  // Star 1
        if catheader.flen[3]>0 then begin
         if catheader.IdFormat=0 then
           lin.star.id:=GetRecString(3)
         else
           lin.star.id:=IntToStr(GetRecQWord(3));
        end;
        if catheader.IdPrefix then lin.star.id:=lin.options.flabel[lOffset+vsId]+' '+lin.star.id;
        if catheader.flen[4]>0 then begin lin.star.magv:=GetRecSmallint(4)/1000; if lin.star.magv>32 then lin.star.magv:=99;end else lin.star.magv:=99;;
        if catheader.flen[5]>0 then begin lin.star.b_v:=GetRecSmallint(5)/1000;  if lin.star.b_v>32  then lin.star.b_v:=99.9;end else lin.star.b_v:=99.9;
        if catheader.flen[6]>0 then begin lin.star.magb:=GetRecSmallint(6)/1000; if lin.star.magb>32 then lin.star.magb:=99;end else lin.star.magb:=99;
        if catheader.flen[7]>0 then begin lin.star.magr:=GetRecSmallint(7)/1000; if lin.star.magr>32 then lin.star.magr:=99;end else lin.star.magr:=99;
        if catheader.flen[8]>0 then lin.star.sp:=GetRecString(8);
        if catheader.HighPrecPM then begin
          if catheader.flen[9]>0 then lin.star.pmra:=GetRecSingle(9);
          if catheader.flen[10]>0 then lin.star.pmdec:=GetRecSingle(10);
          if catheader.flen[12]>0 then lin.star.px:=GetRecSingle(12);
        end
        else begin
          if catheader.flen[9]>0 then lin.star.pmra:=GetRecSmallint(9)/1000;
          if catheader.flen[10]>0 then lin.star.pmdec:=GetRecSmallint(10)/1000;
          if catheader.flen[12]>0 then lin.star.px:=GetRecSmallint(12)/10000;
        end;
        if catheader.flen[11]>0 then lin.star.epoch:=GetRecSingle(11);
        if catheader.flen[13]>0 then lin.star.comment:=GetRecString(13);
        if lin.star.magv>90 then begin lin.star.magv:=lin.star.magb; lin.options.flabel[lOffset+vsMagv]:=lin.options.flabel[lOffset+vsMagb]; end;
        if lin.star.magv>90 then begin lin.star.magv:=lin.star.magr; lin.options.flabel[lOffset+vsMagv]:=lin.options.flabel[lOffset+vsMagr]; end;
        if lin.star.magv>90 then begin lin.options.flabel[lOffset+vsMagv]:=catheader.flabel[lOffset+vsMagv]; end;
        end;
    rtvar : begin  // variables stars 1
        if catheader.flen[3]>0 then lin.variable.id:=GetRecString(3);
        if catheader.IdPrefix then lin.variable.id:=lin.options.flabel[lOffset+vsId]+' '+lin.variable.id;
        if catheader.flen[4]>0 then begin lin.variable.magmax:=GetRecSmallint(4)/1000; if lin.variable.magmax>32 then lin.variable.magmax:=99.9;end;
        if catheader.flen[5]>0 then begin lin.variable.magmin:=GetRecSmallint(5)/1000; if lin.variable.magmin>32 then lin.variable.magmin:=99.9;end;
        if catheader.flen[6]>0 then lin.variable.period:=GetRecSingle(6);
        if catheader.flen[7]>0 then lin.variable.vartype:=GetRecString(7);
        if catheader.flen[8]>0 then lin.variable.maxepoch:=GetRecSingle(8);
        if catheader.flen[9]>0 then lin.variable.risetime:=GetRecSmallint(9)/100;
        if catheader.flen[10]>0 then lin.variable.sp:=GetRecString(10);
        if catheader.flen[11]>0 then lin.variable.magcode:=GetRecString(11);
        if catheader.flen[12]>0 then lin.variable.comment:=GetRecString(12);
        end;
    rtdbl : begin  // doubles stars 1
        if catheader.flen[3]>0 then lin.double.id:=GetRecString(3);
        if catheader.IdPrefix then lin.double.id:=lin.options.flabel[lOffset+vsId]+' '+lin.double.id;
        if catheader.flen[4]>0 then begin lin.double.mag1:=GetRecSmallint(4)/1000; if lin.double.mag1>32 then lin.double.mag1:=99.9;end;
        if catheader.flen[5]>0 then begin lin.double.mag2:=GetRecSmallint(5)/1000; if lin.double.mag2>32 then lin.double.mag2:=99.9;end;
        if catheader.flen[6]>0 then lin.double.sep:=GetRecSmallint(6)/10;
        if catheader.flen[7]>0 then lin.double.pa:=GetRecSmallint(7);
        if catheader.flen[8]>0 then lin.double.epoch:=GetRecSingle(8);
        if catheader.flen[9]>0 then lin.double.compname:=GetRecString(9);
        if catheader.flen[10]>0 then lin.double.sp1:=GetRecString(10);
        if catheader.flen[11]>0 then lin.double.sp2:=GetRecString(11);
        if catheader.flen[12]>0 then lin.double.comment:=GetRecString(12);
        end;
    rtneb : begin  // nebulae 1
        if catheader.flen[3]>0 then lin.neb.id:=GetRecString(3);
        if catheader.IdPrefix then lin.neb.id:=lin.options.flabel[lOffset+vsId]+' '+lin.neb.id;
        if catheader.flen[4]>0 then lin.neb.nebtype:=GetRecByte(4);
        if catheader.flen[5]>0 then begin lin.neb.mag:=GetRecSmallint(5)/1000; if lin.neb.mag>32 then lin.neb.mag:=99.9;end;
        if catheader.flen[6]>0 then begin lin.neb.sbr:=GetRecSmallint(6)/1000; if lin.neb.sbr>32 then lin.neb.sbr:=99.9;end;
        if catheader.flen[7]>0 then lin.neb.dim1:=GetRecSingle(7);
        if catheader.flen[8]>0 then lin.neb.dim2:=GetRecSingle(8);
        if catheader.flen[9]>0 then lin.neb.nebunit:=GetRecSmallint(9);
        if catheader.flen[10]>0 then begin lin.neb.pa:=GetRecSmallint(10); if lin.neb.pa=32767 then lin.neb.pa:=-999;end;
        if catheader.flen[11]>0 then lin.neb.rv:=GetRecSingle(11);
        if catheader.flen[12]>0 then lin.neb.morph:=GetRecString(12);
        if catheader.flen[13]>0 then lin.neb.comment:=GetRecString(13);
        if catheader.flen[14]>0 then lin.neb.color:=GetRecCard(14);
        end;
    rtlin : begin  // outlines 1
        if catheader.flen[3]>0 then lin.outlines.id:=GetRecString(3);
        if catheader.flen[4]>0 then lin.outlines.lineoperation:=GetRecByte(4);
        if catheader.flen[5]>0 then lin.outlines.linewidth:=GetRecByte(5);
        if catheader.flen[6]>0 then lin.outlines.linecolor:=GetRecCard(6);
        if catheader.flen[7]>0 then lin.outlines.linetype:=GetRecByte(7);
        if catheader.flen[8]>0 then lin.outlines.comment:=GetRecString(8);
        end;
    end;
    if catheader.flen[16]>0 then lin.str[1]:=GetRecString(16);
    if catheader.flen[17]>0 then lin.str[2]:=GetRecString(17);
    if catheader.flen[18]>0 then lin.str[3]:=GetRecString(18);
    if catheader.flen[19]>0 then lin.str[4]:=GetRecString(19);
    if catheader.flen[20]>0 then lin.str[5]:=GetRecString(20);
    if catheader.flen[21]>0 then lin.str[6]:=GetRecString(21);
    if catheader.flen[22]>0 then lin.str[7]:=GetRecString(22);
    if catheader.flen[23]>0 then lin.str[8]:=GetRecString(23);
    if catheader.flen[24]>0 then lin.str[9]:=GetRecString(24);
    if catheader.flen[25]>0 then lin.str[10]:=GetRecString(25);
    if catheader.flen[26]>0 then lin.num[1]:=GetRecSingle(26);
    if catheader.flen[27]>0 then lin.num[2]:=GetRecSingle(27);
    if catheader.flen[28]>0 then lin.num[3]:=GetRecSingle(28);
    if catheader.flen[29]>0 then lin.num[4]:=GetRecSingle(29);
    if catheader.flen[30]>0 then lin.num[5]:=GetRecSingle(30);
    if catheader.flen[31]>0 then lin.num[6]:=GetRecSingle(31);
    if catheader.flen[32]>0 then lin.num[7]:=GetRecSingle(32);
    if catheader.flen[33]>0 then lin.num[8]:=GetRecSingle(33);
    if catheader.flen[34]>0 then lin.num[9]:=GetRecSingle(34);
    if catheader.flen[35]>0 then lin.num[10]:=GetRecSingle(35);
  end else ok:=false;
  end;
end;

procedure GetEmptyRec(var lin : GCatrec);
begin
lin:=emptyrec;
end;

end.
