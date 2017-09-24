-module(assignment4_store).
-export([start/0, init/0, stop/0, store/2, fetch/1, flush/0
        ]).

% Starting the serverwith same registerd PId
start() ->
  case whereis(sts) of
    undefined ->
      Pid = spawn(fun() -> init() end),
      register(sts, Pid),
      {ok, Pid};
    Pid  ->
      {ok,Pid}
  end.
  % init the status of server running 
init() -> io:format("Starting... ~n"),
  loop([dict:new()]).

%Handles multiple process of store,fetch,stop and flush during the life cycle of the server.
loop(Dict) ->
receive
        {store, {Pid,K}, V} ->
          case proplists:is_defined({Pid, K}, Dict) of
            true     ->
              {_, OldV} = proplists:lookup({Pid, K}, Dict),
               Pid ! {value, OldV},
            loop([{{Pid, K}, V} |Dict]);
            false       ->  Pid ! {ok,no_value},
              loop([{{Pid, K}, V} | Dict])
          end;
        {fetch, {Pid, K}} ->
          case proplists:is_defined({Pid,K}, Dict) of
            true     -> {_,V} = proplists:lookup({Pid, K}, Dict),
              Pid ! {value, V},
          loop(Dict);
            false       -> Pid ! not_found,
          loop(Dict)
          end;
        {stop, Pid}     ->  Pid ! done;

        {flush, Pid} -> 
  Pid ! {ok, flushed},
        loop([X || X = {{P, _}, _} <- Dict, P /= Pid])
end.

%Functinality to stop the server
stop() ->
  sts ! {stop, self()},
  receive
    done -> ok
after 500 -> process_might_be_stopped
end.
%Stores the PId associated with the Key and value of the process
store(K, V) ->
  sts ! {store, {self(), K}, V},
receive
  {ok,no_value} -> {ok,no_value};
  {value, OldV} -> {ok, OldV}
end.

%Fetches stored Pid processes during excution
fetch(K) ->
  sts ! {fetch, {self(), K}},
  receive
    {value, V} -> {value, V};
    not_found -> {error, not_found}
  end.

%removes Pid associated processs
flush() ->
  sts ! {flush, self()},
  receive
    {ok, flushed} -> {ok, flushed}
  end.