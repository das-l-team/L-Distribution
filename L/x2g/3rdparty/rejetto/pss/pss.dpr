program pss;  {$APPTYPE CONSOLE}
{
Copyright (C) 2002-2004  Massimo Melina (www.rejetto.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{
=== VERSION HISTORY
1.1
+ new killname option
+ full wilcards support
* changed "^" to "!" 
- several bugs fixed

1.0
first release
}

uses
  windows,
  tlHelp32,
  sysutils;

const
  NL = #13#10;
  COPYRIGHT = 'PSS version 1.1, Copyright (C) 2002-2004  Massimo Melina (www.rejetto.com)'
          +NL+'PSS comes with ABSOLUTELY NO WARRANTY; for details see the file license.txt'
          +NL+'This is free software, and you are welcome to redistribute it'
          +NL+'under certain conditions.';
  HELP = 'Syntax: pss.exe [-ps[:auto]] [-limit:N] [-sort:[!]BY] [-kill:PID] [-name:N]'
     +NL+' -ps[:auto]    lists running processes, "auto" cause to refresh every second'
     +NL+' -limit:N     limits list to first N processes'
     +NL+' -sort:BY     sort processes by field BY, BY can be name or pid,'
     +NL+'                 a leading "!" inverts the order'
     +NL+' -kill:PID    kills the process with pid PID'
     +NL+' -name:N      prints PID for processes whose name matches N (support wildcards)'
     +NL+' -killname:N  as -name, but it kills those processes too'; 
  PRIO_RT = 0;
  PRIO_HI = 1;
  PRIO_NO = 2;
  PRIO_ID = 3;
  prio2str:array [0..3] of string=('RT','HI','NO','ID');

type
  Tprocess=record
    exe,path:string;
    pid:integer;
    prio:dword;
    end;
var
  ps:array of Tprocess;
  par_kill:integer;
  par_ps:boolean;
  par_auto:boolean;
  par_sort:string;
  par_sort_inv:boolean;
  par_limit:integer;
  par_name:string;
  par_killname:string;

  function keypressed:boolean;
  var
    n:cardinal;
  begin
  GetNumberOfConsoleInputEvents(GetStdHandle(STD_InPUT_HANDLE),n);
  result:=n>0;
  end; // keypressed

  function readkey:char;
  var
    ir:TinputRecord;
    h:integer;
    n:cardinal;
  begin
  h:=GetStdHandle(STD_INPUT_HANDLE);
  repeat until ReadConsoleInput(h,ir,1,n) and (ir.EventType = KEY_EVENT);
  result:=ir.event.KeyEvent.AsciiChar;
  end; // readkey

  procedure clrscr;
  var
    tc :tcoord;
    cbi : TConsoleScreenBufferInfo;
    n,h:cardinal;
  begin
  h:=GetStdHandle(STD_OUTPUT_HANDLE);
  getConsoleScreenBufferInfo(h,cbi);
  tc.x := 0;
  tc.y := 0;
  FillConsoleOutputAttribute(h,cbi.wAttributes,cbi.dwsize.x*cbi.dwsize.y,tc,n);
  FillConsoleOutputCharacter(h,#32,cbi.dwsize.x*cbi.dwsize.y,tc,n);
  setConsoleCursorPosition(h,tc);
  end; // clrscr

  procedure outputHelp;
  begin
  writeln(COPYRIGHT+NL+NL+HELP+NL);
  halt(1);
  end; // outputHelp

  procedure doKill(pid:integer);
  begin
  pid:=openprocess(PROCESS_TERMINATE,false,pid);
  exitcode:=integer(terminateprocess(pid,0));
  end; // doKill

  function chop(i,l:integer; var s:string):string; overload;
  begin
  if i=0 then
    begin
    result:=s;
    s:='';
    exit;
    end;
  result:=copy(s,1,i-1);
  delete(s,1,i-1+l);
  end; // chop

  function chop(ss:string; var s:string):string; overload;
  begin result:=chop(pos(ss,s),length(ss),s) end;

  function chop(i:integer; var s:string):string; overload;
  begin result:=chop(i,1,s) end;

  procedure getPS;
  var
    hnd:Thandle;
    pe:TProcessEntry32;
    idx:integer;
  begin
  setLength(ps,0);
  idx:=0;
  hnd:=CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  if hnd=0 then exit;
  pe.dwSize:=SizeOf(pe);
  if Process32First(hnd, pe) then
    repeat
    setlength(ps,idx+1);
    ps[idx].exe:=extractFileName(pe.szExeFile);
    ps[idx].path:=extractFilePath(pe.szExeFile);
    ps[idx].pid:=pe.th32ProcessID;
    case GetPriorityClass(pe.th32ProcessID) of
      REALTIME_PRIORITY_CLASS: ps[idx].prio:=PRIO_RT;
      HIGH_PRIORITY_CLASS: ps[idx].prio:=PRIO_HI;
      IDLE_PRIORITY_CLASS: ps[idx].prio:=PRIO_ID;
      else ps[idx].prio:=PRIO_NO;
      end;
    inc(idx);
    until not Process32Next(hnd,pe);
  CloseHandle(hnd);
  end; // getPS

  function startsWith(ss,s:string):boolean;
  begin result:=copy(s,1,length(ss))=ss end;

  function endsWith(ss,s:string):boolean;
  begin result:=copy(s,length(s)-length(ss)+1,length(ss))=ss end;

  function fillTo(s:string; n:integer):string; overload;
  begin
  while length(s)<n do
    s:=s+' ';
  result:=copy(s,1,n);
  end; // fillTo

  function fillTo(i,n:integer):string; overload;
  begin
  str(i,result);
  result:=fillTo(result,n);
  end; // fillTo

  procedure printPS;
  var
    i:integer;
  begin
  writeln('PID  Pri Name');
  if par_limit = 0 then i:=length(ps)
  else i:=par_limit;
  for i:=0 to i-1 do
    writeln(fillTo(ps[i].pid,5)+fillTo(prio2str[ps[i].prio],4)+fillTo(ps[i].exe,79-9));
  end; // printPS

  function val2(s:string;var v:integer):boolean;
  var
    n,i:integer;
  begin
  val(s,n,i);
  result:=i=0;
  if result then v:=n;
  end; // val2

  procedure parsePars;

    function chopPar(ss:string; var s:string):boolean;
    begin
    result:=startsWith(ss,s);
    if result then delete(s,1,length(ss))
    end; // chopPar

  var
    i:integer;
    s:string;
  begin
  if paramcount=0 then outputHelp;
  i:=0;
  while i < paramcount do
    begin
    inc(i);
    s:=lowercase(paramstr(i));
    if chopPar('-ps',s) then
      if s=':auto' then
        par_auto:=TRUE
      else
        par_ps:=TRUE;
    if chopPar('-limit:',s) and not val2(s,par_limit) then outputHelp;

    if chopPar('-sort:',s) then
      begin
      par_sort_inv:=chopPar('!',s);
      par_sort:=s;
      end;
    if chopPar('-kill:',s) and not val2(s,par_kill) then outputHelp;
    if chopPar('-name:',s) then par_name:=s;
    if chopPar('-killname:',s) then par_killname:=s;
    end;
  end; // parsePars

  procedure sortPS;
  var
    by:(_none,_pid,_name);
    i,j:integer;
    b:boolean;
    p:Tprocess;
  begin
  if length(ps)<2 then exit;
  by:=_none;
  if par_sort='name' then by:=_name;
  if par_sort='pid' then by:=_pid;
  if by = _none then exit;
  
  for i:=0 to length(ps)-2 do
    for j:=i+1 to length(ps)-1 do
      begin
      case by of
        _pid: b:= ps[i].pid > ps[j].pid;
        _name: b:= compareText(ps[i].exe,ps[j].exe) >0;
        else b:=FALSE;
        end;
      if par_sort_inv then b:=not b;
      if b then // swap?
        begin
        p:=ps[i];
        ps[i]:=ps[j];
        ps[j]:=p;
        end;
      end;
  end; // sortPS

  function filematch(mask, fn:string):boolean;

    function match(mask, fn:pchar):boolean;
    begin
    result:=TRUE;
    // 1 to 1 match
    while (mask^ <> #0) and (fn <> #0)
    and ((upcase(mask^) = upcase(fn^)) or (mask^ = '?')) do
      begin
      inc(mask);
      inc(fn);
      end;
    // if no * is found, just check if mask and fn did reach the end
    if mask^ <> '*' then
      begin
      result:=(mask^=#0) and (fn^=#0);
      exit;
      end;
    // an * is found, just check for all cases with the rest of the strings
    inc(mask);
    while fn^ <> #0 do
      begin
      result:=filematch(mask, fn);
      if result then exit;
      inc(fn);
      end;
    end; // match

  begin
  result:=TRUE;
  while mask > '' do
    begin
    result:=match( pchar(chop(';',mask)), pchar(fn) );
    if result then exit;
    end;
  end; // filematch

var
  enumIdx: integer;
  enumMask: string;

  function getNextProcess():integer;
  begin
  result:=-1;
    repeat
    inc(enumIdx);
    if enumIdx >= length(ps) then exit;
    if filematch(enumMask, ps[enumIdx].exe) then result:=enumIdx;
    until result >= 0;
  end; // getNextProcess

  procedure resetEnumProcess(mask:string);
  begin
  enumMask:=mask;
  getPS;
  enumIdx:=-1;
  end; // resetEnumProcess

  procedure pidByName;
  var
    i:integer;
  begin
  resetEnumProcess(par_name);
  i:=getNextProcess();
  while i >= 0 do
    begin
    writeln(ps[i].pid);
    i:=getNextProcess();
    end;
  end; // pidByName

  procedure killByName;
  var
    i:integer;
  begin
  resetEnumProcess(par_killname);
  i:=getNextProcess();
  while i >= 0 do
    begin
    writeln(ps[i].pid);
    doKill(ps[i].pid);
    i:=getNextProcess();
    end;
  end; // killByName

begin
parsePars;
if par_kill > 0 then doKill(par_kill);
if par_name > '' then pidByName;
if par_killname > '' then killByName;
if par_ps then
  begin
  getPS;
  sortPS;
  printPS;
  end
else
  if par_auto then
    repeat
    clrScr;
    getPS;
    sortPS;
    printPS;
    if not keypressed then sleep(1000);
    until keypressed and (readkey=#27);
end.
