% FLOW MAP
function dx = f(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

global gamma m1 m2 flag_j k e gain hit err kc h q2md iter c_state u_i gain_i
%
%% controller
if isequal(flag_j,[])
    flag_j = 0;
end
err = [err;q2md-q2];
[flag,max] = detectmax(q2,p2);
if flag&&hit
    k = k + 1*(q2md - max);
    kc = 10*(q2md-max) + 300*k;
    gain = [gain;kc];
    gain_i = [gain_i;300*k];
    e = [e;q2md-max];
    hit = 0;
    c_state = 1;
end
%
%np = .00*randn;
%nq = .00*randn;
if ~c_state
    q1d = q2 + h;
    iter = [iter;iter(end,1)+1,0];
    u = -m1*gamma -10000*(q1-q1d+0.00*randn())-(1000)*(p1+ 0.00*randn());
elseif c_state
    q1d = q2;
    u = -m1*gamma -10*(kc)*(q1-q1d+ 0.00*randn())-(100/m1)*(p1+ 0.00*randn());
    iter = [iter;iter(end,1)+1,1];
else 
   u = 0;
end
err = [err;q1d-q1];
%}
u_i = [u_i,u];
%% closed loop system
dx = [p1/m1;p2/m2;m1*gamma-0.2*p1/m1+u;m2*gamma-0.3*p2/m2];
end