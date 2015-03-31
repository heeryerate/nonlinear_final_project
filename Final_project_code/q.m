algs = {'steepestbacktrack', 'steepestwolfe', 'newtonbacktrack','newtonwolfe','trustregioncg','sr1trustregioncg','bfgsbacktrack','bfgswolfe' };
p = 'steepestwolfe';
for i = 1:length(algs)
    if strcmp(p,algs{i})
        o=i
        break
    end
end

switch p
    case 'steepestbacktrack'
        alg = 'steepest'
    case 'steepestwolfe'
        alg = 'newton'
end