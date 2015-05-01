%  Brief introduction on running these code.

%  1. Algorithm_Set is a collection of main algorithm, all to obtain descent direction.

%  2. Searching_Set is a collection of subproblem solver, to derive proper step-size, update approximate Hessian matrix and solve trust region subproblem.

%  3. Problem_Set is a collection of test problems.

%  4. In the root folder, all parameters are setting in Default.m file and Checkvars are designed to analysis variables and check parameters.

%  5. MrEleven.m is the main solver which has four arguments
%      e.g. MrEleven('rosenbrock', [1,1]', 'newtonbraktrack', i)

%  6. runner.m is a integrated function to collect all the results from all the eight algorithms with respect to a specific problem and a initial point.
%       e.g runner('rosenbrock', [1,1]')

%  7. MrEleven.txt and runner.txt store results of all algorithms and a brief output of all the results.

