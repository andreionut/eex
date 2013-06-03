% Write a module named 'manipulating'. The module has to export the following four functions:

-module (manipulating).

-export ([
    filter/2,
    reverse/1,
    concatenate/1,
    flatten/1
  ]).

% filter/2

% The function, given a list of integers and an integer, returns all integers smaller than or equal to that integer.

% Example: filter([1,2,3,4,5], 3) -> [1,2,3].
filter(List, Max) -> filter(List, Max, []).

filter([H|T], Max, Found) ->
  if
    H =< Max -> filter(T, Max, [H|Found]);
    true -> filter(T, Max, Found)
  end;
filter([], _, Found) -> reverse(Found).

% reverse/1

% The function, given a list of integers, will reverse the order of the elements.

% Example: reverse([1,2,3]) -> [3,2,1].
reverse(List) -> reverse(List,[]).

reverse([Element|NewList], Reversed) ->
  reverse(NewList, [Element|Reversed]);
reverse([],Reversed) -> Reversed.

% concatenate/1

% The function which, given a list of lists, will concatenate the lists.

% Example: concatenate([[1,2,3], [], [4, five]]) -> [1,2,3,4,five].
concatenate(Lists) -> concatenate([], Lists).

concatenate(L,[]) -> L;
concatenate(L, [H|T]) ->
  concatenate(merge(L,H), T).


% flatten/1

% The function, given a list of nested lists, will return a flat list.

% Example: flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]) ⇒ [1,2,3,4,5,6].
flatten(Lists) -> flatten(Lists, []).

flatten([], Flat) -> Flat;
flatten([H|T], Flat) -> 
  flatten(T, merge(Flat, flatten(H)));
flatten(E, Flat) ->
  merge([E], Flat).

% Private functions

merge(List,[]) -> List;
merge(List,[H|T]) ->
  merge(merge(reverse(List),H), T);
merge(List,B) ->
  reverse([B|List]).

