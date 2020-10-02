%% This example shows how to solve an OR logic gate with a single layer Perceptron NN

clear, clc
plot(0,0,'mo')
hold on,grid on
plot(0,1,'co')
plot(1,0,'co')
plot(1,1,'co')
xlim([-1.2 2.2])
ylim([-1.2 2.2])

w=[.2 .2];
b=-.1;
for x=-1:.2:2
    for y=-1:.2:2
        p=[x; y];
        a=hardlim(w*p+b);
        if a==1
            plot(x,y,'*r')
        else 
            plot(x,y,'*b')
        end
    end
end