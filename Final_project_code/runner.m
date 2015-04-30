function runner(problem,x)

% function runner (problem,x)
%
% Author                :  Xi He
% Description           :  Solve problem 'p' by all algorithms with initial point 'x'
% Input                 :  problem ~ Problem handle
%                          x ~ Initial point

 % State global count number
global COUNTF;
global COUNTG;
global COUNTH;
global COUNTS;

% All possible algorithms for this project
algs = {'steepestbacktrack', 'steepestwolfe', 'newtonbacktrack','newtonwolfe','trustregioncg','sr1trustregioncg','bfgsbacktrack','bfgswolfe' };

% Write data to Optsolver.txt
resdis = fopen('MrEleven.txt','w');
resdis2 = fopen('runner.txt','w');
assert(resdis~=-1,'MrEleven: Failed to open MrEleven.txt.');
assert(resdis2~=-1,'MrEleven: Failed to open runner.txt.');

disp(sprintf('\\textbf{%s}&\t%-12s&\t%-7s&   %-10s&   %s&%s&%s&%s\\\\\n\\hline',upper(problem),'gNorm','Iter.','Cputime','feval','geval','Hevel','Linsolved'))
%disp(sprintf('%-19s%-11s%-7s%-10s%s',upper(problem),'gNorm','Iter.','Cputime','(f,g,H,S)'))
fprintf(resdis2,'%-19s%-11s%-7s%-10s%s\n',upper(problem),'gNorm','Iter.','Cputime','(f,g,H,S)');

% Run Optsolver on different algorithms
for p = 1:length(algs)
    tic
    [d,k] = MrEleven(problem,x,algs{p},i);

    disp(sprintf('%-20s&\t$%-10.3e$&\t$%-5i$&   $%-8.4f$&$%-5i$&$%-5i$&$%-5i$&$%-5i$\t    \\\\',algs{p},norm(feval(problem,d,1)),k,toc,COUNTF,COUNTG,COUNTH,COUNTS));
    %disp(sprintf('%-19s%-11.3e%-7i%-10.4f(%i,%i,%i,%i)\t',algs{p},norm(feval(problem,d,1)),k,toc,COUNTF,COUNTG,COUNTH,COUNTS));
    resdis2 = fopen('runner.txt','a');
    fprintf(resdis2,'%-19s%-11.3e%-7i%-10.4f(%i,%i,%i,%i)\t\n',algs{p},norm(feval(problem,d,1)),k,toc,COUNTF,COUNTG,COUNTH,COUNTS);
end
fclose('all');
end