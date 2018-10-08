% Quick Sort implemented in MATLAB
% Author- Aaditya Naik

clear all;
close all;

lenList = 10;

% randomized list to be sorted
global list;
list = rand(1, lenList);

% lists start at index 1 in MATLAB
firstIndex = 1;
lastIndex = 10;

function QuickSort(firstIndex, lastIndex)
  global list;
  if (lastIndex - firstIndex <= 1)
    return
  end
  
  pivot = firstIndex;
  
  small = lastIndex;
  big = pivot + 1;
  
  while (1)
    while (list(small) > list(pivot))
      small = small - 1;
    end
    
    while (big <= lastIndex) && (list(big) < list(pivot))
      big = big + 1;
    end
    
    if (big < small)
      % swapping
      temp = list(big);
      list(big) = list(small);
      list(small) = temp;
    else
      break;
    end    
    
  end
  
  temp = list(firstIndex);
  list(firstIndex) = list(small);
  list(small) = temp;
  
  QuickSort(firstIndex, small);
  QuickSort(small + 1, lastIndex);
  
end

% Unsorted list
list

QuickSort(firstIndex, lastIndex)

% Sorted list
list