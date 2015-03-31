function resdisplay()

% Start clock
tic;

% Set output stream
resdis = fopen('Optsolver.out','w');

% Assert output stream has been opened
assert(resdis~=-1,'Optsolver: Failed to open slqpgs.out.');

% Store output strings
o.l = '======+===================================================+===========================================+========================+===========';
o.q = 'Iter. |  Objective     Infeas.  |  Pen. Par.     Merit    | Msg.   ||Step||    Mod. Red.       KKT    | Samp. Rad.   Inf. Tol. |  Stepsize';
o.n =                                                             '----  ----------  -----------  ---------- | ----------  ---------- | ----------';



% Print acceptance information
    function printAcceptance(o,a)
        
        % Print steplengths
        fprintf(resdis,'%.4e\n',a.alpha);
        
    end

% Print break in output
    function printBreak(o,c)
        
        % Print break every 20 iterations
        if mod(c.k,20) == 0, fprintf(resdis,'%s\n%s\n%s\n',o.l,o.q,o.l); end;
        
    end

% Print direction information
    function printDirection(o,z,d)
        
        % Print direction information
        fprintf(resdis,'%4d  %.4e  %+.4e  %.4e | %.4e  %.4e | ',d.flag,norm(d.x),d.phi_red,z.kkt,z.epsilon,z.theta);
        
    end

% Print output footer
    function printFooter(o,i,c,z,d)
        
        % Print final iterate information
        o.printIterate(c,z);
        
        % Print close of algorithm output
        fprintf(resdis,'%s\n%s\n\n',o.n,o.l);
        
        % Get solver result
        b = z.checkTermination(i,c,d);
        
        % Print solver result
        fprintf(resdis,'Final result\n');
        fprintf(resdis,'============\n');
        if b == 0, fprintf(resdis,'  EXIT: No termination message set\n'                 ); end;
        if b == 1, fprintf(resdis,'  EXIT: Solution appears stationary and feasible\n'   ); end;
        if b == 2, fprintf(resdis,'  EXIT: Solution appears stationary, but infeasible\n'); end;
        if b == 3, fprintf(resdis,'  EXIT: Iteration limit reached\n'                    ); end;
        fprintf(resdis,'\n');
        
        % Print iterate quantities
        fprintf(resdis,'Final values\n');
        fprintf(resdis,'============\n');
        fprintf(resdis,'  Objective function........................ : %+e\n',z.f);
        fprintf(resdis,'  Feasibility violation..................... : %+e\n',z.v);
        fprintf(resdis,'  Penalty parameter......................... : %+e\n',z.rho);
        fprintf(resdis,'  Sampling radius........................... : %+e\n',z.epsilon);
        fprintf(resdis,'  Primal-dual stationarity error estimate... : %+e\n',z.kkt);
        fprintf(resdis,'\n');
        
        % Print counters
        fprintf(resdis,'Final counters\n');
        fprintf(resdis,'==============\n');
        fprintf(resdis,'  Iterations................................ : %d\n',c.k);
        fprintf(resdis,'  Function evaluations...................... : %d\n',c.f);
        fprintf(resdis,'  Gradient evaluations...................... : %d\n',c.g);
        fprintf(resdis,'  Hessian evaluations....................... : %d\n',c.H);
        fprintf(resdis,'  Subproblems solved........................ : %d\n',c.s);
        fprintf(resdis,'  CPU seconds............................... : %d\n',ceil(toc));
        
    end

% Print output header
    function printHeader(o,i)
        
        % Print Optsolver version
        fprintf(resdis,'+======================+\n');
        fprintf(resdis,'| Optsolver, version 1.2 |\n');
        fprintf(resdis,'+======================+\n');
        fprintf(resdis,'\n');
        
        % Print problem size
        fprintf(resdis,'Problem size\n');
        fprintf(resdis,'============\n');
        fprintf(resdis,'  # of variables.................... : %6d\n',i.nV);
        fprintf(resdis,'  # of equality constraints......... : %6d\n',i.nE);
        fprintf(resdis,'  # of inequality constraints....... : %6d\n',i.nI);
        fprintf(resdis,'\n');
        
        % Set output strings
        if i.algorithm  == 0, alg = 'SQP-GS'; else alg = 'SLP-GS'; end;
        if i.sp_problem == 0, sub = 'primal'; else sub = 'dual'  ; end;
        
        % Print subproblem size
        fprintf(resdis,'Subproblem size (%s,%s)\n',alg,sub);
        if i.algorithm == 0 & i.sp_problem == 0
            fprintf(resdis,'===============================\n');
            fprintf(resdis,'  # of variables.................... : %6d\n',i.nV+1+i.nE+i.nI);
            fprintf(resdis,'  # of linear equality constraints.. : %6d\n',0);
            fprintf(resdis,'  # of linear inequality constraints : %6d\n',1+i.pO+2*(i.nE+sum(i.pE))+i.nI+sum(i.pI));
            fprintf(resdis,'  # of bound constraints............ : %6d\n',i.nE+i.nI);
        elseif i.algorithm == 0
            fprintf(resdis,'=============================\n');
            fprintf(resdis,'  # of variables.................... : %6d\n',i.nV+1+i.pO+2*(i.nE+sum(i.pE))+i.nI+sum(i.pI));
            fprintf(resdis,'  # of linear equality constraints.. : %6d\n',i.nV+1);
            fprintf(resdis,'  # of linear inequality constraints : %6d\n',i.nE+i.nI);
            fprintf(resdis,'  # of bound constraints............ : %6d\n',1+i.pO+2*(i.nE+sum(i.pE))+i.nI+sum(i.pI));
        elseif i.sp_problem == 0
            fprintf(resdis,'===============================\n');
            fprintf(resdis,'  # of variables.................... : %6d\n',i.nV+1+i.nE+i.nI);
            fprintf(resdis,'  # of linear equality constraints.. : %6d\n',0);
            fprintf(resdis,'  # of linear inequality constraints : %6d\n',1+i.pO+2*(i.nE+sum(i.pE))+i.nI+sum(i.pI));
            fprintf(resdis,'  # of bound constraints............ : %6d\n',2*i.nV+i.nE+i.nI);
        else
            fprintf(resdis,'=============================\n');
            fprintf(resdis,'  # of variables.................... : %6d\n',1+i.pO+2*(i.nE+sum(i.pE))+i.nI+sum(i.pI)+2*i.nV);
            fprintf(resdis,'  # of linear equality constraints.. : %6d\n',i.nV+1);
            fprintf(resdis,'  # of linear inequality constraints : %6d\n',i.nE+i.nI);
            fprintf(resdis,'  # of bound constraints............ : %6d\n',1+i.pO+2*(i.nE+sum(i.pE))+i.nI+sum(i.pI)+2*i.nV);
        end
        fprintf(resdis,'\n');
        
    end

% Print iterate information
    function printIterate(o,c,z)
        
        % Print iterate information
        fprintf(resdis,'%5d | %+.4e  %.4e | %.4e  %+.4e | ',c.k,z.f,z.v,z.rho,z.phi);
        
    end

% Terminate output
    function terminate(o)
        
        % Close nonstandard output stream
        if ~ismember(resdis,[0 1 2]), fclose(resdis); end;
        
    end

end
