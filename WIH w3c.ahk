; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT/XP/Vista/7/10
; Author:         AucT <AucT.eu@gmail.com>
; Web-Site:		  https://wih.auct.eu/
;********************************************FORCE TO RUN AS ADMIN*************************
RegRead, UAC, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System, EnableLUA
FileInstall, images\wih_inventory.jpg, %A_temp%\wih_inventory.jpg

GroupAdd, WC3DOTA , Warcraft III
;********************************************INITIAL SCRIPT SETTINGS*************************
  #UseHook on                    ;forces to use it at start and not in game
  #SingleInstance force          ;makes sure second execution of the tool will stop teh first
  #HotkeyInterval 0
  #NoEnv
  #InstallKeybdHook       ;Forces the unconditional installation of the keyboard hook
  #UseHook On         ;might increase responsiveness of hotkeys
  #MaxThreads
  Process, priority, , High
  SetWorkingDir %A_ScriptDir%
  SetBatchLines, -1
  SetKeyDelay , -1, -1
  SetDefaultMouseSpeed, 0

  VK_LIST = VK41,VK42,VK43,VK44,VK45,VK46,VK47,VK48,VK49,VK4A,VK4B,VK4C,VK4D,VK4E,VK4F,VK50,VK51,VK52,VK53,VK54,VK55,VK56,VK57,VK58,VK59,VK5A,VK30,VK31,VK32,VK33,VK34,VK35,VK36,VK37,VK38,VK39,VKC0,VKDB,VKDD,VKBE,VKBF,VKBA,VKDE,VKDC
  HK_LIST = A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,``,[,],.,/,;,',\

Version=WIH v1.1.1 (w3c)

IniRead, WorkEverywhere, %A_WorkingDir%\wih.ini, Others, WorkEverywhere, 0
if !WorkEverywhere
Hotkey, IfWinActive, ahk_group WC3DOTA

;************************************************STYLE COLOR**********************************************

;************************************************TRAY MENU********************************************************
  ;Menu
  Menu, tray, NoStandard
  Menu, Tray, Click, 1
  Menu, tray, add, Show, showApp
  Menu, tray, Default, Show
  Menu, tray, add, Reload, ButtonReload
  Menu, tray, add, Exit
  Menu, Tray, Icon, %A_ScriptDir%\%A_ScriptName%,1,1

  CoordMode,Mouse,Screen
  
  IniRead, ScrollIndicator, %A_WorkingDir%\wih.ini, Others, ScrollIndicator, 0
  if ScrollIndicator
  SetScrollLockState, On
  else 
  SetScrollLockState, Off

  ;Hotkey, IfWinActive, ahk_group WC3DOTA
  IniRead, WMC, %A_WorkingDir%\wih.ini,Others, WMC, 0
  IniRead, WMChotkey, %A_WorkingDir%\wih.ini,Others, WMChotkey, %A_Space%
;************************************************INVENTORY*************************************
  
  IniRead, EnInventory, %A_WorkingDir%\wih.ini, Inventory, EnInventory, 1
  IniRead, h1, %A_WorkingDir%\wih.ini, Inventory, item1, %A_Space%
  IniRead, h2, %A_WorkingDir%\wih.ini, Inventory, item2, %A_Space%
  IniRead, h3, %A_WorkingDir%\wih.ini, Inventory, item3, %A_Space%
  IniRead, h4, %A_WorkingDir%\wih.ini, Inventory, item4, %A_Space%
  IniRead, h5, %A_WorkingDir%\wih.ini, Inventory, item5, %A_Space%
  IniRead, h6, %A_WorkingDir%\wih.ini, Inventory, item6, %A_Space%
  if %EnInventory%
  {
  i1:=VK(h1)
  i2:=VK(h2)
  i3:=VK(h3)
  i4:=VK(h4)
  i5:=VK(h5)
  i6:=VK(h6)
  

	if i1 {
	Hotkey,%i1%, i1
	Hotkey,+%i1%, i1
	}
	if i2 {
	Hotkey,%i2%, i2
	Hotkey,+%i2%, i2
	}
	if i3 {
	Hotkey,%i3%, i3
	Hotkey,+%i3%, i3
	}
	if i4 {
	Hotkey,%i4%, i4
	Hotkey,+%i4%, i4
	}
	if i5 {
	Hotkey,%i5%, i5
	Hotkey,+%i5%, i5
	}
	if i6 {
	Hotkey,%i6%, i6
	Hotkey,+%i6%, i6
	}
} 

