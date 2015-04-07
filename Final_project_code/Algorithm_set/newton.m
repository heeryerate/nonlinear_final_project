function d = newton(p,x,i,H)
  g = feval(p,x,1);
  H = feval(p,x,2);
  xi = 1e-4;
  n = length(x);
  while min(eig(H))<0
      H = H + xi*eye(n);
      xi = 10*xi;
  end
  d = -H\g;
end