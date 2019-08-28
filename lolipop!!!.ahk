1:
2:
3:
4:
5:
6:
7:
8:
9:
10:
11:
12:
13:
14:
15:
16:
17:
18:
19:
20:
21:
22:
23:
24:
25:
26:
27:
28:
29:
30:
31:
32:
33:
34:
35:
36:
37:
38:
39:
40:
41:
42:
43:
44:
45:
46:
47:
48:
49:
50:
51:
52:
53:
54:
55:
56:
57:
58:
59:
60:
61:
62:
63:
64:
65:
66:
67:
68:
69:
70:
71:
72:
73:
74:
75:
76:
77:
78:
79:
80:
81:
82:
83:
84:
85:
86:
87:
88:
89:
90:
91:
92:
93:
94:
95:
96:
97:
98:
99:
100:
101:
102:
103:
104:
105:
106:
107:
108:
109:
110:
111:
112:
113:
114:
115:
116:
117:
118:
119:
120:
121:
122:
123:
124:
125:
126:
127:
128:
129:
130:
131:
132:
133:
134:
135:
136:
137:
138:
139:
140:
141:
142:
143:
144:
145:
146:
147:
148:
149:
150:
151:
152:
153:
154:
155:
156:
157:
158:
159:
160:
161:
162:
163:
164:
165:
166:
167:
168:
169:
170:
171:
172:
173:
174:
175:
176:
177:
178:
179:
180:
181:
182:
183:
184:
185:
186:
187:
188:
189:
190:
191:
192:
193:
194:
195:
196:
197:
198:
199:
200:
201:
202:
203:
204:
205:
206:
207:
208:
209:
210:
211:
212:
213:
214:
215:
216:
217:
218:
219:
220:
221:
222:
223:
224:
225:
226:
227:
228:
229:
230:
231:
232:
233:
234:
235:
236:
237:
238:
239:
240:
241:
242:
243:
244:
245:
246:
247:
248:
249:
250:
251:
252:
253:
254:
255:
256:
257:
258:
259:
260:
261:
262:
263:
264:
265:
266:
#IfWinActive, ahk_class D3 Main Window Class ;仅在D3下有效 
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动 

;技能键位：1黑人，2黑洞，3传送，4护甲，左洪流，右魔武 

SetKeyDelay, 10 
SetMouseDelay, 10 

RUN = 0 ;脚本运行开关变量初始化 
TAB = 0 ;小地图开关变量初始化 

$XButton1:: ;鼠标侧键1护甲、魔武、喝药，应急情况长按启动黑人 
{ 
Send, {4} 
Click Right 
Send, {5} ;自定义键盘喝药键位 
KeyWait, XButton1, T0.2 
Loop 
{ 
GetKeyState, XButton1_state, XButton1, P 
if XButton1_state = U 
{ 
Send, {XButton1 Up} 
Break 
} 
Else 
{ 
Send, {2 down} ; 变黑人前放黑洞键位 
Sleep 300 
Send, {2 up} 
Send, {1} ; 变黑人键位 
Sleep 500 
Send, {2} ; 变身后自动罩子键位 
Break 
} 
Sleep, 20 
} 
Return 
} 

$XButton2:: ;鼠标侧键2开关宏 
{ 
RUN:=!RUN 
if (RUN = 1) 
{ 
SetTimer, LM, 50 ;左键连点开启 
SetTimer, DC, 50 ;叠层循环开启 
SetTimer, HR, 650 ;黑人循环开启 
} 
Else 
{ 
SetTimer, LM, off ;左键连点关闭 
SetTimer, DC, off ;叠层循环关闭 
SetTimer, HR, off ;黑人循环关闭 
} 
IfWinNotActive, ahk_class D3 Main Window Class 
{ 
SetTimer, LM, off 
SetTimer, DC, off 
SetTimer, HR, off 
RUN = 0 
} 
Return 
} 

$RButton:: ;加$屏蔽脚本按键,黑人状态短按右键为传送，长按右键为射线 
{ 
if (RUN = 1) 
{ 
Send, {3} 
KeyWait, RButton, T0.2 
Loop 
{ 
GetKeyState, RButton_state, RButton, P 
if RButton_state = U 
{ 
Send, {RButton Up} 
Break 
} 
Else 
{ 
Send, {RButton Down} 
} 
Sleep, 20 
} 
} 
if (RUN = 0) 
{ 
Send, {RButton Down} 
KeyWait, RButton, T0.2 
Loop 
{ 
GetKeyState, RButton_state, RButton, P 
if RButton_state = U 
{ 
Send, {RButton Up} 
Break 
} 
Else 
{ 
Send, {RButton Down} 
} 
Sleep, 20 
} 
} 
Return 
} 

