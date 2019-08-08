% FLOW SET
function value = c(x)

% state
q1 = x(1);
q2 = x(2);
p1 = x(3);
p2 = x(4);

if (q1 >= q2) && (q2>=0)
    value = 1;
else
    value = 0;
end

end

