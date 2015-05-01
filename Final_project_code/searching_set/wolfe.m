function [a,g] = wolfe(p,x,d,f,g,H,i)

% function  [a,g] = wolfe(p,x,d,f,g,H,i)
%
% Author      : Xi He
% Description : Calculate step-size along a descent direction d
% Input       : p ~ problem handle
%               x ~ current point
%               f, g, H ~ function value, gradient value and Hessian matrix at current point
%               d ~ current descent direction
%               i ~ parameter set
% Output      : a ~ step-size along a descent direction
%                  : g ~ updated gradient value 

% Set initial parameters for wolfe-conditions
a0 = 0;
a1 = 1;

% Maximal acceptance step-size
amax = i.wolfemax;

% Set initial iteration counter to be 0
count = 0;

gphi0 = g'*d;
phi0 = f;
phi1 = phi(p,x,d,a1);
[gf1,gphi1] = gphi(p,x,d,a1);

% While True
while 1
    
    % Increment iteration counter
    count = count + 1;
    
    % Evaluation \phi(0), \phi(a_i), gradient of \phi at 0, gradient of \phi at a_i
    
    if a1 == 1;
        phia1 = phi1;
        gf = gf1;
        gphia1 = gphi1;
    else
        phia1 = phi(p,x,d,a1);
        [gf,gphia1] = gphi(p,x,d,a1);
    end
    
    % If a_i is almost same as amax, output a as a_i
    if a1 >= (1-1e-10)*amax
        a = a1;
        g = gf;
        break;
    end
    
    
    % If a_i doesn't satisfy the sufficient condition,
    if phia1 > phi0 + i.c1ls*a1*gphi0 ...
            | (phia1 >= phi(p,x,d,a0) & count>1)
        
        % Choose an proper a between a_{i-1} and a_{i}
        [a,g] = zoom(p,x,d,i,a0,a1,phi0,gphi0);
        
        % Output a and stop
        break;
    end
    
    % If a_i satisfy the curvature condition
    if abs(gphia1) <= -i.c2ls*gphi0
        
        % Set a_i to be a and output
        a = a1;
        g = gf;
        break;
    end
    
    % If gradient of \phi at a_i is greater than 0, which means it's too far away from the acceptance step size
    if gphia1 >= 0
        
        % Shrink a1 to be a proper step size between a_{i-1} and a_i
        [a,g] = zoom(p,x,d,i,a1,a0,phi0,gphi0);
        break;
    end
    
    % Set a_i to be a_{i-1}
    a0 = a1;
    
    % Choose a_i as the midden point of a_i and amax
    a1 = (a1+amax)/2.0;
    
end
end

% Zoom function that to find a proper step size in an interval
function [azoom,g] = zoom(p,x,d,i,alow,ahigh,phi0,gphi0)

while 1
    
    % Choose amid as the middle point of alow and ahigh
    amid = (alow+ahigh)/2;
    
    phimid = phi(p,x,d,amid);
    philow = phi(p,x,d,alow);
    
    % If amid doesn't satisfy the sufficient descent condition
    if phimid > phi0 + i.c1ls*amid*gphi0...
            | phimid >= philow
        
        % Set ahigh to be amidle
        ahigh = amid;
    else
        %Evaluation gradient value of \phi at amid
        [gf,gphimid] = gphi(p,x,d,amid);
        
        % If amid satisfies curvature condition
        if abs(gphimid) <= -i.c2ls*gphi0
            
            % Set azoom to be amid and stop
            azoom = amid;
            g = gf;
            break;
        end
        
        % If gphimid*(ahigh-alow) >= 0, which means that alow is greater than ahigh
        if gphimid*(ahigh-alow) >= 0
            
            % Reset ahigh to be alow
            ahigh = alow;
        end
        
        % Set alow to be amid and keep running the loop
        alow = amid;
    end
    
    % If ahigh and alow are pretty close, we simply set amid as the midden point between alow and ahigh
    if (ahigh-alow)<=1e-10
        azoom=0.5*(ahigh+alow);
        g = feval(p,x+d*azoom,1);
        global COUNTG;
        COUNTG = COUNTG + 1;
        return;
    end
end
end

% Function to evaluate \phi function value at a
function phivalue = phi(p,x,d,a)
% Increment global function counter
global COUNTF;
COUNTF = COUNTF + 1;

res = x+a*d;
phivalue = feval(p,res,0);
end
% Function to evaluate gradient value of \phi at a
function [g,gphivalue] = gphi(p,x,d,a)
% Increment global function counter
global COUNTG;
COUNTG = COUNTG + 1;

res = x+a*d;
g = feval(p,res,1);
gphivalue = g'*d;
end