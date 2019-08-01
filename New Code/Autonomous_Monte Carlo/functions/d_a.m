function inside = d_a(x)
% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

global flag_j m1 m2 hit

if (q2 <= 0) && (p2<=0)
    inside = 1;
    flag_j = 1;
    hit = 1;
elseif abs(q1-q2)<=1e-10
    if (sign(p1)>=0)&&(sign(p2)>=0)&&(p2/m2>=p1/m1)
        inside = 1;
        flag_j = 2;
        hit = 1;
    elseif (sign(p1)<=0)&&(sign(p2)>=0)
        inside = 1;
        flag_j = 2;
        hit = 1;
    elseif (sign(p1)<=0)&&(sign(p2)<=0)&&(abs(p2/m2)<=abs(p1/m1))
        inside = 1;
        flag_j = 2;
        hit = 1;
    else
        inside = 0;
    end
else
    inside = 0;
end

end
    