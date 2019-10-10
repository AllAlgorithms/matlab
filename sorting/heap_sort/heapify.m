function [output_arr] = heapify(arr, n, i)

    max = i;
    left = 2*i;
    right = 2*i + 1;

    if left <= n && arr(i) < arr(left)
        max = left;
    end

    if right <= n && arr(max) < arr(right)
        max = right;
    end

    if max ~= i 
        tmp = arr(max);
        arr(max) = arr(i);
        arr(i) = tmp;
        heapify(arr, n, max);
    end
    
    output_arr = arr;

end