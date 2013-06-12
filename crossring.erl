% Write a program that will create N processes connected in a ring. These processes will then send M number of messages around the ring. Halfway through the ring, however, the message will cross over the first process, which will then forward it to the second half of the ring. The ring should terminate gracefully when receiving a quit message.


-module (crossring).

-export ([start/3, loop/2]).

start(ProcNum, MsgNum, Message) when ProcNum > 1, ProcNum rem 2 =:= 1, MsgNum > 0 ->
  CrossRing = create_crossring(ProcNum),
  {ok, FirstProcess} = get_process(1, CrossRing),
  % io:format("~p / ~p ~n", [CrossRing, FirstProcess]),
  % timer:sleep(ProcNum*20),
  FirstProcess ! {send, Message, {0, CrossRing}},
  timer:sleep(MsgNum*2),
  FirstProcess ! {send, stop, {0, CrossRing}},
  FirstProcess.
  
create_crossring(ProcNum) ->
  create_crossring(ProcNum, 1, []).

create_crossring(ProcNum, ProcId, CrossRing) when ProcId > ProcNum -> lists:reverse(CrossRing);
create_crossring(ProcNum, ProcId, CrossRing) ->
  create_crossring(ProcNum, ProcId+1, [{ProcId,create_process(ProcNum, ProcId)}|CrossRing]).

create_process(ProcNum, ProcId) -> spawn(crossring, loop, [ProcNum, ProcId]).

get_neighbor_id(ProcNum, ProcId, FromId) ->
% io:format("Get Neighbor: ProcNum=~p, ProcId=~p, FromId=~p ~n", [ProcNum, ProcId, FromId]),
  MiddleId = ((ProcNum+1) div 2),
  if
    % Middle node sends to 1
    ProcId =:= MiddleId -> NeighborId = 1;
    % If we are 1 and received a message from the middle, send to Middle+1
    FromId =:= MiddleId, ProcId =:= 1 -> NeighborId = MiddleId + 1;
    % Last node send to first
    ProcId =:= ProcNum -> NeighborId = 1;
    % The rest of nodes send to the next one
    true -> NeighborId = ProcId + 1
  end,
  NeighborId.

get_process(Key, [Item|Tail]) ->
  case Item of
    {Key,Element} -> {ok, Element};
    {_, _} -> get_process(Key, Tail)
  end;
get_process(_,[]) -> {error, instance}.

loop(ProcNum, ProcId) ->
  % io:format("ProcNum = ~p, ProcId = ~p ~n", [ProcNum, ProcId]),
  receive
    {send, Message, {FromId, Ring}} -> 
      {ok, Neighbor} = get_process(get_neighbor_id(ProcNum, ProcId, FromId), Ring),
      Neighbor ! {send, Message, {ProcId, Ring}},
      case Message of
        stop ->
          io:format("Process: ~p terminating~n",[ProcId]);
        _ ->
          io:format("Process: ~p received: ~p ~n",[ProcId, Message]),
          loop(ProcNum, ProcId)
      end %case
  end.