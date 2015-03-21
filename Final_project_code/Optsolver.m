% Optsolver class

addpath('./Algorithm_set', './problem_set','./searching_set');
classdef Optsolver

  % Class properties (private access)
  properties (SetAccess = public, GetAccess = public)
    
    i % Input object
    %o % Output object
    %c % Counter object
    % p % Parameter object
    % z % Iterate object
    % d % Direction object
    
  end
  
  % Class methods
  methods
  
    % Constructor
    function S = Optsolver(dirname)

      % Construct classes
      S.i = Input(dirname);
      % S.o = Output;
      % S.c = Counter;
      % S.p = Parameter;
      % S.z = Iterate(S.i,S.c,S.p);
      % S.d = Direction(S.i);
      % S.a = Acceptance;

    end
    
    % Gets primal solution
    function x = getSolution(S)
      % x = S.z.getx;
      x = 3
    end
    
    % Optimization algorithm
    function optimize(S)

      % % Print header and line break
      % S.o.printHeader(S.i);
      % S.o.printBreak(S.c);
      
      % % Iteration loop
      % while ~S.z.checkTermination(S.i,S.c,S.d)
      %   S.o.printIterate(S.c,S.z);
      %   S.d.evalStep(S.i,S.c,S.p,S.z);
      %   S.o.printDirection(S.z,S.d);
      %   S.a.lineSearch(S.i,S.c,S.p,S.z,S.d);
      %   S.o.printAcceptance(S.a);
      %   S.z.updateIterate(S.i,S.c,S.p,S.d,S.a,1);
      %   S.c.incrementIterationCount;
      %   S.o.printBreak(S.c);
      % end
      
      % % Print footer and terminate
      % S.o.printFooter(S.i,S.c,S.z,S.d);
      % S.o.terminate;
      
    end
        
  end
  
end
