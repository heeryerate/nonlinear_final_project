function a = backtrack(p,x,d,i)

% function [a,f] = linesearch(p,x,f,d,D,o)
%
% Author      : Frank E. Curtis
% Description : Line search subroutines for steepestdescent.m.
% Input       : p ~ problem function handle
%               x ~ point
%               f ~ function value
%               d ~ search direction
%               D ~ directional derivative value
%               o ~ line search option
% Output      : a ~ step size
%               f ~ updated function value
% Revised by  : (your name here)
  
% IMPLEMENT BACKTRACKING LINE SEARCH HERE
  
  a0 = 0;
  a1 = 1e-5;
  amax = 1e+2; 
  count = 0;
  while True
    count = count + 1;
    if phi(p,x,d,a1) > phi(p,x,d,0) + i.c1ls*a1*gphi(p,x,d,0) | (phi(p,x,d,a1) >= phi(p,x,d,a0) & count>1)
      a = zoom(a0,a1);
      break
    end

    if abs(gphi(p,x,d,a1)) <= -i.c2ls*gphi(p,x,d,0)
      a = a1;
      break
    end

    if gphi(p,x,d,a1) >= 0
      a = zoom(a1,a0);
      break
    end

    a0 = a1;
    a1 = a1+rand(1)*(amax-a1);
  end

function phivalue = phi(p,x,d,a)
  res = x+a*d;
  phivalue = feval(p,res,0)
end

function gphivalue = gphi(p,x,d,a)
  res = x+a*d;
  gphivalue = feval(p,res,1)'*d
end

function ad = zoom(b,c)
    ad = (b+c)/2
end

% function a = zoom()
%
% Author      : (your name here)
% Description : Zoom function for Wolfe line search.
% Input       : 
% Output      : a ~ step length

