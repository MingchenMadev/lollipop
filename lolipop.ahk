#IfWinActive,ahk_class D3 Main Window Class 
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动

/* 
键位 
Q 黑洞 
W 黑人 
E 魔法武器 
F 风暴护甲 
鼠标左键 奥数洪流 
鼠标右键 传送 
*/ 

SetKeyDelay, 50
SetMouseDelay, 50

masterFlag = 0  ;宏控制变量
clickFlag = 0 ;控制左键连点的变量
WinGetPos,X,Y,Width, Height, A ;判断你的游戏窗口分辨率


$MButton::  ;鼠标中键为宏开关键，可修改为其它键
{ 
	if(masterFlag=0){
		masterFlag := 1
		clickFlag := 1
	}
	else{
		masterFlag := 0
		clickFlag := 0
	}

	if (masterFlag=0) 
	{
		SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
		SetTimer, Lollipop, off  ;关闭
		clickFlag := 0
	}	
}
Return 

Always:
{
	WinGetPos,X,Y,Width, Height, A ;判断你的游戏窗口分辨率
	PixelGetColor, colorH, Ceil(Width*0.4412), Ceil(Height*0.9574) ;寻找你“4”技能图标位置
	scolor := SubStr(colorH, 3, 1) ;PixelGetColor, color2, 1145, 1370
	if (scolor = 1)
	{
		SetTimer, MouseLButton, 50 ;
		SetTimer, Lollipop, 50  ;
	}
}
Return

$x::
{
	WinGetPos,X,Y,Width, Height, A ;判断你的游戏窗口分辨率
	PixelGetColor, colorH, Ceil(Width*0.4412), Ceil(Height*0.9574) ;寻找你“4”技能图标位置
	scolor := SubStr(colorH, 3, 1) ;PixelGetColor, color2, 1145, 1370
	if (scolor = 1)
	{
		SetTimer, MouseLButton, 50 ;
		SetTimer, Lollipop, 50  ;
	}
}
Return

$c::
{
	SetTimer, MouseLButton, off ;
	SetTimer, Lollipop, off  ;
	clickFlag := 0 
}
Return

$q::  ;q键为宏开关键，可修改为其它键
{
	if (masterFlag=1) 
	{	
		send {q}
		RandSleep(300,700)
		WinGetPos,X,Y,Width, Height, A ;判断你的游戏窗口分辨率
		PixelGetColor, colorH, Ceil(Width*0.4412), Ceil(Height*0.9574) ;寻找你“4”技能图标位置
		scolor := SubStr(colorH, 3, 1) ;PixelGetColor, color2, 1145, 1370
		if (scolor = 1)
		{
		SetTimer, MouseLButton, 50 ;
		send {w}
		SetTimer, Lollipop, 50  ;
		}
	}
}
Return

$XButton1::  ;开关鼠标连点，键时鼠标第四键，可修改
{ 
	clickFlag := !clickFlag
}
Return 

closeClick:  ;开关鼠标连点
{ 
	clickFlag := 0
}
Return 

~Enter::  ;回车打字关闭宏
~T::   ;按T回城关闭宏
~S::   ;按S查看技能关闭宏
~B::   ;按B查看装备关闭宏
~M::   ;按M查看悬赏关闭宏
~I::   ;按I查看悬赏关闭宏
~P::   ;按P查看悬赏关闭宏
~Tab:: ;查看小地图临时关闭宏，再按TAB键继续宏
{
	SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
	SetTimer, Lollipop, off  ;关闭
	SetTimer, Always, off ;关闭
	masterFlag := 0
	clickFlag := 0
}
Return

MouseLButton:   ;左键连点计时器设置
{
	if(clickFlag = 1){
		Click    ;点击鼠标左键，对应主要技能
	}
}

Lollipop:
{
	WinGetPos,X,Y,Width, Height, A ;判断你的游戏窗口分辨率
	PixelGetColor, colorH, Ceil(Width*0.4412), Ceil(Height*0.9574) ;寻找你“4”技能图标位置
	scolor := SubStr(colorH, 3, 1) ;PixelGetColor, color2, 1145, 1370
	if (scolor = 1)
	{
		send {q} ;q为变身后无脑使用的寒冰轰击的快捷键，可自行修改
	}
	else{
		SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
		SetTimer, Lollipop, off  ;关闭	
	}

    if (colorH = 0x0824608) ;如果死亡，自动停止左键连点
    {
        clickFlag := 0
    }
	return
}

RandSleep(x,y) {
	Random, rand, %x%, %y%
	Sleep %rand%
}

~=::Pause  ;宏暂停或继续
