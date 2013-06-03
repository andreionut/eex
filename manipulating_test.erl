c(manipulating).
f().
manipulating:filter([1,2,3,4,5], 1).
lists:filter(fun(X) -> X =< 1 end,[1,2,3,4,5]).
manipulating:filter([1,2,3,4,5], 2).
lists:filter(fun(X) -> X =< 2 end,[1,2,3,4,5]).
manipulating:filter([1,2,3,4,5], 3).
lists:filter(fun(X) -> X =< 3 end,[1,2,3,4,5]).
manipulating:filter([1,2,3,4,5], 4).
lists:filter(fun(X) -> X =< 4 end,[1,2,3,4,5]).
manipulating:filter([1,2,3,4,5], 5).
lists:filter(fun(X) -> X =< 5 end,[1,2,3,4,5]).
manipulating:filter([1,2,3,4,5], 6).
lists:filter(fun(X) -> X =< 6 end,[1,2,3,4,5]).
manipulating:filter([1,2,3,4,5], -1).
lists:filter(fun(X) -> X =< -1 end,[1,2,3,4,5]).
manipulating:reverse([1,2,3,4,5]).
manipulating:concatenate([[1,2,3], [], [4, five]]).
manipulating:concatenate([[1,2,3], [10,12], [4, five]]).
manipulating:concatenate([[1,2,3], [], [4, five], [6,7,8]]).
manipulating:concatenate([[1,2,3], [4, five]]).
manipulating:concatenate([[1,2,3], [4, [five]]]).



c(manipulating).
f().
manipulating:flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]).
manipulating:flatten([[1,2,3], [], [4, five], [6,7,8]]).
