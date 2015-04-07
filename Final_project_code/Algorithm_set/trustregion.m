function [x,D] = trustregion(sea,p,x,i,H,D)
    eta = 0.15;
    f = feval(p,x,0);
    g = feval(p,x,1);
    if strcmp(sea,'sr1cg')  
        d = feval('cg',g,i,D,H);
        H = sr1update(p,d-x,x,i,H);
    else
        H = feval(p,x,2);
        d = feval('cg',g,i,D,H);
    end
    rho = (f-feval(p,x+d,0))/(-g'*d-d'*H*d);
    if rho < i.c1tr
        D = norm(d)/2;
    else
        if rho > i.c2tr && norm(d) == D
            D = min(2*D,i.radius);
        end
    end
    
    if rho > eta
        x = x + d;
    end
end