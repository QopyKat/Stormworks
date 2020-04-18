
-- Utility Functions
function floor(a,n) f=1 for i=1,n do f=f*10 end return math.floor(a*f)/f end
function clamp(n,l,h) if n<l then return l elseif n>h then return h else return n end end

-- 2D Vector Functions
function vec2(x,y) return {x=x,y=y} end
function len2(v) return math.sqrt(v.x*v.x+v.y*v.y) end
function scale2(v,l) c=len2(v) return {x=v.x*l/c,y=v.y*l/c} end
function dot2(a,b) return a.x*b.x+a.y*b.y end

-- 3DVector Functions
function vec(x,y,z) return {x=x,y=y,z=z} end
function vecp(a,b) return {x=b.x-a.x,y=b.y-a.y,z=b.z-a.z} end
function len(v) return math.sqrt(v.x*v.x+v.y*v.y+v.z*v.z) end
function scale(v,l) c=len(v) return {x=v.x*l/c,y=v.y*l/c,z=v.z*l/c} end
function norm(v) l=len(v) return {x=v.x/l,y=v.y/l,z=v.z/l} end
function cross(a,b) return {x=a.y*b.z-a.z*b.y,y=b.x*a.z-a.x*b.z,z=a.x*b.y-a.y*b.x} end
function dot(a,b) return a.x*b.x+a.y*b.y+a.z*b.z end

function v3muls(v,s) return {x=v.x*s,y=v.y*s,z=v.z*s} end
function v3add(a,b) return {x=a.x+b.x,y=a.y+b.y,z=a.z+b.z} end
