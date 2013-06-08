% Write a server which will wait in a receive loop until a message is sent to it. Depending on the message, it should either print it and loop again or terminate. You want to hide the fact that you are dealing with a process, and access its services through a functional interface. These functions will spawn the process and send messages to it. The module should be named 'echo' and it should export the following functions:


-module (echo).

-export ([start/0, stop/0, print/1, loop/0]).

% echo:start() -> ok

start() ->
  register(echo, spawn(echo, loop, [])).

loop() ->
  receive
    stop -> true;
    Term ->
      io:format("~p ~n", [Term]),
      loop()
  end.

% echo:stop() -> ok
stop() -> 
  echo ! stop,
  unregister(echo).

% echo:print(Term) -> ok
print(Term) -> 
  echo ! Term.