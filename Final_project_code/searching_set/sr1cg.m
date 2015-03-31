function [a,f] = linesearch(p,x,f,d,D,o)

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

% Unit step lengths
if strcmp(o,'unit') == 1
  
  % Evaluate unit steplength
  a = 1;

  % Evaluate function value
  f = feval(p,x+a*d,0);
  
elseif strcmp(o,'backtrack') == 1
  
  % IMPLEMENT BACKTRACKING LINE SEARCH HERE
  
else
  
  % IMPLEMENT WOLFE LINE SEARCH HERE
  
end

function a = zoom()

% function a = zoom()
%
% Author      : (your name here)
% Description : Zoom function for Wolfe line search.
% Input       : 
% Output      : a ~ step length

% IMPLEMENT ZOOM FUNCTION HERE