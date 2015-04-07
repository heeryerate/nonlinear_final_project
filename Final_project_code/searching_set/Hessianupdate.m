function H = Hessianupdate(p,s,x,i,H)
  x1 = x + s;
  y = feval(p,x1,1)-feval(p,x,1);
  buf = H*s;
  a1 = s'*y;
  a2 = s'*buf;
  if a1 >= 0.2*a2
      theta = 1;
  else
      theta = (0.8*a2)/(a2-a1);
  end
  r = theta*y+(1-theta)*buf;
  H = H - (buf*buf')/a2+r*r'/(s'*r);
end