-------------------------------------------------------------------------------
-- Utility Functions
function floor(a,n) f=1 for i=1,n do f=f*10 end return math.floor(a*f)/f end
function clamp(n,l,h) if n<l then return l elseif n>h then return h else return n end end

-------------------------------------------------------------------------------
-- 2D Vector Functions
Vector2={}
function Vector2:new(x,y) return {x=x,y=y} end
function Vector2:newP(a,b) return {x=b.x-a.x,y=b.y-a.y} end
function Vector2:len(v) return math.sqrt(v.x*v.x+v.y*v.y) end
function Vector2:normalize(v) l=Vector2:len(v) return {x=v.x/l,y=v.y/l} end
-- 2D Vector x 2D Vector
function Vector2:add(a,b) return {x=a.x+b.x,y=a.y+b.y} end
function Vector2:sub(a,b) return {x=a.x-b.x,y=a.y-b.y} end
function Vector2:mul(a,b) return {x=a.x*b.x,y=a.y*b.y} end
function Vector2:div(a,b) return {x=a.x/b.x,y=a.y/b.y} end
function Vector2:dot(a,b) return a.x*b.x+a.y*b.y end
-- 2D Vector x Scalar operations
function Vector2:adds(v,s) return {x=v.x+s,y=v.y+s} end
function Vector2:subs(v,s) return {x=v.x-s,y=v.y-s} end
function Vector2:muls(v,s) return {x=v.x*s,y=v.y*s} end
function Vector2:divs(v,s) return {x=v.x/s,y=v.y/s} end
function Vector2:scale(v,l) c=Vector2:len(v) return {x=v.x*l/c,y=v.y*l/c} end

-------------------------------------------------------------------------------
-- 3DVector Functions
Vector3={}
function Vector3:new(x,y,z) return {x=x,y=y,z=z} end
function Vector3:newP(a,b) return {x=b.x-a.x,y=b.y-a.y,z=b.z-a.z} end
function Vector3:len(v) return math.sqrt(v.x*v.x+v.y*v.y+v.z*v.z) end
function Vector3:normalize(v) l=Vector3:len(v) return {x=v.x/l,y=v.y/l,z=v.z/l} end
-- 3D Vector x 3D Vector
function Vector3:add(a,b) return {x=a.x+b.x,y=a.y+b.y,z=a.z+b.z} end
function Vector3:sub(a,b) return {x=a.x-b.x,y=a.y-b.y,z=a.z-b.z} end
function Vector3:mul(a,b) return {x=a.x*b.x,y=a.y*b.y,z=a.z*b.z} end
function Vector3:div(a,b) return {x=a.x/b.x,y=a.y/b.y,z=a.z/b.z} end
function Vector3:dot(a,b) return a.x*b.x+a.y*b.y+a.z*b.z end
function Vector3:cross(a,b) return {x=a.y*b.z-a.z*b.y,y=b.x*a.z-a.x*b.z,z=a.x*b.y-a.y*b.x} end
-- 3D Vector x Scalar operations
function Vector3:adds(v,s) return {x=v.x+s,y=v.y+s,z=v.z+s} end
function Vector3:subs(v,s) return {x=v.x-s,y=v.y-s,z=v.z-s} end
function Vector3:muls(v,s) return {x=v.x*s,y=v.y*s,z=v.z*s} end
function Vector3:divs(v,s) return {x=v.x/s,y=v.y/s,z=v.z/s} end
function Vector3:scale(v,l) c=Vector3:len(v) return {x=v.x*l/c,y=v.y*l/c,z=v.z*l/c} end

-------------------------------------------------------------------------------
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
