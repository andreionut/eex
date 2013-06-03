% fails 2 tests
-module (boolean).

-export ([
    b_not/1,
    b_and/2,
    b_or/2
  ]).


b_not(A) -> 
  check_input(A),
  do_not(A).

do_not(true) -> false;
do_not(false) ->	true.

b_and(A,B) -> 
  check_input(A),
  check_input(B),
  do_and(A,B).

do_and(true,true) -> true;
do_and(_,_) -> false.

b_or(A,B) -> 
  check_input(A),
  check_input(B),
  do_or(A,B).

do_or(true,_) -> true;
do_or(_,true) -> true;
do_or(_,_) -> false.

check_input(true) -> true;
check_input(false) -> true;
check_input(_) -> throw({error, "Bad argument. Accepting only true or false"}).
