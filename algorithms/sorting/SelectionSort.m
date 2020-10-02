function selectionsort
A= rand(10,1);
  disp("Unsorted list is:");
  disp(A);
n = length(A);
for i=1:n-1
[x index] = min(A(i:n)); 
minIndex = index + i-1; 
temp = A(i);
A(i) = A(minIndex);
A(minIndex) = temp;
end;
disp("Sorted list is:");
disp(A);
