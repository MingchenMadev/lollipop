#IfWinActive,ahk_class D3 Main Window Class 
#SingleInstance force 

$W:: 
{ 
    MouseGetPos, MouseX, MouseY 
    PixelGetColor, color, %MouseX%, %MouseY% 
    MsgBox, %color%  %MouseX% %MouseY% 
}