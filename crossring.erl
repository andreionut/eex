% Write a program that will create N processes connected in a ring. These processes will then send M number of messages around the ring. Halfway through the ring, however, the message will cross over the first process, which will then forward it to the second half of the ring. The ring should terminate gracefully when receiving a quit message.


-module (crossring).

-export ([start/3, loop/0]).

start(ProcNum, MsgNum, Message) when ProcNum > 1, ProcNum rem 2 =:= 1, MsgNum > 0 ->
  CrossRing = create_crossring(ProcNum),
  io:format("~p", [CrossRing]).
  % timer:sleep(ProcNum*200),
  % send_all(CrossRing, MsgNum, Message),
  % timer:sleep(MsgNum*100),
  % send_all(CrossRing, 1, stop).
  
create_crossring(ProcNum) ->
  CrossPid = spawn(crossring,loop,[]),
  create_crossring(ProcNum, ((ProcNum+1) div 2)+1, CrossPid, [{CrossPid, spawn(crossring,loop,[])}]).

create_crossring(1, _, CrossPid, CrossRing = [{_, Right}|_]) -> 
  lists:reverse([{Right, CrossPid}|CrossRing]);
create_crossring(ProcNum, CrossNum, CrossPid, CrossRing = [{_, Right}|_]) ->
  if
    CrossNum =:= ProcNum -> 
      Neighbor = CrossPid;
    true -> 
      Neighbor = spawn(crossring,loop,[])
  end,
  create_crossring(ProcNum-1, CrossNum, CrossPid, [{Right, Neighbor}|CrossRing]).

send_all(_, 0, _) -> true;
send_all(CrossRing, MsgNum, Message) ->
  send_message(CrossRing, Message),
  send_all(CrossRing, MsgNum-1, Message).

send_message([], _) -> true;
send_message([{Left,Right}|Other], Message) ->
  Left ! {send, Right, Message},
  send_message(Other, Message).

loop() ->
  receive
    {send, Neighbor, stop} -> 
      io:format("Process: ~p terminating~n",[self()]),
      Neighbor ! stop;
    {send, Neighbor, Message} -> 
      io:format("Process: ~p received: ~p ~n",[self(), Message]),
      % io:format("Sending message ~p from ~p to ~p ~n",[Message, self(), Neighbor]),
      Neighbor ! {send, Message},
      loop()
  end.