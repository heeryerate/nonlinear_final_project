function v = concave(x,o)

% function v = rosenbrock(x,o)
%
% Author      : Frank E. Curtis
% Description : Rosenbrock function evaluator.
% Input       : x ~ current iterate
%               o ~ evaluation option
%                     0 ~ function value
%                     1 ~ gradient value
%                     2 ~ Hessian value
% Output      : v ~ function, gradient, or Hessian value

% Switch on o
switch o
  
  case 0

    % Evaluate function
    v = -x(1)^2-x(2)^2;
  
  case 1
  
    % Evaluate gradient
    v = [-2*x(1);
               -2*x(2)           ];

  case 2

    % Evaluate Hessian
    v = [-2 0;
         0             -2      ];
  
end