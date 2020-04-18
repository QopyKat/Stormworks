-------------------------------------------------------------------------------
-- Utility Functions
function floor(a,n) f=1 for i=1,n do f=f*10 end return math.floor(a*f)/f end
function clamp(n,l,h) if n<l then return l elseif n>h then return h else return n end end

-------------------------------------------------------------------------------
-- 2D Vector Functions
Vec2={}
function Vec2:new(x,y) return {x=x,y=y} end
function Vec2:newP(a,b) return {x=b.x-a.x,y=b.y-a.y} end
function Vec2:len(v) return math.sqrt(v.x*v.x+v.y*v.y) end
function Vec2:normalize(v) l=Vec2:len(v) return {x=v.x/l,y=v.y/l} end
-- 2D Vector x 2D Vector
function Vec2:add(a,b) return {x=a.x+b.x,y=a.y+b.y} end
function Vec2:sub(a,b) return {x=a.x-b.x,y=a.y-b.y} end
function Vec2:mul(a,b) return {x=a.x*b.x,y=a.y*b.y} end
function Vec2:div(a,b) return {x=a.x/b.x,y=a.y/b.y} end
function Vec2:dot(a,b) return a.x*b.x+a.y*b.y end
-- 2D Vector x Scalar operations
function Vec2:adds(v,s) return {x=v.x+s,y=v.y+s} end
function Vec2:subs(v,s) return {x=v.x-s,y=v.y-s} end
function Vec2:muls(v,s) return {x=v.x*s,y=v.y*s} end
function Vec2:divs(v,s) return {x=v.x/s,y=v.y/s} end
function Vec2:scale(v,l) c=Vec2:len(v) return {x=v.x*l/c,y=v.y*l/c} end

-------------------------------------------------------------------------------
-- 3DVector Functions
Vec3={}
function Vec3:new(x,y,z) return {x=x,y=y,z=z} end
function Vec3:newP(a,b) return {x=b.x-a.x,y=b.y-a.y,z=b.z-a.z} end
function Vec3:len(v) return math.sqrt(v.x*v.x+v.y*v.y+v.z*v.z) end
function Vec3:normalize(v) l=Vec3:len(v) return {x=v.x/l,y=v.y/l,z=v.z/l} end
-- 3D Vector x 3D Vector
function Vec3:add(a,b) return {x=a.x+b.x,y=a.y+b.y,z=a.z+b.z} end
function Vec3:sub(a,b) return {x=a.x-b.x,y=a.y-b.y,z=a.z-b.z} end
function Vec3:mul(a,b) return {x=a.x*b.x,y=a.y*b.y,z=a.z*b.z} end
function Vec3:div(a,b) return {x=a.x/b.x,y=a.y/b.y,z=a.z/b.z} end
function Vec3:dot(a,b) return a.x*b.x+a.y*b.y+a.z*b.z end
function Vec3:cross(a,b) return {x=a.y*b.z-a.z*b.y,y=b.x*a.z-a.x*b.z,z=a.x*b.y-a.y*b.x} end
-- 3D Vector x Scalar operations
function Vec3:adds(v,s) return {x=v.x+s,y=v.y+s,z=v.z+s} end
function Vec3:subs(v,s) return {x=v.x-s,y=v.y-s,z=v.z-s} end
function Vec3:muls(v,s) return {x=v.x*s,y=v.y*s,z=v.z*s} end
function Vec3:divs(v,s) return {x=v.x/s,y=v.y/s,z=v.z/s} end
function Vec3:scale(v,l) c=Vec3:len(v) return {x=v.x*l/c,y=v.y*l/c,z=v.z*l/c} end

-------------------------------------------------------------------------------
-- Array Functions
Arr={}
function Arr:new(n) a={} for i=1,n do a[i]=0 end return a end
function Arr:newF(n,x) a={} for i=1,n do a[i]=x end return a end
function Arr:sum(a) s=0 for i=1,#a do s=s+a[i] end return s end
function Arr:avg(a) return Arr:sum(a)/#a end
-- Array x Array operations
function Arr:add(a,b) c={} for i=1,#a do c[i]=a[i]+b[i] end return c end
function Arr:sub(a,b) c={} for i=1,#a do c[i]=a[i]-b[i] end return c end
function Arr:mul(a,b) c={} for i=1,#a do c[i]=a[i]*b[i] end return c end
function Arr:div(a,b) c={} for i=1,#a do c[i]=a[i]/b[i] end return c end
-- Array x Scalar operations
function Arr:add(a,s) c={} for i=1,#a do c[i]=a[i]+s end return c end
function Arr:sub(a,s) c={} for i=1,#a do c[i]=a[i]-s end return c end
function Arr:mul(a,s) c={} for i=1,#a do c[i]=a[i]*s end return c end
function Arr:div(a,s) c={} for i=1,#a do c[i]=a[i]/s end return c end
