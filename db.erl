-module (db).

-export ([
    new/0,
    write/3,
    delete/2,
    read/2,
    match/2,
    destroy/1
  ]).



% Create a new database
% new() -> DbRef
new() -> [].

% Insert a new element in the database:
% write(Key, Element, DbRef) -> NewDbRef
write(Key, Element, DbRef) -> 
  case read(Key, DbRef) of
    {ok,_} -> write(Key, Element, delete(Key, DbRef));
    {error, _} -> reverse([{Key,Element}|reverse(DbRef)])
  end.

% Remove the first occurrence of an element from the database:
% delete(Key, DbRef) -> NewDbRef
delete(Key, DbRef) -> 
  delete(Key, [], DbRef).

delete(_, Left, []) -> reverse(Left);
delete(Key, Left, Right) ->
  case Right of
    [{Key,_}|RRight] -> reverse(Left) ++ RRight;
    [LRight|RRight] -> delete(Key, [LRight|Left], RRight)
  end.

reverse(List) -> reverse(List,[]).

reverse([Element|NewList], Reversed) ->
  reverse(NewList, [Element|Reversed]);
reverse([],Reversed) -> Reversed.

% Retrieve the first element in the database with a matching key:
% read(Key, DbRef) -> {ok, Element} | {error, instance}
read(Key, [Item|Tail]) ->
  case Item of
    {Key,Element} -> {ok, Element};
    {_, _} -> read(Key, Tail)
  end;
read(_,[]) -> {error, instance}.

% Return all the keys whose values match the given element:
% match(Element, DbRef) -> [Key1, ..., KeyN]
match(Element, DbRef) -> match(Element, DbRef, []).

match(Element, [Item|Tail], Found) ->
  case Item of
    {Key, Element} -> match(Element, Tail, [Key|Found]);
    _ -> match(Element, Tail, Found)
  end;
match(_, [], Found) -> reverse(Found).

% Delete the database:
% destroy(DbRef) -> ok
destroy(_) -> ok.