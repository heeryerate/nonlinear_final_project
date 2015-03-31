function flag = Termination(p,x,normg0,i)
    g = feval(p,x,2)
    if k > i.maxiter || norms(g) <= opttol*max(normsg0,1), break; end;
end