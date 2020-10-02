
function sorted_arr = heap_sort(arr)

    n = length(arr);

     for i = floor(n/2):-1:1

         arr = heapify(arr, n, i);

     end

     heapsize = n;

     for i = n:-1:2
         tmp = arr(i);
         arr(i) = arr(1);
         arr(1) = tmp;
         heapsize = heapsize - 1;
         arr = heapify(arr, heapsize, 1);
     end

     sorted_arr = arr;
 
end
 
 