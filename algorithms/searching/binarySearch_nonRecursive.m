function res = binarySearch_nonRecursive(A,l,r,x)
    while l <= r
        m = floor((l + r) / 2);
        if A(m) == x
            res = m;
            return
        elseif A(m) < x
            l = m + 1;
        else
            r = m - 1;
        end   
    end
end

