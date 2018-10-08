function lagrange_bivariate_interpolation(X, Y, Z)
% Lagrange Bivariate Interpolation
% USAGE : lagrange_bivariate_interpolation([x1 x2 x3 . . . xi], [y1 y2 y3 . . . yi], [z1, z2, z3 . . . zi])

% Interpolating in X Direction
xCurves={};
for i=1:size(X,1)
    x = X(i,:)';
    z = Z(i,:)';
    p=[];
    for j = x(1):0.2:x(end)
        p = [p,lagrange_univariate_interpolation(x,z,j)];
    end
    xCurves{i} = p;
end

y = Y(:,1);
A=[];

% Interpolating in Y Direction
for i=1:length(xCurves{1})
    p=[];
    z=[];
    for l=1:length(y)
        z = [z;xCurves{l}(i)];
    end
    for j = y(1):0.2:y(end)
        p = [p;lagrange_univariate_interpolation(y,z,j)];
    end
    A = [A,p];
end


s = surf(x(1):(x(end)-x(1))/(size(A,1)-1):x(end),y(1):(y(end)-y(1))/(size(A,1)-1):y(end),A, 'FaceAlpha',0.7);
hold on;
%s.EdgeColor = 'none';
% plot points

for i=1:size(X,1)
    for j=1:size(Y,1)
        p = plot3(X(i,j),Y(i,j),Z(i,j));
        set(p,'Marker','.');
        set(p,'MarkerSize',30);
    end
end

end

%% nested functions
function res = lagrange_univariate_interpolation(x,z,t)
% lagrange interpolation in 1d
% input: x...vektor, welcher die x (bzw. y) Werte beinhaltet

res = 0;
for i=1:length(x)
    % delete the component not needed
    temp = [x(1:i-1);x(i+1:end)];
    
    denominator = x(i)-temp;
    
    numerator = t-temp;
    res = res + z(i)*(prod(numerator))/(prod(denominator));
end
end