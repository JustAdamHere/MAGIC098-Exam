function b = basis(n, i, x)
    if i == 0
        if n == 0
            b = -x(1) - x(2);
        elseif n == 1
            b = x(1) + 1;
        elseif n == 2
            b = x(2) + 1;
        end
    elseif i == 1
        if n == 0
            b = [-1 -1];
        elseif n == 1
            b = [1 0];
        elseif n == 2
            b = [0 1];
        end
    end
end