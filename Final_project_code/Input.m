% Input class
classdef Input < handle
    
    % Class properties (private set access)
    properties (SetAccess = public)
        f                       % function handle
        x                       % initial iteration
        numv                     % number of variables
        opttol                  % optimality tolerance
        maxiter                 % iteration limit
        c1tr               % trust region radius update parameter
        c2tr                % trust region radius update parameter
        algorithm               % Algorithm
        cgopttol               % CG optimality tolerance
        cgmaxiter              % CG iteration limit
        c1ls           % Armijo line search conditions parameter
        c2ls           % curvature line search conditions parameter
        sr1updatetol          % tolerance for SR1 Hessian approximation updates
        bfgsupdatetol         % tolerance for BFGS Hessian approximation updates
    end
    
    % Class methods
    methods
        % Constructor
        function i = Input(para)
       
            assert(exist(sprintf('problem_set/%s.m', para.f),'file')~=0,sprintf('Optsolver: Problem input file, %s, does not exist.',sprintf('problem_set/%s.m',para.f)));
            i.f = para.f
            
            % Set problem function handle
            assert(isfield(in,'f') & ischar(in.f),'Optsolver: Problem functions handle, i.f, must be specified as a string.');
            i.f = in.f;
            
            % Set problem size
            assert(isfield(in,'numv') & i.isscalarinteger(in.numv),'Optsolver: Number of variables, i.numv, must be specified as a scalar integer.');
            i.numv = in.numv;
            
            % Print inputs file
            fprintf('Optsolver: Loading inputs from "./%s.m"\n','input_parameters');
            
            % Read problem data
            in = feval('input_parameters');
            
            % Set data for functions
            if isfield(in,'algorithm'),  i.algorithm  = in.algorithm;  else i.algorithm  = 'steepestbacktrack';end;
            
            % Set data for functions
            if isfield(in,'opttol'), i.opttol = in.opttol; else i.opttol = 1e-06; end;
            if isfield(in,'maxiter'), i.maxiter = in.maxiter; else i.maxiter = 1e+03; end;
            
            % Set Armijo and curvature line search conditions parameters 
            assert(isfield(in,'c1ls') & i.isproperparameter(in.c1ls),'Optsolver: Armijo line search parameter, i.c1ls, must be specified as a real number in interval (0,1)')
            assert(isfield(in,'c2ls') & i.isproperparameter(in.c2ls),'Optsolver: curvature line search parameter, i.c2ls, must be specified as a real number in interval (0,1)')
            assert(in.c1ls < in.c2ls, 'Optsolver: Armijo line search parameter, i.c1ls, must be less than curvature line search parameter i.c2ls')
            i.c1ls = in.c1ls;
            i.c2ls = in.c2ls;

            % Set trust region radius update parameters
            assert(isfield(in,'c1tr          ') & i.isproperparameter(in.c1tr  ),'Optsolver: the first trust region radius update parameter, i.c1tr  , must be specified as a real number in interval (0,1)')
            assert(isfield(in,'c2tr') & i.isproperparameter(in.c2tr),'Optsolver: the second trust region radius update parameter, i.c2tr, must be specified as a real number in interval (0,1)')
            assert(in.c1tr   < in.c2tr, 'Optsolver: the first trust region radius update parameter, i.c1tr    , must be less than the second trust region radius update parameter i.c2tr')
            i.c1tr   = in.c1tr    ;
            i.c2tr = in.c2tr;

            % Set CG optimality tolerance and iteration limit
            if isfield(in,'cgopttol'), i.cgopttol = in.cgopttol; else i.cgopttol = 1e-06; end;
            if isfield(in,'cgmaxiter'), i.cgmaxiter = in.cgmaxiter; else i.cgmaxiter = 1e+03; end;

            % Set tolerance for SR1 and BFGS Hessian approximation updates
            if isfield(in,'sr1updatetol'), i.sr1updatetol = in.sr1updatetol; else i.sr1updatetol = 1e-04; end;
            if isfield(in,'bfgsupdatetol'), i.bfgsupdatetol = in.bfgsupdatetol; else i.bfgsupdatetol = 1e-04; end;
                        
            % Assert that initial point has been specified
            assert(isfield(in,'x') & length(in.x) == i.numv,'Optsolver: Initial point, i.x, must be specified as a vector of length numv');
            
            % Set initial point
            i.x = in.x;
            
            % Print success message
            fprintf('Optsolver: Inputs appear loaded successfully\n');
            fprintf('Optsolver: Problem to be read from "./%s/%s.m"\n',dirname,i.f);
            fprintf('Optsolver: Use "S.optimize" to run optimizer\n');
            fprintf('Optsolver: Output to be printed to Optsolver.out\n');
            fprintf('Optsolver: Use "S.getSolution" to return final iterate\n');
            fprintf('Optsolver: (After optimizing and getting iterate, advised to "clear S" before loading new problem)\n'); 
        end
    end
        
    % Class methods (static)
    methods(Static)
            
        % Function for asserting scalar integers
        function b = isscalarinteger(a)
            
            % Check length
            if length(a) > 1, b = 0; return; end;
            
            % Evaluate boolean
            b = (isnumeric(a) & isscalar(a) & round(a) == a);
        end
        
        % Function for asserting scalar integers
        function b = isproperparameter(a)
            
            % Check length
            if length(a) > 1, b = 0; return; end;
            
            % Evaluate boolean
            b = (isnumeric(a) & a>0 & a<1);
        end
    end
end