;************************************************OTHER*********************************	
IniRead, sound, %A_WorkingDir%\wih.ini, Others, sound, 0
IniRead, Shield, %A_WorkingDir%\wih.ini, Others, Shield, 0
IniRead, ShieldR, %A_WorkingDir%\wih.ini, Others, ShieldR, 0
if Shield
Hotkey, LWin, disable
if ShieldR
Hotkey, RWin, disable

	
	IniRead, toggle, %A_WorkingDir%\wih.ini,Others, toggle, Home
	if %toggle%
	Hotkey,% VK(toggle), Switch
	
	IniRead, pause, %A_WorkingDir%\wih.ini,Others, pause, !P
	if %pause%
	Hotkey,% VK(pause), PauseGame

  ;***************************
 	;Chat Suspending
	IniRead, chat, %A_WorkingDir%\wih.ini, Others, chat, 1
	if chat
	{
	Hotkey,*Enter, SendEnt
	Hotkey,*NumpadEnter, SendEnt
	Hotkey, ~*Esc, KEYSON
	Hotkey, ~LButton, KEYSON
	}

;************************************************KEY REMAP*********************************	
  loop, 35 {
    IniRead, krh%A_Index%, %A_WorkingDir%\wih.ini,RemapKey, KRhotkey%A_Index%, %A_Space%
    IniRead, krv%A_Index%, %A_WorkingDir%\wih.ini,RemapKey, KRvalue%A_Index%, %A_Space%
    if krh%A_Index%
    Hotkey,% VK(krh%A_Index%), krv%A_Index%
}
;==================================================================================
;=====================================GUI==========================================
;==================================================================================

showApp:
if ConfigCreated
{
  Gui, show, xCenter yCenter h455 w300, %Version%
}
else {
ConfigCreated:=1


Menu, Options, Add, Scroll Indicator, SetScrollIndicator
Menu, Options, Add, Sound Indicator, SetSoundIndicator
Menu, Options, Add
Menu, Options, Add, Shield LeftWin, SetShieldLWin
Menu, Options, Add, Shield RightWin, SetShieldRWin
Menu, Options, Add
Menu, Options, Add, Work Everywhere, WorkEverywhereFun

Menu, Chat-Suspend, Add, Chat-free in game, Setchat
Menu, Chat-Suspend, Add, Chat-free Info, ChatFreeInfo


if chat
menu, Chat-Suspend, check, Chat-free in game
if ScrollIndicator
menu, Options, check, Scroll Indicator
if sound
menu, Options, check, Sound Indicator
if Shield
menu, Options, check, Shield LeftWin
if ShieldR
menu, Options, check, Shield RightWin
if WorkEverywhere
menu, Options, check, Work Everywhere

Menu, HelpMenu, Add, &About, About
Menu, HelpMenu, Add, &How to use, Help


; Create the menu bar by attaching the sub-menus to it:
Menu, MyMenuBar, Add, Options, :Options
Menu, MyMenuBar, Add, Chat-Suspend, :Chat-Suspend
Menu, MyMenuBar, Add, Help, :HelpMenu


Gui, Menu, MyMenuBar


Gui, Add, Tab2, x0 y0 w470 h520 , Inventory|Remap
Gui, Tab, Inventory

Gui, Add, Picture, x16 y45 w268 h320 , %A_temp%\wih_inventory.jpg
Gui, Add, Checkbox, Checked%EnInventory% vEnInventory gSwitchInv x16 y28 , Enable Keys
Gui, Add, button, vb1 gSetItem x55 y138 w75 h30,%h1%
Gui, Add, button, vb2 gSetItem x150 y138 w75 h30,%h2%
Gui, Add, button, vb3 gSetItem x55 y223 w75 h30,%h3%
Gui, Add, button, vb4 gSetItem x150 y223 w75 h30,%h4%
Gui, Add, button, vb5 gSetItem x55 y313 w75 h30,%h5%
Gui, Add, button, vb6 gSetItem x150 y313 w75 h30,%h6%



Gui, Add, Hotkey, vtoggle gtoggle x16 y375 w60, %toggle%
Gui, Add, Text, x81 y378, Pause Script
Gui, Add, Hotkey, vpause gpause x155 y375 w60, %pause%
Gui, Add, Text, x220 y378, Pause Game

if EnInventory=0
Gosub, SwitchInv


Gui, Tab, Remap
gui, font
gui, font, s14
Gui, Add, ListBox, x16 y60 w268 h350 vRemap_Key gRemap_Update
gui, font



gui, add, hotkey,vHK_Remap x16 y30 w60 h25,
gui, add, hotkey,vValue_Remap x86 y30 w60 h25,
gui, add, button, gAddRemap x156 y30 w60 h25, ADD
gui, add, button, gDeleteRemap x222 y30 w60 h25, DELETE

gosub, Remap_KeyUpdate

Gui, Tab

gui, font, bold
Gui, Add, Button, x16 y410 w80 h30,Hide
Gui, Add, Button, gButtonReload x110 y410 w80 h30,Save
Gui, Add, Button, x204 y410 w80 h30,Exit

;Gui, Show, x209 y100 h455 w300, %Version%
;Gui, show, autosize center, %Version%
Gui, show, xCenter yCenter h455 w300, %Version%
}
EmptyMem()
return


