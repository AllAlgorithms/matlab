function general_MS

global list;
global tempList;
global n;
%list=[2 3 4 1 0 -1 9 8];
%list=[8 7 6 5 4 3 2 1];
%list=[8 7 6];
%list=[42 7.3 -sqrt(pi) 1 1 0 0 1 2 9 4 1 0 -1 9 8];
list=[42 7.3 -sqrt(pi) 1 1 0];
l=length(list);

maxElement=max(list);
n=2^ceil(log(l)/log(2));
for i=length(list)+1:n
    list(i)=maxElement+1;
end

tempList=list;

MergeSort(2);

truncList=list(1:l);

truncList

end


function MergeSort(sortingLevel)

global list;
global tempList;
global n;

if sortingLevel>n
    return;
end

for i=1:n/sortingLevel
    sortIndex1=(i-1)*sortingLevel+1;
    sortIndex2=sortIndex1+sortingLevel/2;
    
    Merge(sortIndex1,sortIndex2,sortingLevel);
end

list=tempList;
MergeSort(sortingLevel*2);

end



function Merge(sortIndex1,sortIndex2,sortingLevel)

global list;
global tempList;

index=sortIndex1;
j=0;
k=0;

while (j<sortingLevel/2) && (k<sortingLevel/2)
    if list(sortIndex1+j)<list(sortIndex2+k)
        tempList(index)=list(sortIndex1+j);
        j=j+1;
    else
        tempList(index)=list(sortIndex2+k);
        k=k+1;
    end
    index=index+1;
end

if (k<sortingLevel/2) || (j<sortingLevel/2)
    if k<sortingLevel/2
        tempList(index:sortIndex1+sortingLevel-1)=list(sortIndex2+k:sortIndex1+sortingLevel-1);
    else
        tempList(index:sortIndex1+sortingLevel-1)=list(sortIndex1+j:sortIndex2-1);
    end
end


end
