
function getAngle(A, B)
    if A > 0 then -- Upper Half
        if B < 0 then -- Q1
            return A
        else -- Q2
            return 0.5 - A
        end
    else -- Lower Half
        if B > 0 then -- Q3
            return 0.5 - A
        else -- Q4
            return 1 + A
        end
    end
end

function getAngle(A,B) if B>0 then return 0.5-A elseif A>0 then return A end return 1+A end