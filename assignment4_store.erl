-module(assignment4_store).
-export([start/0, init/0, stop/0, store/2, fetch/1, flush/0
        ]).

% Starting the server with same registerd PId that was spawned to help us send message to the sts
start() ->
  case whereis(sts) of
    undefined ->
      P = spawn(fun init/0),
      register(sts, P),
      {ok, P};
    P -> {ok, P}
  end.
  % init the status of server running recursively
init() -> loop([]).

%Handles multiple process of store,fetch,stop and flush during the life cycle of the server.
loop(Store) ->
  receive
    stop -> ok;

    {store, Key, Value, From} ->
      case proplists:lookup({From, Key}, Store) of
        none       ->
          From ! {store, {ok, no_value}},
          loop([{{From, Key}, Value}|Store]);
        {{From, Key}, OldVal} ->
          From ! {store, {ok, OldVal}},
          loop([{{From, Key}, Value}|proplists:delete({From, Key}, Store)])
      end;
    {fetch, Key, From} ->
      case proplists:lookup({From, Key}, Store) of
        none       -> Reply = {error, not_found};
        {{From, Key}, Val} -> Reply = {ok, Val}
      end,
      From ! {fetch, Reply},
      loop(Store);
    {flush, From} ->
      From ! {flush, {ok, flushed}},
      loop([ X || X = {{F, _}, _} <- Store, F =/= From])
  end.

%Stores the PId associated with the Key and value of the process
store(Key, Value) ->
  sts ! {store, Key, Value, self()},
  receive {store, Res} -> Res
  end.

%Fetches stored Pid processes during excution
fetch(Key) ->
  sts ! {fetch, Key, self()},
  receive {fetch, Res} -> Res
  end.

%reads the message sent by the process and returns the messgae PID
flush() ->
  sts ! {flush, self()},
  receive {flush, Res} -> Res
  end.
  %Functinality to stop the server
stop() ->
  case whereis(sts) of
    undefined -> already_stopped;
    P         ->
      P ! stop,
      stopped
  end.