function [d,H] = bfgs(p,x,i,H)
  g = feval(p,x,1);
  d = -H\g;
end