-module (test).

-export ([fac/1]).

fac(0) -> 1;
fac(X)  when X>=0 -> X * fac(X-1).