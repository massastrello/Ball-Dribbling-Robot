% FLOW MAP
function dx = f(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

% controller
u = 0;
%u = -10*p1-100*q1;

% closed loop system
global gamma m1 m2
dx = [p1/m1;p2/m2;m1*gamma+u;m2*gamma];
end