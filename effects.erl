-module (effects).

-export ([print/1, even_print/1]).

print(N) when N > 0 -> 
  print(1,N).

print(I,N) when I =< N ->
  io:format("~p ", [I]),
  print(I+1, N);
print(_,_) ->
 io:format("~n", []).

even_print(N) when N > 0 -> 
  even_print(2,N).

even_print(I,N) when I =< N -> 
  io:format("~p ", [I]),
  even_print(I+2, N);
even_print(_,_) -> io:format("~n", []).