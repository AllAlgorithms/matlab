%% Oranges and apples
clear,clc
%% Initialize patterns
p=[1 1;-1 1;-1 -1];
[R,n]=size(p);
e=1;
%% Introduce targets
t=[-1 1];
c=0;
%% Initialize w,b,N
N=1;
w=rand(N,R);
b=rand(N,1);
%% Calculating alpha
Ra=0;
for q=1:n
    Ra=Ra+p(:,q)*p(:,q)';
end
Ra=Ra/n;
lambda=max(eig(Ra));
maxv=(1/lambda)/2;
alpha=maxv*rand;
%% Learning
while e~=0
    for i=1:n
        a=purelin(w*p(:,i)+b);
        e=t(i)-a;
        wn=w+2*alpha*e*p(:,i)';
        bn=b+2*alpha*e;
        w=wn; b=bn;
        c=c+1;
        
        if e==0 %Verificamos que no haya errores, probando con el 1ero
            a=purelin(w*p(:,1)+b);
            e=t(1)-a;
            if e==0 %Si sigue bien, comprobamos el 2do
                wn=w+2*alpha*e*p(:,1)';
                bn=b+2*alpha*e;
                w=wn; b=bn;
                %checa 2
                a=purelin(w*p(:,2)+b);
                e=t(2)-a;
                wn=w+2*alpha*e*p(:,2)';
                bn=b+2*alpha*e;
                w=wn; b=bn;
                c=c+1;
            end
        end
        
    end
end
c=c-1
%% Testing
plot3(1,-1,-1,'ro')
hold on,grid on
plot3(1,1,-1,'bo')
xlim([-2.2 2.2])
ylim([-2.2 2.2])
zlim([-2.2 2.2])
[X,Y]=meshgrid(-2.2:0.6:2.2);
Z=-(w(1)/w(3))*X-(w(2)/w(3))*Y-b/w(3);
surf(X,Y,Z)
for x=-2:0.5:2
    for y=-2:0.5:2
        for z=-2:0.5:2
            pp=[x;y;z];
            a=purelin(w*pp+b);
            if a>=0
                plot3(x,y,z,'*r')
            else
                plot3(x,y,z,'*b')
            end
        end
    end
end