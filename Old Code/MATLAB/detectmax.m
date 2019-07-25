function [flag,max] = detectmax(q,p)
global q2o p2o maxo
if sign(p)~=sign(p2o)&&(sign(p2o)==1)
    flag = 1;
    max = (q+q2o)/2;
    maxo = max;
    q2o = q;
    p2o = p;
else
    q2o = q;
    p2o = p;
    flag = 0;
    max = maxo;
end


