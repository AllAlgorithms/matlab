function cycleSort(arr)
    n = length(arr);
    
    for cycleStart = 1:n-1
        item = arr(cycleStart);
        pos = cycleStart;
        
        % Find the position to place the current item
        for i = cycleStart+1:n
            if arr(i) < item
                pos = pos + 1;
            end
        end
        
        % Skip if the item is already in its correct position
        if pos == cycleStart
            continue;
        end
        
        % Place the item in its correct position
        while item == arr(pos)
            pos = pos + 1;
        end
        temp = arr(pos);
        arr(pos) = item;
        item = temp;
        
        % Rotate the rest of the cycle
        while pos ~= cycleStart
            pos = cycleStart;
            for i = cycleStart+1:n
                if arr(i) < item
                    pos = pos + 1;
                end
            end
            
            while item == arr(pos)
                pos = pos + 1;
            end
            temp = arr(pos);
            arr(pos) = item;
            item = temp;
        end
    end
end
