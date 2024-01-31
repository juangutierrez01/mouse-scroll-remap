#Requires AutoHotkey v2.0

TraySetIcon "mouse.ico"

; Deactivate scroll wheel
*WheelUp::return
*WheelDown::return

; Use mouse side buttons to scroll
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