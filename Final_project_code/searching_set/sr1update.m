function H = sr1update(p,s,x,f,g,g1,H,i)
% Compute difference between current gradient value and previous point gradient value
y = g1-g;

% Set buf and nobuf to save computation
buf = y-H*s;
nobuf = buf'*s;

% If (y-H*s)'*s is nonzero and nobuf is greater than the threshold
if any(nobuf) == 1 && abs(nobuf) >= i.sr1updatetol*norm(buf)*norm(s)
    % Update Hessian matrix by sr1 update formula
    H = H + (buf*buf')/nobuf;
end
end