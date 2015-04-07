function a = backtrack(p,x,d,i) 
  a0 = 1;
  a = 0;
  rho = 0.5;
  count = 0;
  while 1
    count = count + 1;
    if phi(p,x,d,a0) <= phi(p,x,d,0) + i.c1ls*a*gphi(p,x,d,0);
        a = a0;
        break;
    end
    a0 = rho*a0;
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



