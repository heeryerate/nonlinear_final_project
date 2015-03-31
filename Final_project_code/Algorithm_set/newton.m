function d = newton(p,x,i)
  g = feval(fun,x,1);
  H = feval(fun,x,2);
  d = -H\g;
end