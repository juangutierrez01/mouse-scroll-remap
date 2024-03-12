#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Increase the process priority to see if that stops
; the script from sporadically holding and sending
; XButton1/XButton2 inputs when it shouldn't
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ProcessSetPriority "AboveNormal"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set the tray icon
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TraySetIcon "mouse.ico"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Allow disabling of physical scroll wheel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ScrollWheelDisabled := false

; Add Tray Icon Menu Option
A_TrayMenu.Insert("1&", "Disable Physical Scroll Wheel", ToggleScrollWheel)
A_TrayMenu.Insert("2&")

ToggleScrollWheel(*)
{
    global ScrollWheelDisabled := !ScrollWheelDisabled

    ; Toggle the Checkmark on Tray Menu
    A_TrayMenu.ToggleCheck("1&")

    ; Toggle "too many hotkeys too fast" warning because deactivating the scroll
    ; wheel counts as a hotkey and if the scroll wheel is physically used,
    ; it sends off many hotkey activations in a short period of time
    A_HotkeyInterval := 2000 - A_HotkeyInterval
}

; Conditionally disable scroll wheel
#HotIf ScrollWheelDisabled
*WheelUp::return
*WheelDown::return
#HotIf ; ScrollWheelDisabled

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Use mouse side buttons to scroll
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*XButton1::
{
    Click "WheelDown"
    Sleep 150

    While GetKeyState("XButton1", "P")
    {
        Click "WheelDown"
        Sleep 100
    }
}

*XButton2::
{
    Click "WheelUp"
    Sleep 150

    While GetKeyState("XButton2", "P")
    {
        Click "WheelUp"
        Sleep 100
    }
}