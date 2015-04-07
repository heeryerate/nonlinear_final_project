function v = easyproblem(x,o)

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
    v = (x(2)+2*x(1))^4+x(1)^2+x(2)^2;
  
  case 1
  
    % Evaluate gradient
    v = [2*x(1)+8*(2*x(1)+x(2))^3;
               2*x(2)+4*(2*x(1)+x(2))^3            ];

  case 2

    % Evaluate Hessian
    v = [2+48*(2*x(1)+x(2))^2 24*(2*x(1)+x(2))^2;
         24*(2*x(1)+x(2))^2               2+12*(2*x(1)+x(2))^2      ];
  
end