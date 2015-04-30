function H = Hessianupdate(p,s,x,d,f,g,g1,H,i)

% Calculation difference between current point gradient and previous point gradient
y = g1-g;

% Set buf, a1, a2 to save computation
buf = H*s;
a1 = s'*y;
a2 = s'*buf;

% If s'*y is greater than threshold 
if a1 >= i.bfgsupdatetol*a2

    % Set weight to be 1
  theta = 1;
else

    % Otherwise, shrink the weight theta
  theta = ((1-i.bfgsupdatetol)*a2)/(a2-a1);
end

%  Set r as convex combination of y and H*s
r = theta*y+(1-theta)*buf;

% Use BFGS formula to update approximate Hessian matrix
H = H - (buf*buf')/a2+r*r'/(s'*r);
end