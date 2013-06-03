% Implement a module, named 'sorting', which exports the following functions to do sorting over lists.

-module (sorting).

-export ([quicksort/1, mergesort/1]).


% quicksort/1

% The head of the list is taken as the pivot; the list is then split according to those elements smaller than the pivot and the rest. These two lists are then recursively sorted by quicksort and joined together with the pivot between them

quicksort([]) -> [];
quicksort([Pivot|Tail]) ->
  quicksort([X || X <- Tail, X < Pivot])
  ++ [Pivot] ++
  quicksort([X || X <- Tail, X >= Pivot]).



% mergesort/1

% The list is split into two lists of (almost) equal length. These are then sorted separately and their result merged together
mergesort([]) -> [];
mergesort([H]) -> [H];
mergesort(List) -> 
  {Left,Right} = lists:split(length(List) div 2, List),
  merge(mergesort(Left), mergesort(Right)).
  
merge([], R) -> R;
merge(L, []) -> L;
merge([LH|LT],[RH|RT]) ->
  case LH < RH of
    true ->  [LH | merge(LT, [RH|RT])];
    false -> [RH | merge([LH|LT], RT)]
  end.
