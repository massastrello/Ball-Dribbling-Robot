% JUMP MAP
function xp = g_a(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

global flag_j c_i c_g m1 m2

switch flag_j
    case 1
        xp = [q1;-q2;p1;-c_g*p2];
    case 2
        lambda = (c_i+1)/(m1+m2);
        xp = [q1+1e-10;q2-1e-10;p1-lambda*(m2*p1-m1*p2);...
                    p2+lambda*(m2*p1-m1*p2)];
end
        
end