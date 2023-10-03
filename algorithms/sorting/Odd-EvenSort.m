function oddEvenSort(arr)
    n = length(arr);
    sorted = false;
    
    while ~sorted
        sorted = true;
        
        % Odd phase (compare and swap odd-indexed elements)
        for i = 1:2:(n-1)
            if arr(i) > arr(i + 1)
                temp = arr(i);
                arr(i) = arr(i + 1);
                arr(i + 1) = temp;
                sorted = false;
            end
        end
        
        % Even phase (compare and swap even-indexed elements)
        for i = 2:2:(n-1)
            if arr(i) > arr(i + 1)
                temp = arr(i);
                arr(i) = arr(i + 1);
                arr(i + 1) = temp;
                sorted = false;
            end
        end
    end
end

% Example usage
arr = [64, 34, 25, 12, 22, 11, 90];
disp("Unsorted List:");
disp(arr);

oddEvenSort(arr);

disp("Sorted List:");
disp(arr);
