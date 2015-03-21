% Input class
classdef Input < handle
    
    % Class properties (private set access)
    properties (SetAccess = public)
        f                       % function handle
        x                       % initial iteration
        n_v                     % number of variables
        opttol                  % optimality tolerance
        maxiter                 % iteration limit
        Trust_c1                % trust region radius update parameter
        Trust_c2                % trust region radius update parameter
        algorithm               % Algorithm
        CG_opttol               % CG optimality tolerance
        CG_maxiter              % CG iteration limit
        Linesearch_c1           % Armijo line search conditions parameter
        Linesearch_c2           % curvature line search conditions parameter
        SR1_update_tol          % tolerance for SR1 Hessian approximation updates
        BFGS_update_tol         % tolerance for BFGS Hessian approximation updates
    end
    
    % Class methods
    methods
        % Constructor
        function i = Input(dirname)
            % Assert that problem function directory has been provided as a string
            assert(ischar(dirname),'Optsolver: Problem set folder, dirname, must be specified as a string.');
            
            % Print directory
            fprintf('Optsolver: Adding to path the directory "%s"\n',dirname);
            
            % Add problem function directory to path
            addpath(dirname);
            
            % Assert that slqpgs_inputs.m exists in problem function directory
            problem_dir = dir(sprintf('./%s',dirname));
            
            problem = {};
            num_var = {};
            for k = 4:length(problem_dir)
                name = problem_dir(k).name(1:end-2);
                problem{k-3} = name;
                num_var{k-3} = str2num(name(regexp(name,'\d')));
                assert(exist(sprintf('%s/%s.m',dirname,problem{k-3}),'file')~=0,sprintf('Optsolver: Problem input file, %s, does not exist.',sprintf('%s/%s.m',dirname,problem{k-3})));
            end
%             i.f = problem;
%             i.n_v = num_var
            
            fprintf('Optsolver: There are %i problems in problem set folder "./%s"\n', length(problem), dirname);
            fprintf('Optsolver: The %i problem handles are:', length(problem));
            for k = 1:length(problem)
                fprintf(' %i:"%s" ',k,problem{k});
            end
            fprintf('\n')
            
            % Assert that problem function has been specified
            optfunction = 'Input number of function handle: ';
            n = input(optfunction);
            in.f = problem{n};
            in.n_v = num_var{n};
            
            % Set problem function handle
            assert(isfield(in,'f') & ischar(in.f),'Optsolver: Problem functions handle, i.f, must be specified as a string.');
            i.f = in.f;
            
            % Set problem size
            assert(isfield(in,'n_v') & i.isscalarinteger(in.n_v),'Optsolver: Number of variables, i.n_v, must be specified as a scalar integer.');
            i.n_v = in.n_v;
            
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
            assert(isfield(in,'Linesearch_c1') & i.isproperparameter(in.Linesearch_c1),'Optsolver: Armijo line search parameter, i.Linesearch_c1, must be specified as a real number in interval (0,1)')
            assert(isfield(in,'Linesearch_c2') & i.isproperparameter(in.Linesearch_c2),'Optsolver: curvature line search parameter, i.Linesearch_c2, must be specified as a real number in interval (0,1)')
            assert(in.Linesearch_c1 < in.Linesearch_c2, 'Optsolver: Armijo line search parameter, i.Linesearch_c1, must be less than curvature line search parameter i.Linesearch_c2')
            i.Linesearch_c1 = in.Linesearch_c1;
            i.Linesearch_c2 = in.Linesearch_c2;

            % Set trust region radius update parameters
            assert(isfield(in,'Trust_c1') & i.isproperparameter(in.Trust_c1),'Optsolver: the first trust region radius update parameter, i.Trust_c1, must be specified as a real number in interval (0,1)')
            assert(isfield(in,'Trust_c2') & i.isproperparameter(in.Trust_c2),'Optsolver: the second trust region radius update parameter, i.Trust_c2, must be specified as a real number in interval (0,1)')
            assert(in.Trust_c1 < in.Trust_c2, 'Optsolver: the first trust region radius update parameter, i.Trust_c1, must be less than the second trust region radius update parameter i.Trust_c2')
            i.Trust_c1 = in.Trust_c1;
            i.Trust_c2 = in.Trust_c2;

            % Set CG optimality tolerance and iteration limit
            if isfield(in,'CG_opttol'), i.CG_opttol = in.CG_opttol; else i.CG_opttol = 1e-06; end;
            if isfield(in,'CG_maxiter'), i.CG_maxiter = in.CG_maxiter; else i.CG_maxiter = 1e+03; end;

            % Set tolerance for SR1 and BFGS Hessian approximation updates
            if isfield(in,'SR1_update_tol'), i.SR1_update_tol = in.SR1_update_tol; else i.SR1_update_tol = 1e-04; end;
            if isfield(in,'BFGS_update_tol'), i.BFGS_update_tol = in.BFGS_update_tol; else i.BFGS_update_tol = 1e-04; end;
                        
            % Assert that initial point has been specified
            assert(isfield(in,'x') & length(in.x) == i.n_v,'Optsolver: Initial point, i.x, must be specified as a vector of length n_v');
            
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