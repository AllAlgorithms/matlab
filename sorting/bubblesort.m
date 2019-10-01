function bubblesort
  arr= rand(10,1);
  disp("Unsorted list is:");
  disp(arr);
  m = size(arr,1);
  for i = 1: m
    for j = 1 : m
      if arr(i) < arr(j)
        temp = arr(i);
        arr(i) = arr(j);
        arr(j) = temp;
      end
    end
  end
  disp("Sorted list is:");
  disp(arr);
end
