% Check all input variables, make sure they are all valid
function [p,alg,sea] = Checkvars(p,x,a,i)

% Problems handle must be a string
assert(ischar(p),'Optsolver: Problem functions handle, p, must be specified as a string.');

% Problems handle must be valid, and located in the 'problem_set' directory
assert(exist(sprintf('problem_set/%s.m', p),'file')~=0,sprintf('Optsolver: Problem input file, %s, does not exist.',sprintf('problem_set/%s.m',p)));

% Algorithm handle must be a string
assert(ischar(a),'Optsolver: Algorithm description, a, must be specified as a string.');

% All possible algorithms for this project
algs = {'steepestbacktrack', 'steepestwolfe', 'newtonbacktrack','newtonwolfe','trustregioncg','sr1trustregioncg','bfgsbacktrack','bfgswolfe' };

% Algorithms handle must be valid
assert(ismember(a,algs)~=0,sprintf('Optsolver: Algorithm description, %s, doesn''t exist.',a));

% Split algorithms to be algorithm part and search method part
switch a
    case algs{1}
        alg = 'steepest';
        sea = 'backtrack';
    case algs{2}
        alg = 'steepest';
        sea = 'wolfe';
    case algs{3}
        alg = 'newton';
        sea = 'backtrack';
    case algs{4}
        alg = 'newton';
        sea = 'wolfe';
    case algs{5}
        alg = 'trustregion';
        sea = 'cg';
    case algs{6}
        alg = 'trustregion';
        sea = 'sr1cg';
    case algs{7}
        alg = 'bfgs';
        sea = 'backtrack';
    case algs{8}
        alg = 'bfgs';
        sea = 'wolfe';
end

% Check Armijo and curvature line search conditions parameters value
assert(isproperparameter(i.c1ls),'Optsolver: Armijo line search parameter, i.c1ls, must be specified as a real number in interval (0,1)')
assert(isproperparameter(i.c2ls),'Optsolver: curvature line search parameter, i.c2ls, must be specified as a real number in interval (0,1)')
assert(i.c1ls < i.c2ls, 'Optsolver: Armijo line search parameter, i.c1ls, must be less than curvature line search parameter i.c2ls')

% Check trust region radius update parameters value
assert(isproperparameter(i.c1tr),'Optsolver: the first trust region radius update parameter, i.c1tr, must be specified as a real number in interval (0,1)')
assert(isproperparameter(i.c2tr),'Optsolver: the second trust region radius update parameter, i.c2tr, must be specified as a real number in interval (0,1)')
assert(i.c1tr < i.c2tr, 'Optsolver: the first trust region radius update parameter, i.c1tr, must be less than the second trust region radius update parameter i.c2tr')
end

% A function to test whether a value is valid parameter
function b = isproperparameter(a)

% Check length
if length(a) > 1, b = 0; return; end;

% Evaluate boolean
b = (isnumeric(a) & a>0 & a<1);
end