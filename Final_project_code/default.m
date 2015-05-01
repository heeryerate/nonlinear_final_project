%% Set default parameters
default_para = struct(...
    'maxiter',          1e+3,...
    'opttol',           1e-6,...
    'c1ls',             1e-6,...
    'c2ls',             0.9,...
    'c1tr',             0.3,...
    'c2tr',             0.8,...
    'cgopttol',         1e-6,...
    'cgmaxiter',        5e+2,...
    'initialradius',    1.0,...
    'sr1updatetol',     1e-8,...
    'bfgsupdatetol',    0.2,...
    'perturbHession',   1e-4,...
    'shrinkradius',     1/4,...
    'expandradius',     2,...
    'shrinkbacktrack',  0.25,...
    'residuetol',       1e-12,...
    'wolfemax',         10,...
    'posdeftol',        0.1,...
    'mineigtol',        1.0);

%% Set up user-defined parameter (if possible.)
%% If there is no user-defined parameter, set i to be default value.
if ~isstruct(i)
    i = default_para;
end

% Read all acceptable parameter names in default_para
optionNames = fieldnames(default_para);

% Read all parameter names in input i
inpName = fieldnames(i);

% Count valid input parameter in i
nArgs = length(inpName);

% Check if input parameter of i are valid and update the corresponding parameter in default_para
for j = 1:nArgs
    % Check if input parameter of i are valid
    flag = any(strcmp(optionNames,inpName(j)));
    
    % If input parameter of i are invalid, throw error
    assert(flag== 1,sprintf('%s are invalid parameter of i', inpName{j}));
    
    % If input parameter of i are valid, update the corresponding parameter in default_para
    if flag
        
        % Find the corresponding parameter in default_para
        k = strcmp(optionNames,inpName(j));
        
        % Overwrite the parameter value
        default_para.(optionNames{k}) = i.(inpName{j});
    end
end

i = default_para;

%% Set global count number
% Number of objective function value evaluation
global COUNTF;

% Number of gradient value evaluation
global COUNTG;

% Number of Hessian evaluation
global COUNTH;

% Number of system 
global COUNTS;

% Set all count number to be zero
COUNTF = 0;
COUNTG = 0;
COUNTH = 0;
COUNTS = 0;