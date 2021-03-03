#NoTrayIcon
#pragma compile(Console, True)
#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include "Include/Console.au3"  	; Console stdout with many other functions
#include "Include/Notify.au3"   	; Notify user using default Windows API and some more functions.
#include "Include/Toast.au3"		; Toast like almost same as Notify but it's different position and some more works.
#include "Include/Code128Auto.au3"	; Code128Auto is a fine bar code creator library with default Windows dependencies.

Global $Version 	= "1.0"
Global $Nil 		= 0

; This codes start with uint8_t
 
Global $DOS_BLUE	= 0x1
Global $DOS_GREEN	= 0x2
Global $DOS_AQUA	= 0x3
Global $DOS_RED		= 0x4
Global $DOS_PURPLE 	= 0x5
Global $DOS_YELLOW	= 0x6
Global $DOS_WHITE	= 0x7
Global $DOS_DEFAULT = $DOS_WHITE
Global $DOS_GRAY 	= 0x8

; End of DOS colors.

; Light colors using uint8_t so we can put C style "0x" to using hexadecimal.

Global $LIGHT_BLUE 	= 0x9
Global $LIGHT_GREEN	= 0x0a
Global $LIGHT_AQUA	= 0x0b
Global $LIGHT_RED	= 0x0c
Global $LIGHT_PURPLE = 0x0d
Global $LIGHT_YELLOW = 0x0e
Global $LIGHT_WHITE	 = 0x0f

; End of LIGHT colors.

Main()

