qq = 0:0.1:1;
pp = -1:0.1:1;
epsilon = 0.01;
%
[X,Y] = meshgrid(qq,pp);
Z = (Y.^2)./(2*m1) + m1*gamma.*X;
%
surf(X,Y)