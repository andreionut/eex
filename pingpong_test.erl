c(pingpong).
pingpong:start().
pingpong:send(12).
erlang:monitor(process, whereis(a)).
erlang:monitor(process, whereis(b)).



pingpong:stop().
flush().