-module (create).

-export ([
		create/1,
    reverse_create/1
	]).

create(N) when N > 0 -> 
  create_list_up(N,N,[]).

create_list_up(0,_,List) -> List;
create_list_up(I,N,List) ->
  create_list_up(I-1, N, [I|List]).

reverse_create(N) when N > 0 -> 
  create_list_down(0,N,[]).

create_list_down(N,N,List) -> List;
create_list_down(I,N,List) ->
  create_list_down(I+1, N, [I+1|List]).