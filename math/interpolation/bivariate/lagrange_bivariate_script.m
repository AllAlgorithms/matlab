[X,Y]=meshgrid(-5:1:5,-5:1:5);
Z = Y.*sin(X)-X.*cos(Y);
lagrange_bivariate_interpolation(X, Y, Z);