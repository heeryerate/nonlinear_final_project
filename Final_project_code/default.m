% Set default parameters
default_para = struct(...
    'maxiter',      1e+3,...
    'opttol',       1e-6,...
    'c1ls',         1e-4,...
    'c2ls',         0.9,...
    'c1tr',         0.1,...
    'c2tr',         0.75,...
    'cgopttol',     1e-6,...
    'cgmaxiter',    1e+3,...
    'radius',       1.0,...
    'sr1updatetol', 1e-6);



% If the number of input variable for Optsolver function is 3, set i to be default value.
if nargin == 3
    i = defaul_para;
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