10 poke 646,1:print chr$(147);"  egon olsens compiler benchmark suite"
20 poke 53280,0:poke 53281,0
30 print chr$(17);chr$(17);"running...please wait...";chr$(17)
40 dim na$(10),sc(10):cn=0
50 gosub 500
60 gosub 600
70 gosub 900
80 gosub 1200
85 gosub 1900
90 gosub 1400
100 gosub 1500
110 gosub 1600
120 gosub 1700
130 gosub 1800
140 gosub 2300
150 dim sb(10)
160 for i=0 to 10:read sb(i):next
170 print chr$(147);"results:":print
180 tb=0:tc=0:for i=0 to 10
200 print"test: ";na$(i);":";int(((sb(i)/sc(i))*100));"%"
210 tb=tb+sb(i):tc=tc+sc(i):next
220 print:print"total:";int(((tb/tc)*100));"%"
400 end

500 rem simple loop test
510 n$="simple loop":gosub 60000
520 for i=0 to 5000 step .5:o=i:next
530 gosub 60100:return

600 rem quick sort test
605 n%=200:dim f%(200),l%(50),r%(50)
610 n$="quicksort":gosub 60000
620 o=rnd(-123):n%=200
630 for i=1 to n%:f%(i)=rnd(1)*32000: next 
640 l%(1)=1:r%(1)=n%:t%=0
650 gosub 700
660 for i=1 to n%-1:if f%(i)>f%(i+1) then print"error":end
670 next:gosub 60100:return
700 t%=t%+1: if l%(t%)>=r%(t%) then 800
710 l%=l%(t%):r%=r%(t%):v%=f%((l%+r%)/2)
720 if l%>r% then 780
730 if f%(l%)<v% then l%=l%+1: goto 730
740 if f%(r%)>v% then r%=r%-1: goto 740
750 if l%>r% then 780
760 h%=f%(l%):f%(l%)=f%(r%):f%(r%)=h%
770 l%=l%+1:r%=r%-1: goto 720
780 r%(t%+1)=r%:l%(t%+1)=l%(t%): gosub 700
790 l%(t%+1)=l%:r%(t%+1)=r%(t%): gosub 700
800 t%=t%-1: return 

900 rem hilbert curve
910 dim w%(7),b%(7):o=4:m=8
912 w=1:a=4:b=1:y=170:x=60:w%(o)=1
914 b%(7)=1:b%(6)=2:b%(5)=4:b%(4)=8:b%(3)=16:b%(2)=32:b%(1)=64:b%(0)=128
915 n$="hilbert curve":gosub 60000
920 gosub 940:poke 2023,32
930 gosub 60100:return
940 if o=0 then o=o+b: return 
950 w=w-w%(o):o=o-b:w%(o)=-w%(o+b): gosub 940
960 gosub 1000:w=w+w%(o):o=o-b:w%(o)=w%(o+b): gosub 940
970 gosub 1000:o=o-b:w%(o)=w%(o+b): gosub 940
980 w=w+w%(o): gosub 1000:o=o-b:w%(o)=-w%(o+b): gosub 940
990 w=w-w%(o):o=o+b: return 
1000 i=m
1010 on w and 3 goto 1050,1080,1110
1020 x=x+1: gosub 60400
1030 i=i-1: if i then 1020
1040 return 
1050 y=y-1: gosub 60400
1060 i=i-1: if i then 1050
1070 return
1080 x=x-1: gosub 60400
1090 i=i-1: if i then 1080
1100 return 
1110 y=y+1: gosub 60400
1120 i=i-1: if i then 1110
1130 return

1200 rem mandelbrot
1210 wd=30:ht=20:mx=16
1215 n$="mandelbrot":gosub 60000
1220 for i=1024 to 2023:poke 48182+i,peek(i):next
1240 for py=0 to ht-1
1250 yy=py/0.4/ht-1
1260 for px=0to wd-1
1270 xx=px/0.3/wd-2.2:xq=0:yq=0:x=0:y=0:it=0
1280 if (it>=mx) or (xq+yq>=4) then 1350
1290 y=x*y*2+yy
1300 x=xq-yq+xx
1310 xq=x*x:yq=y*y
1320 it=it+1
1330 goto 1280
1350 ad=40*(py+1)+px+4:poke1024+ad,160:poke55296+ad,mx-it
1360 next:next
1370 gosub 60120:return

