% FLOW MAP
function dx = f(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

global gamma m1 m2 flag_j k e gain hit err kc
%lambda = (c_i+1)/(m1+m2);

%% controller
q2md = 0;
q1d = q2 + 0.1;


if isequal(flag_j,[])
    flag_j = 0;
end
err = [err;q2md-q2];
[flag,max] = detectmax(q2,p2);
if flag&&hit
    k = k + (q2md -max);
    kc = 100*(q2md-max) + 10*k;
    gain = [gain;kc];
    e = [e;q2md-max];
    hit = 0;
end
%
np = 0.0*rand;
nv = 0.0*rand;
%
if  ((p2<0)&&(flag_j==2))||(p2>0)||(flag_j==0)
    u = -m1*gamma -10000*(q1-q1d + np)-(1000)*(p1 + nv);
elseif (p2<0)&&(flag_j==1)
    u = -m1*gamma -10*(kc)*(q1-q2 + np)-(100/m1)*(p1 + nv);
else 
    u = 0;
end

%% closed loop system
dx = [p1/m1;p2/m2;m1*gamma-0.2*p1/m1+u;m2*gamma-0.2*p2/m2];
end