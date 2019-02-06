function integrand=func2(x,y)
% call using: integral2(@func2,0,100,0,100)
% e.g. Ferrier 1994
ea=0.2;
lam=1.5616e4;
alpha_i=0;
a_i=6.96;
b_i=0.33;
c_i=0.01853;
d_i=1.9;
gam=1.;
nax=1.e15;

a=alpha_i;
b=b_i;
lam=1;

integrand=(x+y).^2.*abs(x.^b-y.^b).*x.^a.*y.^a.*exp(-lam.*(x+y));

