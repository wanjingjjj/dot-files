#InstallKeybdHook
#UseHook

; A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode 2

JumpOrExec(exec, exec_path)
{
  IfWinExist ahk_exe %exec%
    If WinActive("ahk_exe " . exec) {
      WinGet, Instances, Count, ahk_exe %exec%
      WinGet, ids, List, ahk_exe %exec%
      WinGetTitle, title, ahk_id %ids1%
      ;MsgBox % "title " . title
      If Instances > 1
        WinActivateBottom, ahk_exe %exec%
      }
    Else {
      winactivate
    }
  Else {
    run, %exec_path%
  }
  Return  
}

#a::
  IfWinExist ahk_class CabinetWClass
    if WinActive("ahk_exe explorer.exe")
      GroupActivate, kaiserexplorers, r
    else
      WinActivate ;you have to use WinActivatebottom if you didn't create a window group.
  else
    Run, ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;My Computer
    GroupAdd, kaiserexplorers, ahk_class CabinetWClass ;You have to make a new group for each application, don't use the same one for all of them!
  Return

#+a::
  run, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
  return

;#g::
;JumpOrExec("chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs -nw in alacritty
;#e::
;  IfWinExist ahk_exe %alacritty%
;  {
;    ;WinSet, Top
;    WinActivate
;  }
;  else
;    run, "C:\Users\mwan\Downloads\%alacritty%"
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs in mintty
;#e::
;  If WinExist("Emacs ahk_exe mintty.exe")
;  {
;    WinSet, Top
;    WinActivate
;  }
;  else
;    run, %LOCALAPPDATA%\wsltty\bin\mintty.exe --WSL= --configdir="%APPDATA%\wsltty" -~ /bin/bash -l -c 'emacs -nw'
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs in windows terminal
;#e::
;  If WinExist("Emacs ahk_exe WindowsTerminal.exe")
;  {
;    WinSet, Top
;    WinActivate
;  }
;  else
;    run, wt.exe --profile Emacs
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs in wslg
#e::
  If WinExist("Emacs ahk_exe msrdc.exe")
  {
    WinActivate
  }
  else
  { 
   run, "C:\Program Files\WSL\wsl.exe" /home/mwan/.local/bin/grab.sh
   Sleep 3000
   If WinExist("Emacs ahk_exe msrdc.exe")
      return
   else
      run, wt.exe wslg.exe emacs --chdir /home/mwan,,hide
  }
  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacsnt
;#e::
;  IfWinExist ahk_exe emacs.exe
;    winactivate
;  else
;    run, "c:\Users\mwan\Downloads\emacs-29.4\bin\runemacs.exe"
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs in mingw
;#e::
;  IfWinExist ahk_exe emacs.exe
;    winactivate
;  else
;    run, "c:\msys64\ucrt64.exe" bash -i -c 'runemacs'
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs in wsl using x11
;#e::
;  IfWinExist Emacs ahk_exe vcxsrv.exe
;    If WinActive("Emacs ahk_exe vcxsrv.exe") {
;      WinGet, Instances, Count, ahk_exe vcxsrv.exe
;      If Instances > 1
;        WinActivateBottom, Emacs ahk_exe vcxsrv.exe
;    }
;    else {
;      winactivate
;    }
;  ;else
;  ;  run, "c:\Users\mwan\Desktop\emacs"
;  return

#f::
JumpOrExec("firefox.exe", "C:\Users\mwan\AppData\Local\Mozilla Firefox\firefox.exe")
Return


#s::
JumpOrExec("ms-teams.exe", "ms-teams")
Return



#enter::
;JumpOrExec("Alacritty-v0.15.0-rc1-portable.exe", "C:\Users\mwan\Downloads\Alacritty-v0.15.0-rc1-portable.exe")
;JumpOrExec("WindowsTerminal.exe", "wt.exe")
; mingw
;JumpOrExec("mintty.exe", "C:\msys64\ucrt64.exe")
JumpOrExec("mintty.exe", "C:\users\mwan\AppData\Local\wsltty\bin\mintty.exe --WSL= --configdir=""C:\users\mwan\AppData\Roaming\wsltty"" -~  -")
Return

;#+enter::
;  run, "wt.exe"
;  Return

;#enter::
;  If WinExist("ADEVINT-CHDR47T ahk_exe msrdc.exe")
;    winactivate
;  else
;    run, wslg bash -i -c 'terminator'
;  return

#w::
JumpOrExec("OUTLOOK.exe", "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")
Return

#m::
WinGet MX, MinMax, A
If MX
	WinRestore A
Else
	WinMaximize A
Return
