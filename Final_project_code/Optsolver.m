% Global solver Optsolver 
function [x,k] = Optsolver(p, x, a, i)
  tic
  % Add problem_set, algorithm_set and searching_set to the search path
  addpath('./problem_set','./Algorithm_set','./searching_set');
  
  % Set default parameters
  default;

  % Check if all the input variables are valid and analyze those variables
  [p,alg,sea] = Checkvars(p,x,a,i);
  
  % Output the optimal solution found and iterations
  [x,k] = Optimizer(p,alg,sea,x,i);
  fprintf('CPU time: %.4f\t',toc)
end
  
