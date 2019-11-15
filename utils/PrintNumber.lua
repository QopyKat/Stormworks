_f=math.floor
_r=screen.drawRect
_c=screen.setColor
_t=screen.drawText
_s=drawSingleDigit
function drawNumber(x,y,n)
s={}
c=0
i=0
n=_f(n)
if n < 0 then
_r(x+1,y+2,1,0)
x=x+4
end
n=math.abs(n)
if not (n==0) then
while n>0 do
d=n%10
if d>0 then
c=i
end
s[i]=d
n=_f(n/10)
i=i+1
end
end
for i=0,c do
_s(x,y,s[c-i])
x=x+4
end
end
function _s(x,y,n)
_c(255,255,255)
screen.drawRectF(x,y,3,5)
_c(0,0,0)
a=x+1
b=y+1
c=y+3
if n==0 then
_r(a,b,0,2)
elseif n==1 then
_r(x,y,1,4)
elseif n==2 then
_r(x,b,1,0)
_r(a,c,1,0)
elseif n==3 then
_r(x,b,1,0)
_r(x,c,1,0)
elseif n==4 then
_r(a,y,0,1)
_r(x,c,1,1)
elseif n==5 then
_r(a,b,1,0)
_r(x,c,1,0)
elseif n==6 then
_r(a,b,1,0)
_t(x,y-1,".")
elseif n==7 then
_r(x,b,1,3)
elseif n==8 then
_t(x,y-3,".")
_t(x,y-1,".")
elseif n==9 then
_t(x,y-3,".")
_r(x,c,1,0)
end
end