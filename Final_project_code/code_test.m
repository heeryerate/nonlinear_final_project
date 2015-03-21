function i = code_test(dirname)

    % Assert that problem function directory has been provided as a string
    assert(ischar(dirname),'Optsolver: Problem set folder, dirname, must be specified as a string.');
    
    % Print directory
    fprintf('Optsolver: Adding to path the directory "%s"\n',dirname);

    % Add problem function directory to path
    addpath(dirname);

    % Assert that slqpgs_inputs.m exists in problem function directory
    problem_dir = dir(sprintf('./%s',dirname));

    problem = {};
    for k = 4:length(problem_dir)
        problem{k-3}= problem_dir(k).name(1:end-2);
        assert(exist(sprintf('%s/%s.m',dirname,problem{k-3}),'file')~=0,sprintf('Optsolver: Problem input file, %s, does not exist.',sprintf('%s/%s.m',dirname,problem{k-3})));
    end
    i.f = problem;
    
    fprintf('Optsolver: There are %i problems in problem set folder "./%s"\n', length(i.f), dirname);
    fprintf('Optsolver: The %i problem handles are:', length(i.f));
    for k = 1:length(i.f)
        fprintf(' %i:"%s" ',k,i.f{k});
    end
    fprintf('\n')
    
    % Print inputs file
    fprintf('Optsolver: Loading inputs from "./%s.m"\n','input_parameters');
      
    % Read problem data
    in = feval('input_parameters');
      
    % Set data for functions
    if isfield(in,'algorithm'),  i.algorithm  = in.algorithm;  else i.algorithm  = 'steepestbacktrack';end;

    % Set problem size
    assert(isfield(in,'n_v') & length(in.n_v) == 1 & isscalarinteger(in.n_v),'Optsolver: Number of variables, i.n_v, must be specified as a scalar integer.');
    i.n_v = in.n_v;
    
    % Set data for functions
    if isfield(in,'opttol'), i.opttol = in.opttol; else i.opttol = 1e-06; end;
    if isfield(in,'maxiter'), i.maxiter = in.maxiter; else i.maxiter = 1e+03; end;

    % Set Armijo and curvature line search conditions parameters
    if isfield(in,'CG_opttol'), i.CG_opttol = in.CG_opttol; else i.CG_opttol = 1e-06; end;
    if isfield(in,'CG_maxiter'), i.CG_maxiter = in.CG_maxiter; else i.CG_maxiter = i.n_v+1; end;

    % Assert that problem function has been specified
    assert(isfield(in,'f') & ischar(in.f),'Optsolver: Problem functions handle, i.f, must be specified as a string.');
      
    % Set problem function handle
    i.f = in.f;

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
    
    % Function for asserting scalar integers
    function b = isscalarinteger(a)
        
        % Check length
        if length(a) > 1, b = 0; return; end;
        
        % Evaluate boolean
        b = (isnumeric(a) & isscalar(a) & round(a) == a);

    end
end