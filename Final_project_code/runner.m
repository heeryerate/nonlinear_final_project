function runner(problem,x)

    % All possible algorithms for this project  
    algs = {'steepestbacktrack', 'steepestwolfe', 'newtonbacktrack','newtonwolfe','trustregioncg','sr1trustregioncg','bfgsbacktrack','bfgswolfe' };
    
    % Set common input parameters for all algorithms, e.g. i.c1ls = 0.1

    % Use all default parameters
    i = struct();

    disp(sprintf('%-20s\t%s\t%s', 'algor','grad_norm','iters'))
    for p = 1:length(algs)
        [d,k] = Optsolver(problem,x,algs{p},i);
        disp(sprintf('%-20s\t%6.6d\t%i', algs{p},norm(feval(problem,d,1)),k))
    end
    fprintf('\n');
end