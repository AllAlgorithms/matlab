function res = binarySearch(A, l, r, x)
    if r >= l
        m = floor(l + r / 2);git 
        if A(m) == x
            res = m;
        elseif A(m) > x
            res = binarySearch(A,l,m-1,x);
        else
            res = binarySearch(A,l,m+1,x);
        end
    end
end

