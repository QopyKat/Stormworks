--[[
===== Input =====
B1: Enabled
N1: Value Input
===== Output =====
N1: Average
N2: Stdev
===== Properties =====
]]

getN = input.getNumber
setN = output.setNumber
getB = input.getBool

-- Array Functions
Array={}
function Array:new(n) a={} for i=1,n do a[i]=0 end return a end
function Array:newF(n,x) a={} for i=1,n do a[i]=x end return a end
function Array:sum(a) s=0 for i=1,#a do s=s+a[i] end return s end
function Array:avg(a) return Array:sum(a)/#a end
function Array:std(a) p=Array:subs(a,Array:avg(a)) return math.sqrt(Array:sum(Array:mul(p,p))/#a) end
-- Array x Array operations
function Array:add(a,b) c={} for i=1,#a do c[i]=a[i]+b[i] end return c end
function Array:sub(a,b) c={} for i=1,#a do c[i]=a[i]-b[i] end return c end
function Array:mul(a,b) c={} for i=1,#a do c[i]=a[i]*b[i] end return c end
function Array:div(a,b) c={} for i=1,#a do c[i]=a[i]/b[i] end return c end
-- Array x Scalar operations
function Array:adds(a,s) c={} for i=1,#a do c[i]=a[i]+s end return c end
function Array:subs(a,s) c={} for i=1,#a do c[i]=a[i]-s end return c end
function Array:muls(a,s) c={} for i=1,#a do c[i]=a[i]*s end return c end
function Array:divs(a,s) c={} for i=1,#a do c[i]=a[i]/s end return c end

data = Array:new(288)
index = 1

function onTick()
    if getB(1) then
        data[index] = getN(1)
        index = index + 1
        if index > #data then
            index = 1
            setN(1, Array:avg(data))
            setN(2, Array:std(data))
        end
    else
        setN(1, 0)
        setN(2, 0)
    end
end
