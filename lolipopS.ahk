代码部分 ...
#maxThreadsPerHotkey, 1 ;最大开启线程数为1
#IfWinActive, ahk_class D3 Main Window Class ;仅在D3下有效

SetKeyDelay,50
SetMouseDelay,50

X:=0
Y:=0
Width:=1440
Height:=900
Return

v_E=0 ;脚本运行开关变量
clickFlag = 0 ;控制左键连点的变量

$MButton::  ;鼠标中键为宏开关键，可修改为其它键
{ 
	if(v_E=0){
		v_E := 1
		clickFlag := 1
	}else{
		v_E := 0
		clickFlag := 0
	}

	if (v_E=0) 
	{
		SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
	}
	else 
	{
		SetTimer, MouseLButton, 50         ;左键连点计时器，会自动拾取
	}
}
Return 

$q:: 
{
v_E=1
WinGetPos,X,Y,Width, Height, A ;判断你的游戏窗口分辨率
Mylabel1:
PixelGetColor, color, Ceil(Width*0.4412), Ceil(Height*0.9574) ;寻找你“4”技能图标位置
scolor := SubStr(color, 3, 1) ;“4”技能位置没有图标的时候，颜色坐标第三个字符是1

If (scolor=1 AND v_E=1)
{
  send {q}
  sleep 600 ;黑人状态q的释放间隔，单位ms，可以修改，建议在600-700之间，如果设置过短会有按键惩罚
  clickFlag = 1
  Goto, MyLabel1
}
Else
{
  send {q} ;我把黑人设置在q，所以按q是开启黑人
  sleep 200
  PixelGetColor, color, Ceil(Width*0.4412), Ceil(Height*0.9574) ;判断上面的1黑人是不是开启成功
  scolor := SubStr(color, 3, 1)
  If (scolor=1 AND v_E=1)
  {
  clickFlag = 1
  Goto, MyLabel1 ;如果开启成功，自动循环开黑人的q
  }
  else{
	clickFlag = 0
	}
  
  
}
}

MouseLButton:   ;左键连点计时器设置
{
	if(clickFlag = 1){
		Click    ;点击鼠标左键，对应主要技能
	}
}

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

Return

~Enter:: 
~T:: 
~S:: 
~I:: 
~M:: 
~D::
~4::
;回车打字、按T回城、按S查看技能、按I查看装备、按M、按其他技能查看悬赏关闭宏，如需其他终止按键，自行添加
{
v_E=0
SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
}
Return