1400 rem ram copy
1405 n$="ram copy":gosub 60000
1410 for i=1024 to 4096:poke 48182+i,peek(i) and 123:next
1420 gosub 60100:return

1500 rem string ops
1510 n$="string ops":gosub 60000
1520 dim c%(26):s$="this is a string and it's rather good!"
1530 f$="abcdefghijklmnopqrstuvwxyz"
1540 for i=1 to len(f$)
1550 c$=mid$(f$,i,1)
1560 for p=1 to len(s$):c2$=mid$(s$,p,1)
1570 if c2$=c$ then c%(i)=c%(i)+1
1580 next p,i
1590 gosub 60100:return

1600 rem prime numbers
1610 w=500:dim f(500):p=1:a=3
1620 n$="prime numbers":gosub 60000
1630 f(p)=a:p=p+1:if p>w then gosub 60100:return
1640 a=a+2:x=1
1650 s=a/f(x):if s=int(s) goto 1640
1660 x=x+1:if x<p and f(x)*f(x)<=a goto 1650
1670 goto 1630

1700 rem data read
1710 n$="data read":gosub 60000:c=0
1720 data 1,2,3,4,5,6,7,8,9,,1,2,3,4,5,6,7,8,9,0,-1
1725 data 1552,4697,8768,16207,12474,2882,1130,27352,4917,5330,9448
1730 restore
1750 read p:if p<>-1 then 1750
1760 c=c+1:if c<200 then 1730
1770 gosub 60100:return

1800 rem jumps
1810 n$="jumps":gosub 60000
1820 o=3:gosub 1840
1830 gosub 60100:return
1840 for i=0 to 1000:gosub 1850:next:return
1850 gosub 1860:return
1860 gosub 1870:return
1870 gosub 1880:return
1880 on o gosub 1890,1890,1890,1890,1890:return
1890 i=i-.8:return

1900 rem balls
1910 n=50:ti$="000000"::na$(cn)="balls"
1920 dim bx(255):dim by(255):dim bc(255)
1930 dim dx(255):dim dy(255)
1980 for b=0 to n
1990 bx(b)=int(rnd(1)*40)
2000 by(b)=int(rnd(1)*25)
2005 bc(b)=int(rnd(1)*14)+1
2006 dx(b)=int(rnd(1)*2)
2008 rem dy(b)=int(rnd(1)*2)
2009 dy(b)=1
2010 next b
2030 for i=1024 to 2023:pokei,81:next
2040 for i=55295 to 56295:pokei,0:next
2050 for ii=0to 29:for b=1 to n
2055 poke55296+by(b)*40+bx(b),0
2060 if dx(b)=0 then gosub 2110
2065 if dx(b)=1 then gosub 2140
2070 if dy(b)=0 then gosub 2170
2075 if dy(b)=1 then gosub 2200
2080 poke 55296+by(b)*40+bx(b),bc(b)
2085 next b,ii
2086 for i=1024 to 2023:poke i,peek(48182+i):poke 54272+i,1:next
2090 print "done";chr$(13);"balls...";:gosub 60100:return
2110 if bx(b)=0 then dx(b)=1:return
2120 bx(b)=bx(b)-1:return
2140 if bx(b)=39 then bx(b)=38:dx(b)=0:return
2150 bx(b)=bx(b)+1:return
2170 if by(b)=0 then dy(b)=1:return
2180 by(b)=by(b)-1:return
2200 if by(b)=24 then by(b)=23:dy(b)=0:return
2210 by(b)=by(b)+1:return

2300 rem math functions
2310 n$="math functions":gosub 60000:for i=0 to 2000
2320 o=sin(i*i):o=cos(i/8+i*80):o=int(o)+sgn(o*16+o*5)
2330 next
2340 gosub 60100:return

60000 rem reset timer, print name
60005 print n$;"...";:na$(cn)=n$
60010 ti$="000000":return

60100 rem read timer, "use" o
60110 poke 2,o and 255:print "done""
60120 sc(cn)=ti:cn=cn+1
60130 return

60400 rem plot (simulated)
60410 j%=(x and 504)+40*(y and 248)+(y and 7)+24576
60420 poke 2023,peek(j%) or b%(x and 7): return 

