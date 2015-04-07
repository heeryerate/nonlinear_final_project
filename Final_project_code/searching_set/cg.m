function d = cg(g,i,D,H);
    d = zeros(size(g));
    r = H*d+g;
    p = -r;
    k = 0;
    while k<i.cgmaxiter
        if p'*H*p < 0
            a = Findroot(d,p,D);
            d = d + a*p;
            break;
        else
            a = (r'*r)/(p'*H'*p);
        end
        
        if norm(d+a*p) > D
            a = Findroot(d,p,D);
            d = d + a*p;
            break;
        else
            d = d + a*p;
            rr = r'*r;
            r = r + a*H*p;
        end
        
        if norm(r) <= 1e-6
            d = d + a*p;
            break;
        else
            beta = (r'*r)/rr;
            p = -r + beta*p;
        end
        k = k + 1;
    end
end

function a = Findroot(d,p,D)
    b1 = p'*p;
    b2 = p'*d;
    a = (sqrt(b2^2-b1*(d'*d-D^2))-b2)/b1;
end