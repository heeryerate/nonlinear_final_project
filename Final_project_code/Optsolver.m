% Optsolver: 
function x = Optsolver(p, x, a, i)
  addpath('./problem_set','./Algorithm_set','./searching_set');
  [p,alg,sea] = Checkvars(p,x,a,i);
  x = Optimizer(p,alg,sea,i);
end
  
function x = Optimizer(p,alg,sea,i)
    % Initialize iteration counter
    k = 0;

    % Evaluate objective function
    f = feval(p,x,0);

    % Evaluate objective gradient
    g = feval(p,x,1);

    % Evaluate inital gradient norm
    normsg0 = norm(g);

    while ~Termination(p,x,normg0,i)
        if sea ~= 'cg' & sea ~= 'sr1cg'
            d = feval(alg,p,x,d,i);
            alpha = feval(sea,p,i);
            update();
        else
            [d,alpha] = feval(sea,p,i);
            trustregion(sea,p,i);
            update();
        end
    end
end