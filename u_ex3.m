function u = u_ex3(x)
    [theta, r] = cart2pol(x(1), x(2));
    
    if (theta<0) theta = theta+2*pi, end
    
    u = r^(2/3)*sin(2/3*theta);
end