Func Main()
For $i = 1 To $CmdLine[$Nil]
	Select
		; Ascii Charecters function
		
		Case $CmdLine[$i] == "ascii"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(Chr($CmdLine[$n]))
				Exit
			Next
			
		; Beep function
		
		Case $CmdLine[$i] == "beep"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					Beep($CmdLine[$n], $CmdLine[$p])
					Exit
				Next
			Next
			
			; Binary length function
			
		Case $CmdLine[$i] == "binlen"
			For $n = $i+1 To $CmdLine[$Nil]
				Local $Binary = Binary($CmdLine[$n])
				Print(BinaryLen($Binary))
				Exit
			Next
		
			; Binary To String function 
			
		Case $CmdLine[$i] == "bintostr"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(BinaryToString($CmdLine[$n], $SB_UTF8)) ; UTF-8 supported by cmd, most of UTF-16 is unsupport and if we use it the only "?" question mark come.
				Exit
			Next
		
		; BlockInput function
		
		Case $CmdLine[$i] == "blockinput"
			For $n = $i+1 To $CmdLine[$Nil]
			Next
		
		Case $CmdLine[$i] == "cdtray"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					If($CmdLine[$n] == "open") Then
						Local $Drive = DriveGetDrive($DT_CDROM)
						If(@error) Then Print("ERROR: CD device not found.") Exit EndIf
						CDTray($Drive[$p], $CDTRAY_OPEN)
						Exit
					ElseIf($CmdLine[$n] == "close") Then
						For $n = $i+1 To $CmdLine[$Nil]
							Local $Drive = DriveGetDrive($DT_CDROM)
							If(@error) Then Print("ERROR: CD device not found.") Exit EndIf
							CDTray($Drive[$n], $CDTRAY_CLOSED)
							Exit
						Next
					EndIf
				Next
			Next
			
			
		Case $CmdLine[$i] == "clipget"
			Print(ClipGet())
			Exit
			
		Case $CmdLine[$i] == "color"
			For $n = $i+1 To $CmdLine[$Nil]
				Cout($CmdLine[$n+1], $CmdLine[$n])
				Exit
			Next
			
		Case $CmdLine[$i] == "colortext"
			For $n = $i+1 To $Cmdline[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					Switch($CmdLine[$n])
						Case "dosblue"
							Cout($CmdLine[$p], $DOS_BLUE)
							Exit
						Case "dosgreen"
							Cout($CmdLine[$p], $DOS_GREEN)
							Exit
						Case "dosaqua"
							Cout($CmdLine[$p], $DOS_AQUA)
							Exit
						Case "dosred"
							Cout($CmdLine[$p], $DOS_RED)
							Exit
						Case "dospurple"
							Cout($CmdLine[$p], $DOS_PURPLE)
							Exit
						Case "dosyellow"
							Cout($CmdLine[$p], $DOS_YELLOW)
							Exit
						Case "doswhite"
							Cout($CmdLine[$p], $DOS_WHITE)
							Exit
						Case "dosgray"
							Cout($CmdLine[$p], $DOS_GRAY)
							Exit
						Case "light-blue"
							Cout($CmdLine[$p], $LIGHT_BLUE)
							Exit
						Case "light-green"
							Cout($CmdLine[$p], $LIGHT_GREEN)
							Exit
						Case "light-aqua"
							Cout($CmdLine[$p], $LIGHT_AQUA)
							Exit
						Case "light-red"
							Cout($CmdLine[$p], $LIGHT_RED)
							Exit
						Case "light-purple"
							Cout($CmdLine[$p], $LIGHT_PURPLE)
							Exit
						Case "light-yellow"
							Cout($CmdLine[$p], $LIGHT_YELLOW)
							Exit
						Case "light-white"
							Cout($CmdLine[$p], $LIGHT_WHITE)
							Exit						
					EndSwitch
				Next
			Next
			
		Case $CmdLine[$i] == "clone"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					If FileExists($CmdLine[$p]) Then 
						Print("Warning: File already exists. It will overwrite. Press a key to continue...")
						system("pause>nul") ; Huh!! Yes, Batch in here!!!
						FileCopy($CmdLine[$n], $CmdLine[$p], $FC_OVERWRITE+$FC_CREATEPATH)
						Exit
					Else
						FileCopy($CmdLine[$n], $CmdLine[$p], $FC_OVERWRITE+$FC_CREATEPATH)
						Exit
					EndIf
				Next
			Next
			
		Case $CmdLine[$i] == "cos"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(Cos($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "dec"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(Dec($CmdLine[$n]))
				Exit
			Next
			
			
		Case $CmdLine[$i] == "dircopy"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					If FileExists($CmdLine[$p]) Then
						Print("Warning: Directory exists. Overwrite? Press a key to proceed.")
						system("pause>nul")
						DirCopy($CmdLine[$n], $CmdLine[$p], $FC_OVERWRITE) ; Let's move onn...
						Exit
					Else
						DirCopy($CmdLine[$n], $CmdLine[$p], $FC_OVERWRITE) ; Let's move onn..
						Exit
					EndIf
				Next
			Next
			
		Case $CmdLine[$i] == "dircreate"
			For $n = $i+1 To $CmdLine[$Nil]
				DirCreate($CmdLine[$n])
				Exit
			Next
			
		; This function is under devolopment.
		
		; Case $CmdLine[$i] == "dirgetsize"
			; For $n = $i+1 To $CmdLine[$Nil]
				; Local $DirSize = Round(DirGetSize($CmdLine[$n], $DIR_EXTENDED)/1024/1024)
				; Print($DirSize)
				; Exit
			; Next
		
		Case $CmdLine[$i] == "dirmove"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					DirMove($CmdLine[$n], $CmdLine[$p], $FC_CREATE+$FC_OVERWRITE)
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "dirremove"
			For $n = $i+1 To $CmdLine[$Nil]
				DirRemove($CmdLine[$n], $DIR_REMOVE)
				Exit
			Next
			
		Case $CmdLine[$i] == "date"
			Print(@MDay & ':' & @Mon & ':' & @Year)
			Exit
			
		Case $CmdLine[$i] == "delete"
			For $n = $i+1 To $CmdLine[$Nil]
				FileDelete($CmdLine[$n])
				Exit
			Next
			
		Case $CmdLine[$i] == "drivefilesys"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(DriveGetFileSystem($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "driveserial"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(DriveGetSerial($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "drivegettype"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(DriveGetType($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "drivestat"
			For $n = $i+1 To $CmdLine[$Nil] ; me again use oh nooo lol
				Print(DriveStatus($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "drivespacefree"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(DriveSpaceFree($CmdLine[$n]) & " MiB")
				Print(DriveSpaceFree($CmdLine[$n])/1024 & " GiB")
				Exit
			Next
			
		Case $CmdLine[$i] == "drivespacetotal"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(DriveSpaceTotal($CmdLine[$n]) & " MiB" & @LF)
				Print(DriveSpaceTotal($CmdLine[$n])/1024 & " GiB")
				Exit
			Next
				
		Case $CmdLine[$i] == "envget"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(EnvGet($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "envset"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					EnvSet($CmdLine[$n], $CmdLine[$p])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "envupdate"
			EnvUpdate()
			
		Case $CmdLine[$i] == "execute"
			For $n = $i+1 To $CmdLine[$Nil]
				Run($CmdLine[$n])
				Exit
			Next
			
		Case $CmdLine[$i] == "exp"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(Exp($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "fileattrib"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(FileGetAttrib($CmdLine[$n]))
				Exit
			Next
			
		
		Case $CmdLine[$i] == "filesize"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(ByteSuffix(FileGetSize($CmdLine[$n])))
				Exit
			Next
			
			
		Case $CmdLine[$i] == "filemove"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					FileMove($CmdLine[$n], $CmdLine[$p], $FC_CREATE+$FC_OVERWRITEE)
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "fileread"
			For $n = $i+1 To $CmdLine[$Nil]
				Local $Open = FileOpen($CmdLine[$n], $FO_READ)
				Print(FileRead($Open))
				FileClose($Open)
				Exit
			Next
			
		Case $CmdLine[$i] == "filereadl"													; So what happens Maruf :P love u too!!
			For	$n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					Local $Open = FileOpen($CmdLine[$n], $FO_READ)
					Print(FileReadLine($CmdLine[$n], $CmdLine[$p]))
					FileClose($CmdLine[$n])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "filerecycle"
			For $n = $i+1 To $CmdLine[$Nil]
				FileRecycle($CmdLine[$n])
				Exit
			Next
			
		
		Case $CmdLine[$i] == "filerecemt"
			FileRecycleEmpty(@HomeDrive)
			Exit
			
		Case $CmdLine[$i] == "filesetattrib"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					FileSetAttrib($CmdLine[$n], $CmdLine[$p])
					Exit
				Next
			Next
			
			
		Case $CmdLine[$i] == "infobox"
			For $n = $i+1 To $CmdLine[$Nil]
				For $p = $n+1 To $CmdLine[$Nil]
					MsgBox(64, $CmdLine[$n], $CmdLine[$p])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "killprocess"
			For $n = $i+1 To $CmdLine[$Nil]
				If not ProcessExists($Cmdline[$n]) Then
					Print("ERROR: Process not found.")
					Exit
				Else
					While(1)
						If(ProcessExists($CmdLine[$n])) Then
							ProcessClose($CmdLine[$n])
						Else
							Exit
						EndIf
					WEnd
				EndIf
			Next
			
		Case $CmdLine[$i] == "lockws"
			DllCall("user32.dll", "int", "LockWorkStation")
			Exit
			
		Case $CmdLine[$i] == "log"
			For $n = $i+1 To $CmdLine[$Nil]
				Print(Log($CmdLine[$n]))
				Exit
			Next
			
		Case $CmdLine[$i] == "mediaplay"
			For $n = $i+1 To $CmdLine[$Nil]
				If FileExists($CmdLine[$n]) Then
					Print("Now playing: " & $CmdLine[$n])
					SoundPlay($CmdLine[$n], $Nil+1)
					Exit
				Else
					Print("ERROR: Music not found.")
					Exit
				EndIf
			Next
			
		Case $CmdLine[$i] == "mousegetpos"
			Local $position = MouseGetPos()
			Print("X:" & $position[0] & "Y:" & $position[1])
			Exit
								
		Case $CmdLine[$i] == "mousemove"
			For $x = $i+1 To $CmdLine[$Nil]
				For $y = $x+1 To $CmdLine[$Nil]
					For $n = $y+1 To $CmdLine[$Nil]
						MouseMove($CmdLine[$x], $CmdLine[$y], $CmdLine[$n])
						Exit
					Next
				Next
			Next
		
		Case $CmdLine[$i] == "mousewheelup"
			For $speed = $i+1 To $CmdLine[$Nil]
				MouseWheel($MOUSE_WHEEL_UP, $CmdLine[$speed])
				Exit
			Next
			
		Case $CmdLine[$i] == "mousewheeldown"
			For $speed = $i+1 To $CmdLine[$Nil]
				MouseWheel($MOUSE_WHEEL_DOWN, $CmdLine[$speed])
				Exit
			Next
			
		Case $CmdLine[$i] == "msgbox"
			For $flag = $i+1 To $CmdLine[$Nil]
				For $title = $flag+1 To $CmdLine[$Nil]
					For $body = $title+1 To $CmdLine[$Nil]
						MsgBox($CmdLine[$flag], $CmdLine[$title], $CmdLine[$body])
						Exit
					Next
				Next
			Next
			
		Case $CmdLine[$i] == "ping"
			For $site = $i+1 To $CmdLine[$Nil]
				For $ms = $site+1 To $CmdLine[$Nil]
					Local $pingAdd = Ping($CmdLine[$site], $CmdLine[$ms])
					If($pingAdd) Then
						Print($CmdLine[$site] & " respond in " & $CmdLine[$ms] & " ms")
						Exit
					Else
						Print("An error occured during ping " & $CmdLine[$site] & @LF)
						Exit
					EndIf
				Next
			Next
			
		Case $CmdLine[$i] == "processchk"
			For $process = $i+1 To $Cmdline[$Nil]
				If(ProcessExists($process)) Then
					Print("EXIST: Process exists.")
					Exit
				Else
					Print("ERROR: Process doesn't exist.")
					Exit
				EndIf
			Next
			
		Case $CmdLine[$i] == "processsetprio"
			For $process = $i+1 To $CmdLine[$Nil]
				For $prority = $process+1 To $CmdLine[$Nil]
					ProcessSetPriority($CmdLine[$process], $CmdLine[$prority])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "random"
			For $p = $i+1 To $CmdLine[$Nil]
				For $n = $p+1 To $CmdLine[$Nil]
					Print(Random($CmdLine[$p], $CmdLine[$n], 1))
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "reboot"
			ShutDown(6)
			Exit
			
		Case $CmdLine[$i] == "regadd"
			For $key = $i+1 To $CmdLine[$Nil]
				For $value = $key+1 To $CmdLine[$Nil]
					For $type = $value+1 To $CmdLine[$Nil]
						For $valueCode = $type+1 To $CmdLine[$Nil]
							RegWrite($CmdLine[$key], $CmdLine[$value], $CmdLine[$type], $Cmdline[$valueCode])
							Exit
						Next
					Next
				Next
			Next
			
			
		Case $CmdLine[$i] == "regdel"
			For $key = $i+1 To $CmdLine[$Nil]
				For $value = $key+1 To $CmdLine[$Nil]
					RegDelete($CmdLine[$key], $CmdLine[$value])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "regread"
			For $key = $i+1 To $CmdLine[$Nil]
				For $value = $key+1 To $CmdLine[$Nil]
					RegRead($CmdLine[$key], $CmdLine[$value])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "round"
			For $p = $i+1 To $CmdLine[$Nil]
				For $n = $p+1 To $CmdLine[$Nil]
					Print(Round($CmdLine[$p], $CmdLine[$n]))
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "run"
			For $program = $i+1 To $CmdLine[$Nil]
				Run($CmdLine[$program])
				Exit
			Next
			
		Case $CmdLine[$i] == "send"
			For $text = $i+1 To $CmdLine[$Nil]
				Send($CmdLine[$text])
				Exit
			Next
		
		Case $CmdLine[$i] == "sendactive"
			For $class = $i+1 To $CmdLine[$Nil]
				SendKeepActive("[CLASS:" & $CmdLine[$class] & "]")
				Exit
			Next
			
		Case $CmdLine[$i] == "shellexe"
			For $program = $i+1 To $CmdLine[$Nil]
				ShellExecute($CmdLine[$program])
				Exit
			Next
			
		Case $CmdLine[$i] == "shellexewait"
			For $program = $i+1 To $CmdLine[$Nil]
				ShellExecuteWait($CmdLine[$program])
				Exit
			Next
			
		Case $CmdLine[$i] == "shutdown"
			ShutDown(1)
			Exit
		
		Case $CmdLine[$i] == "sin"
			For $p = $i+1 To $CmdLine[$Nil]
				Print(Sin($CmdLine[$p]))
				Exit
			Next
			
		Case $CmdLine[$i] == "sleep"
			For $p = $i+1 To $CmdLine[$Nil]
				Sleep($CmdLine[$p])
				Exit
			Next
			
		Case $CmdLine[$i] == "soundplay"
			For $p = $i+1 To $CmdLine[$Nil]
				SoundPlay($Cmdline[$p], 1)
				Exit
			Next
			
		Case $CmdLine[$i] == "splash"
			For $title = $u+1 To $CmdLine[$Nil]
				For $imagename = $title+1 To $CmdLine[$Nil]
					For $x = $imagename+1 To $CmdLine[$Nil]
						For $y = $x+1 To $CmdLine[$Nil]
							SplashImageOn($CmdLine[$title], $Cmdline[$imagename], $CmdLine[$x], $CmdLine[$y])
							Exit
						Next
					Next
				Next
			Next
			
		Case $Cmdline[$i] == "sqrt"
			For $p = $i+1 To $CmdLine[$Nil]
				Print(Sqrt($Cmdline[$p]))
				Exit
			Next
			
		Case $CmdLine[$i] == "strleft"
			For $str = $i+1 To $CmdLine[$Nil]
				For $num = $str+1 To $CmdLine[$Nil]
					Local $string = StringLeft($str, $num)
					Print($CmdLine[$string])
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "strlen"
			For $str = $i+1 To $CmdLine[$Nil]
				Print(StringLen($CmdLine[$str]))
				Exit
			Next
			
		Case $CmdLine[$i] == "strlow"
			For $str = $i+1 To $CmdLine[$Nil]
				Print(StringLower($CmdLine[$str]))
				Exit
			Next
			
		Case $CmdLine[$i] == "strmid"
			For $str = $i+1 To $CmdLine[$Nil]
				For $char = $str+1 To $CmdLine[$Nil]
					For $pos = $char+1 To $CmdLine[$Nil]
						Print(StringMid($Cmdline[$str], $CmdLine[$pos], $CmdLine[$char]))
						Exit
					Next
				Next
			Next
		
		Case $CmdLine[$i] == "strrep"
			For $str = $i+1 To $CmdLine[$Nil]
				For $char = $str+1 To $CmdLine[$Nil]
					For $replace = $char+1 To $CmdLine[$Nil]
						Print(StringReplace($CmdLine[$str], $Cmdline[$char], $CmdLine[$replace]))
						Exit
					Next
				Next
			Next
			
		Case $CmdLine[$i] == "strrev"
			For $str = $i+1 To $CmdLine[$Nil]
				Print(StringReverse($CmdLine[$str]))
				Exit
			Next
			
		Case $CmdLine[$i] == "strright"
			For $str = $i+1 To $CmdLine[$Nil]
				For $char = $str+1 To $CmdLine[$Nil]
					Print(StringRight($CmdLine[$str], $CmdLine[$char]))
					Exit
				Next
			Next
			
		Case $CmdLine[$i] == "strupr"
			For $str = $i+1 To $CmdLine[$Nil]
				Print(StringUpper($CmdLine[$str]))
				Exit
			Next
			
		Case $CmdLine[$i] == "tan"
			For $p = $i+1 To $CmdLine[$Nil]
				Print(Tan($CmdLine[$p]))
				Exit
			Next
			
		Case $CmdLine[$i] == "tooltip"
			For $body = $i+1 To $CmdLine[$Nil]
				For $title = $body+1 To $CmdLine[$Nil]
					For $x = $title+1 To $CmdLine[$Nil]
						For $y = $x+1 To $CmdLine[$Nil]
							For $sleep = $y+1 To $CmdLine[$Nil]
								ToolTip($CmdLine[$body], $CmdLine[$title], $Cmdline[$x], $CmdLine[$y])
								Sleep($CmdLine[$sleep]) ; Multiply to 1000 to seconds
								Exit
							Next
						Next
					Next
				Next
			Next
			
		Case $CmdLine[$i] == "winactive"
			For $window = $i+1 To $CmdLine[$Nil]
				If(WinActive("CLASS:" & $CmdLine[$window])) Then
					Print($CmdLine[$window] & " is active.")
					Exit
				Else
					Print($CmdLine[$window] & " is not active.")
					Exit
				EndIf
			Next
			
			
						
						; Switch(
	EndSelect
Next

EndFunc



Func Print($Data)
	Return ConsoleWrite($Data)
EndFunc

Func PrevAndExit()
	BlockInput($BI_ENABLE) ; Enables as previous
EndFunc

Func ByteSuffix($iBytes)
	Local $iIndex = 0, $aArray = [' bytes', ' KiB', ' MiB', ' GiB', ' TiB', ' PiB', ' EiB', ' ZiB', ' YiB']
	While $iBytes > 1023
		$iIndex += 1
		$iBytes /= 1024
	WEnd
	Return Round($iBytes) & $aArray[$iIndex]
EndFunc   ;==>ByteSuffix
