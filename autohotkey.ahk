#InstallKeybdHook
#UseHook

; A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode 2

alacritty := "Alacritty-v0.12.2-portable.exe"

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
;  If WinExist("Google Chrome ahk_exe chrome.exe")
;    If WinActive("ahk_exe chrome.exe") {
;      WinGet, Instances, Count, ahk_exe chrome.exe
;      If Instances > 1
;        WinActivateBottom, ahk_exe chrome.exe
;    }
;    Else {
;      WinActivateBottom, ahk_exe chrome.exe
;    }
;  else
;    run, "C:\Program Files\Google\Chrome\Application\chrome.exe"
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacs -nw in alacritty
;#e::
;  IfWinExist ahk_exe %alacritty%
;  {
;    ;WinSet, Top
;    WinActivate
;  }
;  else
;    run, "C:\Users\mark.wan\Downloads\%alacritty%"
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
;#e::
;  If WinExist("Emacs ahk_exe msrdc.exe")
;  {
;    WinActivate
;  }
;  else
;   run, "C:\Program Files\WSL\wslg.exe" GTK_THEME=Adwaita:dark emacs --chdir /home/jingwan
;  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; emacsnt
;#e::
;  IfWinExist ahk_exe emacs.exe
;    winactivate
;  else
;    run, "c:\Users\mark.wan\Downloads\emacs-28.2\bin\runemacs.exe"
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
#e::
  IfWinExist Emacs ahk_exe vcxsrv.exe
    If WinActive("Emacs ahk_exe vcxsrv.exe") {
      WinGet, Instances, Count, ahk_exe vcxsrv.exe
      If Instances > 1
        WinActivateBottom, Emacs ahk_exe vcxsrv.exe
    }
    else {
      winactivate
    }
  ;else
  ;  run, "c:\Users\mark.wan\Desktop\emacs"
  return

#f::
  IfWinExist ahk_exe firefox.exe
    If WinActive("ahk_exe firefox.exe") {
      WinGet, Instances, Count, ahk_exe firefox.exe
      If Instances > 1
        WinActivateBottom, ahk_exe firefox.exe
    }
   Else {
      winactivate
    }
  else
    run, "C:\Program Files\Mozilla Firefox\firefox.exe"
  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; chromium in wsl using x11
#g::
  IfWinExist Chromium ahk_exe vcxsrv.exe
        WinActivate
  return

;#g::
;  If WinExist("Adevinta Mail ahk_exe chrome.exe")
;    winactivate
;  else
;    run, "C:\Program Files\Google\Chrome\Application\chrome_proxy.exe"  --profile-directory=Default --app-id=fmgjjmmmlfnkbppncabfkddbjimcfncm
;  return

#m::
  WinGet MX, MinMax, A
  If MX
    WinRestore A
  Else
    WinMaximize A
  Return

#s::
  IfWinExist ahk_exe slack.exe
    winactivate
  else
    run, "slack"
  return

;#+w::
;  run, %LOCALAPPDATA%\wsltty\bin\mintty.exe --WSL="arch" --configdir="%APPDATA%\wsltty" -~  -
;  Return

#enter::
  IfWinExist ahk_exe mintty.exe
    If WinActive("ahk_exe mintty.exe") {
      WinGet, Instances, Count, ahk_exe mintty.exe
      If Instances > 1
        WinActivateBottom, ahk_exe mintty.exe, ,Emacs
    }
   Else {
      WinActivateBottom, ahk_exe mintty.exe, ,Emacs
    }
  else
      run, %LOCALAPPDATA%\wsltty\bin\mintty.exe --WSL= --configdir="%APPDATA%\wsltty" -~  -
  Return

;#enter::
;  IfWinExist ahk_exe WindowsTerminal.exe
;    If WinActive("ahk_exe WindowsTerminal.exe") {
;      WinGet, Instances, Count, ahk_exe WindowsTerminal.exe
;      If Instances > 1
;        WinActivateBottom, ahk_exe WindowsTerminal.exe, ,Emacs
;    }
;   Else {
;      WinActivateBottom, ahk_exe WindowsTerminal.exe, ,Emacs
;    }
;  else
;    run, "wt.exe"
;  Return

;#enter::
;  IfWinNotExist ahk_exe mintty.exe
;    run, "C:\msys64\ucrt64.exe"
;  If WinActive("ahk_exe mintty.exe") {
;    WinGet, Instances, Count, ahk_exe mintty.exe
;    If Instances > 1
;      WinActivateBottom, ahk_exe mintty.exe
;  }
;  Else {
;    WinWait, ahk_exe mintty.exe
;    winactivate, ahk_exe mintty.exe
;  }
;  Return

;#enter::
;  IfWinExist ahk_exe %alacritty%
;    If WinActive("ahk_exe %alacritty%") {
;      WinGet, Instances, Count, ahk_exe %alacritty%
;      If Instances > 1
;        WinActivateBottom, ahk_exe %alacritty%, ,Emacs
;        Return
;    }
;  Else {
;      winactivate
;    }
;  else
;    run, "C:\Users\mark.wan\Downloads\%alacritty%"
;  Return

;#+enter::
;  run, "wt.exe"
;  Return

;#enter::
;  If WinExist("ADEVINT-CHDR47T ahk_exe msrdc.exe")
;    winactivate
;  else
;    run, wslg bash -i -c 'terminator'
;  return

;#m::
;  IfWinNotExist ahk_exe OUTLOOK.EXE
;    run, "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
;  If WinActive("ahk_exe OUTLOOK.EXE") {
;    WinGet, Instances, Count, ahk_exe OUTLOOK.exe
;    If Instances > 1
;      WinActivateBottom, ahk_exe OUTLOOK.exe
;  }
;  Else {
;    WinWait, ahk_exe OUTLOOK.EXE
;    winactivate, ahk_exe OUTLOOK.EXE
;  }
;  return

