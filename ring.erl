% Write a program that will create N processes connected in a ring. These processes will then send M number of messages around the ring and then terminate gracefully when they receive a quit message.

% Call your module 'ring' and export a 'start/3' function as follows:

%     start(ProcNum, MsgNum, Message)

-module (ring).

-export ([start/3, loop/1]).

start(ProcNum, MsgNum, Message) when ProcNum > 1; MsgNum > 0 ->
  FirstPid = spawn(ring,loop,[self()]),
  FirstPid ! {create, ProcNum-1, FirstPid},
  timer:sleep(ProcNum*200),
  send_all(FirstPid, MsgNum, Message),
  timer:sleep(MsgNum*100),
  FirstPid ! stop.

send_all(_, 0, _) -> true;
send_all(FirstPid, MsgNum, Message) ->
  io:format("Sending message ~p ~n",[MsgNum]),
  FirstPid ! {send, Message},
  send_all(FirstPid, MsgNum-1, Message).


loop(Neighbor) ->
  receive
    {update, NewNeighbor} ->
      io:format("Update process ~p to neighbor ~p ~n",[self(), NewNeighbor]),
      loop(NewNeighbor);
    {create, 1, FirstPid} ->
      NewPid = spawn(ring,loop,[self()]),
      io:format("[1] Create process ~p with neighbor ~p ~n",[NewPid,self()]),
      FirstPid ! {update, NewPid},
      loop(Neighbor);
    {create, ProcNum, FirstPid} ->
      NewPid = spawn(ring,loop,[self()]),
      io:format("[~p] Create process ~p with neighbor ~p ~n",[ProcNum,NewPid,self()]),
      NewPid ! {create, ProcNum-1, FirstPid},
      loop(Neighbor);
    {send, Message} -> 
      io:format("[~p] ~p ~n",[self(), Message]),
      % io:format("Sending message ~p from ~p to ~p ~n",[Message, self(), Neighbor]),
      Neighbor ! {send, Message},
      loop(Neighbor);
    stop -> 
      io:format("Stopping ~p and sending stop to ~p ~n",[self(), Neighbor]),
      Neighbor ! stop
  end.