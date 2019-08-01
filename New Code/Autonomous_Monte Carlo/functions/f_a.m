% FLOW MAP
function dx = f_a(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

global gamma m1 m2 b1 b2
%%
dx = [p1/m1;...
      p2/m2;...
      m1*gamma-b1*p1/m1;...
      m2*gamma-b2*p2/m2];
end