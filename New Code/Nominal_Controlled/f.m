% FLOW MAP
function dx = f(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

global gamma m1 m2 flag_j k e gain hit err kc h q2md iter c_state u_i gain_i c_i c_g b1 b2 k_it
%
%% controller
if isequal(flag_j,[])
    flag_j = 0;
end
err = [err;q2md-q2];
[flag,max] = detectmax(q2,p2);
if flag&&hit
    k = k + 1*(q2md - max);
    if k<0
        k=0;
    end
    kc = 10*(q2md-max) + 150*k;
    gain = [gain;kc];
    gain_i = [gain_i;150*k];
    e = [e;q2md-max];
    hit = 0;
    c_state = 1;
    % Robustness tests
    if q2md-max<0.0001
        %q2md = 0.05;
        %m2 = 0.25;
        %m1 = .2;
        %c_i = .99;
        %c_g = .99;
        %b2 = 0.1;
    end
        
end
%
np = 0*rand;
nq = 0*rand;
if ~c_state
    q1d = q2 + h;
    iter = [iter;iter(end,1)+1,0];
    u = -m1*gamma -10000*(q1-q1d+nq)-(1000)*(p1+np);
elseif c_state
    q1d = q2;
    u = -m1*gamma -10*(kc)*(q1-q1d+nq)-(0/m1)*(p1+np);
    iter = [iter;iter(end,1)+1,1];
else 
   u = 0;
end
% Uncomment for autonomous system
%u = 0;
%
err = [err;q1d-q1];
k_it = [k_it;kc];
%}
u_i = [u_i,u];
%% closed loop system
dx = [p1/m1;p2/m2;m1*gamma-b1*p1/m1+u;m2*gamma-b2*p2/m2];
end