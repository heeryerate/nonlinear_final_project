function H = sr1update(p,s,x,i,H)
    x1 = x + s;
    y = feval(p,x1,1)-feval(p,x,1);
    buf = s-H*y;
    H = H + (buf*buf')/(buf'*y);
end