ChatFreeInfo:
info =
(
The system for suspending the script when chatting works in Warcraft 3 and will check enter presses to detect chat. It's not reliable, but if you press enter only for chatting it should work.

You can enable the 'Scroll Indicator' or 'Sound Indicator' options located in the Options menu to know if it is working as expected.

The Scroll Indicator sets Scroll Lock on your keyboard when the script is running.

The Sound Indicator plays a sound when the script switches on or off.
)

MsgBox 64, Suspend Script When Chatting Info,%info%
return


Help:
run, https://wih.auct.eu/tutorial.html
return


About:
if aboutcreated
gui, 2:show, autosize center, About
else {
Gui +Disabled  ; Disable main window.
Gui 2:Default
Gui, +owner1  ; Make the main window (Gui #1) the owner of the "about box" (Gui #2).


gui, font,s10 cblue
Gui, Add, GroupBox, x10 y0 w330 R1 , Author
gui, font, s10 underline
Gui, add, text,x140 y25 gmailauct,AucT


gui, font,s10 cblue
Gui, Add, GroupBox, x10 w330 R1 , Website

gui, font, s10 underline
Gui, add, text,x100 y70 gWIHWEBSITE, https://wih.auct.eu/

gui, font, s10
gui, add, button, x10 y+20 w330, OK

gui, show, autosize center, About
aboutcreated:=1
}
return


2ButtonOK:
2GuiClose:
2GuiEscape:
Gui, 1:-Disabled  ; Re-enable the main window (must be done prior to the next step).
Gui, hide  ; Destroy the about box.
return


WIHWEBSITE:
run, https://wih.auct.eu/
return
mailauct:
run, mailto:AucT.eu@gmail.com?Subject=WIH
return




SetScrollIndicator:
ScrollIndicator:=!ScrollIndicator
IniWrite, %ScrollIndicator%, %A_WorkingDir%\wih.ini, Others, ScrollIndicator
menu, options, togglecheck, Scroll Indicator
return

SetSoundIndicator:
sound:=!sound
IniWrite, %sound%, %A_WorkingDir%\wih.ini, Others, sound
menu, options, togglecheck, Sound Indicator
return

SetShieldLWin:
Shield:=!Shield
IniWrite, %Shield%, %A_WorkingDir%\wih.ini, Others, Shield
menu, options, togglecheck, Shield LeftWin
return

SetShieldRWin:
ShieldR:=!ShieldR
IniWrite, %ShieldR%, %A_WorkingDir%\wih.ini, Others, ShieldR
menu, options, togglecheck, Shield RightWin
return

WorkEverywhereFun:
WorkEverywhere:=!WorkEverywhere
IniWrite, %WorkEverywhere%, %A_WorkingDir%\wih.ini, Others, WorkEverywhere
menu, options, togglecheck, Work Everywhere
return

SetChat:
chat:=!chat
IniWrite, %chat%, %A_WorkingDir%\wih.ini, Others, chat
menu, Chat-Suspend, togglecheck, Chat-free in game
return

SetItem:
ChoosenB=%A_GuiControl%
;Gui , 2:+Disabled
;Gui , 2:-Minimizebox +owner2
Gui 4:Default
gui, destroy
Gui, Add, GroupBox, w220 h50, Modifier
gui, add, checkbox, vAltModifier xp+15 yp+20 gHotkey_UpdateHotkey, &Alt
gui, add, checkbox, vCtrlModifier x+0 gHotkey_UpdateHotkey, &Ctrl
gui, add, checkbox, vShiftModifier x+0 gHotkey_UpdateHotkey, &Shift
gui, add, checkbox, vWinModifier x+0 gHotkey_UpdateHotkey, &Win

gui, add, groupbox,x10 w220 h180, Keys

gui, add, radio, xp+5 yp+30 vRadioKey gHotkey_UpdateKeyList Checked, Standart
gui, add, radio, y+10 gHotkey_UpdateKeyList, Function
gui, add, radio, y+10 gHotkey_UpdateKeyList, Numpad
gui, add, radio, y+10 gHotkey_UpdateKeyList, Mouse
gui, add, radio, y+10 gHotkey_UpdateKeyList, Multimedia
gui, add, radio, y+10 gHotkey_UpdateKeyList, None

gui, add, listbox, x110 y85 w120 h150 vHG_Key gHotkey_UpdateHotkey
gosub, Hotkey_UpdateKeyList
gui, add, text, x10 y250 w40 h20, Key:
gui, add, edit, vhotkeyshow x+5 w190 h20 +readonly

gui, add, text, x10 y+5 w40 h20, Desc:
gui, add, text, vdescshow x+5 w190 h20 +readonly, None

gui, add, button, x25 y300 w100 h30 gHotkey_AcceptButton, Accept
gui, add, button, x+5 w100 h30 gHotkeyClose, Cancel

gui, show, autosize center, Choose hotkey...

return

;==================================Hotkey Mechanism============================================
HotkeyClose:
gui, 4:destroy
return

Hotkey_AcceptButton:
Gui, Submit
i := SubStr(ChoosenB,2)
loop, 18
{
if HG_Hotkey and HG_Hotkey=h%A_Index%
{
gui, 4:destroy
HG_Hotkey=
MsgBox 262160, Error ,Dublicate Hotkeys not allowed
return
}
}

h%i%=%HG_Hotkey%
i2:=i-6
if i<7
IniWrite, %HG_Hotkey%, %A_WorkingDir%\wih.ini, Inventory, item%i%
else
IniWrite, %HG_Hotkey%, %A_WorkingDir%\wih.ini, RemapKey, KRhotkey%i2%
gui, 4:destroy
hDialog:=0
Gui 1:Default
GuiControl Text, %ChoosenB%, %HG_Hotkey%
HG_Hotkey=
return

Hotkey_UpdateKeyList:
Gui 4:Default
Gui, Submit, Nohide
GUIControl -Redraw,HG_Key
if (RadioKey = 1)
GuiControl,, HG_Key, |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|1|2|3|4|5|6|7|8|9|0|``|-|=|\|[|]|;|'|,|.|/|Space|Tab|Enter|Escape|Delete|ScrollLock|CapsLock|NumLock|PrintScreen|BackSpace|CtrlBreak|Pause|Break|Up|Down|Left|Right|Home|End|Insert|Page Up|Page Down
if (RadioKey = 2)
GuiControl,, HG_Key, |F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|LWin|RWin|LControl|RControl|LShift|RShift|LAlt|RAlt
if (RadioKey = 3)
GuiControl,, HG_Key, |Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|Numpadmult|NumpadAdd|NumpadSub|NumpadDiv|NumpadDot|NumpadEnter
if (RadioKey = 4)
GuiControl,, HG_Key, |LButton|RButton|MButton|WheelUp|WheelDown|XButton1|XButton2
if (RadioKey = 5)
GuiControl,, HG_Key, |Browser_back|Browser_forward|Browser_refresh|Browser_stop|Browser_search|Browser_favorites|Browser_home|volume_mute|volume_down|volume_up|Media_next|Media_prev|Media_stop|Media_play_h8|launch_media|launch_mail|launch_app1|launch_app2|Help|Sleep
if (RadioKey = 6)
GuiControl,, HG_Key, |%A_Blank%
GUIControl +Redraw,HG_Key
return


Hotkey_UpdateHotkey:
gui, submit, nohide
HG_Hotkey=
HG_HKDesc=
    if CtrlModifier
        {
        HG_Hotkey:=HG_Hotkey . "^"
        HG_HKDesc:=HG_HKDesc . "Ctrl + "
        }
    
    if ShiftModifier
        {
        HG_Hotkey:=HG_Hotkey . "+"
        HG_HKDesc:=HG_HKDesc . "Shift + "
        }
    
    if WinModifier
        {
        HG_Hotkey:=HG_Hotkey . "#"
        HG_HKDesc:=HG_HKDesc . "Win + "
        }
    
    if AltModifier
        {
        HG_Hotkey:=HG_Hotkey . "!"
        HG_HKDesc:=HG_HKDesc . "Alt + "
        }
		
	HG_Hotkey:=HG_Hotkey . HG_Key
    HG_HKDesc:=HG_HKDesc . HG_Key

    GUIControl ,,hotkeyshow,%HG_Hotkey%
    GUIControl ,,descshow,%HG_HKDesc%
	if a_guievent = DoubleClick
	gosub, Hotkey_AcceptButton
return



3GuiEscape:
3GuiClose:
3ButtonCancel:
Gui, destroy
return

4GuiEscape:
4GuiClose:
gui, 4:destroy
return

GuiEscape:
GuiClose:
ButtonHide:
Gui, Hide
return

ButtonExit:
Exit:
ExitApp
return

ButtonReload:
reload
return



SwitchInv:
;Gui,submit,nohide
GuiControlGet, EnInventory
IniWrite, %EnInventory%, %A_WorkingDir%\wih.ini, Inventory, EnInventory
if (EnInventory=1){
GuiControl, Enable, b1
GuiControl, Enable, b2
GuiControl, Enable, b3
GuiControl, Enable, b4
GuiControl, Enable, b5
GuiControl, Enable, b6
}
else{
GuiControl, Disable, b1
GuiControl, Disable, b2
GuiControl, Disable, b3
GuiControl, Disable, b4
GuiControl, Disable, b5
GuiControl, Disable, b6
}
return


;=======================================END of GUI===============================

;=======================================SAVE INI=================================

chat:
ScrollIndicator:
sound:
Shield:
pause:
toggle:
gui, submit, nohide
IniWrite, % %A_ThisLabel%, %A_WorkingDir%\wih.ini, Others, %A_ThisLabel%
return

;=====================================CORE CODE=================================

;====================================INVENTORY==================================
i1:
send {vk67}
return

i2:
send {vk68}
return
 
i3:
send {vk64}
return

i4:
send {vk65}
return

i5:
send {vk61}
return

i6:
send {vk62}
return

;********************************************OTHER*********************************
disable:
return

;********************************************REMAP*********************************



;********************************************REMAP END*********************************

Switch:
Suspend
if !A_IsSuspended{
   Hotkey,*Enter, SendEnt,on
   Hotkey,*NumpadEnter, SendEnt,on
   Hotkey, ~*Esc, KEYSON,on
   Hotkey, ~LButton, KEYSON,on
   if ScrollIndicator
   SetScrollLockState, On
   if Sound
   soundplay, *48
}
Else{
   Hotkey,*Enter, SendEnt,off
   Hotkey,*NumpadEnter, SendEnt,off
   Hotkey, ~*Esc, KEYSON,off
   Hotkey, ~LButton, KEYSON,off
   if ScrollIndicator
   SetScrollLockState, Off
   if Sound
   soundplay, *64
}
return

KEYSON:
Suspend, Permit
Suspend, Off
if ScrollIndicator
SetScrollLockState, On
return

SendEnt:
	Suspend, Permit
	Send, {Blind}{Enter}
	Suspend
	if !A_IsSuspended
		{
		if ScrollIndicator
		SetScrollLockState, On
		if Sound
		soundplay, *48
		}
	Else {
		if ScrollIndicator
		SetScrollLockState, Off
		if Sound
		soundplay, *64
		}
	return



PauseGame:
send {vk79}{vk4D}{vk52}
return




Remap_Update:
gui, submit, nohide
Remap_Keyi=% getKRIndex(Remap_Key)
IniRead, H, %A_WorkingDir%\wih.ini,RemapKey, KRhotkey%Remap_Keyi%, %A_Space%
IniRead, M, %A_WorkingDir%\wih.ini,RemapKey, KRvalue%Remap_Keyi%, %A_Space%
GUIControl ,,HK_Remap,%H%
GUIControl ,,Value_Remap,%M%
return

Remap_KeyUpdate:
  Remap_KeyList=
  loop, 36 {
  IniRead, rh, %A_WorkingDir%\wih.ini,RemapKey, KRhotkey%A_Index%, %A_Space%
  IniRead, rv, %A_WorkingDir%\wih.ini,RemapKey, KRvalue%A_Index%, %A_Space%
  if rh
  Remap_KeyList=%Remap_KeyList%|%rh% => %rv%
  }
  GuiControl,, Remap_Key,%Remap_KeyList%
return

AddRemap:
gui, submit, nohide
if HK_Remap=
{
MsgBox 262160, Error ,Choose hotkey first!
return
}
loop {
IniRead, h, %A_WorkingDir%\wih.ini, RemapKey, KRhotkey%A_Index%, %A_Space%
  if !h
  {
  i=%A_Index%
  break
  }
}
IniWrite, %HK_Remap%, %A_WorkingDir%\wih.ini, RemapKey, KRhotkey%i%
IniWrite, %Value_Remap%, %A_WorkingDir%\wih.ini, RemapKey, KRvalue%i%

gosub, Remap_KeyUpdate
GUIControl ,,HK_Remap,
GUIControl ,,Value_Remap,
HK_Remap=
Value_Remap=
return


DeleteRemap:
gui, submit, nohide
Remap_Keyi=% getKRIndex(Remap_Key)
IniWrite, %A_Space%, %A_WorkingDir%\wih.ini,RemapKey, KRhotkey%Remap_Keyi%
IniWrite, %A_Space%, %A_WorkingDir%\wih.ini,RemapKey, KRvalue%Remap_Keyi%
gosub, Remap_KeyUpdate
GUIControl ,,HK_Remap,
GUIControl ,,Value_Remap,
HK_Remap=
Value_Remap=
return

getKRIndex(a) {
global
loop, 36 {
IniRead, h, %A_WorkingDir%\wih.ini, RemapKey, KRhotkey%A_Index%, %A_Space%
  if h and (h = SubStr(a,1,StrLen(h)))
  {
  i=%A_Index%
  return i
  }
}
return
}

krv1:
krv2:
krv3:
krv4:
krv5:
krv6:
krv7:
krv8:
krv9:
krv10:
krv11:
krv12:
krv13:
krv14:
krv15:
krv16:
krv17:
krv18:
krv19:
krv20:
krv21:
krv22:
krv23:
krv24:
krv25:
krv26:
krv27:
krv28:
krv29:
krv30:
krv31:
krv32:
krv33:
krv34:
krv35:

v:=% %A_ThisLabel%
v:=VK(v)

if v {
send {%v%}
}
return


VK(Param)
{
	global
	if InStr(Param,"[")
	return % RegExReplace(Param, "\[$", "VKDB")
	if InStr(Param,"]")
	return % RegExReplace(Param, "\]$", "VKDD")
	if InStr(Param,"\")
	return % RegExReplace(Param, "\\$", "VKDC")
	if InStr(Param,",")
	return % RegExReplace(Param, "\,$", "VKBC")
	if InStr(Param,".")
	return % RegExReplace(Param, "\.$", "VKBE")
	if InStr(Param,"/")
	return % RegExReplace(Param, "\/$", "VKBF")
	Hotkey:=RegExReplace(Param, "[\^\!\+\#]+(.*)", "$1")
	If StrLen(Hotkey) > 1
		return Param
	Loop, parse, HK_LIST, CSV
		If (Hotkey = A_LoopField)
		{
			Index := A_Index
			Loop, parse, VK_LIST, CSV
				If (A_Index = Index)
					return % RegExReplace(Param, "(.*)" Hotkey, "$1" A_LoopField)
		}
}

EmptyMem(PID="WIH.v1.1.1.w3c"){
    pid:=(pid="WIH.v1.1.1.w3c") ? DllCall("GetCurrentProcessId") : pid
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", pid)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
}
