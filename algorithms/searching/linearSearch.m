% Linear search function
function index = linearSearch(array, target)
    index = -1;  % Initialize index to -1 (not found)
    
    for i = 1:length(array)
        if array(i) == target
            index = i;  % Target found at index i
            break;      % Exit the loop
        end
    end
end
