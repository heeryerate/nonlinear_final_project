function a = wolfe(p,x,d,i)
  a0 = 0;
  a1 = 1e-2;
  amax = 1;
  count = 0;
  while count < i.maxiter
    count = count + 1;
    if phi(p,x,d,a1) > phi(p,x,d,0) + i.c1ls*a1*gphi(p,x,d,0) ...
            | (phi(p,x,d,a1) >= phi(p,x,d,a0) & count>1)
      a = zoom(p,x,d,i,a0,a1);
      break;
    end

    if abs(gphi(p,x,d,a1)) <= -i.c2ls*gphi(p,x,d,0)
      a = a1;
      break;
    end

    if gphi(p,x,d,a1) >= 0
      a = zoom(p,x,d,i,a1,a0);
      break;
    end
    
    a0 = a1;
    a1 = a1+rand(1)*(amax-a1);
  end
end

function azoom = zoom(p,x,d,i,alow,ahigh)
    while 1
        amid = (alow+ahigh)/2;
        if phi(p,x,d,amid) > phi(p,x,d,0) + i.c1ls*amid*gphi(p,x,d,0)...
                | phi(p,x,d,amid) >= phi(p,x,d,alow)
            ahigh = amid;
        else
            if gphi(p,x,d,amid) <= -i.c2ls*gphi(p,x,d,0)
                azoom = amid;
                break;
            end
            if gphi(p,x,d,amid)*(ahigh-alow) >= 0
                ahigh = alow;
            end
            alow = amid;
        end
    end
end

function phivalue = phi(p,x,d,a)
  res = x+a*d;
  phivalue = feval(p,res,0);
end

function gphivalue = gphi(p,x,d,a)
  res = x+a*d;
  gphivalue = feval(p,res,1)'*d;
end