DC: ;白人阶段叠层判定 
{ 
WinGetPos, X, Y, Width, Height, A 
if (Width = 1280 AND Height = 720) 
{ 
PixelGetColor, color1, 461, 633 ;适配1280*720分辨率 
} 
if (Width = 1440 AND Height = 900) 
{ 
PixelGetColor, color1, 495, 791 ;适配1440*900分辨率 
} 
if (Width = 1600 AND Height = 900) 
{ 
PixelGetColor, color1, 575, 791 ;适配1600*900分辨率 
} 
if (Width = 1680 AND Height = 1050) 
{ 
PixelGetColor, color1, 578, 923 ;适配1680*1050分辨率 
} 
if (Width = 1920 AND Height = 1080) 
{ 
PixelGetColor, color1, 691, 950 ;适配1920*1080分辨率 
} 
if (Width = 1920 AND Height = 1200) 
{ 
PixelGetColor, color1, 661, 1056 ;适配1920*1200分辨率 
} 
if (Width = 2560 AND Height = 1440) 
{ 
PixelGetColor, color1, 922, 1267 ;适配2560*1440分辨率 
} 
;第1增益位20层BUFF像素颜色取样 

if (RUN = 1 AND color1 = 0xFFFFFF) 
{ 
Send, {2 down} ; 变黑人前放黑洞键位 
Sleep 300 
Send, {2 up} 
Send, {1} ; 变黑人键位 
Sleep 500 
Send, {2} ; 变身后自动罩子键位 
} 
Return 
} 

HR: ;黑人阶段自动按技能 
{ 
WinGetPos,X,Y,Width, Height, A 
if (Width = 1280 AND Height = 720) 
{ 
PixelGetColor, color2, 572, 685 ;适配1280*720分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 
if (Width = 1440 AND Height = 900) 
{ 
PixelGetColor, color2, 635, 855 ;适配1440*900分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 
if (Width = 1600 AND Height = 900) 
{ 
PixelGetColor, color2, 716, 855 ;适配1600*900分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 
if (Width = 1680 AND Height = 1050) 
{ 
PixelGetColor, color2, 635, 860 ;适配1680*1050分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 
if (Width = 1920 AND Height = 1080) 
{ 
PixelGetColor, color2, 860, 1030 ;适配1920*1080分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 
if (Width = 1920 AND Height = 1200) 
{ 
PixelGetColor, color2, 848, 1140 ;适配1920*1200分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 
if (Width = 2560 AND Height = 1440) 
{ 
PixelGetColor, color2, 1145, 1370 ;适配2560*1440分辨率 
scolor2 := SubStr(color2, 3, 1) 
} 

If (RUN =1 AND scolor2 = 1) 
{ 
Send, {1} ; 冰爆技能键位 
} 
Return 
} 

;手动开黑人，自动开罩子，应急情况 
~`:: 
~1:: 
{ 
if (RUN) 
{ 
Send, {2 down} ; 变黑人前放黑洞键位 
Sleep 300 
Send, {2 up} 
Send, {1} ; 变黑人键位 
Sleep 500 
Send, {2} ; 变身后自动罩子键位 
} 
Return 
} 

;以下为关闭宏按键，可自行添加 
~MButton:: 
~WheelUp:: 
~ESC:: 
~Enter:: 
~NumpadEnter:: 
~C:: 
~I:: 
~M:: 
~P:: 
~S:: 
~T:: 
{ 
SetTimer, LM, off 
SetTimer, DC, off 
SetTimer, HR, off 
RUN=0 
} 

~Tab:: ;查看小地图临时关闭宏，再按TAB键继续宏 
{ 
If (RUN) 
{ 
TAB:=!TAB 
If (TAB) 
{ 
SetTimer, LM, off 
SetTimer, DC, off 
SetTimer, HR, off 
} 
Else 
{ 
SetTimer, LM, 50 
SetTimer, DC, 50 
SetTimer, HR, 650 
} 
} 
Return 
} 

LM: 
{ 
Click 
Return 
} 

RM: 
{ 
Click Right 
Return 
}

https://bbs.nga.cn/read.php?&tid=17351291

https://bbs.nga.cn/read.php?&tid=17351291

https://bbs.nga.cn/read.php?&tid=17351291